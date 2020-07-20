Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F32260AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGTNV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:21:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30727 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTNVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595251285; x=1626787285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aY+LrtzeFvkG/AGHwu1lHBk2F9eJ1QpgvD7kExoGlM0=;
  b=MeZJJQXmYYwpfy3JtPVWqwdBg5PO+ztbrGhWEUni+E9nO4a4HyP7t1e6
   6PGNUdVOPUC6EYqVI21oN0lARmCXfMP9bUEnq7uVI4zYOls7G9bItFvnQ
   sc5lPWp0nx2WNa26shDrMxnVshSNjATlEvxvc3KbXPGcaG25pMsu5GxtM
   BsuM2J1kHv446H1crPmWeUV/SuHtEqNU30QVeYgnq8xpKK8aGIZdyHfKF
   zakTe2PYVTwG5fLEO+pdRIsUbNX0RKaz8UuRap8Fm5WQXh1RR6Nv1aLzF
   xrUZbym2Jknj5dLsCWpCy+zzl4V/cfBPddnGLMqneaXEMX8sHVttLSHt+
   w==;
IronPort-SDR: djFnSjVquhyafXN7z3QPpl6zL4fMnPPK0/Ti0R1ssAipXN4SBpIp96PU6dx7dHjHXtdPzi6TP9
 zad/OMc5WWSZtO+Jl5v9qjltPhphBptceWW4x3L02dbB+carPtctaPL9FngqRT5tZysCX09NqK
 UeCiKIFtWmW7t1L+N6ao75joVy8bfnGucucvjr3mg7RwXbmgE630oaula8PDH4ox294x2Lj8Mi
 Gi74S14SSL70FH3UYpCgibjA7UY2tS3UgVq7wDMIl842GnMqUoEfijR2cq3sqg3NTJkOF0c6Wc
 eOQ=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="143013751"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 21:21:25 +0800
IronPort-SDR: eDkBD29M1iOD5EakAqX6UXekIV4OofLNFOcNUdpgwbLSTII8mlKPpUTpRwh46S3r3Tz1X9vjpp
 T84yPDGdVfdhtnsts1W0Ci9wiZWoBiDbY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 06:09:43 -0700
IronPort-SDR: hxf0oi9qCnO5sRq5JHRMQ7vuEAv/t4ReezDWkrw+F76N5wh7hKHXf2WZVy3lSuTWXhQTroo9ls
 f6wuUiyx4ckA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2020 06:21:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] fs: fix kiocb ki_complete interface
Date:   Mon, 20 Jul 2020 22:21:17 +0900
Message-Id: <20200720132118.10934-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

The res and res2 fields of struct io_event are signed 64 bits values
(__s64 type). Allow the ki_complete method of struct kiocb to set 64
bits values in these fields by changin its interface from the long type
to long long.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/loop.c              | 3 ++-
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 drivers/target/target_core_file.c | 3 ++-
 fs/aio.c                          | 2 +-
 fs/io_uring.c                     | 5 +++--
 include/linux/fs.h                | 2 +-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a943207705dd..2a1e0f248436 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -513,7 +513,8 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		blk_mq_complete_request(rq);
 }
 
-static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void lo_rw_aio_complete(struct kiocb *iocb,
+			       long long ret, long long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..302bfdff55e5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -123,7 +123,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	return call_iter(iocb, &iter);
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_io_done(struct kiocb *iocb,
+			       long long ret, long long ret2)
 {
 	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
 	u16 status = NVME_SC_SUCCESS;
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 7143d03f0e02..87eac2313758 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -243,7 +243,8 @@ struct target_core_file_cmd {
 	struct kiocb	iocb;
 };
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
+static void cmd_rw_aio_complete(struct kiocb *iocb,
+				long long ret, long long ret2)
 {
 	struct target_core_file_cmd *cmd;
 
diff --git a/fs/aio.c b/fs/aio.c
index 91e7cc4a9f17..38bce07f9733 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1418,7 +1418,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
-static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void aio_complete_rw(struct kiocb *kiocb, long long res, long long res2)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index ce63e1389568..a2e861b13b1e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2261,14 +2261,15 @@ static void __io_complete_rw(struct io_kiocb *req, long res, long res2,
 		io_complete_rw_common(&req->rw.kiocb, res, cs);
 }
 
-static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw(struct kiocb *kiocb, long long res, long long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
 	__io_complete_rw(req, res, res2, NULL);
 }
 
-static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
+static void io_complete_rw_iopoll(struct kiocb *kiocb, long long res,
+				  long long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw.kiocb);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index da90323b9f92..aa8e82496179 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -328,7 +328,7 @@ struct kiocb {
 	randomized_struct_fields_start
 
 	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
+	void (*ki_complete)(struct kiocb *iocb, long long ret, long long ret2);
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
-- 
2.26.2

