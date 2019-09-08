Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D458AD12B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfIHXUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:20:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45231 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbfIHXUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:20:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so7955482pfb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXe8GCRxPXTndFWuYeSWB+6dNeh/wQOQbmrtOTcAGj8=;
        b=aRUJnTyTOdGpYdf5q51USGqiRac27Am5gV26rMbNCYSAIEofNGYw+ppJ7JgtfVSmVQ
         ztBImzq2/yGgedfUuxMY6gq6ESOQmvgamcUnKbyJ2sCri3i2XyF0NL/wIbsIQ95veTzn
         foGGYLXsXaBb4LHv93dPscw5wG8ODcNXEEbRSycesEpQTM9uMGsz+QFnDjRt4hSR9HEf
         jyNl2lxUUS7iW/uwSBj3xczdXn2WVrkgL7s+B+wsdV55XSJ2NM9LS2RyD7Fzn4mf6u2O
         RcfZYE+aU2iEu+d2fB2fJDlEUy4DPQWAD+rasfTCggBB3wCtW3j2JUlXBNiuESTIOwIh
         xPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXe8GCRxPXTndFWuYeSWB+6dNeh/wQOQbmrtOTcAGj8=;
        b=LSOQwS+Y1xQL5kdA4frL0ngezRxMra2DxUlpzOp85ccFSAkOfxWQ1dVCWfzAFvQTUz
         Tp3zvezBD0AjMJV34ysFmktGEX8pzzJMZ8nrTtuB6w7EcvVpWvCEcn4ft7TzCcVw8m6d
         LlJNsEYOaFlGoJoxXE39Hbb6Q5ODmEKVXAhwuYJZMSwtLZCw4o8E4B26wy3h2CdXF2Qs
         EsdoR1VBvGsIT93jkyYF3jX8atITqmI+fgvOAf7iRiT2qlWrcxi8CvmGVOUmS8hAs2Q1
         OTLzkJn8LtnSMX5Q36ZeCcrfbSjXQaQxLDO2s5QH25CkT9Afo/pc5vwpIMHBJPpApKN4
         NSsQ==
X-Gm-Message-State: APjAAAVawl6iGF7Fsa+gbyTPDBR/K+sP8lolF7UsxCYWFFxEOwiC5KpQ
        6eQkfCaKUHiq/LkPXMlzCmbU
X-Google-Smtp-Source: APXvYqzmi1IdmMHCJgeLG02tJ2axSk8U5rWDzebNs1HQFVl16EVwRIpz++mi8+H0nuTzSFvxO2E52A==
X-Received: by 2002:a65:534c:: with SMTP id w12mr10249267pgr.51.1567984801761;
        Sun, 08 Sep 2019 16:20:01 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id z189sm13760624pfb.137.2019.09.08.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:20:01 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:19:55 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <7c2f0ee02b2659d5a45f3e30dbee66b443b5ea0a.1567978633.git.mbobrowski@mbobrowski.org>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567978633.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new direct IO write code path implementation
that makes use of the iomap infrastructure.

All direct IO write operations are now passed from the ->write_iter()
callback to the new function ext4_dio_write_iter(). This function is
responsible for calling into iomap infrastructure via
iomap_dio_rw(). Snippets of the direct IO code from within
ext4_file_write_iter(), such as checking whether the IO request is
unaligned asynchronous IO, or whether it will ber overwriting
allocated and initialized blocks has been moved out and into
ext4_dio_write_iter().

The block mapping flags that are passed to ext4_map_blocks() from
within ext4_dio_get_block() and friends have effectively been taken
out and introduced within the ext4_iomap_begin(). If ext4_map_blocks()
happens to have instantiated blocks beyond the i_size, then we attempt
to place the inode onto the orphan list. Despite being able to perform
i_size extension checking earlier on in the direct IO code path, it
makes most sense to perform this bit post successful block allocation.

The ->end_io() callback ext4_dio_write_end_io() is responsible for
removing the inode from the orphan list and determining if we should
truncate a failed write in the case of an error. We also convert a
range of unwritten extents to written if IOMAP_DIO_UNWRITTEN is set
and perform the necessary i_size/i_disksize extension if the
iocb->ki_pos + dio->size > i_size_read(inode).

In the instance of a short write, we fallback to buffered IO and
complete whatever is left the 'iter'. Any blocks that may have been
allocated in preparation for direct IO will be reused by buffered IO,
so there's no issue with leaving allocated blocks beyond EOF.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 219 +++++++++++++++++++++++++++++++++---------------
 fs/ext4/inode.c |  57 ++++++++++---
 2 files changed, 198 insertions(+), 78 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8e586198f6e6..bf22425a6a6f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagevec.h>
 #include <linux/uio.h>
 #include <linux/mman.h>
+#include <linux/backing-dev.h>
 #include "ext4.h"
 #include "ext4_jbd2.h"
 #include "xattr.h"
@@ -217,6 +218,14 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		return ret;
 
+	ret = file_remove_privs(iocb->ki_filp);
+	if (ret)
+		return 0;
+
+	ret = file_update_time(iocb->ki_filp);
+	if (ret)
+		return 0;
+
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
@@ -234,6 +243,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
+	if (!inode_trylock(inode))
+		inode_lock(inode);
+
+	ret = ext4_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	current->backing_dev_info = NULL;
+out:
+	inode_unlock(inode);
+	if (likely(ret > 0)) {
+		iocb->ki_pos += ret;
+		ret = generic_write_sync(iocb, ret);
+	}
+	return ret;
+}
+
 static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 				       ssize_t len, size_t count)
 {
@@ -311,6 +348,118 @@ static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
 	return ret;
 }
 
+/*
+ * For a write that extends the inode size, ext4_dio_write_iter() will
+ * wait for the write to complete. Consequently, operations performed
+ * within this function are still covered by the inode_lock().
+ */
+static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
+				 unsigned int flags)
+{
+	int ret = 0;
+	loff_t offset = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error) {
+		ret = ext4_handle_failed_inode_extension(inode, offset + size);
+		return ret ? ret : error;
+	}
+
+	if (flags & IOMAP_DIO_UNWRITTEN) {
+		ret = ext4_convert_unwritten_extents(NULL, inode,
+						     offset, size);
+		if (ret)
+			return ret;
+	}
+
+	if (offset + size > i_size_read(inode)) {
+		ret = ext4_handle_inode_extension(inode, offset, size, 0);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret;
+	loff_t offset = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	bool extend = false, overwrite = false, unaligned_aio = false;
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
+	if (!ext4_dio_checks(inode)) {
+		inode_unlock(inode);
+		/*
+		 * Fallback to buffered IO if the operation on the
+		 * inode is not supported by direct IO.
+		 */
+		return ext4_buffered_write_iter(iocb, from);
+	}
+
+	ret = ext4_write_checks(iocb, from);
+	if (ret <= 0) {
+		inode_unlock(inode);
+		return ret;
+	}
+
+	/*
+	 * Unaligned direct AIO must be serialized among each other as
+	 * the zeroing of partial blocks of two competing unaligned
+	 * AIOs can result in data corruption.
+	 */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
+		unaligned_aio = true;
+		inode_dio_wait(inode);
+	}
+
+	/*
+	 * Determine whether the IO operation will overwrite allocated
+	 * and initialized blocks. If so, check to see whether it is
+	 * possible to take the dioread_nolock path.
+	 */
+	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
+	    ext4_should_dioread_nolock(inode)) {
+		overwrite = true;
+		downgrade_write(&inode->i_rwsem);
+	}
+
+	if (offset + count > i_size_read(inode) ||
+	    offset + count > EXT4_I(inode)->i_disksize) {
+		ext4_update_i_disksize(inode, inode->i_size);
+		extend = true;
+	}
+
+	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
+
+	/*
+	 * Unaligned direct AIO must be the only IO in flight or else
+	 * any overlapping aligned IO after unaligned IO might result
+	 * in data corruption. We also need to wait here in the case
+	 * where the inode is being extended so that inode extension
+	 * routines in ext4_dio_write_end_io() are covered by the
+	 * inode_lock().
+	 */
+	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
+		inode_dio_wait(inode);
+
+	if (overwrite)
+		inode_unlock_shared(inode);
+	else
+		inode_unlock(inode);
+
+	if (ret >= 0 && iov_iter_count(from))
+		return ext4_buffered_write_iter(iocb, from);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -325,15 +474,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return -EAGAIN;
 		inode_lock(inode);
 	}
+
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
-	ret = file_remove_privs(iocb->ki_filp);
-	if (ret)
-		goto out;
-	ret = file_update_time(iocb->ki_filp);
-	if (ret)
-		goto out;
 
 	offset = iocb->ki_pos;
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
@@ -359,73 +503,16 @@ static ssize_t
 ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	int o_direct = iocb->ki_flags & IOCB_DIRECT;
-	int unaligned_aio = 0;
-	int overwrite = 0;
-	ssize_t ret;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-#ifdef CONFIG_FS_DAX
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
-#endif
-	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
-		return -EOPNOTSUPP;
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EAGAIN;
-		inode_lock(inode);
-	}
-
-	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0)
-		goto out;
-
-	/*
-	 * Unaligned direct AIO must be serialized among each other as zeroing
-	 * of partial blocks of two competing unaligned AIOs can result in data
-	 * corruption.
-	 */
-	if (o_direct && ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
-	    !is_sync_kiocb(iocb) &&
-	    ext4_unaligned_aio(inode, from, iocb->ki_pos)) {
-		unaligned_aio = 1;
-		ext4_unwritten_wait(inode);
-	}
-
-	iocb->private = &overwrite;
-	/* Check whether we do a DIO overwrite or not */
-	if (o_direct && !unaligned_aio) {
-		if (ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
-			if (ext4_should_dioread_nolock(inode))
-				overwrite = 1;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
-			goto out;
-		}
-	}
-
-	ret = __generic_file_write_iter(iocb, from);
-	/*
-	 * Unaligned direct AIO must be the only IO in flight. Otherwise
-	 * overlapping aligned IO after unaligned might result in data
-	 * corruption.
-	 */
-	if (ret == -EIOCBQUEUED && unaligned_aio)
-		ext4_unwritten_wait(inode);
-	inode_unlock(inode);
-
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
-
-	return ret;
-
-out:
-	inode_unlock(inode);
-	return ret;
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_write_iter(iocb, from);
+	return ext4_buffered_write_iter(iocb, from);
 }
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index efb184928e51..f52ad3065236 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3513,11 +3513,13 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			}
 		}
 	} else if (flags & IOMAP_WRITE) {
-		int dio_credits;
 		handle_t *handle;
-		int retries = 0;
+		int dio_credits, retries = 0, m_flags = 0;
 
-		/* Trim mapping request to maximum we can map at once for DIO */
+		/*
+		 * Trim mapping request to maximum we can map at once
+		 * for DIO.
+		 */
 		if (map.m_len > DIO_MAX_BLOCKS)
 			map.m_len = DIO_MAX_BLOCKS;
 		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
@@ -3533,8 +3535,30 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (IS_ERR(handle))
 			return PTR_ERR(handle);
 
-		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_CREATE_ZERO);
+		/*
+		 * DAX and direct IO are the only two operations that
+		 * are currently supported with IOMAP_WRITE.
+		 */
+		WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));
+		if (IS_DAX(inode))
+			m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
+		else if (round_down(offset, i_blocksize(inode)) >=
+			 i_size_read(inode))
+			m_flags = EXT4_GET_BLOCKS_CREATE;
+		else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
+
+		ret = ext4_map_blocks(handle, inode, &map, m_flags);
+
+		/*
+		 * We cannot fill holes in indirect tree based inodes
+		 * as that could expose stale data in the case of a
+		 * crash. Use the magic error code to fallback to
+		 * buffered IO.
+		 */
+		if (!m_flags && !ret)
+			ret = -ENOTBLK;
+
 		if (ret < 0) {
 			ext4_journal_stop(handle);
 			if (ret == -ENOSPC &&
@@ -3544,13 +3568,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 
 		/*
-		 * If we added blocks beyond i_size, we need to make sure they
-		 * will get truncated if we crash before updating i_size in
-		 * ext4_iomap_end(). For faults we don't need to do that (and
-		 * even cannot because for orphan list operations inode_lock is
-		 * required) - if we happen to instantiate block beyond i_size,
-		 * it is because we race with truncate which has already added
-		 * the inode to the orphan list.
+		 * If we added blocks beyond i_size, we need to make
+		 * sure they will get truncated if we crash before
+		 * updating the i_size. For faults we don't need to do
+		 * that (and even cannot because for orphan list
+		 * operations inode_lock is required) - if we happen
+		 * to instantiate block beyond i_size, it is because
+		 * we race with truncate which has already added the
+		 * inode to the orphan list.
 		 */
 		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
 		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
@@ -3612,6 +3637,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
+	/*
+	 * Check to see whether an error occurred while writing data
+	 * out to allocated blocks. If so, return the magic error code
+	 * so that we fallback to buffered IO and reuse the blocks
+	 * that were allocated in preparation for the direct IO write.
+	 */
+	if (flags & IOMAP_DIRECT && written == 0)
+		return -ENOTBLK;
 	return 0;
 }
 
-- 
2.20.1

