Return-Path: <linux-fsdevel+bounces-51019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3ABAD1D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1772D167793
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E2256C80;
	Mon,  9 Jun 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeJZYxob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6A253F1B;
	Mon,  9 Jun 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471786; cv=none; b=pbGOd8x+M7J0+XreRkkcoTAi93oeTBtExPDyHHb995hZ8E2OWkJRTryMUwWoB66/PY0E4Rh62CnE/08ULNLXSBeRCkYvAPaNktNtjxZ1UAoRm8jfcv4isNN1MC3sKEvwHBoxNENm4bA0CLYL+gzZu8TZRFeCBjYzzt3kwvVur/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471786; c=relaxed/simple;
	bh=LB1TZpHfpmb5QPwd5FGufWhq3Q4BEkr8aVwHbRoSwv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kgqf7GQQ5KzdJY14AxCAGM2T/K+lZWH18rny23lPvPiMHcIpVNZqu3G6FG23WC3CLtxYzAAzCR1XOsBuqHQSAWmiL+dWzJSi7vZ6QZ8P2qze06OQefbD0i1RpK4vsAk11eTLwIqf4G188zLb+yajO4aXgJ2OTsgCvWkxVuO8OSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeJZYxob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A6CC4CEED;
	Mon,  9 Jun 2025 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749471785;
	bh=LB1TZpHfpmb5QPwd5FGufWhq3Q4BEkr8aVwHbRoSwv4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AeJZYxobiWvRSvHMGKx8YMuoPo/N/lGN9VsbMC49ihQOs7MCUEuPI+7w6+ztichRr
	 n+HTiwGK8ONrdqYlRDcnObuB37/QrZLjj+ttbXp44xcJOycQ9H9Go3yb430y+p74FW
	 ittlJ4KqNt2ckdD6NVIZ+mqixGvzCKcXnK/q8tsI+BzQejABL8nOrJMNaoxphGJaB0
	 Vfoise1te12oMmUEW7KmFTp2i0VNQNoheo5V3UeP2Pxa/fiO93unSCj4rP9GAiyjsG
	 4T4pq+1tY2G6YwSWeqcJ7wf1THOshXDP8ak/z+10vo9skqOwZrmKO22gKqSbgQKC/2
	 Jg6nYxA9T8SGw==
Message-ID: <2c87a925de6e3470d205bcfae713a4dc5b3bb0a9.camel@kernel.org>
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever
	 <chuck.lever@oracle.com>, Amir Goldstein <amir73il@gmail.com>, Jan Harkes
	 <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>, Tyler Hicks
	 <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, Carlos Maiolino
	 <cem@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu,
 codalist@coda.cs.cmu.edu, 	linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Jun 2025 08:23:02 -0400
In-Reply-To: <20250608230952.20539-6-neil@brown.name>
References: <20250608230952.20539-1-neil@brown.name>
	 <20250608230952.20539-6-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 09:09 +1000, NeilBrown wrote:
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.
>=20
> vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> be unlocked.
>=20
> So change vfs_mkdir() to unlock on error as well as releasing the
> dentry.  This requires various other functions in various callers to
> also unlock on error.
>=20
> At present this results in some clumsy code.  Once the transition to
> dentry locking is complete the clumsiness will be gone.
>=20
> overlayfs looks particularly clumsy as in some cases a double-directory
> rename lock is taken, and a mkdir is then performed in one of the
> directories.  If that fails the other directory must be unlocked.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    | 10 +++++++---
>  fs/ecryptfs/inode.c      |  3 ++-
>  fs/namei.c               | 10 +++++++---
>  fs/nfsd/nfs4recover.c    | 12 +++++++-----
>  fs/nfsd/vfs.c            | 12 ++++++++++--
>  fs/overlayfs/copy_up.c   | 21 +++++++++++++++------
>  fs/overlayfs/dir.c       | 31 +++++++++++++++++++++++--------
>  fs/overlayfs/overlayfs.h |  1 +
>  fs/overlayfs/super.c     | 14 ++++++++++----
>  fs/xfs/scrub/orphanage.c |  2 +-
>  10 files changed, 83 insertions(+), 33 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index aecfc5c37b49..6644f0694169 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -131,8 +131,11 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
>  		ret =3D cachefiles_inject_write_error();
>  		if (ret =3D=3D 0)
>  			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> -		else
> +		else {
> +			/* vfs_mkdir() unlocks on failure so we must too */
> +			inode_unlock(d_inode(dir));
>  			subdir =3D ERR_PTR(ret);
> +		}
>  		if (IS_ERR(subdir)) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
> @@ -196,9 +199,10 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
>  	return ERR_PTR(-EBUSY);
> =20
>  mkdir_error:
> -	inode_unlock(d_inode(dir));
> -	if (!IS_ERR(subdir))
> +	if (!IS_ERR(subdir)) {
> +		inode_unlock(d_inode(dir));
>  		dput(subdir);
> +	}
>  	pr_err("mkdir %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
> =20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 493d7f194956..c513e912ae3c 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -520,7 +520,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>  				 lower_dentry, mode);
>  	rc =3D PTR_ERR(lower_dentry);
>  	if (IS_ERR(lower_dentry))
> -		goto out;
> +		goto out_unlocked;
>  	rc =3D 0;
>  	if (d_unhashed(lower_dentry))
>  		goto out;
> @@ -532,6 +532,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>  	set_nlink(dir, lower_dir->i_nlink);
>  out:
>  	inode_unlock(lower_dir);
> +out_unlocked:
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return ERR_PTR(rc);
> diff --git a/fs/namei.c b/fs/namei.c
> index dc42bfac5c57..cefbb681d2f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4163,9 +4163,10 @@ EXPORT_SYMBOL(kern_path_create);
> =20
>  void done_path_create(struct path *path, struct dentry *dentry)
>  {
> -	if (!IS_ERR(dentry))
> +	if (!IS_ERR(dentry)) {
>  		dput(dentry);
> -	inode_unlock(path->dentry->d_inode);
> +		inode_unlock(path->dentry->d_inode);
> +	}
>  	mnt_drop_write(path->mnt);
>  	path_put(path);
>  }
> @@ -4328,7 +4329,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filenam=
e, umode_t, mode, unsigned, d
>   * negative or unhashes it and possibly splices a different one returnin=
g it,
>   * the original dentry is dput() and the alternate is returned.
>   *
> - * In case of an error the dentry is dput() and an ERR_PTR() is returned=
.
> + * In case of an error the dentry is dput(), the parent is unlocked, and
> + * an ERR_PTR() is returned.
>   */
>  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  			 struct dentry *dentry, umode_t mode)
> @@ -4366,6 +4368,8 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  	return dentry;
> =20
>  err:
> +	/* Caller only needs to unlock if dentry is not an error */
> +	inode_unlock(dir);
>  	dput(dentry);
>  	return ERR_PTR(error);
>  }
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 82785db730d9..5aedadebebe4 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -222,7 +222,8 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
>  	if (IS_ERR(dentry)) {
>  		status =3D PTR_ERR(dentry);
> -		goto out_unlock;
> +		inode_unlock(d_inode(dir));
> +		goto out;
>  	}
>  	if (d_really_is_positive(dentry))
>  		/*
> @@ -235,13 +236,14 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 */
>  		goto out_put;
>  	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> -	if (IS_ERR(dentry))
> +	if (IS_ERR(dentry)) {
>  		status =3D PTR_ERR(dentry);
> +		goto out;
> +	}
>  out_put:
> -	if (!status)
> -		dput(dentry);
> -out_unlock:
> +	dput(dentry);
>  	inode_unlock(d_inode(dir));
> +out:
>  	if (status =3D=3D 0) {
>  		if (nn->in_grace)
>  			__nfsd4_create_reclaim_record_grace(clp, dname,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd689df2ca5d..be29a18a23b2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1489,7 +1489,9 @@ nfsd_check_ignore_resizing(struct iattr *iap)
>  		iap->ia_valid &=3D ~ATTR_SIZE;
>  }
> =20
> -/* The parent directory should already be locked: */
> +/* The parent directory should already be locked.  The lock
> + * will be dropped on error.
> + */
>  __be32
>  nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		   struct nfsd_attrs *attrs,
> @@ -1555,8 +1557,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> =20
>  out:
> -	if (!IS_ERR(dchild))
> +	if (!IS_ERR(dchild)) {
> +		if (err)
> +			inode_unlock(dirp);
>  		dput(dchild);
> +	}
>  	return err;
> =20
>  out_nfserr:
> @@ -1613,6 +1618,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	if (err !=3D nfs_ok)
>  		goto out_unlock;
>  	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> +	if (err)
> +		/* lock will have been dropped */
> +		return err;
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
>  	inode_unlock(dentry->d_inode);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d7310fcf3888..324429d02569 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -518,7 +518,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struc=
t dentry *upper,
>  /*
>   * Create and install index entry.
>   *
> - * Caller must hold i_mutex on indexdir.
> + * Caller must hold i_mutex on indexdir.  It will be unlocked on error.
>   */
>  static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *=
fh,
>  			    struct dentry *upper)
> @@ -539,16 +539,22 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
>  	 * TODO: implement create index for non-dir, so we can call it when
>  	 * encoding file handle for non-dir in case index does not exist.
>  	 */
> -	if (WARN_ON(!d_is_dir(dentry)))
> +	if (WARN_ON(!d_is_dir(dentry))) {
> +		inode_unlock(dir);
>  		return -EIO;
> +	}
> =20
>  	/* Directory not expected to be indexed before copy up */
> -	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry))))
> +	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry)))) {
> +		inode_unlock(dir);
>  		return -EIO;
> +	}
> =20
>  	err =3D ovl_get_index_name_fh(fh, &name);
> -	if (err)
> +	if (err) {
> +		inode_unlock(dir);
>  		return err;
> +	}
> =20
>  	temp =3D ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
>  	err =3D PTR_ERR(temp);
> @@ -567,8 +573,10 @@ static int ovl_create_index(struct dentry *dentry, c=
onst struct ovl_fh *fh,
>  		dput(index);
>  	}
>  out:
> -	if (err)
> +	if (err) {
>  		ovl_cleanup(ofs, dir, temp);
> +		inode_unlock(dir);
> +	}
>  	dput(temp);
>  free_name:
>  	kfree(name.name);
> @@ -781,7 +789,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  	ovl_start_write(c->dentry);
>  	inode_lock(wdir);
>  	temp =3D ovl_create_temp(ofs, c->workdir, &cattr);
> -	inode_unlock(wdir);
> +	if (!IS_ERR(wdir))
> +		inode_unlock(wdir);
>  	ovl_end_write(c->dentry);
>  	ovl_revert_cu_creds(&cc);
> =20
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index fe493f3ed6b6..b4d92b51b63f 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -138,13 +138,16 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct inode *dir,
>  	goto out;
>  }
> =20
> +/* dir will be unlocked on failure */
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  			       struct dentry *newdentry, struct ovl_cattr *attr)
>  {
>  	int err;
> =20
> -	if (IS_ERR(newdentry))
> +	if (IS_ERR(newdentry)) {
> +		inode_unlock(dir);
>  		return newdentry;
> +	}
> =20
>  	err =3D -ESTALE;
>  	if (newdentry->d_inode)
> @@ -189,13 +192,16 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct inode *dir,
>  	}
>  out:
>  	if (err) {
> -		if (!IS_ERR(newdentry))
> +		if (!IS_ERR(newdentry)) {
> +			inode_unlock(dir);
>  			dput(newdentry);
> +		}
>  		return ERR_PTR(err);
>  	}
>  	return newdentry;
>  }
> =20
> +/* Note workdir will be unlocked on failure */
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>  			       struct ovl_cattr *attr)
>  {
> @@ -309,7 +315,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>  				    attr);
>  	err =3D PTR_ERR(newdentry);
>  	if (IS_ERR(newdentry))
> -		goto out_unlock;
> +		goto out;
> =20
>  	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>  	    !ovl_allow_offline_changes(ofs)) {
> @@ -323,6 +329,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>  		goto out_cleanup;
>  out_unlock:
>  	inode_unlock(udir);
> +out:
>  	return err;
> =20
>  out_cleanup:
> @@ -367,9 +374,12 @@ static struct dentry *ovl_clear_empty(struct dentry =
*dentry,
> =20
>  	opaquedir =3D ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
>  	err =3D PTR_ERR(opaquedir);
> -	if (IS_ERR(opaquedir))
> -		goto out_unlock;
> -
> +	if (IS_ERR(opaquedir)) {
> +		/* workdir was unlocked, no upperdir */
> +		inode_unlock(upperdir->d_inode);
> +		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
> +		return ERR_PTR(err);
> +	}
>  	err =3D ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
>  	if (err)
>  		goto out_cleanup;
> @@ -455,8 +465,13 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
> =20
>  	newdentry =3D ovl_create_temp(ofs, workdir, cattr);
>  	err =3D PTR_ERR(newdentry);
> -	if (IS_ERR(newdentry))
> -		goto out_dput;
> +	if (IS_ERR(newdentry)) {
> +		/* workdir was unlocked, not upperdir */
> +		inode_unlock(upperdir->d_inode);
> +		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
> +		dput(upper);
> +		goto out;
> +	}
> =20
>  	/*
>  	 * mode could have been mutilated due to umask (e.g. sgid directory)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 8baaba0a3fe5..44df3a2449e7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -248,6 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
>  {
>  	dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
>  	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZERO(den=
try));
> +	/* Note: dir will have been unlocked on failure */
>  	return dentry;
>  }
> =20
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e19940d649ca..5f3267e919dd 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -366,14 +366,17 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>  			goto out_dput;
>  	} else {
>  		err =3D PTR_ERR(work);
> +		inode_unlock(dir);
>  		goto out_err;
>  	}
>  out_unlock:
> -	inode_unlock(dir);
> +	if (work && !IS_ERR(work))
> +		inode_unlock(dir);
>  	return work;
> =20
>  out_dput:
>  	dput(work);
> +	inode_unlock(dir);
>  out_err:
>  	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-on=
ly\n",
>  		ofs->config.workdir, name, -err);
> @@ -569,7 +572,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *o=
fs)
>  	temp =3D ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
>  	err =3D PTR_ERR(temp);
>  	if (IS_ERR(temp))
> -		goto out_unlock;
> +		return err;
> =20
>  	dest =3D ovl_lookup_temp(ofs, workdir);
>  	err =3D PTR_ERR(dest);
> @@ -620,10 +623,13 @@ static struct dentry *ovl_lookup_or_create(struct o=
vl_fs *ofs,
> =20
>  	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
>  	child =3D ovl_lookup_upper(ofs, name, parent, len);
> -	if (!IS_ERR(child) && !child->d_inode)
> +	if (!IS_ERR(child) && !child->d_inode) {
>  		child =3D ovl_create_real(ofs, parent->d_inode, child,
>  					OVL_CATTR(mode));
> -	inode_unlock(parent->d_inode);
> +		if (!IS_ERR(child))
> +			inode_unlock(parent->d_inode);
> +	} else
> +		inode_unlock(parent->d_inode);
>  	dput(parent);
> =20
>  	return child;
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 9c12cb844231..c95bded4e8a7 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -170,7 +170,7 @@ xrep_orphanage_create(
>  					     orphanage_dentry, 0750);
>  		error =3D PTR_ERR(orphanage_dentry);
>  		if (IS_ERR(orphanage_dentry))
> -			goto out_unlock_root;
> +			goto out_dput_root;
>  	}
> =20
>  	/* Not a directory? Bail out. */

The patch looks sane at first glance, but you're correct that it makes
the code uglier for now. Assuming that later cleanup will improve
things:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

