Return-Path: <linux-fsdevel+bounces-40711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010CA26F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F1F1887CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984320AF72;
	Tue,  4 Feb 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnLkkpC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9A20125D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665798; cv=none; b=jyp9YMgfzu49kgpltel083n5PkndQYcRgywJ2Rrk1b39dV7TwJ3dgRKPQPX7YcoA7074msKHADR8ihgz6IdlZkkzQOvmokI+cnQ7qG59+hiQ0KJZY9buysGxoVgMymHq66JPzQrcvTW3B2+EdR4oAmSSJFhrZSbAYLDru2i+SK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665798; c=relaxed/simple;
	bh=UpVbAl7P1Ua0K442GKMlHj/+68phudtF935ZTmKbB9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlwZdYdYGkcfwBnMR/5xI3Zzhs9n77pvtLjy7ZnroY9q+3rK2Job9UnMnCheKcfsStfEP5xN4+xtaBcc+v8cBR3dvQJQGEVYdmPVhtkG9heeyGSSVI6lZhAo2aQtKp9VceAfU9KfHEx1+115xwuCXwRTwqFBtd/9nWM19VZ+Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnLkkpC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FBCC4CEDF;
	Tue,  4 Feb 2025 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738665796;
	bh=UpVbAl7P1Ua0K442GKMlHj/+68phudtF935ZTmKbB9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnLkkpC7oFEoVAfYT9Izm5X8fImNxi0CzPQIqkN5kRwrzQjX7ahmMNIoh1Xk4Zy17
	 gNuqhDEuK+XPF3sPRYS46WbPhRm6FJJLC48nTegLgksrd535KRwIhweV6NaQ3OUIiT
	 SroYxZ50rzRiUorfJJvRi+lSB2Cqp/qUC9dDMvxjBhYCiiH51r8kD9w+QOUhkRYRTL
	 f/nsMpIs+TP5+fD/FOygMwP2WcoPys4pXJMhO+F8F2QCW6S8252vJzmR6pMBDq8f2N
	 IBZ5qdnw37a6ZmZJogJvpQjykGaXo9fwiNQETteCSMVXNA7SYsMLPXvW2i3lT7ihwn
	 k+VbsA6CFHUYA==
Date: Tue, 4 Feb 2025 11:43:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Alex Williamson <alex.williamson@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fsnotify: use accessor to set FMODE_NONOTIFY_*
Message-ID: <20250204-drehleiter-kehlkopf-ebfb51587558@brauner>
References: <20250203223205.861346-1-amir73il@gmail.com>
 <20250203223205.861346-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203223205.861346-2-amir73il@gmail.com>

On Mon, Feb 03, 2025 at 11:32:03PM +0100, Amir Goldstein wrote:
> The FMODE_NONOTIFY_* bits are a 2-bits mode.  Open coding manipulation
> of those bits is risky.  Use an accessor file_set_fsnotify_mode() to
> set the mode.
> 
> Rename file_set_fsnotify_mode() => file_set_fsnotify_mode_from_watchers()
> to make way for the simple accessor name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  drivers/tty/pty.c        |  2 +-
>  fs/notify/fsnotify.c     | 18 ++++++++++++------
>  fs/open.c                |  7 ++++---
>  include/linux/fs.h       |  9 ++++++++-
>  include/linux/fsnotify.h |  4 ++--
>  5 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index df08f13052ff4..8bb1a01fef2a1 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -798,7 +798,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
>  	nonseekable_open(inode, filp);
>  
>  	/* We refuse fsnotify events on ptmx, since it's a shared resource */
> -	filp->f_mode |= FMODE_NONOTIFY;
> +	file_set_fsnotify_mode(filp, FMODE_NONOTIFY);
>  
>  	retval = tty_alloc_file(filp);
>  	if (retval)
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8ee495a58d0ad..77a1521335a10 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(fsnotify);
>   * Later, fsnotify permission hooks do not check if there are permission event
>   * watches, but that there were permission event watches at open time.
>   */
> -void file_set_fsnotify_mode(struct file *file)
> +void file_set_fsnotify_mode_from_watchers(struct file *file)
>  {
>  	struct dentry *dentry = file->f_path.dentry, *parent;
>  	struct super_block *sb = dentry->d_sb;
> @@ -665,7 +665,7 @@ void file_set_fsnotify_mode(struct file *file)
>  	 */
>  	if (likely(!fsnotify_sb_has_priority_watchers(sb,
>  						FSNOTIFY_PRIO_CONTENT))) {
> -		file->f_mode |= FMODE_NONOTIFY_PERM;
> +		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
>  		return;
>  	}
>  
> @@ -676,7 +676,7 @@ void file_set_fsnotify_mode(struct file *file)
>  	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
>  	    likely(!fsnotify_sb_has_priority_watchers(sb,
>  						FSNOTIFY_PRIO_PRE_CONTENT))) {
> -		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +		file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
>  		return;
>  	}
>  
> @@ -686,19 +686,25 @@ void file_set_fsnotify_mode(struct file *file)
>  	 */
>  	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
>  	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> -				     FSNOTIFY_PRE_CONTENT_EVENTS)))
> +				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
> +		/* Enable pre-content events */
> +		file_set_fsnotify_mode(file, 0);
>  		return;
> +	}
>  
>  	/* Is parent watching for pre-content events on this file? */
>  	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
>  		parent = dget_parent(dentry);
>  		p_mask = fsnotify_inode_watches_children(d_inode(parent));
>  		dput(parent);
> -		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)
> +		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
> +			/* Enable pre-content events */
> +			file_set_fsnotify_mode(file, 0);
>  			return;
> +		}
>  	}
>  	/* Nobody watching for pre-content events from this file */
> -	file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +	file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
>  }
>  #endif
>  
> diff --git a/fs/open.c b/fs/open.c
> index 932e5a6de63bb..3fcbfff8aede8 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -905,7 +905,8 @@ static int do_dentry_open(struct file *f,
>  	f->f_sb_err = file_sample_sb_err(f);
>  
>  	if (unlikely(f->f_flags & O_PATH)) {
> -		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
> +		f->f_mode = FMODE_PATH | FMODE_OPENED;
> +		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
>  		f->f_op = &empty_fops;
>  		return 0;
>  	}
> @@ -938,7 +939,7 @@ static int do_dentry_open(struct file *f,
>  	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
>  	 * change anything.
>  	 */
> -	file_set_fsnotify_mode(f);
> +	file_set_fsnotify_mode_from_watchers(f);
>  	error = fsnotify_open_perm(f);
>  	if (error)
>  		goto cleanup_all;
> @@ -1122,7 +1123,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
>  	if (!IS_ERR(f)) {
>  		int error;
>  
> -		f->f_mode |= FMODE_NONOTIFY;
> +		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
>  		error = vfs_open(path, f);
>  		if (error) {
>  			fput(f);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f7..e73d9b998780d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -206,6 +206,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>   * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
>   * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
>   */
> +#define FMODE_NONOTIFY_HSM \
> +	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)

After this patch series this define is used exactly twice and it's
currently identical to FMODE_FSNOTIFY_HSM. I suggest to remove it and
simply pass FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the two places it's
used. I can do this myself though so if Jan doesn't have other comments
don't bother resending.

>  #define FMODE_FSNOTIFY_MASK \
>  	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
>  
> @@ -222,7 +224,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_FSNOTIFY_HSM(mode)	0
>  #endif
>  
> -
>  /*
>   * Attribute flags.  These should be or-ed together to figure out what
>   * has been changed!
> @@ -3140,6 +3141,12 @@ static inline void exe_file_allow_write_access(struct file *exe_file)
>  	allow_write_access(exe_file);
>  }
>  
> +static inline void file_set_fsnotify_mode(struct file *file, fmode_t mode)
> +{
> +	file->f_mode &= ~FMODE_FSNOTIFY_MASK;
> +	file->f_mode |= mode;
> +}
> +
>  static inline bool inode_is_open_for_write(const struct inode *inode)
>  {
>  	return atomic_read(&inode->i_writecount) > 0;
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 1a9ef8f6784dd..6a33288bd6a1f 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -129,7 +129,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  
>  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
>  
> -void file_set_fsnotify_mode(struct file *file);
> +void file_set_fsnotify_mode_from_watchers(struct file *file);
>  
>  /*
>   * fsnotify_file_area_perm - permission hook before access to file range
> @@ -213,7 +213,7 @@ static inline int fsnotify_open_perm(struct file *file)
>  }
>  
>  #else
> -static inline void file_set_fsnotify_mode(struct file *file)
> +static inline void file_set_fsnotify_mode_from_watchers(struct file *file)
>  {
>  }
>  
> -- 
> 2.34.1
> 

