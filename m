Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F525182D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgHYMGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 08:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgHYMGF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8430FACDF;
        Tue, 25 Aug 2020 12:06:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E91E1E1319; Tue, 25 Aug 2020 14:05:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     yebin <yebin10@huawei.com>, Christoph Hellwig <hch@infradead.org>,
        <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 2/2] block: Do not discard buffers under a mounted filesystem
Date:   Tue, 25 Aug 2020 14:05:54 +0200
Message-Id: <20200825120554.13070-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200825120554.13070-1-jack@suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
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

So refuse fallocate(2) and BLKZEROOUT, BLKDISCARD, BLKSECDISCARD ioctls
for a block device having filesystem mounted.

Reported-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c  | 19 ++++++++++++++++++-
 fs/block_dev.c |  9 +++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index bdb3bbb253d9..0e3a46b0ffc8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -113,7 +113,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	uint64_t start, len;
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
-
+	struct super_block *sb;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -134,6 +134,14 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
+	/*
+	 * Don't mess with device with mounted filesystem.
+	 */
+	sb = get_super(bdev);
+	if (sb) {
+		drop_super(sb);
+		return -EBUSY;
+	}
 	truncate_inode_pages_range(mapping, start, start + len - 1);
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
@@ -145,6 +153,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 	uint64_t range[2];
 	struct address_space *mapping;
 	uint64_t start, end, len;
+	struct super_block *sb;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -165,6 +174,14 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 	if (end < start)
 		return -EINVAL;
 
+	/*
+	 * Don't mess with device with mounted filesystem.
+	 */
+	sb = get_super(bdev);
+	if (sb) {
+		drop_super(sb);
+		return -EBUSY;
+	}
 	/* Invalidate the page cache, including dirty pages */
 	mapping = bdev->bd_inode->i_mapping;
 	truncate_inode_pages_range(mapping, start, end);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e00443..5b398eb7c34c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1973,6 +1973,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
+	struct super_block *sb;
 
 	/* Fail if we don't recognize the flags. */
 	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
@@ -1996,6 +1997,14 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	/*
+	 * Don't mess with device with mounted filesystem.
+	 */
+	sb = get_super(bdev);
+	if (sb) {
+		drop_super(sb);
+		return -EBUSY;
+	}
 	/* Invalidate the page cache, including dirty pages. */
 	mapping = bdev->bd_inode->i_mapping;
 	truncate_inode_pages_range(mapping, start, end);
-- 
2.16.4

