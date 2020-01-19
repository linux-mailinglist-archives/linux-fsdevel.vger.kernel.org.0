Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3112141B89
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgASDU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:20:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56782 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:20:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it18X-00BFZL-88; Sun, 19 Jan 2020 03:20:34 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 10/17] handle_mounts(): pass dentry in, turn path into a pure out argument
Date:   Sun, 19 Jan 2020 03:17:22 +0000
Message-Id: <20200119031738.2681033-10-viro@ZenIV.linux.org.uk>
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
index f66553ef436a..f95c072bad03 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1304,11 +1304,15 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
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
@@ -1592,10 +1596,7 @@ static int lookup_fast(struct nameidata *nd,
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
@@ -1745,6 +1746,7 @@ static inline int step_into(struct nameidata *nd, struct path *path,
 static int walk_component(struct nameidata *nd, int flags)
 {
 	struct path path;
+	struct dentry *dentry;
 	struct inode *inode;
 	unsigned seq;
 	int err;
@@ -1763,13 +1765,11 @@ static int walk_component(struct nameidata *nd, int flags)
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
@@ -2223,7 +2223,7 @@ static inline int lookup_last(struct nameidata *nd)
 
 static int handle_lookup_down(struct nameidata *nd)
 {
-	struct path path = nd->path;
+	struct path path;
 	struct inode *inode = nd->inode;
 	unsigned seq = nd->seq;
 	int err;
@@ -2234,11 +2234,12 @@ static int handle_lookup_down(struct nameidata *nd)
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
@@ -3260,9 +3261,7 @@ static int do_last(struct nameidata *nd,
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
2.20.1

