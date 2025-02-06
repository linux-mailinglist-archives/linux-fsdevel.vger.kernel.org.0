Return-Path: <linux-fsdevel+bounces-41062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD025A2A874
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB823A814C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797F22E3FA;
	Thu,  6 Feb 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOhYL8AH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A822DFB7;
	Thu,  6 Feb 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844662; cv=none; b=MkoWl0wLt0zOkCYJaeHusrlpjgIvIK52fOVoS4GTfbhsqf6n7z5PAMJXm81kGltwA8fglvnZrvr05049p5sUODmR3fIfBeeZNK5lM6G4XS3U/C91mfXAItTBmeNhxefgPVF4JObs489aHYLmx0ezjnBgs+60bWoqFda0fJ5tdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844662; c=relaxed/simple;
	bh=POuTGn0oMpWPhBaeCpsYfRVghFqYq669DdTcriPoCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6vkxzC4ZHdxHW0p/fM2U53CiphTAlJvAlUMUooUN5mwzrUtJJn+UeoQX8j2wAPWvWiPD2pVFJSordJ0Lr07qwCQiXwS5GtPFAWvY4ROJaKzaHrgnShrtNZYcdHZKaSrKVuYmgBw0+ELk3SqBWNxq5n6bkkikdBn6Gd8Hdbi5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOhYL8AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C809C4CEDD;
	Thu,  6 Feb 2025 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738844661;
	bh=POuTGn0oMpWPhBaeCpsYfRVghFqYq669DdTcriPoCc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOhYL8AHFx4yht1cditKk1lrVKjzdhH0m6o1PMpktgB9Tjhfe1AJ5rLg2aYNl8sh8
	 4M9dVznH4ugeM6nRifkGIMa7sFLxz6bs6KdEWHnQrnRy/zy+lDwi5dm+9NL9ZufJt/
	 QTOi4oSD5CIkQYnFsLQ6l9Iq5LqzGe5O2ZtAgqD7db4sMr6yBXfjKy4bdU+9wYN+P0
	 SU4P/rCZLQbUB4Z/xF5g3fU/VO3x0/2VWTiVuib6vkgQv/oRqcViOx9NUYImfrW0Nf
	 dUQhw9K1jpXlqc7rAqzDbdw3R+7SJQfSwjM1wb8Nytn2Mk1m4s4xdCmMrd0+qxrunM
	 51do4V1aiHe2A==
Date: Thu, 6 Feb 2025 13:24:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
Message-ID: <20250206-zeugnis-vorsehen-a0f524cd0c8b@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-2-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:38PM +1100, NeilBrown wrote:
> vfs_mkdir() does not guarantee to make the child dentry positive on
> success.  It may leave it negative and then the caller needs to perform a
> lookup to find the target dentry.
> 
> This patch introduced vfs_mkdir_return() which performs the lookup if
> needed so that this code is centralised.
> 
> This prepares for a new inode operation which will perform mkdir and
> returns the correct dentry.
> 
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
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7cf59713f0f7..3c866c3b9534 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  	/* search the current directory for the element name */
>  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
>  
> -retry:
>  	ret = cachefiles_inject_read_error();
>  	if (ret == 0)
>  		subdir = lookup_one_len(dirname, dir, strlen(dirname));
> @@ -130,7 +129,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  			goto mkdir_error;
>  		ret = cachefiles_inject_write_error();
>  		if (ret == 0)
> -			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +			ret = vfs_mkdir_return(&nop_mnt_idmap, d_inode(dir), &subdir, 0700);
>  		if (ret < 0) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
> @@ -138,10 +137,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  		}
>  		trace_cachefiles_mkdir(dir, subdir);
>  
> -		if (unlikely(d_unhashed(subdir))) {
> -			cachefiles_put_directory(subdir);
> -			goto retry;
> -		}
>  		ASSERT(d_backing_inode(subdir));
>  
>  		_debug("mkdir -> %pd{ino=%lu}",
> diff --git a/fs/namei.c b/fs/namei.c
> index 3ab9440c5b93..d98caf36e867 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4317,6 +4317,75 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
>  
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
> + * the vfsmount must be passed through @idmap. This function will then take
> + * care to map the inode according to @idmap before checking permissions.
> + * On non-idmapped mounts or if permission checking is to be performed on the
> + * raw inode simply pass @nop_mnt_idmap.
> + *
> + * The filesystem may not use the dentry that was passed in.  In that case
> + * the passed-in dentry is put and a new one is placed in *@dentryp;
> + * So on successful return *@dentryp will always be positive.
> + */
> +int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
> +		     struct dentry **dentryp, umode_t mode)
> +{

I think this is misnamed. Maybe vfs_mkdir_positive() is better here.
It also be nice to have a comment on vfs_mkdir() as well pointing out
that the returned dentry might be negative.

And is there a particular reason to not have it return the new dentry?
That seems clearer than using the argument as a return value.

> +	struct dentry *dentry = *dentryp;
> +	int error;
> +	unsigned max_links = dir->i_sb->s_max_links;
> +
> +	error = may_create(idmap, dir, dentry);
> +	if (error)
> +		return error;
> +
> +	if (!dir->i_op->mkdir)
> +		return -EPERM;
> +
> +	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> +	error = security_inode_mkdir(dir, dentry, mode);
> +	if (error)
> +		return error;
> +
> +	if (max_links && dir->i_nlink >= max_links)
> +		return -EMLINK;
> +
> +	error = dir->i_op->mkdir(idmap, dir, dentry, mode);

Why isn't this calling vfs_mkdir() and then only starts differing afterwards?

> +	if (!error) {
> +		fsnotify_mkdir(dir, dentry);
> +		if (unlikely(d_unhashed(dentry))) {
> +			struct dentry *d;
> +			/* Need a "const" pointer.  We know d_name is const
> +			 * because we hold an exclusive lock on i_rwsem
> +			 * in d_parent.
> +			 */
> +			const struct qstr *d_name = (void*)&dentry->d_name;
> +			d = lookup_dcache(d_name, dentry->d_parent, 0);
> +			if (!d)
> +				d = __lookup_slow(d_name, dentry->d_parent, 0);

Quite a few caller's use lookup_one() here which calls
inode_permission() on @dir again. Are we guaranteed that the permission
check would always pass?

> +			if (IS_ERR(d)) {
> +				error = PTR_ERR(d);
> +			} else if (unlikely(d_is_negative(d))) {
> +				dput(d);
> +				error = -ENOENT;
> +			} else {
> +				dput(dentry);
> +				*dentryp = d;
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
> @@ -1488,26 +1488,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> -		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> -		if (!host_err && unlikely(d_unhashed(dchild))) {
> -			struct dentry *d;
> -			d = lookup_one_len(dchild->d_name.name,
> -					   dchild->d_parent,
> -					   dchild->d_name.len);
> -			if (IS_ERR(d)) {
> -				host_err = PTR_ERR(d);
> -				break;
> -			}
> -			if (unlikely(d_is_negative(d))) {
> -				dput(d);
> -				err = nfserr_serverfault;
> -				goto out;
> -			}
> +		host_err = vfs_mkdir_return(&nop_mnt_idmap, dirp, &dchild, iap->ia_mode);
> +		if (!host_err && unlikely(dchild != resfhp->fh_dentry)) {
>  			dput(resfhp->fh_dentry);
> -			resfhp->fh_dentry = dget(d);
> +			resfhp->fh_dentry = dget(dchild);
>  			err = fh_update(resfhp);
> -			dput(dchild);
> -			dchild = d;
>  			if (err)
>  				goto out;
>  		}
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c9993ff66fc2..e6c54c6ef0f5 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
>  	goto out;
>  }
>  
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode)
> -{
> -	int err;
> -	struct dentry *d, *dentry = *newdentry;
> -
> -	err = ovl_do_mkdir(ofs, dir, dentry, mode);
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
> -	d = ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
> -			     dentry->d_name.len);
> -	if (IS_ERR(d)) {
> -		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
> -			dentry, err);
> -		return PTR_ERR(d);
> -	}
> -	dput(dentry);
> -	*newdentry = d;
> -
> -	return 0;
> -}
> -
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  			       struct dentry *newdentry, struct ovl_cattr *attr)
>  {
> @@ -191,7 +160,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  
>  		case S_IFDIR:
>  			/* mkdir is special... */
> -			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
> +			err =  ovl_do_mkdir(ofs, dir, &newdentry, attr->mode);
>  			break;
>  
>  		case S_IFCHR:
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..967870f12482 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -242,11 +242,11 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  }
>  
>  static inline int ovl_do_mkdir(struct ovl_fs *ofs,
> -			       struct inode *dir, struct dentry *dentry,
> +			       struct inode *dir, struct dentry **dentry,
>  			       umode_t mode)
>  {
> -	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> -	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
> +	int err = vfs_mkdir_return(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> +	pr_debug("mkdir(%pd2, 0%o) = %i\n", *dentry, mode, err);
>  	return err;
>  }
>  
> @@ -838,8 +838,8 @@ struct ovl_cattr {
>  
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
>  
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
> @@ -327,7 +327,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
>  			goto retry;
>  		}
>  
> -		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
> +		err = ovl_do_mkdir(ofs, dir, &work, attr.ia_mode);
>  		if (err)
>  			goto out_dput;
>  
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 6890016e1923..4e580bb7baf8 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -211,7 +211,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct path path;
> -	struct dentry *dentry;
> +	struct dentry *dentry, *d;
>  	int err;
>  
>  	dentry = ksmbd_vfs_kern_path_create(work, name,
> @@ -227,27 +227,11 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  
>  	idmap = mnt_idmap(path.mnt);
>  	mode |= S_IFDIR;
> -	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> -	if (!err && d_unhashed(dentry)) {
> -		struct dentry *d;
> -
> -		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
> -			       dentry->d_name.len);
> -		if (IS_ERR(d)) {
> -			err = PTR_ERR(d);
> -			goto out_err;
> -		}
> -		if (unlikely(d_is_negative(d))) {
> -			dput(d);
> -			err = -ENOENT;
> -			goto out_err;
> -		}
> -
> +	d = dentry;
> +	err = vfs_mkdir_return(idmap, d_inode(path.dentry), &dentry, mode);
> +	if (!err && dentry != d)
>  		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
> -		dput(d);
> -	}
>  
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
> -- 
> 2.47.1
> 

