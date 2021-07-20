Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680F3D05F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 02:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhGTXTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 19:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231823AbhGTXS6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:18:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C72260D07;
        Tue, 20 Jul 2021 23:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626825576;
        bh=ORiFGnA0nOpBSGxcUiu+Os7JxiVUTBcNfYmkhYu+6ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Swn7E2ms0JipFaIqqxamYLOziqLsX8LOVmfu9pLMTv6CFMJ8vvxB4oAkky5HfDcNq
         Etq5fbMPW6TvG/MStHxJ9uo2bW/X97S/qVz3NzQtwY+uTHbzEgpnic4jYMhmOrSAOf
         mYhAlj3OWdh5+Qc1+2eC5ThH7w4OHCopttUfN4PD6RyoqiD6mj18acTtWrm/KyyP+H
         Zec4ABFiSg5cM3UKusigKoQQWkh1PgoqBFrP0XZSTq9vrACwvnZ11btd+X5IXj3sCs
         AE+a21PzUbLNBzH41952bOlYJb7JkkFQXIY5STub9xmR4dq4L34JjIXPgpe5l7xLor
         mfIdNrZ6hKuxA==
Date:   Tue, 20 Jul 2021 16:59:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 13/17] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <20210720235935.GP22357@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-14-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:57PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from head to tail pages as a result of this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Woo, this looks like a straightforward conversion.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index dd05db36e135..4b02337009bc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -543,9 +543,8 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
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
> @@ -585,12 +584,14 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
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
> @@ -606,30 +607,31 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  			return status;
>  	}
>  
> -	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> -			AOP_FLAG_NOFS);
> -	if (!page) {
> +	folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,
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
> @@ -639,11 +641,10 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
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
> @@ -656,10 +657,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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
> @@ -682,9 +683,10 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
>  static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> -		size_t copied, struct page *page, struct iomap *iomap,
> +		size_t copied, struct folio *folio, struct iomap *iomap,
>  		struct iomap *srcmap)
>  {
> +	struct page *page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	loff_t old_size = inode->i_size;
>  	size_t ret;
> @@ -695,7 +697,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>  				page, NULL);
>  	} else {
> -		ret = __iomap_write_end(inode, pos, len, copied, page);
> +		ret = __iomap_write_end(inode, pos, len, copied, folio);
>  	}
>  
>  	/*
> @@ -707,13 +709,13 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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
> @@ -729,6 +731,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	ssize_t written = 0;
>  
>  	do {
> +		struct folio *folio;
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
> @@ -752,18 +755,19 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> +		status = iomap_write_begin(inode, pos, bytes, 0, &folio, iomap,
>  				srcmap);
>  		if (unlikely(status))
>  			break;
>  
> +		page = folio_file_page(folio, pos >> PAGE_SHIFT);
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
> @@ -827,14 +831,14 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
> @@ -873,19 +877,19 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
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
> +	zero_user(folio_file_page(folio, pos >> PAGE_SHIFT), offset, bytes);
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
