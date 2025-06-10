Return-Path: <linux-fsdevel+bounces-51210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BABAD46CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC49A7AC3C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 23:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB828BA88;
	Tue, 10 Jun 2025 23:34:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1322248AB;
	Tue, 10 Jun 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598490; cv=none; b=WKOq1khTUIZvIsch9BmHR7YNCfQIinhoAkA++VFUJg7plkRiyBRuzw/QQrVElED0ZGTxBBo02YrFe6ZQ2IF5SVLXWJ8gLGcGpQBn2Gglhx3/8v9oO+4nejCOBlReZ/91Y+tULf/KzATGvw4TvUfA+GnO9Ih2JJ4OKXlHb0HWgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598490; c=relaxed/simple;
	bh=nAjYQX+TSMsZ9bA78ZfRAkX5IYz9wrbImSKD6ErItyQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pBQyxuUh8kbj+uERSQL5RNuklCgRmT0aPUWPdqIF0xod3g8zwUJogulwtshYX41ceKEINOAn7LoRifPWDzjV0NFqhxfoP3EABle4B0eRZ/SkgyePXNMONe6aAbd64VmP+IVnoBFJD8k2T1qahZeGiyXQt7YvDe47vWvj+4floZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uP8UH-007smc-Po;
	Tue, 10 Jun 2025 23:34:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Song Liu" <song@kernel.org>, Jan Kara <jack@suse.cz>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com,
 m@maowtm.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
In-reply-to: <20250606213015.255134-2-song@kernel.org>
References: <20250606213015.255134-1-song@kernel.org>,
 <20250606213015.255134-2-song@kernel.org>
Date: Wed, 11 Jun 2025 09:34:36 +1000
Message-id: <174959847640.608730.1496017556661353963@noble.neil.brown.name>

On Sat, 07 Jun 2025, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
>=20
> This will be used by landlock, and BPF LSM.
>=20
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c            | 51 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 53 insertions(+)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..f02183e9c073 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1424,6 +1424,57 @@ static bool choose_mountpoint(struct mount *m, const=
 struct path *root,
>  	return found;
>  }
> =20
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * not changed.
> + *
> + * The logic of path_walk_parent() is similar to follow_dotdot(), except
> + * that path_walk_parent() will continue walking for !path_connected case.
> + * This effectively means we are walking from disconnected bind mount to
> + * the original mount. If this behavior is not desired, the caller can add
> + * a check like:
> + *
> + *   if (path_walk_parent(&path) && !path_connected(path.mnt, path.dentry)
> + *           // continue walking
> + *   else
> + *           // stop walking
> + *
> + * Returns:
> + *  true  - if @path is updated to its parent.
> + *  false - if @path is already the root (real root or @root).
> + */
> +bool path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	if (path_equal(path, root))
> +		return false;
> +
> +	if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
> +		struct path p;
> +
> +		if (!choose_mountpoint(real_mount(path->mnt), root, &p))
> +			return false;
> +		path_put(path);
> +		*path =3D p;
> +	}
> +
> +	if (unlikely(IS_ROOT(path->dentry)))
> +		return false;
> +
> +	parent =3D dget_parent(path->dentry);
> +	dput(path->dentry);
> +	path->dentry =3D parent;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(path_walk_parent);

The above looks a lot like follow_dotdot().  This is good because it
means that it is likely correct.  But it is bad because it means there
are two copies of essentially the same code - making maintenance harder.

I think it would be good to split the part that you want out of
follow_dotdot() and use that.  Something like the following.

You might need a small wrapper in landlock which would, for example,
pass LOOKUP_BENEATH and replace path->dentry with the parent on success.

NeilBrown

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..b81d07b4417b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2048,36 +2048,65 @@ static struct dentry *follow_dotdot_rcu(struct nameid=
ata *nd)
 	return nd->path.dentry;
 }
=20
-static struct dentry *follow_dotdot(struct nameidata *nd)
+/**
+ * path_walk_parent - Find the parent of the given struct path
+ * @path  - The struct path to start from
+ * @root  - A struct path which serves as a boundary not to be crosses
+ * @flags - Some LOOKUP_ flags
+ *
+ * Find and return the dentry for the parent of the given path (mount/dentry=
).
+ * If the given path is the root of a mounted tree, it is first updated to
+ * the mount point on which that tree is mounted.
+ *
+ * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new mo=
unt,
+ * the error EXDEV is returned.
+ * If no parent can be found, either because the tree is not mounted or beca=
use
+ * the @path matches the @root, then @path->dentry is returned unless @flags
+ * contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
+ *
+ * Returns: either an ERR_PTR() or the chosen parent which will have had the
+ * refcount incremented.
+ */
+struct dentry *path_walk_parent(struct path *path, struct path *root, int fl=
ags)
 {
 	struct dentry *parent;
=20
-	if (path_equal(&nd->path, &nd->root))
+	if (path_equal(path, root))
 		goto in_root;
-	if (unlikely(nd->path.dentry =3D=3D nd->path.mnt->mnt_root)) {
-		struct path path;
+	if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
+		struct path new_path;
=20
-		if (!choose_mountpoint(real_mount(nd->path.mnt),
-				       &nd->root, &path))
+		if (!choose_mountpoint(real_mount(path->mnt),
+				       root, &new_path))
 			goto in_root;
-		path_put(&nd->path);
-		nd->path =3D path;
-		nd->inode =3D path.dentry->d_inode;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+		path_put(path);
+		*path =3D new_path;
+		if (unlikely(flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
 	/* rare case of legitimate dget_parent()... */
-	parent =3D dget_parent(nd->path.dentry);
+	parent =3D dget_parent(path->dentry);
+	return parent;
+
+in_root:
+	if (unlikely(flags & LOOKUP_BENEATH))
+		return ERR_PTR(-EXDEV);
+	return dget(path->dentry);
+}
+EXPORT_SYMBOL(path_walk_parent);
+
+static struct dentry *follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent =3D path_walk_parent(&nd->path, &nd->root, nd->flags);
+
+	if (IS_ERR(parent))
+		return parent;
 	if (unlikely(!path_connected(nd->path.mnt, parent))) {
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
+	nd->inode =3D nd->path.dentry->d_inode;
 	return parent;
-
-in_root:
-	if (unlikely(nd->flags & LOOKUP_BENEATH))
-		return ERR_PTR(-EXDEV);
-	return dget(nd->path.dentry);
 }
=20
 static const char *handle_dots(struct nameidata *nd, int type)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..4cc15a58d900 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -80,6 +80,7 @@ struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap,
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
 					    struct dentry *base);
+struct dentry *path_walk_parent(struct path *path, struct path *root, int fl=
ags);
=20
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);

