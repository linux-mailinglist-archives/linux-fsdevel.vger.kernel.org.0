Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53521BA24E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgD0LcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgD0LcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987125; x=1619523125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MN1OCVql/0BW/hsNzH9v07vdJngEPy9RyTIYfgzs4G8=;
  b=CKt03OVnaW8+hb8xwjpKKLUq8qj62EonnIrFaONrnFgc8wzHnZ+wByJ6
   RBlb6N9OMaKEvx0nPtziiYw1VsPvGXx0HoB4qGogODkcuIS7Nb5tO4l2C
   +t3KmzxJmOGVAS0mYah+YFCPkesWnuT3hWZXmCV9FmBnAQ+85Y0r5F7CA
   aOJbDH9VMAzpDfhroxQQAVbSC0s4ufO3jSIXvkjbleXrF8+Q353Aepvvw
   NBtMWSMJn5tBGEIiJPLrZk+KTix2WBxpuv6fnTc/cJZdr3rJ37FQ8K9xH
   7QUlZvHgmjM7p3GSWv+J2fToKFvpmIwPVI3BfJguYWhEW5ZgP+KQbdLVC
   A==;
IronPort-SDR: 13skpapPS5/t9H5I4jQm3ubp+2bUaDth+kAvzg4BqWRhl/x9jsVtQu238aZ+5u60qdtF3RxNh7
 83yEHw+sGYX3r9HlmOiV2mrNBJB21Zo8OVFkJY0Cko44DwrfjE8mKv5lb+zRkJ3Tp4aagaIb9T
 FaQQqUnsR9ziRNxPRg9mnIL1feOggMivLMas2nuBQWH81tKCgjvVaN/ERlV2M6vbXj1JIEtor2
 /SQoOilXXOTWqUhX6iBKosGkCUKyCVGcHxxfZbvHt5VexRcYbIsSwF1CGZShwbQSoN3GwKzK6z
 ctE=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136551975"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:05 +0800
IronPort-SDR: fTf0K8ZJB38vGHm4SDTVh1FN1naEuGfKd/5z0gqMfvVUFQzFhgcO5XHsIAwAplTEX3yi9l0df2
 lSZX5RBVXWk/DvCoxrYFubmOzTaXAnWBQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:22:46 -0700
IronPort-SDR: 38vgJAhJCucx7L2JD5HG2lPhArIfRSgZLFlLFsZ8APohLBHcKTvhz/VIwXvwsw7jlopu4hNI5q
 0Yvuz66A+jmg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:03 -0700
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
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v8 01/11] scsi: free sgtables in case command setup fails
Date:   Mon, 27 Apr 2020 20:31:43 +0900
Message-Id: <20200427113153.31246-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
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

