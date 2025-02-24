Return-Path: <linux-fsdevel+bounces-42492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC99A42D7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C87A7364
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90966242902;
	Mon, 24 Feb 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF/7pBC2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D01DB346;
	Mon, 24 Feb 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428014; cv=none; b=hUJxHqhtaVHUPp21WI8ZMyHlKUc0+2crCsyoMNaz/qWu+C9WN0gshJrc8bPSq5Ij6C3yDRjoPlzUPBupO0ZyMrO3sGLEzmKVn2PdGNXdaodQLB4avUR9WbksuRLZs2axxE2zTlHnNPVeEl03DtSBakNjtAf3kM+NhHjddw95r4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428014; c=relaxed/simple;
	bh=k0vnno4H/q7Y2jWBdxb61/sd4YN5Ft+YYbYrZviEfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAz+M6KL/D3y2p0MJNS/467xEVyTnjSGG+YzrrNcwuveAMfgl/lb7kolZmvUoa+ink1eFniM+8I4d2UP5DtLNRYVzT8gjC8mmVoV2IBvyLWMggDFJ1sG2nAuwI1TlhHfjjx65xoVkced0vQ+xhPIW8iXoi+P3hPXS1pPrTpKgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF/7pBC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7208C4CED6;
	Mon, 24 Feb 2025 20:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428013;
	bh=k0vnno4H/q7Y2jWBdxb61/sd4YN5Ft+YYbYrZviEfSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RF/7pBC2ADRgEK/TrVT0HUeWoPCawBkxesuy8A7OPOYQv+y23CmlW793fz5ndInRu
	 zAqH0lpArsO7daeKGEhrHqBXH/xT4dn2Q7FR4FZsKpmJENP/4S41Kbqu/xUhs8jYNW
	 49QqnigEopuBH/hADeK4waGJF7YioOd5NNpCQ6vF2hHdNKjDG17Gwj1MiHDBrDSo3M
	 iaPr9tzJ9YZBs4a4FTPgEGaTZRzycAC9FcLTvhY8U/C2cHJl6FvAjYS75pJUw4Oj5k
	 Jl/0k5XRTIISnZW43obYIiECU8+B5l+iylQza5evEVEm/iFQTegSAdw6DSoJpMXxFm
	 +1RqAoukkdJhA==
Date: Mon, 24 Feb 2025 12:13:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 07/11] xfs: iomap CoW-based atomic write support
Message-ID: <20250224201333.GD21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-8-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:15PM +0000, John Garry wrote:
> In cases of an atomic write occurs for misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.
> 
> So, for that case, return -EAGAIN to request that the write be issued in
> CoW atomic write mode. The dio write path should detect this, similar to
> how misaligned regalar DIO writes are handled.
> 
> For normal HW-based mode, when the range which we are atomic writing to
> covers a shared data extent, try to allocate a new CoW fork. However, if
> we find that what we allocated does not meet atomic write requirements
> in terms of length and alignment, then fallback on the CoW-based mode
> for the atomic write.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iomap.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ab79f0080288..c5ecfafbba60 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -795,6 +795,23 @@ imap_spans_range(
>  	return true;
>  }
>  
> +static bool
> +imap_range_valid_for_atomic_write(

xfs_bmap_valid_for_atomic_write()

> +	struct xfs_bmbt_irec	*imap,
> +	xfs_fileoff_t		offset_fsb,
> +	xfs_fileoff_t		end_fsb)
> +{
> +	/* Misaligned start block wrt size */
> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
> +		return false;
> +
> +	/* Discontiguous or mixed extents */
> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int
>  xfs_direct_write_iomap_begin(
>  	struct inode		*inode,
> @@ -809,12 +826,20 @@ xfs_direct_write_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	bool			atomic_cow = flags & IOMAP_ATOMIC_COW;
> +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
> +	xfs_fileoff_t		orig_offset_fsb;
> +	xfs_fileoff_t		orig_end_fsb;
> +	bool			needs_alloc;
>  	unsigned int		lockmode;
>  	u64			seq;
>  
> +	orig_offset_fsb = offset_fsb;

When does offset_fsb change?

> +	orig_end_fsb = end_fsb;

Set this in the variable declaration?

> +
>  	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
>  
>  	if (xfs_is_shutdown(mp))
> @@ -832,7 +857,7 @@ xfs_direct_write_iomap_begin(
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
>  	 */
> -	if (xfs_is_cow_inode(ip))
> +	if (xfs_is_cow_inode(ip) || atomic_cow)
>  		lockmode = XFS_ILOCK_EXCL;
>  	else
>  		lockmode = XFS_ILOCK_SHARED;
> @@ -857,6 +882,22 @@ xfs_direct_write_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> +	if (flags & IOMAP_ATOMIC_COW) {

	if (atomic_cow) ?

Or really, atomic_sw?

> +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> +				&lockmode,
> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
> +		/*
> +		 * Don't check @shared. For atomic writes, we should error when
> +		 * we don't get a CoW fork.

"Get a CoW fork"?  What does that mean?  The cow fork should be
automatically allocated when needed, right?  Or should this really read
"...when we don't get a COW mapping"?

> +		 */
> +		if (error)
> +			goto out_unlock;
> +
> +		end_fsb = imap.br_startoff + imap.br_blockcount;
> +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
> +		goto out_found_cow;
> +	}

Can this be a separate ->iomap_begin (and hence iomap ops)?  I am trying
to avoid the incohesion (still) plaguing most of the other iomap users.

> +
>  	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
>  		error = -EAGAIN;
>  		if (flags & IOMAP_NOWAIT)
> @@ -868,13 +909,38 @@ xfs_direct_write_iomap_begin(
>  				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
>  		if (error)
>  			goto out_unlock;
> -		if (shared)
> +		if (shared) {
> +			if (atomic_hw &&
> +			    !imap_range_valid_for_atomic_write(&cmap,
> +					orig_offset_fsb, orig_end_fsb)) {
> +				error = -EAGAIN;
> +				goto out_unlock;
> +			}
>  			goto out_found_cow;
> +		}
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
>  
> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> +
> +	if (atomic_hw) {
> +		error = -EAGAIN;
> +		/*
> +		 * Use CoW method for when we need to alloc > 1 block,
> +		 * otherwise we might allocate less than what we need here and
> +		 * have multiple mappings.
> +		*/
> +		if (needs_alloc && orig_end_fsb - orig_offset_fsb > 1)
> +			goto out_unlock;
> +
> +		if (!imap_range_valid_for_atomic_write(&imap, orig_offset_fsb,
> +						orig_end_fsb)) {

You only need to indent by two more tabs for a continuation line.

--D

> +			goto out_unlock;
> +		}
> +	}
> +
> +	if (needs_alloc)
>  		goto allocate_blocks;
>  
>  	/*
> -- 
> 2.31.1
> 
> 

