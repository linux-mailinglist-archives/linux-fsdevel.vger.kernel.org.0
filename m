Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2A3CEA28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbhGSRID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349680AbhGSRHi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:07:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2737661244;
        Mon, 19 Jul 2021 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716897;
        bh=Rs/YchSJN0rGd9psvqlGfWPnVHuDOs8lw2CLoWTu7AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2juWumXeAYnjOVzwR0q+agqIdncx1yA+U3CJiqzGx4s0l+LEIHiaGe2jcxhMzyON
         KCoPK0/PsrzUQ5bGYP0X4HoVf8e7e35VeMj+XhSLQFow/DSM+L+lwTphYfKADbw0kI
         xv4N4QagfY3vr3AkzluX2OHj6OF4XVnd6bt1TkuEm0iDKoPIX0gJOF+7giFpeb0liF
         2oKxxjfJpnq1lMd43y/QQDxR/6YRitZqDAk3jXWvCHD2w9JOQNvhTVNdQZMjCEmawk
         IG/caAqCOptjRu7ARlazLpeIbR1Ny7biVYppbPVAYveMpW2I2zlmFEF6mvzf1S3G9Z
         /noaH6T0dJryg==
Date:   Mon, 19 Jul 2021 10:48:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 22/27] iomap: pass an iomap_iter to various buffered I/O
 helpers
Message-ID: <20210719174816.GK22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-23-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:15PM +0200, Christoph Hellwig wrote:
> Pass the iomap_iter structure instead of individual parameters to
> various internal helpers for buffered I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 117 ++++++++++++++++++++---------------------
>  1 file changed, 56 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c273b5d88dd8a8..daabbe8d7edfb5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -226,12 +226,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  	SetPageUptodate(page);
>  }
>  
> -static inline bool iomap_block_needs_zeroing(struct inode *inode,
> -		struct iomap *iomap, loff_t pos)
> +static inline bool iomap_block_needs_zeroing(struct iomap_iter *iter,
> +		loff_t pos)
>  {
> -	return iomap->type != IOMAP_MAPPED ||
> -		(iomap->flags & IOMAP_F_NEW) ||
> -		pos >= i_size_read(inode);
> +	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +	return srcmap->type != IOMAP_MAPPED ||
> +		(srcmap->flags & IOMAP_F_NEW) ||
> +		pos >= i_size_read(iter->inode);
>  }
>  
>  static loff_t iomap_readpage_iter(struct iomap_iter *iter,
> @@ -259,7 +261,7 @@ static loff_t iomap_readpage_iter(struct iomap_iter *iter,
>  	if (plen == 0)
>  		goto done;
>  
> -	if (iomap_block_needs_zeroing(iter->inode, iomap, pos)) {
> +	if (iomap_block_needs_zeroing(iter, pos)) {
>  		zero_user(page, poff, plen);
>  		iomap_set_range_uptodate(page, poff, plen);
>  		goto done;
> @@ -541,12 +543,12 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  	return submit_bio_wait(&bio);
>  }
>  
> -static int
> -__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> -		struct page *page, struct iomap *srcmap)
> +static int __iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> +		unsigned len, int flags, struct page *page)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, page);
> -	loff_t block_size = i_blocksize(inode);
> +	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	struct iomap_page *iop = iomap_page_create(iter->inode, page);
> +	loff_t block_size = i_blocksize(iter->inode);
>  	loff_t block_start = round_down(pos, block_size);
>  	loff_t block_end = round_up(pos + len, block_size);
>  	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
> @@ -556,7 +558,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	ClearPageError(page);
>  
>  	do {
> -		iomap_adjust_read_range(inode, iop, &block_start,
> +		iomap_adjust_read_range(iter->inode, iop, &block_start,
>  				block_end - block_start, &poff, &plen);
>  		if (plen == 0)
>  			break;
> @@ -566,7 +568,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		    (to <= poff || to >= poff + plen))
>  			continue;
>  
> -		if (iomap_block_needs_zeroing(inode, srcmap, block_start)) {
> +		if (iomap_block_needs_zeroing(iter, block_start)) {
>  			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
>  				return -EIO;
>  			zero_user_segments(page, poff, from, to, poff + plen);
> @@ -582,41 +584,40 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	return 0;
>  }
>  
> -static int
> -iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> +static int iomap_write_begin(struct iomap_iter *iter, loff_t pos, unsigned len,
> +		unsigned flags, struct page **pagep)
>  {
> -	const struct iomap_page_ops *page_ops = iomap->page_ops;
> +	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +	struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct page *page;
>  	int status = 0;
>  
> -	BUG_ON(pos + len > iomap->offset + iomap->length);
> -	if (srcmap != iomap)
> +	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> +	if (srcmap != &iter->iomap)
>  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
>  	if (page_ops && page_ops->page_prepare) {
> -		status = page_ops->page_prepare(inode, pos, len);
> +		status = page_ops->page_prepare(iter->inode, pos, len);
>  		if (status)
>  			return status;
>  	}
>  
> -	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> -			AOP_FLAG_NOFS);
> +	page = grab_cache_page_write_begin(iter->inode->i_mapping,
> +				pos >> PAGE_SHIFT, AOP_FLAG_NOFS);
>  	if (!page) {
>  		status = -ENOMEM;
>  		goto out_no_page;
>  	}
>  
>  	if (srcmap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, srcmap);
> -	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> +		iomap_read_inline_data(iter->inode, page, srcmap);
> +	else if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> -		status = __iomap_write_begin(inode, pos, len, flags, page,
> -				srcmap);
> +		status = __iomap_write_begin(iter, pos, len, flags, page);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> @@ -627,11 +628,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  out_unlock:
>  	unlock_page(page);
>  	put_page(page);
> -	iomap_write_failed(inode, pos, len);
> +	iomap_write_failed(iter->inode, pos, len);
>  
>  out_no_page:
>  	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(inode, pos, 0, NULL);
> +		page_ops->page_done(iter->inode, pos, 0, NULL);
>  	return status;
>  }
>  
> @@ -658,9 +659,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	return copied;
>  }
>  
> -static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> -		struct iomap *iomap, loff_t pos, size_t copied)
> +static size_t iomap_write_end_inline(struct iomap_iter *iter, struct page *page,
> +		loff_t pos, size_t copied)
>  {
> +	struct iomap *iomap = &iter->iomap;
>  	void *addr;
>  
>  	WARN_ON_ONCE(!PageUptodate(page));
> @@ -671,26 +673,26 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  	memcpy(iomap->inline_data + pos, addr + pos, copied);
>  	kunmap_atomic(addr);
>  
> -	mark_inode_dirty(inode);
> +	mark_inode_dirty(iter->inode);
>  	return copied;
>  }
>  
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> -static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> -		size_t copied, struct page *page, struct iomap *iomap,
> -		struct iomap *srcmap)
> +static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> +		size_t copied, struct page *page)
>  {
> -	const struct iomap_page_ops *page_ops = iomap->page_ops;
> -	loff_t old_size = inode->i_size;
> +	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +	struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	loff_t old_size = iter->inode->i_size;
>  	size_t ret;
>  
>  	if (srcmap->type == IOMAP_INLINE) {
> -		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> +		ret = iomap_write_end_inline(iter, page, pos, copied);
>  	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
> -				page, NULL);
> +		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> +				copied, page, NULL);
>  	} else {
> -		ret = __iomap_write_end(inode, pos, len, copied, page);
> +		ret = __iomap_write_end(iter->inode, pos, len, copied, page);
>  	}
>  
>  	/*
> @@ -699,26 +701,24 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 * preferably after I/O completion so that no stale data is exposed.
>  	 */
>  	if (pos + ret > old_size) {
> -		i_size_write(inode, pos + ret);
> -		iomap->flags |= IOMAP_F_SIZE_CHANGED;
> +		i_size_write(iter->inode, pos + ret);
> +		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  	}
>  	unlock_page(page);
>  
>  	if (old_size < pos)
> -		pagecache_isize_extended(inode, old_size, pos);
> +		pagecache_isize_extended(iter->inode, old_size, pos);
>  	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(inode, pos, ret, page);
> +		page_ops->page_done(iter->inode, pos, ret, page);
>  	put_page(page);
>  
>  	if (ret < len)
> -		iomap_write_failed(inode, pos, len);
> +		iomap_write_failed(iter->inode, pos, len);
>  	return ret;
>  }
>  
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
> -	struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	struct iomap *iomap = &iter->iomap;
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	ssize_t written = 0;
> @@ -748,8 +748,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter->inode, pos, bytes, 0, &page,
> -					   iomap, srcmap);
> +		status = iomap_write_begin(iter, pos, bytes, 0, &page);
>  		if (unlikely(status))
>  			break;
>  
> @@ -758,8 +757,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>  
> -		status = iomap_write_end(iter->inode, pos, bytes, copied, page,
> -					 iomap, srcmap);
> +		status = iomap_write_end(iter, pos, bytes, copied, page);
>  
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
> @@ -827,13 +825,12 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  		struct page *page;
>  
> -		status = iomap_write_begin(iter->inode, pos, bytes,
> -				IOMAP_WRITE_F_UNSHARE, &page, iomap, srcmap);
> +		status = iomap_write_begin(iter, pos, bytes,
> +				IOMAP_WRITE_F_UNSHARE, &page);
>  		if (unlikely(status))
>  			return status;
>  
> -		status = iomap_write_end(iter->inode, pos, bytes, bytes, page, iomap,
> -				srcmap);
> +		status = iomap_write_end(iter, pos, bytes, bytes, page);
>  		if (WARN_ON_ONCE(status == 0))
>  			return -EIO;
>  
> @@ -867,22 +864,21 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static s64 iomap_zero(struct inode *inode, loff_t pos, u64 length,
> -		struct iomap *iomap, struct iomap *srcmap)
> +static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
>  	struct page *page;
>  	int status;
>  	unsigned offset = offset_in_page(pos);
>  	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
> +	status = iomap_write_begin(iter, pos, bytes, 0, &page);
>  	if (status)
>  		return status;
>  
>  	zero_user(page, offset, bytes);
>  	mark_page_accessed(page);
>  
> -	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
> +	return iomap_write_end(iter, pos, bytes, bytes, page);
>  }
>  
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> @@ -903,8 +899,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (IS_DAX(iter->inode))
>  			bytes = dax_iomap_zero(pos, length, iomap);
>  		else
> -			bytes = iomap_zero(iter->inode, pos, length, iomap,
> -					   srcmap);
> +			bytes = __iomap_zero_iter(iter, pos, length);
>  		if (bytes < 0)
>  			return bytes;
>  
> -- 
> 2.30.2
> 
