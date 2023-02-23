Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146146A0E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBWRLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 12:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWRLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:11:16 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012004.outbound.protection.outlook.com [52.101.63.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FB55C34;
        Thu, 23 Feb 2023 09:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+uDAI2i5UPksJvCvL0RrnwjWCTYW9ZKtrbwlf1LwRA35gj6Hj6Nz50HbLlMaoZKgwWjZoQ+1r6rTKyC5KXyCAVYPjVImNJU4xnYDkOPHk8ymg9YC9Kk0yarUA88HFXw3KYuNTy6F3Dxq+iazlDyc68Or2EsrbH3wxbCXbkQ0uohoBVsWUUXFYpJDGMRSDx3e20Rze2Fzw0gY6h0Ebj8fZO8nh3IrFK03wSTBdbZfHNyGxcI02PlWiG40c+ioxs0fOhSGKxdsZH3Rfz6yc3B8SPjztzeTllEXR9gdd/C3W3Zhdc7nMUYam1H3h9J31EbKzwVVmx08GHTcH+J70AtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3maXaJ5h9AdwM7zlzbJILiDJ+2zPAG0uRv0unIKjUUY=;
 b=l8L9Tsru9BpYF53mpp39gCGNEf3KvO1uMSxQSjY930GuZ4SYQw2epqi3Ywr8Vc46KWAxEkcDHGdv474I33eAIzL7Q9RDIMbTvYS/RrN8e5YgvzS0PWLzbqzAI/0ARFzi3la6zv+8I4KWKQwwdJx50UdIASO/Cygm0gFnr5O/Vju+hqkX2o/naHBTpvstkbBSt1f+yPvi7cgfIB8hETqX/cynU7OCDY8uDG+bG52pJfbRDn0ysR7uQjdxTq0lPP9ULhimW8lL5hC/HnBlTBLgmFY0j6SfdpFtb2226Xq7Z//Ad0NjDDIORjRHZg3zl0ICnh6pzVppVo6J1ZVK2LOn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3maXaJ5h9AdwM7zlzbJILiDJ+2zPAG0uRv0unIKjUUY=;
 b=mXwvpH+wSMuD9BgSvuojg2EQJRBdt9hpqOdoCm1mn3UiBjEWKr6zImJBf/XZdoFv91uLX8QmAIstuytjmqx3EtDJfpV5HE0+N6DhunXzM2yODN0l/19vY3yLurizL6iR8LoQ368Fro+F/ty7nJJz14MhKtAEnzz/yLZKIlbw1io=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8291.namprd05.prod.outlook.com (2603:10b6:a03:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 17:11:12 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%9]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 17:11:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Thread-Index: AQHZNvnMjIrwR8b570Ch3VOm2txWlq7WZLkAgAGKnwCAA4VRAIAAyUIAgACnuwA=
Date:   Thu, 23 Feb 2023 17:11:11 +0000
Message-ID: <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
In-Reply-To: <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BY3PR05MB8291:EE_
x-ms-office365-filtering-correlation-id: b0fbf43d-5c5d-4488-44fd-08db15c0f69a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAeGpzd+hzRShHnQTW8dYyqCUuntfOKkyZiY+K7cV+L9uOu32LXpk/cb4qSlJjraeGkz1s1w44diPE+Yy6rGzRN63FWPH1RA4pZtZIL71kXCRW3qEQhAfZTesuy6ogWOI6CDKVzQxAadajy0KTCJLkX6wleGufGWdiEHDXSJhdhR+LbgbfSpcseN7Q9NOlgnz8nMAov4ymmHd4Ip32nZFhU5dVG3ngQVZ3EYcjA81+K2v3P+Eudoyjb80thGgkhGf2s37dRJYsEffOvQvGNwLTSh2deBXS9F39duvkXyTtuy+LyTLQLSIDAJCe41UtmS8UjB/cZUvz4Vw0h1z5plWTcXLDQdNeIQdEtGEPTHeymm0S5nsutVql2THvcvmqoAE2mID3iWbINNT6ocDIf7EM3PqjaDTwwCjXWZDXAQ+1592NMrs6rEtUo9or3o/vQ1V/n63iPo0gF6DQUicA55SzxdOVkAkUapN3ixNh1IVJZe9Y0CYUClyPKRMh+U8QkWlw+ZdkN9ukq7/wIu5FCKD8EGvwkccDuXg/PzjpQE+YlT6z3yTdQVBXiKM8QLpROn3ENfg2Ra8DVdwZOL0oCfIWz/E28lLA6xhSXFsS+nIDCHyPtm1ILXtu8tkAP0Ilvr6/QbdNR8sK3yM6//GOY2A4E3CI3Ij8u02pBng8lS5Gq65R1HYs830qZgqOrqL5irrmjOUy81N6zmH+qJLTD5WvzElkyE+lcSsQ84uGWI38HXLFTD8hcs9NoHeJ+FUINM5Jx/sgAOcabLRK06y92IFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(64756008)(66556008)(66446008)(66476007)(66946007)(54906003)(76116006)(83380400001)(316002)(8676002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(6506007)(2616005)(53546011)(26005)(186003)(6512007)(478600001)(6486002)(71200400001)(38070700005)(33656002)(36756003)(86362001)(7416002)(7406005)(2906002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzIvcUFoTDd6VnJndS9IeWRMWEI4TkZXN0tGQmI0ODdjTjdPQkNibHdvVjhG?=
 =?utf-8?B?RG13QVFDR3o4OStPdnhlNG5NYVRGaU1OOW01dzJiR1AwUHVxVWRSV1NrR1Qw?=
 =?utf-8?B?dzBXcXZYYmVrUWFScURSUlRyUzZ3dE8xek1BWGJCangrZDlwbGRsYjVqdDI2?=
 =?utf-8?B?emZwV0hkYkJqdXMrQVUyeEVrejA5SVowZEFFMUhZcldjMWgwTTh1Y1JlSlRL?=
 =?utf-8?B?VTJUK3d5NHNmUmRBazBibG5tcUFrM2hRV2RrTVdOeTVwWUxJMHNocU9jdXR0?=
 =?utf-8?B?VjZ0NnhTZXlsZWdSTFlsMFpmcUVRUnJVRmx3NWNIdm16OUNwTzdUOUVSdXha?=
 =?utf-8?B?YVhmeFVrRVhrZ3dPOE1Sb25yVTlodndQSzVoMHpVVlNYWlJ6aElQMnNOeHlk?=
 =?utf-8?B?L3l5SGlUeTFIYlRwWjhOMnFuUXRjU1RyZlhxN2poWnprK25MbnNudlB0S3ZF?=
 =?utf-8?B?bHplUU9mUlpvbmt3RUxwT2FyRUVGRStEQ0txU1hGbFNRam5YeHBkdVVPTVo1?=
 =?utf-8?B?UE5pNXRPcTkxVVhvQjhIYzFjdUhqd2xOV1p4dmFLSXpySTdBUVh0Z0haZUQz?=
 =?utf-8?B?T09XaWNwOERoMy9vOHJtUkpMSFJ3bm9jWkhBdEcxcnpjZFNKWDZVcGNCK0NW?=
 =?utf-8?B?MUlNM3ZXbjBUd0NidEdmSndDcjhQRi8xRGgvY1RpMVIyZGlGT3dVOUZzeGZD?=
 =?utf-8?B?M2UvNWkxVmRrcnMzdVFkVnk0OENKT2U0cVR3L05ZeTNrcjlQWHFCc0tibFN0?=
 =?utf-8?B?SVZVV0N4SjlhK1ZsUkFzVWpnUG1hcjAxck8zQjBvREk1ajNtNEVXU2VLclhM?=
 =?utf-8?B?TjRDekRIVHdJVDZCUDNodlI2NzR2ZmRQNDNETHVkZEJKR1BWVmdkK3I0Q25k?=
 =?utf-8?B?RWdoYUh4NUd3UEZZWmVWRWZzNkovRzg4UXJIK1c0QnE5OEJVWjBCdUFpV2Fa?=
 =?utf-8?B?aTZOaTEzQXpqazJlVDMrZGdEWXlOMExnTnl0c0dTMHIraUFJcVRGc2U2UUQr?=
 =?utf-8?B?S2FCNnh4UElCaDFGVUFQSmU0RDJPVUlzcXZWZ1M3bzh3bDJMcGxuQmx6Q1Fq?=
 =?utf-8?B?ZEFIbndUT1RtTUxCTWdJc0NUWXliMHRWU3hROXRsWWMxUG10QkpLdFpaREE0?=
 =?utf-8?B?UTNuN1M3S2U4T3MyOUpYb2k0NmdJVlBLQlEybThEaGZXZHppbW1KUHlHTWJD?=
 =?utf-8?B?bkxEZ0U4bkMrK1Q0aXRodmJhbkZvREVxT09GcWcrYm14a1ovSzlJTGk5aGc5?=
 =?utf-8?B?Y0tiTFp1QmwvdkloWDdYNzFyYWd5VXh3eUtOT3E4ZlRuVXJGTWY2bDBSbkZt?=
 =?utf-8?B?Q1JzRlBxQ0h2U1JlNGtvejBlYjUwTzF2MEM3NDRnRENGaExoUE5VbytuTmFw?=
 =?utf-8?B?VWhUTGR5RGU4b05NN0hoMUFXZTZiK1ErVGlySzlZUkkxOGQ5WmtJYW8xaXd4?=
 =?utf-8?B?OEpTMTh0RHZtUHJ2b2pmMGFpMDdLQWVzZUp4MTBkZTQxSnZMNWNUem1pY0hD?=
 =?utf-8?B?cEpJVThmMFcvUUtaZjhpZTVFSnBkUHhiaU1McXJiL2ZSSjUvSXA2VTJDbE4z?=
 =?utf-8?B?b2V5RGhpa3BJV1JrZzBtV090eXZNa0RLWnF5cWVObEhWNkpPOEw0TElKMlZD?=
 =?utf-8?B?bTdRYVNMRDJnTUhFU01HZk5NL3hSaVdVL3M5SXBielZMZzB6cWlMSFdaWnlq?=
 =?utf-8?B?Q29rYTFFYmQ0MURweUdiQS9xQ1BsVHpLbUJ5bm9jYWNmQW9BZ2tBWTJDM1hn?=
 =?utf-8?B?N2s1TUVXaWY1dFZFdXBJRVRBMGVPeEltME96Q09ocXo2OEEvN3BEZnZiUzRJ?=
 =?utf-8?B?dG5ISERQY3pzaElmNzBYL3ZYaUNOSVVxSWFZSUZLNVhyWUc4TWlnb1F3TFFp?=
 =?utf-8?B?VHZrY2RZL0V4WXVMNkthWk9tcEN0RnRPekpvci93ZkMzQ0ZMTTY5b3c0Ry9j?=
 =?utf-8?B?cUg2SUw5ai9tNDZKZ2ttODJLMkQvRktzWDloUTlsa3puN0RnMjVDR2VMdWRn?=
 =?utf-8?B?cTRpdEFCS2hPZnE3MCt5Rk81dTFQZklzbGoxYkVWRG9FeU1FYWhyNVhQbGsz?=
 =?utf-8?B?YlVvR3hpbWFGOWI5ZUlyR1plMDZ2L2FGaUxHejhFTlZ6cDYrOGU1NHU5eFRI?=
 =?utf-8?Q?oSegZ8tPdmKOrJsXf+lFdx0Ex?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71F1611A5C09ED46A63A584976D74854@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fbf43d-5c5d-4488-44fd-08db15c0f69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 17:11:11.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhXsBp+owu7k3qFnGqvZJ4tPnm5H1et60pg9MiVBN6QRyczR6pgkC7QCx3/ojvCDS/P9cRoPEuq6suPKHkA4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEZlYiAyMiwgMjAyMywgYXQgMTE6MTAgUE0sIE11aGFtbWFkIFVzYW1hIEFuanVtIDx1
c2FtYS5hbmp1bUBjb2xsYWJvcmEuY29tPiB3cm90ZToNCj4gDQo+IEhpIE5hZGF2LCBNaWtlLCBN
aWNoYcWCLA0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgeW91ciB0aG91Z2h0cyBhdCBbQV0g
YmVsb3c/DQoNCkkgcHJvbWlzZWQgSSB3b24ndCB0YWxrIGFib3V0IHRoZSBBUEksIGJ1dCB3YXMg
cGVyc3VhZGVkIHRvIHJlY29uc2lkZXIuIEkgaGF2ZSBhDQpnZW5lcmFsIHF1ZXN0aW9uIHJlZ2Fy
ZGluZyB0aGUgc3VpdGFibGl0eSBvZiBjdXJyZW50bHkgcHJvcG9zZWQgaGlnaC1sZXZlbCBBUEku
DQpUbyBleHBsb3JlIHNvbWUgYWx0ZXJuYXRpdmVzLCBJJ2QgbGlrZSB0byBzdWdnZXN0IGFuIGFs
dGVybmF0aXZlIHRoYXQgbWF5IGhhdmUNCnNvbWUgYWR2YW50YWdlcy4gSWYgdGhlc2UgaGF2ZSBh
bHJlYWR5IGJlZW4gY29uc2lkZXJlZCBhbmQgZGlzbWlzc2VkLCBmZWVsIGZyZWUNCnRvIGlnbm9y
ZS4NCg0KSSBiZWxpZXZlIHdlIGhhdmUgdHdvIGRpc3RpbmN0IHVzYWdlIHNjZW5hcmlvczogKDEp
IHZlY3RvcmVkIHJlYWRzIGZyb20gcGFnZW1hcCwNCmFuZCAoMikgYXRvbWljIFVGRkQgV1AtcmVh
ZC9wcm90ZWN0LiBJdCdzIHBvc3NpYmxlIHRoYXQgdGhlc2UgcmVxdWlyZSBzZXBhcmF0ZQ0KaW50
ZXJmYWNlcw0KDQpSZWdhcmRpbmcgdmVjdG9yZWQgcmVhZHMsIEkgYmVsaWV2ZSB0aGUgc2ltcGxl
c3Qgc29sdXRpb24gaXMgdG8gbWFpbnRhaW4gdGhlDQpjdXJyZW50IHBhZ2VtYXAgZW50cnkgZm9y
bWF0IGZvciBvdXRwdXQgYW5kIGV4dGVuZCBpdCBpZiBuZWNlc3NhcnkuIFRoZSBpbnB1dA0KY2Fu
IGJlIGEgdmVjdG9yIG9mIHJhbmdlcy4gSSdtIHVuY2VydGFpbiBhYm91dCB0aGUgcHVycG9zZSBv
ZiBmaWVsZHMgc3VjaA0KYXMgJ2FueW9mX21hc2snIGluICdwYWdlbWFwX3NjYW5fYXJnJywgc28g
SSBjYW4ndCBjb25maXJtIHRoZWlyIG5lY2Vzc2l0eSBhbmQNCndoZXRoZXIgdGhlIGlucHV0IG5l
ZWQgdG8gYmUgbWFkZS4gbW9yZSBjb21wbGljYXRlZC4gVGhlcmUgaXMgYSBwb3NzaWJpbGl0eQ0K
dGhhdCBmaWVsZHMgc3VjaCBhcyAnYW55b2ZfbWFzaycgbWlnaHQgZXhwb3NlIGludGVybmFsIEFQ
SXMsIHNvIEkgaG9wZSB0aGV54oCZcmUNCm5vdCByZXF1aXJlZC4NCg0KRm9yIHRoZSBhdG9taWMg
b3BlcmF0aW9uIG9mICdQQUdFX0lTX1dSSVRURU4nICsgJ1BBR0VNQVBfV1BfRU5HQUdFJywgYSBk
aWZmZXJlbnQNCm1lY2hhbmlzbSBtaWdodCBiZSBuZWNlc3NhcnkuIFRoaXMgZnVuY3Rpb24gYXBw
ZWFycyB0byBiZSBVRkZELXNwZWNpZmljLg0KSW5zdGVhZCBvZiB0aGUgcHJvcG9zZWQgSU9DVEws
IGFuIGFsdGVybmF0aXZlIG9wdGlvbiBpcyB0bw0KdXNlICdVRkZEX0ZFQVRVUkVfV1BfQVNZTkMn
IHRvIGxvZyB0aGUgcGFnZXMgdGhhdCB3ZXJlIHdyaXR0ZW4sIHNpbWlsYXIgdG8NCnBhZ2UtbW9k
aWZpY2F0aW9uIGxvZ2dpbmcgb24gSW50ZWwuIFNpbmNlIHRoaXMgZmVhdHVyZSBhcHBlYXJzIHRv
IGJlIHNwZWNpZmljDQp0byBVRkZELCBJIGJlbGlldmUgaXQgd291bGQgYmUgbW9yZSBhcHByb3By
aWF0ZSB0byBpbmNsdWRlIHRoZSBsb2cgYXMgcGFydCBvZg0KdGhlIFVGRkQgbWVjaGFuaXNtIHJh
dGhlciB0aGFuIHRoZSBwYWdlbWFwLg0KDQpGcm9tIG15IGV4cGVyaWVuY2Ugd2l0aCBVRkZELCBw
cm9wZXIgb3JkZXJpbmcgb2YgZXZlbnRzICBpcyBjcnVjaWFsLCBhbHRob3VnaCBpdA0KaXMgbm90
IGFsd2F5cyBkb25lIHdlbGwuIFRoZXJlZm9yZSwgd2Ugc2hvdWxkIGFpbSBmb3IgaW1wcm92ZW1l
bnQsIG5vdA0KcmVncmVzc2lvbi4gSSBiZWxpZXZlIHRoYXQgdXRpbGl6aW5nIHRoZSBwYWdlbWFw
LWJhc2VkIG1lY2hhbmlzbSBmb3IgV1AnaW5nDQptaWdodCBiZSBhIHN0ZXAgaW4gdGhlIHdyb25n
IGRpcmVjdGlvbi4gSSB0aGluayB0aGF0IGl0IHdvdWxkIGhhdmUgYmVlbiBiZXR0ZXINCnRvIGVt
aXQgYSAnVUZGRF9GRUFUVVJFX1dQX0FTWU5DJyBXUC1sb2cgKGFuZCBvcmRlcmVkKSB3aXRoIFVG
RkQgI1BGIGFuZA0KZXZlbnRzLiBUaGUgJ1VGRkRfRkVBVFVSRV9XUF9BU1lOQyctbG9nIG1heSBu
b3QgbmVlZCB0byB3YWtlIHdhaXRlcnMgb24gdGhlDQpmaWxlIGRlc2NyaXB0b3IgdW5sZXNzIHRo
ZSBsb2cgaXMgZnVsbC4NCg0KSSBhbSBzb3JyeSB0aGF0IEkgY2hpbWUgaW4gdGhhdCBsYXRlLCBi
dXQgSSB0aGluayB0aGUgY29tcGxpY2F0aW9ucyB0aGF0IHRoZQ0KcHJvcG9zZWQgbWVjaGFuaXNt
IG1pZ2h0IHJhaXNlIGFyZSBub3QgbmVnbGlnaWJsZS4gQW5kIGFueWhvdyB0aGlzIHBhdGNoLXNl
dA0Kc3RpbGwgcmVxdWlyZXMgcXVpdGUgYSBiaXQgb2Ygd29yayBiZWZvcmUgaXQgY2FuIGJlIG1l
cmdlZC4NCg0K
