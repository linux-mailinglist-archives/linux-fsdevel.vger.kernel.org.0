Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21424244061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 23:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMVKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 17:10:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45238 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgHMVKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:10:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-266-cZsCGIe9PGK2zEA8sCYUDA-1; Thu, 13 Aug 2020 22:10:44 +0100
X-MC-Unique: cZsCGIe9PGK2zEA8sCYUDA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 22:10:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 22:10:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josef Bacik' <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH][v2] proc: use vmalloc for our kernel buffer
Thread-Topic: [PATCH][v2] proc: use vmalloc for our kernel buffer
Thread-Index: AQHWcZXlpXFy9nu730SSUfZHxwd5cKk2h+wQ
Date:   Thu, 13 Aug 2020 21:10:43 +0000
Message-ID: <3612878ce143427b89a70de3abfb657d@AcuMS.aculab.com>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de> <20200813162002.GX1236603@ZenIV.linux.org.uk>
 <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
In-Reply-To: <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogSm9zZWYgQmFjaWsNCj4gU2VudDogMTMgQXVndXN0IDIwMjAgMTg6MTkNCi4uLg0KPiBX
ZSB3b3VsZG4ndCBldmVuIG5lZWQgdGhlIGV4dHJhICsxIHBhcnQsIHNpbmNlIHdlJ3JlIG9ubHkg
Y29weWluZyBpbiBob3cgbXVjaA0KPiB0aGUgdXNlciB3YW50cyBhbnl3YXksIHdlIGNvdWxkIGp1
c3QgZ28gYWhlYWQgYW5kIGNvbnZlcnQgdGhpcyB0bw0KPiANCj4gbGVmdCAtPSBzbnByaW50Zihi
dWZmZXIsIGxlZnQsICIweCUwNHhcbiIsICoodW5zaWduZWQgaW50ICopIHRhYmxlLT5kYXRhKTsN
Cj4gDQo+IGFuZCBiZSBmaW5lLCByaWdodD8gIE9yIGFtIEkgbWlzdW5kZXJzdGFuZGluZyB3aGF0
IHlvdSdyZSBsb29raW5nIGZvcj8gIFRoYW5rcywNCg0KRG9lc24ndCB0aGF0IG5lZWQgdG8gYmUg
c2NucHJpbnRmKCk/DQpJSVJDIHNucHJpbnRmKCkgcmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVz
IHRoYXQgd291bGQgaGF2ZSBiZWVuDQp3cml0dGVuIHdlcmUgdGhlIGJ1ZmZlciBpbmZpbml0ZSBz
aXplPw0KKEkgc3VzcGVjdCB0aGlzIGlzIGFuICdhY2NpZGVudGFsJyByZXR1cm4gdmFsdWUgZnJv
bSB0aGUgb3JpZ2luYWwNClNZU1Y/IHVzZXJzcGFjZSBpbXBsZW1lbnRhdGlvbiB0aGF0IGp1c3Qg
ZHVtcGVkIGNoYXJhY3RlcnMgdGhhdA0Kd291bGRuJ3QgZml0IGluIHRoZSBidWZmZXIgc29tZXdo
ZXJlLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

