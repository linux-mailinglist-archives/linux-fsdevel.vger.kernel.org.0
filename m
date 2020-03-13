Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349BC1852BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgCMX4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:56:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50130 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgCMXyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7v-00B6cp-JW; Fri, 13 Mar 2020 23:54:03 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 47/69] handle_dots(), follow_dotdot{,_rcu}(): preparation to switch to step_into()
Date:   Fri, 13 Mar 2020 23:53:35 +0000
Message-Id: <20200313235357.2646756-47-viro@ZenIV.linux.org.uk>
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

Right now the tail ends of follow_dotdot{,_rcu}() are pretty
much the open-coded analogues of step_into().  The differences:
	* the lack of proper LOOKUP_NO_XDEV handling in non-RCU case
(arguably a bug)
	* the lack of ->d_manage() handling (again, arguably a bug)

Adjust the calling conventions so that on the next step with could
just switch those functions to returning step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3ee3b8719505..1749e435edc7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1687,7 +1687,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
-static int follow_dotdot_rcu(struct nameidata *nd)
+static const char *follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct dentry *parent = NULL;
 	struct inode *inode = nd->inode;
@@ -1703,9 +1703,9 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			inode = parent->d_inode;
 			seq = read_seqcount_begin(&parent->d_seq);
 			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
-				return -ECHILD;
+				return ERR_PTR(-ECHILD);
 			if (unlikely(!path_connected(nd->path.mnt, parent)))
-				return -ECHILD;
+				return ERR_PTR(-ECHILD);
 			break;
 		} else {
 			struct mount *mnt = real_mount(nd->path.mnt);
@@ -1714,11 +1714,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 			struct inode *inode2 = mountpoint->d_inode;
 			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
 			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-				return -ECHILD;
+				return ERR_PTR(-ECHILD);
 			if (&mparent->mnt == nd->path.mnt)
 				break;
 			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-				return -ECHILD;
+				return ERR_PTR(-ECHILD);
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
@@ -1728,7 +1728,7 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	}
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 	} else {
 		nd->path.dentry = parent;
 		nd->seq = seq;
@@ -1737,21 +1737,21 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 		struct mount *mounted;
 		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
 		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 		if (!mounted)
 			break;
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 		nd->path.mnt = &mounted->mnt;
 		nd->path.dentry = mounted->mnt.mnt_root;
 		inode = nd->path.dentry->d_inode;
 		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 	}
 	nd->inode = inode;
-	return 0;
+	return NULL;
 }
 
-static int follow_dotdot(struct nameidata *nd)
+static const char *follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent = NULL;
 	while (1) {
@@ -1762,34 +1762,34 @@ static int follow_dotdot(struct nameidata *nd)
 			parent = dget_parent(nd->path.dentry);
 			if (unlikely(!path_connected(nd->path.mnt, parent))) {
 				dput(parent);
-				return -ENOENT;
+				return ERR_PTR(-ENOENT);
 			}
 			break;
 		}
 		if (!follow_up(&nd->path))
 			break;
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			return -EXDEV;
+			return ERR_PTR(-EXDEV);
 	}
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return -EXDEV;
+			return ERR_PTR(-EXDEV);
 	} else {
 		dput(nd->path.dentry);
 		nd->path.dentry = parent;
 	}
 	follow_mount(&nd->path);
 	nd->inode = nd->path.dentry->d_inode;
-	return 0;
+	return NULL;
 }
 
-static inline int handle_dots(struct nameidata *nd, int type)
+static const char *handle_dots(struct nameidata *nd, int type)
 {
 	if (type == LAST_DOTDOT) {
-		int error = 0;
+		const char *error = NULL;
 
 		if (!nd->root.mnt) {
-			error = set_root(nd);
+			error = ERR_PTR(set_root(nd));
 			if (error)
 				return error;
 		}
@@ -1809,12 +1809,12 @@ static inline int handle_dots(struct nameidata *nd, int type)
 			 */
 			smp_rmb();
 			if (unlikely(__read_seqcount_retry(&mount_lock.seqcount, nd->m_seq)))
-				return -EAGAIN;
+				return ERR_PTR(-EAGAIN);
 			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
-				return -EAGAIN;
+				return ERR_PTR(-EAGAIN);
 		}
 	}
-	return 0;
+	return NULL;
 }
 
 static const char *walk_component(struct nameidata *nd, int flags)
@@ -1822,7 +1822,6 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	struct dentry *dentry;
 	struct inode *inode;
 	unsigned seq;
-	int err;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -1831,8 +1830,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	if (unlikely(nd->last_type != LAST_NORM)) {
 		if (!(flags & WALK_MORE) && nd->depth)
 			put_link(nd);
-		err = handle_dots(nd, nd->last_type);
-		return ERR_PTR(err);
+		return handle_dots(nd, nd->last_type);
 	}
 	dentry = lookup_fast(nd, &inode, &seq);
 	if (IS_ERR(dentry))
@@ -3128,10 +3126,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		if (nd->depth)
 			put_link(nd);
-		error = handle_dots(nd, nd->last_type);
-		if (likely(!error))
-			error = complete_walk(nd);
-		return ERR_PTR(error);
+		res = handle_dots(nd, nd->last_type);
+		if (likely(!res))
+			res = ERR_PTR(complete_walk(nd));
+		return res;
 	}
 
 	if (!(open_flag & O_CREAT)) {
-- 
2.11.0

