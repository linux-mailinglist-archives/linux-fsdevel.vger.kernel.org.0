Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7CE6CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfJ1HUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:20:42 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37582 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfJ1HUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:41 -0400
Received: by mail-pg1-f201.google.com with SMTP id u20so7653488pga.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O3WIeuWKghxgdKG/ft90uB2M7SIrx3CskO7YtCoXnUg=;
        b=NRiV89+ZKhOBUqsstfX6ZFIY4Afesw6xPz8RZQC3OUPjjDuv6YQHxCIzrU2nQr3d2b
         H5Zot7x4avD6X4qbjE6UK7xTQ7PzE/d7obTeORbElm/lGnXRP0uhW4VlyjqUfVh5zhRw
         2wSm7MItJnkYs6+MVOwxzH3r9bZUgdVMKXrC/WU/FTTiWuaTOhKSxx1Vm3vFQHbyup55
         IS+5/HIDrZSoKFX8jqxSCVcEATfFy+IbLrrpm2791CWDTs9uT3tO9YdqUJAxC5EELcf6
         xl4oE9ki80YSYkIBnDTz1ljfJjvK9rm4hO6CotyuySRhuO0gkUEpYq2VgfGw4Dqy6yvU
         6xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O3WIeuWKghxgdKG/ft90uB2M7SIrx3CskO7YtCoXnUg=;
        b=D+bLXC4vlEINkq+uhvBriuhpToKoaqIoKBSRu9/zseuTcUmw4eupmAnRVf8aKZdnAc
         zVfObuT5vbJmoc2n3bkqOz6pa5H5Wtp6zYXOk2e9xakOxFKaVCKlsygojcJvrz+f4u8L
         ItyCo7c2iDgswIKgD1N4zxpqGFVfv13Q4HFTTJ2FfxQaXdf9YPt/JA7iEikABO75aJ6/
         YOtza3wIRAk67ofqZ0TBke5omcLLnim3zDt4sbnX9gj7WI6wvFNBEIj2CyE2YuBex+Cu
         8geo8b6nkOBSOqTL9aqc5Wm+R8CnWtAzlan0T5XqMqc6b3p1yGuIrcjZq2eyxKbe4sGa
         6P7w==
X-Gm-Message-State: APjAAAUn2iBtVGYQTfRP3FdQ0PrAuCcaHvq6LobR0Ke2a2xbbyDqLH/3
        FzWHeH0cyVboDhK98YWa3cPA8mOKRUY=
X-Google-Smtp-Source: APXvYqz4BYdHS3GKFZYRSkGruyU6p50twEx0EsGH21poEw4Q/e/au51/3CoMWg50X5tpp/s6xxwUqaxK+rw=
X-Received: by 2002:a63:2c9:: with SMTP id 192mr19720017pgc.315.1572247240225;
 Mon, 28 Oct 2019 00:20:40 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:20:24 -0700
In-Reply-To: <20191028072032.6911-1-satyat@google.com>
Message-Id: <20191028072032.6911-2-satyat@google.com>
Mime-Version: 1.0
References: <20191028072032.6911-1-satyat@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v5 1/9] block: Keyslot Manager for Inline Encryption
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

Inline Encryption hardware allows software to specify an encryption context
(an encryption key, crypto algorithm, data unit num, data unit size, etc.)
along with a data transfer request to a storage device, and the inline
encryption hardware will use that context to en/decrypt the data. The
inline encryption hardware is part of the storage device, and it
conceptually sits on the data path between system memory and the storage
device.

Inline Encryption hardware implementations often function around the
concept of "keyslots". These implementations often have a limited number
of "keyslots", each of which can hold an encryption context (we say that
an encryption context can be "programmed" into a keyslot). Requests made
to the storage device may have a keyslot associated with them, and the
inline encryption hardware will en/decrypt the data in the requests using
the encryption context programmed into that associated keyslot. As
keyslots are limited, and programming keys may be expensive in many
implementations, and multiple requests may use exactly the same encryption
contexts, we introduce a Keyslot Manager to efficiently manage keyslots.
The keyslot manager also functions as the interface that upper layers will
use to program keys into inline encryption hardware. For more information
on the Keyslot Manager, refer to documentation found in
block/keyslot-manager.c and linux/keyslot-manager.h.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/Kconfig                   |   8 +
 block/Makefile                  |   1 +
 block/keyslot-manager.c         | 352 ++++++++++++++++++++++++++++++++
 include/linux/bio.h             |   5 +
 include/linux/blkdev.h          |   6 +
 include/linux/keyslot-manager.h |  98 +++++++++
 6 files changed, 470 insertions(+)
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/keyslot-manager.h

diff --git a/block/Kconfig b/block/Kconfig
index 41c0917ce622..ae52d42b783b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -177,6 +177,14 @@ config BLK_SED_OPAL
 	Enabling this option enables users to setup/unlock/lock
 	Locking ranges for SED devices using the Opal protocol.
 
+config BLK_INLINE_ENCRYPTION
+	bool "Enable inline encryption support in block layer"
+	help
+	  Build the blk-crypto subsystem.
+	  Enabling this lets the block layer handle encryption,
+	  so users can take advantage of inline encryption
+	  hardware if present.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 9ef57ace90d4..e922844219c2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
new file mode 100644
index 000000000000..020931fc9f7d
--- /dev/null
+++ b/block/keyslot-manager.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * keyslot-manager.c
+ *
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
+ * Upper layers will call keyslot_manager_get_slot_for_key() to program a
+ * key into some slot in the inline encryption hardware.
+ */
+#include <linux/keyslot-manager.h>
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/blkdev.h>
+
+struct keyslot {
+	atomic_t slot_refs;
+	struct list_head idle_slot_node;
+};
+
+struct keyslot_manager {
+	unsigned int num_slots;
+	atomic_t num_idle_slots;
+	struct keyslot_mgmt_ll_ops ksm_ll_ops;
+	void *ll_priv_data;
+
+	/* Protects programming and evicting keys from the device */
+	struct rw_semaphore lock;
+
+	/* List of idle slots, with least recently used slot at front */
+	wait_queue_head_t idle_slots_wait_queue;
+	struct list_head idle_slots;
+	spinlock_t idle_slots_lock;
+
+	/* Per-keyslot data */
+	struct keyslot slots[];
+};
+
+/**
+ * keyslot_manager_create() - Create a keyslot manager
+ * @num_slots: The number of key slots to manage.
+ * @ksm_ll_ops: The struct keyslot_mgmt_ll_ops for the device that this keyslot
+ *		manager will use to perform operations like programming and
+ *		evicting keys.
+ * @ll_priv_data: Private data passed as is to the functions in ksm_ll_ops.
+ *
+ * Allocate memory for and initialize a keyslot manager. Called by e.g.
+ * storage drivers to set up a keyslot manager in their request_queue.
+ *
+ * Context: May sleep
+ * Return: Pointer to constructed keyslot manager or NULL on error.
+ */
+struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
+				const struct keyslot_mgmt_ll_ops *ksm_ll_ops,
+				void *ll_priv_data)
+{
+	struct keyslot_manager *ksm;
+	int slot;
+
+	if (num_slots == 0)
+		return NULL;
+
+	/* Check that all ops are specified */
+	if (ksm_ll_ops->keyslot_program == NULL ||
+	    ksm_ll_ops->keyslot_evict == NULL ||
+	    ksm_ll_ops->crypto_mode_supported == NULL ||
+	    ksm_ll_ops->keyslot_find == NULL)
+		return NULL;
+
+	ksm = kvzalloc(struct_size(ksm, slots, num_slots), GFP_KERNEL);
+	if (!ksm)
+		return NULL;
+
+	ksm->num_slots = num_slots;
+	atomic_set(&ksm->num_idle_slots, num_slots);
+	ksm->ksm_ll_ops = *ksm_ll_ops;
+	ksm->ll_priv_data = ll_priv_data;
+
+	init_rwsem(&ksm->lock);
+
+	init_waitqueue_head(&ksm->idle_slots_wait_queue);
+	INIT_LIST_HEAD(&ksm->idle_slots);
+
+	for (slot = 0; slot < num_slots; slot++) {
+		list_add_tail(&ksm->slots[slot].idle_slot_node,
+			      &ksm->idle_slots);
+	}
+
+	spin_lock_init(&ksm->idle_slots_lock);
+
+	return ksm;
+}
+EXPORT_SYMBOL(keyslot_manager_create);
+
+static void remove_slot_from_lru_list(struct keyslot_manager *ksm, int slot)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
+	list_del(&ksm->slots[slot].idle_slot_node);
+	spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+
+	atomic_dec(&ksm->num_idle_slots);
+}
+
+static int find_and_grab_keyslot(struct keyslot_manager *ksm, const u8 *key,
+				 enum blk_crypto_mode_num crypto_mode,
+				 unsigned int data_unit_size)
+{
+	int slot;
+
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypto_mode, data_unit_size);
+	if (slot < 0)
+		return slot;
+	if (WARN_ON(slot >= ksm->num_slots))
+		return -EINVAL;
+	if (atomic_inc_return(&ksm->slots[slot].slot_refs) == 1) {
+		/* Took first reference to this slot; remove it from LRU list */
+		remove_slot_from_lru_list(ksm, slot);
+	}
+	return slot;
+}
+
+/**
+ * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
+ * @ksm: The keyslot manager to program the key into.
+ * @key: Pointer to the bytes of the key to program. Must be the correct length
+ *      for the chosen @crypto_mode; see blk_crypto_modes in blk-crypto.c.
+ * @crypto_mode: Identifier for the encryption algorithm to use.
+ * @data_unit_size: The data unit size to use for en/decryption.
+ *
+ * Get a keyslot that's been programmed with the specified key, crypto_mode, and
+ * data_unit_size.  If one already exists, return it with incremented refcount.
+ * Otherwise, wait for a keyslot to become idle and program it.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ * Return: The keyslot on success, else a -errno value.
+ */
+int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypto_mode_num crypto_mode,
+				     unsigned int data_unit_size)
+{
+	int slot;
+	int err;
+	struct keyslot *idle_slot;
+
+	down_read(&ksm->lock);
+	slot = find_and_grab_keyslot(ksm, key, crypto_mode, data_unit_size);
+	up_read(&ksm->lock);
+	if (slot != -ENOKEY)
+		return slot;
+
+	for (;;) {
+		down_write(&ksm->lock);
+		slot = find_and_grab_keyslot(ksm, key, crypto_mode,
+					     data_unit_size);
+		if (slot != -ENOKEY) {
+			up_write(&ksm->lock);
+			return slot;
+		}
+
+		/*
+		 * If we're here, that means there wasn't a slot that was
+		 * already programmed with the key. So try to program it.
+		 */
+		if (atomic_read(&ksm->num_idle_slots) > 0)
+			break;
+
+		up_write(&ksm->lock);
+		wait_event(ksm->idle_slots_wait_queue,
+			(atomic_read(&ksm->num_idle_slots) > 0));
+	}
+
+	idle_slot = list_first_entry(&ksm->idle_slots, struct keyslot,
+					     idle_slot_node);
+	slot = idle_slot - ksm->slots;
+
+	err = ksm->ksm_ll_ops.keyslot_program(ksm->ll_priv_data, key,
+					      crypto_mode,
+					      data_unit_size,
+					      slot);
+
+	if (err) {
+		wake_up(&ksm->idle_slots_wait_queue);
+		up_write(&ksm->lock);
+		return err;
+	}
+
+	atomic_set(&ksm->slots[slot].slot_refs, 1);
+	remove_slot_from_lru_list(ksm, slot);
+
+	up_write(&ksm->lock);
+	return slot;
+
+}
+EXPORT_SYMBOL(keyslot_manager_get_slot_for_key);
+
+/**
+ * keyslot_manager_get_slot() - Increment the refcount on the specified slot.
+ * @ksm - The keyslot manager that we want to modify.
+ * @slot - The slot to increment the refcount of.
+ *
+ * This function assumes that there is already an active reference to that slot
+ * and simply increments the refcount. This is useful when cloning a bio that
+ * already has a reference to a keyslot, and we want the cloned bio to also have
+ * its own reference.
+ *
+ * Context: Any context.
+ */
+void keyslot_manager_get_slot(struct keyslot_manager *ksm, unsigned int slot)
+{
+	if (WARN_ON(slot >= ksm->num_slots))
+		return;
+
+	WARN_ON(atomic_inc_return(&ksm->slots[slot].slot_refs) < 2);
+}
+EXPORT_SYMBOL(keyslot_manager_get_slot);
+
+/**
+ * keyslot_manager_put_slot() - Release a reference to a slot
+ * @ksm: The keyslot manager to release the reference from.
+ * @slot: The slot to release the reference from.
+ *
+ * Context: Any context.
+ */
+void keyslot_manager_put_slot(struct keyslot_manager *ksm, unsigned int slot)
+{
+	unsigned long flags;
+
+	if (WARN_ON(slot >= ksm->num_slots))
+		return;
+
+	if (atomic_dec_and_lock_irqsave(&ksm->slots[slot].slot_refs,
+					&ksm->idle_slots_lock, flags)) {
+		list_add_tail(&ksm->slots[slot].idle_slot_node,
+			      &ksm->idle_slots);
+		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->idle_slots_wait_queue);
+	}
+}
+EXPORT_SYMBOL(keyslot_manager_put_slot);
+
+/**
+ * keyslot_manager_crypto_mode_supported() - Find out if a crypto_mode/data
+ *					     unit size combination is supported
+ *					     by a ksm.
+ * @ksm - The keyslot manager to check
+ * @crypto_mode - The crypto mode to check for.
+ * @data_unit_size - The data_unit_size for the mode.
+ *
+ * Calls and returns the result of the crypto_mode_supported function specified
+ * by the ksm.
+ *
+ * Context: Process context.
+ * Return: Whether or not this ksm supports the specified crypto_mode/
+ *	   data_unit_size combo.
+ */
+bool keyslot_manager_crypto_mode_supported(struct keyslot_manager *ksm,
+					   enum blk_crypto_mode_num crypto_mode,
+					   unsigned int data_unit_size)
+{
+	if (!ksm)
+		return false;
+	return ksm->ksm_ll_ops.crypto_mode_supported(ksm->ll_priv_data,
+						     crypto_mode,
+						     data_unit_size);
+}
+EXPORT_SYMBOL(keyslot_manager_crypto_mode_supported);
+
+bool keyslot_manager_rq_crypto_mode_supported(struct request_queue *q,
+					enum blk_crypto_mode_num crypto_mode,
+					unsigned int data_unit_size)
+{
+	return keyslot_manager_crypto_mode_supported(q->ksm, crypto_mode,
+						     data_unit_size);
+}
+EXPORT_SYMBOL(keyslot_manager_rq_crypto_mode_supported);
+
+/**
+ * keyslot_manager_evict_key() - Evict a key from the lower layer device.
+ * @ksm - The keyslot manager to evict from
+ * @key - The key to evict
+ * @crypto_mode - The crypto algorithm the key was programmed with.
+ * @data_unit_size - The data_unit_size the key was programmed with.
+ *
+ * Finds the slot that the specified key, crypto_mode, data_unit_size combo
+ * was programmed into, and evicts that slot from the lower layer device if
+ * the refcount on the slot is 0. Returns -EBUSY if the refcount is not 0, and
+ * -errno on error.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ */
+int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+			      const u8 *key,
+			      enum blk_crypto_mode_num crypto_mode,
+			      unsigned int data_unit_size)
+{
+	int slot;
+	int err = 0;
+
+	down_write(&ksm->lock);
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypto_mode,
+					    data_unit_size);
+
+	if (slot < 0) {
+		up_write(&ksm->lock);
+		return slot;
+	}
+
+	if (atomic_read(&ksm->slots[slot].slot_refs) == 0) {
+		err = ksm->ksm_ll_ops.keyslot_evict(ksm->ll_priv_data, key,
+						    crypto_mode,
+						    data_unit_size,
+						    slot);
+	} else {
+		err = -EBUSY;
+	}
+
+	up_write(&ksm->lock);
+	return err;
+}
+EXPORT_SYMBOL(keyslot_manager_evict_key);
+
+void keyslot_manager_destroy(struct keyslot_manager *ksm)
+{
+	kvfree(ksm);
+}
+EXPORT_SYMBOL(keyslot_manager_destroy);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3cdb84cdc488..d0cb7c350cdc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -564,6 +564,11 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 }
 #endif
 
+enum blk_crypto_mode_num {
+	BLK_ENCRYPTION_MODE_INVALID	= 0,
+	BLK_ENCRYPTION_MODE_AES_256_XTS	= 1,
+};
+
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3ea78b0c91c..244e81a8f5d2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct keyslot_manager;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -481,6 +482,11 @@ struct request_queue {
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
index 000000000000..0777ade7907c
--- /dev/null
+++ b/include/linux/keyslot-manager.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/bio.h>
+
+#ifdef CONFIG_BLOCK
+
+#ifndef __LINUX_KEYSLOT_MANAGER_H
+#define __LINUX_KEYSLOT_MANAGER_H
+
+/**
+ * struct keyslot_mgmt_ll_ops - functions to manage keyslots in hardware
+ * @keyslot_program:	Program the specified key and algorithm into the
+ *			specified slot in the inline encryption hardware.
+ * @keyslot_evict:	Evict key from the specified keyslot in the hardware.
+ *			The key, crypto_mode and data_unit_size are also passed
+ *			down so that e.g. dm layers can evict keys from
+ *			the devices that they map over.
+ *			Returns 0 on success, -errno otherwise.
+ * @crypto_mode_supported:	Check whether a crypto_mode and data_unit_size
+ *				combo is supported.
+ * @keyslot_find:	Returns the slot number that matches the key,
+ *			or -ENOKEY if no match found, or -errno on
+ *			error.
+ *
+ * This structure should be provided by storage device drivers when they set up
+ * a keyslot manager - this structure holds the function ptrs that the keyslot
+ * manager will use to manipulate keyslots in the hardware.
+ */
+struct keyslot_mgmt_ll_ops {
+	int (*keyslot_program)(void *ll_priv_data, const u8 *key,
+			       enum blk_crypto_mode_num crypto_mode,
+			       unsigned int data_unit_size,
+			       unsigned int slot);
+	int (*keyslot_evict)(void *ll_priv_data, const u8 *key,
+			     enum blk_crypto_mode_num crypto_mode,
+			     unsigned int data_unit_size,
+			     unsigned int slot);
+	bool (*crypto_mode_supported)(void *ll_priv_data,
+				      enum blk_crypto_mode_num crypto_mode,
+				      unsigned int data_unit_size);
+	int (*keyslot_find)(void *ll_priv_data, const u8 *key,
+			    enum blk_crypto_mode_num crypto_mode,
+			    unsigned int data_unit_size);
+};
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+struct keyslot_manager;
+
+extern struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
+				const struct keyslot_mgmt_ll_ops *ksm_ops,
+				void *ll_priv_data);
+
+extern int
+keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				 const u8 *key,
+				 enum blk_crypto_mode_num crypto_mode,
+				 unsigned int data_unit_size);
+
+extern void keyslot_manager_get_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern void keyslot_manager_put_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern bool
+keyslot_manager_crypto_mode_supported(struct keyslot_manager *ksm,
+				      enum blk_crypto_mode_num crypto_mode,
+				      unsigned int data_unit_size);
+
+extern bool
+keyslot_manager_rq_crypto_mode_supported(struct request_queue *q,
+					 enum blk_crypto_mode_num crypto_mode,
+					 unsigned int data_unit_size);
+
+extern int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypto_mode_num crypto_mode,
+				     unsigned int data_unit_size);
+
+extern void keyslot_manager_destroy(struct keyslot_manager *ksm);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline bool
+keyslot_manager_rq_crypto_mode_supported(struct request_queue *q,
+					 enum blk_crypto_mode_num crypto_mode,
+					 unsigned int data_unit_size)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#endif /* __LINUX_KEYSLOT_MANAGER_H */
+
+#endif /* CONFIG_BLOCK */
-- 
2.24.0.rc0.303.g954a862665-goog

