Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF51692D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBWB0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:26:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50304 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBWB0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:26:18 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5g1v-00HDqV-Vc; Sun, 23 Feb 2020 01:26:05 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 34/34] split the lookup-related parts of do_last() into a separate helper
Date:   Sun, 23 Feb 2020 01:16:26 +0000
Message-Id: <20200223011626.4103706-34-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37cbe7806677..96182a947ca1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3121,19 +3121,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	return ERR_PTR(error);
 }
 
-/*
- * Handle the last step of open()
- */
-static const char *do_last(struct nameidata *nd,
+static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
-	kuid_t dir_uid = nd->inode->i_uid;
-	umode_t dir_mode = nd->inode->i_mode;
 	int open_flag = op->open_flag;
-	bool do_truncate;
 	bool got_write = false;
-	int acc_mode;
 	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
@@ -3145,9 +3138,9 @@ static const char *do_last(struct nameidata *nd,
 
 	if (nd->last_type != LAST_NORM) {
 		error = handle_dots(nd, nd->last_type);
-		if (unlikely(error))
-			return ERR_PTR(error);
-		goto finish_open;
+		if (likely(!error))
+			error = complete_walk(nd);
+		return ERR_PTR(error);
 	}
 
 	if (!(open_flag & O_CREAT)) {
@@ -3160,7 +3153,6 @@ static const char *do_last(struct nameidata *nd,
 		if (likely(dentry))
 			goto finish_lookup;
 
-		BUG_ON(nd->inode != dir->d_inode);
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
 		/* create side of things */
@@ -3170,7 +3162,7 @@ static const char *do_last(struct nameidata *nd,
 		 * about to look up
 		 */
 		error = complete_walk(nd);
-		if (error)
+		if (unlikely(error))
 			return ERR_PTR(error);
 
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
@@ -3199,10 +3191,8 @@ static const char *do_last(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
-	if (got_write) {
+	if (got_write)
 		mnt_drop_write(nd->path.mnt);
-		got_write = false;
-	}
 
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
@@ -3210,7 +3200,7 @@ static const char *do_last(struct nameidata *nd,
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
 		nd->path.dentry = dentry;
-		goto finish_open_created;
+		return NULL;
 	}
 
 finish_lookup:
@@ -3226,12 +3216,29 @@ static const char *do_last(struct nameidata *nd,
 		audit_inode(nd->name, nd->path.dentry, 0);
 		return ERR_PTR(-EEXIST);
 	}
-finish_open:
+
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
-	error = complete_walk(nd);
-	if (error)
-		return ERR_PTR(error);
-finish_open_created:
+	return ERR_PTR(complete_walk(nd));
+}
+
+/*
+ * Handle the last step of open()
+ */
+static const char *do_last(struct nameidata *nd,
+		   struct file *file, const struct open_flags *op)
+{
+	kuid_t dir_uid = nd->inode->i_uid;
+	umode_t dir_mode = nd->inode->i_mode;
+	int open_flag = op->open_flag;
+	bool do_truncate;
+	int acc_mode;
+	const char *link;
+	int error;
+
+	link = open_last_lookups(nd, file, op);
+	if (unlikely(link))
+		return link;
+
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
-- 
2.11.0

