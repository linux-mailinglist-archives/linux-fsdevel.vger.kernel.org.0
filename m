Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68481202233
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgFTHRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgFTHRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F9C06174E;
        Sat, 20 Jun 2020 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vxIwR1z3WtgDEHokhnxZst5NPuW9toIowL1zJge5q4U=; b=bob0T/OgQiIvdV02N23f59hTy9
        RaVc427Iv2B1oGIFHPt+wMS+Rcs1chRjNuMPcv5NlC6qs9qPc7SO3guLfulPAo3X/CrWughvOwAjr
        KrH3ZyeuIrTvk9Skau6rWVpTi2DB6BO0LbTHhUsh767gd166+m6m/WHiy1ztOtSgXQP3upX+Bo5zl
        nKEwmHGhD5h1I6VVb91ymSkCJBwVQHJfDTkGWPjYSw/DyOJNQivAnvuhc9qAm8S0RTJ/tjpzX6eAL
        +C6mw6iVkIfoi6v7lDBLQgVMqebgRH3IElkxtLXu1xjuctqrOI4BaG5xoaXRkzya7K7xjQ6cI4zwD
        2OybXwXA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkW-0003uA-Qj; Sat, 20 Jun 2020 07:17:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] block: reduce ifdef CONFIG_BLOCK madness in headers
Date:   Sat, 20 Jun 2020 09:16:43 +0200
Message-Id: <20200620071644.463185-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Large part of bio.h, blkdev.h and genhd.h are under ifdef CONFIG_BLOCK
for no good reason.  Only stub out function that are called from
code that is not dependent on CONFIG_BLOCK and leave the harmless
other declarations around.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h    |  3 --
 include/linux/blkdev.h | 92 ++++++++++++++++++------------------------
 include/linux/genhd.h  | 14 +++----
 3 files changed, 46 insertions(+), 63 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 91676d4b2dfe77..0282f8aa85935c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -8,8 +8,6 @@
 #include <linux/highmem.h>
 #include <linux/mempool.h>
 #include <linux/ioprio.h>
-
-#ifdef CONFIG_BLOCK
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 
@@ -824,5 +822,4 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
-#endif /* CONFIG_BLOCK */
 #endif /* __LINUX_BIO_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 973253ce202d87..0f021ee2ce1c3b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -4,9 +4,6 @@
 
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-
-#ifdef CONFIG_BLOCK
-
 #include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
@@ -1165,13 +1162,13 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 	return __blk_rq_map_sg(q, rq, sglist, &last_sg);
 }
 extern void blk_dump_rq_flags(struct request *, char *);
-extern long nr_blockdev_pages(void);
 
 bool __must_check blk_get_queue(struct request_queue *);
 struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
+#ifdef CONFIG_BLOCK
 /*
  * blk_plug permits building a queue of related requests by holding the I/O
  * fragments for a short period. This allows merging of sequential requests
@@ -1231,9 +1228,47 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 		 !list_empty(&plug->cb_list));
 }
 
+int blkdev_issue_flush(struct block_device *, gfp_t);
+long nr_blockdev_pages(void);
+#else /* CONFIG_BLOCK */
+struct blk_plug {
+};
+
+static inline void blk_start_plug(struct blk_plug *plug)
+{
+}
+
+static inline void blk_finish_plug(struct blk_plug *plug)
+{
+}
+
+static inline void blk_flush_plug(struct task_struct *task)
+{
+}
+
+static inline void blk_schedule_flush_plug(struct task_struct *task)
+{
+}
+
+
+static inline bool blk_needs_flush_plug(struct task_struct *tsk)
+{
+	return false;
+}
+
+static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask)
+{
+	return 0;
+}
+
+static inline long nr_blockdev_pages(void)
+{
+	return 0;
+}
+#endif /* CONFIG_BLOCK */
+
 extern void blk_io_schedule(void);
 
-int blkdev_issue_flush(struct block_device *, gfp_t);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
 
@@ -1833,51 +1868,6 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-#else /* CONFIG_BLOCK */
-
-struct block_device;
-
-/*
- * stubs for when the block layer is configured out
- */
-
-static inline long nr_blockdev_pages(void)
-{
-	return 0;
-}
-
-struct blk_plug {
-};
-
-static inline void blk_start_plug(struct blk_plug *plug)
-{
-}
-
-static inline void blk_finish_plug(struct blk_plug *plug)
-{
-}
-
-static inline void blk_flush_plug(struct task_struct *task)
-{
-}
-
-static inline void blk_schedule_flush_plug(struct task_struct *task)
-{
-}
-
-
-static inline bool blk_needs_flush_plug(struct task_struct *tsk)
-{
-	return false;
-}
-
-static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask)
-{
-	return 0;
-}
-
-#endif /* CONFIG_BLOCK */
-
 static inline void blk_wake_io_task(struct task_struct *waiter)
 {
 	/*
@@ -1891,7 +1881,6 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-#ifdef CONFIG_BLOCK
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 		unsigned int op);
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
@@ -1917,7 +1906,6 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 {
 	return disk_end_io_acct(bio->bi_disk, bio_op(bio), start_time);
 }
-#endif /* CONFIG_BLOCK */
 
 int bdev_read_only(struct block_device *bdev);
 int set_blocksize(struct block_device *bdev, int size);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 83f8e0d8322836..31a54072ffd653 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -19,8 +19,6 @@
 #include <linux/blk_types.h>
 #include <asm/local.h>
 
-#ifdef CONFIG_BLOCK
-
 #define dev_to_disk(device)	container_of((device), struct gendisk, part0.__dev)
 #define dev_to_part(device)	container_of((device), struct hd_struct, __dev)
 #define disk_to_dev(disk)	(&(disk)->part0.__dev)
@@ -337,12 +335,9 @@ static inline void set_capacity(struct gendisk *disk, sector_t size)
 	disk->part0.nr_sects = size;
 }
 
-extern dev_t blk_lookup_devt(const char *name, int partno);
-
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
-extern void printk_all_partitions(void);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern struct kobject *get_disk_and_module(struct gendisk *disk);
@@ -400,10 +395,13 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 }
 #endif /* CONFIG_SYSFS */
 
+#ifdef CONFIG_BLOCK
+void printk_all_partitions(void);
+dev_t blk_lookup_devt(const char *name, int partno);
 #else /* CONFIG_BLOCK */
-
-static inline void printk_all_partitions(void) { }
-
+static inline void printk_all_partitions(void)
+{
+}
 static inline dev_t blk_lookup_devt(const char *name, int partno)
 {
 	dev_t devt = MKDEV(0, 0);
-- 
2.26.2

