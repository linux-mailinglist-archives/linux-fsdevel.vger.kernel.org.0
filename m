Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA471976F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjFAJp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFAJpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A19193;
        Thu,  1 Jun 2023 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KBSZP+H+B3VTPJga3uZab9DVq6AzfNWIBlykXT/Wzx0=; b=LYXIF4HcK1/SwO8gYDml1qoGO8
        Qfg8n88Pr7TJ4LdfLYHZ6VFL5lDnrTbqE2/IXQFjv1d68yDxHtZQ6E6geFes4yObXvDw2abAWZlxX
        3Hdc85DpwvWySKkz0nekueDJT/l/oEOwHRLLWsiuo6rcqqg5HtdpSgJNNlp456fjTggwYd1I83E1j
        2uug+cZgWpNyxZm9YcYxwmATLHfOOWdYTj1+hbEaC+SHIuqpjTpTyhefjeUbehv1ZBdp7DCCeLXsH
        ambjrXEjpP/XmV+I/2DYGheWkpw8hNe0pXPj+MxIoSoGEz9XkqUkw+16YJieXF0ztRXWDXrOAgClB
        dfpxGX1A==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4esC-002m4j-2p;
        Thu, 01 Jun 2023 09:45:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 07/16] block: delete partitions later in del_gendisk
Date:   Thu,  1 Jun 2023 11:44:50 +0200
Message-Id: <20230601094459.1350643-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delay dropping the block_devices for partitions in del_gendisk until
after the call to blk_mark_disk_dead, so that we can implementat
notification of removed devices in blk_mark_disk_dead.

This requires splitting a lower-level drop_partition helper out of
delete_partition and using that from del_gendisk, while having a
common loop for the whole device and partitions that calls
remove_inode_hash, fsync_bdev and __invalidate_device before the
call to blk_mark_disk_dead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk.h             |  2 +-
 block/genhd.c           | 24 +++++++++++++++++++-----
 block/partitions/core.c | 19 ++++++++++++-------
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 7ad7cb6ffa0135..9582fcd0df4123 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -409,7 +409,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 int bdev_del_partition(struct gendisk *disk, int partno);
 int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
-void blk_drop_partitions(struct gendisk *disk);
+void drop_partition(struct block_device *part);
 
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
diff --git a/block/genhd.c b/block/genhd.c
index 6fa926a02d8534..a668d2f0208766 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -615,6 +615,8 @@ EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 void del_gendisk(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	struct block_device *part;
+	unsigned long idx;
 
 	might_sleep();
 
@@ -623,16 +625,28 @@ void del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	/*
+	 * Prevent new openers by unlinked the bdev inode, and write out
+	 * dirty data before marking the disk dead and stopping all I/O.
+	 */
 	mutex_lock(&disk->open_mutex);
-	remove_inode_hash(disk->part0->bd_inode);
-	blk_drop_partitions(disk);
+	xa_for_each(&disk->part_tbl, idx, part) {
+		remove_inode_hash(part->bd_inode);
+		fsync_bdev(part);
+		__invalidate_device(part, true);
+	}
 	mutex_unlock(&disk->open_mutex);
 
-	fsync_bdev(disk->part0);
-	__invalidate_device(disk->part0, true);
-
 	blk_mark_disk_dead(disk);
 
+	/*
+	 * Drop all partitions now that the disk is marked dead.
+	 */
+	mutex_lock(&disk->open_mutex);
+	xa_for_each_start(&disk->part_tbl, idx, part, 1)
+		drop_partition(part);
+	mutex_unlock(&disk->open_mutex);
+
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9d1debaa5caf9a..c3c12671a949d2 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -263,10 +263,19 @@ const struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-static void delete_partition(struct block_device *part)
+void drop_partition(struct block_device *part)
 {
 	lockdep_assert_held(&part->bd_disk->open_mutex);
 
+	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
+	kobject_put(part->bd_holder_dir);
+
+	device_del(&part->bd_device);
+	put_device(&part->bd_device);
+}
+
+static void delete_partition(struct block_device *part)
+{
 	/*
 	 * Remove the block device from the inode hash, so that it cannot be
 	 * looked up any more even when openers still hold references.
@@ -276,11 +285,7 @@ static void delete_partition(struct block_device *part)
 	fsync_bdev(part);
 	__invalidate_device(part, true);
 
-	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
-	device_del(&part->bd_device);
-
-	put_device(&part->bd_device);
+	drop_partition(part);
 }
 
 static ssize_t whole_disk_show(struct device *dev,
@@ -519,7 +524,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	return true;
 }
 
-void blk_drop_partitions(struct gendisk *disk)
+static void blk_drop_partitions(struct gendisk *disk)
 {
 	struct block_device *part;
 	unsigned long idx;
-- 
2.39.2

