Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619E5125F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLSKgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 05:36:04 -0500
Received: from mail-eopbgr10121.outbound.protection.outlook.com ([40.107.1.121]:12257
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfLSKgD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:36:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQlC8ehHRYc9FygN1dumIfrL7q+3E6G2avKRPhrvs4JpYiVqD8cxGHlZ9DuFeiVLsDVr+7leUuYSh4LfztqUCBodrNTR4DdCMvdK1d+bLCiClGZw6q+AGox4IWHQ0lIu9K7Ax3fxcPGz8BXiPCAVF3r97zT/N5/cx1xWy5vVWfQDdB5lcSqeqdDbYZq4D/BKzNwyz9yEqRRdM18gXwShcAUHnOO8tmYaHm5B5BQrEYEwVNYigCOoPtBpvAD4pEmOXr6EXpZP+jsYTuZqTk45bd1kmQy2ztrOr01h0+EoZHSIKyXMO5BB2DaKGLLZuPwF4BmCBMKNBdKA+0/hCXWycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcwfFu1mR4xBLsmZ0mx4t5sLfk53PAGoZYfAL4tpybk=;
 b=KZZV/kE10keJnTYHG7IodzCrhZh5Si/n2A70C9stKtmVkcJS2EXqybxIWUTvbCLzH3Bo54j530ZWV23ndogE+IsPfHFtWXm5FazJ1/fWysU2oJybon9R0ZH831kII7W6CHQDBuj66EDw+IPRHdAmZBUsZPGK3bVFnj2X+azJaiYAhAAvbdmk1uAxeVcWt6eMIC5tx4h79noKTP8kDxpsr6ajpy74On7rY+2oB5JzVHSACPqK4Qz9AFcEjSlZRz3/GSJ48/d7VAJmrz75q2bAQaIB7NF3FHS4pfupj0xaTu1aV1/dHHAoA2aHi+9MlQOuyMo+GHiCKY8+mTJB6D7ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcwfFu1mR4xBLsmZ0mx4t5sLfk53PAGoZYfAL4tpybk=;
 b=tTyR/Z5NNRnNeDyaQ0rCT0PoLM0as721x3mUZEDG+apjNd9BwRN2UvwjXytwj6lle0JH6FmkhWJqDxkgRghmt7hC7Jan6tC2EWzTxWJBvmuK9OmjEldbKw5V2qN181iQ6WImKnFugo7emdRHaiK1gBdQriVQu8m/siJPyjmjZ78=
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com (52.132.212.72) by
 AM0PR08MB4386.eurprd08.prod.outlook.com (20.179.32.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 10:35:57 +0000
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::6555:db6a:995c:ac0f]) by AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::6555:db6a:995c:ac0f%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 10:35:57 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Dave Chinner <david@fromorbit.com>,
        Shakeel Butt <shakeelb@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Thread-Topic: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Thread-Index: AQHVpv50iUgQuqhqn0Cemimr1eLSWKenDy+AgAVXUoCAAPvjgIAFP6sAgA7AIgA=
Date:   Thu, 19 Dec 2019 10:35:57 +0000
Message-ID: <ed839995-9f49-19b6-a46a-5f777cd8f52b@virtuozzo.com>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
 <20191206020953.GS2695@dread.disaster.area>
 <CALvZod4YrnLLbaqTrZR92Y45rd4G+UzcqrkwAptJGJ2Kc8i6Og@mail.gmail.com>
 <20191210012036.GB19213@dread.disaster.area>
In-Reply-To: <20191210012036.GB19213@dread.disaster.area>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0020.eurprd03.prod.outlook.com
 (2603:10a6:3:76::30) To AM0PR08MB5332.eurprd08.prod.outlook.com
 (2603:10a6:208:17e::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f0104b1-e536-4edc-9943-08d7846f3bd7
x-ms-traffictypediagnostic: AM0PR08MB4386:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4386CB7DA49E19252ADDBB89B7520@AM0PR08MB4386.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39830400003)(376002)(396003)(199004)(189003)(31686004)(26005)(8936002)(2616005)(52116002)(81166006)(36756003)(186003)(81156014)(6506007)(53546011)(66556008)(64756008)(66446008)(66946007)(7416002)(6512007)(6486002)(66476007)(86362001)(31696002)(4326008)(71200400001)(8676002)(316002)(110136005)(54906003)(478600001)(2906002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB4386;H:AM0PR08MB5332.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qraSADgxz65wpYed32sOcKtM28fFC2FO960+Gxy2YYzdxcNH/4eLkmrMVevi0rIgJfDWl109SF1U7VYzRw58xe0QbTs9UynAuCDu2P7mkAhiFShFwTw/Ui7JO9ah6Esde8GMmRqeZM24SPe3DVJlgu2zoJwWmKmXxp0JavxFJJmwoqlWPBtwz6N+zEwLZqsic+Zl8zt+Z9qbhWD0VrVQtob9FTqDE1QKFrke2rrzoCalrtdOEU/zS2GGlz2krmC1d0udYGxGaaUHkE7mije78TSNQyiB+4qnrh4RA/50GDWSBR0b0pQ9hoc08EBG14N6RGpBx6LDs3+8L/TeqI/4o4IAuSqNJlb02+uVrU2xRfAaoCc8XRjO84mWC8I5AOqU95i7pBHP5f8u3VrHpHAaOi1HUMHpFAKeDXtKmRs6+5CaSJbRREQnO60eKVT30Cfl
Content-Type: text/plain; charset="utf-8"
Content-ID: <4006B78015E8C64783ABBF308E03CE78@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0104b1-e536-4edc-9943-08d7846f3bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:35:57.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gdG7j0r/bttLBc0YdltsTe30AqHhR0v1twNVFLnfGpssomJlXo9+Shid3cPS9uJZoQLi1mitJyxbycG5vA2btQcw+VF221Gy0prGhe52/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4386
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTIvMTAvMTkgNDoyMCBBTSwgRGF2ZSBDaGlubmVyIHdyb3RlOg0KPiBPbiBGcmksIERlYyAw
NiwgMjAxOSBhdCAwOToxMToyNUFNIC0wODAwLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+PiBPbiBU
aHUsIERlYyA1LCAyMDE5IGF0IDY6MTAgUE0gRGF2ZSBDaGlubmVyIDxkYXZpZEBmcm9tb3JiaXQu
Y29tPiB3cm90ZToNCj4+PiBJZiBhIHNocmlua2VyIGlzIGJsb2NraW5nIGZvciBhIGxvbmcgdGlt
ZSwgdGhlbiB3ZSBuZWVkIHRvDQo+Pj4gd29yayB0byBmaXggdGhlIHNocmlua2VyIGltcGxlbWVu
dGF0aW9uIGJlY2F1c2UgYmxvY2tpbmcgaXMgYSBtdWNoDQo+Pj4gYmlnZ2VyIHByb2JsZW0gdGhh
biBqdXN0IHJlZ2lzdGVyL3VucmVnaXN0ZXIuDQo+Pj4NCj4+DQo+PiBZZXMsIHdlIHNob3VsZCBi
ZSBmaXhpbmcgdGhlIGltcGxlbWVudGF0aW9ucyBvZiBhbGwgc2hyaW5rZXJzIGFuZCB5ZXMNCj4+
IGl0IGlzIGJpZ2dlciBpc3N1ZSBidXQgd2UgY2FuIGFsc28gZml4IHJlZ2lzdGVyL3VucmVnaXN0
ZXIgaXNvbGF0aW9uDQo+PiBpc3N1ZSBpbiBwYXJhbGxlbC4gRml4aW5nIGFsbCBzaHJpbmtlcnMg
d291bGQgYSB0ZWRpb3VzIGFuZCBsb25nIHRhc2sNCj4+IGFuZCB3ZSBzaG91bGQgbm90IGJsb2Nr
IGZpeGluZyBpc29sYXRpb24gaXNzdWUgb24gaXQuDQo+IA0KPiAiZml4aW5nIGFsbCBzaHJpbmtl
cnMiIGlzIGEgYml0IG9mIGh5cGVyYm9sZSAtIHlvdSd2ZSBpZGVudGlmaWVkDQo+IG9ubHkgb25l
IGluc3RhbmNlIHdoZXJlIGJsb2NraW5nIGlzIGNhdXNpbmcgeW91IHByb2JsZW1zLiBJbmRlZWQs
DQo+IG1vc3Qgc2hyaW5rZXJzIGFyZSBhbHJlYWR5IG5vbi1ibG9ja2luZyBhbmQgd29uJ3QgY2F1
c2UgeW91IGFueQ0KPiBwcm9ibGVtcyBhdCBhbGwuDQo+IA0KPj4+IElPV3MsIHdlIGFscmVhZHkg
a25vdyB0aGF0IGN5Y2xpbmcgYSBnbG9iYWwgcndzZW0gb24gZXZlcnkNCj4+PiBpbmRpdmlkdWFs
IHNocmlua2VyIGludm9jYXRpb24gaXMgZ29pbmcgdG8gY2F1c2Ugbm90aWNhYmxlDQo+Pj4gc2Nh
bGFiaWxpdHkgcHJvYmxlbXMuIEhlbmNlIEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGlzIHNvcnQgb2Yg
ImN5Y2xlDQo+Pj4gdGhlIGdsb2JhbCByd3NlbSBmYXN0ZXIgdG8gcmVkdWNlIFt1bl1yZWdpc3Rl
ciBsYXRlbmN5IiBzb2x1dGlvbiBpcw0KPj4+IGdvaW5nIHRvIGZseSBiZWNhdXNlIG9mIHRoZSBy
dW50aW1lIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25zIGl0IHdpbGwNCj4+PiBpbnRyb2R1Y2UuLi4u
DQo+Pj4NCj4+DQo+PiBJIGFncmVlIHdpdGggeW91ciBzY2FsYWJpbGl0eSBjb25jZXJuICh0aG91
Z2ggb3RoZXJzIHdvdWxkIGFyZ3VlIHRvDQo+PiBmaXJzdCBkZW1vbnN0cmF0ZSB0aGUgaXNzdWUg
YmVmb3JlIGFkZGluZyBtb3JlIHNvcGhpc3RpY2F0ZWQgc2NhbGFibGUNCj4+IGNvZGUpLg0KPiAN
Cj4gTG9vayBhdCB0aGUgZ2l0IGhpc3RvcnkuIFdlICprbm93KiB0aGlzIGlzIGEgcHJvYmxlbSwg
c28gYW55b25lDQo+IGFyZ3VpbmcgdGhhdCB3ZSBoYXZlIHRvIHByb3ZlIGl0IGNhbiBnbyB0YWtl
IGEgbG9uZyB3YWxrIG9mIGEgc2hvcnQNCj4gcGxhbmsuLi4uDQo+IA0KPj4gTW9zdCBtZW1vcnkg
cmVjbGFpbSBjb2RlIGlzIHdyaXR0ZW4gd2l0aG91dCB0aGUgcGVyZm9ybWFuY2Ugb3INCj4+IHNj
YWxhYmlsaXR5IGNvbmNlcm4sIG1heWJlIHdlIHNob3VsZCBzd2l0Y2ggb3VyIHRoaW5raW5nLg0K
PiANCj4gSSB0aGluayB0aGVyZSdzIGEgbG90IG9mIGNvcmUgbW0gYW5kIG90aGVyIGRldmVsb3Bl
cnMgdGhhdCB3b3VsZA0KPiBkaXNhZ3JlZSB3aXRoIHlvdSB0aGVyZS4gV2l0aCByZXNwZWN0IHRv
IHNocmlua2Vycywgd2UndmUgYmVlbg0KPiBkaXJlY3RseSBjb25jZXJuZWQgYWJvdXQgcGVyZm9y
bWFuY2UgYW5kIHNjYWxhYmlsaXR5IG9mIHRoZQ0KPiBpbmRpdmlkdWFsIGluc3RhbmNlcyBhcyB3
ZWxsIGFzIHRoZSBpbmZyYXN0cnVjdHVyZSBmb3IgYXQgbGVhc3QgdGhlDQo+IGxhc3QgZGVjYWRl
Li4uLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gRGF2ZS4NCj4gDQoNClRoYW5rcyBhIGxvdCBmb3Ig
eW91ciByZXBsaWVzLCBub3cgSSBzZWUgdGhhdCB0aGUgY29yZSBvZiB0aGUgcHJvYmxlbSBpcyAN
CmluIG5mcyBoYW5nLCBiZWZvcmUgdGhhdCBJIHdhcyB1bnN1cmUgaWYgaXQncyBPSyB0byBoYXZl
IHN1Y2ggYSBoYW5nIGluIA0KZG9fc2hyaW5rX3NsYWIuDQoNCkkgaGF2ZSBhIHBvc3NpYmx5IGJh
ZCBpZGVhIG9uIGhvdyBteSBwYXRjaCBjYW4gc3RpbGwgd29yay4gV2hhdCBpZiB3ZSANCnVzZSB1
bmxvY2svcmVmY291bnQgd2F5IG9ubHkgZm9yIG5mcy1zaHJpbmtlcnM/IEl0IHdpbGwgc3RpbGwg
Z2l2ZSBhIA0KcGVyZm9ybWFuY2UgcGVuYWx0eSBpZiBvbmUgaGFzIG1hbnkgbmZzIG1vdW50cywg
YnV0IGZvciB0aG9zZSB3aG8gaGFzIA0KbGl0dGxlIG51bWJlciBvZiBuZnMgbW91bnRzIHRoZSBw
ZW5hbHR5IHdvdWxkIGJlIGxlc3MuIEFuZCB0aGlzIHdvdWxkIGJlIA0KYSBzbWFsbCBpc29sYXRp
b24gaW1wcm92ZW1lbnQgZm9yIG5mcyB1c2Vycy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsIFRpa2hv
bWlyb3YgUGF2ZWwNClNvZnR3YXJlIERldmVsb3BlciwgVmlydHVvenpvLg0K
