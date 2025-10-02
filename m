Return-Path: <linux-fsdevel+bounces-63314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1ACBB49D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B887AA9EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E48238C0B;
	Thu,  2 Oct 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYwTPx1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240E2F872
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424543; cv=none; b=S7DGRTBWHEpL7JCo1fp3yXReauM34+wBG036qlxE1qAeohVX0DDsNeQO4/tshLkXRN5RcAtIpvooobbEk3GK66hMcnZOWvDUjKvmSAQ1VLwpXZzQhd9VwvGe/WVMwBot/3t3FlC49a0byIrXCxh2k2xtk+zpvaUYe3s3iL5R+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424543; c=relaxed/simple;
	bh=W7Mhfv1IaHuNCglFjLSlDnErWGWub++cX4XVVQk8XmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukUyK8ZHvEW+BTaV0yhNxlmBFyBLU3AgBrLv7Ao6Os2pPfpnq/MTYE75C672LlWT4GXgqNOnTGKF2USh6HL4UlfIi0Q1AxhyJ83M3qOmcy6T9HpLEP7D4VRBzHUGRu0eUY3JKA5Wntn3duuZY9H455AWwvRYHTGxQvxcnhZ1KtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYwTPx1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F1C4CEF4;
	Thu,  2 Oct 2025 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759424542;
	bh=W7Mhfv1IaHuNCglFjLSlDnErWGWub++cX4XVVQk8XmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QYwTPx1bdptiFf5AgxGPXy7SCP7BnOCltZL1Vd0lEe4f6ip4zFjF1kr87lD/U0i5o
	 HJ2jnQg3XBhUNUXKlWJfbxznXpumyQf5QUXa6flW0Nhzbx3nt4vSzMUfGixZ5n+xJt
	 N1xaNA9MAXlMqFzv0RocSme8lp/BYkc6oJRlx676lKm4YIB36jyRjipGp2e4FFuSoZ
	 1SKcjvBTpVx4VDM5/BcA3zndDzt2ya0mNGivhTKDuu+/ZWm86Bx90twNBaDrW0UKbH
	 D1CnAEAtw6iFdnXO8GJFzk44Gx0Ae99eOzH2bgnV8EHFlzSqQEQy6+bJQ16krv+XoM
	 L+h2Uk+gXCnDw==
Message-ID: <f82fe0ab3f805c5e51d005555152d70f9b5293f5.camel@kernel.org>
Subject: Re: [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce
 start_removing() and end_removing()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Date: Thu, 02 Oct 2025 13:02:20 -0400
In-Reply-To: <20250926025015.1747294-5-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
	 <20250926025015.1747294-5-neilb@ownmail.net>
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
> start_removing() is similar to start_creating() but will only return a
> positive dentry with the expectation that it will be removed.  This is
> used by nfsd, cachefiles, and overlayfs.  They are changed to also use
> end_removing() to terminate the action begun by start_removing().  This
> is a simple alias for end_dirop().
>=20
> Apart from changes to the error paths, as we no longer need to unlock on
> a lookup error, an effect on callers is that they don't need to test if
> the found dentry is positive or negative - they can be sure it is
> positive.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    | 25 ++++++++++---------------
>  fs/namei.c               | 27 +++++++++++++++++++++++++++
>  fs/nfsd/nfs4recover.c    | 18 +++++-------------
>  fs/nfsd/vfs.c            | 26 ++++++++++----------------
>  fs/overlayfs/dir.c       | 15 +++++++--------
>  fs/overlayfs/overlayfs.h |  8 ++++++++
>  include/linux/namei.h    | 17 +++++++++++++++++
>  7 files changed, 84 insertions(+), 52 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 965b22b2f58d..3064d439807b 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache =
*cache,
>   * - File backed objects are unlinked
>   * - Directory backed objects are stuffed into the graveyard for userspa=
ce to
>   *   delete
> + * On entry dir must be locked.  It will be unlocked on exit.
>   */
>  int cachefiles_bury_object(struct cachefiles_cache *cache,
>  			   struct cachefiles_object *object,
> @@ -275,7 +276,8 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
>  	_enter(",'%pd','%pd'", dir, rep);
> =20
>  	if (rep->d_parent !=3D dir) {
> -		inode_unlock(d_inode(dir));
> +		dget(rep);
> +		end_removing(rep);
>  		_leave(" =3D -ESTALE");
>  		return -ESTALE;
>  	}
> @@ -286,16 +288,16 @@ int cachefiles_bury_object(struct cachefiles_cache =
*cache,
>  			    * by a file struct.
>  			    */
>  		ret =3D cachefiles_unlink(cache, object, dir, rep, why);
> -		dput(rep);
> +		end_removing(rep);
> =20
> -		inode_unlock(d_inode(dir));
>  		_leave(" =3D %d", ret);
>  		return ret;
>  	}
> =20
>  	/* directories have to be moved to the graveyard */
>  	_debug("move stale object to graveyard");
> -	inode_unlock(d_inode(dir));
> +	dget(rep);
> +	end_removing(rep);
> =20
>  try_again:
>  	/* first step is to make up a grave dentry in the graveyard */
> @@ -745,26 +747,20 @@ static struct dentry *cachefiles_lookup_for_cull(st=
ruct cachefiles_cache *cache,
>  	struct dentry *victim;
>  	int ret =3D -ENOENT;
> =20
> -	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> +	victim =3D start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
> =20
> -	victim =3D lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
>  	if (IS_ERR(victim))
>  		goto lookup_error;
> -	if (d_is_negative(victim))
> -		goto lookup_put;
>  	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
>  		goto lookup_busy;
>  	return victim;
> =20
>  lookup_busy:
>  	ret =3D -EBUSY;
> -lookup_put:
> -	inode_unlock(d_inode(dir));
> -	dput(victim);
> +	end_removing(victim);
>  	return ERR_PTR(ret);
> =20
>  lookup_error:
> -	inode_unlock(d_inode(dir));
>  	ret =3D PTR_ERR(victim);
>  	if (ret =3D=3D -ENOENT)
>  		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
> @@ -812,18 +808,17 @@ int cachefiles_cull(struct cachefiles_cache *cache,=
 struct dentry *dir,
> =20
>  	ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
>  				     FSCACHE_OBJECT_WAS_CULLED);
> +	dput(victim);
>  	if (ret < 0)
>  		goto error;
> =20
>  	fscache_count_culled();
> -	dput(victim);
>  	_leave(" =3D 0");
>  	return 0;
> =20
>  error_unlock:
> -	inode_unlock(d_inode(dir));
> +	end_removing(victim);
>  error:
> -	dput(victim);
>  	if (ret =3D=3D -ENOENT)
>  		return -ESTALE; /* Probably got retired by the netfs */
> =20
> diff --git a/fs/namei.c b/fs/namei.c
> index 064cb44a3a46..0d9e98961758 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3269,6 +3269,33 @@ struct dentry *start_creating(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_creating);
> =20
> +/**
> + * start_removing - prepare to remove a given name with permission check=
ing
> + * @idmap - idmap of the mount
> + * @parent - directory in which to find the name
> + * @name - the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.  Permission checking (MAY_EXEC) is perfor=
med
> + * against @idmap.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +			      struct qstr *name)
> +{
> +	int err =3D lookup_one_common(idmap, name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return start_dirop(parent, name, 0);
> +}
> +EXPORT_SYMBOL(start_removing);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 93b2a3e764db..0f33e13a9da2 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -345,20 +345,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *=
nn)
>  	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
> =20
>  	dir =3D nn->rec_file->f_path.dentry;
> -	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> -	dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
> -	if (IS_ERR(dentry)) {
> -		status =3D PTR_ERR(dentry);
> -		goto out_unlock;
> -	}
> -	status =3D -ENOENT;
> -	if (d_really_is_negative(dentry))
> -		goto out;
> +	dentry =3D start_removing(&nop_mnt_idmap, dir, &QSTR(name));
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
>  	status =3D vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
> -out:
> -	dput(dentry);
> -out_unlock:
> -	inode_unlock(d_inode(dir));
> +	end_removing(dentry);
>  	return status;
>  }
> =20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 90c830c59c60..d5b4550fd8f6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2021,7 +2021,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  {
>  	struct dentry	*dentry, *rdentry;
>  	struct inode	*dirp;
> -	struct inode	*rinode;
> +	struct inode	*rinode =3D NULL;
>  	__be32		err;
>  	int		host_err;
> =20
> @@ -2040,24 +2040,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> =20
>  	dentry =3D fhp->fh_dentry;
>  	dirp =3D d_inode(dentry);
> -	inode_lock_nested(dirp, I_MUTEX_PARENT);
> =20
> -	rdentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
> +	rdentry =3D start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, fle=
n));
> +
>  	host_err =3D PTR_ERR(rdentry);
>  	if (IS_ERR(rdentry))
> -		goto out_unlock;
> +		goto out_drop_write;
> =20
> -	if (d_really_is_negative(rdentry)) {
> -		dput(rdentry);
> -		host_err =3D -ENOENT;
> -		goto out_unlock;
> -	}
> -	rinode =3D d_inode(rdentry);
>  	err =3D fh_fill_pre_attrs(fhp);
>  	if (err !=3D nfs_ok)
>  		goto out_unlock;
> =20
> +	rinode =3D d_inode(rdentry);
> +	/* Prevent truncation until after locks dropped */
>  	ihold(rinode);
> +
>  	if (!type)
>  		type =3D d_inode(rdentry)->i_mode & S_IFMT;
> =20
> @@ -2079,10 +2076,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
>  	}
>  	fh_fill_post_attrs(fhp);
> =20
> -	inode_unlock(dirp);
> -	if (!host_err)
> +out_unlock:
> +	end_removing(rdentry);
> +	if (!err && !host_err)
>  		host_err =3D commit_metadata(fhp);
> -	dput(rdentry);
>  	iput(rinode);    /* truncate the inode here */
> =20
>  out_drop_write:
> @@ -2100,9 +2097,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	}
>  out:
>  	return err !=3D nfs_ok ? err : nfserrno(host_err);
> -out_unlock:
> -	inode_unlock(dirp);
> -	goto out_drop_write;
>  }
>=20
>=20

I like how the new helper simplifies this code.

> =20
>  /*
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0ae79efbfce7..c4057b4a050d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -841,17 +841,17 @@ static int ovl_remove_upper(struct dentry *dentry, =
bool is_dir,
>  			goto out;
>  	}
> =20
> -	inode_lock_nested(dir, I_MUTEX_PARENT);
> -	upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -				 dentry->d_name.len);
> +	upper =3D ovl_start_removing_upper(ofs, upperdir,
> +					 &QSTR_LEN(dentry->d_name.name,
> +						   dentry->d_name.len));
>  	err =3D PTR_ERR(upper);
>  	if (IS_ERR(upper))
> -		goto out_unlock;
> +		goto out_dput;
> =20
>  	err =3D -ESTALE;
>  	if ((opaquedir && upper !=3D opaquedir) ||
>  	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
> -		goto out_dput_upper;
> +		goto out_unlock;
> =20
>  	if (is_dir)
>  		err =3D ovl_do_rmdir(ofs, dir, upper);
> @@ -867,10 +867,9 @@ static int ovl_remove_upper(struct dentry *dentry, b=
ool is_dir,
>  	 */
>  	if (!err)
>  		d_drop(dentry);
> -out_dput_upper:
> -	dput(upper);
>  out_unlock:
> -	inode_unlock(dir);
> +	end_removing(upper);
> +out_dput:
>  	dput(opaquedir);
>  out:
>  	return err;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index c24c2da953bd..915af58459b7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -423,6 +423,14 @@ static inline struct dentry *ovl_start_creating_uppe=
r(struct ovl_fs *ofs,
>  			      parent, name);
>  }
> =20
> +static inline struct dentry *ovl_start_removing_upper(struct ovl_fs *ofs=
,
> +						      struct dentry *parent,
> +						      struct qstr *name)
> +{
> +	return start_removing(ovl_upper_mnt_idmap(ofs),
> +			      parent, name);
> +}
> +
>  static inline bool ovl_open_flags_need_copy_up(int flags)
>  {
>  	if (!flags)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 4cbe930054a1..63941fdbc23d 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -90,6 +90,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_=
idmap *idmap,
> =20
>  struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>  			      struct qstr *name);
> +struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +			      struct qstr *name);
> =20
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
> @@ -106,6 +108,21 @@ static inline void end_creating(struct dentry *child=
, struct dentry *parent)
>  	end_dirop_mkdir(child, parent);
>  }
> =20
> +/* end_removing - finish action started with start_removing
> + * @child - dentry returned by start_removing()
> + * @parent - dentry given to start_removing()
> + *
> + * Unlock and release the child.
> + *
> + * This is identical to end_dirop().  It can be passed the result of
> + * start_removing() whether that was successful or not, but it not neede=
d
> + * if start_removing() failed.
> + */
> +static inline void end_removing(struct dentry *child)
> +{
> +	end_dirop(child);
> +}
> +
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);


Reviewed-by: Jeff Layton <jlayton@kernel.org>

