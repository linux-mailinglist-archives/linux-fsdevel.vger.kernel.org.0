Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91F5AE910
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiIFNFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbiIFNFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:05:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6454D4EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 06:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chk9KqdKoTmpBd5g060VjjGLqgB92yl8TsYSAImGUhAGOraQRLW9d/HXpPY9waUawbFp93x3RjTnLJFtX5AHdhWXzqRuP28aPqb9bICJfvrMzODEHBJWZRkzcuH/NScDrLgg3O/d6esDq9nhjevmN5CfPmfuPJUDupltW4x4rihERQk9xk993RBy1hBM7RLnXbf46WUC8DLFgB7IqXdKplglze1k9RoZ6ME8oBdIMnJ6tA+iDL1FwbBRV2TOPa3D+UIZ1RyXGOEm9Zkf6gN14OzaFtRw3l+BaZPsdoyGZJeU+gOZPMrPpqLtdHUzdrHVE+ErTK7C26eO985hXCh/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6SSmg3M/JZLf2xOd8mxqhSH83+96sJwTEGi+bYRwg4=;
 b=CfMXPHf7+lwT/FLnmDohL249j0bYHpoA9xREqa44qQzemCXQ/Qz/w8BUxOqExiNVCJPukom4C9peoLbpT3Az6kvkITTwGpDIodqbdLn12EopUdySbBayYEfUuPDNaB0gwQUIp3az/KeQ6gTKgTJv4udgPd33kXRwn/31h+JWtO04onAUrSIlDEDOwvRqUr6xdgl8r3w0i7BOCOxSnvm1bF2sBl5CJkbmfMomcDSKYMT1jl6cNg/xGwETiWczymePigNqWKSKrzrtMTKWwdtLnVq9oQwzFKbz/jUq0oQMbwbs6UVyFD5atZ/CQvniRQ5UV7BAlyRvlR2ajSguZe+uRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6SSmg3M/JZLf2xOd8mxqhSH83+96sJwTEGi+bYRwg4=;
 b=eyRJYjjgEuoWEndh+miH1cmzfVMyrxKSfqVJZXAhLI3fdFmbmKQqy3/I2rh1g0ASrwpL7l9riPtLME7jDoNAVCVgOwiLxU2dtb4Q7ektAwEt9oN1FobP3ND8f0v3FU0uFty7Wt+xz6240qyLBv8gGxPytWAA0jupWuuWxOKArl37/qUupuKCUD4Zpd8jASQRD45ymLsRDQ0Qb3e/fCRZsfvzrxkytsC1FogPWPJ1zG67z/5HEujp0HC8piQ8GOOrSMWz+JrUxTlHZgEPZiieXhkbPzIelOMi3nAujs7pZUyP0XEt9IOG1YY2omLaJKaMLRERZYFMzfdAvQeZzhaciQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 13:05:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 13:05:30 +0000
Date:   Tue, 6 Sep 2022 10:05:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxdFmXi/Zdr8Zi3q@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca9ad345-ace6-4b55-bb1c-08da900879e9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6007:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSqp/o8Yk8ognlt/LwhvnvmrGLppJIYM277M9rBcVeGMWjOlq02T+5ho6uzxUBEJy8ga7obFkoWciEjQmcR2G22Rgl7fsuqYvXkON2kM9NJ6SPQCuY7MKDWofisqMDhr2ljnQB9NFgMpgZnWeC/0jUKr3hFr5TE9AWps1KC68Pog6I/ar2TZi4z6KtQWt7F2qplx2gN1B3GquQfv1DaYvc6g5VaF0oxyW7EocOfNrRvXPVwkA8z6ik0eqKjHYM+WDeyzCPE1g4oxxymNrYFEuHsWTDp9mZqFLeE1fs7aDCb1IiLPeFXBAtCCM93684DpFIK84igNMPoG6/htknWxTcflxUC/OcYyISgrjkBC+LKzTgAnbrIC9+vAlGvGBbdSdztu+qhatLk7qhFnDThTnJhRASn2hodgnapr2RqL7OCOUTqYSzGMTdhdJ+EfvAiRqL3/k/7G3+LBf6WSEM2s5zXZNSclVyRIveLT67F5cYnn8TzZ6xAapDJDy9L7MmfdpPblqJuUw9sDm0M64HN8rXyZVZNKSH+HUGNkjPmLUZv9njEmd6Ic3YzxmuupAGmQXUpTt1kIjx7SzqDDfwccLr8lFDeZUUw/lzvf6sy+1MyIOKhp9bDjHbOXPZ9u0b5hTHC3E0UCc7/qsEDGDU1REL+SU+gPM9kiNCtencai0ejVrUM5focquD/34xGPJ9NlH0DF1Lg9b+9SOr0zb36MtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(186003)(66476007)(66556008)(86362001)(66946007)(2616005)(8936002)(6506007)(41300700001)(8676002)(5660300002)(478600001)(4326008)(2906002)(6512007)(38100700002)(6486002)(26005)(83380400001)(316002)(54906003)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncd8qbiQKK7qIu2i5OGo8GHWB2qu15LTtWrFwjvidI9Di6Z97xBxLEZ1VEoO?=
 =?us-ascii?Q?kmBgpU9KrGJT4O6rvX+0C0F3HZ5QyFHdaF1JiXlORRs/jQC3rMYbuepWGoD8?=
 =?us-ascii?Q?baIKOgIMq3rciqdYwE64WHCOEMqt+Wz8K4GuSalCrKiJhlmfEduKMnCuHWE/?=
 =?us-ascii?Q?Qu7TF8Yy8DHONiWnfoYuJ5m6d2kWZeGOYxLaQIPVT4m8mACo94rqp8WdxchG?=
 =?us-ascii?Q?L8/XfsFcpt6zFrXqhgt1oN/ZnjuHijWhxky8C0xSeIxX0+APuME8rePx7i0Z?=
 =?us-ascii?Q?EjzMwRx12ncpyU9jYpeNsYVCliYgTt3B19ey++lMBnkXGEJNdGr3Rm7QEQRd?=
 =?us-ascii?Q?pEtPYwnSYmUbZRpziBGYsAbgdBwO0bcpQNENX4y6El8lZUXH09E5jYTvpGj5?=
 =?us-ascii?Q?3EoLYXx55+Qgg/4h4m4eJSe0R6sX5C2o98y3t3RgZ3TGcf+/hatenvqXAKq6?=
 =?us-ascii?Q?xOBSNyNQ78scwepyo9QwO1wn68HlGSKivapilXZXdxglYYrIdIvAQhcCUTZo?=
 =?us-ascii?Q?eOsT+0ngf6YKgo2S4Isb0Ng0bYv8buW1HochW0g/sP57X+HR83cGVStp1jeI?=
 =?us-ascii?Q?fsezVqLzx0E1g1OTpI+Yo8YNyNtW/5/wzSAQ43AC7AKz4L251LR9jhC3cbaI?=
 =?us-ascii?Q?tXBUNuT0Y4EhmpoRbKhs9buRcyPK0OTJZfULlfeV4Oja1uf4MNTrE6Ezkt/+?=
 =?us-ascii?Q?o6UC5CB8SzUK+IwveqPiQyVdlDLb5xHadqyqnSdRM/cQMC+eIZdypNW3ikEw?=
 =?us-ascii?Q?F+eoBugf/7Ct/W+xaOPItmR6vDD4psZKoLitCwnPPwfwPGvQwfSu8Yk2q0cW?=
 =?us-ascii?Q?vDQwxktkEbwM7DKdYxW1gQZShL0mkxvlX/dw15i30sh0qe//QG+R4oHrtLqw?=
 =?us-ascii?Q?4NgWOrcvot3C6ieSi/wqMGV4BFYDRBa6HU85x8T3yz1gm60vHy+wDwn2Q+Bi?=
 =?us-ascii?Q?/FnrQJUrMq+J4rb4YL92DV6ECXS2kxiLvJB6uGE4yrgtUa/llesNzsMS39jW?=
 =?us-ascii?Q?Id2dfUm7qtoAKk4E6lcMqAmnEjABfE0FKr5D+B/KlH7bXkn9xZ7nuBDEbTcX?=
 =?us-ascii?Q?aknAMukF9wdtyFxC3POFtruqQszj7LnusFzDrZpq/M68gZhioYuRuFWB4i9B?=
 =?us-ascii?Q?9JBcJhEce19voOTaa+fdoYhNoc2yoOFW0pczWqT1/go2J08zjHD67Fylxc/P?=
 =?us-ascii?Q?64oDZb6whM+ODoQ+i+ds07Ffqf68YXzdNUeeFXuvGsBMW6rSOzmdOlykK2SA?=
 =?us-ascii?Q?fzQbRbT9pR483A5aiCBJPmwTCPknUh1L81474OF+TZXFQwxGn558GQw3Nc9e?=
 =?us-ascii?Q?qfRamk3c8CmT8/M6gAHf+ty81+zFAnQLu8dCQONjZlRiNuHESJpllq5wHNMa?=
 =?us-ascii?Q?wVJWt1kKino25klU3CE1DmBiZJXm/PxsuEz17KMhRNBCQCP8Ge7eQtPTCTB+?=
 =?us-ascii?Q?UnZ/fUBv2JhI+yp5OQrZRaoJgXfH05H98gvBlAZO2a+iyL5HNFF82vEqSxWM?=
 =?us-ascii?Q?YlUERTUAeHUB9YGBhuT2hSmfj4P87y++CNR3dbw/h1UqPkkEiaO8q5y83BOU?=
 =?us-ascii?Q?lpPoxqtXFYPkMJwcvYspy246+8Ajvo8JLik5dDTo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9ad345-ace6-4b55-bb1c-08da900879e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:05:30.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeuiivyPqNPk+f/5JIJtNrs1ybrow4V6Ak//bN4tNzhHoclAd9UUVKIwzPsIwo5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 07:16:00PM -0700, Dan Williams wrote:
> tl;dr: Move the pin of 'struct dev_pagemap' instances from gup-time to
> map time, move the unpin of 'struct dev_pagemap' to truncate_inode_pages()
> for fsdax and devdax inodes, and use page_maybe_dma_pinned() to
> determine when filesystems can safely truncate DAX mappings vs DMA.
> 
> The longer story is that DAX has caused friction with folio development
> and other device-memory use cases due to its hack of using a
> page-reference count of 1 to indicate that the page is DMA idle. That
> situation arose from the mistake of not managing DAX page reference
> counts at map time. The lack of page reference counting at map time grew
> organically from the original DAX experiment of attempting to manage DAX
> mappings without page structures. The page lock, dirty tracking and
> other entry management was supported sans pages. However, the page
> support was then bolted on incrementally so solve problems with gup,
> memory-failure, and all the other kernel services that are missing when
> a pfn does not have an associated page structure.
> 
> Since then John has led an effort to account for when a page is pinned
> for DMA vs other sources that elevate the reference count. The
> page_maybe_dma_pinned() helper slots in seamlessly to replace the need
> to track transitions to page->_refount == 1.
> 
> The larger change in this set comes from Jason's observation that
> inserting DAX mappings without any reference taken is a bug. So
> dax_insert_entry(), that fsdax uses, is updated to take 'struct
> dev_pagemap' references, and devdax is updated to reuse the same.

It wasn't pagemap references that were the problem, it was struct page
references.

pagemap is just something that should be ref'd in the background, as
long as a struct page has a positive reference the pagemap should be
considered referenced, IMHO free_zone_device_page() should be dealing
with this - put the pagemap after calling page_free().

Pagemap is protecting page->pgmap from UAF so we must ensure we hold
it when we do pgmap->ops

That should be the only put, and it should pair with the only get
which happens when the driver takes a 0 refcount page out of its free
list and makes it have a refcount of 1.

> page mapping helpers. One of the immediate hurdles is the usage of
> pmd_devmap() to distinguish large page mappings that are not transparent
> huge pages.

And this is because the struct page refcounting is not right :|

I had thought the progression would be to make fsdax use compound
folios, install compound folios in the PMD, remove all the special
case refcounting for DAX from the pagetable code, then address the
pgmap issue from the basis of working page->refcount, eg by putting a
pgmap put in right after the op->page_free call.

Can we continue to have the weird page->refcount behavior and still
change the other things?

Jason
