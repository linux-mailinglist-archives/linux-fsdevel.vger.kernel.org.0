Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32A1852C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgCMX4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50126 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgCMXyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7v-00B6cj-Fg; Fri, 13 Mar 2020 23:54:03 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 46/69] move handle_dots(), follow_dotdot() and follow_dotdot_rcu() past step_into()
Date:   Fri, 13 Mar 2020 23:53:34 +0000
Message-Id: <20200313235357.2646756-46-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

pure move; we are going to have step_into() called by that bunch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 260 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 130 insertions(+), 130 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 577dc541a4d4..3ee3b8719505 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1363,70 +1363,6 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	return ret;
 }
 
-static int follow_dotdot_rcu(struct nameidata *nd)
-{
-	struct dentry *parent = NULL;
-	struct inode *inode = nd->inode;
-	unsigned seq;
-
-	while (1) {
-		if (path_equal(&nd->path, &nd->root))
-			break;
-		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			struct dentry *old = nd->path.dentry;
-
-			parent = old->d_parent;
-			inode = parent->d_inode;
-			seq = read_seqcount_begin(&parent->d_seq);
-			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
-				return -ECHILD;
-			if (unlikely(!path_connected(nd->path.mnt, parent)))
-				return -ECHILD;
-			break;
-		} else {
-			struct mount *mnt = real_mount(nd->path.mnt);
-			struct mount *mparent = mnt->mnt_parent;
-			struct dentry *mountpoint = mnt->mnt_mountpoint;
-			struct inode *inode2 = mountpoint->d_inode;
-			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
-			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-				return -ECHILD;
-			if (&mparent->mnt == nd->path.mnt)
-				break;
-			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-				return -ECHILD;
-			/* we know that mountpoint was pinned */
-			nd->path.dentry = mountpoint;
-			nd->path.mnt = &mparent->mnt;
-			inode = inode2;
-			nd->seq = seq;
-		}
-	}
-	if (unlikely(!parent)) {
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return -ECHILD;
-	} else {
-		nd->path.dentry = parent;
-		nd->seq = seq;
-	}
-	while (unlikely(d_mountpoint(nd->path.dentry))) {
-		struct mount *mounted;
-		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
-		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-			return -ECHILD;
-		if (!mounted)
-			break;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return -ECHILD;
-		nd->path.mnt = &mounted->mnt;
-		nd->path.dentry = mounted->mnt.mnt_root;
-		inode = nd->path.dentry->d_inode;
-		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
-	}
-	nd->inode = inode;
-	return 0;
-}
-
 /*
  * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
  */
@@ -1443,38 +1379,6 @@ static void follow_mount(struct path *path)
 	}
 }
 
-static int follow_dotdot(struct nameidata *nd)
-{
-	struct dentry *parent = NULL;
-	while (1) {
-		if (path_equal(&nd->path, &nd->root))
-			break;
-		if (nd->path.dentry != nd->path.mnt->mnt_root) {
-			/* rare case of legitimate dget_parent()... */
-			parent = dget_parent(nd->path.dentry);
-			if (unlikely(!path_connected(nd->path.mnt, parent))) {
-				dput(parent);
-				return -ENOENT;
-			}
-			break;
-		}
-		if (!follow_up(&nd->path))
-			break;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return -EXDEV;
-	}
-	if (unlikely(!parent)) {
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return -EXDEV;
-	} else {
-		dput(nd->path.dentry);
-		nd->path.dentry = parent;
-	}
-	follow_mount(&nd->path);
-	nd->inode = nd->path.dentry->d_inode;
-	return 0;
-}
-
 /*
  * This looks up the name in dcache and possibly revalidates the found dentry.
  * NULL is returned if the dentry does not exist in the cache.
@@ -1654,40 +1558,6 @@ static inline int may_lookup(struct nameidata *nd)
 	return inode_permission(nd->inode, MAY_EXEC);
 }
 
-static inline int handle_dots(struct nameidata *nd, int type)
-{
-	if (type == LAST_DOTDOT) {
-		int error = 0;
-
-		if (!nd->root.mnt) {
-			error = set_root(nd);
-			if (error)
-				return error;
-		}
-		if (nd->flags & LOOKUP_RCU)
-			error = follow_dotdot_rcu(nd);
-		else
-			error = follow_dotdot(nd);
-		if (error)
-			return error;
-
-		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
-			/*
-			 * If there was a racing rename or mount along our
-			 * path, then we can't be sure that ".." hasn't jumped
-			 * above nd->root (and so userspace should retry or use
-			 * some fallback).
-			 */
-			smp_rmb();
-			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
-				return -EAGAIN;
-			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
-				return -EAGAIN;
-		}
-	}
-	return 0;
-}
-
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 static const char *pick_link(struct nameidata *nd, struct path *link,
@@ -1817,6 +1687,136 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
+static int follow_dotdot_rcu(struct nameidata *nd)
+{
+	struct dentry *parent = NULL;
+	struct inode *inode = nd->inode;
+	unsigned seq;
+
+	while (1) {
+		if (path_equal(&nd->path, &nd->root))
+			break;
+		if (nd->path.dentry != nd->path.mnt->mnt_root) {
+			struct dentry *old = nd->path.dentry;
+
+			parent = old->d_parent;
+			inode = parent->d_inode;
+			seq = read_seqcount_begin(&parent->d_seq);
+			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
+				return -ECHILD;
+			if (unlikely(!path_connected(nd->path.mnt, parent)))
+				return -ECHILD;
+			break;
+		} else {
+			struct mount *mnt = real_mount(nd->path.mnt);
+			struct mount *mparent = mnt->mnt_parent;
+			struct dentry *mountpoint = mnt->mnt_mountpoint;
+			struct inode *inode2 = mountpoint->d_inode;
+			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
+			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+				return -ECHILD;
+			if (&mparent->mnt == nd->path.mnt)
+				break;
+			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+				return -ECHILD;
+			/* we know that mountpoint was pinned */
+			nd->path.dentry = mountpoint;
+			nd->path.mnt = &mparent->mnt;
+			inode = inode2;
+			nd->seq = seq;
+		}
+	}
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -ECHILD;
+	} else {
+		nd->path.dentry = parent;
+		nd->seq = seq;
+	}
+	while (unlikely(d_mountpoint(nd->path.dentry))) {
+		struct mount *mounted;
+		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
+		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+			return -ECHILD;
+		if (!mounted)
+			break;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return -ECHILD;
+		nd->path.mnt = &mounted->mnt;
+		nd->path.dentry = mounted->mnt.mnt_root;
+		inode = nd->path.dentry->d_inode;
+		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+	}
+	nd->inode = inode;
+	return 0;
+}
+
+static int follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent = NULL;
+	while (1) {
+		if (path_equal(&nd->path, &nd->root))
+			break;
+		if (nd->path.dentry != nd->path.mnt->mnt_root) {
+			/* rare case of legitimate dget_parent()... */
+			parent = dget_parent(nd->path.dentry);
+			if (unlikely(!path_connected(nd->path.mnt, parent))) {
+				dput(parent);
+				return -ENOENT;
+			}
+			break;
+		}
+		if (!follow_up(&nd->path))
+			break;
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return -EXDEV;
+	}
+	if (unlikely(!parent)) {
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return -EXDEV;
+	} else {
+		dput(nd->path.dentry);
+		nd->path.dentry = parent;
+	}
+	follow_mount(&nd->path);
+	nd->inode = nd->path.dentry->d_inode;
+	return 0;
+}
+
+static inline int handle_dots(struct nameidata *nd, int type)
+{
+	if (type == LAST_DOTDOT) {
+		int error = 0;
+
+		if (!nd->root.mnt) {
+			error = set_root(nd);
+			if (error)
+				return error;
+		}
+		if (nd->flags & LOOKUP_RCU)
+			error = follow_dotdot_rcu(nd);
+		else
+			error = follow_dotdot(nd);
+		if (error)
+			return error;
+
+		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
+			/*
+			 * If there was a racing rename or mount along our
+			 * path, then we can't be sure that ".." hasn't jumped
+			 * above nd->root (and so userspace should retry or use
+			 * some fallback).
+			 */
+			smp_rmb();
+			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
+				return -EAGAIN;
+			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
+				return -EAGAIN;
+		}
+	}
+	return 0;
+}
+
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
-- 
2.11.0

