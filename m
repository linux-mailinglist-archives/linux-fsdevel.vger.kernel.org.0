Return-Path: <linux-fsdevel+bounces-57920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757EB26CAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425923B1AF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60825A354;
	Thu, 14 Aug 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXOp8cEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF273220F52
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189480; cv=none; b=CUqOzL+5gUOWbUIPE+4W23jojBVl6WDQJeyP9rJhvKTe71ZllYUFHTriLdrlr3bwq8pZTbMRWabDNCrq972Q/W0jbchYBL57YgS6u3tvmSDe1UQC9/QYt0wXZkLEyVIAedlOQAxG980ORmlCZYlcyn9Jc0NUU6G8VGQSLaUYfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189480; c=relaxed/simple;
	bh=7K0HQrsabxo6vKvdSE2xx5aV5V+QQq2/H8olbM0gpFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzVUXBJCtl4CtCxIhT4bFPsI/f+7RZRjUTAvqphOAXoxkc/ltAoA0QXNjriY9D2uTd666xGzLs8azsTmMg3yY5gnFf7uyrFLs++hUwLoyg6LCZmBJ2Om2iKtYgyOrfJb/JiBkNNs8YhmJ+ZF1ShGJ+jOsxVOp0EKa0+HeZKo2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXOp8cEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E81C4CEED;
	Thu, 14 Aug 2025 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755189480;
	bh=7K0HQrsabxo6vKvdSE2xx5aV5V+QQq2/H8olbM0gpFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXOp8cEi3e83luB6yOF0OPlVJB1ymPCOy3WWU7Zb6k2Zacict4cdINUUAyyd+n6VE
	 YlNfCoRbX7Y1fFvoTKbwQBSROYF/9ZUAIhFiiV0LUcVKUBdH0Hbl7+f2YfjV5d/FUA
	 LUV+zidqwOC5eclkwV8ggMuBl7bUPGFINVMd9OmYp3IQt9OsMAWbcMQbyrnV4jFn24
	 NDnieF1/4j/dhNtKWZ1ERwylNztAoJhJnjJmbMi+hHVuSpOOrikty+2L6FxT43TO/n
	 MDN7AnMjr7udRxbnf5nqqeQR5nWODmmB8NX+kWYF6Bd5GGEP4dKY68UqbYJgEjDrio
	 7yl2XeZxAYjwA==
Date: Thu, 14 Aug 2025 09:37:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback
 accounting
Message-ID: <20250814163759.GN7942@frogsfrogsfrogs>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-11-joannelkoong@gmail.com>

On Thu, Jul 31, 2025 at 05:21:31PM -0700, Joanne Koong wrote:
> Add granular dirty and writeback accounting for large folios. These
> stats are used by the mm layer for dirty balancing and throttling.
> Having granular dirty and writeback accounting helps prevent
> over-aggressive balancing and throttling.
> 
> There are 4 places in iomap this commit affects:
> a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> b) writeback_iter with setting the wbc->no_stats_accounting bit and
> calling clear_dirty_for_io_stats()
> c) starting writeback, which now calls __folio_start_writeback()
> d) ending writeback, which now calls folio_end_writeback_pages()
> 
> This relies on using the ifs->state dirty bitmap to track dirty pages in
> the folio. As such, this can only be utilized on filesystems where the
> block size >= PAGE_SIZE.

Apologies for my slow responses this month. :)

I wonder, does this cause an observable change in the writeback
accounting and throttling behavior for non-fuse filesystems like XFS
that use large folios?  I *think* this does actually reduce throttling
for XFS, but it might not be so noticeable because the limits are much
more generous outside of fuse?

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 136 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcc6e0e5334e..626c3c8399cc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -20,6 +20,8 @@ struct iomap_folio_state {
>  	spinlock_t		state_lock;
>  	unsigned int		read_bytes_pending;
>  	atomic_t		write_bytes_pending;
> +	/* number of pages being currently written back */
> +	unsigned		nr_pages_writeback;
>  
>  	/*
>  	 * Each block has two bits in this bitmap:
> @@ -81,6 +83,25 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
>  	return test_bit(block + blks_per_folio, ifs->state);
>  }
>  
> +static unsigned ifs_count_dirty_pages(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode = folio->mapping->host;
> +	unsigned block_size = 1 << inode->i_blkbits;
> +	unsigned start_blk = 0;
> +	unsigned end_blk = min((unsigned)(i_size_read(inode) >> inode->i_blkbits),
> +				i_blocks_per_folio(inode, folio));
> +	unsigned nblks = 0;
> +
> +	while (start_blk < end_blk) {
> +		if (ifs_block_is_dirty(folio, ifs, start_blk))
> +			nblks++;
> +		start_blk++;
> +	}

Hmm, isn't this bitmap_weight(ifs->state, blks_per_folio) ?

Ohh wait no, the dirty bitmap doesn't start on a byte boundary because
the format of the bitmap is [uptodate bits][dirty bits].

Maybe those two should be reversed, because I bet the dirty state gets
changed a lot more over the lifetime of a folio than the uptodate bits.

> +
> +	return nblks * (block_size >> PAGE_SHIFT);
> +}
> +
>  static unsigned ifs_find_dirty_range(struct folio *folio,
>  		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
>  {
> @@ -165,6 +186,63 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
>  		ifs_set_range_dirty(folio, ifs, off, len);
>  }
>  
> +static long iomap_get_range_newly_dirtied(struct folio *folio, loff_t pos,
> +		unsigned len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode = folio->mapping->host;
> +	unsigned start_blk = pos >> inode->i_blkbits;
> +	unsigned end_blk = min((unsigned)((pos + len - 1) >> inode->i_blkbits),
> +				i_blocks_per_folio(inode, folio) - 1);
> +	unsigned nblks = 0;
> +	unsigned block_size = 1 << inode->i_blkbits;
> +
> +	while (start_blk <= end_blk) {
> +		if (!ifs_block_is_dirty(folio, ifs, start_blk))
> +			nblks++;
> +		start_blk++;
> +	}

...then this becomes (endblk - startblk) - bitmap_weight().

> +
> +	return nblks * (block_size >> PAGE_SHIFT);
> +}
> +
> +static bool iomap_granular_dirty_pages(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode;
> +	unsigned block_size;
> +
> +	if (!ifs)
> +		return false;
> +
> +	inode = folio->mapping->host;
> +	block_size = 1 << inode->i_blkbits;
> +
> +	if (block_size >= PAGE_SIZE) {
> +		WARN_ON(block_size & (PAGE_SIZE - 1));
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static bool iomap_dirty_folio_range(struct address_space *mapping, struct folio *folio,
> +			loff_t pos, unsigned len)
> +{
> +	long nr_new_dirty_pages;
> +
> +	if (!iomap_granular_dirty_pages(folio)) {
> +		iomap_set_range_dirty(folio, pos, len);
> +		return filemap_dirty_folio(mapping, folio);
> +	}
> +
> +	nr_new_dirty_pages = iomap_get_range_newly_dirtied(folio, pos, len);
> +	if (!nr_new_dirty_pages)
> +		return false;
> +
> +	iomap_set_range_dirty(folio, pos, len);
> +	return filemap_dirty_folio_pages(mapping, folio, nr_new_dirty_pages);
> +}
> +
>  static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>  		struct folio *folio, unsigned int flags)
>  {
> @@ -661,8 +739,7 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
>  	size_t len = folio_size(folio);
>  
>  	ifs_alloc(inode, folio, 0);
> -	iomap_set_range_dirty(folio, 0, len);
> -	return filemap_dirty_folio(mapping, folio);
> +	return iomap_dirty_folio_range(mapping, folio, 0, len);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dirty_folio);
>  
> @@ -886,8 +963,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return false;
>  	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
> -	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
> -	filemap_dirty_folio(inode->i_mapping, folio);
> +	iomap_dirty_folio_range(inode->i_mapping, folio,
> +			offset_in_folio(folio, pos), copied);
>  	return true;
>  }
>  
> @@ -1560,6 +1637,29 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
>  }
>  EXPORT_SYMBOL_GPL(iomap_start_folio_write);
>  
> +static void iomap_folio_start_writeback(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	if (!iomap_granular_dirty_pages(folio))
> +		return folio_start_writeback(folio);
> +
> +	__folio_start_writeback(folio, false, ifs->nr_pages_writeback);
> +}
> +
> +static void iomap_folio_end_writeback(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	long nr_pages_writeback;
> +
> +	if (!iomap_granular_dirty_pages(folio))
> +		return folio_end_writeback(folio);
> +
> +	nr_pages_writeback = ifs->nr_pages_writeback;
> +	ifs->nr_pages_writeback = 0;
> +	folio_end_writeback_pages(folio, nr_pages_writeback);
> +}
> +
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len)
>  {
> @@ -1569,7 +1669,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
>  
>  	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
> -		folio_end_writeback(folio);
> +		iomap_folio_end_writeback(folio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
>  
> @@ -1657,6 +1757,21 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> +static void iomap_update_dirty_stats(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	long nr_dirty_pages;
> +
> +	if (iomap_granular_dirty_pages(folio)) {
> +		nr_dirty_pages = ifs_count_dirty_pages(folio);
> +		ifs->nr_pages_writeback = nr_dirty_pages;
> +	} else {
> +		nr_dirty_pages = folio_nr_pages(folio);
> +	}
> +
> +	clear_dirty_for_io_stats(folio, nr_dirty_pages);
> +}
> +
>  int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> @@ -1674,6 +1789,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  
>  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> +	iomap_update_dirty_stats(folio);
> +
>  	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
>  		return 0;
>  	WARN_ON_ONCE(end_pos <= pos);
> @@ -1681,6 +1798,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	if (i_blocks_per_folio(inode, folio) > 1) {
>  		if (!ifs) {
>  			ifs = ifs_alloc(inode, folio, 0);
> +			ifs->nr_pages_writeback = folio_nr_pages(folio);
>  			iomap_set_range_dirty(folio, 0, end_pos - pos);
>  		}
>  
> @@ -1698,7 +1816,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	 * Set the writeback bit ASAP, as the I/O completion for the single
>  	 * block per folio case happen hit as soon as we're submitting the bio.
>  	 */
> -	folio_start_writeback(folio);
> +	iomap_folio_start_writeback(folio);
>  
>  	/*
>  	 * Walk through the folio to find dirty areas to write back.
> @@ -1731,10 +1849,10 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	 */
>  	if (ifs) {
>  		if (atomic_dec_and_test(&ifs->write_bytes_pending))
> -			folio_end_writeback(folio);
> +			iomap_folio_end_writeback(folio);
>  	} else {
>  		if (!wb_pending)
> -			folio_end_writeback(folio);
> +			iomap_folio_end_writeback(folio);
>  	}
>  	mapping_set_error(inode->i_mapping, error);
>  	return error;
> @@ -1756,6 +1874,8 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
>  			PF_MEMALLOC))
>  		return -EIO;
>  
> +	wpc->wbc->no_stats_accounting = true;
> +
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
>  		error = iomap_writeback_folio(wpc, folio);
>  		folio_unlock(folio);
> -- 
> 2.47.3
> 
> 

