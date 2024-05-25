Return-Path: <linux-fsdevel+bounces-20151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9478CEE98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BC281B8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E42AF16;
	Sat, 25 May 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfuAd0mS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF518F66
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634536; cv=none; b=pcGni19NwoG5U+2ur+nbmHJ3ZLaKaBiXlM5U9V5AX6ukdx0xhhPYLuEw+AMAMdlxWl3ZA9OMYOFsDwiWNRgJwwN+/n1xcTsNVo4uu13gHVJJbHM3SNtMumjN8k/wt+DbqgxuXq11B5t8SugWp5qv4rsRoAhEEXkBep+35lN5MZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634536; c=relaxed/simple;
	bh=S4inY98R2DeNuNeO3Ebz00g8xb+whkQdpc+NSAAwYoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrhmvDFYsk6lVkhOrcZmmquLx1tDiaSCN6iC6uSG5XJa7S4xe4A2ICOfTtrGoRKD9yyCoZGLUSDhsfiDNuE8q1rPklItWQ/VodolARdSHCWPdXqtQE6zjP/jsgO9E3FI9YUTdO6sFJSQfdp253zIVSKgpAbA88S9aD2pZcXP4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfuAd0mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608D2C2BD11;
	Sat, 25 May 2024 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716634535;
	bh=S4inY98R2DeNuNeO3Ebz00g8xb+whkQdpc+NSAAwYoA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SfuAd0mSs7oUeUb+j8KUt1agd6BRZZeyKv3o01mfeAa6qvIF/IEn2dqYbY5we/oo5
	 eN+P3bsvqzKWaVaMsT6crMZIihnqddoJMal3QLPNooUYXSKbC+GxqZ7uBQvp/V+1wf
	 6gyiLRjhLL3BQupQQXpwVk46pbb9N3vU30Raj/0z0aXPKSM7r/E7jeMubmOBhgWr3U
	 XT2QbCk7dEO5++HUKUHNoaYyk7VrG+umkfZiOvQGaphZcaWYS6zEzwfPP6vR6x9YJ0
	 nG3PsoGXDrIA2XjCpVJJD0kA99IiXq14CVSucD/pFWFBTKiU6zocfe5UktG1mt3tmn
	 mdnKH2Ext1nDQ==
Message-ID: <fc137092da8d872454df475d900d94ea6823f6da.camel@kernel.org>
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission
 checks
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>,  Chuck Lever <chuck.lever@oracle.com>, Aleksa Sarai
 <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org
Date: Sat, 25 May 2024 06:55:34 -0400
In-Reply-To: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:19 +0200, Christian Brauner wrote:
> A current limitation of open_by_handle_at() is that it's currently not po=
ssible
> to use it from within containers at all because we require CAP_DAC_READ_S=
EARCH
> in the initial namespace. That's unfortunate because there are scenarios =
where
> using open_by_handle_at() from within containers.
>=20
> Two examples:
>=20
> (1) cgroupfs allows to encode cgroups to file handles and reopen them wit=
h
>     open_by_handle_at().
> (2) Fanotify allows placing filesystem watches they currently aren't usab=
le in
>     containers because the returned file handles cannot be used.
>=20
> Here's a proposal for relaxing the permission check for open_by_handle_at=
().
>=20
> (1) Opening file handles when the caller has privileges over the filesyst=
em
>     (1.1) The caller has an unobstructed view of the filesystem.
>     (1.2) The caller has permissions to follow a path to the file handle.
>=20
> This doesn't address the problem of opening a file handle when only a por=
tion
> of a filesystem is exposed as is common in containers by e.g., bind-mount=
ing a
> subtree. The proposal to solve this use-case is:
>=20
> (2) Opening file handles when the caller has privileges over a subtree
>     (2.1) The caller is able to reach the file from the provided mount fd=
.
>     (2.2) The caller has permissions to construct an unobstructed path to=
 the
>           file handle.
>     (2.3) The caller has permissions to follow a path to the file handle.
>
> The relaxed permission checks are currently restricted to directory file
> handles which are what both cgroupfs and fanotify need. Handling disconne=
cted
> non-directory file handles would lead to a potentially non-deterministic =
api.
> If a disconnected non-directory file handle is provided we may fail to de=
code
> a valid path that we could use for permission checking. That in itself is=
n't a
> problem as we would just return EACCES in that case. However, confusion m=
ay
> arise if a non-disconnected dentry ends up in the cache later and those o=
pening
> the file handle would suddenly succeed.
>=20

The rules here seem sane to me, and I support making it simpler for
unprivileged users to figure out filehandles.

> * It's potentially possible to use timing information (side-channel) to i=
nfer
>   whether a given inode exists. I don't think that's particularly
>   problematic. Thanks to Jann for bringing this to my attention.
>=20
> * An unrelated note (IOW, these are thoughts that apply to
>   open_by_handle_at() generically and are unrelated to the changes here):
>   Jann pointed out that we should verify whether deleted files could
>   potentially be reopened through open_by_handle_at(). I don't think that=
's
>   possible though.
>=20
>   Another potential thing to check is whether open_by_handle_at() could b=
e
>   abused to open internal stuff like memfds or gpu stuff. I don't think s=
o
>   but I haven't had the time to completely verify this.
>=20
> This dates back to discussions Amir and I had quite some time ago and tha=
nks to
> him for providing a lot of details around the export code and related pat=
ches!
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/exportfs/expfs.c      |   9 ++-
>  fs/fhandle.c             | 162 ++++++++++++++++++++++++++++++++++++-----=
------
>  fs/mount.h               |   1 +
>  fs/namespace.c           |   2 +-
>  fs/nfsd/nfsfh.c          |   2 +-
>  include/linux/exportfs.h |   1 +
>  6 files changed, 137 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 07ea3d62b298..b23b052df715 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -427,7 +427,7 @@ EXPORT_SYMBOL_GPL(exportfs_encode_fh);
> =20
>  struct dentry *
>  exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len=
,
> -		       int fileid_type,
> +		       int fileid_type, bool directory,
>  		       int (*acceptable)(void *, struct dentry *),
>  		       void *context)
>  {
> @@ -445,6 +445,11 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct =
fid *fid, int fh_len,
>  	if (IS_ERR_OR_NULL(result))
>  		return result;
> =20
> +	if (directory && !d_is_dir(result)) {
> +		err =3D -ENOTDIR;
> +		goto err_result;
> +	}
> +
>  	/*
>  	 * If no acceptance criteria was specified by caller, a disconnected
>  	 * dentry is also accepatable. Callers may use this mode to query if
> @@ -581,7 +586,7 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mn=
t, struct fid *fid,
>  {
>  	struct dentry *ret;
> =20
> -	ret =3D exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
> +	ret =3D exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type, false,
>  				     acceptable, context);
>  	if (IS_ERR_OR_NULL(ret)) {
>  		if (ret =3D=3D ERR_PTR(-ENOMEM))
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 8a7f86c2139a..c6ed832ddbb8 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -115,88 +115,174 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const=
 char __user *, name,
>  	return err;
>  }
> =20
> -static struct vfsmount *get_vfsmount_from_fd(int fd)
> +static int get_path_from_fd(int fd, struct path *root)

nit: you could return struct path here and just return an ERR_PTR if
there is an error.

>  {
> -	struct vfsmount *mnt;
> -
>  	if (fd =3D=3D AT_FDCWD) {
>  		struct fs_struct *fs =3D current->fs;
>  		spin_lock(&fs->lock);
> -		mnt =3D mntget(fs->pwd.mnt);
> +		*root =3D fs->pwd;
> +		path_get(root);
>  		spin_unlock(&fs->lock);
>  	} else {
>  		struct fd f =3D fdget(fd);
>  		if (!f.file)
> -			return ERR_PTR(-EBADF);
> -		mnt =3D mntget(f.file->f_path.mnt);
> +			return -EBADF;
> +		*root =3D f.file->f_path;
> +		path_get(root);
>  		fdput(f);
>  	}
> -	return mnt;
> +
> +	return 0;
>  }
> =20
> +enum handle_to_path_flags {
> +	HANDLE_CHECK_PERMS   =3D (1 << 0),
> +	HANDLE_CHECK_SUBTREE =3D (1 << 1),
> +};
> +
> +struct handle_to_path_ctx {
> +	struct path root;
> +	enum handle_to_path_flags flags;
> +	bool directory;
> +};
> +
>  static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
>  {
> -	return 1;
> +	struct handle_to_path_ctx *ctx =3D context;
> +	struct user_namespace *user_ns =3D current_user_ns();
> +	struct dentry *d, *root =3D ctx->root.dentry;
> +	struct mnt_idmap *idmap =3D mnt_idmap(ctx->root.mnt);
> +	int retval =3D 0;
> +
> +	if (!root)
> +		return 1;
> +
> +	/* Old permission model with global CAP_DAC_READ_SEARCH. */
> +	if (!ctx->flags)
> +		return 1;
> +
> +	/*
> +	 * It's racy as we're not taking rename_lock but we're able to ignore
> +	 * permissions and we just need an approximation whether we were able
> +	 * to follow a path to the file.
> +	 */
> +	d =3D dget(dentry);
> +	while (d !=3D root && !IS_ROOT(d)) {
> +		struct dentry *parent =3D dget_parent(d);
> +
> +		/*
> +		 * We know that we have the ability to override DAC permissions
> +		 * as we've verified this earlier via CAP_DAC_READ_SEARCH. But
> +		 * we also need to make sure that there aren't any unmapped
> +		 * inodes in the path that would prevent us from reaching the
> +		 * file.
> +		 */
> +		if (!privileged_wrt_inode_uidgid(user_ns, idmap,
> +						 d_inode(parent))) {
> +			dput(d);
> +			dput(parent);
> +			return retval;
> +		}
> +
> +		dput(d);
> +		d =3D parent;
> +	}

Note that the above will be quite expensive on some filesystems,
particularly if there is a deep path. We've done a similar sort of
checking for a long time in NFS-land, and we really try to avoid it
when possible. Of course there, we do have to also check that the
relevant dentry is exported, which is a bit more costly.

> +
> +	if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> +		retval =3D 1;
> +
> +	dput(d);
> +	return retval;
>  }
> =20
>  static int do_handle_to_path(int mountdirfd, struct file_handle *handle,
> -			     struct path *path)
> +			     struct path *path, struct handle_to_path_ctx *ctx)
>  {
> -	int retval =3D 0;
>  	int handle_dwords;
> +	struct vfsmount *mnt =3D ctx->root.mnt;
> =20
> -	path->mnt =3D get_vfsmount_from_fd(mountdirfd);
> -	if (IS_ERR(path->mnt)) {
> -		retval =3D PTR_ERR(path->mnt);
> -		goto out_err;
> -	}
>  	/* change the handle size to multiple of sizeof(u32) */
>  	handle_dwords =3D handle->handle_bytes >> 2;
> -	path->dentry =3D exportfs_decode_fh(path->mnt,
> +	path->dentry =3D exportfs_decode_fh_raw(mnt,
>  					  (struct fid *)handle->f_handle,
>  					  handle_dwords, handle->handle_type,
> -					  vfs_dentry_acceptable, NULL);
> -	if (IS_ERR(path->dentry)) {
> -		retval =3D PTR_ERR(path->dentry);
> -		goto out_mnt;
> +					  ctx->directory,
> +					  vfs_dentry_acceptable, ctx);
> +	if (IS_ERR_OR_NULL(path->dentry)) {
> +		if (path->dentry =3D=3D ERR_PTR(-ENOMEM))
> +			return -ENOMEM;
> +		return -ESTALE;
>  	}
> +	path->mnt =3D mntget(mnt);
>  	return 0;
> -out_mnt:
> -	mntput(path->mnt);
> -out_err:
> -	return retval;
>  }
> =20
>  static int handle_to_path(int mountdirfd, struct file_handle __user *ufh=
,
> -		   struct path *path)
> +		   struct path *path, unsigned int o_flags)
>  {
>  	int retval =3D 0;
>  	struct file_handle f_handle;
>  	struct file_handle *handle =3D NULL;
> +	struct handle_to_path_ctx ctx =3D {};
> +
> +	retval =3D get_path_from_fd(mountdirfd, &ctx.root);
> +	if (retval)
> +		goto out_err;
> =20
> -	/*
> -	 * With handle we don't look at the execute bit on the
> -	 * directory. Ideally we would like CAP_DAC_SEARCH.
> -	 * But we don't have that
> -	 */
>  	if (!capable(CAP_DAC_READ_SEARCH)) {
> +		/*
> +		 * Allow relaxed permissions of file handles if the caller has
> +		 * the ability to mount the filesystem or create a bind-mount
> +		 * of the provided @mountdirfd.
> +		 *
> +		 * In both cases the caller may be able to get an unobstructed
> +		 * way to the encoded file handle. If the caller is only able
> +		 * to create a bind-mount we need to verify that there are no
> +		 * locked mounts on top of it that could prevent us from
> +		 * getting to the encoded file.
> +		 *
> +		 * In principle, locked mounts can prevent the caller from
> +		 * mounting the filesystem but that only applies to procfs and
> +		 * sysfs neither of which support decoding file handles.
> +		 *
> +		 * This is currently restricted to O_DIRECTORY to provide a
> +		 * deterministic API that avoids a confusing api in the face of
> +		 * disconnected non-dir dentries.
> +		 */
> +
>  		retval =3D -EPERM;
> -		goto out_err;
> +		if (!(o_flags & O_DIRECTORY))
> +			goto out_path;
> +
> +		if (ns_capable(ctx.root.mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
> +			ctx.flags =3D HANDLE_CHECK_PERMS;
> +		else if (ns_capable(real_mount(ctx.root.mnt)->mnt_ns->user_ns, CAP_SYS=
_ADMIN) &&
> +			   !has_locked_children(real_mount(ctx.root.mnt), ctx.root.dentry))
> +			ctx.flags =3D HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
> +		else
> +			goto out_path;
> +
> +		/* Are we able to override DAC permissions? */
> +		if (!ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH))
> +			goto out_path;
> +
> +		ctx.directory =3D true;
>  	}
> +
>  	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
>  		retval =3D -EFAULT;
> -		goto out_err;
> +		goto out_path;
>  	}
>  	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
>  	    (f_handle.handle_bytes =3D=3D 0)) {
>  		retval =3D -EINVAL;
> -		goto out_err;
> +		goto out_path;
>  	}
>  	handle =3D kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes)=
,
>  			 GFP_KERNEL);
>  	if (!handle) {
>  		retval =3D -ENOMEM;
> -		goto out_err;
> +		goto out_path;
>  	}
>  	/* copy the full handle */
>  	*handle =3D f_handle;
> @@ -207,10 +293,14 @@ static int handle_to_path(int mountdirfd, struct fi=
le_handle __user *ufh,
>  		goto out_handle;
>  	}
> =20
> -	retval =3D do_handle_to_path(mountdirfd, handle, path);
> +	retval =3D do_handle_to_path(mountdirfd, handle, path, &ctx);
> +	if (retval)
> +		goto out_handle;
> =20
>  out_handle:
>  	kfree(handle);
> +out_path:
> +	path_put(&ctx.root);
>  out_err:
>  	return retval;
>  }
> @@ -223,7 +313,7 @@ static long do_handle_open(int mountdirfd, struct fil=
e_handle __user *ufh,
>  	struct file *file;
>  	int fd;
> =20
> -	retval =3D handle_to_path(mountdirfd, ufh, &path);
> +	retval =3D handle_to_path(mountdirfd, ufh, &path, open_flag);
>  	if (retval)
>  		return retval;
> =20
> diff --git a/fs/mount.h b/fs/mount.h
> index 4a42fc68f4cc..4adce73211ae 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -152,3 +152,4 @@ static inline void move_from_ns(struct mount *mnt, st=
ruct list_head *dt_list)
>  }
> =20
>  extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *curso=
r);
> +bool has_locked_children(struct mount *mnt, struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5a51315c6678..4386787210c7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2078,7 +2078,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
>  	namespace_unlock();
>  }
> =20
> -static bool has_locked_children(struct mount *mnt, struct dentry *dentry=
)
> +bool has_locked_children(struct mount *mnt, struct dentry *dentry)
>  {
>  	struct mount *child;
> =20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0b75305fb5f5..3e7f81eb2818 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -247,7 +247,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
>  		dentry =3D dget(exp->ex_path.dentry);
>  	else {
>  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> -						data_left, fileid_type,
> +						data_left, fileid_type, false,
>  						nfsd_acceptable, exp);
>  		if (IS_ERR_OR_NULL(dentry)) {
>  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index bb37ad5cc954..90c4b0111218 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -305,6 +305,7 @@ static inline int exportfs_encode_fid(struct inode *i=
node, struct fid *fid,
>  extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
>  					     struct fid *fid, int fh_len,
>  					     int fileid_type,
> +					     bool directory,
>  					     int (*acceptable)(void *, struct dentry *),
>  					     void *context);
>  extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fi=
d *fid,
>=20
> ---
> base-commit: 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6
> change-id: 20240524-vfs-open_by_handle_at-73c20767eb4e
>=20

Otherwise, this seems rather sane. Let's see what breaks!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

