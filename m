Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21401A1A88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDHD5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 23:57:25 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50002 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHD5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:57:24 -0400
Received: by mail-pg1-f202.google.com with SMTP id d124so4372762pgc.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5K05Xoh+SUd9/3sbKxNGQzWXEU2C4ODqRTQbgXmNJ50=;
        b=dwkCO7oCtvUY5vnzfBf0f9j/42FQp2cf/I0ujOSIsTG6ZoJA6cSR2Pju0jDTC0n1em
         X5B026kegrPUkCgWXrRMjp8ttYJ0TwPTCVuY42yqAcDYAdyN2B2k1kjvCSsEbGULkcmn
         LVkZcpwmhxJbiHhwBQmtrlbg3ciwcXay0kfTsI6hFSguBIAZMvvettefG7REQi4TsEte
         ZPKC5kd+MI56tWIJl57hK4Jvv5IQkBOMYIhqZJ/FEGN9qb0DH/wIyXLFjOtXIo4VLiVu
         Y1SqvOsbuPnyvu0Q0268tsDXFcpkDKM7Ya7/Imju9oLg7rM/LmWQsMoV9kxWkisNaxcw
         fXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5K05Xoh+SUd9/3sbKxNGQzWXEU2C4ODqRTQbgXmNJ50=;
        b=aIk540YfCnovDdWBjbGACVItjkZDhSqMd0dsppF50s5YmOoYpHGCQeU1Vxhr3Te/3h
         HhipKk1RjJTQS2gwDE0KgoyHCnxEkQm2uip4WpV4RM7VPIgTCQlCBGyVpIoJbwKWassX
         NZdn9hIdM9/gnRCNqnYJ1DHZDLV0oE5em11GQb9Pabxfi7H4IVRdLW8WVN1oYKnw8tny
         tDdDXXkHKf9dHcHZvZPN1HQ8PkLcyLGHFO0JjufiriRXjMZjrOJ5Yw5dMO4xkTQNoULN
         B5p/sYPvzvx3K/3LPBz58N30sjSkh96R6UCoXAQE/3Gv7I06m1w0twqPpkNNtRurGn/B
         xEHg==
X-Gm-Message-State: AGi0PuZvNYD5H6kCOXA/uR10zOOwvltVTedwYfh6DjIlom7ePaf8iJa/
        mcSNcuUUjLl7o2PtapvkV3+9F+0c0Mg=
X-Google-Smtp-Source: APiQypLA0dvfpQGP+Fnuz4mCP6iiPwfx7hyPGTp3tuJwLGyMme8qhMDGNeQzvGDeOBu1rPWXDYPyIV6ZoHw=
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr5207371pgk.269.1586318243478;
 Tue, 07 Apr 2020 20:57:23 -0700 (PDT)
Date:   Tue,  7 Apr 2020 20:56:49 -0700
In-Reply-To: <20200408035654.247908-1-satyat@google.com>
Message-Id: <20200408035654.247908-8-satyat@google.com>
Mime-Version: 1.0
References: <20200408035654.247908-1-satyat@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v10 07/12] scsi: ufs: UFS crypto API
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

Introduce functions to manipulate UFS inline encryption hardware
in line with the JEDEC UFSHCI v2.1 specification and to work with the
block keyslot manager.

The UFS crypto API will assume by default that a vendor driver doesn't
support UFS crypto, even if the hardware advertises the capability, because
a lot of hardware requires some special handling that's not specified in
the aforementioned JEDEC spec. Each vendor driver must explicity set
hba->caps |= UFSHCD_CAP_CRYPTO before ufshcd_hba_init_crypto is called to
opt-in to UFS crypto support.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/Kconfig         |   9 ++
 drivers/scsi/ufs/Makefile        |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c | 226 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  42 ++++++
 drivers/scsi/ufs/ufshcd.h        |  12 ++
 5 files changed, 290 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e2005aeddc2db..5ed3f209f8810 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -160,3 +160,12 @@ config SCSI_UFS_BSG
 
 	  Select this if you need a bsg device node for your UFS controller.
 	  If unsure, say N.
+
+config SCSI_UFS_CRYPTO
+	bool "UFS Crypto Engine Support"
+	depends on SCSI_UFSHCD && BLK_INLINE_ENCRYPTION
+	help
+	  Enable Crypto Engine Support in UFS.
+	  Enabling this makes it possible for the kernel to use the crypto
+	  capabilities of the UFS device (if present) to perform crypto
+	  operations on data being transferred to/from the device.
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 94c6c5d7334b6..197e178f44bce 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
 ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 0000000000000..65a3115d2a2d4
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include "ufshcd.h"
+#include "ufshcd-crypto.h"
+
+/* Blk-crypto modes supported by UFS crypto */
+static const struct ufs_crypto_alg_entry {
+	enum ufs_crypto_alg ufs_alg;
+	enum ufs_crypto_key_size ufs_key_size;
+} ufs_crypto_algs[BLK_ENCRYPTION_MODE_MAX] = {
+	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
+		.ufs_alg = UFS_CRYPTO_ALG_AES_XTS,
+		.ufs_key_size = UFS_CRYPTO_KEY_SIZE_256,
+	},
+};
+
+static void ufshcd_program_key(struct ufs_hba *hba,
+			       const union ufs_crypto_cfg_entry *cfg,
+			       int slot)
+{
+	int i;
+	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
+
+	ufshcd_hold(hba, false);
+	/* Ensure that CFGE is cleared before programming the key */
+	ufshcd_writel(hba, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	for (i = 0; i < 16; i++) {
+		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
+			      slot_offset + i * sizeof(cfg->reg_val[0]));
+	}
+	/* Write dword 17 */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
+		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
+	/* Dword 16 must be written last */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
+		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	ufshcd_release(hba);
+}
+
+static int ufshcd_crypto_keyslot_program(struct blk_keyslot_manager *ksm,
+					 const struct blk_crypto_key *key,
+					 unsigned int slot)
+{
+	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
+	const union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
+	const struct ufs_crypto_alg_entry *alg =
+			&ufs_crypto_algs[key->crypto_cfg.crypto_mode];
+	u8 data_unit_mask = key->crypto_cfg.data_unit_size / 512;
+	int i;
+	int cap_idx = -1;
+	union ufs_crypto_cfg_entry cfg = { 0 };
+
+	BUILD_BUG_ON(UFS_CRYPTO_KEY_SIZE_INVALID != 0);
+	for (i = 0; i < hba->crypto_capabilities.num_crypto_cap; i++) {
+		if (ccap_array[i].algorithm_id == alg->ufs_alg &&
+		    ccap_array[i].key_size == alg->ufs_key_size &&
+		    (ccap_array[i].sdus_mask & data_unit_mask)) {
+			cap_idx = i;
+			break;
+		}
+	}
+
+	if (WARN_ON(cap_idx < 0))
+		return -EOPNOTSUPP;
+
+	cfg.data_unit_size = data_unit_mask;
+	cfg.crypto_cap_idx = cap_idx;
+	cfg.config_enable = UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	if (ccap_array[cap_idx].algorithm_id == UFS_CRYPTO_ALG_AES_XTS) {
+		/* In XTS mode, the blk_crypto_key's size is already doubled */
+		memcpy(cfg.crypto_key, key->raw, key->size/2);
+		memcpy(cfg.crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
+		       key->raw + key->size/2, key->size/2);
+	} else {
+		memcpy(cfg.crypto_key, key->raw, key->size);
+	}
+
+	ufshcd_program_key(hba, &cfg, slot);
+
+	memzero_explicit(&cfg, sizeof(cfg));
+	return 0;
+}
+
+static void ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
+{
+	/*
+	 * Clear the crypto cfg on the device. Clearing CFGE
+	 * might not be sufficient, so just clear the entire cfg.
+	 */
+	union ufs_crypto_cfg_entry cfg = { 0 };
+
+	ufshcd_program_key(hba, &cfg, slot);
+}
+
+static int ufshcd_crypto_keyslot_evict(struct blk_keyslot_manager *ksm,
+				       const struct blk_crypto_key *key,
+				       unsigned int slot)
+{
+	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
+
+	ufshcd_clear_keyslot(hba, slot);
+
+	return 0;
+}
+
+bool ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
+		return false;
+
+	/* Reset might clear all keys, so reprogram all the keys. */
+	blk_ksm_reprogram_all_keys(&hba->ksm);
+	return true;
+}
+
+static const struct blk_ksm_ll_ops ufshcd_ksm_ops = {
+	.keyslot_program	= ufshcd_crypto_keyslot_program,
+	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+};
+
+static enum blk_crypto_mode_num
+ufshcd_find_blk_crypto_mode(union ufs_crypto_cap_entry cap)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ufs_crypto_algs); i++) {
+		BUILD_BUG_ON(UFS_CRYPTO_KEY_SIZE_INVALID != 0);
+		if (ufs_crypto_algs[i].ufs_alg == cap.algorithm_id &&
+		    ufs_crypto_algs[i].ufs_key_size == cap.key_size) {
+			return i;
+		}
+	}
+	return BLK_ENCRYPTION_MODE_INVALID;
+}
+
+/**
+ * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
+ * @hba: Per adapter instance
+ *
+ * Return: 0 if crypto was initialized or is not supported, else a -errno value.
+ */
+int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	int cap_idx = 0;
+	int err = 0;
+	enum blk_crypto_mode_num blk_mode_num;
+	int slot = 0;
+	int num_keyslots;
+
+	/*
+	 * Don't use crypto if either the hardware doesn't advertise the
+	 * standard crypto capability bit *or* if the vendor specific driver
+	 * hasn't advertised that crypto is supported.
+	 */
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
+	    !(hba->caps & UFSHCD_CAP_CRYPTO))
+		goto out;
+
+	hba->crypto_capabilities.reg_val =
+			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
+	hba->crypto_cfg_register =
+		(u32)hba->crypto_capabilities.config_array_ptr * 0x100;
+	hba->crypto_cap_array =
+		devm_kcalloc(hba->dev, hba->crypto_capabilities.num_crypto_cap,
+			     sizeof(hba->crypto_cap_array[0]), GFP_KERNEL);
+	if (!hba->crypto_cap_array) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* The actual number of configurations supported is (CFGC+1) */
+	num_keyslots = hba->crypto_capabilities.config_count + 1;
+	err = blk_ksm_init(&hba->ksm, num_keyslots);
+	if (err)
+		goto out_free_caps;
+
+	hba->ksm.ksm_ll_ops = ufshcd_ksm_ops;
+	/* UFS only supports 8 bytes for any DUN */
+	hba->ksm.max_dun_bytes_supported = 8;
+	hba->ksm.dev = hba->dev;
+
+	/*
+	 * Cache all the UFS crypto capabilities and advertise the supported
+	 * crypto modes and data unit sizes to the block layer.
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		hba->crypto_cap_array[cap_idx].reg_val =
+			cpu_to_le32(ufshcd_readl(hba,
+						 REG_UFS_CRYPTOCAP +
+						 cap_idx * sizeof(__le32)));
+		blk_mode_num = ufshcd_find_blk_crypto_mode(
+						hba->crypto_cap_array[cap_idx]);
+		if (blk_mode_num != BLK_ENCRYPTION_MODE_INVALID)
+			hba->ksm.crypto_modes_supported[blk_mode_num] |=
+				hba->crypto_cap_array[cap_idx].sdus_mask * 512;
+	}
+
+	for (slot = 0; slot < num_keyslots; slot++)
+		ufshcd_clear_keyslot(hba, slot);
+
+	return 0;
+
+out_free_caps:
+	devm_kfree(hba->dev, hba->crypto_cap_array);
+out:
+	/* Indicate that init failed by clearing UFSHCD_CAP_CRYPTO */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+	return err;
+}
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q)
+{
+	if (hba->caps & UFSHCD_CAP_CRYPTO)
+		blk_ksm_register(&hba->ksm, q);
+}
+
+void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
+{
+	blk_ksm_destroy(&hba->ksm);
+}
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 0000000000000..22677619de595
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _UFSHCD_CRYPTO_H
+#define _UFSHCD_CRYPTO_H
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+#include "ufshcd.h"
+#include "ufshci.h"
+
+bool ufshcd_crypto_enable(struct ufs_hba *hba);
+
+int ufshcd_hba_init_crypto(struct ufs_hba *hba);
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q);
+
+void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba);
+
+#else /* CONFIG_SCSI_UFS_CRYPTO */
+
+static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	return false;
+}
+
+static inline int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	return 0;
+}
+
+static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+						struct request_queue *q) { }
+
+static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
+{ }
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ca570d3f10d42..6c14f72e9ccc1 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -57,6 +57,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/bitfield.h>
 #include <linux/devfreq.h>
+#include <linux/keyslot-manager.h>
 #include "unipro.h"
 
 #include <asm/irq.h>
@@ -601,6 +602,10 @@ enum ufshcd_caps {
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
+ * @crypto_capabilities: Content of crypto capabilities register (0x100)
+ * @crypto_cap_array: Array of crypto capabilities
+ * @crypto_cfg_register: Start of the crypto cfg array
+ * @ksm: the keyslot manager tied to this hba
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -720,6 +725,13 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	union ufs_crypto_capabilities crypto_capabilities;
+	union ufs_crypto_cap_entry *crypto_cap_array;
+	u32 crypto_cfg_register;
+	struct blk_keyslot_manager ksm;
+#endif
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.26.0.110.g2183baf09c-goog

