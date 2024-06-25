Return-Path: <linux-fsdevel+bounces-22297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973999161A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1375B1F21E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C027E14901B;
	Tue, 25 Jun 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7qkF2QM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55E146587;
	Tue, 25 Jun 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305426; cv=none; b=dttY6PJ7hEgPCOz9kNwMwvin6OpyGjSBR3/1wXWHlhtMmSkdM5w9vF7DQ8sTHwJ4fgV7Mkx0JVTwA20aSyqDdhwciaCjDFidZ8h3rgV+fzI2aEnFf1ZLt1fNty3Br0dRxuUu8YvNN0GI6SVeGtzuHHvPpk0VvNFlgNWdM3XYCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305426; c=relaxed/simple;
	bh=joZ6+/PBp0hwFvkIogy7BknIDzUoOeOq/yxzUpqxbbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzp8jlX1J/W0QqtzL7yJAqsK9TRRs+aUOBGq27oSmmz0wC2gAKq568aj+pDWtasgpIVNP0pGxJ8WZADZAX7FrFSMEJkMIvD9Jxvs+S1MRXCoSQ/XfoI337tRTaDD0uYHaQBTnIFdI6CnZEuCgilBRXIApfHC7YvY/eqGS33n4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7qkF2QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D83C32781;
	Tue, 25 Jun 2024 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719305425;
	bh=joZ6+/PBp0hwFvkIogy7BknIDzUoOeOq/yxzUpqxbbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7qkF2QMNs75vYnwea14s3XF+taE5WDnexIZ97L+m0xzaJi9brKXw+YHRK2/QVgCx
	 9Lo++c0G+bpRDrsyTq5001BbrXQgMD7ph+rOlzYoUS6gtLnhwtFP1b+xRjYST/2lId
	 9Sizyj1VYVbflJoW5klOYpPusmpR4O1QKK5CZ3CWYJHC6NpjJjrch/nmk22Ga7KG+U
	 qkl7PBV/pAnBYb4sqasUEZQmQ7O8VX055VUyThKhjW6E3i2JavprjvNXwksXi8pPvZ
	 bFwsUMsM1uz/jIKIQXg9m8kNCMWYTFwGmALeZVtyST8t7jRcw4KrvuyvQq4FPzc02Y
	 LNyztq1/h+4YA==
Date: Tue, 25 Jun 2024 10:50:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alejandro Colomar <alx@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: Shortcut AT_EMPTY_PATH early for statx, and add
 AT_NO_PATH for statx and fstatat
Message-ID: <20240625-kindisch-ausgibt-b4feede36bab@brauner>
References: <20240624085037.33442-2-xry111@xry111.site>
 <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2lv3qamggymdjqzujvyhsd2q34jy5tryniac7d446tlaebqwy@5x4zn7z4d3xz>

On Mon, Jun 24, 2024 at 11:04:03AM GMT, Mateusz Guzik wrote:
> On Mon, Jun 24, 2024 at 04:50:26PM +0800, Xi Ruoyao wrote:
> > It's cheap to check if the path is empty in the userspace, but expensive
> > to check if a userspace string is empty from the kernel.  So it seems a
> > waste to delay the check into the kernel, and using statx(AT_EMPTY_PATH)
> > to implement fstat is slower than a "native" fstat call.
> > 
> > In the past there was a similar performance issue with several Glibc
> > releases using fstatat(AT_EMPTY_PATH) for fstat.  That issue was fixed
> > by Glibc with reverting back to plain fstat, and worked around by the
> > kernel with a special fast code path for fstatat(AT_EMPTY_PATH) at
> > commit 9013c51c630a ("vfs: mostly undo glibc turning 'fstat()' into
> > 'fstatat(AT_EMPTY_PATH)'").
> > 
> > But for arch/loongarch fstat does not exist, so we have to use statx.
> > And on all 32-bit architectures we must use statx for fstat after 2037
> > since the plain fstat call uses 32-bit timestamp.  Thus Glibc uses statx
> > for fstat on LoongArch and all 32-bit platforms, and these platforms
> > still suffer the performance issue.
> > 
> > So port the fstatat(AT_EMPTY_PATH) fast path to statx(AT_EMPTY_PATH) as
> > well, and add AT_NO_PATH (the name is suggested by Mateusz) which makes
> > statx and fstatat completely skip the path check and assume the path is
> > empty.
> > 
> > Benchmark on LoongArch Loongson 3A6000:
> > 
> > 1. Unpatched kernel, Glibc fstat, actually statx(AT_EMPTY_PATH):
> >    2575328 ops/s
> > 2. Patched kernel, Glibc fstat, actually statx(AT_EMPTY_PATH):
> >    5434782 ops/s, +111% from 1
> > 3. Patched kernel, statx(AT_NO_PATH): 5773672 ops/s, +124% from 1,
> >    +6.2% from 2.
> > 
> 
> Nice win.
> 
> > Seccomp sandboxes can also green light fstatat/statx(AT_NO_PATH) easier
> > than fstatat/statx(AT_EMPTY_PATH) for which the audition needs to check
> > 5434782543478254347825434782the path but seccomp BPF program cannot do that now.
> > 
> > Link: https://sourceware.org/pipermail/libc-alpha/2023-September/151364.html
> > Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=e6547d635b99
> > Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=551101e8240b
> > Link: https://lore.kernel.org/loongarch/599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name/
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Mateusz Guzik <mjguzik@gmail.com>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Xuerui Wang <kernel@xen0n.name>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Cc: Icenowy Zheng <uwu@icenowy.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: loongarch@lists.linux.dev
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > 
> > Superseds
> > https://lore.kernel.org/all/20240622105621.7922-1-xry111@xry111.site/.
> > 
> >  fs/stat.c                  | 103 +++++++++++++++++++++++++------------
> >  include/uapi/linux/fcntl.h |   3 ++
> >  2 files changed, 74 insertions(+), 32 deletions(-)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 70bd3e888cfa..2b7d4a22f971 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -208,7 +208,7 @@ int getname_statx_lookup_flags(int flags)
> >  		lookup_flags |= LOOKUP_FOLLOW;
> >  	if (!(flags & AT_NO_AUTOMOUNT))
> >  		lookup_flags |= LOOKUP_AUTOMOUNT;
> > -	if (flags & AT_EMPTY_PATH)
> > +	if (flags & (AT_EMPTY_PATH | AT_NO_PATH))
> >  		lookup_flags |= LOOKUP_EMPTY;
> >  
> >  	return lookup_flags;
> > @@ -217,7 +217,8 @@ int getname_statx_lookup_flags(int flags)
> >  /**
> >   * vfs_statx - Get basic and extra attributes by filename
> >   * @dfd: A file descriptor representing the base dir for a relative filename
> > - * @filename: The name of the file of interest
> > + * @filename: The name of the file of interest, or NULL if the file of
> > +	      interest is dfd itself and dfd isn't AT_FDCWD
> >   * @flags: Flags to control the query
> >   * @stat: The result structure to fill in.
> >   * @request_mask: STATX_xxx flags indicating what the caller wants
> > @@ -232,42 +233,56 @@ int getname_statx_lookup_flags(int flags)
> >  static int vfs_statx(int dfd, struct filename *filename, int flags,
> >  	      struct kstat *stat, u32 request_mask)
> >  {
> > -	struct path path;
> > +	struct path path, *p;
> > +	struct fd f;
> >  	unsigned int lookup_flags = getname_statx_lookup_flags(flags);
> >  	int error;
> >  
> >  	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
> > -		      AT_STATX_SYNC_TYPE))
> > +		      AT_STATX_SYNC_TYPE | AT_NO_PATH))
> >  		return -EINVAL;
> >  
> >  retry:
> > -	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
> > -	if (error)
> > -		goto out;
> > +	if (filename) {
> > +		p = &path;
> > +		error = filename_lookup(dfd, filename, lookup_flags, p,
> > +					NULL);
> > +		if (error)
> > +			goto out;
> > +	} else {
> > +		f = fdget_raw(dfd);
> > +		if (!f.file)
> > +			return -EBADF;
> > +		p = &f.file->f_path;
> > +	}
> >  
> 
> I don't think this is the right approach. Note this also did not cover
> io_uring.
> 
> I was thinking factoring code out to vfs_statx_path and adding
> vfs_statx_fd.
> 
> Below is a diff which compiles but is untested. It adds AT_EMPTY_PATH +
> NULL as suggsted by Linus, but it can be adjusted for AT_NO_PATH (which

No, let's not waste AT_* flag space in fear of some hypothetical
breakage. Let's try it cleanly first and make AT_EMPTY_PATH work with
NULL paths.

Note, I started working on this (checks ...) 30th April but then some
other work came up and I never got back to it (Sorry, Linus). I pushed
the branch to #vfs.empty.path now. The top three commits was what I had
started doing.

It was based on a new vfs_empty_path() helper so we could reuse it for
other system calls as well.

> would be my preffered option, or better yet not do that and add fstatx).
> 
> It does not do the hack to 0-check if a pointer was passed along with
> AT_EMPTY_PATH but that again is an easy addition.
> 
> Feel free to take without attribution:
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 84f371193f74..1d820018e6dc 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -247,6 +247,8 @@ extern const struct dentry_operations ns_dentry_operations;
>  int getname_statx_lookup_flags(int flags);
>  int do_statx(int dfd, struct filename *filename, unsigned int flags,
>  	     unsigned int mask, struct statx __user *buffer);
> +int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
> +		struct statx __user *buffer);
>  
>  /*
>   * fs/splice.c:
> diff --git a/fs/stat.c b/fs/stat.c
> index 16aa1f5ceec4..b0a4db7b90df 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -214,6 +214,48 @@ int getname_statx_lookup_flags(int flags)
>  	return lookup_flags;
>  }
>  
> +static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
> +			  u32 request_mask)
> +{
> +	int error = vfs_getattr(path, stat, request_mask, flags);
> +
> +	if (request_mask & STATX_MNT_ID_UNIQUE) {
> +		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
> +		stat->result_mask |= STATX_MNT_ID_UNIQUE;
> +	} else {
> +		stat->mnt_id = real_mount(path->mnt)->mnt_id;
> +		stat->result_mask |= STATX_MNT_ID;
> +	}
> +
> +	if (path->mnt->mnt_root == path->dentry)
> +		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
> +	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
> +
> +	/* Handle STATX_DIOALIGN for block devices. */
> +	if (request_mask & STATX_DIOALIGN) {
> +		struct inode *inode = d_backing_inode(path->dentry);
> +
> +		if (S_ISBLK(inode->i_mode))
> +			bdev_statx_dioalign(inode, stat);
> +	}
> +
> +	return error;
> +}
> +
> +static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
> +			  u32 request_mask)
> +{
> +	struct fd f;
> +	int error;
> +
> +	f = fdget_raw(fd);
> +	if (!f.file)
> +		return -EBADF;

CLASS(fd_raw, f)(fd), please.

> +	error = vfs_statx_path(&f.file->f_path, flags, stat, request_mask);
> +	fdput(f);
> +	return error;
> +}
> +
>  /**
>   * vfs_statx - Get basic and extra attributes by filename
>   * @dfd: A file descriptor representing the base dir for a relative filename
> @@ -243,36 +285,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  retry:
>  	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
>  	if (error)
> -		goto out;
> -
> -	error = vfs_getattr(&path, stat, request_mask, flags);
> -
> -	if (request_mask & STATX_MNT_ID_UNIQUE) {
> -		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
> -		stat->result_mask |= STATX_MNT_ID_UNIQUE;
> -	} else {
> -		stat->mnt_id = real_mount(path.mnt)->mnt_id;
> -		stat->result_mask |= STATX_MNT_ID;
> -	}
> -
> -	if (path.mnt->mnt_root == path.dentry)
> -		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
> -	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
> -
> -	/* Handle STATX_DIOALIGN for block devices. */
> -	if (request_mask & STATX_DIOALIGN) {
> -		struct inode *inode = d_backing_inode(path.dentry);
> -
> -		if (S_ISBLK(inode->i_mode))
> -			bdev_statx_dioalign(inode, stat);
> -	}
> -
> +		return error;
> +	error = vfs_statx_path(&path, flags, stat, request_mask);
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
>  	}
> -out:
>  	return error;
>  }
>  
> @@ -691,6 +710,29 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
>  	return cp_statx(&stat, buffer);
>  }
>  
> +int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
> +	     struct statx __user *buffer)
> +{
> +	struct kstat stat;
> +	int error;
> +
> +	if (mask & STATX__RESERVED)
> +		return -EINVAL;
> +	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
> +		return -EINVAL;
> +
> +	/* STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
> +	 * from userland.
> +	 */
> +	mask &= ~STATX_CHANGE_COOKIE;
> +
> +	error = vfs_statx_fd(fd, flags, &stat, mask);
> +	if (error)
> +		return error;
> +
> +	return cp_statx(&stat, buffer);
> +}
> +
>  /**
>   * sys_statx - System call to get enhanced stats
>   * @dfd: Base directory to pathwalk from *or* fd to stat.
> @@ -710,6 +752,9 @@ SYSCALL_DEFINE5(statx,
>  	int ret;
>  	struct filename *name;
>  
> +	if (filename == NULL && (flags & AT_EMPTY_PATH))
> +		return do_statx_fd(dfd, flags, mask, buffer);

Maybe use the helper I added

static inline bool vfs_empty_path(int dfd, const char __user *path)
{
       char c;

       if (dfd < 0)
               return false;

       /* We now allow NULL to be used for empty path. */
       if (!path)
               return true;

       if (unlikely(get_user(c, path)))
               return false;

       return !c;
}

> +
>  	name = getname_flags(filename, getname_statx_lookup_flags(flags));
>  	ret = do_statx(dfd, name, flags, mask, buffer);
>  	putname(name);
> diff --git a/io_uring/statx.c b/io_uring/statx.c
> index f7f9b202eec0..21c97aff270d 100644
> --- a/io_uring/statx.c
> +++ b/io_uring/statx.c
> @@ -23,6 +23,7 @@ struct io_statx {
>  int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
>  	struct io_statx *sx = io_kiocb_to_cmd(req, struct io_statx);
> +	struct filename *filename;
>  	const char __user *path;
>  
>  	if (sqe->buf_index || sqe->splice_fd_in)
> @@ -36,14 +37,13 @@ int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	sx->buffer = u64_to_user_ptr(READ_ONCE(sqe->addr2));
>  	sx->flags = READ_ONCE(sqe->statx_flags);
>  
> -	sx->filename = getname_flags(path,
> -				     getname_statx_lookup_flags(sx->flags));
> -
> -	if (IS_ERR(sx->filename)) {
> -		int ret = PTR_ERR(sx->filename);
> -
> -		sx->filename = NULL;
> -		return ret;
> +	sx->filename = NULL;
> +	if (!(path == NULL && (sx->flags & AT_EMPTY_PATH))) {
> +		filename = getname_flags(path,
> +					 getname_statx_lookup_flags(sx->flags));
> +		if (IS_ERR(filename))
> +			return PTR_ERR(filename);
> +		sx->filename = filename;
>  	}
>  
>  	req->flags |= REQ_F_NEED_CLEANUP;
> @@ -58,7 +58,10 @@ int io_statx(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>  
> -	ret = do_statx(sx->dfd, sx->filename, sx->flags, sx->mask, sx->buffer);
> +	if (sx->filename == NULL && (sx->flags & AT_EMPTY_PATH))
> +		ret = do_statx_fd(sx->dfd, sx->flags, sx->mask, sx->buffer);
> +	else
> +		ret = do_statx(sx->dfd, sx->filename, sx->flags, sx->mask, sx->buffer);
>  	io_req_set_res(req, ret, 0);
>  	return IOU_OK;
>  }
> -- 
> 2.43.0
> 

