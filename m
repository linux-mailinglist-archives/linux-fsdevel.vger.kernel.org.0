Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8640175036
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCAVyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:54:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41694 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCAVwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WVy-003fPV-Jy; Sun, 01 Mar 2020 21:52:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 39/55] path_connected(): pass mount and dentry separately
Date:   Sun,  1 Mar 2020 21:52:24 +0000
Message-Id: <20200301215240.873899-39-viro@ZenIV.linux.org.uk>
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

eventually we'll want to do that check *before* mangling
nd->path.dentry...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b73ff6dcca24..971d0ee11286 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -550,22 +550,20 @@ static int __nd_alloc_stack(struct nameidata *nd)
 }
 
 /**
- * path_connected - Verify that a path->dentry is below path->mnt.mnt_root
- * @path: nameidate to verify
+ * path_connected - Verify that a dentry is below mnt.mnt_root
  *
  * Rename can sometimes move a file or directory outside of a bind
  * mount, path_connected allows those cases to be detected.
  */
-static bool path_connected(const struct path *path)
+static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
 {
-	struct vfsmount *mnt = path->mnt;
 	struct super_block *sb = mnt->mnt_sb;
 
 	/* Bind mounts and multi-root filesystems can have disconnected paths */
 	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
 		return true;
 
-	return is_subdir(path->dentry, mnt->mnt_root);
+	return is_subdir(dentry, mnt->mnt_root);
 }
 
 static inline int nd_alloc_stack(struct nameidata *nd)
@@ -1386,7 +1384,7 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 				return -ECHILD;
 			nd->path.dentry = parent;
 			nd->seq = seq;
-			if (unlikely(!path_connected(&nd->path)))
+			if (unlikely(!path_connected(nd->path.mnt, parent)))
 				return -ECHILD;
 			break;
 		} else {
@@ -1448,7 +1446,7 @@ static int path_parent_directory(struct path *path)
 	/* rare case of legitimate dget_parent()... */
 	path->dentry = dget_parent(path->dentry);
 	dput(old);
-	if (unlikely(!path_connected(path)))
+	if (unlikely(!path_connected(path->mnt, path->dentry)))
 		return -ENOENT;
 	return 0;
 }
-- 
2.11.0

