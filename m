Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A737235C3D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbhDLKYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 06:24:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238685AbhDLKX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07EC7B15B;
        Mon, 12 Apr 2021 10:23:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A90261F2B67; Mon, 12 Apr 2021 12:23:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Whitney <enwlinux@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext4: Fix occasional generic/418 failure
Date:   Mon, 12 Apr 2021 12:23:32 +0200
Message-Id: <20210412102333.2676-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412102333.2676-1-jack@suse.cz>
References: <20210412102333.2676-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric has noticed that after pagecache read rework, generic/418 is
occasionally failing for ext4 when blocksize < pagesize. In fact, the
pagecache rework just made hard to hit race in ext4 more likely. The
problem is that since ext4 conversion of direct IO writes to iomap
framework (commit 378f32bab371), we update inode size after direct IO
write only after invalidating page cache. Thus if buffered read sneaks
at unfortunate moment like:

CPU1 - write at offset 1k                       CPU2 - read from offset 0
iomap_dio_rw(..., IOMAP_DIO_FORCE_WAIT);
                                                ext4_readpage();
ext4_handle_inode_extension()

the read will zero out tail of the page as it still sees smaller inode
size and thus page cache becomes inconsistent with on-disk contents with
all the consequences.

Fix the problem by moving inode size update into end_io handler which
gets called before the page cache is invalidated.

Reported-by: Eric Whitney <enwlinux@gmail.com>
Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 185 ++++++++++++++++++++++++++-----------------------
 1 file changed, 99 insertions(+), 86 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2505313d96b0..ec59ea078f53 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -280,11 +280,67 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static int ext4_prepare_dio_extend(struct inode *inode)
+{
+	handle_t *handle;
+	int ret;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ext4_fc_start_update(inode);
+	ret = ext4_orphan_add(handle, inode);
+	ext4_fc_stop_update(inode);
+	if (ret) {
+		ext4_journal_stop(handle);
+		return ret;
+	}
+	ext4_journal_stop(handle);
+	return 0;
+}
+
+static void ext4_cleanup_dio_extend(struct inode *inode, loff_t offset,
+				    ssize_t written, size_t count)
+{
+	handle_t *handle;
+	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t written_blk, end_blk;
+
+	written_blk = ALIGN(offset + written, 1 << blkbits);
+	end_blk = ALIGN(offset + count, 1 << blkbits);
+	if (written_blk < end_blk && ext4_can_truncate(inode)) {
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If the truncate operation failed early, then the inode may
+		 * still be on the orphan list. In that case, we need to try
+		 * remove the inode from the in-memory linked list.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+		return;
+	}
+
+	/*
+	 * We need to ensure that the inode is removed from the orphan
+	 * list if it has been added prematurely, due to writeback of
+	 * delalloc blocks.
+	 */
+	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ext4_orphan_del(NULL, inode);
+			return;
+		}
+		ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
+}
+
 static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 					   ssize_t written, size_t count)
 {
 	handle_t *handle;
-	bool truncate = false;
 	u8 blkbits = inode->i_blkbits;
 	ext4_lblk_t written_blk, end_blk;
 	int ret;
@@ -298,73 +354,31 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 	 * as much as we intended.
 	 */
 	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
-	if (offset + count <= EXT4_I(inode)->i_disksize) {
-		/*
-		 * We need to ensure that the inode is removed from the orphan
-		 * list if it has been added prematurely, due to writeback of
-		 * delalloc blocks.
-		 */
-		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
-			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-
-			if (IS_ERR(handle)) {
-				ext4_orphan_del(NULL, inode);
-				return PTR_ERR(handle);
-			}
-
-			ext4_orphan_del(handle, inode);
-			ext4_journal_stop(handle);
-		}
-
+	if (offset + count <= EXT4_I(inode)->i_disksize)
 		return written;
-	}
-
-	if (written < 0)
-		goto truncate;
 
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-	if (IS_ERR(handle)) {
-		written = PTR_ERR(handle);
-		goto truncate;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
 	if (ext4_update_inode_size(inode, offset + written)) {
 		ret = ext4_mark_inode_dirty(handle, inode);
 		if (unlikely(ret)) {
-			written = ret;
 			ext4_journal_stop(handle);
-			goto truncate;
+			return ret;
 		}
 	}
 
 	/*
-	 * We may need to truncate allocated but not written blocks beyond EOF.
+	 * If there cannot be allocated but unused blocks beyond EOF, remove
+	 * the inode from the orphan list as we are done with it.
 	 */
 	written_blk = ALIGN(offset + written, 1 << blkbits);
 	end_blk = ALIGN(offset + count, 1 << blkbits);
-	if (written_blk < end_blk && ext4_can_truncate(inode))
-		truncate = true;
-
-	/*
-	 * Remove the inode from the orphan list if it has been extended and
-	 * everything went OK.
-	 */
-	if (!truncate && inode->i_nlink)
+	if (written_blk == end_blk && inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 	ext4_journal_stop(handle);
 
-	if (truncate) {
-truncate:
-		ext4_truncate_failed_write(inode);
-		/*
-		 * If the truncate operation failed early, then the inode may
-		 * still be on the orphan list. In that case, we need to try
-		 * remove the inode from the in-memory linked list.
-		 */
-		if (inode->i_nlink)
-			ext4_orphan_del(NULL, inode);
-	}
-
 	return written;
 }
 
@@ -385,10 +399,28 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	return 0;
 }
 
+static int ext4_dio_extending_write_end_io(struct kiocb *iocb, ssize_t size,
+					   ssize_t orig_size, int error,
+					   unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	int ret;
+
+	ret = ext4_dio_write_end_io(iocb, size, orig_size, error, flags);
+	if (ret < 0)
+		return ret;
+	return ext4_handle_inode_extension(inode, iocb->ki_pos, size,
+					   orig_size);
+}
+
 static const struct iomap_dio_ops ext4_dio_write_ops = {
 	.end_io = ext4_dio_write_end_io,
 };
 
+static const struct iomap_dio_ops ext4_dio_extending_write_ops = {
+	.end_io = ext4_dio_extending_write_end_io,
+};
+
 /*
  * The intention here is to start with shared lock acquired then see if any
  * condition requires an exclusive inode lock. If yes, then we restart the
@@ -455,11 +487,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t ret;
-	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
+	const struct iomap_dio_ops *dio_ops = &ext4_dio_write_ops;
 	bool extend = false, unaligned_io = false;
 	bool ilock_shared = true;
 
@@ -530,33 +562,21 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_dio_wait(inode);
 
 	if (extend) {
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
+		ret = ext4_prepare_dio_extend(inode);
+		if (ret)
 			goto out;
-		}
-
-		ext4_fc_start_update(inode);
-		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
-		if (ret) {
-			ext4_journal_stop(handle);
-			goto out;
-		}
-
-		ext4_journal_stop(handle);
 	}
 
 	if (ilock_shared)
 		iomap_ops = &ext4_iomap_overwrite_ops;
-	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0);
-	if (ret == -ENOTBLK)
-		ret = 0;
-
 	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+		dio_ops = &ext4_dio_extending_write_ops;
 
+	ret = iomap_dio_rw(iocb, from, iomap_ops, dio_ops,
+			   (extend || unaligned_io) ? IOMAP_DIO_FORCE_WAIT : 0);
+	if (ret == -ENOTBLK)
+		ret = 0;
+	ext4_cleanup_dio_extend(inode, offset, ret, count);
 out:
 	if (ilock_shared)
 		inode_unlock_shared(inode);
@@ -599,7 +619,6 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	size_t count;
 	loff_t offset;
-	handle_t *handle;
 	bool extend = false;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
@@ -618,26 +637,20 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	count = iov_iter_count(from);
 
 	if (offset + count > EXT4_I(inode)->i_disksize) {
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
-			goto out;
-		}
-
-		ret = ext4_orphan_add(handle, inode);
-		if (ret) {
-			ext4_journal_stop(handle);
+		ret = ext4_prepare_dio_extend(inode);
+		if (ret < 0)
 			goto out;
-		}
-
 		extend = true;
-		ext4_journal_stop(handle);
 	}
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
-	if (extend)
-		ret = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (extend) {
+		if (ret > 0)
+			ret = ext4_handle_inode_extension(inode, offset, ret,
+							  count);
+		ext4_cleanup_dio_extend(inode, offset, ret, count);
+	}
 out:
 	inode_unlock(inode);
 	if (ret > 0)
-- 
2.26.2

