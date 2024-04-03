Return-Path: <linux-fsdevel+bounces-16010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C3896BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1544F1C20400
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40691136989;
	Wed,  3 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ2spcBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B7135405;
	Wed,  3 Apr 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138957; cv=none; b=XGI1ZuG+WQr8UaUHfTbf61fHtXluiAsa5szGG+Wt9IqA5dsvG3AUP7O18MWfjJ+wgIxcYjX7PxzIRyoJkiWYQ9HCrpGfuRJhKU5dGV9eUNwIsA1MGFurOTMvYNtXHghYtfNotYpDhggh7fUznjnzoQpWdG8pV1ArsAAWXHgTCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138957; c=relaxed/simple;
	bh=D7YcKRAyLmgecFCMGfV+qUbrqgrhgsh6evzf5fyLOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmOSBIbdawDw11B5CEv2pcR0aqk3iGgIigwL+t/KT9mjFfSn7WslBw7JWeAB6Azc3XZbH8+d0WuUCk6lyiHN1+m+P9IRAlEMucPs3G0IrwPN/BAFEPMY9uVCTwAyTybxdaPzZcUe4VxZhrGxMa8HatdvRL2d3THr3rNkRddRiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ2spcBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95FAC433F1;
	Wed,  3 Apr 2024 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712138957;
	bh=D7YcKRAyLmgecFCMGfV+qUbrqgrhgsh6evzf5fyLOEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ2spcBgRJ9cCviFtJP0QmImAnbdS+JnAtL4wfOC6ghXiZ4WZFw/PeivBhM4eAS6G
	 8Lht3xZ2oilNdCX84B0ShCgy26TM3ns1j0THOK1pyJ2hL/DIozrsHZS+P+AHkVEIv9
	 uIlqx47gRDkH7vwGkLTRoKGRXOyuWs+kfjAfdaJDDb+aDcoyjK+pJgjO3TlQ+7BKUK
	 6te/s/ciNPdF+y+YP+6Wjub5xoGtVzCUcYQkVbNCMKlkzTg7ikQm7lgVpgRMDxmGLR
	 bCVrv/QgXiD7I7vt51Df4d0g1Yd32hlVsTKUFTCBAwP0sddUTXnDh584gKrbjbdkw7
	 XidMBxWftvX5g==
Date: Wed, 3 Apr 2024 12:09:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Message-ID: <20240403-plant-narren-2bbfb61f19f0@brauner>
References: <20240402202524.1514963-1-axboe@kernel.dk>
 <20240402202524.1514963-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402202524.1514963-3-axboe@kernel.dk>

On Tue, Apr 02, 2024 at 02:18:22PM -0600, Jens Axboe wrote:
> Rather than use the older style ->read() hook, use ->read_iter() so that
> userfaultfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
> read attempts.
> 
> Split the fd setup into two parts, so that userfaultfd can mark the file
> mode with FMODE_NOWAIT before installing it into the process table. With
> that, we can also defer grabbing the mm until we know the rest will
> succeed, as the fd isn't visible before then.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/userfaultfd.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 60dcfafdc11a..7864c2dba858 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -282,7 +282,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  /*
>   * Verify the pagetables are still not ok after having reigstered into
>   * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
> - * userfault that has already been resolved, if userfaultfd_read and
> + * userfault that has already been resolved, if userfaultfd_read_iter and
>   * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
>   * threads.
>   */
> @@ -1177,34 +1177,34 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
>  	return ret;
>  }
>  
> -static ssize_t userfaultfd_read(struct file *file, char __user *buf,
> -				size_t count, loff_t *ppos)
> +static ssize_t userfaultfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct file *file = iocb->ki_filp;
>  	struct userfaultfd_ctx *ctx = file->private_data;
>  	ssize_t _ret, ret = 0;
>  	struct uffd_msg msg;
> -	int no_wait = file->f_flags & O_NONBLOCK;
>  	struct inode *inode = file_inode(file);
> +	bool no_wait;
>  
>  	if (!userfaultfd_is_initialized(ctx))
>  		return -EINVAL;
>  
> +	no_wait = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
>  	for (;;) {
> -		if (count < sizeof(msg))
> +		if (iov_iter_count(to) < sizeof(msg))
>  			return ret ? ret : -EINVAL;
>  		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
>  		if (_ret < 0)
>  			return ret ? ret : _ret;
> -		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
> +		_ret = copy_to_iter(&msg, sizeof(msg), to);
> +		if (_ret < 0)
>  			return ret ? ret : -EFAULT;
>  		ret += sizeof(msg);
> -		buf += sizeof(msg);
> -		count -= sizeof(msg);
>  		/*
>  		 * Allow to read more than one fault at time but only
>  		 * block if waiting for the very first one.
>  		 */
> -		no_wait = O_NONBLOCK;
> +		no_wait = true;
>  	}
>  }
>  
> @@ -2172,7 +2172,7 @@ static const struct file_operations userfaultfd_fops = {
>  #endif
>  	.release	= userfaultfd_release,
>  	.poll		= userfaultfd_poll,
> -	.read		= userfaultfd_read,
> +	.read_iter	= userfaultfd_read_iter,
>  	.unlocked_ioctl = userfaultfd_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  	.llseek		= noop_llseek,
> @@ -2192,6 +2192,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  static int new_userfaultfd(int flags)
>  {
>  	struct userfaultfd_ctx *ctx;
> +	struct file *file;
>  	int fd;
>  
>  	BUG_ON(!current->mm);
> @@ -2215,16 +2216,25 @@ static int new_userfaultfd(int flags)
>  	init_rwsem(&ctx->map_changing_lock);
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
> -	/* prevent the mm struct to be freed */
> -	mmgrab(ctx->mm);
> +
> +	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
> +	if (fd < 0)
> +		goto err_out;
>  
>  	/* Create a new inode so that the LSM can block the creation.  */
> -	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
> +	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
>  			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> -	if (fd < 0) {
> -		mmdrop(ctx->mm);
> -		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> +	if (IS_ERR(file)) {
> +		fd = PTR_ERR(file);
> +		goto err_out;

You're leaking the fd you allocated above.

>  	}
> +	/* prevent the mm struct to be freed */
> +	mmgrab(ctx->mm);
> +	file->f_mode |= FMODE_NOWAIT;
> +	fd_install(fd, file);
> +	return fd;
> +err_out:
> +	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
>  	return fd;
>  }
>  
> -- 
> 2.43.0
> 

