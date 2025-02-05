Return-Path: <linux-fsdevel+bounces-40974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51390A29A59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB10F167A58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAB20B817;
	Wed,  5 Feb 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDe+/0jC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF3DF5C;
	Wed,  5 Feb 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784862; cv=none; b=D1eS4sdl94YYtozYTVoTc8a2iOQUTYX42fHA2QWBzH7ElCbhzczzBz+bPX5pYpTyol8upDytEBeXikhSrJDAgFrqUUlXVJWibtTM4epsbD6+LaNXmABa3LMeuRe1nYn0yuBCbR0FRuVY6lxvab+tI3fMDJyw86X4x83uIBptH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784862; c=relaxed/simple;
	bh=LCmbiWXNKRWpvF7Li6lKrAoivVevoEkM4AvZkVUEa6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYRop9eace0h89Ajwe0dCN+rfH04KBMdk6J3xTSFLSxwsVWGxZwYB6SeFQLRdIQubAR5U7qtZA03ScPPa3bC3BRLNejFjyaTRwoDULB9NrI4xMD6WwBAJz4Ov+BfNdcxUEZ2xW0BAnCeONwXiGAArPbD2LRXhR5XGGwGwrriN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDe+/0jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6114C4CED1;
	Wed,  5 Feb 2025 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738784860;
	bh=LCmbiWXNKRWpvF7Li6lKrAoivVevoEkM4AvZkVUEa6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDe+/0jCxav64xKdhlVdFcbwqvmyxvK7fRST3GwOsVzR3a5Pt//v1i330a9x0+pWv
	 vyzgsQU1aQM1ZtUJ+QxEdx24LMwGvIH7n2dSD/42qlomcvSnIVGleI89pAZ6C3bH+Q
	 IbfZ4mnqnyP+tV9qHYtXDJReCqOJiXuQx0lAKixspFxl9oi2yU2OhnOxHelmoZGLGy
	 vHt5B5wDPBGb998IsnfTmf2Lw5Qs+q/8CwsKRquCpMsASX4DW7qezcLrzFHOdzoHPz
	 3ehCnTy1jrKVmDcXfaMl2Ckpttz/AlkoVR0R+2Hj1L5InP1eTZBfkxvfADxK+cveS3
	 XZlmlG5SoGz+g==
Date: Wed, 5 Feb 2025 11:47:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 08/10] xfs: Commit CoW-based atomic writes atomically
Message-ID: <20250205194740.GW21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-9-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:25PM +0000, John Garry wrote:
> When completing a CoW-based write, each extent range mapping update is
> covered by a separate transaction.
> 
> For a CoW-based atomic write, all mappings must be changed at once, so
> change to use a single transaction.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c    |  5 ++++-
>  fs/xfs/xfs_reflink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_reflink.h |  3 +++
>  3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 12af5cdc3094..170d7891f90d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -527,7 +527,10 @@ xfs_dio_write_end_io(
>  	nofs_flag = memalloc_nofs_save();
>  
>  	if (flags & IOMAP_DIO_COW) {
> -		error = xfs_reflink_end_cow(ip, offset, size);
> +		if (iocb->ki_flags & IOCB_ATOMIC)
> +			error = xfs_reflink_end_atomic_cow(ip, offset, size);
> +		else
> +			error = xfs_reflink_end_cow(ip, offset, size);
>  		if (error)
>  			goto out;
>  	}
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index dbce333b60eb..60c986300faa 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -990,6 +990,54 @@ xfs_reflink_end_cow(
>  		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>  	return error;
>  }
> +int
> +xfs_reflink_end_atomic_cow(
> +	struct xfs_inode		*ip,
> +	xfs_off_t			offset,
> +	xfs_off_t			count)
> +{
> +	xfs_fileoff_t			offset_fsb;
> +	xfs_fileoff_t			end_fsb;
> +	int				error = 0;
> +	struct xfs_mount		*mp = ip->i_mount;
> +	struct xfs_trans		*tp;
> +	unsigned int			resblks;
> +	bool				commit = false;
> +
> +	trace_xfs_reflink_end_cow(ip, offset, count);
> +
> +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
> +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
> +
> +	resblks = XFS_NEXTENTADD_SPACE_RES(ip->i_mount,
> +				(unsigned int)(end_fsb - offset_fsb),
> +				XFS_DATA_FORK);
> +
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,

xfs gained reflink support for realtime volumes in 6.14-rc1, so you now
have to calculate for that in here too.

> +			XFS_TRANS_RESERVE, &tp);
> +	if (error)
> +		return error;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	while (end_fsb > offset_fsb && !error)
> +		error = xfs_reflink_end_cow_extent_locked(ip, &offset_fsb,
> +						end_fsb, tp, &commit);

Hmm.  Attaching intent items to a transaction consumes space in that
transaction, so we probably ought to limit the amount that we try to do
here.  Do you know what that limit is?  I don't, but it's roughly
tr_logres divided by the average size of a log intent item.

This means we need to restrict the size of an untorn write to a
double-digit number of fsblocks for safety.

The logic in here looks reasonable though.

--D

> +
> +	if (error || !commit)
> +		goto out_cancel;
> +
> +	if (error)
> +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> +	error = xfs_trans_commit(tp);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return error;
> +out_cancel:
> +	xfs_trans_cancel(tp);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return error;
> +}
>  
>  /*
>   * Free all CoW staging blocks that are still referenced by the ondisk refcount
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index ef5c8b2398d8..2c3b096c1386 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -45,6 +45,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count, bool cancel_real);
>  extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count);
> +		int
> +xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
> +		xfs_off_t count);
>  extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
>  extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
>  		struct file *file_out, loff_t pos_out, loff_t len,
> -- 
> 2.31.1
> 
> 

