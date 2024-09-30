Return-Path: <linux-fsdevel+bounces-30390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755298AA07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DF01F229D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53471946AA;
	Mon, 30 Sep 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNRpNjOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DA63D5;
	Mon, 30 Sep 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714477; cv=none; b=bbsK5QIjtHrcW9Gmy0ihGd9MyDGPblfEevoPLJgVEsbfo1seZH8lycnBvn0Ps0Pr9BuvnIeaX/yvkW+Rf/y6foGQHceFuAfkoXi5tqxM9rk/rQLaUF0cIHuHY9NuSQKFqoG966IgMPM9kCDNW+9nJnm59hymn2rkKKniRC6M3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714477; c=relaxed/simple;
	bh=QbApHv7YO8fwsTHXzGN74yxmkRh/G1XP15EyHwKkAJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsEgV8Jpl7cZOKmi9PBNZ0visSAW8tgZdVZJ/Xn0RjoFrfK6QCEqyAxUQoNs/sMN1a568etufX1oxCGQaAZ/ZPdUdocZcoXVh9TklhAevZOzA1xUbNRwdMwCsyyiPYlfx9XVlpPxidb0iDvITRT6A9nArAKy5qP6Bo8rnUqZ7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNRpNjOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FA3C4CEC7;
	Mon, 30 Sep 2024 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714476;
	bh=QbApHv7YO8fwsTHXzGN74yxmkRh/G1XP15EyHwKkAJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNRpNjODTA46B4864nC/+jWmRHvhEGqasnIfqSICU3XUE7b4x7P8b8iG9/qCtougA
	 y68hF2W/7I4EV2k7rI2s3tLlAXN7Cni4CdQwUV97GdGVF8B13ErqW0NxciiAnQpV+c
	 Q4SHstTZi9bo1xQJfaGW6FJ53/NDHMbX5jtdtIhLfWZYEgfSlnIBAUulhS60jCjREP
	 SCuIzgQKeSPvCIKzSL23VKLHvHkyTE7Xu0yxrMH3DkCoVniej3U9zvC+aIGb4fIhbD
	 pvgMjgW2SkBHvAqommPTmj3b4tDXoJU9BCtpAdMAhyf98YfWYaX4lfO6VioArG/JNH
	 KsZ/00cRj4f6A==
Date: Mon, 30 Sep 2024 09:41:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 6/7] xfs: Validate atomic writes
Message-ID: <20240930164116.GP21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930125438.2501050-7-john.g.garry@oracle.com>

On Mon, Sep 30, 2024 at 12:54:37PM +0000, John Garry wrote:
> Validate that an atomic write adheres to length/offset rules. Currently
> we can only write a single FS block.
> 
> For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
> FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
> ATOMICWRITES flags would also need to be set for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 412b1d71b52b..fa6a44b88ecc 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -688,6 +688,13 @@ xfs_file_dio_write(
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>  	size_t			count = iov_iter_count(from);
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (count != ip->i_mount->m_sb.sb_blocksize)
> +			return -EINVAL;
> +		if (!generic_atomic_write_valid(iocb, from))
> +			return -EINVAL;
> +	}

Does xfs_file_write_iter need a catch-all so that we don't fall back to
buffered write for a directio write that returns ENOTBLK?

	if (iocb->ki_flags & IOCB_DIRECT) {
		/*
		 * Allow a directio write to fall back to a buffered
		 * write *only* in the case that we're doing a reflink
		 * CoW.  In all other directio scenarios we do not
		 * allow an operation to fall back to buffered mode.
		 */
		ret = xfs_file_dio_write(iocb, from);
		if (ret != -ENOTBLK || (iocb->ki_flags & IOCB_ATOMIC))
			return ret;
	}

IIRC iomap_dio_rw can return ENOTBLK if pagecache invalidation fails for
the region that we're trying to directio write.

--D

> +
>  	/* direct I/O must be aligned to device logical sector size */
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>  		return -EINVAL;
> -- 
> 2.31.1
> 
> 

