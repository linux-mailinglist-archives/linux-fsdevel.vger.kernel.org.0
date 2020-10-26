Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8651A298AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 11:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771081AbgJZKsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 06:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771043AbgJZKsJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:48:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 743C7AE3B;
        Mon, 26 Oct 2020 10:48:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D39A41E10F5; Mon, 26 Oct 2020 11:48:06 +0100 (CET)
Date:   Mon, 26 Oct 2020 11:48:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201026104806.GB29758@quack2.suse.cz>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041408.25230-5-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-10-20 04:14:00, Matthew Wilcox (Oracle) wrote:
> Rewrite shmem_seek_hole_data() and move it to filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 76 +++++++++++++++++++++++++++++++++++++++++
>  mm/shmem.c              | 72 +++-----------------------------------
>  3 files changed, 82 insertions(+), 68 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c77b7c31b2e4..5f3e829c91fd 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -760,6 +760,8 @@ extern void __delete_from_page_cache(struct page *page, void *shadow);
>  int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
>  void delete_from_page_cache_batch(struct address_space *mapping,
>  				  struct pagevec *pvec);
> +loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
> +		int whence);
>  
>  /*
>   * Like add_to_page_cache_locked, but used to add newly allocated pages:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00eaed59e797..3a55d258d9f2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2526,6 +2526,82 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  }
>  EXPORT_SYMBOL(generic_file_read_iter);
>  
> +static inline loff_t page_seek_hole_data(struct page *page,
> +		loff_t start, loff_t end, bool seek_data)
> +{
> +	if (xa_is_value(page) || PageUptodate(page))

Please add a comment here that this is currently tmpfs specific treating
exceptional entries as swapped out pages and thus data. It took me quite a
while to figure this out. You can remove the comment later when it is no
longer true...

> +		return seek_data ? start : end;
> +	return seek_data ? end : start;
> +}
> +
> +static inline
> +unsigned int seek_page_size(struct xa_state *xas, struct page *page)
> +{
> +	if (xa_is_value(page))
> +		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
> +	return thp_size(page);
> +}
> +
> +/**
> + * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
> + * @mapping: Address space to search.
> + * @start: First byte to consider.
> + * @end: Limit of search (exclusive).
> + * @whence: Either SEEK_HOLE or SEEK_DATA.
> + *
> + * If the page cache knows which blocks contain holes and which blocks
> + * contain data, your filesystem can use this function to implement
> + * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
> + * entirely memory-based such as tmpfs, and filesystems which support
> + * unwritten extents.
> + *
> + * Return: The requested offset on successs, or -ENXIO if @whence specifies
> + * SEEK_DATA and there is no data after @start.  There is an implicit hole
> + * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
> + * and @end contain data.
> + */
> +loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
> +		loff_t end, int whence)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
> +	pgoff_t max = (end - 1) / PAGE_SIZE;
> +	bool seek_data = (whence == SEEK_DATA);
> +	struct page *page;
> +
> +	if (end <= start)
> +		return -ENXIO;
> +
> +	rcu_read_lock();
> +	while ((page = xas_find_get_entry(&xas, max, XA_PRESENT))) {
> +		loff_t pos = xas.xa_index * PAGE_SIZE;
> +
> +		if (start < pos) {
> +			if (!seek_data)
> +				goto unlock;
> +			start = pos;
> +		}
> +
> +		pos += seek_page_size(&xas, page);
> +		start = page_seek_hole_data(page, start, pos, seek_data);
> +		if (start < pos)
> +			goto unlock;

Uh, I was staring at this function for half an hour but I still couldn't
convince myself that it is correct in all the corner cases. Maybe I'm dumb
but I'd wish this was more intuitive (and I have to say that the original
tmpfs function is much more obviously correct to me). It would more 
understandable for me if we had a code like:

		if (page_seek_match(page, seek_data))
			goto unlock;

which would be just the condition in page_seek_hole_data(). Honestly at the
moment I fail to see why you bother with 'pos' in the above four lines at
all.

BTW I suspect that this loop forgets to release the page reference it has got
when doing SEEK_HOLE.

> +	}
> +	rcu_read_unlock();
> +
> +	if (seek_data)
> +		return -ENXIO;
> +	goto out;
> +
> +unlock:
> +	rcu_read_unlock();
> +	if (!xa_is_value(page))
> +		put_page(page);
> +out:
> +	if (start > end)
> +		return end;
> +	return start;
> +}


								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
