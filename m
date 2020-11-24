Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C02C2781
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgKXN2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbgKXN2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F1C0613D6;
        Tue, 24 Nov 2020 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nzkUfrT01Wyy3ftM2t5tJYLu+k0O8FwenTfIP4W4Alg=; b=QJqpmwmcRFqcG29M/kctfXCzQB
        BGC4iJ+kXweWuVnoPisgRNDv06K0vk8fvyp15/7tvBIq4LD48rZzewgoVFPe/2uGW8RQq+6b5Jo5k
        WJbpdWZYIqUnR0J90EL3Xlw5a1OXx02V58H5fRlGs8qPi4+Fj5hrX5NBXm1FNtfqTDy2OkeV0TVx9
        FB45owhz/9M9gbrNGPgJBRCGNH+DgxkmtwdGfT/rdtgIwVbTnQSsyNZzCWC4VwvGnJ0E9CevwS/lN
        LVoKe3fEpXX2CVVvJouwGSJdWtCRLhGR47Obd4dXmOJL2zf9oFs12PgYTuAqCvqs1XpWJqIZew3WK
        lNqUCg2A==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYN3-0006cE-B6; Tue, 24 Nov 2020 13:28:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 26/45] block: remove ->bd_contains
Date:   Tue, 24 Nov 2020 14:27:32 +0100
Message-Id: <20201124132751.3747337-27-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that each hd_struct has a reference to the corresponding
block_device, there is no need for the bd_contains pointer.  Add
a bdev_whole() helper to look up the whole device block_device
struture instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c      |  2 +-
 drivers/scsi/scsicam.c    |  2 +-
 fs/block_dev.c            | 22 ++++++++--------------
 include/linux/blk_types.h |  4 +++-
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 26c7aafba7c5f8..c0df88b3300c41 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1088,7 +1088,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
+		claimed_bdev = bdev_whole(bdev);
 		error = bd_prepare_to_claim(bdev, claimed_bdev, loop_configure);
 		if (error)
 			goto out_putf;
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 682cf08ab04153..f1553a453616fd 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,7 +32,7 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = dev->bd_contains->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
 	unsigned char *res = NULL;
 	struct page *page;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b9ee8fe5acd570..e8d7de5fae00a9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -119,7 +119,7 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
 	 * under live filesystem.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bdev->bd_contains;
+		claimed_bdev = bdev_whole(bdev);
 		err = bd_prepare_to_claim(bdev, claimed_bdev,
 					  truncate_bdev_range);
 		if (err)
@@ -879,7 +879,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
-	bdev->bd_contains = NULL;
 	bdev->bd_super = NULL;
 	bdev->bd_inode = inode;
 	bdev->bd_part_count = 0;
@@ -1342,9 +1341,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 	int ret;
 
 	if (!bdev->bd_openers) {
-		bdev->bd_contains = bdev;
-
-		if (!bdev->bd_partno) {
+		if (!bdev_is_partition(bdev)) {
 			ret = -ENXIO;
 			bdev->bd_part = disk_get_part(disk, 0);
 			if (!bdev->bd_part)
@@ -1384,7 +1381,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			whole->bd_part_count++;
 			mutex_unlock(&whole->bd_mutex);
 
-			bdev->bd_contains = whole;
 			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
 			if (!bdev->bd_part || !bdev->bd_part->nr_sects) {
 				__blkdev_put(whole, mode, 1);
@@ -1398,7 +1394,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 		if (bdev->bd_bdi == &noop_backing_dev_info)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
-		if (bdev->bd_contains == bdev) {
+		if (!bdev_is_partition(bdev)) {
 			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
@@ -1416,7 +1412,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
  out_clear:
 	disk_put_part(bdev->bd_part);
 	bdev->bd_part = NULL;
-	bdev->bd_contains = NULL;
 	return ret;
 }
 
@@ -1659,8 +1654,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
 		if (bdev_is_partition(bdev))
-			victim = bdev->bd_contains;
-		bdev->bd_contains = NULL;
+			victim = bdev_whole(bdev);
 	} else {
 		if (!bdev_is_partition(bdev) && disk->fops->release)
 			disk->fops->release(disk, mode);
@@ -1678,6 +1672,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	mutex_lock(&bdev->bd_mutex);
 
 	if (mode & FMODE_EXCL) {
+		struct block_device *whole = bdev_whole(bdev);
 		bool bdev_free;
 
 		/*
@@ -1688,13 +1683,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 		spin_lock(&bdev_lock);
 
 		WARN_ON_ONCE(--bdev->bd_holders < 0);
-		WARN_ON_ONCE(--bdev->bd_contains->bd_holders < 0);
+		WARN_ON_ONCE(--whole->bd_holders < 0);
 
-		/* bd_contains might point to self, check in a separate step */
 		if ((bdev_free = !bdev->bd_holders))
 			bdev->bd_holder = NULL;
-		if (!bdev->bd_contains->bd_holders)
-			bdev->bd_contains->bd_holder = NULL;
+		if (!whole->bd_holders)
+			whole->bd_holder = NULL;
 
 		spin_unlock(&bdev_lock);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9698f459cc65c9..2e0a9bd9688d28 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -32,7 +32,6 @@ struct block_device {
 #ifdef CONFIG_SYSFS
 	struct list_head	bd_holder_disks;
 #endif
-	struct block_device *	bd_contains;
 	u8			bd_partno;
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
@@ -49,6 +48,9 @@ struct block_device {
 	struct super_block	*bd_fsfreeze_sb;
 } __randomize_layout;
 
+#define bdev_whole(_bdev) \
+	((_bdev)->bd_disk->part0.bdev)
+
 #define bdev_kobj(_bdev) \
 	(&part_to_dev((_bdev)->bd_part)->kobj)
 
-- 
2.29.2

