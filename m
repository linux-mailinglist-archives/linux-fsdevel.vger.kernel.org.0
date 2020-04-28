Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC891BBB8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgD1Kqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15249 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgD1Kq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070792; x=1619606792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4fUV2SdvmXgOxK/BRh9JsxnoYJnwwOuISADQEVle6kE=;
  b=ketWsSAqc4BFlfsNLpgM3L94ezOrhOPaVRhxXE0f0Fjoo9d7t+XZHBCH
   mctqlLa2tm81HnWDlsqd7O8iFhnpJfNgECNeQQpXRope07aFJNCr2gJwy
   KQf7anR4qZ1Jum7Dw2d+8PWCdwzURCGrU9HQC+gT706SahfvLP75MVeg4
   FdUfY/V6qqKWnPbLFyEygu5Dv9stIx3SShejWjXoVdYSXaQZmK8mQqK+L
   Qa424ZMLJzQ6bQ2qgddWRAfNRwg1ILry1UZZpIZqNONRRLcKM5v7YpmYE
   obP0xlvx86a75QEkPqyf6RXXDBWYH6oV+srbvJ62z77ym/f4UpfRDHNdF
   A==;
IronPort-SDR: tRGtXVBVhZBGfexv0ULEkzT3Ys2H1RTz/YNPFrCu5483qfP7p6Fo3JieZ00qn+Cmh+zaqo6RVz
 YY7BDxLpXTemGbAv8SNGb70/hA++nqnMXIZ/kVLSzIbEXV/QCTnQqUUuKiPeA/PzqzRhTFxwlD
 DVbx1GYnLkCma6Hmo2hA1UnUhqY4tO7vrHkpUOWHJlsRCbkaKc4/4eFESf2kO2XsJ4LPVOW7O+
 c+Wj8ouXC5zRSkejPVCnuciwIdIhsgjSTr0RcpNV9Tc3Pn/JB0Jow1Tx99StZBFIBaBYtYiiQ7
 7ng=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886593"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:32 +0800
IronPort-SDR: 8AbiBEVf2LgU22Hp+umCm298XfB/Ta85IRdp8YnVV7fjNAATFBrSKhxUxdfr8zJgjeIOVceKqN
 NnWg/1SqVCZ1zHTa4HZPpt0kYyGLal29k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:34 -0700
IronPort-SDR: IIyJYJpQhzTEZBlLfC3iyBGwRjEm5/+WvjR9lb1SCzClHltTsY/8QoKSwgYM+UiFpXIbIIkWGh
 bryyNOo/TKDA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:25 -0700
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
Subject: [PATCH v9 09/11] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Tue, 28 Apr 2020 19:46:03 +0900
Message-Id: <20200428104605.8143-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
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

