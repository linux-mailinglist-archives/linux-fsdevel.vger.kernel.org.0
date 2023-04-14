Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C426E288A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDNQmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDNQl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:41:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2113.outbound.protection.outlook.com [40.107.212.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA2180;
        Fri, 14 Apr 2023 09:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekx8KZa3sALUEWuM9dhmfrEpOdY7LTOLsS2453bTAlG7951r4GYhIVWOvi9CIt3/gS/Ku1/5XQRpkuaJ0lQ+/DXw8EGP99e6Dhxp+w12aVYWcul91RZwHhV756sBNgOwEbii0d6Eck1Y1KAArcmyoYhbqseiBjXxP9RtNdueotR37ko+Q1bp8r386OodIPNpSrXBJddM/uJalABlxfeQOjMB8fzW1BclgEh8eTmICV6HD4WwsQHbQcYAgi6uC9fVUoiFZHaw1eiXa4b+HOzz8BcjUDklOGSeLQIDRhbFxQXvZ7rlpnxcf5aXpMVqtdCFWJ0RrKgTtHK2TQljZFUmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO6ZS2zMdB6b+V6hJ/BMUlMDkfWzAb6p8D7L1GC8byA=;
 b=fg8w/ea+8AlsWyulXXSRDQmNKBEl6y/Ydt9iwuqK+MWZtlSSne0Qy+4wIp4AbQzW5sVZhetK4UB0ar0To2ifl9xSaXEO+lsrhLkI9a3/QzY3C8vaBfB6XhrY+Z0wDpJPl3PbvG7cPe08v0/YiQ9sMMOmvYY5W3TpOs4Jv2nrU/7f7kGHl/20SYyJmXiy/ItZ+C0M408TxKOLmWaLl70/Lffz3RoHMYS5PAV5g4WmPUlx3JroQQwTTebet244ZwShBYve3M8XaTUlxZ2sdxG8YiOwUXw5gGaDyX9RmUUndc8bwyhKwdVVUfqklx88CWzwopAVolsbfQP+wbtLcptEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO6ZS2zMdB6b+V6hJ/BMUlMDkfWzAb6p8D7L1GC8byA=;
 b=Dy3SPWj+0fy81W8OrMLNYqZMCDeB2NlNh+FC0eqyK3gmWXJm4Mt74e7b/ODcngv6ZSw1ZHXcoESUICjKOS4fPCQ9tRZOPsk8mIgmJAjVIhYe2e9UlcIJDMb9cbcHjBXVE+3vZY9Klun7Wg6ZTKq3jQ6ygAknWAFnCedaeP43JjY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5981.namprd13.prod.outlook.com (2603:10b6:a03:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 16:41:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3627:d466:b0ae:1740%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 16:41:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Christian Brauner <brauner@kernel.org>,
        Jeffrey Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Thread-Topic: allowing for a completely cached umount(2) pathwalk
Thread-Index: AQHZblNqsf7f4dFF3kOaw1n+rBD0gK8p1WaAgABDqACAAHvlAIAAO+cAgAALHwCAAA6aAIAABNEAgAAHj4CAAAcggIAABToA
Date:   Fri, 14 Apr 2023 16:41:46 +0000
Message-ID: <E746F6B4-779A-4184-A2A7-5879E3D3DAEE@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
 <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
 <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
 <20230414162253.GL3390869@ZenIV>
In-Reply-To: <20230414162253.GL3390869@ZenIV>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5981:EE_
x-ms-office365-filtering-correlation-id: 70eabe8e-d490-4456-f55d-08db3d072344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYy7jwe1cIuCidw80Zd/VylelaCANRg+dfmeVLCjPlabdtLMHQBew5igbzYO43Jpvgg7ZxSht898ToRfYrnVAZwEwbD0RNeCzjqSEGzSdHyAV82AlYbaJzmPKzxuQ2o+rnnOTa90psbvbHYQ5uq7q2gUGBAnfwTXBOsbGwDWrimDwOH12rFgUtzY+D4U+E2MVH/zgelKhkQBMTLgyQ0mwEW9E5yiZNV1mka75afHWrM9986x4prgmMok0YqPPKHUfqES1b0EPaxqFCFsnAlohQ5R9Rj7w0BB2EnmK3Oxa5Dm5vZPkun7X5FKvD5mVqXOJvmRxdoaCzgwR5hg/JFbMfAFXheh7b198FiYsX9v/0asNRAjkXIsd+wJj9l8AmvQn/IGHIAVe61mjUGAB8YEcv9w6xb2gpnyFgWYKSPaHOHVcBHVgAuNYBNBMUuvT6MyYhXW6eEVZvMEsp9do0euM5UTSiIG1Gdr+nTdTxfZ4cUUjVJ8UwTxja+jw/0upRDqMIEDRHftrw6upOMB7f7sB0Qnd8r8a1UhhonQh0LyWMRboJtmAhJ50EhgMr/Pt/gXdS1WJHufl4iKKNUM2kN6I9etY7hhxnMqBBlo1JGPubQ4AQ9c499n9XV/nQKX3lg4vC1F6xUrlQUYWtLWy1KJHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39840400004)(451199021)(71200400001)(6486002)(5660300002)(66556008)(6916009)(66476007)(66946007)(36756003)(4326008)(66446008)(76116006)(64756008)(2906002)(38070700005)(86362001)(38100700002)(122000001)(41300700001)(33656002)(8676002)(316002)(8936002)(478600001)(54906003)(53546011)(6512007)(6506007)(26005)(2616005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnJwcUtGWHFmZEcwbXl2eW9BWEtiWGhwYjM4MktCUTRJK0VFOEdqYXh6eWRn?=
 =?utf-8?B?ZmVXM0Z4Z0VMMnhnQ3BneWhxaWJTU3I0RTREZ3NXY3ZJWmp1SGRjbkNqWWpX?=
 =?utf-8?B?ZytHd1dJalFJZ2kxR2JtUnhNUkJvVXA1cjFpL3NCTEdldkU2U0FzUkxHdGZV?=
 =?utf-8?B?OGVwTFpLUnNVZTJYWTE3ZzRxakpzZjlaamptNFRhOVVySHZRR3E4ZUgwTUM3?=
 =?utf-8?B?REhQZUNNRmZFRWQ2MWtFbU50MmxmSUNTTHlwQWlpT25oZXcramFEeThiZjJC?=
 =?utf-8?B?bERmYXZCVFpnOHhXMlBxV3llZkJJUmNDTEd1dWpSMFVXVXQ2eVo5bVU3YzZv?=
 =?utf-8?B?RDBuRVdIS0FZZjA3RzVEZlJ2M3RDQlRiM2JqeU1mM3dLSzI5LzhRbHZEbkwv?=
 =?utf-8?B?UHBDZWhsQVZlNm9rQkRtYm9WeWlwT05melVkWmJETkpGOEVDQUpVcGFpNWRu?=
 =?utf-8?B?OE14WGJHUDZDSlYzeW1uUkdKMURXTkMxT0huY0hzTWZOM1pVek9OeWVodXRY?=
 =?utf-8?B?NGZ5RnptMnVzYzJCdWt5UFRUSVNzQ09QdkJxRTNSeFBnWUVucGIrUDUwMDVO?=
 =?utf-8?B?YlpoYlc1Mk4vMFBiTXdoSWZudVNUdFlSb0R1N3Z3YTVZdWZTVHRiQmpZMWJ2?=
 =?utf-8?B?R1F0WlgxMHRhaitkUGJVNzZUVmJ1bUdReU1mb2dGNVdwR25tQXNjZjNXaHc1?=
 =?utf-8?B?WU5ORmV6eVMwU1FZbDZTOG5WTm5udlE3VFBsdlVlM2RXNHYzV21vZWQyQkU2?=
 =?utf-8?B?Z2FJV1hSdDQxOEpkaGZrd0pORW91dSt3R1p3VFJKRVA5bDBHYlFCQ1Q5NWJY?=
 =?utf-8?B?ZUd2YldpeXQ5Q0lQS21LTlZTR0F1Y1Y4SUhibEdsTzNzUkoxV3lsNGVlSDZO?=
 =?utf-8?B?OGtVdlhiVEhnTEJDUVozdXh0MXNHSXlWYlcyMXVPeVBJWkt5MmNhZ09aU0RU?=
 =?utf-8?B?YkFzQmhSaUJ2dDdORGZ3UUNKUWtwM1loeVVxRTk5RUJTR3k0dmdlWUpwcUVp?=
 =?utf-8?B?U3dOV1ZiMHoyV2Uxa0V3UEtzakJYelpuRlN4SUpFbUs1OE8vd1Vpd2lkRTNw?=
 =?utf-8?B?VFBwMGlwUEFQSS9mSUVKZktNMWliaEY5bjR3VEh5WFpkVC94TTl2d2xEblZj?=
 =?utf-8?B?aC9Yc1RmR2d6cDMzUTRmcTB0UGVMZys0U1RXWXlWcUhIU3NCd0V0YU5zMXNQ?=
 =?utf-8?B?QkZtVzBRNDVXYnFiS2N2R25uOVh3UXdqT2kwOThEeEdNOXBiamI5M2s4Wlpv?=
 =?utf-8?B?VWJKUXpoY2JkTThvSENjc1RRS1BxalJ4QXZIU0I5KzV1VDd4UUQrdENoL25o?=
 =?utf-8?B?aDFNaU9COEhCazBYbENFeG0vSkFqcDE5OUN5SWVuUTExcGp5LzlSdWN3Qlc3?=
 =?utf-8?B?VmVIVmR1cFg0dTBUV1F5dW84NDMzeTRpL09VWEtCU1QyejFuWFplcG5sTGhL?=
 =?utf-8?B?UTNLNXlsME5zWlZ2R09Wa1pFdEdsd1FJYzlacGtDZlhVeVExUnR2VHlqd0o0?=
 =?utf-8?B?ZFRaeFh3c1gwbmsxRzNQWEw1WUtMeU5ZcHFEWFAvb0lWQncwWFNod1FJZjEx?=
 =?utf-8?B?T1FrTFJRcUNPeEFMeW1OS21VZEswb0VhdG9PWFA4aUI5aWpBdEs4NVpPbW5Z?=
 =?utf-8?B?dzNaV3hOSWxXcS9FL0kySmZ0M1JrbmdkMFY4RG9KZjFNR05UZEUwR1lRREZI?=
 =?utf-8?B?b1gwNjNYVkxrK1hLUXgycmNhZkIzcGI0SWJ4eU1XOElBSFlXVEJZNE1xTkNO?=
 =?utf-8?B?eHVpd2ZyaTE5Uyt2ejZJdzVKcXJpSHpTaWJKWkExRHZJUWlrZE9mNW9aR1lQ?=
 =?utf-8?B?U0lsRmhnM09DelprTzJZWXIrYXhkVmpjbXhNbzZ4WEtsUHFUMGcrNVhIRWRx?=
 =?utf-8?B?TG9uR2IvZUltT1BhWml1bHVuOExmVGU0dlZhN3g0bnVkekZzcVpsU1FOTjdk?=
 =?utf-8?B?NEJFL2tPR2gwRnRMaDdKTUx5bTZ6TEo2QnpsQnlDNUlGMkprbjFtWm9mL0d1?=
 =?utf-8?B?dDZLQ0N0VU9MTmpGMlg3VXVSbnVlNU5sTFNEV0pRd0ptODNySUNubFJ2RjlT?=
 =?utf-8?B?aW05MjNlMzh0YUc5N25YVEVwdjBEempSKzYyQ0RBWWNxSkJMbnFzbXVGU2VV?=
 =?utf-8?B?bk9qOStPVXQ2R1UwMGFOVUJVbTlRVjR5a29QUDhzQ2J3VS82RCs1Q2hBUWdl?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05D0F5453F68AC4A84D9FEDFB36EC063@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eabe8e-d490-4456-f55d-08db3d072344
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 16:41:46.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO9PD//mjWPlEbVX4QgPvAt897GtBhEtvr9aytVhkdadJq/xNC2Cd1iIwZvj1SsJOHaq2q8M1O66849Hd2V3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDE0LCAyMDIzLCBhdCAxMjoyMiwgQWwgVmlybyA8dmlyb0BaZW5JVi5saW51
eC5vcmcudWs+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBBcHIgMTQsIDIwMjMgYXQgMDM6NTc6MzRQ
TSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiANCj4+PiANCj4+PiBCZWluZyBhYmxl
IHRvIGNvbnZlcnQgaW50byBhbiBPX1BBVEggZGVzY3JpcHRvciBnaXZlcyB5b3UgbW9yZSBvcHRp
b25zIHRoYW4ganVzdCB1bm1vdW50aW5nLiBJdCBzaG91bGQgYWxsb3cgeW91IHRvIHN5bmNmcygp
IGJlZm9yZSB1bm1vdW50aW5nLiBJdCBzaG91bGQgYWxsb3cgeW91IHRvIGNhbGwgb3Blbl90cmVl
KCkgc28geW91IGNhbiBtYW5pcHVsYXRlIHRoZSBmaWxlc3lzdGVtIHRoYXQgaXMgbm8gbG9uZ2Vy
IGFjY2Vzc2libGUgYnkgcGF0aCB3YWxrIChlLmcuIHNvIHlvdSBjYW4gYmluZCBpdCBlbHNld2hl
cmUgb3IgbW92ZSBpdCkuDQo+Pj4gDQo+PiANCj4+IE9uZSBtb3JlIHRoaW5nIGl0IG1pZ2h0IGFs
bG93IHVzIHRvIGRvLCB3aGljaCBJ4oCZdmUgYmVlbiB3YW50aW5nIGZvciBhIHdoaWxlIGluIE5G
UzogYWxsb3cgdXMgdG8gZmxpcCB0aGUgbW91bnQgdHlwZSBmcm9tIGJlaW5nIOKAnGhhcmTigJ0g
dG8g4oCcc29mdOKAnSBiZWZvcmUgZG9pbmcgdGhlIGxhenkgdW5tb3VudCwgc28gdGhhdCBhbnkg
YXBwbGljYXRpb24gdGhhdCBtaWdodCBzdGlsbCByZXRyeSBJL08gYWZ0ZXIgdGhlIGNhbGwgdG8g
dW1vdW50X2JlZ2luKCkgY29tcGxldGVzIHdpbGwgc3RhcnQgdGltaW5nIG91dCB3aXRoIGFuIEkv
TyBlcnJvciwgYW5kIGZyZWUgdXAgdGhlIHJlc291cmNlcyBpdCBtaWdodCBvdGhlcndpc2UgaG9s
ZCBmb3JldmVyLg0KPj4gDQo+IA0KPiBzL2xhenkvZm9yY2VkLywgc3VyZWx5PyAgQ29uZnVzZWQu
Li4NCg0KSSBtZWFuIGJvdGggY2FzZXMuIERvaW5nIGEgbGF6eSB1bW91bnQgd2l0aCBhIGhhcmQg
bW91bnRlZCBmaWxlc3lzdGVtIGlzIGEgcmlzayBzcG9ydDogaWYgdGhlIHNlcnZlciBkb2VzIGJl
Y29tZSBwZXJtYW5lbnRseSBib3JrZWQsIHlvdSBjYW4gZmlsbCB1cCB5b3VyIHBhZ2UgY2FjaGUg
d2l0aCBzdHVmZiB0aGF0IGNhbuKAmXQgYmUgZXZpY3RlZC4gTW9zdCB1c2VycyBkb27igJl0IHJl
YWxpc2UgdGhpcywgc28gdGhleSBnZXQgY29uZnVzZWQgd2hlbiBpdCBoYXBwZW5zIChwYXJ0aWN1
bGFybHkgc2luY2UgdGhlIGZpbGVzeXN0ZW0gaXMgb3V0LW9mLXNpZ2h0IGFuZCBoZW5jZSBvdXQt
b2YtbWluZCkuDQoNCj4gDQo+IE5vdGUsIEJUVywgdGhhdCBoYXJkIHZzLiBzb2Z0IGlzIGEgcHJv
cGVydHkgb2YgZnMgaW5zdGFuY2U7IGlmIHlvdSBoYXZlDQo+IGl0IHByZXNlbnQgZWxzZXdoZXJl
IGluIHRoZSBtb3VudCB0cmVlLCBmbGlwcGluZyBpdCB3b3VsZCBhZmZlY3QgYWxsDQo+IHN1Y2gg
cGxhY2VzLiAgSSBkb24ndCBzZWUgYW55IGdvb2Qgd2F5IHRvIG1ha2UgaXQgYSBwZXItbW91bnQg
dGhpbmcsIFRCSOKApg0KDQoNClRoZSBtYWluIHVzZSBjYXNlIGlzIGZvciB3aGVuIHRoZSBzZXJ2
ZXIgaXMgcGVybWFuZW50bHkgZG93biwgc28gbm9ybWFsbHkgaXQgc2hvdWxkbuKAmXQgYmUgYSBw
cm9ibGVtIHdpdGggZmxpcHBpbmcgdGhlIG1vZGUgb24gYWxsIGluc3RhbmNlcy4NCg0KVGhhdCBz
YWlkLCBpdCBtaWdodCBiZSBuaWNlIHRvIG1ha2UgaXQgcGVyLW1vdW50cG9pbnQgYXQgc29tZSB0
aW1lLiBXZSBkbyBoYXZlIHRoZSBhYmlsaXR5IHRvIGRlY2xhcmUgaW5kaXZpZHVhbCBSUEMgY2Fs
bHMgdG8gdGltZSBvdXQsIHNvIGl04oCZcyBkb2FibGUgYXQgdGhlIFJQQyBsZXZlbC4gQWxsIHdl
IHdvdWxkIHJlYWxseSBuZWVkIGlzIHRoZSBhYmlsaXR5IHRvIHN0b3JlIGEgcGVyLXZmc21vdW50
IGZsYWcuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
