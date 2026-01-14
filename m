Return-Path: <linux-fsdevel+bounces-73849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD6ED21B56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB158302AFBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F3333745;
	Wed, 14 Jan 2026 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipDz0e50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BF43AA4;
	Wed, 14 Jan 2026 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432050; cv=none; b=ev7uX7WCX6zKM2giHk7B+GEitGgyPgmygHRxMAOnXYsaXVPS+3cRm0+/wPBAWRRNyfZVqBsGDmjKB2j5wTv6d9wCSQ2cEv9ysVyqgAKgmOWsmmZe5RAkQO8ZuM08wmcUZZ8JzJJBH0LIfzoJNjNe/UG/fVO3OtmY3zM7np/J3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432050; c=relaxed/simple;
	bh=MmRMnONimKR3VDLK+nHIP/fZEo9OsD82HxQSy/6hNe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+ougOSVvN36mKaCMolmh5dJbIS8GKAKEMYp5ss17lEx6xu/dbYQwxrBmcnhAx8fps8LMat2Onpo+aMamBNJNVwgywVkwksY6Pc3hiUcDgNiSl4el1XQOFpjX1FwIKcZe7JZ8Cqht0x2vmWiO7qotZuuVxrJonMlxqYV08D1Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipDz0e50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF0C16AAE;
	Wed, 14 Jan 2026 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768432049;
	bh=MmRMnONimKR3VDLK+nHIP/fZEo9OsD82HxQSy/6hNe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipDz0e50AzttcrjDdJqj0KoQ/njzbR/g0MrrmyB3My1i+G0RYFMMPwzb5qJ+FYElM
	 KJv3F7U7r6al8qcBD5ZByl30Oc/Pkt/O21aHEZnlSPPPn+XSWSiuRU3gAZG7RAqGso
	 UKBSRbWUZ6XRLLxty+91N9pkE6TIEobs5/srMmpC3/ZBg7CCZ1kLFA+33u2fWdV/cV
	 lan83rlpI4KLPZ1AodqWXtRE0eRQp3tcxOKoSY+wJQB19jvMkavMW/HmouuszvTtel
	 A5UTKUoPaxtxlCQA50PXWnTRLkStoU9mlB8+gpKCRwBzxA5B8a15uofAxhwhAwzHou
	 V1EExXtn0GLbg==
Date: Wed, 14 Jan 2026 15:07:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: use bounce buffering direct I/O when the
 device requires stable pages
Message-ID: <20260114230728.GS15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-15-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:12AM +0100, Christoph Hellwig wrote:
> Fix direct I/O on devices that require stable pages by asking iomap
> to bounce buffer.  To support this, ioends are used for direct reads
> in this case to provide a user context for copying data back from the
> bounce buffer.
> 
> This fixes qemu when used on devices using T10 protection information
> and probably other cases like iSCSI using data digests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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

Now that I've gotten to the final patch, one thing strikes me as a
little strange -- we pass the iocb to iomap_dio_rw, which means that in
theory iomap could set IOMAP_DIO_BOUNCE for us, instead of XFS having to
do that on its own.

I think the only barrier to that is the little bit with
xfs_dio_read_bounce_submit_io where we have to kick the direct read
completion to a place where we can copy the bounce buffer contents to
the pages that the caller gave us in the iov_iter, right?

Directio already has a mechanism for doing completions from
s_dio_done_wq, so can't we reuse that?  Or is the gamble here that
things like btrfs might want to do something further with the bounce
buffer (like verifying checksums before copying to the caller's pages)
so we might as well make the fs responsible for setting IOMAP_DIO_BOUNCE
and taking control of the bio completion?

--D

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

