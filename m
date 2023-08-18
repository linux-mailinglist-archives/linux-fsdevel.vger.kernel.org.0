Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10D780F75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378269AbjHRPmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbjHRPmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:42:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0C94206
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 08:42:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-OcodsAF0MY-quNIfCez-Lg-1; Fri, 18 Aug 2023 16:42:09 +0100
X-MC-Unique: OcodsAF0MY-quNIfCez-Lg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 16:42:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 16:42:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Topic: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Thread-Index: AQHZ0DpP/l59sWTPXU+UuQ9VGbJikq/s16Kg///6foCAACRpIIAA7PpbgABGFYCAAgTAc4AAASpw
Date:   Fri, 18 Aug 2023 15:42:05 +0000
Message-ID: <d8fce3c159b04fdca65cc4d5c307854d@AcuMS.aculab.com>
References: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
 <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
 <2058762.1692371971@warthog.procyon.org.uk>
In-Reply-To: <2058762.1692371971@warthog.procyon.org.uk>
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

RnJvbTogRGF2aWQgSG93ZWxscw0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAxOCwgMjAyMyA0OjIw
IFBNDQo+IA0KPiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+
IHdyb3RlOg0KPiANCj4gPiA+IEFsdGhvdWdoIEknbSBub3Qgc3VyZSB0aGUgYml0LWZpZWxkcyBy
ZWFsbHkgaGVscC4NCj4gPiA+IFRoZXJlIGFyZSA4IGJ5dGVzIGF0IHRoZSBzdGFydCBvZiB0aGUg
c3RydWN0dXJlLCBtaWdodCBhcyB3ZWxsDQo+ID4gPiB1c2UgdGhlbSA6LSkNCj4gPg0KPiA+IEFj
dHVhbGx5w6cgSSB3cm90ZSB0aGUgcGF0Y2ggdGhhdCB3YXkgYmVjYXVzZSBpdCBzZWVtcyB0byBp
bXByb3ZlIGNvZGUNCj4gPiBnZW5lcmF0aW9uLg0KPiA+DQo+ID4gVGhlIGJpdGZpZWxkcyBhcmUg
Z2VuZXJhbGx5IGFsbCBzZXQgdG9nZXRoZXIgYXMganVzdCBwbGFpbiBvbmUtdGltZQ0KPiA+IGNv
bnN0YW50cyBhdCBpbml0aWFsaXphdGlvbiB0aW1lLCBhbmQgZ2NjIHNlZXMgdGhhdCBpdCdzIGEg
ZnVsbCBieXRlDQo+ID4gd3JpdGUuIEFuZCB0aGUgcmVhc29uICdkYXRhX3NvdXJjZScgaXMgbm90
IGEgYml0ZmllbGQgaXMgdGhhdCBpdCdzIG5vdA0KPiA+IGEgY29uc3RhbnQgYXQgaW92X2l0ZXIg
aW5pdCB0aW1lIChpdCdzIGFuIGFyZ3VtZW50IHRvIGFsbCB0aGUgaW5pdA0KPiA+IGZ1bmN0aW9u
cyksIHNvIGhhdmluZyB0aGF0IG9uZSBhcyBhIHNlcGFyYXRlIGJ5dGUgYXQgaW5pdCB0aW1lIGlz
IGdvb2QNCj4gPiBmb3IgY29kZSBnZW5lcmF0aW9uIHdoZW4geW91IGRvbid0IG5lZWQgdG8gbWFz
ayBiaXRzIG9yIGFueXRoaW5nIGxpa2UNCj4gPiB0aGF0Lg0KPiA+DQo+ID4gQW5kIG9uY2UgaW5p
dGlhbGl6ZWQsIGhhdmluZyB0aGluZ3MgYmUgZGVuc2UgYW5kIGRvaW5nIGFsbCB0aGUNCj4gPiBj
b21wYXJlcyB3aXRoIGEgYml0d2lzZSAnYW5kJyBpbnN0ZWFkIG9mIGRvaW5nIHRoZW0gYXMgc29t
ZSB2YWx1ZQ0KPiA+IGNvbXBhcmUgYWdhaW4gdGVuZHMgdG8gZ2VuZXJhdGUgZ29vZCBjb2RlLg0K
PiANCj4gQWN0dWFsbHkuLi4gIEkgc2FpZCB0aGF0IHN3aXRjaChlbnVtKSBzZWVtZWQgdG8gZ2Vu
ZXJhdGUgc3Vib3B0aW1hbCBjb2RlLi4uDQo+IEhvd2V2ZXIsIGlmIHRoZSBlbnVtIGlzIHJlbnVt
YmVyZWQgc3VjaCB0aGF0IHRoZSBjb25zdGFudHMgYXJlIGluIHRoZSBzYW1lDQo+IG9yZGVyIGFz
IGluIHRoZSBzd2l0Y2goKSBpdCBnZW5lcmF0ZXMgYmV0dGVyIGNvZGUuDQoNCkhtbW0uLiB0aGUg
b3JkZXIgb2YgdGhlIHN3aXRjaCBsYWJlbHMgcmVhbGx5IHNob3VsZG4ndCBtYXR0ZXIuDQoNClRo
ZSBhZHZhbnRhZ2Ugb2YgdGhlIGlmLWNoYWluIGlzIHRoYXQgeW91IGNhbiBvcHRpbWlzZSBmb3IN
CnRoZSBtb3N0IGNvbW1vbiBjYXNlLg0KDQo+IFNvIHdlIHdhbnQgdGhpcyBvcmRlcjoNCj4gDQo+
IAllbnVtIGl0ZXJfdHlwZSB7DQo+IAkJSVRFUl9VQlVGLA0KPiAJCUlURVJfSU9WRUMsDQo+IAkJ
SVRFUl9CVkVDLA0KPiAJCUlURVJfS1ZFQywNCj4gCQlJVEVSX1hBUlJBWSwNCj4gCQlJVEVSX0RJ
U0NBUkQsDQo+IAl9Ow0KDQpXaWxsIGdjYyBhY3R1YWxseSBjb2RlIHRoaXMgdmVyc2lvbiB3aXRo
b3V0IHBlc3NpbWlzaW5nIGl0Pw0KDQoJaWYgKGxpa2VseSh0eXBlIDw9IElURVJfSU9WRUMpIHsN
CgkJaWYgKGxpa2VseSh0eXBlICE9IElURVJfSU9WRUMpKQ0KCQkJaXRlcmF0ZV91YnVmKCk7DQoJ
CWVsc2UNCgkJCWl0ZXJhdGVfaW92ZWMoKTsNCgl9IGVsc2UgaWYgKGxpa2VseSh0eXBlKSA8PSBJ
VEVSX0tWRUMpKSB7DQoJCWlmICh0eXBlID09IElURVJfS1ZFQykNCgkJCWl0ZXJhdGVfa3ZlYygp
Ow0KCQllbHNlDQoJCQlpdGVyYXRlX2J2ZWMoKTsNCgl9IGVsc2UgaWYgKHR5cGUgPT0gSVRFUl9Y
QVJSQVkpIHsNCgkJaXRlcmF0ZV94YXJyYXIoKQ0KCX0gZWxzZSB7DQoJCWRpc2NhcmQ7DQoJfQ0K
DQpCdXQgSSBiZXQgeW91IGNhbid0IHN0b3AgaXQgcmVwbGljYXRpbmcgdGhlIGNvbXBhcmVzLg0K
KGVzcGVjaWFsbHkgd2l0aCB0aGUgbGlrZWx5KCkuDQoNClRoYXQgaGFzIHR3byBtaXMtcHJlZGlj
dGVkIChhcmUgdGhleSBldmVyIHJpZ2h0ISkgYnJhbmNoZXMgaW4gdGhlDQpjb21tb24gdXNlci1j
b3B5IHZlcnNpb25zIGFuZCB0aHJlZSBpbiB0aGUgY29tbW9uIGtlcm5lbCBvbmVzLg0KDQpJbiBz
b21lIGFyY2hpdGVjdHVyZXMgeW91IG1pZ2h0IGdldCB0aGUgZGVmYXVsdCAnZmFsbCB0aHJvdWdo
Jw0KdG8gdGhlIFVCVUYgY29kZSBpZiB0aGUgYnJhbmNoZXMgYXJlbid0IHByZWRpY3RhYmxlLg0K
QnV0IEkgYmVsaWV2ZSBjdXJyZW50IHg4NiBjcHUgbmV2ZXIgZG8gc3RhdGljIHByZWRpY3Rpb24u
DQpTbyB5b3UgYWx3YXlzIGxvc2UgOi0pDQoNCi4uLg0KPiAJc3RhdGljIGlubGluZSBib29sIHVz
ZXJfYmFja2VkX2l0ZXIoY29uc3Qgc3RydWN0IGlvdl9pdGVyICppKQ0KPiAJew0KPiAJCXJldHVy
biBpdGVyX2lzX3VidWYoaSkgfHwgaXRlcl9pc19pb3ZlYyhpKTsNCj4gCX0NCj4gDQo+IHdoaWNo
IGdjYyBqdXN0IGNoYW5nZXMgaW50byBzb21ldGhpbmcgbGlrZSBhICJDTVAgJDEiIGFuZCBhICJK
QSIuDQoNClRoYXQgbWFrZXMgc2Vuc2UuLi4NCg0KPiBDb21wYXJpbmcgTGludXMncyBiaXQgcGF0
Y2ggKCsgaXMgYmV0dGVyKSB0byByZW51bWJlcmluZyB0aGUgc3dpdGNoICgtIGlzDQo+IGJldHRl
cik6DQo+IA0KLi4uLg0KPiBpb3ZfaXRlcl9pbml0ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGluYyAweDI3IC0+IDB4MzEgKzB4YQ0KDQpBcmUgeW91IGhpdHRpbmcgdGhlIGdjYyBidWcgdGhh
dCBsb2FkcyB0aGUgY29uc3RhbnQgZnJvbSBtZW1vcnk/DQoNCj4gSSB0aGluayB0aGVyZSBtYXkg
YmUgbW9yZSBzYXZpbmdzIHRvIGJlIG1hZGUgaWYgSSBnbyBhbmQgY29udmVydCBtb3JlIG9mIHRo
ZQ0KPiBmdW5jdGlvbnMgdG8gdXNpbmcgc3dpdGNoKCkuDQoNClNpemUgaXNuJ3QgZXZlcnl0aGlu
ZywgdGhlIGNvZGUgbmVlZHMgdG8gYmUgb3B0aW1pc2VkIGZvciB0aGUgaG90IHBhdGhzLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

