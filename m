Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39583718FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhECQNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 12:13:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29144 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhECQM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 12:12:59 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-43-aJV4MMUENAWjfcroZ_yONA-1; Mon, 03 May 2021 17:12:03 +0100
X-MC-Unique: aJV4MMUENAWjfcroZ_yONA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 3 May 2021 17:12:03 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 3 May 2021 17:12:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] eventfd: convert to using ->write_iter()
Thread-Topic: [PATCH] eventfd: convert to using ->write_iter()
Thread-Index: AQHXQCy3UEj3Jsg3M0OzOTpWlBb2warR7W1A
Date:   Mon, 3 May 2021 16:12:02 +0000
Message-ID: <de316af8f88947fabd1422b04df8a66e@AcuMS.aculab.com>
References: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
In-Reply-To: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
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

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAwMyBNYXkgMjAyMSAxNTo1OA0KPiANCj4gSGFkIGEg
cmVwb3J0IG9uIHdyaXRpbmcgdG8gZXZlbnRmZCB3aXRoIGlvX3VyaW5nIGlzIHNsb3dlciB0aGFu
IGl0DQo+IHNob3VsZCBiZSwgYW5kIGl0J3MgdGhlIHVzdWFsIGNhc2Ugb2YgaWYgYSBmaWxlIHR5
cGUgZG9lc24ndCBzdXBwb3J0DQo+IC0+d3JpdGVfaXRlcigpLCB0aGVuIGlvX3VyaW5nIGNhbm5v
dCByZWx5IG9uIElPQ0JfTk9XQUlUIGJlaW5nIGhvbm9yZWQNCj4gYWxvbmdzaWRlIE9fTk9OQkxP
Q0sgZm9yIHdoZXRoZXIgb3Igbm90IHRoaXMgaXMgYSBub24tYmxvY2tpbmcgd3JpdGUNCj4gYXR0
ZW1wdC4gVGhhdCBtZWFucyBpb191cmluZyB3aWxsIHB1bnQgdGhlIG9wZXJhdGlvbiB0byBhbiBp
byB0aHJlYWQsDQo+IHdoaWNoIHdpbGwgc2xvdyB1cyBkb3duIHVubmVjZXNzYXJpbHkuDQo+IA0K
PiBDb252ZXJ0IGV2ZW50ZmQgdG8gdXNpbmcgZm9wcy0+d3JpdGVfaXRlcigpIGluc3RlYWQgb2Yg
Zm9wcy0+d3JpdGUoKS4NCg0KV29uJ3QgdGhpcyBoYXZlIGEgbWVhc3VyYWJsZSBwZXJmb3JtYW5j
ZSBkZWdyYWRhdGlvbiBvbiBub3JtYWwNCmNvZGUgdGhhdCBkb2VzIHdyaXRlKGV2ZW50X2ZkLCAm
b25lLCA0KTsNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

