Return-Path: <linux-fsdevel+bounces-58952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6408B33598
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE816875B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B74286889;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rHBa21NS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B04272E5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=ul2rCG1/ejG+1a8yetf/Az22MbNogryKywKYIR2ezglwdoajQG1AF1EDsq0L3sABut/6QCBTH0aec9zCMIeRjQO1TwDKsoivXoedBmnRxYzhJp2r9QKnb5zTCF7KiLldgFbK8tYG6qsFcLriB64ICoGsBhuhcjjlckrdGZ+lxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=MuxEsMdnzFB4i0JR5ENyRPRzIrVZPVO4X5GlQy6Vdrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkWEbbfvWg3bGbUvOwAcNr1nACUDcgVOvY3fGOCS/bYfh3XxHJXygQ/cEsqaee4E4isBmCsVWo8SoRCAE+4LAvGeHDXmVi0snVdvHlxJEM8ugXz9FybjD92koK/R/WkmNynSoIZ6jQIcNhMUnwGZc1Sf2s/AM4rXvBS7ACIN8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rHBa21NS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hoTcOfv8eNyenjynk+e6MkqFx+18eTbB1Wd95MXGJMY=; b=rHBa21NSSFeerYqFvx8BH5uXUq
	k2T2AAmBiHa8we+TnIcaYH5B/B5iMbGNRL8D+WGDhGfGjXilQiAqxA6UPDg78V73YT1lGtV66CCG1
	VdQbK08vZvt2rJ+IafQ8JvarVorM9/QRoj8Q7sv5diNjVjsHVRGLE2H3qLwbKK9XA4OFGbTZvPpoz
	ZU5vasGrKf9yxMwbFWOcHSqQpGR+8K85U11jWiAQ9bPZXG67Wm0n9BEEub8CQys6tQVZYbpypmvLC
	rZN5yOF9Pap0bOCifemUbVwguPgLbQR1COdMS6thd3+Sgwh4UoAaRq59zFVVkO96wAi8Iq1Ut9Voz
	+TV4+G6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TC7-3Hn7;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 27/52] change calling conventions for lock_mount() et.al.
Date: Mon, 25 Aug 2025 05:43:30 +0100
Message-ID: <20250825044355.1541941-27-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) pinned_mountpoint gets a new member - struct mount *parent.
Set only if we locked the sucker; ERR_PTR() - on failed attempt.

2) do_lock_mount() et.al. return void and set ->parent to
	* on success with !beneath - mount corresponding to path->mnt
	* on success with beneath - the parent of mount corresponding
to path->mnt
	* in case of error - ERR_PTR(-E...).
IOW, we get the mount we will be actually mounting upon or ERR_PTR().

3) we can't use CLASS, since the pinned_mountpoint is placed on
hlist during initialization, so we define local macros:
	LOCK_MOUNT(mp, path)
	LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath)
	LOCK_MOUNT_EXACT(mp, path)
All of them declare and initialize struct pinned_mountpoint mp,
with unlock_mount done via __cleanup().

Users converted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 219 ++++++++++++++++++++++++-------------------------
 1 file changed, 108 insertions(+), 111 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5819a50d7d67..8d6e26e2c97a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -919,6 +919,7 @@ bool __is_local_mountpoint(const struct dentry *dentry)
 struct pinned_mountpoint {
 	struct hlist_node node;
 	struct mountpoint *mp;
+	struct mount *parent;
 };
 
 static bool lookup_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
@@ -2728,48 +2729,47 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 }
 
 /**
- * do_lock_mount - lock mount and mountpoint
- * @path:    target path
- * @beneath: whether the intention is to mount beneath @path
+ * do_lock_mount - acquire environment for mounting
+ * @path:	target path
+ * @res:	context to set up
+ * @beneath:	whether the intention is to mount beneath @path
  *
- * Follow the mount stack on @path until the top mount @mnt is found. If
- * the initial @path->{mnt,dentry} is a mountpoint lookup the first
- * mount stacked on top of it. Then simply follow @{mnt,mnt->mnt_root}
- * until nothing is stacked on top of it anymore.
+ * To mount something at given location, we need
+ *	namespace_sem locked exclusive
+ *	inode of dentry we are mounting on locked exclusive
+ *	struct mountpoint for that dentry
+ *	struct mount we are mounting on
  *
- * Acquire the inode_lock() on the top mount's ->mnt_root to protect
- * against concurrent removal of the new mountpoint from another mount
- * namespace.
+ * Results are stored in caller-supplied context (pinned_mountpoint);
+ * on success we have res->parent and res->mp pointing to parent and
+ * mountpoint respectively and res->node inserted into the ->m_list
+ * of the mountpoint, making sure the mountpoint won't disappear.
+ * On failure we have res->parent set to ERR_PTR(-E...), res->mp
+ * left NULL, res->node - empty.
+ * In case of success do_lock_mount returns with locks acquired (in
+ * proper order - inode lock nests outside of namespace_sem).
  *
- * If @beneath is requested, acquire inode_lock() on @mnt's mountpoint
- * @mp on @mnt->mnt_parent must be acquired. This protects against a
- * concurrent unlink of @mp->mnt_dentry from another mount namespace
- * where @mnt doesn't have a child mount mounted @mp. A concurrent
- * removal of @mnt->mnt_root doesn't matter as nothing will be mounted
- * on top of it for @beneath.
+ * Request to mount on overmounted location is treated as "mount on
+ * top of whatever's overmounting it"; request to mount beneath
+ * a location - "mount immediately beneath the topmost mount at that
+ * place".
  *
- * In addition, @beneath needs to make sure that @mnt hasn't been
- * unmounted or moved from its current mountpoint in between dropping
- * @mount_lock and acquiring @namespace_sem. For the !@beneath case @mnt
- * being unmounted would be detected later by e.g., calling
- * check_mnt(mnt) in the function it's called from. For the @beneath
- * case however, it's useful to detect it directly in do_lock_mount().
- * If @mnt hasn't been unmounted then @mnt->mnt_mountpoint still points
- * to @mnt->mnt_mp->m_dentry. But if @mnt has been unmounted it will
- * point to @mnt->mnt_root and @mnt->mnt_mp will be NULL.
- *
- * Return: Either the target mountpoint on the top mount or the top
- *         mount's mountpoint.
+ * In all cases the location must not have been unmounted and the
+ * chosen mountpoint must be allowed to be mounted on.  For "beneath"
+ * case we also require the location to be at the root of a mount
+ * that has a parent (i.e. is not a root of some namespace).
  */
-static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bool beneath)
+static void do_lock_mount(struct path *path, struct pinned_mountpoint *res, bool beneath)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct dentry *dentry;
 	struct path under = {};
 	int err = -ENOENT;
 
-	if (unlikely(beneath) && !path_mounted(path))
-		return -EINVAL;
+	if (unlikely(beneath) && !path_mounted(path)) {
+		res->parent = ERR_PTR(-EINVAL);
+		return;
+	}
 
 	for (;;) {
 		struct mount *m = real_mount(mnt);
@@ -2779,7 +2779,8 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 			read_seqlock_excl(&mount_lock);
 			if (unlikely(!mnt_has_parent(m))) {
 				read_sequnlock_excl(&mount_lock);
-				return -EINVAL;
+				res->parent = ERR_PTR(-EINVAL);
+				return;
 			}
 			under.mnt = mntget(&m->mnt_parent->mnt);
 			under.dentry = dget(m->mnt_mountpoint);
@@ -2811,7 +2812,7 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 			path->dentry = dget(mnt->mnt_root);
 			continue;	// got overmounted
 		}
-		err = get_mountpoint(dentry, pinned);
+		err = get_mountpoint(dentry, res);
 		if (err)
 			break;
 		if (beneath) {
@@ -2822,22 +2823,25 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 			 * we are not dropping the final references here).
 			 */
 			path_put(&under);
+			res->parent = real_mount(path->mnt)->mnt_parent;
+			return;
 		}
-		return 0;
+		res->parent = real_mount(path->mnt);
+		return;
 	}
 	namespace_unlock();
 	inode_unlock(dentry->d_inode);
 	if (beneath)
 		path_put(&under);
-	return err;
+	res->parent = ERR_PTR(err);
 }
 
-static inline int lock_mount(struct path *path, struct pinned_mountpoint *m)
+static inline void lock_mount(struct path *path, struct pinned_mountpoint *m)
 {
-	return do_lock_mount(path, m, false);
+	do_lock_mount(path, m, false);
 }
 
-static void unlock_mount(struct pinned_mountpoint *m)
+static void __unlock_mount(struct pinned_mountpoint *m)
 {
 	inode_unlock(m->mp->m_dentry->d_inode);
 	read_seqlock_excl(&mount_lock);
@@ -2846,6 +2850,20 @@ static void unlock_mount(struct pinned_mountpoint *m)
 	namespace_unlock();
 }
 
+static inline void unlock_mount(struct pinned_mountpoint *m)
+{
+	if (!IS_ERR(m->parent))
+		__unlock_mount(m);
+}
+
+#define LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath) \
+	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
+	do_lock_mount((path), &mp, (beneath))
+#define LOCK_MOUNT(mp, path) LOCK_MOUNT_MAYBE_BENEATH(mp, (path), false)
+#define LOCK_MOUNT_EXACT(mp, path) \
+	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
+	lock_mount_exact((path), &mp)
+
 static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 {
 	if (mnt->mnt.mnt_sb->s_flags & SB_NOUSER)
@@ -3015,8 +3033,7 @@ static int do_loopback(struct path *path, const char *old_name,
 				int recurse)
 {
 	struct path old_path __free(path_put) = {};
-	struct mount *mnt = NULL, *parent;
-	struct pinned_mountpoint mp = {};
+	struct mount *mnt = NULL;
 	int err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
@@ -3027,28 +3044,23 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (mnt_ns_loop(old_path.dentry))
 		return -EINVAL;
 
-	err = lock_mount(path, &mp);
-	if (err)
-		return err;
+	LOCK_MOUNT(mp, path);
+	if (IS_ERR(mp.parent))
+		return PTR_ERR(mp.parent);
 
-	parent = real_mount(path->mnt);
-	if (!check_mnt(parent))
-		goto out2;
+	if (!check_mnt(mp.parent))
+		return -EINVAL;
 
 	mnt = __do_loopback(&old_path, recurse);
-	if (IS_ERR(mnt)) {
-		err = PTR_ERR(mnt);
-		goto out2;
-	}
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
 
-	err = graft_tree(mnt, parent, mp.mp);
+	err = graft_tree(mnt, mp.parent, mp.mp);
 	if (err) {
 		lock_mount_hash();
 		umount_tree(mnt, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
-out2:
-	unlock_mount(&mp);
 	return err;
 }
 
@@ -3561,7 +3573,6 @@ static int do_move_mount(struct path *old_path,
 {
 	struct mount *p;
 	struct mount *old = real_mount(old_path->mnt);
-	struct pinned_mountpoint mp;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
 
@@ -3571,52 +3582,49 @@ static int do_move_mount(struct path *old_path,
 	if (d_is_dir(new_path->dentry) != d_is_dir(old_path->dentry))
 		return -EINVAL;
 
-	err = do_lock_mount(new_path, &mp, beneath);
-	if (err)
-		return err;
+	LOCK_MOUNT_MAYBE_BENEATH(mp, new_path, beneath);
+	if (IS_ERR(mp.parent))
+		return PTR_ERR(mp.parent);
 
 	p = real_mount(new_path->mnt);
 
-	err = -EINVAL;
-
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
 		/* ... it should be detachable from parent */
 		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
-			goto out;
+			return -EINVAL;
 		/* ... which should not be shared */
 		if (IS_MNT_SHARED(old->mnt_parent))
-			goto out;
+			return -EINVAL;
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
-			goto out;
+			return -EINVAL;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
 		 */
 		if (!anon_ns_root(old))
-			goto out;
+			return -EINVAL;
 		/*
 		 * Bail out early if the target is within the same namespace -
 		 * subsequent checks would've rejected that, but they lose
 		 * some corner cases if we check it early.
 		 */
 		if (old->mnt_ns == p->mnt_ns)
-			goto out;
+			return -EINVAL;
 		/*
 		 * Target should be either in our namespace or in an acceptable
 		 * anon namespace, sensu check_anonymous_mnt().
 		 */
 		if (!may_use_mount(p))
-			goto out;
+			return -EINVAL;
 	}
 
 	if (beneath) {
 		err = can_move_mount_beneath(old, new_path, mp.mp);
 		if (err)
-			goto out;
+			return err;
 
-		err = -EINVAL;
 		p = p->mnt_parent;
 	}
 
@@ -3625,17 +3633,13 @@ static int do_move_mount(struct path *old_path,
 	 * mount which is shared.
 	 */
 	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
-		goto out;
-	err = -ELOOP;
+		return -EINVAL;
 	if (!check_for_nsfs_mounts(old))
-		goto out;
+		return -ELOOP;
 	if (mount_is_ancestor(old, p))
-		goto out;
+		return -ELOOP;
 
-	err = attach_recursive_mnt(old, p, mp.mp);
-out:
-	unlock_mount(&mp);
-	return err;
+	return attach_recursive_mnt(old, p, mp.mp);
 }
 
 static int do_move_mount_old(struct path *path, const char *old_name)
@@ -3694,7 +3698,6 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
-	struct pinned_mountpoint mp = {};
 	struct super_block *sb = fc->root->d_sb;
 	int error;
 
@@ -3715,13 +3718,14 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
-	error = lock_mount(mountpoint, &mp);
-	if (!error) {
+	LOCK_MOUNT(mp, mountpoint);
+	if (IS_ERR(mp.parent)) {
+		return PTR_ERR(mp.parent);
+	} else {
 		error = do_add_mount(real_mount(mnt), mp.mp,
 				     mountpoint, mnt_flags);
 		if (!error)
 			retain_and_null_ptr(mnt); // consumed on success
-		unlock_mount(&mp);
 	}
 	return error;
 }
@@ -3785,8 +3789,8 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	return err;
 }
 
-static int lock_mount_exact(const struct path *path,
-			    struct pinned_mountpoint *mp)
+static void lock_mount_exact(const struct path *path,
+			     struct pinned_mountpoint *mp)
 {
 	struct dentry *dentry = path->dentry;
 	int err;
@@ -3802,14 +3806,15 @@ static int lock_mount_exact(const struct path *path,
 	if (unlikely(err)) {
 		namespace_unlock();
 		inode_unlock(dentry->d_inode);
+		mp->parent = ERR_PTR(err);
+	} else {
+		mp->parent = real_mount(path->mnt);
 	}
-	return err;
 }
 
 int finish_automount(struct vfsmount *__m, const struct path *path)
 {
 	struct vfsmount *m __free(mntput) = __m;
-	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 	int err;
 
@@ -3828,15 +3833,14 @@ int finish_automount(struct vfsmount *__m, const struct path *path)
 	 * that overmounts our mountpoint to be means "quitely drop what we've
 	 * got", not "try to mount it on top".
 	 */
-	err = lock_mount_exact(path, &mp);
-	if (unlikely(err))
-		return err == -EBUSY ? 0 : err;
+	LOCK_MOUNT_EXACT(mp, path);
+	if (IS_ERR(mp.parent))
+		return mp.parent == ERR_PTR(-EBUSY) ? 0 : PTR_ERR(mp.parent);
 
 	err = do_add_mount(mnt, mp.mp, path,
 			   path->mnt->mnt_flags | MNT_SHRINKABLE);
 	if (likely(!err))
 		retain_and_null_ptr(m);
-	unlock_mount(&mp);
 	return err;
 }
 
@@ -4633,7 +4637,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	struct path old __free(path_put) = {};
 	struct path root __free(path_put) = {};
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
-	struct pinned_mountpoint old_mp = {};
 	int error;
 
 	if (!may_mount())
@@ -4654,45 +4657,42 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		return error;
 
 	get_fs_root(current->fs, &root);
-	error = lock_mount(&old, &old_mp);
-	if (error)
-		return error;
 
-	error = -EINVAL;
+	LOCK_MOUNT(old_mp, &old);
+	old_mnt = old_mp.parent;
+	if (IS_ERR(old_mnt))
+		return PTR_ERR(old_mnt);
+
 	new_mnt = real_mount(new.mnt);
 	root_mnt = real_mount(root.mnt);
-	old_mnt = real_mount(old.mnt);
 	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
 		IS_MNT_SHARED(ex_parent) ||
 		IS_MNT_SHARED(root_parent))
-		goto out4;
+		return -EINVAL;
 	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
-		goto out4;
+		return -EINVAL;
 	if (new_mnt->mnt.mnt_flags & MNT_LOCKED)
-		goto out4;
-	error = -ENOENT;
+		return -EINVAL;
 	if (d_unlinked(new.dentry))
-		goto out4;
-	error = -EBUSY;
+		return -ENOENT;
 	if (new_mnt == root_mnt || old_mnt == root_mnt)
-		goto out4; /* loop, on the same file system  */
-	error = -EINVAL;
+		return -EBUSY; /* loop, on the same file system  */
 	if (!path_mounted(&root))
-		goto out4; /* not a mountpoint */
+		return -EINVAL; /* not a mountpoint */
 	if (!mnt_has_parent(root_mnt))
-		goto out4; /* absolute root */
+		return -EINVAL; /* absolute root */
 	if (!path_mounted(&new))
-		goto out4; /* not a mountpoint */
+		return -EINVAL; /* not a mountpoint */
 	if (!mnt_has_parent(new_mnt))
-		goto out4; /* absolute root */
+		return -EINVAL; /* absolute root */
 	/* make sure we can reach put_old from new_root */
 	if (!is_path_reachable(old_mnt, old.dentry, &new))
-		goto out4;
+		return -EINVAL;
 	/* make certain new is below the root */
 	if (!is_path_reachable(new_mnt, new.dentry, &root))
-		goto out4;
+		return -EINVAL;
 	lock_mount_hash();
 	umount_mnt(new_mnt);
 	if (root_mnt->mnt.mnt_flags & MNT_LOCKED) {
@@ -4711,10 +4711,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	mnt_notify_add(root_mnt);
 	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
-	error = 0;
-out4:
-	unlock_mount(&old_mp);
-	return error;
+	return 0;
 }
 
 static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
-- 
2.47.2


