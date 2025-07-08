Return-Path: <linux-fsdevel+bounces-54300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5380AFD75A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6113B709F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7A238C08;
	Tue,  8 Jul 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8f20uDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D832367CD;
	Tue,  8 Jul 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003875; cv=none; b=AC6kqbl+kF9M40p5y8Mt1krZZ3n0MwJ4hiZS9lX891y5187W3/8jrVjdTlbnFQXu7cHJf7YlBDXMOyfhHWqCUmAvSQEAO8oGVXgQAKhrZKSqTYukWcauRkSC1FPkkOpI3OxApRj/1C7HZWi1ciDGAGBjyOi+BaqEuovNjBXxbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003875; c=relaxed/simple;
	bh=qm49c7dfRt/xsYCoVBJClOPovR7IloiRfqtolmwf1YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egsj8pQxXGVCtWBMjcLLInDBBKsJynosrYQlKpGVNVg6Vo7DE68zG04EWeyQNIHlP6VzrloiTehq9s87ynGXC87+JBSbrTgDCn+zEpYYiHwWbqKYwNmW8NLvjiw21SkR6pCLfrR8jiKnoag9VkQ2mwe7Rnj4gyhO50u4jaNolsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8f20uDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE5C4CEED;
	Tue,  8 Jul 2025 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003874;
	bh=qm49c7dfRt/xsYCoVBJClOPovR7IloiRfqtolmwf1YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8f20uDcM4qaxuzKVwjW+j41YNe2wSCjVTJCBHPQhV02QwLCUsMbZW0KXuP+nNZYU
	 gnJf0IUyDJ7RUft98JbvrfcyK9GHMH6v7RhtycPjibYbsqtJDUr/omKXadPsFBHWV/
	 GgLF3/pL1Z18lzlZOU5cQ3P4LsB7abbTQ+olBu1EqnNw5EWsF2ff9coZw8/fRRx2NW
	 PF/ZddAG/wQVodf+WMe+dETKlQPnVk/E0HAN4QOeRTNAi4e1I4QJHYs4KjypMqheNA
	 Vpx1g66htvQVvZhOJbvPS7h16pibioBd35wXbdFOAq2ReFa1OyFuKZkGoHbrEFzf3P
	 VCOi+eNE9OHQw==
Date: Tue, 8 Jul 2025 12:44:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 04/14] iomap: refactor the writeback interface
Message-ID: <20250708194434.GD2672049@frogsfrogsfrogs>
References: <20250708135132.3347932-1-hch@lst.de>
 <20250708135132.3347932-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708135132.3347932-5-hch@lst.de>

On Tue, Jul 08, 2025 at 03:51:10PM +0200, Christoph Hellwig wrote:
> Replace ->map_blocks with a new ->writeback_range, which differs in the
> following ways:
> 
>  - it must also queue up the I/O for writeback, that is called into the
>    slightly refactored and extended in scope iomap_add_to_ioend for
>    each region
>  - can handle only a part of the requested region, that is the retry
>    loop for partial mappings moves to the caller
>  - handles cleanup on failures as well, and thus also replaces the
>    discard_folio method only implemented by XFS.
> 
> This will allow to use the iomap writeback code also for file systems
> that are not block based like fuse.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>	# zonefs

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  .../filesystems/iomap/operations.rst          |  32 ++---
>  block/fops.c                                  |  25 ++--
>  fs/gfs2/bmap.c                                |  26 ++--
>  fs/iomap/buffered-io.c                        |  96 ++++++-------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 128 +++++++++++-------
>  fs/zonefs/file.c                              |  28 ++--
>  include/linux/iomap.h                         |  21 ++-
>  8 files changed, 197 insertions(+), 161 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 3b628e370d88..f07c8fdb2046 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -271,7 +271,7 @@ writeback.
>  It does not lock ``i_rwsem`` or ``invalidate_lock``.
>  
>  The dirty bit will be cleared for all folios run through the
> -``->map_blocks`` machinery described below even if the writeback fails.
> +``->writeback_range`` machinery described below even if the writeback fails.
>  This is to prevent dirty folio clots when storage devices fail; an
>  ``-EIO`` is recorded for userspace to collect via ``fsync``.
>  
> @@ -283,15 +283,14 @@ The ``ops`` structure must be specified and is as follows:
>  .. code-block:: c
>  
>   struct iomap_writeback_ops {
> -     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> -                       loff_t offset, unsigned len);
> -     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> -     void (*discard_folio)(struct folio *folio, loff_t pos);
> +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> +         struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
>   };
>  
>  The fields are as follows:
>  
> -  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
> +  - ``writeback_range``: Sets ``wpc->iomap`` to the space mapping of the file
>      range (in bytes) given by ``offset`` and ``len``.
>      iomap calls this function for each dirty fs block in each dirty folio,
>      though it will `reuse mappings
> @@ -306,6 +305,15 @@ The fields are as follows:
>      This revalidation must be open-coded by the filesystem; it is
>      unclear if ``iomap::validity_cookie`` can be reused for this
>      purpose.
> +
> +    If this methods fails to schedule I/O for any part of a dirty folio, it
> +    should throw away any reservations that may have been made for the write.
> +    The folio will be marked clean and an ``-EIO`` recorded in the
> +    pagecache.
> +    Filesystems can use this callback to `remove
> +    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
> +    delalloc reservations to avoid having delalloc reservations for
> +    clean pagecache.
>      This function must be supplied by the filesystem.
>  
>    - ``submit_ioend``: Allows the file systems to hook into writeback bio
> @@ -316,18 +324,6 @@ The fields are as follows:
>      transactions from process context before submitting the bio.
>      This function is optional.
>  
> -  - ``discard_folio``: iomap calls this function after ``->map_blocks``
> -    fails to schedule I/O for any part of a dirty folio.
> -    The function should throw away any reservations that may have been
> -    made for the write.
> -    The folio will be marked clean and an ``-EIO`` recorded in the
> -    pagecache.
> -    Filesystems can use this callback to `remove
> -    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
> -    delalloc reservations to avoid having delalloc reservations for
> -    clean pagecache.
> -    This function is optional.
> -
>  Pagecache Writeback Completion
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/block/fops.c b/block/fops.c
> index 3394263d942b..b500ff8f55dd 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -537,22 +537,29 @@ static void blkdev_readahead(struct readahead_control *rac)
>  	iomap_readahead(rac, &blkdev_iomap_ops);
>  }
>  
> -static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
> -		struct inode *inode, loff_t offset, unsigned int len)
> +static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> +		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
>  {
> -	loff_t isize = i_size_read(inode);
> +	loff_t isize = i_size_read(wpc->inode);
>  
>  	if (WARN_ON_ONCE(offset >= isize))
>  		return -EIO;
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> -		return 0;
> -	return blkdev_iomap_begin(inode, offset, isize - offset,
> -				  IOMAP_WRITE, &wpc->iomap, NULL);
> +
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length) {
> +		int error;
> +
> +		error = blkdev_iomap_begin(wpc->inode, offset, isize - offset,
> +				IOMAP_WRITE, &wpc->iomap, NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>  
>  static const struct iomap_writeback_ops blkdev_writeback_ops = {
> -	.map_blocks		= blkdev_map_blocks,
> +	.writeback_range	= blkdev_writeback_range,
>  };
>  
>  static int blkdev_writepages(struct address_space *mapping,
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 7703d0471139..0cc41de54aba 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2469,23 +2469,25 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	return error;
>  }
>  
> -static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
> -		loff_t offset, unsigned int len)
> +static ssize_t gfs2_writeback_range(struct iomap_writepage_ctx *wpc,
> +		struct folio *folio, u64 offset, unsigned int len, u64 end_pos)
>  {
> -	int ret;
> -
> -	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(inode))))
> +	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(wpc->inode))))
>  		return -EIO;
>  
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> -		return 0;
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length) {
> +		int ret;
>  
> -	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
> -	ret = gfs2_iomap_get(inode, offset, INT_MAX, &wpc->iomap);
> -	return ret;
> +		memset(&wpc->iomap, 0, sizeof(wpc->iomap));
> +		ret = gfs2_iomap_get(wpc->inode, offset, INT_MAX, &wpc->iomap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>  
>  const struct iomap_writeback_ops gfs2_writeback_ops = {
> -	.map_blocks		= gfs2_map_blocks,
> +	.writeback_range	= gfs2_writeback_range,
>  };
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 372342bfffa3..7d9cd05c36bb 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1666,14 +1666,30 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>   * At the end of a writeback pass, there will be a cached ioend remaining on the
>   * writepage context that the caller will need to submit.
>   */
> -static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, loff_t pos, loff_t end_pos, unsigned len)
> +ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
> +		loff_t pos, loff_t end_pos, unsigned int dirty_len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	unsigned int ioend_flags = 0;
> +	unsigned int map_len = min_t(u64, dirty_len,
> +		wpc->iomap.offset + wpc->iomap.length - pos);
>  	int error;
>  
> +	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
> +
> +	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +
> +	switch (wpc->iomap.type) {
> +	case IOMAP_INLINE:
> +		WARN_ON_ONCE(1);
> +		return -EIO;
> +	case IOMAP_HOLE:
> +		return map_len;
> +	default:
> +		break;
> +	}
> +
>  	if (wpc->iomap.type == IOMAP_UNWRITTEN)
>  		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
>  	if (wpc->iomap.flags & IOMAP_F_SHARED)
> @@ -1691,11 +1707,11 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
>  	}
>  
> -	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> +	if (!bio_add_folio(&wpc->ioend->io_bio, folio, map_len, poff))
>  		goto new_ioend;
>  
>  	if (ifs)
> -		atomic_add(len, &ifs->write_bytes_pending);
> +		atomic_add(map_len, &ifs->write_bytes_pending);
>  
>  	/*
>  	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> @@ -1738,63 +1754,39 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  	 * Note that this defeats the ability to chain the ioends of
>  	 * appending writes.
>  	 */
> -	wpc->ioend->io_size += len;
> +	wpc->ioend->io_size += map_len;
>  	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
>  		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
>  
> -	wbc_account_cgroup_owner(wpc->wbc, folio, len);
> -	return 0;
> +	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
> +	return map_len;
>  }
> +EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
>  
> -static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
> -		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
> +static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> +		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
>  		bool *wb_pending)
>  {
> -	int error;
> -
>  	do {
> -		unsigned map_len;
> -
> -		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
> -		if (error)
> -			break;
> -		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
> -				&wpc->iomap);
> +		ssize_t ret;
>  
> -		map_len = min_t(u64, dirty_len,
> -			wpc->iomap.offset + wpc->iomap.length - pos);
> -		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +		ret = wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
> +		if (WARN_ON_ONCE(ret == 0 || ret > rlen))
> +			return -EIO;
> +		if (ret < 0)
> +			return ret;
> +		rlen -= ret;
> +		pos += ret;
>  
> -		switch (wpc->iomap.type) {
> -		case IOMAP_INLINE:
> -			WARN_ON_ONCE(1);
> -			error = -EIO;
> -			break;
> -		case IOMAP_HOLE:
> -			break;
> -		default:
> -			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
> -					map_len);
> -			if (!error)
> -				*wb_pending = true;
> -			break;
> -		}
> -		dirty_len -= map_len;
> -		pos += map_len;
> -	} while (dirty_len && !error);
> +		/*
> +		 * Holes are not be written back by ->writeback_range, so track
> +		 * if we did handle anything that is not a hole here.
> +		 */
> +		if (wpc->iomap.type != IOMAP_HOLE)
> +			*wb_pending = true;
> +	} while (rlen);
>  
> -	/*
> -	 * We cannot cancel the ioend directly here on error.  We may have
> -	 * already set other pages under writeback and hence we have to run I/O
> -	 * completion to mark the error state of the pages under writeback
> -	 * appropriately.
> -	 *
> -	 * Just let the file system know what portion of the folio failed to
> -	 * map.
> -	 */
> -	if (error && wpc->ops->discard_folio)
> -		wpc->ops->discard_folio(folio, pos);
> -	return error;
> +	return 0;
>  }
>  
>  /*
> @@ -1906,8 +1898,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 */
>  	end_aligned = round_up(end_pos, i_blocksize(inode));
>  	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
> -		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
> -				rlen, &wb_pending);
> +		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
> +				&wb_pending);
>  		if (error)
>  			break;
>  		pos += rlen;
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 455cc6f90be0..aaea02c9560a 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -169,7 +169,7 @@ DEFINE_EVENT(iomap_class, name,	\
>  DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
>  DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
>  
> -TRACE_EVENT(iomap_writepage_map,
> +TRACE_EVENT(iomap_add_to_ioend,
>  	TP_PROTO(struct inode *inode, u64 pos, unsigned int dirty_len,
>  		 struct iomap *iomap),
>  	TP_ARGS(inode, pos, dirty_len, iomap),
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 65485a52df3b..f6d44ab78442 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -233,6 +233,47 @@ xfs_end_bio(
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  }
>  
> +/*
> + * We cannot cancel the ioend directly on error.  We may have already set other
> + * pages under writeback and hence we have to run I/O completion to mark the
> + * error state of the pages under writeback appropriately.
> + *
> + * If the folio has delalloc blocks on it, the caller is asking us to punch them
> + * out. If we don't, we can leave a stale delalloc mapping covered by a clean
> + * page that needs to be dirtied again before the delalloc mapping can be
> + * converted. This stale delalloc mapping can trip up a later direct I/O read
> + * operation on the same region.
> + *
> + * We prevent this by truncating away the delalloc regions on the folio. Because
> + * they are delalloc, we can do this without needing a transaction. Indeed - if
> + * we get ENOSPC errors, we have to be able to do this truncation without a
> + * transaction as there is no space left for block reservation (typically why
> + * we see a ENOSPC in writeback).
> + */
> +static void
> +xfs_discard_folio(
> +	struct folio		*folio,
> +	loff_t			pos)
> +{
> +	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (xfs_is_shutdown(mp))
> +		return;
> +
> +	xfs_alert_ratelimited(mp,
> +		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> +			folio, ip->i_ino, pos);
> +
> +	/*
> +	 * The end of the punch range is always the offset of the first
> +	 * byte of the next folio. Hence the end offset is only dependent on the
> +	 * folio itself and not the start offset that is passed in.
> +	 */
> +	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
> +				folio_pos(folio) + folio_size(folio), NULL);
> +}
> +
>  /*
>   * Fast revalidation of the cached writeback mapping. Return true if the current
>   * mapping is valid, false otherwise.
> @@ -278,13 +319,12 @@ xfs_imap_valid(
>  static int
>  xfs_map_blocks(
>  	struct iomap_writepage_ctx *wpc,
> -	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_inode	*ip = XFS_I(wpc->inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	ssize_t			count = i_blocksize(inode);
> +	ssize_t			count = i_blocksize(wpc->inode);
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  	xfs_fileoff_t		cow_fsb;
> @@ -436,6 +476,24 @@ xfs_map_blocks(
>  	return 0;
>  }
>  
> +static ssize_t
> +xfs_writeback_range(
> +	struct iomap_writepage_ctx *wpc,
> +	struct folio		*folio,
> +	u64			offset,
> +	unsigned int		len,
> +	u64			end_pos)
> +{
> +	ssize_t			ret;
> +
> +	ret = xfs_map_blocks(wpc, offset, len);
> +	if (!ret)
> +		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +	if (ret < 0)
> +		xfs_discard_folio(folio, offset);
> +	return ret;
> +}
> +
>  static bool
>  xfs_ioend_needs_wq_completion(
>  	struct iomap_ioend	*ioend)
> @@ -488,47 +546,9 @@ xfs_submit_ioend(
>  	return 0;
>  }
>  
> -/*
> - * If the folio has delalloc blocks on it, the caller is asking us to punch them
> - * out. If we don't, we can leave a stale delalloc mapping covered by a clean
> - * page that needs to be dirtied again before the delalloc mapping can be
> - * converted. This stale delalloc mapping can trip up a later direct I/O read
> - * operation on the same region.
> - *
> - * We prevent this by truncating away the delalloc regions on the folio. Because
> - * they are delalloc, we can do this without needing a transaction. Indeed - if
> - * we get ENOSPC errors, we have to be able to do this truncation without a
> - * transaction as there is no space left for block reservation (typically why
> - * we see a ENOSPC in writeback).
> - */
> -static void
> -xfs_discard_folio(
> -	struct folio		*folio,
> -	loff_t			pos)
> -{
> -	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
> -	struct xfs_mount	*mp = ip->i_mount;
> -
> -	if (xfs_is_shutdown(mp))
> -		return;
> -
> -	xfs_alert_ratelimited(mp,
> -		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> -			folio, ip->i_ino, pos);
> -
> -	/*
> -	 * The end of the punch range is always the offset of the first
> -	 * byte of the next folio. Hence the end offset is only dependent on the
> -	 * folio itself and not the start offset that is passed in.
> -	 */
> -	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
> -				folio_pos(folio) + folio_size(folio), NULL);
> -}
> -
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
> -	.map_blocks		= xfs_map_blocks,
> +	.writeback_range	= xfs_writeback_range,
>  	.submit_ioend		= xfs_submit_ioend,
> -	.discard_folio		= xfs_discard_folio,
>  };
>  
>  struct xfs_zoned_writepage_ctx {
> @@ -545,11 +565,10 @@ XFS_ZWPC(struct iomap_writepage_ctx *ctx)
>  static int
>  xfs_zoned_map_blocks(
>  	struct iomap_writepage_ctx *wpc,
> -	struct inode		*inode,
>  	loff_t			offset,
>  	unsigned int		len)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_inode	*ip = XFS_I(wpc->inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + len);
> @@ -608,6 +627,24 @@ xfs_zoned_map_blocks(
>  	return 0;
>  }
>  
> +static ssize_t
> +xfs_zoned_writeback_range(
> +	struct iomap_writepage_ctx *wpc,
> +	struct folio		*folio,
> +	u64			offset,
> +	unsigned int		len,
> +	u64			end_pos)
> +{
> +	ssize_t			ret;
> +
> +	ret = xfs_zoned_map_blocks(wpc, offset, len);
> +	if (!ret)
> +		ret = iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +	if (ret < 0)
> +		xfs_discard_folio(folio, offset);
> +	return ret;
> +}
> +
>  static int
>  xfs_zoned_submit_ioend(
>  	struct iomap_writepage_ctx *wpc,
> @@ -621,9 +658,8 @@ xfs_zoned_submit_ioend(
>  }
>  
>  static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
> -	.map_blocks		= xfs_zoned_map_blocks,
> +	.writeback_range	= xfs_zoned_writeback_range,
>  	.submit_ioend		= xfs_zoned_submit_ioend,
> -	.discard_folio		= xfs_discard_folio,
>  };
>  
>  STATIC int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index edca4bbe4b72..c88e2c851753 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -124,29 +124,33 @@ static void zonefs_readahead(struct readahead_control *rac)
>   * Map blocks for page writeback. This is used only on conventional zone files,
>   * which implies that the page range can only be within the fixed inode size.
>   */
> -static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
> -				   struct inode *inode, loff_t offset,
> -				   unsigned int len)
> +static ssize_t zonefs_writeback_range(struct iomap_writepage_ctx *wpc,
> +		struct folio *folio, u64 offset, unsigned len, u64 end_pos)
>  {
> -	struct zonefs_zone *z = zonefs_inode_zone(inode);
> +	struct zonefs_zone *z = zonefs_inode_zone(wpc->inode);
>  
>  	if (WARN_ON_ONCE(zonefs_zone_is_seq(z)))
>  		return -EIO;
> -	if (WARN_ON_ONCE(offset >= i_size_read(inode)))
> +	if (WARN_ON_ONCE(offset >= i_size_read(wpc->inode)))
>  		return -EIO;
>  
>  	/* If the mapping is already OK, nothing needs to be done */
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> -		return 0;
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length) {
> +		int error;
> +
> +		error = zonefs_write_iomap_begin(wpc->inode, offset,
> +				z->z_capacity - offset, IOMAP_WRITE,
> +				&wpc->iomap, NULL);
> +		if (error)
> +			return error;
> +	}
>  
> -	return zonefs_write_iomap_begin(inode, offset,
> -					z->z_capacity - offset,
> -					IOMAP_WRITE, &wpc->iomap, NULL);
> +	return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>  
>  static const struct iomap_writeback_ops zonefs_writeback_ops = {
> -	.map_blocks		= zonefs_write_map_blocks,
> +	.writeback_range	= zonefs_writeback_range,
>  };
>  
>  static int zonefs_writepages(struct address_space *mapping,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 00179c9387c5..625d7911a2b5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -416,18 +416,20 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
>  
>  struct iomap_writeback_ops {
>  	/*
> -	 * Required, maps the blocks so that writeback can be performed on
> -	 * the range starting at offset.
> +	 * Required, performs writeback on the passed in range
>  	 *
> -	 * Can return arbitrarily large regions, but we need to call into it at
> +	 * Can map arbitrarily large regions, but we need to call into it at
>  	 * least once per folio to allow the file systems to synchronize with
>  	 * the write path that could be invalidating mappings.
>  	 *
>  	 * An existing mapping from a previous call to this method can be reused
>  	 * by the file system if it is still valid.
> +	 *
> +	 * Returns the number of bytes processed or a negative errno.
>  	 */
> -	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> -			  loff_t offset, unsigned len);
> +	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
> +			struct folio *folio, u64 pos, unsigned int len,
> +			u64 end_pos);
>  
>  	/*
>  	 * Optional, allows the file systems to hook into bio submission,
> @@ -438,12 +440,6 @@ struct iomap_writeback_ops {
>  	 * the bio could not be submitted.
>  	 */
>  	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> -
> -	/*
> -	 * Optional, allows the file system to discard state on a page where
> -	 * we failed to submit any I/O.
> -	 */
> -	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
>  struct iomap_writepage_ctx {
> @@ -463,6 +459,9 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
> +ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
> +		loff_t pos, loff_t end_pos, unsigned int dirty_len);
> +
>  int iomap_writepages(struct iomap_writepage_ctx *wpc);
>  
>  /*
> -- 
> 2.47.2
> 
> 

