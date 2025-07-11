Return-Path: <linux-fsdevel+bounces-54698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14BB0248B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84E47B6CD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B122F2C6C;
	Fri, 11 Jul 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yPLiLvUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BA1E1A05
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261935; cv=none; b=YQxsLr5Gvwy/zWjVs2pMzTROwEE+bRR7S4ZsBc0pWlBFghHg9ePwj6Xnvt9Il/QaDFZTCvyCq9MZyg+1P8zWU32oxJMqU+Vow42MXML7/P0eukeWwr2kLUQwzEz3bwFcfpvxXCEEtBmMgZrmUKXnzGdJ3eBcrpL3z2okgl+f6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261935; c=relaxed/simple;
	bh=HpQVfiBxQQXCfChkIkEc4VlR9JldxwIKLJWJXY8vyXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2wRFcOiCgclaX3ZJ9dHQzc6EEqp1FN4oBctFUZsG+OHkE56vi1vBqgGgwgXYmCrvsyZUH0q3/do7mLrRZBbk2taQrqk+COEX/Vy8xTGy4vh0Ky4nS4VbbpeV2q6vTDST8V+0fi4D2Sp7SWCsTPsPspAftQFbme0JU83Z7TeUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yPLiLvUd; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bf1kP4YCrzG7d;
	Fri, 11 Jul 2025 21:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752261597;
	bh=9+Ame6uQZJ1uK8CiYvfLWYxvwY2zVivLuDF1oP4Cqug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPLiLvUdcCZtpxR2MRsfJYc2EBpfQEJWzIEqqZiZY02Np4mb75P32UGe7vFo90dMH
	 tLQv18wFcqyAVDQ/4l7y//jslcgmL/w2VYmtMnciZqQja3lr7lJOtnTAcEF+rQ0D7p
	 vMnnN9AaMBsGBpz6Zub/JXRFIkp7LuPB9fHZxygg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bf1kN6RH4z13C;
	Fri, 11 Jul 2025 21:19:56 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/3] landlock: Fix handling of disconnected directories
Date: Fri, 11 Jul 2025 21:19:33 +0200
Message-ID: <20250711191938.2007175-2-mic@digikod.net>
In-Reply-To: <20250711191938.2007175-1-mic@digikod.net>
References: <20250711191938.2007175-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

We can get disconnected files or directories when they are visible and
opened from a bind mount, before being renamed/moved from the source of
the bind mount in a way that makes them inaccessible from the mount
point (i.e. out of scope).

Until now, access rights tied to files or directories opened through a
disconnected directory were collected by walking the related hierarchy
down to the root of this filesystem because the mount point couldn't be
found.  This could lead to inconsistent access results, and
hard-to-debug renames, especially because such paths cannot be printed.

For a sandboxed task to create a disconnected directory, it needs to
have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
the underlying source of the bind mount, and read access to the related
mount point.  Because a sandboxed task cannot get more access than those
defined by its Landlock domain, this could only lead to inconsistent
access rights because of missing those that should be inherited from the
mount point hierarchy and inheriting from the hierarchy of the mounted
filesystem instead.

Landlock now handles files/directories opened from disconnected
directories like the mount point these disconnected directories were
opened from.  This gives the guarantee that access rights on a
file/directory cannot be more than those at open time.  The rationale is
that disconnected hierarchies might not be visible nor accessible to a
sandboxed task, and relying on the collected access rights from them
could introduce unexpected results, especially for rename actions
because of the access right comparison between the source and the
destination (see LANDLOCK_ACCESS_FS_REFER).  This new behavior is much
less surprising to users and safer from an access point of view.

Unlike follow_dotdot(), we don't need to check for each directory if it
is part of the mount's root, but instead this is only checked when we
reached a root dentry (not a mount point), or when the access
request is about to be allowed.  This limits the number of calls to
is_subdir() which walks down the hierarchy (again).  This also avoids
checking path connection at the beginning of the walk for each mount
point, which would be racy.

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix comment.  Using an unlikely() annotation doesn't seem appropriate
here.

This change increases the stack size with two Landlock layer masks
backups that are needed to reset the collected access rights to the
latest mount point.

Because opened files have their access rights stored in the related file
security properties, their is no impact for disconnected or unlinked
files.

Make path_connected() public to stay consistent with the VFS.  This
helper is used when we are about to allowed an access.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- Remove useless else branch in is_access_to_paths_allowed().
- Update commit message and squash "landlock: Remove warning in
  collect_domain_accesses()":
  https://lore.kernel.org/r/20250618134734.1673254-1-mic@digikod.net
- Remove "extern" for path_connected() in fs.h, requested by Christian.
- Add Acked-by Christian.
- Fix docstring and improve doc for collect_domain_accesses().
- Remove path_connected() check for the real root.
- Fix allowed_parent* resets to be consistent with their initial values
  infered from the evaluated domain.
- Add Landlock erratum.
---
 fs/namei.c                       |   2 +-
 include/linux/fs.h               |   1 +
 security/landlock/errata/abi-1.h |  16 ++++
 security/landlock/fs.c           | 124 +++++++++++++++++++++++++------
 4 files changed, 118 insertions(+), 25 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..7853a876fc1c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -716,7 +716,7 @@ static bool nd_alloc_stack(struct nameidata *nd)
  * Rename can sometimes move a file or directory outside of a bind
  * mount, path_connected allows those cases to be detected.
  */
-static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
+bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct super_block *sb = mnt->mnt_sb;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ec77da65f14..fce95b30c4aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3252,6 +3252,7 @@ extern struct file * open_exec(const char *);
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
+bool path_connected(struct vfsmount *mnt, struct dentry *dentry);
 
 extern char *file_path(struct file *, char *, int);
 
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
new file mode 100644
index 000000000000..db785b2d44b3
--- /dev/null
+++ b/security/landlock/errata/abi-1.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_3
+ *
+ * Erratum 3: Disconnected directory handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue with disconnected directories that occur when
+ * a directory is moved outside the scope of a bind mount. The change ensures
+ * that evaluated access rights exclude those inherited from disconnected
+ * file hierarchies (no longer accessible from the related mount point),
+ * and instead only consider rights tied to directories that remain visible.
+ * This prevents access inconsistencies caused by missing access rights.
+ */
+LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..da862fda329b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -768,7 +768,9 @@ static bool is_access_to_paths_allowed(
 	struct path walker_path;
 	access_mask_t access_masked_parent1, access_masked_parent2;
 	layer_mask_t _layer_masks_child1[LANDLOCK_NUM_ACCESS_FS],
-		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
+		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS],
+		_layer_masks_parent1_bkp[LANDLOCK_NUM_ACCESS_FS],
+		_layer_masks_parent2_bkp[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
 
@@ -800,6 +802,8 @@ static bool is_access_to_paths_allowed(
 		access_masked_parent1 = access_masked_parent2 =
 			landlock_union_access_masks(domain).fs;
 		is_dom_check = true;
+		memcpy(&_layer_masks_parent2_bkp, layer_masks_parent2,
+		       sizeof(_layer_masks_parent2_bkp));
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
 			return false;
@@ -807,6 +811,8 @@ static bool is_access_to_paths_allowed(
 		access_masked_parent1 = access_request_parent1;
 		access_masked_parent2 = access_request_parent2;
 		is_dom_check = false;
+		memcpy(&_layer_masks_parent1_bkp, layer_masks_parent1,
+		       sizeof(_layer_masks_parent1_bkp));
 	}
 
 	if (unlikely(dentry_child1)) {
@@ -858,6 +864,14 @@ static bool is_access_to_paths_allowed(
 				     child1_is_directory, layer_masks_parent2,
 				     layer_masks_child2,
 				     child2_is_directory))) {
+			/*
+			 * Rewinds walk for disconnected directories before any other state
+			 * change.
+			 */
+			if (unlikely(!path_connected(walker_path.mnt,
+						     walker_path.dentry)))
+				goto reset_to_mount_root;
+
 			/*
 			 * Now, downgrades the remaining checks from domain
 			 * handled accesses to requested accesses.
@@ -893,11 +907,30 @@ static bool is_access_to_paths_allowed(
 					  ARRAY_SIZE(*layer_masks_parent2));
 
 		/* Stops when a rule from each layer grants access. */
-		if (allowed_parent1 && allowed_parent2)
+		if (allowed_parent1 && allowed_parent2) {
+			/*
+			 * Rewinds walk for disconnected directories before any other state
+			 * change.
+			 */
+			if (unlikely(!path_connected(walker_path.mnt,
+						     walker_path.dentry)))
+				goto reset_to_mount_root;
+
 			break;
+		}
+
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
 			if (follow_up(&walker_path)) {
+				/* Saves known good values. */
+				memcpy(&_layer_masks_parent1_bkp,
+				       layer_masks_parent1,
+				       sizeof(_layer_masks_parent1_bkp));
+				if (layer_masks_parent2)
+					memcpy(&_layer_masks_parent2_bkp,
+					       layer_masks_parent2,
+					       sizeof(_layer_masks_parent2_bkp));
+
 				/* Ignores hidden mount points. */
 				goto jump_up;
 			} else {
@@ -909,20 +942,48 @@ static bool is_access_to_paths_allowed(
 			}
 		}
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
-			 */
 			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+				/*
+				 * Stops and allows access when reaching disconnected root
+				 * directories that are part of internal filesystems (e.g. nsfs,
+				 * which is reachable through /proc/<pid>/ns/<namespace>).
+				 */
 				allowed_parent1 = true;
 				allowed_parent2 = true;
+				break;
 			}
-			break;
+			/*
+			 * Ignores current walk in walker_path.mnt when reaching
+			 * disconnected root directories from bind mounts.  Reset the
+			 * collected access rights to the latest mount point (or @path) we
+			 * walked through, and start again from the current root of the
+			 * mount point.  The newly collected access rights will be less than
+			 * or equal to those at open time.
+			 */
+			goto reset_to_mount_root;
 		}
 		parent_dentry = dget_parent(walker_path.dentry);
 		dput(walker_path.dentry);
 		walker_path.dentry = parent_dentry;
+		continue;
+
+reset_to_mount_root:
+		/* Restores latest known good values. */
+		memcpy(layer_masks_parent1, &_layer_masks_parent1_bkp,
+		       sizeof(_layer_masks_parent1_bkp));
+		// TODO: Add tests for this case.
+		allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
+		if (layer_masks_parent2) {
+			memcpy(layer_masks_parent2, &_layer_masks_parent2_bkp,
+			       sizeof(_layer_masks_parent2_bkp));
+			allowed_parent2 =
+				is_layer_masks_allowed(layer_masks_parent2);
+		}
+
+		/* Restarts with the current mount point. */
+		dput(walker_path.dentry);
+		walker_path.dentry = walker_path.mnt->mnt_root;
+		dget(walker_path.dentry);
 	}
 	path_put(&walker_path);
 
@@ -1010,15 +1071,18 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * collect_domain_accesses - Walk through a file path and collect accesses
  *
  * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
+ * @mnt_dir: Mount point directory to stop the walk at.
  * @dir: Directory to start the walk from.
  * @layer_masks_dom: Where to store the collected accesses.
  *
- * This helper is useful to begin a path walk from the @dir directory to a
- * @mnt_root directory used as a mount point.  This mount point is the common
- * ancestor between the source and the destination of a renamed and linked
- * file.  While walking from @dir to @mnt_root, we record all the domain's
- * allowed accesses in @layer_masks_dom.
+ * This helper is useful to begin a path walk from the @dir directory to
+ * @mnt_dir.  This mount point is the common ancestor between the source and the
+ * destination of a renamed and linked file.  While walking from @dir to
+ * @mnt_dir, we record all the domain's allowed accesses in @layer_masks_dom.
+ *
+ * Because of disconnected directories, this walk may not reach @mnt_dir.  In
+ * this case, the walk is canceled and the collected accesses are reset to the
+ * domain handled ones.
  *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
@@ -1030,13 +1094,13 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  */
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
-	const struct dentry *const mnt_root, struct dentry *dir,
+	const struct path *const mnt_dir, struct dentry *dir,
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS])
 {
-	unsigned long access_dom;
+	access_mask_t access_dom;
 	bool ret = false;
 
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
+	if (WARN_ON_ONCE(!domain || !mnt_dir || !dir || !layer_masks_dom))
 		return true;
 	if (is_nouser_or_private(dir))
 		return true;
@@ -1053,6 +1117,10 @@ static bool collect_domain_accesses(
 		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
 					   layer_masks_dom,
 					   ARRAY_SIZE(*layer_masks_dom))) {
+			/* Ignores this walk if we end up in a disconnected directory. */
+			if (unlikely(!path_connected(mnt_dir->mnt, dir)))
+				goto cancel_walk;
+
 			/*
 			 * Stops when all handled accesses are allowed by at
 			 * least one rule in each layer.
@@ -1061,13 +1129,23 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/* Stops at the mount point. */
+		if (dir == mnt_dir->dentry)
 			break;
 
+		/* Ignores this walk if we end up in a disconnected root directory. */
+		if (unlikely(IS_ROOT(dir)))
+			goto cancel_walk;
+
 		parent_dentry = dget_parent(dir);
 		dput(dir);
 		dir = parent_dentry;
+		continue;
+
+cancel_walk:
+		landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
+					  layer_masks_dom, LANDLOCK_KEY_INODE);
+		break;
 	}
 	dput(dir);
 	return ret;
@@ -1198,13 +1276,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
-						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
+	allow_parent1 = collect_domain_accesses(
+		subject->domain, &mnt_dir, old_parent, &layer_masks_parent1);
+	allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
 						new_dir->dentry,
 						&layer_masks_parent2);
-
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
-- 
2.50.1


