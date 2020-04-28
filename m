Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1401BBB80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD1KqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15241 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgD1KqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070786; x=1619606786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3fIOLyXPW54CgD9Ij3V/gvCfjDbgKSKZzC8AQRd6oAc=;
  b=k4xhL0ra1N8HuFIef8XEF9gU1TQDKTPJS0UVUVYF22IJf+1uwKwM+8wH
   9fx1dbGboo/G8VPIRbUr6zeZ1rHAL8R1QkrraGy/PKKpstw4m1uU1uSHm
   4kvSrwzzPqWv/h08C9fAZDtieIQ54l2zV7nzw3hKXluEVfD51cx5oX9ju
   pVxd6iyrqIUfRatLpb+Z3YIYNQyfbQpFVc0WNhwbGsx5tkSDYz4qYMaJV
   GDLgct4OJ2CTFtz6OXTa0d78Kz7rZzzDYuloOmGBrQbBsndB9ep7OlpfR
   NPnaPso2JOq6vTe90GEafkdjfGoC54q3G42o+F76SqgSD9mQ6xakIgEOw
   g==;
IronPort-SDR: OtprGDXYzkSzkYel4ltT1reULAZjtgmTZlzYIEspfM63Sa5CXzhj1EXVohtfEzVjmha7LpI3vK
 OEvQi5Iu08GnAxqtJ9jgvupsTUX04uj0D+o3/BY5y/G7Omj9p5yeejJq95wijT3akwtVSA0whv
 3OCiDtWci56PNEQtWX2AhoYzwt9E9ZLW2I1REomr8ilOMx4ZxauFxYedgVHj+1MZth7KQAVtgn
 wTLaOo4WCO4Bx+KKbZpcP7IChaTWg5frq92OsCzd9qdSNJwHcAT8Z6wOJvO2y9taWmcWd2Ijr/
 IUM=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886585"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:26 +0800
IronPort-SDR: ZRtCOVGQr+pep7hlelK3tL7KRHry9Mz2Wav6vHvkZZhcWzkNTdnYsdQ7WIR3Dz8cxSuGQQfuN/
 tZvp2IhhS/zIvEFO1AOhG34fus9VSeH9M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:31 -0700
IronPort-SDR: GJOYlJsOIerAEmO+l3uWs4VG9iWoRzSdJR6eGd5CHFP4cZPnwA89IbB9jECfdIZiqu+rQ3CpW1
 NRsnQP+MYi9Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:21 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v9 07/11] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Tue, 28 Apr 2020 19:46:01 +0900
Message-Id: <20200428104605.8143-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor sanity checks for zoned commands from sd_zbc_setup_zone_mgmt_cmnd().

This will help with the introduction of an emulated ZONE_APPEND command.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/sd_zbc.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index f45c22b09726..ee156fbf3780 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -209,6 +209,26 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	return ret;
 }
 
+static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
+{
+	struct request *rq = cmd->request;
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	sector_t sector = blk_rq_pos(rq);
+
+	if (!sd_is_zoned(sdkp))
+		/* Not a zoned device */
+		return BLK_STS_IOERR;
+
+	if (sdkp->device->changed)
+		return BLK_STS_IOERR;
+
+	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
+		/* Unaligned request */
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
 /**
  * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
  *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
@@ -223,20 +243,14 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all)
 {
 	struct request *rq = cmd->request;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t sector = blk_rq_pos(rq);
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t block = sectors_to_logical(sdkp->device, sector);
+	blk_status_t ret;
 
-	if (!sd_is_zoned(sdkp))
-		/* Not a zoned device */
-		return BLK_STS_IOERR;
-
-	if (sdkp->device->changed)
-		return BLK_STS_IOERR;
-
-	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
-		/* Unaligned request */
-		return BLK_STS_IOERR;
+	ret = sd_zbc_cmnd_checks(cmd);
+	if (ret != BLK_STS_OK)
+		return ret;
 
 	cmd->cmd_len = 16;
 	memset(cmd->cmnd, 0, cmd->cmd_len);
-- 
2.24.1

