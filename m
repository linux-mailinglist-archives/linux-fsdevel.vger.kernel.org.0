Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F31182A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgCLIDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:03:17 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39540 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbgCLIDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:17 -0400
Received: by mail-pl1-f202.google.com with SMTP id q24so2840341pls.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pABsUG6AvnNEnBPGryD45psD17CMkQ8HTS5bi0neaFI=;
        b=AkbnIEhrUeLvuHOY6oPQEJgJtePKAayp2Ar8kXVEX7G3WtzGr3jsPT0xVoDKuSPGeA
         iYNNUh+9ijgOgQh4TEJjGo/l524c1UAYYxQKqOhBsZUIel98OcqBj2GvmC8ASeHqDZw6
         rTjel/AUS69ltcq9nEcgiKgQXk+kgFg7oo7f2VWwe+P5SqoyvQ4nuy31eerALSwlwL0K
         cLqFT0sPjP4+YksGMUs1S+KwRzwkRoL2bi4MXEWDZzygoxJM8xcknJ3CGs5JvaYxTwh0
         icdY/nSMZiKKhAeFqOal8MV/SMdKyonl1sb3FX6FCt/HLaIEk7i/kFWrJZ2LKhgG+L5q
         5P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pABsUG6AvnNEnBPGryD45psD17CMkQ8HTS5bi0neaFI=;
        b=faDnJH2xqXCAmJ9Bd+C/lu1FZ599HMAN8idNKw511UXkSgeC1VxZLcx9fnMUbt4td+
         ebA7JEEwOoWVrZNnZN3GuwL2k3ejO858ruYcatC/+/lbhb3/NupYHc7DFZOVc4mFfKMR
         CN2b9I4Z1eXT499Wltli7hdUuEwydX3dId8gK0mElVXoJZg7rrPTCloNeEXMCi8gJW4p
         rf0vscWjqDVhv4tbL75vRiT4ultgbMIBZtW4Dl8uw+D9Nx+2AgskvW5hHIR9DeZZo445
         QQ0rfpsxgCpQL3bP6euAanR4TnOTzlhtz6scO/v2QFmMms5kYr+vw5p+Ev5lmPGurjAY
         IKqg==
X-Gm-Message-State: ANhLgQ3GQrhpieoQHhU0MELJQe8N7OTmENJpf7+vvbHtA6iQbzF/0clR
        A5IOpGwhdaYSJIV3gxcRKw6/qJkYsd4=
X-Google-Smtp-Source: ADFU+vspnH0n3aIVvxXPsA8ERQ4qr7TVfLts6H4QIJkeVn5Y5cQT8aXs1V+c4T3I6HEi8JCT/KeLmHcE1ss=
X-Received: by 2002:a17:90a:77c3:: with SMTP id e3mr2806012pjs.143.1584000196124;
 Thu, 12 Mar 2020 01:03:16 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:49 -0700
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
Message-Id: <20200312080253.3667-8-satyat@google.com>
Mime-Version: 1.0
References: <20200312080253.3667-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 07/11] scsi: ufs: Add inline encryption support to UFS
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
 drivers/scsi/ufs/ufshcd-crypto.c | 27 +++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h | 14 ++++++++
 drivers/scsi/ufs/ufshcd.c        | 59 +++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufshcd.h        |  8 +++++
 4 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index 8b6f7c83f77f..37254472326a 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -368,3 +368,30 @@ void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
 {
 	blk_ksm_destroy(&hba->ksm);
 }
+
+int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+			       struct scsi_cmnd *cmd,
+			       struct ufshcd_lrb *lrbp)
+{
+	struct request *rq = cmd->request;
+	struct bio_crypt_ctx *bc = rq->crypt_ctx;
+	unsigned int slot_idx = blk_ksm_get_slot_idx(rq->crypt_keyslot);
+
+	lrbp->crypto_enable = false;
+
+	if (WARN_ON(!(hba->caps & UFSHCD_CAP_CRYPTO))) {
+		/*
+		 * Upper layer asked us to do inline encryption
+		 * but that isn't enabled, so we fail this request.
+		 */
+		return -EINVAL;
+	}
+	if (!ufshcd_keyslot_valid(hba, slot_idx))
+		return -EINVAL;
+
+	lrbp->crypto_enable = true;
+	lrbp->crypto_key_slot = slot_idx;
+	lrbp->data_unit_num = bc->bc_dun[0];
+
+	return 0;
+}
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
index 8270c0c5081a..c76f93ede51c 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.h
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -16,6 +16,15 @@ static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
 	return hba->crypto_capabilities.reg_val != 0;
 }
 
+int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+			       struct scsi_cmnd *cmd,
+			       struct ufshcd_lrb *lrbp);
+
+static inline bool ufshcd_lrbp_crypto_enabled(struct ufshcd_lrb *lrbp)
+{
+	return lrbp->crypto_enable;
+}
+
 void ufshcd_crypto_enable(struct ufs_hba *hba);
 
 void ufshcd_crypto_disable(struct ufs_hba *hba);
@@ -49,6 +58,11 @@ static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
 static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
 { }
 
+static inline bool ufshcd_lrbp_crypto_enabled(struct ufshcd_lrb *lrbp)
+{
+	return false;
+}
+
 #endif /* CONFIG_SCSI_UFS_CRYPTO */
 
 #endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 825d9eb34f10..3a19966dbee9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -47,6 +47,7 @@
 #include "unipro.h"
 #include "ufs-sysfs.h"
 #include "ufs_bsg.h"
+#include "ufshcd-crypto.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ufs.h>
@@ -816,7 +817,14 @@ static void ufshcd_enable_run_stop_reg(struct ufs_hba *hba)
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
@@ -2192,9 +2200,23 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 		dword_0 |= UTP_REQ_DESC_INT_CMD;
 
 	/* Transfer request descriptor header fields */
+	if (ufshcd_lrbp_crypto_enabled(lrbp)) {
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
+		dword_0 |= lrbp->crypto_key_slot;
+		req_desc->header.dword_1 =
+			cpu_to_le32(lower_32_bits(lrbp->data_unit_num));
+		req_desc->header.dword_3 =
+			cpu_to_le32(upper_32_bits(lrbp->data_unit_num));
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
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
@@ -2202,8 +2224,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	 */
 	req_desc->header.dword_2 =
 		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
-	/* dword_3 is reserved, hence it is set to 0 */
-	req_desc->header.dword_3 = 0;
 
 	req_desc->prd_table_length = 0;
 }
@@ -2437,6 +2457,20 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 	lrbp->task_tag = tag;
 	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
 	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	if (cmd->request->crypt_keyslot) {
+		err = ufshcd_prepare_lrbp_crypto(hba, cmd, lrbp);
+		if (err) {
+			lrbp->cmd = NULL;
+			ufshcd_release(hba);
+			goto out;
+		}
+	} else {
+		lrbp->crypto_enable = false;
+	}
+#endif
+
 	lrbp->req_abort_skip = false;
 
 	ufshcd_comp_scsi_upiu(hba, lrbp);
@@ -2470,6 +2504,9 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	lrbp->crypto_enable = false; /* No crypto operations */
+#endif
 	hba->dev_cmd.type = cmd_type;
 
 	return ufshcd_comp_devman_upiu(hba, lrbp);
@@ -4208,6 +4245,8 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
 {
 	int err;
 
+	ufshcd_crypto_disable(hba);
+
 	ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
 	err = ufshcd_wait_for_register(hba, REG_CONTROLLER_ENABLE,
 					CONTROLLER_ENABLE, CONTROLLER_DISABLE,
@@ -4624,6 +4663,8 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	if (ufshcd_is_rpm_autosuspend_allowed(hba))
 		sdev->rpm_autosuspend = 1;
 
+	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
+
 	return 0;
 }
 
@@ -8304,6 +8345,7 @@ EXPORT_SYMBOL_GPL(ufshcd_remove);
  */
 void ufshcd_dealloc_host(struct ufs_hba *hba)
 {
+	ufshcd_crypto_destroy_keyslot_manager(hba);
 	scsi_host_put(hba->host);
 }
 EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
@@ -8513,6 +8555,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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
index ee37dd44d5e6..78397864f911 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -168,6 +168,9 @@ struct ufs_pm_lvl_states {
  * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
  * @issue_time_stamp: time stamp for debug purposes
  * @compl_time_stamp: time stamp for statistics
+ * @crypto_enable: whether or not the request needs inline crypto operations
+ * @crypto_key_slot: the key slot to use for inline crypto
+ * @data_unit_num: the data unit number for the first block for inline crypto
  * @req_abort_skip: skip request abort task flag
  */
 struct ufshcd_lrb {
@@ -192,6 +195,11 @@ struct ufshcd_lrb {
 	bool intr_cmd;
 	ktime_t issue_time_stamp;
 	ktime_t compl_time_stamp;
+#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
+	bool crypto_enable;
+	u8 crypto_key_slot;
+	u64 data_unit_num;
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
 
 	bool req_abort_skip;
 };
-- 
2.25.1.481.gfbce0eb801-goog

