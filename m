Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250A72C27A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgKXN3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgKXN3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA83C061A4D;
        Tue, 24 Nov 2020 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Qmxc9F7d78fxvqrcJGALGomPNXCJxQ4BUeKonQI+9iM=; b=XyqGQ69cDW3VmV7MtWM6fAyAuQ
        xMwqzl+m+RXBmsO7uXvW6LGkl8emxWJPDkGZD+RtsFYoUP8Vp7CRyACrz6WjJgjwOJEvKGCpqxA6j
        KnQrGVQTaRSu7gtK+Tea7urSawRPeyaeKy8RJfD4JEoXzn0r0hL8WB9nhe63bsjFwdopiXqfPHLiG
        p78yzr7nysZmwhciBbmOCHXpvL6ZVbcVs2e56BBFUTGKUATmxQaPUcZKkVnPojHv6fNP7LGLC2A5d
        jD5qafRcbkaausdIEi8N5FEnSzrWI/bP9n17voU8JdKocp75w1Ty8NjjBdPRVPP2Ncz2LvkdNqUfW
        Ta6LBeJQ==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNC-0006eW-7z; Tue, 24 Nov 2020 13:28:47 +0000
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
Subject: [PATCH 31/45] block: move disk stat accounting to struct block_device
Date:   Tue, 24 Nov 2020 14:27:37 +0100
Message-Id: <20201124132751.3747337-32-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the dkstats and stamp field to struct block_device in preparation
of killing struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c        |  2 +-
 block/blk-core.c          |  4 ++--
 block/blk.h               |  1 -
 block/genhd.c             | 14 ++++----------
 block/partitions/core.c   |  9 +--------
 fs/block_dev.c            | 10 ++++++++++
 include/linux/blk_types.h |  2 ++
 include/linux/genhd.h     |  2 --
 include/linux/part_stat.h | 38 +++++++++++++++++++-------------------
 9 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 23437b96ea41e6..a598f86e014137 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -830,7 +830,7 @@ static void blkcg_fill_root_iostats(void)
 		for_each_possible_cpu(cpu) {
 			struct disk_stats *cpu_dkstats;
 
-			cpu_dkstats = per_cpu_ptr(part->dkstats, cpu);
+			cpu_dkstats = per_cpu_ptr(part->bdev->bd_stats, cpu);
 			tmp.ios[BLKG_IOSTAT_READ] +=
 				cpu_dkstats->ios[STAT_READ];
 			tmp.ios[BLKG_IOSTAT_WRITE] +=
diff --git a/block/blk-core.c b/block/blk-core.c
index 988f45094a387b..d2c9cb24e087f3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1264,9 +1264,9 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 {
 	unsigned long stamp;
 again:
-	stamp = READ_ONCE(part->stamp);
+	stamp = READ_ONCE(part->bdev->bd_stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
+		if (likely(cmpxchg(&part->bdev->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
 	if (part->partno) {
diff --git a/block/blk.h b/block/blk.h
index 09cee7024fb43e..3f801f6e86f8a1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -381,7 +381,6 @@ static inline void hd_struct_put(struct hd_struct *part)
 
 static inline void hd_free_part(struct hd_struct *part)
 {
-	free_percpu(part->dkstats);
 	kfree(part->info);
 	bdput(part->bdev);
 	percpu_ref_exit(&part->ref);
diff --git a/block/genhd.c b/block/genhd.c
index 8ace0628ac20b7..0c0458367da7e4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -102,7 +102,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 
 	memset(stat, 0, sizeof(struct disk_stats));
 	for_each_possible_cpu(cpu) {
-		struct disk_stats *ptr = per_cpu_ptr(part->dkstats, cpu);
+		struct disk_stats *ptr = per_cpu_ptr(part->bdev->bd_stats, cpu);
 		int group;
 
 		for (group = 0; group < NR_STAT_GROUPS; group++) {
@@ -875,7 +875,7 @@ void del_gendisk(struct gendisk *disk)
 	kobject_put(disk->slave_dir);
 
 	part_stat_set_all(&disk->part0, 0);
-	disk->part0.stamp = 0;
+	disk->part0.bdev->bd_stamp = 0;
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
@@ -1612,19 +1612,15 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk->part0.bdev)
 		goto out_free_disk;
 
-	disk->part0.dkstats = alloc_percpu(struct disk_stats);
-	if (!disk->part0.dkstats)
-		goto out_bdput;
-
 	disk->node_id = node_id;
 	if (disk_expand_part_tbl(disk, 0))
-		goto out_free_bdstats;
+		goto out_bdput;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
 	rcu_assign_pointer(ptbl->part[0], &disk->part0);
 
 	if (hd_ref_init(&disk->part0))
-		goto out_free_bdstats;
+		goto out_bdput;
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
@@ -1633,8 +1629,6 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	device_initialize(disk_to_dev(disk));
 	return disk;
 
-out_free_bdstats:
-	free_percpu(disk->part0.dkstats);
 out_bdput:
 	bdput(disk->part0.bdev);
 out_free_disk:
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 92ffa55bdfddfd..c3a4870bfb123d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -409,14 +409,9 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p)
 		return ERR_PTR(-EBUSY);
 
-	err = -ENOMEM;
-	p->dkstats = alloc_percpu(struct disk_stats);
-	if (!p->dkstats)
-		goto out_free;
-
 	bdev = bdev_alloc(disk, partno);
 	if (!bdev)
-		goto out_free_stats;
+		goto out_free;
 	p->bdev = bdev;
 
 	pdev = part_to_dev(p);
@@ -490,8 +485,6 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	kfree(p->info);
 out_bdput:
 	bdput(bdev);
-out_free_stats:
-	free_percpu(p->dkstats);
 out_free:
 	kfree(p);
 	return ERR_PTR(err);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 02536d9fa29945..0427e6fa59556f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -32,6 +32,7 @@
 #include <linux/cleancache.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
+#include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
 #include "internal.h"
@@ -781,6 +782,10 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 
 static void bdev_free_inode(struct inode *inode)
 {
+	struct block_device *bdev = I_BDEV(inode);
+
+	free_percpu(bdev->bd_stats);
+
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
@@ -874,6 +879,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 #ifdef CONFIG_SYSFS
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
+	bdev->bd_stats = alloc_percpu(struct disk_stats);
+	if (!bdev->bd_stats) {
+		iput(inode);
+		return NULL;
+	}
 	return bdev;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 2e0a9bd9688d28..520011b95276fb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,6 +20,8 @@ typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
 struct block_device {
+	struct disk_stats __percpu *bd_stats;
+	unsigned long		bd_stamp;
 	dev_t			bd_dev;
 	int			bd_openers;
 	struct inode *		bd_inode;	/* will die */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0dbd254bca51aa..dcc40c8217d095 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -52,8 +52,6 @@ struct partition_meta_info {
 
 struct hd_struct {
 	sector_t start_sect;
-	unsigned long stamp;
-	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
 	struct block_device *bdev;
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 24125778ef3ec7..87ad60106e1db0 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -25,17 +25,17 @@ struct disk_stats {
 #define part_stat_unlock()	preempt_enable()
 
 #define part_stat_get_cpu(part, field, cpu)				\
-	(per_cpu_ptr((part)->dkstats, (cpu))->field)
+	(per_cpu_ptr((part)->bdev->bd_stats, (cpu))->field)
 
 #define part_stat_get(part, field)					\
 	part_stat_get_cpu(part, field, smp_processor_id())
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->dkstats->field) res = 0;				\
+	typeof((part)->bdev->bd_stats->field) res = 0;			\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
-		res += per_cpu_ptr((part)->dkstats, _cpu)->field;	\
+		res += per_cpu_ptr((part)->bdev->bd_stats, _cpu)->field; \
 	res;								\
 })
 
@@ -44,7 +44,7 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	int i;
 
 	for_each_possible_cpu(i)
-		memset(per_cpu_ptr(part->dkstats, i), value,
+		memset(per_cpu_ptr(part->bdev->bd_stats, i), value,
 				sizeof(struct disk_stats));
 }
 
@@ -54,7 +54,7 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define __part_stat_add(part, field, addnd)				\
-	__this_cpu_add((part)->dkstats->field, addnd)
+	__this_cpu_add((part)->bdev->bd_stats->field, addnd)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
@@ -63,20 +63,20 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 				field, addnd);				\
 } while (0)
 
-#define part_stat_dec(gendiskp, field)					\
-	part_stat_add(gendiskp, field, -1)
-#define part_stat_inc(gendiskp, field)					\
-	part_stat_add(gendiskp, field, 1)
-#define part_stat_sub(gendiskp, field, subnd)				\
-	part_stat_add(gendiskp, field, -subnd)
+#define part_stat_dec(part, field)					\
+	part_stat_add(part, field, -1)
+#define part_stat_inc(part, field)					\
+	part_stat_add(part, field, 1)
+#define part_stat_sub(part, field, subnd)				\
+	part_stat_add(part, field, -subnd)
 
-#define part_stat_local_dec(gendiskp, field)				\
-	local_dec(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_inc(gendiskp, field)				\
-	local_inc(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_read(gendiskp, field)				\
-	local_read(&(part_stat_get(gendiskp, field)))
-#define part_stat_local_read_cpu(gendiskp, field, cpu)			\
-	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
+#define part_stat_local_dec(part, field)				\
+	local_dec(&(part_stat_get(part, field)))
+#define part_stat_local_inc(part, field)				\
+	local_inc(&(part_stat_get(part, field)))
+#define part_stat_local_read(part, field)				\
+	local_read(&(part_stat_get(part, field)))
+#define part_stat_local_read_cpu(part, field, cpu)			\
+	local_read(&(part_stat_get_cpu(part, field, cpu)))
 
 #endif /* _LINUX_PART_STAT_H */
-- 
2.29.2

