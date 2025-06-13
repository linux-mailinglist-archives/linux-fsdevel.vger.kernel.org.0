Return-Path: <linux-fsdevel+bounces-51533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9198AD7F7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F561892533
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88224207F;
	Fri, 13 Jun 2025 00:11:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9D1B95B;
	Fri, 13 Jun 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773470; cv=none; b=txc9DusHujGDBWNifMHbDcJhoR6xr16/1dfGyJPgYQCm907OLSXVqKlAllfr6ML/RQsMjPuGXIpKQ4YW6mmPGEyyaS4ilIIiyC7Zml4czmMHsJyLSgtdO3tTU+6oJdMiwC5XbltXwuY6TH9373aK6Jhqdd1V3z3zteVxiz02D+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773470; c=relaxed/simple;
	bh=Xf1sOH/3QGZlGQDOZlVWDmfVLgVBfgZWJ/NW2lY6tIA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mQuMq9hiA9WB8Mwp6zVimAOrodTzPEf9GwFHgebV/l+o/QQqO3ypNy0mhW2B2uEzYAUZgtZZmneAOXx3WVBYh2wmFT38z1HaX65xoIF8utwspM5NfDqMhil2AYmNtZzKonYlwmEUBAz0yrwWYTh/uOnNnYtKWgALMKaR+QMWvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPs0W-009ZlJ-Ou;
	Fri, 13 Jun 2025 00:10:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Song Liu" <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com,
 m@maowtm.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v4 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
In-reply-to: <20250611220220.3681382-2-song@kernel.org>
References: <20250611220220.3681382-1-song@kernel.org>,
 <20250611220220.3681382-2-song@kernel.org>
Date: Fri, 13 Jun 2025 10:10:55 +1000
Message-id: <174977345565.608730.2655286329643493783@noble.neil.brown.name>

On Thu, 12 Jun 2025, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
>=20
> This will be used by landlock, and BPF LSM.
>=20
> Suggested-by: Neil Brown <neil@brown.name>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c            | 99 +++++++++++++++++++++++++++++++++++++------
>  include/linux/namei.h |  2 +
>  2 files changed, 87 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..bc65361c5d13 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2048,36 +2048,107 @@ static struct dentry *follow_dotdot_rcu(struct nam=
eidata *nd)
>  	return nd->path.dentry;
>  }
> =20
> -static struct dentry *follow_dotdot(struct nameidata *nd)
> +/**
> + * __path_walk_parent - Find the parent of the given struct path
> + * @path  - The struct path to start from
> + * @root  - A struct path which serves as a boundary not to be crosses.
> + *        - If @root is zero'ed, walk all the way to global root.
> + * @flags - Some LOOKUP_ flags.
> + *
> + * Find and return the dentry for the parent of the given path
> + * (mount/dentry). If the given path is the root of a mounted tree, it
> + * is first updated to the mount point on which that tree is mounted.
> + *
> + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new
> + * mount, the error EXDEV is returned.
> + *
> + * If no parent can be found, either because the tree is not mounted or
> + * because the @path matches the @root, then @path->dentry is returned
> + * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is returne=
d.
> + *
> + * Returns: either an ERR_PTR() or the chosen parent which will have had
> + * the refcount incremented.
> + */
> +static struct dentry *__path_walk_parent(struct path *path, const struct p=
ath *root, int flags)
>  {
>  	struct dentry *parent;
> =20
> -	if (path_equal(&nd->path, &nd->root))
> +	if (path_equal(path, root))
>  		goto in_root;
> -	if (unlikely(nd->path.dentry =3D=3D nd->path.mnt->mnt_root)) {
> -		struct path path;
> +	if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
> +		struct path new_path;
> =20
> -		if (!choose_mountpoint(real_mount(nd->path.mnt),
> -				       &nd->root, &path))
> +		if (!choose_mountpoint(real_mount(path->mnt),
> +				       root, &new_path))
>  			goto in_root;
> -		path_put(&nd->path);
> -		nd->path =3D path;
> -		nd->inode =3D path.dentry->d_inode;
> -		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
> +		path_put(path);
> +		*path =3D new_path;
> +		if (unlikely(flags & LOOKUP_NO_XDEV))
>  			return ERR_PTR(-EXDEV);
>  	}
>  	/* rare case of legitimate dget_parent()... */
> -	parent =3D dget_parent(nd->path.dentry);
> -	if (unlikely(!path_connected(nd->path.mnt, parent))) {
> +	parent =3D dget_parent(path->dentry);
> +	if (unlikely(!path_connected(path->mnt, parent))) {
>  		dput(parent);
>  		return ERR_PTR(-ENOENT);
>  	}
>  	return parent;
> =20
>  in_root:
> -	if (unlikely(nd->flags & LOOKUP_BENEATH))
> +	if (unlikely(flags & LOOKUP_BENEATH))
>  		return ERR_PTR(-EXDEV);
> -	return dget(nd->path.dentry);
> +	return dget(path->dentry);
> +}
> +
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * released and zero'ed.
> + *
> + * Returns:
> + *  true  - if @path is updated to its parent.
> + *  false - if @path is already the root (real root or @root).
> + */
> +bool path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	parent =3D __path_walk_parent(path, root, LOOKUP_BENEATH);
> +
> +	if (IS_ERR(parent))
> +		goto false_out;
> +
> +	if (parent =3D=3D path->dentry) {
> +		dput(parent);
> +		goto false_out;
> +	}
> +	dput(path->dentry);
> +	path->dentry =3D parent;
> +	return true;
> +
> +false_out:
> +	path_put(path);
> +	memset(path, 0, sizeof(*path));
> +	return false;
> +}

I think the public function should return 0 on success and -error on
failure.  That is a well established pattern.  I also think you
shouldn't assume that all callers will want the same flags.

And it isn't clear to me why you want to path_put() on failure.

I wonder if there might be other potential users in the kernel.
If so we should consider how well the interface meets their needs.

autofs, devpts, nfsd, landlock all call follow_up...
maybe they should be using the new interface...
nfsd is the most likely to benefit - particularly nfsd_lookup_parent().

Just a thought..

NeilBrown



> +
> +static struct dentry *follow_dotdot(struct nameidata *nd)
> +{
> +	struct dentry *parent =3D __path_walk_parent(&nd->path, &nd->root, nd->fl=
ags);
> +
> +	if (IS_ERR(parent))
> +		return parent;
> +	if (unlikely(!path_connected(nd->path.mnt, parent))) {
> +		dput(parent);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	nd->inode =3D nd->path.dentry->d_inode;
> +	return parent;
>  }
> =20
>  static const char *handle_dots(struct nameidata *nd, int type)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..cba5373ecf86 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
> =20
> +bool path_walk_parent(struct path *path, const struct path *root);
> +
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> --=20
> 2.47.1
>=20
>=20


