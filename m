Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D950E39F53C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhFHLlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhFHLlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:41:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA2C061789;
        Tue,  8 Jun 2021 04:39:27 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqa4q-005ptE-M7; Tue, 08 Jun 2021 11:39:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] take LOOKUP_{ROOT,ROOT_GRABBED,JUMPED} out of LOOKUP_... space
Date:   Tue,  8 Jun 2021 11:39:22 +0000
Message-Id: <20210608113924.1391062-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
References: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
 <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separate field in nameidata (nd->state) holding the flags that
should be internal-only - that way we both get some spare bits
in LOOKUP_... and get simpler rules for nd->root lifetime rules,
since we can set the replacement of LOOKUP_ROOT (ND_ROOT_PRESET)
at the same time we set nd->root.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/path-lookup.rst |  6 ++--
 fs/namei.c                                | 54 ++++++++++++++++++-------------
 fs/nfs/nfstrace.h                         |  4 ---
 include/linux/namei.h                     |  3 --
 4 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index c482e1619e77..ede67f705787 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1321,18 +1321,18 @@ to lookup: RCU-walk, REF-walk, and REF-walk with forced revalidation.
 yet.  This is primarily used to tell the audit subsystem the full
 context of a particular access being audited.
 
-``LOOKUP_ROOT`` indicates that the ``root`` field in the ``nameidata`` was
+``ND_ROOT_PRESET`` indicates that the ``root`` field in the ``nameidata`` was
 provided by the caller, so it shouldn't be released when it is no
 longer needed.
 
-``LOOKUP_JUMPED`` means that the current dentry was chosen not because
+``ND_JUMPED`` means that the current dentry was chosen not because
 it had the right name but for some other reason.  This happens when
 following "``..``", following a symlink to ``/``, crossing a mount point
 or accessing a "``/proc/$PID/fd/$FD``" symlink (also known as a "magic
 link"). In this case the filesystem has not been asked to revalidate the
 name (with ``d_revalidate()``).  In such cases the inode may still need
 to be revalidated, so ``d_op->d_weak_revalidate()`` is called if
-``LOOKUP_JUMPED`` is set when the look completes - which may be at the
+``ND_JUMPED`` is set when the look completes - which may be at the
 final component or, when creating, unlinking, or renaming, at the penultimate component.
 
 Resolution-restriction flags
diff --git a/fs/namei.c b/fs/namei.c
index 4b6cf4974dd7..622b9f15bf1c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -554,7 +554,7 @@ struct nameidata {
 	struct qstr	last;
 	struct path	root;
 	struct inode	*inode; /* path.dentry.d_inode */
-	unsigned int	flags;
+	unsigned int	flags, state;
 	unsigned	seq, m_seq, r_seq;
 	int		last_type;
 	unsigned	depth;
@@ -573,6 +573,10 @@ struct nameidata {
 	umode_t		dir_mode;
 } __randomize_layout;
 
+#define ND_ROOT_PRESET 1
+#define ND_ROOT_GRABBED 2
+#define ND_JUMPED 4
+
 static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
 	struct nameidata *old = current->nameidata;
@@ -583,6 +587,7 @@ static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
 	p->saved = old;
+	p->state = 0;
 	current->nameidata = p;
 }
 
@@ -645,9 +650,9 @@ static void terminate_walk(struct nameidata *nd)
 		path_put(&nd->path);
 		for (i = 0; i < nd->depth; i++)
 			path_put(&nd->stack[i].link);
-		if (nd->flags & LOOKUP_ROOT_GRABBED) {
+		if (nd->state & ND_ROOT_GRABBED) {
 			path_put(&nd->root);
-			nd->flags &= ~LOOKUP_ROOT_GRABBED;
+			nd->state &= ~ND_ROOT_GRABBED;
 		}
 	} else {
 		nd->flags &= ~LOOKUP_RCU;
@@ -710,9 +715,9 @@ static bool legitimize_root(struct nameidata *nd)
 	if (!nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED))
 		return false;
 	/* Nothing to do if nd->root is zero or is managed by the VFS user. */
-	if (!nd->root.mnt || (nd->flags & LOOKUP_ROOT))
+	if (!nd->root.mnt || (nd->state & ND_ROOT_PRESET))
 		return true;
-	nd->flags |= LOOKUP_ROOT_GRABBED;
+	nd->state |= ND_ROOT_GRABBED;
 	return legitimize_path(nd, &nd->root, nd->root_seq);
 }
 
@@ -849,8 +854,9 @@ static int complete_walk(struct nameidata *nd)
 		 * We don't want to zero nd->root for scoped-lookups or
 		 * externally-managed nd->root.
 		 */
-		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
-			nd->root.mnt = NULL;
+		if (!(nd->state & ND_ROOT_PRESET))
+			if (!(nd->flags & LOOKUP_IS_SCOPED))
+				nd->root.mnt = NULL;
 		nd->flags &= ~LOOKUP_CACHED;
 		if (!try_to_unlazy(nd))
 			return -ECHILD;
@@ -877,7 +883,7 @@ static int complete_walk(struct nameidata *nd)
 			return -EXDEV;
 	}
 
-	if (likely(!(nd->flags & LOOKUP_JUMPED)))
+	if (likely(!(nd->state & ND_JUMPED)))
 		return 0;
 
 	if (likely(!(dentry->d_flags & DCACHE_OP_WEAK_REVALIDATE)))
@@ -915,7 +921,7 @@ static int set_root(struct nameidata *nd)
 		} while (read_seqcount_retry(&fs->seq, seq));
 	} else {
 		get_fs_root(fs, &nd->root);
-		nd->flags |= LOOKUP_ROOT_GRABBED;
+		nd->state |= ND_ROOT_GRABBED;
 	}
 	return 0;
 }
@@ -948,7 +954,7 @@ static int nd_jump_root(struct nameidata *nd)
 		path_get(&nd->path);
 		nd->inode = nd->path.dentry->d_inode;
 	}
-	nd->flags |= LOOKUP_JUMPED;
+	nd->state |= ND_JUMPED;
 	return 0;
 }
 
@@ -976,7 +982,7 @@ int nd_jump_link(struct path *path)
 	path_put(&nd->path);
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
-	nd->flags |= LOOKUP_JUMPED;
+	nd->state |= ND_JUMPED;
 	return 0;
 
 err:
@@ -1424,7 +1430,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 			if (mounted) {
 				path->mnt = &mounted->mnt;
 				dentry = path->dentry = mounted->mnt.mnt_root;
-				nd->flags |= LOOKUP_JUMPED;
+				nd->state |= ND_JUMPED;
 				*seqp = read_seqcount_begin(&dentry->d_seq);
 				*inode = dentry->d_inode;
 				/*
@@ -1469,7 +1475,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			ret = -EXDEV;
 		else
-			nd->flags |= LOOKUP_JUMPED;
+			nd->state |= ND_JUMPED;
 	}
 	if (unlikely(ret)) {
 		dput(path->dentry);
@@ -2220,7 +2226,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			case 2:
 				if (name[1] == '.') {
 					type = LAST_DOTDOT;
-					nd->flags |= LOOKUP_JUMPED;
+					nd->state |= ND_JUMPED;
 				}
 				break;
 			case 1:
@@ -2228,7 +2234,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		}
 		if (likely(type == LAST_NORM)) {
 			struct dentry *parent = nd->path.dentry;
-			nd->flags &= ~LOOKUP_JUMPED;
+			nd->state &= ~ND_JUMPED;
 			if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
 				struct qstr this = { { .hash_len = hash_len }, .name = name };
 				err = parent->d_op->d_hash(parent, &this);
@@ -2302,14 +2308,15 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
 
-	nd->flags = flags | LOOKUP_JUMPED;
+	nd->flags = flags;
+	nd->state |= ND_JUMPED;
 	nd->depth = 0;
 
 	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
 	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
 	smp_rmb();
 
-	if (flags & LOOKUP_ROOT) {
+	if (nd->state & ND_ROOT_PRESET) {
 		struct dentry *root = nd->root.dentry;
 		struct inode *inode = root->d_inode;
 		if (*s && unlikely(!d_can_lookup(root)))
@@ -2384,7 +2391,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->root_seq = nd->seq;
 		} else {
 			path_get(&nd->root);
-			nd->flags |= LOOKUP_ROOT_GRABBED;
+			nd->state |= ND_ROOT_GRABBED;
 		}
 	}
 	return s;
@@ -2423,7 +2430,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 		;
 	if (!err && unlikely(nd->flags & LOOKUP_MOUNTPOINT)) {
 		err = handle_lookup_down(nd);
-		nd->flags &= ~LOOKUP_JUMPED; // no d_weak_revalidate(), please...
+		nd->state &= ~ND_JUMPED; // no d_weak_revalidate(), please...
 	}
 	if (!err)
 		err = complete_walk(nd);
@@ -2447,11 +2454,11 @@ int filename_lookup(int dfd, struct filename *name, unsigned flags,
 	struct nameidata nd;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
+	set_nameidata(&nd, dfd, name);
 	if (unlikely(root)) {
 		nd.root = *root;
-		flags |= LOOKUP_ROOT;
+		nd.state = ND_ROOT_PRESET;
 	}
-	set_nameidata(&nd, dfd, name);
 	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
 	if (unlikely(retval == -ECHILD))
 		retval = path_lookupat(&nd, flags, path);
@@ -3539,7 +3546,7 @@ struct file *do_file_open_root(const struct path *root,
 	struct nameidata nd;
 	struct file *file;
 	struct filename *filename;
-	int flags = op->lookup_flags | LOOKUP_ROOT;
+	int flags = op->lookup_flags;
 
 	if (d_is_symlink(root->dentry) && op->intent & LOOKUP_OPEN)
 		return ERR_PTR(-ELOOP);
@@ -3548,8 +3555,9 @@ struct file *do_file_open_root(const struct path *root,
 	if (IS_ERR(filename))
 		return ERR_CAST(filename);
 
-	nd.root = *root;
 	set_nameidata(&nd, -1, filename);
+	nd.root = *root;
+	nd.state = ND_ROOT_PRESET;
 	file = path_openat(&nd, op, flags | LOOKUP_RCU);
 	if (unlikely(file == ERR_PTR(-ECHILD)))
 		file = path_openat(&nd, op, flags);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5a59dcdce0b2..cb7f49723bbf 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -271,8 +271,6 @@ TRACE_DEFINE_ENUM(LOOKUP_OPEN);
 TRACE_DEFINE_ENUM(LOOKUP_CREATE);
 TRACE_DEFINE_ENUM(LOOKUP_EXCL);
 TRACE_DEFINE_ENUM(LOOKUP_RENAME_TARGET);
-TRACE_DEFINE_ENUM(LOOKUP_JUMPED);
-TRACE_DEFINE_ENUM(LOOKUP_ROOT);
 TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
 TRACE_DEFINE_ENUM(LOOKUP_DOWN);
 
@@ -288,8 +286,6 @@ TRACE_DEFINE_ENUM(LOOKUP_DOWN);
 			{ LOOKUP_CREATE, "CREATE" }, \
 			{ LOOKUP_EXCL, "EXCL" }, \
 			{ LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
-			{ LOOKUP_JUMPED, "JUMPED" }, \
-			{ LOOKUP_ROOT, "ROOT" }, \
 			{ LOOKUP_EMPTY, "EMPTY" }, \
 			{ LOOKUP_DOWN, "DOWN" })
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b9605b2b46e7..be9a2b349ca7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -36,9 +36,6 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 /* internal use only */
 #define LOOKUP_PARENT		0x0010
-#define LOOKUP_JUMPED		0x1000
-#define LOOKUP_ROOT		0x2000
-#define LOOKUP_ROOT_GRABBED	0x0008
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	0x010000 /* No symlink crossing. */
-- 
2.11.0

