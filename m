Return-Path: <linux-fsdevel+bounces-41854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A9A384FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3333F3AC56A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262E21CA1E;
	Mon, 17 Feb 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6GR+J9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51C2185A3;
	Mon, 17 Feb 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799688; cv=none; b=dd/4tmlYMf35D35i5WpeHzwFLyXyAzrxRd19EpqNtGvYGubW/jiCOhJ8LsPxVdRNzPySLSJhCOkN+IQpN4W02kMLC3b1xTkYl4m4EN+4WdfC6am7S6wP5RTuKtx37UVIVeapbA26xiHvKEum3SIvgq32JPY8uKnJJ2EzmP18nXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799688; c=relaxed/simple;
	bh=rBwrjkL9co38iiv0yMfI8v7rsMDtLj8VL1CWIGBeP2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCWjH+hIzhWYa9FVMHbJR5jWYwzypMkq+2iBY8qRO/y4fkKdY4CZ/iC15LooS0oz7mVYeoIglZIVIgjKrzlcXPdHcpsFSvLbycsHaYgR/M12iQMDDgS+YdsyLnTJSOMyN5ksyADgJyGqQtdY2KU1rvGnjFFCQnIX5MgcEkRqb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6GR+J9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5574BC4CED1;
	Mon, 17 Feb 2025 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799686;
	bh=rBwrjkL9co38iiv0yMfI8v7rsMDtLj8VL1CWIGBeP2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z6GR+J9hbqjnFBzXj5DZa+HmK9OxMsn2nDTvTNldz2/PheVlYmUqIXWjHDCvE8Sr9
	 hd8b8+c8suRSTyTp6r7aXACgtnlyjIqZpXy+YOOfVwJeWswjAxeU5z6c/u2Yfsytam
	 fscEDw9oknYSpnO8Zdu1zCoTFhafa5rIBFAphc6gnBUiZ7arLFUZxmPQIc4wkKzSMJ
	 Sc+5QYNVb6scw+i7ikJr8woDo02LcDnvlcWptn7onp77w7exHqb7N3HCQCuXcGfZbU
	 LU6fS1JM2oYGoMbg3qrOqlZGj3uIPKLFeak+LHNmNQaV5vRzzDBTgCQjeiiPz9aAxx
	 XxJSXbQSitxOA==
Message-ID: <10c30f15c0405ce0536146c9b3f099c9773b2f5d.camel@kernel.org>
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Mon, 17 Feb 2025 08:41:25 -0500
In-Reply-To: <20250217003020.3170652-2-neilb@suse.de>
References: <20250217003020.3170652-1-neilb@suse.de>
	 <20250217003020.3170652-2-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 11:27 +1100, NeilBrown wrote:
> No callers of kern_path_locked() or user_path_locked_at() want a
> negative dentry.  So change them to return -ENOENT instead.  This
> simplifies callers.
>=20
> This results in a subtle change to bcachefs in that an ioctl will now
> return -ENOENT in preference to -EXDEV.  I believe this restores the
> behaviour to what it was prior to
>  Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> Link: https://lore.kernel.org/r/20250207034040.3402438-2-neilb@suse.de
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  Documentation/filesystems/porting.rst |  8 ++++
>  drivers/base/devtmpfs.c               | 65 +++++++++++++--------------
>  fs/bcachefs/fs-ioctl.c                |  4 --
>  fs/namei.c                            |  4 ++
>  kernel/audit_watch.c                  | 12 ++---
>  5 files changed, 48 insertions(+), 45 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 1639e78e3146..2ead47e20677 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1157,3 +1157,11 @@ in normal case it points into the pathname being l=
ooked up.
>  NOTE: if you need something like full path from the root of filesystem,
>  you are still on your own - this assists with simple cases, but it's not
>  magic.
> +
> +---
> +
> +** recommended**
> +
> +kern_path_locked() and user_path_locked() no longer return a negative
> +dentry so this doesn't need to be checked.  If the name cannot be found,
> +ERR_PTR(-ENOENT) is returned.
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index b848764ef018..c9e34842139f 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -245,15 +245,12 @@ static int dev_rmdir(const char *name)
>  	dentry =3D kern_path_locked(name, &parent);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> -	if (d_really_is_positive(dentry)) {
> -		if (d_inode(dentry)->i_private =3D=3D &thread)
> -			err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> -					dentry);
> -		else
> -			err =3D -EPERM;
> -	} else {
> -		err =3D -ENOENT;
> -	}
> +	if (d_inode(dentry)->i_private =3D=3D &thread)
> +		err =3D vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
> +				dentry);
> +	else
> +		err =3D -EPERM;
> +
>  	dput(dentry);
>  	inode_unlock(d_inode(parent.dentry));
>  	path_put(&parent);
> @@ -310,6 +307,8 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> +	struct kstat stat;
> +	struct path p;
>  	int deleted =3D 0;
>  	int err;
> =20
> @@ -317,32 +316,28 @@ static int handle_remove(const char *nodename, stru=
ct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> =20
> -	if (d_really_is_positive(dentry)) {
> -		struct kstat stat;
> -		struct path p =3D {.mnt =3D parent.mnt, .dentry =3D dentry};
> -		err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -				  AT_STATX_SYNC_AS_STAT);
> -		if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> -			struct iattr newattrs;
> -			/*
> -			 * before unlinking this node, reset permissions
> -			 * of possible references like hardlinks
> -			 */
> -			newattrs.ia_uid =3D GLOBAL_ROOT_UID;
> -			newattrs.ia_gid =3D GLOBAL_ROOT_GID;
> -			newattrs.ia_mode =3D stat.mode & ~0777;
> -			newattrs.ia_valid =3D
> -				ATTR_UID|ATTR_GID|ATTR_MODE;
> -			inode_lock(d_inode(dentry));
> -			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> -			inode_unlock(d_inode(dentry));
> -			err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> -					 dentry, NULL);
> -			if (!err || err =3D=3D -ENOENT)
> -				deleted =3D 1;
> -		}
> -	} else {
> -		err =3D -ENOENT;
> +	p.mnt =3D parent.mnt;
> +	p.dentry =3D dentry;
> +	err =3D vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> +			  AT_STATX_SYNC_AS_STAT);
> +	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +		struct iattr newattrs;
> +		/*
> +		 * before unlinking this node, reset permissions
> +		 * of possible references like hardlinks
> +		 */
> +		newattrs.ia_uid =3D GLOBAL_ROOT_UID;
> +		newattrs.ia_gid =3D GLOBAL_ROOT_GID;
> +		newattrs.ia_mode =3D stat.mode & ~0777;
> +		newattrs.ia_valid =3D
> +			ATTR_UID|ATTR_GID|ATTR_MODE;
> +		inode_lock(d_inode(dentry));
> +		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
> +		inode_unlock(d_inode(dentry));
> +		err =3D vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
> +				 dentry, NULL);
> +		if (!err || err =3D=3D -ENOENT)
> +			deleted =3D 1;
>  	}
>  	dput(dentry);
>  	inode_unlock(d_inode(parent.dentry));
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 15725b4ce393..595b57fabc9a 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -511,10 +511,6 @@ static long bch2_ioctl_subvolume_destroy(struct bch_=
fs *c, struct file *filp,
>  		ret =3D -EXDEV;
>  		goto err;
>  	}
> -	if (!d_is_positive(victim)) {
> -		ret =3D -ENOENT;
> -		goto err;
> -	}
>  	ret =3D __bch2_unlink(dir, victim, true);
>  	if (!ret) {
>  		fsnotify_rmdir(dir, victim);
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..fb6da3ca0ca5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2741,6 +2741,10 @@ static struct dentry *__kern_path_locked(int dfd, =
struct filename *name, struct
>  	}
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	d =3D lookup_one_qstr_excl(&last, path->dentry, 0);
> +	if (!IS_ERR(d) && d_is_negative(d)) {
> +		dput(d);
> +		d =3D ERR_PTR(-ENOENT);
> +	}
>  	if (IS_ERR(d)) {
>  		inode_unlock(path->dentry->d_inode);
>  		path_put(path);
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 7f358740e958..367eaf2c78b7 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, =
struct path *parent)
>  	struct dentry *d =3D kern_path_locked(watch->path, parent);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> -	if (d_is_positive(d)) {
> -		/* update watch filter fields */
> -		watch->dev =3D d->d_sb->s_dev;
> -		watch->ino =3D d_backing_inode(d)->i_ino;
> -	}
> +	/* update watch filter fields */
> +	watch->dev =3D d->d_sb->s_dev;
> +	watch->ino =3D d_backing_inode(d)->i_ino;
> +
>  	inode_unlock(d_backing_inode(parent->dentry));
>  	dput(d);
>  	return 0;
> @@ -419,10 +418,11 @@ int audit_add_watch(struct audit_krule *krule, stru=
ct list_head **list)
>  	/* caller expects mutex locked */
>  	mutex_lock(&audit_filter_mutex);
> =20
> -	if (ret) {
> +	if (ret && ret !=3D -ENOENT) {
>  		audit_put_watch(watch);
>  		return ret;
>  	}
> +	ret =3D 0;
> =20
>  	/* either find an old parent or attach a new one */
>  	parent =3D audit_find_parent(d_backing_inode(parent_path.dentry));

Reviewed-by: Jeff Layton <jlayton@kernel.org>

