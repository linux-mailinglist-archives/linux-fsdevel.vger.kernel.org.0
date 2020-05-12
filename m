Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8511CEFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgELI4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16027 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgELI4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273775; x=1620809775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5AG8nHQvcBfTW7D00G9a2jNlsRVALeJYYmeP1Th5QM=;
  b=Wq8TONs41wcWDspoz0txZVmlnfdNKwW9lZd0QjDfKx/9X6zrk49w3B4v
   o7P2VY2REBUK5lAIVxNlOlFEcAEA5pxeTo9Vhhx/bgHE1pKGGWxoLtoxk
   QhpOd0WLidR38/ViYi7hmHjtmAOoI0g6DWLztBZTb8FvEKwmgRz/rSZPb
   Sf/ngFcI3YsHhciJuW3OxIADsLJSdzVKlt79+VFN3v8Z6QgtAc4P8e2RB
   GAzEDZbgB01Ujpt4YskocoodWuMAovKczyv2EI3ZWVpwpSysO+UAcMeLe
   Fld+lzQzrUMxy26QmxFoXpVErcyKK4SyN4AFqJfEWynxbfzd9WMLNvZkF
   g==;
IronPort-SDR: XDr0ozXmhBtA+BHOa7HMBBjKLAvh4xwpzTpPah5CrPGPZhXXuzywPtdFA5Ruk3sQziK/f6498H
 +SP64eqfKncRg6ZrMj2mVTbit06Ma69x86MVkqVUcRA1It+p7j353IBUEby//CLeJfpitnma/7
 IBV6jaWNUNwPaS14sxiI3j95u4Y0K9BuFKkI9wwSjsemDXEevh6Q1OS8V448ZKVdxPsH0BlC7R
 ONSDCkeNC8p/9ewv9eMnC3FEsmaMpxHoyVnGZF/1bfQm9OUtyotqsAvOyJQZCju5e8ZSMvas8t
 m1c=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823561"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:15 +0800
IronPort-SDR: nxkIwNqd6BTnLuy+ciBRqHRpUKLUcEZej5S57yQd8JTAdALLdVo8s0cEArutoy9T+mFvehpGku
 nAxLjoL9enn7CiwJgSAkrWMMZFY0sWxrE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:45:57 -0700
IronPort-SDR: Cuz9BrMYQRKWCiVwtppbxEBe6Ov0o1Pc5XoQaTGlrvVqv3WOzToinuy3eA81LFN7ecuqwj5jQ3
 ja6wYIIgp6sA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:12 -0700
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
Subject: [PATCH v11 06/10] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Tue, 12 May 2020 17:55:50 +0900
Message-Id: <20200512085554.26366-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

