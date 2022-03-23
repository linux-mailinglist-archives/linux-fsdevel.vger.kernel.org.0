Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E954E4A87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiCWBhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiCWBhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:37:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CE4611A20
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 18:35:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-XHEmaLmFMKCfa60oSAy2oA-1; Wed, 23 Mar 2022 01:35:34 +0000
X-MC-Unique: XHEmaLmFMKCfa60oSAy2oA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 23 Mar 2022 01:35:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 23 Mar 2022 01:35:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        "chenjiahao (C)" <chenjiahao16@huawei.com>
CC:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
Thread-Topic: [PATCH -next] uaccess: fix __access_ok limit setup in compat
 mode
Thread-Index: AQHYPfsecjlH4Ezf4kOvHM6pPLYCHKzMKolw
Date:   Wed, 23 Mar 2022 01:35:34 +0000
Message-ID: <bdebdcb56b8a4af8a6b1d22029a2e7ba@AcuMS.aculab.com>
References: <20220318071130.163942-1-chenjiahao16@huawei.com>
 <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com>
 <88ff36b3-558b-9c3f-f21d-5ef05b3227c5@huawei.com>
 <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
In-Reply-To: <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyMiBNYXJjaCAyMDIyIDE0OjQxDQo+IA0KPiBP
biBUdWUsIE1hciAyMiwgMjAyMiBhdCAxOjU1IFBNIGNoZW5qaWFoYW8gKEMpIDxjaGVuamlhaGFv
MTZAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4g5ZyoIDIwMjIvMy8xOCAxNTo0NCwgQXJuZCBCZXJn
bWFubiDlhpnpgZM6DQo+ID4gPg0KPiA+ID4gVGhpcyBzaG91bGQgbm90IHJlc3VsdCBpbiBhbnkg
dXNlciB2aXNpYmxlIGRpZmZlcmVuY2UsIGluIGJvdGggY2FzZXMNCj4gPiA+IHVzZXIgcHJvY2Vz
cyB3aWxsIHNlZSBhIC1FRkFVTFQgcmV0dXJuIGNvZGUgZnJvbSBpdHMgc3lzdGVtIGNhbGwuDQo+
ID4gPiBBcmUgeW91IGFibGUgdG8gY29tZSB1cCB3aXRoIGEgdGVzdCBjYXNlIHRoYXQgc2hvd3Mg
YW4gb2JzZXJ2YWJsZQ0KPiA+ID4gZGlmZmVyZW5jZSBpbiBiZWhhdmlvcj8NCj4gPg0KPiA+IEFj
dHVhbGx5LCB0aGlzIHBhdGNoIGRvIGNvbWVzIGZyb20gYSB0ZXN0Y2FzZSBmYWlsdXJlLCB0aGUg
Y29kZSBpcw0KPiA+IHBhc3RlZCBiZWxvdzoNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHRlc3Qg
Y2FzZSENCj4gDQouLi4NCj4gPiAgICAgIHJldCA9IHByZWFkNjQoZmQsIGJ1ZiwgLTEsIDEpOw0K
PiA+ICAgICAgaWYoKC0xID09IHJldCkgJiYgKEVGQVVMVCA9PSBlcnJubykpDQo+ID4gICAgICB7
DQouLi4NCj4gPiAgICAgICAgICBwcmludGYoIlBBU1NcbiIpOw0KLi4uDQo+ID4gSW4gbXkgZXhw
bGFuYXRpb24sIHByZWFkNjQgaXMgY2FsbGVkIHdpdGggY291bnQgJzB4ZmZmZmZmZmZ1bGwnIGFu
ZA0KPiA+IG9mZnNldCAnMScsIHdoaWNoIG1pZ2h0IHN0aWxsIG5vdCB0cmlnZ2VyDQo+ID4NCj4g
PiBwYWdlIGZhdWx0IGluIDY0LWJpdCBrZXJuZWwuDQo+ID4NCj4gPg0KPiA+IFRoaXMgcGF0Y2gg
dXNlcyBUQVNLX1NJWkUgYXMgdGhlIGFkZHJfbGltaXQgdG8gcGVyZm9ybWFuY2UgYSBzdHJpY3Rl
cg0KPiA+IGFkZHJlc3MgY2hlY2sgYW5kIGludGVyY2VwdHMNCj4gDQo+IEkgc2VlLiBTbyB3aGls
ZSB0aGUga2VybmVsIGJlaGF2aW9yIHdhcyBub3QgbWVhbnQgdG8gY2hhbmdlIGZyb20NCj4gbXkg
cGF0Y2gsIGl0IGNsZWFybHkgZGlkLCB3aGljaCBtYXkgY2F1c2UgcHJvYmxlbXMuIEhvd2V2ZXIs
IEknbQ0KPiBub3Qgc3VyZSBpZiB0aGUgY2hhbmdlZCBiZWhhdmlvciBpcyBhY3R1YWxseSB3cm9u
Zy4NCg0KSXQgaXNuJ3QgcmVhbGx5IGFueSBkaWZmZXJlbnQgZnJvbSBwYXNzaW5nIGEgbGVuZ3Ro
IG9mICgxIDw8IDMwKQ0KKGFuZCBhIGJ1ZmZlciBhdCBhIGxvdyB1c2VyIGFkZHJlc3MpLg0KVGhl
IGVudGlyZSBidWZmZXIgaXMgdmFsaWQgdXNlciBhZGRyZXNzZXMsIGJ1dCBtb3N0IG9mIGl0IGlz
DQppbnZhbGlkIGJlY2F1c2UgdGhlcmUgaXMgbm90aGluZyBtYXBwZWQgYXQgdGhlIHJlbGV2YW50
IGFkZHJlc3Nlcy4NClVubGVzcyB5b3UgYWN0dWFsbHkgdHJ5IHRvIGFjY2VzcyBvbmUgb2YgdGhl
IG1lbW9yeSBsb2NhdGlvbnMNCnlvdSB3b24ndCBnZXQgYSBmYXVsdCAtIGFuZCB0aGUgY29ycmVj
dCByZXR1cm4gaXMgdGhlbiBhIHBhcnRpYWwgcmVhZC4NCg0KU2ltaWxhcmx5IGl0IGlzIHZhbGlk
IGZvciB0aGUga2VybmVsIHRvIGVuc3VyZSB0aGVyZSBpcyBhbg0KdW5tYXBwZWQgcGFnZSBiZXR3
ZWVuIHVzZXIgYW5kIGtlcm5lbCBhZGRyZXNzZXMgYW5kIHRoZW4NCm5vdCBjaGVjayB0aGUgYnVm
ZmVyIHNpemUgYXQgYWxsIC0gcmVxdWlyaW5nIHRoZSBrZXJuZWwgY29kZQ0KZG8gKGFkZXF1YXRl
bHkpIHNlcXVlbnRpYWwgYWNjZXNzZXMuDQpBZ2FpbiB5b3VyIHRlc3QgJ2ZhaWxzJy4NCg0KWW91
IGNvdWxkIGVxdWFsbHkgd2VsbCBhcmd1ZSB0aGF0IHRoZSAnb2xkJyBiZWhhdmlvdXIgaXMgd3Jv
bmchDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

