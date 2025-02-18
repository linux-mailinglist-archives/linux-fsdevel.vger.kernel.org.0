Return-Path: <linux-fsdevel+bounces-41993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9DA39D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EB8177985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AD26A0EE;
	Tue, 18 Feb 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjAcgSt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C5269AE6;
	Tue, 18 Feb 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885112; cv=none; b=i8pFd3vnrWLiVlRiEmbWTdE9HyULAcjkkyixA5VNmoZ6IZ3ipKnpz3b52+TB1y/7CEoc+pCKwJhIhIwfWK73msSgObE0tofRkQFzU/Sy7+04rWgdQV3/d2FAUXXKLO0Hc8sCt4WEWShN3drjaRWyf47SVAI/I33QCKSBqVNfCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885112; c=relaxed/simple;
	bh=VrIjIZAZz8Rl4bMr2G6NPAiEWAu5uVe7sTfVpxCKLL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjXHtstz317psaPPQfWl+CWkSjiczAGw5IiTg1UdB4QGawjLfusPKE3oSzq/YJ9BsdnGLdtJmznMfYdAiCTbAnh0Zvz291muleKyIDXywdMUIOVwap3tx2KsAum83Ym7Q7+QyDo9iBY+xbYMbEgNkaHA25iYXc6RbIAdBF0nQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjAcgSt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCAFC4CEE2;
	Tue, 18 Feb 2025 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885111;
	bh=VrIjIZAZz8Rl4bMr2G6NPAiEWAu5uVe7sTfVpxCKLL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZjAcgSt4Jvg4lIspq3tbpmD4X9/NZQD/eBebeQVzJ5aRTkSUqdFqH1Ce1pI3xi+PY
	 LlZvDb3pLGR1vFGhg/PhFuoKGsemdF7dL8+VTXOcqoiltAberwN2BgVA4F/151hxCW
	 SWAnAGSyIOjwKlWmlJYxNIGaqAYKNV3EsRpCY+LVuwTFVki9oZgP796pqeoKNRSwmB
	 KH7eDXTZWDHOrJr5K6/r63R9HbJ07YQtuU2nqiGGZbzwL+yCwXF9HrNliuR/m2vc1D
	 O8MPbAAVxYiFD32Sd2TZ4L+KLnocUaCoaZ6ukBMrd8IP/ZwJcokm6UI5SlLpSChPEq
	 F8RiPsDOyl/mg==
Message-ID: <855e6fd0ed0ef303d7bb2b515726699d280183b4.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfs: change mkdir inode_operation to return
 alternate dentry if needed.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 08:25:09 -0500
In-Reply-To: <20250217053727.3368579-3-neilb@suse.de>
References: <20250217053727.3368579-1-neilb@suse.de>
	 <20250217053727.3368579-3-neilb@suse.de>
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

On Mon, 2025-02-17 at 16:30 +1100, NeilBrown wrote:
> mkdir now allows a different dentry to be returned which is sometimes
> relevant for nfs.
>=20
> This patch changes the nfs_rpc_ops mkdir op to return a dentry, and
> passes that back to the caller.
>=20
> The mkdir nfs_rpc_op will return NULL if the original dentry should be
> used.  This matches the mkdir inode_operation.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/dir.c            | 16 ++++++---------
>  fs/nfs/nfs3proc.c       |  7 ++++---
>  fs/nfs/nfs4proc.c       | 43 +++++++++++++++++++++++++++++------------
>  fs/nfs/proc.c           | 12 ++++++++----
>  include/linux/nfs_xdr.h |  2 +-
>  5 files changed, 50 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 5700f73d48bc..afb1afe0af8e 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2426,7 +2426,7 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  			 struct dentry *dentry, umode_t mode)
>  {
>  	struct iattr attr;
> -	int error;
> +	struct dentry *ret;
> =20
>  	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
> @@ -2435,15 +2435,11 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap,=
 struct inode *dir,
>  	attr.ia_mode =3D mode | S_IFDIR;
> =20
>  	trace_nfs_mkdir_enter(dir, dentry);
> -	error =3D NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
> -	trace_nfs_mkdir_exit(dir, dentry, error);
> -	if (error !=3D 0)
> -		goto out_err;
> -	/* FIXME - ->mkdir might have used an alternate dentry */
> -	return NULL;
> -out_err:
> -	d_drop(dentry);
> -	return ERR_PTR(error);
> +	ret =3D NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
> +	trace_nfs_mkdir_exit(dir, dentry, PTR_ERR_OR_ZERO(ret));

FWIW, this should be fine even since the old dentry should have the
same d_name as the one in ret, if one is returned.
=20
> +	if (IS_ERR(ret))
> +		d_drop(dentry);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(nfs_mkdir);
> =20
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 0c3bc98cd999..cccb12ba19dc 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -578,7 +578,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *d=
entry, struct folio *folio,
>  	return status;
>  }
> =20
> -static int
> +static struct dentry *
>  nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *=
sattr)
>  {
>  	struct posix_acl *default_acl, *acl;
> @@ -613,14 +613,15 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *d=
entry, struct iattr *sattr)
> =20
>  	status =3D nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
> =20
> -	dput(d_alias);
>  out_release_acls:
>  	posix_acl_release(acl);
>  	posix_acl_release(default_acl);
>  out:
>  	nfs3_free_createdata(data);
>  	dprintk("NFS reply mkdir: %d\n", status);
> -	return status;
> +	if (status)
> +		return ERR_PTR(status);
> +	return d_alias;
>  }
> =20
>  static int
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..164c9f3f36c8 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5135,9 +5135,6 @@ static int nfs4_do_create(struct inode *dir, struct=
 dentry *dentry, struct nfs4_
>  				    &data->arg.seq_args, &data->res.seq_res, 1);
>  	if (status =3D=3D 0) {
>  		spin_lock(&dir->i_lock);
> -		/* Creating a directory bumps nlink in the parent */
> -		if (data->arg.ftype =3D=3D NF4DIR)
> -			nfs4_inc_nlink_locked(dir);
>  		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
>  					      data->res.fattr->time_start,
>  					      NFS_INO_INVALID_DATA);
> @@ -5147,6 +5144,25 @@ static int nfs4_do_create(struct inode *dir, struc=
t dentry *dentry, struct nfs4_
>  	return status;
>  }
> =20
> +static struct dentry *nfs4_do_mkdir(struct inode *dir, struct dentry *de=
ntry,
> +				    struct nfs4_createdata *data)
> +{
> +	int status =3D nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir),=
 &data->msg,
> +				    &data->arg.seq_args, &data->res.seq_res, 1);
> +
> +	if (status)
> +		return ERR_PTR(status);
> +
> +	spin_lock(&dir->i_lock);
> +	/* Creating a directory bumps nlink in the parent */
> +	nfs4_inc_nlink_locked(dir);
> +	nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
> +				      data->res.fattr->time_start,
> +				      NFS_INO_INVALID_DATA);
> +	spin_unlock(&dir->i_lock);
> +	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
> +}
> +
>  static void nfs4_free_createdata(struct nfs4_createdata *data)
>  {
>  	nfs4_label_free(data->fattr.label);
> @@ -5203,32 +5219,34 @@ static int nfs4_proc_symlink(struct inode *dir, s=
truct dentry *dentry,
>  	return err;
>  }
> =20
> -static int _nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
> -		struct iattr *sattr, struct nfs4_label *label)
> +static struct dentry *_nfs4_proc_mkdir(struct inode *dir, struct dentry =
*dentry,
> +				       struct iattr *sattr,
> +				       struct nfs4_label *label)
>  {
>  	struct nfs4_createdata *data;
> -	int status =3D -ENOMEM;
> +	struct dentry *ret =3D ERR_PTR(-ENOMEM);
> =20
>  	data =3D nfs4_alloc_createdata(dir, &dentry->d_name, sattr, NF4DIR);
>  	if (data =3D=3D NULL)
>  		goto out;
> =20
>  	data->arg.label =3D label;
> -	status =3D nfs4_do_create(dir, dentry, data);
> +	ret =3D nfs4_do_mkdir(dir, dentry, data);
> =20
>  	nfs4_free_createdata(data);
>  out:
> -	return status;
> +	return ret;
>  }
> =20
> -static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
> -		struct iattr *sattr)
> +static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *=
dentry,
> +				      struct iattr *sattr)
>  {
>  	struct nfs_server *server =3D NFS_SERVER(dir);
>  	struct nfs4_exception exception =3D {
>  		.interruptible =3D true,
>  	};
>  	struct nfs4_label l, *label;
> +	struct dentry *alias;
>  	int err;
> =20
>  	label =3D nfs4_label_init_security(dir, dentry, sattr, &l);
> @@ -5236,14 +5254,15 @@ static int nfs4_proc_mkdir(struct inode *dir, str=
uct dentry *dentry,
>  	if (!(server->attr_bitmask[2] & FATTR4_WORD2_MODE_UMASK))
>  		sattr->ia_mode &=3D ~current_umask();
>  	do {
> -		err =3D _nfs4_proc_mkdir(dir, dentry, sattr, label);
> +		alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label);
> +		err =3D PTR_ERR_OR_ZERO(alias);
>  		trace_nfs4_mkdir(dir, &dentry->d_name, err);
>  		err =3D nfs4_handle_exception(NFS_SERVER(dir), err,
>  				&exception);
>  	} while (exception.retry);
>  	nfs4_label_release_security(label);
> =20
> -	return err;
> +	return alias;
>  }
> =20
>  static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index 77920a2e3cef..63e71310b9f6 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -446,13 +446,14 @@ nfs_proc_symlink(struct inode *dir, struct dentry *=
dentry, struct folio *folio,
>  	return status;
>  }
> =20
> -static int
> +static struct dentry *
>  nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *s=
attr)
>  {
>  	struct nfs_createdata *data;
>  	struct rpc_message msg =3D {
>  		.rpc_proc	=3D &nfs_procedures[NFSPROC_MKDIR],
>  	};
> +	struct dentry *alias =3D NULL;
>  	int status =3D -ENOMEM;
> =20
>  	dprintk("NFS call  mkdir %pd\n", dentry);
> @@ -464,12 +465,15 @@ nfs_proc_mkdir(struct inode *dir, struct dentry *de=
ntry, struct iattr *sattr)
> =20
>  	status =3D rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
>  	nfs_mark_for_revalidate(dir);
> -	if (status =3D=3D 0)
> -		status =3D nfs_instantiate(dentry, data->res.fh, data->res.fattr);
> +	if (status =3D=3D 0) {
> +		alias =3D nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
> +		status =3D PTR_ERR_OR_ZERO(alias);
> +	} else
> +		alias =3D ERR_PTR(status);
>  	nfs_free_createdata(data);
>  out:
>  	dprintk("NFS reply mkdir: %d\n", status);
> -	return status;
> +	return alias;
>  }
> =20
>  static int
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 9155a6ffc370..d66c61cbbd1d 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1802,7 +1802,7 @@ struct nfs_rpc_ops {
>  	int	(*link)    (struct inode *, struct inode *, const struct qstr *);
>  	int	(*symlink) (struct inode *, struct dentry *, struct folio *,
>  			    unsigned int, struct iattr *);
> -	int	(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
> +	struct dentry *(*mkdir)   (struct inode *, struct dentry *, struct iatt=
r *);
>  	int	(*rmdir)   (struct inode *, const struct qstr *);
>  	int	(*readdir) (struct nfs_readdir_arg *, struct nfs_readdir_res *);
>  	int	(*mknod)   (struct inode *, struct dentry *, struct iattr *,

Reviewed-by: Jeff Layton <jlayton@kernel.org>

