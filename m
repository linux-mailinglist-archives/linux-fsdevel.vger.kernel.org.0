Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E23CAEDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhGOWEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhGOWEP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3780660FE7;
        Thu, 15 Jul 2021 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386481;
        bh=EO40IYT9v1nClf3prfyuJT+UTB+r8LgL48MhF/4fssg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNtxQy0yK0wxjrhikZjLEuchIkxicTL5XK5smE0JWADnB9mLTbXkIuWSVpk2xxXur
         nFjgm4p0i7KDm3PPzXWESR0708JMhln9ZQXjyn90ei1eVjiCf4Rn4S5uk4NcvlCVij
         ZZlQh8O0NJEA9vwOWZg6sAvHJx/9z53MmzKhPKEykiMyQzFVRO5dO4HGPWuA2u54CW
         WMshcTeOOvu5RD0Tpf81Bi3fvIpk5crPmmPtpXEe/btBfQvshXhQQHZNtXJLhbI3n8
         8XKk5LdaSkL7DCKhGGlCGLGdiN6NaVQQBUzv1twHtP+yad7U/uCZYb6rIHOtVGF+dA
         SBOypKQ2uOFYg==
Date:   Thu, 15 Jul 2021 15:01:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 105/138] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <20210715220120.GP22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-106-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-106-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:31AM +0100, Matthew Wilcox (Oracle) wrote:
> We still iterate one block at a time, but now we call compound_head()
> less often.  Rename file_offset to pos to fit the rest of the file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 66 +++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ac33f19325ab..8e767aec8d07 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1252,36 +1252,29 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>   * first, otherwise finish off the current ioend and start another.
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
> -	bool merged, same_page = false;
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
> -	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
> -			&same_page);
>  	if (iop)
>  		atomic_add(len, &iop->write_bytes_pending);
> -
> -	if (!merged) {
> -		if (bio_full(wpc->ioend->io_bio, len)) {
> -			wpc->ioend->io_bio =
> -				iomap_chain_bio(wpc->ioend->io_bio);
> -		}
> -		bio_add_page(wpc->ioend->io_bio, page, len, poff);
> +	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
> +		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> +		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);

The paranoiac in me wonders if we ought to have some sort of error
checking here just in case we encounter double failures?

>  	}
>  
>  	wpc->ioend->io_size += len;
> -	wbc_account_cgroup_owner(wbc, page, len);
> +	wbc_account_cgroup_owner(wbc, &folio->page, len);
>  }
>  
>  /*
> @@ -1309,40 +1302,41 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	struct iomap_page *iop = to_iomap_page(folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
> -	u64 file_offset; /* file offset of page */
> +	unsigned nblocks = i_blocks_per_folio(inode, folio);
> +	loff_t pos = folio_pos(folio);
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> -	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
> +	WARN_ON_ONCE(nblocks > 1 && !iop);
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
> +	for (i = 0; i < nblocks; i++, pos += len) {
> +		if (pos >= end_offset)
> +			break;

Any particular reason this isn't:

	for (i = 0; i < nblocks && pos < end_offset; i++, pos += len) {

?

Everything from here on out looks decent to me.

--D

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
> @@ -1358,16 +1352,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 * now.
>  		 */
>  		if (wpc->ops->discard_page)
> -			wpc->ops->discard_page(page, file_offset);
> +			wpc->ops->discard_page(&folio->page, pos);
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
>  	 * Preserve the original error if there was one, otherwise catch
> @@ -1388,9 +1382,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
> -- 
> 2.30.2
> 
