Return-Path: <linux-fsdevel+bounces-30377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F42098A693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7912CB225B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B18190068;
	Mon, 30 Sep 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDTKT7hC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7423186E4A;
	Mon, 30 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705073; cv=none; b=kgNtHNMvzoabLhWuetT4FAb9rtgKHVFvjJtYrs+pFm1vgvrq0iUVsuITSN5SXxcldz/bykE82qx3Udh72/NxLoFwxVY4VGajO+nrUFQcgymCrBrXZqTSvmHl6RFQcVpy9SdYyfyZE+p/dKyr5OknzuyryME4PEPqea21tnkMO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705073; c=relaxed/simple;
	bh=yveOY+sl4ggyVtQ/RJKeO1eCxVgJjnW+CquzDBI9zGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXRRryR8zaMXr7UgxS6ikAvS6puM7Im9JrEYVfLsSIKJze4Jsu2e7mYEoKLzOKRtqGz/lOhAV4NlwnooavY6Ux+G1YdKPmF8qxSJ6beOwwlgS7491EweDPR2mAQASrFAaxabrDIVpz62HWApE3vwEqaxP25QkapzlUALTxN6whc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDTKT7hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E791C4CEC7;
	Mon, 30 Sep 2024 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727705073;
	bh=yveOY+sl4ggyVtQ/RJKeO1eCxVgJjnW+CquzDBI9zGA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FDTKT7hCHS3uiigWZLHfInqxpcyF839pcKLSaBs9LALcqTImytliCli3SAreYxhTi
	 Aal7m2cRnT+RRVMrKdushejm5ApHhZPKzO927Z03zegdrYJVQIFg5KVtEwQDB/KF72
	 s8N/3d0tI8NCcPPKQq0WeqW4wmbkbysNvk6UxSbZ1Umi8jGIZcKIwHAFnHdIcC22H0
	 s0pPHXRsm+7FtEyIloBBRUzUyE36RIysV0e5Hgagh+7xM+eZLnCDGwCUokXWl3K3ut
	 m4cKqya/crlwusPeTWz+G9Ovd93wITJu+VzmIJbht1TMpbsoxRdbE3jfGqgrlVvuzr
	 k0868MV//CdBw==
Message-ID: <cf0644ffec29f6ca2f2dab4184732ea5d39ba01a.camel@kernel.org>
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	linux-nfs@vger.kernel.org
Date: Mon, 30 Sep 2024 10:04:31 -0400
In-Reply-To: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
References: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 14:34 +1000, NeilBrown wrote:
> Various operations such as rename and unlink must break any delegations
> before they proceed.
> do_dentry_open() and vfs_truncate(), which use break_lease(), increment
> i_writecount and/or i_readcount which blocks delegations until the
> counter is decremented, but the various callers of try_break_deleg() do
> not impose any such barrier.  They hold the inode lock while performing
> the operation which blocks delegations, but must drop it while waiting
> for a delegation to be broken, which leaves an opportunity for a new
> delegation to be added.
>=20
> nfsd - the only current user of delegations - records any files on which
> it is called to break a delegation in a manner which blocks further
> delegations for 30-60 seconds.  This is normally sufficient.  However
> there is talk of reducing the timeout and it would be best if operations
> that needed delegations to be blocked used something more definitive
> than a timer.
>=20
> This patch adds that definitive blocking by adding a counter to struct
> file_lock_context of the number of concurrent operations which require
> delegations to be blocked.  check_conflicting_open() checks that counter
> when a delegation is requested and denies the delegation if the counter
> is elevated.
>=20
> try_break_deleg() now increments that counter when it records the inode
> as a 'delegated_inode'.
>=20
> break_deleg_wait() now leaves the inode pointer in *delegated_inode when
> it signals that the operation should be retried, and then clears it -
> decrementing the new counter - when the operation has completed, whether
> successfully or not.  To achieve this we now pass the current error
> status in to break_deleg_wait().
>=20
> vfs_rename() now uses two delegated_inode pointers, one for the
> source and one for the destination in the case of replacement.  This is
> needed as it may be necessary to block further delegations to both
> inodes while the rename completes.
>=20
> The net result is that we no longer depend on the delay that nfsd
> imposes on new delegation in order for various functions that break
> delegations to be sure that new delegations won't be added while they wai=
t
> with the inode unlocked.  This gives more freedom to nfsd to make more
> subtle choices about when and for how long to block delegations when
> there is no active contention.
>=20
> try_break_deleg() is possibly now large enough that it shouldn't be
> inline.
>=20

I like this approach. Moving the blocking of new delegations into the
VFS layer makes sense, and we can do better, more targeted blocking of
new leases this way.

I wonder -- do we still need the bloom filter if we do this? We could
keep track of the time of the last recall in i_flctx as well, and then
avoid handing them out until some time has elapsed.

try_break_deleg() (and break_deleg_wait(), for that matter) were
already a bit large for inlines, so moving them to regular functions
sounds like a good idea. Maybe we can even have inline fastpath
wrappers around them that check for i_flctx =3D=3D NULL and avoid the jmp
in that case?

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/locks.c               | 12 ++++++++++--
>  fs/namei.c               | 32 ++++++++++++++++++++------------
>  fs/open.c                |  8 ++++----
>  fs/posix_acl.c           |  8 ++++----
>  fs/utimes.c              |  4 ++--
>  fs/xattr.c               |  8 ++++----
>  include/linux/filelock.h | 31 ++++++++++++++++++++++++-------
>  include/linux/fs.h       |  3 ++-
>  8 files changed, 70 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index e45cad40f8b6..171628094daa 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
>  	INIT_LIST_HEAD(&ctx->flc_flock);
>  	INIT_LIST_HEAD(&ctx->flc_posix);
>  	INIT_LIST_HEAD(&ctx->flc_lease);
> +	atomic_set(&ctx->flc_deleg_blockers, 0);
> =20
>  	/*
>  	 * Assign the pointer if it's not already assigned. If it is, then
> @@ -255,6 +256,7 @@ locks_free_lock_context(struct inode *inode)
>  	struct file_lock_context *ctx =3D locks_inode_context(inode);
> =20
>  	if (unlikely(ctx)) {
> +		WARN_ON(atomic_read(&ctx->flc_deleg_blockers) !=3D 0);
>  		locks_check_ctx_lists(inode);
>  		kmem_cache_free(flctx_cache, ctx);
>  	}
> @@ -1743,9 +1745,15 @@ check_conflicting_open(struct file *filp, const in=
t arg, int flags)
> =20
>  	if (flags & FL_LAYOUT)
>  		return 0;
> -	if (flags & FL_DELEG)
> -		/* We leave these checks to the caller */
> +	if (flags & FL_DELEG) {
> +		struct file_lock_context *ctx =3D locks_inode_context(inode);
> +
> +		if (ctx && atomic_read(&ctx->flc_deleg_blockers) > 0)
> +			return -EAGAIN;
> +
> +		/* We leave the remaining checks to the caller */
>  		return 0;
> +	}
> =20
>  	if (arg =3D=3D F_RDLCK)
>  		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
> diff --git a/fs/namei.c b/fs/namei.c
> index 5512cb10fa89..3054da90276b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4493,8 +4493,8 @@ int do_unlinkat(int dfd, struct filename *name)
>  		iput(inode);	/* truncate the inode here */
>  	inode =3D NULL;
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(path.mnt);
> @@ -4764,8 +4764,8 @@ int do_linkat(int olddfd, struct filename *old, int=
 newdfd,
>  out_dput:
>  	done_path_create(&new_path, new_dentry);
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error) {
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK) {
>  			path_put(&old_path);
>  			goto retry;
>  		}
> @@ -4848,7 +4848,8 @@ int vfs_rename(struct renamedata *rd)
>  	struct inode *old_dir =3D rd->old_dir, *new_dir =3D rd->new_dir;
>  	struct dentry *old_dentry =3D rd->old_dentry;
>  	struct dentry *new_dentry =3D rd->new_dentry;
> -	struct inode **delegated_inode =3D rd->delegated_inode;
> +	struct inode **delegated_inode_old =3D rd->delegated_inode_old;
> +	struct inode **delegated_inode_new =3D rd->delegated_inode_new;
>  	unsigned int flags =3D rd->flags;
>  	bool is_dir =3D d_is_dir(old_dentry);
>  	struct inode *source =3D old_dentry->d_inode;
> @@ -4954,12 +4955,12 @@ int vfs_rename(struct renamedata *rd)
>  			goto out;
>  	}
>  	if (!is_dir) {
> -		error =3D try_break_deleg(source, delegated_inode);
> +		error =3D try_break_deleg(source, delegated_inode_old);
>  		if (error)
>  			goto out;
>  	}
>  	if (target && !new_is_dir) {
> -		error =3D try_break_deleg(target, delegated_inode);
> +		error =3D try_break_deleg(target, delegated_inode_new);
>  		if (error)
>  			goto out;
>  	}
> @@ -5011,7 +5012,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
> -	struct inode *delegated_inode =3D NULL;
> +	struct inode *delegated_inode_old =3D NULL;
> +	struct inode *delegated_inode_new =3D NULL;
>  	unsigned int lookup_flags =3D 0, target_flags =3D LOOKUP_RENAME_TARGET;
>  	bool should_retry =3D false;
>  	int error =3D -EINVAL;
> @@ -5118,7 +5120,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  	rd.new_dir	   =3D new_path.dentry->d_inode;
>  	rd.new_dentry	   =3D new_dentry;
>  	rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
> -	rd.delegated_inode =3D &delegated_inode;
> +	rd.delegated_inode_old =3D &delegated_inode_old;
> +	rd.delegated_inode_new =3D &delegated_inode_new;
>  	rd.flags	   =3D flags;
>  	error =3D vfs_rename(&rd);
>  exit5:
> @@ -5128,9 +5131,14 @@ int do_renameat2(int olddfd, struct filename *from=
, int newdfd,
>  exit3:
>  	unlock_rename(new_path.dentry, old_path.dentry);
>  exit_lock_rename:
> -	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +	if (delegated_inode_old) {
> +		error =3D break_deleg_wait(&delegated_inode_old, error);
> +		if (error =3D=3D -EWOULDBLOCK)
> +			goto retry_deleg;
> +	}
> +	if (delegated_inode_new) {
> +		error =3D break_deleg_wait(&delegated_inode_new, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(old_path.mnt);
> diff --git a/fs/open.c b/fs/open.c
> index 22adbef7ecc2..6b6d20a68dd8 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -656,8 +656,8 @@ int chmod_common(const struct path *path, umode_t mod=
e)
>  out_unlock:
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	mnt_drop_write(path->mnt);
> @@ -795,8 +795,8 @@ int chown_common(const struct path *path, uid_t user,=
 gid_t group)
>  				      &delegated_inode);
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	return error;
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 3f87297dbfdb..5eb3635d1067 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1143,8 +1143,8 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>  	inode_unlock(inode);
> =20
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
> =20
> @@ -1251,8 +1251,8 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct =
dentry *dentry,
>  	inode_unlock(inode);
> =20
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
> =20
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 3701b3946f88..21b7605551dc 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -67,8 +67,8 @@ int vfs_utimes(const struct path *path, struct timespec=
64 *times)
>  			      &delegated_inode);
>  	inode_unlock(inode);
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
> =20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 7672ce5486c5..63e0b067dab9 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -323,8 +323,8 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *=
dentry,
>  	inode_unlock(inode);
> =20
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
>  	if (value !=3D orig_value)
> @@ -577,8 +577,8 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>  	inode_unlock(inode);
> =20
>  	if (delegated_inode) {
> -		error =3D break_deleg_wait(&delegated_inode);
> -		if (!error)
> +		error =3D break_deleg_wait(&delegated_inode, error);
> +		if (error =3D=3D -EWOULDBLOCK)
>  			goto retry_deleg;
>  	}
> =20
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
> =20
>  #ifdef CONFIG_FILE_LOCKING
> @@ -450,21 +451,37 @@ static inline int try_break_deleg(struct inode *ino=
de, struct inode **delegated_
>  {
>  	int ret;
> =20
> +	if (delegated_inode && *delegated_inode) {
> +		if (*delegated_inode =3D=3D inode)
> +			/* Don't need to count this */
> +			return break_deleg(inode, O_WRONLY|O_NONBLOCK);
> +
> +		/* inode changed, forget the old one */
> +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> +		iput(*delegated_inode);
> +		*delegated_inode =3D NULL;
> +	}
>  	ret =3D break_deleg(inode, O_WRONLY|O_NONBLOCK);
>  	if (ret =3D=3D -EWOULDBLOCK && delegated_inode) {
>  		*delegated_inode =3D inode;
> +		atomic_inc(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
>  		ihold(inode);
>  	}
>  	return ret;
>  }
> =20
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct inode **delegated_inode, int r=
et)
>  {
> -	int ret;
> -
> -	ret =3D break_deleg(*delegated_inode, O_WRONLY);
> -	iput(*delegated_inode);
> -	*delegated_inode =3D NULL;
> +	if (ret =3D=3D -EWOULDBLOCK) {
> +		ret =3D break_deleg(*delegated_inode, O_WRONLY);
> +		if (ret =3D=3D 0)
> +			ret =3D -EWOULDBLOCK;
> +	}
> +	if (ret !=3D -EWOULDBLOCK) {
> +		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
> +		iput(*delegated_inode);
> +		*delegated_inode =3D NULL;
> +	}
>  	return ret;
>  }
> =20
> @@ -494,7 +511,7 @@ static inline int try_break_deleg(struct inode *inode=
, struct inode **delegated_
>  	return 0;
>  }
> =20
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> +static inline int break_deleg_wait(struct inode **delegated_inode, int r=
et)
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
> =20
>=20
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652

--=20
Jeff Layton <jlayton@kernel.org>

