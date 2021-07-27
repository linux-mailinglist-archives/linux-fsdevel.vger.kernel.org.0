Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69623D71FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhG0JaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 05:30:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21196 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236022AbhG0JaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:30:06 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-70-ms7TCF98MzyTiP7ml5G1wg-1; Tue, 27 Jul 2021 10:30:03 +0100
X-MC-Unique: ms7TCF98MzyTiP7ml5G1wg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 27 Jul 2021 10:30:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 27 Jul 2021 10:30:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: RE: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable
 helper
Thread-Topic: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable
 helper
Thread-Index: AQHXgMWAppW/hO87w0mGvb576BwgJqtWjhtg
Date:   Tue, 27 Jul 2021 09:30:02 +0000
Message-ID: <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
 <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
In-Reply-To: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSnVseSAyMDIxIDIwOjUzDQo+IA0KPiBP
biBTYXQsIEp1bCAyNCwgMjAyMSBhdCAxMjozNSBQTSBBbmRyZWFzIEdydWVuYmFjaGVyDQo+IDxh
Z3J1ZW5iYUByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+ICtpbnQgaW92X2l0ZXJfZmF1bHRf
aW5fd3JpdGVhYmxlKGNvbnN0IHN0cnVjdCBpb3ZfaXRlciAqaSwgc2l6ZV90IGJ5dGVzKQ0KPiA+
ICt7DQo+IC4uLg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChmYXVsdF9pbl91c2Vy
X3BhZ2VzKHN0YXJ0LCBsZW4sIHRydWUpICE9IGxlbikNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiANCj4gTG9va2luZyBhdCB0aGlzIG9uY2Ug
bW9yZSwgSSB0aGluayB0aGlzIGlzIGxpa2VseSB3cm9uZy4NCj4gDQo+IFdoeT8NCj4gDQo+IEJl
Y2F1c2UgYW55IHVzZXIgY2FuL3Nob3VsZCBvbmx5IGNhcmUgYWJvdXQgYXQgbGVhc3QgKnBhcnQq
IG9mIHRoZQ0KPiBhcmVhIGJlaW5nIHdyaXRhYmxlLg0KPiANCj4gSW1hZ2luZSB0aGF0IHlvdSdy
ZSBkb2luZyBhIGxhcmdlIHJlYWQuIElmIHRoZSAqZmlyc3QqIHBhZ2UgaXMNCj4gd3JpdGFibGUs
IHlvdSBzaG91bGQgc3RpbGwgcmV0dXJuIHRoZSBwYXJ0aWFsIHJlYWQsIG5vdCAtRUZBVUxULg0K
DQpNeSAyYy4uLg0KDQpJcyBpdCBhY3R1YWxseSB3b3J0aCBkb2luZyBhbnkgbW9yZSB0aGFuIGVu
c3VyaW5nIHRoZSBmaXJzdCBieXRlDQpvZiB0aGUgYnVmZmVyIGlzIHBhZ2VkIGluIGJlZm9yZSBl
bnRlcmluZyB0aGUgYmxvY2sgdGhhdCBoYXMNCnRvIGRpc2FibGUgcGFnZSBmYXVsdHM/DQoNCk1v
c3Qgb2YgdGhlIGFsbCB0aGUgcGFnZXMgYXJlIHByZXNlbnQgc28gdGhlIElPIGNvbXBsZXRlcy4N
Cg0KVGhlIHBhZ2VzIGNhbiBhbHdheXMgZ2V0IHVubWFwcGVkIChkdWUgdG8gcGFnZSBwcmVzc3Vy
ZSBvcg0KYW5vdGhlciBhcHBsaWNhdGlvbiB0aHJlYWQgdW5tYXBwaW5nIHRoZW0pIHNvIHRoZXJl
IG5lZWRzDQp0byBiZSBhIHJldHJ5IGxvb3AuDQpHaXZlbiB0aGUgY29zdCBvZiBhY3R1YWxseSBm
YXVsdGluZyBpbiBhIHBhZ2UgZ29pbmcgYXJvdW5kDQp0aGUgb3V0ZXIgbG9vcCBtYXkgbm90IG1h
dHRlci4NCkluZGVlZCwgaWYgYW4gYXBwbGljYXRpb24gaGFzIGp1c3QgbW1hcCgpZWQgaW4gYSB2
ZXJ5IGxhcmdlDQpmaWxlIGFuZCBpcyB0aGVuIGRvaW5nIGEgd3JpdGUoKSBmcm9tIGl0IHRoZW4g
aXQgaXMgcXVpdGUNCmxpa2VseSB0aGF0IHRoZSBwYWdlcyBnb3QgdW5tYXBwZWQhDQoNCkNsZWFy
bHkgdGhlcmUgbmVlZHMgdG8gYmUgZXh0cmEgY29kZSB0byBlbnN1cmUgcHJvZ3Jlc3MgaXMgbWFk
ZS4NClRoaXMgbWlnaHQgYWN0dWFsbHkgcmVxdWlyZSB0aGUgdXNlIG9mICdib3VuY2UgYnVmZmVy
cycNCmZvciByZWFsbHkgcHJvYmxlbWF0aWMgdXNlciByZXF1ZXN0cy4NCg0KSSBhbHNvIHdvbmRl
ciB3aGF0IGFjdHVhbGx5IGhhcHBlbnMgZm9yIHBpcGVzIGFuZCBmaWZvcy4NCklJUkMgcmVhZHMg
YW5kIHdyaXRlIG9mIHVwIHRvIFBJUEVfTUFYICh0eXBpY2FsbHkgNDA5NikNCmFyZSBleHBlY3Rl
ZCB0byBiZSBhdG9taWMuDQpUaGlzIHNob3VsZCBiZSB0cnVlIGV2ZW4gaWYgdGhlcmUgYXJlIHBh
Z2UgZmF1bHRzIHBhcnQgd2F5DQp0aHJvdWdoIHRoZSBjb3B5X3RvL2Zyb21fdXNlcigpLg0KDQpJ
dCBoYXMgdG8gYmUgc2FpZCBJIGNhbid0IHNlZSBhbnkgcmVmZXJlbmNlIHRvIFBJUEVfTUFYDQpp
biB0aGUgbGludXggbWFuIHBhZ2VzLCBidXQgSSdtIHN1cmUgaXQgaXMgaW4gdGhlIFBPU0lYL1RP
Rw0Kc3BlYy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

