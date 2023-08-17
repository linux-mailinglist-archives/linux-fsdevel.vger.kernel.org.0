Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67BB77F255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349018AbjHQImL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349079AbjHQImD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:42:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBCB1BD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 01:42:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-hqHBxB6wOzSRqVvnXLIsSQ-1; Thu, 17 Aug 2023 09:41:59 +0100
X-MC-Unique: hqHBxB6wOzSRqVvnXLIsSQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 09:41:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 09:41:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAA7PpbgABGFYA=
Date:   Thu, 17 Aug 2023 08:41:56 +0000
Message-ID: <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
In-Reply-To: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBUaGlzIHBhdGNoIG9ubHkgZG9lcyB0aGF0IGZvciB0aGUgJ3VzZXJfYmFja2VkJyB0aGluZywg
d2hpY2ggd2FzIGEgc2ltaWxhciBjYXNlLg0KDQpZZXMsIGhhdmluZyB0d28gZmllbGRzIHRoYXQg
aGF2ZSB0byBiZSBzZXQgdG8gbWF0Y2ggaXMgYSByZWNpcGUNCmZvciBkaXNhc3Rlci4NCg0KQWx0
aG91Z2ggSSdtIG5vdCBzdXJlIHRoZSBiaXQtZmllbGRzIHJlYWxseSBoZWxwLg0KVGhlcmUgYXJl
IDggYnl0ZXMgYXQgdGhlIHN0YXJ0IG9mIHRoZSBzdHJ1Y3R1cmUsIG1pZ2h0IGFzIHdlbGwNCnVz
ZSB0aGVtIDotKQ0KT1RPSCB0aGUgJ25vZmF1bHQnIGFuZCAnY29weV9tYycgZmxhZ3MgY291bGQg
YmUgcHV0IGludG8gbXVjaA0KaGlnaGVyIGJpdHMgb2YgYSAzMmJpdCB2YWx1ZS4NCg0KQWx0ZXJu
YXRpdmVseSBwdXQgYm90aC9hbGwgdGhlIFVTRVIgdmFsdWVzIGZpcnN0Lg0KVGhlbiBhbiBvcmRl
cmVkIGNvbXBhcmUgY291bGQgYmUgdXNlZC4NCg0KSWYgZXZlcnl0aGluZyBpcyBhY3R1YWxseSBp
bmxpbmVkIGNvdWxkIHRoZSAnaXRlcicgYmUgcGFzc2VkDQp0aHJvdWdoIHRvIHRoZSBzdGVwKCkg
ZnVuY3Rpb25zPw0KQWx0aG91Z2ggaXMgbWlnaHQgYmUgYmV0dGVyIHRvIHBhc3MgYSBjYWNoZWQg
Y29weSBvZiBpdGVyLT5pdGVyX3R5cGUNCihhbHRob3VnaCB0aGF0IG1pZ2h0IGp1c3QgZW5kIHVw
IHNwaWxsaW5nIHRvIHN0YWNrLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

