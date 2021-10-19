Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC52C432E64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhJSGhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:37:03 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:30311
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234255AbhJSGhC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZdzar/LfSCftDgFCkBSGvV2rLV7phqlr5DmCiAXxlk99o7rUbAVQQ3Nc7kV+zfBDwrqFhRJlko+gs9uSHrZLtq4gFut7Gr29/ytc1euEDqdCGSk0LP4gzlWPcnJVKfvDUEGpK67U4IorTt/Q2N0Q/ZgKW8q2jY433rQFT7O7a5Hyc1+wUr8qCQvCrDEgrDzIeCJHek7A4PfbgHhbBpz14TfKMqhcB7zCY5aAlSrG9C+1vb2pSZCpztzogg1qvBHoZxYHVf/OB8TpLr62r3MeY61cXVAPIVxxgbRUcYeKujK4RD5v6FsmosDuMXdW2ahwliSCWzv618qBMA/O5ui4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVB0BvaDt9zE3GM4gUNL+r5RYPjibT54Wsp9bJYlVcE=;
 b=g6GfWdGGbZyY/XBbVJCtrFA3nNAe/YFmWpx8fv0080kEii3i4WwzSCs+q6apbO7iLuyX3aHhSUsz1ldDurgFrxXcDZSyclcIM8aeVZxVqU3/e4ftmNjYZjke3MLl7U/tJQsl8uqSbx61KrvH2TZGHT3IUIguq5pLsGFAa0rXWU8yG96R27SCwqT0aoX+SJ4Cd9Dhb6J6XE0OAxmOF6brPwHELyaHtf7bM20Og/MctTwTIj8tS9+3cimZP3NcDk0ucIMqoGqesW5zXlyMP1kIFdOx6nAUx5jLi0dVL1gYJ8SmWliZLRuqgPzZPYYexteWmuqq/73MLP/Vaz/yrsLD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVB0BvaDt9zE3GM4gUNL+r5RYPjibT54Wsp9bJYlVcE=;
 b=JjoB/XnUp/nGAKAFSCNjmCGUS5yREA4zhpNBtdC/CaJvJkSWiC6kHMoG32c6jn6bjsmE/LqCREfWctG4W9jmmBQPs9AZPN0rmiKhn6x4xYn+O/fCIpmWk/p11b1cwHXHwVVfcnzYPMBQwyDKtE4sA4IEEgxsY1rOAG1O7sX9GmOqlObp52kZeojfGUTShV1bYmTTqFPAXk1elmPqxQBJVSZfSU8YvZB5eSUkH59DVd+127GCbNo5+ZyIO26qUTEaKd/c+uLVeWE1YdUsZAGcNjHYcoDUeMRxOetxVYFLXPDW+8NL7vyjW1jDV3Hf5FeUjNrJSeJEg28uJx/vHjEE4Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:34:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:34:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH 6/7] ntfs3: use sync_blockdev_nowait
Thread-Topic: [PATCH 6/7] ntfs3: use sync_blockdev_nowait
Thread-Index: AQHXxLIz65BI1YRpHk2z+emkYWW3DavZ3W4A
Date:   Tue, 19 Oct 2021 06:34:48 +0000
Message-ID: <f9c71f35-e8f1-e53d-9ace-d52e439ec505@nvidia.com>
References: <20211019062530.2174626-1-hch@lst.de>
 <20211019062530.2174626-7-hch@lst.de>
In-Reply-To: <20211019062530.2174626-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1896f933-2378-4d5e-21e5-08d992ca8c4d
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB12622CB0329537E4C6AC0DDCA3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27kgtYJyYZ/TApZdN6tZ66Ai8suo/c7FeUX+K4eZUQbXrKYq0Q0px7/jmceiJgfdw7OdidqESWWKi2Ounb2dzzrY2Odz+vXtN7vnjnx3/YcgPOgeRk7EEi/nRGtwdyvBmn7TynFhC9HLWjlBfM5bxUkP/Oo2PzV4lXXzOfJJeD1so2xFUc1LcqsQ7mx7w7gTUugoFV56NVuQlANqgzJ9ndAlNjLz2fgya/HbYVlDFozIml0MpuZZgRafzkf7yLOeC1hRv4kRIT/P+YT3jVbpoMthTQvGTJmeuEr28pDAe0uplWXuMkcoCMOoB7v4Cv+hJ1sCiSqFgAytl5xcFkYgThhVHJytBdjhxT3/mLHmWQDVO9x8bWvSW4LCLnOltjqyAwR4dLjVVI7AT6s8u+UJlXl0wce+Rek5FLkjtzDpbXP1MEaY25D3togkD2x2QdCngMfs//RhLBUh4TMHW/qCvnmPlgNUvfrCWZephsbcWVZIdoTSgA+UuLVluVo8nYe+mz19C68H3sww3smsQtdU1gYFOl40L4WCHE8lKdoXoY7CsbWae4n1rS8LzVfO+qWyOQ+A0d/yCz3b+WcDb380dMWwIeLMUt7lbUbi0066Llx48MWjmkVVPiC/El/JBBu4vwjHy7D49HVilRR8Xs5Wm+dLtCCQtbVmMMvjPO30PZegtboLrck1oqvl7jX4JYXQS+SG+nvLGYg4bDDmpn+rke5IQu74JNpLAjKFEgbOPcpGZ/9Q13Q9N3AmKlOkXKOlT1QuxOh47XghU8FcTeF9Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(5660300002)(7416002)(508600001)(64756008)(83380400001)(2906002)(36756003)(6486002)(110136005)(186003)(66556008)(38070700005)(122000001)(86362001)(8936002)(53546011)(8676002)(31686004)(316002)(76116006)(54906003)(71200400001)(2616005)(6512007)(4326008)(6506007)(31696002)(91956017)(66446008)(558084003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SS9Kait2TE10Sm51MDVudmpJZnVCK051Mk1QSmp2SGh3czdmNWJhSDBCaXFk?=
 =?utf-8?B?azhWWlFoTHQrUDRka3hVaXdZcWVJbVZ3UDBRdFdTcnFSR2E4ZlliTXRCTXE3?=
 =?utf-8?B?WC9RL2VreWduSXZxWHZTSUZ4YlJMbHNIVEhYUzBWaFkzSWxDanNsTnFzY0Iv?=
 =?utf-8?B?cFd5MTNDT1h1R0pJVzZFSFRoT3hCY3UxNkJLVzBjTUNScEUvQkRSaC9JZlI1?=
 =?utf-8?B?WVJ2T2RJRGpRMmZ5WHBSQTBVWlhMbXBZRVJOSUpLSXZ5WW91RUs5dm9mRWVx?=
 =?utf-8?B?Vm0vc01KUzhkZjNxS1JUQXk4bk4vMUViMkdFbTZhckFib3FYSnllVEJMSG52?=
 =?utf-8?B?b05Fc2V1d0g2Y1pORnhscEttNExPL1JXRTRHVVFSc1NYMWVOczQ3U0VoZmpD?=
 =?utf-8?B?WTUxSHNsbThIb3pFKzVhaS9ERm03SmwzeFZQdjZJTjAzSzk5Zlp1ZGJVMzA5?=
 =?utf-8?B?MHBpN3k4QlhTMCttSGIzTnFDa3pKT2JMOW5WS1BkdVRma2xEZE15T1RtUTB5?=
 =?utf-8?B?aXQ2T3RRMG9rMWlOeFh3bTVvT09KYWtxOTBVQThNOFRKcExjbXFtQjl0cEtQ?=
 =?utf-8?B?ZHRYQ2VrTHBIZ0V3K3JCZHVvOVJLd3RjZ1RYa1ZLdWIyZHBHUzJRT3ZEQVU2?=
 =?utf-8?B?Q2RydTVLTFpPc29LT2FWcnhRVUk4MGhOY2kxL1h0cVJtdExnNE1uTnp3Y2ZL?=
 =?utf-8?B?bkpIUHZpTEZwWnJDeHoxR25MZlg5bTFWd3JQSjgyK2tsRmMxamZieUVJaVJy?=
 =?utf-8?B?elQ4ZVh5VVV5Wk1pVXhrMXZuNENrNGJJZ3U0WmVNbGhrUG5Sd0hQcVVmd3Ar?=
 =?utf-8?B?SW8zdi9MOEVHQUFtWlZCK1pCQVNEMHNDRjMzNEsveU1Pd2dBYzNjNzBUTzlh?=
 =?utf-8?B?SFUyRFJLOXFkbCtHaFFzSlpDTXpEcUM4cVkxcWxWcjduL0thQTIrRHR2RVRt?=
 =?utf-8?B?WldvMmx1VkdnUEEvenRZNm9TODFEKzhPMTBsSHdqbUY3VXBxRjA0WUV2Yi9X?=
 =?utf-8?B?WmhOVlF4VEt3Zm1VY1hMQ05lZmVQY3o2Sjk1dmdxRmFGdVRGRmd5MUZYbVFo?=
 =?utf-8?B?ZVM5YlZuellXOHAxazlUWXJPRlVEWHJVSGZsUGlxbDVzNEZWUFRVcGUyZksz?=
 =?utf-8?B?UmFTOCtjbFhZcC9ERHlHNmk0Zml3NkwvVnczRTJYbys0and4b3RtMXliOE1C?=
 =?utf-8?B?OUs3RzV2ZWFhSXkvYm11U1NoK0ZVN2VTRFBwbHpuUmNXV1JxbjU1OERiaFZr?=
 =?utf-8?B?Um5xNGppKzJZaFg0Z1N1UXg2YWptT2puNjZNZ21lZDYyUmN6MjFZMjU1eVNO?=
 =?utf-8?B?YjdaNngwQ01mK3BpaCs5eG5VeG1GaVJsRU1ZM3ZycGVhUkMzODdxN2F2VllK?=
 =?utf-8?B?VVVYRkpGb2VmMnFoK05sYm55VDZjSWxEUCt1R0E1ejVyUFQ0ak9qR3g1NTlS?=
 =?utf-8?B?NzZOeUNvU25LUC9RbGhiTndlWXNnakQrWnR2MkoxbXV5UitlVXkwZzd2dVlS?=
 =?utf-8?B?M2RVV3o3ZGlsdjRoWXBNWVBrbEt6dmJXT3FDSlp0NTAwMy9Ya2lnejVVTWJI?=
 =?utf-8?B?Rm9DWFlwZkpIVFB6TC85M1RpRm5oRFQ2aHVyNmhraWFXSVgrQXFMSzlsVHFw?=
 =?utf-8?B?MmlLK2sxZHN5ak9lZ1lBNUUySXIzbHJhYTZTejlmeTZaNW5scTBBQzhZS25E?=
 =?utf-8?B?ZjdSY1FOZUZkNkh6Nk9lUXlYVmE2aldNZlFsdHFuSHRnaWhCRU0xOHUzWEdN?=
 =?utf-8?B?ZkhTK1ZhRHNXMDVxM0h2cjRtRUVDMFZDc2lHV09XTEdxRWlOdnV3KzV6U3VQ?=
 =?utf-8?B?ZVFYaEVxam5wd0lQUWh0MzVKRmhGOHhSMDlIR1RualhkMTEraDhuYUthcDlm?=
 =?utf-8?Q?Ni2ECUBala5n0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <57B9C9764B89564A9693EC835C4BFD79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896f933-2378-4d5e-21e5-08d992ca8c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:34:48.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5d3WDFPffcPfZEa4iGEgrRLJv2/C2UdJVfSj3VJimBydrV1HAVFegYoyMHYdnnGQGSlg+2ARG4I29pKzAkZYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMToyNSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSBz
eW5jX2Jsb2NrZGV2X25vd2FpdCBpbnN0ZWFkIG9mIG9wZW5jb2RpbmcgaXQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQo=
