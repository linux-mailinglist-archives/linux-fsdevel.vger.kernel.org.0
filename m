Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781EA17502A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCAVxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41734 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCAVwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW0-003fQU-HZ; Sun, 01 Mar 2020 21:52:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 49/55] lift all calls of step_into() out of follow_dotdot/follow_dotdot_rcu
Date:   Sun,  1 Mar 2020 21:52:34 +0000
Message-Id: <20200301215240.873899-49-viro@ZenIV.linux.org.uk>
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

lift step_into() into handle_dots() (where they merge with each other);
have follow_... return dentry and pass inode/seq to the caller.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 74 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cc01bca2266c..cf7b7a6c08fc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1689,31 +1689,29 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
-static const char *follow_dotdot_rcu(struct nameidata *nd, int flags)
+static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
+					struct inode **inodep,
+					unsigned *seqp)
 {
-	struct dentry *parent = NULL;
-	struct inode *inode = nd->inode;
-	unsigned seq;
-
 	while (1) {
 		if (path_equal(&nd->path, &nd->root))
 			break;
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
+			struct dentry *parent = old->d_parent;
 
-			parent = old->d_parent;
-			inode = parent->d_inode;
-			seq = read_seqcount_begin(&parent->d_seq);
+			*inodep = parent->d_inode;
+			*seqp = read_seqcount_begin(&parent->d_seq);
 			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
 				return ERR_PTR(-ECHILD);
 			if (unlikely(!path_connected(nd->path.mnt, parent)))
 				return ERR_PTR(-ECHILD);
-			break;
+			return parent;
 		} else {
 			struct mount *mnt = real_mount(nd->path.mnt);
 			struct mount *mparent = mnt->mnt_parent;
 			struct dentry *mountpoint = mnt->mnt_mountpoint;
-			struct inode *inode2 = mountpoint->d_inode;
+			struct inode *inode = mountpoint->d_inode;
 			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
 			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
 				return ERR_PTR(-ECHILD);
@@ -1724,56 +1722,51 @@ static const char *follow_dotdot_rcu(struct nameidata *nd, int flags)
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
-			inode = nd->inode = inode2;
+			nd->inode = inode;
 			nd->seq = seq;
 		}
 	}
-	if (unlikely(!parent)) {
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return ERR_PTR(-ECHILD);
-		return step_into(nd, flags | WALK_NOFOLLOW,
-				 nd->path.dentry, nd->inode, nd->seq);
-	} else {
-		return step_into(nd, flags | WALK_NOFOLLOW,
-				 parent, inode, seq);
-	}
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return ERR_PTR(-ECHILD);
+	return NULL;
 }
 
-static const char *follow_dotdot(struct nameidata *nd, int flags)
+static struct dentry *follow_dotdot(struct nameidata *nd,
+				 struct inode **inodep,
+				 unsigned *seqp)
 {
-	struct dentry *parent = NULL;
 	while (1) {
 		if (path_equal(&nd->path, &nd->root))
 			break;
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			/* rare case of legitimate dget_parent()... */
-			parent = dget_parent(nd->path.dentry);
+			struct dentry *parent = dget_parent(nd->path.dentry);
 			if (unlikely(!path_connected(nd->path.mnt, parent))) {
 				dput(parent);
 				return ERR_PTR(-ENOENT);
 			}
-			break;
+			*seqp = 0;
+			*inodep = parent->d_inode;
+			return parent;
 		}
 		if (!follow_up(&nd->path))
 			break;
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
-	if (unlikely(!parent)) {
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
-			return ERR_PTR(-EXDEV);
-		return step_into(nd, flags | WALK_NOFOLLOW,
-				 dget(nd->path.dentry), nd->inode, nd->seq);
-	} else {
-		return step_into(nd, flags | WALK_NOFOLLOW,
-				 parent, parent->d_inode, 0);
-	}
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return ERR_PTR(-EXDEV);
+	dget(nd->path.dentry);
+	return NULL;
 }
 
 static const char *handle_dots(struct nameidata *nd, int type, int flags)
 {
 	if (type == LAST_DOTDOT) {
 		const char *error = NULL;
+		struct dentry *parent;
+		struct inode *inode;
+		unsigned seq;
 
 		if (!nd->root.mnt) {
 			error = ERR_PTR(set_root(nd));
@@ -1781,11 +1774,18 @@ static const char *handle_dots(struct nameidata *nd, int type, int flags)
 				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
-			error = follow_dotdot_rcu(nd, flags);
+			parent = follow_dotdot_rcu(nd, &inode, &seq);
 		else
-			error = follow_dotdot(nd, flags);
-		if (error)
-			return error;
+			parent = follow_dotdot(nd, &inode, &seq);
+		if (IS_ERR(parent))
+			return ERR_CAST(parent);
+		if (unlikely(!parent)) {
+			error = step_into(nd, flags | WALK_NOFOLLOW,
+					 nd->path.dentry, nd->inode, nd->seq);
+		} else {
+			error = step_into(nd, flags | WALK_NOFOLLOW,
+					 parent, inode, seq);
+		}
 
 		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
 			/*
-- 
2.11.0

