Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF81162133
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 07:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgBRG6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 01:58:04 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33665 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgBRG6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:58:03 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7C5BF3A2771;
        Tue, 18 Feb 2020 17:57:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3wpS-0006Wf-5F; Tue, 18 Feb 2020 17:57:58 +1100
Date:   Tue, 18 Feb 2020 17:57:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 11/19] btrfs: Convert from readpages to readahead
Message-ID: <20200218065758.GQ10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-19-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=cHVu4ezWpKoVtZSsmu8A:9
        a=a6t_wt_lAo5S5IOh:21 a=CcahuoPPjRgWG3dV:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:59AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in btrfs.  Add a
> readahead_for_each_batch() iterator to optimise the loop in the XArray.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/btrfs/extent_io.c    | 46 +++++++++++++----------------------------
>  fs/btrfs/extent_io.h    |  3 +--
>  fs/btrfs/inode.c        | 16 +++++++-------
>  include/linux/pagemap.h | 27 ++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c0f202741e09..e97a6acd6f5d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4278,52 +4278,34 @@ int extent_writepages(struct address_space *mapping,
>  	return ret;
>  }
>  
> -int extent_readpages(struct address_space *mapping, struct list_head *pages,
> -		     unsigned nr_pages)
> +void extent_readahead(struct readahead_control *rac)
>  {
>  	struct bio *bio = NULL;
>  	unsigned long bio_flags = 0;
>  	struct page *pagepool[16];
>  	struct extent_map *em_cached = NULL;
> -	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
> -	int nr = 0;
> +	struct extent_io_tree *tree = &BTRFS_I(rac->mapping->host)->io_tree;
>  	u64 prev_em_start = (u64)-1;
> +	int nr;
>  
> -	while (!list_empty(pages)) {
> -		u64 contig_end = 0;
> -
> -		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
> -			struct page *page = lru_to_page(pages);
> -
> -			prefetchw(&page->flags);
> -			list_del(&page->lru);
> -			if (add_to_page_cache_lru(page, mapping, page->index,
> -						readahead_gfp_mask(mapping))) {
> -				put_page(page);
> -				break;
> -			}
> -
> -			pagepool[nr++] = page;
> -			contig_end = page_offset(page) + PAGE_SIZE - 1;
> -		}
> +	readahead_for_each_batch(rac, pagepool, ARRAY_SIZE(pagepool), nr) {
> +		u64 contig_start = page_offset(pagepool[0]);
> +		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;

So this assumes a contiguous page range is returned, right?

>  
> -		if (nr) {
> -			u64 contig_start = page_offset(pagepool[0]);
> +		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);

Ok, yes it does. :)

I don't see how readahead_for_each_batch() guarantees that, though.

>  
> -			ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> -
> -			contiguous_readpages(tree, pagepool, nr, contig_start,
> -				     contig_end, &em_cached, &bio, &bio_flags,
> -				     &prev_em_start);
> -		}
> +		contiguous_readpages(tree, pagepool, nr, contig_start,
> +				contig_end, &em_cached, &bio, &bio_flags,
> +				&prev_em_start);
>  	}
>  
>  	if (em_cached)
>  		free_extent_map(em_cached);
>  
> -	if (bio)
> -		return submit_one_bio(bio, 0, bio_flags);
> -	return 0;
> +	if (bio) {
> +		if (submit_one_bio(bio, 0, bio_flags))
> +			return;
> +	}
>  }

Shouldn't that just be

	if (bio)
		submit_one_bio(bio, 0, bio_flags);

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4f36c06d064d..1bbb60a0bf16 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -669,6 +669,33 @@ static inline void readahead_next(struct readahead_control *rac)
>  #define readahead_for_each(rac, page)					\
>  	for (; (page = readahead_page(rac)); readahead_next(rac))
>  
> +static inline unsigned int readahead_page_batch(struct readahead_control *rac,
> +		struct page **array, unsigned int size)
> +{
> +	unsigned int batch = 0;

Confusing when put alongside rac->_batch_count counting the number
of pages in the batch, and "batch" being the index into the page
array, and they aren't the same counts....

> +	XA_STATE(xas, &rac->mapping->i_pages, rac->_start);
> +	struct page *page;
> +
> +	rac->_batch_count = 0;
> +	xas_for_each(&xas, page, rac->_start + rac->_nr_pages - 1) {

That just iterates pages in the start,end doesn't it? What
guarantees that this fills the array with a contiguous page range?

> +		VM_BUG_ON_PAGE(!PageLocked(page), page);
> +		VM_BUG_ON_PAGE(PageTail(page), page);
> +		array[batch++] = page;
> +		rac->_batch_count += hpage_nr_pages(page);
> +		if (PageHead(page))
> +			xas_set(&xas, rac->_start + rac->_batch_count);

What on earth does this do? Comments please!

> +
> +		if (batch == size)
> +			break;
> +	}
> +
> +	return batch;
> +}

Seems a bit big for an inline function.

> +
> +#define readahead_for_each_batch(rac, array, size, nr)			\
> +	for (; (nr = readahead_page_batch(rac, array, size));		\
> +			readahead_next(rac))

I had to go look at the caller to work out what "size" refered to
here.

This is complex enough that it needs proper API documentation.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
