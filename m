Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57196444521
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhKCQDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhKCQDe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3323460F39;
        Wed,  3 Nov 2021 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635955258;
        bh=qYrqAk9L8zMdD9ghnLm6MhxEpBBm+ik0BHHeiqZnFMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxOuIP8tUg4KFGAMTUYI3xCwMqMBl1Pf0mwYoXmIIypTNfA+Nq8iurfDDUFcLWmsw
         poJWmz8VDLm+oxgdb22Qr3av8lQHexE44fia0fKP7HeOqQu6B4Cw60G0Rw2lI9t7fQ
         eaobC1Z6hQNLPEVbhNFwp/r0p3bprHpgv5hNDqySWvSzA36FqsfitYa7iqR3AvVUD8
         kje+VZsz0E4aVjTX8lUJvsCqdrjs7RQQl1K8ZpQQQspaKCW1slVemGhkv0SafgCi39
         OlQYLOy4KeRyjuHpu5IGYpuFcjCT6KguPGgdAkJ5dHc42lDGcMzb20pp6ofzR3pQ6n
         04b7Inomqywhw==
Date:   Wed, 3 Nov 2021 09:00:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <20211103160057.GH24333@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYGfUuItAyTNax5V@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 08:28:02PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 02, 2021 at 12:26:42AM -0700, Christoph Hellwig wrote:
> > Looking at the code not part of the context this looks fine.  But I
> > really wonder if this (and also the blocks change above) would be
> > better off being split into separate, clearly documented patches.
> 
> How do these three patches look?  I retained your R-b on all three since
> I figured the one you offered below was good for all of them.

(TLDR: I have two RVB and a question about the third patch, please
scroll down...)

> From ab7cace8f325ca5cc1b1e62e6a8498c84738bc10 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 2 Nov 2021 10:51:55 -0400
> Subject: [PATCH 1/3] iomap: Simplify iomap_writepage_map()
> 
> Rename end_offset to end_pos and file_offset to pos to match the
> rest of the file.  Simplify the loop by calculating nblocks
> up front instead of each time around the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8f47879f9f05..e32e3cb2cf86 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1296,37 +1296,36 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  static int
>  iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
> -		struct page *page, u64 end_offset)
> +		struct page *page, loff_t end_pos)
>  {
>  	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
> -	u64 file_offset; /* file offset of page */
> +	unsigned nblocks = i_blocks_per_folio(inode, folio);
> +	loff_t pos = folio_pos(folio);
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>  
>  	/*
> -	 * Walk through the page to find areas to write back. If we run off the
> -	 * end of the current map or find the current map invalid, grab a new
> -	 * one.
> +	 * Walk through the folio to find areas to write back. If we
> +	 * run off the end of the current map or find the current map
> +	 * invalid, grab a new one.
>  	 */
> -	for (i = 0, file_offset = page_offset(page);
> -	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
> -	     i++, file_offset += len) {
> +	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>  		if (iop && !test_bit(i, iop->uptodate))
>  			continue;
>  
> -		error = wpc->ops->map_blocks(wpc, inode, file_offset);
> +		error = wpc->ops->map_blocks(wpc, inode, pos);
>  		if (error)
>  			break;
>  		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
>  			continue;
>  		if (wpc->iomap.type == IOMAP_HOLE)
>  			continue;
> -		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
> +		iomap_add_to_ioend(inode, pos, page, iop, wpc, wbc,
>  				 &submit_list);
>  		count++;
>  	}
> @@ -1350,7 +1349,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 * now.
>  		 */
>  		if (wpc->ops->discard_folio)
> -			wpc->ops->discard_folio(page_folio(page), file_offset);
> +			wpc->ops->discard_folio(folio, pos);

/me wonders why this wouldn't have been done in whichever patch added
folio as a local variable, but fmeh, the end result is the same:

Pretty straightforward conversion,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(onto the next patch)

>  		if (!count) {
>  			ClearPageUptodate(page);
>  			unlock_page(page);
> -- 
> 2.33.0
> 
> 
> From 07c994353e357c3b4252595a80b86e8565deb09c Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 2 Nov 2021 11:41:16 -0400
> Subject: [PATCH 2/3] iomap: Simplify iomap_do_writepage()
> 
> Rename end_offset to end_pos and offset_into_page to poff to match the
> rest of the file.  Simplify the handling of the last page straddling
> i_size.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e32e3cb2cf86..4f4f33849417 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1397,9 +1397,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  {
>  	struct iomap_writepage_ctx *wpc = data;
>  	struct inode *inode = page->mapping->host;
> -	pgoff_t end_index;
> -	u64 end_offset;
> -	loff_t offset;
> +	loff_t end_pos, isize;
>  
>  	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
>  
> @@ -1430,11 +1428,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	 * |     desired writeback range    |      see else    |
>  	 * ---------------------------------^------------------|
>  	 */
> -	offset = i_size_read(inode);
> -	end_index = offset >> PAGE_SHIFT;
> -	if (page->index < end_index)
> -		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
> -	else {
> +	isize = i_size_read(inode);
> +	end_pos = page_offset(page) + PAGE_SIZE;
> +	if (end_pos - 1 >= isize) {

This old code was good at twisting my brain in knots, thanks for
cleaning this up.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(onto the third patch)

>  		/*
>  		 * Check whether the page to write out is beyond or straddles
>  		 * i_size or not.
> @@ -1446,7 +1442,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * |				    |      Straddles     |
>  		 * ---------------------------------^-----------|--------|
>  		 */
> -		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
> +		size_t poff = offset_in_page(isize);
> +		pgoff_t end_index = isize >> PAGE_SHIFT;
>  
>  		/*
>  		 * Skip the page if it's fully outside i_size, e.g. due to a
> @@ -1466,7 +1463,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * offset is just equal to the EOF.
>  		 */
>  		if (page->index > end_index ||
> -		    (page->index == end_index && offset_into_page == 0))
> +		    (page->index == end_index && poff == 0))
>  			goto redirty;
>  
>  		/*
> @@ -1477,13 +1474,13 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * memory is zeroed when mapped, and writes to that region are
>  		 * not written out to the file."
>  		 */
> -		zero_user_segment(page, offset_into_page, PAGE_SIZE);
> +		zero_user_segment(page, poff, PAGE_SIZE);
>  
>  		/* Adjust the end_offset to the end of file */
> -		end_offset = offset;
> +		end_pos = isize;
>  	}
>  
> -	return iomap_writepage_map(wpc, wbc, inode, page, end_offset);
> +	return iomap_writepage_map(wpc, wbc, inode, page, end_pos);
>  
>  redirty:
>  	redirty_page_for_writepage(wbc, page);
> -- 
> 2.33.0
> 
> 
> From d5412657a503ae27efb5770fbc1c5c980180c9c4 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 2 Nov 2021 12:45:12 -0400
> Subject: [PATCH 3/3] iomap: Convert iomap_add_to_ioend to take a folio
> 
> We still iterate one block at a time, but now we call compound_head()
> less often.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 70 ++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4f4f33849417..8908368abd49 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1252,29 +1252,29 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>   * first; otherwise finish off the current ioend and start another.
>   */
>  static void
> -iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
> +iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
>  		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct list_head *iolist)
>  {
> -	sector_t sector = iomap_sector(&wpc->iomap, offset);
> +	sector_t sector = iomap_sector(&wpc->iomap, pos);
>  	unsigned len = i_blocksize(inode);
> -	unsigned poff = offset & (PAGE_SIZE - 1);
> +	size_t poff = offset_in_folio(folio, pos);
>  
> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
> +	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, sector)) {
>  		if (wpc->ioend)
>  			list_add(&wpc->ioend->io_list, iolist);
> -		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
> +		wpc->ioend = iomap_alloc_ioend(inode, wpc, pos, sector, wbc);
>  	}
>  
> -	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
> +	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
>  		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> -		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
> +		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
>  	}
>  
>  	if (iop)
>  		atomic_add(len, &iop->write_bytes_pending);
>  	wpc->ioend->io_size += len;
> -	wbc_account_cgroup_owner(wbc, page, len);
> +	wbc_account_cgroup_owner(wbc, &folio->page, len);
>  }
>  
>  /*
> @@ -1296,9 +1296,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  static int
>  iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
> -		struct page *page, loff_t end_pos)
> +		struct folio *folio, loff_t end_pos)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
> @@ -1325,15 +1324,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  			continue;
>  		if (wpc->iomap.type == IOMAP_HOLE)
>  			continue;
> -		iomap_add_to_ioend(inode, pos, page, iop, wpc, wbc,
> +		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
>  				 &submit_list);
>  		count++;
>  	}
>  
>  	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
> -	WARN_ON_ONCE(!PageLocked(page));
> -	WARN_ON_ONCE(PageWriteback(page));
> -	WARN_ON_ONCE(PageDirty(page));
> +	WARN_ON_ONCE(!folio_test_locked(folio));
> +	WARN_ON_ONCE(folio_test_writeback(folio));
> +	WARN_ON_ONCE(folio_test_dirty(folio));
>  
>  	/*
>  	 * We cannot cancel the ioend directly here on error.  We may have
> @@ -1351,14 +1350,14 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		if (wpc->ops->discard_folio)
>  			wpc->ops->discard_folio(folio, pos);
>  		if (!count) {
> -			ClearPageUptodate(page);
> -			unlock_page(page);
> +			folio_clear_uptodate(folio);
> +			folio_unlock(folio);
>  			goto done;
>  		}
>  	}
>  
> -	set_page_writeback(page);
> -	unlock_page(page);
> +	folio_start_writeback(folio);
> +	folio_unlock(folio);
>  
>  	/*
>  	 * Preserve the original error if there was one; catch
> @@ -1379,9 +1378,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * with a partial page truncate on a sub-page block sized filesystem.
>  	 */
>  	if (!count)
> -		end_page_writeback(page);
> +		folio_end_writeback(folio);
>  done:
> -	mapping_set_error(page->mapping, error);
> +	mapping_set_error(folio->mapping, error);
>  	return error;
>  }
>  
> @@ -1395,14 +1394,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  static int
>  iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  {
> +	struct folio *folio = page_folio(page);
>  	struct iomap_writepage_ctx *wpc = data;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	loff_t end_pos, isize;
>  
> -	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
> +	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
>  
>  	/*
> -	 * Refuse to write the page out if we're called from reclaim context.
> +	 * Refuse to write the folio out if we're called from reclaim context.
>  	 *
>  	 * This avoids stack overflows when called from deeply used stacks in
>  	 * random callers for direct reclaim or memcg reclaim.  We explicitly
> @@ -1416,10 +1416,10 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		goto redirty;
>  
>  	/*
> -	 * Is this page beyond the end of the file?
> +	 * Is this folio beyond the end of the file?
>  	 *
> -	 * The page index is less than the end_index, adjust the end_offset
> -	 * to the highest offset that this page should represent.
> +	 * The folio index is less than the end_index, adjust the end_pos
> +	 * to the highest offset that this folio should represent.
>  	 * -----------------------------------------------------
>  	 * |			file mapping	       | <EOF> |
>  	 * -----------------------------------------------------
> @@ -1429,7 +1429,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	 * ---------------------------------^------------------|
>  	 */
>  	isize = i_size_read(inode);
> -	end_pos = page_offset(page) + PAGE_SIZE;
> +	end_pos = folio_pos(folio) + folio_size(folio);
>  	if (end_pos - 1 >= isize) {
>  		/*
>  		 * Check whether the page to write out is beyond or straddles
> @@ -1442,7 +1442,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * |				    |      Straddles     |
>  		 * ---------------------------------^-----------|--------|
>  		 */
> -		size_t poff = offset_in_page(isize);
> +		size_t poff = offset_in_folio(folio, isize);
>  		pgoff_t end_index = isize >> PAGE_SHIFT;
>  
>  		/*
> @@ -1462,8 +1462,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * checking if the page is totally beyond i_size or if its
>  		 * offset is just equal to the EOF.
>  		 */
> -		if (page->index > end_index ||
> -		    (page->index == end_index && poff == 0))
> +		if (folio->index > end_index ||
> +		    (folio->index == end_index && poff == 0))
>  			goto redirty;
>  
>  		/*
> @@ -1474,17 +1474,15 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  		 * memory is zeroed when mapped, and writes to that region are
>  		 * not written out to the file."
>  		 */
> -		zero_user_segment(page, poff, PAGE_SIZE);
> -
> -		/* Adjust the end_offset to the end of file */
> +		zero_user_segment(&folio->page, poff, folio_size(folio));

Question: is &folio->page != page here?  I guess the idea is that we
have a (potentially multi-page) folio straddling i_size, and we need to
zero everything in the whole folio after i_size.  But then why not pass
the whole folio?

--D

>  		end_pos = isize;
>  	}
>  
> -	return iomap_writepage_map(wpc, wbc, inode, page, end_pos);
> +	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
>  
>  redirty:
> -	redirty_page_for_writepage(wbc, page);
> -	unlock_page(page);
> +	folio_redirty_for_writepage(wbc, folio);
> +	folio_unlock(folio);
>  	return 0;
>  }
>  
> -- 
> 2.33.0
> 
