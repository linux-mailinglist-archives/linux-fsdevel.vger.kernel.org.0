Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD86813AED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgANQNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:13:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgANQMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KsSHHUOODJAHu0IH1q2ibItg0o+FnF2PjXUOf0SG9sk=; b=UEzcY+P6ZvJxzr8ibbfl7rLl4Z
        173d2Re54ZTDUtZuxdT3xB1jvIvX/ELdv1aF02PAqHtlKcZHFtbKxF/AoiK2YmisrsIC7XEHHgzRB
        tF9ZwhfAEH0phGwBRkfQjaxddO0iPZZyh55XP9r+dVluaUZGpM2OOoJN68oVnheCZxD9/R2O+iSJq
        JULueo3prR4THi9bWDNyJYcLPoDCbiI21velupVtAIonY/MelN+LDgMpyONrFeUd/7weRrLxsSYo8
        0Np5PDa2YtOY71dex2+4X7fGg4vkORBUCVG4MAF6EhUV3BQ+FwVbaYsBWGEEtLexQG0Lh+Qzpq31f
        batE4Azg==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoD-0000DG-38; Tue, 14 Jan 2020 16:12:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/12] ext4: hold i_rwsem until AIO completes
Date:   Tue, 14 Jan 2020 17:12:21 +0100
Message-Id: <20200114161225.309792-9-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch ext4 from the magic i_dio_count scheme to just hold i_rwsem
until the actual I/O has completed to reduce the locking complexity
and avoid nasty bugs due to missing inode_dio_wait calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/extents.c     | 12 ------------
 fs/ext4/file.c        | 21 +++++++++++++--------
 fs/ext4/inode.c       | 11 -----------
 fs/ext4/ioctl.c       |  5 -----
 fs/ext4/move_extent.c |  4 ----
 5 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e8708b77da6..b6aa2d249b30 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4777,9 +4777,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (mode & FALLOC_FL_KEEP_SIZE)
 		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
-	inode_dio_wait(inode);
-
 	/* Preallocate the range including the unaligned edges */
 	if (partial_begin || partial_end) {
 		ret = ext4_alloc_file_blocks(file,
@@ -4949,9 +4946,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 			goto out;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
-	inode_dio_wait(inode);
-
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
 	if (ret)
 		goto out;
@@ -5525,9 +5519,6 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		goto out_mutex;
 	}
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
@@ -5678,9 +5669,6 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		goto out_mutex;
 	}
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 08b603d0c638..b3410a3ede27 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,9 +74,10 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0);
-	inode_unlock_shared(inode);
-
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
+			   IOMAP_DIO_RWSEM_SHARED);
+	if (ret != -EIOCBQUEUED)
+		inode_unlock_shared(inode);
 	file_accessed(iocb->ki_filp);
 	return ret;
 }
@@ -405,7 +406,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
 		unaligned_aio = true;
 		dio_flags |= IOMAP_DIO_SYNCHRONOUS;
-		inode_dio_wait(inode);
 	}
 
 	/*
@@ -416,7 +416,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
 	    ext4_should_dioread_nolock(inode)) {
 		overwrite = true;
+		dio_flags |= IOMAP_DIO_RWSEM_SHARED;
 		downgrade_write(&inode->i_rwsem);
+	} else {
+		dio_flags |= IOMAP_DIO_RWSEM_EXCL;
 	}
 
 	if (offset + count > EXT4_I(inode)->i_disksize) {
@@ -444,10 +447,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
 
 out:
-	if (overwrite)
-		inode_unlock_shared(inode);
-	else
-		inode_unlock(inode);
+	if (ret != -EIOCBQUEUED) {
+		if (overwrite)
+			inode_unlock_shared(inode);
+		else
+			inode_unlock(inode);
+	}
 
 	if (ret >= 0 && iov_iter_count(from)) {
 		ssize_t err;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 629a25d999f0..e2dac0727ab0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3965,9 +3965,6 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
-	inode_dio_wait(inode);
-
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
@@ -5263,11 +5260,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				if (error)
 					goto err_out;
 			}
-			/*
-			 * Blocks are going to be removed from the inode. Wait
-			 * for dio in flight.
-			 */
-			inode_dio_wait(inode);
 		}
 
 		down_write(&EXT4_I(inode)->i_mmap_sem);
@@ -5798,9 +5790,6 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (is_journal_aborted(journal))
 		return -EROFS;
 
-	/* Wait for all existing dio workers */
-	inode_dio_wait(inode);
-
 	/*
 	 * Before flushing the journal and switching inode's aops, we have
 	 * to flush all dirty data the inode has. There can be outstanding
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8870fff8224..99d21d81074f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -153,10 +153,6 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	if (err)
 		goto err_out;
 
-	/* Wait for all existing dio workers */
-	inode_dio_wait(inode);
-	inode_dio_wait(inode_bl);
-
 	truncate_inode_pages(&inode->i_data, 0);
 	truncate_inode_pages(&inode_bl->i_data, 0);
 
@@ -364,7 +360,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	 */
 	if (S_ISREG(inode->i_mode) && !IS_IMMUTABLE(inode) &&
 	    (flags & EXT4_IMMUTABLE_FL)) {
-		inode_dio_wait(inode);
 		err = filemap_write_and_wait(inode->i_mapping);
 		if (err)
 			goto flags_out;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 30ce3dc69378..20240808569f 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -602,10 +602,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	/* Protect orig and donor inodes against a truncate */
 	lock_two_nondirectories(orig_inode, donor_inode);
 
-	/* Wait for all existing dio workers */
-	inode_dio_wait(orig_inode);
-	inode_dio_wait(donor_inode);
-
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	/* Check the filesystem environment whether move_extent can be done */
-- 
2.24.1

