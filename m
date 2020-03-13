Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7A185305
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCMX6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:58:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49982 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCMXx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:53:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7q-00B6Z6-9z; Fri, 13 Mar 2020 23:53:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 10/69] handle_mounts(): pass dentry in, turn path into a pure out argument
Date:   Fri, 13 Mar 2020 23:52:58 +0000
Message-Id: <20200313235357.2646756-10-viro@ZenIV.linux.org.uk>
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

All callers are equivalent to
	path->dentry = dentry;
	path->mnt = nd->path.mnt;
	err = handle_mounts(path, ...)
Pass dentry as an explicit argument, fill *path in handle_mounts()
itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 79029a1048be..a613fa52a174 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1385,11 +1385,15 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		!(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
 }
 
-static inline int handle_mounts(struct path *path, struct nameidata *nd,
-			  struct inode **inode, unsigned int *seqp)
+static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
+			  struct path *path, struct inode **inode,
+			  unsigned int *seqp)
 {
-	int ret = follow_managed(path, nd);
+	int ret;
 
+	path->mnt = nd->path.mnt;
+	path->dentry = dentry;
+	ret = follow_managed(path, nd);
 	if (likely(ret >= 0)) {
 		*inode = d_backing_inode(path->dentry);
 		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
@@ -1685,10 +1689,7 @@ static int lookup_fast(struct nameidata *nd,
 		dput(dentry);
 		return status;
 	}
-
-	path->mnt = mnt;
-	path->dentry = dentry;
-	return handle_mounts(path, nd, inode, seqp);
+	return handle_mounts(nd, dentry, path, inode, seqp);
 }
 
 /* Fast lookup failed, do it the slow way */
@@ -1859,6 +1860,7 @@ static inline int step_into(struct nameidata *nd, struct path *path,
 static int walk_component(struct nameidata *nd, int flags)
 {
 	struct path path;
+	struct dentry *dentry;
 	struct inode *inode;
 	unsigned seq;
 	int err;
@@ -1877,13 +1879,11 @@ static int walk_component(struct nameidata *nd, int flags)
 	if (unlikely(err <= 0)) {
 		if (err < 0)
 			return err;
-		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
-					  nd->flags);
-		if (IS_ERR(path.dentry))
-			return PTR_ERR(path.dentry);
+		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
 
-		path.mnt = nd->path.mnt;
-		err = handle_mounts(&path, nd, &inode, &seq);
+		err = handle_mounts(nd, dentry, &path, &inode, &seq);
 		if (unlikely(err < 0))
 			return err;
 	}
@@ -2355,7 +2355,7 @@ static inline int lookup_last(struct nameidata *nd)
 
 static int handle_lookup_down(struct nameidata *nd)
 {
-	struct path path = nd->path;
+	struct path path;
 	struct inode *inode = nd->inode;
 	unsigned seq = nd->seq;
 	int err;
@@ -2366,11 +2366,12 @@ static int handle_lookup_down(struct nameidata *nd)
 		 * at the very beginning of walk, so we lose nothing
 		 * if we simply redo everything in non-RCU mode
 		 */
+		path = nd->path;
 		if (unlikely(!__follow_mount_rcu(nd, &path, &inode, &seq)))
 			return -ECHILD;
 	} else {
-		dget(path.dentry);
-		err = handle_mounts(&path, nd, &inode, &seq);
+		dget(nd->path.dentry);
+		err = handle_mounts(nd, nd->path.dentry, &path, &inode, &seq);
 		if (unlikely(err < 0))
 			return err;
 	}
@@ -3393,9 +3394,7 @@ static int do_last(struct nameidata *nd,
 		got_write = false;
 	}
 
-	path.mnt = nd->path.mnt;
-	path.dentry = dentry;
-	error = handle_mounts(&path, nd, &inode, &seq);
+	error = handle_mounts(nd, dentry, &path, &inode, &seq);
 	if (unlikely(error < 0))
 		return error;
 finish_lookup:
-- 
2.11.0

