Return-Path: <linux-fsdevel+bounces-42494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D9A42DA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5683B1BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067E244EAB;
	Mon, 24 Feb 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQBYy678"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F251219301;
	Mon, 24 Feb 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428436; cv=none; b=aS/1ZWdJwRD2kB9ptF1D2/ULakRqAHtm2xxnqDXThTIeKcPNmGasRRhfJsY34MxCvxxoK64VDXhITjsSsWnvz2KTplDU0VjpmqxNC+J8owBhuyrOStp0AbuZTdE8yVHWqx2zcTGY1P0lAmvJnXs61n6fJex/UXIJ494nJXOv2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428436; c=relaxed/simple;
	bh=6VAqcp8i/KksTRnjFl8hZ1PVyC+q8YxP3Kyhwai1Ibs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7U/vMurP2Rm0huVhA2/JzU9I1KGlnw42ag6jBv7rqmG64+HKfEzfQri3a//WuwMPDGSw8riPpZDbMXBs7OyHQXJ2nq5ea+xQ2UfVFclMKmBxlgN+Vu3MX/LyMRSJELxJY891PfJqPWLLVQ8DBHvHoCCYvVqAkEHYCjrAABINRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQBYy678; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A5C4CEDD;
	Mon, 24 Feb 2025 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428435;
	bh=6VAqcp8i/KksTRnjFl8hZ1PVyC+q8YxP3Kyhwai1Ibs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQBYy678jd44jdnG4APN0sq4DrqtNqvjjyui5kWyGLPH18QZpNUyvuN3yCUwfPPKj
	 Oe+E+cwzCIiaL2mw+VOOyeoOLuRKWd95cD+JUQuyJSOgZLFZvlNga+A8BgGpmLwU4p
	 cE+3K8RUrf/XYQcrMFXohjfgPivA25T2k7zwZJdS3/Jd8iRoqrFvzJxR0gRLf57JHB
	 buv7TRQeLux1FLmzfl8YvXUamn5toFAHbaiXhjLQQ+cS/+eHo7KXWFY6oiuS4mJbxk
	 DAfOHb+Jz/+GW8nuM3RBh1YQziFuAYZ4mNHLe8vpCZZhxnkymGr6f8JorFmEeRfP+h
	 1IjUFP57O0xnA==
Date: Mon, 24 Feb 2025 12:20:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 09/11] xfs: Commit CoW-based atomic writes atomically
Message-ID: <20250224202034.GE21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-10-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:17PM +0000, John Garry wrote:
> When completing a CoW-based write, each extent range mapping update is
> covered by a separate transaction.
> 
> For a CoW-based atomic write, all mappings must be changed at once, so
> change to use a single transaction.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c    |  5 ++++-
>  fs/xfs/xfs_reflink.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_reflink.h |  3 +++
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 9762fa503a41..243640fe4874 100644
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
> index 3dab3ba900a3..d097d33dc000 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -986,6 +986,51 @@ xfs_reflink_end_cow(
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
> +
> +	trace_xfs_reflink_end_cow(ip, offset, count);
> +
> +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
> +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);

Use @mp here instead of walking the pointer.

> +
> +	resblks = (end_fsb - offset_fsb) *
> +			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);

How did you arrive at this computation?  The "b" parameter to
XFS_NEXTENTADD_SPACE_RES is usually the worst case number of mappings
that you're going to change on this file.  I think that quantity is
(end_fsb - offset_fsb)?

> +
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> +			XFS_TRANS_RESERVE, &tp);
> +	if (error)
> +		return error;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	while (end_fsb > offset_fsb && !error)
> +		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
> +							end_fsb);

Overly long line, and the continuation line only needs to be indented
two more tabs.

> +
> +	if (error) {
> +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> +		goto out_cancel;
> +	}
> +	error = xfs_trans_commit(tp);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return 0;

Why is it ok to drop @error here?  Shouldn't a transaction commit error
should be reported to the writer thread?

--D

> +out_cancel:
> +	xfs_trans_cancel(tp);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return error;
> +}
>  
>  /*
>   * Free all CoW staging blocks that are still referenced by the ondisk refcount
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index 754d2bb692d3..ca945d98e823 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -43,6 +43,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
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

