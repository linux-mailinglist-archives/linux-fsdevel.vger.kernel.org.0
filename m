Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCE5E56FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIVAI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVAIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:08:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18DA4B36;
        Wed, 21 Sep 2022 17:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw63aK4ww5/vGYT5ZwG1VrZCTJBh3V1u3QZPKjZhJUHbBuQMKQPgv/PVV/+Pv/cvZyUFaDc5OmjnYQEV/zWotekm3gEYh4HYtOxe79jflTLjK51dA+rCaoXHuKFHxLTnh4tSlwmZlPQMVQ2Fzk2zWcJf8ZwgM1FmnAbVXlI7v8cbxd3kkY/maMtZ4ljQ22DPwsJBbT5NY3hofwMT+aF0qPDwkBarhdvQLZbJrJxEPd/8fd47ozuYNLhDN9FjZsrsIKFkTzcJ2AZDssdYUQ9jr/nsngLf3FphO467zh19E8cIj7duo7zrkP5cGdbQKAb5s4/Rfi2qa+EEN3KUuwyMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV3Cqntf3tZml1xMFSBc5MhVlBhF9CWt6FBQX2NKAvw=;
 b=ahjDaizw8TWjJS959098A38RhMCgdkqmL9gBXvsjik09/GsqfEYGALwkRWOd2q1dbYGgf8YI89vnZsOoOhyIT9SqW3uOPeKNfwA3E+17e1/0gIya4ZblgjG+79BOvjK4Xorgn/BA7BIQ92C+ZE1kNayjzr7q0VZUXKybS7YhsjFi78f9zBIR3BLFq02FTX+rbvwpEJs9uqMbS3+ZPMD15HLfrsKYhqNvGbsdRXoZ36vgsWjaDcz6mMbBak1CQ2p1bYmcuwD9HJQ7D4sClxG6RfNA33l5ken2QIkIY387/iwxx+P1/Dq5j89nS2U8iMALpnT1WZ0iaDdrqa6ROdH6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV3Cqntf3tZml1xMFSBc5MhVlBhF9CWt6FBQX2NKAvw=;
 b=hi1N6L4vyIwr3tO9vKO2PiiA0SxXapAgdCSyyG+zlGh52P4Sq9ca9SY5MFOKV8TdwsDMGJ5S3+l9G0E5YPjRnI1RgOXgIxvLidFOTcWIGeawRT7u/AW1c+RdCiYMsZ9pdVOL6a3HD0qvFw6WvCCrAUR7XrU31RR2bn91MtXvPtUXBy9R8NVExEHq+4dFF4lTIW0UT0reyzBAG3pjOjJWWS4qLow39eDUepJD5m2XKaKC74/EoxMdjAue64KQ7KZ6DcBnkG8C2Z3dWR6uHvnRdTYwyG6vwkUY0LQC6Dyi6/WoSVkNq4/GMe34L3mvVv31yIdJSfoJpR9fG+YdEgbn1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:08:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cf90:9a08:7869:7f32]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cf90:9a08:7869:7f32%5]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 00:08:49 +0000
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
 <YyssywF6HmZrfqhD@nvidia.com>
 <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Date:   Thu, 22 Sep 2022 10:03:26 +1000
In-reply-to: <632ba212e32bb_349629451@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <874jx0nud3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: ME2PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:201:15::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 585995a2-976d-429d-22bc-08da9c2e9fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2nIuyHpk9K0/HCvb68/6bxhXk0jIxPzaOR78Jl9LiWd/v1hc0Mb1ck5G9K6WKAZv6Txei5ow6Uj3yy1B3dFxc3v6Iw8gKxe4R4ouBMes2XjOGN1yP88cpSsaKI1ZGn6Bz98yF/RTYaNr+wn3964q/Cnbb4FYckVBP0AnpV9hURoxinDPURGQrLiaE/lq/Xt7fWwFpleSzHsTDAjor96CY/AhzFVDgTJDrHSAUW0KrJz5TZDLx1YqQhb9g0w8pzF2CkOmotlcHi62q/rkbeAH9qkgukOU6Q+g1xdjJ+JpHhyAleYXWC0HZE3MTt6gB2RNWXSvfHA7zrVTKRx1o/Ocbt6y5QDN9yY1aNMeWA9bQ5MTIDIgVEbUgTjgY6BMZfedb47/T7JW17DE5sz/8geL2AJSYJr0TLTJW8TUAudf15W8MD5r0KPLv6K0IvyenlYXAkxs2YrmdNwHNNT0/M4edchxkavCa5rWJ3lGxm8yOrxOWC4IP/LtkZIUrm39orBALwokA1Buo7o1idIIyKPN3N2AETqEg+x1fgqSHYeMf24vsIBA4Vd0vfIpMfTzEaarFaDJRZtEVjzstqggx7rHbF92fQ8P+XUH1Z2i5LOCqbitR3bAAjvomRxXv4T95gXcI9qVLEjar/3vcuvpgCnbeVYzxD+YJzEG2CSPBABWLZfslaGAlwkXzoKXKI/wtMiIxZnTty3SNkmpI7i53X6AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(54906003)(6916009)(316002)(86362001)(38100700002)(83380400001)(6486002)(66556008)(6506007)(478600001)(8676002)(5660300002)(66946007)(4326008)(26005)(6512007)(9686003)(6666004)(41300700001)(2906002)(66476007)(8936002)(7416002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lcl6p7KpolnFBVmgvLwLDTPrcxHUufMFfc77fQ3FXM1CXGOoVhCT1dsfMJsd?=
 =?us-ascii?Q?FkB2j1wJR9WnR2H6yFCNWF5ZOxEE0kg7e8xt6CKVOZz6cuSs4hXHqzadG1Vd?=
 =?us-ascii?Q?LhZ9wvl0FOn/J+GJFrMdBEIPERurSvzYeLJboHYOvcNAvlrBcrFBXYFjevmR?=
 =?us-ascii?Q?HEmaHb9P81+htHhuZNinDtJs2tw9D38AAl7Rvag8qIghQ8Pi+8Ie9PZ8HIIm?=
 =?us-ascii?Q?n74JWdIY8rLwVdzatkhHt7W0TqxRn5NYaLoC57k0LEfR6k43gJwFItA8wkh8?=
 =?us-ascii?Q?QAJXQsq8nbBs1O4ejiSqJd22XuSRsbn3MUht+0erCUTy+XV1KS4cy/q85jxN?=
 =?us-ascii?Q?B7jo7NxTsDtaAxh0sL9DZt5aRbYgHoWocmxywmBMc+cH9xAskDzquGrYL6ar?=
 =?us-ascii?Q?1yDmu+Axi7m1DCuJTujI5mviOIHM+cBP77Znn5ddVntFmR7zvlElE41Q/g+z?=
 =?us-ascii?Q?9dNnWGVgwo+k7JQII5Am1sSM+MLkFB4zs1LXcFHOadqnbqyJlM0spQHP5CmF?=
 =?us-ascii?Q?QRa35cwL6vU9dk/zM6J9+0TyHRNahpn4dXFmP7mwP8OfbqIbZ1+n2PHDdhC3?=
 =?us-ascii?Q?90KpEbFp2wkfQBr5De/Sw/2UTqVtddPe2AxIPkjRRWxdD/rIdYA7SJtgTWjk?=
 =?us-ascii?Q?O1kp/QaSIOufi6MME/MMOec3n7TG+Gv08yBwVcUntOWz7DfiNGvbj4RuAKcx?=
 =?us-ascii?Q?bXv+YKnGSV/Lx4SSCEbrljMuwTAMjp+eVmTy5qLpf7AKLnGWovnlXu69y9fA?=
 =?us-ascii?Q?XjT4/7FvYNc5exMojzmqu184VlcaiU+bDGWV531ObI8RCww/O5VAKnYzTMr7?=
 =?us-ascii?Q?0A7Z7AZcUURHyr20+5FrYk5LYGovNsX09mieUvi3Cc1UuyZv6hBzeOnrKNm1?=
 =?us-ascii?Q?14nCUT316oHwFv9TDYHwVJ8VY21dPWhnoI1bV6jLc4dxsoYaUhKm8x+tGYer?=
 =?us-ascii?Q?Lsm+qkoQukH6LXR8Tn+xsJsEIZdHkYVLclr9JDde8+cPQRb1Io2YEJSqxt6X?=
 =?us-ascii?Q?tZYyUV2WZxL2X8yX+tD2+YSViK683bCLIDVFFyTtV16u5Rf3/KJQbSuZmBSz?=
 =?us-ascii?Q?VL5auIpR9Cl9aPI5l7EfU0gjP0/urQvKAbvZvK/9yGLrR7TELEU9/kpN+DY3?=
 =?us-ascii?Q?yRq0iosAF8wLe/DBmYHeXmn9B/d6wUBseX7a82UBlLNb+5LBLF2aYbphQ8ZC?=
 =?us-ascii?Q?1S4UqXumvZXs/Mds2aCfmg02xwtl1YC2C/HOMcIodpaoE7gT1qVOl8tf8vfa?=
 =?us-ascii?Q?A9x70NfYAGeNId6Nlg4b+bQA+Q81pt4rqjT81nvmGcGiFY1hAwRcWL84t4/M?=
 =?us-ascii?Q?kPGCcIXJnb/4il0/AEi9Tv1hKDsTRiqgMl4LeRvRUsiIXascAWbFIlQdyb3H?=
 =?us-ascii?Q?VjDLMDjNKGmIP28uOhGLFtNfiqVFCrqu+Y1qaWSSAOCi8/iFHbajJVCHMGCO?=
 =?us-ascii?Q?nP/U9jRqk8EQQ+6T6A4eNdo8tOSBftljo03mCLMmo4dlArYLzQKr0dZwc1H8?=
 =?us-ascii?Q?DhTjTGK4DwiC1r3qCybQ20R80a4hh+levLg8kvAnu4K8tLGg+31pUHqURrR8?=
 =?us-ascii?Q?T00YMsTGG8LvcpHdK79izC/E3pO05GdyHOzOWtaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585995a2-976d-429d-22bc-08da9c2e9fa1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:08:49.0349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EWclFXLmWD/f7zclykaTOCMITZ5ZdO8YzTc018kQYQZSvRpDRbgLSiBWFuPrYmf+/axyaapCgi3yp30mdzmFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dan Williams <dan.j.williams@intel.com> writes:

> Jason Gunthorpe wrote:
>> On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
>> > The initial memremap_pages() implementation inherited the
>> > __init_single_page() default of pages starting life with an elevated
>> > reference count. This originally allowed for the page->pgmap pointer to
>> > alias with the storage for page->lru since a page was only allowed to be
>> > on an lru list when its reference count was zero.
>> >
>> > Since then, 'struct page' definition cleanups have arranged for
>> > dedicated space for the ZONE_DEVICE page metadata, and the
>> > MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
>> > page->_refcount transition to route the page to free_zone_device_page()
>> > and not the core-mm page-free. With those cleanups in place and with
>> > filesystem-dax and device-dax now converted to take and drop references
>> > at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
>> > and MEMORY_DEVICE_GENERIC reference counts at 0.
>> >
>> > MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
>> > pages start life at _refcount 1, so make that the default if
>> > pgmap->init_mode is left at zero.
>>
>> I'm shocked to read this - how does it make any sense?
>
> I think what happened is that since memremap_pages() historically
> produced pages with an elevated reference count that GPU drivers skipped
> taking a reference on first allocation and just passed along an elevated
> reference count page to the first user.
>
> So either we keep that assumption or update all users to be prepared for
> idle pages coming out of memremap_pages().
>
> This is all in reaction to the "set_page_count(page, 1);" in
> free_zone_device_page(). Which I am happy to get rid of but need from
> help from MEMORY_DEVICE_{PRIVATE,COHERENT} folks to react to
> memremap_pages() starting all pages at reference count 0.

This is all rather good timing - This week I've been in the middle of
getting a series together which fixes this among other things. So I'm
all for fixing it and can help with that - my motivation was I needed to
be able to tell if a page is free or not with get_page_unless_zero()
etc. which doesn't work at the moment because free device
private/coherent pages have an elevated refcount.

 - Alistair

>> dev_pagemap_ops->page_free() is only called on the 1->0 transition, so
>> any driver which implements it must be expecting pages to have a 0
>> refcount.
>>
>> Looking around everything but only fsdax_pagemap_ops implements
>> page_free()
>
> Right.
>
>> So, how does it work? Surely the instant the page map is created all
>> the pages must be considered 'free', and after page_free() is called I
>> would also expect the page to be considered free.
>
> The GPU drivers need to increment reference counts when they hand out
> the page rather than reuse the reference count that they get by default.
>
>> How on earth can a free'd page have both a 0 and 1 refcount??
>
> This is residual wonkiness from memremap_pages() handing out pages with
> elevated reference counts at the outset.
>
>> eg look at the simple hmm_test, it threads pages on to the
>> mdevice->free_pages list immediately after memremap_pages and then
>> again inside page_free() - it is completely wrong that they would have
>> different refcounts while on the free_pages list.
>
> I do not see any page_ref_inc() in that test, only put_page() so it is
> assuming non-idle pages at the outset.
>
>> I would expect that after the page is removed from the free_pages list
>> it will have its recount set to 1 to make it non-free then it will go
>> through the migration.
>>
>> Alistair how should the refcounting be working here in hmm_test?
>>
>> Jason
