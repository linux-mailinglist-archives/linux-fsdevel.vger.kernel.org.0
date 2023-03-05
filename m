Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4E6AB191
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 18:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCERXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 12:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCERXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:23:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD3EC6F
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Mar 2023 09:23:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-250-LOSwqRzdPumsQ90Himc9cg-1; Sun, 05 Mar 2023 17:23:31 +0000
X-MC-Unique: LOSwqRzdPumsQ90Himc9cg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Sun, 5 Mar
 2023 17:23:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Sun, 5 Mar 2023 17:23:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@suse.de>
CC:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Thread-Topic: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Thread-Index: AQHZTtzWe5NzBLiIgUWjC9/KNPby/q7sbr9A
Date:   Sun, 5 Mar 2023 17:23:29 +0000
Message-ID: <f764a4ff956c4de8b059602c539e2c4a@AcuMS.aculab.com>
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV>
 <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
 <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com>
 <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
 <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
In-Reply-To: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDQgTWFyY2ggMjAyMyAyMDo0OA0KPiANCj4g
T24gU2F0LCBNYXIgNCwgMjAyMyBhdCAxMjozMeKAr1BNIE1hdGV1c3ogR3V6aWsgPG1qZ3V6aWtA
Z21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEdvb2QgbmV3czogZ2NjIHByb3ZpZGVzIGEgbG90
IG9mIGNvbnRyb2wgYXMgdG8gaG93IGl0IGlubGluZXMgc3RyaW5nDQo+ID4gb3BzLCBtb3N0IG5v
dGFibHk6DQo+ID4gICAgICAgIC1tc3RyaW5nb3Atc3RyYXRlZ3k9YWxnDQo+IA0KPiBOb3RlIHRo
YXQgYW55IHN0YXRpYyBkZWNpc2lvbiBpcyBhbHdheXMgZ29pbmcgdG8gYmUgY3JhcCBzb21ld2hl
cmUuDQo+IFlvdSBjYW4gbWFrZSBpdCBkbyB0aGUgIm9wdGltYWwiIHRoaW5nIGZvciBhbnkgcGFy
dGljdWxhciBtYWNoaW5lLCBidXQNCj4gSSBjb25zaWRlciB0aGF0IHRvIGJlIGp1c3QgZ2FyYmFn
ZS4NCj4gDQo+IFdoYXQgSSB3b3VsZCBhY3R1YWxseSBsaWtlIHRvIHNlZSBpcyB0aGUgY29tcGls
ZXIgYWx3YXlzIGdlbmVyYXRlIGFuDQo+IG91dC1vZi1saW5lIGNhbGwgZm9yIHRoZSAiYmlnIGVu
b3VnaCB0byBub3QganVzdCBkbyBpbmxpbmUgdHJpdmlhbGx5Ig0KPiBjYXNlLCBidXQgZG8gc28g
d2l0aCB0aGUgInJlcCBzdG9zYi9tb3ZzYiIgY2FsbGluZyBjb252ZW50aW9uLg0KDQpJIHRoaW5r
IHlvdSBhbHNvIHdhbnQgaXQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHJlcXVlc3RzIHRoYXQN
CmFyZSBrbm93biB0byBiZSBhIHdob2xlIG51bWJlciBvZiB3b3JkcyBhbmQgb25lcyB0aGF0IG1p
Z2h0DQpiZSBieXRlIHNpemVkLg0KDQpGb3IgdGhlIGttYWxsb2MrbWVtemVybyBjYXNlIHlvdSBr
bm93IHlvdSBjYW4gemVybyBhIHdob2xlDQpudW1iZXIgb2Ygd29yZHMgLSBzbyBhbGwgdGhlIGNo
ZWNrcyBtZW1zZXQgaGFzIHRvIGRvIGZvcg0KYnl0ZSBsZW5ndGgvYWxpZ25tZW50IGNhbiBiZSBy
ZW1vdmVkLg0KDQpUaGUgc2FtZSBpcyB0cnVlIGZvciBtZW1jcHkoKSBjYWxscyB1c2VkIGZvciBz
dHJ1Y3R1cmUgY29waWVzLg0KVGhlIGNvbXBpbGVyIGtub3dzIHRoYXQgYWxpZ25lZCBmdWxsLXdv
cmQgY29waWVzIGNhbiBiZSBkb25lLg0KU28gaXQgc2hvdWxkbid0IGJlIGNhbGxpbmcgYSBmdW5j
dGlvbiB0aGF0IGhhcyB0byByZWRvIHRoZSB0ZXN0cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

