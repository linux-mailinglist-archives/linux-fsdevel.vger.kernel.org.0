Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE23CAEC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGOVyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhGOVx7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD65613D2;
        Thu, 15 Jul 2021 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626385865;
        bh=C377cI/FYmnPpSlquiD6gH6gxIG8ukjLXAKL0kiIGIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiDjoVsFtj3CtW0AitkEbK7BsZVBEZaww1lq9PhM7T6XSc+v6InbUh4zoYPnXPT80
         jCze4xXEK6QHFjQYmSW7qj0g5Mci/Enz84p5d0cxTmWCx/oWsmkcJxKSP1KlRrT9KQ
         onF/gn2vhuXI+oifK1ia0uU0LhGlzUcvZEFdSjwqhkZbAeleokKHL5V18gF9p2z/2c
         M8xn0CbycsalrldSZ1tDy5P4fzz4eDvF+0q6kXDxUMc7fzDWhV2WQCWWMuVI5hW/Ji
         WgjxkiPcNy4BtPfrI17bLYYOpw2ggHa2/2gIgVi+3etnjV66xSPoPkfS4A+6dI/v4T
         +p9MYTWxHv+gw==
Date:   Thu, 15 Jul 2021 14:51:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 102/138] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <20210715215105.GM22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-103-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-103-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:28AM +0100, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from head to tail pages as a result of this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a3fe0d36c739..5e0aa23d4693 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -541,9 +541,8 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
>  
>  static int
>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> -		struct page *page, struct iomap *srcmap)
> +		struct folio *folio, struct iomap *srcmap)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = round_down(pos, block_size);
> @@ -583,12 +582,14 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	return 0;
>  }
>  
> -static int
> -iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> +static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
> +		unsigned flags, struct folio **foliop, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> +	struct folio *folio;
>  	struct page *page;
> +	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iomap->offset + iomap->length);
> @@ -604,30 +605,31 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  			return status;
>  	}
>  
> -	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> -			AOP_FLAG_NOFS);
> -	if (!page) {
> +	folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,

Ah, ok, so we're moving the file_get_pages flags up to iomap now.

> +			mapping_gfp_mask(inode->i_mapping));
> +	if (!folio) {
>  		status = -ENOMEM;
>  		goto out_no_page;
>  	}
>  
> +	page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  	if (srcmap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(inode, pos, len, flags, page,
> +		status = __iomap_write_begin(inode, pos, len, flags, folio,
>  				srcmap);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
>  
> -	*pagep = page;
> +	*foliop = folio;
>  	return 0;
>  
>  out_unlock:
> -	unlock_page(page);
> -	put_page(page);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  	iomap_write_failed(inode, pos, len);
>  
>  out_no_page:
> @@ -637,11 +639,10 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  }
>  
>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> -		size_t copied, struct page *page)
> +		size_t copied, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = to_iomap_page(folio);
> -	flush_dcache_page(page);
> +	flush_dcache_folio(folio);
>  
>  	/*
>  	 * The blocks that were entirely written will now be uptodate, so we
> @@ -654,10 +655,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 * uptodate page as a zero-length write, and force the caller to redo
>  	 * the whole thing.
>  	 */
> -	if (unlikely(copied < len && !PageUptodate(page)))
> +	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return 0;
>  	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
> -	__set_page_dirty_nobuffers(page);
> +	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
>  
> @@ -680,9 +681,10 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
>  static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> -		size_t copied, struct page *page, struct iomap *iomap,
> +		size_t copied, struct folio *folio, struct iomap *iomap,
>  		struct iomap *srcmap)
>  {
> +	struct page *page = folio_file_page(folio, pos / PAGE_SIZE);

pos >> PAGE_SHIFT ?

(There's a few more of these elsewhere...)

--D

>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	loff_t old_size = inode->i_size;
>  	size_t ret;
> @@ -693,7 +695,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>  				page, NULL);
>  	} else {
> -		ret = __iomap_write_end(inode, pos, len, copied, page);
> +		ret = __iomap_write_end(inode, pos, len, copied, folio);
>  	}
>  
>  	/*
> @@ -705,13 +707,13 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		i_size_write(inode, pos + ret);
>  		iomap->flags |= IOMAP_F_SIZE_CHANGED;
>  	}
> -	unlock_page(page);
> +	folio_unlock(folio);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(inode, old_size, pos);
>  	if (page_ops && page_ops->page_done)
>  		page_ops->page_done(inode, pos, ret, page, iomap);
> -	put_page(page);
> +	folio_put(folio);
>  
>  	if (ret < len)
>  		iomap_write_failed(inode, pos, len);
> @@ -727,6 +729,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	ssize_t written = 0;
>  
>  	do {
> +		struct folio *folio;
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
> @@ -750,18 +753,19 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> +		status = iomap_write_begin(inode, pos, bytes, 0, &folio, iomap,
>  				srcmap);
>  		if (unlikely(status))
>  			break;
>  
> +		page = folio_file_page(folio, pos / PAGE_SIZE);
>  		if (mapping_writably_mapped(inode->i_mapping))
>  			flush_dcache_page(page);
>  
>  		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>  
> -		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
> -				srcmap);
> +		status = iomap_write_end(inode, pos, bytes, copied, folio,
> +				iomap, srcmap);
>  
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
> @@ -825,14 +829,14 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	do {
>  		unsigned long offset = offset_in_page(pos);
>  		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> -		struct page *page;
> +		struct folio *folio;
>  
>  		status = iomap_write_begin(inode, pos, bytes,
> -				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
> +				IOMAP_WRITE_F_UNSHARE, &folio, iomap, srcmap);
>  		if (unlikely(status))
>  			return status;
>  
> -		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
> +		status = iomap_write_end(inode, pos, bytes, bytes, folio, iomap,
>  				srcmap);
>  		if (WARN_ON_ONCE(status == 0))
>  			return -EIO;
> @@ -871,19 +875,19 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
>  		struct iomap *iomap, struct iomap *srcmap)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	int status;
>  	unsigned offset = offset_in_page(pos);
>  	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
> +	status = iomap_write_begin(inode, pos, bytes, 0, &folio, iomap, srcmap);
>  	if (status)
>  		return status;
>  
> -	zero_user(page, offset, bytes);
> -	mark_page_accessed(page);
> +	zero_user(folio_file_page(folio, pos / PAGE_SIZE), offset, bytes);
> +	folio_mark_accessed(folio);
>  
> -	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
> +	return iomap_write_end(inode, pos, bytes, bytes, folio, iomap, srcmap);
>  }
>  
>  static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
> -- 
> 2.30.2
> 
