Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CF59CDF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 03:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiHWBdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:33:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830C5FEF;
        Mon, 22 Aug 2022 18:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohg9s8kTMK3sjg7K2hngO/uYF21+gDTNrmhkPn3Zp9SLJOuekWs/mp+B0G5a/yXJMSmFHTiCpzmPxB0/9Id0/zYe2F6+42xPs9UzqRankftpDi4AqwCJ6Yjha8qnOBe9OBLMHYpvMMfvSbcY9FyotSWpnTeWnj8U1AmfrTDVxIISLicHMjlUizW6Kdf2GEMmNOHwR1OUl8U0MP4TU6eew9fGwsQqttVBujsl6K29PCLYDf3U/YiU0kA7bxPZGkgv9WL9gR2WIakXLBdaQOBFNHmIc75bVSI9ApXsswJBZpzIcmz/fHSsaOuVl3Ku65fupq4YUojReTFUmSSuWzwPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F0pebtmvEgaeo6GnodB4KT8LwMsLYGKWG8dEQ4INvA=;
 b=VKn1kdwegSpJXa6QRlQ7Ped/7EqUrdRXiRfbd7OzJosq1hrMBLHGdTLfSjBjtgmO9T5VvHzM7Vis7Uo96LN+9mSM3up+qfhRs8ZZ1anbfNFBSeXID1RJR7VqfZQAkjg7OyP7tX5DCgtJi9Rw4XdR9lzDYXeBIs21e9/2TF6PcppGxYl8r7w4ahxV6kqb/9NiZ3ZpD3GcG9mgGkiIoFzjbDnTnlkCHzkoSfi5/mhrsgdAXOOVh72DMrn7GZBL3p64WSMdBfpB8ooc0Zbd4YtL/epLMeEaEvREyjIv6BktUWvjoAjGcaycy7K+VCiUhHOq89iib8GgnhK07LU3IV9lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F0pebtmvEgaeo6GnodB4KT8LwMsLYGKWG8dEQ4INvA=;
 b=gqzOQY3sS3ok+tBO3jV9fBQfaLkQsHmNHBRMayNBJUVSMRWi1l42zHoRZqEZ+ve5lFVkTTXjntHH90VVdI1Baxqug+Cwa2A4M9IFkWVr2iCnGv8qE9n0oOMMrI2UjoUuXO9jg3ZPIiqxzE5+Bw8fzIPBPYFAzSMsEk2T6+wc4SY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3816.namprd13.prod.outlook.com (2603:10b6:610:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 01:33:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Tue, 23 Aug 2022
 01:33:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Thread-Topic: [PATCH] xfs: fix i_version handling in xfs
Thread-Index: AQHYsXLXiDzQGb6SwE6W212lBryYZK2xqt0AgAAELwCAAHEdgIABu7uAgAAo54CAAAp6gIAAcjAAgAcjngCAABipAA==
Date:   Tue, 23 Aug 2022 01:33:18 +0000
Message-ID: <ce373532fb77dd29a565ffde34a122fc83c3434a.camel@hammerspace.com>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
         <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
         <20220816224257.GV3600936@dread.disaster.area>
         <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
         <20220818033731.GF3600936@dread.disaster.area>
         <0e41fb378e57794ab2a8a714b44ef92733598e8e.camel@hammerspace.com>
         <b8cf4464cc31dc262a2d38e66265c06bf1e35751.camel@kernel.org>
         <20220823000500.GL3600936@dread.disaster.area>
In-Reply-To: <20220823000500.GL3600936@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50a68208-53ba-45ac-db7a-08da84a77531
x-ms-traffictypediagnostic: CH2PR13MB3816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqT5NRuu1X+kZbB2DFdkoeh4pMYTir746wi9bT+KJiM8f3hYYilLdxJjG3pODMWYkfuniT3SxjWpBU2CZpBxV98CKF4v6xyIIlngFpQDfljFlNdKno5PyedhLWAjeBqSUJKTOb/kmY5i0dnmpLfG/MV6ghoGmObWmC0L/7KP1SMvOwDsoba9X3+GB09e5KwITE7qEND1N48MJhn0xKP3xDPAdT8Sz8iQnmKZJxNoszJPZSyNLkXVNq1VEBiHYEywyqR6Sv2knDfc40r9LsaAP8Sgvl6leilpZvtaYiZ2AOFaFMO5j2F5nyRUUQSjXxpnzQdc/MLUwSTSr72RjI1eVfFlMIqf+Z8SglnFFJqjc7ARgkvE6KgI7bfuOUE6UC6Y3WdBhUzbgC/gEzh5u2iNuZHKxeap9cG3pSN7x87o8Jx3U8hyEOqPO5JXvzkh/VoQUjk+hmcPDT6zb03tc5VWQIm1O3fbBsTMqvOEoHWGX/KXJZmsJ3xCHJG/NlCBlKzC2Ql0UheVS2U/YKQZ0JGIt8OWGO1F5OkeuuJ+t5fUc63izYvOFtEe2FtCR2pxLXQ1T4U18JiyQOghDnqKBtcNaWwfu/uSTMo9/V9bLjux+WC68kBTtXGoVZzXjLZ1uzxCanJgafuQVmDVtAymPi0fvEWqy3jVEbIETHDk1RzIbznUXBWiOKqZPwRVuhEVIgLlrd4yGPh2WS52uoB5uFtm5JRg2No+YQ/fYKECFl4KY3QLytZ9bvB2gJvKFEOfctvvmbEqb/4CU37AyhFC7adhe4Dqckxf79fxMu7udGoG+1NdpJcBdtntgBHdm6HAakgT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39840400004)(2906002)(38100700002)(38070700005)(478600001)(6486002)(41300700001)(86362001)(186003)(110136005)(2616005)(6506007)(6512007)(26005)(83380400001)(5660300002)(71200400001)(122000001)(8936002)(4326008)(66946007)(316002)(76116006)(54906003)(66446008)(66556008)(66476007)(8676002)(36756003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEtQY3I1S1BST2o0WUVaSlk3SFRwNG5SOHFHT3daYUlPY0lYUFhpR3V3Y1Rr?=
 =?utf-8?B?WWRHYVhLdHhwdVJWZ3BZbXBxNzYwSzUwaER6MXU3dENadFZMMWplZGs2b2Ex?=
 =?utf-8?B?ZUQ3dWpNSGVudmUvVElpVmhsVzdNRXdWTlRYRnNHYnFoNGdGQ3FPNkU0WUpB?=
 =?utf-8?B?RnRQd0hKNi9IVHVpV20wS1JkY3lhQWhGYVMzUzhzQ241ekxSb0RTTWlVbi9R?=
 =?utf-8?B?UXNVMXVlbnNGK0MrMWN0M09aM2dVU2RyUWNYakpEMm44NWdkUEdha2RZd1Vq?=
 =?utf-8?B?ZVFJY2dYWmxQaG5PYVB4Z2xscEZXNTVDcEowbStkQjU1c2xGVXhVYTIyVXFH?=
 =?utf-8?B?NFlZV09UTi94TmgzYjZ1K0t0VXMxeXRqMUJNQmpJVE1Ob1N6TWxtcTUydVBU?=
 =?utf-8?B?emg4TXh6UXRWUWZsdENaRHdURHBWdk5lVjA0U1hHZnAvVGZ2ejdIdDFZaGFk?=
 =?utf-8?B?cVpLbWZ4R0pTakxFRERZL1BrMVNEeGNwYzZYK1doQ056UmxEUUVUTmtRSXJx?=
 =?utf-8?B?RmNNeERTdlRsVWpDQ3NabEpBbTFXcjQvajNDNjNhNzZTK0RHejd1cDlkQUhC?=
 =?utf-8?B?KzVHTE93WFFaUElKd2pMZkpoaGp2amowSEhZL2VIQWhqU3pycEg0VXNRS1c4?=
 =?utf-8?B?eW41NHkzUkxRbG1QVjVrUlI3NXFwaE5QejZuZVRmS1RlR0p3L2luVkJTcUJD?=
 =?utf-8?B?ME5JeWtudTgyazloMUNRUS8xTWk0UkNmZzNVaFhXNTNMZEYrQ3lodUtpcHdx?=
 =?utf-8?B?TGVsVzgxWWMrODh1cVFEK0FMdXlVSHlZUUNBYjlwUTJEWUtsRnhHa3diTW9L?=
 =?utf-8?B?T3AvdHlHSDMzdHUzTzBpUHdONHhJdnZkSnFJbWhSN0lFS3ZaLy9BRU9jczA5?=
 =?utf-8?B?OUUyaTNoU1lNUnB2WC9KL25YalFYOHVwMzZJVk0veXA3NVR6bDVHd0V5RnpC?=
 =?utf-8?B?aDE3T1FHVm9VRzhBU0sxUkszZTlLWFg3NE9tdm4wU0JWU1FEaVNvSWc4UHpr?=
 =?utf-8?B?VjZraHZTYzdXakxaSkQ3MytseGRvUlp1V09wN2dSa0pOZ0xKRFlmTTJiWk5D?=
 =?utf-8?B?UHlJK0xDeUZmR1dReG5pODNpQVh4T3cyTDQyL1BnaTg3MG93US9JNkJ3RUlW?=
 =?utf-8?B?NS9SS0Era1hOS09qZmVxZTJ1d1lOZWxwc0YvRzFTTkdpbW1kMmkwcS82b2Jr?=
 =?utf-8?B?TDgrQmJjeUNJRngrWlV6ZTh0dkZEblJVSjhBSTJuRTNrSzY4Q3BkUWJhME9C?=
 =?utf-8?B?Tmp4eEU1ZC9yOFRrRTNxdmVUcGRXZ0pPVkxWRzk5R2ZaWHJlSW4vd0hhS0Fj?=
 =?utf-8?B?Z2hvbVlIUFVnTnRROEFwM2lwaFRsbDNCMVNVaS9wYmRoRjh6aDVUZ1JYN3ZI?=
 =?utf-8?B?MXR3Wm9DRDhlaDNWNlJ2bnhTN05LZkM1eittdjR1dmFlaWIyLys0a01uUlN3?=
 =?utf-8?B?WjliUVppSktJWGtrUEhhdkdpa3o3OWIvT0tLVHdFemNWcE93OUdjWnMzbjlO?=
 =?utf-8?B?M1ZVNWRvU2huYno4ZEtVeVArWmhkT3JBZ0VZaUJNQzh3M1pOZjBIRGZvNzdM?=
 =?utf-8?B?VnJMR3QrdlVXY1lGM3RTNm8rSWFDa0YzQWl3YzNLMTV0NHQybkNOVGFOb0ND?=
 =?utf-8?B?bjhNdXFSQlJ3VDJoV2lWYnhZWHhrZWdYWnYzTm1YeFUwWnVLTHNjRW4zbmlH?=
 =?utf-8?B?ekkvZStjTTcxVTVKMGlST21OTXYzY2U2MVhjbXRvMmJMS00xbEhrbHR4amVi?=
 =?utf-8?B?R3l5dFBSTWlGaGphd3U0NmJhbmVXMTk2WDVVRklHVEp0c1B1ZWF4dkt5M24r?=
 =?utf-8?B?NWNiZll6YTNKWFpzVjBOOUJBWkdaK0ZZQldsdHJ1WlBsQWE5WFhEK05ESC9y?=
 =?utf-8?B?U1kwbHpEQVF3c0JvVGkzeTV4VjJvTzJEM1pPRDA1OUhQRFJZdWl0YzRtSDAr?=
 =?utf-8?B?OHFzeUJqdnBoY3E3ai9sd2UvdHVOT1lvVG1jSHhSR0dOMmNub1NzUnpKZzh6?=
 =?utf-8?B?RDZ5dlYzT3h4NXhwNXNFTHFhQnJuOGhJMy9XOTdWdmRxV3I1SmhsSkdvbmds?=
 =?utf-8?B?SVVQTXRsMlB2UHQwc2FSanpVaitOcldpc3RzNjVORml6TlZndVIvaGcvcXdR?=
 =?utf-8?B?Q3AxUmVVMHlScENBY1lldG5SMW5jTzhVRTdPVEhuOFBHYVhlUmtJNjNQYlNM?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6691ADBFC70249933F92C72F6843C8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a68208-53ba-45ac-db7a-08da84a77531
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:33:18.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtvFPFxCNEa8QlX+3mcT2DcHMr9mjB3aGQq/X2SNRuxmh+7cnqx6PabEK32+jwG9XJ9qmp+UZalI6BoyF6E8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTIzIGF0IDEwOjA1ICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0IDA3OjAzOjQyQU0gLTA0MDAsIEplZmYgTGF5dG9uIHdy
b3RlOg0KPiA+IERhdmUsIHlvdSBrZWVwIHRhbGtpbmcgYWJvdXQgdGhlIHhmcyBpX3ZlcnNpb24g
Y291bnRlciBhcyBpZiB0aGVyZQ0KPiA+IGFyZQ0KPiA+IG90aGVyIGFwcGxpY2F0aW9ucyBhbHJl
YWR5IHJlbHlpbmcgb24gaXRzIGJlaGF2aW9yLCBidXQgSSBkb24ndCBzZWUNCj4gPiBob3cNCj4g
PiB0aGF0IGNhbiBiZS4gVGhlcmUgaXMgbm8gd2F5IGZvciB1c2VybGFuZCBhcHBsaWNhdGlvbnMg
dG8gZmV0Y2ggdGhlDQo+ID4gY291bnRlciBjdXJyZW50bHkuDQo+IA0KPiBZb3UgbWlzcyB0aGUg
cG9pbnQgZW50aXJlbHk6IHRoZSBiZWhhdmlvdXIgaXMgZGVmaW5lZCBieSB0aGUgb24tZGlzaw0K
PiBmb3JtYXQgKHRoZSBkaV9jaGFuZ2Vjb3VudCBmaWxlZCksIG5vdCB0aGUgYXBwbGljYXRpb25z
IHRoYXQgYXJlDQo+IHVzaW5nIHRoZSBrZXJuZWwgaW50ZXJuYWwgaXZlcnNpb24gQVBJLg0KPiAN
Cj4gSnVzdCBiZWNhdXNlIHRoZXJlIGFyZSBubyBpbi1rZXJuZWwgdXNlcnMgb2YgdGhlIGRpX2No
YW5nZWNvdW50DQo+IGZpZWxkIGluIHRoZSBYRlMgaW5vZGUsIGl0IGRvZXMgbm90IG1lYW4gdGhh
dCBpdCBkb2Vzbid0IGdldCB1c2VkIGJ5DQo+IGFwcGxpY2F0aW9ucy4gRm9yZW5zaWMgYW5hbHlz
aXMgdG9vbHMgdGhhdCB3YWxrIGZpbGVzeXN0ZW0gaW1hZ2VzLg0KPiANCj4gRGlkIHlvdSBub3Qg
bm90aWNlIHRoYXQgeGZzX3RyYW5zX2xvZ19pbm9kZSgpIGZvcmNlcyBhbiBpdmVyc2lvbg0KPiB1
cGRhdGUgaWYgdGhlIGlub2RlIGNvcmUgaXMgbWFya2VkIGZvciB1cGRhdGU6DQo+IA0KPiDCoMKg
wqDCoMKgwqDCoMKgaW5vZGVfbWF5YmVfaW5jX2l2ZXJzaW9uKGlub2RlLCBmbGFncyAmIFhGU19J
TE9HX0NPUkUpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGlzPw0KPiANCj4gU28gZXZlcnkgbW9kaWZp
Y2F0aW9uIHRvIHRoZSBpbm9kZSBjb3JlICh3aGljaCBhbG1vc3QgYWxsIGlub2RlDQo+IG1vZGlm
aWNhdGlvbnMgd2lsbCBkbywgZXhjZXB0IGZvciBwdXJlIHRpbWVzdGFtcCB1cGRhdGVzKSB3aWxs
IGJ1bXANCj4gdGhlIGl2ZXJzaW9uIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCB3YXMgcXVlcmll
ZCBvciBub3QuDQo+IA0KPiBJIHVzZSB0aGlzIGluZm9ybWF0aW9uIGFsbCB0aGUgdGltZSBmb3Ig
Zm9yZW5zaWMgYW5hbHlzaXMgb2YgYnJva2VuDQo+IGZpbGVzeXN0ZW0gaW1hZ2VzLiBUaGVyZSBh
cmUgZm9yZW5zaWMgdG9vbHMgdGhhdCB1c2UgZXhwb3NlIHRoaXMNCj4gaW5mb3JtYXRpb24gZnJv
bSBmaWxlc3lzdGVtIGltYWdlcyAoZS5nLiB4ZnNfZGIpIHNvIHRoYXQgd2UgY2FuIHVzZQ0KPiBp
dCBmb3IgZm9yZW5zaWMgYW5hbHlzaXMuDQo+IA0KPiBTZWUgdGhlIHByb2JsZW0/IE9uLWRpc2sg
Zm9ybWF0IGRpX2NoYW5nZWNvdW50ICE9IE5GUyBjaGFuZ2UNCj4gYXR0cmlidXRlLiBXZSBjYW4g
aW1wbGVtZW50IHRoZSBORlMgY2hhbmdlIGF0dHJpYnV0ZSB3aXRoIHRoZQ0KPiBleGlzdGluZyBk
aV9jaGFuZ2Vjb3VudCBmaWVsZCwgYnV0IGlmIHlvdSB3YW50IHRvIGNvbnN0cmFpbiB0aGUNCj4g
ZGVmaW5pdGlvbiBvZiBob3cgdGhlIE5GUyBjaGFuZ2UgYXR0cmlidXRlIGlzIGNhbGN1bGF0ZWQs
IHdlIGNhbid0DQo+IG5lY2Vzc2FyaWx5IGltcGxlbWVudCB0aGF0IGluIGRpX2NoYW5nZWNvdW50
IHdpdGhvdXQgY2hhbmdpbmcgdGhlDQo+IG9uLWRpc2sgZm9ybWF0IGRlZmluaXRpb24uDQo+IA0K
PiBBbmQsIHllcywgdGhpcyBoYXMgaW1wbGljYXRpb25zIGZvciBpdmVyc2lvbiBiZWluZyBleHBv
c2VkIHRvDQo+IHVzZXJzcGFjZSB2aWEgc3RhdHgoKSwgYXMgSSd2ZSBtZW50aW9uZWQgaW4gcmVw
bHkgdG8gdGhlIHYyIHBhdGNoDQo+IHlvdSd2ZSBwb3N0ZWQuIGl2ZXJzaW9uIGlzIHBlcnNpc3Rl
bnQgaW5mb3JtYXRpb24gLSB5b3UgY2FuJ3QganVzdA0KPiByZWRlZmluZSBpdCdzIGJlaGF2aW91
ciB3aXRob3V0IHNvbWUgZmFpcmx5IHNlcmlvdXMga25vY2stb24NCj4gZWZmZWN0cyBmb3IgdGhl
IHN1YnN5c3RlbXMgdGhhdCBwcm92aWRlIHRoZSBwZXJzaXN0ZW50IHN0b3JhZ2UuLi4NCj4gDQoN
ClRoYXQgc3RpbGwgZG9lc24ndCBleHBsYWluIHdoeSBhIHJlZ3VsYXIgYXBwbGljYXRpb24gd291
bGQgd2FudCB0byB1c2UNCnRoYXQgZGVmaW5pdGlvbiBvZiBhIHZlcnNpb24gY291bnRlci4NCllv
dXIgdXNlIGNhc2Ugb2YgYSBmb3JlbnNpYyB0b29sIGlzIG5vdCBhIGdlbmVyaWMgdXNlIGNhc2Uu
IEl0IGlzIHZlcnkNCmxpbWl0ZWQgdG8gc29tZXRoaW5nIHdoaWNoIG5lZWRzIGFjY2VzcyB0byBk
ZXRhaWxlZCBrbm93bGVkZ2Ugb2YgdGhlDQppbnRlcm5hbHMgb2YgeW91ciB0cmFuc2FjdGlvbmFs
IGZpbGVzeXN0ZW0uIFRoaXMgaXNuJ3QgZXZlbiBzb21ldGhpbmcNCnRoYXQgbmVlZHMgdG8gYmUg
ZXhwb3NlZCB0byB0aGUgVkZTIGxheWVyIHRocm91Z2ggdGhlIGlfdmVyc2lvbiBpZiB0aGUNCnVz
ZXJzIGFyZSBhbGwgZ29pbmcgdG8gYmUgaW50ZXJuYWwgdG8gWEZTLg0KDQpXaGF0IGlzIGJlaW5n
IHJlcXVlc3RlZCB3YXMgaW5pdGlhbGx5IGRyaXZlbiAoeWVzLCBvdmVyIDIwIHllYXJzIGFnbw0K
bm93LCBhcyB5b3UndmUgcG9pbnRlZCBvdXQpIGJ5IHRoZSB1c2UgY2FzZSBvZiBjYWNoaW5nIGFw
cGxpY2F0aW9ucywgb2YNCndoaWNoIE5GUyBpcyBvbmx5IG9uZS4gVGhlcmUgYXJlIG90aGVyIGFw
cGxpY2F0aW9ucyB0aGF0IGNhbiBiZW5lZml0DQpmcm9tIGl0LiBQcmV0dHkgbXVjaCBhbnl0aGlu
ZyB0aGF0IGlzIGN1cnJlbnRseSB1c2luZyB0aGUgY3RpbWUgYW5kL29yDQptdGltZSwgd2FudHMg
YSBzdGFuZGFyZCB0aGF0IG92ZXJjb21lcyB0aGUgdGltZSByZXNvbHV0aW9uIGlzc3VlcyB0aGF0
DQppbmNyZWFzaW5nbHkgYWZmZWN0IHN0b3JhZ2UgYXMgcGVyZm9ybWFuY2UgaW1wcm92ZXMuIFRo
YXQgbWVhbnMNCmFwcGxpY2F0aW9ucyBzdWNoIGFzIGJ1aWxkIHV0aWxpdGllcywgYmFja3VwL3Jl
c3RvcmUgdXRpbGl0aWVzLCBzZWFyY2gNCnV0aWxpdGllcywgZXRjLi4uIEV2ZW4gJ2dpdCcgY291
bGQgbWFrZSB1c2Ugb2YgaXQuDQoNCkhvd2V2ZXIgbm9uZSBvZiB0aGUgYWJvdmUgYXBwbGljYXRp
b25zIG5lZWQgdGhlICdhbGwgbWV0YWRhdGENCnRyYW5zYWN0aW9ucycgZGVmaW5pdGlvbiB0aGF0
IHlvdSBhcHBlYXIgdG8gbmVlZCBmb3IgeW91ciBmb3JlbnNpY3MgdXNlDQpjYXNlLiBBbGwgd2ls
bCBzdWZmZXIgYSBwZXJmb3JtYW5jZSBsb3NzIHdpdGggc3VjaCBhIGRlZmluaXRpb24uIFdvcnN0
DQpvZiBhbGwsIHRoZSBhcHBsaWNhdGlvbiBiZWhhdmlvdXIgd291bGQgdmFyeSB3aWxkbHkgZGVw
ZW5kaW5nIG9uIHRoZQ0KY29tYmluYXRpb24gb2YgbW91bnQgb3B0aW9ucyBiZWluZyB1c2VkIChu
b2F0aW1lIHZzIG5vZGlyYXRpbWUgdnMuLi4pLg0KDQpTbyB0aGUgcG9pbnQgaXNuJ3QgYWJvdXQg
J3JlZGVmaW5pbmcgdGhlIGJlaGF2aW91ciBvZiBpX3ZlcnNpb24nLiBJdCBpcw0KYWJvdXQgZGVs
aXZlcmluZyBhIHN0YXR4KCkgQVBJIHRoYXQgbWVldHMgdGhlIHJlcXVpcmVtZW50cyBvZiBhIG51
bWJlcg0Kb2YgYXBwbGljYXRpb25zLiBJZiBYRlMgaXMgZ29pbmcgdG8gb3B0IGluIHRvIHRoYXQg
QVBJLCB0aGVuIGl0IG5lZWRzDQp0byBiZSBhYmxlIHRvIGRlbGl2ZXIgYW4gYXR0cmlidXRlIHRo
YXQgbWVldHMgdGhlIHNhbWUgcmVxdWlyZW1lbnRzLg0KT3RoZXJ3aXNlLCBpdCBjb3VsZCBjaG9v
c2UgdG8gb3B0IG91dC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
