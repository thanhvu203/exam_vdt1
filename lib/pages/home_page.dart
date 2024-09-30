import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Gọi API từ dịch vụ này
import '../widgets/destination_card.dart'; // Card hiển thị thông tin địa điểm
import '../widgets/category_button.dart'; // Các nút lựa chọn danh mục
import '../models/place.dart'; // Định nghĩa lớp Place

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Place> places = []; // Danh sách địa điểm

  @override
  void initState() {
    super.initState();
    fetchPlaces(); // Gọi API khi trang được tải
  }

  void fetchPlaces() async {
    places = await ApiService.getAllPlaces(); // Gọi API để lấy dữ liệu
    setState(() {}); // Cập nhật UI khi có dữ liệu mới
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi Guy!', style: TextStyle(fontSize: 18)),
            Text('Where are you going next?', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search your destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(text: 'Hotels', color: Colors.orange),
                CategoryButton(text: 'Flights', color: Colors.pink),
                CategoryButton(text: 'All', color: Colors.lightBlue),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Destinations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('See all', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Hiển thị 2 cột
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Tỉ lệ của mỗi card
              ),
              itemCount: places.length, // Số lượng địa điểm
              itemBuilder: (context, index) {
                return DestinationCard(place: places[index]); // Mỗi card đại diện cho một địa điểm
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
