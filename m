Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF15A4264
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiH2FjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 01:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiH2FjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:39:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2057.outbound.protection.outlook.com [40.107.113.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18D19C1B;
        Sun, 28 Aug 2022 22:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1ILFDR3ZseeZFzg8mTXSU22AFeCN2UU3trWWZr9IqqZy5k74yt6iSixHEVFqL5xl60wfiC2zw3D1KhHdFjapWzpBtoM+77jbG9K/K/qnUjfkSd8zX1bj5tg3b289DtT7yRWM1ZLNR9aQtMn+qpFfUjid7DK2HAOXuEsO1OtcGoKk5EyjsrZV9W1HiMpKR5aWAvd/n4676Ex+pc/JELwoHELF/b70zfoTK4lO5IqI/gbR8iJi0SEORZ5GOZt+t5ep/uDeXI/mzYgzg1SJVs6h+fe5dvdw36CStYn5XtGo2FVeIwdVYTq8qXhii7i/oOPM6Ga5RrirvkKZMfNXnS/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIEvvbto9GsI0M2GFgePTM5elMMiEfGg60/rxHWGkQ4=;
 b=JAPKRzt0R3Dhvi7zLaH/qn1NtS1HW2Y0S2tuI1BQatsDix3Kyx5x5OYPfQQv08yBG65s0Wypm1Ck2pzajcyOMaORWBRV+1xIMVmZdQSUvD6RhFL4PwKqQ11moGwvvK7ZmZ4ILNZi5qfdHARdHve3aGdrVTLZB4yyrFb/S96e6G3pwRAZ12/r3KnLfJMAcGtH+6o4SzxjXEZo6ZyI4cHXDoGyhvO25xNSZGYMCITaXLTtNIY2lla1RifdJuQ4EUHF/gr574fGN/z93UslpPNj1ZP/jZ7HNBDUl6gwqZ8OFZQun4Z6MgHxykqNaOR8MjtA11A3vIGUFMwrItlG436TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIEvvbto9GsI0M2GFgePTM5elMMiEfGg60/rxHWGkQ4=;
 b=RNu6NQFu7/H5m4cWhWhlv8ja+jt6IMFbw0YalUMuHyFnY2AqGYmKOhsRDo9/XpnQinq2gFOp6j1XV9ECg1Bf8Czy2cnFSEKCbUS7FvHz0ow0+rv6UtKBm6kFiGz4vOLrjViz9ZldJP6LRe7Nv2wY+DU85/XoLXZFTErNx43kHeE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3380.jpnprd01.prod.outlook.com (2603:1096:604:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 05:39:09 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 05:39:09 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm/memory-failure: Fix detection of memory_failure()
 handlers
Thread-Topic: [PATCH 3/4] mm/memory-failure: Fix detection of memory_failure()
 handlers
Thread-Index: AQHYuW/br9E2Dx6NqECCTTkq83ZuOq3FYHEA
Date:   Mon, 29 Aug 2022 05:39:09 +0000
Message-ID: <20220829053908.GA1029946@hori.linux.bs1.fc.nec.co.jp>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
 <166153428781.2758201.1990616683438224741.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166153428781.2758201.1990616683438224741.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd6fb89-837c-4a87-31e1-08da8980cbc8
x-ms-traffictypediagnostic: OSAPR01MB3380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANF4TMDi+UVx9cCsP+7P/7aSQ3228FenyJBSBd2OYuwdcG5lF+Fn5lSarW5aZb5LhBfCo1WCLeMtdN08ZJx0GbuP8NLIIBkjj/wowc/yQvvjwr1MjxZw2dOtcCjxY70bUX83gzjSlscjWJ9W7/sMyFeRHYElxMsYChkR363eqm7NYcyvd11M0UMAgcmWNcjTC76obXtPCYKAhnGSl9/3cFzJuiY/00w69L5SESPlJ31u99LBeoSeJq76tDBxkFekxkayF51XelbLqGdJg+uwchfy4RKYXU+G/PcYlJzt/sjgzsle2Vlq4q9svmZcf2e0uuAufCft1qbEwAJ6fTItb1H0+7LgQ4BvcMiKRYQ24ZQeY4PQZNBoifLbC3kqSgJ10S6Mz3Q8ZJesXHQnMQtU1g1fOWKY1Vahfa6HC4WjXaapjnd1l4mCJpsAuJ/zya1RpIPkqia4h7P6gcp7N/2A9H9uxDkPsiibmpEnRazDGJZC8UZ4jClcK/usmqJT9x5LnzVnO5e7EL6k4GTCBOklPaLeobzcg6RNZHAZWutsaidma7BIfGeN81E7Eu5wl4K/oqvkw/zRiIBnrK9m2/4p0ub79iNSZLU9tyinTFTz3llLTGTXcOxopWyzXyVVrU26WuL2IDPRyj1jS2rfIgAA52rJbrpKM+X/ya74YvtauWt+3bowhNxgzh+wbLoYuUm688Txxro5Xoca4lEMpUUCRy7b12eT5nlBaY3Sc+DHUSZpMcgMggR5KEsVQkxLe7THfON4lIK91cPK3fh1DKTsAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(66446008)(4326008)(2906002)(8676002)(64756008)(6486002)(122000001)(38100700002)(5660300002)(76116006)(8936002)(66476007)(38070700005)(316002)(86362001)(478600001)(7416002)(6916009)(33656002)(71200400001)(66556008)(6512007)(66946007)(9686003)(26005)(186003)(85182001)(1076003)(54906003)(6506007)(83380400001)(41300700001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alVZN3hiZ2hBWVRyNTBlMmxPR3phS2NFN3Iwd3lCcWZLTFNrakRiem5TYW5Q?=
 =?utf-8?B?VkFML3Z5QnBodXhnRWNPSE8wWHhBWEp1UWZBZEgyMmF5aDhFcXY4MDdHY2pO?=
 =?utf-8?B?RkRyaDVCbHlzZ1czVGVpeThQb1lGOC81TEVEdFZuN1RSVjNXcTFmYk9VaTUr?=
 =?utf-8?B?L1B2bVlycHhEZ0JBWmxvZVdpaGFNQUtTSXBiODgxMTh3cElYa3dsMDcyRjhy?=
 =?utf-8?B?T2kxRGRYUHY5VFdLWG1CRm12bGFhQm5qcUFIMjBOY3dpamV2NWFBMTZDVFMr?=
 =?utf-8?B?aTVJWUVha1grT1pmaytVNDlVMjhDbVRQenFvTWxNYStyRzk4bDM2QzBadGo1?=
 =?utf-8?B?dkdaczMyQ1M5ZzJ6cUd6QVBYbkVoa1N6b1ZDbU9qL2MvU1djL0pmT1AxcnVo?=
 =?utf-8?B?NGUzSXJnb1NDc1lBbkNjMWNjSnludDIrSEQxWjJoVHBYaS9raUpaS3RKWklk?=
 =?utf-8?B?dHFGeU96QzlPcDJUbXdGZTNlUFFGVkdrSTJBUDZhbStZeVp6dTBPYkxlSFpU?=
 =?utf-8?B?czBROVorMVdNbDRBQ2pYMEJyWkpieC9kMFlRSWJMbkVNQ3llM2ZCUjVacGFE?=
 =?utf-8?B?OU5hTzJyMUYwZFp1ZHBXNDZpa29xenB1WVRsNWxyVENLYk9zalA0bitQdnZv?=
 =?utf-8?B?d2pENS8xa0l5UXdRdENWbHNWOFNSU2FxVFVBVWpvTlEyVVBoSXpWNGlpT0wy?=
 =?utf-8?B?TXBIVk00NUNKbkFKcHBLRW1LaEQrd0ZzeUIvdW8rYXptSDZEc2FaWlRDZFVG?=
 =?utf-8?B?UHNVTEZzUTZrTk5QVWlsRm4zZzlLZWJKaDBpWmZMQ3lDVEM3UWxma3kwOFVp?=
 =?utf-8?B?c3dUZGNZUERuTTZ3d2pkbXBpUnB3L3NkcWhDb2ZSdStqUVk1MHFWN1YrNzQz?=
 =?utf-8?B?SzlOSDB0M0dwYkV2OUJQU1JRSzk3blJKSTA4dmtNa1ZLTVJxWmZSVmkyeVFO?=
 =?utf-8?B?TjFIeFB1dDdlaUhxUTFGS2gxKzRnT1pnUzNiNlVaWUtzRWxiYWNTZGpZMm94?=
 =?utf-8?B?UFdGbGJnUVZ1S2RKb2NMWG00dzgvMXc3OUttdmlMV1R5U1o0clRMMlVDWnAz?=
 =?utf-8?B?ZDUzUVZRdFd0L3RUOEJaZWVweE1ROEVmWDcrcEpIWnlidlBmTWFhQzhVK3JV?=
 =?utf-8?B?N1d2Q2E1YWJPYTc5Ykp4VGw2aUZBR2drM045OGxONERYMWkxOXJrdTJUaHV6?=
 =?utf-8?B?M3dGU0FGaVdvVU92eGtPTmRLc0hhQk94M2VFMDU1SHZxaklaWVJhUnIvTTFj?=
 =?utf-8?B?NDlSd2tBaEtxUVZ3NFlaVjRtRitGT3VHRzlWN0ozeFphaGJQaHYyNVNURnVC?=
 =?utf-8?B?MFNxTkJ3M25teEVSUnljOFVRYkNRQ2twRDZDSWc4QjVNUlVFNDhsM3Z5cSsr?=
 =?utf-8?B?UFVHMFlaOHBZbExzelh1UXBDVmVhelAvdTl6K3MzVjBPaVRjeGJQQzRNSUVB?=
 =?utf-8?B?L1RUVnBzdjlLUnRXVDJzOGQ0Z0Jna1hQV1FHZHhaQ0xITHExekV6bndPQmdM?=
 =?utf-8?B?eDdDNzZxU0w1VGFrUzZSR0ZJUCt2OE9WUXBEY05NWG9HM0dqUmt3bVNXYldD?=
 =?utf-8?B?Q21pbHJrL1hFeHIrRnV0Y2FodDB4d09YRmMrRWdrTDVFbUpBRlJ3RjZ4b3lL?=
 =?utf-8?B?aTkvc0tReEpLNFQzczMrMjY0bUR2L0ZQaWFLRVFPd0lrYm41VVZ2TmNGQ1Y0?=
 =?utf-8?B?RlV5RjFCVlRmR3JZOHZDZlVGdzZIMHJUUlRzR1dwYUlyV1BjRjN2YUROd0lC?=
 =?utf-8?B?bVJRWFNmSVdKVVoydHJYdVRXTVFJR3kyZHpodTY4SHNueHNNRFNpeGlOUUpE?=
 =?utf-8?B?eGpXaCtmUmZXQWtHNnRibUJNRlVxdjlsdTI5SFh5TDJEbnRrbWZlOWVRaFJi?=
 =?utf-8?B?S0lReW9NcklsSmFVMjFrTXJMWWdQSWYvbHJDc2wwbGE3Z1k3QXhUQm5Yd3Zm?=
 =?utf-8?B?THVqOEIyaFJrK1FhOHpDKy9QOXphVUtKWEM1VkEycHM2OWhoanY0THBnZVk5?=
 =?utf-8?B?WFg5U3JJYjF2WktpOVphY2NZbTcyeWE4NWdnNzF0bWNkaGFBa0krd0JHSEJx?=
 =?utf-8?B?SE85blZVTVFRODY2cWhJVnpFRGhwdWc2R3lNM1UzRk1TQzNMVFFuc0JlQW9Z?=
 =?utf-8?B?N1RnM051NG1YYkZtMjA5ZURPaVRlaDZpL1JlemtQanNSM0prTGN5TTdwc3Yx?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA0F13C3947B94AACB0E452BADF6907@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd6fb89-837c-4a87-31e1-08da8980cbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 05:39:09.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idaLETZ0BMhjJdcc6b8qm5K7x7+honnIh0DgkC2X1VPlzJgzA2AF/439oK0qxA9EPU/WnIGqDEKH4+yx/RpojA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIgYXQgMTA6MTg6MDdBTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBTb21lIHBhZ2VtYXAgdHlwZXMsIGxpa2UgTUVNT1JZX0RFVklDRV9HRU5FUklDIChk
ZXZpY2UtZGF4KSBkbyBub3QgZXZlbg0KPiBoYXZlIHBhZ2VtYXAgb3BzIHdoaWNoIHJlc3VsdHMg
aW4gY3Jhc2ggc2lnbmF0dXJlcyBsaWtlIHRoaXM6DQo+IA0KPiAgIEJVRzoga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAxMA0KPiAgICNQRjog
c3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiAgICNQRjogZXJyb3JfY29k
ZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiAgIFBHRCA4MDAwMDAwMjA1MDczMDY3IFA0
RCA4MDAwMDAwMjA1MDczMDY3IFBVRCAyMDYyYjMwNjcgUE1EIDANCj4gICBPb3BzOiAwMDAwIFsj
MV0gUFJFRU1QVCBTTVAgUFRJDQo+ICAgQ1BVOiAyMiBQSUQ6IDQ1MzUgQ29tbTogZGV2aWNlLWRh
eCBUYWludGVkOiBHICAgICAgICAgICBPRSAgICBOIDYuMC4wLXJjMisgIzU5DQo+ICAgSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMC4wLjAg
MDIvMDYvMjAxNQ0KPiAgIFJJUDogMDAxMDptZW1vcnlfZmFpbHVyZSsweDY2Ny8weGJhMA0KPiAg
Wy4uXQ0KPiAgIENhbGwgVHJhY2U6DQo+ICAgIDxUQVNLPg0KPiAgICA/IF9wcmludGsrMHg1OC8w
eDczDQo+ICAgIGRvX21hZHZpc2UucGFydC4wLmNvbGQrMHhhZi8weGM1DQo+IA0KPiBDaGVjayBm
b3Igb3BzIGJlZm9yZSBjaGVja2luZyBpZiB0aGUgb3BzIGhhdmUgYSBtZW1vcnlfZmFpbHVyZSgp
DQo+IGhhbmRsZXIuDQo+IA0KPiBGaXhlczogMzNhOGY3ZjJiM2EzICgicGFnZW1hcCxwbWVtOiBp
bnRyb2R1Y2UgLT5tZW1vcnlfZmFpbHVyZSgpIikNCj4gQ2M6IFNoaXlhbmcgUnVhbiA8cnVhbnN5
LmZuc3RAZnVqaXRzdS5jb20+DQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gQ2M6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+IENjOiBOYW95YSBI
b3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiBDYzogQWwgVmlybyA8dmlyb0B6
ZW5pdi5saW51eC5vcmcudWs+DQo+IENjOiBEYXZlIENoaW5uZXIgPGRhdmlkQGZyb21vcmJpdC5j
b20+DQo+IENjOiBHb2xkd3luIFJvZHJpZ3VlcyA8cmdvbGR3eW5Ac3VzZS5kZT4NCj4gQ2M6IEph
bmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPiBDYzogTWF0dGhldyBXaWxjb3ggPHdpbGx5
QGluZnJhZGVhZC5vcmc+DQo+IENjOiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4N
Cj4gQ2M6IFJpdGVzaCBIYXJqYW5pIDxyaXRlc2hoQGxpbnV4LmlibS5jb20+DQo+IENjOiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBE
YW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0KVGhhbmsgeW91IGZvciBz
ZW5kaW5nIHBhdGNoZXMsIHRoaXMgbG9va3MgZmluZSB0byBtZS4NCg0KQWNrZWQtYnk6IE5hb3lh
IEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNCj4gLS0tDQo+ICBpbmNsdWRl
L2xpbnV4L21lbXJlbWFwLmggfCAgICA1ICsrKysrDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jICAg
ICAgfCAgICAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2lu
Y2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPiBpbmRleCAxOTAxMDQ5MWE2MDMuLmMzYjRjYzg0ODc3
YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvbWVtcmVtYXAuaA0KPiBAQCAtMTM5LDYgKzEzOSwxMSBAQCBzdHJ1Y3QgZGV2X3Bh
Z2VtYXAgew0KPiAgCX07DQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgcGdtYXBf
aGFzX21lbW9yeV9mYWlsdXJlKHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXApDQo+ICt7DQo+ICsJ
cmV0dXJuIHBnbWFwLT5vcHMgJiYgcGdtYXAtPm9wcy0+bWVtb3J5X2ZhaWx1cmU7DQo+ICt9DQo+
ICsNCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHZtZW1fYWx0bWFwICpwZ21hcF9hbHRtYXAoc3Ry
dWN0IGRldl9wYWdlbWFwICpwZ21hcCkNCj4gIHsNCj4gIAlpZiAocGdtYXAtPmZsYWdzICYgUEdN
QVBfQUxUTUFQX1ZBTElEKQ0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggMTQ0Mzk4MDZiNWVmLi44YTQyOTRhZmJmYTAgMTAw
NjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1
cmUuYw0KPiBAQCAtMTkyOCw3ICsxOTI4LDcgQEAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9k
ZXZfcGFnZW1hcCh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzLA0KPiAgCSAqIENhbGwgZHJp
dmVyJ3MgaW1wbGVtZW50YXRpb24gdG8gaGFuZGxlIHRoZSBtZW1vcnkgZmFpbHVyZSwgb3RoZXJ3
aXNlDQo+ICAJICogZmFsbCBiYWNrIHRvIGdlbmVyaWMgaGFuZGxlci4NCj4gIAkgKi8NCj4gLQlp
ZiAocGdtYXAtPm9wcy0+bWVtb3J5X2ZhaWx1cmUpIHsNCj4gKwlpZiAocGdtYXBfaGFzX21lbW9y
eV9mYWlsdXJlKHBnbWFwKSkgew0KPiAgCQlyYyA9IHBnbWFwLT5vcHMtPm1lbW9yeV9mYWlsdXJl
KHBnbWFwLCBwZm4sIDEsIGZsYWdzKTsNCj4gIAkJLyoNCj4gIAkJICogRmFsbCBiYWNrIHRvIGdl
bmVyaWMgaGFuZGxlciB0b28gaWYgb3BlcmF0aW9uIGlzIG5vdA==
