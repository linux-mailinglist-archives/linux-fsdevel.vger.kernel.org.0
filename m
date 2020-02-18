Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5401620B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 07:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgBRGPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 01:15:06 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55597 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgBRGPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:15:06 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id ABD677E9E5B;
        Tue, 18 Feb 2020 17:15:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3w9r-0006E2-AR; Tue, 18 Feb 2020 17:14:59 +1100
Date:   Tue, 18 Feb 2020 17:14:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200218061459.GM10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-12-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=6Sg7X3AK5n0gSZn-CawA:9
        a=XfLjuTNYxNuElQ0I:21 a=atnrvcmCVHYDzj7Q:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:52AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> At allocation time, put the pages in the cache unless we're using
> ->readpages.  Add the readahead_for_each() iterator for the benefit of
> the ->readpage fallback.  This iterator supports huge pages, even though
> none of the filesystems to be converted do yet.

This could be better written - took me some time to get my head
around it and the code.

"When populating the page cache for readahead, mappings that don't
use ->readpages need to have their pages added to the page cache
before ->readpage is called. Do this insertion earlier so that the
pages can be looked up immediately prior to ->readpage calls rather
than passing them on a linked list. This early insert functionality
is also required by the upcoming ->readahead method that will
replace ->readpages.

Optimise and simplify the readpage loop by adding a
readahead_for_each() iterator to provide the pages we need to read.
This iterator also supports huge pages, even though none of the
filesystems have been converted to use them yet."

> +static inline struct page *readahead_page(struct readahead_control *rac)
> +{
> +	struct page *page;
> +
> +	if (!rac->_nr_pages)
> +		return NULL;

Hmmmm.

> +
> +	page = xa_load(&rac->mapping->i_pages, rac->_start);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	rac->_batch_count = hpage_nr_pages(page);

So we could have rac->_nr_pages = 2, and then we get an order 2
large page returned, and so rac->_batch_count = 4.
> +
> +	return page;
> +}
> +
> +static inline void readahead_next(struct readahead_control *rac)
> +{
> +	rac->_nr_pages -= rac->_batch_count;
> +	rac->_start += rac->_batch_count;

This results in rac->_nr_pages = -2 (or a huge positive number).
That means that readahead_page() will not terminate when it should,
and potentially will panic if it doesn't find the page that it
thinks should be there at rac->_start + 4...

> +#define readahead_for_each(rac, page)					\
> +	for (; (page = readahead_page(rac)); readahead_next(rac))
> +
>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *rac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index bdc5759000d3..9e430daae42f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,12 +113,11 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static void read_pages(struct readahead_control *rac, struct list_head *pages,
> -		gfp_t gfp)
> +static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  {
>  	const struct address_space_operations *aops = rac->mapping->a_ops;
> +	struct page *page;
>  	struct blk_plug plug;
> -	unsigned page_idx;
>  
>  	blk_start_plug(&plug);
>  
> @@ -127,19 +126,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>  				readahead_count(rac));
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
> -		goto out;
> -	}
> -
> -	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
> -		struct page *page = lru_to_page(pages);
> -		list_del(&page->lru);
> -		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
> -				gfp))
> +	} else {
> +		readahead_for_each(rac, page) {
>  			aops->readpage(rac->file, page);
> -		put_page(page);
> +			put_page(page);
> +		}
>  	}

Nice simplification and gets rid of the need for rac->mapping, but I
still find the aops variable weird.

> -out:
>  	blk_finish_plug(&plug);
>  }
>  
> @@ -159,6 +152,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long i;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	bool use_list = mapping->a_ops->readpages;
>  	struct readahead_control rac = {
>  		.mapping = mapping,
>  		.file = filp,

[ I do find these unstructured mixes of declarations and
initialisations dense and difficult to read.... ]

> @@ -196,8 +190,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = offset;
> -		list_add(&page->lru, &page_pool);
> +		if (use_list) {
> +			page->index = offset;
> +			list_add(&page->lru, &page_pool);
> +		} else if (add_to_page_cache_lru(page, mapping, offset,
> +					gfp_mask) < 0) {
> +			put_page(page);
> +			goto read;
> +		}

Ok, so that's why you put read code at the end of the loop. To turn
the code into spaghetti :/

How much does this simplify down when we get rid of ->readpages and
can restructure the loop? This really seems like you're trying to
flatten two nested loops into one by the use of goto....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
