Return-Path: <linux-fsdevel+bounces-36543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F253D9E58FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2F5280DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8A321C190;
	Thu,  5 Dec 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XroGXx9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03074218853;
	Thu,  5 Dec 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410702; cv=none; b=goLR5EhodcIpYcSWsppeicai2tcCGlteILz0CfmTM1cmy6qsmqCQPVrtBEAlFxTcEIADFwfhVisWlyA+X7N2aFw/QQF9qDQRyMHwrv9LFpxn6eRi8NjEej4jTgpgCjnOxcpacxxKZAkNw+wLzjNl/rve7jVsKwiCII/yQkLlhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410702; c=relaxed/simple;
	bh=UqrgiOwKrQRuBt063enFRtDuN5GoS9kInSGmW2OytGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiFNaFpYmg6b7x1650A8E1vivwHjuZIIinfEJobSD45rUwak0k9o9nXJsqDJFi28iPG/JX26gEuwpLgOsSm0HSnWigg6sM12ALClKGzKBpz7J+R6AhUZBWFJdW7SxUcuJoX8kQNRrbL3dEqcZLX9T6FtALENDEUFUmDzivG2pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XroGXx9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1BDC4CEDC;
	Thu,  5 Dec 2024 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733410701;
	bh=UqrgiOwKrQRuBt063enFRtDuN5GoS9kInSGmW2OytGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XroGXx9leBpCCBGlKuPRd4D1Tpz+lkPE8qZnUFozqMMJQizV8cW3RB0pampPYHnvV
	 7RHv/u2vdQMR4Z7d1l2hu4RDIta5hJlCAMG+s5d271BtXv4bUDOq55GH4TudQtph4+
	 +FwztL2BmpwpduC/ce1rx5BeSxfGOzULslVciGnE4WkT7mBw/DgmuOB/Ri7zbTKClx
	 osXcaQ3ztJkvePrwLiq2iTFA1Ba8BGXu2+lLQEhPlAgPb0bKRaPRDhbvMNoAHiqLHn
	 eUPPJct4cbL9ALFcH/xnaNPNI5/xRP/Umh8wNCEmhcwWrs8O3J3AQk298GvPHv9/b/
	 XTzhUNipK/qYQ==
Date: Thu, 5 Dec 2024 15:58:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paulmck@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241205-kursgewinn-balsam-a3e8bfd1e7d4@brauner>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205120332.1578562-1-mjguzik@gmail.com>

On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> See the added commentary for reasoning.
> 
> ->resize_in_progress handling is moved inside of expand_fdtable() for
> clarity.
> 
> Whacks an actual fence on arm64.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> To my reading of commentary above synchronize_rcu() this works fine(tm)
> and there is even other code relying on the same idea (percpu rwsems
> (see percpu_down_read for example), maybe there is more).
> 
> However, given that barriers like to be tricky and I know about squat of
> RCU internals, I refer to Paul here.
> 
> Paul, does this work? If not, any trivial tweaks to make it so?
> 
> I mean smp_rmb looks dodgeable, at worst I made a mistake somewhere and
> the specific patch does not work.
> 
>  fs/file.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 019fb9acf91b..d065a24980da 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -233,28 +233,54 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
>  	__acquires(files->file_lock)
>  {
>  	struct fdtable *new_fdt, *cur_fdt;
> +	int err = 0;
>  
> +	BUG_ON(files->resize_in_progress);

I think this BUG_ON() here is a bit unnecessary.

> +	files->resize_in_progress = true;

Minor: Why move that into expand_fdtable()? Having
files->resize_in_progress in here doesn't add much more clarity than
just having it set around expand_fdtable() in the caller.

Leaving it there also makes the patch smaller and clearer to follow as
you neither need the additional err nor the goto.

>  	spin_unlock(&files->file_lock);
>  	new_fdt = alloc_fdtable(nr + 1);
>  
> -	/* make sure all fd_install() have seen resize_in_progress
> -	 * or have finished their rcu_read_lock_sched() section.
> +	/*
> +	 * Synchronize against the lockless fd_install().
> +	 *
> +	 * All work in that routine is enclosed with RCU sched section.
> +	 *
> +	 * We published ->resize_in_progress = true with the unlock above,
> +	 * which makes new arrivals bail to locked operation.
> +	 *
> +	 * Now we only need to wait for CPUs which did not observe the flag to
> +	 * leave and make sure their store to the fd table got published.
> +	 *
> +	 * We do it with synchronize_rcu(), which both waits for all sections to
> +	 * finish (taking care of the first part) and guarantees all CPUs issued a
> +	 * full fence (taking care of the second part).
> +	 *
> +	 * Note we know there is nobody to wait for if we are dealing with a
> +	 * single-threaded process.
>  	 */
>  	if (atomic_read(&files->count) > 1)
>  		synchronize_rcu();
>  
>  	spin_lock(&files->file_lock);
> -	if (IS_ERR(new_fdt))
> -		return PTR_ERR(new_fdt);
> +	if (IS_ERR(new_fdt)) {
> +		err = PTR_ERR(new_fdt);
> +		goto out;
> +	}
>  	cur_fdt = files_fdtable(files);
>  	BUG_ON(nr < cur_fdt->max_fds);
>  	copy_fdtable(new_fdt, cur_fdt);
>  	rcu_assign_pointer(files->fdt, new_fdt);
>  	if (cur_fdt != &files->fdtab)
>  		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
> -	/* coupled with smp_rmb() in fd_install() */
> +
> +	/*
> +	 * Publish everything before we unset ->resize_in_progress, see above
> +	 * for an explanation.
> +	 */
>  	smp_wmb();
> -	return 0;
> +out:
> +	files->resize_in_progress = false;
> +	return err;
>  }
>  
>  /*
> @@ -290,9 +316,7 @@ static int expand_files(struct files_struct *files, unsigned int nr)
>  		return -EMFILE;
>  
>  	/* All good, so we try */
> -	files->resize_in_progress = true;
>  	error = expand_fdtable(files, nr);
> -	files->resize_in_progress = false;
>  
>  	wake_up_all(&files->resize_wait);
>  	return error;
> @@ -629,13 +653,18 @@ EXPORT_SYMBOL(put_unused_fd);
>  
>  void fd_install(unsigned int fd, struct file *file)
>  {
> -	struct files_struct *files = current->files;
> +	struct files_struct *files;
>  	struct fdtable *fdt;
>  
>  	if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
>  		return;
>  
> +	/*
> +	 * Synchronized with expand_fdtable(), see that routine for an
> +	 * explanation.
> +	 */
>  	rcu_read_lock_sched();
> +	files = READ_ONCE(current->files);
>  
>  	if (unlikely(files->resize_in_progress)) {
>  		rcu_read_unlock_sched();
> @@ -646,8 +675,7 @@ void fd_install(unsigned int fd, struct file *file)
>  		spin_unlock(&files->file_lock);
>  		return;
>  	}
> -	/* coupled with smp_wmb() in expand_fdtable() */
> -	smp_rmb();
> +
>  	fdt = rcu_dereference_sched(files->fdt);
>  	BUG_ON(fdt->fd[fd] != NULL);
>  	rcu_assign_pointer(fdt->fd[fd], file);
> -- 
> 2.43.0
> 

