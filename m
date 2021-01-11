Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90C2F0F69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhAKJri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 04:47:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28428 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727819AbhAKJrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:47:37 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-36-V9nBYAwpNcy0GTxHaZ28IA-1; Mon, 11 Jan 2021 09:35:57 +0000
X-MC-Unique: V9nBYAwpNcy0GTxHaZ28IA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 09:35:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 09:35:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Begunkov' <asml.silence@gmail.com>,
        'Al Viro' <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iov_iter: optimise iter type checking
Thread-Topic: [PATCH] iov_iter: optimise iter type checking
Thread-Index: AQHW5qm9/hT6YRd33Eq5lMaMuw9mB6of0+hQgAAHboCAAk7E0A==
Date:   Mon, 11 Jan 2021 09:35:56 +0000
Message-ID: <e125521b90d5405898c21c0e896c3525@AcuMS.aculab.com>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
In-Reply-To: <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
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

RnJvbTogUGF2ZWwgQmVndW5rb3YNCj4gU2VudDogMDkgSmFudWFyeSAyMDIxIDIyOjExDQouLi4u
DQo+ID4gRG9lcyBhbnkgY29kZSBhY3R1YWxseSBsb29rIGF0IHRoZSBmaWVsZHMgYXMgYSBwYWly
Pw0KPiA+IFdvdWxkIGl0IGV2ZW4gYmUgYmV0dGVyIHRvIHVzZSBzZXBhcmF0ZSBieXRlcz8NCj4g
PiBFdmVuIGdyb3dpbmcgdGhlIG9uLXN0YWNrIHN0cnVjdHVyZSBieSBhIHdvcmQgd29uJ3QgcmVh
bGx5IG1hdHRlci4NCj4gDQo+IHU4IHR5cGUsIHJ3Ow0KPiANCj4gVGhhdCB3b24ndCBibG9hdCB0
aGUgc3RydWN0LiBJIGxpa2UgdGhlIGlkZWEuIElmIHVzZWQgdG9nZXRoZXIgY29tcGlsZXJzDQo+
IGNhbiB0cmVhdCBpdCBhcyB1MTYuDQo+IA0KPiBidHcgdGhlcmUgaXMgYSA0QiBob2xlIGp1c3Qg
YWZ0ZXIgZm9yIHg2NC4NCg0KSSd2ZSBqdXN0IGhhZCBhIHF1aWNrIGxvb2sgYXQgdGhlIHNvdXJj
ZXMuDQooTm90aGluZyB3YXMgcG93ZXJlZCB1cCBlYXJsaWVyLikNCg0KQUZBSUNUIG5vdGhpbmcg
bmVlZHMgdGhlIFJXIGZsYWcgdG8gYmUgaW4gdGhlIHNhbWUgd29yZA0KYXMgdGhlIHR5cGUuDQpJ
ZiB5b3UgdGhpbmsgYWJvdXQgaXQsIHRoZSBjYWxsIHNpdGUgaXMgc3BlY2lmaWMgdG8gcmVhZC93
cml0ZS4NClRoZSBvbmx5IHBsYWNlcyBpb3ZfaXRlcl9ydygpIGlzIHVzZWQgaW4gaW5zaWRlIGhl
bHBlciBmdW5jdGlvbnMNCnRvIHNhdmUgdGhlIGRpcmVjdGlvbiBiZWluZyBwYXNzZWQgZnJvbSB0
aGUgY2FsbGVyLg0KDQpJIGhvcGUgdGhlIGNvbW1lbnQgYWJvdXQgYml0IDEgYmVpbmcgQlZFQ19G
TEFHX05PX1JFRiBpcyBvbGQuDQpJIGNhbid0IGZpbmQgYW55IHJlZmVyZW5jZXMgdG8gdGhhdCBm
bGFnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

