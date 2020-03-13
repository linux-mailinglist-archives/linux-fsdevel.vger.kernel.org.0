Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6200C18529B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgCMXyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50194 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCMXyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6eY-TV; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 63/69] take post-lookup part of do_last() out of loop
Date:   Fri, 13 Mar 2020 23:53:51 +0000
Message-Id: <20200313235357.2646756-63-viro@ZenIV.linux.org.uk>
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

now we can have open_last_lookups() directly from the loop in
path_openat() - the rest of do_last() never returns a symlink
to follow, so we can bloody well leave the loop first.

Rename the rest of that thing from do_last() to do_open() and
make it return an int.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index aa1a74c5f52d..da64fa0b2f6d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3219,31 +3219,26 @@ static const char *open_last_lookups(struct nameidata *nd,
 /*
  * Handle the last step of open()
  */
-static const char *do_last(struct nameidata *nd,
+static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	int open_flag = op->open_flag;
 	bool do_truncate;
 	int acc_mode;
-	const char *link;
 	int error;
 
-	link = open_last_lookups(nd, file, op);
-	if (unlikely(link))
-		return link;
-
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
 		if (d_is_dir(nd->path.dentry))
-			return ERR_PTR(-EISDIR);
+			return -EISDIR;
 		error = may_create_in_sticky(nd->dir_mode, nd->dir_uid,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
-			return ERR_PTR(error);
+			return error;
 	}
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
-		return ERR_PTR(-ENOTDIR);
+		return -ENOTDIR;
 
 	do_truncate = false;
 	acc_mode = op->acc_mode;
@@ -3254,7 +3249,7 @@ static const char *do_last(struct nameidata *nd,
 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
-			return ERR_PTR(error);
+			return error;
 		do_truncate = true;
 	}
 	error = may_open(&nd->path, acc_mode, open_flag);
@@ -3270,7 +3265,7 @@ static const char *do_last(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
-	return ERR_PTR(error);
+	return error;
 }
 
 struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
@@ -3373,8 +3368,10 @@ static struct file *path_openat(struct nameidata *nd,
 	} else {
 		const char *s = path_init(nd, flags);
 		while (!(error = link_path_walk(s, nd)) &&
-		       (s = do_last(nd, file, op)) != NULL)
+		       (s = open_last_lookups(nd, file, op)) != NULL)
 			;
+		if (!error)
+			error = do_open(nd, file, op);
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
-- 
2.11.0

