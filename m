Return-Path: <linux-fsdevel+bounces-63315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2EBBB4A15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B8717A8A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3C26A0C6;
	Thu,  2 Oct 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo7Tr59N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819222655B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425220; cv=none; b=XNX1bDgq1jL8RBkMjWIbQuNu3H6JwrIIHkzEGxW642uCNlItGtsf/euG98p1dNILngXaNnNWAVg1EXFecG4W1bFfykUTAQtoBTM70LARKKUZyC4G6FgFh2V1vs2y4PHGhcmyEho3mskhOleJFGeIWlXvnApa7D9WuOiFbSfmY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425220; c=relaxed/simple;
	bh=Zg7WGoZOYEyYuEZ6aOwj7KkMnL7rJJP1YQb4Q4P4/1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9b298qeVFKuCLGynLkDhUGIeb/PP88XhxQ8pbULQO/vYMUaWqOcytnbJaemmiTAa9fsfp2KCvP72qFQeNfJiZfYPuakWwR1Ts8tgIio4Mv0erF1M97AMK5pnhK23o/N9jxsTe35rQOsb3CGmA6AhgR4D/wjGvKVZQY+FX40AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo7Tr59N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F1C4CEF9;
	Thu,  2 Oct 2025 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759425220;
	bh=Zg7WGoZOYEyYuEZ6aOwj7KkMnL7rJJP1YQb4Q4P4/1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eo7Tr59N+Ka+8GqnLSyrk8XO9WNRNeL5grRbvICpr78QrqPIYd6e9ggbAOQHiR1M4
	 UgvcUZgO5+FPKrnBEEXy8eaBf0VDlDKjDIlaOc0k0wBkh/OJ8mjezeITfI87fLwDeF
	 /8RZRs/wmdHUIgiWYLTQv5tw7dgj2R7qKf2JjZXmcZZU7P2ra/QatDiZI6+JvRx7iQ
	 CYsWXcS3CCuDDa4HRvPj4G173MRyARdlDTz3cNaNBK8YD+40JLgfu++vuUScKYcyb4
	 tn4Ts7nM0gRNepLOCzqk4Ncol6Zzbf6WF29bbM3pv2kczgVMHE6F6v0xLaJGfjzgOx
	 n4qoqccXjPb8w==
Message-ID: <29cfb47b5a2cedf5b4fb8de94382ccd8449de346.camel@kernel.org>
Subject: Re: [PATCH 05/11] VFS: introduce start_creating_noperm() and
 start_removing_noperm()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Date: Thu, 02 Oct 2025 13:13:38 -0400
In-Reply-To: <20250926025015.1747294-6-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
	 <20250926025015.1747294-6-neilb@ownmail.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 12:49 +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
> which do not check permissions.
> This patch adds _noperm versions of these functions.
>=20
> Note that do_mq_open() was only calling mntget() so it could call
> path_put() - it didn't really need an extra reference on the mnt.
> Now it doesn't call mntget() and uses end_creating() which does
> the dput() half of path_put().
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/fuse/dir.c            | 19 +++++++---------
>  fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/scrub/orphanage.c | 11 ++++-----
>  include/linux/namei.h    |  2 ++
>  ipc/mqueue.c             | 31 +++++++++-----------------
>  5 files changed, 73 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5c569c3cb53f..88bc512639e2 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1404,27 +1404,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
, u64 parent_nodeid,
>  	if (!parent)
>  		return -ENOENT;
> =20
> -	inode_lock_nested(parent, I_MUTEX_PARENT);
>  	if (!S_ISDIR(parent->i_mode))
> -		goto unlock;
> +		goto put_parent;
> =20
>  	err =3D -ENOENT;
>  	dir =3D d_find_alias(parent);
>  	if (!dir)
> -		goto unlock;
> +		goto put_parent;
> =20
> -	name->hash =3D full_name_hash(dir, name->name, name->len);
> -	entry =3D d_lookup(dir, name);
> +	entry =3D start_removing_noperm(dir, name);
>  	dput(dir);
> -	if (!entry)
> -		goto unlock;
> +	if (IS_ERR(entry))
> +		goto put_parent;
> =20
>  	fuse_dir_changed(parent);
>  	if (!(flags & FUSE_EXPIRE_ONLY))
>  		d_invalidate(entry);
>  	fuse_invalidate_entry_cache(entry);
> =20
> -	if (child_nodeid !=3D 0 && d_really_is_positive(entry)) {
> +	if (child_nodeid !=3D 0) {
>  		inode_lock(d_inode(entry));
>  		if (get_node_id(d_inode(entry)) !=3D child_nodeid) {
>  			err =3D -ENOENT;
> @@ -1452,10 +1450,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
>  	} else {
>  		err =3D 0;
>  	}
> -	dput(entry);
> =20
> - unlock:
> -	inode_unlock(parent);
> +	end_removing(entry);
> + put_parent:
>  	iput(parent);
>  	return err;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 0d9e98961758..bd5c45801756 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3296,6 +3296,54 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_removing);
> =20
> +/**
> + * start_creating_noperm - prepare to create a given name without permis=
sion checking
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating
> + * an object in a directory.
> + *
> + * If the name already exists, a positive dentry is returned.
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating_noperm(struct dentry *parent,
> +				     struct qstr *name)
> +{
> +	int err =3D lookup_noperm_common(name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return start_dirop(parent, name, LOOKUP_CREATE);
> +}
> +EXPORT_SYMBOL(start_creating_noperm);
> +
> +/**
> + * start_removing_noperm - prepare to remove a given name without permis=
sion checking
> + * @parent - directory in which to find the name
> + * @name - the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing_noperm(struct dentry *parent,
> +				     struct qstr *name)
> +{
> +	int err =3D lookup_noperm_common(name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return start_dirop(parent, name, 0);
> +}
> +EXPORT_SYMBOL(start_removing_noperm);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 9c12cb844231..e732605924a1 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -152,11 +152,10 @@ xrep_orphanage_create(
>  	}
> =20
>  	/* Try to find the orphanage directory. */
> -	inode_lock_nested(root_inode, I_MUTEX_PARENT);
> -	orphanage_dentry =3D lookup_noperm(&QSTR(ORPHANAGE), root_dentry);
> +	orphanage_dentry =3D start_creating_noperm(root_dentry, &QSTR(ORPHANAGE=
));
>  	if (IS_ERR(orphanage_dentry)) {
>  		error =3D PTR_ERR(orphanage_dentry);
> -		goto out_unlock_root;
> +		goto out_dput_root;
>  	}
> =20
>  	/*
> @@ -170,7 +169,7 @@ xrep_orphanage_create(
>  					     orphanage_dentry, 0750);
>  		error =3D PTR_ERR(orphanage_dentry);
>  		if (IS_ERR(orphanage_dentry))
> -			goto out_unlock_root;
> +			goto out_dput_orphanage;
>  	}
> =20
>  	/* Not a directory? Bail out. */
> @@ -200,9 +199,7 @@ xrep_orphanage_create(
>  	sc->orphanage_ilock_flags =3D 0;
> =20
>  out_dput_orphanage:
> -	dput(orphanage_dentry);
> -out_unlock_root:
> -	inode_unlock(VFS_I(sc->mp->m_rootip));
> +	end_creating(orphanage_dentry, root_dentry);
>  out_dput_root:
>  	dput(root_dentry);
>  out:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 63941fdbc23d..20a88a46fe92 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,6 +92,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, =
struct dentry *parent,
>  			      struct qstr *name);
>  struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>  			      struct qstr *name);
> +struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> =20
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 093551fe66a7..060e8e9c4f59 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -913,13 +913,11 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
>  		goto out_putname;
> =20
>  	ro =3D mnt_want_write(mnt);	/* we'll drop it in any case */
> -	inode_lock(d_inode(root));
> -	path.dentry =3D lookup_noperm(&QSTR(name->name), root);
> +	path.dentry =3D start_creating_noperm(root, &QSTR(name->name));
>  	if (IS_ERR(path.dentry)) {
>  		error =3D PTR_ERR(path.dentry);
>  		goto out_putfd;
>  	}
> -	path.mnt =3D mntget(mnt);
>  	error =3D prepare_open(path.dentry, oflag, ro, mode, name, attr);
>  	if (!error) {
>  		struct file *file =3D dentry_open(&path, oflag, current_cred());
> @@ -928,13 +926,12 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
>  		else
>  			error =3D PTR_ERR(file);
>  	}
> -	path_put(&path);
>  out_putfd:
>  	if (error) {
>  		put_unused_fd(fd);
>  		fd =3D error;
>  	}
> -	inode_unlock(d_inode(root));
> +	end_creating(path.dentry, root);
>  	if (!ro)
>  		mnt_drop_write(mnt);
>  out_putname:
> @@ -957,7 +954,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_nam=
e)
>  	int err;
>  	struct filename *name;
>  	struct dentry *dentry;
> -	struct inode *inode =3D NULL;
> +	struct inode *inode;
>  	struct ipc_namespace *ipc_ns =3D current->nsproxy->ipc_ns;
>  	struct vfsmount *mnt =3D ipc_ns->mq_mnt;
> =20
> @@ -969,26 +966,20 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_n=
ame)
>  	err =3D mnt_want_write(mnt);
>  	if (err)
>  		goto out_name;
> -	inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
> -	dentry =3D lookup_noperm(&QSTR(name->name), mnt->mnt_root);
> +	dentry =3D start_removing_noperm(mnt->mnt_root, &QSTR(name->name));
>  	if (IS_ERR(dentry)) {
>  		err =3D PTR_ERR(dentry);
> -		goto out_unlock;
> +		goto out_drop_write;
>  	}
> =20
>  	inode =3D d_inode(dentry);
> -	if (!inode) {
> -		err =3D -ENOENT;
> -	} else {
> -		ihold(inode);
> -		err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
> -				 dentry, NULL);
> -	}
> -	dput(dentry);
> -
> -out_unlock:
> -	inode_unlock(d_inode(mnt->mnt_root));
> +	ihold(inode);
> +	err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
> +			 dentry, NULL);
> +	end_removing(dentry);
>  	iput(inode);
> +
> +out_drop_write:
>  	mnt_drop_write(mnt);
>  out_name:
>  	putname(name);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

