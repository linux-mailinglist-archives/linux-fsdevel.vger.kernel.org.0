Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B7265176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgIJUzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbgIJOt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:49:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F61C0617A9;
        Thu, 10 Sep 2020 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3H9p3uWCKdiQ5NPUZ0WV92/bByweR5cI4Fkw2+XKDQY=; b=WSxHstAYx9AAyZYoQbm0Y+PDlt
        h34LcLsnYclt8Fdvnm838FLQ1TeSX2V3CZ40dj6ezsgPnBiJpwF+6MohWoDy/ct+9O8+Y56a32ZVF
        OItsjbMd7zj0VF3FlCh7qmchU9wtqBW8Hf0iwWW4BAuzATl/U4rNozCE7CmFXBAuR7Wox2pJrPfKP
        OJAEmGI6VdDcpZtkSzrKkS5C406N3F9BAfd5gIL2b6ytfGJz6sU5J6ztgiwa9lheU99rrMTy3Hsgp
        u8VRhCDz4zC8LK4BL2ysIvB30fzTCYG8DYH9wFBQ4ECTyoK9L6cDY7Z7udU295bHcbyq8fKkMBPk/
        9fDmmpKw==;
Received: from [2001:4bb8:184:af1:3ecc:ac5b:136f:434a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGNsY-0006xu-Mz; Thu, 10 Sep 2020 14:48:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 10/12] bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag
Date:   Thu, 10 Sep 2020 16:48:30 +0200
Message-Id: <20200910144833.742260-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910144833.742260-1-hch@lst.de>
References: <20200910144833.742260-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The BDI_CAP_STABLE_WRITES is one of the few bits of information in the
backing_dev_info shared between the block drivers and the writeback code.
To help untangling the dependency replace it with a queue flag and a
superblock flag derived from it.  This also helps with the case of e.g.
a file system requiring stable writes due to its own checksumming, but
not forcing it on other users of the block device like the swap code.

One downside is that we can't support the stable_pages_required bdi
attribute in sysfs anymore.  It is replaced with a queue attribute, that
can also be made writable for easier testing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c         |  4 ++--
 block/blk-mq-debugfs.c        |  1 +
 block/blk-sysfs.c             |  3 +++
 drivers/block/rbd.c           |  2 +-
 drivers/block/zram/zram_drv.c |  2 +-
 drivers/md/dm-table.c         |  6 +++---
 drivers/md/raid5.c            |  8 ++++----
 drivers/mmc/core/queue.c      |  3 +--
 drivers/nvme/host/core.c      |  3 +--
 drivers/nvme/host/multipath.c | 10 +++-------
 drivers/scsi/iscsi_tcp.c      |  4 ++--
 fs/super.c                    |  2 ++
 include/linux/backing-dev.h   |  6 ------
 include/linux/blkdev.h        |  3 +++
 include/linux/fs.h            |  1 +
 mm/backing-dev.c              |  6 ++----
 mm/page-writeback.c           |  2 +-
 mm/swapfile.c                 |  2 +-
 18 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index c03705cbb9c9f2..2b36a8f9b81390 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -408,7 +408,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
-	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	if (disk->queue->ksm) {
@@ -428,7 +428,7 @@ EXPORT_SYMBOL(blk_integrity_register);
  */
 void blk_integrity_unregister(struct gendisk *disk)
 {
-	disk->queue->backing_dev_info->capabilities &= ~BDI_CAP_STABLE_WRITES;
+	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 645b7f800cb827..3094542e12ae0f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -116,6 +116,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(SAME_FORCE),
 	QUEUE_FLAG_NAME(DEAD),
 	QUEUE_FLAG_NAME(INIT_DONE),
+	QUEUE_FLAG_NAME(STABLE_WRITES),
 	QUEUE_FLAG_NAME(POLL),
 	QUEUE_FLAG_NAME(WC),
 	QUEUE_FLAG_NAME(FUA),
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 95eb35324e1a61..d679ef2e08671f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -286,6 +286,7 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -612,6 +613,7 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
+QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
@@ -644,6 +646,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_nomerges_entry.attr,
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
+	&queue_stable_writes_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5d3923c0997ce0..cf5b016358cdab 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5022,7 +5022,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	}
 
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
-		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 
 	/*
 	 * disk_release() expects a queue ref from add_disk() and will
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b51bb664f91f5..2e26e170bd9753 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1954,7 +1954,7 @@ static int zram_add(void)
 	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
-	zram->disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
 	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e1be7697214bd7..fec17f658f58c8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1815,7 +1815,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 {
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 
-	return q && bdi_cap_stable_pages_required(q->backing_dev_info);
+	return q && blk_queue_stable_writes(q);
 }
 
 /*
@@ -1900,9 +1900,9 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	 * because they do their own checksumming.
 	 */
 	if (dm_table_requires_stable_pages(t))
-		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 	else
-		q->backing_dev_info->capabilities &= ~BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
 
 	/*
 	 * Determine whether or not this queue's I/O timings contribute
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7ace1f76b14736..d589d26c86ea3f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6638,14 +6638,14 @@ raid5_store_skip_copy(struct mddev *mddev, const char *page, size_t len)
 	if (!conf)
 		err = -ENODEV;
 	else if (new != conf->skip_copy) {
+		struct request_queue *q = mddev->queue;
+
 		mddev_suspend(mddev);
 		conf->skip_copy = new;
 		if (new)
-			mddev->queue->backing_dev_info->capabilities |=
-				BDI_CAP_STABLE_WRITES;
+			blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 		else
-			mddev->queue->backing_dev_info->capabilities &=
-				~BDI_CAP_STABLE_WRITES;
+			blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, q);
 		mddev_resume(mddev);
 	}
 	mddev_unlock(mddev);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6c022ef0f84d72..80fe3852ce0f75 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -472,8 +472,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 	}
 
 	if (mmc_host_is_spi(host) && host->use_spi_crc)
-		mq->queue->backing_dev_info->capabilities |=
-			BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
 
 	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea1fa41fbba8df..1c9547c7a61388 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3925,8 +3925,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_ns;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
-		ns->queue->backing_dev_info->capabilities
-			|= BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d4ba736c6c8905..74896be40c1769 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -673,13 +673,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		nvme_mpath_set_live(ns);
 	}
 
-	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-		struct gendisk *disk = ns->head->disk;
-
-		if (disk)
-			disk->queue->backing_dev_info->capabilities |=
-					BDI_CAP_STABLE_WRITES;
-	}
+	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
+				   ns->head->disk->queue);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index b5dd1caae5e92d..a622f334c933f5 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -962,8 +962,8 @@ static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
 	struct iscsi_conn *conn = session->leadconn;
 
 	if (conn->datadgst_en)
-		sdev->request_queue->backing_dev_info->capabilities
-			|= BDI_CAP_STABLE_WRITES;
+		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
+				   sdev->request_queue);
 	blk_queue_dma_alignment(sdev->request_queue, 0);
 	return 0;
 }
diff --git a/fs/super.c b/fs/super.c
index 904459b3511995..a51c2083cd6b18 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1256,6 +1256,8 @@ static int set_bdev_super(struct super_block *s, void *data)
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
 
+	if (blk_queue_stable_writes(s->s_bdev->bd_disk->queue))
+		s->s_iflags |= SB_I_STABLE_WRITES;
 	return 0;
 }
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 860ea33571bce5..5da4ea3dd0cc5c 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -126,7 +126,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
 #define BDI_CAP_NO_ACCT_DIRTY	0x00000001
 #define BDI_CAP_NO_WRITEBACK	0x00000002
 #define BDI_CAP_NO_ACCT_WB	0x00000004
-#define BDI_CAP_STABLE_WRITES	0x00000008
 #define BDI_CAP_STRICTLIMIT	0x00000010
 #define BDI_CAP_CGROUP_WRITEBACK 0x00000020
 
@@ -170,11 +169,6 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 long congestion_wait(int sync, long timeout);
 long wait_iff_congested(int sync, long timeout);
 
-static inline bool bdi_cap_stable_pages_required(struct backing_dev_info *bdi)
-{
-	return bdi->capabilities & BDI_CAP_STABLE_WRITES;
-}
-
 static inline bool bdi_cap_writeback_dirty(struct backing_dev_info *bdi)
 {
 	return !(bdi->capabilities & BDI_CAP_NO_WRITEBACK);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 37ec5a73d027b1..3e030085627905 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -606,6 +606,7 @@ struct request_queue {
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 #define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
+#define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
 #define QUEUE_FLAG_WC		17	/* Write back caching */
 #define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
@@ -635,6 +636,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_noxmerges(q)	\
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
 #define blk_queue_nonrot(q)	test_bit(QUEUE_FLAG_NONROT, &(q)->queue_flags)
+#define blk_queue_stable_writes(q) \
+	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbd74df5ce5f34..222465b7cf4178 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1385,6 +1385,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
 #define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
 #define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
+#define SB_I_STABLE_WRITES 0x00000008	/* don't modify blks until WB is done */
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 2dac3be6127127..f9a2842bd81c3d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -204,10 +204,8 @@ static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *page)
 {
-	struct backing_dev_info *bdi = dev_get_drvdata(dev);
-
-	return snprintf(page, PAGE_SIZE-1, "%d\n",
-			bdi_cap_stable_pages_required(bdi) ? 1 : 0);
+	pr_info_once("the stable_pages_required attribute has been deprecated\n");
+	return snprintf(page, PAGE_SIZE-1, "%d\n", 0);
 }
 static DEVICE_ATTR_RO(stable_pages_required);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4e4ddd67b71e58..e9c36521461aaa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2849,7 +2849,7 @@ EXPORT_SYMBOL_GPL(wait_on_page_writeback);
  */
 void wait_for_stable_page(struct page *page)
 {
-	if (bdi_cap_stable_pages_required(inode_to_bdi(page->mapping->host)))
+	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
 		wait_on_page_writeback(page);
 }
 EXPORT_SYMBOL_GPL(wait_for_stable_page);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 986fe5aad30e18..c119b839937d65 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3234,7 +3234,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
-	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
+	if (p->bdev && blk_queue_stable_writes(p->bdev->bd_disk->queue))
 		p->flags |= SWP_STABLE_WRITES;
 
 	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
-- 
2.28.0

