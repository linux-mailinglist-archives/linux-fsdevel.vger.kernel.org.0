Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FE4A4ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiAaSr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:47:56 -0500
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:5985
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358367AbiAaSrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc3T503AbxOp4GIvt8ywOtEZMnnlin+0SuMo19pF+vU2sotBXSfI3Uaj/AOZ2RX+wNUwpg+jhtzG5UN18Q0Cgs1+XrXaFGHNiUDXc1SBmpzNkJJ/2F/k/+PgV1gitrkp9ywDbU7rvIRSwchldOvt/BMHSGrDhAI5Zsj80RKbpds6DRW13bnpB164YG108WWsMyxGhiQurZuspJ7vWNmwE+28Pfh6t4jLTxsaa17bdNgAoMTrPw4rnp5BiCCjhEbdPp+HFvus9GzMFx/A+EAZQRa3mtac2ahfHW7fgkA6ZE03yP23veB8CwHkaFeh58FcVXsNTD6qs9hWMRSzD7zqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcilJgPCeRT3BPaGsXGCr2aTG5GqWVazL4G1oWpVjMU=;
 b=JZvdV1Ld0swL1PbW3fUAizdRdgKlfVdnAhE44AP/yljKSz61bOH4IhMwONOZ/f5Yb1fVozVxH/8WFOiDT1S//zSAIos3w1YbKYeoDKiCJ7t0V8ypjXOUuM0rQILT3sEPimRxyBzj1H5QCykKJ7dkqaH9VrSVSlCsVd3uDUrzgqEaniqVnZTWKZwBPRm1idhzV8BKcbJDJm8IA2y9wy82mL6/mocT1iVIa66qaFrRN4QOr/EOrOEvIhlJzPyzCk2tOvFURh1u7TQc1NTo3w03TUb1vM/kdjBSG2qgEI5lBgHI0uTyDf39FM8YpVM3CZIUuVJgw+SLGJ/DRIQ3a6VMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcilJgPCeRT3BPaGsXGCr2aTG5GqWVazL4G1oWpVjMU=;
 b=A+xgUAF/8RLNkmm4+J9rwDR5MdTaOTgnlv1S7DzTvIZfqwEC/9OCBU1x1TWUaQC+QwFRIS02+qeIRz42EwZfb92LFEEp2JnmQmqr1U6QUOvNzyhCn6g+paq9lNw4v/q6RS2jPmbBkz33F0EhzQQsyGr2d7/hVbgR42LBLjVFCaw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4008.namprd13.prod.outlook.com (2603:10b6:208:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Mon, 31 Jan
 2022 18:47:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%6]) with mapi id 15.20.4951.011; Mon, 31 Jan 2022
 18:47:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of large
 file sizes
Thread-Topic: [PATCH v2 2/5] NFSD: Fix NFSv3 SETATTR/CREATE's handling of
 large file sizes
Thread-Index: AQHYFs/ypcuQk9gPT06tiQmZ/LtqSax9da4AgAACkYA=
Date:   Mon, 31 Jan 2022 18:47:05 +0000
Message-ID: <0448eb0e136da9e8e24880411644f5fcb816e833.camel@hammerspace.com>
References: <164365324981.3304.4571955521912946906.stgit@bazille.1015granger.net>
         <164365349299.3304.4161554101383665486.stgit@bazille.1015granger.net>
         <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
In-Reply-To: <cb06de6582d9a428405af43d0cb92e0c2d04c76f.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a24a5a1-6da2-4515-ff7c-08d9e4ea1395
x-ms-traffictypediagnostic: MN2PR13MB4008:EE_
x-microsoft-antispam-prvs: <MN2PR13MB40086B7D73E09C1785EE2B4EB8259@MN2PR13MB4008.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vs7yvCG8UqpraI4GgRl1+YYK+0OBKsUGqmkLuhk3lOLw9fmk2G28adEfe3MtZQ70cyTxx/8jsCAzWzniHmDcpE2LwaAZwQnKqhlppWmDFhwOd0iSoxNhW0jjo/9K+J0hUNeSqtDQQ5W4f2qX/4wQ6+8RNyfWHpHRXtgSJ3yImef4bYPKpTcu3HEowxQ75pZt8c6MFCziGOLmX7YGQuwQbg8gLPTVD6iWoL7qYgpSB129SIlP7i6+e8uAR2q0tA7rYCt9cDMYHdP17oEYtp00BWmKf90dqmWvVeUXJonlK6Tpqa/E9bm0Mm9lduStt944QJElURvdy6W6RmRfnox24zbUcudkfKnty6/NrdNiatkak9pa+4oqfD4n9JylXGBZ9e6bum0lY2sZeVZL1rXxVJC0tTNscMUp+/V2narEYQKV/rTQp+6eREOKk9PfBE3LrkFjVYY7Cgh4Ee7R6RToEw7FbBBhfQ/61Dx+qpbjYQoM+4ByicEBZCmUfMNANnUcFG+SaFwMf6bPgQQ5OMI29AAe4FrElHcV9fNSoupMy+oJ3+1qkHRK6m/0MoYrJWPfvfHUzTSaIVz56ydnYAhITr0Ub0S5BMBi8a4jUvnYPv558wK+0cogsezBs///SsEMzaaF/8jvBTXmXOaL2dv993iXpe6iAvyA3ncEA9RbMgOtdNfZ7Tnu8kilLl9N+s4G//4B0vKwbdiAG/UlpB04WQc1ISC0BAlqo/Hd7gzzd1kFgUFnHNiejAyVQOUY30/v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(396003)(376002)(39830400003)(366004)(26005)(186003)(83380400001)(110136005)(76116006)(316002)(6506007)(66946007)(2906002)(86362001)(38070700005)(36756003)(5660300002)(71200400001)(6512007)(2616005)(38100700002)(508600001)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(6486002)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVGRlNNbkVLaGZ4OWQ1MVBLUjh3MncwdFYvR0lYYkJBZHhueHc3WHNlYity?=
 =?utf-8?B?RFBoZVIxbVh1U1A5bFdYMERBMCtsd3FnTDZKNjhFTzNocURLOWJ6WXZLNDh0?=
 =?utf-8?B?STJZSWxUdzZtR0JxNDdMeWV6YVZyN0FxbDJLOEltd1NxWDNYZzFhRUhuMWth?=
 =?utf-8?B?OE0wT1RZQTdVTnhrUzJNR3RjQ1FicGs4MFdxMVNlU3pCQ0VXRXptOHFiWUxz?=
 =?utf-8?B?OEZrMGVqbWlXYmRMNkhJSFVJdjNRcFo0UXN2RVo3NnpSOVMwd1FISDNoTTUx?=
 =?utf-8?B?bWpHM0thbWkzeFA0ZUhENzBhTHlXYnBRazRHRDRKMkVpUDhwMnRURHNWSmRG?=
 =?utf-8?B?bnkxcS9ZUVpSdnRGQkgyMGhySjFNWktjcllsVFBidUJoNmVqcG1VaWVHd2ZY?=
 =?utf-8?B?eDhnOXVSUlkwL3EzTnJ0TmdablFzbnJ1bzBsWVFUVFQrOEVzamNqbnVxMEdV?=
 =?utf-8?B?MHRJVTQ2R1RjbjFjY2JTTlpGZEFmVSs0REVybDlJL1NwaXN1VnZnOS9NcUZM?=
 =?utf-8?B?MWNTSHJ5WTc5d2M3QmZHK3BvckxxKzFEclpJYXpyL2ZVc1lUb0ZzSFYrTEd1?=
 =?utf-8?B?UzloaG1rY2dpb1grR3h0N1NpSitpbWE2enY0MHNIU0tLb3lQalNaUXN3S3dQ?=
 =?utf-8?B?QUtyTnkxMkhuVVRHVXV1K2JDTGJQam55dHE1K3dkZVRuUVZmT3FWL2ZVbWhH?=
 =?utf-8?B?Q1VyVVQ2VTM4eFNJbHN4UXpYbnRNVXdHSEU2N2p6SHozSkdLVkM0UVNoeHh4?=
 =?utf-8?B?Njd1UGFhMmFUZ2FBWmVTRDZLaTlpNlE0S0pNM2hYTUV6VVFqM1paek9hL0Fk?=
 =?utf-8?B?ZnAxUzBmbzNhSkpuZXRVVnMrZ0hrT1MvSzlzazBiUzVWZjRrODkwZTlqTno3?=
 =?utf-8?B?dnlqamwxL3FubUtqOVhtc2dVeEVQMXRweUtPUjVGc1RUaFdhRnRFZm1oQUE1?=
 =?utf-8?B?d1JvNHM2VUNtVUZnMGtQNVU2SVJ0RVFKM0FEazJ0V3o0Y2dGMi9GMCtDei9D?=
 =?utf-8?B?UUJUUksrOEpvNzRnREZDUG5lK3FUdE5kU2RMQlNoMkJFN3dPN2xKVFJtTXlO?=
 =?utf-8?B?KzMwdzcySXBQenAwQkNOUTc3bDM5aXIwcVhLd3IvSDJWaUFicmtzdVFaY21q?=
 =?utf-8?B?MFpJSUZzRmtVZlVXdTB5SnNnM2JUbkJVam9ZVldHNzlSNVF0djZtMDJIS29U?=
 =?utf-8?B?UWx3NVljRk96ZEw0YlA1SHI2UFErd2hkRGEwVEhidnROT2d6UWF2WVpNSGxD?=
 =?utf-8?B?NnpCRkFEZkRDSEcrUk9TRmJZRGVpVVNBVUZmRktCdlNSVzN1dWRHNGR4L3Bs?=
 =?utf-8?B?dzM1SU1sWGwrSW1rbU16dzcxekNVTVY3WFlETFdRbEtnYWxDLzduamI5RkR2?=
 =?utf-8?B?ZkFjTFFkS1Zwd2VQUjdYSTNYMVNseWRsa2hteWoybDFpY2hNUFpxNllaQkJK?=
 =?utf-8?B?dUZkYU4yMTkzblp6UjNGbUZOS1FXVEdWTnZsWEQ1Si9wYlY0Skg0UnVxWmFT?=
 =?utf-8?B?dGhPUXRYNTBPOHRNZXJvUVdodmxzREUvMXFrRzdSaERzWmlWaTZaRjVldmdO?=
 =?utf-8?B?Nzc1RG1DMDcyMXFMOC9lQlViY2ROY3dhdjdKaENMTW1PaXBhTk1HZkJNMGts?=
 =?utf-8?B?OUVjUFpvVG0xcmN1KzkrbzIzRlAxUUg0WnhwQkppVWFaejJQRU5henN0STBo?=
 =?utf-8?B?OExpQ0psOGFBVjQyVVgzKytYa1FWMC9nZzR3QUlKMVVwUEoreXJqdEt6UWlP?=
 =?utf-8?B?REdMd0FoeHkvZ0pDSDRKMS9SU29CZS9EZ3poVlZ5UWhBT2JrcW9iSmZtZTlj?=
 =?utf-8?B?WDZIK0ZMZDJRRGMvUXFlc3NrdUpOS1pJZ0NBeW5SaVBDYXo1aXRTbVZnUXF2?=
 =?utf-8?B?NDY0eXFYWWlGZXdYMkI3cHEybWgrSlBPc29IdjNIcEwzOUlma3FCRXZ5Mkp6?=
 =?utf-8?B?ejBiTXNodnhKa3R1TVRPNmNzNG92MVZWYk44TmRNRENaUDZqS0l3d25RR0Ri?=
 =?utf-8?B?eTI5bGRIMlB1WTgvZ3hlTVRMNzk1M01zMkNkTFNNZGZ0bFRlNzZsUWx2SU5G?=
 =?utf-8?B?bnNSazcwMk14c2VvWHNHV0VuWVVqWnhSVzhpMTBDVlRTWlVFaWMxc215d3Rn?=
 =?utf-8?B?RE13YkRKbzBjRDhRWUw0OHdXdElIUmc1dzB5R2ZoOHpVQktYeXVjQXFwOFV5?=
 =?utf-8?Q?RPObxkKWB6GDQjPWVRpivbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF720546D42FAF44BDDB048DADB63622@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a24a5a1-6da2-4515-ff7c-08d9e4ea1395
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 18:47:05.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVE6I9y5qNPU2iOLZWUEfoExpfGiS3/bUg8Qi1mT8ugBLgFNfMLFbgXMMMNQ0VSbr5WWvzMRdWRFCNJAMuvXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4008
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDEzOjM3IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMi0wMS0zMSBhdCAxMzoyNCAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6
DQo+ID4gaWF0dHI6OmlhX3NpemUgaXMgYSBsb2ZmX3QsIHNvIHRoZXNlIE5GU3YzIHByb2NlZHVy
ZXMgbXVzdCBiZQ0KPiA+IGNhcmVmdWwgdG8gZGVhbCB3aXRoIGluY29taW5nIGNsaWVudCBzaXpl
IHZhbHVlcyB0aGF0IGFyZSBsYXJnZXINCj4gPiB0aGFuIHM2NF9tYXggd2l0aG91dCBjb3JydXB0
aW5nIHRoZSB2YWx1ZS4NCj4gPiANCj4gPiBTaWxlbnRseSBjYXBwaW5nIHRoZSB2YWx1ZSByZXN1
bHRzIGluIHN0b3JpbmcgYSBkaWZmZXJlbnQgdmFsdWUNCj4gPiB0aGFuIHRoZSBjbGllbnQgcGFz
c2VkIGluIHdoaWNoIGlzIHVuZXhwZWN0ZWQgYmVoYXZpb3IsIHNvIHJlbW92ZQ0KPiA+IHRoZSBt
aW5fdCgpIGNoZWNrIGluIGRlY29kZV9zYXR0cjMoKS4NCj4gPiANCj4gPiBNb3Jlb3ZlciwgYSBs
YXJnZSBmaWxlIHNpemUgaXMgbm90IGFuIFhEUiBlcnJvciwgc2luY2UgYW55dGhpbmcgdXANCj4g
PiB0byBVNjRfTUFYIGlzIHBlcm1pdHRlZCBmb3IgTkZTdjMgZmlsZSBzaXplIHZhbHVlcy4gU28g
aXQgaGFzIHRvIGJlDQo+ID4gZGVhbHQgd2l0aCBpbiBuZnMzcHJvYy5jLCBub3QgaW4gdGhlIFhE
UiBkZWNvZGVyLg0KPiA+IA0KPiA+IFNpemUgY29tcGFyaXNvbnMgbGlrZSBpbiBpbm9kZV9uZXdz
aXplX29rIHNob3VsZCBub3cgd29yayBhcw0KPiA+IGV4cGVjdGVkIC0tIHRoZSBWRlMgcmV0dXJu
cyAtRUZCSUcgaWYgdGhlIG5ldyBzaXplIGlzIGxhcmdlciB0aGFuDQo+ID4gdGhlIHVuZGVybHlp
bmcgZmlsZXN5c3RlbSdzIHNfbWF4Ynl0ZXMuDQo+ID4gDQo+ID4gSG93ZXZlciwgUkZDIDE4MTMg
cGVybWl0cyBvbmx5IHRoZSBXUklURSBwcm9jZWR1cmUgdG8gcmV0dXJuDQo+ID4gTkZTM0VSUl9G
QklHLiBFeHRyYSBjaGVja3MgYXJlIG5lZWRlZCB0byBwcmV2ZW50IE5GU3YzIFNFVEFUVFIgYW5k
DQo+ID4gQ1JFQVRFIGZyb20gcmV0dXJuaW5nIEZCSUcuIFVuZm9ydHVuYXRlbHkgUkZDIDE4MTMg
ZG9lcyBub3QgcHJvdmlkZQ0KPiA+IGEgc3BlY2lmaWMgc3RhdHVzIGNvZGUgZm9yIGVpdGhlciBw
cm9jZWR1cmUgdG8gaW5kaWNhdGUgdGhpcw0KPiA+IHNwZWNpZmljIGZhaWx1cmUsIHNvIEkndmUg
Y2hvc2VuIE5GUzNFUlJfSU5WQUwgZm9yIFNFVEFUVFIgYW5kDQo+ID4gTkZTM0VSUl9JTyBmb3Ig
Q1JFQVRFLg0KPiA+IA0KPiA+IEFwcGxpY2F0aW9ucyBhbmQgTkZTIGNsaWVudHMgbWlnaHQgYmUg
YmV0dGVyIHNlcnZlZCBpZiB0aGUgc2VydmVyDQo+ID4gc3R1Y2sgd2l0aCBORlMzRVJSX0ZCSUcg
ZGVzcGl0ZSB3aGF0IFJGQyAxODEzIHNheXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1
Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBmcy9uZnNk
L25mczNwcm9jLmMgfMKgwqDCoCA5ICsrKysrKysrKw0KPiA+IMKgZnMvbmZzZC9uZnMzeGRyLmPC
oCB8wqDCoMKgIDIgKy0NCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczNwcm9jLmMg
Yi9mcy9uZnNkL25mczNwcm9jLmMNCj4gPiBpbmRleCA4ZWY1M2Y2NzI2ZWMuLjAyZWRjNzA3NGQw
NiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnNkL25mczNwcm9jLmMNCj4gPiArKysgYi9mcy9uZnNk
L25mczNwcm9jLmMNCj4gPiBAQCAtNzMsNiArNzMsMTAgQEAgbmZzZDNfcHJvY19zZXRhdHRyKHN0
cnVjdCBzdmNfcnFzdCAqcnFzdHApDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGZoX2NvcHkoJnJlc3At
PmZoLCAmYXJncC0+ZmgpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXNwLT5zdGF0dXMgPSBuZnNk
X3NldGF0dHIocnFzdHAsICZyZXNwLT5maCwgJmFyZ3AtPmF0dHJzLA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYXJncC0+Y2hlY2tfZ3VhcmQsIGFyZ3AtDQo+ID4gPiBndWFyZHRpbWUpOw0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAocmVzcC0+c3RhdHVzID09IG5mc2Vycl9mYmlnKQ0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXNwLT5zdGF0dXMgPSBuZnNlcnJfaW52YWw7
DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcnBjX3N1Y2Nlc3M7DQo+ID4gwqB9
DQo+ID4gwqANCj4gPiBAQCAtMjQ1LDYgKzI0OSwxMSBAQCBuZnNkM19wcm9jX2NyZWF0ZShzdHJ1
Y3Qgc3ZjX3Jxc3QgKnJxc3RwKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXNwLT5zdGF0dXMgPSBk
b19uZnNkX2NyZWF0ZShycXN0cCwgZGlyZmhwLCBhcmdwLT5uYW1lLA0KPiA+IGFyZ3AtPmxlbiwN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRyLCBuZXdmaHAsIGFyZ3AtDQo+ID4gPmNyZWF0ZW1v
ZGUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHUzMiAqKWFyZ3AtPnZlcmYsIE5VTEwsDQo+ID4g
TlVMTCk7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoC8qIENSRUFURSBtdXN0IG5vdCByZXR1
cm4gTkZTM0VSUl9GQklHICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJlc3AtPnN0YXR1cyA9
PSBuZnNlcnJfZmJpZykNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVzcC0+
c3RhdHVzID0gbmZzZXJyX2lvOw0KDQpCVFc6IFRoaXMgRUZCSUcgLyBFT1ZFUkZMT1cgY2FzZSBj
b3VsZCBvbmx5IHBvc3NpYmx5IGhhcHBlbiBkdWUgdG8gYW4NCmludGVybmFsIHNlcnZlciBlcnJv
ci4NCg0KICAgICAgIEVGQklHICBTZWUgRU9WRVJGTE9XLg0KDQogICAgICAgRU9WRVJGTE9XDQog
ICAgICAgICAgICAgIHBhdGhuYW1lICByZWZlcnMgIHRvICBhICByZWd1bGFyICBmaWxlICB0aGF0
ICBpcyB0b28gbGFyZ2UgdG8gYmUNCiAgICAgICAgICAgICAgb3BlbmVkLiAgVGhlIHVzdWFsIHNj
ZW5hcmlvIGhlcmUgaXMgdGhhdCBhbiBhcHBsaWNhdGlvbiBjb21waWxlZA0KICAgICAgICAgICAg
ICBvbiAgYSAgMzItYml0ICBwbGF0Zm9ybSAgd2l0aG91dCAtRF9GSUxFX09GRlNFVF9CSVRTPTY0
IHRyaWVkIHRvDQogICAgICAgICAgICAgIG9wZW4gYSAgZmlsZSAgd2hvc2UgIHNpemUgIGV4Y2Vl
ZHMgICgxPDwzMSktMSAgYnl0ZXM7ICBzZWUgIGFsc28NCiAgICAgICAgICAgICAgT19MQVJHRUZJ
TEUgIGFib3ZlLiAgIFRoaXMgaXMgdGhlIGVycm9yIHNwZWNpZmllZCBieSBQT1NJWC4xOyBpbg0K
ICAgICAgICAgICAgICBrZXJuZWxzIGJlZm9yZSAyLjYuMjQsIExpbnV4IGdhdmUgdGhlIGVycm9y
IEVGQklHIGZvciB0aGlzIGNhc2UuDQoNCg0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIHJwY19zdWNjZXNzOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25m
c2QvbmZzM3hkci5jIGIvZnMvbmZzZC9uZnMzeGRyLmMNCj4gPiBpbmRleCA3YzQ1YmE0ZGI2MWIu
LjJlNDdhMDcwMjlmMSAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnNkL25mczN4ZHIuYw0KPiA+ICsr
KyBiL2ZzL25mc2QvbmZzM3hkci5jDQo+ID4gQEAgLTI1NCw3ICsyNTQsNyBAQCBzdmN4ZHJfZGVj
b2RlX3NhdHRyMyhzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLA0KPiA+IHN0cnVjdCB4ZHJfc3RyZWFt
ICp4ZHIsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoeGRyX3N0cmVh
bV9kZWNvZGVfdTY0KHhkciwgJm5ld3NpemUpIDwgMCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZmFsc2U7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpYXAtPmlhX3ZhbGlkIHw9IEFUVFJfU0laRTsNCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFwLT5pYV9zaXplID0gbWluX3QodTY0LCBu
ZXdzaXplLCBORlNfT0ZGU0VUX01BWCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlhcC0+aWFfc2l6ZSA9IG5ld3NpemU7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKHhkcl9zdHJlYW1fZGVjb2RlX3UzMih4ZHIsICZzZXRfaXQpIDwg
MCkwDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZmFsc2U7DQo+
ID4gDQo+ID4gDQo+IA0KPiBOQUNLLg0KPiANCj4gVW5saWtlIE5GU1Y0LCBORlN2MyBoYXMgcmVm
ZXJlbmNlIGltcGxlbWVudGF0aW9ucywgbm90IGEgcmVmZXJlbmNlDQo+IHNwZWNpZmljYXRpb24g
ZG9jdW1lbnQuIFRoZXJlIGlzIG5vIG5lZWQgdG8gY2hhbmdlIHRob3NlDQo+IGltcGxlbWVudGF0
aW9ucyB0byBkZWFsIHdpdGggdGhlIGZhY3QgdGhhdCBSRkMxODEzIGlzIHVuZGVyc3BlY2lmaWVk
Lg0KPiANCj4gVGhpcyBjaGFuZ2Ugd291bGQganVzdCBzZXJ2ZSB0byBicmVhayBjbGllbnQgYmVo
YXZpb3VyLCBmb3Igbm8gZ29vZA0KPiByZWFzb24uDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
