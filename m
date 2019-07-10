Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD764EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 00:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGJW4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 18:56:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56866 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfGJW4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:56:39 -0400
Received: by mail-pf1-f202.google.com with SMTP id x10so2209276pfa.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OHrZfjp/K12gC+qxbFciCHqHs9g6QC4y4kIf9uBdohg=;
        b=JS6aUM/2e/leP4wpd89iwhRZK7jNIwpmkFqY3EdShoFfERVlMuWTxjB8k0VfMYtWN8
         kVHVsmA0agNvjKA12e7zCDdgBG/V3IBkGdkYybJGl+BqBg/h/U7NwLhBvlWLXuI6d/sM
         BoCa5Pg0cpDw7tdlk5hBCcbBhsPUC+h+mAA6G4s5LC/ncEaUINFw115RNpSttbfQ4eud
         4ONKp7K1HDDNnYP0GFnqZevYVg3fjoPWe1jQcJSfwqvvMR3x79Eb5CDGsQOBdel/wQcO
         UBELzf3PoaTEmQB9BjlRei1Tj/43UIePPekWy+yJ+/hRSctACYBjJS+AhyTpeJjh48lu
         NYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OHrZfjp/K12gC+qxbFciCHqHs9g6QC4y4kIf9uBdohg=;
        b=cXGnUVoKRpwgo5RWq+VnASezGxQ2n0toto9QSLHTdsSdPe4jIQkCD0cyfDaTMIFC7g
         iV+O09CYd026ebYIIbDQT6Y1KBQCe3T+FWGBM1YAk9Y2VJDO7+vpqAM3XW3XISpPA1Du
         /yL53wICjy7T7LjdXTihgSFklcV8fQNgq1DG9nklEpgLUgbOjT6pZZy5AqjbdDSunCwm
         TN6cZx3uWmovg8CZt4UDtdx6ZH23/x7+PlfzbjKWxCY5d7g2aJUu0SSae69KcuffjqZI
         74F5YhUh2/iih3TwxJuqydY+gnPRR5DNM6Q534IPcr6JcRAa3bvfLhJCw1JDJ5/CFD2j
         d9kQ==
X-Gm-Message-State: APjAAAWrfScwzRrO+hzuMp5brLkgWTzNhxy61qB70qtK1vT+GxBnv4/O
        bkJ6CHbiroJ/dZpkQkdpntWL81r7m7w=
X-Google-Smtp-Source: APXvYqzf7PIg0ekGuFEV6rIElTZBVnBZbzuA3mRwQSLhDGV6O5t+VPYc2LM1TfOVu5EsFmZS8EGdEOsXcbM=
X-Received: by 2002:a65:4841:: with SMTP id i1mr770141pgs.316.1562799397968;
 Wed, 10 Jul 2019 15:56:37 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:56:07 -0700
In-Reply-To: <20190710225609.192252-1-satyat@google.com>
Message-Id: <20190710225609.192252-7-satyat@google.com>
Mime-Version: 1.0
References: <20190710225609.192252-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 6/8] scsi: ufs: Add inline encryption support to UFS
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 drivers/scsi/ufs/ufshcd.c | 82 ++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufshcd.h |  6 +++
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 36413f97074d..492e9db6b50f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,7 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#include "ufshcd-crypto.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -855,7 +856,14 @@ static void ufshcd_enable_run_stop_reg(struct ufs_hba *hba)
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
@@ -2209,9 +2217,21 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
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
@@ -2219,8 +2239,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	 */
 	req_desc->header.dword_2 =
 		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
-	/* dword_3 is reserved, hence it is set to 0 */
-	req_desc->header.dword_3 = 0;
 
 	req_desc->prd_table_length = 0;
 }
@@ -2380,6 +2398,37 @@ static inline u16 ufshcd_upiu_wlun_to_scsi_wlun(u8 upiu_wlun_id)
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
@@ -2467,6 +2516,13 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
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
@@ -2500,6 +2556,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
+	lrbp->crypto_enable = false; /* No crypto operations */
 	hba->dev_cmd.type = cmd_type;
 
 	return ufshcd_comp_devman_upiu(hba, lrbp);
@@ -4192,6 +4249,8 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
 {
 	int err;
 
+	ufshcd_crypto_disable(hba);
+
 	ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
 	err = ufshcd_wait_for_register(hba, REG_CONTROLLER_ENABLE,
 					CONTROLLER_ENABLE, CONTROLLER_DISABLE,
@@ -4585,10 +4644,13 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 static int ufshcd_slave_configure(struct scsi_device *sdev)
 {
 	struct request_queue *q = sdev->request_queue;
+	struct ufs_hba *hba = shost_priv(sdev->host);
 
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
 
+	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
+
 	return 0;
 }
 
@@ -4599,6 +4661,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	struct request_queue *q = sdev->request_queue;
 
 	hba = shost_priv(sdev->host);
 	/* Drop the reference as it won't be needed anymore */
@@ -4609,6 +4672,8 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
+
+	ufshcd_crypto_destroy_rq_keyslot_manager(hba, q);
 }
 
 /**
@@ -8293,6 +8358,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto exit_gating;
 	}
 
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
index ef62b3ba03fd..ab9c1191c206 100644
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
2.22.0.410.gd8fdbe21b5-goog

