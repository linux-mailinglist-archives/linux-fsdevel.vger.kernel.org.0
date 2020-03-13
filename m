Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671218530C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgCMX6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:58:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgCMXx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:53:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7p-00B6Yo-Ue; Fri, 13 Mar 2020 23:53:57 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 07/69] atomic_open(): saner calling conventions (return dentry on success)
Date:   Fri, 13 Mar 2020 23:52:55 +0000
Message-Id: <20200313235357.2646756-7-viro@ZenIV.linux.org.uk>
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

Currently it either returns -E... or puts (nd->path.mnt,dentry)
into *path and returns 0.  Make it return ERR_PTR(-E...) or
dentry; adjust the caller.  Fewer arguments and it's easier
to keep track of *path contents that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c104ec75faef..5f8b791a6d6e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3087,10 +3087,10 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
  *
  * Returns an error code otherwise.
  */
-static int atomic_open(struct nameidata *nd, struct dentry *dentry,
-			struct path *path, struct file *file,
-			const struct open_flags *op,
-			int open_flag, umode_t mode)
+static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
+				  struct file *file,
+				  const struct open_flags *op,
+				  int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
 	struct inode *dir =  nd->path.dentry->d_inode;
@@ -3131,17 +3131,15 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 			}
 			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir, dentry);
-			if (unlikely(d_is_negative(dentry))) {
+			if (unlikely(d_is_negative(dentry)))
 				error = -ENOENT;
-			} else {
-				path->dentry = dentry;
-				path->mnt = nd->path.mnt;
-				return 0;
-			}
 		}
 	}
-	dput(dentry);
-	return error;
+	if (error) {
+		dput(dentry);
+		dentry = ERR_PTR(error);
+	}
+	return dentry;
 }
 
 /*
@@ -3236,11 +3234,20 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	}
 
 	if (dir_inode->i_op->atomic_open) {
-		error = atomic_open(nd, dentry, path, file, op, open_flag,
-				    mode);
-		if (unlikely(error == -ENOENT) && create_error)
-			error = create_error;
-		return error;
+		dentry = atomic_open(nd, dentry, file, op, open_flag, mode);
+		if (IS_ERR(dentry)) {
+			error = PTR_ERR(dentry);
+			if (unlikely(error == -ENOENT) && create_error)
+				error = create_error;
+			return error;
+		}
+		if (file->f_mode & FMODE_OPENED) {
+			dput(dentry);
+			return 0;
+		}
+		path->mnt = nd->path.mnt;
+		path->dentry = dentry;
+		return 0;
 	}
 
 no_open:
-- 
2.11.0

