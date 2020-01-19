Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A991141BB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgASD0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:26:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57042 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgASD0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:26:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it1Dt-00BFmu-T8; Sun, 19 Jan 2020 03:26:10 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 9/9] new helper: traverse_mounts()
Date:   Sun, 19 Jan 2020 03:17:38 +0000
Message-Id: <20200119031738.2681033-26-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

common guts of follow_down() and follow_managed() taken to a new
helper - traverse_mounts().  The remnants of follow_managed()
are folded into its sole remaining caller (handle_mounts()).
Calling conventions of handle_mounts() slightly sanitized -
instead of the weird "1 for success, -E... for failure" that used
to be imposed by the calling conventions of walk_component() et.al.
we can use the normal "0 for success, -E... for failure".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 177 ++++++++++++++++++++++-------------------------------
 1 file changed, 72 insertions(+), 105 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 310c5ccddf42..d3172e2c7f7f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1167,91 +1167,79 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 }
 
 /*
- * Handle a dentry that is managed in some way.
- * - Flagged for transit management (autofs)
- * - Flagged as mountpoint
- * - Flagged as automount point
- *
- * This may only be called in refwalk mode.
- * On success path->dentry is known positive.
- *
- * Serialization is taken care of in namespace.c
+ * mount traversal - out-of-line part.  One note on ->d_flags accesses -
+ * dentries are pinned but not locked here, so negative dentry can go
+ * positive right under us.  Use of smp_load_acquire() provides a barrier
+ * sufficient for ->d_inode and ->d_flags consistency.
  */
-static int follow_managed(struct path *path, struct nameidata *nd)
+static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
+			     int *count, unsigned lookup_flags)
 {
-	struct vfsmount *mnt = path->mnt; /* held by caller, must be left alone */
-	unsigned flags;
+	struct vfsmount *mnt = path->mnt;
 	bool need_mntput = false;
 	int ret = 0;
 
-	/* Given that we're not holding a lock here, we retain the value in a
-	 * local variable for each dentry as we look at it so that we don't see
-	 * the components of that value change under us */
-	while (flags = smp_load_acquire(&path->dentry->d_flags),
-	       unlikely(flags & DCACHE_MANAGED_DENTRY)) {
+	while (flags & DCACHE_MANAGED_DENTRY) {
 		/* Allow the filesystem to manage the transit without i_mutex
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
-			BUG_ON(!path->dentry->d_op);
-			BUG_ON(!path->dentry->d_op->d_manage);
 			ret = path->dentry->d_op->d_manage(path, false);
 			flags = smp_load_acquire(&path->dentry->d_flags);
 			if (ret < 0)
 				break;
 		}
 
-		/* Transit to a mounted filesystem. */
-		if (flags & DCACHE_MOUNTED) {
+		if (flags & DCACHE_MOUNTED) {	// something's mounted on it..
 			struct vfsmount *mounted = lookup_mnt(path);
-			if (mounted) {
+			if (mounted) {		// ... in our namespace
 				dput(path->dentry);
 				if (need_mntput)
 					mntput(path->mnt);
 				path->mnt = mounted;
 				path->dentry = dget(mounted->mnt_root);
+				// here we know it's positive
+				flags = path->dentry->d_flags;
 				need_mntput = true;
 				continue;
 			}
-
-			/* Something is mounted on this dentry in another
-			 * namespace and/or whatever was mounted there in this
-			 * namespace got unmounted before lookup_mnt() could
-			 * get it */
 		}
 
-		/* Handle an automount point */
-		if (flags & DCACHE_NEED_AUTOMOUNT) {
-			ret = follow_automount(path, &nd->total_link_count,
-						nd->flags);
-			if (ret < 0)
-				break;
-			continue;
-		}
+		if (!(flags & DCACHE_NEED_AUTOMOUNT))
+			break;
 
-		/* We didn't change the current path point */
-		break;
+		// uncovered automount point
+		ret = follow_automount(path, count, lookup_flags);
+		flags = smp_load_acquire(&path->dentry->d_flags);
+		if (ret < 0)
+			break;
 	}
 
-	if (need_mntput) {
-		if (path->mnt == mnt)
-			mntput(path->mnt);
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			ret = -EXDEV;
-		else
-			nd->flags |= LOOKUP_JUMPED;
-	}
-	if (ret == -EISDIR || !ret)
-		ret = 1;
-	if (ret > 0 && unlikely(d_flags_negative(flags)))
+	if (ret == -EISDIR)
+		ret = 0;
+	// possible if you race with several mount --move
+	if (need_mntput && path->mnt == mnt)
+		mntput(path->mnt);
+	if (!ret && unlikely(d_flags_negative(flags)))
 		ret = -ENOENT;
-	if (unlikely(ret < 0)) {
-		dput(path->dentry);
-		if (path->mnt != nd->path.mnt)
-			mntput(path->mnt);
-	}
+	*jumped = need_mntput;
 	return ret;
 }
 
+static inline int traverse_mounts(struct path *path, bool *jumped,
+				  int *count, unsigned lookup_flags)
+{
+	unsigned flags = smp_load_acquire(&path->dentry->d_flags);
+
+	/* fastpath */
+	if (likely(!(flags & DCACHE_MANAGED_DENTRY))) {
+		*jumped = false;
+		if (unlikely(d_flags_negative(flags)))
+			return -ENOENT;
+		return 0;
+	}
+	return __traverse_mounts(path, flags, jumped, count, lookup_flags);
+}
+
 int follow_down_one(struct path *path)
 {
 	struct vfsmount *mounted;
@@ -1268,6 +1256,23 @@ int follow_down_one(struct path *path)
 }
 EXPORT_SYMBOL(follow_down_one);
 
+/*
+ * Follow down to the covering mount currently visible to userspace.  At each
+ * point, the filesystem owning that dentry may be queried as to whether the
+ * caller is permitted to proceed or not.
+ */
+int follow_down(struct path *path)
+{
+	struct vfsmount *mnt = path->mnt;
+	bool jumped;
+	int ret = traverse_mounts(path, &jumped, NULL, 0);
+
+	if (path->mnt != mnt)
+		mntput(mnt);
+	return ret;
+}
+EXPORT_SYMBOL(follow_down);
+
 /*
  * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
  * we meet a managed dentry that would need blocking.
@@ -1324,6 +1329,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 			  struct path *path, struct inode **inode,
 			  unsigned int *seqp)
 {
+	bool jumped;
 	int ret;
 
 	path->mnt = nd->path.mnt;
@@ -1333,15 +1339,25 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		if (unlikely(!*inode))
 			return -ENOENT;
 		if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
-			return 1;
+			return 0;
 		if (unlazy_child(nd, dentry, seq))
 			return -ECHILD;
 		// *path might've been clobbered by __follow_mount_rcu()
 		path->mnt = nd->path.mnt;
 		path->dentry = dentry;
 	}
-	ret = follow_managed(path, nd);
-	if (likely(ret >= 0)) {
+	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
+	if (jumped) {
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			ret = -EXDEV;
+		else
+			nd->flags |= LOOKUP_JUMPED;
+	}
+	if (unlikely(ret)) {
+		dput(path->dentry);
+		if (path->mnt != nd->path.mnt)
+			mntput(path->mnt);
+	} else {
 		*inode = d_backing_inode(path->dentry);
 		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
 	}
@@ -1409,55 +1425,6 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	return 0;
 }
 
-/*
- * Follow down to the covering mount currently visible to userspace.  At each
- * point, the filesystem owning that dentry may be queried as to whether the
- * caller is permitted to proceed or not.
- */
-int follow_down(struct path *path)
-{
-	unsigned managed;
-	int ret;
-
-	while (managed = READ_ONCE(path->dentry->d_flags),
-	       unlikely(managed & DCACHE_MANAGED_DENTRY)) {
-		/* Allow the filesystem to manage the transit without i_mutex
-		 * being held.
-		 *
-		 * We indicate to the filesystem if someone is trying to mount
-		 * something here.  This gives autofs the chance to deny anyone
-		 * other than its daemon the right to mount on its
-		 * superstructure.
-		 *
-		 * The filesystem may sleep at this point.
-		 */
-		if (managed & DCACHE_MANAGE_TRANSIT) {
-			BUG_ON(!path->dentry->d_op);
-			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(path, false);
-			if (ret < 0)
-				return ret == -EISDIR ? 0 : ret;
-		}
-
-		/* Transit to a mounted filesystem. */
-		if (managed & DCACHE_MOUNTED) {
-			struct vfsmount *mounted = lookup_mnt(path);
-			if (!mounted)
-				break;
-			dput(path->dentry);
-			mntput(path->mnt);
-			path->mnt = mounted;
-			path->dentry = dget(mounted->mnt_root);
-			continue;
-		}
-
-		/* Don't handle automount points here */
-		break;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(follow_down);
-
 /*
  * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
  */
-- 
2.20.1

