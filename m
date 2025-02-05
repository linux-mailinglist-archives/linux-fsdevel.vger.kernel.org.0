Return-Path: <linux-fsdevel+bounces-40975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAACDA29A5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D0D7A2CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6920B817;
	Wed,  5 Feb 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPBWkqv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8BE1E0DE4;
	Wed,  5 Feb 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785052; cv=none; b=VNVXTNXbVy3QUBIp8humFfYSPeSK8T+1VLcp1QWAg6vgBT8x2EkIcc9eYSMsjAYV7k+6D9qipINjaOl3PvDLX2MTvMAEvza5Gg4i173lrGJ5qiPG83WNQ/Qe8nJdVBEakwl6ULps2dI+Fin/Tnrm2gSJIjGrASFgd1XqthJyWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785052; c=relaxed/simple;
	bh=0gCQWd5HDA6ixYd63Pm375DgjnfCP4qbBgNyhOShAco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn2KtdmlNQ9jZujVXXVF+LcXuKmnvQMseWYWwvYSUMpPuyi9MjaYCB2+Hv9Ibg4AIY0l38kgd87LKmMUOYBPogf6JqxeKeHi9py9v6+LRVyRWpXBanztIAIS3ZMqmuB/3OnMGT/xYtxkTRaZ2sfDkXpM/L3lf9kJCsrDoHft8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPBWkqv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618D6C4CED1;
	Wed,  5 Feb 2025 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785051;
	bh=0gCQWd5HDA6ixYd63Pm375DgjnfCP4qbBgNyhOShAco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPBWkqv9vHKG7UmNXdGAW/aYlH00jM760yqLBZMHrnXyuD5LVE6pPQfnbL5PX/Muu
	 3mQgjd+4Apls3bHHsymu/gXD84X2jpTnk7Kq97dDtS9FfBhbJUSe8aTHcuPXRJAIsr
	 soDK4IwCpEadi4TmOBBg94ms2D716j+2zY5S9Z1wr9HIJXbLlqybHs2XzXrAsdFaAH
	 i1/ZLAK9eLVGC8Wu84dCqCywLkztjTYoBtiqmbTH5ASinLrDl9nu5bR2R3v3eHqtsi
	 NnvRmIVMt8UN5RHqfrQ1H1wucnSZ1QkqLiCwZ5IhVP2rsrQpafHIgJPuOFZwzU30CT
	 8QQo3RODnq/KQ==
Date: Wed, 5 Feb 2025 11:50:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 02/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250205195050.GX21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-3-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:19PM +0000, John Garry wrote:
> Refactor xfs_reflink_end_cow_extent() into separate parts which process
> the CoW range and commit the transaction.
> 
> This refactoring will be used in future for when it is required to commit
> a range of extents as a single transaction, similar to how it was done
> pre-commit d6f215f359637.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_reflink.c | 79 +++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 59f7fc16eb80..580469668334 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -786,35 +786,20 @@ xfs_reflink_update_quota(
>   * requirements as low as possible.
>   */
>  STATIC int
> -xfs_reflink_end_cow_extent(
> +xfs_reflink_end_cow_extent_locked(
>  	struct xfs_inode	*ip,
>  	xfs_fileoff_t		*offset_fsb,
> -	xfs_fileoff_t		end_fsb)
> +	xfs_fileoff_t		end_fsb,
> +	struct xfs_trans	*tp,
> +	bool			*commit)

Transactions usually come before the inode in the parameter list.

You don't need to pass out a @commit flag -- if the function returns
nonzero then the caller has to cancel the transaction; otherwise it will
return zero and the caller should commit it.  There's no penalty for
committing a non-dirty transaction.

--D

>  {
>  	struct xfs_iext_cursor	icur;
>  	struct xfs_bmbt_irec	got, del, data;
> -	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_trans	*tp;
>  	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
> -	unsigned int		resblks;
>  	int			nmaps;
>  	bool			isrt = XFS_IS_REALTIME_INODE(ip);
>  	int			error;
>  
> -	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> -			XFS_TRANS_RESERVE, &tp);
> -	if (error)
> -		return error;
> -
> -	/*
> -	 * Lock the inode.  We have to ijoin without automatic unlock because
> -	 * the lead transaction is the refcountbt record deletion; the data
> -	 * fork update follows as a deferred log item.
> -	 */
> -	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	xfs_trans_ijoin(tp, ip, 0);
> -
>  	/*
>  	 * In case of racing, overlapping AIO writes no COW extents might be
>  	 * left by the time I/O completes for the loser of the race.  In that
> @@ -823,7 +808,7 @@ xfs_reflink_end_cow_extent(
>  	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
>  	    got.br_startoff >= end_fsb) {
>  		*offset_fsb = end_fsb;
> -		goto out_cancel;
> +		return 0;
>  	}
>  
>  	/*
> @@ -837,7 +822,7 @@ xfs_reflink_end_cow_extent(
>  		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
>  		    got.br_startoff >= end_fsb) {
>  			*offset_fsb = end_fsb;
> -			goto out_cancel;
> +			return 0;
>  		}
>  	}
>  	del = got;
> @@ -846,14 +831,14 @@ xfs_reflink_end_cow_extent(
>  	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
>  			XFS_IEXT_REFLINK_END_COW_CNT);
>  	if (error)
> -		goto out_cancel;
> +		return error;
>  
>  	/* Grab the corresponding mapping in the data fork. */
>  	nmaps = 1;
>  	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
>  			&nmaps, 0);
>  	if (error)
> -		goto out_cancel;
> +		return error;
>  
>  	/* We can only remap the smaller of the two extent sizes. */
>  	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
> @@ -882,7 +867,7 @@ xfs_reflink_end_cow_extent(
>  		error = xfs_bunmapi(NULL, ip, data.br_startoff,
>  				data.br_blockcount, 0, 1, &done);
>  		if (error)
> -			goto out_cancel;
> +			return error;
>  		ASSERT(done);
>  	}
>  
> @@ -899,17 +884,49 @@ xfs_reflink_end_cow_extent(
>  	/* Remove the mapping from the CoW fork. */
>  	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
>  
> -	error = xfs_trans_commit(tp);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	if (error)
> -		return error;
> -
>  	/* Update the caller about how much progress we made. */
>  	*offset_fsb = del.br_startoff + del.br_blockcount;
> +	*commit = true;
>  	return 0;
> +}
>  
> -out_cancel:
> -	xfs_trans_cancel(tp);
> +
> +/*
> + * Remap part of the CoW fork into the data fork.
> + *
> + * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
> + * into the data fork; this function will remap what it can (at the end of the
> + * range) and update @end_fsb appropriately.  Each remap gets its own
> + * transaction because we can end up merging and splitting bmbt blocks for
> + * every remap operation and we'd like to keep the block reservation
> + * requirements as low as possible.
> + */
> +STATIC int
> +xfs_reflink_end_cow_extent(
> +	struct xfs_inode	*ip,
> +	xfs_fileoff_t		*offset_fsb,
> +	xfs_fileoff_t		end_fsb)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_trans	*tp;
> +	unsigned int		resblks;
> +	int			error;
> +	bool			commit = false;
> +
> +	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> +			XFS_TRANS_RESERVE, &tp);
> +	if (error)
> +		return error;
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	error = xfs_reflink_end_cow_extent_locked(ip, offset_fsb,
> +					end_fsb, tp, &commit);
> +	if (commit)
> +		error = xfs_trans_commit(tp);
> +	else
> +		xfs_trans_cancel(tp);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
>  }
> -- 
> 2.31.1
> 
> 

