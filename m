Return-Path: <linux-fsdevel+bounces-41081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B912BA2AA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E30F1889435
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E41EA7F6;
	Thu,  6 Feb 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH8qd5Cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D01EA7F9;
	Thu,  6 Feb 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849950; cv=none; b=qu+CUGDJ5SUdfxx3yTFhmF8ICWmEteC4rRGXW6NgnB1zQxW+MHk5VZPg8nIk+IBqw5h8+lxDfLEO3ZNw9pg4Hzzcm7gn+qAI98GhvrezsgLqTv21QO9k9Qy6AoWkoj2bI8HUCoF/5bbLNa6h4kis5Jt1K+HDm7Dcemhn1aFasEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849950; c=relaxed/simple;
	bh=sIxDyonZm3zn1Agpmc7P2pAIE3cQfr+Tv/NUycJ+Prk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZB2hgBTL9LjZgmmCFYsOpUq9/aqIvKGTd6lSkmqZLby1hdRA0rzCkIXHAlU5e6YME+RE9WFScW07Vvpzb0cuJ81JQIEffofMM5SoIgM5iy9JNr2lK5RGBqGi/aNpqi5hP8S2M1qfbmJuHuUbazgEGrTVAEOy2lRc5BHlUskDB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH8qd5Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4B0C4CEDD;
	Thu,  6 Feb 2025 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738849949;
	bh=sIxDyonZm3zn1Agpmc7P2pAIE3cQfr+Tv/NUycJ+Prk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iH8qd5Cmsst60b3pFySrhN9nhzvjmyXWUqYEz2pqowW87oPbP/np3tzmB6KdubBXn
	 Ec9GrafzlAkCsUBNsvyeEJXRZ51+vVLUwnJhe/ANdrbgxsWsX1U+m2obWxGMr1OvZw
	 gJ0H+uhmspNoxikOilCHnIKUOgJWTqjhEOkqeSBgBDOZN6JlXdgZ2dOOUGmSCQWQXE
	 Xa1lUi10ZFYm729ajFGdZoSKr5tYXatJMpv00X67Y+U14AziGoHswfeL1zTdQg/652
	 1ndR14baiGOtoK6Ft89hCT40Dad9uhBAJQtEacYFlbnAKeYQS41b9QpFNH9K+WRAiz
	 NBb1XMbt8+7hA==
Message-ID: <6ca281d4e45052a3a23bd60a63ef20288931dae1.camel@kernel.org>
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Linus Torvalds
	 <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 08:52:27 -0500
In-Reply-To: <20250206054504.2950516-2-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
	 <20250206054504.2950516-2-neilb@suse.de>
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

On Thu, 2025-02-06 at 16:42 +1100, NeilBrown wrote:
> vfs_mkdir() does not guarantee to make the child dentry positive on
> success.  It may leave it negative and then the caller needs to perform a
> lookup to find the target dentry.
>=20
> This patch introduced vfs_mkdir_return() which performs the lookup if
> needed so that this code is centralised.
>=20
> This prepares for a new inode operation which will perform mkdir and
> returns the correct dentry.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/cachefiles/namei.c    |  7 +---
>  fs/namei.c               | 69 ++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/vfs.c            | 21 ++----------
>  fs/overlayfs/dir.c       | 33 +------------------
>  fs/overlayfs/overlayfs.h | 10 +++---
>  fs/overlayfs/super.c     |  2 +-
>  fs/smb/server/vfs.c      | 24 +++-----------
>  include/linux/fs.h       |  2 ++
>  8 files changed, 86 insertions(+), 82 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7cf59713f0f7..3c866c3b9534 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefil=
es_cache *cache,
>  	/* search the current directory for the element name */
>  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> =20
> -retry:
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
>  		subdir =3D lookup_one_len(dirname, dir, strlen(dirname));
> @@ -130,7 +129,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  			goto mkdir_error;
>  		ret =3D cachefiles_inject_write_error();
>  		if (ret =3D=3D 0)
> -			ret =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +			ret =3D vfs_mkdir_return(&nop_mnt_idmap, d_inode(dir), &subdir, 0700)=
;
>  		if (ret < 0) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
> @@ -138,10 +137,6 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
>  		}
>  		trace_cachefiles_mkdir(dir, subdir);
> =20
> -		if (unlikely(d_unhashed(subdir))) {
> -			cachefiles_put_directory(subdir);
> -			goto retry;
> -		}
>  		ASSERT(d_backing_inode(subdir));
> =20
>  		_debug("mkdir -> %pd{ino=3D%lu}",
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..d98caf36e867 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4317,6 +4317,75 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inod=
e *dir,
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
> =20
> +/**
> + * vfs_mkdir_return - create directory returning correct dentry
> + * @idmap:	idmap of the mount the inode was found from
> + * @dir:	inode of the parent directory
> + * @dentryp:	pointer to dentry of the child directory
> + * @mode:	mode of the child directory
> + *
> + * Create a directory.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then t=
ake
> + * care to map the inode according to @idmap before checking permissions=
.
> + * On non-idmapped mounts or if permission checking is to be performed o=
n the
> + * raw inode simply pass @nop_mnt_idmap.
> + *
> + * The filesystem may not use the dentry that was passed in.  In that ca=
se
> + * the passed-in dentry is put and a new one is placed in *@dentryp;

This sounds like the filesystem is not allowed to use the dentry that
we're passing it. Maybe something like this:

"In the event that the filesystem doesn't use *@dentryp, the dentry is
put and a new one is placed in *@dentryp;"


> + * So on successful return *@dentryp will always be positive.
> + */
> +int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
> +		     struct dentry **dentryp, umode_t mode)
> +{
> +	struct dentry *dentry =3D *dentryp;
> +	int error;
> +	unsigned max_links =3D dir->i_sb->s_max_links;
> +
> +	error =3D may_create(idmap, dir, dentry);
> +	if (error)
> +		return error;
> +
> +	if (!dir->i_op->mkdir)
> +		return -EPERM;
> +
> +	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> +	error =3D security_inode_mkdir(dir, dentry, mode);
> +	if (error)
> +		return error;
> +
> +	if (max_links && dir->i_nlink >=3D max_links)
> +		return -EMLINK;
> +
> +	error =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (!error) {
> +		fsnotify_mkdir(dir, dentry);
> +		if (unlikely(d_unhashed(dentry))) {
> +			struct dentry *d;
> +			/* Need a "const" pointer.  We know d_name is const
> +			 * because we hold an exclusive lock on i_rwsem
> +			 * in d_parent.
> +			 */
> +			const struct qstr *d_name =3D (void*)&dentry->d_name;
> +			d =3D lookup_dcache(d_name, dentry->d_parent, 0);
> +			if (!d)
> +				d =3D __lookup_slow(d_name, dentry->d_parent, 0);
> +			if (IS_ERR(d)) {
> +				error =3D PTR_ERR(d);
> +			} else if (unlikely(d_is_negative(d))) {
> +				dput(d);
> +				error =3D -ENOENT;
> +			} else {
> +				dput(dentry);
> +				*dentryp =3D d;
> +			}
> +		}
> +	}
> +	return error;
> +}
> +EXPORT_SYMBOL(vfs_mkdir_return);
> +
>  int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  {
>  	struct dentry *dentry;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..740332413138 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1488,26 +1488,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> -		host_err =3D vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> -		if (!host_err && unlikely(d_unhashed(dchild))) {
> -			struct dentry *d;
> -			d =3D lookup_one_len(dchild->d_name.name,
> -					   dchild->d_parent,
> -					   dchild->d_name.len);
> -			if (IS_ERR(d)) {
> -				host_err =3D PTR_ERR(d);
> -				break;
> -			}
> -			if (unlikely(d_is_negative(d))) {
> -				dput(d);
> -				err =3D nfserr_serverfault;
> -				goto out;
> -			}
> +		host_err =3D vfs_mkdir_return(&nop_mnt_idmap, dirp, &dchild, iap->ia_m=
ode);
> +		if (!host_err && unlikely(dchild !=3D resfhp->fh_dentry)) {
>  			dput(resfhp->fh_dentry);
> -			resfhp->fh_dentry =3D dget(d);
> +			resfhp->fh_dentry =3D dget(dchild);
>  			err =3D fh_update(resfhp);
> -			dput(dchild);
> -			dchild =3D d;
>  			if (err)
>  				goto out;
>  		}
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c9993ff66fc2..e6c54c6ef0f5 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, str=
uct inode *dir,
>  	goto out;
>  }
> =20
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode)
> -{
> -	int err;
> -	struct dentry *d, *dentry =3D *newdentry;
> -
> -	err =3D ovl_do_mkdir(ofs, dir, dentry, mode);
> -	if (err)
> -		return err;
> -
> -	if (likely(!d_unhashed(dentry)))
> -		return 0;
> -
> -	/*
> -	 * vfs_mkdir() may succeed and leave the dentry passed
> -	 * to it unhashed and negative. If that happens, try to
> -	 * lookup a new hashed and positive dentry.
> -	 */
> -	d =3D ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
> -			     dentry->d_name.len);
> -	if (IS_ERR(d)) {
> -		pr_warn("failed lookup after mkdir (%pd2, err=3D%i).\n",
> -			dentry, err);
> -		return PTR_ERR(d);
> -	}
> -	dput(dentry);
> -	*newdentry =3D d;
> -
> -	return 0;
> -}
> -
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  			       struct dentry *newdentry, struct ovl_cattr *attr)
>  {
> @@ -191,7 +160,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, st=
ruct inode *dir,
> =20
>  		case S_IFDIR:
>  			/* mkdir is special... */
> -			err =3D  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
> +			err =3D  ovl_do_mkdir(ofs, dir, &newdentry, attr->mode);
>  			break;
> =20
>  		case S_IFCHR:
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..967870f12482 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -242,11 +242,11 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  }
> =20
>  static inline int ovl_do_mkdir(struct ovl_fs *ofs,
> -			       struct inode *dir, struct dentry *dentry,
> +			       struct inode *dir, struct dentry **dentry,
>  			       umode_t mode)
>  {
> -	int err =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> -	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, err);
> +	int err =3D vfs_mkdir_return(ovl_upper_mnt_idmap(ofs), dir, dentry, mod=
e);
> +	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", *dentry, mode, err);
>  	return err;
>  }
> =20
> @@ -838,8 +838,8 @@ struct ovl_cattr {
> =20
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
> =20
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode);
> +int ovl_do_mkdir(struct ovl_fs *ofs, struct inode *dir,
> +	      struct dentry **newdentry, umode_t mode);
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>  			       struct inode *dir, struct dentry *newdentry,
>  			       struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..06ca8b01c336 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -327,7 +327,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  			goto retry;
>  		}
> =20
> -		err =3D ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
> +		err =3D ovl_do_mkdir(ofs, dir, &work, attr.ia_mode);
>  		if (err)
>  			goto out_dput;
> =20
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 6890016e1923..4e580bb7baf8 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -211,7 +211,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct path path;
> -	struct dentry *dentry;
> +	struct dentry *dentry, *d;
>  	int err;
> =20
>  	dentry =3D ksmbd_vfs_kern_path_create(work, name,
> @@ -227,27 +227,11 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const =
char *name, umode_t mode)
> =20
>  	idmap =3D mnt_idmap(path.mnt);
>  	mode |=3D S_IFDIR;
> -	err =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> -	if (!err && d_unhashed(dentry)) {
> -		struct dentry *d;
> -
> -		d =3D lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
> -			       dentry->d_name.len);
> -		if (IS_ERR(d)) {
> -			err =3D PTR_ERR(d);
> -			goto out_err;
> -		}
> -		if (unlikely(d_is_negative(d))) {
> -			dput(d);
> -			err =3D -ENOENT;
> -			goto out_err;
> -		}
> -
> +	d =3D dentry;
> +	err =3D vfs_mkdir_return(idmap, d_inode(path.dentry), &dentry, mode);
> +	if (!err && dentry !=3D d)
>  		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
> -		dput(d);
> -	}
> =20
> -out_err:
>  	done_path_create(&path, dentry);
>  	if (err)
>  		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f..f81d6bc65fe4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1971,6 +1971,8 @@ int vfs_create(struct mnt_idmap *, struct inode *,
>  	       struct dentry *, umode_t, bool);
>  int vfs_mkdir(struct mnt_idmap *, struct inode *,
>  	      struct dentry *, umode_t);
> +int vfs_mkdir_return(struct mnt_idmap *, struct inode *,
> +		     struct dentry **, umode_t);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                umode_t, dev_t);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,

--=20
Jeff Layton <jlayton@kernel.org>

