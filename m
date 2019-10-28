Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B245FE6CFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfJ1HUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:52 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39125 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbfJ1HUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:52 -0400
Received: by mail-pg1-f201.google.com with SMTP id m20so7649422pgv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YuLRBT8VeKFjeFAxW/RFbwDFQDt87L5ymIHlQ4T2tKE=;
        b=GKZGgMi/B6ycgEcPXCNsdNf93Eck666Y5VeC5+v8EzPCvEBsbJztoAv5JnltzkNazX
         5atVX3AUEQVUdaDz2uncJeVahLolQ7TfOgdHnbnBiL2vc/UWEdp2JTnu07kXYsBJji/Q
         Zqk9FtVOR/LLqsEcFxarl6fyZpWocebg40i8cWWDap4nd+287AALYb07uOnC7YEYNooj
         2xzOttjR/b8n4HGVT2voMOb7nF5ejTFw2D9eUkDjHq4Yu7KzERECuI3aflhauYzgTXbF
         VxLXTO3pQCRB89qNktQpwP0M41RRJ5v9QM66CZtT9aKvxjx/lTHsQCF1c0IFEuYZa9/W
         ZUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YuLRBT8VeKFjeFAxW/RFbwDFQDt87L5ymIHlQ4T2tKE=;
        b=UXMWthXu/4jEud5iP/9N3IlZEXCPMA85PZRxVX9+Lr2Y8YQUOlyIAZ+esgXi31f9Hx
         ThvPQONreXoHMjP+wqyvC5shcQMwsZ7oH7rtCZuR0kl0r+iisusEc+MtGtnSLVvn9Nkk
         qudtqiSxYqj8+qF+LSeLr2lOGOSRRKZ3L8XBfMqCVGpzN2QtkJ6bMLXFzO3WqE2WM9ly
         eOkSSHPYNYspACkuBe8MHVBrbMBYRA4vw5VeLxPkLQ+U7KZH1HakyIZuP81mSn8gvI6w
         yeCAEg7oGgIWGZE9MR+13/lVi+UCE9NYTmipfxXW6HeENFNOmAt6Lvk1/Jj/zSDJfQof
         oLsQ==
X-Gm-Message-State: APjAAAWWomih86KzXePkvZnr7WcFU4DpZUOOFD71VbAQlCKGIV0bTE0q
        ng0UQ/H7sEYfZlbhNBcuoC21KDYEpng=
X-Google-Smtp-Source: APXvYqwlVuJpn+Z1ioz3x/N3OYX0dwcv7dyCP7U4ND/nJgH4yaOVqF/AQ0+ZA9A5Z6rprH0WX9QpmN/gtBc=
X-Received: by 2002:a63:bc11:: with SMTP id q17mr10427556pge.223.1572247250972;
 Mon, 28 Oct 2019 00:20:50 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:28 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-6-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 5/9] scsi: ufs: UFS crypto API
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
 drivers/scsi/ufs/ufshcd-crypto.c | 391 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  86 +++++++
 drivers/scsi/ufs/ufshcd.h        |  14 ++
 5 files changed, 501 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 0b845ab7c3bf..3ee5cede823e 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -150,3 +150,12 @@ config SCSI_UFS_BSG
 
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
index 2a9097939bcb..094c39989a37 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
 obj-$(CONFIG_SCSI_UFS_MEDIATEK) += ufs-mediatek.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 000000000000..3900a07a7e9b
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <crypto/algapi.h>
+
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
+	case UFS_CRYPTO_KEY_SIZE_128: return 16;
+	case UFS_CRYPTO_KEY_SIZE_192: return 24;
+	case UFS_CRYPTO_KEY_SIZE_256: return 32;
+	case UFS_CRYPTO_KEY_SIZE_512: return 64;
+	default: return 0;
+	}
+}
+
+static int ufshcd_crypto_cap_find(void *hba_p,
+			   enum blk_crypto_mode_num crypto_mode,
+			   unsigned int data_unit_size)
+{
+	struct ufs_hba *hba = hba_p;
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
+	default: return -EINVAL;
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
+	case UFS_CRYPTO_ALG_BITLOCKER_AES_CBC: // fallthrough
+	case UFS_CRYPTO_ALG_AES_ECB: // fallthrough
+	case UFS_CRYPTO_ALG_ESSIV_AES_CBC:
+		memcpy(cfg->crypto_key, key, key_size_bytes);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void program_key(struct ufs_hba *hba,
+			const union ufs_crypto_cfg_entry *cfg,
+			int slot)
+{
+	int i;
+	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
+
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
+}
+
+static int ufshcd_crypto_keyslot_program(void *hba_p, const u8 *key,
+					 enum blk_crypto_mode_num crypto_mode,
+					 unsigned int data_unit_size,
+					 unsigned int slot)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int cap_idx;
+
+	cap_idx = ufshcd_crypto_cap_find(hba_p, crypto_mode,
+					       data_unit_size);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot) ||
+	    !ufshcd_cap_idx_valid(hba, cap_idx))
+		return -EINVAL;
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask & hba->crypto_cap_array[cap_idx].sdus_mask))
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.data_unit_size = data_unit_mask;
+	cfg.crypto_cap_idx = cap_idx;
+	cfg.config_enable |= UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+				hba->crypto_cap_array[cap_idx]);
+	if (err)
+		return err;
+
+	program_key(hba, &cfg, slot);
+
+	memcpy(&cfg_arr[slot], &cfg, sizeof(cfg));
+	memzero_explicit(&cfg, sizeof(cfg));
+
+	return 0;
+}
+
+static int ufshcd_crypto_keyslot_find(void *hba_p,
+				      const u8 *key,
+				      enum blk_crypto_mode_num crypto_mode,
+				      unsigned int data_unit_size)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	int slot;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int cap_idx;
+
+	cap_idx = ufshcd_crypto_cap_find(hba_p, crypto_mode,
+					       data_unit_size);
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_cap_idx_valid(hba, cap_idx))
+		return -EINVAL;
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask & hba->crypto_cap_array[cap_idx].sdus_mask))
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+					hba->crypto_cap_array[cap_idx]);
+
+	if (err)
+		return -EINVAL;
+
+	for (slot = 0; slot < NUM_KEYSLOTS(hba); slot++) {
+		if ((cfg_arr[slot].config_enable &
+		     UFS_CRYPTO_CONFIGURATION_ENABLE) &&
+		    data_unit_mask == cfg_arr[slot].data_unit_size &&
+		    cap_idx == cfg_arr[slot].crypto_cap_idx &&
+		    !crypto_memneq(&cfg.crypto_key, cfg_arr[slot].crypto_key,
+				  UFS_CRYPTO_KEY_MAX_SIZE)) {
+			memzero_explicit(&cfg, sizeof(cfg));
+			return slot;
+		}
+	}
+
+	memzero_explicit(&cfg, sizeof(cfg));
+	return -ENOKEY;
+}
+
+static int ufshcd_crypto_keyslot_evict(void *hba_p, const u8 *key,
+				       enum blk_crypto_mode_num crypto_mode,
+				       unsigned int data_unit_size,
+				       unsigned int slot)
+{
+	struct ufs_hba *hba = hba_p;
+	int i = 0;
+	u32 reg_base;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot))
+		return -EINVAL;
+
+	memset(&cfg_arr[slot], 0, sizeof(cfg_arr[slot]));
+	reg_base = hba->crypto_cfg_register + slot * sizeof(cfg_arr[0]);
+
+	/*
+	 * Clear the crypto cfg on the device. Clearing CFGE
+	 * might not be sufficient, so just clear the entire cfg.
+	 */
+	for (i = 0; i < sizeof(cfg_arr[0]); i += sizeof(__le32))
+		ufshcd_writel(hba, 0, reg_base + i);
+	wmb();
+
+	return 0;
+}
+
+static bool ufshcd_crypto_mode_supported(void *hba_p,
+					 enum blk_crypto_mode_num crypto_mode,
+					 unsigned int data_unit_size)
+{
+	return ufshcd_crypto_cap_find(hba_p, crypto_mode, data_unit_size) >= 0;
+}
+
+void ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int slot;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return;
+
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+	/*
+	 * Reset might clear all keys, so reprogram all the keys.
+	 * Also serves to clear keys on driver init.
+	 */
+	for (slot = 0; slot < NUM_KEYSLOTS(hba); slot++)
+		program_key(hba, &cfg_arr[slot], slot);
+}
+
+void ufshcd_crypto_disable(struct ufs_hba *hba)
+{
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+}
+
+static const struct keyslot_mgmt_ll_ops ufshcd_ksm_ops = {
+	.keyslot_program	= ufshcd_crypto_keyslot_program,
+	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.keyslot_find		= ufshcd_crypto_keyslot_find,
+	.crypto_mode_supported	= ufshcd_crypto_mode_supported,
+};
+
+/**
+ * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
+ * @hba: Per adapter instance
+ *
+ * Returns 0 on success. Returns -ENODEV if such capabilities don't exist, and
+ * -ENOMEM upon OOM.
+ */
+int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	int cap_idx = 0;
+	int err = 0;
+
+	/* Default to disabling crypto */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT)) {
+		err = -ENODEV;
+		goto out;
+	}
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
+	hba->crypto_cfgs =
+		devm_kcalloc(hba->dev,
+			     NUM_KEYSLOTS(hba),
+			     sizeof(hba->crypto_cfgs[0]),
+			     GFP_KERNEL);
+	if (!hba->crypto_cfgs) {
+		err = -ENOMEM;
+		goto out_free_cfg_mem;
+	}
+
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
+	}
+
+	hba->ksm = keyslot_manager_create(NUM_KEYSLOTS(hba), &ufshcd_ksm_ops,
+					  hba);
+
+	if (!hba->ksm) {
+		err = -ENOMEM;
+		goto out_free_crypto_cfgs;
+	}
+
+	return 0;
+out_free_crypto_cfgs:
+	devm_kfree(hba->dev, hba->crypto_cfgs);
+out_free_cfg_mem:
+	devm_kfree(hba->dev, hba->crypto_cap_array);
+out:
+	// TODO: print error?
+	/* Indicate that init failed by setting crypto_capabilities to 0 */
+	hba->crypto_capabilities.reg_val = 0;
+	return err;
+}
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba) || !q)
+		return;
+
+	q->ksm = hba->ksm;
+}
+
+void ufshcd_crypto_destroy_rq_keyslot_manager(struct ufs_hba *hba,
+					      struct request_queue *q)
+{
+	keyslot_manager_destroy(hba->ksm);
+}
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 000000000000..73ddc8e493fb
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
+struct ufs_hba;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+#include <linux/keyslot-manager.h>
+
+#include "ufshci.h"
+
+#define NUM_KEYSLOTS(hba) (hba->crypto_capabilities.config_count + 1)
+
+static inline bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
+{
+	/*
+	 * The actual number of configurations supported is (CFGC+1), so slot
+	 * numbers range from 0 to config_count inclusive.
+	 */
+	return slot < NUM_KEYSLOTS(hba);
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
+static inline void ufshcd_crypto_setup_rq_keyslot_manager(
+					struct ufs_hba *hba,
+					struct request_queue *q) { }
+
+static inline void ufshcd_crypto_destroy_rq_keyslot_manager(
+				struct ufs_hba *hba,
+				struct request_queue *q) { }
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8f2329b4fe79..31e64f4267dd 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -525,6 +525,11 @@ struct ufs_stats {
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
+ * @crypto_capabilities: Content of crypto capabilities register (0x100)
+ * @crypto_cap_array: Array of crypto capabilities
+ * @crypto_cfg_register: Start of the crypto cfg array
+ * @crypto_cfgs: Array of crypto configurations (i.e. config for each slot)
+ * @ksm: the keyslot manager tied to this hba
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -735,6 +740,15 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	/* crypto */
+	union ufs_crypto_capabilities crypto_capabilities;
+	union ufs_crypto_cap_entry *crypto_cap_array;
+	u32 crypto_cfg_register;
+	union ufs_crypto_cfg_entry *crypto_cfgs;
+	struct keyslot_manager *ksm;
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.24.0.rc0.303.g954a862665-goog

