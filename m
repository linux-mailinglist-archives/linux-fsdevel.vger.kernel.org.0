Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0373306110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbhA0Qao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 11:30:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:31212 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343732AbhA0QaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:30:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-OneHWQocNNiSYulcGjezNQ-1;
 Wed, 27 Jan 2021 16:28:40 +0000
X-MC-Unique: OneHWQocNNiSYulcGjezNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 27 Jan 2021 16:28:38 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 27 Jan 2021 16:28:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Begunkov' <asml.silence@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iov_iter: optimise iter type checking
Thread-Topic: [PATCH] iov_iter: optimise iter type checking
Thread-Index: AQHW5qm9/hT6YRd33Eq5lMaMuw9mB6of0+hQgBvncPiAAAmTEA==
Date:   Wed, 27 Jan 2021 16:28:38 +0000
Message-ID: <6f7ba1dbbc4749f09ae44aafc6ada284@AcuMS.aculab.com>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
 <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
In-Reply-To: <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
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

RnJvbTogUGF2ZWwgQmVndW5rb3YNCj4gU2VudDogMjcgSmFudWFyeSAyMDIxIDE1OjQ4DQo+IA0K
PiBPbiAxNi8wMS8yMDIxIDA1OjE4LCBBbCBWaXJvIHdyb3RlOg0KPiA+IE9uIFNhdCwgSmFuIDA5
LCAyMDIxIGF0IDEwOjExOjA5UE0gKzAwMDAsIFBhdmVsIEJlZ3Vua292IHdyb3RlOg0KPiA+DQo+
ID4+PiBEb2VzIGFueSBjb2RlIGFjdHVhbGx5IGxvb2sgYXQgdGhlIGZpZWxkcyBhcyBhIHBhaXI/
DQo+ID4+PiBXb3VsZCBpdCBldmVuIGJlIGJldHRlciB0byB1c2Ugc2VwYXJhdGUgYnl0ZXM/DQo+
ID4+PiBFdmVuIGdyb3dpbmcgdGhlIG9uLXN0YWNrIHN0cnVjdHVyZSBieSBhIHdvcmQgd29uJ3Qg
cmVhbGx5IG1hdHRlci4NCj4gPj4NCj4gPj4gdTggdHlwZSwgcnc7DQo+ID4+DQo+ID4+IFRoYXQg
d29uJ3QgYmxvYXQgdGhlIHN0cnVjdC4gSSBsaWtlIHRoZSBpZGVhLiBJZiB1c2VkIHRvZ2V0aGVy
IGNvbXBpbGVycw0KPiA+PiBjYW4gdHJlYXQgaXQgYXMgdTE2Lg0KPiA+DQo+ID4gUmVhc29uYWJs
ZSwgYW5kIGZyb20gd2hhdCBJIHJlbWVtYmVyIGZyb20gbG9va2luZyB0aHJvdWdoIHRoZSB1c2Vy
cywNCj4gPiBubyByZWFkZXJzIHdpbGwgYm90aGVyIHdpdGggbG9va2luZyBhdCBib3RoIGF0IHRo
ZSBzYW1lIHRpbWUuDQo+IA0KPiBBbCwgYXJlIHlvdSBnb2luZyB0dXJuIGl0IGludG8gYSBwYXRj
aCwgb3IgcHJlZmVyIG1lIHRvIHRha2Ugb3Zlcj8NCg0KSSdkIGRlZmluaXRlbHkgbGVhdmUgdGhl
IHR5cGUgYXMgYSBiaXRtYXAuDQoNCkl0IG1heSBiZSB1c2VmdWwgdG8gYWRkIElURVJfSU9WRUNf
U0lOR0xFIHRvIG9wdGltaXNlIHNvbWUNCnZlcnkgY29tbW9uIHBhdGhzIGZvciB1c2VyIGlvdmVj
IHdpdGggb25seSBhIHNpbmdsZSBidWZmZXIuDQpCdXQgeW91J2QgcHJvYmFibHkgd2FudCB0byBr
ZWVwIHRoZSBmdWxsIHZlcnNpb24gZm9yDQptb3JlIHVudXN1YWwgKG9yIGFscmVhZHkgZXhwZW5z
aXZlKSBjYXNlcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

