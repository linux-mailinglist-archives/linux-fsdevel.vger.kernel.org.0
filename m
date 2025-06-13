Return-Path: <linux-fsdevel+bounces-51602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37843AD947F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66DC1E4A51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19F231832;
	Fri, 13 Jun 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjxZOL4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047A757EA;
	Fri, 13 Jun 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839519; cv=none; b=oca6us0iglvnlO4XUEX24stru1gmrijdETBVX8DU+Atroj6Jey63PJVR7rxBBqEAEKsPcJegseIjSqoTdKcB4rwpmRGohFXFXsv/tvns19QfPS5unWymDqMEoAGiCcZzXKRV7c4d9LBVAULoIeDvZUxbY2iJ1QnRpVGR9hHphTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839519; c=relaxed/simple;
	bh=V+b3KK+c56axkz87WdXsI7DXzzjg1n/07GkyarvOQrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5dHgT+kXSw0VZULsEFTj4ZmcNaZzAAewtpEHWfvOIx3Xupr63Vk48tfftmKhz3cd07le+gN0f4/OlknWD2ffkma4AaW24LIsedNutqdfpCcGgbiOEhBHvsU9ntyxKiQnjqP+sr9UGs1qmPPD9NY03UM7dHeW5l9lTf+I+umvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjxZOL4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FFBC4CEE3;
	Fri, 13 Jun 2025 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749839518;
	bh=V+b3KK+c56axkz87WdXsI7DXzzjg1n/07GkyarvOQrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GjxZOL4nxB7a+uZt/Zo4Avpv2ZB+KZvEQVVSNrWgWIk6sHdzaR3/rbRP8BYWFjP0a
	 yu3YRVX8mdUxc90PuIvoKUocoV3WS25JS4ZQooxsG68StHM+/lfHv3p7djEUpsE3Z7
	 at8Gz8f/SEYmKqmcgzHOm1CxRsKbGqaSVHOdJHg3xgIFFO4D9yLzSdxA4FctK1pAcM
	 B/VloJkwStE+7icMk1FDLs00F1ZF0zgHcu8FG0wuyIHG8nJk75+DZwyE3ZlXQFttZs
	 Yyp9wLOjYSNqFzEaP/NJp9RvtYRWu2qlopx1sGNNMHUU5pl9vMUPPslznMqcWEyxbb
	 pHXSgBBKm7G6g==
Message-ID: <84376c8a7753a8242e9f5730128f0eaea7863b61.camel@kernel.org>
Subject: Re: [PATCH 02/17] new helper: simple_start_creating()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org, trondmy@kernel.org
Date: Fri, 13 Jun 2025 14:31:56 -0400
In-Reply-To: <20250613073432.1871345-2-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
	 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
	 <20250613073432.1871345-2-viro@zeniv.linux.org.uk>
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
> Set the things up for kernel-initiated creation of object in
> a tree-in-dcache filesystem.  With respect to locking it's
> an equivalent of filename_create() - we either get a negative
> dentry with locked parent, or ERR_PTR() and no locks taken.
>=20
> tracefs and debugfs had that open-coded as part of their
> object creation machinery; switched to calling new helper.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/debugfs/inode.c | 21 ++-------------------
>  fs/libfs.c         | 25 +++++++++++++++++++++++++
>  fs/tracefs/inode.c | 15 ++-------------
>  include/linux/fs.h |  1 +
>  4 files changed, 30 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 30c4944e1862..08638e39bd12 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -384,26 +384,9 @@ static struct dentry *start_creating(const char *nam=
e, struct dentry *parent)
>  	if (!parent)
>  		parent =3D debugfs_mount->mnt_root;
> =20
> -	inode_lock(d_inode(parent));
> -	if (unlikely(IS_DEADDIR(d_inode(parent))))
> -		dentry =3D ERR_PTR(-ENOENT);
> -	else
> -		dentry =3D lookup_noperm(&QSTR(name), parent);
> -	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
> -		if (d_is_dir(dentry))
> -			pr_err("Directory '%s' with parent '%s' already present!\n",
> -			       name, parent->d_name.name);
> -		else
> -			pr_err("File '%s' in directory '%s' already present!\n",
> -			       name, parent->d_name.name);

Any chance we could keep a pr_err() for this case? I was doing some
debugfs work recently, and found it helpful.

> -		dput(dentry);
> -		dentry =3D ERR_PTR(-EEXIST);
> -	}
> -
> -	if (IS_ERR(dentry)) {
> -		inode_unlock(d_inode(parent));
> +	dentry =3D simple_start_creating(parent, name);
> +	if (IS_ERR(dentry))
>  		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> -	}
> =20
>  	return dentry;
>  }
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 42e226af6095..833ad5ed10f5 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2260,3 +2260,28 @@ void stashed_dentry_prune(struct dentry *dentry)
>  	 */
>  	cmpxchg(stashed, dentry, NULL);
>  }
> +
> +/* parent must be held exclusive */
> +struct dentry *simple_start_creating(struct dentry *parent, const char *=
name)
> +{
> +	struct dentry *dentry;
> +	struct inode *dir =3D d_inode(parent);
> +
> +	inode_lock(dir);
> +	if (unlikely(IS_DEADDIR(dir))) {
> +		inode_unlock(dir);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	dentry =3D lookup_noperm(&QSTR(name), parent);
> +	if (IS_ERR(dentry)) {
> +		inode_unlock(dir);
> +		return dentry;
> +	}
> +	if (dentry->d_inode) {
> +		dput(dentry);
> +		inode_unlock(dir);
> +		return ERR_PTR(-EEXIST);
> +	}
> +	return dentry;
> +}
> +EXPORT_SYMBOL(simple_start_creating);
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index a3fd3cc591bd..4e5d091e9263 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -551,20 +551,9 @@ struct dentry *tracefs_start_creating(const char *na=
me, struct dentry *parent)
>  	if (!parent)
>  		parent =3D tracefs_mount->mnt_root;
> =20
> -	inode_lock(d_inode(parent));
> -	if (unlikely(IS_DEADDIR(d_inode(parent))))
> -		dentry =3D ERR_PTR(-ENOENT);
> -	else
> -		dentry =3D lookup_noperm(&QSTR(name), parent);
> -	if (!IS_ERR(dentry) && d_inode(dentry)) {
> -		dput(dentry);
> -		dentry =3D ERR_PTR(-EEXIST);
> -	}
> -
> -	if (IS_ERR(dentry)) {
> -		inode_unlock(d_inode(parent));
> +	dentry =3D simple_start_creating(parent, name);
> +	if (IS_ERR(dentry))
>  		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> -	}
> =20
>  	return dentry;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 96c7925a6551..9f75f8836bbd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3619,6 +3619,7 @@ extern int simple_fill_super(struct super_block *, =
unsigned long,
>  			     const struct tree_descr *);
>  extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mo=
unt, int *count);
>  extern void simple_release_fs(struct vfsmount **mount, int *count);
> +struct dentry *simple_start_creating(struct dentry *, const char *);
> =20
>  extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
>  			loff_t *ppos, const void *from, size_t available);

--=20
Jeff Layton <jlayton@kernel.org>

