Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1E2F5BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 09:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhANIFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 03:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbhANIFl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:05:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBCEF2343F;
        Thu, 14 Jan 2021 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=YKYjqgvgj+FcJgByBL0k2kdYPUwJD9Fu/p2d+T3EJVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA8oTDzzLzmIBqYxF1WxPqFEzVQREa/5RebJ2B0Gt/UnY0wSEJUBuKJSTKZOWkxxs
         pAjiR+BvBgSDV/Nsn708sc/HGJUMtjHOrns61HmmT3yhOLHUSFD2mCvKQwsYK+2r8r
         oVjR8ATai9SrfLVfRXFXANnQsuYqs2QCjmjOYiSkzM7HoKGQSKopxXOM56Mb8KHQ2U
         YUxtPQhPW0LQhRptFtwSJ3vTQCXKvH4AW3UZL+BKLRp9yFOJDq8ZCApjCrhEg5oM2O
         EDDRaOabWl/Z8yo6FtI2AQr3u9b3Ao90+55hstydeI1R0bGHGrnopPhOTaLvfkLlxC
         ii80tUcExMJyA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6T-PY; Thu, 14 Jan 2021 09:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/16] fs: fix kernel-doc markups
Date:   Thu, 14 Jan 2021 09:04:39 +0100
Message-Id: <96b1e1b388600ab092331f6c4e88ff8e8779ce6c.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two markups are at the wrong place. Kernel-doc only
support having the comment just before the identifier.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/dcache.c   | 73 ++++++++++++++++++++++++++-------------------------
 fs/inode.c    |  4 +--
 fs/seq_file.c |  5 ++--
 fs/super.c    | 12 ++++-----
 4 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 737631c8ca7e..51e7081aacdd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -456,23 +456,6 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
 }
 
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent dentry hashes, so that it won't
- * be found through a VFS lookup any more. Note that this is different from
- * deleting the dentry - d_delete will try to mark the dentry negative if
- * possible, giving a successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
- * reason (NFS timeouts or autofs deletes).
- *
- * __d_drop requires dentry->d_lock
- * ___d_drop doesn't mark dentry as "unhashed"
- *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
- */
 static void ___d_drop(struct dentry *dentry)
 {
 	struct hlist_bl_head *b;
@@ -501,6 +484,24 @@ void __d_drop(struct dentry *dentry)
 }
 EXPORT_SYMBOL(__d_drop);
 
+/**
+ * d_drop - drop a dentry
+ * @dentry: dentry to drop
+ *
+ * d_drop() unhashes the entry from the parent dentry hashes, so that it won't
+ * be found through a VFS lookup any more. Note that this is different from
+ * deleting the dentry - d_delete will try to mark the dentry negative if
+ * possible, giving a successful _negative_ lookup, while d_drop will
+ * just make the cache lookup fail.
+ *
+ * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
+ * reason (NFS timeouts or autofs deletes).
+ *
+ * __d_drop requires dentry->d_lock
+ *
+ * ___d_drop doesn't mark dentry as "unhashed"
+ * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
+ */
 void d_drop(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
@@ -996,6 +997,25 @@ struct dentry *d_find_any_alias(struct inode *inode)
 }
 EXPORT_SYMBOL(d_find_any_alias);
 
+static struct dentry *__d_find_alias(struct inode *inode)
+{
+	struct dentry *alias;
+
+	if (S_ISDIR(inode->i_mode))
+		return __d_find_any_alias(inode);
+
+	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+		spin_lock(&alias->d_lock);
+ 		if (!d_unhashed(alias)) {
+			__dget_dlock(alias);
+			spin_unlock(&alias->d_lock);
+			return alias;
+		}
+		spin_unlock(&alias->d_lock);
+	}
+	return NULL;
+}
+
 /**
  * d_find_alias - grab a hashed alias of inode
  * @inode: inode in question
@@ -1010,25 +1030,6 @@ EXPORT_SYMBOL(d_find_any_alias);
  * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
  * any other hashed alias over that one.
  */
-static struct dentry *__d_find_alias(struct inode *inode)
-{
-	struct dentry *alias;
-
-	if (S_ISDIR(inode->i_mode))
-		return __d_find_any_alias(inode);
-
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		spin_lock(&alias->d_lock);
- 		if (!d_unhashed(alias)) {
-			__dget_dlock(alias);
-			spin_unlock(&alias->d_lock);
-			return alias;
-		}
-		spin_unlock(&alias->d_lock);
-	}
-	return NULL;
-}
-
 struct dentry *d_find_alias(struct inode *inode)
 {
 	struct dentry *de = NULL;
diff --git a/fs/inode.c b/fs/inode.c
index dd52b6444fdf..af280ffb105d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1494,7 +1494,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 EXPORT_SYMBOL(find_inode_rcu);
 
 /**
- * find_inode_by_rcu - Find an inode in the inode cache
+ * find_inode_by_ino_rcu - Find an inode in the inode cache
  * @sb:		Super block of file system to search
  * @ino:	The inode number to match
  *
@@ -1780,7 +1780,7 @@ static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 }
 
 /**
- *	touch_atime	-	update the access time
+ *	atime_needs_update	-	update the access time
  *	@path: the &struct path to update
  *	@inode: inode to update
  *
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 03a369ccd28c..cb11a34fb871 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -669,7 +669,8 @@ void seq_puts(struct seq_file *m, const char *s)
 EXPORT_SYMBOL(seq_puts);
 
 /**
- * A helper routine for putting decimal numbers without rich format of printf().
+ * seq_put_decimal_ull_width - A helper routine for putting decimal numbers
+ * 			       without rich format of printf().
  * only 'unsigned long long' is supported.
  * @m: seq_file identifying the buffer to which data should be written
  * @delimiter: a string which is printed before the number
@@ -1044,7 +1045,7 @@ struct hlist_node *seq_hlist_next_rcu(void *v,
 EXPORT_SYMBOL(seq_hlist_next_rcu);
 
 /**
- * seq_hlist_start_precpu - start an iteration of a percpu hlist array
+ * seq_hlist_start_percpu - start an iteration of a percpu hlist array
  * @head: pointer to percpu array of struct hlist_heads
  * @cpu:  pointer to cpu "cursor"
  * @pos:  start position of sequence
diff --git a/fs/super.c b/fs/super.c
index 2c6cdea2ab2d..18a3de0b93f5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1718,12 +1718,6 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
-/**
- * thaw_super -- unlock filesystem
- * @sb: the super to thaw
- *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
- */
 static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
@@ -1759,6 +1753,12 @@ static int thaw_super_locked(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * thaw_super -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ */
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-- 
2.29.2

