Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122A52C27B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgKXN3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbgKXN3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5E9C0613D6;
        Tue, 24 Nov 2020 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fU4q5g8DrG8H4tmNCyRi+kxvuLyvbj3BSRsKCHW7Lvs=; b=lCj/qA5g5ZkwyWOAQF8ozej3vH
        keMjMwfYtWrbfzi/noHPO0Jb5da9D0DGw7G8IWjYVy/O03K5og4aipRWsXkLxQK8EApPzcDWjwilc
        7fOJgtIOp1JRzInyLgIUAxC0fi7eGIOiUCRfXEhU3Tc/HoDFvyV8LhCmctZyuMEvauG5YTP8OsLJd
        IYuC4WJUcdjC5RIGPIV3kk26bwLOc4XU7AkfAB1J2hi0J7THmDwtvAdtfGR8uO7tvNnNVgXDX8hQk
        MiweyWMDmpBAA5XTivLlhZpF582slGC3wGEw8gercd3+MT5GCadCLqsEY9cuVgz3g2gwaSBRy9UC3
        4wKMb0bg==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNR-0006hS-0P; Tue, 24 Nov 2020 13:29:01 +0000
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
Subject: [PATCH 39/45] block: remove the partno field from struct hd_struct
Date:   Tue, 24 Nov 2020 14:27:45 +0100
Message-Id: <20201124132751.3747337-40-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the bd_partno field in struct block_device everywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 12 ++++++------
 block/partitions/core.c |  9 ++++-----
 include/linux/genhd.h   |  1 -
 init/do_mounts.c        |  2 +-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 197120c0c60f23..60004bc8ba5b56 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -576,8 +576,8 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 	int idx;
 
 	/* in consecutive minor range? */
-	if (part->partno < disk->minors) {
-		*devt = MKDEV(disk->major, disk->first_minor + part->partno);
+	if (part->bdev->bd_partno < disk->minors) {
+		*devt = MKDEV(disk->major, disk->first_minor + part->bdev->bd_partno);
 		return 0;
 	}
 
@@ -847,7 +847,7 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(disk, part->partno);
+		invalidate_partition(disk, part->bdev->bd_partno);
 		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
@@ -989,7 +989,7 @@ void __init printk_all_partitions(void)
 			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
 			       bdevt_str(part_devt(part), devt_buf),
 			       bdev_nr_sectors(part->bdev) >> 1,
-			       disk_name(disk, part->partno, name_buf),
+			       disk_name(disk, part->bdev->bd_partno, name_buf),
 			       part->bdev->bd_meta_info ?
 					part->bdev->bd_meta_info->uuid : "");
 			if (is_part0) {
@@ -1083,7 +1083,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 		seq_printf(seqf, "%4d  %7d %10llu %s\n",
 			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
 			   bdev_nr_sectors(part->bdev) >> 1,
-			   disk_name(sgp, part->partno, buf));
+			   disk_name(sgp, part->bdev->bd_partno, buf));
 	disk_part_iter_exit(&piter);
 
 	return 0;
@@ -1506,7 +1506,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %u"
 			   "\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
-			   disk_name(gp, hd->partno, buf),
+			   disk_name(gp, hd->bdev->bd_partno, buf),
 			   stat.ios[STAT_READ],
 			   stat.merges[STAT_READ],
 			   stat.sectors[STAT_READ],
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8beab9e7727e27..ee4f4e3237aa2d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -184,7 +184,7 @@ static ssize_t part_partition_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%d\n", p->partno);
+	return sprintf(buf, "%d\n", p->bdev->bd_partno);
 }
 
 static ssize_t part_start_show(struct device *dev,
@@ -274,7 +274,7 @@ static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct hd_struct *part = dev_to_part(dev);
 
-	add_uevent_var(env, "PARTN=%u", part->partno);
+	add_uevent_var(env, "PARTN=%u", part->bdev->bd_partno);
 	if (part->bdev->bd_meta_info && part->bdev->bd_meta_info->volname[0])
 		add_uevent_var(env, "PARTNAME=%s",
 			       part->bdev->bd_meta_info->volname);
@@ -298,7 +298,7 @@ void delete_partition(struct hd_struct *part)
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
-	rcu_assign_pointer(ptbl->part[part->partno], NULL);
+	rcu_assign_pointer(ptbl->part[part->bdev->bd_partno], NULL);
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
 
 	kobject_put(part->bdev->bd_holder_dir);
@@ -372,7 +372,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
-	p->partno = partno;
 	bdev->bd_read_only = get_disk_ro(disk);
 
 	if (info) {
@@ -445,7 +444,7 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
-		if (part->partno == skip_partno ||
+		if (part->bdev->bd_partno == skip_partno ||
 		    start >= part->bdev->bd_start_sect +
 			bdev_nr_sectors(part->bdev) ||
 		    start + length <= part->bdev->bd_start_sect)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 77443a1031e373..afe27a0b8f5dd8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -54,7 +54,6 @@ struct partition_meta_info {
 struct hd_struct {
 	struct block_device *bdev;
 	struct device __dev;
-	int partno;
 };
 
 /**
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 368ccb71850126..86bef93e72ebd6 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -136,7 +136,7 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 		struct hd_struct *part;
 
 		part = disk_get_part(dev_to_disk(dev),
-				     dev_to_part(dev)->partno + offset);
+				     dev_to_part(dev)->bdev->bd_partno + offset);
 		if (part) {
 			devt = part_devt(part);
 			put_device(part_to_dev(part));
-- 
2.29.2

