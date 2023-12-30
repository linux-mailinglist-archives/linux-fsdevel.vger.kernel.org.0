Return-Path: <linux-fsdevel+bounces-7041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C5820846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FB6B21739
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB4AC122;
	Sat, 30 Dec 2023 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EipliMvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE97BE4E;
	Sat, 30 Dec 2023 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm+TlvLVaMMDxsjMxp5UFmHNQuFw77rLOK/y6ciWRGncqCdc7Tndv/Bw9x8M17pCBoJu1ZwcrrGw/v815iqewkI/gI4MKaTVzc/q04/8RGdstglNbZyFVxGHq7dO0AfcTufdk/tRNIpwwavpQHYEI9TQdUlEomphYVi4loIAmQ/ioU899jjXb3VguGVgVILXWQ2eo2AB1Fgf+ls011hhpgmLZQqkSRupLmgQOMz3OIJGRJcDiww03VgVT+Yr8lfbG/Lb1MOCCYdq0F8u7bX7PP92ILSYl6LtEeRqpKWr41R3ulumsydwPdBrNG658QbCSbU666LM32Dh3FOZl7bO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuEhWTkdODn+BLMjNOV8sA2fuwwQ7Hcmy+Q1ANXdvAg=;
 b=Y3gn4lHIxORWWFHhLquQ3xvIsDvE+j4rdYFFWsxR4Pq57bCH1u013kAjfB17+oZxDI86hliF3jPdDltPMyfeMtTCj52ywL/33qCEFvYSbBLuSPSZg6+yCTdzuby6US5xnJk2L8lppMgg61MryHtxyhsRBM39yJDe3u+9+4N+8hsVyKsTqFXEDOabXABgMi7FTuL2rgJxtZvK3hl+idxW0/tg+D1H8L5FkJH9tlCg7hcms7ixe8iotfmMKunpiwRcilGLkc/92Dlrmk5+kHvzrRBjaaTPL2ZBpbsyic8TtvSXQv3rNdil0wmljKa66qHniqKdI4psaYS+9ALFJVsDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuEhWTkdODn+BLMjNOV8sA2fuwwQ7Hcmy+Q1ANXdvAg=;
 b=EipliMvcgJSxnGuhEsSOpqxEwcNlV8DjIsH6VDwx7Bw9bQdkv7hIUGl/jJiufnSBuLOCXzAv5b7AfNBeUf2bfY+bge94+vfjhOM926DTNBRg27u4TOV+d3masgarYu0FfWojxyh4IcEooL/HdFn+tRxhTM+9i3Fpq1vXXLQ+Rtg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA3PR13MB6444.namprd13.prod.outlook.com (2603:10b6:806:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 19:36:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 19:36:41 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Topic: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Thread-Index:
 AQHaOcuIQhXuXI7gUE61seKNbWjvCbC/wUMAgACTgoCAADTxAIAAYE0AgAAF2wCAAG31gIAA3ZgA
Date: Sat, 30 Dec 2023 19:36:41 +0000
Message-ID: <9c4867cf1f94a8e46c2271bfd5a91d30d49ada70.camel@hammerspace.com>
References: <20231228201510.985235-1-trondmy@kernel.org>
	 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
	 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
	 <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
	 <ZY9WPKwO2M6FXKpT@tissot.1015granger.net>
	 <a14bca2bb50eb0a305efc829262081b9b262d888.camel@hammerspace.com>
	 <CAOQ4uxgcCajCD_bNKSLJp2AG1Q=N0CW9P-h+JMiun48mY0ZyDQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgcCajCD_bNKSLJp2AG1Q=N0CW9P-h+JMiun48mY0ZyDQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA3PR13MB6444:EE_
x-ms-office365-filtering-correlation-id: 92944285-3059-4dd1-fdd9-08dc096ea608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M68dTnSzDBq2CkbwJf6mSpoATVvbPLNuApa72dPMMXD2b/HWae1MSpnJ8h99ZVmfFvNjEBh6pFLwiWu0dnTRMZxejOsCU+O5/oYJcn6Phl9GxfThwQWQiIzI7U4Ypn2TvrEHmGgTP68zYkWID0IlABG6z2BRiDNRNpFYYoC1Em4x060cMD44wnGkFEhsA4YMW/pxtZYPVaWDs1/iLAjmbZnmrnsDP5F95phbHC8sIcCQel5+ljVWJatwOW4qGgNwnVkbViguSxmiPuhuGjpnSSdhK5ifsY0PGr6Rc2/uZz87A6YFHiW512Ik+XNsgK/YW3Wpc3qfDmcZ4xbj9k94I3ZxtnRPXwGgwSjv0VAwPR4iBB5ztYDUp0v9Bew2FcDd4qZ9q5Ju26D2v+rmgn4VrjFcH8Dcmt7t5Zd9UXTMo6Axb3CVNKjfk4NrEzygNZVAvIvOiu1pWzTCMZiYJcJ8ZxXTYio8kHsfjVAx9/28uB5+hR5noLZHsV2mWo7cwIqOcMyRW4R3oteAVF1x0Z+ruqs7yafuC90KhDpHr+nkx9MLsgw0UbX3BPMYzazvECes54lU45WUugofLvQTQKsRC5rfXspn5hmwb77sh0T521Z3Sl1jC3Bd+NeseQXF+F1lnRmoZ+3KSIdze7b+TnMHd8IhBHVdCloq9NfUivaXcTc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39840400004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(66476007)(66446008)(64756008)(6916009)(53546011)(6512007)(6506007)(66556008)(66946007)(76116006)(86362001)(38070700009)(38100700002)(6486002)(122000001)(26005)(2616005)(41300700001)(4001150100001)(2906002)(5660300002)(4326008)(478600001)(71200400001)(316002)(54906003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG8zbkpScjY1UmJFM1QzUjFxQlZVOGFPSVZLdnlBUzdwNWZtZmFVYTdhTzBF?=
 =?utf-8?B?Rks3K0Z3b1RUYy90R1pkZ1YyclhKTVZ1NzFnVVRudjRDU2hKK3V5ZmNuTVY1?=
 =?utf-8?B?b0ZHRi9VZWlyVFVpRUwxdS9VTWNkZnVpRkdFR2RlTXY1eCs0UnZLdlJHR1do?=
 =?utf-8?B?Z1EzTlIwRHU2ZXZmalVkZjhLeFdJcEd6M053dE9IVEVJUnY0ZDdac1dIeXNp?=
 =?utf-8?B?UVhndDI3LzlpV2QyTitBK0x6dUt5QisybjNRckR0UmVtMXRjQytiOXYrN0Ns?=
 =?utf-8?B?RUtJMittTVd4cGJTd09wUit4SnhoNGYyclY3RmRabzUxQlZ1Qm9LbTdmSUxK?=
 =?utf-8?B?aml4N09hWkdpRmFwalJVVUNwNU02aS9Ea1ZhczBFUlZVZE9ZYlVkUDFDbSth?=
 =?utf-8?B?eCtyZVNxT3NnREI3YkpTYm5uTk9HdERoNFFGMnRjQUlBMjMxeEI5Tm56aStk?=
 =?utf-8?B?N1NMR3NnakMyenQvVGQxVHhzTy9zNUN3VVpnQS9nVXA0d0orMHFtQWlzQy9Z?=
 =?utf-8?B?dGpQUjZFd1ZBZmI4TkFTMFBYRGYvRW5FNVZHaWJ6aXRNZW5ydEpQOUtNc29H?=
 =?utf-8?B?dG0rYzRyMnNTWjZnTHRMaG1FdXowYnNaSHVqWmxHenpkNEFKV2RjWnhmbURQ?=
 =?utf-8?B?c1ZuZlFqckR1bWVXTUlOSmVHZ1o5NkNvU0ZpWHhoZ094QklydUJ4UUM2Y3pW?=
 =?utf-8?B?YlRoRUs1aE9lVHgvQi9hb3NuZEtKdE9XRjM3Qm9LbkpXOUgwOTZUakpjeWVT?=
 =?utf-8?B?R2dqR0pxWTNTdDVIbnVwc0VReEVNV3BLRGFzK3ZXMDRtYUx6RjFpcitMOVYw?=
 =?utf-8?B?M0NTZUxMVGhSaWwzOXR0Z0s5VGpIV0o0b05OVURQOTRHZFpzYWo0ekd6SnNm?=
 =?utf-8?B?VUgvZkJrUGlLbjRpcWQrYkw1dzA0T1lmQmtNNENFQUt1ZmV2OG84Y0x4aVVG?=
 =?utf-8?B?Q1d6ZXNuSXZyUFIvVGd2TUJvUTRrTVBTQVZhRjd0eUw1VW1ubnZINTY4TXZl?=
 =?utf-8?B?WU1QaEx5cExvR0xZT1hoLzNXNmV6a3NsY2wrczhUd3VYbXpSQnBQZkpzbEpN?=
 =?utf-8?B?VklXZkd6L1dtSUtjdEM2MURaVm1BbTRoZnFSVCtnUUttQnJTUjhZcytCUEI4?=
 =?utf-8?B?ZmdieGt3aXdMMzhCM3A2eGpVWndSVkxPVzArbHZ2eHBlN1phTWVQV0pPMkRL?=
 =?utf-8?B?NUN3ZTFjb3lES1Q1WTU0bVBJdEQ2Ymt6RXArOGQ2SVFwdWlDTW9VR1NRQWlV?=
 =?utf-8?B?UnJmTyt0QWQ0dUZ0akF5bWpUbDMxcGg1WWpIZFpmUmVmTktWd1IwSm5PT29K?=
 =?utf-8?B?TjQ0V0xaQTR1T01ET3FvekIxc0hFNkRGUDRDQWZJMTRCWWVJaDNzM3VScHVO?=
 =?utf-8?B?eHp6dUhxTFRFZjZGYkFDT0RkbEdDR3JQMGpzL2cvd0ZESVorblpoWThIWGdv?=
 =?utf-8?B?Mi9sckZFTWw1RHBUd1ZPN0p4MWsvWHRPT3ExV1U3U2YyL1RDREFGTTBLRi9s?=
 =?utf-8?B?V2huOG1ldWcydDQ0eU1namtLQytvemYzUWRmQWw5ek5rd2Jra3BBbVkxdjhy?=
 =?utf-8?B?RVkvcThLSm5oM0psbzdvMTFwNUFhVkZZdk4yMWdueklFOVpXOXBaTDZFekdl?=
 =?utf-8?B?QlhocnFOYkg1eXlPV2VEcXFodnZWSkVJMk5HdU5oajVXYVFNR3RRdzBuMDl4?=
 =?utf-8?B?MHk4MklYNFlBM2h4a2diaVVzdFczeHlyaWFBVEtSQ0hPN0pxWEhVTy9MUGtZ?=
 =?utf-8?B?anl1eG9nNGd5ZVRuSzUzb1Q2QzNmaGd1OVRRMG1iNzd6K2FaNU94WDRCcVov?=
 =?utf-8?B?RUJuS1RPWit1Y2RVRFRQc2hYa3NlUnlMalBWWG1YNTNKMDFVRGx4NEVidzFH?=
 =?utf-8?B?NmZ4Y0pPQ2s2b201eTNyUDEwWVQ5aDVkenFYSHRiUjBYVXZObGJGTDFCM0cx?=
 =?utf-8?B?MjZjMzl1Q3pBT3ZPZ09tMTk3Z1RESUpsOE40ODdaNjBCb1gzOG1TdDR3WEVL?=
 =?utf-8?B?cWpoazNJVE8xK1BNY084aDlwYjlib3ppeTh6dDdCdzQ3MzNLUnB3OFh2Rm9m?=
 =?utf-8?B?dmVMblpKUFAxajh0MGRyQ3krb2htQm9Kd1lzL3FUTGpMdWdIdFYyZXlqNldk?=
 =?utf-8?B?b0x6UHBTYzRiUGVuMHQzOTQ5NENsY0VmeGpwU25pdlR2QSt1b3RvdnRkR2Yx?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15C9D7CF15C6DF45ABCC87FAB378F1EB@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92944285-3059-4dd1-fdd9-08dc096ea608
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2023 19:36:41.6029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1A+OjLZFkM2BnYBQ46GKlbWLjDOVVC9LzGtMWjMpzjoatP8xfed4NorZqL/rmZOOVGfjoUcALYjZeZcGPqGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6444

T24gU2F0LCAyMDIzLTEyLTMwIGF0IDA4OjIzICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gU2F0LCBEZWMgMzAsIDIwMjMgYXQgMTo1MOKAr0FNIFRyb25kIE15a2xlYnVzdA0KPiA8
dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMy0x
Mi0yOSBhdCAxODoyOSAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBPbiBGcmksIERl
YyAyOSwgMjAyMyBhdCAwNzo0NDoyMFBNICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4g
PiA+ID4gT24gRnJpLCBEZWMgMjksIDIwMjMgYXQgNDozNeKAr1BNIENodWNrIExldmVyDQo+ID4g
PiA+IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBPbiBGcmksIERlYyAyOSwgMjAyMyBhdCAwNzo0Njo1NEFNICswMjAwLCBBbWlyIEdvbGRzdGVp
bg0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gW0NDOiBmc2RldmVsLCB2aXJvXQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5rcyBmb3IgcGlja2luZyB0aGlzIHVwLCBBbWlyLCBhbmQg
Zm9yIGNvcHlpbmcNCj4gPiA+ID4gPiB2aXJvL2ZzZGV2ZWwuIEkNCj4gPiA+ID4gPiB3YXMgcGxh
bm5pbmcgdG8gcmVwb3N0IHRoaXMgbmV4dCB3ZWVrIHdoZW4gbW9yZSBmb2xrcyBhcmUNCj4gPiA+
ID4gPiBiYWNrLA0KPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IHRoaXMgd29ya3MgdG9vLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRyb25kLCBpZiB5b3UnZCBsaWtlLCBJIGNhbiBoYW5kbGUgcmV2
aWV3IGNoYW5nZXMgaWYgeW91DQo+ID4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4gPiBoYXZlDQo+ID4g
PiA+ID4gdGltZSB0byBmb2xsb3cgdXAuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBPbiBUaHUsIERlYyAyOCwgMjAyMyBhdCAxMDoyMuKAr1BNIDx0cm9uZG15QGtlcm5lbC5v
cmc+DQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEZy
b206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoZSBmYWxsYmFjayBpbXBsZW1lbnRhdGlvbiBm
b3IgdGhlIGdldF9uYW1lIGV4cG9ydA0KPiA+ID4gPiA+ID4gPiBvcGVyYXRpb24NCj4gPiA+ID4g
PiA+ID4gdXNlcw0KPiA+ID4gPiA+ID4gPiByZWFkZGlyKCkgdG8gdHJ5IHRvIG1hdGNoIHRoZSBp
bm9kZSBudW1iZXIgdG8gYSBmaWxlbmFtZS4NCj4gPiA+ID4gPiA+ID4gVGhhdCBmaWxlbmFtZQ0K
PiA+ID4gPiA+ID4gPiBpcyB0aGVuIHVzZWQgdG9nZXRoZXIgd2l0aCBsb29rdXBfb25lKCkgdG8g
cHJvZHVjZSBhDQo+ID4gPiA+ID4gPiA+IGRlbnRyeS4NCj4gPiA+ID4gPiA+ID4gQSBwcm9ibGVt
IGFyaXNlcyB3aGVuIHdlIG1hdGNoIHRoZSAnLicgb3IgJy4uJyBlbnRyaWVzLA0KPiA+ID4gPiA+
ID4gPiBzaW5jZQ0KPiA+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiA+IGNhdXNlcyBsb29r
dXBfb25lKCkgdG8gZmFpbC4gVGhpcyBoYXMgc29tZXRpbWVzIGJlZW4gc2Vlbg0KPiA+ID4gPiA+
ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiBvY2N1ciBmb3INCj4gPiA+ID4gPiA+ID4gZmlsZXN5c3Rl
bXMgdGhhdCB2aW9sYXRlIFBPU0lYIHJlcXVpcmVtZW50cyBhcm91bmQNCj4gPiA+ID4gPiA+ID4g
dW5pcXVlbmVzcw0KPiA+ID4gPiA+ID4gPiBvZiBpbm9kZQ0KPiA+ID4gPiA+ID4gPiBudW1iZXJz
LCBzb21ldGhpbmcgdGhhdCBpcyBjb21tb24gZm9yIHNuYXBzaG90DQo+ID4gPiA+ID4gPiA+IGRp
cmVjdG9yaWVzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPdWNoLiBOYXN0eS4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gTG9va3MgdG8gbWUgbGlrZSB0aGUgcm9vdCBjYXVzZSBpcyAi
ZmlsZXN5c3RlbXMgdGhhdA0KPiA+ID4gPiA+ID4gdmlvbGF0ZQ0KPiA+ID4gPiA+ID4gUE9TSVgN
Cj4gPiA+ID4gPiA+IHJlcXVpcmVtZW50cyBhcm91bmQgdW5pcXVlbmVzcyBvZiBpbm9kZSBudW1i
ZXJzIi4NCj4gPiA+ID4gPiA+IFRoaXMgdmlvbGF0aW9uIGNhbiBjYXVzZSBhbnkgb2YgdGhlIHBh
cmVudCdzIGNoaWxkcmVuIHRvDQo+ID4gPiA+ID4gPiB3cm9uZ2x5IG1hdGNoDQo+ID4gPiA+ID4g
PiBnZXRfbmFtZSgpIG5vdCBvbmx5ICcuJyBhbmQgJy4uJyBhbmQgZmFpbCB0aGUgZF9pbm9kZQ0K
PiA+ID4gPiA+ID4gc2FuaXR5DQo+ID4gPiA+ID4gPiBjaGVjayBhZnRlcg0KPiA+ID4gPiA+ID4g
bG9va3VwX29uZSgpLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIHVuZGVyc3RhbmQgd2h5
IHRoaXMgd291bGQgYmUgY29tbW9uIHdpdGggcGFyZW50IG9mDQo+ID4gPiA+ID4gPiBzbmFwc2hv
dA0KPiA+ID4gPiA+ID4gZGlyLA0KPiA+ID4gPiA+ID4gYnV0IHRoZSBvbmx5IGZzIHRoYXQgc3Vw
cG9ydCBzbmFwc2hvdHMgdGhhdCBJIGtub3cgb2YNCj4gPiA+ID4gPiA+IChidHJmcywNCj4gPiA+
ID4gPiA+IGJjYWNoZWZzKQ0KPiA+ID4gPiA+ID4gZG8gaW1wbGVtZW50IC0+Z2V0X25hbWUoKSwg
c28gd2hpY2ggZmlsZXN5c3RlbSBkaWQgeW91DQo+ID4gPiA+ID4gPiBlbmNvdW50ZXINCj4gPiA+
ID4gPiA+IHRoaXMgYmVoYXZpb3Igd2l0aD8gY2FuIGl0IGJlIGZpeGVkIGJ5IGltcGxlbWVudGlu
ZyBhDQo+ID4gPiA+ID4gPiBzbmFwc2hvdA0KPiA+ID4gPiA+ID4gYXdhcmUgLT5nZXRfbmFtZSgp
Pw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2gganVzdCBlbnN1cmVzIHRo
YXQgd2Ugc2tpcCAnLicgYW5kICcuLicgcmF0aGVyDQo+ID4gPiA+ID4gPiA+IHRoYW4NCj4gPiA+
ID4gPiA+ID4gYWxsb3dpbmcgYQ0KPiA+ID4gPiA+ID4gPiBtYXRjaC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gSSBhZ3JlZSB0aGF0IHNraXBwaW5nICcuJyBhbmQgJy4uJyBtYWtlcyBzZW5z
ZSwgYnV0Li4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRG9lcyBza2lwcGluZyAnLicgYW5kICcu
LicgbWFrZSBzZW5zZSBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQNCj4gPiA+ID4gPiBkbw0KPiA+ID4g
PiANCj4gPiA+ID4gSXQgbWFrZXMgc2Vuc2UgYmVjYXVzZSBpZiB0aGUgY2hpbGQncyBuYW1lIGlu
IGl0cyBwYXJlbnQgd291bGQNCj4gPiA+ID4gaGF2ZSBiZWVuICIuIiBvciAiLi4iIGl0IHdvdWxk
IGhhdmUgYmVlbiBpdHMgb3duIHBhcmVudCBvciBpdHMNCj4gPiA+ID4gb3duDQo+ID4gPiA+IGdy
YW5kcGFyZW50IChFTE9PUCBzaXR1YXRpb24pLg0KPiA+ID4gPiBJT1csIHdlIGNhbiBzYWZlbHkg
c2tpcCAiLiIgYW5kICIuLiIsIHJlZ2FyZGxlc3Mgb2YgYW55dGhpbmcNCj4gPiA+ID4gZWxzZS4N
Cj4gPiA+IA0KPiA+ID4gVGhpcyBuZXcgY29tbWVudDoNCj4gPiA+IA0KPiA+ID4gK8KgwqDCoMKg
IC8qIElnbm9yZSB0aGUgJy4nIGFuZCAnLi4nIGVudHJpZXMgKi8NCj4gPiA+IA0KPiA+ID4gdGhl
biBzZWVtcyBpbmFkZXF1YXRlIHRvIGV4cGxhaW4gd2h5IGRvdCBhbmQgZG90LWRvdCBhcmUgbm93
DQo+ID4gPiBuZXZlcg0KPiA+ID4gbWF0Y2hlZC4gUGVyaGFwcyB0aGUgZnVuY3Rpb24ncyBkb2N1
bWVudGluZyBjb21tZW50IGNvdWxkIGV4cGFuZA0KPiA+ID4gb24NCj4gPiA+IHRoaXMgYSBsaXR0
bGUuIEknbGwgZ2l2ZSBpdCBzb21lIHRob3VnaHQuDQo+ID4gDQo+ID4gVGhlIHBvaW50IG9mIHRo
aXMgY29kZSBpcyB0byBhdHRlbXB0IHRvIGNyZWF0ZSBhIHZhbGlkIHBhdGggdGhhdA0KPiA+IGNv
bm5lY3RzIHRoZSBpbm9kZSBmb3VuZCBieSB0aGUgZmlsZWhhbmRsZSB0byB0aGUgZXhwb3J0IHBv
aW50LiBUaGUNCj4gPiByZWFkZGlyKCkgbXVzdCBkZXRlcm1pbmUgYSB2YWxpZCBuYW1lIGZvciBh
IGRlbnRyeSB0aGF0IGlzIGENCj4gPiBjb21wb25lbnQNCj4gPiBvZiB0aGF0IHBhdGgsIHdoaWNo
IGlzIHdoeSAnLicgYW5kICcuLicgY2FuIG5ldmVyIGJlIGFjY2VwdGFibGUuDQo+ID4gDQo+ID4g
VGhpcyBpcyB3aHkgSSB0aGluayB3ZSBzaG91bGQga2VlcCB0aGUgJ0ZpeGVzOicgbGluZS4gVGhl
IGNvbW1pdCBpdA0KPiA+IHBvaW50cyB0byBleHBsYWlucyBxdWl0ZSBjb25jaXNlbHkgd2h5IHRo
aXMgcGF0Y2ggaXMgbmVlZGVkLg0KPiA+IA0KPiANCj4gQnkgYWxsIG1lYW5zLCBtZW50aW9uIHRo
aXMgY29tbWl0LCBqdXN0IG5vdCB3aXRoIGEgZml4ZWQgdGFnIHBsZWFzZS4NCj4gSUlVQywgY29t
bWl0IDIxZDhhMTVhYzMzMyBkaWQgbm90IGludHJvZHVjZSBhIHJlZ3Jlc3Npb24gdGhhdCB0aGlz
DQo+IHBhdGNoIGZpeGVzLiBSaWdodD8NCj4gU28gd2h5IGluc2lzdCBvbiBhYnVzaW5nIEZpeGVz
OiB0YWcgaW5zdGVhZCBvZiBhIG1lbnRpb24/DQoNCkkgZG9uJ3Qgc2VlIGl0IGFzIGJlaW5nIHRo
YXQgc3RyYWlnaHRmb3J3YXJkLg0KDQpQcmlvciB0byBjb21taXQgMjFkOGExNWFjMzMzLCB0aGUg
Y2FsbCB0byBsb29rdXBfb25lX2xlbigpIGNvdWxkIHJldHVybg0KYSBkZW50cnkgKGFsYmVpdCBv
bmUgd2l0aCBhbiBpbnZhbGlkIG5hbWUpIGRlcGVuZGluZyBvbiB3aGV0aGVyIG9yIG5vdA0KdGhl
IGZpbGVzeXN0ZW0gbG9va3VwIHN1Y2NlZWRzLiBOb3RlIHRoYXQga25mc2QgZG9lcyBzdXBwb3J0
IGEgbG9va3VwDQpvZiAiLiIgYW5kICIuLiIsIGFzIGRvIHNldmVyYWwgb3RoZXIgTkZTIHNlcnZl
cnMuDQoNCldpdGggY29tbWl0IDIxZDhhMTVhYzMzMyBhcHBsaWVkLCBob3dldmVyLCBsb29rdXBf
b25lX2xlbigpDQphdXRvbWF0aWNhbGx5IHJldHVybnMgYW4gRUFDQ0VTIGVycm9yLg0KDQpTbyB3
aGlsZSBJIGFncmVlIHRoYXQgdGhlcmUgYXJlIGdvb2QgcmVhc29ucyBmb3IgaW50cm9kdWNpbmcg
Y29tbWl0DQoyMWQ4YTE1YWMzMzMsIGl0IGRvZXMgY2hhbmdlIHRoZSBiZWhhdmlvdXIgaW4gdGhp
cyBjb2RlIHBhdGguDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K

