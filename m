Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F732B486E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbgKPPFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgKPO6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375BC0613D1;
        Mon, 16 Nov 2020 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gB9wX8Sf5Fr0vBVAuUG0acKrf9nR5B+BsqLVZ7zKAPE=; b=hPdBqu7LASCimrqoWvJWekgiwM
        e6sFN9M6496yHhIwQZ8SVDNPv85Fa5P7ZEcnY74J6Tt2EVaQ1HjE7fGy6Qo/q8v9uzp6sD/vtDi3k
        x+AFEwLxBM9S/UHTZAELAThsMlf8jyW4aFqZBbR6MMz+Vsa4kuh+hdpwNonyepLm5hF/WY/im2Qsp
        M27a3ymH344cKP7AJlnEbQ1ShVBTdT3pN0ujj3wBLxRxqpqeL17Wc9RHjP5WuygZtcYOLRkmU6YW7
        qqsDvFjX11ndArIbuj3JsnUHh/P8r/XoLsW781HNKdSvw8XE1eNQ7Y5+/zRvydj78vPLvJktJkTdb
        /FmNl3CA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxQ-0003jM-O4; Mon, 16 Nov 2020 14:58:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 05/78] block: remove the update_bdev parameter to set_capacity_revalidate_and_notify
Date:   Mon, 16 Nov 2020 15:56:56 +0100
Message-Id: <20201116145809.410558-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The update_bdev argument is always set to true, so remove it.  Also
rename the function to the slighly less verbose set_capacity_and_notify,
as propagating the disk size to the block device isn't really
revalidation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 block/genhd.c                | 13 +++++--------
 drivers/block/loop.c         |  2 +-
 drivers/block/virtio_blk.c   |  2 +-
 drivers/block/xen-blkfront.c |  2 +-
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  5 ++---
 include/linux/genhd.h        |  3 +--
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9387f050c248a7..8c350fecfe8bfe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,17 +46,15 @@ static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
 /*
- * Set disk capacity and notify if the size is not currently
- * zero and will not be set to zero
+ * Set disk capacity and notify if the size is not currently zero and will not
+ * be set to zero.  Returns true if a uevent was sent, otherwise false.
  */
-bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool update_bdev)
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 {
 	sector_t capacity = get_capacity(disk);
 
 	set_capacity(disk, size);
-	if (update_bdev)
-		revalidate_disk_size(disk, true);
+	revalidate_disk_size(disk, true);
 
 	if (capacity != size && capacity != 0 && size != 0) {
 		char *envp[] = { "RESIZE=1", NULL };
@@ -67,8 +65,7 @@ bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 
 	return false;
 }
-
-EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
+EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
 /*
  * Format the device name of the indicated disk into the supplied buffer and
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0a0c0c3a68ec4c..84a36c242e5550 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -251,7 +251,7 @@ loop_validate_block_size(unsigned short bsize)
  */
 static void loop_set_size(struct loop_device *lo, loff_t size)
 {
-	if (!set_capacity_revalidate_and_notify(lo->lo_disk, size, true))
+	if (!set_capacity_and_notify(lo->lo_disk, size))
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a314b9382442b6..3e812b4c32e669 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -470,7 +470,7 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);
+	set_capacity_and_notify(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 48629d3433b4c3..79521e33d30ed5 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2370,7 +2370,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity_revalidate_and_notify(info->gd, sectors, true);
+		set_capacity_and_notify(info->gd, sectors);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f6c6479da0e9ec..6c144e748f8cae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2053,7 +2053,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
-	set_capacity_revalidate_and_notify(disk, capacity, true);
+	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4a34dd5b153196..a2a4f385833d6c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3263,8 +3263,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity_revalidate_and_notify(disk,
-		logical_to_sectors(sdp, sdkp->capacity), true);
+	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
@@ -3274,7 +3273,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 * capacity to 0.
 	 */
 	if (sd_zbc_revalidate_zones(sdkp))
-		set_capacity_revalidate_and_notify(disk, 0, true);
+		set_capacity_and_notify(disk, 0);
 
  out:
 	return 0;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 03da3f603d309c..4b22bfd9336e1a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,8 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-		bool update_bdev);
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.29.2

