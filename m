Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB417502B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCAVxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW0-003fQC-0C; Sun, 01 Mar 2020 21:52:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 46/55] move follow_dotdot() and follow_dotdot_rcu() towards handle_dots()
Date:   Sun,  1 Mar 2020 21:52:31 +0000
Message-Id: <20200301215240.873899-46-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
References: <20200301215125.GA873525@ZenIV.linux.org.uk>
 <20200301215240.873899-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

pure move

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 192 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 20a2fc27dd87..1bfefb99cbca 100644
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
@@ -1785,6 +1689,102 @@ static const char *step_into(struct nameidata *nd, int flags,
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
 static const char *handle_dots(struct nameidata *nd, int type, int flags)
 {
 	if (type == LAST_DOTDOT) {
-- 
2.11.0

