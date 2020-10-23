Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0E297459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465775AbgJWQfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbgJWQdu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F79246AE;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=wFAn0R/tOd0Kse8l+Oi7WKhaA3ZlYRYbU5RUMjj5mUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU9oAuoHnG9RRaRL/yHmNiCrFh+7U1K9d8gKjoak3zpb5iONPyeVfB+sKSIIpXMJd
         Wx+zNnOLY+lwUbkrCDXq9wdUVxJJ5zZqNzZ2p6A8+80Pg3gDVes5heM5Tf5/Mto2Ul
         QyAvW/kqeiL4AfAXWvUAFmYNunP3lGONZ6+VdAS0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Aws-6O; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 34/56] fs: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:21 +0200
Message-Id: <eb5b1596a78485a6b60d73baea3ce50223c10dbb.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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
 fs/dcache.c   | 72 +++++++++++++++++++++++++--------------------------
 fs/inode.c    |  4 +--
 fs/seq_file.c |  5 ++--
 fs/super.c    | 12 ++++-----
 4 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..6eabb48a49fc 100644
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
@@ -501,6 +484,23 @@ void __d_drop(struct dentry *dentry)
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
+ * ___d_drop doesn't mark dentry as "unhashed"
+ *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
+ */
 void d_drop(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
@@ -989,6 +989,25 @@ struct dentry *d_find_any_alias(struct inode *inode)
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
@@ -1003,25 +1022,6 @@ EXPORT_SYMBOL(d_find_any_alias);
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
index 9d78c37b00b8..aad3dcf2e259 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1496,7 +1496,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 EXPORT_SYMBOL(find_inode_rcu);
 
 /**
- * find_inode_by_rcu - Find an inode in the inode cache
+ * find_inode_by_ino_rcu - Find an inode in the inode cache
  * @sb:		Super block of file system to search
  * @ino:	The inode number to match
  *
@@ -1778,7 +1778,7 @@ static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 }
 
 /**
- *	touch_atime	-	update the access time
+ *	atime_needs_update	-	update the access time
  *	@path: the &struct path to update
  *	@inode: inode to update
  *
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 31219c1db17d..f0b933179a74 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -653,7 +653,8 @@ void seq_puts(struct seq_file *m, const char *s)
 EXPORT_SYMBOL(seq_puts);
 
 /**
- * A helper routine for putting decimal numbers without rich format of printf().
+ * seq_put_decimal_ull_width - A helper routine for putting decimal numbers
+ * 			       without rich format of printf().
  * only 'unsigned long long' is supported.
  * @m: seq_file identifying the buffer to which data should be written
  * @delimiter: a string which is printed before the number
@@ -1028,7 +1029,7 @@ struct hlist_node *seq_hlist_next_rcu(void *v,
 EXPORT_SYMBOL(seq_hlist_next_rcu);
 
 /**
- * seq_hlist_start_precpu - start an iteration of a percpu hlist array
+ * seq_hlist_start_percpu - start an iteration of a percpu hlist array
  * @head: pointer to percpu array of struct hlist_heads
  * @cpu:  pointer to cpu "cursor"
  * @pos:  start position of sequence
diff --git a/fs/super.c b/fs/super.c
index a51c2083cd6b..3f7a4c10ef0a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1820,12 +1820,6 @@ int freeze_super(struct super_block *sb)
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
@@ -1861,6 +1855,12 @@ static int thaw_super_locked(struct super_block *sb)
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
2.26.2

