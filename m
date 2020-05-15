Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2711D5803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEORd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 13:33:27 -0400
Received: from mail-mw2nam12on2128.outbound.protection.outlook.com ([40.107.244.128]:60992
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbgEORd1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 13:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl79a+L3/kRseais3O61WRoEV+4tKNu8dSHBTj8qujDrg8g//kiOOaORyHcFs5XofReOoZgfd5kKGv5Dhy+G/nCC8cUYuypob+9JM2Mvl29gkJloJMtzusu4XXG6V0qRqgTeZffxwxH3o0xvoWzTgB4SBSK97Kg6agq+P4CZX505xvonbXMk5TrgMMqVBBVgWdmSkUqYXvyzXxpVHGg/Mk9HsK1BegiDxEePPv6C9rRqE9g9XQCB/asXa3VNOmjwvGFgM+TjbezHUjbyBzAC9fubOJGHXIxCLZmcHLS0hp9IP2AdNc09o7iAmJ8pIhT4Y+yxl8YbrVIfgVTMkZSqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhZPRgD56SmhxPz8dRZpKCAZC1xo3cjNv9IdpSDJfLY=;
 b=RNbX+69CL41/xY49eu2amusRkzBZhl08i5EcNOhDLq142QTFUsMTlzD4W/XCCyVGrNWkvWQUQ5VqyBRDyp5SX7NoweSrcTI1+xOFn5DAh4SrM5LzjPtULFQZKSiGCJrizcb8bhsZgFOH3hXlQHt6keqjRec2lxK4ooxtTWJOG8/YLvAWxris+XjkeFhlDtT0y9+lPMAhG/Mc/tAAUYwYvldsDWupaj1uJAZG4uoCA2M3SFypNHZLFwoyzPzJuZ0Fu04K/wR9Nk1/alNdqLZS4GNL6qHjh47CBKOPhqucGwvEZoIuQ+ETN3TArfvzaj9wGh/yZH2CqzGS+T8FdXDShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhZPRgD56SmhxPz8dRZpKCAZC1xo3cjNv9IdpSDJfLY=;
 b=RFzc3S0UGnfbmUi9/WnnmzhTFEaj6/Wq8mCsO2EJWIAl0BOMJa8YkHR1pb0wQn1lP7YK2ralob3dHK9vFFqwyI35YSRdrNDXjwCNKfYn63n9ad+Vri4Lmh6d22/8FgrMJSXgvM/Kahq5j6gqvapjZoHL9vh0zzwp0VFR5t57V6w=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3400.namprd13.prod.outlook.com (2603:10b6:610:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Fri, 15 May
 2020 17:33:21 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.010; Fri, 15 May 2020
 17:33:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH -next] nfs: fsinfo: fix build when CONFIG_NFS_V4 is not
 enabled
Thread-Topic: [PATCH -next] nfs: fsinfo: fix build when CONFIG_NFS_V4 is not
 enabled
Thread-Index: AQHWKt4lMy7Q6CzlOEGhiA37hN4oaaipaByA
Date:   Fri, 15 May 2020 17:33:21 +0000
Message-ID: <7c446f9f404135f0f4109e03646c4ce598484cae.camel@hammerspace.com>
References: <f91b8f29-271a-b5cd-410b-a43a399d34aa@infradead.org>
In-Reply-To: <f91b8f29-271a-b5cd-410b-a43a399d34aa@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ceeca14-b203-4dd6-fcde-08d7f8f6102a
x-ms-traffictypediagnostic: CH2PR13MB3400:
x-microsoft-antispam-prvs: <CH2PR13MB34001E0087C339751CE14C1EB8BD0@CH2PR13MB3400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNnussIdUul5hFSqA1T3F+0QPueZvMLkOJFbHDNYFWs/C0jiFpAYFLHTd3a3NIOHgLQaS8n9Cb6IGuXK0kZCs7jc/1Ywf607D41mAw86gwabDHpXgCJ3BPqINSOfABsFCdoVL1yRdwHcRboYtiT3x3fFLCVvJc1nyKBiDx5NZ9r9laeQBI4JS5lZWnM0d/LPr9902em6CxhURT9eYPXHqoeCdyzlNjy6xhEkPxgv6DyyRZJvkZunYAg+HPQE1q7kyk6F1qph9XW9xehRt5JkveR2hTF0RchxGK0gK6BslVxA8+uadhjU4bf3K6u1oXDy6B9s8KiBMZlC7lZzLLmfkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39830400003)(366004)(346002)(376002)(36756003)(64756008)(66446008)(86362001)(5660300002)(66556008)(66946007)(76116006)(66476007)(71200400001)(2906002)(6486002)(8936002)(6506007)(478600001)(26005)(6512007)(316002)(110136005)(2616005)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wfyPHy/mPSZBULWeA4avnN96avNNiGDJx1j1P40Kl/UVn0zRDScVzxQzQ9AWEDQGoFczJ7cDmaGsk+9TwyLoKmif3XYCzQDf5RJAO9na1zVhcRyL4u0EP6eHR1/8smqmkJ/PtfBwxqd+BRvDqkV8qk5hFgLyXgKAVJHPTK+DqhHx0yz3Vcj7DfWixPWlwgXaAD/4Sps0V7xRABWQYVus61Z268yj0Z9vZl2ny7fOSlT4Xk011v1Bf5YugosmKYRZ3/WLqSxsxCwM0msnzh6YqORXpdEHrZjC1uoYZ59Aocw2rsHXbL9CYQEScW6xShq7of/V+ODL/teHDaqxrvHtUJaXMiWdzKUO1Yy6VhyZECMcpwrHSzbPo85lpv2Ye0r9pAp+9NQi1zWsmb0Hl9gDkdZ/UCnewX9w2MXrM4js88maldz4kBk7G+AY7pqRSXT2RxvwlCYshi4tnouAgJ10145QXxnrtdJji13SnZxz2Q4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CAA3CC7001E9945B726C2AF04E684A4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceeca14-b203-4dd6-fcde-08d7f8f6102a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 17:33:21.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nb1L1/1Yg/0DTl7ta1gHYHAd1Jw79Ch2WNMU8VkNFB0quWMQfwhzznud0ek6FziMUUFbNYdHCUR21ALa7yu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3400
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDEwOjI3IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gRml4IG11
bHRpcGxlIGJ1aWxkIGVycm9ycyB3aGVuIENPTkZJR19ORlNfVjQgaXMgbm90IGVuYWJsZWQuDQo+
IA0KPiAuLi9mcy9uZnMvZnNpbmZvLmM6IEluIGZ1bmN0aW9uICduZnNfZnNpbmZvX2dldF9zdXBw
b3J0cyc6DQo+IC4uL2ZzL25mcy9mc2luZm8uYzoxNTM6MTI6IGVycm9yOiAnY29uc3Qgc3RydWN0
IG5mc19zZXJ2ZXInIGhhcyBubw0KPiBtZW1iZXIgbmFtZWQgJ2F0dHJfYml0bWFzaycNCj4gICBp
ZiAoc2VydmVyLT5hdHRyX2JpdG1hc2tbMF0gJiBGQVRUUjRfV09SRDBfU0laRSkNCj4gICAgICAg
ICAgICAgXn4NCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjE1NToxMjogZXJyb3I6ICdjb25zdCBzdHJ1
Y3QgbmZzX3NlcnZlcicgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCAnYXR0cl9iaXRtYXNrJw0KPiAg
IGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1sxXSAmIEZBVFRSNF9XT1JEMV9OVU1MSU5LUykNCj4g
ICAgICAgICAgICAgXn4NCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjE1ODoxMjogZXJyb3I6ICdjb25z
dCBzdHJ1Y3QgbmZzX3NlcnZlcicgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCAnYXR0cl9iaXRtYXNr
Jw0KPiAgIGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9BUkNISVZF
KQ0KPiAgICAgICAgICAgICBefg0KPiAuLi9mcy9uZnMvZnNpbmZvLmM6MTYwOjEyOiBlcnJvcjog
J2NvbnN0IHN0cnVjdCBuZnNfc2VydmVyJyBoYXMgbm8NCj4gbWVtYmVyIG5hbWVkICdhdHRyX2Jp
dG1hc2snDQo+ICAgaWYgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0hJ
RERFTikNCj4gICAgICAgICAgICAgXn4NCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjE2MjoxMjogZXJy
b3I6ICdjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcicgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCAnYXR0
cl9iaXRtYXNrJw0KPiAgIGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1sxXSAmIEZBVFRSNF9XT1JE
MV9TWVNURU0pDQo+ICAgICAgICAgICAgIF5+DQo+IC4uL2ZzL25mcy9mc2luZm8uYzogSW4gZnVu
Y3Rpb24gJ25mc19mc2luZm9fZ2V0X2ZlYXR1cmVzJzoNCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjIw
NToxMjogZXJyb3I6ICdjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcicgaGFzIG5vDQo+IG1lbWJlciBu
YW1lZCAnYXR0cl9iaXRtYXNrJw0KPiAgIGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1swXSAmIEZB
VFRSNF9XT1JEMF9DQVNFX0lOU0VOU0lUSVZFKQ0KPiAgICAgICAgICAgICBefg0KPiAuLi9mcy9u
ZnMvZnNpbmZvLmM6MjA3OjEzOiBlcnJvcjogJ2NvbnN0IHN0cnVjdCBuZnNfc2VydmVyJyBoYXMg
bm8NCj4gbWVtYmVyIG5hbWVkICdhdHRyX2JpdG1hc2snDQo+ICAgaWYgKChzZXJ2ZXItPmF0dHJf
Yml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9BUkNISVZFKSB8fA0KPiAgICAgICAgICAgICAgXn4N
Cj4gLi4vZnMvbmZzL2ZzaW5mby5jOjIwODoxMzogZXJyb3I6ICdjb25zdCBzdHJ1Y3QgbmZzX3Nl
cnZlcicgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCAnYXR0cl9iaXRtYXNrJw0KPiAgICAgICAoc2Vy
dmVyLT5hdHRyX2JpdG1hc2tbMF0gJiBGQVRUUjRfV09SRDBfSElEREVOKSB8fA0KPiAgICAgICAg
ICAgICAgXn4NCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjIwOToxMzogZXJyb3I6ICdjb25zdCBzdHJ1
Y3QgbmZzX3NlcnZlcicgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCAnYXR0cl9iaXRtYXNrJw0KPiAg
ICAgICAoc2VydmVyLT5hdHRyX2JpdG1hc2tbMV0gJiBGQVRUUjRfV09SRDFfU1lTVEVNKSkNCj4g
ICAgICAgICAgICAgIF5+DQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+
IENjOiBBbm5hIFNjaHVtYWtlciA8YW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbT4NCj4gQ2M6IEFs
ZXhhbmRlciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gQ2M6IGxpbnV4LWZzZGV2
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQu
Y29tPg0KPiAtLS0NCj4gIGZzL25mcy9mc2luZm8uYyB8ICAgIDUgKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IC0tLSBsaW51eC1uZXh0LTIwMjAwNTE1Lm9y
aWcvZnMvbmZzL2ZzaW5mby5jDQo+ICsrKyBsaW51eC1uZXh0LTIwMjAwNTE1L2ZzL25mcy9mc2lu
Zm8uYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gICAqIFdyaXR0ZW4gYnkgRGF2aWQgSG93ZWxscyAo
ZGhvd2VsbHNAcmVkaGF0LmNvbSkNCj4gICAqLw0KPiAgDQo+ICsjaW5jbHVkZSA8bGludXgva2Nv
bmZpZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L25mc19mcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3dpbmRvd3MuaD4NCj4gICNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPiBAQCAtMTUwLDYgKzE1MSw3
IEBAIHN0YXRpYyBpbnQgbmZzX2ZzaW5mb19nZXRfc3VwcG9ydHMoc3RydWMNCj4gIAkJc3VwLT5z
dHhfbWFzayB8PSBTVEFUWF9DVElNRTsNCj4gIAlpZiAoc2VydmVyLT5jYXBzICYgTkZTX0NBUF9N
VElNRSkNCj4gIAkJc3VwLT5zdHhfbWFzayB8PSBTVEFUWF9NVElNRTsNCj4gKyNpZiBJU19FTkFC
TEVEKENPTkZJR19ORlNfVjQpDQo+ICAJaWYgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFU
VFI0X1dPUkQwX1NJWkUpDQo+ICAJCXN1cC0+c3R4X21hc2sgfD0gU1RBVFhfU0laRTsNCj4gIAlp
ZiAoc2VydmVyLT5hdHRyX2JpdG1hc2tbMV0gJiBGQVRUUjRfV09SRDFfTlVNTElOS1MpDQo+IEBA
IC0xNjEsNiArMTYzLDcgQEAgc3RhdGljIGludCBuZnNfZnNpbmZvX2dldF9zdXBwb3J0cyhzdHJ1
Yw0KPiAgCQlzdXAtPndpbl9maWxlX2F0dHJzIHw9IEFUVFJfSElEREVOOw0KPiAgCWlmIChzZXJ2
ZXItPmF0dHJfYml0bWFza1sxXSAmIEZBVFRSNF9XT1JEMV9TWVNURU0pDQo+ICAJCXN1cC0+d2lu
X2ZpbGVfYXR0cnMgfD0gQVRUUl9TWVNURU07DQo+ICsjZW5kaWYNCj4gIA0KPiAgCXN1cC0+c3R4
X2F0dHJpYnV0ZXMgPSBTVEFUWF9BVFRSX0FVVE9NT1VOVDsNCj4gIAlyZXR1cm4gc2l6ZW9mKCpz
dXApOw0KPiBAQCAtMjAyLDEyICsyMDUsMTQgQEAgc3RhdGljIGludCBuZnNfZnNpbmZvX2dldF9m
ZWF0dXJlcyhzdHJ1Yw0KPiAgCWlmIChzZXJ2ZXItPmNhcHMgJiBORlNfQ0FQX01USU1FKQ0KPiAg
CQlmc2luZm9fc2V0X2ZlYXR1cmUoZnQsIEZTSU5GT19GRUFUX0hBU19NVElNRSk7DQo+ICANCj4g
KyNpZiBJU19FTkFCTEVEKENPTkZJR19ORlNfVjQpDQo+ICAJaWYgKHNlcnZlci0+YXR0cl9iaXRt
YXNrWzBdICYgRkFUVFI0X1dPUkQwX0NBU0VfSU5TRU5TSVRJVkUpDQo+ICAJCWZzaW5mb19zZXRf
ZmVhdHVyZShmdCwgRlNJTkZPX0ZFQVRfTkFNRV9DQVNFX0lOREVQKTsNCj4gIAlpZiAoKHNlcnZl
ci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0FSQ0hJVkUpIHx8DQo+ICAJICAgIChz
ZXJ2ZXItPmF0dHJfYml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9ISURERU4pIHx8DQo+ICAJICAg
IChzZXJ2ZXItPmF0dHJfYml0bWFza1sxXSAmIEZBVFRSNF9XT1JEMV9TWVNURU0pKQ0KPiAgCQlm
c2luZm9fc2V0X2ZlYXR1cmUoZnQsIEZTSU5GT19GRUFUX1dJTkRPV1NfQVRUUlMpOw0KPiArI2Vu
ZGlmDQo+ICANCj4gIAlyZXR1cm4gc2l6ZW9mKCpmdCk7DQo+ICB9DQoNClRoaXMgd2hvbGUgdGhp
bmcgbmVlZHMgdG8gYmUgcmV2aWV3ZWQgYW5kIGFja2VkIGJ5IHRoZSBORlMgY29tbXVuaXR5LA0K
YW5kIHF1aXRlIGZyYW5rbHkgSSdtIGluY2xpbmVkIHRvIE5BSyB0aGlzLiBUaGlzIGlzIHRoZSBz
ZWNvbmQgdGltZQ0KRGF2aWQgdHJpZXMgdG8gcHVzaCB0aGlzIHVud2FudGVkIHJld3JpdGUgb2Yg
dG90YWxseSB1bnJlbGF0ZWQgY29kZS4NCg0KPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
