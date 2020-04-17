Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1941ADD15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgDQMPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:15:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50633 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDQMPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125750; x=1618661750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pELZdFaBDOCSlhpLmW1NsDce5dkjBcqSqBPgtxDGc4=;
  b=NQP5EzOAraAAHtDKEJp7eWd8h0YJmBNMOikztMS8Li6h9Hjh2jU25it0
   XmZfNE60DmE/u3j2GAnczSNE27W6QNhQsmQZd5GWOeSeVAkZ2gq7IuZCA
   sW6mzlptnbcDxTXEa5g5F7O/3sZOVRpsTxbPcJGtbLSSoZ6OrD5+hKIkz
   lWstjdrYZKMmL6sDABF51QkiqFIk1NYpe8XbGLlk1alZyaiQHjrEEtrYf
   auibSl6904aDDEHoLRy9tp6Q6tcOUusniaB294mSBeNZqSf8TNKq3Y39d
   Fqp9JzkabKj6nO8q9X35iuuDKgzR1V1uNn8JW+wFaq1W2H52+fSUvnVPo
   A==;
IronPort-SDR: cwpUUwDFj4xbTmfopd4V7+miE+iYlrmyb4caUf5fjGwmips11Pvi0iDqeMshRYRIL2uneGcOGb
 Qf7m8jCisbpbhp0YJacGNfXoLcOGn0msAVliO3B9Dn8ZBuanDtQ1PY00tvxfHGGtD1B72gnUgm
 MvhZhN6Om73ntMHGqtbmniToBC8maKxLOCnMRxLWCKvcTQh1U0JVNQ98gFNVIt8ReMgnV+lN2q
 qWUInJ5b3hZ1nlIbmN12bGGJUkKqvvPhC6lylkGNnaWiFFsrdMI97mePibNVYNSpq2wiFxbLUY
 deE=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989186"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:15:50 +0800
IronPort-SDR: 5d0Cb1mVcBKFHm3FqcuOIIgGeM7r8tOwejOtdz+AEcaluHX75F/+UBhYEBnFDh2a/KbEr7oTDQ
 bdhCeOCnXUwB0mnOyKnx7TG1lsrIPKchk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:06:46 -0700
IronPort-SDR: liTpkeGF1lG49RXI90uJk/vixLqudWjSqAV2T6JkKWifx2cfZHGE5o3O7LBg5B5WZjsjKPrsRP
 axcuwLRS6OxQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:15:46 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Date:   Fri, 17 Apr 2020 21:15:26 +0900
Message-Id: <20200417121536.5393-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case scsi_setup_fs_cmnd() fails we're not freeing the sgtables
allocated by scsi_init_io(), thus we leak the allocated memory.

So free the sgtables allocated by scsi_init_io() in case
scsi_setup_fs_cmnd() fails.

Technically scsi_setup_scsi_cmnd() does not suffer from this problem, as
it can only fail if scsi_init_io() fails, so it does not have sgtables
allocated. But to maintain symmetry and as a measure of defensive
programming, free the sgtables on scsi_setup_scsi_cmnd() failure as well.
scsi_mq_free_sgtables() has safeguards against double-freeing of memory so
this is safe to do.

While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/scsi_lib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..ad97369ffabd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -548,7 +548,7 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 	}
 }
 
-static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
+static void scsi_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table,
@@ -560,7 +560,7 @@ static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
 }
 
@@ -1059,7 +1059,7 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 
 	return BLK_STS_OK;
 out_free_sgtables:
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	return ret;
 }
 EXPORT_SYMBOL(scsi_init_io);
@@ -1190,6 +1190,7 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
 		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
 
 	if (!blk_rq_bytes(req))
 		cmd->sc_data_direction = DMA_NONE;
@@ -1199,9 +1200,14 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
 		cmd->sc_data_direction = DMA_FROM_DEVICE;
 
 	if (blk_rq_is_scsi(req))
-		return scsi_setup_scsi_cmnd(sdev, req);
+		ret = scsi_setup_scsi_cmnd(sdev, req);
 	else
-		return scsi_setup_fs_cmnd(sdev, req);
+		ret = scsi_setup_fs_cmnd(sdev, req);
+
+	if (ret != BLK_STS_OK)
+		scsi_free_sgtables(cmd);
+
+	return ret;
 }
 
 static blk_status_t
-- 
2.24.1

