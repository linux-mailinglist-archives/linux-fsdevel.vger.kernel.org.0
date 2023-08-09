Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7905777560E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHIJDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjHIJDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:03:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD911FE2
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:03:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-E2PvGH_dN_qFLXu5QR-fLA-1; Wed, 09 Aug 2023 10:03:09 +0100
X-MC-Unique: E2PvGH_dN_qFLXu5QR-fLA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 10:03:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 9 Aug 2023 10:03:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
CC:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
Thread-Topic: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
Thread-Index: AQHZyjf9/+BpaDZOA0md/r6gL7olr6/hq0VA
Date:   Wed, 9 Aug 2023 09:03:05 +0000
Message-ID: <760ee963ce814021ab64e1ec9fee6477@AcuMS.aculab.com>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner>
 <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner>
 <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
 <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com>
 <20230808-lebst-vorgibt-75c3010b4e54@brauner>
 <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
In-Reply-To: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggQXVndXN0IDIwMjMgMTg6MDUNCi4uLg0K
PiAgICAgICAgIHJldHVybiBfX2ZpbHBfY2xvc2UoZmlscCwgaWQsIHRydWUpOw0KPiANCj4gYW5k
IHRoZXJlIGlzIHplcm8gY2x1ZSBhYm91dCB3aGF0IHRoZSBoZWNrICd0cnVlJyBtZWFucy4NCj4g
DQo+IEF0IGxlYXN0IHRoZW4gdGhlICJiZWhhdmlvciBmbGFncyIgYXJlIG5hbWVkIGJpdG1hc2tz
LCB0aGluZ3MgbWFrZQ0KPiAqc2Vuc2UqLiBCdXQgd2UgaGF2ZSB0b28gbWFueSBvZiB0aGVzZSBi
b29sZWFuIGFyZ3VtZW50cy4NCg0KQW5kIG1ha2UgdGhlIHVzdWFsIGNhc2UgMC4NCg0KSSB3YXMg
Y2hhc2luZyB0aHJvdWdoIHNvbWUgY29kZSB0aGF0IGhhcyBhIGZsYWcgZm9yIGENCmNvbmRpdGlv
bmFsIGxvY2suDQpIb3dldmVyIGlzIHdhcyAnTkVFRF9UT19MT0NLJyBub3QgJ0FMUkVBRFlfTE9D
S0VEJy4NCihicGYgY2FsbGluZyBpbiB3aXRoIHRoZSBzb2NrZXQgbG9ja2VkKS4NCg0KQXMgd2Vs
bCBhcyBtYWtpbmcgdGhlIGNvZGUgaGFyZGVyIHRvIHJlYWQgaXQgaXMgYW4gYWNjaWRlbnQNCmp1
c3Qgd2FpdGluZyB0byBoYXBwZW4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

