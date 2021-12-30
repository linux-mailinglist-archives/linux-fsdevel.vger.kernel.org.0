Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3C48209C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhL3WZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 17:25:20 -0500
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com ([40.107.94.114]:59041
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhL3WZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:25:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZok4z3OoKC41hbEOoRLVimaG4ziRXrZukADKQbEA5iA+8XNP0pSAaZp8dQQRbv0YSSxBXhSo5JvltroglCsj9zOdOHzHVXCuXfd00bZ3bvr58SGIU3k+vQMzxeVDT0GkxLaPgIQOplYqPVLvppBTgsp3dw8NI0WESqppN81MjN22OUiXBinZdR/5lj5/qig4PiAoUrBfYvw+Fh/1HSzBe8VCbnDDvMqvBmTgquUAAjQd5hCGyUtxEhc503Z0EfCpH+APQKo5D2ckFojM39S6wF12scUyPxZ6PU6+uOTuToumTm3wjvAqQk0SN5QUQr0vZaJ7TkSlHaQ7GMjuHnfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgAdPIGQkfbgUGq0JGKbEtHEA0N26s8zKWcNsQMxPs=;
 b=dTXc5ddcWNN4qiWvollHhIJ1PG3rsQy4A/sKW4K92rAH+CtIgedyKhBe2Z60Dk9aXiBJLYGO5CyUYuOeig2J79osVywtyLzQWEBsyOZOtE+nRNtcLjQGg8AYgrSBFxMrMRDjBbnwO6YFX5h3nQOsB09nzfv9jzSsczuR3ve0CxU8jnkyksqSndtyYoL2h7pIzcdNEzI2x8Nksc83K9fuq1fZujkRbECZ1P6XcDZpT1EroheraqbWpcfIXm0Tgvn35C9flBq1F0EyAQNNypAKgbN0c4RvbuJkRyCFTmjS/2+BsVdURDUK63ea1ny39C7dcxud29PxltB8f8mHdWMJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgAdPIGQkfbgUGq0JGKbEtHEA0N26s8zKWcNsQMxPs=;
 b=TGjlbILETjCnBDDdm+S3wa9bBiP8vT0TZygCYvtEF3wXNBGMgr588ZwH1xLoJw2YYtYiILPFLeqdMesVyD3e6VmufHB5adjsXuQqM8PDVVq+7quzW/kUmvXeyNnrQ1TuPWc/fYrxpEQCmPGwNQQKAqkQQblpqsIGGHL/+GE1RCE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5702.namprd13.prod.outlook.com (2603:10b6:303:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.10; Thu, 30 Dec
 2021 22:25:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 22:25:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xLi/aAgAAQ2YA=
Date:   Thu, 30 Dec 2021 22:25:14 +0000
Message-ID: <a42acb06152b0ecba3e99aec38349e1f29304b1e.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <05bac8cb-e36a-b043-5ac3-82c585f76bbe@kernel.dk>
In-Reply-To: <05bac8cb-e36a-b043-5ac3-82c585f76bbe@kernel.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e7715b4-1ce9-4747-06f5-08d9cbe34088
x-ms-traffictypediagnostic: CO3PR13MB5702:EE_
x-microsoft-antispam-prvs: <CO3PR13MB5702210137AEF509C0E4096EB8459@CO3PR13MB5702.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64zGXYw0XyCS0pbGdhNa5NPug3v31HJ3XiFrqBJkO4CT1/YM2juD3BLaIieL6qKvx6XPoBGDowlM6AQO60l1HD4E2KszzH44z7NW8bymwmWJYc/madQ5MbzK3DQqEbYD2kl1ulWW+LVOt3CIWSymwKUaXnlp5o6xzSZorkfsPZS+BAgpGjUU2qhc3cvyl9gPTJgY8NJoc5MaKV43gNV6Xg7u6h3cjToM33KgIIBil4pn6AwtmOAvtwwZ693dLcdW3bAOCe+nbwpVlSJGLJ1dUf1v5JvcO/O9zQR1SkI9p3xeeP4AnId1/dITM5+mFNFkBqoUyuNPwPEk0KKUrWS3+6BQdOkQ5uibPnOMssJC4FsQ85nVYkeqhmkx32CirSEEOWS5nW1A31OiJgkjOS09PfTt95dgBtpNAikqdkIj8BMN1W0tWRsow3cH+1MVmA9QN7gaXscKnf5HG/tJ5qOseqmKP2QtbUJtfU/KgyVplMjJNv3z5+B2dr5R/23UPt3ZAqs1kHWzNZib1g9n5qH1DR2N/oDZazsKWSMjSR4wGtmFQfiAzQZSrAQ0nVIQP6eooXQ8rMe+5WSuKKrzx+Fj3vECnDRjAr5ULrpNXs+nTqBWrNaIksyyFQD6EAETCxYpRb0gDjUC7kTppA0e4V9HI2gnduNnVMMFbWprhBlEEeyfEmsrJlCZSEcGdmOE46VtRxXlYVViaoeeE55wiHq5PWJX/1qVeVBXTDtBX/w0n+7lvB77Q8l/D+ivD5/J5oo/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(396003)(376002)(39830400003)(366004)(53546011)(6506007)(45080400002)(5660300002)(38100700002)(71200400001)(86362001)(6486002)(38070700005)(36756003)(26005)(122000001)(6512007)(76116006)(4001150100001)(186003)(2906002)(8936002)(110136005)(66446008)(508600001)(66946007)(66476007)(83380400001)(8676002)(316002)(66556008)(54906003)(4326008)(2616005)(64756008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlXbWFad3REY21jbmVuZlN4U0pUWi9xbHdGcVpVRlhNUlVrTVhjUU5JUHdM?=
 =?utf-8?B?a21ucFZYa1RqYjJ3enFPQkl0T3RlMDY3R2RuNEcwUFRKSTlORGlVbmlCVXhw?=
 =?utf-8?B?YUFnNDZRVjJQVU5rUE1vdFN0Wnl6TVBKblFza1l3THNEbVlMeWRINStFWnV1?=
 =?utf-8?B?V1F5VS9oRTlsSnhwMkFDS0czOEluN2taaCtsQzh1RHFENzlrOXY3TzdtK0RQ?=
 =?utf-8?B?L2N0WDhKOFlPaU1sY24vUDI4RUp3Y2FZMk1YRldoZWJCekNGL3k1RUtYYUkz?=
 =?utf-8?B?Z0lESzR5ejZkUGRJa003Z1BpMUtoYVIvbTY3Uk42d2JZbG5qR3cvUHhSMUZS?=
 =?utf-8?B?bXNnbW12MDM0NDkxT1BmazZ3UStRanYwQjlJUFh3aFU2YmFJU0k2MXVaR3lr?=
 =?utf-8?B?SnY0MnBnY3BiSDFscmxGbCtRclNlakZES0kxQWJjMzNyakNDTjJML2NFSWgw?=
 =?utf-8?B?Q2dVYWpxV1RFMW9kNWtMUDVwMThEczFaa3F5Zk9lelExY21qajhiN1Y3Um9J?=
 =?utf-8?B?aXNaVWg3VjRKN0UvNXV3WVdzaTNDQStmWmJaWmxHandwNnZCRjZvTDRjN0RX?=
 =?utf-8?B?ajd4TTVxYmJSbGIvQkhEY3dEV21HaUdQZlVMZU01Z2dKNHR5eE5GV3pZc01Z?=
 =?utf-8?B?Wjh3OVpwalZqY2NvVERZNVI1d1hiOTloVURaaDdKdFhQQVN3MG5PUGhJQ3Vy?=
 =?utf-8?B?UWlPb1g2WEpNU21TOVNMdVFDQVZYUytkM282S1RiZjR0N3RuU0tpbnlNYkVs?=
 =?utf-8?B?YUw0dnI2OWN0d2JXbVNLUC92bHFUVDRVbEZBUTA5bXJLWVQ3YVJFU3JpVGdk?=
 =?utf-8?B?Z3ZlRjJzZStOenk1N3lTOHRRNks3RkZ6SXI4QnJaTFk5d01Ub053ckhvbVIx?=
 =?utf-8?B?ZkpDaFVKeEtVZ0lPZUlqaW1ZbDIvUFJVZHEwS1F5RlV5NXRYNkY2NEtpczlo?=
 =?utf-8?B?dElZcm9CdnliTXhzQmdrZG0wcWZ0Z2JiT0tXNkt2d3dTcDZaRWJxM3hOUVll?=
 =?utf-8?B?K251NWlEaU1vbGxBS09henVJak5RbkoySElBVEpvQmpTUXk1eUZSQXlCMHhG?=
 =?utf-8?B?RDNKdzVUaW1JblRpS2cyRGhUQ0Z6Y2VkQjMxZjRPMk1wZ3laZ3hVWS9WUnlw?=
 =?utf-8?B?aG41a1JucUNjQitiNzgvVG9TbjIzeG5oN1gydlVZWUVyWGQvT2JsUWtoelNU?=
 =?utf-8?B?T1U4ZVMyR2I1YVF3S3VmbjFUL2dvY1VUUDZLMFBQblI1Qkx5YU1ma3pQemlO?=
 =?utf-8?B?RUhRaUpoVEVpcWVBU1BmVUVWNG5iZjIrU0NEZytaUXNXSnVyM1ZuYmJWZzV3?=
 =?utf-8?B?NjJrc3pGakV2S1RrWGg2Q2hqMjR3WmFFdGlqTDk4RUtia3d1bThtZjBpYUZS?=
 =?utf-8?B?aWtVbUxJTW5kVjRERGgrbnpZS1pNWWFoOWhwWktYV3JpRGg5QjRJdTNZNi9H?=
 =?utf-8?B?aEY4VjJyS2lKRXdVaGNmQnYvSkRHcVhCZlZ2WU5xZGF5cnBJSlVnekpoLytB?=
 =?utf-8?B?YklwYmZVRWcyU1hWcHYwTURucDZZUFBvQ2x5aU9FTnF2MGhlOWNnMmdCVDhu?=
 =?utf-8?B?ejZJK29wVWlvNTVRSllHMGNhR1RXV2F4aUg1OHJNQ3ltL3lEdkltVWhNSm9K?=
 =?utf-8?B?OVlqR0o1clBIc25SYUFZMU5iRW1JL3VzYXVQZGp4emNUMmtwQnBLekRja0ky?=
 =?utf-8?B?SCt2SkJoWkpDZktubWZtd09LVXI2by9yZXJQaHBiNFBTRjRUcGU4QzN2K28r?=
 =?utf-8?B?UnM1RkdzcFZUQ2g3QUxjTDZYaXp3eG1wK0JIRHEvOEo4RjNLUmcyMndabEQ4?=
 =?utf-8?B?WkFhdUVOWU1STkJXQUF6VjhyZ2dYUUtrWVpHOTkwdXFMWkJFTi9CNlJGbnhq?=
 =?utf-8?B?RmorTjcvMDJzSHh0QUsxaVpEaFNhSjBwSXk2Tzc1cUk5eTZzdW02UmRNbFFI?=
 =?utf-8?B?T1dVSk1NbXpBbERmQlZ0WU8rUDlHd0JKTysrejhMSHM0aXoyTDVuL3k1NlFq?=
 =?utf-8?B?SVJ1bElvdWlpc2lINXV2em1yUkxjTXBwNjZIT2RkTW11WWd6ZXN3WFZ0ajh0?=
 =?utf-8?B?OGplUkRPSVZjTHordFIwc1ZpTmd5UmdvblJXU1NEN0JKZGVWK1dmZ3lhazh2?=
 =?utf-8?B?SnZQMEFOQ054TjdMa3NwcGQ2RFhoR010eXRoeEFjQldKTmxNVm9DaDBsc3k3?=
 =?utf-8?Q?lh3wWA98J5eH0o1ukcurWWM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87162A4D140A7645BDFF5B41BD1CCE8F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7715b4-1ce9-4747-06f5-08d9cbe34088
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 22:25:14.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sVuXK4Btopf7LNO3psPEDfecvkPwk/iSIrrBUW4cg8Eyg15FoY5ySb7eUhHSveoDU95iFfYx7gN0rX73DiNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5702
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIxLTEyLTMwIGF0IDEzOjI0IC0wODAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxMi8zMC8yMSAxMTozNSBBTSwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiBGcm9t
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4g
DQo+ID4gV2UncmUgb2JzZXJ2aW5nIHRoZSBmb2xsb3dpbmcgc3RhY2sgdHJhY2UgdXNpbmcgdmFy
aW91cyBrZXJuZWxzDQo+ID4gd2hlbg0KPiA+IHJ1bm5pbmcgaW4gdGhlIEF6dXJlIGNsb3VkLg0K
PiA+IA0KPiA+IMKgd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjMTIgc3R1Y2sgZm9y
IDIzcyENCj4gPiBba3dvcmtlci8xMjoxOjMxMDZdDQo+ID4gwqBNb2R1bGVzIGxpbmtlZCBpbjog
cmFpZDAgaXB0X01BU1FVRVJBREUgbmZfY29ubnRyYWNrX25ldGxpbmsNCj4gPiB4dF9hZGRydHlw
ZSBuZnRfY2hhaW5fbmF0IG5mX25hdCBicl9uZXRmaWx0ZXIgYnJpZGdlIHN0cCBsbGMgZXh0NA0K
PiA+IG1iY2FjaGUgamJkMiBvdmVybGF5IHh0X2Nvbm50cmFjayBuZl9jb25udHJhY2sgbmZfZGVm
cmFnX2lwdjYNCj4gPiBuZl9kZWZyYWdfaXB2NCBuZnRfY291bnRlciBycGNyZG1hIHJkbWFfdWNt
IHh0X293bmVyIGliX3NycHQNCj4gPiBuZnRfY29tcGF0IGludGVsX3JhcGxfbXNyIGliX2lzZXJ0
IGludGVsX3JhcGxfY29tbW9uIG5mX3RhYmxlcw0KPiA+IGlzY3NpX3RhcmdldF9tb2QgaXNzdF9p
Zl9tYm94X21zciBpc3N0X2lmX2NvbW1vbiBuZm5ldGxpbmsNCj4gPiB0YXJnZXRfY29yZV9tb2Qg
bmZpdCBpYl9pc2VyIGxpYm52ZGltbSBsaWJpc2NzaQ0KPiA+IHNjc2lfdHJhbnNwb3J0X2lzY3Np
IGliX3VtYWQga3ZtX2ludGVsIGliX2lwb2liIHJkbWFfY20gaXdfY20gdmZhdA0KPiA+IGliX2Nt
IGZhdCBrdm0gaXJxYnlwYXNzIGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIG1seDVfaWIN
Cj4gPiBnaGFzaF9jbG11bG5pX2ludGVsIHJhcGwgaWJfdXZlcmJzIGliX2NvcmUgaTJjX3BpaXg0
IHBjc3Brcg0KPiA+IGh5cGVydl9mYiBodl9iYWxsb29uIGh2X3V0aWxzIGpveWRldiBuZnNkIGF1
dGhfcnBjZ3NzIG5mc19hY2wgbG9ja2QNCj4gPiBncmFjZSBzdW5ycGMgaXBfdGFibGVzIHhmcyBs
aWJjcmMzMmMgbWx4NV9jb3JlIG1seGZ3IHRscyBwY2lfaHlwZXJ2DQo+ID4gcGNpX2h5cGVydl9p
bnRmIHNkX21vZCB0MTBfcGkgc2cgYXRhX2dlbmVyaWMgaHZfc3RvcnZzYyBodl9uZXR2c2MNCj4g
PiBzY3NpX3RyYW5zcG9ydF9mYyBoeXBlcnZfa2V5Ym9hcmQgaGlkX2h5cGVydiBhdGFfcGlpeCBs
aWJhdGENCj4gPiBjcmMzMmNfaW50ZWwgaHZfdm1idXMgc2VyaW9fcmF3IGZ1c2UNCj4gPiDCoENQ
VTogMTIgUElEOiAzMTA2IENvbW06IGt3b3JrZXIvMTI6MSBOb3QgdGFpbnRlZCA0LjE4LjAtDQo+
ID4gMzA1LjEwLjIuZWw4XzQueDg2XzY0ICMxDQo+ID4gwqBIYXJkd2FyZSBuYW1lOiBNaWNyb3Nv
ZnQgQ29ycG9yYXRpb24gVmlydHVhbCBNYWNoaW5lL1ZpcnR1YWwNCj4gPiBNYWNoaW5lLCBCSU9T
IDA5MDAwOMKgIDEyLzA3LzIwMTgNCj4gPiDCoFdvcmtxdWV1ZTogeGZzLWNvbnYvbWQxMjcgeGZz
X2VuZF9pbyBbeGZzXQ0KPiA+IMKgUklQOiAwMDEwOl9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSsweDExLzB4MjANCj4gPiDCoENvZGU6IDdjIGZmIDQ4IDI5IGU4IDRjIDM5IGUwIDc2IGNmIDgw
IDBiIDA4IGViIDhjIDkwIDkwIDkwIDkwIDkwDQo+ID4gOTAgOTAgOTAgOTAgOTAgMGYgMWYgNDQg
MDAgMDAgZTggZTYgZGIgN2UgZmYgNjYgOTAgNDggODkgZjcgNTcgOWQNCj4gPiA8MGY+IDFmIDQ0
IDAwIDAwIGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwIDhiIDA3
DQo+ID4gwqBSU1A6IDAwMTg6ZmZmZmFjNTFkMjZkZmQxOCBFRkxBR1M6IDAwMDAwMjAyIE9SSUdf
UkFYOg0KPiA+IGZmZmZmZmZmZmZmZmZmMTINCj4gPiDCoFJBWDogMDAwMDAwMDAwMDAwMDAwMSBS
Qlg6IGZmZmZmZmZmOTgwMDg1YTAgUkNYOiBkZWFkMDAwMDAwMDAwMjAwDQo+ID4gwqBSRFg6IGZm
ZmZhYzUxZDM4OTNjNDAgUlNJOiAwMDAwMDAwMDAwMDAwMjAyIFJESTogMDAwMDAwMDAwMDAwMDIw
Mg0KPiA+IMKgUkJQOiAwMDAwMDAwMDAwMDAwMjAyIFIwODogZmZmZmFjNTFkMzg5M2M0MCBSMDk6
IDAwMDAwMDAwMDAwMDAwMDANCj4gPiDCoFIxMDogMDAwMDAwMDAwMDAwMDBiOSBSMTE6IDAwMDAw
MDAwMDAwMDA0YjMgUjEyOiAwMDAwMDAwMDAwMDAwYTIwDQo+ID4gwqBSMTM6IGZmZmZkMjI4ZjNl
NWEyMDAgUjE0OiBmZmZmOTYzY2Y3ZjU4ZDEwIFIxNTogZmZmZmQyMjhmM2U1YTIwMA0KPiA+IMKg
RlM6wqAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTYyNWJmYjAwMDAwKDAwMDApDQo+
ID4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IMKgQ1M6wqAgMDAxMCBEUzogMDAwMCBFUzog
MDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gPiDCoENSMjogMDAwMDdmNTAzNTQ4NzUwMCBD
UjM6IDAwMDAwMDA0MzI4MTAwMDQgQ1I0OiAwMDAwMDAwMDAwMzcwNmUwDQo+ID4gwqBEUjA6IDAw
MDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAw
MA0KPiA+IMKgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6
IDAwMDAwMDAwMDAwMDA0MDANCj4gPiDCoENhbGwgVHJhY2U6DQo+ID4gwqAgd2FrZV91cF9wYWdl
X2JpdCsweDhhLzB4MTEwDQo+ID4gwqAgaW9tYXBfZmluaXNoX2lvZW5kKzB4ZDcvMHgxYzANCj4g
PiDCoCBpb21hcF9maW5pc2hfaW9lbmRzKzB4N2YvMHhiMA0KPiA+IMKgIHhmc19lbmRfaW9lbmQr
MHg2Yi8weDEwMCBbeGZzXQ0KPiA+IMKgID8geGZzX3NldGZpbGVzaXplX2lvZW5kKzB4NjAvMHg2
MCBbeGZzXQ0KPiA+IMKgIHhmc19lbmRfaW8rMHhiOS8weGUwIFt4ZnNdDQo+ID4gwqAgcHJvY2Vz
c19vbmVfd29yaysweDFhNy8weDM2MA0KPiA+IMKgIHdvcmtlcl90aHJlYWQrMHgxZmEvMHgzOTAN
Cj4gPiDCoCA/IGNyZWF0ZV93b3JrZXIrMHgxYTAvMHgxYTANCj4gPiDCoCBrdGhyZWFkKzB4MTE2
LzB4MTMwDQo+ID4gwqAgPyBrdGhyZWFkX2ZsdXNoX3dvcmtfZm4rMHgxMC8weDEwDQo+ID4gwqAg
cmV0X2Zyb21fZm9yaysweDM1LzB4NDANCj4gPiANCj4gPiBKZW5zIHN1Z2dlc3RlZCBhZGRpbmcg
YSBsYXRlbmN5LXJlZHVjaW5nIGNvbmRfcmVzY2hlZCgpIHRvIHRoZSBsb29wDQo+ID4gaW4NCj4g
PiBpb21hcF9maW5pc2hfaW9lbmRzKCkuDQo+IA0KPiBUaGUgcGF0Y2ggZG9lc24ndCBhZGQgaXQg
dGhlcmUgdGhvdWdoLCBJIHdhcyBzdWdnZXN0aW5nOg0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2lv
bWFwL2J1ZmZlcmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jDQo+IGluZGV4IDcxYTM2
YWUxMjBlZS4uNGFkMjQzNmE5MzZhIDEwMDY0NA0KPiAtLS0gYS9mcy9pb21hcC9idWZmZXJlZC1p
by5jDQo+ICsrKyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMNCj4gQEAgLTEwNzgsNiArMTA3OCw3
IEBAIGlvbWFwX2ZpbmlzaF9pb2VuZHMoc3RydWN0IGlvbWFwX2lvZW5kICppb2VuZCwNCj4gaW50
IGVycm9yKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlvZW5kID0gbGlzdF9m
aXJzdF9lbnRyeSgmdG1wLCBzdHJ1Y3QgaW9tYXBfaW9lbmQsDQo+IGlvX2xpc3QpOw0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsX2luaXQoJmlvZW5kLT5pb19saXN0
KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpb21hcF9maW5pc2hfaW9lbmQo
aW9lbmQsIGVycm9yKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbmRfcmVz
Y2hlZCgpOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoH0NCj4gwqBFWFBPUlRfU1lNQk9MX0dQ
TChpb21hcF9maW5pc2hfaW9lbmRzKTsNCj4gDQo+IGFzIEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQg
aXQgb25jZS1wZXItdmVjLiBCdXQgbm90IHN1cmUgaWYgeW91IHRlc3RlZA0KPiB0aGF0IHZhcmlh
bnQgb3Igbm90Li4uDQo+IA0KDQpZZXMsIHdlIGRpZCB0ZXN0IHRoYXQgdmFyaWFudCwgYnV0IHdl
cmUgc3RpbGwgc2VlaW5nIHRoZSBzb2Z0IGxvY2t1cHMNCm9uIEF6dXJlLCBoZW5jZSB3aHkgSSBt
b3ZlZCBpdCBpbnRvIHRoZSBpbm5lciBsb29wLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
