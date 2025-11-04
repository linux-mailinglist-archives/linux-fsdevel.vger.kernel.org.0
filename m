Return-Path: <linux-fsdevel+bounces-66959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F0C319D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D87C3B6C6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197A2D8362;
	Tue,  4 Nov 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnTz02Cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776733030C;
	Tue,  4 Nov 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267616; cv=none; b=mHRJNAtbOnA1tR0bB72Gcv64XSg2R2nnupw7UiquvFP117EjEbEknxzGvimFWY6F0osyIqWiAnVHtUyw+XoyIGt2iP5xGZSkerEaBryJ9aiWh7NdqXuI8OUCuamI8foFct4PYfk0DMgkjGalbPa2FZBHd/A9r+55uNdHU4Cd5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267616; c=relaxed/simple;
	bh=/a27NOlv+cT1f3NL+AngUXaBuBQ16btI2AZABdX1FjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKjJ/oFzLodS6br6CtmhKCvNYr+HsRvHlayTQeV3btkGp+XgnBSodW0nhwSd2O5H8rstlTOSAcXNOpVMLbyq36RGydgJS0lz8V61FIdHMYUdHjf21iLL98f+qG3B5Fj7yFkdtMIqTIxB2rcsqMZwL9ITgRTBuK21qZK1iL/EDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnTz02Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9321C116C6;
	Tue,  4 Nov 2025 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267616;
	bh=/a27NOlv+cT1f3NL+AngUXaBuBQ16btI2AZABdX1FjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EnTz02Cwp+Y3RPRj68dlr1fJul2hHB0LO4HUJ/e/hVwU2cV2GD++TXWXr1npmN/QS
	 0bLcZqrDpFm7EcnRWXzPyQ4qKXwbF9PTsXhwI2WQLFecIJp2sQqo3w+xYYNa1uHlxR
	 71MuWd092p9+Mi6mu947vIfX52fA6f7DbRYOOwzEthC0/4GOo9jyj/MJKhickOljbm
	 hoQu7uwUjjaZEA8ymDSkWefHh9uXQMnkyKHFafZK6FQ36x5NB9QWHoDciLMwzyZg4q
	 ywAqNGGntrFgiHChCcvtwLmKmKrHeHOVoJZ92aSqpyuWe6jJvv+UiHSCaa6XTl7Zeg
	 mthb45v2VURjA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 15:46:34 +0100
Subject: [PATCH 3/3] fs: add fs_super.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-fs-header-v1-3-fb39a2efe39e@kernel.org>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
In-Reply-To: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18003; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/a27NOlv+cT1f3NL+AngUXaBuBQ16btI2AZABdX1FjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyCd4on7mqvn5xqfuXhxzuTGyvFXsrD87vNT1vPbem0
 /OIymWTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsncfI8FX67aqwWT5LTJTm
 nJgld6f5ZNRxszQmgY8sKa3+rCaL2hkZnr+SP1wjteHSuv+6z/Jub/g0P+K9hE/Nt9MCt8UXpOc
 IcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split out super block associated functions into a separate header.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h       | 220 +-------------------------------------------
 include/linux/fs_super.h | 233 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 219 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 17fa9b64354b..1fde6bab3287 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
-#include <linux/fs_super_types.h>
+#include <linux/fs_super.h>
 #include <linux/vfsdebug.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
@@ -1662,66 +1662,6 @@ struct timespec64 simple_inode_init_ts(struct inode *inode);
  * Snapshotting support.
  */
 
-/*
- * These are internal functions, please use sb_start_{write,pagefault,intwrite}
- * instead.
- */
-static inline void __sb_end_write(struct super_block *sb, int level)
-{
-	percpu_up_read(sb->s_writers.rw_sem + level-1);
-}
-
-static inline void __sb_start_write(struct super_block *sb, int level)
-{
-	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);
-}
-
-static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
-{
-	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
-}
-
-#define __sb_writers_acquired(sb, lev)	\
-	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
-#define __sb_writers_release(sb, lev)	\
-	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
-
-/**
- * __sb_write_started - check if sb freeze level is held
- * @sb: the super we write to
- * @level: the freeze level
- *
- * * > 0 - sb freeze level is held
- * *   0 - sb freeze level is not held
- * * < 0 - !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
- */
-static inline int __sb_write_started(const struct super_block *sb, int level)
-{
-	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
-}
-
-/**
- * sb_write_started - check if SB_FREEZE_WRITE is held
- * @sb: the super we write to
- *
- * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
- */
-static inline bool sb_write_started(const struct super_block *sb)
-{
-	return __sb_write_started(sb, SB_FREEZE_WRITE);
-}
-
-/**
- * sb_write_not_started - check if SB_FREEZE_WRITE is not held
- * @sb: the super we write to
- *
- * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
- */
-static inline bool sb_write_not_started(const struct super_block *sb)
-{
-	return __sb_write_started(sb, SB_FREEZE_WRITE) <= 0;
-}
-
 /**
  * file_write_started - check if SB_FREEZE_WRITE is held
  * @file: the file we write to
@@ -1752,118 +1692,6 @@ static inline bool file_write_not_started(const struct file *file)
 	return sb_write_not_started(file_inode(file)->i_sb);
 }
 
-/**
- * sb_end_write - drop write access to a superblock
- * @sb: the super we wrote to
- *
- * Decrement number of writers to the filesystem. Wake up possible waiters
- * wanting to freeze the filesystem.
- */
-static inline void sb_end_write(struct super_block *sb)
-{
-	__sb_end_write(sb, SB_FREEZE_WRITE);
-}
-
-/**
- * sb_end_pagefault - drop write access to a superblock from a page fault
- * @sb: the super we wrote to
- *
- * Decrement number of processes handling write page fault to the filesystem.
- * Wake up possible waiters wanting to freeze the filesystem.
- */
-static inline void sb_end_pagefault(struct super_block *sb)
-{
-	__sb_end_write(sb, SB_FREEZE_PAGEFAULT);
-}
-
-/**
- * sb_end_intwrite - drop write access to a superblock for internal fs purposes
- * @sb: the super we wrote to
- *
- * Decrement fs-internal number of writers to the filesystem.  Wake up possible
- * waiters wanting to freeze the filesystem.
- */
-static inline void sb_end_intwrite(struct super_block *sb)
-{
-	__sb_end_write(sb, SB_FREEZE_FS);
-}
-
-/**
- * sb_start_write - get write access to a superblock
- * @sb: the super we write to
- *
- * When a process wants to write data or metadata to a file system (i.e. dirty
- * a page or an inode), it should embed the operation in a sb_start_write() -
- * sb_end_write() pair to get exclusion against file system freezing. This
- * function increments number of writers preventing freezing. If the file
- * system is already frozen, the function waits until the file system is
- * thawed.
- *
- * Since freeze protection behaves as a lock, users have to preserve
- * ordering of freeze protection and other filesystem locks. Generally,
- * freeze protection should be the outermost lock. In particular, we have:
- *
- * sb_start_write
- *   -> i_rwsem			(write path, truncate, directory ops, ...)
- *   -> s_umount		(freeze_super, thaw_super)
- */
-static inline void sb_start_write(struct super_block *sb)
-{
-	__sb_start_write(sb, SB_FREEZE_WRITE);
-}
-
-static inline bool sb_start_write_trylock(struct super_block *sb)
-{
-	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
-}
-
-/**
- * sb_start_pagefault - get write access to a superblock from a page fault
- * @sb: the super we write to
- *
- * When a process starts handling write page fault, it should embed the
- * operation into sb_start_pagefault() - sb_end_pagefault() pair to get
- * exclusion against file system freezing. This is needed since the page fault
- * is going to dirty a page. This function increments number of running page
- * faults preventing freezing. If the file system is already frozen, the
- * function waits until the file system is thawed.
- *
- * Since page fault freeze protection behaves as a lock, users have to preserve
- * ordering of freeze protection and other filesystem locks. It is advised to
- * put sb_start_pagefault() close to mmap_lock in lock ordering. Page fault
- * handling code implies lock dependency:
- *
- * mmap_lock
- *   -> sb_start_pagefault
- */
-static inline void sb_start_pagefault(struct super_block *sb)
-{
-	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
-}
-
-/**
- * sb_start_intwrite - get write access to a superblock for internal fs purposes
- * @sb: the super we write to
- *
- * This is the third level of protection against filesystem freezing. It is
- * free for use by a filesystem. The only requirement is that it must rank
- * below sb_start_pagefault.
- *
- * For example filesystem can call sb_start_intwrite() when starting a
- * transaction which somewhat eases handling of freezing for internal sources
- * of filesystem changes (internal fs threads, discarding preallocation on file
- * close, etc.).
- */
-static inline void sb_start_intwrite(struct super_block *sb)
-{
-	__sb_start_write(sb, SB_FREEZE_FS);
-}
-
-static inline bool sb_start_intwrite_trylock(struct super_block *sb)
-{
-	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
-}
-
 bool inode_owner_or_capable(struct mnt_idmap *idmap,
 			    const struct inode *inode);
 
@@ -2233,7 +2061,6 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
  */
 #define __IS_FLG(inode, flg)	((inode)->i_sb->s_flags & (flg))
 
-static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags & SB_RDONLY; }
 #define IS_RDONLY(inode)	sb_rdonly((inode)->i_sb)
 #define IS_SYNC(inode)		(__IS_FLG(inode, SB_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
@@ -2467,10 +2294,6 @@ extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
-int freeze_super(struct super_block *super, enum freeze_holder who,
-		 const void *freeze_owner);
-int thaw_super(struct super_block *super, enum freeze_holder who,
-	       const void *freeze_owner);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
@@ -2657,12 +2480,6 @@ extern struct kmem_cache *names_cachep;
 #define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
 #define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
 
-extern struct super_block *blockdev_superblock;
-static inline bool sb_is_blkdev_sb(struct super_block *sb)
-{
-	return IS_ENABLED(CONFIG_BLOCK) && sb == blockdev_superblock;
-}
-
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
@@ -3117,9 +2934,6 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
-extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
-
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
 int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
@@ -3439,38 +3253,6 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir,
 }
 #endif
 
-static inline struct unicode_map *sb_encoding(const struct super_block *sb)
-{
-#if IS_ENABLED(CONFIG_UNICODE)
-	return sb->s_encoding;
-#else
-	return NULL;
-#endif
-}
-
-static inline bool sb_has_encoding(const struct super_block *sb)
-{
-	return !!sb_encoding(sb);
-}
-
-/*
- * Compare if two super blocks have the same encoding and flags
- */
-static inline bool sb_same_encoding(const struct super_block *sb1,
-				    const struct super_block *sb2)
-{
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (sb1->s_encoding == sb2->s_encoding)
-		return true;
-
-	return (sb1->s_encoding && sb2->s_encoding &&
-	       (sb1->s_encoding->version == sb2->s_encoding->version) &&
-	       (sb1->s_encoding_flags == sb2->s_encoding_flags));
-#else
-	return true;
-#endif
-}
-
 int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		unsigned int ia_valid);
 int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);
diff --git a/include/linux/fs_super.h b/include/linux/fs_super.h
new file mode 100644
index 000000000000..2c8f4e61a5dd
--- /dev/null
+++ b/include/linux/fs_super.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FS_SUPER_H
+#define _LINUX_FS_SUPER_H
+
+#include <linux/fs_super_types.h>
+#include <linux/unicode.h>
+
+/*
+ * These are internal functions, please use sb_start_{write,pagefault,intwrite}
+ * instead.
+ */
+static inline void __sb_end_write(struct super_block *sb, int level)
+{
+	percpu_up_read(sb->s_writers.rw_sem + level - 1);
+}
+
+static inline void __sb_start_write(struct super_block *sb, int level)
+{
+	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);
+}
+
+static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
+{
+	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
+}
+
+#define __sb_writers_acquired(sb, lev) \
+	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev) - 1], 1, _THIS_IP_)
+#define __sb_writers_release(sb, lev) \
+	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev) - 1], _THIS_IP_)
+
+/**
+ * __sb_write_started - check if sb freeze level is held
+ * @sb: the super we write to
+ * @level: the freeze level
+ *
+ * * > 0 - sb freeze level is held
+ * *   0 - sb freeze level is not held
+ * * < 0 - !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
+ */
+static inline int __sb_write_started(const struct super_block *sb, int level)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
+}
+
+/**
+ * sb_write_started - check if SB_FREEZE_WRITE is held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
+static inline bool sb_write_started(const struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_WRITE);
+}
+
+/**
+ * sb_write_not_started - check if SB_FREEZE_WRITE is not held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
+static inline bool sb_write_not_started(const struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_WRITE) <= 0;
+}
+
+/**
+ * sb_end_write - drop write access to a superblock
+ * @sb: the super we wrote to
+ *
+ * Decrement number of writers to the filesystem. Wake up possible waiters
+ * wanting to freeze the filesystem.
+ */
+static inline void sb_end_write(struct super_block *sb)
+{
+	__sb_end_write(sb, SB_FREEZE_WRITE);
+}
+
+/**
+ * sb_end_pagefault - drop write access to a superblock from a page fault
+ * @sb: the super we wrote to
+ *
+ * Decrement number of processes handling write page fault to the filesystem.
+ * Wake up possible waiters wanting to freeze the filesystem.
+ */
+static inline void sb_end_pagefault(struct super_block *sb)
+{
+	__sb_end_write(sb, SB_FREEZE_PAGEFAULT);
+}
+
+/**
+ * sb_end_intwrite - drop write access to a superblock for internal fs purposes
+ * @sb: the super we wrote to
+ *
+ * Decrement fs-internal number of writers to the filesystem.  Wake up possible
+ * waiters wanting to freeze the filesystem.
+ */
+static inline void sb_end_intwrite(struct super_block *sb)
+{
+	__sb_end_write(sb, SB_FREEZE_FS);
+}
+
+/**
+ * sb_start_write - get write access to a superblock
+ * @sb: the super we write to
+ *
+ * When a process wants to write data or metadata to a file system (i.e. dirty
+ * a page or an inode), it should embed the operation in a sb_start_write() -
+ * sb_end_write() pair to get exclusion against file system freezing. This
+ * function increments number of writers preventing freezing. If the file
+ * system is already frozen, the function waits until the file system is
+ * thawed.
+ *
+ * Since freeze protection behaves as a lock, users have to preserve
+ * ordering of freeze protection and other filesystem locks. Generally,
+ * freeze protection should be the outermost lock. In particular, we have:
+ *
+ * sb_start_write
+ *   -> i_rwsem			(write path, truncate, directory ops, ...)
+ *   -> s_umount		(freeze_super, thaw_super)
+ */
+static inline void sb_start_write(struct super_block *sb)
+{
+	__sb_start_write(sb, SB_FREEZE_WRITE);
+}
+
+static inline bool sb_start_write_trylock(struct super_block *sb)
+{
+	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
+}
+
+/**
+ * sb_start_pagefault - get write access to a superblock from a page fault
+ * @sb: the super we write to
+ *
+ * When a process starts handling write page fault, it should embed the
+ * operation into sb_start_pagefault() - sb_end_pagefault() pair to get
+ * exclusion against file system freezing. This is needed since the page fault
+ * is going to dirty a page. This function increments number of running page
+ * faults preventing freezing. If the file system is already frozen, the
+ * function waits until the file system is thawed.
+ *
+ * Since page fault freeze protection behaves as a lock, users have to preserve
+ * ordering of freeze protection and other filesystem locks. It is advised to
+ * put sb_start_pagefault() close to mmap_lock in lock ordering. Page fault
+ * handling code implies lock dependency:
+ *
+ * mmap_lock
+ *   -> sb_start_pagefault
+ */
+static inline void sb_start_pagefault(struct super_block *sb)
+{
+	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
+}
+
+/**
+ * sb_start_intwrite - get write access to a superblock for internal fs purposes
+ * @sb: the super we write to
+ *
+ * This is the third level of protection against filesystem freezing. It is
+ * free for use by a filesystem. The only requirement is that it must rank
+ * below sb_start_pagefault.
+ *
+ * For example filesystem can call sb_start_intwrite() when starting a
+ * transaction which somewhat eases handling of freezing for internal sources
+ * of filesystem changes (internal fs threads, discarding preallocation on file
+ * close, etc.).
+ */
+static inline void sb_start_intwrite(struct super_block *sb)
+{
+	__sb_start_write(sb, SB_FREEZE_FS);
+}
+
+static inline bool sb_start_intwrite_trylock(struct super_block *sb)
+{
+	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
+}
+
+static inline bool sb_rdonly(const struct super_block *sb)
+{
+	return sb->s_flags & SB_RDONLY;
+}
+
+static inline bool sb_is_blkdev_sb(struct super_block *sb)
+{
+	return IS_ENABLED(CONFIG_BLOCK) && sb == blockdev_superblock;
+}
+
+#if IS_ENABLED(CONFIG_UNICODE)
+static inline struct unicode_map *sb_encoding(const struct super_block *sb)
+{
+	return sb->s_encoding;
+}
+
+/* Compare if two super blocks have the same encoding and flags */
+static inline bool sb_same_encoding(const struct super_block *sb1,
+				    const struct super_block *sb2)
+{
+	if (sb1->s_encoding == sb2->s_encoding)
+		return true;
+
+	return (sb1->s_encoding && sb2->s_encoding &&
+		(sb1->s_encoding->version == sb2->s_encoding->version) &&
+		(sb1->s_encoding_flags == sb2->s_encoding_flags));
+}
+#else
+static inline struct unicode_map *sb_encoding(const struct super_block *sb)
+{
+	return NULL;
+}
+
+static inline bool sb_same_encoding(const struct super_block *sb1,
+				    const struct super_block *sb2)
+{
+	return true;
+}
+#endif
+
+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+	return !!sb_encoding(sb);
+}
+
+int sb_set_blocksize(struct super_block *sb, int size);
+int sb_min_blocksize(struct super_block *sb, int size);
+
+int freeze_super(struct super_block *super, enum freeze_holder who,
+		 const void *freeze_owner);
+int thaw_super(struct super_block *super, enum freeze_holder who,
+	       const void *freeze_owner);
+
+#endif /* _LINUX_FS_SUPER_H */

-- 
2.47.3


