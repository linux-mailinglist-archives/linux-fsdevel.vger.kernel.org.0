Return-Path: <linux-fsdevel+bounces-63030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A025BA9373
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AEF17D082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F693054CB;
	Mon, 29 Sep 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKzBIkb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B7191
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149471; cv=none; b=f4OKgbE7XNhFhQrGUo0v8FssobjCpY4qJHayoGNzHgFBCKU1HHiUMD+I0galQxOnNySnJQoNKJgin1powKaaMsIqu4gbK6kgyI2B/eB/VqPE8c6fwoi5ShAaM8GaipHxR9FDQ3Oa1djhbk8kK2hKUg/VCO7ZjlN4oI9L20p0Z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149471; c=relaxed/simple;
	bh=wHYuTFVEaRzgAQVzEceYLtBSFIVAfOKYATIZn9qLFOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2q20oHeUMjluFOq4u5Vvn9s782lIeG+p5mJovkPUeSeQob1BabYhiKDaUymouOTJMRVp3iEvnbsZJBP6Y6E+Wm0fF7PTwElhKzj3v2yq7Smm88BKCIvADca9Dt+ec4P9m2fvrYvYXFXjuwkTPylaj5RUe+XhQ5jQoP4beViGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKzBIkb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782B5C4CEF4;
	Mon, 29 Sep 2025 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759149471;
	bh=wHYuTFVEaRzgAQVzEceYLtBSFIVAfOKYATIZn9qLFOc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UKzBIkb+hG+1wFyRQMI1aJ0GE1Qyugl00Ta9pKlQSgbOUmUhoNc+Y5WR6ILMOHEuv
	 Gua0RLbsXHtvJTZhlCHnWhBhccIjHjq8HiaGSokdUI+nbSx3GuBtxfeiYJaFEpxLc9
	 k4NkOl674WE1rVk2mEiTIgZ42euFk5NPGJ+PN0F+rfwx0m+tcxRw6CcX5Y0LMNrUN4
	 CA38KiUsWIpvuxYypJ7bx0wgPWHimc0kONZx4AWCiBwgvvJifLhsehg4MM2cSo6t5H
	 vF8ICrO6M4gVtHunA1Em11pFUcY/cmpgHZDZ/LhqZJoek4/+cxBVfc6DAaqEmKYU8i
	 dWPSQDWSjjMIw==
Message-ID: <ac7482e19782ad9a0bb928253247c8860ed53ab8.camel@kernel.org>
Subject: Re: [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
 end_creating()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Date: Mon, 29 Sep 2025 08:37:49 -0400
In-Reply-To: <20250926025015.1747294-4-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
	 <20250926025015.1747294-4-neilb@ownmail.net>
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
> start_creating() is similar to simple_start_creating() but is not so
> simple.
> It takes a qstr for the name, includes permission checking, and does NOT
> report an error if the name already exists, returning a positive dentry
> instead.
>=20
> This is currently used by nfsd, cachefiles, and overlayfs.
>=20
> end_creating() is called after the dentry has been used.
> end_creating() drops the reference to the dentry as it is generally no
> longer needed.  This is exactly end_dirop_mkdir(),
> but using that everywhere looks a bit odd...
>=20
> These calls help encapsulate locking rules so that directory locking can
> be changed.
>=20
> Occasionally this change means that the parent lock is held for a
> shorter period of time, for example in cachefiles_commit_tmpfile().
> As this function now unlocks after an unlink and before the following
> lookup, it is possible that the lookup could again find a positive
> dentry, so a while loop is introduced there.
>=20
> In overlayfs the ovl_lookup_temp() function has ovl_tempname()
> split out to be used in ovl_start_creating_temp().  The other use
> of ovl_lookup_temp() is preparing for a rename.  When rename handling
> is updated, ovl_lookup_temp() will be removed.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    | 37 ++++++++--------
>  fs/namei.c               | 27 ++++++++++++
>  fs/nfsd/nfs3proc.c       | 14 +++---
>  fs/nfsd/nfs4proc.c       | 14 +++---
>  fs/nfsd/nfs4recover.c    | 16 +++----
>  fs/nfsd/nfsproc.c        | 11 +++--
>  fs/nfsd/vfs.c            | 42 +++++++-----------
>  fs/overlayfs/copy_up.c   | 19 ++++----
>  fs/overlayfs/dir.c       | 94 ++++++++++++++++++++++++----------------
>  fs/overlayfs/overlayfs.h |  8 ++++
>  fs/overlayfs/super.c     | 32 +++++++-------
>  include/linux/namei.h    | 18 ++++++++
>  12 files changed, 187 insertions(+), 145 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d1edb2ac3837..965b22b2f58d 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -93,12 +93,11 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  	_enter(",,%s", dirname);
> =20
>  	/* search the current directory for the element name */
> -	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> =20
>  retry:
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
> -		subdir =3D lookup_one(&nop_mnt_idmap, &QSTR(dirname), dir);
> +		subdir =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dirname));
>  	else
>  		subdir =3D ERR_PTR(ret);
>  	trace_cachefiles_lookup(NULL, dir, subdir);
> @@ -141,7 +140,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  		trace_cachefiles_mkdir(dir, subdir);
> =20
>  		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
> -			dput(subdir);
> +			end_creating(subdir, dir);
>  			goto retry;
>  		}
>  		ASSERT(d_backing_inode(subdir));
> @@ -154,7 +153,8 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> =20
>  	/* Tell rmdir() it's not allowed to delete the subdir */
>  	inode_lock(d_inode(subdir));
> -	inode_unlock(d_inode(dir));
> +	dget(subdir);
> +	end_creating(subdir, dir);
> =20
>  	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
>  		pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx)\n",
> @@ -196,14 +196,11 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
>  	return ERR_PTR(-EBUSY);
> =20
>  mkdir_error:
> -	inode_unlock(d_inode(dir));
> -	if (!IS_ERR(subdir))
> -		dput(subdir);
> +	end_creating(subdir, dir);
>  	pr_err("mkdir %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
> =20
>  lookup_error:
> -	inode_unlock(d_inode(dir));
>  	ret =3D PTR_ERR(subdir);
>  	pr_err("Lookup %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
> @@ -679,36 +676,37 @@ bool cachefiles_commit_tmpfile(struct cachefiles_ca=
che *cache,
> =20
>  	_enter(",%pD", object->file);
> =20
> -	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
>  	ret =3D cachefiles_inject_read_error();
>  	if (ret =3D=3D 0)
> -		dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
> +		dentry =3D start_creating(&nop_mnt_idmap, fan, &QSTR(object->d_name));
>  	else
>  		dentry =3D ERR_PTR(ret);
>  	if (IS_ERR(dentry)) {
>  		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
>  					   cachefiles_trace_lookup_error);
>  		_debug("lookup fail %ld", PTR_ERR(dentry));
> -		goto out_unlock;
> +		goto out;
>  	}
> =20
> -	if (!d_is_negative(dentry)) {
> +	while (!d_is_negative(dentry)) {

Can you explain why this changed from an if to a while? The existing
code doesn't seem to ever retry this operation.

>  		ret =3D cachefiles_unlink(volume->cache, object, fan, dentry,
>  					FSCACHE_OBJECT_IS_STALE);
>  		if (ret < 0)
> -			goto out_dput;
> +			goto out_end;
> +
> +		end_creating(dentry, fan);
> =20
> -		dput(dentry);
>  		ret =3D cachefiles_inject_read_error();
>  		if (ret =3D=3D 0)
> -			dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(object->d_name), fan);
> +			dentry =3D start_creating(&nop_mnt_idmap, fan,
> +						&QSTR(object->d_name));
>  		else
>  			dentry =3D ERR_PTR(ret);
>  		if (IS_ERR(dentry)) {
>  			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
>  						   cachefiles_trace_lookup_error);
>  			_debug("lookup fail %ld", PTR_ERR(dentry));
> -			goto out_unlock;
> +			goto out;
>  		}
>  	}
> =20
> @@ -729,10 +727,9 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cac=
he *cache,
>  		success =3D true;
>  	}
> =20
> -out_dput:
> -	dput(dentry);
> -out_unlock:
> -	inode_unlock(d_inode(fan));
> +out_end:
> +	end_creating(dentry, fan);
> +out:
>  	_leave(" =3D %u", success);
>  	return success;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 81cbaabbbe21..064cb44a3a46 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3242,6 +3242,33 @@ struct dentry *lookup_noperm_positive_unlocked(str=
uct qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
> =20
> +/**
> + * start_creating - prepare to create a given name with permission check=
ing
> + * @idmap - idmap of the mount
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating
> + * an object in a directory.  Permission checking (MAY_EXEC) is performe=
d
> + * against @idmap.
> + *
> + * If the name already exists, a positive dentry is returned, so
> + * behaviour is similar to O_CREAT without O_EXCL, which doesn't fail
> + * with -EEXIST.
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +			      struct qstr *name)
> +{
> +	int err =3D lookup_one_common(idmap, name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return start_dirop(parent, name, LOOKUP_CREATE);
> +}
> +EXPORT_SYMBOL(start_creating);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7..e2aac0def2cb 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -281,14 +281,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	if (host_err)
>  		return nfserrno(host_err);
> =20
> -	inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -	child =3D lookup_one(&nop_mnt_idmap,
> -			   &QSTR_LEN(argp->name, argp->len),
> -			   parent);
> +	child =3D start_creating(&nop_mnt_idmap, parent,
> +			       &QSTR_LEN(argp->name, argp->len));
>  	if (IS_ERR(child)) {
>  		status =3D nfserrno(PTR_ERR(child));
> -		goto out;
> +		goto out_write;
>  	}
> =20
>  	if (d_really_is_negative(child)) {
> @@ -367,9 +364,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> =20
>  out:
> -	inode_unlock(inode);
> -	if (child && !IS_ERR(child))
> -		dput(child);
> +	end_creating(child, parent);
> +out_write:
>  	fh_drop_write(fhp);
>  	return status;
>  }
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..35d48221072f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -264,14 +264,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	if (is_create_with_attrs(open))
>  		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> =20
> -	inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -	child =3D lookup_one(&nop_mnt_idmap,
> -			   &QSTR_LEN(open->op_fname, open->op_fnamelen),
> -			   parent);
> +	child =3D start_creating(&nop_mnt_idmap, parent,
> +			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
>  	if (IS_ERR(child)) {
>  		status =3D nfserrno(PTR_ERR(child));
> -		goto out;
> +		goto out_write;
>  	}
> =20
>  	if (d_really_is_negative(child)) {
> @@ -379,10 +376,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  	if (attrs.na_aclerr)
>  		open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
>  out:
> -	inode_unlock(inode);
> +	end_creating(child, parent);
>  	nfsd_attrs_free(&attrs);
> -	if (child && !IS_ERR(child))
> -		dput(child);
> +out_write:
>  	fh_drop_write(fhp);
>  	return status;
>  }
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2231192ec33f..93b2a3e764db 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -216,13 +216,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		goto out_creds;
> =20
>  	dir =3D nn->rec_file->f_path.dentry;
> -	/* lock the parent */
> -	inode_lock(d_inode(dir));
> =20
> -	dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
> +	dentry =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dname));
>  	if (IS_ERR(dentry)) {
>  		status =3D PTR_ERR(dentry);
> -		goto out_unlock;
> +		goto out;
>  	}
>  	if (d_really_is_positive(dentry))
>  		/*
> @@ -233,15 +231,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * In the 4.0 case, we should never get here; but we may
>  		 * as well be forgiving and just succeed silently.
>  		 */
> -		goto out_put;
> +		goto out_end;
>  	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
>  	if (IS_ERR(dentry))
>  		status =3D PTR_ERR(dentry);
> -out_put:
> -	if (!status)
> -		dput(dentry);
> -out_unlock:
> -	inode_unlock(d_inode(dir));
> +out_end:
> +	end_creating(dentry, dir);
> +out:
>  	if (status =3D=3D 0) {
>  		if (nn->in_grace)
>  			__nfsd4_create_reclaim_record_grace(clp, dname,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8f71f5748c75..ee1b16e921fd 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -306,18 +306,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		goto done;
>  	}
> =20
> -	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> -	dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(argp->name, argp->len),
> -			    dirfhp->fh_dentry);
> +	dchild =3D start_creating(&nop_mnt_idmap, dirfhp->fh_dentry,
> +				&QSTR_LEN(argp->name, argp->len));
>  	if (IS_ERR(dchild)) {
>  		resp->status =3D nfserrno(PTR_ERR(dchild));
> -		goto out_unlock;
> +		goto out_write;
>  	}
>  	fh_init(newfhp, NFS_FHSIZE);
>  	resp->status =3D fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
>  	if (!resp->status && d_really_is_negative(dchild))
>  		resp->status =3D nfserr_noent;
> -	dput(dchild);
>  	if (resp->status) {
>  		if (resp->status !=3D nfserr_noent)
>  			goto out_unlock;
> @@ -423,7 +421,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	}
> =20
>  out_unlock:
> -	inode_unlock(dirfhp->fh_dentry->d_inode);
> +	end_creating(dchild, dirfhp->fh_dentry);
> +out_write:
>  	fh_drop_write(dirfhp);
>  done:
>  	fh_put(dirfhp);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index aa4a95713a48..90c830c59c60 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1605,19 +1605,16 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	if (host_err)
>  		return nfserrno(host_err);
> =20
> -	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
> +	dchild =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen=
));
>  	host_err =3D PTR_ERR(dchild);
> -	if (IS_ERR(dchild)) {
> -		err =3D nfserrno(host_err);
> -		goto out_unlock;
> -	}
> +	if (IS_ERR(dchild))
> +		return nfserrno(host_err);
> +
>  	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
>  	/*
>  	 * We unconditionally drop our ref to dchild as fh_compose will have
>  	 * already grabbed its own ref for it.
>  	 */
> -	dput(dchild);
>  	if (err)
>  		goto out_unlock;
>  	err =3D fh_fill_pre_attrs(fhp);
> @@ -1626,7 +1623,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
> -	inode_unlock(dentry->d_inode);
> +	end_creating(dchild, dentry);
>  	return err;
>  }
> =20
> @@ -1712,11 +1709,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	}
> =20
>  	dentry =3D fhp->fh_dentry;
> -	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
> +	dnew =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen))=
;
>  	if (IS_ERR(dnew)) {
>  		err =3D nfserrno(PTR_ERR(dnew));
> -		inode_unlock(dentry->d_inode);
>  		goto out_drop_write;
>  	}
>  	err =3D fh_fill_pre_attrs(fhp);
> @@ -1729,11 +1724,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
> -	inode_unlock(dentry->d_inode);
> +	end_creating(dnew, dentry);
>  	if (!err)
>  		err =3D nfserrno(commit_metadata(fhp));
> -	dput(dnew);
> -	if (err=3D=3D0) err =3D cerr;
> +	if (!err)
> +		err =3D cerr;
>  out_drop_write:
>  	fh_drop_write(fhp);
>  out:
> @@ -1788,32 +1783,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> =20
>  	ddir =3D ffhp->fh_dentry;
>  	dirp =3D d_inode(ddir);
> -	inode_lock_nested(dirp, I_MUTEX_PARENT);
> +	dnew =3D start_creating(&nop_mnt_idmap, ddir, &QSTR_LEN(name, len));
> =20
> -	dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(name, len), ddir);
>  	if (IS_ERR(dnew)) {
>  		host_err =3D PTR_ERR(dnew);
> -		goto out_unlock;
> +		goto out_drop_write;
>  	}
> =20
>  	dold =3D tfhp->fh_dentry;
> =20
>  	err =3D nfserr_noent;
>  	if (d_really_is_negative(dold))
> -		goto out_dput;
> +		goto out_unlock;
>  	err =3D fh_fill_pre_attrs(ffhp);
>  	if (err !=3D nfs_ok)
> -		goto out_dput;
> +		goto out_unlock;
>  	host_err =3D vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
>  	fh_fill_post_attrs(ffhp);
> -	inode_unlock(dirp);
> +out_unlock:
> +	end_creating(dnew, ddir);
>  	if (!host_err) {
>  		host_err =3D commit_metadata(ffhp);
>  		if (!host_err)
>  			host_err =3D commit_metadata(tfhp);
>  	}
> =20
> -	dput(dnew);
>  out_drop_write:
>  	fh_drop_write(tfhp);
>  	if (host_err =3D=3D -EBUSY) {
> @@ -1828,12 +1822,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
>  	}
>  out:
>  	return err !=3D nfs_ok ? err : nfserrno(host_err);
> -
> -out_dput:
> -	dput(dnew);
> -out_unlock:
> -	inode_unlock(dirp);
> -	goto out_drop_write;
>  }
>=20
>=20


I do quite like the nfsd cleanup though!


> =20
>  static void
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 27396fe63f6d..6a31ea34ff80 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -613,9 +613,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>  	if (err)
>  		goto out;
> =20
> -	inode_lock_nested(udir, I_MUTEX_PARENT);
> -	upper =3D ovl_lookup_upper(ofs, c->dentry->d_name.name, upperdir,
> -				 c->dentry->d_name.len);
> +	upper =3D ovl_start_creating_upper(ofs, upperdir,
> +					 &QSTR_LEN(c->dentry->d_name.name,
> +						   c->dentry->d_name.len));
>  	err =3D PTR_ERR(upper);
>  	if (!IS_ERR(upper)) {
>  		err =3D ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udir, upper);
> @@ -626,9 +626,8 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>  			ovl_dentry_set_upper_alias(c->dentry);
>  			ovl_dentry_update_reval(c->dentry, upper);
>  		}
> -		dput(upper);
> +		end_creating(upper, upperdir);
>  	}
> -	inode_unlock(udir);
>  	if (err)
>  		goto out;
> =20
> @@ -894,16 +893,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_c=
tx *c)
>  	if (err)
>  		goto out;
> =20
> -	inode_lock_nested(udir, I_MUTEX_PARENT);
> -
> -	upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> -				 c->destname.len);
> +	upper =3D ovl_start_creating_upper(ofs, c->destdir,
> +					 &QSTR_LEN(c->destname.name,
> +						   c->destname.len));
>  	err =3D PTR_ERR(upper);
>  	if (!IS_ERR(upper)) {
>  		err =3D ovl_do_link(ofs, temp, udir, upper);
> -		dput(upper);
> +		end_creating(upper, c->destdir);
>  	}
> -	inode_unlock(udir);
> =20
>  	if (err)
>  		goto out;
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index dbd63a74df4b..0ae79efbfce7 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -59,15 +59,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *wo=
rkdir,
>  	return 0;
>  }
> =20
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> +#define OVL_TEMPNAME_SIZE 20
> +static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  {
> -	struct dentry *temp;
> -	char name[20];
>  	static atomic_t temp_id =3D ATOMIC_INIT(0);
> =20
>  	/* counter is allowed to wrap, since temp dentries are ephemeral */
> -	snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
> +	snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_id));
> +}
> +
> +struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> +{
> +	struct dentry *temp;
> +	char name[OVL_TEMPNAME_SIZE];
> =20
> +	ovl_tempname(name);
>  	temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
>  	if (!IS_ERR(temp) && temp->d_inode) {
>  		pr_err("workdir/%s already exists\n", name);
> @@ -78,6 +84,16 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, str=
uct dentry *workdir)
>  	return temp;
>  }
> =20
> +static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> +					      struct dentry *workdir)
> +{
> +	char name[OVL_TEMPNAME_SIZE];
> +
> +	ovl_tempname(name);
> +	return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
> +			      &QSTR(name));
> +}
> +
>  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>  {
>  	int err;
> @@ -88,35 +104,31 @@ static struct dentry *ovl_whiteout(struct ovl_fs *of=
s)
>  	guard(mutex)(&ofs->whiteout_lock);
> =20
>  	if (!ofs->whiteout) {
> -		inode_lock_nested(wdir, I_MUTEX_PARENT);
> -		whiteout =3D ovl_lookup_temp(ofs, workdir);
> -		if (!IS_ERR(whiteout)) {
> -			err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> -			if (err) {
> -				dput(whiteout);
> -				whiteout =3D ERR_PTR(err);
> -			}
> -		}
> -		inode_unlock(wdir);
> +		whiteout =3D ovl_start_creating_temp(ofs, workdir);
>  		if (IS_ERR(whiteout))
>  			return whiteout;
> -		ofs->whiteout =3D whiteout;
> +		err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> +		if (!err)
> +			ofs->whiteout =3D dget(whiteout);
> +		end_creating(whiteout, workdir);
> +		if (err)
> +			return ERR_PTR(err);
>  	}
> =20
>  	if (!ofs->no_shared_whiteout) {
> -		inode_lock_nested(wdir, I_MUTEX_PARENT);
> -		whiteout =3D ovl_lookup_temp(ofs, workdir);
> -		if (!IS_ERR(whiteout)) {
> -			err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> -			if (err) {
> -				dput(whiteout);
> -				whiteout =3D ERR_PTR(err);
> -			}
> -		}
> -		inode_unlock(wdir);
> -		if (!IS_ERR(whiteout))
> +		struct dentry *ret =3D NULL;
> +
> +		whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +		if (IS_ERR(whiteout))
>  			return whiteout;
> -		if (PTR_ERR(whiteout) !=3D -EMLINK) {
> +		err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> +		if (!err)
> +			ret =3D dget(whiteout);
> +		end_creating(whiteout, workdir);
> +		if (ret)
> +			return ret;
> +
> +		if (err !=3D -EMLINK) {
>  			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(n=
link=3D%u, err=3D%lu)\n",
>  				ofs->whiteout->d_inode->i_nlink,
>  				PTR_ERR(whiteout));
> @@ -225,10 +237,13 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, =
struct dentry *workdir,
>  			       struct ovl_cattr *attr)
>  {
>  	struct dentry *ret;
> -	inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> -	ret =3D ovl_create_real(ofs, workdir,
> -			      ovl_lookup_temp(ofs, workdir), attr);
> -	inode_unlock(workdir->d_inode);
> +	ret =3D ovl_start_creating_temp(ofs, workdir);
> +	if (IS_ERR(ret))
> +		return ret;
> +	ret =3D ovl_create_real(ofs, workdir, ret, attr);
> +	if (!IS_ERR(ret))
> +		dget(ret);
> +	end_creating(ret, workdir);
>  	return ret;
>  }
> =20
> @@ -327,18 +342,21 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,
>  {
>  	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>  	struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> -	struct inode *udir =3D upperdir->d_inode;
>  	struct dentry *newdentry;
>  	int err;
> =20
> -	inode_lock_nested(udir, I_MUTEX_PARENT);
> -	newdentry =3D ovl_create_real(ofs, upperdir,
> -				    ovl_lookup_upper(ofs, dentry->d_name.name,
> -						     upperdir, dentry->d_name.len),
> -				    attr);
> -	inode_unlock(udir);
> +	newdentry =3D ovl_start_creating_upper(ofs, upperdir,
> +					     &QSTR_LEN(dentry->d_name.name,
> +						       dentry->d_name.len));
>  	if (IS_ERR(newdentry))
>  		return PTR_ERR(newdentry);
> +	newdentry =3D ovl_create_real(ofs, upperdir, newdentry, attr);
> +	if (IS_ERR(newdentry)) {
> +		end_creating(newdentry, upperdir);
> +		return PTR_ERR(newdentry);
> +	}
> +	dget(newdentry);
> +	end_creating(newdentry, upperdir);
> =20
>  	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>  	    !ovl_allow_offline_changes(ofs)) {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4f84abaa0d68..c24c2da953bd 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -415,6 +415,14 @@ static inline struct dentry *ovl_lookup_upper_unlock=
ed(struct ovl_fs *ofs,
>  				   &QSTR_LEN(name, len), base);
>  }
> =20
> +static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs=
,
> +						      struct dentry *parent,
> +						      struct qstr *name)
> +{
> +	return start_creating(ovl_upper_mnt_idmap(ofs),
> +			      parent, name);
> +}
> +
>  static inline bool ovl_open_flags_need_copy_up(int flags)
>  {
>  	if (!flags)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index bd3d7ba8fb95..67abb62e205b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -300,8 +300,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  	bool retried =3D false;
> =20
>  retry:
> -	inode_lock_nested(dir, I_MUTEX_PARENT);
> -	work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
> +	work =3D ovl_start_creating_upper(ofs, ofs->workbasedir, &QSTR(name));
> =20
>  	if (!IS_ERR(work)) {
>  		struct iattr attr =3D {
> @@ -310,14 +309,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>  		};
> =20
>  		if (work->d_inode) {
> +			dget(work);
> +			end_creating(work, ofs->workbasedir);
> +			if (persist)
> +				return work;
>  			err =3D -EEXIST;
> -			inode_unlock(dir);
>  			if (retried)
>  				goto out_dput;
> -
> -			if (persist)
> -				return work;
> -
>  			retried =3D true;
>  			err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir, mnt, work, 0);
>  			dput(work);
> @@ -328,7 +326,9 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  		}
> =20
>  		work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> -		inode_unlock(dir);
> +		if (!IS_ERR(work))
> +			dget(work);
> +		end_creating(work, ofs->workbasedir);
>  		err =3D PTR_ERR(work);
>  		if (IS_ERR(work))
>  			goto out_err;
> @@ -366,7 +366,6 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  		if (err)
>  			goto out_dput;
>  	} else {
> -		inode_unlock(dir);
>  		err =3D PTR_ERR(work);
>  		goto out_err;
>  	}
> @@ -616,14 +615,17 @@ static struct dentry *ovl_lookup_or_create(struct o=
vl_fs *ofs,
>  					   struct dentry *parent,
>  					   const char *name, umode_t mode)
>  {
> -	size_t len =3D strlen(name);
>  	struct dentry *child;
> =20
> -	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -	child =3D ovl_lookup_upper(ofs, name, parent, len);
> -	if (!IS_ERR(child) && !child->d_inode)
> -		child =3D ovl_create_real(ofs, parent, child, OVL_CATTR(mode));
> -	inode_unlock(parent->d_inode);
> +	child =3D ovl_start_creating_upper(ofs, parent, &QSTR(name));
> +	if (!IS_ERR(child)) {
> +		if (!child->d_inode)
> +			child =3D ovl_create_real(ofs, parent, child,
> +						OVL_CATTR(mode));
> +		if (!IS_ERR(child))
> +			dget(child);
> +		end_creating(child, parent);
> +	}
>  	dput(parent);
> =20
>  	return child;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index a7800ef04e76..4cbe930054a1 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -88,6 +88,24 @@ struct dentry *lookup_one_positive_killable(struct mnt=
_idmap *idmap,
>  					    struct qstr *name,
>  					    struct dentry *base);
> =20
> +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +			      struct qstr *name);
> +
> +/* end_creating - finish action started with start_creating
> + * @child - dentry returned by start_creating()
> + * @parent - dentry given to start_creating()
> + *
> + * Unlock and release the child.
> + *
> + * Unlike end_dirop() this can only be called if start_creating() succee=
ded.
> + * It handles @child being and error as vfs_mkdir() might have converted=
 the
> + * dentry to an error - in that case the parent still needs to be unlock=
ed.
> + */
> +static inline void end_creating(struct dentry *child, struct dentry *par=
ent)
> +{
> +	end_dirop_mkdir(child, parent);
> +}
> +
>  extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);


--=20
Jeff Layton <jlayton@kernel.org>

