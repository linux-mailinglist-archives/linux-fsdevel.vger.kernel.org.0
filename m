Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27213726EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhEDIId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 04:08:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24273 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhEDIIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 04:08:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-33-EEImOuSdNDCrsQWXDN1VGQ-1; Tue, 04 May 2021 09:07:34 +0100
X-MC-Unique: EEImOuSdNDCrsQWXDN1VGQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 4 May 2021 09:07:33 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 4 May 2021 09:07:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] eventfd: convert to using ->write_iter()
Thread-Topic: [PATCH] eventfd: convert to using ->write_iter()
Thread-Index: AQHXQCy3UEj3Jsg3M0OzOTpWlBb2warR7W1AgAAf+a2AAOi50A==
Date:   Tue, 4 May 2021 08:07:33 +0000
Message-ID: <494f31b8e37b44d1a24e28885188f16e@AcuMS.aculab.com>
References: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
 <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
 <7caa3703-af14-2ff6-e409-77284da11e1f@kernel.dk>
 <20210503180207.GD1847222@casper.infradead.org>
 <7263c088-22f5-d125-cf80-5ebbd9d110e5@kernel.dk>
In-Reply-To: <7263c088-22f5-d125-cf80-5ebbd9d110e5@kernel.dk>
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

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAwMyBNYXkgMjAyMSAxOTowNQ0KPiANCj4gT24gNS8z
LzIxIDEyOjAyIFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiBPbiBNb24sIE1heSAwMywg
MjAyMSBhdCAxMTo1NzowOEFNIC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+PiBPbiA1LzMv
MjEgMTA6MTIgQU0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4+IEZyb206IEplbnMgQXhib2UN
Cj4gPj4+PiBTZW50OiAwMyBNYXkgMjAyMSAxNTo1OA0KPiA+Pj4+DQo+ID4+Pj4gSGFkIGEgcmVw
b3J0IG9uIHdyaXRpbmcgdG8gZXZlbnRmZCB3aXRoIGlvX3VyaW5nIGlzIHNsb3dlciB0aGFuIGl0
DQo+ID4+Pj4gc2hvdWxkIGJlLCBhbmQgaXQncyB0aGUgdXN1YWwgY2FzZSBvZiBpZiBhIGZpbGUg
dHlwZSBkb2Vzbid0IHN1cHBvcnQNCj4gPj4+PiAtPndyaXRlX2l0ZXIoKSwgdGhlbiBpb191cmlu
ZyBjYW5ub3QgcmVseSBvbiBJT0NCX05PV0FJVCBiZWluZyBob25vcmVkDQo+ID4+Pj4gYWxvbmdz
aWRlIE9fTk9OQkxPQ0sgZm9yIHdoZXRoZXIgb3Igbm90IHRoaXMgaXMgYSBub24tYmxvY2tpbmcg
d3JpdGUNCj4gPj4+PiBhdHRlbXB0LiBUaGF0IG1lYW5zIGlvX3VyaW5nIHdpbGwgcHVudCB0aGUg
b3BlcmF0aW9uIHRvIGFuIGlvIHRocmVhZCwNCj4gPj4+PiB3aGljaCB3aWxsIHNsb3cgdXMgZG93
biB1bm5lY2Vzc2FyaWx5Lg0KPiA+Pj4+DQo+ID4+Pj4gQ29udmVydCBldmVudGZkIHRvIHVzaW5n
IGZvcHMtPndyaXRlX2l0ZXIoKSBpbnN0ZWFkIG9mIGZvcHMtPndyaXRlKCkuDQo+ID4+Pg0KPiA+
Pj4gV29uJ3QgdGhpcyBoYXZlIGEgbWVhc3VyYWJsZSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiBv
biBub3JtYWwNCj4gPj4+IGNvZGUgdGhhdCBkb2VzIHdyaXRlKGV2ZW50X2ZkLCAmb25lLCA0KTsN
Cj4gPj4NCj4gPj4gSWYgLT53cml0ZV9pdGVyKCkgb3IgLT5yZWFkX2l0ZXIoKSBpcyBtdWNoIHNs
b3dlciB0aGFuIHRoZSBub24taW92DQo+ID4+IHZlcnNpb25zLCB0aGVuIEkgdGhpbmsgd2UgaGF2
ZSBnZW5lcmljIGlzc3VlcyB0aGF0IHNob3VsZCBiZSBzb2x2ZWQuDQo+ID4NCj4gPiBXZSBkbyEN
Cj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAyMTAxMDcx
NTExMjUuR0I1MjcwQGNhc3Blci5pbmZyYWRlYWQub3JnLw0KPiA+IGlzIG9uZSB0aHJlYWQgb24g
aXQuICBUaGVyZSBoYXZlIGJlZW4gb3RoZXJzLg0KPiANCj4gQnV0IHRoZW4gd2UgcmVhbGx5IG11
c3QgZ2V0IHRoYXQgZml4ZWQsIGltaG8gLT5yZWFkKCkgYW5kIC0+d3JpdGUoKQ0KPiBzaG91bGQg
Z28gYXdheSwgYW5kIGlmIHRoZSBpdGVyIHZhcmlhbnRzIGFyZSAxMCUgc2xvd2VyLCB0aGVuIHRo
YXQgc2hvdWxkDQo+IGdldCBmaXhlZCB1cC4NCg0KSSB0aGluayB0aGVyZSBhcmUgdHdvIHNlcGFy
YXRlIGlzc3Vlcy4NCihBbHRob3VnaCBJJ3ZlIG5vdCBsb29rZWQgaW4gZGV0YWlsIGludG8gdGhl
IHJlYWxseSBiYWQgY2FzZXMuKQ0KDQoxKSBJIHN1c3BlY3Qgc29tZSBvZiB0aGUgZnMgY29kZSBp
cyB1c2luZyBlbnRpcmVseSBkaWZmZXJlbnQgcGF0aHMgZm9yIHRoZQ0KJ3NpbmdsZSBmcmFnbWVu
dCcgYW5kICdpdGVyJyB2YXJpYW50cy4NCg0KMikgRm9yIHRyaXZpYWwgZHJpdmVycyB0aGUgY29z
dCBvZiBzZXR0aW5nIHVwIHRoZSBpb3ZfaXRlcltdIGFuZCB0aGVuDQppdGVyYXRpbmcgaXQgYmVj
b21lcyBzaWduaWZpY2FudCAob3IgYXQgbGVhc3QgbWVhc3VyYWJsZSkuDQoNCkkgaGF2ZW4ndCB0
cmllZCB0byB1bmRvIHRoZSBtb3Jhc3Mgb2YgI2RlZmluZXMgaW4gdGhlIGl0ZXIgY29kZS4NCkJ1
dCBJIHN1c3BlY3QgdGhleSBjb3VsZCBiZSBvcHRpbWlzZWQgZm9yIHRoZSBjb21tb24gY2FzZSBv
Zg0KY29weWluZyBhbiBlbnRpcmUgc2luZ2xlLWZyYWdtZW50IHRvL2Zyb20gdXNlcnNwYWNlIGlu
IG9uZSBjYWxsLg0KDQpOb3QgcmVsYXRlZCB0byB0aGlzIGNvZGUgcGF0aCwgYnV0IEkndmUgc29t
ZSBwYXRjaGVzIHRoYXQgZ2l2ZSBhDQpmZXcgJSBzcGVlZHVwIGZvciB3cml0ZXYoKSB0byAvZGV2
L251bGwuDQpUaGF0IGlzIGFsbCBhYm91dCBjb3B5aW5nIHRoZSBpb3ZbXSBmcm9tIHVzZXIgLSBp
dCBkb2Vzbid0IGdldCAnaXRlcmF0ZWQnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

