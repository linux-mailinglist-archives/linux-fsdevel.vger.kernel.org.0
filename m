Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD724502456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiDOFoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349774AbiDOFoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:44:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43931120B5;
        Thu, 14 Apr 2022 22:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMNCqekaQ2PPLXsItKoSPbv7xKyBM8FG4bDYzsTI8p3pFlzNiSFLFYL/K2KXbJfY7llLFks4m3mdrdw3EVEtYAX2siioptEBYZ3FKx7C/tiq5/JYQ4FxJ+76iLsBi/LluoLaUyataCSrWf6pJFKGdGYGrNnAx3nugwCi6ejqpAuWnmpRudBM64DAZsSFdYFgpSNAnoAE0dq/s8h0UMwhonjQG/Y7nm5FG7X3CWA9Kh68T2P2LpiuqyE4BfwIU2kg/+bN8Mp08nncID0B2wemNSevI4kIA4kbinB+m3GQuo4y3Aq/jtNOLsUhPkTHuji08+uKzfLI0x5oVeOLCqq4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FqhaTrfUIQ4NPWF8rNUYFIy1CuNkuH68bv7RBix4hU=;
 b=nuaIirgzT8DzctS5Y9j/d2kyd0lW3DM5qrq/AXm0vasrNszSA74DN86ufg+ORASklF44xrj+ptqmPyYfDuCdb++JXyEt/OyILP/AWa1FaBDmEanRIcLTW3cTMUJJxEApdlf0P0lOCxpMcNlq/leITabTxivbxpXreDhZ0aBnvdzyOs6xaFRYIBE9jczIsTwvKlH78i4uy+v4PHxgrMTDagBtYn4RKVmBZRvdKSKilJvPkb6TCe8WwsaWXPDtGd3pGAzgvPi+A9GDlcHzuj7rI/77IS77QIdRX80JurmTBhmI5K76W99fnlsE+agJ1STzKPFmajXoLIJVGsEwDe6DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FqhaTrfUIQ4NPWF8rNUYFIy1CuNkuH68bv7RBix4hU=;
 b=tODTqjlAlsHeCHfKrGBmp/tDHryUzAA7ST5FHPcQ4MnODbRHDx40ZYACQv3iV8osnIwGU7mI45cL8QjiiX3HNHLJm/2G45jzrmT1Mc0fYmxAOaiV8rCseFGQ3tWvtBtqOKkXO7telm8RCXpcS8UehyxM3hRkrZHHNRI/KkJP7TEMk7gyB43Ks7EwAYOKDdyp+T6bLCR3kCDElDJEGMMNcCAvCxWOEUoPtjl4p0bl82up+6InTGQbswUlW4+y9UOfW5KkeRkP19LusgWV8XKdeXad5d5ZC2O8KmLypNfb7maetucp1RfqAl5zZNiLBqeh9L94vpoq80dB5LzJE2dZig==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:41:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:41:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 12/27] block: add a bdev_write_cache helper
Thread-Topic: [PATCH 12/27] block: add a bdev_write_cache helper
Thread-Index: AQHYUITdob/Ugwum8EaYZwRM1yM7v6zwdfMA
Date:   Fri, 15 Apr 2022 05:41:46 +0000
Message-ID: <cf0b3178-8823-4cb2-c987-db76e005ac4d@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-13-hch@lst.de>
In-Reply-To: <20220415045258.199825-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48830246-69de-427d-1f12-08da1ea2a179
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1815BFF38ECDB61E066BCE78A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QukpvFRWGEJB2QMDxopY+7PehX7V0MCO16Kh18N7kY4LOzr9YuBq8I+WJa8MvCoM5twpadFcdPxd+GRpk+xryAGpEsKBOtHwdFoHJSkkARPlYe13Te+9szYCWxaNM/i8IRBLCZxqh1GJ30cPMCf9I+ua9PzkMxrJIFIsHawZ1toOQCPTN3GsLd7BronqU3M9pLSvHmxKCVfGHnuxLHaMvcysmwRv1lTdiKN++/TAKBYwtptwP0kT3tVJB1Xh0KzR3m/pBOgR8es4hNmVTf6QzA+RFLSk+P3bZHwY6wX5nDfSFZtmtt740wSmNkMIdD++XfLcRV0X4jwL5qba1Tui2KcPBPz8S5wyx3RmD/YxTxFI9ZhP81i9HPrY5m3kkP6EobNmIYtVi+X5db7S68Z1A1RnZoawXaSALScymo19klGFGU4il16B+3AoRk9pNOSfJ+q0/jcfJsbO3ftz1JrKnkLWDs34mDZyRcmcEqxE2nsNTl63HJ7Pz0OhK5YKWCL1QvH+pVK1qvS/ZHQRCqC7cqfHmDOZqAOvoi6Jx4WT7AWoFG0cXsMwCzZrQN9nj062h2CbUX6EdW4xQgty0PGht7c3U7fKr48E8zApO+g+NpHOISkyfSXJxb0C1Tyr2hA11F9Q+TnT18ReXZLRWu1ToFYQK75baOmk5HMrOFAM3fLJRyug6J95Nkh+gWiDtSa9twCfF1M9EXacFEk9cl5dpXFezGiAlPle5HX2rjSTdoU4GPrIA4/u/0V1SVv5Uxdg3fWlCfeHiNwRGj8lO8uNfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHN1U0pkOSs4MDNHMG1yMkhRTUg4b0M1Q0dRTUVSWGRyYXc3NlN6NWhVcy9q?=
 =?utf-8?B?V1NoZDdFVjdycXdrRDVMQUVGa1B0TndSUWdhNE90ZEh0ai9Pdk4veWZhcDd6?=
 =?utf-8?B?cXFmVTdTU29YV2hFcGpSQlpxMEpvV3o5M3lZelJTUXN0d2w2N08wZU1EOTFS?=
 =?utf-8?B?ZjU2d0JneUdXR0owQUk2RUlmNHZqZlo0aTgrQTVFZUdKRTZjL0NNT0RyTzVY?=
 =?utf-8?B?OU1NZ0xmNVVEQ0laalFsNDVYMExkaklTSTI2WExpTVA5UGwybk1GTlZYMjZS?=
 =?utf-8?B?dEtBU0NOWU5sblRkRGJrdVlGNVpsYlNUK0srUXBVdGdFdHVURXZCd3ZrYmVS?=
 =?utf-8?B?ZHZnQkVYSkJRdlFlaDArMUJQUjhsMDlKdFJvTnF4OU53OUVHamtkUnZ0OUNq?=
 =?utf-8?B?b01GZzJlQk9BMFkwb01INi8vbmdUUGl0Q1lvc2Q0SExxUVJkaFVuUHNSNUdC?=
 =?utf-8?B?Rng1b2JMNjBlTnFuWEgyNGQ1SGcybVV3Ykh1YlU3Q0krbDVYYnFLUHhYWXV4?=
 =?utf-8?B?YnJKMElIRE1SQUY1VHc1YVc3SDcwd21hZzJPZUdGWXhzR1c4ZEpPSXB0dDhM?=
 =?utf-8?B?b0Z4dFVBOW1tR1Q0YUR0aXBWYTlCeG1RVFpXVHorWStVK3VJRFY2L0hhdklR?=
 =?utf-8?B?bHR2bDliamh2WElncUJ4emFZVjJRejRZMDV2KzhhTW45eU4wNGRPSC9qVGZs?=
 =?utf-8?B?d2RXNWlXbmhUbHBzWENxcGhuRUZTbFcvTU1RUzRjdzFiOGNaSGhZM3A4Vkd0?=
 =?utf-8?B?NkphNkpONWFuNmg0UVlFdjZVK0w4OGd0WjlTMWJvRTRNRERsM0ExN1NTallZ?=
 =?utf-8?B?bWVhVVVOS25ldythMUN0NHlnR1FpbENUV1RpcE1Qb0hEemJzeis3UDhtN2Qz?=
 =?utf-8?B?bXZZMlV2RGc0dHorUHF4RmluSmd1SmZ2SjBKNmN2NmJKendtMGFqdE04U2x0?=
 =?utf-8?B?Tk9mWWowQ2IrNWVtTTRtZmNNRitVaHcraXZOODAreXVYTGw1MVJROXY4c3Z4?=
 =?utf-8?B?MzdzWlVBaDR6UGJrSDBuQVZYcWVPUndOSGl5dklGQlZ6V1hKL0prME05aFE4?=
 =?utf-8?B?MERSbVBMNEdLZm9zUWdBQS83Yzg3VmN2WTk0NEFzc1NYRUZpdnlOYXBCakxq?=
 =?utf-8?B?N3krcHpSQTB2R2s5Q2d1VFQwc2FsSlkwVlVpQy9BWk52b0lyamExYTdNejhn?=
 =?utf-8?B?SXIzNldFZ0JvVUtIRmNQUlhmWHVwczV0cE8yRkJHSEE1UXNnZm1oNzJBK3Nw?=
 =?utf-8?B?aW1yaGpXYkRod1lJcVo0MzFTdlNCYnZETHptOFY3ZkdDV0pIaVRsMFJiblhE?=
 =?utf-8?B?UzNhbytweThWanJvZVl5cXRwTmlKTkJxNytGNkdsRUNnN21USThYV2JuZXhJ?=
 =?utf-8?B?SVUwUjNlT0t5TDc3YXYwdStKS1EzZ1NvVjB4TGhTQzBnd1c4VmhOZy9RRkMv?=
 =?utf-8?B?aWhWZVBUUDkzcDlJcGkvOFpYNnBkTGFWOU40WjRzckxYaHdmL3RhaWJnYUZw?=
 =?utf-8?B?Mjk0UUFSTlp5eWZ6MEVockpJWTE0TmtzTjhXaDI1d2h2V2pqU1k4R2FxODRT?=
 =?utf-8?B?eUxLS1hVQWEzVzZFR1hQOXh5Q29mZ1NJQ3NYS1U4SHQxMmpXUjkraWxUQ0gw?=
 =?utf-8?B?eC9RbWVsMFFKUTVoNDhJMHhyVXowbkcrSml0RWx4S3BzQTBpWFlmYTdXOGpZ?=
 =?utf-8?B?endhcXN3anl3OFY2TG5DSERySE55eGpyaVVwbklMSlhhVW5DN3UzZEFRZUg4?=
 =?utf-8?B?VVhQdzAzMUI5UUFRRzBtZDEzdlZPOVlkd1FSMmdwRERGMzJYUmhzN3ZKU3RL?=
 =?utf-8?B?QnBxeWxodGRJQ2N6ZExJcjdyS0FoaC9PaHhyaWNjRGc0SzRPOERubzVvbyt3?=
 =?utf-8?B?emYzL1U2WENJblEwL09QYWVLYmZZTlJST3hra1htSTRINnBJbG01OGJZWVo2?=
 =?utf-8?B?WXFSZ1JPd2lBQXRiNmVycE0zVko4YjNTOThsYjl5MmtPK3FpOWsvc2hQUEE0?=
 =?utf-8?B?SW5xMFV5eEplQUlEdFdxR0NEa1NSR3gzNm9QdUpHZGdQbzdTK2JsSG41QTBZ?=
 =?utf-8?B?TEJSS1planUrZk12eEtjeXh4TkNLelNNK2ErVlUxbWJ3dlZHaCsrMUxHSHZ3?=
 =?utf-8?B?eCtFLzBnOWl1UDhRcWlEcE9neGRJdGtFVkZmd01iWVZuTVRodUgxM0JhZ0hQ?=
 =?utf-8?B?K1FwTlE4bHd5RWRrb2pxaUxXajNmK2UvZ3hUb1h4T3dGRk9QdUVyQjFoSzFD?=
 =?utf-8?B?WVUxODNxcnF4Tk9uZVBGOThiTkFzSTJveHlzbWU2TnJ1bVZ6SzVrY0R2Q2xL?=
 =?utf-8?B?Um5kY1MxL0NhaHlYTm5ZSnB5em8xSXVqSWdYMnhSVUM4OWY5RmdGSmNiMFgw?=
 =?utf-8?Q?yoCsm6uWvQ1a7EMM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80FC9A4858701045A17542A9B486AED5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48830246-69de-427d-1f12-08da1ea2a179
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:41:46.7857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1I/HGrTepjPrJfyDJXvAhA0IGeyaOEbNK+YAiCNuMMlAxhtbd6TSpK4UrJ9KB71YHciDco0PVv/pgbmfpPENTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIGhlbHBl
ciB0byBjaGVjayB0aGUgd3JpdGUgY2FjaGUgZmxhZyBiYXNlZCBvbiB0aGUgYmxvY2tfZGV2aWNl
DQo+IGluc3RlYWQgb2YgaGF2aW5nIHRvIHBva2UgaW50byB0aGUgYmxvY2sgbGF5ZXIgaW50ZXJu
YWwgcmVxdWVzdF9xdWV1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4u
cGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gQWNrZWQtYnk6IERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBz
dXNlLmNvbT4gW2J0cmZzXQ0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
