Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC06A5E23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjB1RVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjB1RV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:21:29 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0871CF4F;
        Tue, 28 Feb 2023 09:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0GCoKQoJ+nNLmn5lv70D+QqCfI/M3CDTiLf6/f7Erxazwh4OS4JZ5D14ZP1/PnfrxFc2CqSwQntC+kcCLb0gvojCsjECA5uhI9fvME1MecQOFQEWEQNWir+LSipAsPHVZnPqqfda8igxgzPOetm7IU/C3OR6890X3jojns5y3d/I9dwlWrSocG+Y3TN5z1jiyVQT8vc29JoZYBXdlUhu/4IpSZhGXlAEh4XZH9nsjGPBohjqSp1t9+qBiGIpslo9/DoRl/J+PRSKWKgE3Is/SSRM8rc+ZdjkX73biN6sYK5y/KxZckvF5Q4jvU1qWxRJiMYNgNKNZTbXSb2ZocLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SugpBi/u+8RbtrANEaA+HziCHPMXUdOS5BzGO0Ea0Js=;
 b=Xyga5X0UnzyMmsKYv7GyE42d3ZSlpwVKkHWxEqOJbrNX+hTQk/6qFH9CZITshjdN9k3tAvYKgp/JWMfITIkSCRhpMply9o73zTyz1+g7Gok6reW4uvJVDW1uUTZOyWKKUkYfLcBBGzZ3cP6aWHS9gUeOeJxLnYCQuWbVuBUSLo07/2f7R1rI3Zg0FSHMG8yI09US+c2EGxs6Km45RLMo4NTSUwrRPTR/sPJGBG3FeQMqTljWisJCaRFgtxccKEgr3lgRjdnjKgaog1S40E5Yw5zYH4MLrsuD1V2uVlT/hayaV9uuHwiVf1/zNmr+zfW2AJtq38XOHuEnT51MD4ruOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SugpBi/u+8RbtrANEaA+HziCHPMXUdOS5BzGO0Ea0Js=;
 b=q/9MUvMqAC5cBE0DkgMKqVAu/XfUcNlqOd+e1xJApiGhj3n0TVAUyXgsZEIrIOhV5lhoYHMQHKlfjB1BKGYVf4VFdk6ezeBMNyGKylHP5pPAaBcT1bKXoEhTdoy2l+yzi9RUUqe6A80avNpwiMamFkOUaahcalGohU4cOcaRF+I=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8161.namprd05.prod.outlook.com (2603:10b6:a03:3b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 17:21:21 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%3]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:21:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
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
Thread-Index: AQHZNvnMjIrwR8b570Ch3VOm2txWlq7WZLkAgAGKnwCAA4VRAIAAyUIAgACnuwCABo50gIAAHuYAgAEZQgCAABfigA==
Date:   Tue, 28 Feb 2023 17:21:20 +0000
Message-ID: <C96B273F-31EE-4784-A614-B03DEE680462@vmware.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com> <Y/0eIUIh81jK9w2i@x1n>
 <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com> <Y/4j/Nu1vp9sVI7N@x1n>
In-Reply-To: <Y/4j/Nu1vp9sVI7N@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BY3PR05MB8161:EE_
x-ms-office365-filtering-correlation-id: fcfc068a-d414-4100-c8f7-08db19b035aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0iR4PQ4nxIdMbDkm/fi+3cjxDkkClPN3tcfAeivNhySZ4sZ8T7kIPTMbqB+ni4jhZu01X3Nq1b4rzNdjweeVUmbEzpUu/bwpOMZ2OS3zGD/PQ/wPjquth011zBwvWH8buYmAGNth6NqcjJ+sCw1grQe2+LaVvT0TKTsJDM5IiSqnPlQCTVaqO5fnfubMDlU3iWD7vSBi7/L965F7PlkxeLjLoY5RUty+id8bhK95zj1KpTGtIJGHWIaLM+3z4Adf6JLMHJkuW9mBLnC8ItHYXUm+xfrKSSl3md4f9UDDV1tilAhB3z6FBYM1RBaFijr4AYTRnMuUNlz3o/G2xtwUjKuc5yMPyEBlNQAnJ6QUi0FJ1U7HVOuf4EUUnW4Ge6gTV6YBEfFCvgr2Iom7mKXaYFXWMcctxLw9yPvegqMJzD13O1m4qfyb3oKSqEtiK5HXh+HZyTSlcsPOZrqHf1BgoRpOMc3vUJtyf1Mvye8oTliqXVMy0E9wROgso+0Ol2f7u57m6gNMf//HmYn8eQ8BzxejplAziSq+N2oHNpaHTPjEZbMUR2NAnaBEeGApLslffeWaiMYSGG1LFc593+nQhWRHZIWeKM1a97HxdE9iefP2oG3wHwnI5/0nMlTEbsSJJ2cGaQi794SAGH4GUkraaFm+EjCnLQF/UswhGSfLz1ySCZVsJPMCQqY5W4HvYAnlTKJOJCyw1qn2MdC1DlPCQ6DpcwAERhjQ5HUu6JCOq9pB9x3mYpHiespgM3AAwtmfFUAoZMsf/0vpffx7TichoF9oA+uXgbxEzYMjpB3xWGBeZPNzCstDnbZFPWDJSwq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199018)(38070700005)(2616005)(86362001)(66556008)(316002)(66476007)(6486002)(66446008)(6506007)(6916009)(76116006)(36756003)(33656002)(8676002)(71200400001)(54906003)(478600001)(64756008)(41300700001)(66946007)(186003)(4326008)(6512007)(53546011)(2906002)(122000001)(26005)(38100700002)(8936002)(66899018)(83380400001)(7416002)(7406005)(5660300002)(69594002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nms2M3RNaXBkSllxcGlDcDhxUnYvS3RSSWUrdzhsZHBJeUdkVjEwNjM4RzJW?=
 =?utf-8?B?OU5jWWw4RWQyMm9FbWlwRUIzQW4rbDRVcDRYSmJJL3JYd2psb201NmRuU25P?=
 =?utf-8?B?MnZJYlNqeWJXRzA1b29FT2VNNCtpR2xGRjByMlg0cnMrWVhEbFhiLzUrS3BN?=
 =?utf-8?B?TUNtS2dYeUtxc3VPbWJZUkhMRWtWNHlvc240eXZHRWFhV05LaFBFL1RkbjE5?=
 =?utf-8?B?bjhRL0Nva1JSL2E5OXc1WHdlWFJqREwxbGRSZGhaMkVnQ1N5RGdSSG50UzU2?=
 =?utf-8?B?c3pzZ1VRdXFyeFNCV3FCZ1lMcVNzSzF3OU9VTVZEWlBsU01ROXcyMjFYR2hK?=
 =?utf-8?B?a0U5Yk9aWjgyK0FTNktJOGxubjJQaEFHV2V0b3lSNVd2WTFTL3VMTmg4RjJ2?=
 =?utf-8?B?Nys2YVdLZldNdWNQVElKVVNCRTBIb2pqTk1oYTJpU1dHdHREVC9jWVVHdzRn?=
 =?utf-8?B?S3ZEWlRjTEVPd0pqTVBvNGwvblFYbDUwSHM3VGxvcG9xZDI2emxnWFd1ell1?=
 =?utf-8?B?MjNMNFFUTEI3RHRSNnpwZVNxb0J6WEl3UjlFcU1tS3ZvZ3ZaNHhmSE9HN25B?=
 =?utf-8?B?TnRoa09qcEhYaGJXMXQ4dUU1Zy9kWFQyTEtuMWxFSjRrV3NvVGlaWGhOWkl5?=
 =?utf-8?B?WTg2OXZpYUIxTmFadmZpVHpiRjFNZzg1NXdNZkhoSnc5clBrLzl5UVpPUm5V?=
 =?utf-8?B?c0FiUDYvYTNoazVTWk1sT0hHbEpNeFBxa0Ntb3k4Y3MrTlFsL3Bhc1pMYTQr?=
 =?utf-8?B?aWVtZG1VUGJCUzhnaWJrcU5jQlR6dlJwMmx3NmkwdGpzc3hrbyszVGZCUTdu?=
 =?utf-8?B?MU81VVBsT1M3eTZUUk1NcFZrKysrWW1JK0k2YXRWS3FRbHZ5bEdvY2taOXhS?=
 =?utf-8?B?dFNhVms1Vkd4bTBGTDRwNWNpL01zS1hZSTlmQUlIVDRTeU9ibHF1VVlBM1Rq?=
 =?utf-8?B?dEdZVjB2cFg5SjhXS0FXTFU3T2EvNElJVno3Y1piWDhyRVE2V0E5UTBpakNL?=
 =?utf-8?B?WDc4MzJqcFFwOGEvQmFyZ25wVUZWMUhnTStXNnJkM0dueWRTWTJNc01VTDN2?=
 =?utf-8?B?QzhPMUpkMEQ5WXBVaXQ1YlB6dVFXd3F6cE1JRnJYU2k0VkFhM2Z0RzFYYlJE?=
 =?utf-8?B?N3NpeFJERktpcEpBSE52Wk1WaWloL1paWmhTcWtkS2I4TXFDTDV0eU5oTEFJ?=
 =?utf-8?B?YTdaUithTmxTbm0yUGxTN3ZuWDg3UkJKVWdaQ3U1eEdIRUNjTjJQV1didzc2?=
 =?utf-8?B?WkkyQkNsQlNCTmhkTXdJQW5rUFRKYmxDQ0l2WkJyenYwMEExUWZLcUZ0MHZo?=
 =?utf-8?B?OUF5bk5PaEZaU3VndVMrTko2c0FQcEE2SHJRUE1ick1UZ0RsZHlJTGloSEJU?=
 =?utf-8?B?aUpMdzFnV3FjdFlKZ0FyeUhzOFhQMnpXdjJkZmkyeTNxaFlpOWdSNWpMYzlo?=
 =?utf-8?B?cUI0R0lLTUYvbUpuOGJxeVhYeUM0Qk9YdHVqR2ZxanhyRGxLRklQVnVXQWk2?=
 =?utf-8?B?Z2FkVmJ3elFFdWpENHZLQkF2YTJ0YWRBT2ozZDg4akhsMm5DcEMrL0FuYzhi?=
 =?utf-8?B?T3E0VG96eFQ2T3F3RTRWRGw5NVRJNDhwNVExYWtwMVJ2MEZFck9PODR0RXdR?=
 =?utf-8?B?QVEyUWVHenh3YXdwSFU4ODFvVm9mKzgyR0NHUm5xNWwrRjdFeGlLVzZmQ1d0?=
 =?utf-8?B?MDNUVFR0enpOakJDL0xuUENCYWNmQVlMYkx2T0lqTTB6bUx3NDZhTHJ0TDVW?=
 =?utf-8?B?SHBHUHZoN2hyU1kzOGgyektJclRiWE84WUFYdEFzUTJmeHNVMTI0NUV4Y2JF?=
 =?utf-8?B?bUhxZmtOL0ttWHZmODZRVDBrMnFZQWVKRUJBOUlnNHR3VmNSTUxsSmV0WWQ1?=
 =?utf-8?B?ampBbkx5UkIrR2svNml3TnU1dG1oRWFvdEMweVlkWjBzdWt2d0xHeXovRUww?=
 =?utf-8?B?SDRCTVBEL0JFQWpDeGlTUHoybXU4WEQ4RldpTHYvTVhrYUQzMGY2VHVlYlNy?=
 =?utf-8?B?eHk5ekJaMkVXd200SUtUSUgzNkhnc0I1WHVtNzdEQWR2TE5NWkJiaW1Kempj?=
 =?utf-8?B?N1pxL2crRHRadGV6L3RmeXhWMHRIc2wwam9CTFRoaTcyaHdSNGhUYVBZM3Na?=
 =?utf-8?Q?SyVweYCeD2S3a+PfOixTcc14q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D796B478668F48AF1E30588AB97CBE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc068a-d414-4100-c8f7-08db19b035aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 17:21:20.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVs+X0toWScSM4KpJLm1QP+G8b/DRDfmvGmwKxMQuBI1/wRbkQhcAxQ/IZpbygFTBRQi/UzMQRT/R9g7EZVpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDI4LCAyMDIzLCBhdCA3OjU1IEFNLCBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhh
dC5jb20+IHdyb3RlOg0KPiANCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIE1vbiwgRmVi
IDI3LCAyMDIzIGF0IDExOjA5OjEyUE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiANCj4+
IA0KPj4+IE9uIEZlYiAyNywgMjAyMywgYXQgMToxOCBQTSwgUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiAhISBFeHRlcm5hbCBFbWFpbA0KPj4+IA0KPj4+IE9u
IFRodSwgRmViIDIzLCAyMDIzIGF0IDA1OjExOjExUE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6
DQo+Pj4+IEZyb20gbXkgZXhwZXJpZW5jZSB3aXRoIFVGRkQsIHByb3BlciBvcmRlcmluZyBvZiBl
dmVudHMgIGlzIGNydWNpYWwsIGFsdGhvdWdoIGl0DQo+Pj4+IGlzIG5vdCBhbHdheXMgZG9uZSB3
ZWxsLiBUaGVyZWZvcmUsIHdlIHNob3VsZCBhaW0gZm9yIGltcHJvdmVtZW50LCBub3QNCj4+Pj4g
cmVncmVzc2lvbi4gSSBiZWxpZXZlIHRoYXQgdXRpbGl6aW5nIHRoZSBwYWdlbWFwLWJhc2VkIG1l
Y2hhbmlzbSBmb3IgV1AnaW5nDQo+Pj4+IG1pZ2h0IGJlIGEgc3RlcCBpbiB0aGUgd3JvbmcgZGly
ZWN0aW9uLiBJIHRoaW5rIHRoYXQgaXQgd291bGQgaGF2ZSBiZWVuIGJldHRlcg0KPj4+PiB0byBl
bWl0IGEgJ1VGRkRfRkVBVFVSRV9XUF9BU1lOQycgV1AtbG9nIChhbmQgb3JkZXJlZCkgd2l0aCBV
RkZEICNQRiBhbmQNCj4+Pj4gZXZlbnRzLiBUaGUgJ1VGRkRfRkVBVFVSRV9XUF9BU1lOQyctbG9n
IG1heSBub3QgbmVlZCB0byB3YWtlIHdhaXRlcnMgb24gdGhlDQo+Pj4+IGZpbGUgZGVzY3JpcHRv
ciB1bmxlc3MgdGhlIGxvZyBpcyBmdWxsLg0KPj4+IA0KPj4+IFllcyB0aGlzIGlzIGFuIGludGVy
ZXN0aW5nIHF1ZXN0aW9uIHRvIHRoaW5rIGFib3V0Li4NCj4+PiANCj4+PiBLZWVwaW5nIHRoZSBk
YXRhIGluIHRoZSBwZ3RhYmxlIGhhcyBvbmUgZ29vZCB0aGluZyB0aGF0IGl0IGRvZXNuJ3QgbmVl
ZCBhbnkNCj4+PiBjb21wbGV4aXR5IG9uIG1haW50YWluaW5nIHRoZSBsb2csIGFuZCBubyBwb3Nz
aWJpbGl0eSBvZiAibG9nIGZ1bGwiLg0KPj4gDQo+PiBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJu
LCBidXQgSSB0aGluayB0aGF0IGV2ZW50dWFsbHkgaXQgbWlnaHQgYmUgc2ltcGxlcg0KPj4gdG8g
bWFpbnRhaW4sIHNpbmNlIHRoZSBsb2dpYyBvZiBob3cgdG8gcHJvY2VzcyB0aGUgbG9nIGlzIG1v
dmVkIHRvIHVzZXJzcGFjZS4NCj4+IA0KPj4gQXQgdGhlIHNhbWUgdGltZSwgaGFuZGxpbmcgaW5w
dXRzIGZyb20gcGFnZW1hcCBhbmQgdWZmZCBoYW5kbGVycyBhbmQgc3luY+KAmWluZw0KPj4gdGhl
bSB3b3VsZCBub3QgYmUgdG9vIGVhc3kgZm9yIHVzZXJzcGFjZS4NCj4gDQo+IEkgZG8gbm90IGV4
cGVjdCBhIGNvbW1vbiB1ZmZkLXdwIGFzeW5jIHVzZXIgdG8gcHJvdmlkZSBhIGZhdWx0IGhhbmRs
ZXIgYXQNCj4gYWxsLiAgSW4gbXkgaW1hZ2luYXRpb24gaXQncyBpbiBtb3N0IGNhc2VzIHVzZWQg
c3RhbmRhbG9uZSBmcm9tIG90aGVyIHVmZmQNCj4gbW9kZXM7IGl0IG1lYW5zIGFsbCB0aGUgZmF1
bHRzIHdpbGwgc3RpbGwgYmUgaGFuZGxlZCBieSB0aGUga2VybmVsLiAgSGVyZQ0KPiB3ZSBvbmx5
IGxldmVyYWdlIHRoZSBhY2N1cmFjeSBvZiB1c2VyZmF1bHRmZCBjb21wYXJpbmcgdG8gc29mdC1k
aXJ0eSwgc28NCj4gbm90IHJlYWxseSByZWFsICJ1c2VyIi1mYXVsdHMuDQoNCklmIHRoYXQgaXMg
dGhlIG9ubHkgdXNlLWNhc2UsIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UuIEJ1dCBJIGd1ZXNzIG1vc3Qg
dXNlcnMgd291bGQNCm1vc3QgbGlrZWx5IHVzZSBzb21lIGxpYnJhcnkgKGFuZCBub3Qgc3lzY2Fs
bHMgZGlyZWN0bHkpLiBTbyBzbGlnaHRseQ0KY29tcGxpY2F0aW5nIHRoZSBBUEkgZm9yIGJldHRl
ciBnZW5lcmFsaXR5IG1heSBiZSByZWFzb25hYmxlLg0KDQo+IA0KPj4gDQo+PiBCdXQgeWVzLCBh
bGxvY2F0aW9uIG9uIHRoZSBoZWFwIGZvciB1c2VyZmF1bHRmZF93YWl0X3F1ZXVlLWxpa2UgZW50
cmllcyB3b3VsZA0KPj4gYmUgbmVlZGVkLCBhbmQgdGhlcmUgYXJlIHNvbWUgaXNzdWVzIG9mIG9y
ZGVyaW5nIHRoZSBldmVudHMgKEkgdGhpbmsgYWxsICNQRg0KPj4gYW5kIG90aGVyIGV2ZW50cyBz
aG91bGQgYmUgb3JkZXJlZCByZWdhcmRsZXNzKSBhbmQgaG93IG5vdCB0byB0cmF2ZXJzZSBhbGwN
Cj4+IGFzeW5jLXVzZXJmYXVsdGZkX3dhaXRfcXVldWXigJlzIChleGNlcHQgdGhvc2UgdGhhdCBi
bG9jayBpZiB0aGUgbG9nIGlzIGZ1bGwpDQo+PiB3aGVuIGEgd2FrZXVwIGlzIG5lZWRlZC4NCj4g
DQo+IFdpbGwgdGhlcmUgYmUgYW4gb3JkZXJpbmcgcmVxdWlyZW1lbnQgZm9yIGFuIGFzeW5jIG1v
ZGU/ICBDb25zaWRlcmluZyBpdA0KPiBzaG91bGQgYmUgYXN5bmMgdG8gd2hhdGV2ZXIgZWxzZSwg
SSB3b3VsZCB0aGluayBpdCdzIG5vdCBhIHByb2JsZW0sIGJ1dA0KPiBtYXliZSBJIG1pc3NlZCBz
b21ldGhpbmcuDQoNCllvdSBtYXkgYmUgcmlnaHQsIGJ1dCBJIGFtIG5vdCBzdXJlLiBJIGFtIHN0
aWxsIG5vdCBzdXJlIHdoYXQgdXNlLWNhc2VzIGFyZQ0KdGFyZ2V0ZWQgaW4gdGhpcyBwYXRjaC1z
ZXQuIEZvciBDUklVIGNoZWNrcG9pbnQgdXNlLWNhc2UgKHdoZW4gdGhlIGFwcCBpcw0Kbm90IHJ1
bm5pbmcpLCBJIGd1ZXNzIHRoZSBjdXJyZW50IGludGVyZmFjZSBtYWtlcyBzZW5zZS4gQnV0IGlm
IHRoZXJlIGFyZQ0KdXNlLWNhc2VzIGluIHdoaWNoIHRoaXMgeW91IGRvIGNhcmUgYWJvdXQgVUZG
RC1ldmVudHMgdGhpcyBjYW4gYmVjb21lIGFuDQppc3N1ZS4NCg0KQnV0IGV2ZW4gaW4gc29tZSBv
YnZpb3VzIHVzZS1jYXNlcywgdGhpcyBtaWdodCBiZSB0aGUgd3JvbmcgaW50ZXJmYWNlIGZvcg0K
bWFqb3IgcGVyZm9ybWFuY2UgaXNzdWVzLiBJZiB3ZSB0aGluayBhYm91dCBzb21lIGluY3JlbWVu
dGFsIGNvcHlpbmcgb2YNCm1vZGlmaWVkIHBhZ2VzIChhLWxhIHByZS1jb3B5IGxpdmUtbWlncmF0
aW9uIG9yIHRvIGNyZWF0ZSBwb2ludC1pbi10aW1lDQpzbmFwc2hvdHMpLCBpdCBzZWVtcyB0byBt
ZSBtdWNoIG1vcmUgZWZmaWNpZW50IGZvciBhcHBsaWNhdGlvbiB0byBoYXZlIGENCmxvZyB0aGFu
IHRyYXZlcnNpbmcgYWxsIHRoZSBwYWdlLXRhYmxlcy4NCg0KDQo+PiANCj4+PiANCj4+PiBJZiB0
aGVyZSdzIHBvc3NpYmxlICJsb2cgZnVsbCIgdGhlbiB0aGUgbmV4dCBxdWVzdGlvbiBpcyB3aGV0
aGVyIHdlIHNob3VsZA0KPj4+IGxldCB0aGUgd29ya2VyIHdhaXQgdGhlIG1vbml0b3IgaWYgdGhl
IG1vbml0b3IgaXMgbm90IGZhc3QgZW5vdWdoIHRvDQo+Pj4gY29sbGVjdCB0aG9zZSBkYXRhLiAg
SXQgYWRkcyBzb21lIHNsaWdodCBkZXBlbmRlbmN5IG9uIHRoZSB0d28gdGhyZWFkcywgSQ0KPj4+
IHRoaW5rIGl0IGNhbiBtYWtlIHRoZSB0cmFja2luZyBoYXJkZXIgb3IgaW1wb3NzaWJsZSBpbiBs
YXRlbmN5IHNlbnNpdGl2ZQ0KPj4+IHdvcmtsb2Fkcy4NCj4+IA0KPj4gQWdhaW4sIEkgdW5kZXJz
dGFuZCB5b3VyIGNvbmNlcm4uIEJ1dCB0aGlzIG1vZGVsIHRoYXQgSSBwcm9wb3NlIGlzIG5vdCBu
ZXcuDQo+PiBJdCBpcyB1c2VkIHdpdGggUE1MIChwYWdlLW1vZGlmaWNhdGlvbiBsb2dnaW5nKSBh
bmQgS1ZNLCBhbmQgSUlSQyB0aGVyZSBpcw0KPj4gYSBzaW1pbGFyIGludGVyZmFjZSBiZXR3ZWVu
IEtWTSBhbmQgUUVNVSB0byBwcm92aWRlIHRoaXMgaW5mb3JtYXRpb24uIFRoZXJlDQo+PiBhcmUg
ZW5kbGVzcyBvdGhlciBleGFtcGxlcyBmb3Igc2ltaWxhciBwcm9kdWNlci1jb25zdW1lciBtZWNo
YW5pc21zIHRoYXQNCj4+IG1pZ2h0IGxlYWQgdG8gc3RhbGwgaW4gZXh0cmVtZSBjYXNlcy4NCj4g
DQo+IFllcywgSSdtIG5vdCBhZ2FpbnN0IHRoaW5raW5nIG9mIHVzaW5nIHNpbWlsYXIgc3RydWN0
dXJlcyBoZXJlLiAgSXQncyBqdXN0DQo+IHRoYXQgaXQncyBkZWZpbml0ZWx5IG1vcmUgY29tcGxp
Y2F0ZWQgb24gdGhlIGludGVyZmFjZSwgYXQgbGVhc3Qgd2UgbmVlZA0KPiB5ZXQgb25lIG1vcmUg
aW50ZXJmYWNlIHRvIHNldHVwIHRoZSByaW5ncyBhbmQgZGVmaW5lIGl0cyBpbnRlcmZhY2VzLg0K
PiANCj4gTm90ZSB0aGF0IGFsdGhvdWdoIE11aGFtbXVkIGlzIGRlZmluaW5nIGFub3RoZXIgbmV3
IGludGVyZmFjZSBoZXJlIHRvbyBmb3INCj4gcGFnZW1hcCwgSSBkb24ndCB0aGluayBpdCdzIHN0
cmljdGx5IG5lZWRlZCBmb3IgdWZmZC13cCBhc3luYyBtb2RlLiAgT25lDQo+IGNhbiB1c2UgdWZm
ZC13cCBhc3luYyBtb2RlIHdpdGggUE1fVUZGRF9XUCB3aGljaCBpcyB3aXRoIGN1cnJlbnQgcGFn
ZW1hcA0KPiBpbnRlcmZhY2UgYWxyZWFkeS4NCj4gDQo+IFNvIHdoYXQgTXVoYW1tdWQgaXMgcHJv
cG9zaW5nIGhlcmUgYXJlIHR3byB0aGluZ3MgdG8gbWU6ICgxKSB1ZmZkLXdwIGFzeW5jLA0KPiBw
bHVzICgyKSBhIG5ldyBwYWdlbWFwIGludGVyZmFjZSAod2hpY2ggd2lsbCBjbG9zZWx5IHdvcmsg
d2l0aCAoMSkgb25seSBpZg0KPiB3ZSBuZWVkIGF0b21pY2l0eSBvbiBnZXQtZGlydHkgYW5kIHJl
cHJvdGVjdCkuDQo+IA0KPiBEZWZpbmluZyBuZXcgaW50ZXJmYWNlIGZvciB1ZmZkLXdwIGFzeW5j
IG1vZGUgd2lsbCBiZSBzb21ldGhpbmcgZXh0cmEsIHNvDQo+IElNSE8gYmVzaWRlcyB0aGUgaGVh
cCBhbGxvY2F0aW9uIG9uIHRoZSByaW5ncywgd2UgbmVlZCB0byBhbHNvIGp1c3RpZnkNCj4gd2hl
dGhlciB0aGF0IGlzIG5lZWRlZC4gIFRoYXQncyB3aHkgSSB0aGluayBpdCdzIGZpbmUgdG8gZ28g
d2l0aCB3aGF0DQo+IE11aGFtbXVkIHByb3Bvc2VkLCBiZWNhdXNlIGl0J3MgYSBtaW5pbXVtIGNo
YW5nZXNldCBhdCBsZWFzdCBmb3IgdXNlcmZhdWx0DQo+IHRvIHN1cHBvcnQgYW4gYXN5bmMgbW9k
ZSwgYW5kIGFueXRoaW5nIGVsc2UgY2FuIGJlIGRvbmUgb24gdG9wIGlmIG5lY2Vzc2FyeS4NCj4g
DQo+IEdvaW5nIGEgYml0IGJhY2sgdG8gdGhlICJsZWFkIHRvIHN0YWxsIGluIGV4dHJlbWUgY2Fz
ZXMiIGFib3ZlLCBqdXN0IGFsc28NCj4gd2FudCB0byBtZW50aW9uIHRoYXQgdGhlIFZNIHVzZSBj
YXNlIGlzIHNsaWdodGx5IGRpZmZlcmVudCAtIGRpcnR5IHRyYWNraW5nDQo+IGlzIG9ubHkgaGVh
dmlseSB1c2VkIGR1cmluZyBtaWdyYXRpb24gYWZhaWN0LCBhbmQgaXQncyBhIHNob3J0IHBlcmlv
ZC4gIE5vdA0KPiBhIGxvdCBvZiBwZW9wbGUgd2lsbCBjb21wbGFpbiBwZXJmb3JtYW5jZSBkZWdy
YWRlcyBkdXJpbmcgdGhhdCBwZXJpb2QNCj4gYmVjYXVzZSB0aGF0J3MganVzdCByYXJlLiAgQW5k
LCBldmVuIHdpdGhvdXQgdGhlIHJpbmcgdGhlIHBlcmYgaXMgcmVhbGx5DQo+IGJhZCBkdXJpbmcg
bWlncmF0aW9uIGFueXdheS4uLiBFc3BlY2lhbGx5IHdoZW4gaHVnZSBwYWdlcyBhcmUgdXNlZCB0
byBiYWNrDQo+IHRoZSBndWVzdCBSQU0uDQo+IA0KPiBIZXJlIGl0J3Mgc2xpZ2h0bHkgZGlmZmVy
ZW50IHRvIG1lOiBpdCdzIGFib3V0IHRyYWNraW5nIGRpcnR5IHBhZ2VzIGR1cmluZw0KPiBhbnkg
cG9zc2libGUgd29ya2xvYWQsIGFuZCBpdCBjYW4gYmUgbW9uaXRvcmVkIHBlcmlvZGljYWxseSBh
bmQgZnJlcXVlbnRseS4NCj4gU28gSU1ITyBzdHJpY3RlciB0aGFuIGEgVk0gdXNlIGNhc2Ugd2hl
cmUgbWlncmF0aW9uIGlzIHRoZSBvbmx5IHBlcmlvZCB0bw0KPiB1c2UgaXQuDQoNCkkgc3RpbGwg
ZG9u4oCZdCBnZXQgdGhlIHVzZS1jYXNlcy4gIm1vbml0b3JlZCBwZXJpb2RpY2FsbHkgYW5kIGZy
ZXF1ZW50bHnigJ0gaXMNCm5vdCBhIHVzZS1jYXNlLiBBbmQgYXMgSSBzYWlkIGJlZm9yZSwgYWN0
dWFsbHksIG1vbml0b3JpbmcgZnJlcXVlbnRseSBpcw0KbW9yZSBwZXJmb3JtYW50IHdpdGggYSBs
b2cgdGhhbiB3aXRoIHNjYW5uaW5nIGFsbCB0aGUgcGFnZS10YWJsZXMuDQoNCj4gDQo+PiANCj4+
PiANCj4+PiBUaGUgb3RoZXIgdGhpbmcgaXMgd2UgY2FuIGFsc28gbWFrZSB0aGUgbG9nICJuZXZl
ciBnb25uYSBmdWxsIiBieSBtYWtpbmcgaXQNCj4+PiBhIGJpdG1hcCBjb3ZlcmluZyBhbnkgcmVn
aXN0ZXJlZCByYW5nZXMsIGJ1dCBJIGRvbid0IGVpdGhlciBrbm93IHdoZXRoZXINCj4+PiBpdCds
bCBiZSB3b3J0aCBpdCBmb3IgdGhlIGVmZm9ydC4NCj4+IA0KPj4gSSBkbyBub3Qgc2VlIGEgYmVu
ZWZpdCBvZiBoYWxmLWxvZyBoYWxmLXNjYW4uIEl0IHRyaWVzIHRvIHRha2UgdGhlDQo+PiBkYXRh
LXN0cnVjdHVyZSBvZiBvbmUgZm9ybWF0IGFuZCBjb21iaW5lIGl0IHdpdGggYW5vdGhlci4NCj4g
DQo+IFdoYXQgSSdtIHNheWluZyBoZXJlIGlzIG5vdCBoYWxmLWxvZyAvIGhhbGYtc2NhbiwgYnV0
IHVzZSBhIHNpbmdsZSBiaXRtYXANCj4gdG8gc3RvcmUgd2hhdCBwYWdlIGlzIGRpcnR5LCBqdXN0
IGxpa2UgS1ZNX0dFVF9ESVJUWV9MT0cuICBJIHRoaW5rIGl0DQo+IGF2b2lkcyBhbnkgYWJvdmUg
InN0YWxsIiBpc3N1ZS4NCg0KT2gsIEkgbmV2ZXIgd2VudCBpbnRvIHRoZSBLVk0gZGV0YWlscyBi
ZWZvcmUgLSBzdHVwaWQgbWUuIElmIHRoYXTigJlzIHdoYXQNCmV2ZW50dWFsbHkgd2FzIHByb3Zl
biB0byB3b3JrIGZvciBLVk0vUUVNVSwgdGhlbiBpdCByZWFsbHkgc291bmRzIGxpa2UNCnRoZSBw
YWdlbWFwIHNvbHV0aW9uIHRoYXQgTXVoYW1tYWQgcHJvcG9zZWQuDQoNCkJ1dCBzdGlsbCBub3Qg
Y29udm9sdXRpbmcgcGFnZW1hcCB3aXRoIHVzZXJmYXVsdGZkIChhbmQgZXNwZWNpYWxseQ0KdWZm
ZC13cCkgY2FuIGJlIGJlbmVmaWNpYWwuIExpbnVzIGFscmVhZHkgdGhyZXcgc29tZSBjb21tZW50
cyBoZXJlIGFuZA0KdGhlcmUgYWJvdXQgZGlzbGlraW5nIHVmZmQtd3AsIGFuZCBJ4oCZbSBub3Qg
c3VyZSBhZGRpbmcgdWZmZC13cCBzcGVjaWZpYw0Kc3R1ZmYgdG8gcGFnZW1hcCB3b3VsZCBiZSB3
ZWxjb21lZC4NCg0KQW55aG93LCB0aGFua3MgZm9yIGFsbCB0aGUgZXhwbGFuYXRpb25zLiBFdmVu
dHVhbGx5LCBJIHVuZGVyc3RhbmQgdGhhdA0KdXNpbmcgYml0bWFwcyBjYW4gYmUgbW9yZSBlZmZp
Y2llbnQgdGhhbiBhIGxvZyBpZiB0aGUgYml0cyBhcmUgY29uZGVuc2VkLg0KDQo=
