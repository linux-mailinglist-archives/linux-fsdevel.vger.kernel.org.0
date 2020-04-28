Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41C1BBB6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgD1KqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15223 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgD1KqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070773; x=1619606773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YuZuzegoqN8PtLpqyYOjTJaDMOiwKd1UNcXgvMnGaKw=;
  b=kCzOwWS0+MW3A8XufeJFzf+5gdoRWn3u4awhjsVv5o3Na0VFRY/bmfP2
   +Jyoao1LHh/TvqwMdyLV4zRGx/0O9rmzVGn2JGijayoyQwjPAkC8etyqN
   8wK4rTg3WikGe1P2Za4MUy5kK2Kv0dHWyKuffKyWpjAl/CaDjrdFlqzSP
   98kiXApN+8E2LJOWSRy7hNDbxTdqcrkSvL6HLnV/6h1LCq8rWIRrZxLcj
   58ZT3+QsXTN80pKIOkjQdCkv9hcsbVJDztj2vJtShcCsSpQTfjinkbZny
   7Q1FHOul0K+zD6r0lRC05mPA2cIvaIVkbb3TlfL3kHs9W0cNuB5X4P8UA
   A==;
IronPort-SDR: HVkjOHE1P/mCnqZXk9ruM1WcL63S8osr4+ZVaiSOLaFfUswPMyUPRjxjKoUJV8S5hJXIKKz7LI
 1FwVXP964IAELlMeNRJ9eSTrVlxPGAgWo6slYIpDrP78DohjYLAvUi77b56aW9nSaXXrRnvtag
 vXu/KSdeAbuRM+sXY8gIp74a5mtXnotSzwVxTXBxq7XC9MnAAGlb3x3mEpKrjUy4Rrr9WlxDe8
 yMh1hIfb2TTINlmkho6KqorHZ2O+68zElrfxUweLlK0mqmzE0D2DhnsrFDXZ6noSU8DeSclUsd
 yPQ=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:12 +0800
IronPort-SDR: 1wkHcUwQU1mKY5gIvLdnEmqMjK3QbpQGFbZC1h8mNMURrymA+/Breq/W6ZEBclIQhbhXSFGah/
 TyLEjPpvohkz7c6dY/NXDy6Ngxkt4AEx0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:19 -0700
IronPort-SDR: VUPTJlfdVG6YsxkyYucUk8Dp3R0PPW6ydOYM3RmmKpTO+0sDddFTzFoqkJhfPba15TFAvO2sW4
 qzQylb2FPHwg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:09 -0700
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
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v9 01/11] scsi: free sgtables in case command setup fails
Date:   Tue, 28 Apr 2020 19:45:55 +0900
Message-Id: <20200428104605.8143-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205595
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0a73230a8f16..f0cb26b3da6a 100644
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
 
@@ -1086,7 +1086,7 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 
 	return BLK_STS_OK;
 out_free_sgtables:
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	return ret;
 }
 EXPORT_SYMBOL(scsi_init_io);
@@ -1217,6 +1217,7 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
 		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
 
 	if (!blk_rq_bytes(req))
 		cmd->sc_data_direction = DMA_NONE;
@@ -1226,9 +1227,14 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
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

