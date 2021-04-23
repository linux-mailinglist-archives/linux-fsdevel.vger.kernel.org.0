Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5F369862
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhDWRa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 13:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRa4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:30:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A4C7B181;
        Fri, 23 Apr 2021 17:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E4981F2B6E; Fri, 23 Apr 2021 19:30:18 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: [PATCH 04/12] ext2: Convert to using invalidate_lock
Date:   Fri, 23 Apr 2021 19:29:33 +0200
Message-Id: <20210423173018.23133-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210423171010.12-1-jack@suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ext2 has its private dax_sem used for synchronizing page faults and
truncation. Use mapping->invalidate_lock instead as it is meant for this
purpose.

CC: <linux-ext4@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  | 11 -----------
 fs/ext2/file.c  |  7 +++----
 fs/ext2/inode.c | 12 ++++++------
 fs/ext2/super.c |  3 ---
 4 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3309fb2d327a..96d5ea5df78b 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -671,9 +671,6 @@ struct ext2_inode_info {
 	struct rw_semaphore xattr_sem;
 #endif
 	rwlock_t i_meta_lock;
-#ifdef CONFIG_FS_DAX
-	struct rw_semaphore dax_sem;
-#endif
 
 	/*
 	 * truncate_mutex is for serialising ext2_truncate() against
@@ -689,14 +686,6 @@ struct ext2_inode_info {
 #endif
 };
 
-#ifdef CONFIG_FS_DAX
-#define dax_sem_down_write(ext2_inode)	down_write(&(ext2_inode)->dax_sem)
-#define dax_sem_up_write(ext2_inode)	up_write(&(ext2_inode)->dax_sem)
-#else
-#define dax_sem_down_write(ext2_inode)
-#define dax_sem_up_write(ext2_inode)
-#endif
-
 /*
  * Inode dynamic state flags
  */
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..9d4870df95c4 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -81,7 +81,7 @@ static ssize_t ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
  *
  * mmap_lock (MM)
  *   sb_start_pagefault (vfs, freeze)
- *     ext2_inode_info->dax_sem
+ *     address_space->invalidate_lock
  *       address_space->i_mmap_rwsem or page_lock (mutually exclusive in DAX)
  *         ext2_inode_info->truncate_mutex
  *
@@ -91,7 +91,6 @@ static ssize_t ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct ext2_inode_info *ei = EXT2_I(inode);
 	vm_fault_t ret;
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
@@ -100,11 +99,11 @@ static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 		sb_start_pagefault(inode->i_sb);
 		file_update_time(vmf->vma->vm_file);
 	}
-	down_read(&ei->dax_sem);
+	down_read(&inode->i_mapping->invalidate_lock);
 
 	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
 
-	up_read(&ei->dax_sem);
+	up_read(&inode->i_mapping->invalidate_lock);
 	if (write)
 		sb_end_pagefault(inode->i_sb);
 	return ret;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 68178b2234bd..e843be0ae53c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1175,7 +1175,7 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
 		ext2_free_data(inode, p, q);
 }
 
-/* dax_sem must be held when calling this function */
+/* mapping->invalidate_lock must be held when calling this function */
 static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
 	__le32 *i_data = EXT2_I(inode)->i_data;
@@ -1192,7 +1192,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	iblock = (offset + blocksize-1) >> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
 
 #ifdef CONFIG_FS_DAX
-	WARN_ON(!rwsem_is_locked(&ei->dax_sem));
+	WARN_ON(!rwsem_is_locked(&inode->i_mapping->invalidate_lock));
 #endif
 
 	n = ext2_block_to_path(inode, iblock, offsets, NULL);
@@ -1274,9 +1274,9 @@ static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
 
-	dax_sem_down_write(EXT2_I(inode));
+	down_write(&inode->i_mapping->invalidate_lock);
 	__ext2_truncate_blocks(inode, offset);
-	dax_sem_up_write(EXT2_I(inode));
+	up_write(&inode->i_mapping->invalidate_lock);
 }
 
 static int ext2_setsize(struct inode *inode, loff_t newsize)
@@ -1306,10 +1306,10 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	if (error)
 		return error;
 
-	dax_sem_down_write(EXT2_I(inode));
+	down_write(&inode->i_mapping->invalidate_lock);
 	truncate_setsize(inode, newsize);
 	__ext2_truncate_blocks(inode, newsize);
-	dax_sem_up_write(EXT2_I(inode));
+	up_write(&inode->i_mapping->invalidate_lock);
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	if (inode_needs_sync(inode)) {
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 6c4753277916..143e72c95acf 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -206,9 +206,6 @@ static void init_once(void *foo)
 	init_rwsem(&ei->xattr_sem);
 #endif
 	mutex_init(&ei->truncate_mutex);
-#ifdef CONFIG_FS_DAX
-	init_rwsem(&ei->dax_sem);
-#endif
 	inode_init_once(&ei->vfs_inode);
 }
 
-- 
2.26.2

