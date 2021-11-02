Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD844398E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 00:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhKBXYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 19:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhKBXYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:24:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C931060F90;
        Tue,  2 Nov 2021 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635895335;
        bh=hh1XvCtAGXhkzXESsTFx/N/yLgo9NT5r8ywDgrvHFTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epcyrvuoyC59+hs4bJh+FGW8oEZfCl3j25PbDVpgH/W7OoANk33IqU9ST0CaaBtzS
         ws9Vj4m1tPZTdyed0TRzqbAE3Z3XoxPpzIR1EV8CP+AnGB07T4Zxm78nc32M25swjX
         h2/ltRF72w8uOm6DtLQunpPCoBktO70BlZwNACbk1SJU3ELt1IIRB3m/JcX4pwMnAJ
         4DvMwt+iOnERflWdG/MFrnLjJDxw/Lqkv8jixtd7IcB6vhZU+twPvz0CESExel3uy0
         cQcwEBmOsuyA0LYFySe9Jfe1wS9bmSlG+uqQicWCk7aKSYYd57HMI9RQ3kjK0T8lSf
         YL7Ks9QyuL8OA==
Date:   Tue, 2 Nov 2021 16:22:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/21] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <20211102232215.GG2237511@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-16-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:23PM +0000, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from tail to head pages as a result of this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b55d947867b1..6df8fdbb1951 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -539,9 +539,8 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
>  }
>  
>  static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> -		unsigned len, struct page *page)
> +		size_t len, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct iomap_page *iop = iomap_page_create(iter->inode, folio);
>  	loff_t block_size = i_blocksize(iter->inode);
> @@ -583,9 +582,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  }
>  
>  static int iomap_write_begin_inline(const struct iomap_iter *iter,
> -		struct page *page)
> +		struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	int ret;
>  
>  	/* needs more work for the tailpacking case; disable for now */
> @@ -598,11 +596,13 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  }
>  
>  static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> -		unsigned len, struct page **pagep)
> +		size_t len, struct folio **foliop)
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	struct folio *folio;
>  	struct page *page;
> +	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> @@ -618,29 +618,30 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  			return status;
>  	}
>  
> -	page = grab_cache_page_write_begin(iter->inode->i_mapping,
> -				pos >> PAGE_SHIFT, AOP_FLAG_NOFS);
> -	if (!page) {
> +	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> +			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> +	if (!folio) {
>  		status = -ENOMEM;
>  		goto out_no_page;
>  	}
>  
> +	page = folio_file_page(folio, pos >> PAGE_SHIFT);

Isn't this only needed in the BUFFER_HEAD case?

--D

>  	if (srcmap->type == IOMAP_INLINE)
> -		status = iomap_write_begin_inline(iter, page);
> +		status = iomap_write_begin_inline(iter, folio);
>  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(iter, pos, len, page);
> +		status = __iomap_write_begin(iter, pos, len, folio);
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
>  	iomap_write_failed(iter->inode, pos, len);
>  
>  out_no_page:
> @@ -650,11 +651,10 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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
> @@ -667,10 +667,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 * non-uptodate page as a zero-length write, and force the caller to
>  	 * redo the whole thing.
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
> @@ -694,8 +694,9 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
>  
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
>  static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> -		size_t copied, struct page *page)
> +		size_t copied, struct folio *folio)
>  {
> +	struct page *page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t old_size = iter->inode->i_size;
> @@ -707,7 +708,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
>  				copied, page, NULL);
>  	} else {
> -		ret = __iomap_write_end(iter->inode, pos, len, copied, page);
> +		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
>  	}
>  
>  	/*
> @@ -719,13 +720,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		i_size_write(iter->inode, pos + ret);
>  		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  	}
> -	unlock_page(page);
> +	folio_unlock(folio);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(iter->inode, old_size, pos);
>  	if (page_ops && page_ops->page_done)
>  		page_ops->page_done(iter->inode, pos, ret, page);
> -	put_page(page);
> +	folio_put(folio);
>  
>  	if (ret < len)
>  		iomap_write_failed(iter->inode, pos, len);
> @@ -740,6 +741,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  	long status = 0;
>  
>  	do {
> +		struct folio *folio;
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
> @@ -763,16 +765,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, pos, bytes, &page);
> +		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (unlikely(status))
>  			break;
>  
> +		page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  		if (mapping_writably_mapped(iter->inode->i_mapping))
>  			flush_dcache_page(page);
>  
>  		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>  
> -		status = iomap_write_end(iter, pos, bytes, copied, page);
> +		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
> @@ -838,13 +841,13 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  	do {
>  		unsigned long offset = offset_in_page(pos);
>  		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> -		struct page *page;
> +		struct folio *folio;
>  
> -		status = iomap_write_begin(iter, pos, bytes, &page);
> +		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (unlikely(status))
>  			return status;
>  
> -		status = iomap_write_end(iter, pos, bytes, bytes, page);
> +		status = iomap_write_end(iter, pos, bytes, bytes, folio);
>  		if (WARN_ON_ONCE(status == 0))
>  			return -EIO;
>  
> @@ -880,19 +883,19 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	int status;
>  	unsigned offset = offset_in_page(pos);
>  	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	status = iomap_write_begin(iter, pos, bytes, &page);
> +	status = iomap_write_begin(iter, pos, bytes, &folio);
>  	if (status)
>  		return status;
>  
> -	zero_user(page, offset, bytes);
> -	mark_page_accessed(page);
> +	zero_user(folio_file_page(folio, pos >> PAGE_SHIFT), offset, bytes);
> +	folio_mark_accessed(folio);
>  
> -	return iomap_write_end(iter, pos, bytes, bytes, page);
> +	return iomap_write_end(iter, pos, bytes, bytes, folio);
>  }
>  
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> -- 
> 2.33.0
> 
