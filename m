Return-Path: <linux-fsdevel+bounces-53681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649CAF5FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE0448637F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BA30E835;
	Wed,  2 Jul 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqWjSAls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6430114D;
	Wed,  2 Jul 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476435; cv=none; b=ZMJowb9Ch+0WUvHalhTCA1kWnBIE7i3/imUbHBWDjTxKW8J0GazZ/QIPRla8Mdfl+DcGXNfaj8U+D8J3mHvtVfm+LYUBFCCYd5S+E6bFyGza6xCrvgnFXH0yq6PRGt8YxMhaC54Ro+gRh/23LmOtIIzt5ZiRMpqz8MedNxVYEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476435; c=relaxed/simple;
	bh=VMHkRZ7gpU0AfX2qLMxrAX33XER5hP8dZXdzdJxemCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx9AdgjLWpWe25U+4tamKiwJneToLeuW3kgCwVDBbixYxKEiC2U6oIa5eEGqRcgRK4yGgg34RK0Y6yAsIIHBsg2fh08fSUyT5AiEaOQNwqZsKlHOSifQKeb7hsEw6pW1Eez3llpqOnBhrDCTzpzqpp5wISWdx1Exm4E50yOzyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqWjSAls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA9EC4CEE7;
	Wed,  2 Jul 2025 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751476434;
	bh=VMHkRZ7gpU0AfX2qLMxrAX33XER5hP8dZXdzdJxemCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqWjSAls/3I2/qkJF0lrCmHbcllM12X/+UYhj6ojzX5bE8opr/61vzbGpkq6q802R
	 cbrbuqdrjyjfsTc5N/e41ZRYAA9zD5BpdFMj9tJz7Q6RXbFvaw/TdWh+WTMmaKlLLn
	 kOymSvz5USKrCSlrcoleDIyjr/sC7yq9syye7FfD111b4x7KGZMF1q5s6fKILu/Dqe
	 uQMnkBGGyVXgcI9UqnxJIw1+GuF9LtbvRgf/5zfaUrX3UsutG3Sfxv0oAsTKwyKvIO
	 89Bg7Xn5cJ+t2VeofBOEOeJf89g7b8LbmDJZ7tr6QYxoqE7vsBX2NmLDHO1rEhDrFx
	 SHsoS6yLQexYg==
Date: Wed, 2 Jul 2025 10:13:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 03/16] iomap: refactor the writeback interface
Message-ID: <20250702171353.GW10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-4-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:22PM -0700, Joanne Koong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
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

Sounds like a good goal. ;)

> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  23 +--
>  block/fops.c                                  |  25 ++-
>  fs/gfs2/bmap.c                                |  26 +--
>  fs/iomap/buffered-io.c                        |  93 +++++------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 154 ++++++++++--------
>  fs/zonefs/file.c                              |  28 ++--
>  include/linux/iomap.h                         |  20 +--
>  8 files changed, 187 insertions(+), 184 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 3b628e370d88..b28f215db6e5 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst

<snip>

> @@ -283,15 +283,14 @@ The ``ops`` structure must be specified and is as follows:
>  .. code-block:: c
>  
>   struct iomap_writeback_ops {
> -     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> -                       loff_t offset, unsigned len);
> -     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> -     void (*discard_folio)(struct folio *folio, loff_t pos);
> +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);

Why does @pos change from loff_t to u64 here?  Are we expecting
filesystems that set FOP_UNSIGNED_OFFSET?

> +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);

Nit:   ^^ indenting change here.

>   };
>  
>  The fields are as follows:
>  
> -  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
> +  - ``writeback_range``: Sets ``wpc->iomap`` to the space mapping of the file
>      range (in bytes) given by ``offset`` and ``len``.
>      iomap calls this function for each dirty fs block in each dirty folio,
>      though it will `reuse mappings

<snip>

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 11a55da26a6f..80d8acfaa068 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1748,63 +1764,34 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
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
> -
> -		map_len = min_t(u64, dirty_len,
> -			wpc->iomap.offset + wpc->iomap.length - pos);
> -		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +		ssize_t ret;
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
> +		ret = wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
> +		if (WARN_ON_ONCE(ret == 0 || ret > rlen))
> +			return -EIO;
> +		if (ret < 0)
> +			return ret;
> +		rlen -= ret;
> +		pos += ret;
> +		if (wpc->iomap.type != IOMAP_HOLE)
> +			*wb_pending = true;

/me wonders if this should be an outparam of ->writeback_range to signal
that it actually added the folio to the writeback ioend chain?  Or maybe
just a boolean in iomap_writepage_ctx that we clear before calling
->writeback_range and iomap_add_to_ioend can set it as appropriate?

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

<snip>

> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 65485a52df3b..8157b6d92c8e 100644
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

Nice, one less indirect call. :)

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

<snip>

> @@ -389,7 +431,12 @@ xfs_map_blocks(
>  
>  	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
> -	return 0;
> +map_blocks:

Should this jump label should be named add_to_ioend or something?  We
already mapped the blocks.  The same applies to the zoned version of
this function.

--D

