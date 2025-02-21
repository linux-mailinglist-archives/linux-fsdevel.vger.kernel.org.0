Return-Path: <linux-fsdevel+bounces-42247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023BA3F730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19E519C05D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A120FAB0;
	Fri, 21 Feb 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0AApFk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027820F07C;
	Fri, 21 Feb 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147923; cv=none; b=uJM+kqcW0DHXkJOHHtgw5VUbRmFg1yzGEKaEMLhCi0vuh/EWNuhfY93vWBeUa5eNLZnHX/diaMFZut65cUJ6vj6KUXg9qlJB86myxgJjEV1fbAWxhABSUtwV6A8YpMnof8yynnlLzoHsMFOAKz524BSeSotel5J3x87PeozAfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147923; c=relaxed/simple;
	bh=nhFM7YpTcxwFTIK82ovGB9T3JpSzZKqlOO5rQVon8Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gf+R1m/02FymxKlb8uio/7EamyvSs/qvKXiFoc+8sAUxxElTRJdBcKJY/6kEjngGpqu6MayWrMEK1JheWmLaPhc9ZSXNSjEkpQdqGOZhTG2mzTzxKndhmEsnGGOgdoCyJ0gvtW9xfOOrCekzZ8EFeRg8FGrZQxNABv4IxRmbtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0AApFk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E471C4CED6;
	Fri, 21 Feb 2025 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740147923;
	bh=nhFM7YpTcxwFTIK82ovGB9T3JpSzZKqlOO5rQVon8Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H0AApFk/ThtwZVFQHe/W6+F0kQP/3PGAOOTdDLlOIQ2GvKosyil2Ad9Dat+vxIeV6
	 jU6RBX/x3Q/he6Gk9FyfxJW7AzlSzk8VVbPPmtrQK7FWqkfkHC7CUuAyP1V/NMR/Wo
	 iNuLaxDIrUCu9DzaA+IqRfjZfnNi46iSo1AT6XIRvavuEYnjOdBqQOmtiGy+o/0IQQ
	 6RWmwFiMpdGyXPPqIYfyrWIcvJKhn/ow2U5mUK9HSYvggs2yI8KpVGADkSU61o0LRM
	 z/T8xwISrNNPoiWV9S5oR2mChdWiGsOA7MJp1jBCJf/BpRQVQl9SpyMyqRQ0LE16xi
	 S64cg0apBJwOQ==
Message-ID: <3b30ca37e9466e1d547f86911ec14655c1e1062e.camel@kernel.org>
Subject: Re: [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos
 Szeredi <miklos@szeredi.hu>,  Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>, Richard Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Trond Myklebust	 <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Chuck Lever	 <chuck.lever@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo	 <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Sergey Senozhatsky	 <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev
Date: Fri, 21 Feb 2025 09:25:19 -0500
In-Reply-To: <20250220234630.983190-7-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
	 <20250220234630.983190-7-neilb@suse.de>
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

On Fri, 2025-02-21 at 10:36 +1100, NeilBrown wrote:
> vfs_mkdir() does not guarantee to leave the child dentry hashed or make
> it positive on success, and in many such cases the filesystem had to use
> a different dentry which it can now return.
>=20
> This patch changes vfs_mkdir() to return the dentry provided by the
> filesystems which is hashed and positive when provided.  This reduces
> the number of cases where the resulting dentry is not positive to a
> handful which don't deserve extra efforts.
>=20
> The only callers of vfs_mkdir() which are interested in the resulting
> inode are in-kernel filesystem clients: cachefiles, nfsd, smb/server.
> The only filesystems that don't reliably provide the inode are:
> - kernfs, tracefs which these clients are unlikely to be interested in
> - cifs in some configurations would need to do a lookup to find the
>   created inode, but doesn't.  cifs cannot be exported via NFS, is
>   unlikely to be used by cachefiles, and smb/server only has a soft
>   requirement for the inode, so this is unlikely to be a problem in
>   practice.
> - hostfs, nfs, cifs may need to do a lookup (rarely for NFS) and it is
>   possible for a race to make that lookup fail.  Actual failure
>   is unlikely and providing callers handle negative dentries graceful
>   they will fail-safe.
>=20
> So this patch removes the lookup code in nfsd and smb/server and adjusts
> them to fail safe if a negative dentry is provided:
> - cache-files already fails safe by restarting the task from the
>   top - it still does with this change, though it no longer calls
>   cachefiles_put_directory() as that will crash if the dentry is
>   negative.
> - nfsd reports "Server-fault" which it what it used to do if the lookup
>   failed. This will never happen on any file-systems that it can actually
>   export, so this is of no consequence.  I removed the fh_update()
>   call as that is not needed and out-of-place.  A subsequent
>   nfsd_create_setattr() call will call fh_update() when needed.
> - smb/server only wants the inode to call ksmbd_smb_inherit_owner()
>   which updates ->i_uid (without calling notify_change() or similar)

That looks like a bug. ksmbd should really be using notify_change().
There is no guarantee that that uid will eventually be persisted. It
could get overwritten if the exported filesystem is something like Ceph
or NFS. I see no reason why it can't use that either, as it's not in a
weird context at that point.

It would probably be ideal though to make it create the dir with the
right ownership in the first place, possibly by manipulating the task
creds?

In any case, that's not directly related to your patch.

>   which can be safely skipping on cifs (I hope).
>=20
> If a different dentry is returned, the first one is put.  If necessary
> the fact that it is new can be determined by comparing pointers.  A new
> dentry will certainly have a new pointer (as the old is put after the
> new is obtained).
> Similarly if an error is returned (via ERR_PTR()) the original dentry is
> put.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/base/devtmpfs.c  |  7 +++---
>  fs/cachefiles/namei.c    | 16 ++++++++------
>  fs/ecryptfs/inode.c      | 14 ++++++++----
>  fs/init.c                |  7 ++++--
>  fs/namei.c               | 46 ++++++++++++++++++++++++++--------------
>  fs/nfsd/nfs4recover.c    |  7 ++++--
>  fs/nfsd/vfs.c            | 34 ++++++++++-------------------
>  fs/overlayfs/dir.c       | 37 ++++----------------------------
>  fs/overlayfs/overlayfs.h | 15 ++++++-------
>  fs/overlayfs/super.c     |  7 +++---
>  fs/smb/server/vfs.c      | 32 +++++++++-------------------
>  fs/xfs/scrub/orphanage.c |  9 ++++----
>  include/linux/fs.h       |  4 ++--
>  13 files changed, 105 insertions(+), 130 deletions(-)
>=20
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 7a101009bee7..6dd1a8860f1c 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -175,18 +175,17 @@ static int dev_mkdir(const char *name, umode_t mode=
)
>  {
>  	struct dentry *dentry;
>  	struct path path;
> -	int err;
> =20
>  	dentry =3D kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> =20
> -	err =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> -	if (!err)
> +	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode=
);
> +	if (!IS_ERR(dentry))
>  		/* mark as kernel-created inode */
>  		d_inode(dentry)->i_private =3D &thread;
>  	done_path_create(&path, dentry);
> -	return err;
> +	return PTR_ERR_OR_ZERO(dentry);
>  }
> =20
>  static int create_path(const char *nodepath)
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7cf59713f0f7..83a60126de0f 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -128,18 +128,19 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
>  		ret =3D security_path_mkdir(&path, subdir, 0700);
>  		if (ret < 0)
>  			goto mkdir_error;
> -		ret =3D cachefiles_inject_write_error();
> -		if (ret =3D=3D 0)
> -			ret =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> -		if (ret < 0) {
> +		subdir =3D ERR_PTR(cachefiles_inject_write_error());
> +		if (!IS_ERR(subdir))
> +			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +		ret =3D PTR_ERR(subdir);
> +		if (IS_ERR(subdir)) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
>  			goto mkdir_error;
>  		}
>  		trace_cachefiles_mkdir(dir, subdir);
> =20
> -		if (unlikely(d_unhashed(subdir))) {
> -			cachefiles_put_directory(subdir);
> +		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
> +			dput(subdir);
>  			goto retry;
>  		}
>  		ASSERT(d_backing_inode(subdir));
> @@ -195,7 +196,8 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> =20
>  mkdir_error:
>  	inode_unlock(d_inode(dir));
> -	dput(subdir);
> +	if (!IS_ERR(subdir))
> +		dput(subdir);
>  	pr_err("mkdir %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
> =20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 6315dd194228..51a5c54eb740 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -511,10 +511,16 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
>  	struct inode *lower_dir;
> =20
>  	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	if (!rc)
> -		rc =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
> -			       lower_dentry, mode);
> -	if (rc || d_really_is_negative(lower_dentry))
> +	if (rc)
> +		goto out;
> +
> +	lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
> +				 lower_dentry, mode);
> +	rc =3D PTR_ERR(lower_dentry);
> +	if (IS_ERR(lower_dentry))
> +		goto out;
> +	rc =3D 0;
> +	if (d_unhashed(lower_dentry))
>  		goto out;
>  	rc =3D ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
>  	if (rc)
> diff --git a/fs/init.c b/fs/init.c
> index e9387b6c4f30..eef5124885e3 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -230,9 +230,12 @@ int __init init_mkdir(const char *pathname, umode_t =
mode)
>  		return PTR_ERR(dentry);
>  	mode =3D mode_strip_umask(d_inode(path.dentry), mode);
>  	error =3D security_path_mkdir(&path, dentry, mode);
> -	if (!error)
> -		error =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +	if (!error) {
> +		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
>  				  dentry, mode);
> +		if (IS_ERR(dentry))
> +			error =3D PTR_ERR(dentry);
> +	}
>  	done_path_create(&path, dentry);
>  	return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 63fe4dc29c23..bd5eec2c0af4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4125,7 +4125,8 @@ EXPORT_SYMBOL(kern_path_create);
> =20
>  void done_path_create(struct path *path, struct dentry *dentry)
>  {
> -	dput(dentry);
> +	if (!IS_ERR(dentry))
> +		dput(dentry);
>  	inode_unlock(path->dentry->d_inode);
>  	mnt_drop_write(path->mnt);
>  	path_put(path);
> @@ -4271,7 +4272,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filenam=
e, umode_t, mode, unsigned, d
>  }
> =20
>  /**
> - * vfs_mkdir - create directory
> + * vfs_mkdir - create directory returning correct dentry if possible
>   * @idmap:	idmap of the mount the inode was found from
>   * @dir:	inode of the parent directory
>   * @dentry:	dentry of the child directory
> @@ -4284,9 +4285,15 @@ SYSCALL_DEFINE3(mknod, const char __user *, filena=
me, umode_t, mode, unsigned, d
>   * care to map the inode according to @idmap before checking permissions=
.
>   * On non-idmapped mounts or if permission checking is to be performed o=
n the
>   * raw inode simply pass @nop_mnt_idmap.
> + *
> + * In the event that the filesystem does not use the *@dentry but leaves=
 it
> + * negative or unhashes it and possibly splices a different one returnin=
g it,
> + * the original dentry is dput() and the alternate is returned.
> + *
> + * In case of an error the dentry is dput() and an ERR_PTR() is returned=
.
>   */
> -int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -	      struct dentry *dentry, umode_t mode)
> +struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> +			 struct dentry *dentry, umode_t mode)
>  {
>  	int error;
>  	unsigned max_links =3D dir->i_sb->s_max_links;
> @@ -4294,31 +4301,36 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct ino=
de *dir,
> =20
>  	error =3D may_create(idmap, dir, dentry);
>  	if (error)
> -		return error;
> +		goto err;
> =20
> +	error =3D -EPERM;
>  	if (!dir->i_op->mkdir)
> -		return -EPERM;
> +		goto err;
> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
>  	error =3D security_inode_mkdir(dir, dentry, mode);
>  	if (error)
> -		return error;
> +		goto err;
> =20
> +	error =3D -EMLINK;
>  	if (max_links && dir->i_nlink >=3D max_links)
> -		return -EMLINK;
> +		goto err;
> =20
>  	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	error =3D PTR_ERR(de);
>  	if (IS_ERR(de))
> -		return PTR_ERR(de);
> +		goto err;
>  	if (de) {
> -		fsnotify_mkdir(dir, de);
> -		/* Cannot return de yet */
> -		dput(de);
> -	} else {
> -		fsnotify_mkdir(dir, dentry);
> +		dput(dentry);
> +		dentry =3D de;
>  	}
> +	fsnotify_mkdir(dir, dentry);
> +	return dentry;
> =20
> -	return 0;
> +err:
> +	dput(dentry);
> +
> +	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
> =20
> @@ -4338,8 +4350,10 @@ int do_mkdirat(int dfd, struct filename *name, umo=
de_t mode)
>  	error =3D security_path_mkdir(&path, dentry,
>  			mode_strip_umask(path.dentry->d_inode, mode));
>  	if (!error) {
> -		error =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
>  				  dentry, mode);
> +		if (IS_ERR(dentry))
> +			error =3D PTR_ERR(dentry);
>  	}
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 28f4d5311c40..c1d9bd07285f 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -233,9 +233,12 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * as well be forgiving and just succeed silently.
>  		 */
>  		goto out_put;
> -	status =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	if (IS_ERR(dentry))
> +		status =3D PTR_ERR(dentry);
>  out_put:
> -	dput(dentry);
> +	if (!status)
> +		dput(dentry);
>  out_unlock:
>  	inode_unlock(d_inode(dir));
>  	if (status =3D=3D 0) {
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..34d7aa531662 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1461,7 +1461,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	struct inode	*dirp;
>  	struct iattr	*iap =3D attrs->na_iattr;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err =3D 0;
> =20
>  	dentry =3D fhp->fh_dentry;
>  	dirp =3D d_inode(dentry);
> @@ -1488,28 +1488,15 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct=
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
> +		dchild =3D vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> +		if (IS_ERR(dchild)) {
> +			host_err =3D PTR_ERR(dchild);
> +		} else if (d_is_negative(dchild)) {
> +			err =3D nfserr_serverfault;
> +			goto out;
> +		} else if (unlikely(dchild !=3D resfhp->fh_dentry)) {
>  			dput(resfhp->fh_dentry);
> -			resfhp->fh_dentry =3D dget(d);
> -			err =3D fh_update(resfhp);
> -			dput(dchild);
> -			dchild =3D d;
> -			if (err)
> -				goto out;
> +			resfhp->fh_dentry =3D dget(dchild);
>  		}
>  		break;
>  	case S_IFCHR:
> @@ -1530,7 +1517,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> =20
>  out:
> -	dput(dchild);
> +	if (!IS_ERR(dchild))
> +		dput(dchild);
>  	return err;
> =20
>  out_nfserr:
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 21c3aaf7b274..fe493f3ed6b6 100644
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
> @@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, st=
ruct inode *dir,
> =20
>  		case S_IFDIR:
>  			/* mkdir is special... */
> -			err =3D  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
> +			newdentry =3D  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
> +			err =3D PTR_ERR_OR_ZERO(newdentry);
>  			break;
> =20
>  		case S_IFCHR:
> @@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, st=
ruct inode *dir,
>  	}
>  out:
>  	if (err) {
> -		dput(newdentry);
> +		if (!IS_ERR(newdentry))
> +			dput(newdentry);
>  		return ERR_PTR(err);
>  	}
>  	return newdentry;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..6f2f8f4cfbbc 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  	return err;
>  }
> =20
> -static inline int ovl_do_mkdir(struct ovl_fs *ofs,
> -			       struct inode *dir, struct dentry *dentry,
> -			       umode_t mode)
> +static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
> +					  struct inode *dir,
> +					  struct dentry *dentry,
> +					  umode_t mode)
>  {
> -	int err =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> -	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, err);
> -	return err;
> +	dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> +	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZERO(den=
try));
> +	return dentry;
>  }
> =20
>  static inline int ovl_do_mknod(struct ovl_fs *ofs,
> @@ -838,8 +839,6 @@ struct ovl_cattr {
> =20
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
> =20
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode);
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>  			       struct inode *dir, struct dentry *newdentry,
>  			       struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 61e21c3129e8..b63474d1b064 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_=
fs *ofs,
>  			goto retry;
>  		}
> =20
> -		err =3D ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
> -		if (err)
> -			goto out_dput;
> +		work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> +		err =3D PTR_ERR(work);
> +		if (IS_ERR(work))
> +			goto out_err;
> =20
>  		/* Weird filesystem returning with hashed negative (kernfs)? */
>  		err =3D -EINVAL;
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index fe29acef5872..8554aa5a1059 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -206,8 +206,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct path path;
> -	struct dentry *dentry;
> -	int err;
> +	struct dentry *dentry, *d;
> +	int err =3D 0;
> =20
>  	dentry =3D ksmbd_vfs_kern_path_create(work, name,
>  					    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
> @@ -222,27 +222,15 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const =
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
> -		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
> -		dput(d);
> -	}
> +	d =3D dentry;
> +	dentry =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> +	if (IS_ERR(dentry))
> +		err =3D PTR_ERR(dentry);
> +	else if (d_is_negative(dentry))
> +		err =3D -ENOENT;
> +	if (!err && dentry !=3D d)
> +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
> =20
> -out_err:
>  	done_path_create(&path, dentry);
>  	if (err)
>  		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index c287c755f2c5..3537f3cca6d5 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -167,10 +167,11 @@ xrep_orphanage_create(
>  	 * directory to control access to a file we put in here.
>  	 */
>  	if (d_really_is_negative(orphanage_dentry)) {
> -		error =3D vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
> -				0750);
> -		if (error)
> -			goto out_dput_orphanage;
> +		orphanage_dentry =3D vfs_mkdir(&nop_mnt_idmap, root_inode,
> +					     orphanage_dentry, 0750);
> +		error =3D PTR_ERR(orphanage_dentry);
> +		if (IS_ERR(orphanage_dentry))
> +			goto out_unlock_root;
>  	}
> =20
>  	/* Not a directory? Bail out. */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8f4fbecd40fc..eaad8e31c0d4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1971,8 +1971,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap=
,
>   */
>  int vfs_create(struct mnt_idmap *, struct inode *,
>  	       struct dentry *, umode_t, bool);
> -int vfs_mkdir(struct mnt_idmap *, struct inode *,
> -	      struct dentry *, umode_t);
> +struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> +			 struct dentry *, umode_t);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                umode_t, dev_t);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,

Nice cleanup in the vfs_mkdir() callers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

