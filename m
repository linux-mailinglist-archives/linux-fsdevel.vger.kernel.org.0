Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55236778B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjHKKKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjHKKK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B465E3593;
        Fri, 11 Aug 2023 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A5NrYQQ+iDMl8ZujZTgThEgOwqRi6PntDgVI1EiuCVQ=; b=sfWTgv2BPWYvzMM/4il9y74Drn
        EHJp9clvtdEHtpYQjRzvEt9SAR3ejMLE116/CrVtxPVVX4j81JwwyU6hY7YK1TIBx3ebMSMOCSBb9
        RUxA9sjtCVeiw1QTdIy4VqMdApdC4657OyxiNyenzMOxg6jc7L2IsBOr1xgS/En+7D6gemUIEVkCX
        gDtUxh+7FW6q9H1hdenUSP7mACWFvzfVQbX+yLJkxJyfV5nQqAKmbeBTLQJgxt+EnLnU2rCxE769S
        IU8r4+8REAtchqaTjbaKmjDZsJ/Q+pNqWE4qWSEA63JPeLQW2oIIAzeooxj2G++rfBkCGB9sw4Q4S
        YnAVAUOw==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4z-00A5rB-1r;
        Fri, 11 Aug 2023 10:09:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/17] block: call into the file system for bdev_mark_dead
Date:   Fri, 11 Aug 2023 12:08:25 +0200
Message-Id: <20230811100828.1897174-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Combine the newly merged bdev_mark_dead helper with the existing
mark_dead holder operation so that all operations that invalidate
a device that is dead or being removed now go through the holder
ops.  This allows file systems to explicitly shutdown either ASAP
(for a surprise removal) or after writing back data (for an orderly
removal), and do so not only for the main device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c           | 30 +++++++++-------------------
 block/genhd.c          | 44 +++++++++++++++++++++++-------------------
 fs/super.c             |  8 ++++++--
 include/linux/blkdev.h |  2 +-
 4 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b9ca947bd5e405..658d5dd62cac0a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -968,31 +968,19 @@ EXPORT_SYMBOL(lookup_bdev);
  * to %true the device or media is already gone, if not we are preparing for an
  * orderly removal.
  *
- * This syncs out all dirty data and writes back inodes and then invalidates any
- * cached data in the inodes on the file system, the inodes themselves and the
- * block device mapping.
+ * This calls into the file system, which then typicall syncs out all dirty data
+ * and writes back inodes and then invalidates any cached data in the inodes on
+ * the file system.  In addition we also invalidate the block device mapping.
  */
 void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
-	struct super_block *sb = get_super(bdev);
-	int res = 0;
+	mutex_lock(&bdev->bd_holder_lock);
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
+		bdev->bd_holder_ops->mark_dead(bdev, surprise);
+	else
+		sync_blockdev(bdev);
+	mutex_unlock(&bdev->bd_holder_lock);
 
-	if (sb) {
-		if (!surprise)
-			sync_filesystem(sb);
-		/*
-		 * no need to lock the super, get_super holds the
-		 * read mutex so the filesystem cannot go away
-		 * under us (->put_super runs with the write lock
-		 * hold).
-		 */
-		shrink_dcache_sb(sb);
-		res = invalidate_inodes(sb, true);
-		drop_super(sb);
-	} else {
-		if (!surprise)
-			sync_blockdev(bdev);
-	}
 	invalidate_bdev(bdev);
 }
 #ifdef CONFIG_DASD
diff --git a/block/genhd.c b/block/genhd.c
index afc2cb09eb94b9..cc32a0c704eb84 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -554,7 +554,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 }
 EXPORT_SYMBOL(device_add_disk);
 
-static void blk_report_disk_dead(struct gendisk *disk)
+static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 {
 	struct block_device *bdev;
 	unsigned long idx;
@@ -565,10 +565,7 @@ static void blk_report_disk_dead(struct gendisk *disk)
 			continue;
 		rcu_read_unlock();
 
-		mutex_lock(&bdev->bd_holder_lock);
-		if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
-			bdev->bd_holder_ops->mark_dead(bdev);
-		mutex_unlock(&bdev->bd_holder_lock);
+		bdev_mark_dead(bdev, surprise);
 
 		put_device(&bdev->bd_device);
 		rcu_read_lock();
@@ -576,14 +573,7 @@ static void blk_report_disk_dead(struct gendisk *disk)
 	rcu_read_unlock();
 }
 
-/**
- * blk_mark_disk_dead - mark a disk as dead
- * @disk: disk to mark as dead
- *
- * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
- * to this disk.
- */
-void blk_mark_disk_dead(struct gendisk *disk)
+static void __blk_mark_disk_dead(struct gendisk *disk)
 {
 	/*
 	 * Fail any new I/O.
@@ -603,8 +593,19 @@ void blk_mark_disk_dead(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(disk->queue);
+}
 
-	blk_report_disk_dead(disk);
+/**
+ * blk_mark_disk_dead - mark a disk as dead
+ * @disk: disk to mark as dead
+ *
+ * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
+ * to this disk.
+ */
+void blk_mark_disk_dead(struct gendisk *disk)
+{
+	__blk_mark_disk_dead(disk);
+	blk_report_disk_dead(disk, true);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
@@ -641,17 +642,20 @@ void del_gendisk(struct gendisk *disk)
 	disk_del_events(disk);
 
 	/*
-	 * Prevent new openers by unlinked the bdev inode, and write out
-	 * dirty data before marking the disk dead and stopping all I/O.
+	 * Prevent new openers by unlinked the bdev inode.
 	 */
 	mutex_lock(&disk->open_mutex);
-	xa_for_each(&disk->part_tbl, idx, part) {
+	xa_for_each(&disk->part_tbl, idx, part)
 		remove_inode_hash(part->bd_inode);
-		bdev_mark_dead(part, false);
-	}
 	mutex_unlock(&disk->open_mutex);
 
-	blk_mark_disk_dead(disk);
+	/*
+	 * Tell the file system to write back all dirty data and shut down if
+	 * it hasn't been notified earlier.
+	 */
+	if (!test_bit(GD_DEAD, &disk->state))
+		blk_report_disk_dead(disk, false);
+	__blk_mark_disk_dead(disk);
 
 	/*
 	 * Drop all partitions now that the disk is marked dead.
diff --git a/fs/super.c b/fs/super.c
index bbce0fdebf7e52..94d41040584f7b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1228,7 +1228,7 @@ static bool lock_active_super(struct super_block *sb)
 	return true;
 }
 
-static void fs_mark_dead(struct block_device *bdev)
+static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	struct super_block *sb = bdev->bd_holder;
 
@@ -1238,6 +1238,10 @@ static void fs_mark_dead(struct block_device *bdev)
 	if (!lock_active_super(sb))
 		return;
 
+	if (!surprise)
+		sync_filesystem(sb);
+	shrink_dcache_sb(sb);
+	invalidate_inodes(sb, true);
 	if (sb->s_op->shutdown)
 		sb->s_op->shutdown(sb);
 
@@ -1245,7 +1249,7 @@ static void fs_mark_dead(struct block_device *bdev)
 }
 
 const struct blk_holder_ops fs_holder_ops = {
-	.mark_dead		= fs_mark_dead,
+	.mark_dead		= fs_bdev_mark_dead,
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6721595b9f9741..cdd03c612d3957 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1461,7 +1461,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #endif
 
 struct blk_holder_ops {
-	void (*mark_dead)(struct block_device *bdev);
+	void (*mark_dead)(struct block_device *bdev, bool surprise);
 };
 
 extern const struct blk_holder_ops fs_holder_ops;
-- 
2.39.2

