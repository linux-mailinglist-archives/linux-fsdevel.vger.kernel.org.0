Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31855F19A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiF1Wu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiF1Wu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:50:28 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 954DF39833;
        Tue, 28 Jun 2022 15:50:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 092A910E7862;
        Wed, 29 Jun 2022 08:17:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o6JWv-00CEcF-Ry; Wed, 29 Jun 2022 08:17:57 +1000
Date:   Wed, 29 Jun 2022 08:17:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <20220628221757.GJ227878@dread.disaster.area>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrr/oBlf1Eig8uKS@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62bb7e19
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=I0e5OopBZKVaJ7lt07gA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > So using this technique, I've discovered that there's a dirty page
> > > > accounting leak that eventually results in fsx hanging in
> > > > balance_dirty_pages().
> > > 
> > > Alas, I think this is only an accounting error, and not related to
> > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > seeing is dirty pages being dropped at truncation without the
> > > appropriate accounting.  ie this should be the fix:
> > 
> > Argh, try one that actually compiles.
> 
> ... that one's going to underflow the accounting.  Maybe I shouldn't
> be writing code at 6am?
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f7248002dad9..4eec6ee83e44 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -18,6 +18,7 @@
>  #include <linux/shrinker.h>
>  #include <linux/mm_inline.h>
>  #include <linux/swapops.h>
> +#include <linux/backing-dev.h>
>  #include <linux/dax.h>
>  #include <linux/khugepaged.h>
>  #include <linux/freezer.h>
> @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond EOF: drop them from page cache */
>  		if (head[i].index >= end) {
> -			ClearPageDirty(head + i);
> -			__delete_from_page_cache(head + i, NULL);
> +			struct folio *tail = page_folio(head + i);
> +
>  			if (shmem_mapping(head->mapping))
>  				shmem_uncharge(head->mapping->host, 1);
> -			put_page(head + i);
> +			else if (folio_test_clear_dirty(tail))
> +				folio_account_cleaned(tail,
> +					inode_to_wb(folio->mapping->host));
> +			__filemap_remove_folio(tail, NULL);
> +			folio_put(tail);
>  		} else if (!PageAnon(page)) {
>  			__xa_store(&head->mapping->i_pages, head[i].index,
>  					head + i, 0);
> 

Yup, that fixes the leak.

Tested-by: Dave Chinner <dchinner@redhat.com>

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
