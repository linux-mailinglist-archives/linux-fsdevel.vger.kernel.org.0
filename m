Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D43C6113
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhGLQ7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34554 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhGLQ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2BA3B2211B;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgWT5tfqbtBkDrX2L7CznODEgq2BTXfXClIF6lsIWFg=;
        b=Sm5c7q5vWIleHI665sSlVqnIrmuMub99LSvmLfGEhJccZqjnJXyrAs5+vU7ohfHa6X49lk
        j5Z1aOGlYv4JgU+r2T/j4S7bic9cq7vsqwGzRucEjnyD56rtZ9vxoByE2FwlqWDJlb7Aaf
        VJcLT6/yo9sxoeIZzfkVhnm/dYkhVlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VgWT5tfqbtBkDrX2L7CznODEgq2BTXfXClIF6lsIWFg=;
        b=vuGVDsvOKxWoy5sgAZUaacamI2k1MtX0dlMhk/EuWnR85DX4i1myzVVkznWRlIEQiNzrfC
        j+o+MM6xz4ia+LCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1A351A3B8F;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA7FD1F2CD6; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/14] ext2: Convert to using invalidate_lock
Date:   Mon, 12 Jul 2021 18:55:57 +0200
Message-Id: <20210712165609.13215-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4727; h=from:subject; bh=ym49Iu4QRUik/RZXy3TKmo1SdbNHjClhswakdveozJ4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQdXqVppyqhs9Kow3gAlNxylsvMUO1Q8weiZrXk EGLnB5OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0HQAKCRCcnaoHP2RA2UOjB/ 4vizzKQOY3566vzcBx+Oo+EVCYDCp8fWw67wRuEwuKvbkWrtvFa4EL5D3aZd+jpmPZZxmIAnsZsrge TAVfNnOyq7uQPu5FJdfkukZLHHaiuZOyWEzBPvwKOc3mkzuQv+oZDpL+N9i7oyfcYTpZWJhjKZln49 h28u8FRs/Gy4s43hnmXsUcOGmvhjwgWRHOrLOlOSrB/0ui08NuYnuIEj+0JjNzno9wP0c/k0QxseC8 WBN1T3YIhaI3OV7ZLCv+UcIGM3Ezjm4TOkl0ZRxanSejUaZ9Nzg6D/EB7j9MvNZcCmolZUdqK6QCTK lGzG4V/9QFGv3wSLKROh+XLf7n8Ep6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ext2 has its private dax_sem used for synchronizing page faults and
truncation. Use mapping->invalidate_lock instead as it is meant for this
purpose.

CC: <linux-ext4@vger.kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  | 11 -----------
 fs/ext2/file.c  |  7 +++----
 fs/ext2/inode.c | 12 ++++++------
 fs/ext2/super.c |  3 ---
 4 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index b0a694820cb7..81907a041570 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -667,9 +667,6 @@ struct ext2_inode_info {
 	struct rw_semaphore xattr_sem;
 #endif
 	rwlock_t i_meta_lock;
-#ifdef CONFIG_FS_DAX
-	struct rw_semaphore dax_sem;
-#endif
 
 	/*
 	 * truncate_mutex is for serialising ext2_truncate() against
@@ -685,14 +682,6 @@ struct ext2_inode_info {
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
index f98466acc672..eb97aa3d700e 100644
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
+	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
 
-	up_read(&ei->dax_sem);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 	if (write)
 		sb_end_pagefault(inode->i_sb);
 	return ret;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dadb121beb22..33f874f0fc4a 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1177,7 +1177,7 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
 		ext2_free_data(inode, p, q);
 }
 
-/* dax_sem must be held when calling this function */
+/* mapping->invalidate_lock must be held when calling this function */
 static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
 	__le32 *i_data = EXT2_I(inode)->i_data;
@@ -1194,7 +1194,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	iblock = (offset + blocksize-1) >> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
 
 #ifdef CONFIG_FS_DAX
-	WARN_ON(!rwsem_is_locked(&ei->dax_sem));
+	WARN_ON(!rwsem_is_locked(&inode->i_mapping->invalidate_lock));
 #endif
 
 	n = ext2_block_to_path(inode, iblock, offsets, NULL);
@@ -1276,9 +1276,9 @@ static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
 
-	dax_sem_down_write(EXT2_I(inode));
+	filemap_invalidate_lock(inode->i_mapping);
 	__ext2_truncate_blocks(inode, offset);
-	dax_sem_up_write(EXT2_I(inode));
+	filemap_invalidate_unlock(inode->i_mapping);
 }
 
 static int ext2_setsize(struct inode *inode, loff_t newsize)
@@ -1308,10 +1308,10 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	if (error)
 		return error;
 
-	dax_sem_down_write(EXT2_I(inode));
+	filemap_invalidate_lock(inode->i_mapping);
 	truncate_setsize(inode, newsize);
 	__ext2_truncate_blocks(inode, newsize);
-	dax_sem_up_write(EXT2_I(inode));
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	if (inode_needs_sync(inode)) {
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 21e09fbaa46f..987bcf32ed46 100644
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

