Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485E502264
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiDOE5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349744AbiDOE4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:56:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808275C16;
        Thu, 14 Apr 2022 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fsm4eQJmjNs7mthWl6aQ0QoznH4mW7xZq3krP8KP9Uc=; b=Kc0kFPKNrBsztP51rQrb436EpC
        clkRG1c+RWauytSxyP1VZHzZm0k/n/bJiQF9offdgxlhFL9TpCe41mL4yiFXHZXG7NN3dZBqQWTyh
        VS32YFvooKg6jmcfwAv8iLy6ibtMV7kgdq4kptYmhPm0Z6NWmVX2oFVQWm6WbZ6ctUwWMEvyxnK3Y
        b9ovdNw4IiS4Q9grCcaQcJlT12XLY6ANDPyUjFzxFxy5R6sXbufEUiOBD2A9POWjPp9fJgc5BHmlx
        btpCR9+B/FjoYWNox5ht1MfT6qlsZJ4E91t9jc1UTJI5F9kZQSgKF9QlK5aIdPlC3AU3hlr6Kf/BQ
        9t86XlyA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfDxn-008P9R-W4; Fri, 15 Apr 2022 04:53:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 12/27] block: add a bdev_write_cache helper
Date:   Fri, 15 Apr 2022 06:52:43 +0200
Message-Id: <20220415045258.199825-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
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

Add a helper to check the write cache flag based on the block_device
instead of having to poke into the block layer internal request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 drivers/block/rnbd/rnbd-srv.c       | 2 +-
 drivers/block/xen-blkback/xenbus.c  | 2 +-
 drivers/target/target_core_iblock.c | 8 ++------
 fs/btrfs/disk-io.c                  | 3 +--
 include/linux/blkdev.h              | 5 +++++
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index f04df6294650b..f8cc3c5fecb4b 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -558,7 +558,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 	rsp->secure_discard =
 		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
 	rsp->cache_policy = 0;
-	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (bdev_write_cache(rnbd_dev->bdev))
 		rsp->cache_policy |= RNBD_WRITEBACK;
 	if (blk_queue_fua(q))
 		rsp->cache_policy |= RNBD_FUA;
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index f09040435e2e5..8b691fe50475f 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -517,7 +517,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		vbd->type |= VDISK_REMOVABLE;
 
 	q = bdev_get_queue(bdev);
-	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (bdev_write_cache(bdev))
 		vbd->flush_support = true;
 
 	if (q && blk_queue_secure_erase(q))
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index b41ee5c3b5b82..03013e85ffc03 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -737,7 +737,7 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
 			if (cmd->se_cmd_flags & SCF_FUA)
 				opf |= REQ_FUA;
-			else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+			else if (!bdev_write_cache(ib_dev->ibd_bd))
 				opf |= REQ_FUA;
 		}
 	} else {
@@ -886,11 +886,7 @@ iblock_parse_cdb(struct se_cmd *cmd)
 
 static bool iblock_get_write_cache(struct se_device *dev)
 {
-	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
-	struct block_device *bd = ib_dev->ibd_bd;
-	struct request_queue *q = bdev_get_queue(bd);
-
-	return test_bit(QUEUE_FLAG_WC, &q->queue_flags);
+	return bdev_write_cache(IBLOCK_DEV(dev)->ibd_bd);
 }
 
 static const struct target_backend_ops iblock_ops = {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b30309f187cf0..092e986b8e8ed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4247,8 +4247,7 @@ static void write_dev_flush(struct btrfs_device *device)
 	 * of simplicity, since this is a debug tool and not meant for use in
 	 * non-debug builds.
 	 */
-	struct request_queue *q = bdev_get_queue(device->bdev);
-	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (!bdev_write_cache(device->bdev))
 		return;
 #endif
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3a9578e14a6b0..807a49aa5a27a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1331,6 +1331,11 @@ static inline bool bdev_nonrot(struct block_device *bdev)
 	return blk_queue_nonrot(bdev_get_queue(bdev));
 }
 
+static inline bool bdev_write_cache(struct block_device *bdev)
+{
+	return test_bit(QUEUE_FLAG_WC, &bdev_get_queue(bdev)->queue_flags);
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.30.2

