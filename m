Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8E4FA324
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 06:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiDIExM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Apr 2022 00:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiDIExC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:53:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFDA186F5;
        Fri,  8 Apr 2022 21:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6JVZQz23Gg3oLV4oYc05UwmOH+nGeMd1Qpin5+I9KgM=; b=T+9t+qRVixcYOKTh1AUVT25z0M
        +SeVr5+q6XffdW1kFW64UkJe5HiR1JzBYZYydkfDGnhvPDwIWt1BqK0kdRpQlzNS/wUGgV0dz2FlC
        P9lWy4ngvRvWzpwNKC0K2fF5KsKRF9WdU7qIRMHjoHzTM+p/DmxnFS/6hYJwPtf1Atl9jbNqvHRbW
        tlOYlU8ufbWGBydt1bUmPAZA5D8zkMlkbBnkY22C2NT6vnnROSTB46+rpRyEX5lzOjlaPcp8DwJyC
        bbKS1PGTuIP4F/DHMFVbTCV/5B0d0tMWG8vDpg/SA6IBHxSKH9SXtm1xmXyImu30Ag6d2DwUVgBc6
        Y9GfxcxA==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd33l-0020TC-Pz; Sat, 09 Apr 2022 04:50:54 +0000
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
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 02/27] target: pass a block_device to target_configure_unmap_from_queue
Date:   Sat,  9 Apr 2022 06:50:18 +0200
Message-Id: <20220409045043.23593-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
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

The SCSI target drivers is a consumer of the block layer and shoul
d generally work on struct block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/target/target_core_device.c  | 5 +++--
 drivers/target/target_core_file.c    | 7 ++++---
 drivers/target/target_core_iblock.c  | 2 +-
 include/target/target_core_backend.h | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index fa866acef5bb2..3a1ec705cd80b 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -834,9 +834,10 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
  * in ATA and we need to set TPE=1
  */
 bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
-				       struct request_queue *q)
+				       struct block_device *bdev)
 {
-	int block_size = queue_logical_block_size(q);
+	struct request_queue *q = bdev_get_queue(bdev);
+	int block_size = bdev_logical_block_size(bdev);
 
 	if (!blk_queue_discard(q))
 		return false;
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 8190b840065f3..8d191fdc33217 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -134,10 +134,11 @@ static int fd_configure_device(struct se_device *dev)
 	 */
 	inode = file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
-		struct request_queue *q = bdev_get_queue(I_BDEV(inode));
+		struct block_device *bdev = I_BDEV(inode);
+		struct request_queue *q = bdev_get_queue(bdev);
 		unsigned long long dev_size;
 
-		fd_dev->fd_block_size = bdev_logical_block_size(I_BDEV(inode));
+		fd_dev->fd_block_size = bdev_logical_block_size(bdev);
 		/*
 		 * Determine the number of bytes from i_size_read() minus
 		 * one (1) logical sector from underlying struct block_device
@@ -150,7 +151,7 @@ static int fd_configure_device(struct se_device *dev)
 			dev_size, div_u64(dev_size, fd_dev->fd_block_size),
 			fd_dev->fd_block_size);
 
-		if (target_configure_unmap_from_queue(&dev->dev_attrib, q))
+		if (target_configure_unmap_from_queue(&dev->dev_attrib, bdev))
 			pr_debug("IFILE: BLOCK Discard support available,"
 				 " disabled by default\n");
 		/*
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 87ede165ddba4..b886ce1770bfd 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -119,7 +119,7 @@ static int iblock_configure_device(struct se_device *dev)
 	dev->dev_attrib.hw_max_sectors = queue_max_hw_sectors(q);
 	dev->dev_attrib.hw_queue_depth = q->nr_requests;
 
-	if (target_configure_unmap_from_queue(&dev->dev_attrib, q))
+	if (target_configure_unmap_from_queue(&dev->dev_attrib, bd))
 		pr_debug("IBLOCK: BLOCK Discard support available,"
 			 " disabled by default\n");
 
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index 675f3a1fe6139..773963a1e0b53 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -14,7 +14,7 @@
 #define TRANSPORT_FLAG_PASSTHROUGH_ALUA		0x2
 #define TRANSPORT_FLAG_PASSTHROUGH_PGR          0x4
 
-struct request_queue;
+struct block_device;
 struct scatterlist;
 
 struct target_backend_ops {
@@ -117,7 +117,7 @@ sense_reason_t passthrough_parse_cdb(struct se_cmd *cmd,
 bool target_sense_desc_format(struct se_device *dev);
 sector_t target_to_linux_sector(struct se_device *dev, sector_t lb);
 bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
-				       struct request_queue *q);
+				       struct block_device *bdev);
 
 static inline bool target_dev_configured(struct se_device *se_dev)
 {
-- 
2.30.2

