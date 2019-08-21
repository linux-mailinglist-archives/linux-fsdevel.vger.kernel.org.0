Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E750197431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfHUH5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:57:35 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45200 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfHUH5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:57:34 -0400
Received: by mail-yb1-f201.google.com with SMTP id 15so929360ybj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 00:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SfY5XRW311zdC5RUZv3f1YyeJJxz4XjcRlTY+ZjAHvc=;
        b=fWI4uwOOZULs38dJ/e4/Rov0rnXIpdgH46de98nsV/ACBXN1r1TbY8E4Nd7KuoWjBH
         g6wf7ZEj1i06r6eNeZEXyNidpiodgNdKwMma2Iiu4iwalBguttIU91udt3U+LY/0vK5L
         dN4xXQSkXRPxlGv8vodUe3SK3sWdv5m/q15C/L/5mient8PcVeiKuJJ8qXFDITGBo1Gq
         R4sBj7cqy9OvvTUGuvriaDdR5KlQKPWtTGVGv2Bxq41P48wo5toxF2doQ2uIMfkfe5Vg
         MB6ZUENCkq11qGTZvWQAIrwQi7QdqCSPirn78ushHpBMIYlxbXL7mZ3P3P9VEgIICuSC
         zhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SfY5XRW311zdC5RUZv3f1YyeJJxz4XjcRlTY+ZjAHvc=;
        b=WQeRsdFx0UokufeDZQpbkatKmv2zznTy5Trz6S/uKZwhBEkBOQ54qERpsXXeI6CWcw
         6VNpvBNVfa7ufvyFLCDFMGQbjnhi66jA0kEky8hRTmywSUSZI1pds7J7Jy0zi3xTERfX
         Bp4uAEplm7/A1V6LSLy6SL3yg0sxIHb3IYywee5uHZUWwlOAIfjDK1Xt+I+PYQgCC0ZN
         DK5QARthRHOff4CdAVv3oH42HMBmzZJ2Cq8pGCfDFlhbUjrhl3gYMGXnYJp7W/EKSr7Q
         ErafRQmAXuFKBI7HaFg7UhzJkQAr6AsKH9SPy7oP+36xBNyqwpnaYLKIu3UATEl5l9Xu
         4ILQ==
X-Gm-Message-State: APjAAAXPZZ1ichyOkmAyZt/7sIqFvN559dcaQXcDSMnF8+O9Czdhd35e
        g8PlYeLN1iUWwAaYzmawiDPRnaCJ9Ok=
X-Google-Smtp-Source: APXvYqxis6xCLsHhX8VMjHW7pKCBcr3N5pGkoeuirvOMEpcmqSmucQXX36A/XD2uzZlmNEeh88CJW3Uksa0=
X-Received: by 2002:a81:7850:: with SMTP id t77mr170499ywc.129.1566374253554;
 Wed, 21 Aug 2019 00:57:33 -0700 (PDT)
Date:   Wed, 21 Aug 2019 00:57:12 -0700
In-Reply-To: <20190821075714.65140-1-satyat@google.com>
Message-Id: <20190821075714.65140-7-satyat@google.com>
Mime-Version: 1.0
References: <20190821075714.65140-1-satyat@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v4 6/8] scsi: ufs: Add inline encryption support to UFS
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
index 212f7653c4c5..dcb841c6be7e 100644
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
@@ -4585,8 +4644,12 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
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
 
@@ -4597,6 +4660,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	struct request_queue *q = sdev->request_queue;
 
 	hba = shost_priv(sdev->host);
 	/* Drop the reference as it won't be needed anymore */
@@ -4607,6 +4671,8 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
+
+	ufshcd_crypto_destroy_rq_keyslot_manager(hba, q);
 }
 
 /**
@@ -8323,6 +8389,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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
index 34e9849f00f0..c3e1f409e63d 100644
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
2.23.0.rc1.153.gdeed80330f-goog

