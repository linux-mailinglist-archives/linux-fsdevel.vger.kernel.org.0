Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607371852B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgCMXzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:55:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgCMXyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7w-00B6dN-95; Fri, 13 Mar 2020 23:54:04 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 51/69] follow_dotdot_rcu(): be lazy about changing nd->path
Date:   Fri, 13 Mar 2020 23:53:39 +0000
Message-Id: <20200313235357.2646756-51-viro@ZenIV.linux.org.uk>
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

Change nd->path only after the loop is done and only in case we hadn't
ended up finding ourselves in root.  Same for NO_XDEV check.  Don't
recheck mount_lock on each step either.

That separates the "check how far back do we need to go through the
mount stack" logics from the rest of .. traversal.

Note that the sequence for d_seq/d_inode here is
	* sample mount_lock seqcount
...
	* sample d_seq
	* fetch d_inode
	* verify mount_lock seqcount
The last step makes sure that d_inode value we'd got matches d_seq -
it dentry is guaranteed to have been a mountpoint through the
entire thing, so its d_inode must have been stable.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3d37434cadcc..e569ccdd3513 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1696,28 +1696,31 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	if (path_equal(&nd->path, &nd->root))
 		goto in_root;
 	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
+		struct path path = nd->path;
+		unsigned seq;
+
 		while (1) {
-			struct mount *mnt = real_mount(nd->path.mnt);
+			struct mount *mnt = real_mount(path.mnt);
 			struct mount *mparent = mnt->mnt_parent;
 			struct dentry *mountpoint = mnt->mnt_mountpoint;
-			struct inode *inode = mountpoint->d_inode;
-			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
-			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
-				return ERR_PTR(-ECHILD);
-			if (&mparent->mnt == nd->path.mnt)
+			seq = read_seqcount_begin(&mountpoint->d_seq);
+			if (&mparent->mnt == path.mnt)
 				goto in_root;
-			if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-				return ERR_PTR(-ECHILD);
-			/* we know that mountpoint was pinned */
-			nd->path.dentry = mountpoint;
-			nd->path.mnt = &mparent->mnt;
-			nd->inode = inode;
-			nd->seq = seq;
-			if (path_equal(&nd->path, &nd->root))
+			path.dentry = mountpoint;
+			path.mnt = &mparent->mnt;
+			if (path_equal(&path, &nd->root))
 				goto in_root;
-			if (nd->path.dentry != nd->path.mnt->mnt_root)
+			if (path.dentry != path.mnt->mnt_root)
 				break;
 		}
+		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+			return ERR_PTR(-ECHILD);
+		nd->path = path;
+		nd->inode = path.dentry->d_inode;
+		nd->seq = seq;
+		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+			return ERR_PTR(-ECHILD);
+		/* we know that mountpoint was pinned */
 	}
 	old = nd->path.dentry;
 	parent = old->d_parent;
@@ -1729,6 +1732,8 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 		return ERR_PTR(-ECHILD);
 	return parent;
 in_root:
+	if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+		return ERR_PTR(-ECHILD);
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-ECHILD);
 	return NULL;
-- 
2.11.0

