Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2A18529C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgCMXyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgCMXyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7y-00B6ef-8f; Fri, 13 Mar 2020 23:54:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 64/69] open_last_lookups(): consolidate fsnotify_create() calls
Date:   Fri, 13 Mar 2020 23:53:52 +0000
Message-Id: <20200313235357.2646756-64-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index da64fa0b2f6d..a86ee06e637d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2956,8 +2956,6 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 				dput(dentry);
 				dentry = dget(file->f_path.dentry);
 			}
-			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir, dentry);
 		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
 			error = -EIO;
 		} else {
@@ -2965,8 +2963,6 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 				dput(dentry);
 				dentry = file->f_path.dentry;
 			}
-			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir, dentry);
 			if (unlikely(d_is_negative(dentry)))
 				error = -ENOENT;
 		}
@@ -3102,7 +3098,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
-		fsnotify_create(dir_inode, dentry);
 	}
 	if (unlikely(create_error) && !dentry->d_inode) {
 		error = create_error;
@@ -3181,6 +3176,8 @@ static const char *open_last_lookups(struct nameidata *nd,
 	else
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write);
+	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
+		fsnotify_create(dir->d_inode, dentry);
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
-- 
2.11.0

