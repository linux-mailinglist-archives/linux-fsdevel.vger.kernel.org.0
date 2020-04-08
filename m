Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3D1A1A95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDHD5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 23:57:22 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44605 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDHD5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:57:21 -0400
Received: by mail-pl1-f201.google.com with SMTP id c7so4031084plr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i09Z01KPmnipCKwcuqO+BH7TEpLI0FHXqkOsjdT8mMc=;
        b=ffK4HqqcZjl5AeCmiiBScGRyrHbBOUjLsY7BKId9qXhpYY2OQQyyc2t6JKAZjM8Yty
         DpVdjc4m4mXXxYaJyFw3um0kpB+VJ1MP7gcFXCr+ode4kfXNyLWGBqoenn5igYi6sPQk
         YG9E5QKcSigImPVN7Jtq1NvWuB7zvXMyUZ0kvYELnZRKLfMN+s2RkQCGUvjt0WIJRpg/
         I7S45xt5iJpRdwwfYt+rxVm6Y5tb8+WVpJD49vNw0o8LXHQZjhiEEtZCms1wfgFaG8hK
         0f0Xc0p39jPO4ab7Ay8F6WwUl5boF/tx7eJK+CdslFwoTn0K0emgWA7Aim1b3kRiI1PZ
         aCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i09Z01KPmnipCKwcuqO+BH7TEpLI0FHXqkOsjdT8mMc=;
        b=TmnJP9s+oF+tG3msDPrkEwUDmP+yUJjLmmrGYvhyqjz4Dr9rrnV599K+QvhUlATPF3
         Wdh3fpRhtStCZGU93X+ulk3qOV7XSvkThAaOxoYGPI683m0cQml7t1+8NcfqF6b7pA+U
         vbv0HcfW0YBZqk2l4H4BPPusalLqBH8T2Dl/vV0+4EV6zDNL/wNNRkn4X6ZLVQfj6c9O
         yZ5UEB8c0K+9gGKJBzyh4C+NIi2KdHmzWWND67adj5TdZxHQAhmeA5kpF5j/FOGAf63W
         dlWpFT4A26ob8ceukm236W6uwORyhGkS0JAE7oTkBwfxivTnNWjQr/dEivjBpMiD8109
         Dd6w==
X-Gm-Message-State: AGi0PuYWH9TUTkVQ1ydpL0ejN8Wr5cnUSOZOq8Lx+pxGqt8E+UkFo70H
        mz6bnbuXsvNQJJRhMWB6x1b3g+WmxFg=
X-Google-Smtp-Source: APiQypI+pOe3VKcGFVMYYoVSJNmEYESvlsJvIU5N1raFLEkf5eugYzzhRi7Kq2pbZGBdPUI5KyGcheryt98=
X-Received: by 2002:a63:735c:: with SMTP id d28mr5284339pgn.63.1586318241211;
 Tue, 07 Apr 2020 20:57:21 -0700 (PDT)
Date:   Tue,  7 Apr 2020 20:56:48 -0700
In-Reply-To: <20200408035654.247908-1-satyat@google.com>
Message-Id: <20200408035654.247908-7-satyat@google.com>
Mime-Version: 1.0
References: <20200408035654.247908-1-satyat@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v10 06/12] scsi: ufs: UFS driver v2.1 spec crypto additions
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

Add the crypto registers and structs defined in v2.1 of the JEDEC UFSHCI
specification in preparation to add support for inline encryption to
UFS.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/ufshcd.c |  2 ++
 drivers/scsi/ufs/ufshcd.h |  6 ++++
 drivers/scsi/ufs/ufshci.h | 67 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e04e8b8bdca60..99445e30e8ddc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4759,6 +4759,8 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	case OCS_MISMATCH_RESP_UPIU_SIZE:
 	case OCS_PEER_COMM_FAILURE:
 	case OCS_FATAL_ERROR:
+	case OCS_INVALID_CRYPTO_CONFIG:
+	case OCS_GENERAL_CRYPTO_ERROR:
 	default:
 		result |= DID_ERROR << 16;
 		dev_err(hba->dev,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index dd1ee277069a4..ca570d3f10d42 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -542,6 +542,12 @@ enum ufshcd_caps {
 	 * for userspace to control the power management.
 	 */
 	UFSHCD_CAP_RPM_AUTOSUSPEND			= 1 << 6,
+
+	/*
+	 * This capability allows the host controller driver to use the
+	 * inline crypto engine, if it is present
+	 */
+	UFSHCD_CAP_CRYPTO				= (1 << 7),
 };
 
 /**
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index c2961d37cc1cf..c0651fe6dbbc6 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -90,6 +90,7 @@ enum {
 	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
+	MASK_CRYPTO_SUPPORT			= 0x10000000,
 };
 
 #define UFS_MASK(mask, offset)		((mask) << (offset))
@@ -143,6 +144,7 @@ enum {
 #define DEVICE_FATAL_ERROR			0x800
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
+#define CRYPTO_ENGINE_FATAL_ERROR		0x40000
 
 #define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT)
@@ -155,11 +157,13 @@ enum {
 #define UFSHCD_ERROR_MASK	(UIC_ERROR |\
 				DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
+				SYSTEM_BUS_FATAL_ERROR |\
+				CRYPTO_ENGINE_FATAL_ERROR)
 
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
-				SYSTEM_BUS_FATAL_ERROR)
+				SYSTEM_BUS_FATAL_ERROR |\
+				CRYPTO_ENGINE_FATAL_ERROR)
 
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
@@ -318,6 +322,61 @@ enum {
 	INTERRUPT_MASK_ALL_VER_21	= 0x71FFF,
 };
 
+/* CCAP - Crypto Capability 100h */
+union ufs_crypto_capabilities {
+	__le32 reg_val;
+	struct {
+		u8 num_crypto_cap;
+		u8 config_count;
+		u8 reserved;
+		u8 config_array_ptr;
+	};
+};
+
+enum ufs_crypto_key_size {
+	UFS_CRYPTO_KEY_SIZE_INVALID	= 0x0,
+	UFS_CRYPTO_KEY_SIZE_128		= 0x1,
+	UFS_CRYPTO_KEY_SIZE_192		= 0x2,
+	UFS_CRYPTO_KEY_SIZE_256		= 0x3,
+	UFS_CRYPTO_KEY_SIZE_512		= 0x4,
+};
+
+enum ufs_crypto_alg {
+	UFS_CRYPTO_ALG_AES_XTS			= 0x0,
+	UFS_CRYPTO_ALG_BITLOCKER_AES_CBC	= 0x1,
+	UFS_CRYPTO_ALG_AES_ECB			= 0x2,
+	UFS_CRYPTO_ALG_ESSIV_AES_CBC		= 0x3,
+};
+
+/* x-CRYPTOCAP - Crypto Capability X */
+union ufs_crypto_cap_entry {
+	__le32 reg_val;
+	struct {
+		u8 algorithm_id;
+		u8 sdus_mask; /* Supported data unit size mask */
+		u8 key_size;
+		u8 reserved;
+	};
+};
+
+#define UFS_CRYPTO_CONFIGURATION_ENABLE (1 << 7)
+#define UFS_CRYPTO_KEY_MAX_SIZE 64
+/* x-CRYPTOCFG - Crypto Configuration X */
+union ufs_crypto_cfg_entry {
+	__le32 reg_val[32];
+	struct {
+		u8 crypto_key[UFS_CRYPTO_KEY_MAX_SIZE];
+		u8 data_unit_size;
+		u8 crypto_cap_idx;
+		u8 reserved_1;
+		u8 config_enable;
+		u8 reserved_multi_host;
+		u8 reserved_2;
+		u8 vsb[2];
+		u8 reserved_3[56];
+	};
+};
+
 /*
  * Request Descriptor Definitions
  */
@@ -339,6 +398,7 @@ enum {
 	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
 	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
 	UTP_REQ_DESC_INT_CMD		= 0x01000000,
+	UTP_REQ_DESC_CRYPTO_ENABLE_CMD	= 0x00800000,
 };
 
 /* UTP Transfer Request Data Direction (DD) */
@@ -358,6 +418,9 @@ enum {
 	OCS_PEER_COMM_FAILURE		= 0x5,
 	OCS_ABORTED			= 0x6,
 	OCS_FATAL_ERROR			= 0x7,
+	OCS_DEVICE_FATAL_ERROR		= 0x8,
+	OCS_INVALID_CRYPTO_CONFIG	= 0x9,
+	OCS_GENERAL_CRYPTO_ERROR	= 0xA,
 	OCS_INVALID_COMMAND_STATUS	= 0x0F,
 	MASK_OCS			= 0x0F,
 };
-- 
2.26.0.110.g2183baf09c-goog

