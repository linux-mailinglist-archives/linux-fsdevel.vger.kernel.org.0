Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD10C25D415
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgIDI7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 04:59:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbgIDI67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79CF2AFC6;
        Fri,  4 Sep 2020 08:58:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0C6B1E12D9; Fri,  4 Sep 2020 10:58:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        yebin <yebin10@huawei.com>, Andreas Dilger <adilger@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] block: Do not discard buffers under a mounted filesystem
Date:   Fri,  4 Sep 2020 10:58:52 +0200
Message-Id: <20200904085852.5639-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200904085852.5639-1-jack@suse.cz>
References: <20200904085852.5639-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Discarding blocks and buffers under a mounted filesystem is hardly
anything admin wants to do. Usually it will confuse the filesystem and
sometimes the loss of buffer_head state (including b_private field) can
even cause crashes like:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 4 PID: 203778 Comm: jbd2/dm-3-8 Kdump: loaded Tainted: G O     --------- -  - 4.18.0-147.5.0.5.h126.eulerosv2r9.x86_64 #1
Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 1.57 08/11/2015
RIP: 0010:jbd2_journal_grab_journal_head+0x1b/0x40 [jbd2]
...
Call Trace:
 __jbd2_journal_insert_checkpoint+0x23/0x70 [jbd2]
 jbd2_journal_commit_transaction+0x155f/0x1b60 [jbd2]
 kjournald2+0xbd/0x270 [jbd2]

So if we don't have block device open with O_EXCL already, claim the
block device while we truncate buffer cache. This makes sure any
exclusive block device user (such as filesystem) cannot operate on the
device while we are discarding buffer cache.

Reported-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c          | 16 ++++++++++------
 fs/block_dev.c         | 37 +++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  7 +++++++
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index bdb3bbb253d9..ae74d0409afa 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -112,8 +112,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	uint64_t range[2];
 	uint64_t start, len;
 	struct request_queue *q = bdev_get_queue(bdev);
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
-
+	int err;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -134,7 +133,11 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
-	truncate_inode_pages_range(mapping, start, start + len - 1);
+
+	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	if (err)
+		return err;
+
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
 }
@@ -143,8 +146,8 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	struct address_space *mapping;
 	uint64_t start, end, len;
+	int err;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -166,8 +169,9 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
-	mapping = bdev->bd_inode->i_mapping;
-	truncate_inode_pages_range(mapping, start, end);
+	err = truncate_bdev_range(bdev, mode, start, end);
+	if (err)
+		return err;
 
 	return blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
 			BLKDEV_ZERO_NOUNMAP);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e00443..02a749370717 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -103,6 +103,35 @@ void invalidate_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
+/*
+ * Drop all buffers & page cache for given bdev range. This function bails
+ * with error if bdev has other exclusive owner (such as filesystem).
+ */
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
+			loff_t lstart, loff_t lend)
+{
+	struct block_device *claimed_bdev = NULL;
+	int err;
+
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * while we discard the buffer cache to avoid discarding buffers
+	 * under live filesystem.
+	 */
+	if (!(mode & FMODE_EXCL)) {
+		claimed_bdev = bdev->bd_contains;
+		err = bd_prepare_to_claim(bdev, claimed_bdev,
+					  truncate_bdev_range);
+		if (err)
+			return err;
+	}
+	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	if (claimed_bdev)
+		bd_abort_claiming(bdev, claimed_bdev, truncate_bdev_range);
+	return 0;
+}
+EXPORT_SYMBOL(truncate_bdev_range);
+
 static void set_init_blocksize(struct block_device *bdev)
 {
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
@@ -1969,7 +1998,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct address_space *mapping;
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -1997,8 +2025,9 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages. */
-	mapping = bdev->bd_inode->i_mapping;
-	truncate_inode_pages_range(mapping, start, end);
+	error = truncate_bdev_range(bdev, file->f_mode, start, end);
+	if (error)
+		return error;
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
@@ -2025,7 +2054,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	 * the caller will be given -EBUSY.  The third argument is
 	 * inclusive, so the rounding here is safe.
 	 */
-	return invalidate_inode_pages2_range(mapping,
+	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
 					     start >> PAGE_SHIFT,
 					     end >> PAGE_SHIFT);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..91c62bfb2042 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1984,11 +1984,18 @@ void bdput(struct block_device *);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
+			loff_t lend);
 int sync_blockdev(struct block_device *bdev);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
 }
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
+			loff_t lend)
+{
+	return 0;
+}
 static inline int sync_blockdev(struct block_device *bdev)
 {
 	return 0;
-- 
2.16.4

