//
//  ContentView.swift
//  SwiftUIBarGraphAnimation
//
//  Created by Steve Wall on 9/11/21.
//

import SwiftUI

enum PickerState {
  case weekday
  case afternoon
  case evening
  
  var description: String {
    switch self {
    case .weekday: return "Weekday"
    case .afternoon: return "Afternoon"
    case .evening: return "Evening"
    }
  }
}

enum Weekday: Int, CaseIterable {
  case sunday
  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  
  var description: String {
    switch self {
    case .sunday: return "Su"
    case .monday: return "M"
    case .tuesday: return "T"
    case .wednesday: return "W"
    case .thursday: return "Th"
    case .friday: return "F"
    case .saturday: return "Sa"
    }
  }
}

struct ContentView: View {
  @State var pickerState: PickerState = .weekday
  
  var body: some View {
    ZStack {
      Color("appBackground").edgesIgnoringSafeArea(.all)
      
      VStack {
        // Title
        Text("Calorie Intake")
          .font(.system(size: 34))
          .fontWeight(.heavy)
        // Picker
        Picker(selection: $pickerState, label: Text("")) {
          Text(PickerState.weekday.description).tag(PickerState.weekday)
          Text(PickerState.afternoon.description).tag(PickerState.afternoon)
          Text(PickerState.evening.description).tag(PickerState.evening)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        // Graph
        HStack(spacing: 20) {
          BarView(value: getRandomData(pickerState: pickerState), day: .sunday)
          BarView(value: getRandomData(pickerState: pickerState), day: .monday)
          BarView(value: getRandomData(pickerState: pickerState), day: .tuesday)
          BarView(value: getRandomData(pickerState: pickerState), day: .wednesday)
          BarView(value: getRandomData(pickerState: pickerState), day: .thursday)
          BarView(value: getRandomData(pickerState: pickerState), day: .friday)
          BarView(value: getRandomData(pickerState: pickerState), day: .saturday)
        }
        .animation(.easeInOut, value: pickerState)
        
      }
    }
    
  }
  
  func getRandomData(pickerState: PickerState) -> CGFloat {
    switch pickerState {
    case .weekday, .afternoon, .evening: return CGFloat.random(in: 0...200)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.light)
      
  }
}

struct BarView: View {
  let value: CGFloat
  let day: Weekday
  var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        // Background
        Capsule().frame(width: 30, height: 200)
          .foregroundColor(Color("barBackground"))
        // Foreground
        Capsule().frame(width: 30, height: value)
          .foregroundColor(Color("barForeground"))
      }
      Text(day.description)
        .padding(.top, 8)
    }
  }
}
