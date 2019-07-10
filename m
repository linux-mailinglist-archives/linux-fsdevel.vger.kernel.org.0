Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0362E64EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGJW4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 18:56:32 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36843 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfGJW4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:56:31 -0400
Received: by mail-qt1-f202.google.com with SMTP id q26so3797484qtr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4/QTYY2AlGrGFK44WSp0Jd8POW7A5Vb4AZQh/O/gS78=;
        b=aXowkVMI94/7JLmk41Qo1UxhN8v6st8xbXGSMPE3U6Eds/64QzO+KcB3gIf3sqxl4e
         twxxi2CN0MOH+fXUVZLrPcRvb/uEj7UvYANSi5QFUXOCfNLSz3SfLBMXUKYkKcsOMQT6
         0p04ifOd9ksIMt0EdEm5Lib6ExUTlBTyMl56R7u8HXyWwmgs20MD8p7w3CIb93crPPRW
         kUU8tdkkf0BkVr2Zop+DNUVyn7AKgaa/i1chZXqspHI1G0N0WKX224J/bpF7JGAZx/Yu
         rODbft1B8eDM1kUBFSRkXWujlFmXPxPsYZCKF1ZL6b4mVZoAhRPuOjPQj2xFFlteRUKO
         wr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4/QTYY2AlGrGFK44WSp0Jd8POW7A5Vb4AZQh/O/gS78=;
        b=g0p6vNftzURdZjAOGvI2WrXtUj9dZKcxmfk8YQo5IjW0iS6/QwAnmJfjF7WnrlGui8
         BxDMQv6R9rA7fIupAZgbApb6Y3Re8oyNe+VdrGm68GUys4W7HhIlR+c0gQAH/isqneNj
         2dS6iSmxD9ucxOyhZTao0M+iJdN6dFbwKLTskkMPhxqGl/cUk2pUcgw50G3hxg7T3Lvj
         yJD6piabzcc8+L2koL5OgfVoeVcVKR9zDollHsmwwQ9MPESAy1pqhtb7SV2IMl8ofvLa
         E9tf2aBiZkPowGbuR8jWxBf1ak7cdCmRzTghouhoiTRP4XoTzPZX/dd54MDi7YIRJ8FA
         NE0Q==
X-Gm-Message-State: APjAAAXLEkwCWHY+Log0SWEl8NxHcQ00kqhRhXHD1/HZjP82wTJvP1rH
        oxJ/JpXGZjbes0BYX6KRQfCmn1c3ooQ=
X-Google-Smtp-Source: APXvYqznz5aKxFDmxJVIXALkeXeWkpTA/DKOsnNz9XgpUJafD2fHXkHEitHcmq/qQy5SQBDPtZ0vFryg76U=
X-Received: by 2002:ae9:ea09:: with SMTP id f9mr532639qkg.379.1562799390249;
 Wed, 10 Jul 2019 15:56:30 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:56:05 -0700
In-Reply-To: <20190710225609.192252-1-satyat@google.com>
Message-Id: <20190710225609.192252-5-satyat@google.com>
Mime-Version: 1.0
References: <20190710225609.192252-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 4/8] scsi: ufs: UFS driver v2.1 spec crypto additions
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

Add the crypto registers and structs defined in v2.1 of the JEDEC UFSHCI
specification in preparation to add support for inline encryption to
UFS.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/ufshcd.c |  2 ++
 drivers/scsi/ufs/ufshcd.h |  5 +++
 drivers/scsi/ufs/ufshci.h | 67 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3fe3029617a8..36413f97074d 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4724,6 +4724,8 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	case OCS_MISMATCH_RESP_UPIU_SIZE:
 	case OCS_PEER_COMM_FAILURE:
 	case OCS_FATAL_ERROR:
+	case OCS_INVALID_CRYPTO_CONFIG:
+	case OCS_GENERAL_CRYPTO_ERROR:
 	default:
 		result |= DID_ERROR << 16;
 		dev_err(hba->dev,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ecfa898b9ccc..d3b6a6b57a37 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -692,6 +692,11 @@ struct ufs_hba {
 	 * the performance of ongoing read/write operations.
 	 */
 #define UFSHCD_CAP_KEEP_AUTO_BKOPS_ENABLED_EXCEPT_SUSPEND (1 << 5)
+	/*
+	 * This capability allows the host controller driver to use the
+	 * inline crypto engine, if it is present
+	 */
+#define UFSHCD_CAP_CRYPTO (1 << 6)
 
 	struct devfreq *devfreq;
 	struct ufs_clk_scaling clk_scaling;
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6fa889de5ee5..a757eaf99a19 100644
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
 
 #define UFSHCD_UIC_PWR_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT |\
@@ -153,11 +155,13 @@ enum {
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
@@ -316,6 +320,61 @@ enum {
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
@@ -337,6 +396,7 @@ enum {
 	UTP_NATIVE_UFS_COMMAND		= 0x10000000,
 	UTP_DEVICE_MANAGEMENT_FUNCTION	= 0x20000000,
 	UTP_REQ_DESC_INT_CMD		= 0x01000000,
+	UTP_REQ_DESC_CRYPTO_ENABLE_CMD	= 0x00800000,
 };
 
 /* UTP Transfer Request Data Direction (DD) */
@@ -356,6 +416,9 @@ enum {
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
2.22.0.410.gd8fdbe21b5-goog

