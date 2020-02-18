Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20B2162001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgBRFDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 00:03:06 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35948 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbgBRFDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 00:03:06 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7E1D17E99BC;
        Tue, 18 Feb 2020 16:03:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3v2C-0005rs-Ui; Tue, 18 Feb 2020 16:03:00 +1100
Date:   Tue, 18 Feb 2020 16:03:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
Message-ID: <20200218050300.GI10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-4-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=T1S5Ow7nDR_9LkHsJ_YA:9
        a=8UYMWJo80S1V5K9C:21 a=Xcujrn6zEerIh50R:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:44AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> In this patch, only between __do_page_cache_readahead() and
> read_pages(), but it will be extended in upcoming patches.  Also add
> the readahead_count() accessor.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 17 +++++++++++++++++
>  mm/readahead.c          | 36 +++++++++++++++++++++---------------
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..982ecda2d4a2 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -630,6 +630,23 @@ static inline int add_to_page_cache(struct page *page,
>  	return error;
>  }
>  
> +/*
> + * Readahead is of a block of consecutive pages.
> + */
> +struct readahead_control {
> +	struct file *file;
> +	struct address_space *mapping;
> +/* private: use the readahead_* accessors instead */
> +	pgoff_t _start;
> +	unsigned int _nr_pages;
> +};
> +
> +/* The number of pages in this readahead block */
> +static inline unsigned int readahead_count(struct readahead_control *rac)
> +{
> +	return rac->_nr_pages;
> +}
> +
>  static inline unsigned long dir_pages(struct inode *inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 12d13b7792da..15329309231f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,26 +113,29 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static void read_pages(struct address_space *mapping, struct file *filp,
> -		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
> +static void read_pages(struct readahead_control *rac, struct list_head *pages,
> +		gfp_t gfp)
>  {
> +	const struct address_space_operations *aops = rac->mapping->a_ops;
>  	struct blk_plug plug;
>  	unsigned page_idx;

Splitting out the aops rather than the mapping here just looks
weird, especially as you need the mapping later in the function.
Using aops doesn't even reduce the code side....

>  
>  	blk_start_plug(&plug);
>  
> -	if (mapping->a_ops->readpages) {
> -		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +	if (aops->readpages) {
> +		aops->readpages(rac->file, rac->mapping, pages,
> +				readahead_count(rac));
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  		goto out;
>  	}
>  
> -	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
> +	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
>  		struct page *page = lru_to_page(pages);
>  		list_del(&page->lru);
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
> -			mapping->a_ops->readpage(filp, page);
> +		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
> +				gfp))
> +			aops->readpage(rac->file, page);

... it just makes this less readable by splitting the if() over two
lines...

>  		put_page(page);
>  	}
>  
> @@ -155,9 +158,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;
> -	unsigned int nr_pages = 0;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	struct readahead_control rac = {
> +		.mapping = mapping,
> +		.file = filp,
> +		._nr_pages = 0,
> +	};

No need to initialise _nr_pages to zero, leaving it out will do the
same thing.

>  
>  	if (isize == 0)
>  		return;
> @@ -180,10 +187,9 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  			 * contiguous pages before continuing with the next
>  			 * batch.
>  			 */
> -			if (nr_pages)
> -				read_pages(mapping, filp, &page_pool, nr_pages,
> -						gfp_mask);
> -			nr_pages = 0;
> +			if (readahead_count(&rac))
> +				read_pages(&rac, &page_pool, gfp_mask);
> +			rac._nr_pages = 0;

Hmmm. Wondering ig it make sense to move the gfp_mask to the readahead
control structure - if we have to pass the gfp_mask down all the
way along side the rac, then I think it makes sense to do that...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
