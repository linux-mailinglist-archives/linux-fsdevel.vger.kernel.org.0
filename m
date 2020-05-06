Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE821C75FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgEFQMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 12:12:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61321 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgEFQMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588781525; x=1620317525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vC6fIcl8UNycAk5TzfaPQt3mtOYMSDj8SXxAWxcvzvc=;
  b=Jf14kAxAsF5HSX2SzYOgVzn6YhYmq0dopql9aWSwCMsxmyFTXsG3qHWJ
   w6cwNavByAl8fVPxodHlAracsw9nnfAWtaRE/PBlpKKyijgLP7oCLlKYa
   iR5I60qX3UqXxYOdiqKuVEGA7B+AWYNvrrr5zYnynsTnAPYlSoREm75zb
   bCm6BFO7yqhJqPK0FyLwrhcjU37QSIv9qNxpmhjVrg9FCwYSlzzQwksO4
   u7ago/en3cYNjsHeWu79u0AUyH+X5qKRLU9e4lUdcz/nanzEtigozWmzS
   6JiG0QZfHtDeIppWJYbiFNDD60UaEO8u3Ln5N1KzZRZ0n4yNsqzZFu0+A
   g==;
IronPort-SDR: BhciZIlkJxhKIMKEcXZ3A8xRSZ/LpTAH6jnu9t8YLnqozw7u93aF56YWPUy6VjzzjeXOzfCFqN
 FxrLMOE/4FZkn7n1gqQB1EojtXXSDZKxN903GeoLNnaU0jBDq8SthdCG7xCsANVKSUoLTVAqOi
 fBsEjvhZ9wyLHDhg5TfmoYa29fLAcbkNa6XmrJKR7KrFhdct2xZkb/eelNzogJ3B7GTteyEr+x
 /0EWwBU9Czaui3Tamm7hPVM57xXpVCFUeV96w4THSX/IMf9oONQJHOB2DUAHWxXROfqZIb0ayi
 Kf4=
X-IronPort-AV: E=Sophos;i="5.73,359,1583164800"; 
   d="scan'208";a="245917913"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 00:12:05 +0800
IronPort-SDR: 3xu854Fydizjk6rkWTHGN+KUgcwRdAyLKP9d8jTD2M4o9cMEGv4ybeXzxes9ksfGU6SgsgxUWT
 j3hK8wuTaQfCn+yvaj/CMGJbtv8BUdQk0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 09:02:30 -0700
IronPort-SDR: 9zips//CtNjVuZBiEXmIhcmdhx7wgGq07hsUVg+6j51E9J3Kludh6Kp5eNR0pWmr6FIVAxLu66
 KSYk0269+EYQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2020 09:12:03 -0700
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
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 7/9] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Thu,  7 May 2020 01:11:43 +0900
Message-Id: <20200506161145.9841-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
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

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_zoned.c | 37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 46641df2e58e..9c19f747f394 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -70,13 +70,20 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
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
+	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
 
 	return 0;
 }
@@ -138,7 +145,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 }
 
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-		     unsigned int nr_sectors)
+				    unsigned int nr_sectors, bool append)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -158,9 +165,21 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
@@ -242,7 +261,9 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
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

