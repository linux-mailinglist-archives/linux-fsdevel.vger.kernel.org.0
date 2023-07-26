Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B387633BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjGZKbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGZKbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:31:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A854211C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 03:31:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-xYTxgX3WO7ONweBAUeQ-4g-1; Wed, 26 Jul 2023 11:31:09 +0100
X-MC-Unique: xYTxgX3WO7ONweBAUeQ-4g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 11:31:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 11:31:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] file: always lock position
Thread-Topic: [PATCH] file: always lock position
Thread-Index: AQHZv52Wk7VECN4jRkOkgcQ6dxTgSq/L2Oww
Date:   Wed, 26 Jul 2023 10:31:07 +0000
Message-ID: <081f95b2428049999cc2c0f55a46075f@AcuMS.aculab.com>
References: <20230724-eckpunkte-melden-fc35b97d1c11@brauner>
 <CAHk-=wijcZGxrw8+aukW-m2YRGn5AUWfZsPSscez7w7_EqfuGQ@mail.gmail.com>
 <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
 <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
 <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
 <20230726-antik-abwinken-87647ff63ec8@brauner>
In-Reply-To: <20230726-antik-abwinken-87647ff63ec8@brauner>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEJyYXVuZXINCj4gU2VudDogMjYgSnVseSAyMDIzIDA5OjM3DQouLi4N
Cj4gWWVzLCBhbmQgdG8gc3VtbWFyaXplIHdoaWNoIEkgdHJpZWQgaW4gbXkgZGVzY3JpcHRpb24g
Zm9yIHRoZSBjb21taXQuDQo+IFRoZSBnZXRkZW50cyBzdXBwb3J0IHBhdGNoc2V0IHdvdWxkIGhh
dmUgaW50cm9kdWNlZCBhIGJ1ZyBiZWNhdXNlIHRoZQ0KPiBwYXRjaHNldCBjb3BpZWQgdGhlIGZk
Z2V0X3BvcygpIGZpbGVfY291bnQoZmlsZSkgPiAxIG9wdGltaXphdGlvbiBpbnRvDQo+IGlvX3Vy
aW5nLg0KPiANCj4gVGhhdCB3b3JrcyBmaW5lIGFzIGxvbmcgYXMgdGhlIG9yaWdpbmFsIGZpbGUg
ZGVzY3JpcHRvciB1c2VkIHRvIHJlZ2lzdGVyDQo+IHRoZSBmaXhlZCBmaWxlIGlzIGtlcHQuIFRo
ZSBsb2NraW5nIHdpbGwgd29yayBjb3JyZWN0bHkgYXMNCj4gZmlsZV9jb3VudChmaWxlKSA+IDEg
YW5kIG5vIHJhY2VzIGFyZSBwb3NzaWJsZSBuZWl0aGVyIHZpYSBnZXRkZW50IGNhbGxzDQo+IHVz
aW5nIHRoZSBvcmlnaW5hbCBmaWxlIGRlc2NyaXB0b3Igbm9yIHZpYSBpb191cmluZyB1c2luZyB0
aGUgZml4ZWQgZmlsZQ0KPiBvciBldmVuIG1peGluZyBib3RoLg0KPiANCj4gQnV0IGFzIHNvb24g
YXMgdGhlIG9yaWdpbmFsIGZpbGUgZGVzY3JpcHRvciBpcyBjbG9zZWQgdGhlIGZfY291bnQgZm9y
DQo+IHRoZSBmaWxlIGRyb3BzIGJhY2sgdG8gMSBidXQgY29udGludWVzIHRvIGJlIHVzYWJsZSBm
cm9tIGlvX3VyaW5nIHZpYQ0KPiB0aGUgZml4ZWQgZmlsZS4gTm93IHRoZSBvcHRpbWl6YXRpb24g
dGhhdCB0aGUgcGF0Y2hzZXQgd2FudGVkIHRvIGNvcHkNCj4gb3ZlciB3b3VsZCBjYXVzZSBidWdz
IGFzIG11bHRpcGxlIHJhY2luZyBnZXRkZW50IHJlcXVlc3RzIHdvdWxkIGJlDQo+IHBvc3NpYmxl
IHVzaW5nIHRoZSBmaXhlZCBmaWxlLg0KDQpDb3VsZCB0aGUgaW9fdXJpbmcgY29kZSBncmFiIHR3
byByZWZlcmVuY2VzPw0KVGhhdCB3b3VsZCBzdG9wIHRoZSBvcHRpbWlzYXRpb24gd2l0aG91dCBh
ZmZlY3RpbmcgYW55DQpub3JtYWwgY29kZSBwYXRocz8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

