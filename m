Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D36193666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 04:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCZDIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 23:08:31 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36270 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgCZDI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:08:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id y4so3310240plk.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 20:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VyrAb2GX/c73TaDrSc6Y0IqAMODH5jh/VkIfN2UUS8U=;
        b=k2v1NszEgDpA7XcViKtsQWp2vq6S/aNqs6FxXt3nSY7Hsti/4ZS2r8QARXQ5F7lMEE
         kdDX5Coh+mAA5oXpI4CZcAVFBtajno8hEnZODYHfUmYjsfHP1TkBUdRB+Rs+o38e/BNN
         yULDcsAOpp68RzAzomK0SqL1q+qIgvwMLWm5pObwb+fxd8E+sWMbYzdB/G+wqLtj45Bu
         TX+jpc4cy5JcAPTTfwqUlI0f6uWi6TGV1FvZi48yQdkwlNBAiLc0T9tSv41aJz1DPOdq
         cznVm8KshntPle0YfHkUnES/ZtE/OVGSa795jO7WgTzoQyJ1Rvs4ET4GxK2vzo/Vaog6
         OEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VyrAb2GX/c73TaDrSc6Y0IqAMODH5jh/VkIfN2UUS8U=;
        b=LBwgEV5gONPjQx9E7gQmADV0PnuVyj5BLAXp9rEWiUreii+YdSP3hbDLiYtZUM0tLQ
         VbiHYkfcCgGzMu48vkhGRnsaOTrTxBaRLKPm0QFumPsysOhskhxoc7v7UHON2YpG1wfA
         5/pQ7Y4mW1jcm4vp2/CP+xGm+9MVt4pu4KXP6lKXDVRE7YvjOu1CvyZfywW9Pq5mETB1
         /oqlQx2sTHLd2623OTnLGUQvZ9HnSNV9kBOaW5YfOhQVHa/t2FwQb+zDfsX0hb6tmIaV
         Bwhws7kUe5LqZqYB3LBcnlyaEElPu8dndTvARkQZjUTGmvN9r601LUxEncOgJI2/NxZ7
         +G0A==
X-Gm-Message-State: ANhLgQ29qpPVLVtWqJ1Y0VRsRUfwfZNPW+0Ywcnkx7l9UIxbhBjXMYK9
        G0WWu5ORlyO0UdbsC4QLbfW2YlrgcxY=
X-Google-Smtp-Source: ADFU+vuQFQOB5rcmxy4ddkfj05Dp6EL4atyP8tTqpuDXJbGli7ArV6uGiMK7zb9MbeY2F611rNUf4waTy08=
X-Received: by 2002:a17:90a:25a8:: with SMTP id k37mr776958pje.14.1585192106547;
 Wed, 25 Mar 2020 20:08:26 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:06:58 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-8-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v9 07/11] scsi: ufs: Add inline encryption support to UFS
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
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
 drivers/scsi/ufs/ufshcd-crypto.h | 18 +++++++++++++
 drivers/scsi/ufs/ufshcd.c        | 44 ++++++++++++++++++++++++++++----
 drivers/scsi/ufs/ufshcd.h        |  6 +++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
index 1e98f1fc99965..707e7b77e16fc 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.h
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -10,6 +10,20 @@
 #include "ufshcd.h"
 #include "ufshci.h"
 
+static inline void ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+					      struct scsi_cmnd *cmd,
+					      struct ufshcd_lrb *lrbp)
+{
+	struct request *rq = cmd->request;
+
+	if (rq->crypt_keyslot) {
+		lrbp->crypto_key_slot = blk_ksm_get_slot_idx(rq->crypt_keyslot);
+		lrbp->data_unit_num = rq->crypt_ctx->bc_dun[0];
+	} else {
+		lrbp->crypto_key_slot = -1;
+	}
+}
+
 bool ufshcd_crypto_enable(struct ufs_hba *hba);
 
 void ufshcd_crypto_disable(struct ufs_hba *hba);
@@ -23,6 +37,10 @@ void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba);
 
 #else /* CONFIG_SCSI_UFS_CRYPTO */
 
+static inline void ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+					      struct scsi_cmnd *cmd,
+					      struct ufshcd_lrb *lrbp) { }
+
 static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	return false;
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a9c2ae9984ad7..71b3d1fb4e47c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,7 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#include "ufshcd-crypto.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -816,7 +817,12 @@ static void ufshcd_enable_run_stop_reg(struct ufs_hba *hba)
  */
 static inline void ufshcd_hba_start(struct ufs_hba *hba)
 {
-	ufshcd_writel(hba, CONTROLLER_ENABLE, REG_CONTROLLER_ENABLE);
+	u32 val = CONTROLLER_ENABLE;
+
+	if (ufshcd_crypto_enable(hba))
+		val |= CRYPTO_GENERAL_ENABLE;
+
+	ufshcd_writel(hba, val, REG_CONTROLLER_ENABLE);
 }
 
 /**
@@ -2174,6 +2180,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	struct utp_transfer_req_desc *req_desc = lrbp->utr_descriptor_ptr;
 	u32 data_direction;
 	u32 dword_0;
+	u32 dword_1 = 0;
+	u32 dword_3 = 0;
 
 	if (cmd_dir == DMA_FROM_DEVICE) {
 		data_direction = UTP_DEVICE_TO_HOST;
@@ -2192,9 +2200,17 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
 	/* Transfer request descriptor header fields */
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	if (lrbp->crypto_key_slot >= 0) {
+		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
+		dword_0 |= lrbp->crypto_key_slot;
+		dword_1 = lower_32_bits(lrbp->data_unit_num);
+		dword_3 = upper_32_bits(lrbp->data_unit_num);
+	}
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
 	req_desc->header.dword_0 = cpu_to_le32(dword_0);
-	/* dword_1 is reserved, hence it is set to 0 */
-	req_desc->header.dword_1 = 0;
+	req_desc->header.dword_1 = cpu_to_le32(dword_1);
 	/*
 	 * assigning invalid value for command status. Controller
 	 * updates OCS on command completion, with the command
@@ -2202,8 +2218,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	 */
 	req_desc->header.dword_2 =
 		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
-	/* dword_3 is reserved, hence it is set to 0 */
-	req_desc->header.dword_3 = 0;
+	req_desc->header.dword_3 = cpu_to_le32(dword_3);
 
 	req_desc->prd_table_length = 0;
 }
@@ -2437,6 +2452,9 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	lrbp->task_tag = tag;
 	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
 	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
+
+	ufshcd_prepare_lrbp_crypto(hba, cmd, lrbp);
+
 	lrbp->req_abort_skip = false;
 
 	ufshcd_comp_scsi_upiu(hba, lrbp);
@@ -2470,6 +2488,9 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	lrbp->crypto_key_slot = -1; /* No crypto operations */
+#endif
 	hba->dev_cmd.type = cmd_type;
 
 	return ufshcd_comp_devman_upiu(hba, lrbp);
@@ -4631,6 +4652,8 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	if (ufshcd_is_rpm_autosuspend_allowed(hba))
 		sdev->rpm_autosuspend = 1;
 
+	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
+
 	return 0;
 }
 
@@ -5897,6 +5920,9 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0;
 	lrbp->intr_cmd = true;
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	lrbp->crypto_key_slot = -1; /* No crypto operations */
+#endif
 	hba->dev_cmd.type = cmd_type;
 
 	switch (hba->ufs_version) {
@@ -8311,6 +8337,7 @@ EXPORT_SYMBOL_GPL(ufshcd_remove);
  */
 void ufshcd_dealloc_host(struct ufs_hba *hba)
 {
+	ufshcd_crypto_destroy_keyslot_manager(hba);
 	scsi_host_put(hba->host);
 }
 EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
@@ -8520,6 +8547,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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
index eaeb21b9cda24..3af15880e1e36 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -168,6 +168,8 @@ struct ufs_pm_lvl_states {
  * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
  * @issue_time_stamp: time stamp for debug purposes
  * @compl_time_stamp: time stamp for statistics
+ * @crypto_key_slot: the key slot to use for inline crypto
+ * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
  */
 struct ufshcd_lrb {
@@ -192,6 +194,10 @@ struct ufshcd_lrb {
 	bool intr_cmd;
 	ktime_t issue_time_stamp;
 	ktime_t compl_time_stamp;
+#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
+	int crypto_key_slot;
+	u64 data_unit_num;
+#endif
 
 	bool req_abort_skip;
 };
-- 
2.25.1.696.g5e7596f4ac-goog

