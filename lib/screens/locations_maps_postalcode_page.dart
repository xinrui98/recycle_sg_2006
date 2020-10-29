import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:tensorflow_lite_flutter/screens/distance_calculator.dart';

class LocationMapsPostalCodePage extends StatefulWidget {
  final double lat;
  final double long;

  const LocationMapsPostalCodePage({Key key, this.lat, this.long}) : super(key: key);

  @override
  _LocationMapsPostalCodePageState createState() => _LocationMapsPostalCodePageState();
}

class _LocationMapsPostalCodePageState extends State<LocationMapsPostalCodePage> {
  LatLng currentPostion;
  List nearestTenBinsList = [];
  List nearestTenBinsLats = [];
  List nearestTenBinsLong = [];

  @override
  void initState() {
    // TODO: implement initState
    _getUserLocation();
    print("LAT LONG POSTAL CODE INIT STATE");
    print(widget.lat);
    print(widget.long);
    super.initState();
  }

  void _getUserLocation() async {
    // var position = await GeolocatorPlatform.instance
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // setState(() {
    //   currentPostion = LatLng(widget.lat, widget.long);
    // });
    print("LAT LONG POSTAL CODE");
    print(widget.lat);
    print(widget.long);

    var distanceCalculator = DistanceCalculator();
    nearestTenBinsList =
        distanceCalculator.main(widget.lat, widget.long);
    for (int i = 0; i < nearestTenBinsList.length; i++) {
      if (i % 2 == 0) {
        nearestTenBinsLats.add(nearestTenBinsList[i]);
      } else {
        nearestTenBinsLong.add(nearestTenBinsList[i]);
      }
    }
  }

  GoogleMapController mapController;

  // final Map<String, Marker> _markers = {};
  Set<Marker> markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final nearestBinsLatsTest = [1.34948, 1.3404, 1.3328];
    final nearestBinsLongsTest = [103.69456, 103.7090, 103.7433];

    setState(() {
      markers.clear();
      for (int i = 0; i < 10; i++) {
        print(nearestTenBinsLats[i]);
        print(nearestTenBinsLong[i]);
        final marker = Marker(
          markerId: MarkerId("Nearest bins"),
          position: LatLng(nearestTenBinsLats[i],
              nearestTenBinsLong[i]), // change to bins
        );
        markers.add(marker);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
          // Text('${currentPostion.latitude}, ${currentPostion.longitude}'),
          Text('hello'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            // target: LatLng(widget.lat,widget.long),
            target: LatLng(1.3543, 103.6869),
            zoom: 15.0,
          ),
          markers: markers,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //     _getCurrentLocation();
        //   },
        //   child: Icon(Icons.navigation),
        //   backgroundColor: Colors.green,
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
