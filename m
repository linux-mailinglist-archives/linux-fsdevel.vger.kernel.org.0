Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46A015628
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEFWmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 18:42:36 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56173 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfEFWmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 18:42:36 -0400
Received: by mail-qk1-f202.google.com with SMTP id l4so15992546qke.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UNMpfx4u0m7XeyGRPJFN0wzD6OA0kU0/7UH6Z+ZX2TE=;
        b=Gzfsl6hewryy7/I1MdOUPSZNbUjEblyeMUadnDbwMK+2AkL9V/4NsSQEw5ONPrj7Cc
         CIOTDJzdyaEAfHH6KgJurp9g/DnPuaYv0kPjlNoXLKRYQwdOg7Pp2fUXTVLj8/0PDi0B
         9NU7ndIc2/nTSoUTKRHoTCRoRPXKG0TIkLEXEnqNa5UH5PrzlUUrpnnB0M9fAe4QhPMw
         pDEIKmIrGYIb6hoLgqgVbdZb6osesCuL4BUR5WXNL3IxgCyBiD1yRWyNl8EzeTOzP0be
         xdLPByOvRW+Q5C7AoEgop6xIcl2iwCdw3Y7MrYSNdR/bC3ZSxmJDqvQTaiIBe/hwaNNf
         PiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UNMpfx4u0m7XeyGRPJFN0wzD6OA0kU0/7UH6Z+ZX2TE=;
        b=AcXRXpqDj7LsrE9XT1QZv4kTMLOVXfq61fIADkrxbG3apgtSQzhYKKxtgqyuRVzjrc
         7HyOzeeydVh8GQ29AbV0gEKXyOEs0tgriSqUj7kaGMkJcmffy7aB/yv7YT3YHEIoktue
         0BDIpdq6tuJQPk+XzjtNwfpoIbqNuWZYL3l5VxRn+8McPEeyCOiDFVSUJSp1sMKZG0Sr
         /ZHfU+zKMBeRFnlnE0yfyOIHUOI8LjqvKXyosH3PZbLTBZF6z64wzZlUP/bw6iScGHua
         anvWV07X2evfja3f99xg1sOSFxSbO+penjU4TOI30H8XTgD73m8XANb2tVzwXzaHlmeT
         hgHw==
X-Gm-Message-State: APjAAAU5lb/zU9oghB6kits5Vf9ad1R3tA2sBqzfihg9tr4RtI4MCvhc
        9iQMyzNu7FiU4SrUT2vwEmQ/MfRyaAw=
X-Google-Smtp-Source: APXvYqxM/w+70wVGtVeubT9xrGn581uu5PjcgD80EaB6NCzTo5AW3MRwjwfBXWX2NQ+DMZaCYgI6Uol5A+Q=
X-Received: by 2002:a37:9b10:: with SMTP id d16mr10871854qke.41.1557182554404;
 Mon, 06 May 2019 15:42:34 -0700 (PDT)
Date:   Mon,  6 May 2019 15:35:42 -0700
In-Reply-To: <20190506223544.195371-1-satyat@google.com>
Message-Id: <20190506223544.195371-3-satyat@google.com>
Mime-Version: 1.0
References: <20190506223544.195371-1-satyat@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 2/4] scsi: ufs: UFS driver v2.1 crypto support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Uses the UFSHCI v2.1 spec to manage keys in inline crypto engine
hardware, and exposes that functionality through the keyslot manager it
sets up in the device's request_queue. Uses the keyslot in the
bio_crypt_ctx of the bio, if specified, as the encryption context.

Known Issues: In the current implementation, multiple keyslot managers
may be allocated for a single UFS host. We should tie keyslot managers
to hosts to avoid this issue.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/Kconfig         |  10 +
 drivers/scsi/ufs/Makefile        |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c | 449 +++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h |  92 +++++++
 drivers/scsi/ufs/ufshcd.c        |  85 +++++-
 drivers/scsi/ufs/ufshcd.h        |  23 ++
 drivers/scsi/ufs/ufshci.h        |  67 ++++-
 7 files changed, 720 insertions(+), 7 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 6db37cf306b0..c14f445a2522 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -135,3 +135,13 @@ config SCSI_UFS_BSG
 
 	  Select this if you need a bsg device node for your UFS controller.
 	  If unsure, say N.
+
+config SCSI_UFS_CRYPTO
+	bool "UFS Crypto Engine Support"
+	depends on SCSI_UFSHCD && BLK_KEYSLOT_MANAGER
+	help
+	Enable Crypto Engine Support in UFS.
+	Enabling this makes it possible for the kernel to use the crypto
+	capabilities of the UFS device (if present) to perform crypto
+	operations on data being transferred into/out of the device.
+
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index a3bd70c3652c..5b52463e8abf 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -10,3 +10,4 @@ ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
+ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
\ No newline at end of file
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
new file mode 100644
index 000000000000..af1da161d53e
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -0,0 +1,449 @@
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
+/*TODO: worry about endianness and cpu_to_le32 */
+
+bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
+{
+	return hba->crypto_capabilities.reg_val != 0;
+}
+
+bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
+{
+	return hba->caps & UFSHCD_CAP_CRYPTO;
+}
+
+static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
+{
+	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
+}
+
+bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
+{
+	/**
+	 * The actual number of configurations supported is (CFGC+1), so slot
+	 * numbers range from 0 to config_count inclusive.
+	 */
+	return slot <= hba->crypto_capabilities.config_count;
+}
+
+static u8 get_data_unit_size_mask(unsigned int data_unit_size)
+{
+	if (data_unit_size < 512 || data_unit_size > 65536 ||
+	    !is_power_of_2(data_unit_size)) {
+		return 0;
+	}
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
+ * Returns 0 on success, or -errno
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
+	/* TODO: swab32 on the key? */
+	for (i = 0; i < 16; i++) {
+		ufshcd_writel(hba, cfg->reg_val[i],
+			      slot_offset + i * sizeof(cfg->reg_val[0]));
+		/* Spec says each dword in key must be written sequentially */
+		wmb();
+	}
+	/* Write dword 17 */
+	ufshcd_writel(hba, cfg->reg_val[17],
+		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
+	/* Dword 16 must be written last */
+	wmb();
+	/* Write dword 16 */
+	ufshcd_writel(hba, cfg->reg_val[16],
+		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
+	wmb();
+}
+
+static int ufshcd_crypto_keyslot_program(void *hba_p, const u8 *key,
+			      unsigned int data_unit_size,
+			      unsigned int crypto_alg_id,
+			      unsigned int slot)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot) ||
+	    !ufshcd_cap_idx_valid(hba, crypto_alg_id)) {
+		return -EINVAL;
+	}
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask &
+	      hba->crypto_cap_array[crypto_alg_id].sdus_mask)) {
+		return -EINVAL;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.data_unit_size = data_unit_mask;
+	cfg.crypto_cap_idx = crypto_alg_id;
+	cfg.config_enable |= UFS_CRYPTO_CONFIGURATION_ENABLE;
+
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+					hba->crypto_cap_array[crypto_alg_id]);
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
+				      unsigned int data_unit_size,
+				      unsigned int crypto_alg_id)
+{
+	struct ufs_hba *hba = hba_p;
+	int err = 0;
+	int slot;
+	u8 data_unit_mask;
+	union ufs_crypto_cfg_entry cfg;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    crypto_alg_id >= hba->crypto_capabilities.num_crypto_cap) {
+		return -EINVAL;
+	}
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	if (!(data_unit_mask &
+	      hba->crypto_cap_array[crypto_alg_id].sdus_mask)) {
+		return -EINVAL;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key,
+					hba->crypto_cap_array[crypto_alg_id]);
+
+	if (err)
+		return -EINVAL;
+
+	for (slot = 0; slot <= hba->crypto_capabilities.config_count; slot++) {
+		if ((cfg_arr[slot].config_enable &
+		     UFS_CRYPTO_CONFIGURATION_ENABLE) &&
+		    data_unit_mask == cfg_arr[slot].data_unit_size &&
+		    crypto_alg_id == cfg_arr[slot].crypto_cap_idx &&
+		    crypto_memneq(&cfg.crypto_key, cfg_arr[slot].crypto_key,
+				  UFS_CRYPTO_KEY_MAX_SIZE) == 0) {
+			memzero_explicit(&cfg, sizeof(cfg));
+			return slot;
+		}
+	}
+
+	memzero_explicit(&cfg, sizeof(cfg));
+	return -ENOKEY;
+}
+
+static int ufshcd_crypto_keyslot_evict(void *hba_p, unsigned int slot,
+				       const u8 *key,
+				       unsigned int data_unit_size,
+				       unsigned int crypto_alg_id)
+{
+	struct ufs_hba *hba = hba_p;
+	int i = 0;
+	u32 reg_base;
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+
+	if (!ufshcd_is_crypto_enabled(hba) ||
+	    !ufshcd_keyslot_valid(hba, slot)) {
+		return -EINVAL;
+	}
+
+	memset(&cfg_arr[slot], 0, sizeof(cfg_arr[slot]));
+	reg_base = hba->crypto_cfg_register +
+			slot * sizeof(cfg_arr[0]);
+
+	/**
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
+static int ufshcd_crypto_alg_find(void *hba_p,
+			   enum blk_crypt_mode_index crypt_mode,
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
+	switch (crypt_mode) {
+	case BLK_ENCRYPTION_MODE_AES_256_XTS:
+		ufs_alg = UFS_CRYPTO_ALG_AES_XTS;
+		ufs_key_size = UFS_CRYPTO_KEY_SIZE_256;
+		break;
+	/**
+	 * case BLK_CRYPTO_ALG_BITLOCKER_AES_CBC:
+	 *	ufs_alg = UFS_CRYPTO_ALG_BITLOCKER_AES_CBC;
+	 *	break;
+	 * case INLINECRYPT_ALG_AES_ECB:
+	 *	ufs_alg = UFS_CRYPTO_ALG_AES_ECB;
+	 *	break;
+	 * case INLINECRYPT_ALG_ESSIV_AES_CBC:
+	 *	ufs_alg = UFS_CRYPTO_ALG_ESSIV_AES_CBC;
+	 *	break;
+	 */
+	default: return -EINVAL;
+	}
+
+	data_unit_mask = get_data_unit_size_mask(data_unit_size);
+
+	/**
+	 * TODO: We can replace this for loop entirely by constructing
+	 * a table on init that translates blk_crypt_mode_index to
+	 * ufs crypt alg numbers. (By assuming that each alg/keysize combo
+	 * appears only once in the ufs crypto caps array.)
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		if (ccap_array[cap_idx].algorithm_id == ufs_alg &&
+		    (ccap_array[cap_idx].sdus_mask & data_unit_mask) &&
+		    ccap_array[cap_idx].key_size == ufs_key_size) {
+			return cap_idx;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
+	int slot;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return -EINVAL;
+
+	hba->caps |= UFSHCD_CAP_CRYPTO;
+	/**
+	 * Reset might clear all keys, so reprogram all the keys.
+	 * Also serves to clear keys on driver init.
+	 */
+	for (slot = 0; slot <= hba->crypto_capabilities.config_count; slot++)
+		program_key(hba, &cfg_arr[slot], slot);
+
+	return 0;
+}
+
+int ufshcd_crypto_disable(struct ufs_hba *hba)
+{
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return -EINVAL;
+
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	return 0;
+}
+
+
+/**
+ * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
+ * @hba: Per adapter instance
+ *
+ * Returns 0 on success. Returns -ENODEV if such capabilties don't exist, and
+ * -ENOMEM upon OOM.
+ */
+int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	int cap_idx = 0;
+	int err = 0;
+	/* Default to disabling crypto */
+	hba->caps &= ~UFSHCD_CAP_CRYPTO;
+
+	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT)) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	/**
+	 * Crypto Capabilities should never be 0, because the
+	 * config_array_ptr > 04h. So we use a 0 value to indicate that
+	 * crypto init failed, and can't be enabled.
+	 */
+	hba->crypto_capabilities.reg_val = ufshcd_readl(hba, REG_UFS_CCAP);
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
+			     hba->crypto_capabilities.config_count + 1,
+			     sizeof(union ufs_crypto_cfg_entry),
+			     GFP_KERNEL);
+	if (!hba->crypto_cfgs) {
+		err = -ENOMEM;
+		goto out_cfg_mem;
+	}
+
+	/**
+	 * Store all the capabilities now so that we don't need to repeatedly
+	 * access the device each time we want to know its capabilities
+	 */
+	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
+	     cap_idx++) {
+		hba->crypto_cap_array[cap_idx].reg_val =
+			ufshcd_readl(hba,
+				     REG_UFS_CRYPTOCAP +
+				     cap_idx * sizeof(__le32));
+	}
+
+	return 0;
+out_cfg_mem:
+	devm_kfree(hba->dev, hba->crypto_cap_array);
+out:
+	// TODO: print error?
+	/* Indicate that init failed by setting crypto_capabilities to 0 */
+	hba->crypto_capabilities.reg_val = 0;
+	return err;
+}
+
+const struct keyslot_mgmt_ll_ops ufshcd_ksm_ops = {
+	.keyslot_program	= ufshcd_crypto_keyslot_program,
+	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.keyslot_find		= ufshcd_crypto_keyslot_find,
+	.crypto_alg_find	= ufshcd_crypto_alg_find,
+};
+
+int ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					   struct request_queue *q)
+{
+	int err = 0;
+
+	if (!ufshcd_hba_is_crypto_supported(hba))
+		return 0;
+
+	if (!q) {
+		err = -ENODEV;
+		goto out_no_q;
+	}
+
+	q->ksm = keyslot_manager_create(
+	    hba->crypto_capabilities.config_count+1,
+	    &ufshcd_ksm_ops, hba);
+	/*
+	 * If we fail we make it look like
+	 * crypto is not supported, which will avoid issues
+	 * with reset
+	 */
+	if (!q->ksm) {
+		err = -ENOMEM;
+out_no_q:
+		ufshcd_crypto_disable(hba);
+		hba->crypto_capabilities.reg_val = 0;
+		devm_kfree(hba->dev, hba->crypto_cap_array);
+		devm_kfree(hba->dev, hba->crypto_cfgs);
+		return err;
+	}
+
+	return 0;
+}
+
+int ufshcd_crypto_destroy_rq_keyslot_manager(struct request_queue *q)
+{
+	if (q && q->ksm)
+		keyslot_manager_destroy(q->ksm);
+
+	return 0;
+}
+
diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
new file mode 100644
index 000000000000..16445efe3666
--- /dev/null
+++ b/drivers/scsi/ufs/ufshcd-crypto.h
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
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
+bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot);
+
+bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba);
+
+bool ufshcd_is_crypto_enabled(struct ufs_hba *hba);
+
+int ufshcd_crypto_set_enable_slot(struct ufs_hba *hba,
+				  unsigned int slot,
+				  bool enable);
+
+int ufshcd_crypto_enable(struct ufs_hba *hba);
+
+int ufshcd_crypto_disable(struct ufs_hba *hba);
+
+int ufshcd_hba_init_crypto(struct ufs_hba *hba);
+
+int ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
+					   struct request_queue *q);
+
+int ufshcd_crypto_destroy_rq_keyslot_manager(struct request_queue *q);
+
+#else /* CONFIG_UFS_CRYPTO */
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
+static inline int ufshcd_crypto_set_enable_slot(struct ufs_hba *hba,
+				  unsigned int slot,
+				  bool enable)
+{
+	return -1;
+}
+
+static inline int ufshcd_crypto_enable(struct ufs_hba *hba)
+{
+	return -1;
+}
+
+static inline int ufshcd_crypto_disable(struct ufs_hba *hba)
+{
+	return -1;
+}
+
+static inline int ufshcd_hba_init_crypto(struct ufs_hba *hba)
+{
+	return -1;
+}
+
+static inline int ufshcd_crypto_setup_rq_keyslot_manager(
+					struct ufs_hba *hba,
+					struct request_queue *q)
+{
+	return -1;
+}
+
+static inline int ufshcd_crypto_destroy_rq_keyslot_manager(
+				struct request_queue *q)
+{
+	return -1;
+}
+
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* _UFSHCD_CRYPTO_H */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e040f9dd9ff3..65c51943e331 100644
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
@@ -2208,9 +2216,21 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
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
@@ -2218,8 +2238,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
 	 */
 	req_desc->header.dword_2 =
 		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
-	/* dword_3 is reserved, hence it is set to 0 */
-	req_desc->header.dword_3 = 0;
 
 	req_desc->prd_table_length = 0;
 }
@@ -2379,6 +2397,38 @@ static inline u16 ufshcd_upiu_wlun_to_scsi_wlun(u8 upiu_wlun_id)
 	return (upiu_wlun_id & ~UFS_UPIU_WLUN_ID) | SCSI_W_LUN_BASE;
 }
 
+static inline int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
+					     struct scsi_cmnd *cmd,
+					     struct ufshcd_lrb *lrbp)
+{
+	int key_slot;
+
+	if (!bio_crypt_should_process(cmd->request->bio,
+					cmd->request->q)) {
+		lrbp->crypto_enable = false;
+		return 0;
+	}
+
+	if (WARN_ON(!ufshcd_is_crypto_enabled(hba))) {
+		/**
+		 * Upper layer asked us to do inline encryption
+		 * but that isn't enabled, so we fail this request.
+		 */
+		return -EINVAL;
+	}
+	key_slot = bio_crypt_get_slot(cmd->request->bio);
+	if (!ufshcd_keyslot_valid(hba, key_slot))
+		return -EINVAL;
+
+	lrbp->crypto_enable = true;
+	lrbp->crypto_key_slot = key_slot;
+	lrbp->data_unit_num =
+		bio_crypt_data_unit_num(cmd->request->bio);
+
+	return 0;
+}
+
+
 /**
  * ufshcd_queuecommand - main entry point for SCSI requests
  * @host: SCSI host pointer
@@ -2466,6 +2516,13 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
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
@@ -2499,6 +2556,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	lrbp->task_tag = tag;
 	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
 	lrbp->intr_cmd = true; /* No interrupt aggregation */
+	lrbp->crypto_enable = false; /* No crypto operations */
 	hba->dev_cmd.type = cmd_type;
 
 	return ufshcd_comp_devman_upiu(hba, lrbp);
@@ -4191,6 +4249,8 @@ static inline void ufshcd_hba_stop(struct ufs_hba *hba, bool can_sleep)
 {
 	int err;
 
+	ufshcd_crypto_disable(hba);
+
 	ufshcd_writel(hba, CONTROLLER_DISABLE,  REG_CONTROLLER_ENABLE);
 	err = ufshcd_wait_for_register(hba, REG_CONTROLLER_ENABLE,
 					CONTROLLER_ENABLE, CONTROLLER_DISABLE,
@@ -4584,10 +4644,13 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
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
 
@@ -4598,6 +4661,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	struct request_queue *q = sdev->request_queue;
 
 	hba = shost_priv(sdev->host);
 	/* Drop the reference as it won't be needed anymore */
@@ -4608,6 +4672,8 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 	}
+
+	ufshcd_crypto_destroy_rq_keyslot_manager(q);
 }
 
 /**
@@ -4723,6 +4789,8 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	case OCS_MISMATCH_RESP_UPIU_SIZE:
 	case OCS_PEER_COMM_FAILURE:
 	case OCS_FATAL_ERROR:
+	case OCS_INVALID_CRYPTO_CONFIG:
+	case OCS_GENERAL_CRYPTO_ERROR:
 	default:
 		result |= DID_ERROR << 16;
 		dev_err(hba->dev,
@@ -8287,6 +8355,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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
index ecfa898b9ccc..283014e0924f 100644
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
@@ -501,6 +507,10 @@ struct ufs_stats {
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
+ * @crypto_capabilities: Content of crypto capabilities register (0x100)
+ * @crypto_cap_array: Array of crypto capabilities
+ * @crypto_cfg_register: Start of the crypto cfg array
+ * @crypto_cfgs: Array of crypto configurations (i.e. config for each slot)
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -692,6 +702,11 @@ struct ufs_hba {
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
@@ -706,6 +721,14 @@ struct ufs_hba {
 
 	struct device		bsg_dev;
 	struct request_queue	*bsg_queue;
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+	/* crypto */
+	union ufs_crypto_capabilities crypto_capabilities;
+	union ufs_crypto_cap_entry *crypto_cap_array;
+	u32 crypto_cfg_register;
+	union ufs_crypto_cfg_entry *crypto_cfgs;
+#endif /* CONFIG_SCSI_UFS_CRYPTO */
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
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
2.21.0.1020.gf2820cf01a-goog

