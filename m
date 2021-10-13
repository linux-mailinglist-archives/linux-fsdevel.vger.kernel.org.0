Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9842CE4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 00:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJMWgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 18:36:06 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:11712
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230348AbhJMWgF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAhd5I6nnjhGqg9wfbNUBBBSoBrlYpc5IkcS4AJ3d85TveWNYIER96FpAiBdNqzOYFHpTmrlqp2fjGSCXsoJlkWYcgXT6okzLAsuMP8iZJAXaSBCvVC+AF/GlYWzxJKrXtOTQD/Kx9icCs2IPzlk+Dckl5m5na2ewdxCSl36Z6iXaDOMA5/+iUuhwXmOhS9Ry2Ndv8SPuPhGQWRKQAvGz0GpsbyxxXcvKpTR9SdiC74I6kjC1xCeQ0itPgxBKbF5DZQiTvNWCbOg8iuXuRstC3x1nFvAjtzAz9KVdhZtRkWxA7k9vdH3p0nncsYln8B/8G+GpCAj3RAs0r6qAJINZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=864Gkq+OUjAaLhBpXJA5Ah2pBllzcjFIWDplOWzOyP4=;
 b=aFShMIt9jV3ra3fSkvlzvlQVaHKXKGaHw6NaSusbnR2cOxJLpTNxtpqZ8OgLgR1Y4KrIPaBIQTq6V7zyxwIJIaTyUBzdehXxxphMIiTu9ioQlXqZAh0RJLh6kt86FYZzSb9+xhxv77e3ROEqBhJXPeHibgSyTcXMHRNr8rOvOYFPlSOPf2/u5LMYfsG+SfQ1ekwCwbPl1psAJE8HxDmS8La68zv6vPUBrit/M+Jo5oVhfa4Tc60X/AeeVqzBOHQkasXu1oLP9BFDC1tvcZW5JN4OZB1YYBd0JgQbyqoHUPMjXdS80YFqRYDYkp/quawlEsVh5SDgjeGGQkxGxlk5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=864Gkq+OUjAaLhBpXJA5Ah2pBllzcjFIWDplOWzOyP4=;
 b=SR7TM+mzsVKJ5FcwuH4OJ/G6M7CVpu9nLgJGLji70wSll0bcXNQulE85bH5e4usBWwGp/h3mkJCnwPKOp/k9obor0lqbUS5BWCdwUcwxMwNUBhJkeO4D0dsCkCzyxiHbdC6K1KbCPqDS3pJtTx08yTpJFmn9XJKPYNzeAx4y5Vlm5I5+0upcLYyIImD+56o7GpNtg7HqYVlYnz/3EWic8VabFL+ZEqU5XPZquQRczajCRVup/HMIBFwC6o7JgXHWjmztJuu1zzKNFQweOLEdd3Mbrm7NRaULyvaUGIjZbtRmocQrCXvxm6EFz7/SB60BJR8Q9pCOfCC8Xy+Nix/I4w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 22:33:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:33:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 02/29] drbd: use bdev_nr_sectors instead of open coding it
Thread-Topic: [PATCH 02/29] drbd: use bdev_nr_sectors instead of open coding
 it
Thread-Index: AQHXv/Fw+fZmcLtgm0ivWGuz5dJtu6vRhO+A
Date:   Wed, 13 Oct 2021 22:33:58 +0000
Message-ID: <473988dd-f18a-3ca0-7b3e-f5ad34f1b045@nvidia.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-3-hch@lst.de>
In-Reply-To: <20211013051042.1065752-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b45371-cc14-405f-24bd-08d98e998c64
x-ms-traffictypediagnostic: MW2PR12MB2379:
x-microsoft-antispam-prvs: <MW2PR12MB2379E51F4C87ED93D1735180A3B79@MW2PR12MB2379.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yc2rUiYBejKEb16Y8tfL5gzu0Ohbg9H7y9NStXHxgHhTYm6o6/HVrpYHPmg4ACugQAC7d8CqoVZb/wB3okQl5ZywXtXLj6N5du38klYVQXd9Gu+/RVUWDsQjAA4o5YaDXV0CYDaqPq3huJlQCnkEpii3r5mAFkJQ1Q6Ddotscy907z67twCV1nAFpIwTqWkBu6u7iBU0wb3K5PSYJhxxES8UPVToI/vRV71O3T6L1k1s+ZFbm7u6Nl364ZIjU6MbPC9yUFjaAWF6RbqUS36O8suOHsP9UuCfXmUe0UTGzqOmUud8UIr0S3Q1mz5HeE0gB08xf1rGQiTeh8G3d0YNzgb3afO7j0y6Ag258GUSvnenzm/SVfPyIMxiM7uCrEETvL3tT8XS/m+yiib1ZwON3WhGCMx01hPcob1voyJNpdVxi8LMhqfRlVD7RJo+/26xsEEk4OvTmpVK99dg4aDD5B6K/ebX7AJrzDovbHFFKy92C/aAIkrS8Rd7y0P/W+nY2b/IhmcVEuQ0cwK346JetkytHJck7Ko8x7agnKvNQB/I+jsdZIbPHhteUkraKcnNAMFSi3miKTgWTkKfareXVGMlj1TB7SBe2bdUNEjc4bC/WnE53d5VznJutxjVL6a0FjIw2y02GgSHW4phu+3EndafWQlKTgeYHKFTffGH+jX2ee16bs/es5ufpnEYsckB3HNc4SLqLIer9QdH9SXHPh3Sadum6tYMxdihWbX1u3oTZ4q55w6Ap1isqS9iM3DwDGRK8n9ic+TimKywGt5jrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(122000001)(38100700002)(36756003)(5660300002)(83380400001)(316002)(6506007)(91956017)(66476007)(76116006)(86362001)(6486002)(8936002)(8676002)(66556008)(4326008)(2616005)(2906002)(110136005)(54906003)(66446008)(6512007)(64756008)(186003)(66946007)(31686004)(53546011)(71200400001)(38070700005)(7416002)(558084003)(7406005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2UrellEYXM5NjBPYzdYcjVzRTNNak5CY0VCUWtzc1lENDliS05XL1dZMnhk?=
 =?utf-8?B?dGFiVzg1WElIeGkzZm1RTlBBeFBmc2ZuR28wNi9kdVVoOTJIMGd6VU4rSS9K?=
 =?utf-8?B?TzZBSWNzclhFR2NFa2s3Sjl0UTVhQTl4Ylo4d1VTZUJaR2dBd1lKS3BTSW11?=
 =?utf-8?B?Y2J3Z2JxYkM0RHZkQityMjlzNE5kU0FVL2gwMWQ1OU0wNE9rak9FM3dmUjRR?=
 =?utf-8?B?VFJsN05JMHZZNmc1N3FrS0w4d3hmd3lGUGxHckY0aHdzMFZNYkJCQUkyWVhn?=
 =?utf-8?B?VHN6eCtZbndHQVlwQTRlWEQzZ3NiNm9UamdnZ0hlZlZ2dk1zSlVHeWhnOHpw?=
 =?utf-8?B?aE04ZXFiblhLYS9mUC9Dbk01Wm1LM2RUQ2hOa1pFRStiekhCVGdYRm1wem5P?=
 =?utf-8?B?aExYNFltZWZJbk90ZkY1U240NVRKbnRVdzM4UFFHSlB1RklnWXpCMDAxblZn?=
 =?utf-8?B?RTVzM1R0M2pFNUxGTTgxV2UyTk1qRjRXTUdDVzFEYnZOSnROQ2xhb1FUTkp5?=
 =?utf-8?B?WkhaTy9JcWZRTEZSTS9aNGpSZHNNMnZiWStnM1VXblM4SWozdHFURVFBQVlh?=
 =?utf-8?B?c1MxcXFLKzNINUpqZ2Yvemx4ejdDcXNYbFdqTisyVTNDbmViQ0lxY3hYeFhj?=
 =?utf-8?B?TVppaXd0OU1ONS9pYTZPRFZNb3R2cGVlOFk5OVZYb0s4WmdueFJpWXJmRWtm?=
 =?utf-8?B?d04zQTVOeUllRUFnQ2w3d2N5bmV1U2pTRmpQZ1hiOWhaWStZOVpFSFk2Wkp2?=
 =?utf-8?B?ZHpGMDZkUU5Ia3Z5WHJPTFpnT2NXTmhBajZPcS9OV2VhY2VSQm5PZkNhaHZP?=
 =?utf-8?B?Z0tKUGU2WkVHV3cxN2NkSGQweVJEaDI4N1FySEp6RkJBOUttVmFGbzc2UzE1?=
 =?utf-8?B?K1VIdGZMdW9zeFFVRFNBMC9wVEdXdzlYV0hGRXN2NzFDeGJ1aFoyTFVUNmQv?=
 =?utf-8?B?Z1M2TTVpQ1NJZFdZS3JCNFRiR2hlcSttSlVOMzVDbC9PTjlrTU1zWDN2TEdB?=
 =?utf-8?B?bVN4Y3VZbkxWM1hkSHpwcEhsVjVNbGd6cklyaldHRjVMeFIveGFzb3h4T0RY?=
 =?utf-8?B?M3REaUl2YmNIaC9oK2w1ZTVhcFQ5blU4OUJkU1hwSTBjYlp3WEhhTkdXT3Za?=
 =?utf-8?B?RkVHdE9Nek5XZlBVNVJmZmtMaEdVRXBjTGtEbEMyNEUzaUFBUmdadkNlOFQ1?=
 =?utf-8?B?K2NDbWJ3SHcxVktZQ1NoVGRRMXBEZWYwWlpKMjdVT1VkbDU1ZXhLUnVSdHoz?=
 =?utf-8?B?MzR2UEErOVlYY0lMbmJZQ3RGcVppa0tHZjVyaDhhT1Y1UW5NeU1PTnRIb1dZ?=
 =?utf-8?B?eHp6NDdYU0pzck91UEQzYURIT3gzMlp0T3VTQ1Ywd2dsVzY3S0RJNmZJOXVm?=
 =?utf-8?B?TjNmbHlRdnBiM04xSTU1alhNcTVKT0JIMHlMUm8xZno0QXRoQmpMMHJSd0Nh?=
 =?utf-8?B?MGRDN1pJRmkydzluSUhlQkd2eDFJNldKdzY1S0FTNGtlTlNzM29kWEUyUE4y?=
 =?utf-8?B?YUNrdnlVSjd0b2VKRzUveC9SQU1lSG1Jd2cySjdTeU0yWEJnOHNuTWc0ZVdj?=
 =?utf-8?B?OU11V2tpNmdWeUc2emd5dnBOdUVSclVDOXJJVTA5a3ljdmthU1lybVV6Mm5y?=
 =?utf-8?B?Z2hHYVZtcHcxWTl0ek5kRi9EdWFWT0RlaFMwL2plRlhzNXQzODlKQjNTVmt1?=
 =?utf-8?B?VUFQNUdmZElZZ3JrS293M0w5TU5XTElrWFR4ZDR1NzhuUndPUmthM0k4MHVK?=
 =?utf-8?B?cENaOHA5enhjcmRZR0REMlFaOFpIN0pDS1B5KzJINldGR1pGMmhWcm90ck0w?=
 =?utf-8?B?Y0Yyc081RUtKQWY0NlZIOEpOWTV1YUNoeUQzdEdqNmRNVUNCajhyRWNzOVd1?=
 =?utf-8?Q?LLSYYjlw9Pj/w?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43BBE4AA93E9954CAC870DE93CD2159C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b45371-cc14-405f-24bd-08d98e998c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:33:58.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUXTUhN7+/pSfSk2Q8INU7sTSrLD8giM4dtXzKen74fxkniAVtH+59sgrSc9iRqeHqxYKyJSInGCb0g8228cXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTIvMjAyMSAxMDoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0
aGUgcHJvcGVyIGhlbHBlciB0byByZWFkIHRoZSBibG9jayBkZXZpY2Ugc2l6ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg==
