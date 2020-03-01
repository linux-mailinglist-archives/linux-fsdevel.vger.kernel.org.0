Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5A175025
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCAVx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW0-003fQI-5J; Sun, 01 Mar 2020 21:52:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 47/55] follow_dotdot{,_rcu}(): preparation to switch to step_into()
Date:   Sun,  1 Mar 2020 21:52:32 +0000
Message-Id: <20200301215240.873899-47-viro@ZenIV.linux.org.uk>
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

Right now the tail ends of follow_dotdot{,_rcu}() are pretty
much the open-coded analogues of step_into().  The differences:
	* the lack of proper LOOKUP_NO_XDEV handling in non-RCU case
(arguably a bug)
	* the lack of ->d_manage() handling (again, arguably a bug)
	* the lack of (conditional) put_link() - that sits in
handle_dots() right now.

Bring the put_link() in, adjust the calling conventions so that
on the next step with could just switch those functions to
returning step_into().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1bfefb99cbca..3e3bf11ee3d7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1689,7 +1689,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
-static int follow_dotdot_rcu(struct nameidata *nd)
+static const char *follow_dotdot_rcu(struct nameidata *nd, int flags)
 {
 	struct dentry *parent = NULL;
 	struct inode *inode = nd->inode;
@@ -1705,9 +1705,9 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
@@ -1716,11 +1716,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
@@ -1730,7 +1730,7 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	}
 	if (unlikely(!parent)) {
 		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 	} else {
 		nd->path.dentry = parent;
 		nd->seq = seq;
@@ -1739,21 +1739,23 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
+	if (!(flags & WALK_MORE) && nd->depth)
+		put_link(nd);
+	return NULL;
 }
 
-static int follow_dotdot(struct nameidata *nd)
+static const char *follow_dotdot(struct nameidata *nd, int flags)
 {
 	struct dentry *parent = NULL;
 	while (1) {
@@ -1764,43 +1766,45 @@ static int follow_dotdot(struct nameidata *nd)
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
+	if (!(flags & WALK_MORE) && nd->depth)
+		put_link(nd);
+	return NULL;
 }
 
 static const char *handle_dots(struct nameidata *nd, int type, int flags)
 {
 	if (type == LAST_DOTDOT) {
-		int error = 0;
+		const char *error = NULL;
 
 		if (!nd->root.mnt) {
-			error = set_root(nd);
+			error = ERR_PTR(set_root(nd));
 			if (error)
-				return ERR_PTR(error);
+				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
-			error = follow_dotdot_rcu(nd);
+			error = follow_dotdot_rcu(nd, flags);
 		else
-			error = follow_dotdot(nd);
+			error = follow_dotdot(nd, flags);
 		if (error)
-			return ERR_PTR(error);
+			return error;
 
 		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
 			/*
@@ -1815,9 +1819,10 @@ static const char *handle_dots(struct nameidata *nd, int type, int flags)
 			if (unlikely(__read_seqcount_retry(&rename_lock.seqcount, nd->r_seq)))
 				return ERR_PTR(-EAGAIN);
 		}
+	} else { // LAST_DOT
+		if (!(flags & WALK_MORE) && nd->depth)
+			put_link(nd);
 	}
-	if (!(flags & WALK_MORE) && nd->depth)
-		put_link(nd);
 	return NULL;
 }
 
-- 
2.11.0

