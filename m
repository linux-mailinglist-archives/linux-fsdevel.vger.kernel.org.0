Return-Path: <linux-fsdevel+bounces-51611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2093AD958A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513DE3B1EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CB22A819;
	Fri, 13 Jun 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY3PEV3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FD22F76C;
	Fri, 13 Jun 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842861; cv=none; b=qkb+RO67dRD33FBb46fTYZlKhWNYXWd3RC2c1GsFmqtb1fZva8lhQfWXnB5MCmxoj7E/lmz6VWq56wPs9nEyfUzlzar58cx26YxQhlRjpsgQqEcWFLHvGWDAStKd15H3pTffAh71MwDDttaOZo+rPG2YU8BEpKkOCPkufXZZfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842861; c=relaxed/simple;
	bh=qonhuy3yfA+w6AeuW+CRJ6dlKmfcLr6iZSqeb8lXXGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mH7SxbtG97yPq6cN7K73tloymu42eU8caJ8skrprS15zftUAfG9GgSSi6dORL5/sixqoRcjhngCyeqHh76imGYsR+q6lQHuO/XdzOH2v3G++2A0s8182r8j/JI3pL1VvFQIgQHDTGVQ2YMsNQ6jkZ68Hhd2kZUBKqSjg9CB8v78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY3PEV3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0EAC4CEE3;
	Fri, 13 Jun 2025 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749842861;
	bh=qonhuy3yfA+w6AeuW+CRJ6dlKmfcLr6iZSqeb8lXXGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mY3PEV3KgEPr2/nbs9/Qp5XzHsX8iD5b1wHccZ4fhY62k0lwG/2bF2Qsycw94CaeB
	 bzYx6QtlFngPU40acF9dFWmkC9CHhEzUxUO5o6+Ugyv7I4qQk8O9kxyhGaLstfUiFc
	 bR7eKYedzJFOo/bcFFzU52G2vHcWygfp/Zl8PAg934Z0hPX3BrVIFT7XdnZHBKGpYe
	 UUbYsB51Sc8JBcCF+KhrsRczsYCgEeBaH4MOUuBVnTJyhQ50+3JXDMkFGH/wOyxOcg
	 lGLLRbfmNPJLirmMSucc0acz9gSXUNVicaDxRH8/j1TesdAlPY9H+szZc+mAa9Ecmz
	 Rb/uoTvvROnlg==
Message-ID: <6ccc761034c253704988b5a7b58d908e06127a9f.camel@kernel.org>
Subject: Re: [PATCH 12/17] rpc_mkpipe_dentry(): switch to start_creating()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org, trondmy@kernel.org
Date: Fri, 13 Jun 2025 15:27:39 -0400
In-Reply-To: <20250613073432.1871345-12-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
	 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
	 <20250613073432.1871345-12-viro@zeniv.linux.org.uk>
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

On Fri, 2025-06-13 at 08:34 +0100, Al Viro wrote:
> ... and make sure we set the rpc_pipe-private part of inode up before
> attaching it to dentry.
>=20

"rpc_pipe->private"

nit: subject should say  "...switch to simple_start_creating()".

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  net/sunrpc/rpc_pipe.c | 83 +++++++++++++++----------------------------
>  1 file changed, 29 insertions(+), 54 deletions(-)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 8f88c75c9b30..a52fe3bbf9dc 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -485,31 +485,6 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
>  	return inode;
>  }
> =20
> -static int __rpc_create_common(struct inode *dir, struct dentry *dentry,
> -			       umode_t mode,
> -			       const struct file_operations *i_fop,
> -			       void *private)
> -{
> -	struct inode *inode;
> -
> -	d_drop(dentry);
> -	inode =3D rpc_get_inode(dir->i_sb, mode);
> -	if (!inode)
> -		goto out_err;
> -	inode->i_ino =3D iunique(dir->i_sb, 100);
> -	if (i_fop)
> -		inode->i_fop =3D i_fop;
> -	if (private)
> -		rpc_inode_setowner(inode, private);
> -	d_add(dentry, inode);
> -	return 0;
> -out_err:
> -	printk(KERN_WARNING "%s: %s failed to allocate inode for dentry %pd\n",
> -			__FILE__, __func__, dentry);
> -	dput(dentry);
> -	return -ENOMEM;
> -}
> -
>  static void
>  init_pipe(struct rpc_pipe *pipe)
>  {
> @@ -546,25 +521,6 @@ struct rpc_pipe *rpc_mkpipe_data(const struct rpc_pi=
pe_ops *ops, int flags)
>  }
>  EXPORT_SYMBOL_GPL(rpc_mkpipe_data);
> =20
> -static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
> -			       umode_t mode,
> -			       const struct file_operations *i_fop,
> -			       void *private,
> -			       struct rpc_pipe *pipe)
> -{
> -	struct rpc_inode *rpci;
> -	int err;
> -
> -	err =3D __rpc_create_common(dir, dentry, S_IFIFO | mode, i_fop, private=
);
> -	if (err)
> -		return err;
> -	rpci =3D RPC_I(d_inode(dentry));
> -	rpci->private =3D private;
> -	rpci->pipe =3D pipe;
> -	fsnotify_create(dir, dentry);
> -	return 0;
> -}
> -
>  static int rpc_new_file(struct dentry *parent,
>  			   const char *name,
>  			   umode_t mode,
> @@ -704,8 +660,10 @@ static struct dentry *rpc_mkdir_populate(struct dent=
ry *parent,
>  int rpc_mkpipe_dentry(struct dentry *parent, const char *name,
>  				 void *private, struct rpc_pipe *pipe)
>  {
> -	struct dentry *dentry;
>  	struct inode *dir =3D d_inode(parent);
> +	struct dentry *dentry;
> +	struct inode *inode;
> +	struct rpc_inode *rpci;
>  	umode_t umode =3D S_IFIFO | 0600;
>  	int err;
> =20
> @@ -715,16 +673,33 @@ int rpc_mkpipe_dentry(struct dentry *parent, const =
char *name,
>  		umode &=3D ~0222;
> =20
>  	dentry =3D simple_start_creating(parent, name);
> -	if (IS_ERR(dentry))
> -		return PTR_ERR(dentry);
> -	err =3D __rpc_mkpipe_dentry(dir, dentry, umode, &rpc_pipe_fops,
> -				  private, pipe);
> -	if (unlikely(err))
> -		pr_warn("%s() failed to create pipe %pd/%s (errno =3D %d)\n",
> -			__func__, parent, name, err);
> -	else
> -		pipe->dentry =3D dentry;
> +	if (IS_ERR(dentry)) {
> +		err =3D PTR_ERR(dentry);
> +		goto failed;
> +	}
> +
> +	inode =3D rpc_get_inode(dir->i_sb, umode);
> +	if (unlikely(!inode)) {
> +		dput(dentry);
> +		inode_unlock(dir);
> +		err =3D -ENOMEM;
> +		goto failed;
> +	}
> +	inode->i_ino =3D iunique(dir->i_sb, 100);
> +	inode->i_fop =3D &rpc_pipe_fops;
> +	rpci =3D RPC_I(inode);
> +	rpci->private =3D private;
> +	rpci->pipe =3D pipe;
> +	rpc_inode_setowner(inode, private);
> +	d_instantiate(dentry, inode);
> +	pipe->dentry =3D dentry;
> +	fsnotify_create(dir, dentry);
>  	inode_unlock(dir);
> +	return 0;
> +
> +failed:
> +	pr_warn("%s() failed to create pipe %pd/%s (errno =3D %d)\n",
> +			__func__, parent, name, err);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(rpc_mkpipe_dentry);

--=20
Jeff Layton <jlayton@kernel.org>

