Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA01BA26B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD0Lc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54662 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgD0LcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987140; x=1619523140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EptpuszxKds2VZq8D512Jp2spjpDwJgzg8AZNAyDqGo=;
  b=IIpAcMEIIueytAwThmdTA0BXw9+KC9SP+BKVCYesyNlWwEOZswGTZrlr
   VVCDw9vdf77glveaGOGKRuDSQ5jxOJE7n6H06tXmZEveP2FvAVpKBWcQO
   k3n9Tw8Bwj3MkGR9vroZBG/xs2rYNIARP8JPSquqywmKRH4MoVz2DBkvI
   RLcCj99Iq0I3AJnrATsuxN3iWUWHqy0UdAoK54ukklRIQ4qWTwDw++B3a
   60VP1sNAvy1p6QIcwPOTp7gZOns1MTGS6M++JQrvvbebSy/Gvue+7mJL8
   GAeznCg/kYGhwVwo4DYvwykouq03RLHl3XGtEZhScIsTZjkdyaj4f9JzP
   A==;
IronPort-SDR: R9grZ0oEVQO1RmjNn36AC9ZsMxZCKkzBOVdiFDy2VAbA8QpeTVmev/8N4ZGa8F3armNqc/7ajb
 eYD1SSEhnkUWhJ2fqvYM7FdiUMre2Lu8E43TuTsqDFgafG0b3DLzMvHLIDeOuMMSCj+OuWhphM
 jmF3O6GssH68hrYsv2jQrwz5f3eQRs4C9chapMZCIYIwQM7xATfScf2Kl3Fjc+eaHDqtCA+A0e
 mAzjDftCcZ3JBXE96EyJEwVbYO9FVIdwwNfmiAUIJEK66hokvCcO8f4foBA+T4BZ2x4JqBCFFA
 uAk=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136552035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:20 +0800
IronPort-SDR: QZ2NIkzrdR/Z1q2cLylf6ZqDcWQem4pon1iCbqybiy49vcQlBXST3idxm4XC5jb4b+MufHw7qZ
 GvFwdgyS4sgrW3PtSmKXlpK2dXZ9uiWoY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:23:01 -0700
IronPort-SDR: vfUVC7uHLoWZ3TDoSVDVw28e98w6YGN+jFV0a7HM9ARWgY14/J3BXOLuUZBrJCC94+nmENXB4W
 CrFkJ5DiDU0Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 09/11] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Mon, 27 Apr 2020 20:31:51 +0900
Message-Id: <20200427113153.31246-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Support REQ_OP_ZONE_APPEND requests for null_blk devices with zoned
mode enabled. Use the internally tracked zone write pointer position
as the actual write position and return it using the command request
__sector field in the case of an mq device and using the command BIO
sector in the case of a BIO device.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_zoned.c | 39 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 46641df2e58e..5c70e0c7e862 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -70,13 +70,22 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 int null_register_zoned_dev(struct nullb *nullb)
 {
+	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk, NULL);
+	if (queue_is_mq(q)) {
+		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
+
+		if (ret)
+			return ret;
+	} else {
+		blk_queue_chunk_sectors(q, dev->zone_size_sects);
+		q->nr_zones = blkdev_nr_zones(nullb->disk);
+	}
 
-	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
-	q->nr_zones = blkdev_nr_zones(nullb->disk);
+	blk_queue_max_zone_append_sectors(q,
+			min_t(sector_t, q->limits.max_hw_sectors,
+			      dev->zone_size_sects));
 
 	return 0;
 }
@@ -138,7 +147,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 }
 
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-		     unsigned int nr_sectors)
+				    unsigned int nr_sectors, bool append)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -158,9 +167,21 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
-		/* Writes must be at the write pointer position */
-		if (sector != zone->wp)
+		/*
+		 * Regular writes must be at the write pointer position.
+		 * Zone append writes are automatically issued at the write
+		 * pointer and the position returned using the request or BIO
+		 * sector.
+		 */
+		if (append) {
+			sector = zone->wp;
+			if (cmd->bio)
+				cmd->bio->bi_iter.bi_sector = sector;
+			else
+				cmd->rq->__sector = sector;
+		} else if (sector != zone->wp) {
 			return BLK_STS_IOERR;
+		}
 
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
@@ -242,7 +263,9 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 {
 	switch (op) {
 	case REQ_OP_WRITE:
-		return null_zone_write(cmd, sector, nr_sectors);
+		return null_zone_write(cmd, sector, nr_sectors, false);
+	case REQ_OP_ZONE_APPEND:
+		return null_zone_write(cmd, sector, nr_sectors, true);
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
-- 
2.24.1

