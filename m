Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A25483ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiADDBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 22:01:40 -0500
Received: from mail-dm6nam10on2117.outbound.protection.outlook.com ([40.107.93.117]:57696
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232440AbiADDBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onm4D8e4CMTxAfIcKvpm18AR6mVWCiDqtoueqZKzf8KNdExyzly5Ym1YBHWsXx/qzrBlz8GbSEOdpl4knogNnHCTum2E+fACXoLVU1FR6dknBDChesHa5pOUMh8busqpBBNqiGGavuSUvPUhP+RA7ey6yut7MnGzGbjBtTDKB8d81kzAkrtrfePX1kVQeLII7MvchMNyf1dKYlOOu1peQLbKYBWbW0dFEBn7eDNQRHjj9mAWr5COe644CMwfO58YaiM0hzr6aDtp9qoz0PXcGnRKF2ku/ZG6PHYYbn3TC5MjEtIuDTLpv2QuRCsfn4S7vrT/NymtwOGAluaBMszWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn5nqWqMuDsUDKaPKklhqsGSao4o/03EjjXrCS1mBug=;
 b=oV+Ns3SvCdIsF9BPRMyB7FQjtC+MZ73R/wPVIirP2yLNqYY6jG3381ATYWJUX4+o+9rtYPcPEAi1cbx6aJlgVnmZvBbLyRAX5gEe6xSXQd9rjV/LlTDOLE6RZVmHm1JPzooRcgHeGk1rRFaCnfWuzAzLmVJkliKC4c/l741Wvs5O4P/RLL2FVFOhz6xSBMRgdaxN9GgUJe1CCSczWlgtsF6HnCg9sefIlNTrbLOHb1cdmrIDQk5c09X/QMMZxXQaTGiT4NLwN9djDVqaUG+2eGniHOY9xsSUS6x4Ouol+EF11dO6hVjuQnpY8VsjBKnE6CeMXbU5loXxEJdvZjGQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn5nqWqMuDsUDKaPKklhqsGSao4o/03EjjXrCS1mBug=;
 b=PPA/qCa3R2lftIKqO2zFUmhyKD2YUtic12/HZEcZS7s3bEfH8vBJ2paYppcRF/pfl71ZswIecvg1glddmvc5Bzlvk43KbaYDCtwj2ajUpgmqhOmrWriTIXxqccrDFQfhKictDfd7Otgi/Jj221Sj2y90w4gq9w74A5eUMxicPK0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR1301MB2205.namprd13.prod.outlook.com (2603:10b6:301:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.6; Tue, 4 Jan
 2022 03:01:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.006; Tue, 4 Jan 2022
 03:01:36 +0000
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
Thread-Index: AQHX/bVbnIYKv9Eyz0mlbt/BPMOEG6xL0+EAgABMs4CAAWrGAIAA5lqAgANuRQCAACHbgIAAFcSAgAAbwAA=
Date:   Tue, 4 Jan 2022 03:01:36 +0000
Message-ID: <4072d4a2990d4739b08273ec0efda9fc0c5f1d55.camel@hammerspace.com>
References: <20211230193522.55520-1-trondmy@kernel.org>
         <Yc5f/C1I+N8MPHcd@casper.infradead.org>
         <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
         <20220101035516.GE945095@dread.disaster.area>
         <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
         <20220103220310.GG945095@dread.disaster.area>
         <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
         <20220104012215.GH945095@dread.disaster.area>
In-Reply-To: <20220104012215.GH945095@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b911045-a475-43b0-8da1-08d9cf2e856b
x-ms-traffictypediagnostic: MWHPR1301MB2205:EE_
x-microsoft-antispam-prvs: <MWHPR1301MB22055038DDEEFFCE7FA7A66FB84A9@MWHPR1301MB2205.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dZ0fYYznIknFYpAJpX5XbgQH91FdW12+EuSSwretNRl9mqln0jdkiJ0ZiqPm7gpXZoZMLsBOgur08yNsRqVOpwSibnKNXTLTDzfUjM4tXh/YB+qykr5yH0iczIfiYwEjxqsscwvk9miVyuHgnwgQYisCz5zsBlZsgxfTmudgYSgIG2pPix/IEr/07qfI3iOIDtFEN8Qj2MeSr2mYUJK15X6O5XGByjfTwvTVAb6+TMrd3bnV6DlCLB7IQ/nU8ezG4R64kGWGU/A3idbuRoB1jkX8uz1hqy67005cXGhkqgwNuPQdG7MG2dkw95vCGrMilHsKXVvCBPGVfL/XyHvKwoX7f8ZdcgzjnGb1pxb13/7MMXojuXuj6e5uPK4TtLuOIFnIr+dU6vudWiljcfzHNTOQS8lFAPd3dR9yDA/xkawQqUoMNyDifmc0xJcpUrLOjP/7nNM1L69AMo2dqFEgkOqDYpFls9DoKs/iH5/s4NsMJ2uT4EhutEk2vGeSFd3GkB8FBtasre6KSx+zd6nuWpt8j30EoeP9sAk/3uc+2nBE6raSoAqIURVN9gqrElbijZ2YbOEQs8DNES6rjnH2slWCOsmsWOXxi6nwzZ70ioJox9hgmA8LF2rksXSqLLkZpJX59oJwbAwzduUJo5vzn6nsHwih3QfpzWCVjz38vITjj7JXBiUqONi36eCqo78kqSoDD4GnDY7AtS4XI6C85IvaHntlClQZHLbSY8sZjmg5/LL6i+et/r9pgK40jGP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(396003)(346002)(136003)(39830400003)(366004)(83380400001)(2906002)(508600001)(71200400001)(36756003)(66476007)(66556008)(38100700002)(54906003)(86362001)(64756008)(5660300002)(6512007)(122000001)(38070700005)(4326008)(66446008)(76116006)(8936002)(6916009)(316002)(26005)(8676002)(186003)(66946007)(6506007)(2616005)(6486002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aExwazJ2TFh4cThFVGVxNzNLRS9zMThXcmFZVFA5Z2xDbnJLTkV5M0xrRTgz?=
 =?utf-8?B?MWZxaFRQTTVvWHNIcW84T2xIUzdGMitER0tsZkxtdXo0VE1sVHc2YXJXRkZU?=
 =?utf-8?B?UGtQTUoxRzBEVnpxRE5ZYkN1aXU4Rk4xcVdWdnozMzJXV0xnWHBmWmFoZVg4?=
 =?utf-8?B?eG8wOW9NN1VjVVgwN2tSbExoNlBURWxYaHUzUWd3SXRCbkNaY0wvS2M5ZEtD?=
 =?utf-8?B?Y1BEM1JYVDU3TGdIY1ViOE15cTdOeGgxQWgyS25ha3hZVU15VW9HS2hCUWN0?=
 =?utf-8?B?RFJVWEhTMjhCV0tSTWJFMFMwRnMrT0ZSVXdJUU5hTGlUTEhDbGFIOFM2NzEy?=
 =?utf-8?B?S1UyaDJpbEVRRzZxR2QzMFc5ZE9BNHJzT2Z6R3JTc3FZZkFZRERTQk5WdEV0?=
 =?utf-8?B?SVJFYS9nZkwvR0tQcXdWUStXcmdLcXNEL3Yva2F6dVpydnJmMlJVdWtLYkQz?=
 =?utf-8?B?UzFNTjBwK3BlNFBPRFp5bko3TWkvRGJFTnZNZFBMRzNVa2JOUUllMFh4bjNm?=
 =?utf-8?B?UEw4eUpoT2FUM2FkSWVveVUwUmNjek1GTXFseXVKYVFXZDJJOWNUd2RkVmQw?=
 =?utf-8?B?RTNwVUhDd2hxQ0NsQXhoMjBHYXlQR25PS2ovd0FSR1NnaHNHTENOcGdoVkR5?=
 =?utf-8?B?aDAzNElFRFJ1ZGdvc3RDVWc2U2NqMnhhaDlNRWRkNENaNW1qeDAyc3ZGSlhL?=
 =?utf-8?B?TEtjWEhuZFFkb3dVWmtiTWNJUCtXMWZxWnVRdEprcVg2bXoxYktZY2FpdE0y?=
 =?utf-8?B?eURNNFhXa0NVWUNRQ3haajZKaE9jZ1dwaURSNDVIa0p6OVBLOVVEK0pUdXpt?=
 =?utf-8?B?QTZYWk9TSjlFUzNiQ1U4YVp2aFhlZlFwV2Fkd3F5cFBkOUpoS2Nkd2ZEclpC?=
 =?utf-8?B?OXZINkgwY0hDNjNJQ1NKUEJldktCb0Y5TmVVL0l2amRlNEt0eDd0aEJrZ1R4?=
 =?utf-8?B?YXFNMkJEdGVudDNDR2JNeG9ZZUtFOXhXeGFtN1hCd2NLcUQ2aW1zM2pLcEFE?=
 =?utf-8?B?ZFNGei9pOG5yNVJ4T0RFS0JhbEFGUVdUcW9CMnBRZ1Fnb1JzSUl6U29nN2F5?=
 =?utf-8?B?dXdHQk1ENGZjWnFJTEJCQndxVGdUbjlwR1ByVVByWXlWZ3Z3cU5ncndQamI1?=
 =?utf-8?B?cEJ6QVN6S0QwVDhuTENFV1dsWlc0L2tsMFY2UTdwSzJFL0pxQTR6c2syZGdC?=
 =?utf-8?B?ODNlUzNmVFh4TUtWYzZBeDBJNGg1TlArcCtkY3pDZHY1UmJJWVd1dEl5eG1N?=
 =?utf-8?B?RlNYZC9HTlQ5T1UvYUJMdWI2ajM1bU5CTzFCQTJKKzhkaVc3dllReitnblMz?=
 =?utf-8?B?d04rOTRHSE1Va0VaYXY5MDdKQmM2LzNiVldBV20yZ1J0V0orQUd5TGdTZTIz?=
 =?utf-8?B?SnRhK3FpUEVybms2em9YbnloNUxyRWtiejNZNU5pY2tDNW9XN0R2MWswMXpq?=
 =?utf-8?B?RGpXendma1QxWXpBUTBNWHNrdExzN0ZIeHY4VnN5RUU1WEg0RHFsNFhUem5m?=
 =?utf-8?B?b3daSS9LS1pxVHlSNEhMVTRDWDFwY1RLNUhPNFNNSlB4K0JiVlVQangrYVdT?=
 =?utf-8?B?Z3pUZStHTWViMmNRRXJVM3AwMzdGWDlVcFAzYnBYTmZFZ2VzU3VadlEyUzlH?=
 =?utf-8?B?bUtFc0lsczA3WjJLYjhYck51M2JyMHNHZkVUOUtEc0tRSnJ2WG1jblZFV09t?=
 =?utf-8?B?aEt1VTJheUpCelJuUWVUZGRoaExEQ0FQNEdaRzlwRk0za0ZJNCtDaVdGbmxo?=
 =?utf-8?B?SEdmY3ZycXNTTkFaWWdzcnNvNFgwMkVSZlF1QjJhVTBVYVRldWhyaWlFZVZQ?=
 =?utf-8?B?cVgxTUN4YTc2b3ZxNzZ3Vnd1cXVQZkJyZWtsTWRkdmVOL294Y3hhVHl0bU1m?=
 =?utf-8?B?bmVyM05NUmRUYjRNamJYQTdQWEhjMDMxdTlWbnFLUXA5TUxFZ0J4VUJDOUpK?=
 =?utf-8?B?NlQ2anR2ZnVOOWc1VVVLSmxBcDRaOElkais3Y1FPVlBVY290N3dNdXhEajBZ?=
 =?utf-8?B?Sm13UHVWZW85c1kxeVUvbDhoc3VBWEF6bnhLOThYRzdFUzNRZ0x6cmtnTzFh?=
 =?utf-8?B?ejZ1cDVXUDFSMzh4YlFYelh0ZGFCdUxsSG95WktLTDM3SlJhcjNubmcxclc5?=
 =?utf-8?B?cUxqOU9OVnBLUDA4a1RvYWJQclhJRFBKVkh2RnErbVVvSk9leG4zSExEUXg0?=
 =?utf-8?Q?I8L0N3HwXu+siXNxfWTcUI8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF50FE96F8E6D40AC183A88DBC1E787@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b911045-a475-43b0-8da1-08d9cf2e856b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 03:01:36.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPHFRVz0Vgtlv3FvzGvyMKlctxjRhXQnCSw12dzXXUm1uvMXKJZZlTjyyUhZ/IYjnE4dNDAKkvT1lmhmTAoRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2205
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDEyOjIyICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFR1ZSwgSmFuIDA0LCAyMDIyIGF0IDEyOjA0OjIzQU0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMDEtMDQgYXQgMDk6MDMgKzExMDAsIERhdmUgQ2hp
bm5lciB3cm90ZToNCj4gPiA+IE9uIFNhdCwgSmFuIDAxLCAyMDIyIGF0IDA1OjM5OjQ1UE0gKzAw
MDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gU2F0LCAyMDIyLTAxLTAxIGF0
IDE0OjU1ICsxMTAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+ID4gPiA+ID4gQXMgaXQgaXMsIGlm
IHlvdSBhcmUgZ2V0dGluZyBzb2Z0IGxvY2t1cHMgaW4gdGhpcyBsb2NhdGlvbiwNCj4gPiA+ID4g
PiB0aGF0J3MNCj4gPiA+ID4gPiBhbiBpbmRpY2F0aW9uIHRoYXQgdGhlIGlvZW5kIGNoYWluIHRo
YXQgaXMgYmVpbmcgYnVpbHQgYnkgWEZTDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiB3YXksIHdh
eSB0b28gbG9uZy4gSU9XcywgdGhlIGNvbXBsZXRpb24gbGF0ZW5jeSBwcm9ibGVtIGlzDQo+ID4g
PiA+ID4gY2F1c2VkDQo+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiBhIGxhY2sgb2Ygc3VibWl0IHNp
ZGUgaW9lbmQgY2hhaW4gbGVuZ3RoIGJvdW5kaW5nIGluDQo+ID4gPiA+ID4gY29tYmluYXRpb24N
Cj4gPiA+ID4gPiB3aXRoIHVuYm91bmQgY29tcGxldGlvbiBzaWRlIG1lcmdpbmcgaW4geGZzX2Vu
ZF9iaW8gLSBpdCdzDQo+ID4gPiA+ID4gbm90IGENCj4gPiA+ID4gPiBwcm9ibGVtIHdpdGggdGhl
IGdlbmVyaWMgaW9tYXAgY29kZS4uLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMZXQncyB0cnkg
dG8gYWRkcmVzcyB0aGlzIGluIHRoZSBYRlMgY29kZSwgcmF0aGVyIHRoYW4gaGFjaw0KPiA+ID4g
PiA+IHVubmVjZXNzYXJ5IGJhbmQtYWlkcyBvdmVyIHRoZSBwcm9ibGVtIGluIHRoZSBnZW5lcmlj
IGNvZGUuLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDaGVlcnMsDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gRGF2ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZhaXIgZW5vdWdoLiBBcyBsb25nIGFzIHNv
bWVvbmUgaXMgd29ya2luZyBvbiBhIHNvbHV0aW9uLCB0aGVuDQo+ID4gPiA+IEknbQ0KPiA+ID4g
PiBoYXBweS4gSnVzdCBhIGNvdXBsZSBvZiB0aGluZ3M6DQo+ID4gPiA+IA0KPiA+ID4gPiBGaXJz
dGx5LCB3ZSd2ZSB2ZXJpZmllZCB0aGF0IHRoZSBjb25kX3Jlc2NoZWQoKSBpbiB0aGUgYmlvIGxv
b3ANCj4gPiA+ID4gZG9lcw0KPiA+ID4gPiBzdWZmaWNlIHRvIHJlc29sdmUgdGhlIGlzc3VlIHdp
dGggWEZTLCB3aGljaCB3b3VsZCB0ZW5kIHRvDQo+ID4gPiA+IGNvbmZpcm0NCj4gPiA+ID4gd2hh
dA0KPiA+ID4gPiB5b3UncmUgc2F5aW5nIGFib3ZlIGFib3V0IHRoZSB1bmRlcmx5aW5nIGlzc3Vl
IGJlaW5nIHRoZSBpb2VuZA0KPiA+ID4gPiBjaGFpbg0KPiA+ID4gPiBsZW5ndGguDQo+ID4gPiA+
IA0KPiA+ID4gPiBTZWNvbmRseSwgbm90ZSB0aGF0IHdlJ3ZlIHRlc3RlZCB0aGlzIGlzc3VlIHdp
dGggYSB2YXJpZXR5IG9mDQo+ID4gPiA+IG9sZGVyDQo+ID4gPiA+IGtlcm5lbHMsIGluY2x1ZGlu
ZyA0LjE4LngsIDUuMS54IGFuZCA1LjE1LngsIHNvIHBsZWFzZSBiZWFyIGluDQo+ID4gPiA+IG1p
bmQNCj4gPiA+ID4gdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwgZm9yIGFueSBmaXggdG8gYmUgYmFj
a3dhcmQgcG9ydGFibGUNCj4gPiA+ID4gdGhyb3VnaA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3Rh
YmxlIG1lY2hhbmlzbS4NCj4gPiA+IA0KPiA+ID4gVGhlIGluZnJhc3RydWN0dXJlIGhhc24ndCBj
aGFuZ2VkIHRoYXQgbXVjaCwgc28gd2hhdGV2ZXIgdGhlDQo+ID4gPiByZXN1bHQNCj4gPiA+IGlz
IGl0IHNob3VsZCBiZSBiYWNrcG9ydGFibGUuDQo+ID4gPiANCj4gPiA+IEFzIGl0IGlzLCBpcyB0
aGVyZSBhIHNwZWNpZmljIHdvcmtsb2FkIHRoYXQgdHJpZ2dlcnMgdGhpcyBpc3N1ZT8NCj4gPiA+
IE9yDQo+ID4gPiBhIHNwZWNpZmljIG1hY2hpbmUgY29uZmlnIChlLmcuIGxhcmdlIG1lbW9yeSwg
c2xvdyBzdG9yYWdlKS4gQXJlDQo+ID4gPiB0aGVyZSBsYXJnZSBmcmFnbWVudGVkIGZpbGVzIGlu
IHVzZSAoZS5nLiByYW5kb21seSB3cml0dGVuIFZNDQo+ID4gPiBpbWFnZQ0KPiA+ID4gZmlsZXMp
PyBUaGVyZSBhcmUgYSBmZXcgZmFjdG9ycyB0aGF0IGNhbiBleGFjZXJiYXRlIHRoZSBpb2VuZA0K
PiA+ID4gY2hhaW4NCj4gPiA+IGxlbmd0aHMsIHNvIGl0IHdvdWxkIGJlIGhhbmR5IHRvIGhhdmUg
c29tZSBpZGVhIG9mIHdoYXQgaXMNCj4gPiA+IGFjdHVhbGx5DQo+ID4gPiB0cmlnZ2VyaW5nIHRo
aXMgYmVoYXZpb3VyLi4uDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IA0KPiA+ID4gRGF2
ZS4NCj4gPiANCj4gPiBXZSBoYXZlIGRpZmZlcmVudCByZXByb2R1Y2Vycy4gVGhlIGNvbW1vbiBm
ZWF0dXJlIGFwcGVhcnMgdG8gYmUgdGhlDQo+ID4gbmVlZCBmb3IgYSBkZWNlbnRseSBmYXN0IGJv
eCB3aXRoIGZhaXJseSBsYXJnZSBtZW1vcnkgKDEyOEdCIGluIG9uZQ0KPiA+IGNhc2UsIDQwMEdC
IGluIHRoZSBvdGhlcikuIEl0IGhhcyBiZWVuIHJlcHJvZHVjZWQgd2l0aCBIRHMsIFNTRHMNCj4g
PiBhbmQNCj4gPiBOVk1FIHN5c3RlbXMuDQo+ID4gDQo+ID4gT24gdGhlIDEyOEdCIGJveCwgd2Ug
aGFkIGl0IHNldCB1cCB3aXRoIDEwKyBkaXNrcyBpbiBhIEpCT0QNCj4gPiBjb25maWd1cmF0aW9u
IGFuZCB3ZXJlIHJ1bm5pbmcgdGhlIEFKQSBzeXN0ZW0gdGVzdHMuDQo+ID4gDQo+ID4gT24gdGhl
IDQwMEdCIGJveCwgd2Ugd2VyZSBqdXN0IHNlcmlhbGx5IGNyZWF0aW5nIGxhcmdlICg+IDZHQikN
Cj4gPiBmaWxlcw0KPiA+IHVzaW5nIGZpbyBhbmQgdGhhdCB3YXMgb2NjYXNpb25hbGx5IHRyaWdn
ZXJpbmcgdGhlIGlzc3VlLiBIb3dldmVyDQo+ID4gZG9pbmcNCj4gPiBhbiBzdHJhY2Ugb2YgdGhh
dCB3b3JrbG9hZCB0byBkaXNrIHJlcHJvZHVjZWQgdGhlIHByb2JsZW0gZmFzdGVyIDotDQo+ID4g
KS4NCj4gDQo+IE9rLCB0aGF0IG1hdGNoZXMgdXAgd2l0aCB0aGUgImxvdHMgb2YgbG9naWNhbGx5
IHNlcXVlbnRpYWwgZGlydHkNCj4gZGF0YSBvbiBhIHNpbmdsZSBpbm9kZSBpbiBjYWNoZSIgdmVj
dG9yIHRoYXQgaXMgcmVxdWlyZWQgdG8gY3JlYXRlDQo+IHJlYWxseSBsb25nIGJpbyBjaGFpbnMg
b24gaW5kaXZpZHVhbCBpb2VuZHMuDQo+IA0KPiBDYW4geW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cg
YW5kIHNlZSBpZiBhZGRyZXNzZXMgdGhlIGlzc3VlPw0KPiANCj4gQ2hlZXJzLA0KPiANCj4gRGF2
ZS4NCg0KVGhhbmtzIERhdmUhDQoNCkknbSBidWlsZGluZyBhIG5ldyBrZXJuZWwgZm9yIHRlc3Rp
bmcgbm93IGFuZCBzaG91bGQgaGF2ZSByZXN1bHRzIHJlYWR5DQp0b21vcnJvdyBhdCB0aGUgbGF0
ZXN0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
