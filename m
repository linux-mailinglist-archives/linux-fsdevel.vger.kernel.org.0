Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A46141B84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 04:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgASDUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 22:20:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56742 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgASDUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:20:03 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1it17e-00BFXJ-12; Sun, 19 Jan 2020 03:19:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 07/17] atomic_open(): saner calling conventions (return dentry on success)
Date:   Sun, 19 Jan 2020 03:17:19 +0000
Message-Id: <20200119031738.2681033-7-viro@ZenIV.linux.org.uk>
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

Currently it either returns -E... or puts (nd->path.mnt,dentry)
into *path and returns 0.  Make it return ERR_PTR(-E...) or
dentry; adjust the caller.  Fewer arguments and it's easier
to keep track of *path contents that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4c867d0970d5..9d8837432a7b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2955,10 +2955,10 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
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
@@ -2999,17 +2999,15 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
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
@@ -3104,11 +3102,16 @@ static int lookup_open(struct nameidata *nd, struct path *path,
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
+		path->mnt = nd->path.mnt;
+		path->dentry = dentry;
+		return 0;
 	}
 
 no_open:
-- 
2.20.1

