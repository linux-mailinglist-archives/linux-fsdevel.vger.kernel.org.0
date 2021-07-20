Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD903D037C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhGTUQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 16:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234912AbhGTUBr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE5E60FEA;
        Tue, 20 Jul 2021 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626813744;
        bh=P1J28ss1PScW+PP+ZVuOa5wOA5aC5yz4+UYz8kAQIMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCga28067OZrAYiB+IuEUjo1sFVbQnJYPQyh5qf5Cc50s+WJx21SdPlv8RwJdzpNd
         Ac/G4FNacPybVxP6XYtUhkZnxuwEiCqb02XxcaZGPblP+ZHM4epAWrOxrnSDJz37Pv
         O40LT/ANJf9P7Hsj4QCPoKw7Oy2WvJYMolaiRDJysevYVJH7+mCq8sImEvzMBhnfte
         oMTMbSuOJ0N+iPWwS6HHHYhvioWSYysc7C6kr4kKpK30be6exGqiInitWrMlHnd/BH
         lXaK+jxGDNX0zaGXXNhGrH5k4y36OH+Yo9yBlbE+/7oDlvq1VIwQgin+iRsOZVDb9d
         POWnX8AG5FFrQ==
Date:   Tue, 20 Jul 2021 13:42:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <20210720204224.GK23236@magnolia>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 09:35:54PM +0800, Gao Xiang wrote:
> This tries to add tail packing inline read to iomap, which can support
> several inline tail blocks. Similar to the previous approach, it cleans
> post-EOF in one iteration.
> 
> The write path remains untouched since EROFS cannot be used for testing.
> It'd be better to be implemented if upcoming real users care rather than
> leave untested dead code around.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v3: https://lore.kernel.org/r/20210719144747.189634-1-hsiangkao@linux.alibaba.com
> changes since v3:
>  - update return value type of iomap_read_inline_data to int;
>  - fix iomap_write_begin_inline() pointed out by Andreas.
> 
>  fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++----------------
>  fs/iomap/direct-io.c   | 11 +++++----
>  2 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..0edc8bbb35d1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,25 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static void
> +static int
>  iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> +		struct iomap *iomap, loff_t pos)
>  {
> -	size_t size = i_size_read(inode);
> +	unsigned int size, poff = offset_in_page(pos);
>  	void *addr;
>  
> -	if (PageUptodate(page))
> -		return;
> -
> -	BUG_ON(page_has_private(page));
> -	BUG_ON(page->index);
> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* inline source data must be inside a single page */
> +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));

Can we reduce the strength of these checks to a warning and an -EIO
return?

> +	/* handle tail-packing blocks cross the current page into the next */
> +	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> +		     PAGE_SIZE - poff);
>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);

Hmm, so I guess the point of this is to support reading data from a
tail-packing block, where each file gets some arbitrary byte range
within the tp-block, and the range isn't aligned to an fs block?  Hence
you have to use the inline data code to read the relevant bytes and copy
them into the pagecache?

Aka this thing from the v3 discussion:

> The other one is actual file tail blocks, I think it can cross pages due
> to multiple tail inline blocks.
>
>                             |<---------- inline data ------------->|
>   _________________________________________________________________
>   | file block | file block | file block | file block | file block |
>   |<----------------    page   ---------------------->|<---  page

Except ... is this diagram a little misleading?  Each of these "file
blocks" isn't i_blocksize bytes in size, right?  Because if they were,
you could use the standard iomap codepaths?

So the real layout might look a bit more like this?

                                |<--- inline data ---->|
  _________________________________________________________________
  | file1 |     file2     |file3|  file4  |   file4    |
  |<-------------   page   -------------->|<---  page ----...

(Sorry, /me isn't all that familiar with erofs layout...)

>  	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> +	return PAGE_SIZE - poff;
>  }
>  
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,18 +246,18 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> -
> -	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> +	/* needs to skip some leading uptodate blocks */
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
>  
> +	if (iomap->type == IOMAP_INLINE) {
> +		plen = iomap_read_inline_data(inode, page, iomap, pos);
> +		goto done;
> +	}
> +
> +	/* zero post-eof blocks as the page may be mapped */
>  	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
>  		zero_user(page, poff, plen);
>  		iomap_set_range_uptodate(page, poff, plen);
> @@ -589,6 +589,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  	return 0;
>  }
>  
> +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> +		struct page *page, struct iomap *srcmap)
> +{
> +	/* needs more work for the tailpacking case, disable for now */
> +	if (WARN_ON_ONCE(srcmap->offset != 0))
> +		return -EIO;
> +	if (PageUptodate(page))
> +		return 0;
> +	iomap_read_inline_data(inode, page, srcmap, 0);
> +	return 0;
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	}
>  
>  	if (srcmap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, srcmap);
> +		status = iomap_write_begin_inline(inode, pos, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..ee6309967b77 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -379,22 +379,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  {
>  	struct iov_iter *iter = dio->submit.iter;
>  	size_t copied;
> +	void *dst = iomap->inline_data + pos - iomap->offset;
>  
> -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* inline data must be inside a single page */
> +	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));

Same here, can we convert these to warnings + EIO return?

--D

>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		loff_t size = inode->i_size;
>  
>  		if (pos > size)
> -			memset(iomap->inline_data + size, 0, pos - size);
> -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +			memset(iomap->inline_data + size - iomap->offset,
> +			       0, pos - size);
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
> -- 
> 2.24.4
> 
