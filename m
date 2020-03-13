Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0818529D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCMXyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:54:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50190 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgCMXyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCu7x-00B6eS-QB; Fri, 13 Mar 2020 23:54:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v4 62/69] link_path_walk(): sample parent's i_uid and i_mode for the last component
Date:   Fri, 13 Mar 2020 23:53:50 +0000
Message-Id: <20200313235357.2646756-62-viro@ZenIV.linux.org.uk>
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
 fs/namei.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c4b6e3c969b7..aa1a74c5f52d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -505,6 +505,8 @@ struct nameidata {
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
+	kuid_t		dir_uid;
+	umode_t		dir_mode;
 } __randomize_layout;
 
 static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
@@ -938,9 +940,6 @@ int sysctl_protected_regular __read_mostly;
  */
 static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
 {
-	const struct inode *parent;
-	kuid_t puid;
-
 	if (!sysctl_protected_symlinks)
 		return 0;
 
@@ -949,13 +948,11 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 		return 0;
 
 	/* Allowed if parent directory not sticky and world-writable. */
-	parent = nd->inode;
-	if ((parent->i_mode & (S_ISVTX|S_IWOTH)) != (S_ISVTX|S_IWOTH))
+	if ((nd->dir_mode & (S_ISVTX|S_IWOTH)) != (S_ISVTX|S_IWOTH))
 		return 0;
 
 	/* Allowed if parent directory and link owner match. */
-	puid = parent->i_uid;
-	if (uid_valid(puid) && uid_eq(puid, inode->i_uid))
+	if (uid_valid(nd->dir_uid) && uid_eq(nd->dir_uid, inode->i_uid))
 		return 0;
 
 	if (nd->flags & LOOKUP_RCU)
@@ -2158,6 +2155,8 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 OK:
 			/* pathname or trailing symlink, done */
 			if (!depth) {
+				nd->dir_uid = nd->inode->i_uid;
+				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
 			}
@@ -3223,8 +3222,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 static const char *do_last(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
-	kuid_t dir_uid = nd->inode->i_uid;
-	umode_t dir_mode = nd->inode->i_mode;
 	int open_flag = op->open_flag;
 	bool do_truncate;
 	int acc_mode;
@@ -3240,7 +3237,7 @@ static const char *do_last(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if (d_is_dir(nd->path.dentry))
 			return ERR_PTR(-EISDIR);
-		error = may_create_in_sticky(dir_mode, dir_uid,
+		error = may_create_in_sticky(nd->dir_mode, nd->dir_uid,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
 			return ERR_PTR(error);
-- 
2.11.0

