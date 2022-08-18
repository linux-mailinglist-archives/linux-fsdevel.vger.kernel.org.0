Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50793597CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiHREQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 00:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHREQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:16:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2098.outbound.protection.outlook.com [40.107.95.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51B4E639;
        Wed, 17 Aug 2022 21:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYnBXbOl6iat7iudmuYmkgVwyhI1A3boeJdnpmYcaM0VEp31wdsKiXAiGzg/eySEnaCd628QpCXtH+k1aq6xW+4ja3FfGToZiRcERwy1Hqo8Nb7mxGRVtkItD71J5XKDvwkgpr5vKJMQtr8aLzApL/t7e3IJ2vI7jY9b3vwMEiKuItHuZLjunS1HW5u4Jr5sTJelRMSrrL+0i9OHS+JmfWixFpsbzNzF8jOz5FUCMnImxnDmrWp/2LI3ox0ArI9elxiQxXKSB27g8f5OPHZxYy410DRKxptlyS/GENjwPM9Jy4cWunOxJJh0/+lUXZIT+4fys8/PyO3EXboM1QG4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjxkXhOSdSKIf3bzUOU+uFkzXCLQkg1q6BJLyv618qA=;
 b=c50N9rcMRHwPFDJZAP1WBAtj6a7LK9C3lxmYSmvvZ4F3JDd0h9EtsFA+NkqHiyLx88q7erL/iU1dmYegVumHFdNRJWcMzge/xRmDnUMcMO4/K3sTdMuF8oyQA6jD06LL+ZVN3ho4ieshVPpfBp035UfWCC6ReX5Lb4Ckc78bEYmVVX9v+gue71qt3xM5W7j7u15kcpRj4KrunD7ngyt0NlImPMDVH+6z4TgWymxiUeNxy+75VLwnQjy/cTP2AF4XQJUezh0iw5rnXHot3rJ7JFIZ3ByAbEkNw597YgEsGYWRnY7GQese6S6PtgXoTmOCYUYfd/HB9eIrv6AIYKeX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjxkXhOSdSKIf3bzUOU+uFkzXCLQkg1q6BJLyv618qA=;
 b=EmOrYxDUx2eAX/eSugVwKXoGsiogXpqM5nXln5p62NzSZbvVuuNJI1KsGLNrWw2vblsZ6RK3fjjeZQWplV/+QBn5+SvTkSZf/2KchASVnqFk1pUFTRDnKhlUu4PJFLe2qb5Uate4qghlzoDr4E4E8002k2mQjK9cCiNIBCCYADE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB2236.namprd13.prod.outlook.com (2603:10b6:5:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Thu, 18 Aug
 2022 04:15:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Thu, 18 Aug 2022
 04:15:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Thread-Topic: [PATCH] xfs: fix i_version handling in xfs
Thread-Index: AQHYsXLXiDzQGb6SwE6W212lBryYZK2xqt0AgAAELwCAAHEdgIABu7uAgAAo54CAAAp6gA==
Date:   Thu, 18 Aug 2022 04:15:03 +0000
Message-ID: <0e41fb378e57794ab2a8a714b44ef92733598e8e.camel@hammerspace.com>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
         <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
         <20220816224257.GV3600936@dread.disaster.area>
         <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
         <20220818033731.GF3600936@dread.disaster.area>
In-Reply-To: <20220818033731.GF3600936@dread.disaster.area>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94486c5f-e342-46df-e345-08da80d0396f
x-ms-traffictypediagnostic: DM6PR13MB2236:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFmjl5I5ppl8vQ6E4Jh4ZPkLKIYBFIAB7HVPoyo3odVzPT76UZPxKwAx4bsNl/pUYqhrPkRJP27jKsSwBXVygN8LaKCvjnGZYSkEdbPgBcszS1+ZNKVqwR0jdLU4QutxjMswNoblKKCXNHc4BZDaAYCWZXgIYlyxCO+c6uuBcMDqdUi++XCHRQgXKevpib8PA3moYdfS7NkDLkgMwv5Kj9QIlYbJrNi0ucRfOUnRKoNPYpgKCK6RJ0/DkgFXU1tu1nyx9lN5NBVY3m9niyBlw/M3XpXCBWoygExZc9lSmIFxvjLQnkbeEY3760Y2Tj2o7iB2FbkPEshh3OabSa+kNBbC3DYNyYfmJCuG7PgjXljLlM0y+ePw2Yx7H+RtjZZtRHrPSJFh9aQnbtde4KwyNrx2pCDGi2IqxHDxD7npDETVaRr23xlo/zRryJYAgTWC9sYaI9mRJiwleamIYFBf5Ft2KWnBv9QdVE82hiV8FJg26UdNoB5KM2zAY1+AXZqXZS3xFsV0rGmt1dFje2SAdMZc4ma5WjdRrlLHS/NPtX/9iF8vj9j/E9D/FEjak2qLHR4e6QAs+j/F2iEtutyxOw3fqZU5AblaAp1zpSa0DBI6nTK2vQpm+rRAn4A8A8kW4rQWjtETBzvbXcgLTYwYb0n8HY2MSeJqh/tFyth9Mv54yFKQyEBuOCV0GNzV/9AW844I3eXM4pS0y9R+jLnxxFaxdk1jW4xbKcAn8sM9h6QgnnYIEtj+Pmp68CtVNpLuoq+9FxzaPIeZ3Nckadoz13Kbs4hmLauyTR+/T6w40jJFisRPFn0BcWqeKHKloHWh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(136003)(39840400004)(396003)(478600001)(41300700001)(316002)(71200400001)(6916009)(6486002)(54906003)(66946007)(66556008)(2906002)(5660300002)(4326008)(8676002)(64756008)(66446008)(76116006)(122000001)(66476007)(8936002)(38100700002)(36756003)(86362001)(38070700005)(6506007)(2616005)(186003)(6512007)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZQRGNpM1lsK0xCZ2ZUMllkcS9sNTdwK3FBZ2pTVGZmYjRTWEg3eHpZVE9n?=
 =?utf-8?B?a1NHY1VnbC9mK2pmcTRUWVRUenhWU05uaXBtSkdhZmNiSXNud3QwQlRFa0Iz?=
 =?utf-8?B?QmpCYkRnUTlZTzZQdkpsanJDM0x5cm1sWW8wYXFWVm5TYTdSV0srcDdBbmVr?=
 =?utf-8?B?Kzh6QkhpcVNjWG0zSCtGd0NrSDFaVlFQSEl0d2N6Vml6UHd4bDJXR1VFRTI2?=
 =?utf-8?B?U1Uvb0NJeGpMSU83QmpmS0ZveXl1b2NnNWFQMGg4Rk9JNHZMblRCOU5wNWlD?=
 =?utf-8?B?eWR6anRsYjRjaERxMHBnOG9ndlgxMzVvQ2dzYU9iY3BzWERNWFBDTW1vaXR3?=
 =?utf-8?B?ckplMFlqWG05WkZYMEF3eTZJaU9KSDlBdHEyMnk4UkxSQW9FOExEK2Z1UDUw?=
 =?utf-8?B?N3FnWit6aVFnTUs0S0gyV2Q2Z0NZWTB2VjArcHhxUkVvMkp4czUya3lIZVNh?=
 =?utf-8?B?WnZwa2pmbnlKMlBsSzF5SEZuYk5DTnBhYi81dkxxK0syRlNZZGRXWlJwakJY?=
 =?utf-8?B?a0IrWENKTmFqYndWL3VQREg1dFk4aE4rYmNHczFib2RPUzQxZkVQSmNBdDIx?=
 =?utf-8?B?MzhhWG5JQkNZbVdnZitpbm5wSHhWWXRVUG54Qm9DOXo1SkJkakpPZlM0SFcx?=
 =?utf-8?B?K2g4cFI3MC9CZFlsb1paOWV1RFZ5QzBtOVZCclJQeVVIRVA1TC9BVDYxUjJq?=
 =?utf-8?B?OFkvUzlpWEZKSm1DaFRWalFOcVlIemgrblBlQzRuMmlHcDU5bGpGNVJyaVJV?=
 =?utf-8?B?bHpNQXYrVysrdjdRNXowM1RraTgveUpOTkd0WkZyVnRiN3F2R0IyRkN0Y3RH?=
 =?utf-8?B?MzdmZnUrZGdxK1E1UVBXaEhpcHRJUng5ejJsWTRKOUNlOG0zQVgyYjE3UWdp?=
 =?utf-8?B?SkZNQzVXMnR4eE1IaUF0ZzRrekJ3bmlxZzZ6d0pkdGhQWDhPeTVGOExuVXkw?=
 =?utf-8?B?RmhhZVlDSzRmVzZYMGUyeFBmK1UzWU9odThhb1ZpWFoyV2c4VW5VSityRCtE?=
 =?utf-8?B?STF4Rmo0cmNLaVNsRVFZS3NCMjV0QnN0QUxxVjBPV1ZWU1dVZUhYU21ENE9i?=
 =?utf-8?B?RUs3bGV6dFVPalI5eFVXSGpaeXk4Y09EVnNqQ0g2cUNmZmVIanhYZjJEdWlx?=
 =?utf-8?B?STdCendmSCs1S0VLTjV0L2h6ZitqWjJvT3YwUGdsTmxqN0FKejRrSjNlUjZT?=
 =?utf-8?B?OUVKM1dMOVBKTDIrYTN1c1ExMmRZNGdTZWlRdmd2VHNjUXZPcEw5L3Q4UTZB?=
 =?utf-8?B?bVFHWm5IN2wveWFwTnRJSFlRVWh5UmJERlUzK0dNcWFFMjRaOW5aMXU1OGxh?=
 =?utf-8?B?cWFvTFJCeU0raTFPSDFJaVZ3SktsZzFYRTF2cVFmMjFCVUJmeit1UG14Mkdx?=
 =?utf-8?B?SG1WR1RuQm04RkVva2Y5MnlvdGdZSUdhY1VFOEJRWG01MXlobXgxeTNUZVEy?=
 =?utf-8?B?elRJQURxMHdKUmtybHVNYm9VOTUrSjBHQk84dHhUcGFwUi9TeDhQSXBFOWtZ?=
 =?utf-8?B?WEFva0JvK1dvNnJPVERmZzdLSTdHa2xzaStNS3Q1MUpnUnA2VWZWdENPc21B?=
 =?utf-8?B?VjZnS1AxZk5aMHc1d1dVZUsyb0ZEeGtoSDNwL0pVK1F6eTFjTWpjcEV4bFg0?=
 =?utf-8?B?Qit2dXB4bHV5WlFwK0Q4czVzQ1hYQkt5c2tVSE1iTFJ0eHphSmsxbWY0ZkZI?=
 =?utf-8?B?SGU2U05WNWhoSDZwdHdoRHYxZmQ4VlQzUWNWaXc3endVeVlkdTMwcFJDTUZF?=
 =?utf-8?B?M0lmZmNEZjZXc1FpWmp4T1RuSzNKK3ZPcFFESGlsTnhKM0JTdit3Umc2VEdm?=
 =?utf-8?B?SUdzcExHZXVFa2kxY3l1R2hrRFZSOWZXQldhRzBCekJiNXFoOHR2ZmNjNndF?=
 =?utf-8?B?bHk2SWtzRStoWmZWRkpISm5vMGxoTDR6Y3ovSlRGOVlwOUQyMEYyVk44dmYy?=
 =?utf-8?B?NHd6RVg3Ukp5MHZzcGU0RVNQWm94NVBYQ2p6MzVSZHROcHFTRGYyN0JpTmhs?=
 =?utf-8?B?K3ArS2krT2Jnb3hwU2tqTzdxREJRaTRrU1lIRHI1YkJLeFpQMXV5OEsycEdl?=
 =?utf-8?B?TUgxdCs5WG1mNVhlUU5vZmpsN2dMU1laWDZmaUlWYlpEcGR6ai8wOFlYSTNq?=
 =?utf-8?B?eDcyQVRxT2k2dlZqOWY0QU8yU3NIUnd2a0lnNi9GNzh0L05NWmM3eEgzeHIx?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DC46FC9F88D644587F4A76D97D70039@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94486c5f-e342-46df-e345-08da80d0396f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 04:15:03.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJf4t+gazwDVRW7QQu4v/0zzigKUUg6u/j9H8cNN2fEI8fRV4vuhIO2gQ562BobH4dLQJokJ2GV5M3CF+uuY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTE4IGF0IDEzOjM3ICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0IDAxOjExOjA5QU0gKzAwMDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjItMDgtMTcgYXQgMDg6NDIgKzEwMDAsIERhdmUgQ2hp
bm5lciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSW4gWEZTLCB3ZSd2ZSBkZWZpbmVkIHRoZSBvbi1k
aXNrIGlfdmVyc2lvbiBmaWVsZCB0byBtZWFuDQo+ID4gPiAiaW5jcmVtZW50cyB3aXRoIGFueSBw
ZXJzaXN0ZW50IGlub2RlIGRhdGEgb3IgbWV0YWRhdGEgY2hhbmdlIiwNCj4gPiA+IHJlZ2FyZGxl
c3Mgb2Ygd2hhdCB0aGUgaGlnaCBsZXZlbCBhcHBsaWNhdGlvbnMgdGhhdCB1c2UgaV92ZXJzaW9u
DQo+ID4gPiBtaWdodCBhY3R1YWxseSByZXF1aXJlLg0KPiA+ID4gDQo+ID4gPiBUaGF0IHNvbWUg
bmV0d29yayBmaWxlc3lzdGVtIG1pZ2h0IG9ubHkgbmVlZCBhIHN1YnNldCBvZiB0aGUNCj4gPiA+
IG1ldGFkYXRhIHRvIGJlIGNvdmVyZWQgYnkgaV92ZXJzaW9uIGlzIGxhcmdlbHkgaXJyZWxldmFu
dCAtIGlmIHdlDQo+ID4gPiBkb24ndCBjb3ZlciBldmVyeSBwZXJzaXN0ZW50IGlub2RlIG1ldGFk
YXRhIGNoYW5nZSB3aXRoDQo+ID4gPiBpX3ZlcnNpb24sDQo+ID4gPiB0aGVuIGFwcGxpY2F0aW9u
cyB0aGF0ICpuZWVkKiBzdHVmZiBsaWtlIGF0aW1lIGNoYW5nZQ0KPiA+ID4gbm90aWZpY2F0aW9u
DQo+ID4gPiBjYW4ndCBiZSBzdXBwb3J0ZWQuDQo+ID4gDQo+ID4gT0ssIEknbGwgYml0ZS4uLg0K
PiA+IA0KPiA+IFdoYXQgcmVhbCB3b3JsZCBhcHBsaWNhdGlvbiBhcmUgd2UgdGFsa2luZyBhYm91
dCBoZXJlLCBhbmQgd2h5DQo+ID4gY2FuJ3QgaXQNCj4gPiBqdXN0IHJlYWQgYm90aCB0aGUgYXRp
bWUgKyBpX3ZlcnNpb24gaWYgaXQgY2FyZXM/DQo+IA0KPiBUaGUgd2hvbGUgcG9pbnQgb2YgaV92
ZXJzaW9uIGlzIHRoYXQgdGhlIGFwbGljYXRpb24gY2FuIHNraXAgdGhlDQo+IHN0b3JhZ2UgYW5k
IGNvbXBhcmlzb24gb2YgaW5kaXZpZHVhbCBtZXRhZGF0YSBmaWVsZHMgdG8gZGV0ZXJtaW5lIGlm
DQo+IGFueXRoaWduIGNoYW5nZWQuIElmIHlvdSdyZSBnb2luZyB0byBzdG9yZSBtdWx0aXBsZSBm
aWVsZHMgYW5kDQo+IGNvbXBhcmUgdGhlbSBhbGwgaW4gYWRkaXRpb24gdG8gdGhlIGNoYW5nZSBh
dHRyaWJ1dGUsIHRoZW4gd2hhdCBpcw0KPiB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBhY3R1YWxseSBn
YWluaW5nIHlvdT8NCg0KSW5mb3JtYXRpb24gdGhhdCBpcyBub3QgY29udGFpbmVkIGluIHRoZSBm
aWVsZHMgdGhlbXNlbHZlcy4gU3VjaCBhcw0KbWV0YWRhdGEgYWJvdXQgdGhlIGZhY3QgdGhhdCB0
aGV5IHdlcmUgZXhwbGljaXRseSBjaGFuZ2VkIGJ5IGFuDQphcHBsaWNhdGlvbi4NCg0KPiANCj4g
PiBUaGUgdmFsdWUgb2YgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgbGllcyBpbiB0aGUgZmFjdCB0aGF0
IGl0IGdpdmVzDQo+ID4geW91DQo+ID4gY3RpbWUgc2VtYW50aWNzIHdpdGhvdXQgdGhlIHRpbWUg
cmVzb2x1dGlvbiBsaW1pdGF0aW9uLg0KPiA+IGkuZS4gaWYgdGhlIGNoYW5nZSBhdHRyaWJ1dGUg
aGFzIGNoYW5nZWQsIHRoZW4geW91IGtub3cgdGhhdA0KPiA+IHNvbWVvbmUNCj4gPiBoYXMgZXhw
bGljaXRseSBtb2RpZmllZCBlaXRoZXIgdGhlIGZpbGUgZGF0YSBvciB0aGUgZmlsZSBtZXRhZGF0
YQ0KPiA+ICh3aXRoDQo+ID4gdGhlIGVtcGhhc2lzIGJlaW5nIG9uIHRoZSB3b3JkICJleHBsaWNp
dGx5IikuDQo+ID4gSW1wbGljaXQgY2hhbmdlcyBzdWNoIGFzIHRoZSBtdGltZSBjaGFuZ2UgZHVl
IHRvIGEgd3JpdGUgYXJlDQo+ID4gcmVmbGVjdGVkDQo+ID4gb25seSBiZWNhdXNlIHRoZXkgYXJl
IG5lY2Vzc2FyaWx5IGFsc28gYWNjb21wYW5pZWQgYnkgYW4gZXhwbGljaXQNCj4gPiBjaGFuZ2Ug
dG8gdGhlIGRhdGEgY29udGVudHMgb2YgdGhlIGZpbGUuDQo+ID4gSW1wbGljaXQgY2hhbmdlcywg
c3VjaCBhcyB0aGUgYXRpbWUgY2hhbmdlcyBkdWUgdG8gYSByZWFkIGFyZSBub3QNCj4gPiByZWZs
ZWN0ZWQgaW4gdGhlIGNoYW5nZSBhdHRyaWJ1dGUgYmVjYXVzZSB0aGVyZSBpcyBubyBleHBsaWNp
dA0KPiA+IGNoYW5nZQ0KPiA+IGJlaW5nIG1hZGUgYnkgYW4gYXBwbGljYXRpb24uDQo+IA0KPiBU
aGF0J3MgdGhlICpORlN2NCByZXF1aXJlbWVudHMqLCBub3Qgd2hhdCBwZW9wbGUgd2VyZSBhc2tp
bmcgWEZTIHRvDQo+IHN1cHBvcnQgaW4gYSBwZXJzaXN0ZW50IGNoYW5nZSBhdHRyaWJ1dGUgMTAt
MTUgeWVhcnMgYWdvLiBXaGF0IE5GUw0KPiByZXF1aXJlZCB3YXMganVzdCBvbmUgb2YgdGhlIGlu
cHV0cyBhdCB0aGUgdGltZSwgYW5kIHdoYXQgd2UNCj4gaW1wbGVtZW50ZWQgaGFzIGtlcHQgTkZT
djQgaGFwcHkgZm9yIHRoZSBwYXN0IGRlY2FkZS4gSSd2ZSBtZW50aW9uZWQNCj4gb3RoZXIgcmVx
dWlyZW1lbnRzIGVsc2V3aGVyZSBpbiB0aGUgdGhyZWFkDQoNCk5GUyBjYW4gd29yayB3aXRoIGEg
Y2hhbmdlIGF0dHJpYnV0ZSB0aGF0IHRlbGxzIGl0IHRvIGludmFsaWRhdGUgaXRzDQpjYWNoZSBv
biBldmVyeSByZWFkLiBUaGUgb25seSBzaWRlIGVmZmVjdCB3aWxsIGJlIHRoYXQgdGhlIHBlcmZv
cm1hbmNlDQpncmFwaCB3aWxsIGFjdCBhcyBpZiB5b3Ugd2VyZSBmaWx0ZXJpbmcgaXQgdGhyb3Vn
aCBhIGNvdydzIGRpZ2VzdGl2ZQ0Kc3lzdGVtLi4uDQoNCj4gVGhlIHByb2JsZW0gd2UncmUgdGFs
a2luZyBhYm91dCBoZXJlIGlzIGVzc2VudGlhbGx5IGEgcmVsYXRpbWUNCj4gZmlsdGVyaW5nIGlz
c3VlOyBpdCdzIHRyaWdnZXJpbmcgYW4gZmlsZXN5c3RlbSB1cGRhdGUgYmVjYXVzZSB0aGUNCj4g
Zmlyc3QgYWNjZXNzIGFmdGVyIGEgbW9kaWZpY2F0aW9uIHRyaWdnZXJzIGFuIG9uLWRpc2sgYXRp
bWUgdXBkYXRlDQo+IHJhaHRlciB0aGFuIGp1c3Qgc3RvcmluZyBpdCBpbiBtZW1vcnkuDQoNCk5v
LiBJdCdzIG5vdC4uLiBZb3UgYXBwZWFyIHRvIGJlIGRpc2NhcmRpbmcgdmFsdWFibGUgaW5mb3Jt
YXRpb24gYWJvdXQNCndoeSB0aGUgYXR0cmlidXRlcyBjaGFuZ2VkLiBJJ3ZlIGJlZW4gYXNraW5n
IHlvdSBmb3IgcmVhc29ucyB3aHksIGFuZA0KeW91J3JlIGF2b2lkaW5nIHRoZSBxdWVzdGlvbi4N
Cg0KPiBUaGlzIGlzIG5vdCBhIGZpbGVzeXN0ZW0gaXNzdWUgLSB0aGUgVkZTIGNvbnRyb2xzIHdo
ZW4gdGhlIG9uLWRpc2sNCj4gdXBkYXRlcyBvY2N1ciwgYW5kIHRoYXQgd2hhdCBORlN2NCBhcHBl
YXJzIHRvIG5lZWQgY2hhbmdlZC4NCj4gSWYgTkZTIGRvZXNuJ3Qgd2FudCB0aGUgZmlsZXN5c3Rl
bSB0byBidW1wIGNoYW5nZSBjb3VudGVycyBmb3INCj4gb24tZGlzayBhdGltZSB1cGRhdGVzLCB0
aGVuIGl0IHNob3VsZCBiZSBhc2tpbmcgdGhlIFZGUyB0byBrZWVwIHRoZQ0KPiBhdGltZSB1cGRh
dGVzIGluIG1lbW9yeS4gZS5nLiB1c2UgbGF6eXRpbWUgc2VtYW50aWNzLg0KPiANCj4gVGhpcyB3
YXksIGV2ZXJ5IGZpbGVzeXN0ZW0gd2lsbCBoYXZlIHRoZSBzYW1lIGJlaGF2aW91ciwgcmVnYXJk
bGVzcw0KPiBvZiBob3cgdGhleSB0cmFjay9zdG9yZSBwZXJzaXN0ZW50IGNoYW5nZSBjb3VudCBt
ZXRhZGF0YS4NCg0KUmlnaHQgbm93LCB0aGUgaV92ZXJzaW9uIHVwZGF0ZXMgYXJlIG5vdCBleHBv
cnRlZCB2aWEgYW55IGNvbW1vbiBBUEksDQpzbyBhbnkgcGlzcyBwb29yIHBlcmZvcm1hbmNlIHNp
ZGUtZWZmZWN0cyBvZiB0aGUgaW1wbGVtZW50YXRpb24gYXJlDQpwcmV0dHkgbXVjaCBsaW1pdGVk
IHRvIHRoZSBrZXJuZWwgdXNlcnMgKE5GUyBhbmQuLi4gPz8/KQ0KDQpXaG8gZG8geW91IGV4cGVj
dCB0byB1c2UgdGhpcyBhdHRyaWJ1dGUgaWYgaXQgd2VyZSB0byBiZSBleHBvcnRlZCB2aWENCnN0
YXR4KCkgYXMgSmVmZiBpcyBwcm9wb3NpbmcsIGFuZCB3aHkgaXMgdGhlIFhGUyBiZWhhdmlvdXIg
YXBwcm9wcmlhdGU/DQpJdCBhbHJlYWR5IGRpZmZlcnMgZnJvbSB0aGUgYmVoYXZpb3VyIG9mIGJv
dGggYnRyZnMgYW5kIE5GUywgc28gdGhlDQphcmd1bWVudCB0aGF0IHRoaXMgd2lsbCBtYWdpY2Fs
bHkgY29uc29saWRhdGUgYmVoYXZpb3VyIGNhbiBiZSBpZ25vcmVkLg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
