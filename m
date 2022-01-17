Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DBF490F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiAQRYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 12:24:54 -0500
Received: from mail-bn8nam12on2102.outbound.protection.outlook.com ([40.107.237.102]:50698
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230177AbiAQRYx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:24:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf2SK6blTJWYw4oEL9MDVFLo/Bdsd7yFhbMiWyaEFyZdTQ0K3EgfVgwLBbZJA4oDjLYAPuLCNmmZF6MRTjaGN5GvDRyhIR1zaWyi9LT9LruIT8iLaX8KnKcbyNfHTHgy/uc3F0TpJMzuK4soy1G1KxFT9bnTx3lV1ykNIDO3w/nflztRz2UZAVrtXRxH1y4gMfZzjgPbbTknJC95qADLzlXqyjfheuAlOHufgx2LVQ0fmCh/VnyC6UbhiWvp4udM5LJOOufaexNsvwiO7o3siau3h/d7MqCc4i/TSpwdySPTatXqVUaAuyIO/Dd36eE/QPCZXDAmfM0XLjquQUUF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkP7+if+SACRKBmK1a/Rn+I+8H0vRjG1Z+lCofEFu5c=;
 b=CjBrUe5f1qJRD7BWdFQAuor+l2fBGufQ7saql686+EJ4zjWVqyblxbenyM/9+zjYHzur0Beg11FKZZcfX7EnMCoTpwLaj/j9QIbfA5Ix0q6qrZFzeVJ42djhb2pxSTtBzxB0EiTaMlruFyLqtgluaFkbdIKS7RA/EJgdj+VooHQXAs+iCcrBoDcsSTJFkZ0kXDJgdfNODnjbML2WZi2IZl4ZpTD21zNJ3a5K86xLUrU+6pUNE1F5xR9w8C11Y+VTP1dBrsAZyKv6reLxb2gP4jXkXdZAgwGffwdNBT9Y7zTB6CZX89U9+WlqaV8pW5iPmNSfFCsrq4xexeryvddckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkP7+if+SACRKBmK1a/Rn+I+8H0vRjG1Z+lCofEFu5c=;
 b=HioF6XJQAkvk41/CeQZ5zC4OaGILAOcuOpTyj0dOG20J98ZYsplAASyWdzM6WttGpQycrK5byPW4dQKrfWGJ/TK7m9lPtfw+GVpSqEbSzDOTNd9N0uBzDyrF+16ZY2JmpJg219ZRdnYsRVlX6Gp/nD1/FSssm2zX2JM9XoGrmpk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3563.namprd13.prod.outlook.com (2603:10b6:5:1c9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 17 Jan
 2022 17:24:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4909.007; Mon, 17 Jan 2022
 17:24:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Topic: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAGffQCAATe6gIAAIn2AgAFMBQCABp1oAIAESE+AgAZPz4A=
Date:   Mon, 17 Jan 2022 17:24:50 +0000
Message-ID: <47240d293a6ce4d0119563989cba42f46dcaa4e3.camel@hammerspace.com>
References: <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
         <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
         <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
         <20220105224829.GO945095@dread.disaster.area>
         <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
         <20220110233746.GB945095@dread.disaster.area>
         <ac3d6ea486e9992fe38bc76426070b38d712e44a.camel@hammerspace.com>
In-Reply-To: <ac3d6ea486e9992fe38bc76426070b38d712e44a.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ea41afb-9683-41d8-c2e6-08d9d9de4475
x-ms-traffictypediagnostic: DM6PR13MB3563:EE_
x-microsoft-antispam-prvs: <DM6PR13MB35634C8E5782C5B31384E2ABB8579@DM6PR13MB3563.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQftfoXdZRwXQFxwq/xw7Sjh13oE7XXY6+VPS2Dmv1mZ/xMDQ8sa/In1XU8fwbyVKet2YpF0ZtcXvUMDCUudfHlgf8TB1cUhys2wR5s5xG2CGDbnqM4a91OiPx3Cwd+z2OD2Hm8qR+IgzBvleisEN1CFS6qlvaR28x+hzQaBvIM1F5/3pG2XO0DUEQZp81+TQAfI6POr6WJ1rI/jrQU/sUG/bbzn4iosteEk6enH0mJz32j3UiWCyh2oT93Pfn2Qrp8xGC2Dd8yfyrDdBlCOJff856B0DfmQvfMuBueFKupjWJzWwXEuAzRXPlIeS78YzTj2TYKU54P3juEg1Gatj+5nK1iI+6TuVh8M775bKhKC0b0Isxr+it32TrhzNgdnL1y7OCxyECNtRWQZ5h66y/qzT8vrkeSD4a9qWJ/fWmfZmz5Pk8Uf9VLYDRtjdQ+DW+uTDPxdcJ8Cud6/zQUox2o4C2FpDim8wySvvZjOGLgq828ksGWTvl4hnH/SSZHOlm59BrzCOX1xXwNOgESC8+8mEoE+tsL7CoQmYcDJCt81AckwfMaigppMnp8OwYsPoOm6Z4GkX4lfrXd6jliUQ40vLnQA1oqUUd4DxlNWiQico61cfFi7UlEsgS/9xuZxZoR48uvwk0FqaFe8DCvaGRz1bGjQ3Dpr8cg+T0icLf1s0ZkpQVvitZlnU+0I1DO2Kiqrao10V7mfjKrNQOmmlXRFJnowbuxFAg4uTuKus2u+g3KYUL/0YsYz/I72OM1o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(376002)(136003)(39830400003)(66556008)(66476007)(64756008)(186003)(66446008)(66946007)(26005)(76116006)(4326008)(2616005)(4744005)(5660300002)(8676002)(36756003)(71200400001)(83380400001)(8936002)(54906003)(86362001)(6916009)(316002)(508600001)(38100700002)(6512007)(122000001)(6506007)(6486002)(2906002)(38070700005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enRyWTJtSnhmNjRLZWZxYVY0NjB0cEJJL1NYL1dSYkZrUHNtcE1zREduT1dx?=
 =?utf-8?B?ZVFGNUdqZXdDSUc1MmU4dkRBcUZRRjYrblp2b2QwSWJZMENCZVZuTWg2SWNZ?=
 =?utf-8?B?eEtKRU5yYVp5dzZmSk9BcmFPYUl4ZDdYSlBWY1RwdHZTbTM5bEFzYzlYejJn?=
 =?utf-8?B?eU1lRE5FcndwNER2S2s0cXNGMXpQckswZ0srZzJiY2RNVWloRFNVTy8rYmRS?=
 =?utf-8?B?L09tR1lRdnJXc3ZKTDd0QWh3TmVKSnN5ZGlOZ1owTXdJTTBqR2p3a0Nsa0xB?=
 =?utf-8?B?MHFZbGVnQXBMcU1YaWRjSlc1Z3JhRjV5WGRRN00zRU9NYUUySEwvSUs3RGpR?=
 =?utf-8?B?TDc4QndhTXU1alg5d21BL0VQNmtmZFBRdDVlN0k1Nk9oclRNQ24zYmw2ckRD?=
 =?utf-8?B?NVNUR0NFd08vSk4rTkJBeXNoY3I4eWgxREdUaG1tb24wTkdnUXA1ei9BeEFp?=
 =?utf-8?B?RDR6amJTYXpsa29QeVgrYmZEcEFWcFNRaFQ5VjFtcE93cHdHL245ZjBRMmtE?=
 =?utf-8?B?NVNobUlvbkpBL05wUGxyQ3JXZmdYd3R0b1V3T0lwSXJ0WFRrWlRCU0VFaGJU?=
 =?utf-8?B?bmZ6SGlPazhCKzA0QWgxb1ljSVVqNzJiczFXVTlVaEI2b0RHdnZTQVIyN1Fu?=
 =?utf-8?B?dnU3SXYzTHFkTDBVY0Y2M1QvVXFGdUpQNVVjejl5YmJ3NlJ1M0w0ZE8yRi94?=
 =?utf-8?B?MVpxRFdKbm1ta1gzUGR0WEZva0Nnd09FT0lwRG1OcG1kaC8zN0ZiYmFwSFlZ?=
 =?utf-8?B?UFh5S25QRTcrWkxRVEdTZGlyUi9VaGVnaWxhREYwWlZKTGZta2Z0YkRDSi9z?=
 =?utf-8?B?UkhhZi9MUmNvRGRnSlFwWGxVeHQvYVJaVXlvai9oaVU4NHdMa1JKaGE0SG13?=
 =?utf-8?B?RGdHa3E2WFRoZ245bENkS2dTSFBmbmlBVExUcHZQcVFibEJkS2Vtak5zV3VZ?=
 =?utf-8?B?MUdiRmJhOEh4ZnJrRS9IOVh6RWgwOGFleUI3VTRFUzU5TzFPSmFaQWs1enhs?=
 =?utf-8?B?M0dyekpiUzdQVFRRdDFzdWJYZ0ZjaWRNVDZqVCt1TThFZnVLTm1mbldKeFZB?=
 =?utf-8?B?NXBLY3ZPZTRjTkF5YzJqMHpyOTlOK0ZCTk5FMnhqdFQxL2lMR24rZFFRRnBa?=
 =?utf-8?B?dm15bnZWaXI1Q0Z6d1ZVVW9NZC9KQ2FPekNqVGdEUTdhSDh2cVJDN3NESk1K?=
 =?utf-8?B?S0lRS1N2eEZsUEt1WE1nM1YxSU5QeVYyeC9DSUJEbTNvUjdxalV4NTVxamE3?=
 =?utf-8?B?THlyWVgvZjJiSzhjenYyYzFxOTA0VS9YcFFpc3dRY0RWY09ueVdyUUk2Z1R3?=
 =?utf-8?B?TlVjSlZFNVVTOXhKeUQ0VDlYK3MxV2N2aDNWWnNDdEU5dGZHd1ZmUFJ4QVFW?=
 =?utf-8?B?QnFiT2lhVXBzcXhLTDZjMDRnYkszOTZpdHE3WkovVVNCcFE0NG8zVklJNVlz?=
 =?utf-8?B?RFlNUlQrazBPUlVlSGxYbGNDcGVyaXk3eVVhN0M4ejhhdVlPZ3FzWW1uaWNj?=
 =?utf-8?B?WDdXbnFKNElBaEp0UXNxVVU4aXhhYytITXVHeXptRVRVSjNQVmE1TXVTVnVC?=
 =?utf-8?B?bDRwZklYQzU3T2d6c3FSSXlRa2pKRVNTd3NpS2VpSTh4TWUwTldqNU9mU2xS?=
 =?utf-8?B?b2VyMjRISzA2cFRWczNmTXk3clRUdTJOK1YwM3NFUFB1L1JmS29zd285Q0kx?=
 =?utf-8?B?QnZBQ2pVU3JlMW5WcnZraGJFUE4yQ0s1QjFKS0NlNmpmUEFQRmhqWUlFZXZF?=
 =?utf-8?B?Sm84cC9EdSs4elROWjY3R00rVzZwUWFYT1EvRTJsWW5PVVUzQjN5UEdQdWNJ?=
 =?utf-8?B?SWp3UW53bGl3K2t1cEVxaHJvbUcxZVdDc2tmVXhBd0crUk1BaWJSQm9IZkpB?=
 =?utf-8?B?MVRFMG54alY4RHMyWW9GanNPTDhoaGZwK1loekQ0OG9oeUJIRXllOXRNdTUv?=
 =?utf-8?B?RkNjK0pNQXh3VzgvSDZsbEUwZEZLY0ZwNzZKa1lUVVJUUjgxS0NCdy9YZlkv?=
 =?utf-8?B?aWQwV2RxNFpKbDE2YTVWV2RNK2FZWHpsZ0thVFhQa1hmVTh6RTI4dTBHbkNJ?=
 =?utf-8?B?dDdDclM0TjVvUlV4YUxKNTU3RnMrRnJDR0Q5cTN3Ymoxc2p1QVZ4VEZSYUNx?=
 =?utf-8?B?aW1SeStJTkZEKzJWUGppYkZOcThOYU9taGZ6NTRuQVRTNXhPQlB3b3dxenUy?=
 =?utf-8?Q?szl1nUjx7PfV/AXLl9S2yt0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9950B198535D99499D287239A6D22EC8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea41afb-9683-41d8-c2e6-08d9d9de4475
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 17:24:50.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSVUmanaEHtl7Kwk6jl/F4/L/YuAwrhLYxwWH/MkFgniuIflf9PoNA3BykfJyXoKirGI+elWHi/v7f+a3H3AfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3563
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRGF2ZSAmIEJyaWFuLA0KDQpPbiBUaHUsIDIwMjItMDEtMTMgYXQgMTI6MDEgLTA1MDAsIFRy
b25kIE15a2xlYnVzdCB3cm90ZToNCj4gDQo+IFllc3RlcmRheSBJIGZpZ3VyZWQgb3V0IGEgdGVz
dGluZyBpc3N1ZSB0aGF0IHdhcyBjYXVzaW5nIGNvbmZ1c2lvbg0KPiBhbW9uZyB0aGUgcGVvcGxl
IGRvaW5nIHRoZSBhY3R1YWwgdGVzdGluZy4gVGhleSB3ZXJlIHNlZWluZyBoYW5ncywNCj4gd2hp
Y2ggd2VyZSBub3Qgc29mdCBsb2NrdXBzLCBhbmQgd2hpY2ggdHVybmVkIG91dCB0byBiZSBhcnRp
ZmFjdHMgb2YNCj4gdGhlIHRlc3RpbmcgbWV0aG9kb2xvZ3kuDQo+IA0KPiBXaXRoIHRoaXMgcGF0
Y2gsIGl0IGFwcGVhcnMgdGhhdCB3ZSBhcmUgbm90IHJlcHJvZHVjaW5nIHRoZSBzb2Z0DQo+IGxv
Y2t1cHMuDQo+IA0KDQpXaGF0IGFyZSB0aGUgbmV4dCBzdGVwcyB5b3UgbmVlZCBmcm9tIG1lIGF0
IHRoaXMgcG9pbnQ/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
