Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D751CEFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgELI41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16030 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgELI4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273779; x=1620809779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vC6fIcl8UNycAk5TzfaPQt3mtOYMSDj8SXxAWxcvzvc=;
  b=Ns7PA6lG99vwlgZlrVSqRNbClpV7y1gnwJBDWS0Mwyq9Qb8j7G2kNPRW
   PR7zEjUCHnJxXQWYchxNPXf0AIs2qT0xLIQBsfNHMZnZvioJB9ZTudJnp
   rVfFUg2Wqe4n1oBRf5W8RY+CxCYjb3eFJPXgOO6qx4OS5rLvQPCBZmSrs
   FEe+Wa5ENcsnQGIQ7KQgK/wxw2SNfK1oKtQpZEQ4x1NN7B1dTd/5Hb2zG
   M4fO+kebsv4FZ4cc7EghuueiEgfSXh9DiH2M1IrJpojT7ppSj1DaKX99J
   O85/7iXrQp90JM6aTDbAVYgxbtfr5HKSIZ8CsERj80IjmBjAmZ3n2ZU6S
   Q==;
IronPort-SDR: GBdPTr2AD2KlxPbjrngsyjfBSmDEi8yGmg8/xP7zWQ6Ze0N/5Xdn68tXaXfwP+qLoKMTVUiWsR
 HcmKOZ+GCHpE38R7NExXEBWFaD14RW6hIfPH0mmYb47hv6QC8NtjaThoAo1F4La4J1PIMghSdo
 myri+r0HdNq5ruhn06FTMBneA57QBOjzmRVXMDYp8MpBhPByoEEaXpQFwJpumCXkbtv9I3EqP6
 0clikxc+pItGHDz9144M14Bc753iQyO52WsEPOQUKBp8uxIv7lnch4TG37ZN5EC1JN4U8aCrUu
 SEI=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823569"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:19 +0800
IronPort-SDR: b3/+sDJF7rG452guAAQ3a1Xm2TZwQDnaaBJd4hTQgtLClKiSBDz0c2srzW5BGXmu4p0NYvqRnM
 P9RVaw+13ZtKQ9DVo5un47PyXSEf7jelc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:46:01 -0700
IronPort-SDR: Q6NfnjeDGmusNEvKwosiFCbvk/4Tf4DAeNFqZ1zFfe43aN/XU4/bNCW15TtqA6PFf5hh4uToOE
 t78W65S2nsIA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:16 -0700
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
Subject: [PATCH v11 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Tue, 12 May 2020 17:55:52 +0900
Message-Id: <20200512085554.26366-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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

