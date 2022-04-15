Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740235024C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbiDOFuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiDOFuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:50:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043440A20;
        Thu, 14 Apr 2022 22:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPk0O6tEDhuKAM7Ba1VETuhiLVSniDNnDNvDwLHweQAAMAnVBxm3felIgvdeeTra7y7bSarZJqus8iCg2G8a05R56VwwTPb9prcGd4hwbKulSR7yGpZZK0DIiy2w1OtrQ/OXYZIgIOUAqQpuEMclF4x5lKZR25hsxX4TwaouW3lrhbrhTSfKOFye3M4UGEIY7lhPwCt3rrHQJI/1/TNA8qG0xpGGr9WaY1FwDxpYQO3szLUZ4qWhfkQhrUadkieKa8XARdnnzfilPa+gi4KC7mym7ZQVRWTcVbxsud1nVZ6XMOO7pfwhsssTEkwZ3OUl5ijJfVWAc3oIB+4nqxgsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yccX0Ck38D03COpr5o1/1QaWpsfoh5G/DeZ7DRwbxA=;
 b=NYuJOrJ2zsP67QUGov1BM5eW7UCGdD7PFHZcAgDi9CeCT3M3kcCEoW0Lsq7TAsOf1pqsPw07l8apuGFGHGl0PnzWScuDRKr1YycpOUyXsFO6y+s4e9IzfGR80gz3IsBXLNkblPeU2rnsuob0/7YH5z7Qm3Ztmt3h/A7LYd/3wSBugjf12u0S3R2lEdrdNeBcsxwVSHWLHXUMrCoSZqCWh+RfqKhnUuo2tpcgbi1TwKmbNOh49JWMRQ1ofDpPCLhDkqEQQIN6RrKth/em4c0RZRWj6eoqtDFtihLTunVH3WALBowYOeC5VhqdNSixD4DXTwdKFqUgKceuMYLpjb+dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yccX0Ck38D03COpr5o1/1QaWpsfoh5G/DeZ7DRwbxA=;
 b=eexxlZfYMjmAdwt+eDdwGqGoSYW67KO1NX9sKkqRDCqyY6hBFpyBG+BpU+2/e7y7pWsF9bCw+rrqnt3vqhBdk7UFPEhEK6KOIRAYQsnOGAeT2l8jFcYcHUD9WieOuybNERv2EYDzEuZQ/N4THg5CILJmeXucz0BocQG462XQzWLIltv3jqhHaHzhPGaKxU/U9EdvRnZlHVUN57vzdDLRTmxYMdtUEhBY4IcaeLLCiIuhhWf+AaJs/GQADZOhGnvfvFDCMkD9MdnMzTwEVFj+4cHzzy/VTaNWnqS739bzw3BHJt+LWtQIDD9LcA0Q2eWKw05BiPxioGGadwmKdTVB7g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:47:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:47:46 +0000
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
        =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= 
        <christoph.boehmwalder@linbit.com>,
        =?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Coly Li <colyli@suse.de>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Thread-Topic: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Thread-Index: AQHYUITwHwmFqkxbgUOy+ZlMTcrucqzwd5+A
Date:   Fri, 15 Apr 2022 05:47:45 +0000
Message-ID: <0bf7bda0-0c19-7186-8492-ad894456d98d@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-25-hch@lst.de>
In-Reply-To: <20220415045258.199825-25-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 440487f6-ed5b-42fa-3422-08da1ea3778b
x-ms-traffictypediagnostic: DM5PR1201MB0169:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01694ADC34E9EBF9CD309483A3EE9@DM5PR1201MB0169.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0WkzUzQ88U0jXi33Plo0IGtu+s+0FhW5jG3JNBZuI1CKLpAQuJ8fdB5n0oSEDvIB7vtCVUwCDVnDak+yGhQci+LIPNUxWp++wHC1hN0hvK6+WkpkL8GR62mtNSqy32qx6VdPr+iA3Xa6s1B4XUp36Puun4ss7MpQhDC0nTJtIQeFe1cKWpLjuOWJknC69aUOCqLhAM0libwtB79dYPWbgHZemZJPhxnuizB2CNhUDJQ3dKXM4Yn7HsO5FoPSX9vQklzzVk2uHh2Bn+TtJtGdp5UDkrs2CXirUxaot1ufgTVZ7xcdBZixy9s7EJUyJ5Tjc77S7vWCZBsay1BpW/FEQIFBA4BVzuewtk/3ICyqSwMuA8c/Xz5L1hmc8wUNBd5PIv8BWshOrQwgeHptY3GPRsXoMO8tci2+txD0MxM86x/C/qpu/1iEdgg4PkneUcICTEn9vZthXp4SBlK87nyVWU9y1mXRQzBWJDpl0c46uOAsDP8PBlkqw1vsLuSPMBHdc8CWSe4esbPeMtUc9mDylh5JP8EwIeytsETljATJ7/oSit6Sf0QT3kumxL+dRyhXSoPTPQEgB/nN7oSytYKKuEbEiSiX26Gdb+sgZ4jZedikS6LUbA5BdATinxDZsGktNU+LGpbIlY2FxbXa1zJtiDN/Rcoqc3wzuNY97fPNLi1ijO+HsfaUyY0FYG4iVRx7b4+p9ik9NFbAjNKAuc/aow74uOFIpNEDMU1rLOB2McUDwTrBEb9xowLNvy2yZCnsc6FpXKfx6voaLB3duTybw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(110136005)(71200400001)(64756008)(8936002)(83380400001)(4744005)(2616005)(31686004)(2906002)(38070700005)(316002)(6506007)(53546011)(6512007)(66446008)(7406005)(122000001)(186003)(7416002)(76116006)(66476007)(66946007)(91956017)(66556008)(508600001)(36756003)(5660300002)(54906003)(38100700002)(6486002)(66574015)(86362001)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHdiUE96TjVSeVFUcnNxNDVCQXJQcWJvZmNqVjVmUnE4UlZCOGNwTHVFMSt3?=
 =?utf-8?B?bjFjYndwdFpxYzZuS2NYNkNsaThhM2ZuNEZyVDZUQ2ZpbDdLTHJDNWxER1U4?=
 =?utf-8?B?N1UyekVnZUgxVHVTT0lOaEtXcnMyWGl5ZjZhWVVHZGxBb1hRaTVaWnJOSjR4?=
 =?utf-8?B?NCtZRnpXWndYcEpjenlWT1UwMC9rV1p4aFpPZnJFVUhOZlVmRVUwOGs2aXY2?=
 =?utf-8?B?MFZsOXpnUCtBalFrbHd5SkJQbkVvTzBwZTNRaE9OazJiVFpMeC9uc2FuRnRm?=
 =?utf-8?B?THNIQlU4L0l1WnpFYkZYZWlreVU3SkpIaCtVempaZGkvVjBjdGVZRWc0czhz?=
 =?utf-8?B?ZlRqTlM2U01TNHJNb0ovb0RLTjdTT3VqclVXNnhoV2RjMkhNUmZSbzN2dnRO?=
 =?utf-8?B?bUJHcTBYY3pXQkVjcDBJcGEyM2JSd09acmhBUGxGNjAzckc2aDlXUnNkZjFH?=
 =?utf-8?B?T25xU2ZvRVdLbGQvYzJKTC8waDVMeFZVajFQT0ZYbytvQTNyV2o2eGU1VWFN?=
 =?utf-8?B?c0tKbnF1b3hQdDZlTFg4NCswa3lVK2lnSyt2SS8wcjhXVTZNTnlubjJBOW1Y?=
 =?utf-8?B?c0lFWnpBMmJZTnZnTEpEeW5ZVkVZWE1uV25JWDcva1FCanUyRXZxc2ZUem1I?=
 =?utf-8?B?aENwc1V4a2RjUEllRTM1THE1WmMxdW1oV2JmLzVZL0lxUU5mUmw1MXBnNWUy?=
 =?utf-8?B?QlNmbkZyMTRDOFFhMU52Rm9uc3lNcXNRaDJGS3VFczVUeCtSR2s1TTNBWkFu?=
 =?utf-8?B?bjZwSXMwL2NlZFRNL094Vy90elkrb0IvRXFvTGJCNVZPdDRhczIrRGZOM3VI?=
 =?utf-8?B?ekFUVmU5Um12RDY4czg5enlMdXpkVnNob0pCS3VyVVRQR251OFZwbWFjNmNs?=
 =?utf-8?B?bnY2YTFOK0E0QnRpNEhHb3RXVG16bG8xMjJXL25jRC9jamI2TG1NWkhmemdN?=
 =?utf-8?B?WlRzbzh3cElXY3Q4R3U4TEFBWkppcGtyaXdzb2dvdGgrK1hiRVFRQVp2ZWVD?=
 =?utf-8?B?SnFkT3JUbEVPejVZa1RYTnFiejkwRUhyZGR3Zy9YbThxZ3B4Z1A0S0V5ZnVG?=
 =?utf-8?B?OElVbnFnSnprSnBiaXlGWklUVUhJa29qRVVSK2lMRzhuWHlaNXZOc1M0eTNK?=
 =?utf-8?B?OFJHdkxRcHI3d0E0TUw4aU5DRndaVDZlQUhSeDBhS1ErNnViMnlIZk15OWNp?=
 =?utf-8?B?MWg4UVRncWtjbEs0RWN1MWhoa3pwaFovamVER244RXhwZEVlWVYyWXV2SG5j?=
 =?utf-8?B?czBtTXJtdGVKWjNFOUx2Si9SNm5kR2s2Y1BGMFFmUVJFWnZBSE0rUGw5WnFi?=
 =?utf-8?B?SFFFaDZ5YWpNRDJVa1dRdWU5MkxldVIwN01iR0hlTUJTQkdxMWkzd0lZc1Ro?=
 =?utf-8?B?MmpYN3F2bUVNaFVsYmd4bTlwbitXMzlPbUx2UmZENzNTUVdnNmhvNUZCVWRP?=
 =?utf-8?B?QU1qNXNHcWxpbXdCV2w3RFhNMlB1MTM1UFR5cUd0VURhMHNEcUpuUW55WjMz?=
 =?utf-8?B?WkFIQW9yRVM4LzJqWnRkMk9vZEhzdU1RWWFGUnBhWWZpUDNPSG94dGo5U1RL?=
 =?utf-8?B?QUN3Titmb3FqMytLaWFqbGF2QTc3MVN3eDZhaFVrSUltRTVMSlpsL2kwNFFx?=
 =?utf-8?B?aTgyOGdDUC9vS1pZSEphcEhKZ0J6SXZrbElxNTBQczNGSUN6cVcxditXYmNh?=
 =?utf-8?B?cGtOMWJ0TzdzVXA2ZksvcXJFYWhZSEJuRWpRMmJBd3JYc2NvVFc1c0NqQUcx?=
 =?utf-8?B?eXJaOXkycDBibEJuUmZNU055WXlBbHlPeDZpRDQwSkpoVHArTnFjZTM1c20w?=
 =?utf-8?B?eWd3eHRNYSthOG1NZ1BOek5UcVkyVTRSZDcvM3h1YXMyMFNjVUI5NlEybnB4?=
 =?utf-8?B?UkRFbVI3M3dBb1F5NFV6ZEVRUk51bzFCUGtuSlh0aU43MkZoL1Q0OEJDTFMy?=
 =?utf-8?B?VVRlSEd2cjU5b3VPWXRWTGd2RUp3bGVXOUtFRGY2SEFxU080ZGJqemFDVjlT?=
 =?utf-8?B?b1h6QjExNUpRWklsTVgyc3FESFgyOEtKd210ZGloYUZhTDhxaWVRZks1R2Vm?=
 =?utf-8?B?VnJaVG9YMlBTQXpsYlMwTzFHV1lETm1QbldBMFB1RmJuWVpCOC9talRRc3dU?=
 =?utf-8?B?bmlZamhlTHhKOHJURVozbXBXdHhzVEI5YzJUYkdSbjI0cWJMWTlVeW83VEVq?=
 =?utf-8?B?L2tHUFV4Mi9obGN2Rm9QUVk1K1lBTnYxQ1lCdTh4Z3NFTVJPWWlRMzBPbHgv?=
 =?utf-8?B?VzJXM1JVZ2pYaTA2YW1Id0E0bThLZDNVb1dXUHg0b3FvWm5JNnJ5OUNnMWFB?=
 =?utf-8?B?c3VObXVCWXFaU3d2YlE3dUR2QlRBQTF3ZTkrRTQzUEIrQmVwN3A1VTRzSEp6?=
 =?utf-8?Q?lLngOiMUsnjBXv80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B35E75958048F04C98F125EEE4A4B3F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440487f6-ed5b-42fa-3422-08da1ea3778b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:47:45.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppEpaEXyVIbVSePEJ7wcrxl3EYx79mbfMaGBhJoxUD4tL0hru/1v9euWD5zTV77oZdGiiMDXmH8ygtIW71l8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEp1c3QgdXNlIGEg
bm9uLXplcm8gbWF4X2Rpc2NhcmRfc2VjdG9ycyBhcyBhbiBpbmRpY2F0b3IgZm9yIGRpc2NhcmQN
Cj4gc3VwcG9ydCwgc2ltaWxhciB0byB3aGF0IGlzIGRvbmUgZm9yIHdyaXRlIHplcm9lcy4NCj4g
DQo+IFRoZSBvbmx5IHBsYWNlcyB3aGVyZSBuZWVkcyBzcGVjaWFsIGF0dGVudGlvbiBpcyB0aGUg
UkFJRDUgZHJpdmVyLA0KPiB3aGljaCBtdXN0IGNsZWFyIGRpc2NhcmQgc3VwcG9ydCBmb3Igc2Vj
dXJpdHkgcmVhc29ucyBieSBkZWZhdWx0LA0KPiBldmVuIGlmIHRoZSBkZWZhdWx0IHN0YWNraW5n
IHJ1bGVzIHdvdWxkIGFsbG93IGZvciBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2Vu
IDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gQWNrZWQtYnk6IENocmlzdG9waCBCw7Zo
bXdhbGRlciA8Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+IFtkcmJkXQ0KPiBBY2tl
ZC1ieTogSmFuIEjDtnBwbmVyIDxob2VwcG5lckBsaW51eC5pYm0uY29tPiBbczM5MF0NCj4gQWNr
ZWQtYnk6IENvbHkgTGkgPGNvbHlsaUBzdXNlLmRlPiBbYmNhY2hlXQ0KPiBBY2tlZC1ieTogRGF2
aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPiBbYnRyZnNdDQo+IC0tLQ0KDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
