Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04E7C9D76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfJCLfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:35:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33873 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbfJCLfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:35:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so1397755pll.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfD5v888GD+Sq5U4ek2CGqmQ1Pqr1DB0VmP9ytubR/I=;
        b=x9E7MSjpOYw2E25cVPD4nQgZVZKLj9N7KacCWKGWvTHkSrlE6SzxH1eOh9tqo52t8m
         K6l4tPbZLgTjOA2Ujh3uaHS4WdN9Nopp2i4C1p3vufwcI3jQpByqBf0JlYKvDi6kR4th
         /ZhEWhkB1oSZdUbSgaVQGQqlyGKHi6PNBsotXhbFbR579dLZ0y/ZzAKCrSGjwzmH9ltz
         fxBSjOWUma4MPExHEwslje6x/U9GuD8WXEU8SI3zexuNZld9HyGdzfDc2Xk7hs++HOGu
         CvWVVIUoevDe4cn1C2XXfo3TDRDtw9NPq+U0VsOK+USjPI0ngTIfkfnON0LecG58TDAR
         FZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfD5v888GD+Sq5U4ek2CGqmQ1Pqr1DB0VmP9ytubR/I=;
        b=unxzmqoMA8pWkUfwUorCBCXv/zt8Hn48cI29uvhlDsiq8tLhrl8v+xFUFlfsvqrcJm
         JT3NtEPv14J/f2TuPyrx/0a/y1ZdEtDJ8X2EXD1hU4I2AvZ3ew/1+ODA/AX9vFiKjGMe
         2X6XYubZrCBy/NrbZHAnLrptZCLpbiWzau8pfP8J/ZxTKHyzExA3HKvk3oLV7Oj5cJ1o
         uEXEVUAwq3yH5Kz6kZ4yEO3aEL+b3jKackMd4WVB9iUnVq864h/fVS3237MYYgtUVxWS
         cXZkFl262p+7mQ7r7TiMVLOiLz5d59OV1DG1Me8QSFqUOO1mMRuqAFyNkFre6KxC+yqv
         i1Xw==
X-Gm-Message-State: APjAAAXpVaFU6k+dO3xhqYo32Y0vL5n0NcsKF1ZiJrVVqZlMlOUdpTeD
        1RPK76gA3RebbxkjL78WmSNm0kaIgu5l
X-Google-Smtp-Source: APXvYqzIL8ByBJR0ey0mo1x2rzia8X9BsR+pxy5TtXuS1oOlstZJW2WPcnBXkeYLRL9BPrfzEo/zSg==
X-Received: by 2002:a17:902:7409:: with SMTP id g9mr9450245pll.59.1570102512566;
        Thu, 03 Oct 2019 04:35:12 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id r24sm2726879pfh.69.2019.10.03.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:35:11 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:35:05 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 8/8] ext4: introduce direct I/O write path using iomap
 infrastructure
Message-ID: <9ef408b4079d438c0e6071b862c56fc8b65c3451.1570100361.git.mbobrowski@mbobrowski.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new direct I/O write code path implementation
that makes use of the iomap infrastructure.

All direct I/O write operations are now passed from the ->write_iter()
callback to the new function ext4_dio_write_iter(). This function is
responsible for calling into iomap infrastructure via
iomap_dio_rw(). Snippets of the direct I/O code from within
ext4_file_write_iter(), such as checking whether the IO request is
unaligned asynchronous I/O, or whether it will ber overwriting
allocated and initialized blocks has been moved out and into
ext4_dio_write_iter().

The block mapping flags that are passed to ext4_map_blocks() from
within ext4_dio_get_block() and friends have effectively been taken
out and introduced within the ext4_iomap_alloc().

For inode extension cases, the ->end_io() callback
ext4_dio_write_end_io() is responsible for calling into
ext4_handle_inode_extension() and performing the necessary metadata
updates. Failed writes that we're intended to be extend the inode will
have blocks truncated accordingly. The ->end_io() handler is also
responsible for converting allocated unwritten extents to written
extents.

In the instance of a short write, we fallback to buffered I/O and use
that method to complete whatever is left over in 'iter'. Any blocks
that have been allocated in preparation for direct I/O write will be
reused by buffered I/O, so there's no issue with leaving allocated
blocks beyond EOF.

Existing direct I/O write buffer_head code has been removed as it's
now redundant.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/ext4.h    |   3 -
 fs/ext4/extents.c |  11 +-
 fs/ext4/file.c    | 245 ++++++++++++++++++---------
 fs/ext4/inode.c   | 411 +++++-----------------------------------------
 4 files changed, 214 insertions(+), 456 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d0d88f411a44..fdab3420539d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1579,7 +1579,6 @@ enum {
 	EXT4_STATE_NO_EXPAND,		/* No space for expansion */
 	EXT4_STATE_DA_ALLOC_CLOSE,	/* Alloc DA blks on close */
 	EXT4_STATE_EXT_MIGRATE,		/* Inode is migrating */
-	EXT4_STATE_DIO_UNWRITTEN,	/* need convert on dio done*/
 	EXT4_STATE_NEWENTRY,		/* File just added to dir */
 	EXT4_STATE_MAY_INLINE_DATA,	/* may have in-inode data */
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
@@ -2560,8 +2559,6 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 			     struct buffer_head *bh_result, int create);
 int ext4_get_block(struct inode *inode, sector_t iblock,
 		   struct buffer_head *bh_result, int create);
-int ext4_dio_get_block(struct inode *inode, sector_t iblock,
-		       struct buffer_head *bh_result, int create);
 int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create);
 int ext4_walk_page_buffers(handle_t *handle,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fb0f99dc8c22..df0629de3667 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1753,16 +1753,9 @@ ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent *ex1,
 	 */
 	if (ext1_ee_len + ext2_ee_len > EXT_INIT_MAX_LEN)
 		return 0;
-	/*
-	 * The check for IO to unwritten extent is somewhat racy as we
-	 * increment i_unwritten / set EXT4_STATE_DIO_UNWRITTEN only after
-	 * dropping i_data_sem. But reserved blocks should save us in that
-	 * case.
-	 */
+
 	if (ext4_ext_is_unwritten(ex1) &&
-	    (ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) ||
-	     atomic_read(&EXT4_I(inode)->i_unwritten) ||
-	     (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)))
+	    ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)
 		return 0;
 #ifdef AGGRESSIVE_TEST
 	if (ext1_ee_len >= 4)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f64da0c590b2..a6ad747709cf 100644
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
@@ -154,13 +155,6 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static void ext4_unwritten_wait(struct inode *inode)
-{
-	wait_queue_head_t *wq = ext4_ioend_wq(inode);
-
-	wait_event(*wq, (atomic_read(&EXT4_I(inode)->i_unwritten) == 0));
-}
-
 /*
  * This tests whether the IO in question is block-aligned or not.
  * Ext4 utilizes unwritten extents when hole-filling during direct IO, and they
@@ -213,13 +207,13 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
 		return ret;
 
-	if (unlikely(IS_IMMUTABLE(inode)))
-		return -EPERM;
-
 	/*
 	 * If we have encountered a bitmap-format file, the size limit
 	 * is smaller than s_maxbytes, which is for extent-mapped files.
@@ -231,9 +225,39 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 			return -EFBIG;
 		iov_iter_truncate(from, sbi->s_bitmap_maxbytes - iocb->ki_pos);
 	}
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		return ret;
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
+	inode_lock(inode);
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
 				       ssize_t written, size_t count)
 {
@@ -301,34 +325,77 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-#ifdef CONFIG_FS_DAX
-static ssize_t
-ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
+				 int error, unsigned int flags)
+{
+	loff_t offset = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!error && (flags & IOMAP_DIO_UNWRITTEN))
+		error = ext4_convert_unwritten_extents(NULL, inode, offset,
+						       size);
+	return ext4_handle_inode_extension(inode, offset, error ? : size,
+					   size);
+}
+
+static const struct iomap_dio_ops ext4_dio_write_ops = {
+	.end_io =	ext4_dio_write_end_io,
+};
+
+static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	int error;
 	ssize_t ret;
 	size_t count;
 	loff_t offset;
 	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	bool extend = false, overwrite = false, unaligned_aio = false;
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		inode_lock(inode);
 	}
+
+	if (!ext4_dio_supported(inode)) {
+		inode_unlock(inode);
+		/*
+		 * Fallback to buffered I/O if the operation on the
+		 * inode is not supported by direct I/O.
+		 */
+		return ext4_buffered_write_iter(iocb, from);
+	}
+
 	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0)
-		goto out;
-	ret = file_remove_privs(iocb->ki_filp);
-	if (ret)
-		goto out;
-	ret = file_update_time(iocb->ki_filp);
-	if (ret)
-		goto out;
+	if (ret <= 0) {
+		inode_unlock(inode);
+		return ret;
+	}
 
+	/*
+	 * Unaligned direct asynchronous I/O must be serialized among
+	 * each other as the zeroing of partial blocks of two
+	 * competing unaligned asynchronous I/O writes can result in
+	 * data corruption.
+	 */
 	offset = iocb->ki_pos;
 	count = iov_iter_count(from);
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
+		unaligned_aio = true;
+		inode_dio_wait(inode);
+	}
+
+	/*
+	 * Determine whether the I/O will overwrite allocated and
+	 * initialized blocks. If so, check to see whether it is
+	 * possible to take the dioread_nolock path.
+	 */
+	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
+	    ext4_should_dioread_nolock(inode)) {
+		overwrite = true;
+		downgrade_write(&inode->i_rwsem);
+	}
 
 	if (offset + count > EXT4_I(inode)->i_disksize) {
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
@@ -342,38 +409,64 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ext4_journal_stop(handle);
 			goto out;
 		}
+
+		extend = true;
 		ext4_journal_stop(handle);
 	}
 
-	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops);
 
-	error = ext4_handle_inode_extension(inode, offset, ret, count);
-	if (error)
-		ret = error;
+	/*
+	 * Unaligned direct asynchronous I/O must be the only I/O in
+	 * flight or else any overlapping aligned I/O after unaligned
+	 * I/O might result in data corruption. We also need to wait
+	 * here in the case where the inode is being extended so that
+	 * inode extension routines in the ->end_io handler are
+	 * covered by the inode_lock().
+	 */
+	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
+		inode_dio_wait(inode);
+
+	/*
+	 * The ->end_io handler may have failed to remove the inode
+	 * from the orphan list in the case that the i_disksize got
+	 * updated due to a delalloc writeback while the direct I/O
+	 * was running.
+	 */
+	if (extend && !list_empty(&EXT4_I(inode)->i_orphan)) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			if (inode->i_nlink)
+				ext4_orphan_del(NULL, inode);
+			goto out;
+		}
+
+		if (inode->i_nlink)
+			ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
 out:
-	inode_unlock(inode);
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
+	if (overwrite)
+		inode_unlock_shared(inode);
+	else
+		inode_unlock(inode);
+
+	if (ret >= 0 && iov_iter_count(from))
+		return ext4_buffered_write_iter(iocb, from);
 	return ret;
 }
-#endif
 
+#ifdef CONFIG_FS_DAX
 static ssize_t
-ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
-	int o_direct = iocb->ki_flags & IOCB_DIRECT;
-	int unaligned_aio = 0;
-	int overwrite = 0;
+	int error;
 	ssize_t ret;
-
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
-		return -EIO;
-
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(inode))
-		return ext4_dax_write_iter(iocb, from);
-#endif
+	size_t count;
+	loff_t offset;
+	handle_t *handle;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -385,48 +478,50 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		goto out;
 
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
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
+	if (offset + count > EXT4_I(inode)->i_disksize) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
 
-	iocb->private = &overwrite;
-	/* Check whether we do a DIO overwrite or not */
-	if (o_direct && !unaligned_aio) {
-		if (ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
-			if (ext4_should_dioread_nolock(inode))
-				overwrite = 1;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
+		ret = ext4_orphan_add(handle, inode);
+		if (ret) {
+			ext4_journal_stop(handle);
 			goto out;
 		}
+		ext4_journal_stop(handle);
 	}
 
-	ret = __generic_file_write_iter(iocb, from);
-	/*
-	 * Unaligned direct AIO must be the only IO in flight. Otherwise
-	 * overlapping aligned IO after unaligned might result in data
-	 * corruption.
-	 */
-	if (ret == -EIOCBQUEUED && unaligned_aio)
-		ext4_unwritten_wait(inode);
-	inode_unlock(inode);
+	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
+	error = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (error)
+		ret = error;
+out:
+	inode_unlock(inode);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
-
 	return ret;
+}
+#endif
 
-out:
-	inode_unlock(inode);
-	return ret;
+static ssize_t
+ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+		return -EIO;
+
+	if (IS_DAX(inode))
+		return ext4_dax_write_iter(iocb, from);
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_write_iter(iocb, from);
+	return ext4_buffered_write_iter(iocb, from);
 }
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 63ad23ae05b8..83c5daf7e0c4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -826,133 +826,6 @@ int ext4_get_block_unwritten(struct inode *inode, sector_t iblock,
 /* Maximum number of blocks we map for direct IO at once. */
 #define DIO_MAX_BLOCKS 4096
 
-/*
- * Get blocks function for the cases that need to start a transaction -
- * generally difference cases of direct IO and DAX IO. It also handles retries
- * in case of ENOSPC.
- */
-static int ext4_get_block_trans(struct inode *inode, sector_t iblock,
-				struct buffer_head *bh_result, int flags)
-{
-	int dio_credits;
-	handle_t *handle;
-	int retries = 0;
-	int ret;
-
-	/* Trim mapping request to maximum we can map at once for DIO */
-	if (bh_result->b_size >> inode->i_blkbits > DIO_MAX_BLOCKS)
-		bh_result->b_size = DIO_MAX_BLOCKS << inode->i_blkbits;
-	dio_credits = ext4_chunk_trans_blocks(inode,
-				      bh_result->b_size >> inode->i_blkbits);
-retry:
-	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
-
-	ret = _ext4_get_block(inode, iblock, bh_result, flags);
-	ext4_journal_stop(handle);
-
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
-		goto retry;
-	return ret;
-}
-
-/* Get block function for DIO reads and writes to inodes without extents */
-int ext4_dio_get_block(struct inode *inode, sector_t iblock,
-		       struct buffer_head *bh, int create)
-{
-	/* We don't expect handle for direct IO */
-	WARN_ON_ONCE(ext4_journal_current_handle());
-	return ext4_get_block_trans(inode, iblock, bh, EXT4_GET_BLOCKS_CREATE);
-}
-
-/*
- * Get block function for AIO DIO writes when we create unwritten extent if
- * blocks are not allocated yet. The extent will be converted to written
- * after IO is complete.
- */
-static int ext4_dio_get_block_unwritten_async(struct inode *inode,
-		sector_t iblock, struct buffer_head *bh_result,	int create)
-{
-	int ret;
-
-	/* We don't expect handle for direct IO */
-	WARN_ON_ONCE(ext4_journal_current_handle());
-
-	ret = ext4_get_block_trans(inode, iblock, bh_result,
-				   EXT4_GET_BLOCKS_IO_CREATE_EXT);
-
-	/*
-	 * When doing DIO using unwritten extents, we need io_end to convert
-	 * unwritten extents to written on IO completion. We allocate io_end
-	 * once we spot unwritten extent and store it in b_private. Generic
-	 * DIO code keeps b_private set and furthermore passes the value to
-	 * our completion callback in 'private' argument.
-	 */
-	if (!ret && buffer_unwritten(bh_result)) {
-		if (!bh_result->b_private) {
-			ext4_io_end_t *io_end;
-
-			io_end = ext4_init_io_end(inode, GFP_KERNEL);
-			if (!io_end)
-				return -ENOMEM;
-			bh_result->b_private = io_end;
-			ext4_set_io_unwritten_flag(inode, io_end);
-		}
-		set_buffer_defer_completion(bh_result);
-	}
-
-	return ret;
-}
-
-/*
- * Get block function for non-AIO DIO writes when we create unwritten extent if
- * blocks are not allocated yet. The extent will be converted to written
- * after IO is complete by ext4_direct_IO_write().
- */
-static int ext4_dio_get_block_unwritten_sync(struct inode *inode,
-		sector_t iblock, struct buffer_head *bh_result,	int create)
-{
-	int ret;
-
-	/* We don't expect handle for direct IO */
-	WARN_ON_ONCE(ext4_journal_current_handle());
-
-	ret = ext4_get_block_trans(inode, iblock, bh_result,
-				   EXT4_GET_BLOCKS_IO_CREATE_EXT);
-
-	/*
-	 * Mark inode as having pending DIO writes to unwritten extents.
-	 * ext4_direct_IO_write() checks this flag and converts extents to
-	 * written.
-	 */
-	if (!ret && buffer_unwritten(bh_result))
-		ext4_set_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
-
-	return ret;
-}
-
-static int ext4_dio_get_block_overwrite(struct inode *inode, sector_t iblock,
-		   struct buffer_head *bh_result, int create)
-{
-	int ret;
-
-	ext4_debug("ext4_dio_get_block_overwrite: inode %lu, create flag %d\n",
-		   inode->i_ino, create);
-	/* We don't expect handle for direct IO */
-	WARN_ON_ONCE(ext4_journal_current_handle());
-
-	ret = _ext4_get_block(inode, iblock, bh_result, 0);
-	/*
-	 * Blocks should have been preallocated! ext4_file_write_iter() checks
-	 * that.
-	 */
-	WARN_ON_ONCE(!buffer_mapped(bh_result) || buffer_unwritten(bh_result));
-
-	return ret;
-}
-
-
 /*
  * `handle' can be NULL if create is zero
  */
@@ -3518,7 +3391,8 @@ static int ext4_iomap_alloc(struct inode *inode,
 			    struct ext4_map_blocks *map)
 {
 	handle_t *handle;
-	int ret, dio_credits, retries = 0;
+	u8 blkbits = inode->i_blkbits;
+	int ret, dio_credits, m_flags = 0, retries = 0;
 
 	/*
 	 * Trim mapping request to the maximum value that we can map
@@ -3538,7 +3412,34 @@ static int ext4_iomap_alloc(struct inode *inode,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
+	/*
+	 * DAX and direct I/O are the only two operations that are
+	 * currently supported with IOMAP_WRITE.
+	 */
+	WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));
+	if (IS_DAX(inode))
+		m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
+	/*
+	 * We use i_size instead of i_disksize here because delalloc
+	 * writeback can complete at any point and subsequently push
+	 * the i_disksize out to i_size. This could be beyond where
+	 * the direct I/O is happening and thus expose allocated
+	 * blocks to direct I/O reads.
+	 */
+	else if ((first_block * (1 << blkbits)) >= i_size_read(inode))
+		m_flags = EXT4_GET_BLOCKS_CREATE;
+	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
+
+	ret = ext4_map_blocks(handle, inode, map, m_flags);
+
+	/*
+	 * We cannot fill holes in indirect tree based inodes as that
+	 * could expose stale data in the case of a crash. Use the
+	 * magic error code to fallback to buffered I/O.
+	 */
+	if (!m_flags && !ret)
+		ret = -ENOTBLK;
 
 	ext4_journal_stop(handle);
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
@@ -3580,6 +3481,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
+	/*
+	 * Check to see whether an error occurred while writing out
+	 * data to the allocated blocks. If so, return the magic error
+	 * code so that we fallback to buffered I/O. Any blocks that
+	 * have been allocated in preparation for the direct I/O write
+	 * will be reused during buffered I/O.
+	 */
+	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+		return -ENOTBLK;
 	return 0;
 }
 
@@ -3588,243 +3498,6 @@ const struct iomap_ops ext4_iomap_ops = {
 	.iomap_end		= ext4_iomap_end,
 };
 
-static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
-			    ssize_t size, void *private)
-{
-        ext4_io_end_t *io_end = private;
-
-	/* if not async direct IO just return */
-	if (!io_end)
-		return 0;
-
-	ext_debug("ext4_end_io_dio(): io_end 0x%p "
-		  "for inode %lu, iocb 0x%p, offset %llu, size %zd\n",
-		  io_end, io_end->inode->i_ino, iocb, offset, size);
-
-	/*
-	 * Error during AIO DIO. We cannot convert unwritten extents as the
-	 * data was not written. Just clear the unwritten flag and drop io_end.
-	 */
-	if (size <= 0) {
-		ext4_clear_io_unwritten_flag(io_end);
-		size = 0;
-	}
-	io_end->offset = offset;
-	io_end->size = size;
-	ext4_put_io_end(io_end);
-
-	return 0;
-}
-
-/*
- * Handling of direct IO writes.
- *
- * For ext4 extent files, ext4 will do direct-io write even to holes,
- * preallocated extents, and those write extend the file, no need to
- * fall back to buffered IO.
- *
- * For holes, we fallocate those blocks, mark them as unwritten
- * If those blocks were preallocated, we mark sure they are split, but
- * still keep the range to write as unwritten.
- *
- * The unwritten extents will be converted to written when DIO is completed.
- * For async direct IO, since the IO may still pending when return, we
- * set up an end_io call back function, which will do the conversion
- * when async direct IO completed.
- *
- * If the O_DIRECT write will extend the file then add this inode to the
- * orphan list.  So recovery will truncate it back to the original size
- * if the machine crashes during the write.
- *
- */
-static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	ssize_t ret;
-	loff_t offset = iocb->ki_pos;
-	size_t count = iov_iter_count(iter);
-	int overwrite = 0;
-	get_block_t *get_block_func = NULL;
-	int dio_flags = 0;
-	loff_t final_size = offset + count;
-	int orphan = 0;
-	handle_t *handle;
-
-	if (final_size > inode->i_size || final_size > ei->i_disksize) {
-		/* Credits for sb + inode write */
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
-			goto out;
-		}
-		ret = ext4_orphan_add(handle, inode);
-		if (ret) {
-			ext4_journal_stop(handle);
-			goto out;
-		}
-		orphan = 1;
-		ext4_update_i_disksize(inode, inode->i_size);
-		ext4_journal_stop(handle);
-	}
-
-	BUG_ON(iocb->private == NULL);
-
-	/*
-	 * Make all waiters for direct IO properly wait also for extent
-	 * conversion. This also disallows race between truncate() and
-	 * overwrite DIO as i_dio_count needs to be incremented under i_mutex.
-	 */
-	inode_dio_begin(inode);
-
-	/* If we do a overwrite dio, i_mutex locking can be released */
-	overwrite = *((int *)iocb->private);
-
-	if (overwrite)
-		inode_unlock(inode);
-
-	/*
-	 * For extent mapped files we could direct write to holes and fallocate.
-	 *
-	 * Allocated blocks to fill the hole are marked as unwritten to prevent
-	 * parallel buffered read to expose the stale data before DIO complete
-	 * the data IO.
-	 *
-	 * As to previously fallocated extents, ext4 get_block will just simply
-	 * mark the buffer mapped but still keep the extents unwritten.
-	 *
-	 * For non AIO case, we will convert those unwritten extents to written
-	 * after return back from blockdev_direct_IO. That way we save us from
-	 * allocating io_end structure and also the overhead of offloading
-	 * the extent convertion to a workqueue.
-	 *
-	 * For async DIO, the conversion needs to be deferred when the
-	 * IO is completed. The ext4 end_io callback function will be
-	 * called to take care of the conversion work.  Here for async
-	 * case, we allocate an io_end structure to hook to the iocb.
-	 */
-	iocb->private = NULL;
-	if (overwrite)
-		get_block_func = ext4_dio_get_block_overwrite;
-	else if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) ||
-		   round_down(offset, i_blocksize(inode)) >= inode->i_size) {
-		get_block_func = ext4_dio_get_block;
-		dio_flags = DIO_LOCKING | DIO_SKIP_HOLES;
-	} else if (is_sync_kiocb(iocb)) {
-		get_block_func = ext4_dio_get_block_unwritten_sync;
-		dio_flags = DIO_LOCKING;
-	} else {
-		get_block_func = ext4_dio_get_block_unwritten_async;
-		dio_flags = DIO_LOCKING;
-	}
-	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
-				   get_block_func, ext4_end_io_dio, NULL,
-				   dio_flags);
-
-	if (ret > 0 && !overwrite && ext4_test_inode_state(inode,
-						EXT4_STATE_DIO_UNWRITTEN)) {
-		int err;
-		/*
-		 * for non AIO case, since the IO is already
-		 * completed, we could do the conversion right here
-		 */
-		err = ext4_convert_unwritten_extents(NULL, inode,
-						     offset, ret);
-		if (err < 0)
-			ret = err;
-		ext4_clear_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN);
-	}
-
-	inode_dio_end(inode);
-	/* take i_mutex locking again if we do a ovewrite dio */
-	if (overwrite)
-		inode_lock(inode);
-
-	if (ret < 0 && final_size > inode->i_size)
-		ext4_truncate_failed_write(inode);
-
-	/* Handle extending of i_size after direct IO write */
-	if (orphan) {
-		int err;
-
-		/* Credits for sb + inode write */
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle)) {
-			/*
-			 * We wrote the data but cannot extend
-			 * i_size. Bail out. In async io case, we do
-			 * not return error here because we have
-			 * already submmitted the corresponding
-			 * bio. Returning error here makes the caller
-			 * think that this IO is done and failed
-			 * resulting in race with bio's completion
-			 * handler.
-			 */
-			if (!ret)
-				ret = PTR_ERR(handle);
-			if (inode->i_nlink)
-				ext4_orphan_del(NULL, inode);
-
-			goto out;
-		}
-		if (inode->i_nlink)
-			ext4_orphan_del(handle, inode);
-		if (ret > 0) {
-			loff_t end = offset + ret;
-			if (end > inode->i_size || end > ei->i_disksize) {
-				ext4_update_i_disksize(inode, end);
-				if (end > inode->i_size)
-					i_size_write(inode, end);
-				/*
-				 * We're going to return a positive `ret'
-				 * here due to non-zero-length I/O, so there's
-				 * no way of reporting error returns from
-				 * ext4_mark_inode_dirty() to userspace.  So
-				 * ignore it.
-				 */
-				ext4_mark_inode_dirty(handle, inode);
-			}
-		}
-		err = ext4_journal_stop(handle);
-		if (ret == 0)
-			ret = err;
-	}
-out:
-	return ret;
-}
-
-static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	size_t count = iov_iter_count(iter);
-	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
-
-#ifdef CONFIG_FS_ENCRYPTION
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
-		return 0;
-#endif
-	if (fsverity_active(inode))
-		return 0;
-
-	/*
-	 * If we are doing data journalling we don't support O_DIRECT
-	 */
-	if (ext4_should_journal_data(inode))
-		return 0;
-
-	/* Let buffer I/O handle the inline data case. */
-	if (ext4_has_inline_data(inode))
-		return 0;
-
-	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
-	ret = ext4_direct_IO_write(iocb, iter);
-	trace_ext4_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), ret);
-	return ret;
-}
-
 /*
  * Pages can be marked dirty completely asynchronously from ext4's journalling
  * activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.  We cannot do
@@ -3862,7 +3535,7 @@ static const struct address_space_operations ext4_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= ext4_direct_IO,
+	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
@@ -3879,7 +3552,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_journalled_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= ext4_direct_IO,
+	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 };
@@ -3895,7 +3568,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= ext4_direct_IO,
+	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
-- 
2.20.1

