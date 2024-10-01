Return-Path: <linux-fsdevel+bounces-30513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD598C09E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF65D285558
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F11C9B84;
	Tue,  1 Oct 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knVZFeXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA2645;
	Tue,  1 Oct 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794133; cv=none; b=WHT0pufoE9LkPmo61IIVQrmWZZWVsTGsZLPeP/K6LkxzTJN2/gw3lxO1hP7pkJ05YdAWc3SAsejSZcSQRQNHLDDN6puNnoGCY6+2F+S+2hRTTfyYBZRPywtcLVMVvgbQ8G5MDn0l3Dd2UDE3+RFcgqMBrxTBhUfLv2QFSBqPqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794133; c=relaxed/simple;
	bh=EAv1lrQVcymYc99WOIdzGZa/Io0fq6ARfqrObpJAVZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPWWGZxzmfEbS1QOXwHU+tk0kZ13aPGRK+1l2B4GTM6qtjTSpbnmE33iVXEfJXQTI1WuOb/9+mLKvP+AT8mTjItorGwyReTZb8u7uwaJ7ohkCIMGLQIVjqv45LcaR1ipkkjtcEVEGZUY3a89XnHpsgyeBmcVPpHyRZbFM+7xXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knVZFeXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC4C4CEC6;
	Tue,  1 Oct 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794132;
	bh=EAv1lrQVcymYc99WOIdzGZa/Io0fq6ARfqrObpJAVZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knVZFeXJi83A5T9sFZDsYDEoxj2yoqGO4W1B9/shd81sw/ifOXt/9HuXc3PuB1DcS
	 p6exPzv+8Ltt4Vy8hkEhBOa/A6XprtCp1Lmq/nYobA4+7XNsKzgHAtEbUCvB5/B6jn
	 9IvjPSCq56NZsOQcTAcydOi8whSkUZXh9Zpk71ijW/1WjAQSq7QxnOyt0qj3pUM9hD
	 I1rNYwkkx0CcZ4Qz6eqbh5yB5eDgmgyN4RsrUjYGIv4fAuu9f7p5prQkaKkmJsfUkU
	 KtWY5cvs9CwCbQWXHi6RKyIB29/HJYYMCl91nVpJpIHKzCB1uqFnI5UtFkOagCc5sK
	 FqtWo/VLfVLqg==
Date: Tue, 1 Oct 2024 07:48:51 -0700
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
Message-ID: <20241001144851.GW21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-7-john.g.garry@oracle.com>
 <20240930164116.GP21853@frogsfrogsfrogs>
 <7fa598f5-3920-4b13-9d15-49337688713f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa598f5-3920-4b13-9d15-49337688713f@oracle.com>

On Tue, Oct 01, 2024 at 02:22:23PM +0100, John Garry wrote:
> On 30/09/2024 17:41, Darrick J. Wong wrote:
> > On Mon, Sep 30, 2024 at 12:54:37PM +0000, John Garry wrote:
> > > Validate that an atomic write adheres to length/offset rules. Currently
> > > we can only write a single FS block.
> > > 
> > > For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
> > > FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
> > > ATOMICWRITES flags would also need to be set for the inode.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 412b1d71b52b..fa6a44b88ecc 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -688,6 +688,13 @@ xfs_file_dio_write(
> > >   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
> > >   	size_t			count = iov_iter_count(from);
> > > +	if (iocb->ki_flags & IOCB_ATOMIC) {
> > > +		if (count != ip->i_mount->m_sb.sb_blocksize)
> > > +			return -EINVAL;
> > > +		if (!generic_atomic_write_valid(iocb, from))
> > > +			return -EINVAL;
> > > +	}
> > 
> > Does xfs_file_write_iter need a catch-all so that we don't fall back to
> > buffered write for a directio write that returns ENOTBLK?
> > 
> > 	if (iocb->ki_flags & IOCB_DIRECT) {
> > 		/*
> > 		 * Allow a directio write to fall back to a buffered
> > 		 * write *only* in the case that we're doing a reflink
> > 		 * CoW.  In all other directio scenarios we do not
> > 		 * allow an operation to fall back to buffered mode.
> > 		 */
> > 		ret = xfs_file_dio_write(iocb, from);
> > 		if (ret != -ENOTBLK || (iocb->ki_flags & IOCB_ATOMIC))
> > 			return ret;
> > 	}
> > 
> > IIRC iomap_dio_rw can return ENOTBLK if pagecache invalidation fails for
> > the region that we're trying to directio write.
> 
> I see where you are talking about. There is also a ENOTBLK from unaligned
> write for CoW, but we would not see that.
> 
> But I was thinking to use a common helper to catch this, like
> generic_write_checks_count() [which is called on the buffered IO path]:
> 
> ----8<-----
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 32b476bf9be0..222f25c6439c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1774,6 +1774,10 @@ int generic_write_checks_count(struct kiocb *iocb,
> loff_t *count)
>  	if (!*count)
>  		return 0;
> 
> +	if (iocb->ki_flags & IOCB_ATOMIC &&
> +	    !(iocb->ki_flags & IOCB_DIRECT))
> +		return -EINVAL;
> +
>  	if (iocb->ki_flags & IOCB_APPEND)
>  		iocb->ki_pos = i_size_read(inode);
> 
> ---->8-----
> 
> But we keep the IOCB_DIRECT flag for the buffered IO fallback (so no good).
> 
> Another option would be:
> 
> ----8<-----
> 
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -679,7 +679,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter
> *iter,
>  			if (ret != -EAGAIN) {
>  				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
>  								iomi.len);
> -				ret = -ENOTBLK;
> +				if (iocb->ki_flags & IOCB_ATOMIC) {
> +					if (ret == -ENOTBLK)
> +						ret = -EAGAIN;

I don't follow the logic here -- all the error codes except for EAGAIN
are squashed into ENOTBLK, so why would we let them through for an
atomic write?

	if (ret != -EAGAIN) {
		trace_iomap_dio_invalidate_fail(inode, iomi.pos,
						iomi.len);

		if (iocb->ki_flags & IOCB_ATOMIC) {
			/*
			 * folio invalidation failed, maybe this is
			 * transient, unlock and see if the caller
			 * tries again
			 */
			return -EAGAIN;
		} else {
			/* fall back to buffered write */
			return -ENOTBLK;
		}
	}

--D

> +				}else {
> +					ret = -ENOTBLK;
> +				}
>  			}
>  			goto out_free_dio;
>  		}
> ---->8-----
> 
> I suggest that, as other FSes (like ext4) handle -ENOTBLK and would need to
> be changed similar to XFS. But I am not sure if changing the error code from
> -ENOTBLK for IOCB_ATOMIC is ok.
> 
> Let me know what you think about possible alternative solutions.
> 
> Thanks,
> John
> 

