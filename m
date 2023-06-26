Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4895373DB23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFZJUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFZJTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D73C19
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 02:16:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-128--2i5PMHPMya9Tn9UXmmevQ-1; Mon, 26 Jun 2023 10:16:16 +0100
X-MC-Unique: -2i5PMHPMya9Tn9UXmmevQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 10:16:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Jun 2023 10:16:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Franck Grosjean <fgrosjea@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pipe: Make a partially-satisfied blocking read wait for
 more
Thread-Topic: [PATCH] pipe: Make a partially-satisfied blocking read wait for
 more
Thread-Index: AQHZpir6nf64Bm6mB0W9DmTd8gcjT6+c0Jmg
Date:   Mon, 26 Jun 2023 09:16:15 +0000
Message-ID: <4fd200bd9df24106a6d19293a495b661@AcuMS.aculab.com>
References: <2730511.1687559668@warthog.procyon.org.uk>
 <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
 <CAHk-=wjjNErGaMCepX-2q_3kuZV_aNoqB5SE-LLR_eLk2+OHJA@mail.gmail.com>
 <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
In-Reply-To: <CAHk-=wjrsPMko==NyQ1Y=Cta-ATshCwzSn9OwCq6KAx8Gh8RLA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgSnVuZSAyMDIzIDAwOjMyDQo+IA0KPiBP
biBGcmksIDIzIEp1biAyMDIzIGF0IDE2OjA4LCBMaW51cyBUb3J2YWxkcw0KPiA8dG9ydmFsZHNA
bGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSW4gZmFjdCwgSSdkIGV4cGVj
dCB0aGF0IHBhdGNoIHRvIGZhaWwgaW1tZWRpYXRlbHkgb24gYSBwZXJmZWN0bHkNCj4gPiBub3Jt
YWwgcHJvZ3JhbSB0aGF0IHBhc3NlcyBhIHRva2VuIGFyb3VuZCBieSBkb2luZyBhIHNtYWxsIHdy
aXRlIHRvIGENCj4gPiBwaXBlLCBhbmQgaGF2ZSB0aGUgInRva2VuIHJlYWRlciIgZG8gYSBiaWdn
ZXIgd3JpdGUuDQo+IA0KPiBCaWdnZXIgX3JlYWRfLCBvZiBjb3Vyc2UuDQo+IA0KPiBUaGlzIG1p
Z2h0IGJlIGhpZGRlbiBieSBzdWNoIHByb2dyYW1zIHR5cGljYWxseSBkb2luZyBhIHNpbmdsZSBi
eXRlDQo+IHdyaXRlIGFuZCBhIHNpbmdsZSBieXRlIHJlYWQsIGJ1dCBJIGNvdWxkIGVhc2lseSBp
bWFnaW5lIHNpdHVhdGlvbnMNCj4gd2hlcmUgcGVvcGxlIGFjdHVhbGx5IGRlcGVuZCBvbiB0aGUg
UE9TSVggYXRvbWljaXR5IGd1YXJhbnRlZXMsIGllIHlvdQ0KPiB3cml0ZSBhICJ0b2tlbiBwYWNr
ZXQiIHRoYXQgbWlnaHQgYmUgdmFyaWFibGUtc2l6ZWQsIGFuZCB0aGUgcmVhZGVyDQo+IHRoZW4g
anVzdCBkb2VzIGEgbWF4aW1hbGx5IHNpemVkIHJlYWQsIGtub3dpbmcgdGhhdCBpdCB3aWxsIGdl
dCBhIGZ1bGwNCj4gcGFja2V0IG9yIG5vdGhpbmcuDQoNClRoZXJlIGFyZSBkZWZpbml0ZWx5IHBy
b2dyYW1zIHRoYXQganVzdCBkbyBhIGxhcmdlIHJlYWQgaW4gb3JkZXINCnRvIGNvbnN1bWUgYWxs
IHRoZSBzaW5nbGUgYnl0ZSAnd2FrZXVwJyB3cml0ZXMuDQoNCihUaGUgJ211c3QgY2hlY2snIG9u
IHRoZXNlIHJlYWRzIGlzIGEgcmlnaHQgUElUQS4pDQoNClRoZXkgb3VnaHQgdG8gc2V0IHRoZSBw
aXBlIG5vbi1ibG9ja2luZywgYnV0IEkgc3VzcGVjdCBtYW55DQpkb24ndCAtIGJlY2F1c2UgaXQg
YWxsIHdvcmtzIGFueXdheS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

