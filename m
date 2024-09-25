Return-Path: <linux-fsdevel+bounces-30047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760FF9855EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993011C237D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D615B13D;
	Wed, 25 Sep 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5uVQK7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372C139579;
	Wed, 25 Sep 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254587; cv=none; b=TF84SX/Dg02RqzEudVI0KdPphO3F/7iHBp+dEwKKvTYaIVkR68W9exYEE+AfA2ijTi/ujQHNjFC6RkPjubVsXYYjWr4h7pldrgYR/ZUW6SXXduq/DaS+3i0PqQdR1KX+9rKqLEUth+fzvg+Jwp8T+1AiUICq7Nnhg+bwaNPydWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254587; c=relaxed/simple;
	bh=TLBQhEag6OZdHj5pIrkL8iAWtnJuTrqP8RyYnODCY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKIHKgE741gfhf1+wbniYbPBQPVo9FInezbEHMndgHdeJQcLrnz3TynF37KZLIUlQCbadfaSXEM0qtTwrhyVVd0WhVynrkNK5TwFAlr9ywclmhTTYXfAq0hvT7YkYiBZ+y98XVCBGO99JLIEeRiAgDan+MtA75ik9CHq3dJQJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5uVQK7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C32C4CECD;
	Wed, 25 Sep 2024 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727254586;
	bh=TLBQhEag6OZdHj5pIrkL8iAWtnJuTrqP8RyYnODCY1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5uVQK7ZEloIemva9jvzfuhuyYadYmUpN+7vJx3Ohx1+8XA0zjIauI/8R24Guzd6B
	 ZPDm8CDI63n+mjeGQHUoCqVT2fHbq42iB/UdGrnDCoHt8Uxtqvx/vP5P/Bvn7oHLPB
	 2WuytlPfWaTuqYKCH1Cj5mF2ty1zh/6sqY97vgIq0e+ONdMcw2pTXWCrlGmJ+VaLS0
	 GfojpAr7xrg0euorHnMrxWnMLMSChIBCWqgAcOYKVAWOTDDd5Rt7iyVLaxb1ES2jNk
	 lzYCaY2/49fGud0Its524/8R5qm7JCkKIWWaKHoy0V9P9umFIfQfjp602VJNQr2++B
	 YzTEb4NCnlWTA==
Date: Wed, 25 Sep 2024 10:56:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
Message-ID: <20240925-gegriffen-lerngruppen-c173f1fd884e@brauner>
References: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172646129988.17050.4729474250083101679@noble.neil.brown.name>

On Mon, Sep 16, 2024 at 02:34:59PM GMT, NeilBrown wrote:
> 
> Various operations such as rename and unlink must break any delegations
> before they proceed.
> do_dentry_open() and vfs_truncate(), which use break_lease(), increment
> i_writecount and/or i_readcount which blocks delegations until the
> counter is decremented, but the various callers of try_break_deleg() do
> not impose any such barrier.  They hold the inode lock while performing
> the operation which blocks delegations, but must drop it while waiting
> for a delegation to be broken, which leaves an opportunity for a new
> delegation to be added.
> 
> nfsd - the only current user of delegations - records any files on which
> it is called to break a delegation in a manner which blocks further
> delegations for 30-60 seconds.  This is normally sufficient.  However
> there is talk of reducing the timeout and it would be best if operations
> that needed delegations to be blocked used something more definitive
> than a timer.
> 
> This patch adds that definitive blocking by adding a counter to struct
> file_lock_context of the number of concurrent operations which require
> delegations to be blocked.  check_conflicting_open() checks that counter
> when a delegation is requested and denies the delegation if the counter
> is elevated.
> 
> try_break_deleg() now increments that counter when it records the inode
> as a 'delegated_inode'.
> 
> break_deleg_wait() now leaves the inode pointer in *delegated_inode when
> it signals that the operation should be retried, and then clears it -
> decrementing the new counter - when the operation has completed, whether
> successfully or not.  To achieve this we now pass the current error
> status in to break_deleg_wait().
> 
> vfs_rename() now uses two delegated_inode pointers, one for the
> source and one for the destination in the case of replacement.  This is
> needed as it may be necessary to block further delegations to both
> inodes while the rename completes.

I'm not intimiately familiar with delegations but the reasoning seems
sound to me and I don't spot anything obvious in the code. I will defer
to Jeff for a decision.

Is there any potential for deadlocks due to ordering issues when calling
__break_lease() on source and target?

> 
> The net result is that we no longer depend on the delay that nfsd
> imposes on new delegation in order for various functions that break
> delegations to be sure that new delegations won't be added while they wait
> with the inode unlocked.  This gives more freedom to nfsd to make more
> subtle choices about when and for how long to block delegations when
> there is no active contention.
> 
> try_break_deleg() is possibly now large enough that it shouldn't be
> inline.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

I looked a bit for broader documentation on delegations/leases and it
seems we don't have any. It would be nice if we could add something
to Documentation/filesystems/.

>  fs/locks.c               | 12 ++++++++++--
>  fs/namei.c               | 32 ++++++++++++++++++++------------
>  fs/open.c                |  8 ++++----
>  fs/posix_acl.c           |  8 ++++----
>  fs/utimes.c              |  4 ++--
>  fs/xattr.c               |  8 ++++----
>  include/linux/filelock.h | 31 ++++++++++++++++++++++++-------
>  include/linux/fs.h       |  3 ++-
>  8 files changed, 70 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index e45cad40f8b6..171628094daa 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
>  	INIT_LIST_HEAD(&ctx->flc_flock);
>  	INIT_LIST_HEAD(&ctx->flc_posix);
>  	INIT_LIST_HEAD(&ctx->flc_lease);
> +	atomic_set(&ctx->flc_deleg_blockers, 0);
>  
>  	/*
>  	 * Assign the pointer if it's not already assigned. If it is, then
> @@ -255,6 +256,7 @@ locks_free_lock_context(struct inode *inode)
>  	struct file_lock_context *ctx = locks_inode_context(inode);
>  
>  	if (unlikely(ctx)) {
> +		WARN_ON(atomic_read(&ctx->flc_deleg_blockers) != 0);
>  		locks_check_ctx_lists(inode);
>  		kmem_cache_free(flctx_cache, ctx);
>  	}
> @@ -1743,9 +1745,15 @@ check_conflicting_open(struct file *filp, const int arg, int flags)
>  
>  	if (flags & FL_LAYOUT)
>  		return 0;
> -	if (flags & FL_DELEG)
> -		/* We leave these checks to the caller */
> +	if (flags & FL_DELEG) {
> +		struct file_lock_context *ctx = locks_inode_context(inode);
> +
> +		if (ctx && atomic_read(&ctx->flc_deleg_blockers) > 0)
> +			return -EAGAIN;
> +
> +		/* We leave the remaining checks to the caller */
>  		return 0;
> +	}
>  
>  	if (arg == F_RDLCK)
>  		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> diff --git a/fs/namei.c b/fs/namei.c
> index 5512cb10fa89..3054da90276b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4493,8 +4493,8 @@ int do_unlinkat(int dfd, struct filename *name)
>  		iput(inode);	/* truncate the inode here */
>  	inode = NULL;
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(path.mnt);
> @@ -4764,8 +4764,8 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
>  out_dput:
>  	done_path_create(&new_path, new_dentry);
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error) {
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK) {
>  			path_put(&old_path);
>  			goto retry;
>  		}
> @@ -4848,7 +4848,8 @@ int vfs_rename(struct renamedata *rd)
>  	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
>  	struct dentry *old_dentry = rd->old_dentry;
>  	struct dentry *new_dentry = rd->new_dentry;
> -	struct inode **delegated_inode = rd->delegated_inode;
> +	struct inode **delegated_inode_old = rd->delegated_inode_old;
> +	struct inode **delegated_inode_new = rd->delegated_inode_new;
>  	unsigned int flags = rd->flags;
>  	bool is_dir = d_is_dir(old_dentry);
>  	struct inode *source = old_dentry->d_inode;
> @@ -4954,12 +4955,12 @@ int vfs_rename(struct renamedata *rd)
>  			goto out;
>  	}
>  	if (!is_dir) {
> -		error = try_break_deleg(source, delegated_inode);
> +		error = try_break_deleg(source, delegated_inode_old);
>  		if (error)
>  			goto out;
>  	}
>  	if (target && !new_is_dir) {
> -		error = try_break_deleg(target, delegated_inode);
> +		error = try_break_deleg(target, delegated_inode_new);
>  		if (error)
>  			goto out;
>  	}
> @@ -5011,7 +5012,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
> -	struct inode *delegated_inode = NULL;
> +	struct inode *delegated_inode_old = NULL;
> +	struct inode *delegated_inode_new = NULL;
>  	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
>  	bool should_retry = false;
>  	int error = -EINVAL;
> @@ -5118,7 +5120,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	rd.new_dir	   = new_path.dentry->d_inode;
>  	rd.new_dentry	   = new_dentry;
>  	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
> -	rd.delegated_inode = &delegated_inode;
> +	rd.delegated_inode_old = &delegated_inode_old;
> +	rd.delegated_inode_new = &delegated_inode_new;
>  	rd.flags	   = flags;
>  	error = vfs_rename(&rd);
>  exit5:
> @@ -5128,9 +5131,14 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  exit3:
>  	unlock_rename(new_path.dentry, old_path.dentry);
>  exit_lock_rename:
> -	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +	if (delegated_inode_old) {
> +		error = break_deleg_wait(&delegated_inode_old, error);
> +		if (error == -EWOULDBLOCK)
> +			goto retry_deleg;
> +	}
> +	if (delegated_inode_new) {
> +		error = break_deleg_wait(&delegated_inode_new, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(old_path.mnt);
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2..6b6d20a68dd8 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -656,8 +656,8 @@ int chmod_common(const struct path *path, umode_t mode)
>  out_unlock:
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(path->mnt);
> @@ -795,8 +795,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  				      &delegated_inode);
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	return error;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 3f87297dbfdb..5eb3635d1067 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1143,8 +1143,8 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	inode_unlock(inode);
>  
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  
> @@ -1251,8 +1251,8 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	inode_unlock(inode);
>  
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 3701b3946f88..21b7605551dc 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -67,8 +67,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
>  			      &delegated_inode);
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 7672ce5486c5..63e0b067dab9 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -323,8 +323,8 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	inode_unlock(inode);
>  
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	if (value != orig_value)
> @@ -577,8 +577,8 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	inode_unlock(inode);
>  
>  	if (delegated_inode) {
> -		error = break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error = break_deleg_wait(&delegated_inode, error);
> +		if (error == -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index daee999d05f3..66470ba9658c 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -144,6 +144,7 @@ struct file_lock_context {
>  	struct list_head	flc_flock;
>  	struct list_head	flc_posix;
>  	struct list_head	flc_lease;
> +	atomic_t		flc_deleg_blockers;
>  };
>  
>  #ifdef CONFIG_FILE_LOCKING
> @@ -450,21 +451,37 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
>  {
>  	int ret;
>  
> +	if (delegated_inode && *delegated_inode) {
> +		if (*delegated_inode == inode)
> +			/* Don't need to count this */
> +			return break_deleg(inode, O_WRONLY|O_NONBLOCK);
> +
> +		/* inode changed, forget the old one */
> +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> +		iput(*delegated_inode);
> +		*delegated_inode = NULL;
> +	}
>  	ret = break_deleg(inode, O_WRONLY|O_NONBLOCK);
>  	if (ret == -EWOULDBLOCK && delegated_inode) {
>  		*delegated_inode = inode;
> +		atomic_inc(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
>  		ihold(inode);
>  	}
>  	return ret;
>  }
>  
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct inode **delegated_inode, int ret)
>  {
> -	int ret;
> -
> -	ret = break_deleg(*delegated_inode, O_WRONLY);
> -	iput(*delegated_inode);
> -	*delegated_inode = NULL;
> +	if (ret == -EWOULDBLOCK) {
> +		ret = break_deleg(*delegated_inode, O_WRONLY);
> +		if (ret == 0)
> +			ret = -EWOULDBLOCK;
> +	}
> +	if (ret != -EWOULDBLOCK) {
> +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> +		iput(*delegated_inode);
> +		*delegated_inode = NULL;
> +	}
>  	return ret;
>  }
>  
> @@ -494,7 +511,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
>  	return 0;
>  }
>  
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct inode **delegated_inode, int ret)
>  {
>  	BUG();
>  	return 0;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6ca11e241a24..50957d9e1c2b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1902,7 +1902,8 @@ struct renamedata {
>  	struct mnt_idmap *new_mnt_idmap;
>  	struct inode *new_dir;
>  	struct dentry *new_dentry;
> -	struct inode **delegated_inode;
> +	struct inode **delegated_inode_old;
> +	struct inode **delegated_inode_new;
>  	unsigned int flags;
>  } __randomize_layout;
>  
> 
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> -- 
> 2.46.0
> 

