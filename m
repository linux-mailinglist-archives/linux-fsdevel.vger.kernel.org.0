Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DA16929E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBWBSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:18:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgBWBSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:18:37 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fuK-00HDcF-9m; Sun, 23 Feb 2020 01:18:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 08/34] lookup_open(): saner calling conventions (return dentry on success)
Date:   Sun, 23 Feb 2020 01:16:00 +0000
Message-Id: <20200223011626.4103706-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

same story as for atomic_open() in the previous commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5f8b791a6d6e..4946d006ba20 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3157,10 +3157,9 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  *
  * An error code is returned on failure.
  */
-static int lookup_open(struct nameidata *nd, struct path *path,
-			struct file *file,
-			const struct open_flags *op,
-			bool got_write)
+static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
+				  const struct open_flags *op,
+				  bool got_write)
 {
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
@@ -3171,7 +3170,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -3179,7 +3178,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last, &wq);
 			if (IS_ERR(dentry))
-				return PTR_ERR(dentry);
+				return dentry;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -3195,7 +3194,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		goto out_no_open;
+		return dentry;
 	}
 
 	/*
@@ -3236,18 +3235,10 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	if (dir_inode->i_op->atomic_open) {
 		dentry = atomic_open(nd, dentry, file, op, open_flag, mode);
 		if (IS_ERR(dentry)) {
-			error = PTR_ERR(dentry);
-			if (unlikely(error == -ENOENT) && create_error)
-				error = create_error;
-			return error;
+			if (dentry == ERR_PTR(-ENOENT) && create_error)
+				dentry = ERR_PTR(create_error);
 		}
-		if (file->f_mode & FMODE_OPENED) {
-			dput(dentry);
-			return 0;
-		}
-		path->mnt = nd->path.mnt;
-		path->dentry = dentry;
-		return 0;
+		return dentry;
 	}
 
 no_open:
@@ -3283,14 +3274,11 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 		error = create_error;
 		goto out_dput;
 	}
-out_no_open:
-	path->dentry = dentry;
-	path->mnt = nd->path.mnt;
-	return 0;
+	return dentry;
 
 out_dput:
 	dput(dentry);
-	return error;
+	return ERR_PTR(error);
 }
 
 /*
@@ -3309,6 +3297,7 @@ static int do_last(struct nameidata *nd,
 	unsigned seq;
 	struct inode *inode;
 	struct path path;
+	struct dentry *dentry;
 	int error;
 
 	nd->flags &= ~LOOKUP_PARENT;
@@ -3365,14 +3354,18 @@ static int do_last(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	error = lookup_open(nd, &path, file, op, got_write);
+	dentry = lookup_open(nd, file, op, got_write);
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
 		inode_unlock_shared(dir->d_inode);
 
-	if (error)
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
 		goto out;
+	}
+	path.mnt = nd->path.mnt;
+	path.dentry = dentry;
 
 	if (file->f_mode & FMODE_OPENED) {
 		if ((file->f_mode & FMODE_CREATED) ||
@@ -3380,6 +3373,7 @@ static int do_last(struct nameidata *nd,
 			will_truncate = false;
 
 		audit_inode(nd->name, file->f_path.dentry, 0);
+		dput(dentry);
 		goto opened;
 	}
 
-- 
2.11.0

