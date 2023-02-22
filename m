Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6336A69FBC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 20:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBVTKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 14:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBVTKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:10:37 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2482A99E;
        Wed, 22 Feb 2023 11:10:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/H8cGZ/6HzcSGQjp1REIDfBViNYPxE3pjA13JLcFkOHjghzdeMT2GPSSzWCRcD6uGnpYhb3cNrJ8XZbxnRuuUHCKvdT1fdfcmS9uo44Mq8gtgi/tutbTEx3hslrOqvK2n3rA5nlK4Ma1G3H57fh0Ez4N5EXE5we+1/4lgiYzhzEsmz+L3k/ZpSTE3gFeWtaYz1aF9gsba4NUu3GWfjvQi14o2mtvjmHZqNq44Dn4EF4UW15hMy7yXKeRn9lET7e4Rmkp2cf9fnfs1TwLQD47XI5cbjLT7UE0mIxDzJ6BTOEiOBRp3MatYzUFLcNXMex2leH+4v9PD/vukobRHscQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU1jbb/pJ14m1Np3swUODjcdecTpQuvnCxy1nbKAnSM=;
 b=B4kl4V74PGOrYk28DKTMN+0Vty/1FrXVImys3LAk5EwwC7vLhmGh+NN9Hy919O3r8BC4hEkRIjIZ3/1JLJJR5GnusT9fPZf/xK6s64jQN0Bp3KrOTCcdRGVF4HoNkQihCmHGILQwtd19kMCKXDC/9YKRoWyO6/3grxa04fsFdZweAIDLVsM6/TDzdhJ9x0czd9tuqXLhu6WcnvleUmw96gPdNQi/c9w720/Ersl4hilAWVyvaa6efXJVeFbQzBWMNbrwvNTev9u38EEYCAczyeXOH6gYkXTPIIC/vixlwROOCDBdLCeR48mKh7me5jg23hJ4xRXSsGdGO+u2yqHH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU1jbb/pJ14m1Np3swUODjcdecTpQuvnCxy1nbKAnSM=;
 b=hl5GgdIwxTq/LUFnp8T1QtJVz1VOw4T1ZoY7uqGH5xj1xqhK4Fxt7r/ajZpn5j/xYiAsEbhcwSdNFExnSFofZvdb7HhZaCOgKSEcRRP25rRKi04gOD6A5+IQ8jocJA8aFDGjOkvUrH+0tjv/b0k5AYy7NnB1f9q7Ia2ehwvowAk=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CO1PR05MB8554.namprd05.prod.outlook.com (2603:10b6:303:ed::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 19:10:31 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%8]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 19:10:31 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Topic: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Thread-Index: AQHZNvnMjIrwR8b570Ch3VOm2txWlq7WZLkAgAGKnwCAA4VRAA==
Date:   Wed, 22 Feb 2023 19:10:31 +0000
Message-ID: <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
In-Reply-To: <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CO1PR05MB8554:EE_
x-ms-office365-filtering-correlation-id: e9cc4a92-2f02-4f49-a45f-08db15087780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVWpvg13Rai4ifmujKycuUIvWvT8Xl18Ed11c/EqdcwRy0dqUjU2mkBoYLJ3eql0ZinShM7o7IAx3/VCoSjft5kS3tNEzfUZ1UVHAZpUWUs66Nxv0ybISlCO3fQhBP+BGtP8v8YX7cqMHV4lwduYM4jyBE8bOLTLE+4fLFTS8A5fWgqU7w06LKdcqpox8mk5kcNTlkQYppLWpxvho4tx9fDXH/KmcL1njI4WJ7pdydaYgWkbAe3NMA46i8xh0wkipBiJdy20vWvYB68xJxvH6WID5rx23VrTNn/orJNLEHLPA/R+bDMdewEyYLhp7rwhx3fV+1Ls7pLNHPHqKEQFvhWC8CEvZv4MJu2PPiEsvgP0iFONUIS4arJ1qMmSfmosW9n7DjOCiu11ur1kFgVJr5fzNaC5I/4E2wSVLBUgfWDI96H8MzTXs820wgSXiAArBnLNztYIEwGkJSE1AttFmbSSS+VORc6yGYtBacQfwK+vMQu5bjEYbcKgrtBZ1+MYk/3k5oZbKiZYegPFY0+iUjM9IaTI73FlBeUon1l/S7H7o/fXowgqO9PtQvuziF8eMaKEOoFKgPhqKrSWjhqSWMot4QsEtg2Nc7Gj4AgYJST21MEEPET2yFpnE3dgFId8jAKjOJVRETh2B8Mav1WelB2+Y/Y9UfkXDp26pyPV+/ZNOqG46ZuZvxACCGlfY79HqPEoC+2NyckIOacM/rUYBHjH/RNwFhgX8XdYPgVLVaY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199018)(478600001)(71200400001)(26005)(6512007)(186003)(53546011)(2616005)(122000001)(6486002)(66946007)(316002)(83380400001)(8676002)(54906003)(4326008)(6916009)(6506007)(66476007)(64756008)(66556008)(76116006)(66446008)(41300700001)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(36756003)(86362001)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU0rL3pTa3U1M1N0dHRwalM5R0ZnY2tJRVdqTGNiUitKTXRrcHJhQ0dxWXlG?=
 =?utf-8?B?dFZNSGF0cThFQWh0MnIzSmJDVDdVODBhdVZKRUphMm10OTcwQXQ5cHU5RHJP?=
 =?utf-8?B?UUEyUlpmY1dZZ1Qxb2ROVWc5TmRUUFIyMUoydlo5d2dxc0IyRVV6RWVKU0hW?=
 =?utf-8?B?dTlBaW1wN3YvbCtjVXJ0L2RiQ2FzNklLZ2cxSXVFbEVFMFJ0Nk16UDBOVlU0?=
 =?utf-8?B?RWMxdlExMks5cGhjNjBKZUhWbVN5endHR0g3YXVDaTlBK1BtMnV1R2E1Wk0x?=
 =?utf-8?B?K25FZFN4SHBlS2NORnN1c1ZrdWpidjNpL1FIMUJsWjVIMEM0UUpPUXdIR0sr?=
 =?utf-8?B?TU0wdEhNMHZxemV6bWgrcnlSeURJU1JUaHFSM2VNbjIwcTR3SWlPTG9yTWZB?=
 =?utf-8?B?NHhMVXE4RlJTK2dKQmRJSW1MOFZSaW5Ld2NmSWpGVnVTcHFWNFZQbzlON2Zn?=
 =?utf-8?B?WmpWS0lONGdTd3B1MTBFeTkydWN6bFBPN21YTXNnSzA5djY4dUh0b3J4RmJw?=
 =?utf-8?B?VGk2cUdHRytWd0p0WmhVU1Z2L1V0ZkZFdzhmNmZLZ3pWa3pVTmNYYkZ5anNI?=
 =?utf-8?B?bkFFZFpLakVkWjhCZ1RBSGJKWHpobWMyb0svU0JHdDJ1aExQQncyUzFDOGsx?=
 =?utf-8?B?a00zWUEvUVRSMTl6VU5zS3RvcmxxeDJIcHhpa0pOWEpkNkNLRmoxTTdweCtW?=
 =?utf-8?B?MWV4QzhjNzU2VWFwa1JJMGwyRG9mK3FhcGFVUkc1UTl2Z2tsMUt4MTJxb0pp?=
 =?utf-8?B?YWJhZzQrNEZHS0FLS2lodU5CS1BtTk03dkNBZkwxSURRcGlRUHJVeW5JMit3?=
 =?utf-8?B?M1kxejMycjcwZ3FvK3M4MVFNNEZaUHdBblRKa0JRb1pkU05ERml0ZjFBNmpZ?=
 =?utf-8?B?K3BHWlNoUmN0ckJJa211aDZBWkxiWmU1ZWlFL1Q3bVA4NWo5VkpneHVNRk1n?=
 =?utf-8?B?d0dvM3g4Z004ZnRpTGRTeDB6VFU3ZXVITWJKb2hXNkZ5ZHRwUDR5Q1htOXlE?=
 =?utf-8?B?WDlldTFMVXo3ZWZPTDk5eXF1NEpMY3Q4R0dUSTI0TGw3bVBLS0tGUWY0cXM4?=
 =?utf-8?B?a0kwK0JPT1FOUEx1SGd2elFUZSszT0p4NjNEMXdZN3VaZnNsblBCYi8xWHFL?=
 =?utf-8?B?UjVJdnFUTDZtR0dQb1BFeE1JVWV6TEFJUlAzSWVxUHVnajg5bjBWZ0JNS0ky?=
 =?utf-8?B?RjQyeHRyOGl2V2R0Q1dGNjFQVFJIK01UWG5yQnhraHdqcjFUZXJvZS9UUkM2?=
 =?utf-8?B?cVA4SU4wQmNsYS81V05UUFlyazQ4ZWg2UjdDVTE2ZGdMYWVCdDhxckw2WXZH?=
 =?utf-8?B?aE9manR4c0pUWXV5SmtWcDg3NkxsVU5nWWkvSFJOMEw1czVWcUFTc1p4RkJq?=
 =?utf-8?B?VDRvOVRvN3BwNDZoUmgwZlhrY1FBd2twbUVRLytlMTVlNlBLTzNzOThBVmNX?=
 =?utf-8?B?OVBvdmdPcThqVG9WVmFvMGdxa1JIWE5iV2V5ZzFhdTlMOXdlUG0xMnVncjlT?=
 =?utf-8?B?ZXNQZ1ZuVXVuQlN0U2Rxb2N4RGdrdFJwZHcySnFTckNLUnVHTzEyN0dhQWlI?=
 =?utf-8?B?Ty92a2lFVFd0aE5ZU3BXMXV1MmMrWW8yNVBmSDZObHowWml0NDdhSUk2OUw5?=
 =?utf-8?B?SGdqNDBpK2gweitxb0hWK1lNT25KQ3FXeDVPNSt2RThFRGFrR051aEFBSzRV?=
 =?utf-8?B?SHhWZjhkTisvN1NjYXR5TWxTbGRTcDFKaVNQMmhPbzBPUWpPTW1CWG10L2lt?=
 =?utf-8?B?WXpZdnpoc2djSTEvbFRJK0VGOVdZSXBFWEFKUWk3bjVKd0k2STZ2eCtwMmJB?=
 =?utf-8?B?TXptM1YwWHAzY3EwcW1uTFh1OEpuWGpYSUlocGhYbnBnVUo3ZE5IWE51V3c2?=
 =?utf-8?B?Z1RuVks1RTZuUWZOOTV5STVyTTRndnA1ZHNnWlcvdCtsYlM0d0tDZi9wNXdj?=
 =?utf-8?B?cjhQN1J0aWwzcC9mMFlnZTRmeGxidWM2NVhtb0MwUk05UnVZMUVOamRGTWZh?=
 =?utf-8?B?WjVlMXdhNVJwN2VPa1p3MjVSSE1ydTRPRUR0SEZ2YnE0U0JqNXBhbUxvV0VI?=
 =?utf-8?B?OXI0eElaQjlIekNZckZrMGJSM0lIZS96Q0pZNTJrY2pxaHNST1VIaXJsK0lk?=
 =?utf-8?Q?/FAo/qBNdTULodlaQL2qXsEEO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72118BF55720BF409683A813DC714A14@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cc4a92-2f02-4f49-a45f-08db15087780
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 19:10:31.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MC8iZIjlBN57nAlJp9zFsV9Yc3HzapHPDB+Nyuz/s+KFEkplEGE8bhZ3cdrKzvj7YQVurADiiHc2aEHF0XjeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8554
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDIwLCAyMDIzLCBhdCA1OjI0IEFNLCBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8
dXNhbWEuYW5qdW1AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+IA0KPj4+ICtzdGF0aWMgaW5saW5l
IGludCBwYWdlbWFwX3NjYW5fcG1kX2VudHJ5KHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgc3Rh
cnQsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCBzdHJ1Y3Qg
bW1fd2FsayAqd2FsaykNCj4+PiArew0KPj4+ICsgICAgc3RydWN0IHBhZ2VtYXBfc2Nhbl9wcml2
YXRlICpwID0gd2Fsay0+cHJpdmF0ZTsNCj4+PiArICAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hID0gd2Fsay0+dm1hOw0KPj4+ICsgICAgdW5zaWduZWQgbG9uZyBhZGRyID0gZW5kOw0KPj4+
ICsgICAgc3BpbmxvY2tfdCAqcHRsOw0KPj4+ICsgICAgaW50IHJldCA9IDA7DQo+Pj4gKyAgICBw
dGVfdCAqcHRlOw0KPj4+ICsNCj4+PiArI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFH
RQ0KPj4+ICsgICAgcHRsID0gcG1kX3RyYW5zX2h1Z2VfbG9jayhwbWQsIHZtYSk7DQo+Pj4gKyAg
ICBpZiAocHRsKSB7DQo+Pj4gKyAgICAgICAgYm9vbCBwbWRfd3Q7DQo+Pj4gKw0KPj4+ICsgICAg
ICAgIHBtZF93dCA9ICFpc19wbWRfdWZmZF93cCgqcG1kKTsNCj4+PiArICAgICAgICAvKg0KPj4+
ICsgICAgICAgICAqIEJyZWFrIGh1Z2UgcGFnZSBpbnRvIHNtYWxsIHBhZ2VzIGlmIG9wZXJhdGlv
biBuZWVkcyB0byBiZQ0KPj4+IHBlcmZvcm1lZCBpcw0KPj4+ICsgICAgICAgICAqIG9uIGEgcG9y
dGlvbiBvZiB0aGUgaHVnZSBwYWdlLg0KPj4+ICsgICAgICAgICAqLw0KPj4+ICsgICAgICAgIGlm
IChwbWRfd3QgJiYgSVNfV1BfRU5HQUdFX09QKHApICYmIChlbmQgLSBzdGFydCA8IEhQQUdFX1NJ
WkUpKSB7DQo+Pj4gKyAgICAgICAgICAgIHNwaW5fdW5sb2NrKHB0bCk7DQo+Pj4gKyAgICAgICAg
ICAgIHNwbGl0X2h1Z2VfcG1kKHZtYSwgcG1kLCBzdGFydCk7DQo+Pj4gKyAgICAgICAgICAgIGdv
dG8gcHJvY2Vzc19zbWFsbGVyX3BhZ2VzOw0KPj4gSSB0aGluayB0aGF0IHN1Y2ggZ290bydzIGFy
ZSByZWFsbHkgY29uZnVzaW5nIGFuZCBzaG91bGQgYmUgYXZvaWRlZC4gQW5kDQo+PiB1c2luZyAn
ZWxzZScgKGNvdWxkIGhhdmUgZWFzaWx5IHByZXZlbnRlZCB0aGUgbmVlZCBmb3IgZ290bykuIEl0
IGlzIG5vdCB0aGUNCj4+IGJlc3Qgc29sdXRpb24gdGhvdWdoLCBzaW5jZSBJIHRoaW5rIGl0IHdv
dWxkIGhhdmUgYmVlbiBiZXR0ZXIgdG8gaW52ZXJ0IHRoZQ0KPj4gY29uZGl0aW9ucy4NCj4gWWVh
aCwgZWxzZSBjYW4gYmUgdXNlZCBoZXJlLiBCdXQgdGhlbiB3ZSdsbCBoYXZlIHRvIGFkZCBhIHRh
YiB0byBhbGwgdGhlDQo+IGNvZGUgYWZ0ZXIgYWRkaW5nIGVsc2UuIFdlIGhhdmUgYWxyZWFkeSBz
byBtYW55IHRhYnMgYW5kIHZlcnkgbGVzcyBzcGFjZSB0bw0KPiByaWdodCBjb2RlLiBOb3Qgc3Vy
ZSB3aGljaCBpcyBiZXR0ZXIuDQoNCmdvdG/igJlzIGFyZSB1c3VhbGx5IG5vdCB0aGUgcmlnaHQg
c29sdXRpb24uIFlvdSBjYW4gZXh0cmFjdCB0aGluZ3MgaW50byBhIGRpZmZlcmVudA0KZnVuY3Rp
b24gaWYgeW91IGhhdmUgdG8uDQoNCknigJltIG5vdCBzdXJlIHdoeSBJU19HRVRfT1AocCkgbWln
aHQgYmUgZmFsc2UgYW5kIHdoYXTigJlzIHRoZSBtZWFuaW5nIG9mIHRha2luZyB0aGUNCmxvY2sg
YW5kIGRyb3BwaW5nIGl0IGluIHN1Y2ggYSBjYXNlLiBJIHRoaW5rIHRoYXQgdGhlIGNvZGUgY2Fu
IGJlIHNpbXBsaWZpZWQgYW5kDQphZGRpdGlvbmFsIGNvbmRpdGlvbiBuZXN0aW5nIGNhbiBiZSBh
dm9pZGVkLg0KDQo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmgNCj4+PiArKysgYi9p
bmNsdWRlL3VhcGkvbGludXgvZnMuaA0KPj4+IEBAIC0zMDUsNCArMzA1LDU0IEBAIHR5cGVkZWYg
aW50IF9fYml0d2lzZSBfX2tlcm5lbF9yd2ZfdDsNCj4+PiAgI2RlZmluZSBSV0ZfU1VQUE9SVEVE
ICAgIChSV0ZfSElQUkkgfCBSV0ZfRFNZTkMgfCBSV0ZfU1lOQyB8IFJXRl9OT1dBSVQgfFwNCj4+
PiAgICAgICAgICAgICAgIFJXRl9BUFBFTkQpDQo+Pj4gICsvKiBQYWdlbWFwIGlvY3RsICovDQo+
Pj4gKyNkZWZpbmUgUEFHRU1BUF9TQ0FOICAgIF9JT1dSKCdmJywgMTYsIHN0cnVjdCBwYWdlbWFw
X3NjYW5fYXJnKQ0KPj4+ICsNCj4+PiArLyogQml0cyBhcmUgc2V0IGluIHRoZSBiaXRtYXAgb2Yg
dGhlIHBhZ2VfcmVnaW9uIGFuZCBtYXNrcyBpbg0KPj4+IHBhZ2VtYXBfc2Nhbl9hcmdzICovDQo+
Pj4gKyNkZWZpbmUgUEFHRV9JU19XUklUVEVOICAgICAgICAoMSA8PCAwKQ0KPj4+ICsjZGVmaW5l
IFBBR0VfSVNfRklMRSAgICAgICAgKDEgPDwgMSkNCj4+PiArI2RlZmluZSBQQUdFX0lTX1BSRVNF
TlQgICAgICAgICgxIDw8IDIpDQo+Pj4gKyNkZWZpbmUgUEFHRV9JU19TV0FQUEVEICAgICAgICAo
MSA8PCAzKQ0KPj4gDQo+PiBUaGVzZSBuYW1lcyBhcmUgd2F5IHRvbyBnZW5lcmljIGFuZCBhcmUg
bGlrZWx5IHRvIGJlIG1pc3VzZWQgZm9yIHRoZSB3cm9uZw0KPj4gcHVycG9zZS4gVGhlICJfSVNf
IiBwYXJ0IHNlZW1zIGNvbmZ1c2luZyBhcyB3ZWxsLiBTbyBJIHRoaW5rIHRoZSBuYW1pbmcNCj4+
IG5lZWRzIHRvIGJlIGZpeGVkIGFuZCBzb21lIG5ldyB0eXBlICh1c2luZyB0eXBlZGVmKSBvciBl
bnVtIHNob3VsZCBiZQ0KPj4gaW50cm9kdWNlZCB0byBob2xkIHRoZXNlIGZsYWdzLiBJIHVuZGVy
c3RhbmQgaXQgaXMgcGFydCBvZiB1YXBpIGFuZCBpdCBpcw0KPj4gbGVzcyBjb21tb24gdGhlcmUs
IGJ1dCBpdCBpcyBub3QgdW5oZWFyZCBvZiBhbmQgZG9lcyBtYWtlIHRoaW5ncyBjbGVhcmVyLg0K
PiBEbyB5b3UgdGhpbmsgUE1fU0NBTl9QQUdFX0lTXyogd29yayBoZXJlPw0KDQpDYW4gd2UgbG9z
ZSB0aGUgSVMgc29tZWhvdz8NCg0KPiANCj4+IA0KPj4gDQo+Pj4gKw0KPj4+ICsvKg0KPj4+ICsg
KiBzdHJ1Y3QgcGFnZV9yZWdpb24gLSBQYWdlIHJlZ2lvbiB3aXRoIGJpdG1hcCBmbGFncw0KPj4+
ICsgKiBAc3RhcnQ6ICAgIFN0YXJ0IG9mIHRoZSByZWdpb24NCj4+PiArICogQGxlbjogICAgTGVu
Z3RoIG9mIHRoZSByZWdpb24NCj4+PiArICogYml0bWFwOiAgICBCaXRzIHNldHMgZm9yIHRoZSBy
ZWdpb24NCj4+PiArICovDQo+Pj4gK3N0cnVjdCBwYWdlX3JlZ2lvbiB7DQo+Pj4gKyAgICBfX3U2
NCBzdGFydDsNCj4+PiArICAgIF9fdTY0IGxlbjsNCj4+IA0KPj4gSSBwcmVzdW1lIGluIGJ5dGVz
LiBXb3VsZCBiZSB1c2VmdWwgdG8gbWVudGlvbi4NCj4gTGVuZ3RoIG9mIHJlZ2lvbiBpbiBwYWdl
cy4NCg0KVmVyeSB1bmludHVpdGl2ZSB0byBtZSBJIG11c3Qgc2F5LiBJZiB0aGUgc3RhcnQgaXMg
YW4gYWRkcmVzcywgSSB3b3VsZCBleHBlY3QNCnRoZSBsZW4gdG8gYmUgaW4gYnl0ZXMuDQoNCg==
