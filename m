Return-Path: <linux-fsdevel+bounces-42796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593ABA48DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E97A802D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628721364;
	Fri, 28 Feb 2025 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s536YGJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478C4409;
	Fri, 28 Feb 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705185; cv=none; b=bBPmVgGUaSYza8W6LGfW9NyMHxs6jQ7PDSsBV6uDIWzQJyldpp7mBC7efZunolYW+dp2qxM+dVCKjzLJYFmuFyGq1BsEG6mLa4B1Mj18JnkfGFqQEzgnSrAb3ify20knhzNBDeoa2ZbhX849FYqLX9rKd4ANPKJcy5tSO0X2pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705185; c=relaxed/simple;
	bh=iibeqmxcNk4k1THp5xIlxdco9/RD68czTK+36Ph5pnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1ZhVHxY4Ma1i4NAZaQuHRb1fkau0VbBoz7EPlQhhXlP0BjEP0EidqRxUXnW2M1JvosA027YZvZuYHXjwyUGPTj6A0w4JdV3uo5jTv9KKDTcpQkXrxpkJ4fbZQC68fwrKUC2sIM0xTN8MBvOj6g+RqtsDzJxP8G2oj55zWYaRSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s536YGJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E0AC4CEDD;
	Fri, 28 Feb 2025 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705185;
	bh=iibeqmxcNk4k1THp5xIlxdco9/RD68czTK+36Ph5pnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s536YGJC+pzpFwJ6KVBYH4lnIIAPz4Xfk4TGkZ8VTVpDK7b9KUwU/WbkyByZqrfuT
	 ObAMiOBr5wCxRzpdvjTRXQZhDYdFdv/bN8JwZTAotV2oOvjES3s6zBziFKt7udMb5A
	 iWWoy/je1kvl5ccHCUbjbtqWWxuDpLWk4W2Jr+Z75HzoNpn+8fNHItTmCTB7FzZgvO
	 Mb+RwRIA0/+y+dyD58Ro8pwtYloxTL224Zr9NbebWghDoavsJ4xpLGlOK76ufMwdXp
	 xF22/WWtuzqdG1Qo8ZYmp7enGmvIqy8eLDz4tDQ92n/+a10eALxBRcq1qOyNM0HCBl
	 HNdhGsF4ls5sg==
Date: Thu, 27 Feb 2025 17:13:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 10/12] xfs: Commit CoW-based atomic writes atomically
Message-ID: <20250228011304.GC1124788@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-11-john.g.garry@oracle.com>

On Thu, Feb 27, 2025 at 06:08:11PM +0000, John Garry wrote:
> When completing a CoW-based write, each extent range mapping update is
> covered by a separate transaction.
> 
> For a CoW-based atomic write, all mappings must be changed at once, so
> change to use a single transaction.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c    |  5 ++++-
>  fs/xfs/xfs_reflink.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_reflink.h |  3 +++
>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 76ea59c638c3..44e11c433569 100644
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
> index 97dc38841063..844e2b43357b 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -987,6 +987,55 @@ xfs_reflink_end_cow(
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
> +	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	end_fsb = XFS_B_TO_FSB(mp, offset + count);
> +
> +	/*
> +	 * Each remapping operation could cause a btree split, so in the worst
> +	 * case that's one for each block.
> +	 */
> +	resblks = (end_fsb - offset_fsb) *
> +			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
> +
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> +			XFS_TRANS_RESERVE, &tp);
> +	if (error)
> +		return error;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	xfs_trans_ijoin(tp, ip, 0);
> +
> +	while (end_fsb > offset_fsb && !error) {
> +		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
> +				end_fsb);
> +	}
> +	if (error) {
> +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> +		goto out_cancel;
> +	}
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
> index dfd94e51e2b4..4cb2ee53cd8d 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -49,6 +49,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count, bool cancel_real);
>  extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count);
> +		int
> +xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
> +		xfs_off_t count);

Nit: return type should be at column 0 and the name should be right
after.

int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
		xfs_off_t count);

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
>  extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
>  		struct file *file_out, loff_t pos_out, loff_t len,
> -- 
> 2.31.1
> 

