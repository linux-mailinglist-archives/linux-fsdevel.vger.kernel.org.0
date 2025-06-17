Return-Path: <linux-fsdevel+bounces-51850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD92ADC221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0515E1896A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30428C2B6;
	Tue, 17 Jun 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3xJYa2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994A1E521D;
	Tue, 17 Jun 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140687; cv=none; b=mgwNS/jvPRwGrk9hv07zFLEmaY+HKrgOuSzGCou/iSupu+bbuWehmWTPRxJcQhRCZH1o4wcCR1t6aSi+LoOsy2Oa9Ndx2R7NriYtuYYT5olEraUOiNK48tVgxQL7Bw1mKhlMTgAHNSYh5SGA2UJKLfi0/xqlQ2l/DDbGnCkLYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140687; c=relaxed/simple;
	bh=RgJWHD65/lLqLRRj/mZf66iDcTZ9KMomSVgLP6/ZWFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOW2pc/3riDTILLEoiug0tX9QpPDXB/1xMCGmtuQR333gzVk/ZExEzR5q7X1DPmqfg4GgR9yYqr0mcHQ6EPvxxud+sOr6CjJWuNuQyRwoQkE+ggv9yOjip8FVIP+y52bDnR+zAJ2FQo5ZkNDT2xN1czhXqGa0Jqd4yc9MT++t9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3xJYa2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9011C4CEE3;
	Tue, 17 Jun 2025 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140686;
	bh=RgJWHD65/lLqLRRj/mZf66iDcTZ9KMomSVgLP6/ZWFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3xJYa2Dx37asskvhJcEb2wXZaSzAH1DPhKkXRyClSTWR+He5ZalWkkP7ONdMuPEK
	 T7PvSxP+V+/Z/yV2GSoS7eIQVWGD3FUNbzcLXDV9r/rhPoAXdzRjzvRK/3kCDyfnGS
	 ITi6x7ck1nOFgauZtRPytsFUxynAz04qzpfogCKWvLhbr5aRU0B0CobchHRRDLqwvO
	 8u47+EzNNuDHekc57FWyRrBlIMDV62qJNpObWQsWcusYvY3qf6ikHPxX18ktFNLYZs
	 ehEhqK4gzNDPbPG7Y5w336pJ1Vu+XbXeNMDtSFjqYRiCgthqniAdWtXkJUw6Xd5KkO
	 kEMRkfVMLBUNg==
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
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
Date: Mon, 16 Jun 2025 23:11:12 -0700
Message-ID: <20250617061116.3681325-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617061116.3681325-1-song@kernel.org>
References: <20250617061116.3681325-1-song@kernel.org>
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
 fs/namei.c            | 95 +++++++++++++++++++++++++++++++++++--------
 include/linux/namei.h |  2 +
 2 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..d0557c0b5cc8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2048,36 +2048,95 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
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
-	struct dentry *parent;
-
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
+	return dget_parent(path->dentry);
+
+in_root:
+	if (unlikely(flags & LOOKUP_BENEATH))
+		return ERR_PTR(-EXDEV);
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
+ * not changed.
+ *
+ * Returns:
+ *  0  - if @path is updated to its parent.
+ *  <0 - if @path is already the root (real root or @root).
+ */
+int path_walk_parent(struct path *path, const struct path *root)
+{
+	struct dentry *parent;
+
+	parent = __path_walk_parent(path, root, LOOKUP_BENEATH);
+
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	if (parent == path->dentry) {
+		dput(parent);
+		return -ENOENT;
+	}
+	dput(path->dentry);
+	path->dentry = parent;
+	return 0;
+}
+
+static struct dentry *follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
+
+	if (IS_ERR(parent))
+		return parent;
 	if (unlikely(!path_connected(nd->path.mnt, parent))) {
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
+	nd->inode = nd->path.dentry->d_inode;
 	return parent;
-
-in_root:
-	if (unlikely(nd->flags & LOOKUP_BENEATH))
-		return ERR_PTR(-EXDEV);
-	return dget(nd->path.dentry);
 }
 
 static const char *handle_dots(struct nameidata *nd, int type)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..ca68fa4089e0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+int path_walk_parent(struct path *path, const struct path *root);
+
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
-- 
2.47.1


