Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE7125EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLSKUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 05:20:43 -0500
Received: from mail-eopbgr50106.outbound.protection.outlook.com ([40.107.5.106]:15822
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfLSKUm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:20:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZC2J5fvoenTKovOz46TxztEnbado9zvKxu4y5hF8qRsz7mcxvrvp+qVQ1nxjEY3A+3TDurIyz9FZFRXOhujMctsJlCPFbTPxa7EyLt5E/jGinc0N6pACzCZr1SqnTGcbFMiZ3kn1YcrrL5t8JmpA+Qveg/7M9lXmji5nIvbHrc3wxxmyb9Z1mxlXGoGR+VDBmsjmvGb0XXvyJZsj117QGq63wJusqhGJxgh6/YGOQ0346cmTextEPXN0AttgkbBmO5SbLJRgT9aURcQ1v0KET2NeWBDmYHQt56RJDR9sPvpp/2TjPwj6oBf8WiQAwv7mBmeW76HnP/zT/KZPiUdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtkYFAswgpeW4bYzMVnB81wWPf33dBH6xah3ankjxp0=;
 b=LPs2XAcOL7H2NEgIRMiC9rOXw2htuODOyPp/Xg7Kizlh4iDfBCNhNm+V3Svfgf6v6HwuV3JUwcKpzUHjh8ArMwcxo1Cm9TQ5JUbapH9VliocGVQ+js+uloB/a/UtzGk11ZsHHAHtX0+kHyf4UeX33BhUqFsIeIz8zrUqSh/NKb5bWhh4ufhucbfX9VNc2DUk+ytJJOO62CIBxAFWrE4KklSgoZAuJG7H5ZcfMAD3Qyz7PcQLyaareouyi1sVXYcIx27g3QkOvtKBJoKItgmqyxs4atkP69RUvmOkYOktBH4AceZK/3jpOUf2BwR6PFYDFNtnPpfhJmokjP2WVBVW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtkYFAswgpeW4bYzMVnB81wWPf33dBH6xah3ankjxp0=;
 b=VdXIGn7giOiIBq4VTeWWsCPT6dyFQkH4zAGq5w7FwnlhlHTuSaHRVwlsXy/pQpCSxhInwpNiGNykImxk6ZE6wH3rdNsv8oe9rNgbcHHZV9g87CaLSm6SOTcWitgX6zIj7Ip22niIjOM7THTp7ffw4YxbHTC6jPYDeeZyAuqQy+M=
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com (52.132.212.72) by
 AM0PR08MB3457.eurprd08.prod.outlook.com (20.177.108.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 10:20:36 +0000
Received: from AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::6555:db6a:995c:ac0f]) by AM0PR08MB5332.eurprd08.prod.outlook.com
 ([fe80::6555:db6a:995c:ac0f%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 10:20:36 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dave Chinner <david@fromorbit.com>,
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
Thread-Index: AQHVpv50iUgQuqhqn0Cemimr1eLSWKeprYIAgBewZYA=
Date:   Thu, 19 Dec 2019 10:20:36 +0000
Message-ID: <f3fb2869-e89f-707b-c6e2-05d6e3abfb74@virtuozzo.com>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <20191204083514.GC25242@dhcp22.suse.cz>
In-Reply-To: <20191204083514.GC25242@dhcp22.suse.cz>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:7:66::20) To AM0PR08MB5332.eurprd08.prod.outlook.com
 (2603:10a6:208:17e::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f514c111-ce10-40ac-c7da-08d7846d1686
x-ms-traffictypediagnostic: AM0PR08MB3457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3457A32B374259B919CF5145B7520@AM0PR08MB3457.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39830400003)(189003)(199004)(2616005)(71200400001)(7416002)(8676002)(8936002)(5660300002)(186003)(316002)(31696002)(4326008)(64756008)(6916009)(52116002)(66476007)(66946007)(53546011)(6506007)(966005)(6486002)(6512007)(478600001)(66446008)(86362001)(2906002)(31686004)(81156014)(81166006)(54906003)(66556008)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3457;H:AM0PR08MB5332.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTN05Lng1ED5ExQjKPfY7FeUGxrEoRmP+ZwVv0K64CGxhWN/udsFRmwV1OUYLzrsPFBEXfsKBQOI8vIGyv768ccWYGeOBBgh7Mh31yhZt/dT6dS76zfT7o+T+waWLS52P16XTNJhk25WPfq/XhxmpoP32V+BDx4vtt4TGby6fIMY7VyCu5qFgtWzWAT9USiALyZn3E//Npe29+7XVLBLDPXiq8kQ5arZyauy/6oll2BZ9BTl5sFkDoQoP2UagYSbaidOteZGIlHzeikiN/Gs1OqzdPDO9j3lXP2c6k8EwA2UFyZ2GF1H88xBNLPehRBj+AH7SW5npheOpjoIBfP8+Zcg+b4+mYVBzRCZduzM97oI/dfVa+hsmN/+6uinPZIfQKWVjo60ps1OCmOjBUzQxKXku6pQ6SHLyrKX/d9L78SjgNlPaQDqnE9ffhv384pdaqWme0LqO6bs72VtwKlzgHrczpnInh+xSQRxX8paM4s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E579F461D779494A9D996861C06D6344@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f514c111-ce10-40ac-c7da-08d7846d1686
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:20:36.1662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/XOvXs1vLO+Cw2UNR93Ndcne6jdsv5xUQ+iqX3AwtXcUf05xIQUGZH1Z8jubYcVmNAqIrVUgohZ7v/xKdrjrdkAEarEvv+lldDjH469ErQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3457
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCk9uIDEyLzQvMTkgMTE6MzUgQU0sIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gT24gU2F0IDMw
LTExLTE5IDAwOjQ1OjQxLCBQYXZlbCBUaWtob21pcm92IHdyb3RlOg0KPj4gV2UgaGF2ZSBhIHBy
b2JsZW0gdGhhdCBzaHJpbmtlcl9yd3NlbSBjYW4gYmUgaGVsZCBmb3IgYSBsb25nIHRpbWUgZm9y
DQo+PiByZWFkIGluIHNocmlua19zbGFiLCBhdCB0aGUgc2FtZSB0aW1lIGFueSBwcm9jZXNzIHdo
aWNoIGlzIHRyeWluZyB0bw0KPj4gbWFuYWdlIHNocmlua2VycyBoYW5ncy4NCj4+DQo+PiBUaGUg
c2hyaW5rZXJfcndzZW0gaXMgdGFrZW4gaW4gc2hyaW5rX3NsYWIgd2hpbGUgdHJhdmVyc2luZyBz
aHJpbmtlcl9saXN0Lg0KPj4gSXQgdHJpZXMgdG8gc2hyaW5rIHNvbWV0aGluZyBvbiBuZnMgKGhh
cmQpIGJ1dCBuZnMgc2VydmVyIGlzIGRlYWQgYXQNCj4+IHRoZXNlIG1vbWVudCBhbHJlYWR5IGFu
ZCBycGMgd2lsbCBuZXZlciBzdWNjZWVkLiBHZW5lcmFsbHkgYW55IHNocmlua2VyDQo+PiBjYW4g
dGFrZSBzaWduaWZpY2FudCB0aW1lIHRvIGRvX3Nocmlua19zbGFiLCBzbyBpdCdzIGEgYmFkIGlk
ZWEgdG8gaG9sZA0KPj4gdGhlIGxpc3QgbG9jayBoZXJlLg0KPiANCj4gWWVzLCB0aGlzIGlzIGEg
a25vd24gcHJvYmxlbSBhbmQgcGVvcGxlIGhhdmUgYWxyZWFkeSB0cmllZCB0byBhZGRyZXNzIGl0
DQo+IGluIHRoZSBwYXN0LiBIYXZlIHlvdSBjaGVja2VkIHByZXZpb3VzIGF0dGVtcHRzPyBTUkNV
IGJhc2VkIG9uZQ0KPiBodHRwOi8vbGttbC5rZXJuZWwub3JnL3IvMTUzMzY1MzQ3OTI5LjE5MDc0
LjEyNTA5NDk1NzEyNzM1ODQzODA1LnN0Z2l0QGxvY2FsaG9zdC5sb2NhbGRvbWFpbg0KPiBidXQg
SSBiZWxpZXZlIHRoZXJlIHdlcmUgb3RoZXJzIChJIG9ubHkgaGFkIHRoaXMgb25lIGluIG15IG5v
dGVzKS4NCj4gUGxlYXNlIG1ha2Ugc3VyZSB0byBDYyBEYXZlIENoaW5uZXIgd2hlbiBwb3N0aW5n
IGEgbmV4dCB2ZXJzaW9uIGJlY2F1c2UNCj4gaGUgaGFkIHNvbWUgY29uY2VybnMgYWJvdXQgdGhl
IGNoYW5nZSBvZiB0aGUgYmVoYXZpb3IuDQoNClRoZSBhcHByb2FjaCBvZiB0aGUgcGF0Y2ggeW91
IGFyZSByZWZlcmVuY2luZyBpcyBxdWlldCBkaWZmZXJlbnQsIGl0IA0Kd2lsbCBzdGlsbCBob2xk
IGdsb2JhbCBzcmN1X3JlYWRfbG9jaygmc3JjdSkgd2hlbiBkaXZpbmcgaW4gDQpkb19zaHJpbmtf
c2xhYiBhbmQgaGFuZ2luZyBuZnMgd2lsbCBzdGlsbCBibG9jayBhbGwgW3VuXXJlZ2lzdGVyX3No
cmlua2VyLg0KDQo+IA0KPj4gV2UgaGF2ZSBhIHNpbWlsYXIgcHJvYmxlbSBpbiBzaHJpbmtfc2xh
Yl9tZW1jZywgZXhjZXB0IHRoYXQgd2UgYXJlDQo+PiB0cmF2ZXJzaW5nIHNocmlua2VyX21hcCtz
aHJpbmtlcl9pZHIgdGhlcmUuDQo+Pg0KPj4gVGhlIGlkZWEgb2YgdGhlIHBhdGNoIGlzIHRvIGlu
YyBhIHJlZmNvdW50IHRvIHRoZSBjaG9zZW4gc2hyaW5rZXIgc28gaXQNCj4+IHdvbid0IGRpc2Fw
cGVhciBhbmQgcmVsZWFzZSBzaHJpbmtlcl9yd3NlbSB3aGlsZSB3ZSBhcmUgaW4NCj4+IGRvX3No
cmlua19zbGFiLCBhZnRlciB0aGF0IHdlIHdpbGwgcmVhY3F1aXJlIHNocmlua2VyX3J3c2VtLCBk
ZWMNCj4+IHRoZSByZWZjb3VudCBhbmQgY29udGludWUgdGhlIHRyYXZlcnNhbC4NCj4gDQo+IFRo
ZSByZWZlcmVuY2UgY291bnQgcGFydCBtYWtlcyBzZW5zZSB0byBtZS4gUkNVIHJvbGUgbmVlZHMg
YSBiZXR0ZXINCj4gZXhwbGFuYXRpb24uDQoNCkkgaGF2ZSAyIHJjdSdzIGluIHBhdGNoLCAxLXN0
IGlzIHRvIHByb3RlY3Qgc2hyaW5rZXJfbWFwIHNhbWUgYXMgaXQgd2FzIA0KYmVmb3JlIGluIG1l
bWNnX3NldF9zaHJpbmtlcl9iaXQsIDItbmQgaXMgdG8gcHJvdGVjdCBzaHJpbmtlciBzdHJ1Y3Qg
aW4gDQpwdXRfc2hyaW5rZXIgZnJvbSBiZWluZyBmcmVlZCwgYXMgdW5yZWdpc3Rlcl9zaHJpbmtl
ciBjYW4gc2VlIHJlZmNudD09MCANCndpdGhvdXQgYWN0dWFsbHkgZ29pbmcgdG8gc2NoZWR1bGUo
KS4NCg0KPiBBbHNvIGRvIHlvdSBoYXZlIGFueSByZWFzb24gdG8gbm90IHVzZSBjb21wbGV0aW9u
IGZvcg0KPiB0aGUgZmluYWwgc3RlcD8gT3BlbmNvbmRpbmcgZXNzZW50aWFsbHkgdGhlIHNhbWUg
Y29uY2VwdCBzb3VuZHMgYSBiaXQNCj4gYXdrd2FyZCB0byBtZS4NCg0KVGhhbmtzIGZvciBhIGdv
b2QgaGludCwgZnJvbSB0aGUgZmlyc3QgZ2xhbmNlIHdlIGNhbiByZXdvcmsgd2FpdF9ldmVudCAN
CnBhcnQgdG8gd2FpdF9mb3JfY29tcGxldGlvbi4NCg0KPiANCj4+IFdlIGFsc28gbmVlZCBhIHdh
aXRfcXVldWUgc28gdGhhdCB1bnJlZ2lzdGVyX3Nocmlua2VyIGNhbiB3YWl0IGZvciB0aGUNCj4+
IHJlZmNudCB0byBiZWNvbWUgemVyby4gT25seSBhZnRlciB0aGVzZSB3ZSBjYW4gc2FmZWx5IHJl
bW92ZSB0aGUNCj4+IHNocmlua2VyIGZyb20gbGlzdCBhbmQgaWRyLCBhbmQgZnJlZSB0aGUgc2hy
aW5rZXIuDQo+IFsuLi5dDQo+PiAgICBjcmFzaD4gYnQgLi4uDQo+PiAgICBQSUQ6IDE4NzM5ICBU
QVNLOiAuLi4gIENQVTogMyAgIENPTU1BTkQ6ICJiYXNoIg0KPj4gICAgICMwIFsuLi5dIF9fc2No
ZWR1bGUgYXQgLi4uDQo+PiAgICAgIzEgWy4uLl0gc2NoZWR1bGUgYXQgLi4uDQo+PiAgICAgIzIg
Wy4uLl0gcnBjX3dhaXRfYml0X2tpbGxhYmxlIGF0IC4uLiBbc3VucnBjXQ0KPj4gICAgICMzIFsu
Li5dIF9fd2FpdF9vbl9iaXQgYXQgLi4uDQo+PiAgICAgIzQgWy4uLl0gb3V0X29mX2xpbmVfd2Fp
dF9vbl9iaXQgYXQgLi4uDQo+PiAgICAgIzUgWy4uLl0gX25mczRfcHJvY19kZWxlZ3JldHVybiBh
dCAuLi4gW25mc3Y0XQ0KPj4gICAgICM2IFsuLi5dIG5mczRfcHJvY19kZWxlZ3JldHVybiBhdCAu
Li4gW25mc3Y0XQ0KPj4gICAgICM3IFsuLi5dIG5mc19kb19yZXR1cm5fZGVsZWdhdGlvbiBhdCAu
Li4gW25mc3Y0XQ0KPj4gICAgICM4IFsuLi5dIG5mczRfZXZpY3RfaW5vZGUgYXQgLi4uIFtuZnN2
NF0NCj4+ICAgICAjOSBbLi4uXSBldmljdCBhdCAuLi4NCj4+ICAgICMxMCBbLi4uXSBkaXNwb3Nl
X2xpc3QgYXQgLi4uDQo+PiAgICAjMTEgWy4uLl0gcHJ1bmVfaWNhY2hlX3NiIGF0IC4uLg0KPj4g
ICAgIzEyIFsuLi5dIHN1cGVyX2NhY2hlX3NjYW4gYXQgLi4uDQo+PiAgICAjMTMgWy4uLl0gZG9f
c2hyaW5rX3NsYWIgYXQgLi4uDQo+IA0KPiBBcmUgTkZTIHBlb3BsZSBhd2FyZSBvZiB0aGlzPyBC
ZWNhdXNlIHRoaXMgaXMgc2ltcGx5IG5vdCBhY2NlcHRhYmxlDQo+IGJlaGF2aW9yLiBNZW1vcnkg
cmVjbGFpbSBjYW5ub3QgYmUgYmxvY2sgaW5kZWZpbml0ZWx5IG9yIGZvciBhIGxvbmcNCj4gdGlt
ZS4gVGhlcmUgbXVzdCBiZSBhIHdheSB0byBzaW1wbHkgZ2l2ZSB1cCBpZiB0aGUgdW5kZXJseWlu
ZyBpbm9kZQ0KPiBjYW5ub3QgYmUgcmVjbGFpbWVkLg0KDQpTb3JyeSB0aGF0IEkgZGlkbid0IGNj
IG5mcyBwZW9wbGUgZnJvbSB0aGUgYmVnaW5pbmcuDQoNCj4gDQo+IEkgc3RpbGwgaGF2ZSB0byB0
aGluayBhYm91dCB0aGUgcHJvcG9zZWQgc29sdXRpb24uIEl0IHNvdW5kcyBhIGJpdCBvdmVyDQo+
IGNvbXBsaWNhdGVkIHRvIG1lLg0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsIFRpa2hvbWlyb3Yg
UGF2ZWwNClNvZnR3YXJlIERldmVsb3BlciwgVmlydHVvenpvLg0K
