Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A089E48226D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 07:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhLaGQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 01:16:57 -0500
Received: from mail-co1nam11on2122.outbound.protection.outlook.com ([40.107.220.122]:18273
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229496AbhLaGQ4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:16:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMRlFz6WgtWYogH7E+Njzc/bR0yrSstc2IHTEnppsamtxOlcRRQwZV2AF7EHHBBysn00GlcOIR+xCx4NH59dSVP5IgAgEcBw0eS0AZw5he+gLnISzsa5MsWlW8l44+N1v1wS/54dmNqq2uKMR4SzUd8frBoVUC1Ja9Mk/AxGzQmioHr3W+CJlCbhoapbEeWPsCkh9R7dHBgnIpXJ5w96+gWXKpQLv4ai72pcHNmPUhq/M4mrikwqbTy0lbHG/28UdJDiaxov+G9thuyiL/pbmR02BjQ7Aynl5rzv5wyNdecR94OHvkbJHzm1KS95SHPUXJlSrPntpbmws2C1ZemyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFA0eACchPuxqd2T+hfEJCR28cv7cOaJ5SvzUENnwRk=;
 b=DyJZZ3G3Q8mKFvtbaddzdt+LaaMdtrZCzMtCXNmFUh4XbQi8gnA5Baq+zDD0WqCai9Ek5n2kh58qlAHpXcwwyHNka3miV1kRFy993hUN2iv+v4nTuBHG5uS9Pq/t10XB0nAuLQNywuSSesBF3s40cbGwbjVZqDS9X3M2ym3aOQC1/TSM4By+LlQX7gPBrViJMXItwMswZrhCvBOJYW9InnNt1kLLtXwOxI0ebFVsnk9mrEZL4+tzw1/ytST5GurxPn4VqfN9rm7aeNhIhAACBuqZS1XLS7Ud1PrYCyhm4lPTcqCm8QeWCe6ZF5uDF8wGeq4mULrcIxrWXdjgdCs3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFA0eACchPuxqd2T+hfEJCR28cv7cOaJ5SvzUENnwRk=;
 b=BbREVrGzVTScMB1qOIGOlGZGedw+v/UTC5lcPbaMS1vIGlDORTU0/xyT/E6t75ahRuRSkizptSajZaOZXPYaXJ1bbQrhkDNm07hOa7/iLcfN5Za/t7MpQDuwf10X9Ju15TxWREigdOaOq3fdEXjIl4ymJ3B2248c7CvckYYnxaY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DS7PR13MB4639.namprd13.prod.outlook.com (2603:10b6:5:3ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.9; Fri, 31 Dec
 2021 06:16:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 06:16:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "willy@infradead.org" <willy@infradead.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4A=
Date:   Fri, 31 Dec 2021 06:16:53 +0000
Message-ID: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
In-Reply-To: <Yc5f/C1I+N8MPHcd@casper.infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2faa22b-e112-40c7-7dbc-08d9cc25239e
x-ms-traffictypediagnostic: DS7PR13MB4639:EE_
x-microsoft-antispam-prvs: <DS7PR13MB463921DAB5F31EBBCFF830CFB8469@DS7PR13MB4639.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZH0MAU+yzRYzsP9kCTwNU6PxvdQL8HLAI6NIZy2Ce1gYEvKBhHCVG3Qn0FG2V4xwb4WgjvxY/r/LxsDumyPTF2gc0w0RmdOvh8uWensA0ggVG3kdxIoc47UTqCYTtA7PQQVJ+XZErHHvHIlJitHWWdyGfzVeXMjf+4j5KR2iCc/UIH/iqkxsksA3ERp2jrtcpMbR2uuDkrRcDGoZzAVMLm2lYjBBtIGDFvJQCAiyqyWIGB9RQXJzTY/YATdbWTkNLglc7u9IkuyuXcsDupxIk58Za+ujYcRJ8Dqxd8wMGoG21ikxOB0qZBAyqZuJbilICg3lrjYwBCy8HbZJUiXEK81KUbxAIWTvsDlyawG+B/n0GfAgs3sYBHPu+psTgblFyHcDk4XRnPdmgPurhjPSGNVeq8kg95I06bnTH/Csmn5zbT+ILVNz1XU2gmVf4GWZPaHG6kC+xKyEDT1u2M7W+qFqFc00VsiKksBCIkIoS4/NAZmEFvSaoYGddv5WdTF+uam8gAQ92Qzo26w5ScNwcOVhsB8f0gRoPZoxW0EOmlDSuHMp26C2lhOf7OKDzbZTKt+utAg3tlAbh+VQS2+dxU44LWD252O1QNAjRPuQPoGnUjeivpsax8xwIDFz+4l+rpGi/d3dBA4IKYTuMukyLWR0fI9sEZLIP2ax10YS+hOINj8LSAKGh8wU2jbyCr07BNnYz8eixquxtcbyUVhtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(376002)(396003)(39830400003)(136003)(71200400001)(38070700005)(6486002)(76116006)(110136005)(6512007)(122000001)(508600001)(38100700002)(26005)(6506007)(36756003)(186003)(4001150100001)(2616005)(2906002)(54906003)(8676002)(83380400001)(316002)(8936002)(4326008)(66556008)(66476007)(64756008)(66446008)(86362001)(5660300002)(66946007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWNjVlBsYktMSUh6ZTBVZVBZTWZhRHByaEdSZzdNNlY3K3VLaXBMYVBDY1p4?=
 =?utf-8?B?amZvelhvemM1YStZRklWNGVMcWcrNVNwRW9BT0E0SWx3aFhpQ2xySzd2OG5n?=
 =?utf-8?B?eCtGeW95YkpvNVNuUHUrTkhqV3dPQ2s4cHJoSS9BdGJtVS9uZ0YxSFVtUVJx?=
 =?utf-8?B?bHNsbStIQkpFUllPanBYK0pQQnVvQUdTblcwdFFhNzdnWW0vZGNLMjhNdFBa?=
 =?utf-8?B?R2NkR0dLTnZ4NEhKVmhvbldRdmkreWJHWHIyODRBQjYwY3pieFpGN1NmTkdS?=
 =?utf-8?B?dCtBWHpwNHBoVmtIZ2dVcjkyY1Q1UDFva0hUYk0rMWJzWG1BenU1NlpXelNa?=
 =?utf-8?B?aGJXbG9iRm5LaVlFbWtDSU5NbmVWTHI3NHA5djQ4SXlYelZTdDhpQU5XMEtM?=
 =?utf-8?B?ZWdOaE1BcVl6QzJYMkh0Nm8weXE3NE9GRzZQZ1hXaUJXSUpkK2hQU3g4Ky9v?=
 =?utf-8?B?NGdrcDlUcEFkZSs1b003UmkyWWl4cmEvV2t1NUg5QjZrWXZRTTVjSXoxTzlZ?=
 =?utf-8?B?V1VYN0lOeHVrRm5yWnE4MFB4ME52LzZBVXg4YURuVkxQVkYvTEk3aE5nVjlq?=
 =?utf-8?B?Wll6M2JuUGNkaERBRUdxQTVwaXp1WUd0TWhQeEhVditOWk05Z2hxTVNxdm1R?=
 =?utf-8?B?SFV1cGFwWW16aTZ6TFl5S0gzL21OSjBxNC95SWJzeHdKNkx4MVRZcDhhVEIw?=
 =?utf-8?B?Y0phdDdJUmkwTkxST1BHSnNIK1FEZTI1Y3MrcW1LUUwwV0xYQWtqZzRDOXJ5?=
 =?utf-8?B?STNOY0hJVktmaUh0M0ppMUhVeUJPK3phaThsWWk0QUlyL0JxOWxEcmFVSlZ6?=
 =?utf-8?B?M28xeDhQZk81QmNOVkg3S2ltU3ZFaTdmUjFTVUdlK2lMSjVCMWM5cjIrNmFD?=
 =?utf-8?B?QlFzdHNoaE5oUCs2a2Q5MW1Fa2Q2cjVQZGJaNGxxVjYvTFg2TTJxYXZaYUFk?=
 =?utf-8?B?SmQxWlJ2NzZ2a3JIRDR0L0hzL2p2U1FBZnpBbW0xZmlSYXZNLyt2S0xLV1ox?=
 =?utf-8?B?MjhYYThMY0ZxdldoYStVai9KaTNSQWE4UzlKVHhjRGNuMWI0anZqZTZMRTZO?=
 =?utf-8?B?QWlWdGZXUkpjOW9UVVgzKzVTR0dvc1dBSlF0REJBTDRoZkJkaXBnWXRuVUNV?=
 =?utf-8?B?eC9GV3FQNzVmaC9EQ1R0Qy83cXRaWTd0M2ljT3UvZUExZkFIOUE5N3hJSVU3?=
 =?utf-8?B?UnZtbFE4RjE3eWZ2M1RabVlFUWxqOVlFYk9yNWFBbXZIakRwcTNDdXdaSlhR?=
 =?utf-8?B?M1U2bWhFZ0xPaml5ZlJ3ZE93cjEzSWwwZEdrS2hyRk9rRWZJY0pHQUpJMXZU?=
 =?utf-8?B?VVcwYnozSjZVWTJxb0JTM1ZwWW5jWWFvZjFCVmVKSk11OUNJNEZNcWZqUzlF?=
 =?utf-8?B?bFhKV1ovK240QkdTbFFGVEJUQno4aC9pZFNTVjhaS2RNOVA5ajhlbGhsNmZl?=
 =?utf-8?B?ZmM2eTVuRzc5dVU3YmZBeC90YVhSMUxCbVM2QURvSHdwRDBwOVYwUjA4Zm9l?=
 =?utf-8?B?d1BwS3Njc1BIdDBySEEwVitwTE5yUmZITVRlZlZyd0ZFRjRSeDBibEtjSGxp?=
 =?utf-8?B?VDJNYjRPMkg5Mmt1RWNZVkUxZFRIMFpPaEVvQUhPQ1FyVkMxeGN1TVlIaDc2?=
 =?utf-8?B?Q2FoVlpBam1Lc1RGbC8reERzZFJKbExyalA1RkMwcVBMZC9uZnFiMkY0aWZt?=
 =?utf-8?B?SmdsR2lzSVB5Y0Vrc3VoWlAwUU03QTZDL1k2b1FOdnptdjhpYjFwUlo1bjFO?=
 =?utf-8?B?OElhR0Y5cld2ckhNWm9oN2g3bXBIZVdNVktNSzdTL1l1aHBYVmd1cEU5RjV5?=
 =?utf-8?B?NE9IazVZR2YyRW4rWG5veFJoR095TVFGMVRZa3FFR09LU2NOZy8zd0dnSXN3?=
 =?utf-8?B?VnlINDh3NHM1YklzMU1kL004OUdMN3o2Tm1yQXQyVTl0SVQ3ajJFbGh4bU5Y?=
 =?utf-8?B?UUZ2cDNjRjBVSlZBenlXRURkLzdxVXpXOUZOMmMwZVorbEpvYjRuTktEZXJM?=
 =?utf-8?B?NTZaRGNSUEEyQkRibWtkeXJWTDFxN0VFU2Ewci9velJGVVZldm1BR1ROTVk0?=
 =?utf-8?B?RXNvTlNqdXZjNXZMeEVFRnR3NDdOR2tLTGdFQmgvaWU5WHJldzZJT2V0T0c4?=
 =?utf-8?B?L2diQ3FEc2Z5VUxDNW5qNEdxWFlDZ1RmVGVLT25aYlhZb2VMU2d5bHVpRy9j?=
 =?utf-8?Q?JaWg0cBzNlR3rcwyYpN+sdE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5378E57DC15543BF9E062C22B2FDD5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2faa22b-e112-40c7-7dbc-08d9cc25239e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 06:16:53.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvUy/JNH9NkkLpAwVLAeor4srsR5DnR8ctmRUWfO7jnyhdetvZAGw95eenXe4PbBka6Y+q4RlsqP5lWBsTEkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4639
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIxLTEyLTMxIGF0IDAxOjQyICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gVGh1LCBEZWMgMzAsIDIwMjEgYXQgMDI6MzU6MjJQTSAtMDUwMCwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiDCoFdvcmtxdWV1ZTogeGZzLWNvbnYvbWQxMjcgeGZzX2VuZF9p
byBbeGZzXQ0KPiA+IMKgUklQOiAwMDEwOl9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDEx
LzB4MjANCj4gPiDCoENvZGU6IDdjIGZmIDQ4IDI5IGU4IDRjIDM5IGUwIDc2IGNmIDgwIDBiIDA4
IGViIDhjIDkwIDkwIDkwIDkwIDkwDQo+ID4gOTAgOTAgOTAgOTAgOTAgMGYgMWYgNDQgMDAgMDAg
ZTggZTYgZGIgN2UgZmYgNjYgOTAgNDggODkgZjcgNTcgOWQNCj4gPiA8MGY+IDFmIDQ0IDAwIDAw
IGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQ0IDAwIDAwIDhiIDA3DQo+ID4g
wqBSU1A6IDAwMTg6ZmZmZmFjNTFkMjZkZmQxOCBFRkxBR1M6IDAwMDAwMjAyIE9SSUdfUkFYOg0K
PiA+IGZmZmZmZmZmZmZmZmZmMTINCj4gPiDCoFJBWDogMDAwMDAwMDAwMDAwMDAwMSBSQlg6IGZm
ZmZmZmZmOTgwMDg1YTAgUkNYOiBkZWFkMDAwMDAwMDAwMjAwDQo+ID4gwqBSRFg6IGZmZmZhYzUx
ZDM4OTNjNDAgUlNJOiAwMDAwMDAwMDAwMDAwMjAyIFJESTogMDAwMDAwMDAwMDAwMDIwMg0KPiA+
IMKgUkJQOiAwMDAwMDAwMDAwMDAwMjAyIFIwODogZmZmZmFjNTFkMzg5M2M0MCBSMDk6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPiDCoFIxMDogMDAwMDAwMDAwMDAwMDBiOSBSMTE6IDAwMDAwMDAwMDAw
MDA0YjMgUjEyOiAwMDAwMDAwMDAwMDAwYTIwDQo+ID4gwqBSMTM6IGZmZmZkMjI4ZjNlNWEyMDAg
UjE0OiBmZmZmOTYzY2Y3ZjU4ZDEwIFIxNTogZmZmZmQyMjhmM2U1YTIwMA0KPiA+IMKgRlM6wqAg
MDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTYyNWJmYjAwMDAwKDAwMDApDQo+ID4ga25s
R1M6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IMKgQ1M6wqAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBD
UjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gPiDCoENSMjogMDAwMDdmNTAzNTQ4NzUwMCBDUjM6IDAw
MDAwMDA0MzI4MTAwMDQgQ1I0OiAwMDAwMDAwMDAwMzcwNmUwDQo+ID4gwqBEUjA6IDAwMDAwMDAw
MDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+
IMKgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAw
MDAwMDAwMDA0MDANCj4gPiDCoENhbGwgVHJhY2U6DQo+ID4gwqAgd2FrZV91cF9wYWdlX2JpdCsw
eDhhLzB4MTEwDQo+ID4gwqAgaW9tYXBfZmluaXNoX2lvZW5kKzB4ZDcvMHgxYzANCj4gPiDCoCBp
b21hcF9maW5pc2hfaW9lbmRzKzB4N2YvMHhiMA0KPiANCj4gPiArKysgYi9mcy9pb21hcC9idWZm
ZXJlZC1pby5jDQo+ID4gQEAgLTEwNTIsOSArMTA1MiwxMSBAQCBpb21hcF9maW5pc2hfaW9lbmQo
c3RydWN0IGlvbWFwX2lvZW5kDQo+ID4gKmlvZW5kLCBpbnQgZXJyb3IpDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV4dCA9IGJpby0+YmlfcHJp
dmF0ZTsNCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogd2Fs
ayBlYWNoIHBhZ2Ugb24gYmlvLCBlbmRpbmcgcGFnZSBJTyBvbiB0aGVtICovDQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJpb19mb3JfZWFjaF9zZWdtZW50X2FsbChidiwgYmlv
LCBpdGVyX2FsbCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmlvX2Zvcl9l
YWNoX3NlZ21lbnRfYWxsKGJ2LCBiaW8sIGl0ZXJfYWxsKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW9tYXBfZmluaXNoX3BhZ2Vfd3JpdGVi
YWNrKGlub2RlLCBidi0NCj4gPiA+YnZfcGFnZSwgZXJyb3IsDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBidi0+YnZfbGVuKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvbmRfcmVzY2hlZCgpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaW9fcHV0
KGJpbyk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgLyogVGhl
IGlvZW5kIGhhcyBiZWVuIGZyZWVkIGJ5IGJpb19wdXQoKSAqLw0KPiANCj4gQXMgSSByZWNhbGws
IGlvbWFwX2ZpbmlzaF9pb2VuZCgpIGNhbiBiZSBjYWxsZWQgaW4gc29mdGlycSAob3IgZXZlbg0K
PiBoYXJkaXJxPykgY29udGV4dCBjdXJyZW50bHkuwqAgSSB0aGluayB3ZSd2ZSBzZWVuIHNpbWls
YXIgdGhpbmdzDQo+IGJlZm9yZSwNCj4gYW5kIHRoZSBzb2x1dGlvbiBzdWdnZXN0ZWQgYXQgdGhl
IHRpbWUgd2FzIHRvIGFnZ3JlZ2F0ZSBmZXdlcg0KPiB3cml0ZWJhY2sNCj4gcGFnZXMgaW50byBh
IHNpbmdsZSBiaW8uDQoNCkkgaGF2ZW4ndCBzZWVuIGFueSBldmlkZW5jZSB0aGF0IGlvbWFwX2Zp
bmlzaF9pb2VuZCgpIGlzIGJlaW5nIGNhbGxlZA0KZnJvbSBhbnl0aGluZyBvdGhlciB0aGFuIGEg
cmVndWxhciB0YXNrIGNvbnRleHQuIFdoZXJlIGNhbiBpdCBiZSBjYWxsZWQNCmZyb20gc29mdGly
cS9oYXJkaXJxIGFuZCB3aHkgaXMgdGhhdCBhIHJlcXVpcmVtZW50Pw0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
