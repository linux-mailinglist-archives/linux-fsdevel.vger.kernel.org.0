Return-Path: <linux-fsdevel+bounces-29599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE797B50E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DA11C22D7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29F185953;
	Tue, 17 Sep 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/lPpMuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24339762E0;
	Tue, 17 Sep 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607660; cv=none; b=I9Hx3q2eQ0edPKMITy6NXW/rG7B3c8txBvyCEv5VfW9YhHmqudnpaM4jp3eHNmaGK+9OSxpoiYlKnn7XaXIspNQGeyGJsZbxJ7WUQR4ii3wf0cRGvg9iz8UjEl3gcopFchtogZqYdBgDDbm9VlGaepKOEQLikVNi8uRke97R5O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607660; c=relaxed/simple;
	bh=8P63ar+vDTXf5ivxQ/vJ2sKq85OTabVrl8wJoceTiLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXol+mhZesSXrbyxlaJbgbE7+1h8IbOaONH4jERkDxr/6Sb92nymL/qdOt4o3mE+S2e38hIwPQGPbn8Dl5nl16Qe+zhVuN3rZ6/v9CQ2/1nc0KYaca280FF1TYNlfI6JPUEJVqhnvB6xysosB8x3LS1EJKAl3GWVD9b/I6lKSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/lPpMuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4746C4CEC5;
	Tue, 17 Sep 2024 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726607659;
	bh=8P63ar+vDTXf5ivxQ/vJ2sKq85OTabVrl8wJoceTiLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/lPpMuN6t1lPgDK8TYx7F1yhWn3Er3ps7fTJCzx23TyuR372cauTJUtOviLMym/9
	 1yrN2f0dnc2f/M2cmYI0zgr201cJnEyPoQ6X56cYFjzeHHRarAC++ZfrdMfqNVSQFA
	 l/t2Ui0NpnGVNHADd0I8NmFlNM+XC4M3uBOLmyde6Kyj45qwk9s14xw1vaH6Bq3OGm
	 6SCT2OnhL1/ql2kTR2MvK+bOiRQ8XMJXy2+HP63fX4/Uamc5BI/L7COQ54JHHj2Q6e
	 W1l4PXvNYfF52aemoacWCJPmj2PwwdORNOy6EvQ7nvyfYchH+7vcSgg5lhqglOzBex
	 Qh9MVQ9ipVg+A==
Date: Tue, 17 Sep 2024 14:14:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: factor out a xfs_file_write_zero_eof helper
Message-ID: <20240917211419.GC182177@frogsfrogsfrogs>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910043949.3481298-7-hch@lst.de>

On Tue, Sep 10, 2024 at 07:39:08AM +0300, Christoph Hellwig wrote:
> Split a helper from xfs_file_write_checks that just deal with the
> post-EOF zeroing to keep the code readable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 133 ++++++++++++++++++++++++++--------------------
>  1 file changed, 75 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 0d258c21b9897f..a30fda1985e6af 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -347,10 +347,70 @@ xfs_file_splice_read(
>  	return ret;
>  }
>  
> +static ssize_t
> +xfs_file_write_zero_eof(
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from,
> +	unsigned int		*iolock,
> +	size_t			count,
> +	bool			*drained_dio)
> +{
> +	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	loff_t			isize;
> +
> +	/*
> +	 * We need to serialise against EOF updates that occur in IO completions
> +	 * here. We want to make sure that nobody is changing the size while
> +	 * we do this check until we have placed an IO barrier (i.e. hold
> +	 * XFS_IOLOCK_EXCL) that prevents new IO from being dispatched.  The
> +	 * spinlock effectively forms a memory barrier once we have
> +	 * XFS_IOLOCK_EXCL so we are guaranteed to see the latest EOF value and
> +	 * hence be able to correctly determine if we need to run zeroing.
> +	 */
> +	spin_lock(&ip->i_flags_lock);
> +	isize = i_size_read(VFS_I(ip));
> +	if (iocb->ki_pos <= isize) {
> +		spin_unlock(&ip->i_flags_lock);
> +		return 0;
> +	}
> +	spin_unlock(&ip->i_flags_lock);
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EAGAIN;
> +
> +	if (!*drained_dio) {
> +		/*
> +		 * If zeroing is needed and we are currently holding the iolock
> +		 * shared, we need to update it to exclusive which implies
> +		 * having to redo all checks before.
> +		 */
> +		if (*iolock == XFS_IOLOCK_SHARED) {
> +			xfs_iunlock(ip, *iolock);
> +			*iolock = XFS_IOLOCK_EXCL;
> +			xfs_ilock(ip, *iolock);
> +			iov_iter_reexpand(from, count);
> +		}
> +
> +		/*
> +		 * We now have an IO submission barrier in place, but AIO can do
> +		 * EOF updates during IO completion and hence we now need to
> +		 * wait for all of them to drain.  Non-AIO DIO will have drained
> +		 * before we are given the XFS_IOLOCK_EXCL, and so for most
> +		 * cases this wait is a no-op.
> +		 */
> +		inode_dio_wait(VFS_I(ip));
> +		*drained_dio = true;
> +		return 1;

I gotta say, I'm not a big fan of the "return 1 to loop again" behavior.
Can you add a comment at the top stating that this is a possible return
value and why it gets returned?

--D

> +	}
> +
> +	trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
> +	return xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
> +}
> +
>  /*
>   * Common pre-write limit and setup checks.
>   *
> - * Called with the iolocked held either shared and exclusive according to
> + * Called with the iolock held either shared and exclusive according to
>   * @iolock, and returns with it held.  Might upgrade the iolock to exclusive
>   * if called for a direct write beyond i_size.
>   */
> @@ -360,13 +420,10 @@ xfs_file_write_checks(
>  	struct iov_iter		*from,
>  	unsigned int		*iolock)
>  {
> -	struct file		*file = iocb->ki_filp;
> -	struct inode		*inode = file->f_mapping->host;
> -	struct xfs_inode	*ip = XFS_I(inode);
> -	ssize_t			error = 0;
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
>  	size_t			count = iov_iter_count(from);
>  	bool			drained_dio = false;
> -	loff_t			isize;
> +	ssize_t			error;
>  
>  restart:
>  	error = generic_write_checks(iocb, from);
> @@ -389,7 +446,7 @@ xfs_file_write_checks(
>  	 * exclusively.
>  	 */
>  	if (*iolock == XFS_IOLOCK_SHARED && !IS_NOSEC(inode)) {
> -		xfs_iunlock(ip, *iolock);
> +		xfs_iunlock(XFS_I(inode), *iolock);
>  		*iolock = XFS_IOLOCK_EXCL;
>  		error = xfs_ilock_iocb(iocb, *iolock);
>  		if (error) {
> @@ -400,64 +457,24 @@ xfs_file_write_checks(
>  	}
>  
>  	/*
> -	 * If the offset is beyond the size of the file, we need to zero any
> +	 * If the offset is beyond the size of the file, we need to zero all
>  	 * blocks that fall between the existing EOF and the start of this
> -	 * write.  If zeroing is needed and we are currently holding the iolock
> -	 * shared, we need to update it to exclusive which implies having to
> -	 * redo all checks before.
> -	 *
> -	 * We need to serialise against EOF updates that occur in IO completions
> -	 * here. We want to make sure that nobody is changing the size while we
> -	 * do this check until we have placed an IO barrier (i.e.  hold the
> -	 * XFS_IOLOCK_EXCL) that prevents new IO from being dispatched.  The
> -	 * spinlock effectively forms a memory barrier once we have the
> -	 * XFS_IOLOCK_EXCL so we are guaranteed to see the latest EOF value and
> -	 * hence be able to correctly determine if we need to run zeroing.
> +	 * write.
>  	 *
> -	 * We can do an unlocked check here safely as IO completion can only
> -	 * extend EOF. Truncate is locked out at this point, so the EOF can
> -	 * not move backwards, only forwards. Hence we only need to take the
> -	 * slow path and spin locks when we are at or beyond the current EOF.
> +	 * We can do an unlocked check for i_size here safely as I/O completion
> +	 * can only extend EOF.  Truncate is locked out at this point, so the
> +	 * EOF can not move backwards, only forwards. Hence we only need to take
> +	 * the slow path when we are at or beyond the current EOF.
>  	 */
> -	if (iocb->ki_pos <= i_size_read(inode))
> -		goto out;
> -
> -	spin_lock(&ip->i_flags_lock);
> -	isize = i_size_read(inode);
> -	if (iocb->ki_pos > isize) {
> -		spin_unlock(&ip->i_flags_lock);
> -
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> -			return -EAGAIN;
> -
> -		if (!drained_dio) {
> -			if (*iolock == XFS_IOLOCK_SHARED) {
> -				xfs_iunlock(ip, *iolock);
> -				*iolock = XFS_IOLOCK_EXCL;
> -				xfs_ilock(ip, *iolock);
> -				iov_iter_reexpand(from, count);
> -			}
> -			/*
> -			 * We now have an IO submission barrier in place, but
> -			 * AIO can do EOF updates during IO completion and hence
> -			 * we now need to wait for all of them to drain. Non-AIO
> -			 * DIO will have drained before we are given the
> -			 * XFS_IOLOCK_EXCL, and so for most cases this wait is a
> -			 * no-op.
> -			 */
> -			inode_dio_wait(inode);
> -			drained_dio = true;
> +	if (iocb->ki_pos > i_size_read(inode)) {
> +		error = xfs_file_write_zero_eof(iocb, from, iolock, count,
> +				&drained_dio);
> +		if (error == 1)
>  			goto restart;
> -		}
> -
> -		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
> -		error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
>  		if (error)
>  			return error;
> -	} else
> -		spin_unlock(&ip->i_flags_lock);
> +	}
>  
> -out:
>  	return kiocb_modified(iocb);
>  }
>  
> -- 
> 2.45.2
> 
> 

