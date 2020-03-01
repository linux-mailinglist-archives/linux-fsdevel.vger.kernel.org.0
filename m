Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF1175016
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 22:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCAVxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 16:53:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgCAVwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:52:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8WW1-003fQy-Mq; Sun, 01 Mar 2020 21:52:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v3 54/55] non-RCU analogue of the previous commit
Date:   Sun,  1 Mar 2020 21:52:39 +0000
Message-Id: <20200301215240.873899-54-viro@ZenIV.linux.org.uk>
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

new helper: choose_mountpoint().  Wrapper around choose_mountpoint_rcu(),
similar to lookup_mnt() vs. __lookup_mnt().  follow_dotdot() switched to
it.  Now we don't grab mount_lock exclusive anymore; note that the
primitive used non-RCU mount traversals in other direction (lookup_mnt())
doesn't bother with that either - it uses mount_lock seqcount instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8c09523c6f56..f247eca119f1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -605,10 +605,9 @@ static void terminate_walk(struct nameidata *nd)
 }
 
 /* path_put is needed afterwards regardless of success or failure */
-static bool legitimize_path(struct nameidata *nd,
-			    struct path *path, unsigned seq)
+static bool __legitimize_path(struct path *path, unsigned seq, unsigned mseq)
 {
-	int res = __legitimize_mnt(path->mnt, nd->m_seq);
+	int res = __legitimize_mnt(path->mnt, mseq);
 	if (unlikely(res)) {
 		if (res > 0)
 			path->mnt = NULL;
@@ -622,6 +621,12 @@ static bool legitimize_path(struct nameidata *nd,
 	return !read_seqcount_retry(&path->dentry->d_seq, seq);
 }
 
+static inline bool legitimize_path(struct nameidata *nd,
+			    struct path *path, unsigned seq)
+{
+	return __legitimize_path(path, nd->m_seq, seq);
+}
+
 static bool legitimize_links(struct nameidata *nd)
 {
 	int i;
@@ -1383,6 +1388,31 @@ static bool choose_mountpoint_rcu(struct mount *m, const struct path *root,
 	return false;
 }
 
+static bool choose_mountpoint(struct mount *m, const struct path *root,
+			      struct path *path)
+{
+	bool found;
+
+	rcu_read_lock();
+	while (1) {
+		unsigned seq, mseq = read_seqbegin(&mount_lock);
+
+		found = choose_mountpoint_rcu(m, root, path, &seq);
+		if (unlikely(!found)) {
+			if (!read_seqretry(&mount_lock, mseq))
+				break;
+		} else {
+			if (likely(__legitimize_path(path, seq, mseq)))
+				break;
+			rcu_read_unlock();
+			path_put(path);
+			rcu_read_lock();
+		}
+	}
+	rcu_read_unlock();
+	return found;
+}
+
 /*
  * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
  */
@@ -1758,22 +1788,14 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 	if (path_equal(&nd->path, &nd->root))
 		goto in_root;
 	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path = nd->path;
-		path_get(&path);
-		while (1) {
-			if (!follow_up(&path)) {
-				path_put(&path);
-				goto in_root;
-			}
-			if (path_equal(&path, &nd->root)) {
-				path_put(&path);
-				goto in_root;
-			}
-			if (path.dentry != nd->path.mnt->mnt_root)
-				break;
-		}
+		struct path path;
+
+		if (!choose_mountpoint(real_mount(nd->path.mnt),
+				       &nd->root, &path))
+			goto in_root;
 		path_put(&nd->path);
 		nd->path = path;
+		nd->inode = path.dentry->d_inode;
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
-- 
2.11.0

