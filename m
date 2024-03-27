Return-Path: <linux-fsdevel+bounces-15453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6288E9F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9525E1C2DBD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C712FB29;
	Wed, 27 Mar 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="d8w83Q3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF912A14B;
	Wed, 27 Mar 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555018; cv=fail; b=DHaU9m6mIEhPA1yy29nEEe3qmRihbpGODJLdl/Ts9wmRdAonZ0nrY6K8fVPx4t9fnS6BHVImoUmjhyIO6bVmRuQQle/9Mex5clNGZN6+EqoZR1qEW77T/WZWfTOUhwxdHy+PTEv34jMDgxTgzS19L5cmk4v6XLljeqjj+/soSUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555018; c=relaxed/simple;
	bh=FXJFCR+BBXk+rUR7mQfA3LSVcIGFTjLUBBnpteZKoAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ENES7mOoIXHhRO+BklNK9aqF+HKbASBXZX+3obl8+PVWyJNif32Byi5oDDy3v+DsvPw0+dnVq8COi/1b5WWDS9tb9n98Vyp9J+d+vkFZIT8TxCkzl+RG4f/NYcTXftyN+pQcDnyX/+K9u59PmNnc3wCazW9WCZc0VwyuXQL3OeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=d8w83Q3z; arc=fail smtp.client-ip=40.107.92.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOZYhV4alxHbyhM7lHKUiCKqwsaJ4jR8xYTiJS4yWEd/qt98AvDJp2C+tleEIR6JeIe/zffr4kIQSBvkNA0VCz/QIJqk3e4eamIDHS6XLxYDLqb/8X1mLbSLbePCctYY6DByV0iaSP+H+LkfRv72+OHimVuhsZhh4zmS+Eem+2oIb6E4ioi7VQnNSUq+aTfFqDZC1S1QRPpnUOOkzHCfci6S140EDhFaEVUBrmqFVZJosQUQ4pkvnw2JH5/me9YDTgp5M/p3YX3jxNo4/Ckv+ISRqioPEtd6KTAwfh27L94OB+B+36o9XguiaXRg6jvgoe0DPQX0RUPHfphNmLRjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXJFCR+BBXk+rUR7mQfA3LSVcIGFTjLUBBnpteZKoAY=;
 b=CycrcnSM51+aM69eQ8Ue0sPzij0nC2f3cnd2z9hMRvIxhBV9SLGM+IZzNoPWiNvapXun9NQ572TKHNWMu6pFTJQ5AMwLk0oxuoNaWV4wlIptKWuaosOe+xDs9z6NOuemnLXjt99AMLbzgBD036LwXcDMQi29YEHNoDi65+0VyJoOeRr9TgHi4BUxeJs9q+38sYNmBUyT5hOHaQmx3ycC6QK1CNsQsgoi4DO7hfrvs5OOEQpL5npBhTx6gcWq4BELOv9Bw8SHXv90GwXHxeNYwrCFl44teZauKcICQYB3F1hC3+gK+8qwpX4sqyLPyNcHc1F0olxqaUe2MqpomPmKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXJFCR+BBXk+rUR7mQfA3LSVcIGFTjLUBBnpteZKoAY=;
 b=d8w83Q3zZMeSxMialAkLTswhRDjN1rSeFjn9QON1lwq2CqIl47lMegbNJqQJ+hLPoKotJOiJO0lzhGhqh9faQrw6oDZf02K4Je4DYolJi1iL2dHGgn+CeWsUzH/1fXlm12dzj9m0JS7kBAJQMd4lpYboxQZMSyyMrXlc2OSLxCg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4852.namprd13.prod.outlook.com (2603:10b6:a03:364::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 15:56:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 15:56:50 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"willy@infradead.org" <willy@infradead.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@lists.orangefs.org" <devel@lists.orangefs.org>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>
Subject: Re: [RFC PATCH] mm, netfs: Provide a means of invalidation without
 using launder_folio
Thread-Topic: [RFC PATCH] mm, netfs: Provide a means of invalidation without
 using launder_folio
Thread-Index: AQHagFgP7Mkjvq23K0uqjflULja+w7FLvg6A
Date: Wed, 27 Mar 2024 15:56:50 +0000
Message-ID: <37514eae34c02cefb11fc4c6d3f4ae2296fb6ab5.camel@hammerspace.com>
References: <2318298.1711551844@warthog.procyon.org.uk>
In-Reply-To: <2318298.1711551844@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY3PR13MB4852:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AnamPbhxCzS7FRPRsuKlnU8eK3T8fssJ92zatLvQhYSGel1cTwPOkEQLyOaWPmgQvnGANwwMbGBvaLk0n2sJklkVz9U1JoTXpAMaGOEEpuA6I3sLxrhTWYkMyaUJP30DEBnYw9SRjAgVW4sw6S+L5dcjYyNjcz5o7+nml/ctNI4QCGKYXkkNKXoY6EJkUvvGhynbrQdKO+lnm/kcMv/LljShlhcGqvWe4G5SBIHG7LUt1tmF0STSRyPT1f4gIzDZjsBVRAZlsEpyODVg2KIVd/TOI/Xt5rpE8G7TgPc3WG4zTShEAIo1fbjhLH4mFQ0dZA/kpcTPs7jGCWjdRTSas+ao2c/Sd5FEE391NLa+viWmed88XzDiy52acqOp40KoWzSvztAIgKGxNHRWA/80FEmslejaUSyg+M/9jdCCy4FlXSEUwOfOu3MOFBzR9fpW+VN7rVgXXvSZ5S4D+amwBzPteqgZF+MFhT/4QswEIpe5lCDT/OaFewxPQTGI9lL7FInctJXxgTUR6xx5okF8DMg7auLaxciFhKVaqJs9u/M+J9NCXfLgnAj+NbuooETuQg4IEtnTabdhBRZwZvtvpKeaV8OLaI9C1YJl3RNijZc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzQzYXBqTGpLaVlGTXBnVnZJUUpQa0VIMjQ1U2Y1cVMyMTRBbHF4dEcwNG92?=
 =?utf-8?B?YXhORitjbXl0RmNpeVRYUjhCaEtEbUpCQmdnVHNucDQ1WklnUUsrZEQxOGsw?=
 =?utf-8?B?K1h2bWRFVnRaMHNOZmZTRFBLaml4STBLV2hMNWhIcVVmNXkySCtMVThaL2xw?=
 =?utf-8?B?TmFyeDRaVFNFUW12aUV2UmY3M1p4a0NFaEhPL0pCZHlXaE14R3B0dDRHSXhw?=
 =?utf-8?B?QVpINUJybVhtclBmNUdaU1dUL3B6YnZZMUV3SDRuMFJhVjArQlUxby9wWHVh?=
 =?utf-8?B?aUwvWXEyUUMwQ2d2MlEzcmN6bnVnNEx6dCs1eUkxODRBRVVERGdud3E4dWly?=
 =?utf-8?B?U084OThVaUFicktoTEJ1MTFNU2d4VVRBMkJvYW9IZWFVNmJMZ1o4d2EyekpN?=
 =?utf-8?B?WWt4S3pKM0wwZDlmVndndHBNeFlUYmVUT3Z3a21XNWFrWmY1d0RoQlNmUmg1?=
 =?utf-8?B?eHBKQldqNlFnODBtdFFNaGFFZ0xpci9NZkxKZ3NNQnRVbFE1c2NDOHd0ejZU?=
 =?utf-8?B?UlV4dmFJcmF4QjlMU3F1WHlCeGhDQTltUzlkVU1uMGV2MVI0Y1RzSEdmc0w1?=
 =?utf-8?B?NTFKaUZyR2N3VlVJMnpsc3RWR1JlbU93S25PclpneWdEZGZpcVl6Um1SV2RO?=
 =?utf-8?B?bW1Yc0Y1RG9lUTNYZC85TzZRRldBN3dkakY1WXVXbms3MlNTRlZmRzNQaXpw?=
 =?utf-8?B?N3diNlgrWEwvUzFxei94aDhqQk1QdUFGQmF4RTA2UU5jdHRmTUd5ei9wYTBs?=
 =?utf-8?B?ZXJRalRnZ00xcm83SXJYTUNDU2UvNDNObHVLVEFDQTNvN2VmN1RrZm0yT21T?=
 =?utf-8?B?MVUwUm5xSCtMMWFsZ2szTFA2dTMvSW9DZTNSNnJLTUNqZ0hIU2czTlhOcTFm?=
 =?utf-8?B?Z1pwYWdzT0FCN2FvMGgwRUZ1TlBEUkFJSm1QWVl1NXpucFBiZDE1MGN6Ykhq?=
 =?utf-8?B?V3lBRGNEKzNMR0ttSWpYaC9IL0w5Y3pHejA1Njg4MlRxeHJNbnlMZzlRdWdw?=
 =?utf-8?B?ZW4vckFRaSsyci9YYUFQeWRudFl4bGpSRTNaeEJIbmxxUTdVNmtua053SXBj?=
 =?utf-8?B?aUJqY3h0WG9mQ3d1clFQOUZGVVdBMUEzVmwyTTQ1Q1VwdnRoM2l6MVJFcEhP?=
 =?utf-8?B?bUJLQzVJVzFWOTFRVWpzNzQ2SDFYSlg1TEk0WlN3NGozSk9rV083ZWNtOElT?=
 =?utf-8?B?Mk5wczllSTVyNHJqVzR5azkwQm9WaEdJd2JkNm5FTVFVVHBYVUxlMTVJMWpF?=
 =?utf-8?B?bUpESXI4eitKOXI2U25VSUpObXI1bkFJS3U3Ums2dUxMZ1p2STMwLzA3cEtG?=
 =?utf-8?B?N25SNVM4c1ZpSTl0elZaUlBZajVKZC8yank1ejlGU0Z3RkJGcHIyc2p5aWxt?=
 =?utf-8?B?c3ZCbkt3alV4bzE1RmRFUUxvd25OS3NYME5ZNFNSVW5KdFpkWVBBbi9jM3lM?=
 =?utf-8?B?UDdMaFQyRDZHQ08rNDZUNEpHWUxPYjhaL0ZOYkdJU3cyNDdzTzgvVXdLVUhm?=
 =?utf-8?B?WTIzM0hZU3RWZ21hMllzekVqMjk3QUVkUFplVnAxYlBieDBlbHRLMzNSQWdS?=
 =?utf-8?B?Y2dlSTdZZHI1Z3ozZnNMZWpWazgzVzZiTmJVMk1seUVPRmRUcnYvUTlNWklP?=
 =?utf-8?B?dDJGZ25XWVpDSW1hWWhHQkNyRzdDdGJUU0o5K0gyQy82SHBrcXBJQnpDQ3VX?=
 =?utf-8?B?VHVZMkt3bXYxVHQvUlVPSm5NUjhHbzlFU0w4M0VUM1lEWkM1RmpFY0lyRFA3?=
 =?utf-8?B?NWZ4SmNJcVBFS1lOazMvRlVuZGZCaGRjTWVoSTZ6cUxUaGlOWWJBUFh3UHhn?=
 =?utf-8?B?WHF4VTZLNnd1ZDhhVFhUWkVnbzJTOE5TbGRWbnR0YW5Xd0Q4MmZ0RnRmd0Y1?=
 =?utf-8?B?MzdlRndKbWdBT29UcmhqcnpJNk9VSFBWczRSalFLdXFSYWw5eGc0SENzMHdT?=
 =?utf-8?B?anhRZjZnMmlQcEtOcldBTnc5dFpCRnFXbm1kenBVMUFjWGxIWS9YQWVoemN1?=
 =?utf-8?B?R045UVRoVmF6RUIzd0V6Yng1TC9jTjFKR2J4WEwwWEJWbVBZYTdpRk5IT0g1?=
 =?utf-8?B?VEJxQ0hiZlVwaHlTQ1ZvRTRtbXIxdnBVU3ZSbFJKVHFGWE80TkxqbUxnUnJ5?=
 =?utf-8?B?dzVJZFRsOWhxMm9LSWcrZXNkSmF0eGVDOGh5eHgxYzlzR2tGdExuSXhHQzho?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A0DD27EF8015A4B8B12BC47CF8C355A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa5e8b-0f14-42da-22b6-08dc4e7683a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 15:56:50.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxNzxeIf2KeFKbYhM9zQn2VeHKGZOITHVRFrdEEY2bpz6SZoBdSl4v6eM+Mu14/CwZfPXrBciUv4ZOYXjAk9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4852

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDE1OjA0ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBJbXBsZW1lbnQgYSByZXBsYWNlbWVudCBmb3IgbGF1bmRlcl9mb2xpb1sxXS7CoCBUaGUga2V5
IGZlYXR1cmUgb2YNCj4gaW52YWxpZGF0ZV9pbm9kZV9wYWdlczIoKSBpcyB0aGF0IGl0IGxvY2tz
IGVhY2ggZm9saW8gaW5kaXZpZHVhbGx5LA0KPiB1bm1hcHMNCj4gaXQgdG8gcHJldmVudCBtbWFw
J2QgYWNjZXNzZXMgaW50ZXJmZXJpbmcgYW5kIGNhbGxzIHRoZSAtDQo+ID5sYXVuZGVyX2ZvbGlv
KCkNCj4gYWRkcmVzc19zcGFjZSBvcCB0byBmbHVzaCBpdC7CoCBUaGlzIGhhcyBwcm9ibGVtczog
Zmlyc3RseSwgZWFjaCBmb2xpbw0KPiBpcw0KPiB3cml0dGVuIGluZGl2aWR1YWxseSBhcyBvbmUg
b3IgbW9yZSBzbWFsbCB3cml0ZXM7IHNlY29uZGx5LCBhZGphY2VudA0KPiBmb2xpb3MNCj4gY2Fu
bm90IGJlIGFkZGVkIHNvIGVhc2lseSBpbnRvIHRoZSBsYXVuZHJ5OyB0aGlyZGx5LCBpdCdzIHll
dCBhbm90aGVyDQo+IG9wIHRvDQo+IGltcGxlbWVudC4NCj4gDQo+IEhlcmUncyBhIGJpdCBvZiBh
IGhhY2tlZCB0b2dldGhlciBzb2x1dGlvbiB3aGljaCBzaG91bGQgcHJvYmFibHkgYmUNCj4gbW92
ZWQNCj4gdG8gbW0vOg0KPiANCj4gVXNlIHRoZSBtbWFwIGxvY2sgdG8gY2F1c2UgZnV0dXJlIGZh
dWx0aW5nIHRvIHdhaXQsIHRoZW4gdW5tYXAgYWxsDQo+IHRoZQ0KPiBmb2xpb3MgaWYgd2UgaGF2
ZSBtbWFwcywgdGhlbiwgY29uZGl0aW9uYWxseSwgdXNlIC0+d3JpdGVwYWdlcygpIHRvDQo+IGZs
dXNoDQo+IGFueSBkaXJ0eSBkYXRhIGJhY2sgYW5kIHRoZW4gZGlzY2FyZCBhbGwgcGFnZXMuwqAg
VGhlIGNhbGxlciBuZWVkcyB0bw0KPiBob2xkIGENCj4gbG9jayB0byBwcmV2ZW50IC0+d3JpdGVf
aXRlcigpIGdldHRpbmcgdW5kZXJmb290Lg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgZG9lcyBub3Qg
cHJldmVudCAtPnJlYWRfaXRlcigpIGZyb20gYWNjZXNzaW5nIHRoZSBmaWxlDQo+IHdoaWxzdCB3
ZSBkbyB0aGlzIHNpbmNlIHRoYXQgbWF5IG9wZXJhdGUgd2l0aG91dCBsb2NraW5nLg0KPiANCj4g
V2UgYWxzbyBoYXZlIHRoZSB3cml0ZWJhY2tfY29udHJvbCBhdmFpbGFibGUgYW5kIHNvIGhhdmUg
dGhlDQo+IG9wcG9ydHVuaXR5IHRvDQo+IHNldCBhIGZsYWcgaW4gaXQgdG8gdGVsbCB0aGUgZmls
ZXN5c3RlbSB0aGF0IHdlJ3JlIGRvaW5nIGFuDQo+IGludmFsaWRhdGlvbi4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+DQo+IGNjOiBNYXR0
aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gY2M6IE1pa2xvcyBTemVyZWRpIDxt
aWtsb3NAc3plcmVkaS5odT4NCj4gY2M6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCj4gY2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiBjYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gY2M6IEFs
ZXhhbmRlciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gY2M6IENocmlzdGlhbiBC
cmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+IGNjOiBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPg0KPiBjYzogbGludXgtbW1Aa3ZhY2sub3JnDQo+IGNjOiBsaW51eC1mc2RldmVs
QHZnZXIua2VybmVsLm9yZw0KPiBjYzogbmV0ZnNAbGlzdHMubGludXguZGV2DQo+IGNjOiB2OWZz
QGxpc3RzLmxpbnV4LmRldg0KPiBjYzogbGludXgtYWZzQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Y2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IGNjOiBsaW51eC1jaWZzQHZnZXIua2Vy
bmVsLm9yZw0KPiBjYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiBjYzogZGV2ZWxAbGlz
dHMub3JhbmdlZnMub3JnDQo+IExpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTY2
ODE3Mi4xNzA5NzY0Nzc3QHdhcnRob2cucHJvY3lvbi5vcmcudWsvwqANCj4gWzFdDQo+IC0tLQ0K
PiDCoGZzL25ldGZzL21pc2MuY8KgwqDCoMKgwqDCoCB8wqDCoCA1Ng0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoGluY2x1ZGUvbGludXgv
bmV0ZnMuaCB8wqDCoMKgIDMgKysNCj4gwqBtbS9tZW1vcnkuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqAgMyArLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25ldGZzL21pc2MuYyBiL2ZzL25ldGZz
L21pc2MuYw0KPiBpbmRleCBiYzFmYzU0ZmI3MjQuLjc3NGNlODI1ZmJlYyAxMDA2NDQNCj4gLS0t
IGEvZnMvbmV0ZnMvbWlzYy5jDQo+ICsrKyBiL2ZzL25ldGZzL21pc2MuYw0KPiBAQCAtMjUwLDMg
KzI1MCw1OSBAQCBib29sIG5ldGZzX3JlbGVhc2VfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbywN
Cj4gZ2ZwX3QgZ2ZwKQ0KPiDCoAlyZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IMKgRVhQT1JUX1NZTUJP
TChuZXRmc19yZWxlYXNlX2ZvbGlvKTsNCj4gKw0KPiArZXh0ZXJuIHZvaWQgdW5tYXBfbWFwcGlu
Z19yYW5nZV90cmVlKHN0cnVjdCByYl9yb290X2NhY2hlZCAqcm9vdCwNCj4gKwkJCQnCoMKgwqDC
oCBwZ29mZl90IGZpcnN0X2luZGV4LA0KPiArCQkJCcKgwqDCoMKgIHBnb2ZmX3QgbGFzdF9pbmRl
eCwNCj4gKwkJCQnCoMKgwqDCoCBzdHJ1Y3QgemFwX2RldGFpbHMgKmRldGFpbHMpOw0KPiArDQo+
ICsvKioNCj4gKyAqIG5ldGZzX2ludmFsaWRhdGVfaW5vZGUgLSBJbnZhbGlkYXRlL2ZvcmNpYmx5
IHdyaXRlIGJhY2sgYW4NCj4gaW5vZGUncyBwYWdlY2FjaGUNCj4gKyAqIEBpbm9kZTogVGhlIGlu
b2RlIHRvIGZsdXNoDQo+ICsgKiBAZmx1c2g6IFNldCB0byB3cml0ZSBiYWNrIHJhdGhlciB0aGFu
IHNpbXBseSBpbnZhbGlkYXRlLg0KPiArICoNCj4gKyAqIEludmFsaWRhdGUgYWxsIHRoZSBmb2xp
b3Mgb24gYW4gaW5vZGUsIHBvc3NpYmx5IHdyaXRpbmcgdGhlbSBiYWNrDQo+IGZpcnN0Lg0KPiAr
ICogV2hpbHN0IHRoZSBvcGVyYXRpb24gaXMgdW5kZXJ0YWtlbiwgdGhlIG1tYXAgbG9jayBpcyBo
ZWxkIHRvDQo+IHByZXZlbnQNCj4gKyAqIC0+ZmF1bHQoKSBmcm9tIHJlaW5zdGFsbGluZyB0aGUg
Zm9saW9zLsKgIFRoZSBjYWxsZXIgbXVzdCBob2xkIGENCj4gbG9jayBvbiB0aGUNCj4gKyAqIGlu
b2RlIHN1ZmZpY2llbnQgdG8gcHJldmVudCAtPndyaXRlX2l0ZXIoKSBmcm9tIGRpcnR5aW5nIG1v
cmUNCj4gZm9saW9zLg0KPiArICovDQo+ICtpbnQgbmV0ZnNfaW52YWxpZGF0ZV9pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBib29sIGZsdXNoKQ0KPiArew0KPiArCXN0cnVjdCBhZGRyZXNzX3Nw
YWNlICptYXBwaW5nID0gaW5vZGUtPmlfbWFwcGluZzsNCj4gKw0KPiArCWlmICghbWFwcGluZyB8
fCAhbWFwcGluZy0+bnJwYWdlcykNCj4gKwkJZ290byBvdXQ7DQo+ICsNCj4gKwkvKiBQcmV2ZW50
IGZvbGlvcyBmcm9tIGJlaW5nIGZhdWx0ZWQgaW4uICovDQo+ICsJaV9tbWFwX2xvY2tfd3JpdGUo
bWFwcGluZyk7DQo+ICsNCj4gKwlpZiAoIW1hcHBpbmctPm5ycGFnZXMpDQo+ICsJCWdvdG8gdW5s
b2NrOw0KPiArDQo+ICsJLyogQXNzdW1lIHRoZXJlIGFyZSBwcm9iYWJseSBQVEVzIG9ubHkgaWYg
dGhlcmUgYXJlIG1tYXBzLg0KPiAqLw0KPiArCWlmICh1bmxpa2VseSghUkJfRU1QVFlfUk9PVCgm
bWFwcGluZy0+aV9tbWFwLnJiX3Jvb3QpKSkgew0KPiArCQlzdHJ1Y3QgemFwX2RldGFpbHMgZGV0
YWlscyA9IHsgfTsNCj4gKw0KPiArCQl1bm1hcF9tYXBwaW5nX3JhbmdlX3RyZWUoJm1hcHBpbmct
PmlfbW1hcCwgMCwNCj4gTExPTkdfTUFYLCAmZGV0YWlscyk7DQo+ICsJfQ0KPiArDQo+ICsJLyog
V3JpdGUgYmFjayB0aGUgZGF0YSBpZiB3ZSdyZSBhc2tlZCB0by4gKi8NCj4gKwlpZiAoZmx1c2gp
IHsNCj4gKwkJc3RydWN0IHdyaXRlYmFja19jb250cm9sIHdiYyA9IHsNCj4gKwkJCS5zeW5jX21v
ZGUJPSBXQl9TWU5DX0FMTCwNCj4gKwkJCS5ucl90b193cml0ZQk9IExPTkdfTUFYLA0KPiArCQkJ
LnJhbmdlX3N0YXJ0CT0gMCwNCj4gKwkJCS5yYW5nZV9lbmQJPSBMTE9OR19NQVgsDQo+ICsJCX07
DQo+ICsNCj4gKwkJZmlsZW1hcF9mZGF0YXdyaXRlX3diYyhtYXBwaW5nLCAmd2JjKTsNCj4gKwl9
DQo+ICsNCj4gKwkvKiBXYWl0IGZvciB3cml0ZWJhY2sgdG8gY29tcGxldGUgb24gYWxsIGZvbGlv
cyBhbmQgZGlzY2FyZC4NCj4gKi8NCj4gKwl0cnVuY2F0ZV9pbm9kZV9wYWdlc19yYW5nZShtYXBw
aW5nLCAwLCBMTE9OR19NQVgpOw0KPiArDQo+ICt1bmxvY2s6DQo+ICsJaV9tbWFwX3VubG9ja193
cml0ZShtYXBwaW5nKTsNCj4gK291dDoNCj4gKwlyZXR1cm4gZmlsZW1hcF9jaGVja19lcnJvcnMo
bWFwcGluZyk7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25ldGZzLmggYi9p
bmNsdWRlL2xpbnV4L25ldGZzLmgNCj4gaW5kZXggMjk4NTUyZjUxMjJjLi40MGRjMzRlZTI5MWQg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbmV0ZnMuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L25ldGZzLmgNCj4gQEAgLTQwMCw2ICs0MDAsOSBAQCBzc2l6ZV90IG5ldGZzX2J1ZmZlcmVk
X3dyaXRlX2l0ZXJfbG9ja2VkKHN0cnVjdA0KPiBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICpmcg0KPiDCoHNzaXplX3QgbmV0ZnNfdW5idWZmZXJlZF93cml0ZV9pdGVyKHN0cnVjdCBraW9j
YiAqaW9jYiwgc3RydWN0DQo+IGlvdl9pdGVyICpmcm9tKTsNCj4gwqBzc2l6ZV90IG5ldGZzX2Zp
bGVfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlcg0KPiAqZnJv
bSk7DQo+IMKgDQo+ICsvKiBIaWdoLWxldmVsIGludmFsaWRhdGlvbiBBUEkgKi8NCj4gK2ludCBu
ZXRmc19pbnZhbGlkYXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGJvb2wgZmx1c2gpOw0K
PiArDQo+IMKgLyogQWRkcmVzcyBvcGVyYXRpb25zIEFQSSAqLw0KPiDCoHN0cnVjdCByZWFkYWhl
YWRfY29udHJvbDsNCj4gwqB2b2lkIG5ldGZzX3JlYWRhaGVhZChzdHJ1Y3QgcmVhZGFoZWFkX2Nv
bnRyb2wgKik7DQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBiL21tL21lbW9yeS5jDQo+IGlu
ZGV4IGYyYmM2ZGQxNWViOC4uMTA2ZjMyYzdkN2ZiIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnku
Yw0KPiArKysgYi9tbS9tZW1vcnkuYw0KPiBAQCAtMzY2NSw3ICszNjY1LDcgQEAgc3RhdGljIHZv
aWQgdW5tYXBfbWFwcGluZ19yYW5nZV92bWEoc3RydWN0DQo+IHZtX2FyZWFfc3RydWN0ICp2bWEs
DQo+IMKgCXphcF9wYWdlX3JhbmdlX3NpbmdsZSh2bWEsIHN0YXJ0X2FkZHIsIGVuZF9hZGRyIC0N
Cj4gc3RhcnRfYWRkciwgZGV0YWlscyk7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIGlubGluZSB2
b2lkIHVubWFwX21hcHBpbmdfcmFuZ2VfdHJlZShzdHJ1Y3QgcmJfcm9vdF9jYWNoZWQNCj4gKnJv
b3QsDQo+ICtpbmxpbmUgdm9pZCB1bm1hcF9tYXBwaW5nX3JhbmdlX3RyZWUoc3RydWN0IHJiX3Jv
b3RfY2FjaGVkICpyb290LA0KPiDCoAkJCQkJwqDCoMKgIHBnb2ZmX3QgZmlyc3RfaW5kZXgsDQo+
IMKgCQkJCQnCoMKgwqAgcGdvZmZfdCBsYXN0X2luZGV4LA0KPiDCoAkJCQkJwqDCoMKgIHN0cnVj
dCB6YXBfZGV0YWlscw0KPiAqZGV0YWlscykNCj4gQEAgLTM2ODUsNiArMzY4NSw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZA0KPiB1bm1hcF9tYXBwaW5nX3JhbmdlX3RyZWUoc3RydWN0IHJiX3Jvb3Rf
Y2FjaGVkICpyb290LA0KPiDCoAkJCQlkZXRhaWxzKTsNCj4gwqAJfQ0KPiDCoH0NCj4gK0VYUE9S
VF9TWU1CT0xfR1BMKHVubWFwX21hcHBpbmdfcmFuZ2VfdHJlZSk7DQo+IMKgDQo+IMKgLyoqDQo+
IMKgICogdW5tYXBfbWFwcGluZ19mb2xpbygpIC0gVW5tYXAgc2luZ2xlIGZvbGlvIGZyb20gcHJv
Y2Vzc2VzLg0KPiANCg0KVGhpcyBpcyBoYXJkbHkgYSBkcm9wLWluIHJlcGxhY2VtZW50IGZvciBs
YXVuZGVyX3BhZ2UuIFRoZSB3aG9sZSBwb2ludA0Kb2YgdXNpbmcgaW52YWxpZGF0ZV9pbm9kZV9w
YWdlczIoKSB3YXMgdGhhdCBpdCBvbmx5IHJlcXVpcmVzIHRha2luZyB0aGUNCnBhZ2UgbG9ja3Ms
IGFsbG93aW5nIHVzIHRvIHVzZSBpdCBpbiBjb250ZXh0cyBzdWNoIGFzDQpuZnNfcmVsZWFzZV9m
aWxlKCkuDQoNClRoZSBhYm92ZSB1c2Ugb2YgdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2UoKSB3
aWxsIHJlcXVpcmUgYW55IGNhbGxlcg0KdG8gZ3JhYiBzZXZlcmFsIGxvY2tzIGluIG9yZGVyIHRv
IHByZXZlbnQgZGF0YSBsb3NzIHRocm91Z2ggcmFjZXMgd2l0aA0Kd3JpdGUgc3lzdGVtIGNhbGxz
Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

