Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6257F77FB78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbjHQQGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353493AbjHQQGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:06:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806630FB
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 09:06:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-WB12oNh9NZeEKc7yOwxybA-1; Thu, 17 Aug 2023 17:06:39 +0100
X-MC-Unique: WB12oNh9NZeEKc7yOwxybA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 17:06:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 17:06:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
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
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAA7PpbgABGFYCAAFYcAIAAGHiw///2TICAABg4YA==
Date:   Thu, 17 Aug 2023 16:06:35 +0000
Message-ID: <d8500b7f585d41628b9c53a9848d9875@AcuMS.aculab.com>
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
 <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
 <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
 <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
In-Reply-To: <CAHk-=wj1WfFGxHs4k6pn5y6V8BYd3aqODCjqEmrTWP8XO78giw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxNywgMjAyMyA0
OjMxIFBNDQouLi4NCj4gICAgICAgICBtb3Z6d2wgIC5MQzEoJXJpcCksICVlYXgNCj4gICAgICAg
ICB0ZXN0bCAgICVlc2ksICVlc2kNCj4gICAgICAgICBtb3ZiICAgICQwLCAoJXJkaSkNCj4gICAg
ICAgICBtb3ZiICAgICQxLCA0KCVyZGkpDQo+ICAgICAgICAgbW92dyAgICAlYXgsIDEoJXJkaSkN
Cj4gICAgICAgICBtb3ZxICAgICQwLCA4KCVyZGkpDQo+ICAgICAgICAgbW92cSAgICAlcmR4LCAx
NiglcmRpKQ0KPiAgICAgICAgIG1vdnEgICAgJXI4LCAyNCglcmRpKQ0KPiAgICAgICAgIG1vdnEg
ICAgJXJjeCwgMzIoJXJkaSkNCj4gICAgICAgICBzZXRuZSAgIDMoJXJkaSkNCj4gDQo+IHdoaWNo
IGlzIHRoYXQgZGlzZ3VzdGluZyAibW92ZSB0d28gYnl0ZXMgZnJvbSBtZW1vcnkiLCBhbmQgbWFr
ZXMNCj4gYWJzb2x1dGVseSBubyBzZW5zZSBhcyBhIHdheSB0byAid3JpdGUgMiB6ZXJvIGJ5dGVz
IjoNCj4gDQo+IC5MQzE6DQo+ICAgICAgICAgLmJ5dGUgICAwDQo+ICAgICAgICAgLmJ5dGUgICAw
DQo+IA0KPiBJIHRoaW5rIHRoYXQncyBzb21lIG9kZCBnY2MgYnVnLCBhY3R1YWxseS4NCg0KSSBn
ZXQgdGhhdCB3aXRoIHNvbWUgY29kZSwgYnV0IG5vdCBvdGhlcnMuDQpTZWVtcyB0byBkZXBlbmQg
b24gcmFuZG9tIG90aGVyIHN0dWZmLg0KSGFwcGVucyBmb3I6DQoJc3RydWN0IHsgdW5zaWduZWQg
Y2hhciB4OjcsIHk6MTsgfTsNCmJ1dCBub3QgaWYgSSBhZGQgYW55dGhpbmcgYWZ0ZXIgaWYgKHRo
YXQgZ2V0cyB6ZXJvZWQpLg0KV2hpY2ggc2VlbXMgdG8gYmUgdGhlIG9wcG9zaXRlIG9mIHdoYXQg
eW91IHNlZS4NCg0KSWYgSSB1c2UgZXhwbGljaXQgYXNzaWdubWVudHMgKHJhdGhlciB0aGFuIGFu
IGluaXRpYWxpc2VyKQ0KSSBzdGlsbCBnZXQgbWVyZ2VkIHdyaXRlcyAoZXZlbiBpZiBub3QgYSBi
aXRmaWVsZCkgYnV0IGFsc28NCmxvc2UgdGhlIG1lbW9yeSBhY2Nlc3MuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

