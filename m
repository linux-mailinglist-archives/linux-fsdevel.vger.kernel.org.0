Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AEE6D02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfJ1HU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42097 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfJ1HUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:54 -0400
Received: by mail-pg1-f202.google.com with SMTP id x203so7655197pgx.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2wF1FL2um71TZXTPllMyCv0xpSXF1RkAdV1vOmnGVGY=;
        b=pakzYc6XGQh8JJBkU4zMyfqMOmrVrcl/WRoKpjbj4CR8/r1ll5Sc/09c+qBgJ9Vv+/
         V3iFR+fwDeecGH+5OMSlK3d4Kx8A5N2zOaByVI/2sx4cKubt9L8HxWPIFLz4HYn48tou
         7G6hBQ5QjfIibd/tOiR84zroVq4xYHgy6z90RcY+bL/Npfkd9zrRuj/1i+JUy99s5/v5
         5YdZ+GeNEb5ejKsK29JfeykIpWe9Cw4OYbXYN+F+oghX2V/Lt7LZhViP7YZMh2CzV3xE
         Iv8mY0vgL68SNWXAHohbWA4rHNGA2LFfLCvg9sLN16ELQwvqWhGO/mZlC1UdWBeWR2qb
         sjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2wF1FL2um71TZXTPllMyCv0xpSXF1RkAdV1vOmnGVGY=;
        b=QMVLOi8K645zo4jx3wyDSHwDabnWNnRNca7956oYsw+QC8dINg8W7n5tyVg3MQqgH7
         vz7Wr3Y+PSvcRys5okaFC+6BQ67iQSvMKB5NkKGORVzCto0dfEAvsZ+RT932uLGuiQKd
         eOcnk3VEqsffwo0bC70zv5bD0s9EbrQVrpmqCxV+bEv/eeqgUK5jPfHqwqKlYEoHUE8q
         Bfs2IV3oVWIIrqCf8j12gPpue4UsAxKgCwomtwrp47fJ5APWUP/2g1fXOwV1xB+aecvL
         AeaaJtMFfMDlXbwMtpwizI7eLjUDJEN0bukg4sij+RnF/5F6do95qenUm8PiEtmYl4IV
         EVQA==
X-Gm-Message-State: APjAAAURvcqLQ7eQt24MurHKDvmZcd1cEgnGggj7pNXJKe7tWbcETCD0
        mliPu9aAtnS+LbBdHt8rf3YD+7cLA34=
X-Google-Smtp-Source: APXvYqy3InTY+RdLpcR9tmFHR45buosecQvoYzfMkh7GKWF+l2h443+9Dqs0Id39jUvJQqmLzfTv4bBn4dQ=
X-Received: by 2002:a65:4608:: with SMTP id v8mr18872025pgq.366.1572247253428;
 Mon, 28 Oct 2019 00:20:53 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:29 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-7-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 6/9] scsi: ufs: Add inline encryption support to UFS
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up ufshcd.c with the UFS Crypto API, the block layer inline
encryption additions and the keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/ufshcd.c | 83 ++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufshcd.h |  6 +++
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e66eb7a39a02..3a1190f0c672 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,7 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#include "ufshcd-crypto.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -857,7 +858,14 @@ static void ufshcd_enable_run_stop_reg(struct ufs_hba *hba)
  */
 static inline void ufshcd_hba_start(struct ufs_hba *hba)
 {
-	ufshcd_writel(hba, CONTROLLER_ENABLE, REG_CONTROLLER_ENABLE);
+	u32 val = CONTROLLER_ENABLE;
+
+	if (ufshcd_hba_is_crypto_supported(hba)) {
+		ufshcd_crypto_enable(hba);
+		val |= CRYPTO_GENERAL_ENABLE;
+	}
+
+	ufshcd_writel(hba, val, REG_CONTROLLER_ENABLE);
 }
 
 /**
@@ -2211,9 +2219,21 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
 	/* Transfer request descriptor header fields */
+	if (lrbp->crypto_enable) {
+		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
+		dword_0 |= lrbp->crypto_key_slot;
+		req_desc->header.dword_1 =
+			cpu_to_le32((u32)lrbp->data_unit_num);
+		req_desc->header.dword_3 =
+			cpu_to_le32((u32)(lrbp->data_unit_num >> 32));
+	} else {
+		/* dword_1 and dword_3 are reserved, hence they are set to 0 */
+		req_desc->header.dword_1 = 0;
+		req_desc->header.dword_3 = 0;
+	}
+
 	req_desc->header.dword_0 = cpu_to_le32(dword_0);
-	/* dword_1 is reserved, hence it is set to 0 */
-	req_desc->header.dword_1 = 0;
+
 	/*
 	 * assigning invalid value for command status. Controller
 	 * updates OCS on command completion, with the command
@@ -2221,8 +2241,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	 */
 	req_desc->header.dword_2 =
 		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
-	/* dword_3 is reserved, hence it is set to 0 */
-	req_desc->header.dword_3 = 0;
 
 	req_desc->prd_table_length = 0;
 }
@@ -2382,6 +2400,37 @@ static inline u16 ufshcd_upiu_wlun_to_scsi_wlun(u8 upiu_wlun_id)
 	return (upiu_wlun_id & ~UFS_UPIU_WLUN_ID) | SCSI_W_LUN_BASE;
 }
 
+static inline int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+					     struct scsi_cmnd *cmd,
+					     struct ufshcd_lrb *lrbp)
+{
+	int key_slot;
+
+	if (!cmd->request->bio ||
+	    !bio_crypt_should_process(cmd->request->bio, cmd->request->q)) {
+		lrbp->crypto_enable = false;
+		return 0;
+	}
+
+	if (WARN_ON(!ufshcd_is_crypto_enabled(hba))) {
+		/*
+		 * Upper layer asked us to do inline encryption
+		 * but that isn't enabled, so we fail this request.
+		 */
+		return -EINVAL;
+	}
+	key_slot = bio_crypt_get_keyslot(cmd->request->bio);
+	if (!ufshcd_keyslot_valid(hba, key_slot))
+		return -EINVAL;
+
+	lrbp->crypto_enable = true;
+	lrbp->crypto_key_slot = key_slot;
+	lrbp->data_unit_num = bio_crypt_data_unit_num(cmd->request->bio);
+
+	return 0;
+}
+
+
 /**
  * ufshcd_queuecommand - main entry point for SCSI requests
  * @host: SCSI host pointer
@@ -2469,6 +2518,13 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	lrbp->task_tag = tag;
 	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
 	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
+
+	err = ufshcd_prepare_lrbp_crypto(hba, cmd, lrbp);
+	if (err) {
+		lrbp->cmd = NULL;
+		clear_bit_unlock(tag, &hba->lrb_in_use);
+		goto out;
+	}
 	lrbp->req_abort_skip = false;
 
 	ufshcd_comp_scsi_upiu(hba, lrbp);
@@ -2502,6 +2558,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
+	lrbp->crypto_enable = false; /* No crypto operations */
 	hba->dev_cmd.type = cmd_type;
 
 	return ufshcd_comp_devman_upiu(hba, lrbp);
@@ -4229,6 +4286,8 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
 {
 	int err;
 
+	ufshcd_crypto_disable(hba);
+
 	ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
 	err = ufshcd_wait_for_register(hba, REG_CONTROLLER_ENABLE,
 					CONTROLLER_ENABLE, CONTROLLER_DISABLE,
@@ -4632,8 +4691,12 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 static int ufshcd_slave_configure(struct scsi_device *sdev)
 {
 	struct request_queue *q = sdev->request_queue;
+	struct ufs_hba *hba = shost_priv(sdev->host);
 
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
+
+	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
+
 	return 0;
 }
 
@@ -4644,6 +4707,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	struct request_queue *q = sdev->request_queue;
 
 	hba = shost_priv(sdev->host);
 	/* Drop the reference as it won't be needed anymore */
@@ -4654,6 +4718,8 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
+
+	ufshcd_crypto_destroy_rq_keyslot_manager(hba, q);
 }
 
 /**
@@ -8380,6 +8446,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	/* Reset the attached device */
 	ufshcd_vops_device_reset(hba);
 
+	/* Init crypto */
+	err = ufshcd_hba_init_crypto(hba);
+	if (err) {
+		dev_err(hba->dev, "crypto setup failed\n");
+		goto out_remove_scsi_host;
+	}
+
 	/* Host controller enable */
 	err = ufshcd_hba_enable(hba);
 	if (err) {
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 31e64f4267dd..a106b45f8358 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -167,6 +167,9 @@ struct ufs_pm_lvl_states {
  * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
  * @issue_time_stamp: time stamp for debug purposes
  * @compl_time_stamp: time stamp for statistics
+ * @crypto_enable: whether or not the request needs inline crypto operations
+ * @crypto_key_slot: the key slot to use for inline crypto
+ * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
  */
 struct ufshcd_lrb {
@@ -191,6 +194,9 @@ struct ufshcd_lrb {
 	bool intr_cmd;
 	ktime_t issue_time_stamp;
 	ktime_t compl_time_stamp;
+	bool crypto_enable;
+	u8 crypto_key_slot;
+	u64 data_unit_num;
 
 	bool req_abort_skip;
 };
-- 
2.24.0.rc0.303.g954a862665-goog

