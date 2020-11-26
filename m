Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFABA2C54EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbgKZNHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbgKZNHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778AC0613D4;
        Thu, 26 Nov 2020 05:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AmF+soi/tJlwBNaRONn2IjJTl0osBWVgBcgFQOU13ls=; b=jJXqBUAS3st2PZGdwZeZime/43
        eTZI5ELlBaI3OiNEy21rSFdQoNQmJi1T6VVB+866taDb4O/afrByfjnlvDvxJpLZjFXOXJ1+KQqXc
        QBfftUZAJanQY9Jge2SNJo9P6m3fdkCcEUuT+GjW46V9tXYGLkkDD+bW3c9kYt7UfidTTbY7V0VB4
        bBi3q/XQgGF/jhkhnEHSgPlNPm8SgssZdAxLOzrXNgNnwaAaSMwUZBYWH7JCgG1QM5Ulk2FTMKl/B
        8PV2emIEVL0okwr3E1uUbf2Om64AR3FFqaYfrvLkrDs2boYEXrB2y1JgtukMIZUfZ97OXplXNKv6a
        QtIAveUQ==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzb-000484-DD; Thu, 26 Nov 2020 13:07:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 35/44] block: move the policy field to struct block_device
Date:   Thu, 26 Nov 2020 14:04:13 +0100
Message-Id: <20201126130422.92945-36-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the policy field to struct block_device and rename it to the
more descriptive bd_read_only.  Also turn the field into a bool as it
is used as such.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          | 2 +-
 block/genhd.c             | 8 ++++----
 block/ioctl.c             | 2 +-
 block/partitions/core.c   | 4 ++--
 include/linux/blk_types.h | 1 +
 include/linux/genhd.h     | 4 ++--
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9121390be97a76..d64ffcb6f9ae5d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -696,7 +696,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && op_is_write(op)) {
+	if (part->bdev->bd_read_only && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
diff --git a/block/genhd.c b/block/genhd.c
index 0371558ccde14c..ae312ccc6dd7c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1679,14 +1679,14 @@ void set_disk_ro(struct gendisk *disk, int flag)
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	if (disk->part0.policy != flag) {
+	if (disk->part0.bdev->bd_read_only != flag) {
 		set_disk_ro_uevent(disk, flag);
-		disk->part0.policy = flag;
+		disk->part0.bdev->bd_read_only = flag;
 	}
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		part->policy = flag;
+		part->bdev->bd_read_only = flag;
 	disk_part_iter_exit(&piter);
 }
 
@@ -1696,7 +1696,7 @@ int bdev_read_only(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return bdev->bd_part->policy;
+	return bdev->bd_read_only;
 }
 
 EXPORT_SYMBOL(bdev_read_only);
diff --git a/block/ioctl.c b/block/ioctl.c
index a6d8171221c7dc..d61d652078f41c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -345,7 +345,7 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_part->policy = n;
+	bdev->bd_read_only = n;
 	return 0;
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index d1093adf2570e2..f397ec9922bd6e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -199,7 +199,7 @@ static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%d\n", p->policy ? 1 : 0);
+	return sprintf(buf, "%d\n", p->bdev->bd_read_only);
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
@@ -420,7 +420,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
 	p->partno = partno;
-	p->policy = get_disk_ro(disk);
+	bdev->bd_read_only = get_disk_ro(disk);
 
 	if (info) {
 		err = -ENOMEM;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b237f1e4081405..758cf71c9aa2a6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -23,6 +23,7 @@ struct block_device {
 	sector_t		bd_start_sect;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
+	bool			bd_read_only;	/* read-only policy */
 	dev_t			bd_dev;
 	int			bd_openers;
 	struct inode *		bd_inode;	/* will die */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 349cf6403ccddc..dcbf9ef7610ea6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -55,7 +55,7 @@ struct hd_struct {
 
 	struct block_device *bdev;
 	struct device __dev;
-	int policy, partno;
+	int partno;
 	struct rcu_work rcu_work;
 };
 
@@ -278,7 +278,7 @@ extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.policy;
+	return disk->part0.bdev->bd_read_only;
 }
 
 extern void disk_block_events(struct gendisk *disk);
-- 
2.29.2

