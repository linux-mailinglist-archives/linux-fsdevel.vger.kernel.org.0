Return-Path: <linux-fsdevel+bounces-39495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C35BA1529B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D87188FE18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883A19ABB6;
	Fri, 17 Jan 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pferPUaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8F18D626;
	Fri, 17 Jan 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126758; cv=none; b=mnlz2y+bE4UFKmgmUKbFX8u7y6ZMD10sLl48PhmSwVfQ5ZqN8219RkSfN4A9ENCIiCIhlZQ4p7oTd0kJo4OaHaDyDKJyg6yf/OWXXSCpnLe9ngHVjdhN+VYT/OkvDkZp9m4xDT9jSmfXhEKTSG6zOT/UviooHbOvYhCiADvuDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126758; c=relaxed/simple;
	bh=j0/9jTWWYd8RMR82gwYG27SebDRFj9SceoBtOxDVplk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi01ouGsGelFYoA/qIqnm5Nu8FBDdJI2iI7w/M9iH3414Bfzldjl6TPMtu2x9o02f9ec6MUS1Ha8sIqizJN+45refNDomB94zF9gzAmk/JTtPXjoeffvvYbqXK42g/zqfpYnXFMKUCZysqlJGVbomc+fWnGSJDVs6tm4Fsn7KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pferPUaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25181C4CEDD;
	Fri, 17 Jan 2025 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737126758;
	bh=j0/9jTWWYd8RMR82gwYG27SebDRFj9SceoBtOxDVplk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pferPUaQfigH4KGx1K7Xrp55DUIf+HZN7TQdksnhbyjH96/i5DtgCZYY2CS8OgDZj
	 6GFLKnE7nFVwjXX+o0WUlODgJZONQESHeV22gVcNmbWG//9hWd4PcLEercEX6qLgOV
	 6m8AecbIGOlZllgcn/zn5FSW4CFWMieAhu/uXzhSMGK5Sq65TS0LqJyeNGOC2mPjXK
	 xxwzybCa6cXnuAIwrYOpl11+fDrPckmXYCp2gTcG+n2hDDTqqfx6Z7ueXpreshoF0G
	 ZnmY38YtHeAEaZMhw1xmFnuZnaUcwvFdSfwIXLKhcMuS+w+6huoflQN+of2MgSm/Ij
	 +Qc32f9FNyLvA==
Message-ID: <e5ce27122c9c37d63420a37319d2d610f6cc6fd2.camel@kernel.org>
Subject: Re: [PATCH v2 17/20] nfs: fix ->d_revalidate() UAF on ->d_name
 accesses
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com, amir73il@gmail.com, brauner@kernel.org, 
	ceph-devel@vger.kernel.org, dhowells@redhat.com, hubcap@omnibond.com,
 jack@suse.cz, 	krisman@kernel.org, linux-nfs@vger.kernel.org,
 miklos@szeredi.hu, 	torvalds@linux-foundation.org
Date: Fri, 17 Jan 2025 10:12:35 -0500
In-Reply-To: <20250116052317.485356-17-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
	 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
	 <20250116052317.485356-17-viro@zeniv.linux.org.uk>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-16 at 05:23 +0000, Al Viro wrote:
> Pass the stable name all the way down to ->rpc_ops->lookup() instances.
>=20
> Note that passing &dentry->d_name is safe in e.g. nfs_lookup() - it *is*
> stable there, as it is in ->create() et.al.
>=20
> dget_parent() in nfs_instantiate() should be redundant - it'd better be
> stable there; if it's not, we have more trouble, since ->d_name would
> also be unsafe in such case.
>=20
> nfs_submount() and nfs4_submount() may or may not require fixes - if
> they ever get moved on server with fhandle preserved, we are in trouble
> there...
>=20
> UAF window is fairly narrow here and exfiltration requires the ability
> to watch the traffic.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/nfs/dir.c            | 14 ++++++++------
>  fs/nfs/namespace.c      |  2 +-
>  fs/nfs/nfs3proc.c       |  5 ++---
>  fs/nfs/nfs4proc.c       | 20 ++++++++++----------
>  fs/nfs/proc.c           |  6 +++---
>  include/linux/nfs_xdr.h |  2 +-
>  6 files changed, 25 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index c28983ee75ca..2b04038b0e40 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1672,7 +1672,7 @@ nfs_lookup_revalidate_delegated(struct inode *dir, =
struct dentry *dentry,
>  	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
>  }
> =20
> -static int nfs_lookup_revalidate_dentry(struct inode *dir,
> +static int nfs_lookup_revalidate_dentry(struct inode *dir, const struct =
qstr *name,
>  					struct dentry *dentry,
>  					struct inode *inode, unsigned int flags)
>  {
> @@ -1690,7 +1690,7 @@ static int nfs_lookup_revalidate_dentry(struct inod=
e *dir,
>  		goto out;
> =20
>  	dir_verifier =3D nfs_save_change_attribute(dir);
> -	ret =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
> +	ret =3D NFS_PROTO(dir)->lookup(dir, dentry, name, fhandle, fattr);
>  	if (ret < 0)
>  		goto out;
> =20
> @@ -1775,7 +1775,7 @@ nfs_do_lookup_revalidate(struct inode *dir, const s=
truct qstr *name,
>  	if (NFS_STALE(inode))
>  		goto out_bad;
> =20
> -	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
> +	return nfs_lookup_revalidate_dentry(dir, name, dentry, inode, flags);
>  out_valid:
>  	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
>  out_bad:
> @@ -1970,7 +1970,8 @@ struct dentry *nfs_lookup(struct inode *dir, struct=
 dentry * dentry, unsigned in
> =20
>  	dir_verifier =3D nfs_save_change_attribute(dir);
>  	trace_nfs_lookup_enter(dir, dentry, flags);
> -	error =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
> +	error =3D NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
> +				       fhandle, fattr);
>  	if (error =3D=3D -ENOENT) {
>  		if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
>  			dir_verifier =3D inode_peek_iversion_raw(dir);
> @@ -2246,7 +2247,7 @@ nfs4_lookup_revalidate(struct inode *dir, const str=
uct qstr *name,
>  reval_dentry:
>  	if (flags & LOOKUP_RCU)
>  		return -ECHILD;
> -	return nfs_lookup_revalidate_dentry(dir, dentry, inode, flags);
> +	return nfs_lookup_revalidate_dentry(dir, name, dentry, inode, flags);
> =20
>  full_reval:
>  	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
> @@ -2305,7 +2306,8 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs=
_fh *fhandle,
>  	d_drop(dentry);
> =20
>  	if (fhandle->size =3D=3D 0) {
> -		error =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
> +		error =3D NFS_PROTO(dir)->lookup(dir, dentry, &dentry->d_name,
> +					       fhandle, fattr);
>  		if (error)
>  			goto out_error;
>  	}
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 2d53574da605..973aed9cc5fe 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -308,7 +308,7 @@ int nfs_submount(struct fs_context *fc, struct nfs_se=
rver *server)
>  	int err;
> =20
>  	/* Look it up again to get its attributes */
> -	err =3D server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry,
> +	err =3D server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry, &d=
entry->d_name,
>  						  ctx->mntfh, ctx->clone_data.fattr);
>  	dput(parent);
>  	if (err !=3D 0)
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 1566163c6d85..ce70768e0201 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -192,7 +192,7 @@ __nfs3_proc_lookup(struct inode *dir, const char *nam=
e, size_t len,
>  }
> =20
>  static int
> -nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
> +nfs3_proc_lookup(struct inode *dir, struct dentry *dentry, const struct =
qstr *name,
>  		 struct nfs_fh *fhandle, struct nfs_fattr *fattr)
>  {
>  	unsigned short task_flags =3D 0;
> @@ -202,8 +202,7 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *de=
ntry,
>  		task_flags |=3D RPC_TASK_TIMEOUT;
> =20
>  	dprintk("NFS call  lookup %pd2\n", dentry);
> -	return __nfs3_proc_lookup(dir, dentry->d_name.name,
> -				  dentry->d_name.len, fhandle, fattr,
> +	return __nfs3_proc_lookup(dir, name->name, name->len, fhandle, fattr,
>  				  task_flags);
>  }
> =20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 405f17e6e0b4..4d85068e820d 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4536,15 +4536,15 @@ nfs4_proc_setattr(struct dentry *dentry, struct n=
fs_fattr *fattr,
>  }
> =20
>  static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
> -		struct dentry *dentry, struct nfs_fh *fhandle,
> -		struct nfs_fattr *fattr)
> +		struct dentry *dentry, const struct qstr *name,
> +		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
>  {
>  	struct nfs_server *server =3D NFS_SERVER(dir);
>  	int		       status;
>  	struct nfs4_lookup_arg args =3D {
>  		.bitmask =3D server->attr_bitmask,
>  		.dir_fh =3D NFS_FH(dir),
> -		.name =3D &dentry->d_name,
> +		.name =3D name,
>  	};
>  	struct nfs4_lookup_res res =3D {
>  		.server =3D server,
> @@ -4586,17 +4586,16 @@ static void nfs_fixup_secinfo_attributes(struct n=
fs_fattr *fattr)
>  }
> =20
>  static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode =
*dir,
> -				   struct dentry *dentry, struct nfs_fh *fhandle,
> -				   struct nfs_fattr *fattr)
> +				   struct dentry *dentry, const struct qstr *name,
> +				   struct nfs_fh *fhandle, struct nfs_fattr *fattr)
>  {
>  	struct nfs4_exception exception =3D {
>  		.interruptible =3D true,
>  	};
>  	struct rpc_clnt *client =3D *clnt;
> -	const struct qstr *name =3D &dentry->d_name;
>  	int err;
>  	do {
> -		err =3D _nfs4_proc_lookup(client, dir, dentry, fhandle, fattr);
> +		err =3D _nfs4_proc_lookup(client, dir, dentry, name, fhandle, fattr);
>  		trace_nfs4_lookup(dir, name, err);
>  		switch (err) {
>  		case -NFS4ERR_BADNAME:
> @@ -4631,13 +4630,13 @@ static int nfs4_proc_lookup_common(struct rpc_cln=
t **clnt, struct inode *dir,
>  	return err;
>  }
> =20
> -static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry,
> +static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry, co=
nst struct qstr *name,
>  			    struct nfs_fh *fhandle, struct nfs_fattr *fattr)
>  {
>  	int status;
>  	struct rpc_clnt *client =3D NFS_CLIENT(dir);
> =20
> -	status =3D nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr=
);
> +	status =3D nfs4_proc_lookup_common(&client, dir, dentry, name, fhandle,=
 fattr);
>  	if (client !=3D NFS_CLIENT(dir)) {
>  		rpc_shutdown_client(client);
>  		nfs_fixup_secinfo_attributes(fattr);
> @@ -4652,7 +4651,8 @@ nfs4_proc_lookup_mountpoint(struct inode *dir, stru=
ct dentry *dentry,
>  	struct rpc_clnt *client =3D NFS_CLIENT(dir);
>  	int status;
> =20
> -	status =3D nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr=
);
> +	status =3D nfs4_proc_lookup_common(&client, dir, dentry, &dentry->d_nam=
e,
> +					 fhandle, fattr);
>  	if (status < 0)
>  		return ERR_PTR(status);
>  	return (client =3D=3D NFS_CLIENT(dir)) ? rpc_clone_client(client) : cli=
ent;
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index 6c09cd090c34..77920a2e3cef 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -153,13 +153,13 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_=
fattr *fattr,
>  }
> =20
>  static int
> -nfs_proc_lookup(struct inode *dir, struct dentry *dentry,
> +nfs_proc_lookup(struct inode *dir, struct dentry *dentry, const struct q=
str *name,
>  		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
>  {
>  	struct nfs_diropargs	arg =3D {
>  		.fh		=3D NFS_FH(dir),
> -		.name		=3D dentry->d_name.name,
> -		.len		=3D dentry->d_name.len
> +		.name		=3D name->name,
> +		.len		=3D name->len
>  	};
>  	struct nfs_diropok	res =3D {
>  		.fh		=3D fhandle,
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 559273a0f16d..08b62bbf59f0 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1785,7 +1785,7 @@ struct nfs_rpc_ops {
>  			    struct nfs_fattr *, struct inode *);
>  	int	(*setattr) (struct dentry *, struct nfs_fattr *,
>  			    struct iattr *);
> -	int	(*lookup)  (struct inode *, struct dentry *,
> +	int	(*lookup)  (struct inode *, struct dentry *, const struct qstr *,
>  			    struct nfs_fh *, struct nfs_fattr *);
>  	int	(*lookupp) (struct inode *, struct nfs_fh *,
>  			    struct nfs_fattr *);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

