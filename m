Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1055B2CA4FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391560AbgLAOGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 09:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbgLAOGr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:06:47 -0500
Received: from coco.lan (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FC120857;
        Tue,  1 Dec 2020 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831566;
        bh=Ialf7VVYOWrStFEyTWHR4a2cJFjkmNc87hIezbnabDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APzFqj/76ePP8ghi3a0lmmoXeTWBNutKM149XAk6TQDzUhc3699WdLaWrkXqWdISY
         skDzLMXkCUCgdtHC7hOj0hCLtBjOVuwabWzs/ksRw3Z9HP2w4Y6zwvA5MqFcpXLOim
         0E1jHbq+SeO5qHI29S3Sf7NjAtb2Ol1ZsGp4HaAs=
Date:   Tue, 1 Dec 2020 15:06:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/16] fs: fix kernel-doc markups
Message-ID: <20201201150601.7f92bfd6@coco.lan>
In-Reply-To: <20201201124341.GA21541@infradead.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
        <46ccd8f26eb51b2eb092923d74eadf71fdca43d7.1606823973.git.mchehab+huawei@kernel.org>
        <20201201124341.GA21541@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Tue, 1 Dec 2020 12:43:41 +0000
Christoph Hellwig <hch@infradead.org> escreveu:

> On Tue, Dec 01, 2020 at 01:08:58PM +0100, Mauro Carvalho Chehab wrote:
> > Two markups are at the wrong place. Kernel-doc only
> > support having the comment just before the identifier.
> > 
> > Also, some identifiers have different names between their
> > prototypes and the kernel-doc markup.  
> 
> This patch looks really weird, having 30-ish unchanged lines as the
> unified diff context.

That was due to a past review request for this series.

With -U32, all kernel-doc markups and the corresponding function names
can be seen at the patch.

I'm enclosing the same patch with the usual -U3.

Thanks,
Mauro

[PATCH] fs: fix kernel-doc markups

Two markups are at the wrong place. Kernel-doc only
support having the comment just before the identifier.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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
@@ -989,20 +989,6 @@ struct dentry *d_find_any_alias(struct inode *inode)
 }
 EXPORT_SYMBOL(d_find_any_alias);
 
-/**
- * d_find_alias - grab a hashed alias of inode
- * @inode: inode in question
- *
- * If inode has a hashed alias, or is a directory and has any alias,
- * acquire the reference to alias and return it. Otherwise return NULL.
- * Notice that if inode is a directory there can be only one alias and
- * it can be unhashed only if it has no children, or if it is the root
- * of a filesystem, or if the directory was renamed and d_revalidate
- * was the first vfs operation to notice.
- *
- * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
- * any other hashed alias over that one.
- */
 static struct dentry *__d_find_alias(struct inode *inode)
 {
 	struct dentry *alias;
@@ -1022,6 +1008,20 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	return NULL;
 }
 
+/**
+ * d_find_alias - grab a hashed alias of inode
+ * @inode: inode in question
+ *
+ * If inode has a hashed alias, or is a directory and has any alias,
+ * acquire the reference to alias and return it. Otherwise return NULL.
+ * Notice that if inode is a directory there can be only one alias and
+ * it can be unhashed only if it has no children, or if it is the root
+ * of a filesystem, or if the directory was renamed and d_revalidate
+ * was the first vfs operation to notice.
+ *
+ * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
+ * any other hashed alias over that one.
+ */
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
index 98bb0629ee10..912636bbda9e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1771,12 +1771,6 @@ int freeze_super(struct super_block *sb)
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
@@ -1812,6 +1806,12 @@ static int thaw_super_locked(struct super_block *sb)
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
