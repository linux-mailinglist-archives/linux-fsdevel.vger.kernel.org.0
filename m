Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD60124A4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLROwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:52:35 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54353 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfLROwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:52:34 -0500
Received: by mail-pf1-f201.google.com with SMTP id v14so1413863pfm.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wzkcr+zoTSzhv7WWY9LkN1q17itmXtN69Iemtiq6qxU=;
        b=A4J//EMewrWOkNCyXgDgp7KEMlveeKZCCjLXecpAC+H0W8ex8ltRoI2QU4EfVNGnJU
         pw85qVcsv48gegOeIn6WKMUZpnXA4IF5jlOE5cUcy/2Am+yOk5B1UyJB7CbefPx5vH9t
         4uWUE1dlwROEHAOyWCCBUJJGBIYjjatOyoz48ktKsWu3+ZaPBTQfq6prlwjG53yz5PJi
         cyTZqE6d+LiJvBUGbdqaLxBim58ii8shVNodeifqCA44RzVX4wy0wYhP9TL51/j7uqu+
         c2IGxEraJ4cyvduIch1w5DlCIVdUPEPCo0FJd1oktgeadpaGrUX8cI2eA/kWGEvegdqD
         ZUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wzkcr+zoTSzhv7WWY9LkN1q17itmXtN69Iemtiq6qxU=;
        b=pLH4DFW7d2KBVeBiPIjphPnpBXpdHS7FdpSuj927o8cwlUdOYIuHs3+kBLE1Dd8uFZ
         EZw4jxSm3FH2cD8ikujGx+ZUPBxquqDcfPOIjKIbaATrwbITSgRQp4GjNJS0AZa88/ai
         LKd5JrflRHw9n7si+YG3NJDRB5gwfMcotTrYB+xya5khsDbaWckdtUyKHBFIuhMo3vqF
         orCu9X7GFCpKDyyBA0sM4KfI6Nn0utnC5ZApJHeE02YNkpC3H/xaFlX+ftZfpxFmhHB3
         s9PyqnNHhN6lPSjbkxnKG9zvcqGsgkZBoJ4C7ggQLRfcuhlahn29BYTP0CVuNmwHySRf
         fJYQ==
X-Gm-Message-State: APjAAAXuG4encRcc0hT+Cyitr9+x+yNOemXuB53T2FLp9XH1Ync8rMEI
        CBA7c+k4SjE9zrLuT2MuXhYoQKzkIBk=
X-Google-Smtp-Source: APXvYqzaMB6+uJyqpj5xgq+rwThrgdH5RqmUaSUXaHqP07l34mNVLKLHtB4A306CFlbx6zarChO8U294QFk=
X-Received: by 2002:a65:408d:: with SMTP id t13mr3424296pgp.441.1576680752346;
 Wed, 18 Dec 2019 06:52:32 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:51:32 -0800
In-Reply-To: <20191218145136.172774-1-satyat@google.com>
Message-Id: <20191218145136.172774-6-satyat@google.com>
Mime-Version: 1.0
References: <20191218145136.172774-1-satyat@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v6 5/9] scsi: ufs: UFS crypto API
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

Introduce functions to manipulate UFS inline encryption hardware
in line with the JEDEC UFSHCI v2.1 specification and to work with the
block keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/Kconfig         |   9 +
 drivers/scsi/ufs/Makefile        |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c | 361 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  86 ++++++++
 drivers/scsi/ufs/ufshcd.h        |  12 +
 5 files changed, 469 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index d14c2243e02a..c69f1b49167b 100644
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
index 94c6c5d7334b..e88cdcde83fd 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_SCSI_UFS_TI_J721E) += ti-j721e-ufs.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 000000000000..b0aa072d9009
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/keyslot-manager.h>
+#include "ufshcd.h"
+#include "ufshcd-crypto.h"
+
+static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
+{
+	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
+}
+
+static u8 get_data_unit_size_mask(unsigned int data_unit_size)
+{
+	if (data_unit_size < 512 || data_unit_size > 65536 ||
+	    !is_power_of_2(data_unit_size))
+		return 0;
+
+	return data_unit_size / 512;
+}
+
+static size_t get_keysize_bytes(enum ufs_crypto_key_size size)
+{
+	switch (size) {
+	case UFS_CRYPTO_KEY_SIZE_128:
+		return 16;
+	case UFS_CRYPTO_KEY_SIZE_192:
+		return 24;
+	case UFS_CRYPTO_KEY_SIZE_256:
+		return 32;
+	case UFS_CRYPTO_KEY_SIZE_512:
+		return 64;
+	default:
+		return 0;
+	}
+}
+
+static int ufshcd_crypto_cap_find(struct ufs_hba *hba,
+				  enum blk_crypto_mode_num crypto_mode,
+				  unsigned int data_unit_size)
+{
+	enum ufs_crypto_alg ufs_alg;
+	u8 data_unit_mask;
+	int cap_idx;
+	enum ufs_crypto_key_size ufs_key_size;
+	union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return -EINVAL;
+
+	switch (crypto_mode) {
+	case BLK_ENCRYPTION_MODE_AES_256_XTS:
+		ufs_alg = UFS_CRYPTO_ALG_AES_XTS;
+		ufs_key_size = UFS_CRYPTO_KEY_SIZE_256;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		if (ccap_array[cap_idx].algorithm_id == ufs_alg &&
+		    (ccap_array[cap_idx].sdus_mask & data_unit_mask) &&
+		    ccap_array[cap_idx].key_size == ufs_key_size)
+			return cap_idx;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * ufshcd_crypto_cfg_entry_write_key - Write a key into a crypto_cfg_entry
+ *
+ *	Writes the key with the appropriate format - for AES_XTS,
+ *	the first half of the key is copied as is, the second half is
+ *	copied with an offset halfway into the cfg->crypto_key array.
+ *	For the other supported crypto algs, the key is just copied.
+ *
+ * @cfg: The crypto config to write to
+ * @key: The key to write
+ * @cap: The crypto capability (which specifies the crypto alg and key size)
+ *
+ * Returns 0 on success, or -EINVAL
+ */
+static int ufshcd_crypto_cfg_entry_write_key(union ufs_crypto_cfg_entry *cfg,
+					     const u8 *key,
+					     union ufs_crypto_cap_entry cap)
+{
+	size_t key_size_bytes = get_keysize_bytes(cap.key_size);
+
+	if (key_size_bytes == 0)
+		return -EINVAL;
+
+	switch (cap.algorithm_id) {
+	case UFS_CRYPTO_ALG_AES_XTS:
+		key_size_bytes *= 2;
+		if (key_size_bytes > UFS_CRYPTO_KEY_MAX_SIZE)
+			return -EINVAL;
+
+		memcpy(cfg->crypto_key, key, key_size_bytes/2);
+		memcpy(cfg->crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
+		       key + key_size_bytes/2, key_size_bytes/2);
+		return 0;
+	case UFS_CRYPTO_ALG_BITLOCKER_AES_CBC:
+		/* fall through */
+	case UFS_CRYPTO_ALG_AES_ECB:
+		/* fall through */
+	case UFS_CRYPTO_ALG_ESSIV_AES_CBC:
+		memcpy(cfg->crypto_key, key, key_size_bytes);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void ufshcd_program_key(struct ufs_hba *hba,
+			       const union ufs_crypto_cfg_entry *cfg,
+			       int slot)
+{
+	int i;
+	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
+
+	pm_runtime_get_sync(hba->dev);
+	ufshcd_hold(hba, false);
+	/* Clear the dword 16 */
+	ufshcd_writel(hba, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	/* Ensure that CFGE is cleared before programming the key */
+	wmb();
+	for (i = 0; i < 16; i++) {
+		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
+			      slot_offset + i * sizeof(cfg->reg_val[0]));
+		/* Spec says each dword in key must be written sequentially */
+		wmb();
+	}
+	/* Write dword 17 */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
+		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
+	/* Dword 16 must be written last */
+	wmb();
+	/* Write dword 16 */
+	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
+		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	wmb();
+	ufshcd_release(hba);
+	pm_runtime_put_sync(hba->dev);
+}
+
+static void ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
+{
+	union ufs_crypto_cfg_entry cfg = { 0 };
+
+	ufshcd_program_key(hba, &cfg, slot);
+}
+
+/* Clear all keyslots at driver init time */
+static void ufshcd_clear_all_keyslots(struct ufs_hba *hba)
+{
+	int slot;
+
+	for (slot = 0; slot < ufshcd_num_keyslots(hba); slot++)
+		ufshcd_clear_keyslot(hba, slot);
+}
+
+static int ufshcd_crypto_keyslot_program(struct keyslot_manager *ksm,
+					 const struct blk_crypto_key *key,
+					 unsigned int slot)
+{
+	struct ufs_hba *hba = keyslot_manager_private(ksm);
+	int err = 0;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	int cap_idx;
+
+	cap_idx = ufshcd_crypto_cap_find(hba, key->crypto_mode,
+					 key->data_unit_size);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot) ||
+	    !ufshcd_cap_idx_valid(hba, cap_idx))
+		return -EINVAL;
+
+	data_unit_mask = get_data_unit_size_mask(key->data_unit_size);
+
+	if (!(data_unit_mask & hba->crypto_cap_array[cap_idx].sdus_mask))
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.data_unit_size = data_unit_mask;
+	cfg.crypto_cap_idx = cap_idx;
+	cfg.config_enable |= UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key->raw,
+						hba->crypto_cap_array[cap_idx]);
+	if (err)
+		return err;
+
+	ufshcd_program_key(hba, &cfg, slot);
+
+	memzero_explicit(&cfg, sizeof(cfg));
+	return 0;
+}
+
+static int ufshcd_crypto_keyslot_evict(struct keyslot_manager *ksm,
+				       const struct blk_crypto_key *key,
+				       unsigned int slot)
+{
+	struct ufs_hba *hba = keyslot_manager_private(ksm);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot))
+		return -EINVAL;
+
+	/*
+	 * Clear the crypto cfg on the device. Clearing CFGE
+	 * might not be sufficient, so just clear the entire cfg.
+	 */
+	ufshcd_clear_keyslot(hba, slot);
+
+	return 0;
+}
+
+/* Functions implementing UFSHCI v2.1 specification behaviour */
+void ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return;
+
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+
+	/* Reset might clear all keys, so reprogram all the keys. */
+	keyslot_manager_reprogram_all_keys(hba->ksm);
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_enable);
+
+void ufshcd_crypto_disable(struct ufs_hba *hba)
+{
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_disable);
+
+static const struct keyslot_mgmt_ll_ops ufshcd_ksm_ops = {
+	.keyslot_program	= ufshcd_crypto_keyslot_program,
+	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+};
+
+enum blk_crypto_mode_num ufshcd_blk_crypto_mode_num_for_alg_dusize(
+					enum ufs_crypto_alg ufs_crypto_alg,
+					enum ufs_crypto_key_size key_size)
+{
+	/*
+	 * This is currently the only mode that UFS and blk-crypto both support.
+	 */
+	if (ufs_crypto_alg == UFS_CRYPTO_ALG_AES_XTS &&
+		key_size == UFS_CRYPTO_KEY_SIZE_256)
+		return BLK_ENCRYPTION_MODE_AES_256_XTS;
+
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
+	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX];
+	enum blk_crypto_mode_num blk_mode_num;
+
+	/* Default to disabling crypto */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	/* Return 0 if crypto support isn't present */
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT))
+		goto out;
+
+	/*
+	 * Crypto Capabilities should never be 0, because the
+	 * config_array_ptr > 04h. So we use a 0 value to indicate that
+	 * crypto init failed, and can't be enabled.
+	 */
+	hba->crypto_capabilities.reg_val =
+			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
+	hba->crypto_cfg_register =
+		(u32)hba->crypto_capabilities.config_array_ptr * 0x100;
+	hba->crypto_cap_array =
+		devm_kcalloc(hba->dev,
+			     hba->crypto_capabilities.num_crypto_cap,
+			     sizeof(hba->crypto_cap_array[0]),
+			     GFP_KERNEL);
+	if (!hba->crypto_cap_array) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memset(crypto_modes_supported, 0, sizeof(crypto_modes_supported));
+	/*
+	 * Store all the capabilities now so that we don't need to repeatedly
+	 * access the device each time we want to know its capabilities
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		hba->crypto_cap_array[cap_idx].reg_val =
+			cpu_to_le32(ufshcd_readl(hba,
+						 REG_UFS_CRYPTOCAP +
+						 cap_idx * sizeof(__le32)));
+		blk_mode_num = ufshcd_blk_crypto_mode_num_for_alg_dusize(
+				hba->crypto_cap_array[cap_idx].algorithm_id,
+				hba->crypto_cap_array[cap_idx].key_size);
+		if (blk_mode_num == BLK_ENCRYPTION_MODE_INVALID)
+			continue;
+		crypto_modes_supported[blk_mode_num] |=
+			hba->crypto_cap_array[cap_idx].sdus_mask * 512;
+	}
+
+	ufshcd_clear_all_keyslots(hba);
+
+	hba->ksm = keyslot_manager_create(ufshcd_num_keyslots(hba),
+					  &ufshcd_ksm_ops,
+					  crypto_modes_supported, hba);
+
+	if (!hba->ksm) {
+		err = -ENOMEM;
+		goto out_free_caps;
+	}
+
+	return 0;
+
+out_free_caps:
+	devm_kfree(hba->dev, hba->crypto_cap_array);
+out:
+	/* Indicate that init failed by setting crypto_capabilities to 0 */
+	hba->crypto_capabilities.reg_val = 0;
+	return err;
+}
+EXPORT_SYMBOL_GPL(ufshcd_hba_init_crypto);
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba) || !q)
+		return;
+
+	q->ksm = hba->ksm;
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_setup_rq_keyslot_manager);
+
+void ufshcd_crypto_destroy_rq_keyslot_manager(struct ufs_hba *hba,
+					      struct request_queue *q)
+{
+	keyslot_manager_destroy(hba->ksm);
+}
+EXPORT_SYMBOL_GPL(ufshcd_crypto_destroy_rq_keyslot_manager);
+
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 000000000000..61996c6520e9
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _UFSHCD_CRYPTO_H
+#define _UFSHCD_CRYPTO_H
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+#include <linux/keyslot-manager.h>
+#include "ufshcd.h"
+#include "ufshci.h"
+
+static inline int ufshcd_num_keyslots(struct ufs_hba *hba)
+{
+	return hba->crypto_capabilities.config_count + 1;
+}
+
+static inline bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
+{
+	/*
+	 * The actual number of configurations supported is (CFGC+1), so slot
+	 * numbers range from 0 to config_count inclusive.
+	 */
+	return slot < ufshcd_num_keyslots(hba);
+}
+
+static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return hba->crypto_capabilities.reg_val != 0;
+}
+
+static inline bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_CRYPTO;
+}
+
+/* Functions implementing UFSHCI v2.1 specification behaviour */
+void ufshcd_crypto_enable(struct ufs_hba *hba);
+
+void ufshcd_crypto_disable(struct ufs_hba *hba);
+
+int ufshcd_hba_init_crypto(struct ufs_hba *hba);
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q);
+
+void ufshcd_crypto_destroy_rq_keyslot_manager(struct ufs_hba *hba,
+					      struct request_queue *q);
+
+#else /* CONFIG_SCSI_UFS_CRYPTO */
+
+static inline bool ufshcd_keyslot_valid(struct ufs_hba *hba,
+					unsigned int slot)
+{
+	return false;
+}
+
+static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return false;
+}
+
+static inline bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
+{
+	return false;
+}
+
+static inline void ufshcd_crypto_enable(struct ufs_hba *hba) { }
+
+static inline void ufshcd_crypto_disable(struct ufs_hba *hba) { }
+
+static inline int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	return 0;
+}
+
+static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+						struct request_queue *q) { }
+
+static inline void ufshcd_crypto_destroy_rq_keyslot_manager(struct ufs_hba *hba,
+						struct request_queue *q) { }
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index dbb581244bdb..6c8e2d04e9f8 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -525,6 +525,10 @@ struct ufs_stats {
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
@@ -741,6 +745,14 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	/* crypto */
+	union ufs_crypto_capabilities crypto_capabilities;
+	union ufs_crypto_cap_entry *crypto_cap_array;
+	u32 crypto_cfg_register;
+	struct keyslot_manager *ksm;
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.24.1.735.g03f4e72817-goog

