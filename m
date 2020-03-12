Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E284B182A30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbgCLIDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:03:10 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41498 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbgCLIDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:09 -0400
Received: by mail-pf1-f201.google.com with SMTP id g13so3233270pfq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FB64hyOJM8w8rCIb1MRYXCpgPTs0C17IuLQtT7vfdFU=;
        b=tkOFBQuHQr4Pyqw0bCuGHihbF+fFIJ74xIqMkN+N1JKByZrukm42Z/L0Yq7Z3EI6us
         QUChM7Mk2uM+PYZaX5vp02PQMGa2G8vVB8C/a54z/FQLf1tIFNq6+A6bQtcUxVsg0mN0
         zC1KdzA+/ESlnc054Bv39wrnJYOSO0EziCByaDD4ls4az6AXGfEVB4j1Yiz7e0b6GA/W
         XGbeOGon9FR3aBDeGX3BmO1HXeYLqfQmSIxZ21Xl2cM1qDkuAO3Fcy7t4ZTf/uZlzq7m
         fYmf0YXZQWxvjYF9fXeStObY29q2g4pfWPHAancN+njL0z86+AmHc/FfgUHctwidsX8u
         eTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FB64hyOJM8w8rCIb1MRYXCpgPTs0C17IuLQtT7vfdFU=;
        b=RC/jWS+WD9cFjNUFzb4z/ExVbgWJEljsho/0/IqT/IVpf8CSq1y+9zx4/DPio52ZJR
         LFUlGtgDHSQ0oJ4Oj5pdqTbhTflVPZOl/SzX5lCl1Q1pdaUz8JhAm/bTX3s9bnb1JeGD
         EbggE68r/x4hKMKck9VSZJ7ZfD0bPTjcK60sVR/POIJf81i2Xf6yN28waopeS3aB5ckL
         VVSN9wXG1omzqsO+BlGQA1DtzYoEmtOBMwxLimViVzj9qbc6KPlA6oC3xBpcdvKCxWDJ
         3MXQ9+0T+mn0BgbF3kNAf6MOJ8APuqoiqzJEA3AORSE+pjSCXbqCYJ6tAAT9fzd0sgHh
         y7pA==
X-Gm-Message-State: ANhLgQ0sB9kNe/d91J5/huf+itkHU3FE+j7bTDSpdm+xi54NCl8SA33P
        B/Q+KwiE69cA/8fgvDOQjNA6z9LZL8A=
X-Google-Smtp-Source: ADFU+vu7AsqpGaCK+D4MKzSu4eKbde7kcMt9Gyj7mnaGKCbsJvTQXh+ugRvXF2sV0Wvvxlk8CbQjuXs4CME=
X-Received: by 2002:a17:90a:2663:: with SMTP id l90mr2650971pje.188.1584000181315;
 Thu, 12 Mar 2020 01:03:01 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:43 -0700
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
Message-Id: <20200312080253.3667-2-satyat@google.com>
Mime-Version: 1.0
References: <20200312080253.3667-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 01/11] block: Keyslot Manager for Inline Encryption
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline Encryption hardware allows software to specify an encryption context
(an encryption key, crypto algorithm, data unit num, data unit size) along
with a data transfer request to a storage device, and the inline encryption
hardware will use that context to en/decrypt the data. The inline
encryption hardware is part of the storage device, and it conceptually sits
on the data path between system memory and the storage device.

Inline Encryption hardware implementations often function around the
concept of "keyslots". These implementations often have a limited number
of "keyslots", each of which can hold a key (we say that a key can be
"programmed" into a keyslot). Requests made to the storage device may have
a keyslot and a data unit number associated with them, and the inline
encryption hardware will en/decrypt the data in the requests using the key
programmed into that associated keyslot and the data unit number specified
with the request.

As keyslots are limited, and programming keys may be expensive in many
implementations, and multiple requests may use exactly the same encryption
contexts, we introduce a Keyslot Manager to efficiently manage keyslots.

We also introduce a blk_crypto_key, which will represent the key that's
programmed into keyslots managed by keyslot managers. The keyslot manager
also functions as the interface that upper layers will use to program keys
into inline encryption hardware. For more information on the Keyslot
Manager, refer to documentation found in block/keyslot-manager.c and
linux/keyslot-manager.h.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/Kconfig                   |   7 +
 block/Makefile                  |   1 +
 block/keyslot-manager.c         | 377 ++++++++++++++++++++++++++++++++
 include/linux/blk-crypto.h      |  45 ++++
 include/linux/blkdev.h          |   6 +
 include/linux/keyslot-manager.h | 108 +++++++++
 6 files changed, 544 insertions(+)
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

diff --git a/block/Kconfig b/block/Kconfig
index 3bc76bb113a0..c04a1d500842 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -185,6 +185,13 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
 
+config BLK_INLINE_ENCRYPTION
+	bool "Enable inline encryption support in block layer"
+	help
+	  Build the blk-crypto subsystem. Enabling this lets the
+	  block layer handle encryption, so users can take
+	  advantage of inline encryption hardware if present.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 1a43750f4b01..ef3a05dcf1f2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
new file mode 100644
index 000000000000..38df0652df80
--- /dev/null
+++ b/block/keyslot-manager.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/**
+ * DOC: The Keyslot Manager
+ *
+ * Many devices with inline encryption support have a limited number of "slots"
+ * into which encryption contexts may be programmed, and requests can be tagged
+ * with a slot number to specify the key to use for en/decryption.
+ *
+ * As the number of slots are limited, and programming keys is expensive on
+ * many inline encryption hardware, we don't want to program the same key into
+ * multiple slots - if multiple requests are using the same key, we want to
+ * program just one slot with that key and use that slot for all requests.
+ *
+ * The keyslot manager manages these keyslots appropriately, and also acts as
+ * an abstraction between the inline encryption hardware and the upper layers.
+ *
+ * Lower layer devices will set up a keyslot manager in their request queue
+ * and tell it how to perform device specific operations like programming/
+ * evicting keys from keyslots.
+ *
+ * Upper layers will call blk_ksm_get_slot_for_key() to program a
+ * key into some slot in the inline encryption hardware.
+ */
+#include <crypto/algapi.h>
+#include <linux/keyslot-manager.h>
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/wait.h>
+#include <linux/blkdev.h>
+
+struct blk_ksm_keyslot {
+	atomic_t slot_refs;
+	struct list_head idle_slot_node;
+	struct hlist_node hash_node;
+	struct blk_crypto_key key;
+	struct keyslot_manager *ksm;
+};
+
+static inline void blk_ksm_hw_enter(struct keyslot_manager *ksm)
+{
+	/*
+	 * Calling into the driver requires ksm->lock held and the device
+	 * resumed.  But we must resume the device first, since that can acquire
+	 * and release ksm->lock via blk_ksm_reprogram_all_keys().
+	 */
+	if (ksm->dev)
+		pm_runtime_get_sync(ksm->dev);
+	down_write(&ksm->lock);
+}
+
+static inline void blk_ksm_hw_exit(struct keyslot_manager *ksm)
+{
+	up_write(&ksm->lock);
+	if (ksm->dev)
+		pm_runtime_put_sync(ksm->dev);
+}
+
+/**
+ * blk_ksm_init() - Initialize a keyslot manager
+ * @ksm: The keyslot_manager to initialize.
+ * @dev: Device for runtime power management (NULL if none)
+ * @num_slots: The number of key slots to manage.
+ *
+ * Allocate memory for keyslots and initialize a keyslot manager. Called by
+ * e.g. storage drivers to set up a keyslot manager in their request_queue.
+ *
+ * Return: 0 on success, or else a negative error code.
+ */
+int blk_ksm_init(struct keyslot_manager *ksm, struct device *dev,
+		 unsigned int num_slots)
+{
+	unsigned int slot;
+	unsigned int i;
+
+	memset(ksm, 0, sizeof(*ksm));
+
+	if (num_slots == 0)
+		return -EINVAL;
+
+	ksm->slots = kvcalloc(num_slots, sizeof(ksm->slots[0]), GFP_KERNEL);
+	if (!ksm->slots)
+		return -ENOMEM;
+
+	ksm->num_slots = num_slots;
+	ksm->dev = dev;
+
+	init_rwsem(&ksm->lock);
+
+	init_waitqueue_head(&ksm->idle_slots_wait_queue);
+	INIT_LIST_HEAD(&ksm->idle_slots);
+
+	for (slot = 0; slot < num_slots; slot++) {
+		ksm->slots[slot].ksm = ksm;
+		list_add_tail(&ksm->slots[slot].idle_slot_node,
+			      &ksm->idle_slots);
+	}
+
+	spin_lock_init(&ksm->idle_slots_lock);
+
+	ksm->slot_hashtable_size = roundup_pow_of_two(num_slots);
+	ksm->slot_hashtable = kvmalloc_array(ksm->slot_hashtable_size,
+					     sizeof(ksm->slot_hashtable[0]),
+					     GFP_KERNEL);
+	if (!ksm->slot_hashtable)
+		goto err_destroy_ksm;
+	for (i = 0; i < ksm->slot_hashtable_size; i++)
+		INIT_HLIST_HEAD(&ksm->slot_hashtable[i]);
+
+	return 0;
+
+err_destroy_ksm:
+	blk_ksm_destroy(ksm);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_init);
+
+static inline struct hlist_head *
+blk_ksm_hash_bucket_for_key(struct keyslot_manager *ksm,
+			    const struct blk_crypto_key *key)
+{
+	return &ksm->slot_hashtable[key->hash & (ksm->slot_hashtable_size - 1)];
+}
+
+static void blk_ksm_remove_slot_from_lru_list(struct blk_ksm_keyslot *slot)
+{
+	struct keyslot_manager *ksm = slot->ksm;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
+	list_del(&slot->idle_slot_node);
+	spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+}
+
+static struct blk_ksm_keyslot *blk_ksm_find_keyslot(struct keyslot_manager *ksm,
+					const struct blk_crypto_key *key)
+{
+	const struct hlist_head *head = blk_ksm_hash_bucket_for_key(ksm, key);
+	struct blk_ksm_keyslot *slotp;
+
+	hlist_for_each_entry(slotp, head, hash_node) {
+		if (slotp->key.hash == key->hash &&
+		    slotp->key.crypto_mode == key->crypto_mode &&
+		    slotp->key.data_unit_size == key->data_unit_size &&
+		    !crypto_memneq(slotp->key.raw, key->raw, key->size))
+			return slotp;
+	}
+	return NULL;
+}
+
+static struct blk_ksm_keyslot *blk_ksm_find_and_grab_keyslot(
+					struct keyslot_manager *ksm,
+					const struct blk_crypto_key *key)
+{
+	struct blk_ksm_keyslot *slot;
+
+	slot = blk_ksm_find_keyslot(ksm, key);
+	if (!slot)
+		return NULL;
+	if (atomic_inc_return(&slot->slot_refs) == 1) {
+		/* Took first reference to this slot; remove it from LRU list */
+		blk_ksm_remove_slot_from_lru_list(slot);
+	}
+	return slot;
+}
+
+unsigned int blk_ksm_get_slot_idx(struct blk_ksm_keyslot *slot)
+{
+	return slot - slot->ksm->slots;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_get_slot_idx);
+
+/**
+ * blk_ksm_get_slot_for_key() - Program a key into a keyslot.
+ * @ksm: The keyslot manager to program the key into.
+ * @key: Pointer to the key object to program, including the raw key, crypto
+ *	 mode, and data unit size.
+ * @keyslot: A pointer to return the pointer of the allocated keyslot.
+ *
+ * Get a keyslot that's been programmed with the specified key.  If one already
+ * exists, return it with incremented refcount.  Otherwise, wait for a keyslot
+ * to become idle and program it.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ * Return: BLK_STATUS_OK on success (and keyslot is set to the pointer of the
+ *	   allocated keyslot), and BLK_STATUS_IOERR otherwise (and keyslot is
+ *	   set to NULL).
+ */
+blk_status_t blk_ksm_get_slot_for_key(struct keyslot_manager *ksm,
+				      const struct blk_crypto_key *key,
+				      struct blk_ksm_keyslot **slot_ptr)
+{
+	struct blk_ksm_keyslot *slot;
+	int slot_idx;
+	blk_status_t err;
+
+	*slot_ptr = NULL;
+	down_read(&ksm->lock);
+	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
+	up_read(&ksm->lock);
+	if (slot)
+		goto success;
+
+	for (;;) {
+		blk_ksm_hw_enter(ksm);
+		slot = blk_ksm_find_and_grab_keyslot(ksm, key);
+		if (slot) {
+			blk_ksm_hw_exit(ksm);
+			goto success;
+		}
+
+		/*
+		 * If we're here, that means there wasn't a slot that was
+		 * already programmed with the key. So try to program it.
+		 */
+		if (!list_empty(&ksm->idle_slots))
+			break;
+
+		blk_ksm_hw_exit(ksm);
+		wait_event(ksm->idle_slots_wait_queue,
+			   !list_empty(&ksm->idle_slots));
+	}
+
+	slot = list_first_entry(&ksm->idle_slots, struct blk_ksm_keyslot,
+				idle_slot_node);
+	slot_idx = blk_ksm_get_slot_idx(slot);
+
+	err = ksm->ksm_ll_ops.keyslot_program(ksm, key, slot_idx);
+	if (err != BLK_STS_OK) {
+		wake_up(&ksm->idle_slots_wait_queue);
+		blk_ksm_hw_exit(ksm);
+		return err;
+	}
+
+	/* Move this slot to the hash list for the new key. */
+	if (slot->key.crypto_mode != BLK_ENCRYPTION_MODE_INVALID)
+		hlist_del(&slot->hash_node);
+	hlist_add_head(&slot->hash_node, blk_ksm_hash_bucket_for_key(ksm, key));
+
+	atomic_set(&slot->slot_refs, 1);
+	slot->key = *key;
+
+	blk_ksm_remove_slot_from_lru_list(slot);
+
+	blk_ksm_hw_exit(ksm);
+success:
+	*slot_ptr = slot;
+	return BLK_STS_OK;
+}
+
+/**
+ * blk_ksm_put_slot() - Release a reference to a slot
+ * @slot: The keyslot to release the reference of.
+ *
+ * Context: Any context.
+ */
+void blk_ksm_put_slot(struct blk_ksm_keyslot *slot)
+{
+	struct keyslot_manager *ksm = slot->ksm;
+	unsigned long flags;
+
+	if (!slot)
+		return;
+
+	if (atomic_dec_and_lock_irqsave(&slot->slot_refs,
+					&ksm->idle_slots_lock, flags)) {
+		list_add_tail(&slot->idle_slot_node,
+			      &ksm->idle_slots);
+		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+		wake_up(&ksm->idle_slots_wait_queue);
+	}
+}
+
+/**
+ * blk_ksm_crypto_key_supported() - Find out if the crypto_mode, dusize, dun
+ *				    bytes of a crypto_key are supported by a
+ *				    ksm.
+ * @ksm: The keyslot manager to check
+ * @key: The key whose crypto_mode, dusize and dun bytes to check for.
+ *
+ * Checks for crypto_mode/data unit size/dun bytes support.
+ *
+ * Return: Whether or not this ksm supports the specified crypto key.
+ */
+bool blk_ksm_crypto_key_supported(struct keyslot_manager *ksm,
+				  const struct blk_crypto_key *key)
+{
+	if (!ksm)
+		return false;
+	return (ksm->crypto_modes_supported[key->crypto_mode] &
+		key->data_unit_size) &&
+	       (ksm->max_dun_bytes_supported >= key->dun_bytes);
+}
+
+/**
+ * blk_ksm_evict_key() - Evict a key from the lower layer device.
+ * @ksm: The keyslot manager to evict from
+ * @key: The key to evict
+ *
+ * Find the keyslot that the specified key was programmed into, and evict that
+ * slot from the lower layer device if that slot is not currently in use.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
+ *	   if the key is still in use, or another -errno value on other error.
+ */
+int blk_ksm_evict_key(struct keyslot_manager *ksm,
+		      const struct blk_crypto_key *key)
+{
+	struct blk_ksm_keyslot *slot;
+	int err = 0;
+
+	blk_ksm_hw_enter(ksm);
+	slot = blk_ksm_find_keyslot(ksm, key);
+	if (!slot)
+		goto out_unlock;
+
+	if (atomic_read(&slot->slot_refs) != 0) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	err = ksm->ksm_ll_ops.keyslot_evict(ksm, key,
+					    blk_ksm_get_slot_idx(slot));
+	if (err)
+		goto out_unlock;
+
+	hlist_del(&slot->hash_node);
+	memzero_explicit(&slot->key, sizeof(slot->key));
+	err = 0;
+out_unlock:
+	blk_ksm_hw_exit(ksm);
+	return err;
+}
+
+/**
+ * blk_ksm_reprogram_all_keys() - Re-program all keyslots.
+ * @ksm: The keyslot manager
+ *
+ * Re-program all keyslots that are supposed to have a key programmed.  This is
+ * intended only for use by drivers for hardware that loses its keys on reset.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ */
+void blk_ksm_reprogram_all_keys(struct keyslot_manager *ksm)
+{
+	unsigned int slot;
+
+	/* This is for device initialization, so don't resume the device */
+	down_write(&ksm->lock);
+	for (slot = 0; slot < ksm->num_slots; slot++) {
+		const struct blk_ksm_keyslot *slotp = &ksm->slots[slot];
+		int err;
+
+		if (slotp->key.crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
+			continue;
+
+		err = ksm->ksm_ll_ops.keyslot_program(ksm, &slotp->key, slot);
+		WARN_ON(err);
+	}
+	up_write(&ksm->lock);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_reprogram_all_keys);
+
+void blk_ksm_destroy(struct keyslot_manager *ksm)
+{
+	if (!ksm)
+		return;
+	kvfree(ksm->slot_hashtable);
+	memzero_explicit(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
+	kvfree(ksm->slots);
+	memzero_explicit(ksm, sizeof(*ksm));
+}
+EXPORT_SYMBOL_GPL(blk_ksm_destroy);
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
new file mode 100644
index 000000000000..b8d54eca1c0d
--- /dev/null
+++ b/include/linux/blk-crypto.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_BLK_CRYPTO_H
+#define __LINUX_BLK_CRYPTO_H
+
+enum blk_crypto_mode_num {
+	BLK_ENCRYPTION_MODE_INVALID,
+	BLK_ENCRYPTION_MODE_AES_256_XTS,
+	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
+	BLK_ENCRYPTION_MODE_ADIANTUM,
+	BLK_ENCRYPTION_MODE_MAX,
+};
+
+#define BLK_CRYPTO_MAX_KEY_SIZE		64
+
+/**
+ * struct blk_crypto_key - an inline encryption key
+ * @crypto_mode: encryption algorithm this key is for
+ * @data_unit_size: the data unit size for all encryption/decryptions with this
+ *	key.  This is the size in bytes of each individual plaintext and
+ *	ciphertext.  This is always a power of 2.  It might be e.g. the
+ *	filesystem block size or the disk sector size.
+ * @data_unit_size_bits: log2 of data_unit_size
+ * @dun_bytes: the number of bytes of DUN used when using this key
+ * @size: size of this key in bytes (determined by @crypto_mode)
+ * @hash: hash of this key, for keyslot manager use only
+ * @raw: the raw bytes of this key.  Only the first @size bytes are used.
+ *
+ * A blk_crypto_key is immutable once created, and many bios can reference it at
+ * the same time.  It must not be freed until all bios using it have completed.
+ */
+struct blk_crypto_key {
+	enum blk_crypto_mode_num crypto_mode;
+	unsigned int data_unit_size;
+	unsigned int data_unit_size_bits;
+	unsigned int dun_bytes;
+	unsigned int size;
+	unsigned int hash;
+	u8 raw[BLK_CRYPTO_MAX_KEY_SIZE];
+};
+
+#endif /* __LINUX_BLK_CRYPTO_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 10455b2bbbb4..c447361952d1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct keyslot_manager;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -474,6 +475,11 @@ struct request_queue {
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	/* Inline crypto capabilities */
+	struct keyslot_manager *ksm;
+#endif
+
 	unsigned int		rq_timeout;
 	int			poll_nsec;
 
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
new file mode 100644
index 000000000000..7f88ed02faee
--- /dev/null
+++ b/include/linux/keyslot-manager.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_KEYSLOT_MANAGER_H
+#define __LINUX_KEYSLOT_MANAGER_H
+
+#include <linux/bio.h>
+#include <linux/blk-crypto.h>
+
+struct keyslot_manager;
+
+/**
+ * struct keyslot_mgmt_ll_ops - functions to manage keyslots in hardware
+ * @keyslot_program:	Program the specified key into the specified slot in the
+ *			inline encryption hardware.
+ * @keyslot_evict:	Evict key from the specified keyslot in the hardware.
+ *			The key is provided so that e.g. dm layers can evict
+ *			keys from the devices that they map over.
+ *			Returns 0 on success, -errno otherwise.
+ *
+ * This structure should be provided by storage device drivers when they set up
+ * a keyslot manager - this structure holds the function ptrs that the keyslot
+ * manager will use to manipulate keyslots in the hardware.
+ */
+struct keyslot_mgmt_ll_ops {
+	blk_status_t (*keyslot_program)(struct keyslot_manager *ksm,
+					const struct blk_crypto_key *key,
+					unsigned int slot);
+	int (*keyslot_evict)(struct keyslot_manager *ksm,
+			     const struct blk_crypto_key *key,
+			     unsigned int slot);
+};
+
+struct keyslot_manager {
+	/*
+	 * The struct keyslot_mgmt_ll_ops that this keyslot manager will use
+	 * to perform operations like programming and evicting keys on the
+	 * device
+	 */
+	struct keyslot_mgmt_ll_ops ksm_ll_ops;
+
+	/*
+	 * The maximum number of bytes supported for specifying the data unit
+	 * number.
+	 */
+	unsigned int max_dun_bytes_supported;
+
+	/*
+	 * Array of size BLK_ENCRYPTION_MODE_MAX of bitmasks that represents
+	 * whether a crypto mode and data unit size are supported. The i'th
+	 * bit of crypto_mode_supported[crypto_mode] is set iff a data unit
+	 * size of (1 << i) is supported. We only support data unit sizes
+	 * that are powers of 2.
+	 */
+	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX];
+
+	/* Device for runtime power management (NULL if none) */
+	struct device *dev;
+
+	/* Here onwards are *private* fields for internal keyslot manager use */
+
+	unsigned int num_slots;
+
+	/* Protects programming and evicting keys from the device */
+	struct rw_semaphore lock;
+
+	/* List of idle slots, with least recently used slot at front */
+	wait_queue_head_t idle_slots_wait_queue;
+	struct list_head idle_slots;
+	spinlock_t idle_slots_lock;
+
+	/*
+	 * Hash table which maps key hashes to keyslots, so that we can find a
+	 * key's keyslot in O(1) time rather than O(num_slots).  Protected by
+	 * 'lock'.  A cryptographic hash function is used so that timing attacks
+	 * can't leak information about the raw keys.
+	 */
+	struct hlist_head *slot_hashtable;
+	unsigned int slot_hashtable_size;
+
+	/* Per-keyslot data */
+	struct blk_ksm_keyslot *slots;
+};
+
+int blk_ksm_init(struct keyslot_manager *ksm, struct device *dev,
+		 unsigned int num_slots);
+
+blk_status_t blk_ksm_get_slot_for_key(struct keyslot_manager *ksm,
+				      const struct blk_crypto_key *key,
+				      struct blk_ksm_keyslot **slot_ptr);
+
+unsigned int blk_ksm_get_slot_idx(struct blk_ksm_keyslot *slot);
+
+void blk_ksm_put_slot(struct blk_ksm_keyslot *slot);
+
+bool blk_ksm_crypto_key_supported(struct keyslot_manager *ksm,
+				  const struct blk_crypto_key *key);
+
+int blk_ksm_evict_key(struct keyslot_manager *ksm,
+		      const struct blk_crypto_key *key);
+
+void blk_ksm_reprogram_all_keys(struct keyslot_manager *ksm);
+
+void blk_ksm_destroy(struct keyslot_manager *ksm);
+
+#endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.25.1.481.gfbce0eb801-goog

