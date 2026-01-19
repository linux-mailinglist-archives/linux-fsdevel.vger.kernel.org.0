Return-Path: <linux-fsdevel+bounces-74512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6ED3B4F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA8863047C91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A732D7FF;
	Mon, 19 Jan 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5XRitry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2302FFFA4;
	Mon, 19 Jan 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844738; cv=none; b=paF1/pjpEKrRTxHWaJBW1e3aSkeMQ5h35Xthx0Rtw+Z6VWA+2GMEJZmTuMLzv444LUeF3xGc7IKUx9sp6aZXJ44uJHRZF9P2WSRsAm3eYYHhCdJET0P6CNzXalzJCxJV+yt272TdZ7cpxQxcDr881us1BWc1c8SH0X5zY4c9GXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844738; c=relaxed/simple;
	bh=GPpH+lrbGOkUO+HU9Chxi5Q9b/lVJMf37L9lUr7ORSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAt7XMeyn6XaRzwLVKJoySz9CMWaaF+M0sYjmyeivm6CfZEfQ/ujXe2Pa2pwdcaLbcehCm6iNDjjwjZHdibs2GyPOsrwPiIgwRs+Xabk+k+37MmCxPC+63lstYn5pgjUqY1c+Vn1/M8z47I1VEFRc11trDZd4uT0jF1mR65tX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5XRitry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264B7C116C6;
	Mon, 19 Jan 2026 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844738;
	bh=GPpH+lrbGOkUO+HU9Chxi5Q9b/lVJMf37L9lUr7ORSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5XRitryyvB369UvpUUl4ZByVUzZnV/Os70U8sb5qN7qyvUay3fkYqXuMerG1KiaK
	 uiCUCQPF45PW7tt+hEkQzAKhgO2IXjJlJGMPNTIhEbYTIEDRde7TbzUW7Odwa6CiU0
	 RYgOM/1POMEt5PwTYJmmkKJ2iPsOrShfOjrk4tKwSREc4rPj5kvQv+/m8qkx1xYOoq
	 GfbiOA5x4FLcNJ3KgUtHdwWYiCpSHNMLSQdDRWPLKD2/Pf4n9wXkJhSCG/7GMnVUS8
	 xboHbYe45dKIdeVZUtIKXcTbU53+OBiVlxyAlKjzZbwJ+7XYrwiro3TzMUuc86s/u6
	 7JcdUFJL9s1kg==
Date: Mon, 19 Jan 2026 09:45:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: use bounce buffering direct I/O when the
 device requires stable pages
Message-ID: <20260119174537.GD15551@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-15-hch@lst.de>

On Mon, Jan 19, 2026 at 08:44:21AM +0100, Christoph Hellwig wrote:
> Fix direct I/O on devices that require stable pages by asking iomap
> to bounce buffer.  To support this, ioends are used for direct reads
> in this case to provide a user context for copying data back from the
> bounce buffer.
> 
> This fixes qemu when used on devices using T10 protection information
> and probably other cases like iSCSI using data digests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ahaha, I forgot in the last round that s_dio_done_wq is not at all the
place for doing bio completions.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c |  8 ++++++--
>  fs/xfs/xfs_file.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 56a544638491..c3c1e149fff4 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -103,7 +103,7 @@ xfs_ioend_put_open_zones(
>   * IO write completion.
>   */
>  STATIC void
> -xfs_end_ioend(
> +xfs_end_ioend_write(
>  	struct iomap_ioend	*ioend)
>  {
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
> @@ -202,7 +202,11 @@ xfs_end_io(
>  			io_list))) {
>  		list_del_init(&ioend->io_list);
>  		iomap_ioend_try_merge(ioend, &tmp);
> -		xfs_end_ioend(ioend);
> +		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> +			iomap_finish_ioends(ioend,
> +				blk_status_to_errno(ioend->io_bio.bi_status));
> +		else
> +			xfs_end_ioend_write(ioend);
>  		cond_resched();
>  	}
>  }
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 7874cf745af3..f6cc63dcf961 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -224,12 +224,34 @@ xfs_ilock_iocb_for_write(
>  	return 0;
>  }
>  
> +/*
> + * Bounce buffering dio reads need a user context to copy back the data.
> + * Use an ioend to provide that.
> + */
> +static void
> +xfs_dio_read_bounce_submit_io(
> +	const struct iomap_iter	*iter,
> +	struct bio		*bio,
> +	loff_t			file_offset)
> +{
> +	iomap_init_ioend(iter->inode, bio, file_offset, IOMAP_IOEND_DIRECT);
> +	bio->bi_end_io = xfs_end_bio;
> +	submit_bio(bio);
> +}
> +
> +static const struct iomap_dio_ops xfs_dio_read_bounce_ops = {
> +	.submit_io	= xfs_dio_read_bounce_submit_io,
> +	.bio_set	= &iomap_ioend_bioset,
> +};
> +
>  STATIC ssize_t
>  xfs_file_dio_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> +	unsigned int		dio_flags = 0;
> +	const struct iomap_dio_ops *dio_ops = NULL;
>  	ssize_t			ret;
>  
>  	trace_xfs_file_direct_read(iocb, to);
> @@ -242,7 +264,12 @@ xfs_file_dio_read(
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
>  		return ret;
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
> +	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
> +		dio_ops = &xfs_dio_read_bounce_ops;
> +		dio_flags |= IOMAP_DIO_BOUNCE;
> +	}
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, dio_ops, dio_flags,
> +			NULL, 0);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -703,6 +730,8 @@ xfs_file_dio_write_aligned(
>  		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
>  		iolock = XFS_IOLOCK_SHARED;
>  	}
> +	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
> +		dio_flags |= IOMAP_DIO_BOUNCE;
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, ops, dops, dio_flags, ac, 0);
>  out_unlock:
> @@ -750,6 +779,7 @@ xfs_file_dio_write_atomic(
>  {
>  	unsigned int		iolock = XFS_IOLOCK_SHARED;
>  	ssize_t			ret, ocount = iov_iter_count(from);
> +	unsigned int		dio_flags = 0;
>  	const struct iomap_ops	*dops;
>  
>  	/*
> @@ -777,8 +807,10 @@ xfs_file_dio_write_atomic(
>  	}
>  
>  	trace_xfs_file_direct_write(iocb, from);
> -	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
> -			0, NULL, 0);
> +	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
> +		dio_flags |= IOMAP_DIO_BOUNCE;
> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops, dio_flags,
> +			NULL, 0);
>  
>  	/*
>  	 * The retry mechanism is based on the ->iomap_begin method returning
> @@ -867,6 +899,9 @@ xfs_file_dio_write_unaligned(
>  	if (flags & IOMAP_DIO_FORCE_WAIT)
>  		inode_dio_wait(VFS_I(ip));
>  
> +	if (mapping_stable_writes(iocb->ki_filp->f_mapping))
> +		flags |= IOMAP_DIO_BOUNCE;
> +
>  	trace_xfs_file_direct_write(iocb, from);
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
>  			   &xfs_dio_write_ops, flags, NULL, 0);
> -- 
> 2.47.3
> 
> 

