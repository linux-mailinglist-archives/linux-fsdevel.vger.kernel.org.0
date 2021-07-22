Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E523D2A6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhGVQLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 12:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235045AbhGVQKe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:10:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9EB360BD3;
        Thu, 22 Jul 2021 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626972669;
        bh=YPFjIV/cOfo9frdHbxz8MEqY64Kh1mVpesIueSZqjno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAXgxxdGtBBkU8sn4fROa9JZHXVZajAjmGPJtJSdY3L6/CM/2QBFUl3l7IzZxoXyj
         CA6ta6IH7o9hBD5w/cB6Rnus2PfnjWRLiYGZDRhXreNFdWkUFKstCejnNzXhm1Cmem
         GwIsywdwsq01gSQYwxaksmS32B/Uhz3YxE6d/5BupSJPnKByJuCFatZXXPl4aAmn3N
         Pl6Wd1nYSMYStmwtemRcGL4PMDKcLEwVVU1Y/o9RUz4027v38a3LPsD4BKGrS8uO27
         xWh9Cn0jOuG0Myd+zW52DdDwL9Bu3CGrpjGl4mx+CxOaLjjIcHDk+L8WEUHCX79G0q
         e7bGYJzb4JQcw==
Date:   Thu, 22 Jul 2021 09:51:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <20210722165109.GD8639@magnolia>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210722053947.GA28594@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> I think some of the language here is confusing - mostly about tail
> packing when we otherwise use inline data.  Can you take a look at
> the version below?  This mostly cleans up the terminology, adds a
> new helper to check the size, and removes the error on trying to
> write with a non-zero pos, as it can be trivially supported now.
> 
> ---
> From 0f9c6ac6c2e372739b29195d25bebb8dd87e583a Mon Sep 17 00:00:00 2001
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date: Thu, 22 Jul 2021 11:17:29 +0800
> Subject: iomap: make inline data support more flexible
> 
> Add support for offsets into the inline data page at iomap->inline_data
> to cater for the EROFS tailpackng case where a small data is stored
> right after the inode.

The commit message is a little misleading -- this adds support for
inline data pages at nonzero (but page-aligned) file offsets, not file
offsets into the page itself.  I suggest:

"Add support for reading inline data content into the page cache from
nonzero page-aligned file offsets.  This enables the EROFS tailpacking
mode where the last few bytes of the file are stored right after the
inode."

The code changes look good to me.

--D

> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/iomap/buffered-io.c | 35 ++++++++++++++++++-----------------
>  fs/iomap/direct-io.c   | 10 ++++++----
>  include/linux/iomap.h  | 14 ++++++++++++++
>  3 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438becd9..0597f5c186a33f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> +		struct iomap *iomap, loff_t pos)
>  {
> -	size_t size = i_size_read(inode);
> +	size_t size = iomap->length + iomap->offset - pos;
>  	void *addr;
>  
>  	if (PageUptodate(page))
> -		return;
> +		return PAGE_SIZE;
>  
> -	BUG_ON(page_has_private(page));
> -	BUG_ON(page->index);
> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* inline data must start page aligned in the file */
> +	if (WARN_ON_ONCE(offset_in_page(pos)))
> +		return -EIO;
> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +		return -EIO;
> +	if (WARN_ON_ONCE(page_has_private(page)))
> +		return -EIO;
>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> +	memcpy(addr, iomap_inline_buf(iomap, pos), size);
>  	memset(addr + size, 0, PAGE_SIZE - size);
>  	kunmap_atomic(addr);
>  	SetPageUptodate(page);
> +	return PAGE_SIZE;
>  }
>  
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,11 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> +	if (iomap->type == IOMAP_INLINE)
> +		return iomap_read_inline_data(inode, page, iomap, pos);
>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> @@ -618,14 +619,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	}
>  
>  	if (srcmap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, srcmap);
> +		status = iomap_read_inline_data(inode, page, srcmap, pos);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
>  		status = __iomap_write_begin(inode, pos, len, flags, page,
>  				srcmap);
>  
> -	if (unlikely(status))
> +	if (unlikely(status < 0))
>  		goto out_unlock;
>  
>  	*pagep = page;
> @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  
>  	flush_dcache_page(page);
>  	addr = kmap_atomic(page);
> -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
>  	kunmap_atomic(addr);
>  
>  	mark_inode_dirty(inode);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323b3..a6aaea2764a55f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
>  {
>  	struct iov_iter *iter = dio->submit.iter;
> +	void *dst = iomap_inline_buf(iomap, pos);
>  	size_t copied;
>  
> -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +		return -EIO;
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		loff_t size = inode->i_size;
>  
>  		if (pos > size)
> -			memset(iomap->inline_data + size, 0, pos - size);
> -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +			memset(iomap_inline_buf(iomap, size), 0, pos - size);
> +		copied = copy_from_iter(dst, length, iter);
>  		if (copied) {
>  			if (pos + copied > size)
>  				i_size_write(inode, pos + copied);
>  			mark_inode_dirty(inode);
>  		}
>  	} else {
> -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +		copied = copy_to_iter(dst, length, iter);
>  	}
>  	dio->size += copied;
>  	return copied;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e2211e..5efae7153912ed 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>  
> +static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
> +{
> +	return iomap->inline_data - iomap->offset + pos;
> +}
> +
> +/*
> + * iomap->inline_data is a potentially kmapped page, ensure it never crosseѕ a
> + * page boundary.
> + */
> +static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
> +{
> +	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
> +
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>   * and page_done will be called for each page written to.  This only applies to
> -- 
> 2.30.2
> 
