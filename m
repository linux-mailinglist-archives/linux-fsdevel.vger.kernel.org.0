Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4B166CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 03:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgBUCVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 21:21:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8152 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:21:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f3e6c0000>; Thu, 20 Feb 2020 18:20:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 18:21:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 18:21:01 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 02:21:01 +0000
Subject: Re: [PATCH v7 06/24] mm: Rename various 'offset' parameters to
 'index'
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-7-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <495787f3-b242-7b72-8807-50eff3b5c37d@nvidia.com>
Date:   Thu, 20 Feb 2020 18:21:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-7-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582251628; bh=1fFzHXOgqDzJ1VBkHnOJtWMQIQmJCZGe4/j7h8tGuhk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nLktpHwwzGqIePL6VSpd9k2G8RyNAxcHdTcPd3D9UEYanuFUvq03y/M0tkR+F+abS
         /n5rSdxkI9edLNw4w1E3lHUfTFm22LnuDNojlvTrkWcPTHFiCGbQh5gJW0h0AMMeo0
         7boQ/893EJgAI+mRR8wSZ9TMLRKHUlMcoPAavwk97Lw3Ua2HR39t3EBysiSW/Td7AL
         k48i5RfxcIV64YMBIbOyGLSffujfxNxT9IzTDhMUiXggPQrXxJTdDfk5dEqnBmnjTh
         Yz9PS6jOdXtCCZJ8QaDQfW1vLbbm/J+2bS3SGtDVWbw7aKWh62eC7wTcMwHfCc1yQE
         kHIZgyuznkgvw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The word 'offset' is used ambiguously to mean 'byte offset within
> a page', 'byte offset from the start of the file' and 'page offset
> from the start of the file'.  Use 'index' to mean 'page offset
> from the start of the file' throughout the readahead code.


And: use 'count' to mean 'number of pages'.  Since the patch also changes
req_size to req_count.

I'm casting about for a nice place in the code, to put your above note...and
there isn't one. But would it be terrible to just put a short comment
block at the top of this file, just so we have it somewhere? It's pretty
cool to settle on a consistent terminology, so backing it up with "yes, we
actually mean it" documentation would be even better.

One minor note below, but no bugs spotted, and this clarifies the code a bit, so:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 86 ++++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a9d99229bd6..096cf9020648 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -156,7 +156,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
>   * We really don't want to intermingle reads and writes like that.
>   */
>  void __do_page_cache_readahead(struct address_space *mapping,
> -		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
> +		struct file *filp, pgoff_t index, unsigned long nr_to_read,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> @@ -181,7 +181,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * Preallocate as many pages as we will need.
>  	 */
>  	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
> -		pgoff_t page_offset = offset + page_idx;
> +		pgoff_t page_offset = index + page_idx;


This line seems to unrepentantly mix offset and index, still. :)


>  
>  		if (page_offset > end_index)
>  			break;
> @@ -220,7 +220,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>   * memory at once.
>   */
>  void force_page_cache_readahead(struct address_space *mapping,
> -		struct file *filp, pgoff_t offset, unsigned long nr_to_read)
> +		struct file *filp, pgoff_t index, unsigned long nr_to_read)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>  	struct file_ra_state *ra = &filp->f_ra;
> @@ -240,9 +240,9 @@ void force_page_cache_readahead(struct address_space *mapping,
>  
>  		if (this_chunk > nr_to_read)
>  			this_chunk = nr_to_read;
> -		__do_page_cache_readahead(mapping, filp, offset, this_chunk, 0);
> +		__do_page_cache_readahead(mapping, filp, index, this_chunk, 0);
>  
> -		offset += this_chunk;
> +		index += this_chunk;
>  		nr_to_read -= this_chunk;
>  	}
>  }
> @@ -323,21 +323,21 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
>   */
>  
>  /*
> - * Count contiguously cached pages from @offset-1 to @offset-@max,
> + * Count contiguously cached pages from @index-1 to @index-@max,
>   * this count is a conservative estimation of
>   * 	- length of the sequential read sequence, or
>   * 	- thrashing threshold in memory tight systems
>   */
>  static pgoff_t count_history_pages(struct address_space *mapping,
> -				   pgoff_t offset, unsigned long max)
> +				   pgoff_t index, unsigned long max)
>  {
>  	pgoff_t head;
>  
>  	rcu_read_lock();
> -	head = page_cache_prev_miss(mapping, offset - 1, max);
> +	head = page_cache_prev_miss(mapping, index - 1, max);
>  	rcu_read_unlock();
>  
> -	return offset - 1 - head;
> +	return index - 1 - head;
>  }
>  
>  /*
> @@ -345,13 +345,13 @@ static pgoff_t count_history_pages(struct address_space *mapping,
>   */
>  static int try_context_readahead(struct address_space *mapping,
>  				 struct file_ra_state *ra,
> -				 pgoff_t offset,
> +				 pgoff_t index,
>  				 unsigned long req_size,
>  				 unsigned long max)
>  {
>  	pgoff_t size;
>  
> -	size = count_history_pages(mapping, offset, max);
> +	size = count_history_pages(mapping, index, max);
>  
>  	/*
>  	 * not enough history pages:
> @@ -364,10 +364,10 @@ static int try_context_readahead(struct address_space *mapping,
>  	 * starts from beginning of file:
>  	 * it is a strong indication of long-run stream (or whole-file-read)
>  	 */
> -	if (size >= offset)
> +	if (size >= index)
>  		size *= 2;
>  
> -	ra->start = offset;
> +	ra->start = index;
>  	ra->size = min(size + req_size, max);
>  	ra->async_size = 1;
>  
> @@ -379,13 +379,13 @@ static int try_context_readahead(struct address_space *mapping,
>   */
>  static void ondemand_readahead(struct address_space *mapping,
>  		struct file_ra_state *ra, struct file *filp,
> -		bool hit_readahead_marker, pgoff_t offset,
> +		bool hit_readahead_marker, pgoff_t index,
>  		unsigned long req_size)
>  {
>  	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>  	unsigned long max_pages = ra->ra_pages;
>  	unsigned long add_pages;
> -	pgoff_t prev_offset;
> +	pgoff_t prev_index;
>  
>  	/*
>  	 * If the request exceeds the readahead window, allow the read to
> @@ -397,15 +397,15 @@ static void ondemand_readahead(struct address_space *mapping,
>  	/*
>  	 * start of file
>  	 */
> -	if (!offset)
> +	if (!index)
>  		goto initial_readahead;
>  
>  	/*
> -	 * It's the expected callback offset, assume sequential access.
> +	 * It's the expected callback index, assume sequential access.
>  	 * Ramp up sizes, and push forward the readahead window.
>  	 */
> -	if ((offset == (ra->start + ra->size - ra->async_size) ||
> -	     offset == (ra->start + ra->size))) {
> +	if ((index == (ra->start + ra->size - ra->async_size) ||
> +	     index == (ra->start + ra->size))) {
>  		ra->start += ra->size;
>  		ra->size = get_next_ra_size(ra, max_pages);
>  		ra->async_size = ra->size;
> @@ -422,14 +422,14 @@ static void ondemand_readahead(struct address_space *mapping,
>  		pgoff_t start;
>  
>  		rcu_read_lock();
> -		start = page_cache_next_miss(mapping, offset + 1, max_pages);
> +		start = page_cache_next_miss(mapping, index + 1, max_pages);
>  		rcu_read_unlock();
>  
> -		if (!start || start - offset > max_pages)
> +		if (!start || start - index > max_pages)
>  			return;
>  
>  		ra->start = start;
> -		ra->size = start - offset;	/* old async_size */
> +		ra->size = start - index;	/* old async_size */
>  		ra->size += req_size;
>  		ra->size = get_next_ra_size(ra, max_pages);
>  		ra->async_size = ra->size;
> @@ -444,29 +444,29 @@ static void ondemand_readahead(struct address_space *mapping,
>  
>  	/*
>  	 * sequential cache miss
> -	 * trivial case: (offset - prev_offset) == 1
> -	 * unaligned reads: (offset - prev_offset) == 0
> +	 * trivial case: (index - prev_index) == 1
> +	 * unaligned reads: (index - prev_index) == 0
>  	 */
> -	prev_offset = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
> -	if (offset - prev_offset <= 1UL)
> +	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
> +	if (index - prev_index <= 1UL)
>  		goto initial_readahead;
>  
>  	/*
>  	 * Query the page cache and look for the traces(cached history pages)
>  	 * that a sequential stream would leave behind.
>  	 */
> -	if (try_context_readahead(mapping, ra, offset, req_size, max_pages))
> +	if (try_context_readahead(mapping, ra, index, req_size, max_pages))
>  		goto readit;
>  
>  	/*
>  	 * standalone, small random read
>  	 * Read as is, and do not pollute the readahead state.
>  	 */
> -	__do_page_cache_readahead(mapping, filp, offset, req_size, 0);
> +	__do_page_cache_readahead(mapping, filp, index, req_size, 0);
>  	return;
>  
>  initial_readahead:
> -	ra->start = offset;
> +	ra->start = index;
>  	ra->size = get_init_ra_size(req_size, max_pages);
>  	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
>  
> @@ -477,7 +477,7 @@ static void ondemand_readahead(struct address_space *mapping,
>  	 * the resulted next readahead window into the current one.
>  	 * Take care of maximum IO pages as above.
>  	 */
> -	if (offset == ra->start && ra->size == ra->async_size) {
> +	if (index == ra->start && ra->size == ra->async_size) {
>  		add_pages = get_next_ra_size(ra, max_pages);
>  		if (ra->size + add_pages <= max_pages) {
>  			ra->async_size = add_pages;
> @@ -496,9 +496,8 @@ static void ondemand_readahead(struct address_space *mapping,
>   * @mapping: address_space which holds the pagecache and I/O vectors
>   * @ra: file_ra_state which holds the readahead state
>   * @filp: passed on to ->readpage() and ->readpages()
> - * @offset: start offset into @mapping, in pagecache page-sized units
> - * @req_size: hint: total size of the read which the caller is performing in
> - *            pagecache pages
> + * @index: Index of first page to be read.
> + * @req_count: Total number of pages being read by the caller.
>   *
>   * page_cache_sync_readahead() should be called when a cache miss happened:
>   * it will submit the read.  The readahead logic may decide to piggyback more
> @@ -507,7 +506,7 @@ static void ondemand_readahead(struct address_space *mapping,
>   */
>  void page_cache_sync_readahead(struct address_space *mapping,
>  			       struct file_ra_state *ra, struct file *filp,
> -			       pgoff_t offset, unsigned long req_size)
> +			       pgoff_t index, unsigned long req_count)
>  {
>  	/* no read-ahead */
>  	if (!ra->ra_pages)
> @@ -518,12 +517,12 @@ void page_cache_sync_readahead(struct address_space *mapping,
>  
>  	/* be dumb */
>  	if (filp && (filp->f_mode & FMODE_RANDOM)) {
> -		force_page_cache_readahead(mapping, filp, offset, req_size);
> +		force_page_cache_readahead(mapping, filp, index, req_count);
>  		return;
>  	}
>  
>  	/* do read-ahead */
> -	ondemand_readahead(mapping, ra, filp, false, offset, req_size);
> +	ondemand_readahead(mapping, ra, filp, false, index, req_count);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
>  
> @@ -532,21 +531,20 @@ EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
>   * @mapping: address_space which holds the pagecache and I/O vectors
>   * @ra: file_ra_state which holds the readahead state
>   * @filp: passed on to ->readpage() and ->readpages()
> - * @page: the page at @offset which has the PG_readahead flag set
> - * @offset: start offset into @mapping, in pagecache page-sized units
> - * @req_size: hint: total size of the read which the caller is performing in
> - *            pagecache pages
> + * @page: The page at @index which triggered the readahead call.
> + * @index: Index of first page to be read.
> + * @req_count: Total number of pages being read by the caller.
>   *
>   * page_cache_async_readahead() should be called when a page is used which
> - * has the PG_readahead flag; this is a marker to suggest that the application
> + * is marked as PageReadahead; this is a marker to suggest that the application
>   * has used up enough of the readahead window that we should start pulling in
>   * more pages.
>   */
>  void
>  page_cache_async_readahead(struct address_space *mapping,
>  			   struct file_ra_state *ra, struct file *filp,
> -			   struct page *page, pgoff_t offset,
> -			   unsigned long req_size)
> +			   struct page *page, pgoff_t index,
> +			   unsigned long req_count)
>  {
>  	/* no read-ahead */
>  	if (!ra->ra_pages)
> @@ -570,7 +568,7 @@ page_cache_async_readahead(struct address_space *mapping,
>  		return;
>  
>  	/* do read-ahead */
> -	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
> +	ondemand_readahead(mapping, ra, filp, true, index, req_count);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_async_readahead);
>  
> 
