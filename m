Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A3453FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKQEif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhKQEie (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:38:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECDC619F6;
        Wed, 17 Nov 2021 04:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637123736;
        bh=lLK2m/g/rYAh3Vwa+4eN/Dmc3Z5OsRkwB51PHxhEq2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N82HhoRa8kcepZBKLTx9GoDdDDXlla6C9aIVXQ3zMn78m4l7ubK/20Uoq7PwPKEsV
         xnQnVUVv5rvXTe1mugpEvbw28erlgDOVcG2YQ3ZeAcK1I299R+lMh5LLVBEAnLs87L
         x8aLB9X0AnYbPPBWEkP4JIDqlwoe2z1lYY/x05EY71G/1Iro/XB0A0qqQn5iH9SZ8N
         8jyuOPTvH2WlBdtWFj+jBYXVWdu/D/h4KyPRQtYrb/AcqWsuU2H1u6AYwc5FQZ0qc7
         xzXxwCcBZYpD7pzjre6eEvoio1xoutP+Xulse5fqLoKuQ0CWkNKw2RZFo8bBXYKg/d
         VZWsgErXvGsww==
Date:   Tue, 16 Nov 2021 20:35:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 07/28] fs/buffer: Convert __block_write_begin_int() to
 take a folio
Message-ID: <20211117043536.GM24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:30AM +0000, Matthew Wilcox (Oracle) wrote:
> There are no plans to convert buffer_head infrastructure to use multi-page
> folios, but __block_write_begin_int() is called from iomap, and it's
> more convenient and less error-prone if we pass in a folio from iomap.
> It also has a nice saving of almost 200 bytes of code from removing
> repeated calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Pretty straightforward,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/buffer.c            | 22 +++++++++++-----------
>  fs/internal.h          |  2 +-
>  fs/iomap/buffered-io.c |  7 +++++--
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 46bc589b7a03..b1d722b26fe9 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1969,34 +1969,34 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  	}
>  }
>  
> -int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> +int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block, const struct iomap *iomap)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
>  	unsigned to = from + len;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	unsigned block_start, block_end;
>  	sector_t block;
>  	int err = 0;
>  	unsigned blocksize, bbits;
>  	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
>  
> -	BUG_ON(!PageLocked(page));
> +	BUG_ON(!folio_test_locked(folio));
>  	BUG_ON(from > PAGE_SIZE);
>  	BUG_ON(to > PAGE_SIZE);
>  	BUG_ON(from > to);
>  
> -	head = create_page_buffers(page, inode, 0);
> +	head = create_page_buffers(&folio->page, inode, 0);
>  	blocksize = head->b_size;
>  	bbits = block_size_bits(blocksize);
>  
> -	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
> +	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
>  
>  	for(bh = head, block_start = 0; bh != head || !block_start;
>  	    block++, block_start=block_end, bh = bh->b_this_page) {
>  		block_end = block_start + blocksize;
>  		if (block_end <= from || block_start >= to) {
> -			if (PageUptodate(page)) {
> +			if (folio_test_uptodate(folio)) {
>  				if (!buffer_uptodate(bh))
>  					set_buffer_uptodate(bh);
>  			}
> @@ -2016,20 +2016,20 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>  
>  			if (buffer_new(bh)) {
>  				clean_bdev_bh_alias(bh);
> -				if (PageUptodate(page)) {
> +				if (folio_test_uptodate(folio)) {
>  					clear_buffer_new(bh);
>  					set_buffer_uptodate(bh);
>  					mark_buffer_dirty(bh);
>  					continue;
>  				}
>  				if (block_end > to || block_start < from)
> -					zero_user_segments(page,
> +					folio_zero_segments(folio,
>  						to, block_end,
>  						block_start, from);
>  				continue;
>  			}
>  		}
> -		if (PageUptodate(page)) {
> +		if (folio_test_uptodate(folio)) {
>  			if (!buffer_uptodate(bh))
>  				set_buffer_uptodate(bh);
>  			continue; 
> @@ -2050,14 +2050,14 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
>  			err = -EIO;
>  	}
>  	if (unlikely(err))
> -		page_zero_new_buffers(page, from, to);
> +		page_zero_new_buffers(&folio->page, from, to);
>  	return err;
>  }
>  
>  int __block_write_begin(struct page *page, loff_t pos, unsigned len,
>  		get_block_t *get_block)
>  {
> -	return __block_write_begin_int(page, pos, len, get_block, NULL);
> +	return __block_write_begin_int(page_folio(page), pos, len, get_block, NULL);
>  }
>  EXPORT_SYMBOL(__block_write_begin);
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index cdd83d4899bb..afc13443392b 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -37,7 +37,7 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
>  /*
>   * buffer.c
>   */
> -int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> +int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		get_block_t *get_block, const struct iomap *iomap);
>  
>  /*
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1753c26c8e76..4e09ea823148 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -597,6 +597,7 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct page *page;
> +	struct folio *folio;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> @@ -618,11 +619,12 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		status = -ENOMEM;
>  		goto out_no_page;
>  	}
> +	folio = page_folio(page);
>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		status = iomap_write_begin_inline(iter, page);
>  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> -		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> +		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
>  	else
>  		status = __iomap_write_begin(iter, pos, len, page);
>  
> @@ -954,11 +956,12 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
>  		struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
>  	loff_t length = iomap_length(iter);
>  	int ret;
>  
>  	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = __block_write_begin_int(page, iter->pos, length, NULL,
> +		ret = __block_write_begin_int(folio, iter->pos, length, NULL,
>  					      &iter->iomap);
>  		if (ret)
>  			return ret;
> -- 
> 2.33.0
> 
