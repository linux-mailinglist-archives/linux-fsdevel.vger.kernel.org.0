Return-Path: <linux-fsdevel+bounces-42798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67FA48DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0ED16E9AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E1158874;
	Fri, 28 Feb 2025 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpePtAE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A49225D7;
	Fri, 28 Feb 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705582; cv=none; b=NmcwD0GLvV3mmsS6fmu90J7e94RsVAqyiJFmGY5f1tErpcnfpHF64zX5QZfSTGtq+mASaWBKgdsrQ3f73K9Dkdecq+SppdlX6vIEUmQzcGRJS3ZDmIf8tUEtyacwHA2FqcEYnB4op+vQX1LLSsm978pAphHLO+4A0ExeABBb5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705582; c=relaxed/simple;
	bh=SOf/TpR/qlSTJrForgk9jM6BV4s+TUagC9VknpbKN50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ4zWvAd2cPYCogM8dYW/JKZqgnq4V8t1LzDuVoBcs6561OzlweMHNXMbO+CeyRaHyM++8MaLOlcUaFTXdBsa9mqaME7vPm9NBlnFgeYUioBPuOCXAFKoobvpFBly7yP5wsK+AxB50YOv6Tj6y0GgGND3C8UydxzMu0o1g9v/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpePtAE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745B5C4CEDD;
	Fri, 28 Feb 2025 01:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705581;
	bh=SOf/TpR/qlSTJrForgk9jM6BV4s+TUagC9VknpbKN50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpePtAE0cB5n1VC9ayXs+cq3a1ZG4TRkq5bbp3YPsI3NSaGgf3tPVJqsdqYDpyo+3
	 n2wK12A41ZEN3ZWfANfWsJJUzffIBisnvi3zl6dusXIz4UKU5ap6QgUNYQMtqCIGJT
	 6cAVHmK7fEBVDLHqOB0VLjLppwEMi7JwvqUo75uPpIQRkYvezJ/qbbN/UeGB3igVuX
	 mO/9Qy/29u334WXtiMPueBqZbX3n3Rb2lMrTi7M0WT0LWwNMycWxR3z//ZEg40XMgF
	 EMpwB/yUL3wec02ZCxkr/pvHRj3YQQ5IYgAfiNShYQxDe6Y2WQgXiGbDs4XQ6NpdCK
	 8cfNDQTZHKvPw==
Date: Thu, 27 Feb 2025 17:19:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 08/12] xfs: Iomap SW-based atomic write support
Message-ID: <20250228011941.GE1124788@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-9-john.g.garry@oracle.com>

On Thu, Feb 27, 2025 at 06:08:09PM +0000, John Garry wrote:
> In cases of an atomic write occurs for misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.
> 
> So, for that case, return -EAGAIN to request that the write be issued in
> CoW atomic write mode. The dio write path should detect this, similar to
> how misaligned regular DIO writes are handled.
> 
> For normal HW-based mode, when the range which we are atomic writing to
> covers a shared data extent, try to allocate a new CoW fork. However, if
> we find that what we allocated does not meet atomic write requirements
> in terms of length and alignment, then fallback on the CoW-based mode
> for the atomic write.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks reasonable,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 143 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h |   1 +
>  2 files changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index edfc038bf728..573108cbdc5c 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -795,6 +795,23 @@ imap_spans_range(
>  	return true;
>  }
>  
> +static bool
> +xfs_bmap_valid_for_atomic_write(
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
> @@ -809,10 +826,13 @@ xfs_direct_write_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	xfs_fileoff_t		orig_end_fsb = end_fsb;
> +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
>  	int			nimaps = 1, error = 0;
>  	unsigned int		reflink_flags = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
> +	bool			needs_alloc;
>  	unsigned int		lockmode;
>  	u64			seq;
>  
> @@ -871,13 +891,37 @@ xfs_direct_write_iomap_begin(
>  				&lockmode, reflink_flags);
>  		if (error)
>  			goto out_unlock;
> -		if (shared)
> +		if (shared) {
> +			if (atomic_hw &&
> +			    !xfs_bmap_valid_for_atomic_write(&cmap,
> +					offset_fsb, end_fsb)) {
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
> +		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
> +			goto out_unlock;
> +
> +		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
> +				orig_end_fsb))
> +			goto out_unlock;
> +	}
> +
> +	if (needs_alloc)
>  		goto allocate_blocks;
>  
>  	/*
> @@ -965,6 +1009,101 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
>  	.iomap_begin		= xfs_direct_write_iomap_begin,
>  };
>  
> +static int
> +xfs_atomic_write_sw_iomap_begin(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			length,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_bmbt_irec	imap, cmap;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	int			nimaps = 1, error;
> +	unsigned int		reflink_flags;
> +	bool			shared = false;
> +	u16			iomap_flags = 0;
> +	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	u64			seq;
> +
> +	if (xfs_is_shutdown(mp))
> +		return -EIO;
> +
> +	reflink_flags = XFS_REFLINK_CONVERT | XFS_REFLINK_ATOMIC_SW;
> +
> +	/*
> +	 * Set IOMAP_F_DIRTY similar to xfs_atomic_write_iomap_begin()
> +	 */
> +	if (offset + length > i_size_read(inode))
> +		iomap_flags |= IOMAP_F_DIRTY;
> +
> +	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> +	if (error)
> +		return error;
> +
> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
> +			&nimaps, 0);
> +	if (error)
> +		goto out_unlock;
> +
> +	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> +			&lockmode, reflink_flags);
> +	/*
> +	 * Don't check @shared. For atomic writes, we should error when
> +	 * we don't get a COW mapping
> +	 */
> +	if (error)
> +		goto out_unlock;
> +
> +	end_fsb = imap.br_startoff + imap.br_blockcount;
> +
> +	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> +	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
> +	if (imap.br_startblock != HOLESTARTBLOCK) {
> +		seq = xfs_iomap_inode_sequence(ip, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
> +		if (error)
> +			goto out_unlock;
> +	}
> +	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> +	xfs_iunlock(ip, lockmode);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
> +
> +out_unlock:
> +	if (lockmode)
> +		xfs_iunlock(ip, lockmode);
> +	return error;
> +}
> +
> +static int
> +xfs_atomic_write_iomap_begin(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			length,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
> +{
> +	ASSERT(flags & IOMAP_WRITE);
> +	ASSERT(flags & IOMAP_DIRECT);
> +
> +	if (flags & IOMAP_ATOMIC_SW)
> +		return xfs_atomic_write_sw_iomap_begin(inode, offset, length,
> +				flags, iomap, srcmap);
> +
> +	ASSERT(flags & IOMAP_ATOMIC_HW);
> +	return xfs_direct_write_iomap_begin(inode, offset, length, flags,
> +			iomap, srcmap);
> +}
> +
> +const struct iomap_ops xfs_atomic_write_iomap_ops = {
> +	.iomap_begin		= xfs_atomic_write_iomap_begin,
> +};
> +
>  static int
>  xfs_dax_write_iomap_end(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 8347268af727..b7fbbc909943 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -53,5 +53,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
>  extern const struct iomap_ops xfs_dax_write_iomap_ops;
> +extern const struct iomap_ops xfs_atomic_write_iomap_ops;
>  
>  #endif /* __XFS_IOMAP_H__*/
> -- 
> 2.31.1
> 

