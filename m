Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C473DB70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFZJb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFZJb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:31:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60508F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 02:31:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-KlAEpZ10PpWLOI4ALd46BQ-1; Mon, 26 Jun 2023 10:31:53 +0100
X-MC-Unique: KlAEpZ10PpWLOI4ALd46BQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 10:31:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Jun 2023 10:31:52 +0100
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
Thread-Index: AQHZpiQIVAgSMCrk8UeX4nEsAOQxPq+c1Vbw
Date:   Mon, 26 Jun 2023 09:31:52 +0000
Message-ID: <fa6de786ee1241c6ba54c3cce0b980aa@AcuMS.aculab.com>
References: <2730511.1687559668@warthog.procyon.org.uk>
 <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiXr2WTDFZi6y8c4TjZXfTnw28BkLF9Fpe=SyvmSCvP2Q@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgSnVuZSAyMDIzIDIzOjQyDQo+IA0KPiBP
biBGcmksIDIzIEp1biAyMDIzIGF0IDE1OjM0LCBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRo
YXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IENhbiB5b3UgY29uc2lkZXIgbWVyZ2luZyBzb21ldGhp
bmcgbGlrZSB0aGUgYXR0YWNoZWQgcGF0Y2g/ICBVbmZvcnR1bmF0ZWx5LA0KPiA+IHRoZXJlIGFy
ZSBhcHBsaWNhdGlvbnMgb3V0IHRoZXJlIHRoYXQgZGVwZW5kIG9uIGEgcmVhZCBmcm9tIHBpcGUo
KSB3YWl0aW5nDQo+ID4gdW50aWwgdGhlIGJ1ZmZlciBpcyBmdWxsIHVuZGVyIHNvbWUgY2lyY3Vt
c3RhbmNlcy4gIFBhdGNoIGEyOGM4YjlkYjhhMQ0KPiA+IHJlbW92ZWQgdGhlIGNvbmRpdGlvbmFs
aXR5IG9uIHRoZXJlIGJlaW5nIGFuIGF0dGFjaGVkIHdyaXRlci4NCj4gDQo+IFRoaXMgcGF0Y2gg
c2VlbXMgYWN0aXZlbHkgd3JvbmcsIGluIHRoYXQgbm93IGl0J3MgcG9zc2libHkgd2FpdGluZyBm
b3INCj4gZGF0YSB0aGF0IHdvbid0IGNvbWUsIGV2ZW4gaWYgaXQncyBub25ibG9ja2luZy4NCg0K
SSB0aGluayBpdCBwcmV0dHkgbXVjaCBicmVha3M6DQoJY29tbWFuZCB8IHRlZSBmaWxlDQp3aGVy
ZSAnY29tbWFuZCcgaXMgY2FyZWZ1bCB0byBmZmx1c2goc3Rkb3V0KS4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

