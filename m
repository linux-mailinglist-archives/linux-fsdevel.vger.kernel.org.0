Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACF277FA86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353050AbjHQPQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353138AbjHQPQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:16:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8C2722
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:16:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-eGokBTGGPKySjKBRyhfXcw-1; Thu, 17 Aug 2023 16:16:44 +0100
X-MC-Unique: eGokBTGGPKySjKBRyhfXcw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 16:16:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 16:16:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAA7PpbgABGFYCAAFYcAIAAGHiw
Date:   Thu, 17 Aug 2023 15:16:40 +0000
Message-ID: <2190704172a5458eb909c9df59b6a556@AcuMS.aculab.com>
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
In-Reply-To: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxNywgMjAyMyAz
OjM4IFBNDQo+IA0KPiBPbiBUaHUsIDE3IEF1ZyAyMDIzIGF0IDEwOjQyLCBEYXZpZCBMYWlnaHQg
PERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFsdGhvdWdoIEknbSBu
b3Qgc3VyZSB0aGUgYml0LWZpZWxkcyByZWFsbHkgaGVscC4NCj4gPiBUaGVyZSBhcmUgOCBieXRl
cyBhdCB0aGUgc3RhcnQgb2YgdGhlIHN0cnVjdHVyZSwgbWlnaHQgYXMgd2VsbA0KPiA+IHVzZSB0
aGVtIDotKQ0KPiANCj4gQWN0dWFsbHnDpyBJIHdyb3RlIHRoZSBwYXRjaCB0aGF0IHdheSBiZWNh
dXNlIGl0IHNlZW1zIHRvIGltcHJvdmUgY29kZQ0KPiBnZW5lcmF0aW9uLg0KPiANCj4gVGhlIGJp
dGZpZWxkcyBhcmUgZ2VuZXJhbGx5IGFsbCBzZXQgdG9nZXRoZXIgYXMganVzdCBwbGFpbiBvbmUt
dGltZQ0KPiBjb25zdGFudHMgYXQgaW5pdGlhbGl6YXRpb24gdGltZSwgYW5kIGdjYyBzZWVzIHRo
YXQgaXQncyBhIGZ1bGwgYnl0ZQ0KPiB3cml0ZS4NCg0KSSd2ZSBqdXN0IHNwZW50IHRvbyBsb25n
IG9uIGdvZGJvbHQgKGFnYWluKSA6LSkNCkZpZGRsaW5nIHdpdGg6DQoNCiNkZWZpbmUgdDEgdW5z
aWduZWQgY2hhcg0Kc3RydWN0IGIgew0KICAgIHQxIGIxOjc7DQogICAgdDEgYjI6MTsNCn07DQoN
CnZvaWQgZmYoc3RydWN0IGIgKixpbnQpOw0KDQp2b2lkIGZmMSh2b2lkKQ0Kew0KICAgIHN0cnVj
dCBiIGIgPSB7LmIxPTMsIC5iMiA9IDF9Ow0KICAgIGZmKCZiLCBzaXplb2YgYik7DQp9DQoNCmdj
YyBmb3IgeDg2LTY0IG1ha2UgYSBwaWdzLWJyZWFrZmFzdCB3aGVuIHRoZSBiaXRmaWVsZHMgYXJl
ICdjaGFyJw0KYW5kIGxvYWRzIHRoZSBjb25zdGFudCBmcm9tIG1lbW9yeSB1c2luZyBwYy1yZWxh
dGl2ZSBhY2Nlc3MuDQpPdGhlcndpc2UgcHJldHR5IG11c3QgYWxsIHZhcmlhbnRzICh3aXRoIG9y
IHdpdGhvdXQgdGhlIGJpdGZpZWxkKQ0KZ2V0IGluaXRpYWxpc2VkIGluIGEgc2luZ2xlIHdyaXRl
Lg0KKEFsdGhvdWdoIGdjYyBzZWVtcyB0byBpbnNpc3Qgb24gbG9hZGluZyBhIDMyYml0IGNvbnN0
YW50IGludG8gJWVheC4pDQoNCkkgY2FuIHdlbGwgaW1hZ2luZSB0aGF0IGtlZXBpbmcgdGhlIGNv
bnN0YW50IGJlbG93IDMyNzY4IHdpbGwgaGVscA0Kb24gYXJjaGl0ZWN0dXJlcyB0aGF0IGhhdmUg
dG8gY29uc3RydWN0IGxhcmdlIGNvbnN0YW50cy4NCg0KPiBBbmQgdGhlIHJlYXNvbiAnZGF0YV9z
b3VyY2UnIGlzIG5vdCBhIGJpdGZpZWxkIGlzIHRoYXQgaXQncyBub3QNCj4gYSBjb25zdGFudCBh
dCBpb3ZfaXRlciBpbml0IHRpbWUgKGl0J3MgYW4gYXJndW1lbnQgdG8gYWxsIHRoZSBpbml0DQo+
IGZ1bmN0aW9ucyksIHNvIGhhdmluZyB0aGF0IG9uZSBhcyBhIHNlcGFyYXRlIGJ5dGUgYXQgaW5p
dCB0aW1lIGlzIGdvb2QNCj4gZm9yIGNvZGUgZ2VuZXJhdGlvbiB3aGVuIHlvdSBkb24ndCBuZWVk
IHRvIG1hc2sgYml0cyBvciBhbnl0aGluZyBsaWtlDQo+IHRoYXQuDQo+IA0KPiBBbmQgb25jZSBp
bml0aWFsaXplZCwgaGF2aW5nIHRoaW5ncyBiZSBkZW5zZSBhbmQgZG9pbmcgYWxsIHRoZQ0KPiBj
b21wYXJlcyB3aXRoIGEgYml0d2lzZSAnYW5kJyBpbnN0ZWFkIG9mIGRvaW5nIHRoZW0gYXMgc29t
ZSB2YWx1ZQ0KPiBjb21wYXJlIGFnYWluIHRlbmRzIHRvIGdlbmVyYXRlIGdvb2QgY29kZS4NCj4g
DQo+IFRoZW4gYmVpbmcgYWJsZSB0byB0ZXN0IG11bHRpcGxlIGJpdHMgYXQgdGhlIHNhbWUgdGlt
ZSBpcyBqdXN0IGdyYXZ5DQo+IG9uIHRvcCBvZiB0aGF0IChpZSB0aGF0IHdob2xlICJyZW1vdmUg
dXNlcl9iYWNrZWQsIGJlY2F1c2UgaXQncyBlYXNpZXINCj4gdG8ganVzdCB0ZXN0IHRoZSBiaXQg
Y29tYmluYXRpb24iKS4NCg0KSW5kZWVkLCB0aGV5IHVzZWQgdG8gYmUgYml0cyBidXQgbmV2ZXIg
Z290IHRlc3RlZCB0b2dldGhlci4NCg0KPiA+IE9UT0ggdGhlICdub2ZhdWx0JyBhbmQgJ2NvcHlf
bWMnIGZsYWdzIGNvdWxkIGJlIHB1dCBpbnRvIG11Y2gNCj4gPiBoaWdoZXIgYml0cyBvZiBhIDMy
Yml0IHZhbHVlLg0KPiANCj4gT25jZSB5b3Ugc3RhcnQgZG9pbmcgdGhhdCwgeW91IG9mdGVuIGdl
dCBiaWdnZXIgY29uc3RhbnRzIGluIHRoZSBjb2RlIHN0cmVhbS4NCg0KSSB3YXNuJ3QgdGhpbmtp
bmcgb2YgdXNpbmcgJ3JlYWxseSBiaWcnIHZhbHVlcyA6LSkNCkV2ZW4gMzI3NjggY2FuIGJlIGFu
IGlzc3VlIGJlY2F1c2Ugc29tZSBjcHUgc2lnbiBleHRlbmQgYWxsIGNvbnN0YW50cy4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

