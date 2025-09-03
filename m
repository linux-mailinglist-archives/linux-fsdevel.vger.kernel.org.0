Return-Path: <linux-fsdevel+bounces-60213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C3B42B83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC14C3AB0A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727122EACE1;
	Wed,  3 Sep 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNoabFnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BF1F2371;
	Wed,  3 Sep 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933737; cv=none; b=lnzaNPQ8UEL71n3uk7Iz+XyfykcjAPMRjmz6xZYHNJUIrQN0Z09n+jvEf23tzYY5MCz78TRng70Z3ToUJmlUSQ9ziIxKwfWwLOgLy8ib+JH8SXi8oelmAvxcGZuDUXz8/d2OiJZ5ldGBypH+GWYQJuBVt7UjJou7ojlSnk7Fo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933737; c=relaxed/simple;
	bh=WU4ErpRJgRF3F2JiQE1qDcNH5PqccLDnum2OvhHgai8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVRn2vCyD+KWmxC0xlfn/vcQvlWnR37tYRYMxmTgjwb3g5nm7RtJ4vKv0Y4qqktTxppW0O9VE1M8qvSiqzXoQymz5s8GcnUO2BZNzOJ/jE7hp9S3Cjccbu/axQMHD1RbF68EV1uxdCqCE9ob1JEWpaDVauA2h6xHZf0yNWecNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNoabFnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4467AC4CEE7;
	Wed,  3 Sep 2025 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756933737;
	bh=WU4ErpRJgRF3F2JiQE1qDcNH5PqccLDnum2OvhHgai8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNoabFnzOPGRwMUzxV0jMPxGHt2jqOR5hlMyM+uM49j4RyDaI/tv9KX508Q6XP1tR
	 eg/byNz8B03Gn2zFBCCBjd7Mf0ma/AKsIpkiT3ZG6gwtzB5dBztOQr2jjnk+U+Zi7V
	 qWDwFZtFbX8xbN45OmbyFGhBQ3Ne4qSl9abpk+jK8e0Idso6v9Z504RdE3v8eZ237v
	 OFdN6hch2nuu0eGEeAPONOfFzJpPGiZ+bGS+Y7sMecxFGdfRjZMqvagsCopxGex2jz
	 PcZ9Vx0LbMMp+0GlRGy9MPuXRz/GBhgAp5GHuCR74+PwgP96AFKqTfulTdpbcK7esc
	 UicsPi36IOTwQ==
Date: Wed, 3 Sep 2025 14:08:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 12/16] iomap: add iomap_read_ops for read and readahead
Message-ID: <20250903210856.GT1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-13-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:23PM -0700, Joanne Koong wrote:
> Add a "struct iomap_read_ops" that contains a read_folio_range()
> callback that callers can provide as a custom handler for reading in a
> folio range, if the caller does not wish to issue bio read requests
> (which otherwise is the default behavior). read_folio_range() may read
> the request asynchronously or synchronously. The caller is responsible
> for calling iomap_start_folio_read()/iomap_finish_folio_read() when
> reading the folio range.
> 
> This makes it so that non-block based filesystems may use iomap for
> reads.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  .../filesystems/iomap/operations.rst          | 19 +++++
>  block/fops.c                                  |  4 +-
>  fs/erofs/data.c                               |  4 +-
>  fs/gfs2/aops.c                                |  4 +-
>  fs/iomap/buffered-io.c                        | 79 +++++++++++++------
>  fs/xfs/xfs_aops.c                             |  4 +-
>  fs/zonefs/file.c                              |  4 +-
>  include/linux/iomap.h                         | 21 ++++-
>  8 files changed, 105 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 067ed8e14ef3..215053f0779d 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -57,6 +57,25 @@ The following address space operations can be wrapped easily:
>   * ``bmap``
>   * ``swap_activate``
>  
> +``struct iomap_read_ops``
> +--------------------------
> +
> +.. code-block:: c
> +
> + struct iomap_read_ops {
> +     int (*read_folio_range)(const struct iomap_iter *iter,
> +                        struct folio *folio, loff_t pos, size_t len);
> + };
> +
> +iomap calls these functions:
> +
> +  - ``read_folio_range``: Called to read in the range (read does not need to
> +    be synchronous). The caller is responsible for calling

Er... does this perform the read synchronously or asynchronously?
Does the implementer need to know?  How does iomap figure out what
happened?

My guess is that iomap_finish_folio_read unlocks the folio, and anyone
who cared is by this point already waiting on the folio lock?  So it's
actually not important if the ->read_folio_range implementation runs
async or not; the key is that the folio stays locked until we've
completed the read IO?

> +    iomap_start_folio_read() and iomap_finish_folio_read() when reading the
> +    folio range. This should be done even if an error is encountered during
> +    the read. If this function is not provided by the caller, then iomap
> +    will default to issuing asynchronous bio read requests.

What is this function supposed to return?  The usual 0 or negative
errno?

> +
>  ``struct iomap_write_ops``
>  --------------------------
>  
> diff --git a/block/fops.c b/block/fops.c
> index ddbc69c0922b..b42e16d0eb35 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -533,12 +533,12 @@ const struct address_space_operations def_blk_aops = {
>  #else /* CONFIG_BUFFER_HEAD */
>  static int blkdev_read_folio(struct file *file, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &blkdev_iomap_ops);
> +	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
>  }
>  
>  static void blkdev_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &blkdev_iomap_ops);
> +	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
>  }
>  
>  static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3b1ba571c728..ea451f233263 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -371,7 +371,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>  {
>  	trace_erofs_read_folio(folio, true);
>  
> -	return iomap_read_folio(folio, &erofs_iomap_ops);
> +	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
>  }
>  
>  static void erofs_readahead(struct readahead_control *rac)
> @@ -379,7 +379,7 @@ static void erofs_readahead(struct readahead_control *rac)
>  	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>  					readahead_count(rac), true);
>  
> -	return iomap_readahead(rac, &erofs_iomap_ops);
> +	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
>  }
>  
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 47d74afd63ac..bf531bcfd8a0 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -428,7 +428,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
>  
>  	if (!gfs2_is_jdata(ip) ||
>  	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
> -		error = iomap_read_folio(folio, &gfs2_iomap_ops);
> +		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
>  	} else if (gfs2_is_stuffed(ip)) {
>  		error = stuffed_read_folio(ip, folio);
>  	} else {
> @@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
>  	else if (gfs2_is_jdata(ip))
>  		mpage_readahead(rac, gfs2_block_map);
>  	else
> -		iomap_readahead(rac, &gfs2_iomap_ops);
> +		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
>  }
>  
>  /**
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 5d153c6b16b6..06f2c857de64 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -335,8 +335,8 @@ void iomap_start_folio_read(struct folio *folio, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(iomap_start_folio_read);
>  
> -void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
> -		int error)
> +static void __iomap_finish_folio_read(struct folio *folio, size_t off,
> +		size_t len, int error, bool update_bitmap)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	bool uptodate = !error;
> @@ -346,7 +346,7 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&ifs->state_lock, flags);
> -		if (!error)
> +		if (!error && update_bitmap)
>  			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);

When do we /not/ want to set uptodate after a successful read?  I guess
iomap_read_folio_range_async goes through the bio machinery and sets
uptodate via iomap_finish_folio_read()?  Does the ->read_folio_range
function need to set the uptodate bits itself?  Possibly by calling
iomap_finish_folio_read as well?

>  		ifs->read_bytes_pending -= len;
>  		finished = !ifs->read_bytes_pending;
> @@ -356,6 +356,12 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  	if (finished)
>  		folio_end_read(folio, uptodate);
>  }
> +
> +void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
> +		int error)
> +{
> +	return __iomap_finish_folio_read(folio, off, len, error, true);
> +}
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>  
>  #ifdef CONFIG_BLOCK
> @@ -379,7 +385,6 @@ static void iomap_read_folio_range_async(struct iomap_iter *iter,
>  	struct bio *bio = iter->private;
>  	sector_t sector;
>  
> -	ctx->folio_unlocked = true;
>  	iomap_start_folio_read(folio, plen);
>  
>  	sector = iomap_sector(iomap, pos);
> @@ -453,15 +458,17 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
>  #endif /* CONFIG_BLOCK */
>  
>  static int iomap_readfolio_iter(struct iomap_iter *iter,
> -		struct iomap_readfolio_ctx *ctx)
> +		struct iomap_readfolio_ctx *ctx,
> +		const struct iomap_read_ops *read_ops)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> +	struct iomap_folio_state *ifs;
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	struct folio *folio = ctx->cur_folio;
>  	size_t poff, plen;
>  	loff_t count;
> -	int ret;
> +	int ret = 0;
>  
>  	if (iomap->type == IOMAP_INLINE) {
>  		ret = iomap_read_inline_data(iter, folio);
> @@ -471,7 +478,14 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> -	ifs_alloc(iter->inode, folio, iter->flags);
> +	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> +
> +	/*
> +	 * Add a bias to ifs->read_bytes_pending so that a read is ended only
> +	 * after all the ranges have been read in.
> +	 */
> +	if (ifs)
> +		iomap_start_folio_read(folio, 1);
>  
>  	length = min_t(loff_t, length,
>  			folio_size(folio) - offset_in_folio(folio, pos));
> @@ -479,35 +493,53 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
>  		iomap_adjust_read_range(iter->inode, folio, &pos,
>  				length, &poff, &plen);
>  		count = pos - iter->pos + plen;
> -		if (plen == 0)
> -			return iomap_iter_advance(iter, &count);
> +		if (plen == 0) {
> +			ret = iomap_iter_advance(iter, &count);
> +			break;
> +		}
>  
>  		if (iomap_block_needs_zeroing(iter, pos)) {
>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> -			iomap_read_folio_range_async(iter, ctx, pos, plen);
> +			ctx->folio_unlocked = true;
> +			if (read_ops && read_ops->read_folio_range) {
> +				ret = read_ops->read_folio_range(iter, folio, pos, plen);
> +				if (ret)
> +					break;
> +			} else {
> +				iomap_read_folio_range_async(iter, ctx, pos, plen);
> +			}
>  		}
>  
>  		length -= count;
>  		ret = iomap_iter_advance(iter, &count);
>  		if (ret)
> -			return ret;
> +			break;
>  		pos = iter->pos;
>  	}
> -	return 0;
> +
> +	if (ifs) {
> +		__iomap_finish_folio_read(folio, 0, 1, ret, false);
> +		ctx->folio_unlocked = true;

Er.... so we subtract 1 from read_bytes_pending?  I thought the
->read_folio_range ioend was supposed to decrease that?

--D

> +	}
> +
> +	return ret;
>  }
>  
>  static void iomap_readfolio_complete(const struct iomap_iter *iter,
> -		const struct iomap_readfolio_ctx *ctx)
> +		const struct iomap_readfolio_ctx *ctx,
> +		const struct iomap_read_ops *read_ops)
>  {
> -	iomap_readfolio_submit(iter);
> +	if (!read_ops || !read_ops->read_folio_range)
> +		iomap_readfolio_submit(iter);
>  
>  	if (ctx->cur_folio && !ctx->folio_unlocked)
>  		folio_unlock(ctx->cur_folio);
>  }
>  
> -int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
> +int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> +		const struct iomap_read_ops *read_ops)
>  {
>  	struct iomap_iter iter = {
>  		.inode		= folio->mapping->host,
> @@ -522,16 +554,17 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_readfolio_iter(&iter, &ctx);
> +		iter.status = iomap_readfolio_iter(&iter, &ctx, read_ops);
>  
> -	iomap_readfolio_complete(&iter, &ctx);
> +	iomap_readfolio_complete(&iter, &ctx, read_ops);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
>  static int iomap_readahead_iter(struct iomap_iter *iter,
> -		struct iomap_readfolio_ctx *ctx)
> +		struct iomap_readfolio_ctx *ctx,
> +		const struct iomap_read_ops *read_ops)
>  {
>  	int ret;
>  
> @@ -545,7 +578,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  		 */
>  		WARN_ON(!ctx->cur_folio);
>  		ctx->folio_unlocked = false;
> -		ret = iomap_readfolio_iter(iter, ctx);
> +		ret = iomap_readfolio_iter(iter, ctx, read_ops);
>  		if (ret)
>  			return ret;
>  	}
> @@ -557,6 +590,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>   * iomap_readahead - Attempt to read pages from a file.
>   * @rac: Describes the pages to be read.
>   * @ops: The operations vector for the filesystem.
> + * @read_ops: Optional ops callers can pass in if they want custom handling.
>   *
>   * This function is for filesystems to call to implement their readahead
>   * address_space operation.
> @@ -568,7 +602,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>   * function is called with memalloc_nofs set, so allocations will not cause
>   * the filesystem to be reentered.
>   */
> -void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
> +void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
> +		const struct iomap_read_ops *read_ops)
>  {
>  	struct iomap_iter iter = {
>  		.inode	= rac->mapping->host,
> @@ -582,9 +617,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
>  	while (iomap_iter(&iter, ops) > 0)
> -		iter.status = iomap_readahead_iter(&iter, &ctx);
> +		iter.status = iomap_readahead_iter(&iter, &ctx, read_ops);
>  
> -	iomap_readfolio_complete(&iter, &ctx);
> +	iomap_readfolio_complete(&iter, &ctx, read_ops);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 1ee4f835ac3c..fb2150c0825a 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -742,14 +742,14 @@ xfs_vm_read_folio(
>  	struct file		*unused,
>  	struct folio		*folio)
>  {
> -	return iomap_read_folio(folio, &xfs_read_iomap_ops);
> +	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
>  }
>  
>  STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops);
> +	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
>  }
>  
>  static int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index fd3a5922f6c3..96470daf4d3f 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
>  
>  static int zonefs_read_folio(struct file *unused, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
> +	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
>  }
>  
>  static void zonefs_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &zonefs_read_iomap_ops);
> +	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
>  }
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0938c4a57f4c..a7247439aeb5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,6 +178,21 @@ struct iomap_write_ops {
>  			struct folio *folio, loff_t pos, size_t len);
>  };
>  
> +struct iomap_read_ops {
> +	/*
> +	 * If the filesystem doesn't provide a custom handler for reading in the
> +	 * contents of a folio, iomap will default to issuing asynchronous bio
> +	 * read requests.
> +	 *
> +	 * The read does not need to be done synchronously. The caller is
> +	 * responsible for calling iomap_start_folio_read() and
> +	 * iomap_finish_folio_read() when reading the folio range. This should
> +	 * be done even if an error is encountered during the read.
> +	 */
> +	int (*read_folio_range)(const struct iomap_iter *iter,
> +			struct folio *folio, loff_t pos, size_t len);
> +};
> +
>  /*
>   * Flags for iomap_begin / iomap_end.  No flag implies a read.
>   */
> @@ -339,8 +354,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
> -int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> -void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
> +int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> +		const struct iomap_read_ops *read_ops);
> +void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
> +		const struct iomap_read_ops *read_ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> -- 
> 2.47.3
> 
> 

