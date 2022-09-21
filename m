Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3999F5C012B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiIUPZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiIUPZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:25:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDA4DF1D;
        Wed, 21 Sep 2022 08:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGMoqRo1mLnX9i+o0i4O0F7FYj6qLkUyoJZj+aDho0TSmMXUAs2nSG6Xvt9OJi/GVk0eMcW9s9z/2wT7RNDy5oetTv4s/xeXAoHpS5+jDMTjsD8wArNHQha2A7aqtmoYH1uin67t1RXod88efUVHpAergSmjfFWpcHrkNZbIaJNeFYYKXxmIhNeT6SsVEordIXvRNIkUHA0MTETXIC18XXcMGdooc9/KmV0M/z4kHDEr7xQilXrGgw2SBNWJMciRpwuwoSEZnbwlYvBXTTHOVjrVPrhFdo8F/JG3HD5tnj64cvc8FXxa9ZKBaUFq4CjrdVrWcbwes19Mzec25agzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCGmxhVYM+8WceLLNg1dU35al+oAr0gLUCiCoHCFoZU=;
 b=F/f1s17Lky8KicK96TKPxpvdLC+zIt/mqZ87RA46diD119n0JfTGE4DCkUur3QK+cpyF3AwTtA23dgOs+6tmjCp9XFZmy9lcNDuopBRUM1cJNhcnFpbd0HWrGze9H5gT/LrzOXJP9gSD4EI60ygKUJDcm+euWcE3Fd3j5r84BiMrNdv8RhCbR28a3/iRILoqg88E1gafQMG75Tsj6yQkZI5UdVoSRGjt9Kj3lYAYJxVI42g67hPXUIZdzw5RjmnilPPnfg8ss6nBLBZgpo01bcYzNhMNzpeBgKwGqO5bMSK52z1+XWFwBneZbh8z/EymQGzlneuJTTs17ZdOwE1Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCGmxhVYM+8WceLLNg1dU35al+oAr0gLUCiCoHCFoZU=;
 b=Hrso//CB/uyPDalq4c9w0zJP1xVlTr6XQuPckHIV0xzQC4VoCCWl407Z/C91XcqIGe+H/1rQeRU+OljnLKYWD+RAdnABNo/S90I9e164KF1U1eDI58Aal8wJgcj5zXRQ+yVQ0noHCftMNITgLz9vBIT8c435wOdwhtkCbkr7ZjcHyr37rfTAOlkCQPTz7KqYn636bymoiASj8IH5drh0ScRuMz92oV/RqH8VApXhCsMQwjBgFAkR38Koc2nz/8wWUWStlUdDpvWU2xfQ0m3vBhfQJAUayKFUJ3WY6jQ6S9EoKDbtPFihutWglxnbCULIRrnWlCElK2TnH4eto70DAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 15:25:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 15:25:00 +0000
Date:   Wed, 21 Sep 2022 12:24:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages
 to a zero reference count
Message-ID: <YyssywF6HmZrfqhD@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 20937e17-6dc7-4343-3948-08da9be572d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFKLMdpQ7dsou3Y1Aq06fq2zRNqBOwe4ofUQtS5twUH8WRApp5wSFSMukFKTbqejg6y6d4P9BTNAbtPq3zuSgg6KoqoFlocBQ99iC0V4H0IXfZMTjOkoqtHy3VkUgq72UA1zPPpLluGa0E/RN9aCcetJs9uV7HpH1ktOWWZ357E+fsVx5Zj6Oht8hmU0vtys99+V6qytt8u9VByn/lq5cNXDZDq+YeTCUpbzgq8+KvaA9ZMxiWl2bBiOQDeJEulPIqnI7BjURHHvZgnb0zpBY1Hx2CmNQ5vwKvDSe/n7bwpRYU6UeSd9k91HhQmCAIg/PKbWrFMHDIlJPcc+WxL37lB2gAChBmVMPDFCEfDZiqjFOHf/N+VnmUO6ghPoMZnn7OeO+qP3KgMWastXJVifvm+cNsniOeg6y2FmimVRdmtoS8BdRnt8UN3Rqehbz89fx4eNxyfquXZvmNToAJ/mmolR9mrApJkm3t3AqPhVWzDWPxtq0x4wNu9EvbmnQCI3iocjdLnTMRF4zQlfCfDcVxNV2XafXUo5Kn61f4nqjV+6ECYkBb4ZoFCEJ3gYbqsg7LeD+fhuADzj+UOR3YDjqJ6OTqNxEZsfp79fJltUliNiGc/rWcaeuDAmX+99gH8K0MPrUVZSlHKV43mE3zAfxkpPDlgxBxK9YC/1hpjX7aiH+j7Yf66TZOjp9zMIJM2yuHsYRsFM+RE3uRM3USSoug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(316002)(478600001)(110136005)(66556008)(66476007)(54906003)(6636002)(4326008)(66946007)(8676002)(86362001)(83380400001)(38100700002)(36756003)(2906002)(5660300002)(26005)(6506007)(41300700001)(6512007)(8936002)(6486002)(186003)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0YOaWtQAP5hwvDbQdpegHCXsZI/m1lLqklhpMBjcmyGjGh4KT/fn9MJZuSm?=
 =?us-ascii?Q?Esg723kC/Emv9l40NDxTVinGPJByJGTIlykzwEvC0x3fFylnqU8YBatGNt8h?=
 =?us-ascii?Q?VXJR+QbPp55f8EAvGp9L6oX4F1+/9Jn5Sr95vIReH8QKGgqwUsB5Jdk8Pc2T?=
 =?us-ascii?Q?gKoF7FHkmVYe8KlkqU9JhhlufL2LMf9Lcv+QySyVmn+mN/Kdz3hfcl+97w0Z?=
 =?us-ascii?Q?SsdoT7e6L/fwD4FGe2gB6lCNfBI97tYX3Pz3ChiN26dZc4rwZ6/0A6iSN+4r?=
 =?us-ascii?Q?TfdD7IXowCdUmi2n+TSi86Rei7WvjKbDECp2zVjFmCM0ZbmzXnXRkRTWD9lm?=
 =?us-ascii?Q?hcwxCWkPcOIDyJJDvMoqjUTKyDTRXl3doSJuzWVqgafHGAmmSrYevKEO1/Mv?=
 =?us-ascii?Q?QDuEcRu/frUGmZ7ayHeX/cadudWry+9a9Kc96trsLcQmMirJzdhC7QXyndxm?=
 =?us-ascii?Q?Ux7ee7xGDIki+ZI11rbeJsV/igP5Yz2CAGfyqEfEnURUiWfBY9prGBnnF7r7?=
 =?us-ascii?Q?AMPq9ZGfwpx4wfGFATFnZV1/AsCYUcgsh3egXl5BjZIZraYVEX3LMNAUdwkX?=
 =?us-ascii?Q?Hztq0Zi8wGNIfG7BB70n6CfSmluxknJFOAcgNn1r5qDgvRA5b9O0eGYR6lc1?=
 =?us-ascii?Q?ySzHJjcvmh1KQAjAU4Tk/+1N0wqjv9D8NGk4s6pUWAFOuA74Wj92Pfgr0kgV?=
 =?us-ascii?Q?Q3iMafgb/6hh7PTiwfqPmm2hlcRsVrCAX00nUoDeii2FHqFK6g06/vXRuxV0?=
 =?us-ascii?Q?xDRffalyCZPtRyYqy2Chqtf5FoCJ6MLAfhCNhXBkO9U2G6Afrj6p4v3N13io?=
 =?us-ascii?Q?IpF02sDQ8MZzakMKvHWkxFzejxtC68Knsl2GCsfouQNLkj/NQvfcjfNbOuK7?=
 =?us-ascii?Q?6e70fxicxRbFrcMYt+AiLb4h8hjNZqObIrYcfrcTh4lvrYxn+RhcH5g4iY+J?=
 =?us-ascii?Q?Z8mObi9yOxeztVhHfggWcQgb3Qy7NZM4Sq3TOBmPyt1FGflPq0OQ62EJPFr1?=
 =?us-ascii?Q?kVtNUY6/vcIJTSvBGns9oO7AtrNHFd/Fga4qjXz3GBc3pQR+b/aGNNIODjyP?=
 =?us-ascii?Q?jss2nhG6JUa25KAYANC1q6VT9N/z0HdA/1KbQGm2Tu0aKcGVYvIVkNkGxFXI?=
 =?us-ascii?Q?1Ab/OWl0jeMOrSJ8YEDE4PTpxqCxxm8mSzplXmKyy/45nxF+FEbgFpxdjqQ8?=
 =?us-ascii?Q?boiEK4txsC/54ko6USNg3osV9qGTuJtdX0HwON/SRnU4xM7oP7fZhDkM7s2M?=
 =?us-ascii?Q?z9u/KGiKm/OjakS3Xfu5DOEXfqAzEIlPwi4mNfeCmkXkkYDKzC3smC+Wq4sy?=
 =?us-ascii?Q?lS8YKud/MvLDUZ/KqQLJiijjQmXOCsNlxI+Qol5XsVCYywarEze5lT26wv4h?=
 =?us-ascii?Q?G+mgtXsumQJ9kgReZgg5UxXm/RgYOFkplE63tdDJDaP84pLaYrKpPg/jqY6F?=
 =?us-ascii?Q?rC1wfOlCAdx8ShjtLFnVNlVqCawoLk+ZLsZSsUNHujahF2FG0dDGQxbA/Ubi?=
 =?us-ascii?Q?SjFHjeLJ2bVLJARMRcZdVVk49HocucOSUlY3REuj8zm+1hyC84bkit1Pu2E/?=
 =?us-ascii?Q?4gQ19h71pO3qA7SGxxr5fnSOjjygaL6Eon4HU29o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20937e17-6dc7-4343-3948-08da9be572d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:25:00.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /elOh4y3JwyZEYbWhjJ5l1hsf6Wd8OfXu5zyPfhCTKMA4zwolC1++q3BRa8pB7c4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:36:43PM -0700, Dan Williams wrote:
> The initial memremap_pages() implementation inherited the
> __init_single_page() default of pages starting life with an elevated
> reference count. This originally allowed for the page->pgmap pointer to
> alias with the storage for page->lru since a page was only allowed to be
> on an lru list when its reference count was zero.
> 
> Since then, 'struct page' definition cleanups have arranged for
> dedicated space for the ZONE_DEVICE page metadata, and the
> MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
> page->_refcount transition to route the page to free_zone_device_page()
> and not the core-mm page-free. With those cleanups in place and with
> filesystem-dax and device-dax now converted to take and drop references
> at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
> and MEMORY_DEVICE_GENERIC reference counts at 0.
> 
> MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
> pages start life at _refcount 1, so make that the default if
> pgmap->init_mode is left at zero.

I'm shocked to read this - how does it make any sense?

dev_pagemap_ops->page_free() is only called on the 1->0 transition, so
any driver which implements it must be expecting pages to have a 0
refcount.

Looking around everything but only fsdax_pagemap_ops implements
page_free()

So, how does it work? Surely the instant the page map is created all
the pages must be considered 'free', and after page_free() is called I
would also expect the page to be considered free.

How on earth can a free'd page have both a 0 and 1 refcount??

eg look at the simple hmm_test, it threads pages on to the
mdevice->free_pages list immediately after memremap_pages and then
again inside page_free() - it is completely wrong that they would have
different refcounts while on the free_pages list.

I would expect that after the page is removed from the free_pages list
it will have its recount set to 1 to make it non-free then it will go
through the migration.

Alistair how should the refcounting be working here in hmm_test?

Jason
