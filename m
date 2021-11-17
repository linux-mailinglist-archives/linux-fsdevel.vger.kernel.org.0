Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A53453F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhKQEe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhKQEe0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:34:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C98661BF9;
        Wed, 17 Nov 2021 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637123488;
        bh=HuY9YRYrFBAz77ILgr6umLsyClVsfHdg4hJxm0f/Ixc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlHoa7CLhR+ZAGPTtPrbPTwWOhwLayvxj4uRkcCTP0Ye8EuSE1Qtk4z9xi3GaOeyH
         WmBMudLg9E3TjSGyB0hJuduJ2+/6amJYTjhHtVZGY+I8YxfBU4moJZmI189j7mw/xX
         Jm8sx0Bp2RzB07KGWhWpyJ2BUJwankuxvzPsycTmqWySepC+3OK7v+auPJZYytzs08
         xNn8jcVz5Br1w6bj0lQzxgDTSnRwS9wZh4LSP0CfWjPrR1GKmDTm4Lj/j1wXidPNOy
         CQ3NhguvBvf3pzKrpYZokUScu9NxexINTRd6LxmTMn63/LR7aluhZhNgczhrzM9mT1
         aZCZlP8r4gsoQ==
Date:   Tue, 16 Nov 2021 20:31:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 20/28] iomap: Convert iomap_write_begin() and
 iomap_write_end() to folios
Message-ID: <20211117043127.GK24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-21-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:43AM +0000, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from tail to head pages as a result of this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 66 ++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9c61d12028ca..f4ae200adc4c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c

<snip>

> @@ -741,6 +737,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  	long status = 0;
>  
>  	do {
> +		struct folio *folio;
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
> @@ -764,16 +761,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
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

Hrmm.  In principle (or I guess even a subsequent patch), if we had
multi-page folios, could we simply loop the pages in the folio instead
of doing a single page and then calling back into iomap_write_begin to
get (probably) the same folio?

This looks like a fairly straightforward conversion, but I was wondering
about that one little point...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
> -		status = iomap_write_end(iter, pos, bytes, copied, page);
> +		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
> @@ -839,13 +837,13 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
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
> @@ -882,21 +880,19 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
>  	struct folio *folio;
> -	struct page *page;
>  	int status;
>  	size_t offset, bytes;
>  
> -	status = iomap_write_begin(iter, pos, length, &page);
> +	status = iomap_write_begin(iter, pos, length, &folio);
>  	if (status)
>  		return status;
> -	folio = page_folio(page);
>  
>  	offset = offset_in_folio(folio, pos);
>  	bytes = min_t(u64, folio_size(folio) - offset, length);
>  	folio_zero_range(folio, offset, bytes);
>  	folio_mark_accessed(folio);
>  
> -	return iomap_write_end(iter, pos, bytes, bytes, page);
> +	return iomap_write_end(iter, pos, bytes, bytes, folio);
>  }
>  
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> -- 
> 2.33.0
> 
