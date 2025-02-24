Return-Path: <linux-fsdevel+bounces-42497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75998A42DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF1918927F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514B2566C5;
	Mon, 24 Feb 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5aE8D2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D6243374;
	Mon, 24 Feb 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428772; cv=none; b=Y7y947rIVvmbF9e/GoqbTJYiV3MPbQIT1YNmSZxO1D+ILfwwOJCe8hg71AZjkn26IUBHgSB+jXy/4/qmn9jE3FRE2r+5wW1NQ21LkbJ4MPE5EBKWMZtO6g+p+QK3qtN1BZ4sSfUKFKhyFRGbZLjdCH2TRK5s0N+fAZYdD6cXafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428772; c=relaxed/simple;
	bh=6DkvP5Utu3fZcN+GtpoN9thgA+2c0lgdkBnrvG1XS/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAQjxF7zES8liDMJYKJMBYe2J0oLFqjdoo69sXSfudR9i4rCiB7YIr1WupevozWq06gQGBjngAxYT8SYqGuLtCToxPqYVfGb+vxYwJiiaDMONqiWc/wLCkyLcLOhlYtmkPVALBomJz8fFad2gAWmdDGDc2Q+o/h0tDGl+PJDOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5aE8D2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48595C4CEE7;
	Mon, 24 Feb 2025 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428770;
	bh=6DkvP5Utu3fZcN+GtpoN9thgA+2c0lgdkBnrvG1XS/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5aE8D2IQIIWf2OcyMAsmlJRWU5ap7dVpPfjyrb3hzcQzj+HKypWylNlX8I1Z4ttt
	 Zi20Qsh0mg1YKpMLhB6s+7XjmKRDtRBdnMe00Y4GiS8W9CwsRV9tWfZ2OPeYROHnDC
	 ZZUVTi75g9MsDWymVPkDMKCEE/BRxziODJAwoFwA/zW/1T1Bdgj1uuiGb85QOTc9PF
	 V58WD35yyGueJo0YvJjXaL7VFLqOx5VaaPdDS5jAtCPd5RHmG3xTq6dSniTPgudtCO
	 8eB8Rlnp7YyMCLBDnGU1SpcpqCo9OrpkO/jxCV57on9/1PKo/cuzcv0RChqMnu5DK1
	 szv8TBvchL1Hw==
Date: Mon, 24 Feb 2025 12:26:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 03/11] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250224202609.GH21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-4-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:11PM +0000, John Garry wrote:
> Refactor xfs_reflink_end_cow_extent() into separate parts which process
> the CoW range and commit the transaction.
> 
> This refactoring will be used in future for when it is required to commit
> a range of extents as a single transaction, similar to how it was done
> pre-commit d6f215f359637.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 59f7fc16eb80..8428f7b26ee6 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -786,35 +786,19 @@ xfs_reflink_update_quota(
>   * requirements as low as possible.
>   */
>  STATIC int
> -xfs_reflink_end_cow_extent(
> +xfs_reflink_end_cow_extent_locked(
> +	struct xfs_trans	*tp,
>  	struct xfs_inode	*ip,
>  	xfs_fileoff_t		*offset_fsb,
>  	xfs_fileoff_t		end_fsb)
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
> @@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
>  	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
>  	    got.br_startoff >= end_fsb) {
>  		*offset_fsb = end_fsb;
> -		goto out_cancel;
> +		return 0;
>  	}
>  
>  	/*
> @@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
>  		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
>  		    got.br_startoff >= end_fsb) {
>  			*offset_fsb = end_fsb;
> -			goto out_cancel;
> +			return 0;
>  		}
>  	}
>  	del = got;
> @@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
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
> @@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
>  		error = xfs_bunmapi(NULL, ip, data.br_startoff,
>  				data.br_blockcount, 0, 1, &done);
>  		if (error)
> -			goto out_cancel;
> +			return error;
>  		ASSERT(done);
>  	}
>  
> @@ -899,17 +883,46 @@ xfs_reflink_end_cow_extent(
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
> +
> +	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> +			XFS_TRANS_RESERVE, &tp);
> +	if (error)
> +		return error;
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);

Overly long line, but otherwise looks fine.  With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	if (error)
> +		xfs_trans_cancel(tp);
> +	else
> +		error = xfs_trans_commit(tp);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
>  }
> -- 
> 2.31.1
> 
> 

