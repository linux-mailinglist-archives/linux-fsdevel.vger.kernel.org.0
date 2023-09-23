Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719E7AC088
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjIWKb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjIWKb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:31:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B11A5
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 03:31:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-mAZ3OHZQNnS1PlaWjhD8UA-1; Sat, 23 Sep 2023 11:31:40 +0100
X-MC-Unique: mAZ3OHZQNnS1PlaWjhD8UA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Sep
 2023 11:31:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Sep 2023 11:31:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 00/11] iov_iter: Convert the iterator macros into
 inline funcs
Thread-Topic: [PATCH v5 00/11] iov_iter: Convert the iterator macros into
 inline funcs
Thread-Index: AQHZ7BD/kh4zTlIOdEezFNQQd09cYrAlRT1QgAK52CSAADgPAA==
Date:   Sat, 23 Sep 2023 10:31:38 +0000
Message-ID: <7e7f2599b5544d838696ebc2cba16e47@AcuMS.aculab.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
 <591a70bf016b4317add2d936696abc0f@AcuMS.aculab.com>
 <1173637.1695384067@warthog.procyon.org.uk>
 <CAF=yD-L3aXM17=hsJBoauWJ6Dqq16ykcnv8sg-Fn_Td_FsOafA@mail.gmail.com>
In-Reply-To: <CAF=yD-L3aXM17=hsJBoauWJ6Dqq16ykcnv8sg-Fn_Td_FsOafA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAyMyBTZXB0ZW1iZXIgMjAyMyAwNzo1OQ0K
PiANCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMjowMeKAr1BNIERhdmlkIEhvd2VsbHMgPGRo
b3dlbGxzQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRGF2aWQgTGFpZ2h0IDxEYXZpZC5M
YWlnaHRAQUNVTEFCLkNPTT4gd3JvdGU6DQo+ID4NCj4gPiA+ID4gICg4KSBNb3ZlIHRoZSBjb3B5
LWFuZC1jc3VtIGNvZGUgdG8gbmV0LyB3aGVyZSBpdCBjYW4gYmUgaW4gcHJveGltaXR5IHdpdGgN
Cj4gPiA+ID4gICAgICB0aGUgY29kZSB0aGF0IHVzZXMgaXQuICBUaGlzIGVsaW1pbmF0ZXMgdGhl
IGNvZGUgaWYgQ09ORklHX05FVD1uIGFuZA0KPiA+ID4gPiAgICAgIGFsbG93cyBmb3IgdGhlIHNs
aW0gcG9zc2liaWxpdHkgb2YgaXQgYmVpbmcgaW5saW5lZC4NCj4gPiA+ID4NCj4gPiA+ID4gICg5
KSBGb2xkIG1lbWNweV9hbmRfY3N1bSgpIGluIHRvIGl0cyB0d28gdXNlcnMuDQo+ID4gPiA+DQo+
ID4gPiA+ICgxMCkgTW92ZSBjc3VtX2FuZF9jb3B5X2Zyb21faXRlcl9mdWxsKCkgb3V0IG9mIGxp
bmUgYW5kIG1lcmdlIGluDQo+ID4gPiA+ICAgICAgY3N1bV9hbmRfY29weV9mcm9tX2l0ZXIoKSBz
aW5jZSB0aGUgZm9ybWVyIGlzIHRoZSBvbmx5IGNhbGxlciBvZiB0aGUNCj4gPiA+ID4gICAgICBs
YXR0ZXIuDQo+ID4gPg0KPiA+ID4gSSB0aG91Z2h0IHRoYXQgdGhlIHJlYWwgaWRlYSBiZWhpbmQg
dGhlc2Ugd2FzIHRvIGRvIHRoZSBjaGVja3N1bQ0KPiA+ID4gYXQgdGhlIHNhbWUgdGltZSBhcyB0
aGUgY29weSB0byBhdm9pZCBsb2FkaW5nIHRoZSBkYXRhIGludG8gdGhlIEwxDQo+ID4gPiBkYXRh
LWNhY2hlIHR3aWNlIC0gZXNwZWNpYWxseSBmb3IgbG9uZyBidWZmZXJzLg0KPiA+ID4gSSB3b25k
ZXIgaG93IG9mdGVuIHRoZXJlIGFyZSBtdWx0aXBsZSBpb3ZbXSB0aGF0IGFjdHVhbGx5IG1ha2UN
Cj4gPiA+IGl0IGJldHRlciB0aGFuIGp1c3QgY2hlY2sgc3VtbWluZyB0aGUgbGluZWFyIGJ1ZmZl
cj8NCj4gPg0KPiA+IEl0IGFsc28gcmVkdWNlcyB0aGUgb3ZlcmhlYWQgZm9yIGZpbmRpbmcgdGhl
IGRhdGEgdG8gY2hlY2tzdW0gaW4gdGhlIGNhc2UgdGhlDQo+ID4gcGFja2V0IGdldHMgc3BsaXQg
c2luY2Ugd2UncmUgZG9pbmcgdGhlIGNoZWNrc3VtbWluZyBhcyB3ZSBjb3B5IC0gYnV0IHdpdGgg
YQ0KPiA+IGxpbmVhciBidWZmZXIsIHRoYXQncyBuZWdsaWdpYmxlLg0KPiA+DQo+ID4gPiBJIGhh
ZCBhIGZlZWxpbmcgdGhhdCBjaGVjayBzdW1taW5nIG9mIHVkcCBkYXRhIHdhcyBkb25lIGR1cmlu
Zw0KPiA+ID4gY29weV90by9mcm9tX3VzZXIsIGJ1dCB0aGUgY29kZSBjYW4ndCBiZSB0aGUgY29w
eS1hbmQtY3N1bSBoZXJlDQo+ID4gPiBmb3IgdGhhdCBiZWNhdXNlIGl0IGlzIG1pc3Npbmcgc3Vw
cG9ydCBmb3JtIG9kZC1sZW5ndGggYnVmZmVycy4NCj4gPg0KPiA+IElzIHRoZXJlIGEgYnVnIHRo
ZXJlPw0KDQpObywgSSBtaXNyZWFkIHRoZSBjb2RlIC0gaSBzaG91bGRuJ3Qgc2NhbiBwYXRjaGVz
IHdoZW4gSSdkDQpnb3QgYSB2aXJhbCBoZWFkIGNvZGUuLi4NCg0KLi4uDQo+ID4gWW91IG1heSBi
ZSByaWdodC4gIFRoYXQncyBtb3JlIGEgcXVlc3Rpb24gZm9yIHRoZSBuZXR3b3JraW5nIGZvbGtz
IHRoYW4gZm9yDQo+ID4gbWUuICBJdCdzIGVudGlyZWx5IHBvc3NpYmxlIHRoYXQgdGhlIGNoZWNr
c3VtbWluZyBjb2RlIGlzIGp1c3Qgbm90IHVzZWQgb24NCj4gPiBtb2Rlcm4gc3lzdGVtcyB0aGVz
ZSBkYXlzLg0KPiA+DQo+ID4gTWF5YmUgV2lsbGVtIGNhbiBjb21tZW50IHNpbmNlIGhlJ3MgdGhl
IFVEUCBtYWludGFpbmVyPw0KPiANCj4gUGVyaGFwcyB0aGVzZSBkYXlzIGl0IGlzIG1vcmUgcmVs
ZXZhbnQgdG8gZW1iZWRkZWQgc3lzdGVtcyB0aGFuIGhpZ2gNCj4gZW5kIHNlcnZlcnMuDQoNClRo
ZSBjaGVja3N1bSBhbmQgY29weSBhcmUgZG9uZSB0b2dldGhlci4NCkkgcHJvYmFibHkgbWlzc2Vk
IGl0IGJlY2F1c2UgdGhlIGZ1bmN0aW9uIGlzbid0IHBhc3NlZCB0aGUNCm9sZCBjaGVja3N1bSAo
d2hpY2ggaXQgY2FuIHByZXR0eSBtdWNoIHByb2Nlc3MgZm9yIGZyZWUpLg0KSW5zdGVhZCB0aGUg
Y2FsbGVyIGlzIGFkZGluZyBpdCBhZnRlcndhcmRzIC0gd2hpY2ggaW52b2x2ZXMNCmFuZCBleHRy
YSBleHBsaWNpdCBjc3VtX2FkZCgpLg0KDQpUaGUgeDg2LXg4NCBpcCBjaGVja3N1bSBsb29wcyBh
cmUgYWxsIGhvcnJpZCB0aG91Z2guDQpUaGUgdW5yb2xsaW5nIGluIHRoZW0gaXMgc28gMTk5MCdz
Lg0KV2l0aCB0aGUgb3V0LW9mLW9yZGVyIHBpcGVsaW5lIHRoZSBtZW1vcnkgYWNjZXNzZXMgdGVu
ZA0KdG8gdGFrZSBjYXJlIG9mIHRoZW1zZWx2ZXMuDQpOb3QgdG8gbWVudGlvbiB0aGF0IGEgd2hv
bGUgcmFmdCBvZiAobm93IG9sZGlzaCkgY3B1IHRha2UgdHdvDQpjbG9ja3MgdG8gZXhlY3V0ZSAn
YWRjJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

