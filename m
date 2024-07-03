Return-Path: <linux-fsdevel+bounces-23039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAB92637E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BC7B24041
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F617B4E0;
	Wed,  3 Jul 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiQH8xQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C576173339;
	Wed,  3 Jul 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017296; cv=none; b=X1OfqjQn4X5pg8jSSCWRwT9Fny2nXiY3MgnNUd72OahzsEdSm7v6kjbzHf1R0cdR/k1sNqWH9pNMV+NgrVl7M5eE6v807TkKXwtdV9INNQ695E1pPZXn9RvXiVxnBVUqE50HhWRqAmLsbZzUExW032ks/NlA4Hb5XHP/DntxWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017296; c=relaxed/simple;
	bh=danotnRKesFCKkZY2EXb3ZHi5zeeS6hT/AIJoxLeFpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBTIOctvRQWRTXfoV0ml5NYB4HiSY+Q0VS0GO/TwDgRD8dpjZAJBLF4A6GWApsheFPSk3cQDJv92Kdweg2btMgVWYBfpRNUXoATiN7fonh3rYFJlq0slt7OcePy8KSrJYAyh0hWV/IqAQh6gJ6SbfOEDlE4yJrjzT6A/pR9b/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiQH8xQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC6C2BD10;
	Wed,  3 Jul 2024 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720017296;
	bh=danotnRKesFCKkZY2EXb3ZHi5zeeS6hT/AIJoxLeFpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiQH8xQ/BQLiiBHlSGRzFcZ5FH19iX4IK/7/p5kSDkITPsE77NNOAwDYhqvwH3nA3
	 m6TvQdvM0hg9p/wxTqtN0QikfpspckRk3IbHsi0wPkeLqC2NIFztB12KYv4SGWdtyh
	 dPXJIkrQLloE2o6aXcR1U/bb5D/iokG6ixfq0qsD4Uddj20WYM5eLCv/q9DzeJ9vDJ
	 X5tQKo/wi/krwXgj3BJauUXPGLdc8kfKcH5lkw6Y8Z7ZZGHi7l8GjOh0QxiPkC8WMV
	 3Ftw8ekdpHSgD+OOlNu5cUhPr8NFwm/usyVcpS3Pt2PCKJpBlYSQBHgNz+8tF2w4Zr
	 jJs0jZwIrlKAg==
Date: Wed, 3 Jul 2024 16:34:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, mjguzik@gmail.com, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240703-ketchup-aufteilen-3e4c648b20c8@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-2-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703143311.2184454-2-yu.ma@intel.com>

On Wed, Jul 03, 2024 at 10:33:09AM GMT, Yu Ma wrote:
> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> allocated fd is NULL. Remove this sanity check since it can be assured by
> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
> likely/unlikely and expand_file() call avoidance to reduce the work under
> file_lock.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..5178b246e54b 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (fd < files->next_fd)
>  		fd = files->next_fd;
>  
> -	if (fd < fdt->max_fds)
> +	if (likely(fd < fdt->max_fds))
>  		fd = find_next_fd(fdt, fd);
>  
> +	error = -EMFILE;
> +	if (unlikely(fd >= fdt->max_fds)) {
> +		error = expand_files(files, fd);
> +		if (error < 0)
> +			goto out;
> +		/*
> +		 * If we needed to expand the fs array we
> +		 * might have blocked - try again.
> +		 */
> +		if (error)
> +			goto repeat;
> +	}

So this ends up removing the expand_files() above the fd >= end check
which means that you can end up expanding the files_struct even though
the request fd is past the provided end. That seems odd. What's the
reason for that reordering?

> +
>  	/*
>  	 * N.B. For clone tasks sharing a files structure, this test
>  	 * will limit the total number of files that can be opened.
>  	 */
> -	error = -EMFILE;
> -	if (fd >= end)
> -		goto out;
> -
> -	error = expand_files(files, fd);
> -	if (error < 0)
> +	if (unlikely(fd >= end))
>  		goto out;
>  
> -	/*
> -	 * If we needed to expand the fs array we
> -	 * might have blocked - try again.
> -	 */
> -	if (error)
> -		goto repeat;
> -
>  	if (start <= files->next_fd)
>  		files->next_fd = fd + 1;
>  
> @@ -546,13 +547,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	else
>  		__clear_close_on_exec(fd, fdt);
>  	error = fd;
> -#if 1
> -	/* Sanity check */
> -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> -		rcu_assign_pointer(fdt->fd[fd], NULL);
> -	}
> -#endif
>  
>  out:
>  	spin_unlock(&files->file_lock);
> @@ -618,7 +612,7 @@ void fd_install(unsigned int fd, struct file *file)
>  		rcu_read_unlock_sched();
>  		spin_lock(&files->file_lock);
>  		fdt = files_fdtable(files);
> -		BUG_ON(fdt->fd[fd] != NULL);
> +		WARN_ON(fdt->fd[fd] != NULL);
>  		rcu_assign_pointer(fdt->fd[fd], file);
>  		spin_unlock(&files->file_lock);
>  		return;
> -- 
> 2.43.0
> 

