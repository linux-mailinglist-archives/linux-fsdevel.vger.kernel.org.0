Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461623D1DD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGVFQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 01:16:03 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34995 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhGVFP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:15:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ugaix7h_1626933391;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ugaix7h_1626933391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Jul 2021 13:56:32 +0800
Date:   Thu, 22 Jul 2021 13:56:30 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPkIjhVq+MzVl1Sk@B-P7TQMD6M-0146.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
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

Hi Christoph,

On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> I think some of the language here is confusing - mostly about tail
> packing when we otherwise use inline data.  Can you take a look at
> the version below?  This mostly cleans up the terminology, adds a
> new helper to check the size, and removes the error on trying to
> write with a non-zero pos, as it can be trivially supported now.
> 

Many thanks for your time and hard work on revising this again. I'm
fine with this version and the update for iomap_write_begin(), and
I will do test hours later as I said before.

Hopefully this version could be confirmed by Andreas on the gfs2
side as well.

Thanks,
Gao Xiang

> ---
> From 0f9c6ac6c2e372739b29195d25bebb8dd87e583a Mon Sep 17 00:00:00 2001
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date: Thu, 22 Jul 2021 11:17:29 +0800
> Subject: iomap: make inline data support more flexible
> 
> Add support for offsets into the inline data page at iomap->inline_data
> to cater for the EROFS tailpackng case where a small data is stored
> right after the inode.
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
