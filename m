Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355ED2B8159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKRP7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:59:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42118 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbgKRP7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:59:37 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-185--CpBF4jRNLeF2EmBffFv5g-1; Wed, 18 Nov 2020 15:59:33 +0000
X-MC-Unique: -CpBF4jRNLeF2EmBffFv5g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Nov 2020 15:59:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Nov 2020 15:59:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
Thread-Topic: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
Thread-Index: AQHWvcDieFOOUR5p5U6TdCRQART+IqnOC5Tw
Date:   Wed, 18 Nov 2020 15:59:32 +0000
Message-ID: <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
 <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
In-Reply-To: <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxOCBOb3ZlbWJlciAyMDIwIDE1OjM4DQo+IA0K
PiBPbiBXZWQsIE5vdiAxOCwgMjAyMCBhdCA0OjEwIFBNIFdpbGxlbSBkZSBCcnVpam4NCj4gPHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIFdlZCwgTm92IDE4
LCAyMDIwIGF0IDEwOjAwIEFNIE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIE5vdiAxOCwgMjAyMCBhdCAwOTo0NjoxNUFNIC0w
NTAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiA+ID4gPiAtc3RhdGljIGlubGluZSBzdHJ1
Y3QgdGltZXNwZWM2NCBlcF9zZXRfbXN0aW1lb3V0KGxvbmcgbXMpDQo+ID4gPiA+ICtzdGF0aWMg
aW5saW5lIHN0cnVjdCB0aW1lc3BlYzY0IGVwX3NldF9uc3RpbWVvdXQoczY0IHRpbWVvdXQpDQo+
ID4gPiA+ICB7DQo+ID4gPiA+IC0gICAgIHN0cnVjdCB0aW1lc3BlYzY0IG5vdywgdHMgPSB7DQo+
ID4gPiA+IC0gICAgICAgICAgICAgLnR2X3NlYyA9IG1zIC8gTVNFQ19QRVJfU0VDLA0KPiA+ID4g
PiAtICAgICAgICAgICAgIC50dl9uc2VjID0gTlNFQ19QRVJfTVNFQyAqIChtcyAlIE1TRUNfUEVS
X1NFQyksDQo+ID4gPiA+IC0gICAgIH07DQo+ID4gPiA+ICsgICAgIHN0cnVjdCB0aW1lc3BlYzY0
IG5vdywgdHM7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgIHRzID0gbnNfdG9fdGltZXNwZWM2NCh0
aW1lb3V0KTsNCj4gPiA+ID4gICAgICAga3RpbWVfZ2V0X3RzNjQoJm5vdyk7DQo+ID4gPiA+ICAg
ICAgIHJldHVybiB0aW1lc3BlYzY0X2FkZF9zYWZlKG5vdywgdHMpOw0KPiA+ID4gPiAgfQ0KPiA+
ID4NCj4gPiA+IFdoeSBkbyB5b3UgcGFzcyBhcm91bmQgYW4gczY0IGZvciB0aW1lb3V0LCBjb252
ZXJ0aW5nIGl0IHRvIGFuZCBmcm9tDQo+ID4gPiBhIHRpbWVzcGVjNjQgaW5zdGVhZCBvZiBwYXNz
aW5nIGFyb3VuZCBhIHRpbWVzcGVjNjQ/DQo+ID4NCj4gPiBJIGltcGxlbWVudGVkIGJvdGggYXBw
cm9hY2hlcy4gVGhlIGFsdGVybmF0aXZlIHdhcyBubyBzaW1wbGVyLg0KPiA+IENvbnZlcnNpb24g
aW4gZXhpc3RpbmcgZXBvbGxfd2FpdCwgZXBvbGxfcHdhaXQgYW5kIGVwb2xsX3B3YWl0DQo+ID4g
KGNvbXBhdCkgYmVjb21lcyBhIGJpdCBtb3JlIGNvbXBsZXggYW5kIGFkZHMgYSBzdGFjayB2YXJp
YWJsZSB0aGVyZSBpZg0KPiA+IHBhc3NpbmcgdGhlIHRpbWVzcGVjNjQgYnkgcmVmZXJlbmNlLiBB
bmQgaW4gZXBfcG9sbCB0aGUgdGVybmFyeQ0KPiA+IHRpbWVvdXQgdGVzdCA+IDAsIDAsIDwgMCBu
b3cgcmVxdWlyZXMgY2hlY2tpbmcgYm90aCB0dl9zZWNzIGFuZA0KPiA+IHR2X25zZWNzLiBCYXNl
ZCBvbiB0aGF0LCBJIGZvdW5kIHRoaXMgc2ltcGxlci4gQnV0IG5vIHN0cm9uZw0KPiA+IHByZWZl
cmVuY2UuDQo+IA0KPiBUaGUgNjQtYml0IGRpdmlzaW9uIGNhbiBiZSBmYWlybHkgZXhwZW5zaXZl
IG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVzLA0KPiBhdCBsZWFzdCB3aGVuIGl0IGRvZXNuJ3QgZ2V0
IG9wdGltaXplZCBpbnRvIGEgbXVsdGlwbHkrc2hpZnQuDQoNCkknZCBoYXZlIHRob3VnaHQgeW91
J2Qgd2FudCB0byBkbyBldmVyeXRoaW5nIGluIDY0Yml0IG5hbm9zZWNzLg0KQ29udmVyc2lvbnMg
dG8vZnJvbSBhbnkgb2YgdGhlICd0aW1lc3BlYycgc3RydWN0dXJlIGFyZSBleHBlbnNpdmUuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

