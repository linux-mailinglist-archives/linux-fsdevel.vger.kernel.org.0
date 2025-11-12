Return-Path: <linux-fsdevel+bounces-68101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63264C544B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA593B9370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140C29E0E5;
	Wed, 12 Nov 2025 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4B61jCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230C1917F1;
	Wed, 12 Nov 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976747; cv=none; b=NqVca2gPefGimotmSSaScBrdZO6lDWWC4g2rV5i9HXzOA3XtQ8VBP9aEcOf27kExwy8mZ3Oa3TjR1EG4ku28G4Lx7OhRGegP3PDH5bIcoBrfWx6fOThainkCeNMbl4fZaSVHdyp6lHWxO1HzYwpToGKZAGyzVtXEa6lB9uOTGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976747; c=relaxed/simple;
	bh=3kqXSkWW59GhVE1ed65aG7ohwWf85if+BhiWCScs9pc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+RYlszU38NCsVkHhyBerHLwysJ1pnWAUP7wvb8sLYss/+Y2su3xVCtiB0bYDYjQHWwdokR60C8/t8IUA9kcwVGFNkMny3iDqDsxAOOzfxr6D9wuPMpHjkypOR9UoUdbc84sF0oIAm8x/jlIlDJWbAQq7vYouWu5h0yKdw2KGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4B61jCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC8C113D0;
	Wed, 12 Nov 2025 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976745;
	bh=3kqXSkWW59GhVE1ed65aG7ohwWf85if+BhiWCScs9pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L4B61jCfnLwvDJzF9CjQoY2QalnENeWaYbfXovXOVP+JnqJKuA3r5qrs7MWMR8gtN
	 8GeeDOCpHAZ6iY+IDgLM/hipYOrSEP3UTp2FdUoY9GYek0af6GZiIZFMOVc10/lYId
	 Dl5LzNpPT5hcNXR5tBZtuXgb1/Ggx1e+RJcaxuz4QRv/sMhUiGtcriYXVG4VgR8aK2
	 wJzFStWYHHkdPMwETb5A+Wh1tBjNB/ZJfq1p9MQ5ZTWLYBd2mif4MSvyDXiuDCgLTa
	 7UKHCpHdOrIhc/n/39p0p/A0YY16mqghNm3nen2ue/cAfWelWCoUe4hMHbu83poFhs
	 +sB4kntwGFY8A==
Message-ID: <80a6bf30b55db9c0e08338e4852358edec5d4972.camel@kernel.org>
Subject: Re: [PATCH v5 13/14] VFS: change vfs_mkdir() to unlock on failure.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Chris Mason	
 <clm@fb.com>, David Sterba <dsterba@suse.com>, David Howells
 <dhowells@redhat.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, Miklos Szeredi	
 <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Namjae
 Jeon	 <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, Sergey
 Senozhatsky	 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>,
 John Johansen	 <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Stephen Smalley	 <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger	
 <stefanb@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Date: Wed, 12 Nov 2025 14:45:41 -0500
In-Reply-To: <20251106005333.956321-14-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-14-neilb@ownmail.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 11:50 +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> vfs_mkdir() already drops the reference to the dentry on failure but it
> leaves the parent locked.
> This complicates end_creating() which needs to unlock the parent even
> though the dentry is no longer available.
>=20
> If we change vfs_mkdir() to unlock on failure as well as releasing the
> dentry, we can remove the "parent" arg from end_creating() and simplify
> the rules for calling it.
>=20
> Note that cachefiles_get_directory() can choose to substitute an error
> instead of actually calling vfs_mkdir(), for fault injection.  In that
> case it needs to call end_creating(), just as vfs_mkdir() now does on
> error.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> --
> changes since v2:
>  - extra {} in if() branch in cachefiles_get_directory() to
>    match the new extra {} in the else branch.
>  - filesystems/porting.rst updated.
> ---
>  Documentation/filesystems/porting.rst | 13 +++++++++++++
>  fs/btrfs/ioctl.c                      |  2 +-
>  fs/cachefiles/namei.c                 | 16 ++++++++-------
>  fs/ecryptfs/inode.c                   |  8 ++++----
>  fs/namei.c                            |  4 ++--
>  fs/nfsd/nfs3proc.c                    |  2 +-
>  fs/nfsd/nfs4proc.c                    |  2 +-
>  fs/nfsd/nfs4recover.c                 |  2 +-
>  fs/nfsd/nfsproc.c                     |  2 +-
>  fs/nfsd/vfs.c                         |  8 ++++----
>  fs/overlayfs/copy_up.c                |  4 ++--
>  fs/overlayfs/dir.c                    | 13 ++++++-------
>  fs/overlayfs/super.c                  |  6 +++---
>  fs/xfs/scrub/orphanage.c              |  2 +-
>  include/linux/namei.h                 | 28 +++++++++------------------
>  ipc/mqueue.c                          |  2 +-
>  16 files changed, 59 insertions(+), 55 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 35f027981b21..d33429294252 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1309,3 +1309,16 @@ a different length, use
>  	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
> =20
>  instead.
> +
> +---
> +
> +**mandatory**
> +
> +vfs_mkdir() now returns a dentry - the one returned by ->mkdir().  If
> +that dentry is different from the dentry passed in, including if it is
> +an IS_ERR() dentry pointer, the original dentry is dput().
> +
> +When vfs_mkdir() returns an error, and so both dputs() the original
> +dentry and doesn't provide a replacement, it also unlocks the parent.
> +Consequently the return value from vfs_mkdir() can be passed to
> +end_creating() and the parent will be unlocked precisely when necessary.
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d0c3bb0423bb..b138120feba3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -935,7 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *par=
ent,
>  out_up_read:
>  	up_read(&fs_info->subvol_sem);
>  out_dput:
> -	end_creating(dentry, parent);
> +	end_creating(dentry);
>  	return ret;
>  }
> =20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 0104ac00485d..59327618ac42 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -128,10 +128,12 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
>  		if (ret < 0)
>  			goto mkdir_error;
>  		ret =3D cachefiles_inject_write_error();
> -		if (ret =3D=3D 0)
> +		if (ret =3D=3D 0) {
>  			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> -		else
> +		} else {
> +			end_creating(subdir);
>  			subdir =3D ERR_PTR(ret);
> +		}
>  		if (IS_ERR(subdir)) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
> @@ -140,7 +142,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  		trace_cachefiles_mkdir(dir, subdir);
> =20
>  		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
> -			end_creating(subdir, dir);
> +			end_creating(subdir);
>  			goto retry;
>  		}
>  		ASSERT(d_backing_inode(subdir));
> @@ -154,7 +156,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  	/* Tell rmdir() it's not allowed to delete the subdir */
>  	inode_lock(d_inode(subdir));
>  	dget(subdir);
> -	end_creating(subdir, dir);
> +	end_creating(subdir);
> =20
>  	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
>  		pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx)\n",
> @@ -196,7 +198,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>  	return ERR_PTR(-EBUSY);
> =20
>  mkdir_error:
> -	end_creating(subdir, dir);
> +	end_creating(subdir);
>  	pr_err("mkdir %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
> =20
> @@ -699,7 +701,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cach=
e *cache,
>  		if (ret < 0)
>  			goto out_end;
> =20
> -		end_creating(dentry, fan);
> +		end_creating(dentry);
> =20
>  		ret =3D cachefiles_inject_read_error();
>  		if (ret =3D=3D 0)
> @@ -733,7 +735,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cach=
e *cache,
>  	}
> =20
>  out_end:
> -	end_creating(dentry, fan);
> +	end_creating(dentry);
>  out:
>  	_leave(" =3D %u", success);
>  	return success;
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 37d6293600c7..c951e723f24d 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -211,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>  	fsstack_copy_attr_times(directory_inode, lower_dir);
>  	fsstack_copy_inode_size(directory_inode, lower_dir);
>  out_lock:
> -	end_creating(lower_dentry, NULL);
> +	end_creating(lower_dentry);
>  	return inode;
>  }
> =20
> @@ -456,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, s=
truct inode *dir,
>  		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
>  	i_size_write(d_inode(new_dentry), file_size_save);
>  out_lock:
> -	end_creating(lower_new_dentry, NULL);
> +	end_creating(lower_new_dentry);
>  	return rc;
>  }
> =20
> @@ -500,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>  	fsstack_copy_attr_times(dir, lower_dir);
>  	fsstack_copy_inode_size(dir, lower_dir);
>  out_lock:
> -	end_creating(lower_dentry, NULL);
> +	end_creating(lower_dentry);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return rc;
> @@ -534,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>  	fsstack_copy_inode_size(dir, lower_dir);
>  	set_nlink(dir, lower_dir->i_nlink);
>  out:
> -	end_creating(lower_dentry, lower_dir_dentry);
> +	end_creating(lower_dentry);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return ERR_PTR(rc);
> diff --git a/fs/namei.c b/fs/namei.c
> index 2444c7ddb926..e834486acff1 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4832,7 +4832,7 @@ EXPORT_SYMBOL(start_creating_path);
>   */
>  void end_creating_path(const struct path *path, struct dentry *dentry)
>  {
> -	end_creating(dentry, path->dentry);
> +	end_creating(dentry);
>  	mnt_drop_write(path->mnt);
>  	path_put(path);
>  }
> @@ -5034,7 +5034,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  	return dentry;
> =20
>  err:
> -	dput(dentry);
> +	end_creating(dentry);
>  	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index e2aac0def2cb..6b39e4aff959 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -364,7 +364,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
> =20
>  out:
> -	end_creating(child, parent);
> +	end_creating(child);
>  out_write:
>  	fh_drop_write(fhp);
>  	return status;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b2c95e8e7c68..524cb07a477c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -376,7 +376,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	if (attrs.na_aclerr)
>  		open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
>  out:
> -	end_creating(child, parent);
> +	end_creating(child);
>  	nfsd_attrs_free(&attrs);
>  out_write:
>  	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 3eefaa2202e3..18c08395b273 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -215,7 +215,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	if (IS_ERR(dentry))
>  		status =3D PTR_ERR(dentry);
>  out_end:
> -	end_creating(dentry, dir);
> +	end_creating(dentry);
>  out:
>  	if (status =3D=3D 0) {
>  		if (nn->in_grace)
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index ee1b16e921fd..28f03a6a3cc3 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -421,7 +421,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	}
> =20
>  out_unlock:
> -	end_creating(dchild, dirfhp->fh_dentry);
> +	end_creating(dchild);
>  out_write:
>  	fh_drop_write(dirfhp);
>  done:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a993f1e54182..145f1c8d124d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1589,7 +1589,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  out:
>  	if (!err)
>  		fh_fill_post_attrs(fhp);
> -	end_creating(dchild, dentry);
> +	end_creating(dchild);
>  	return err;
> =20
>  out_nfserr:
> @@ -1646,7 +1646,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	return err;
> =20
>  out_unlock:
> -	end_creating(dchild, dentry);
> +	end_creating(dchild);
>  	return err;
>  }
> =20
> @@ -1747,7 +1747,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
> -	end_creating(dnew, dentry);
> +	end_creating(dnew);
>  	if (!err)
>  		err =3D nfserrno(commit_metadata(fhp));
>  	if (!err)
> @@ -1824,7 +1824,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
>  	host_err =3D vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
>  	fh_fill_post_attrs(ffhp);
>  out_unlock:
> -	end_creating(dnew, ddir);
> +	end_creating(dnew);
>  	if (!host_err) {
>  		host_err =3D commit_metadata(ffhp);
>  		if (!host_err)
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 9911a346b477..23216ed01325 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -624,7 +624,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>  			ovl_dentry_set_upper_alias(c->dentry);
>  			ovl_dentry_update_reval(c->dentry, upper);
>  		}
> -		end_creating(upper, upperdir);
> +		end_creating(upper);
>  	}
>  	if (err)
>  		goto out;
> @@ -891,7 +891,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>  	err =3D PTR_ERR(upper);
>  	if (!IS_ERR(upper)) {
>  		err =3D ovl_do_link(ofs, temp, udir, upper);
> -		end_creating(upper, c->destdir);
> +		end_creating(upper);
>  	}
> =20
>  	if (err)
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 61e9484e4ab8..a4a0dc261310 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -91,7 +91,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>  		err =3D ovl_do_whiteout(ofs, wdir, whiteout);
>  		if (!err)
>  			ofs->whiteout =3D dget(whiteout);
> -		end_creating(whiteout, workdir);
> +		end_creating(whiteout);
>  		if (err)
>  			return ERR_PTR(err);
>  	}
> @@ -103,7 +103,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>  		err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
>  		if (!err)
>  			whiteout =3D dget(link);
> -		end_creating(link, workdir);
> +		end_creating(link);
>  		if (!err)
>  			return whiteout;;
> =20
> @@ -254,7 +254,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>  	ret =3D ovl_create_real(ofs, workdir, ret, attr);
>  	if (!IS_ERR(ret))
>  		dget(ret);
> -	end_creating(ret, workdir);
> +	end_creating(ret);
>  	return ret;
>  }
> =20
> @@ -362,12 +362,11 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,
>  	if (IS_ERR(newdentry))
>  		return PTR_ERR(newdentry);
>  	newdentry =3D ovl_create_real(ofs, upperdir, newdentry, attr);
> -	if (IS_ERR(newdentry)) {
> -		end_creating(newdentry, upperdir);
> +	if (IS_ERR(newdentry))
>  		return PTR_ERR(newdentry);
> -	}
> +
>  	dget(newdentry);
> -	end_creating(newdentry, upperdir);
> +	end_creating(newdentry);
> =20
>  	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>  	    !ovl_allow_offline_changes(ofs)) {
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a721ef2b90e8..3acda985c8a3 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -320,7 +320,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> =20
>  		if (work->d_inode) {
>  			dget(work);
> -			end_creating(work, ofs->workbasedir);
> +			end_creating(work);
>  			if (persist)
>  				return work;
>  			err =3D -EEXIST;
> @@ -338,7 +338,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  		work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
>  		if (!IS_ERR(work))
>  			dget(work);
> -		end_creating(work, ofs->workbasedir);
> +		end_creating(work);
>  		err =3D PTR_ERR(work);
>  		if (IS_ERR(work))
>  			goto out_err;
> @@ -632,7 +632,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl=
_fs *ofs,
>  						OVL_CATTR(mode));
>  		if (!IS_ERR(child))
>  			dget(child);
> -		end_creating(child, parent);
> +		end_creating(child);
>  	}
>  	dput(parent);
> =20
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index e732605924a1..b77c2b6b6d44 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -199,7 +199,7 @@ xrep_orphanage_create(
>  	sc->orphanage_ilock_flags =3D 0;
> =20
>  out_dput_orphanage:
> -	end_creating(orphanage_dentry, root_dentry);
> +	end_creating(orphanage_dentry);
>  out_dput_root:
>  	dput(root_dentry);
>  out:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 0e6b1b9afc26..b4d95b79b5a8 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -106,34 +106,24 @@ struct dentry *start_creating_dentry(struct dentry =
*parent,
>  struct dentry *start_removing_dentry(struct dentry *parent,
>  				     struct dentry *child);
> =20
> -/**
> - * end_creating - finish action started with start_creating
> - * @child:  dentry returned by start_creating() or vfs_mkdir()
> - * @parent: dentry given to start_creating(),
> - *
> - * Unlock and release the child.
> +/* end_creating - finish action started with start_creating
> + * @child: dentry returned by start_creating() or vfs_mkdir()
>   *
> - * Unlike end_dirop() this can only be called if start_creating() succee=
ded.
> - * It handles @child being and error as vfs_mkdir() might have converted=
 the
> - * dentry to an error - in that case the parent still needs to be unlock=
ed.
> + * Unlock and release the child. This can be called after
> + * start_creating() whether that function succeeded or not,
> + * but it is not needed on failure.
>   *
>   * If vfs_mkdir() was called then the value returned from that function
>   * should be given for @child rather than the original dentry, as vfs_mk=
dir()
> - * may have provided a new dentry.  Even if vfs_mkdir() returns an error
> - * it must be given to end_creating().
> + * may have provided a new dentry.
> + *
>   *
>   * If vfs_mkdir() was not called, then @child will be a valid dentry and
>   * @parent will be ignored.
>   */
> -static inline void end_creating(struct dentry *child, struct dentry *par=
ent)
> +static inline void end_creating(struct dentry *child)
>  {
> -	if (IS_ERR(child))
> -		/* The parent is still locked despite the error from
> -		 * vfs_mkdir() - must unlock it.
> -		 */
> -		inode_unlock(parent->d_inode);
> -	else
> -		end_dirop(child);
> +	end_dirop(child);
>  }
> =20
>  /**
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 6d7610310003..83d9466710d6 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -932,7 +932,7 @@ static int do_mq_open(const char __user *u_name, int =
oflag, umode_t mode,
>  		put_unused_fd(fd);
>  		fd =3D error;
>  	}
> -	end_creating(path.dentry, root);
> +	end_creating(path.dentry);
>  	if (!ro)
>  		mnt_drop_write(mnt);
>  out_putname:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

