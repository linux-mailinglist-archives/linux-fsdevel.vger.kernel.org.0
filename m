Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFA141B86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgASDU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:20:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:20:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it17y-00BFY1-D0; Sun, 19 Jan 2020 03:19:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/17] lookup_open(): saner calling conventions (return dentry on success)
Date:   Sun, 19 Jan 2020 03:17:20 +0000
Message-Id: <20200119031738.2681033-8-viro@ZenIV.linux.org.uk>
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

same story as for atomic_open() in the previous commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9d8837432a7b..30503f114142 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3025,10 +3025,9 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
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
@@ -3039,7 +3038,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -3047,7 +3046,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last, &wq);
 			if (IS_ERR(dentry))
-				return PTR_ERR(dentry);
+				return dentry;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -3063,7 +3062,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		goto out_no_open;
+		return dentry;
 	}
 
 	/*
@@ -3104,14 +3103,10 @@ static int lookup_open(struct nameidata *nd, struct path *path,
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
-		path->mnt = nd->path.mnt;
-		path->dentry = dentry;
-		return 0;
+		return dentry;
 	}
 
 no_open:
@@ -3147,14 +3142,11 @@ static int lookup_open(struct nameidata *nd, struct path *path,
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
@@ -3171,6 +3163,7 @@ static int do_last(struct nameidata *nd,
 	unsigned seq;
 	struct inode *inode;
 	struct path path;
+	struct dentry *dentry;
 	int error;
 
 	nd->flags &= ~LOOKUP_PARENT;
@@ -3227,14 +3220,18 @@ static int do_last(struct nameidata *nd,
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
-- 
2.20.1

