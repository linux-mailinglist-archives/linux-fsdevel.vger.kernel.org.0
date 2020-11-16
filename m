Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD022B4C43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgKPRLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 12:11:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42727 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732195AbgKPRLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:11:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-86-D4jR3JQ7M8irR6fMM85TtA-1; Mon, 16 Nov 2020 17:11:24 +0000
X-MC-Unique: D4jR3JQ7M8irR6fMM85TtA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Nov 2020 17:11:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Nov 2020 17:11:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Soheil Hassas Yeganeh" <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Shuo Chen" <shuochen@google.com>
Subject: RE: [PATCH v2] epoll: add nsec timeout support
Thread-Topic: [PATCH v2] epoll: add nsec timeout support
Thread-Index: AQHWvDp1Tk9JlMrT10ixC6C535CccanK/krw
Date:   Mon, 16 Nov 2020 17:11:24 +0000
Message-ID: <eead2765ea5e417abe616950b4e5d02f@AcuMS.aculab.com>
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
 <20201116161930.GF29991@casper.infradead.org>
 <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
In-Reply-To: <CA+FuTSdifgNAYe4DAfpRJxCO08y-sOi=XhOeMhd9mKbA3aPOug@mail.gmail.com>
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

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAxNiBOb3ZlbWJlciAyMDIwIDE3OjAxDQo+
IA0KPiBPbiBNb24sIE5vdiAxNiwgMjAyMCBhdCAxMToxOSBBTSBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIE5vdiAxNiwgMjAyMCBh
dCAxMToxMDowMUFNIC0wNTAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiA+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ldmVudHBvbGwuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC9ldmVudHBvbGwuaA0KPiA+ID4gaW5kZXggOGEzNDMyZDBmMGRjLi5mNmVmOWM5ZjhhYzIgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvZXZlbnRwb2xsLmgNCj4gPiA+ICsr
KyBiL2luY2x1ZGUvdWFwaS9saW51eC9ldmVudHBvbGwuaA0KPiA+ID4gQEAgLTIxLDYgKzIxLDcg
QEANCj4gPiA+DQo+ID4gPiAgLyogRmxhZ3MgZm9yIGVwb2xsX2NyZWF0ZTEuICAqLw0KPiA+ID4g
ICNkZWZpbmUgRVBPTExfQ0xPRVhFQyBPX0NMT0VYRUMNCj4gPiA+ICsjZGVmaW5lIEVQT0xMX05T
VElNRU8gMHgxDQo+ID4gPg0KPiA+ID4gIC8qIFZhbGlkIG9wY29kZXMgdG8gaXNzdWUgdG8gc3lz
X2Vwb2xsX2N0bCgpICovDQo+ID4gPiAgI2RlZmluZSBFUE9MTF9DVExfQUREIDENCj4gPg0KPiA+
IE5vdCBhIHByb2JsZW0gd2l0aCB5b3VyIHBhdGNoLCBidXQgdGhpcyBjb25jZXJucyBtZS4gIE9f
Q0xPRVhFQyBpcw0KPiA+IGRlZmluZWQgZGlmZmVyZW50bHkgZm9yIGVhY2ggYXJjaGl0ZWN0dXJl
LCBzbyB3ZSBuZWVkIHRvIHN0YXkgb3V0IG9mDQo+ID4gc2V2ZXJhbCBkaWZmZXJlbnQgYml0cyB3
aGVuIHdlIGRlZmluZSBuZXcgZmxhZ3MgZm9yIEVQT0xMXyouICBNYXliZQ0KPiA+IHRoaXM6DQo+
ID4NCj4gPiAvKg0KPiA+ICAqIEZsYWdzIGZvciBlcG9sbF9jcmVhdGUxLiAgT19DTE9FWEVDIG1h
eSBiZSBkaWZmZXJlbnQgYml0cywgZGVwZW5kaW5nDQo+ID4gICogb24gdGhlIENQVSBhcmNoaXRl
Y3R1cmUuICBSZXNlcnZlIHRoZSBrbm93biBvbmVzLg0KPiA+ICAqLw0KPiA+ICNkZWZpbmUgRVBP
TExfQ0xPRVhFQyAgICAgICAgICAgT19DTE9FWEVDDQo+ID4gI2RlZmluZSBFUE9MTF9SRVNFUlZF
RF9GTEFHUyAgICAweDAwNjgwMDAwDQo+ID4gI2RlZmluZSBFUE9MTF9OU1RJTUVPICAgICAgICAg
ICAweDAwMDAwMDAxDQo+IA0KPiBUaGFua3MuIEdvb2QgcG9pbnQsIEknbGwgYWRkIHRoYXQgaW4g
djMuDQoNCllvdSBjb3VsZCBhbHNvIGFkZCBhIGNvbXBpbGUgYXNzZXJ0IHRvIGNoZWNrIHRoYXQg
dGhlIGZsYWcgaXMgcmVzZXJ2ZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

