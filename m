Return-Path: <linux-fsdevel+bounces-69773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B494EC84B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B73C4E2358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF93115A2;
	Tue, 25 Nov 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCAYtl3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6A2E0B5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069860; cv=none; b=E5lTcet/CmhMsjzlABkyEfIFBJd4WQK4hxejhqddOgfXxyqutFfcsJtgAOIn4xG7E/S8PB0g4nCyEC0HB8MiCKZ0BZnwRpvhAmHOHezchmeHo/ASidZzYtEPrBsLzlvNyRcyTv7ortz1PVbLDlx03OgZ+B9n+s8NLc2rHvLRN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069860; c=relaxed/simple;
	bh=gEJigKKjf8bYe1/1N8CiBYGCZdirY3CuVneJaRXhXhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSZ9qp2MWolAaRYH3pD5ntsSu/S4C/WiodZy+juHA09lJl459/fo9aHy5XgQr7rZldaV+d1UrVkCdF3PS0GB/bQi/z5BG5ADeCq01u5P5omuaXZz/I5Fl2xQ9QIuXJ8ms0kEWOBx2BmwEkLnBHyisuFqFJlhwyyI7Hr8pUrE+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCAYtl3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F265EC4CEF1;
	Tue, 25 Nov 2025 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069859;
	bh=gEJigKKjf8bYe1/1N8CiBYGCZdirY3CuVneJaRXhXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCAYtl3g4qSYrRx2IyI0B4SXB022m/S//hxFn0uVB/nCcq9l6ZYyASvWuQzYg7Hgi
	 LVOqmrWZOa+Q7QWpAmKcLAqK29QzvQhJ7+eNgiXnkVCskIBEa+otxd5Vs/Mmugi6bW
	 0cb/24/1p0XnP9tYfKLJFolJthMyXxvdSFTJEo4Y4msVGMTfoIRi3sdLc2c5iTQ+Vp
	 AuWta/dh4qO8hTg/PA4SIloF5O4hVLji4ThFaavHiKHYkkQIXzC1QC5pgh2jFiVFcQ
	 pnBsEipYWUuYuy6AubSe5ZHqxJGT/k07+epRFRlEa/9IJXHIQsB73/Wyn2hppySo0e
	 BDBA5fIyNT1LA==
Date: Tue, 25 Nov 2025 13:24:13 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 16/47] userfaultfd: convert new_userfaultfd() to
 FD_PREPARE()
Message-ID: <aSWR3RfQIloxGwoJ@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-16-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-16-b6efa1706cfd@kernel.org>

On Sun, Nov 23, 2025 at 05:33:34PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 54c6cc7fe9c6..e6e74b384087 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2111,9 +2111,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  
>  static int new_userfaultfd(int flags)
>  {
> -	struct userfaultfd_ctx *ctx;
> -	struct file *file;
> -	int fd;
> +	struct userfaultfd_ctx *ctx __free(kfree) = NULL;
>  
>  	VM_WARN_ON_ONCE(!current->mm);
>  
> @@ -2135,26 +2133,18 @@ static int new_userfaultfd(int flags)
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
>  
> -	fd = get_unused_fd_flags(flags & UFFD_SHARED_FCNTL_FLAGS);
> -	if (fd < 0)
> -		goto err_out;
> +	FD_PREPARE(fdf, flags & UFFD_SHARED_FCNTL_FLAGS,
> +		   anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
> +					     O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS),
> +					     NULL));
> +	if (fdf.err)
> +		return fdf.err;
>  
> -	/* Create a new inode so that the LSM can block the creation.  */
> -	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
> -			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> -	if (IS_ERR(file)) {
> -		put_unused_fd(fd);
> -		fd = PTR_ERR(file);
> -		goto err_out;
> -	}
>  	/* prevent the mm struct to be freed */
>  	mmgrab(ctx->mm);
> -	file->f_mode |= FMODE_NOWAIT;
> -	fd_install(fd, file);
> -	return fd;
> -err_out:
> -	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> -	return fd;
> +	fd_prepare_file(fdf)->f_mode |= FMODE_NOWAIT;
> +	retain_and_null_ptr(ctx);
> +	return fd_publish(fdf);
>  }
>  
>  static inline bool userfaultfd_syscall_allowed(int flags)
> 
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

