Return-Path: <linux-fsdevel+bounces-51366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67630AD6213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB87189B467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9224BCF5;
	Wed, 11 Jun 2025 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMrRIyq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51C22331E;
	Wed, 11 Jun 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679351; cv=none; b=H0S3rNMLmPfYzw4cYkEutfTCf697UH22U/ZjGGsGFuK8Npy9Pl1A5g9mNtJHccFDtMR48oVxlnFgyFT7qcWSsYaaTVsFXufheNlCf1KPl9PFTKyL8fIYcLf5JSJAvpaJlc76mt8EiKg8IsXjINwT0H8Xx5umKi8uePSTsA90js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679351; c=relaxed/simple;
	bh=I1E1/88ouy4jlOHjaJMujlro8u00FJXobC+CmNEcaCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elo31X5xKYaAEkqTiE/jr3AH6YYZWtwuegNZsOe1Jl3TD1dwvS1FG2YZyIRjxTsuFidcbXsjZ/UXE1jZcv3aKU6kDayCzU6O7s1KiqulHA5c5VXztHZTikUoy0lkUr+zhxD4cY7cB2EFue2L+0KNOqx3yK/ty4axWxQbHQEVFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMrRIyq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BF7C4CEE3;
	Wed, 11 Jun 2025 22:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749679350;
	bh=I1E1/88ouy4jlOHjaJMujlro8u00FJXobC+CmNEcaCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMrRIyq+qkj/dZq7tuFHdi4DidWUVn8ep31aFjVfUeY5qJEot525F8AetBcYB+cgQ
	 /zLAxAXFz+GPF2UIhiRywWujiPB2ADihIHcv2enJM02HpJNoMY3JmngCYqLutWZGtf
	 IDCmhTPbeK51fJ1ax06sMxEPOQLlvyOSVLh3IN+fVKISKmuePucR6K6D4Cm3rxJFVl
	 smnmlG3ezzVSik/AHWKSq6zKm4QFjgJqOLMEkhMgIwm9aUFnm9RzJHGMUvyrikcgPl
	 Z1T9MNDM25Kv1fuSHKsbEQeNWXWBl2ROmJzRbdT5a+RlzA525JPGaseeEGAq41QNhX
	 JjBzIhvkOwHpg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
Date: Wed, 11 Jun 2025 15:02:16 -0700
Message-ID: <20250611220220.3681382-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611220220.3681382-1-song@kernel.org>
References: <20250611220220.3681382-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper walks an input path to its parent. Logic are added to handle
walking across mount tree.

This will be used by landlock, and BPF LSM.

Suggested-by: Neil Brown <neil@brown.name>
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namei.c            | 99 +++++++++++++++++++++++++++++++++++++------
 include/linux/namei.h |  2 +
 2 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..bc65361c5d13 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2048,36 +2048,107 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 	return nd->path.dentry;
 }
 
-static struct dentry *follow_dotdot(struct nameidata *nd)
+/**
+ * __path_walk_parent - Find the parent of the given struct path
+ * @path  - The struct path to start from
+ * @root  - A struct path which serves as a boundary not to be crosses.
+ *        - If @root is zero'ed, walk all the way to global root.
+ * @flags - Some LOOKUP_ flags.
+ *
+ * Find and return the dentry for the parent of the given path
+ * (mount/dentry). If the given path is the root of a mounted tree, it
+ * is first updated to the mount point on which that tree is mounted.
+ *
+ * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a new
+ * mount, the error EXDEV is returned.
+ *
+ * If no parent can be found, either because the tree is not mounted or
+ * because the @path matches the @root, then @path->dentry is returned
+ * unless @flags contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
+ *
+ * Returns: either an ERR_PTR() or the chosen parent which will have had
+ * the refcount incremented.
+ */
+static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
 {
 	struct dentry *parent;
 
-	if (path_equal(&nd->path, &nd->root))
+	if (path_equal(path, root))
 		goto in_root;
-	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path;
+	if (unlikely(path->dentry == path->mnt->mnt_root)) {
+		struct path new_path;
 
-		if (!choose_mountpoint(real_mount(nd->path.mnt),
-				       &nd->root, &path))
+		if (!choose_mountpoint(real_mount(path->mnt),
+				       root, &new_path))
 			goto in_root;
-		path_put(&nd->path);
-		nd->path = path;
-		nd->inode = path.dentry->d_inode;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+		path_put(path);
+		*path = new_path;
+		if (unlikely(flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
 	/* rare case of legitimate dget_parent()... */
-	parent = dget_parent(nd->path.dentry);
-	if (unlikely(!path_connected(nd->path.mnt, parent))) {
+	parent = dget_parent(path->dentry);
+	if (unlikely(!path_connected(path->mnt, parent))) {
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
 	return parent;
 
 in_root:
-	if (unlikely(nd->flags & LOOKUP_BENEATH))
+	if (unlikely(flags & LOOKUP_BENEATH))
 		return ERR_PTR(-EXDEV);
-	return dget(nd->path.dentry);
+	return dget(path->dentry);
+}
+
+/**
+ * path_walk_parent - Walk to the parent of path
+ * @path: input and output path.
+ * @root: root of the path walk, do not go beyond this root. If @root is
+ *        zero'ed, walk all the way to real root.
+ *
+ * Given a path, find the parent path. Replace @path with the parent path.
+ * If we were already at the real root or a disconnected root, @path is
+ * released and zero'ed.
+ *
+ * Returns:
+ *  true  - if @path is updated to its parent.
+ *  false - if @path is already the root (real root or @root).
+ */
+bool path_walk_parent(struct path *path, const struct path *root)
+{
+	struct dentry *parent;
+
+	parent = __path_walk_parent(path, root, LOOKUP_BENEATH);
+
+	if (IS_ERR(parent))
+		goto false_out;
+
+	if (parent == path->dentry) {
+		dput(parent);
+		goto false_out;
+	}
+	dput(path->dentry);
+	path->dentry = parent;
+	return true;
+
+false_out:
+	path_put(path);
+	memset(path, 0, sizeof(*path));
+	return false;
+}
+
+static struct dentry *follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
+
+	if (IS_ERR(parent))
+		return parent;
+	if (unlikely(!path_connected(nd->path.mnt, parent))) {
+		dput(parent);
+		return ERR_PTR(-ENOENT);
+	}
+	nd->inode = nd->path.dentry->d_inode;
+	return parent;
 }
 
 static const char *handle_dots(struct nameidata *nd, int type)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..cba5373ecf86 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+bool path_walk_parent(struct path *path, const struct path *root);
+
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
-- 
2.47.1


