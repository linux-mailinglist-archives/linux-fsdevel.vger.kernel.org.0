Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41DCE167CBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 12:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgBULvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 06:51:38 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59383 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgBULvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:51:13 -0500
Received: by mail-pj1-f74.google.com with SMTP id ie20so844933pjb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hlTekD0lbPk0TIDYnujJFRmzcwaIaeKN4ilcnosjaP0=;
        b=K+x340K+LkNhtMBeXN8ca1XXLOcCbohm/EfVnbb9GrIT+UFHgVU0IYNEtwyN8dzKd0
         L5owUV+vWFV91qxKOnE3gXFX9USpGAcqhaxGBhccm0YnzylGs3wnWCUApiiJX1TGWBoJ
         H231G8y6juVxKs2N/CeH0vPXGdIqi6ty33e+gq+ngPEdMZ/2mYj92i+op0ojonwQZKI/
         MflddAOk4oDs96PSuI1tJhfo1UZ+s2NIL/GfsDtXJoTFWcZiS3vxrcdTNqgleUHPneAw
         hXxX6dtP/VAgeFWiKFjuTFwBvHJhYpMzzGjYU6CQLLvlBGI5YpLgtrL5E1H13/+own5B
         Bjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hlTekD0lbPk0TIDYnujJFRmzcwaIaeKN4ilcnosjaP0=;
        b=FXTNsaZbroGr3/ktUPHYXR6O4+S7I1jeseh3B8sNsH3uz4k8nXPKck5WIldMEkiu86
         BxGtyd5jql1QUCubVGNYoU8xphsTBNF/Aq/XlTDSAniOnpz3DA3nYIHnstGJ4hSnlkGF
         a/5IkkT15k9+npNNJmi48FXsIycXXelGP9NcSmbXsM/AbF60eY+WGXWB+jjOlP8Wk465
         89P68Y6EYxNMLEAyi11cyEvt0H5SsfALAmc7Qw+coFoOEakJqc0cdrKErqYyD2cl4Uuh
         KxHsjHuapTbN05Df5qIGtg18UjM6C51ZFQvuRz50XQyQPnHtMfj7cjHBwdTkCUHxsN9M
         6tGQ==
X-Gm-Message-State: APjAAAXSjC/w68D94ku3wNGJZcPolj1ZarrujMaBZhMtG07++2TvI25k
        vq6mvCs6bQblxOa5yVp8WxpH1QpNO00=
X-Google-Smtp-Source: APXvYqy7fP0PMxTqRe5Txj7oWdyZshKbh4DRX5CEQp4LRxYvKTbrSyNZJnszC5hL+6l8ZLl/KdL0OR7qT7E=
X-Received: by 2002:a63:be48:: with SMTP id g8mr39328456pgo.23.1582285872856;
 Fri, 21 Feb 2020 03:51:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 03:50:46 -0800
In-Reply-To: <20200221115050.238976-1-satyat@google.com>
Message-Id: <20200221115050.238976-6-satyat@google.com>
Mime-Version: 1.0
References: <20200221115050.238976-1-satyat@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 5/9] scsi: ufs: UFS crypto API
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

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/Kconfig         |   9 +
 drivers/scsi/ufs/Makefile        |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c | 367 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  54 +++++
 drivers/scsi/ufs/ufshcd.h        |  20 ++
 5 files changed, 451 insertions(+)
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
index 94c6c5d7334b..197e178f44bc 100644
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
index 000000000000..1b8e14d30c04
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/keyslot-manager.h>
+#include "ufshcd.h"
+#include "ufshcd-crypto.h"
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
+static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
+{
+	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
+}
+
+static u8 ufshcd_get_data_unit_size_mask(unsigned int data_unit_size)
+{
+	if (data_unit_size < 512 || data_unit_size > 65536 ||
+	    !is_power_of_2(data_unit_size))
+		return 0;
+
+	return data_unit_size / 512;
+}
+
+static size_t ufshcd_get_keysize_bytes(enum ufs_crypto_key_size size)
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
+	data_unit_mask = ufshcd_get_data_unit_size_mask(data_unit_size);
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
+	size_t key_size_bytes = ufshcd_get_keysize_bytes(cap.key_size);
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
+	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
+	int err = 0;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	int cap_idx;
+
+	cap_idx = ufshcd_crypto_cap_find(hba, key->crypto_mode,
+					 key->data_unit_size);
+
+	if (!(hba->caps & UFSHCD_CAP_CRYPTO) ||
+	    !ufshcd_keyslot_valid(hba, slot) ||
+	    !ufshcd_cap_idx_valid(hba, cap_idx))
+		return -EINVAL;
+
+	data_unit_mask = ufshcd_get_data_unit_size_mask(key->data_unit_size);
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
+	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
+
+	if (!(hba->caps & UFSHCD_CAP_CRYPTO) ||
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
+void ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return;
+
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+
+	/* Reset might clear all keys, so reprogram all the keys. */
+	blk_ksm_reprogram_all_keys(&hba->ksm);
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
+};
+
+bool ufshcd_blk_crypto_mode_num_for_alg_dusize(
+					enum ufs_crypto_alg ufs_crypto_alg,
+					enum ufs_crypto_key_size key_size,
+					enum blk_crypto_mode_num *blk_mode_num,
+					unsigned int *max_dun_bytes_supported)
+{
+	/*
+	 * This is currently the only mode that UFS and blk-crypto both support.
+	 */
+	if (ufs_crypto_alg == UFS_CRYPTO_ALG_AES_XTS &&
+	    key_size == UFS_CRYPTO_KEY_SIZE_256) {
+		*blk_mode_num = BLK_ENCRYPTION_MODE_AES_256_XTS;
+		*max_dun_bytes_supported = 8;
+		return true;
+	}
+
+	return false;
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
+	unsigned int max_dun_bytes;
+
+	/* Default to disabling crypto */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	/* Return 0 if crypto support isn't present */
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
+	    (hba->quirks & UFSHCD_QUIRK_BROKEN_CRYPTO))
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
+	err = blk_ksm_init(&hba->ksm, hba->dev, ufshcd_num_keyslots(hba));
+	if (err)
+		goto out_free_caps;
+
+	hba->ksm.ksm_ll_ops = ufshcd_ksm_ops;
+	hba->ksm.ll_priv_data = hba;
+
+	memset(hba->ksm.crypto_modes_supported, 0,
+	       sizeof(hba->ksm.crypto_modes_supported));
+	memset(hba->ksm.max_dun_bytes_supported, 0,
+	       sizeof(hba->ksm.max_dun_bytes_supported));
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
+		if (!ufshcd_blk_crypto_mode_num_for_alg_dusize(
+				hba->crypto_cap_array[cap_idx].algorithm_id,
+				hba->crypto_cap_array[cap_idx].key_size,
+				&blk_mode_num,
+				&max_dun_bytes))
+			continue;
+		hba->ksm.crypto_modes_supported[blk_mode_num] |=
+			hba->crypto_cap_array[cap_idx].sdus_mask * 512;
+		hba->ksm.max_dun_bytes_supported[blk_mode_num] = max_dun_bytes;
+	}
+
+	ufshcd_clear_all_keyslots(hba);
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
+
+void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					    struct request_queue *q)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba) || !q)
+		return;
+
+	q->ksm = &hba->ksm;
+}
+
+void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
+{
+	blk_ksm_destroy(&hba->ksm);
+}
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 000000000000..8270c0c5081a
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,54 @@
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
+static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return hba->crypto_capabilities.reg_val != 0;
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
+void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba);
+
+#else /* CONFIG_SCSI_UFS_CRYPTO */
+
+static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
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
+static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
+{ }
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 978781c538c4..7b8a87418f0c 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -55,6 +55,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/regulator/consumer.h>
+#include <linux/keyslot-manager.h>
 #include "unipro.h"
 
 #include <asm/irq.h>
@@ -521,6 +522,10 @@ struct ufs_stats {
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
@@ -634,6 +639,13 @@ struct ufs_hba {
 	 * enabled via HCE register.
 	 */
 	#define UFSHCI_QUIRK_BROKEN_HCE				0x400
+
+	/*
+	 * This quirk needs to be enabled if the host controller advertises
+	 * inline encryption support but it doesn't work correctly.
+	 */
+	#define UFSHCD_QUIRK_BROKEN_CRYPTO			0x800
+
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
@@ -735,6 +747,14 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	/* crypto */
+	union ufs_crypto_capabilities crypto_capabilities;
+	union ufs_crypto_cap_entry *crypto_cap_array;
+	u32 crypto_cfg_register;
+	struct keyslot_manager ksm;
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.25.0.265.gbab2e86ba0-goog

