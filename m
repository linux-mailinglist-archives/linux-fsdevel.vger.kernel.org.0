Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65AC64EDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 00:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGJW4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 18:56:21 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48528 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfGJW4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:56:20 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so2214435pfn.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JT1bXouP+fvOdlQALoRX9oq1TH9MM1RmEQkq2BrUIMM=;
        b=dWM6aKg5zdzdr3jNNgojURs9H/kcZwBW48Mg74TXp/171G8lZKoCiVLnRv5EZyeh+P
         lWCN7mIy0UYAXm2hgLrPXnWMqwDzYd4FZilD1YHqR47R4C1AM+L7ZdR9I6gL2o6AJ9iI
         HPke6T+JfFORwpVSwyvYRV1wOT8cDZoKXygrJfqrjwfWGvNjVCRz3tQI0DpZQ+dvlu/p
         4DEL4A67f0Hb265xEQk+zukkK0+xrEz5bHrGwhxvOrXhQHgsd+v305pIBHUIcyVuIOft
         QUP3z75/qwJsMOU1jrHg62UkM4o/gNcS3ebTC0kA4+1HgtVxbsZWWeYoLhSDH4+ICf9C
         ektw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JT1bXouP+fvOdlQALoRX9oq1TH9MM1RmEQkq2BrUIMM=;
        b=p+Nr8usshZc9jG1nafhnzaSWm5aFc4DwMPVAKmGvCBqofg3WvD3LZC/f0D/SPvfSgN
         fAGe5x41Ub+LUApib/he8LulE9jbQUI0MeZAtka/99me2hI/p1Zex5z8I4wPtasyZjnc
         +r0Pw2g1MoDv5fQR5WWhwEZnEiOudjaQy4mhSAejOD8h5xZFBrB70dwxW5j3tGbgNBon
         ul3OaHbh5Z2S1baGHAf56XICOU9STraNYdqro24B+TOBBV/Fx1Gz3L7Hp654dUdacYSO
         7g10C4II59VipHQ/4h6d645BSvVoP/xqpBBmpAcuXDOFb4ugdTeWN1og6LuiuXxZ+upI
         bYjw==
X-Gm-Message-State: APjAAAWOoFIVaoUymYDo+CKlZxkfA31AhC6mG03eQhl+cDQa+/QS/yIH
        NLML9tq3gc0k+awLxwxR1yk4q92Hyio=
X-Google-Smtp-Source: APXvYqwcn2sTF1c646csADNUahEFTmdUX8Cd1X2FC1sg7hcY6ddvq6GyjSqjnH2Az83I8oLBXI+dVgzqRos=
X-Received: by 2002:a63:e356:: with SMTP id o22mr787048pgj.150.1562799378948;
 Wed, 10 Jul 2019 15:56:18 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:56:02 -0700
In-Reply-To: <20190710225609.192252-1-satyat@google.com>
Message-Id: <20190710225609.192252-2-satyat@google.com>
Mime-Version: 1.0
References: <20190710225609.192252-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 1/8] block: Keyslot Manager for Inline Encryption
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
 block/keyslot-manager.c         | 314 ++++++++++++++++++++++++++++++++
 include/linux/bio.h             |  11 ++
 include/linux/blkdev.h          |   6 +
 include/linux/keyslot-manager.h |  75 ++++++++
 6 files changed, 415 insertions(+)
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/keyslot-manager.h

diff --git a/block/Kconfig b/block/Kconfig
index 2466dcc3ef1d..fef7c60f6d8e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -164,6 +164,14 @@ config BLK_SED_OPAL
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
index eee1b4ceecf9..a72abd61b220 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= keyslot-manager.o
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
new file mode 100644
index 000000000000..22afd00c9235
--- /dev/null
+++ b/block/keyslot-manager.c
@@ -0,0 +1,314 @@
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
+ * Allocate memory for and initialize a keyslot manager. Called by for e.g.
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
+	    ksm_ll_ops->crypt_mode_supported == NULL ||
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
+	for (slot = 0; slot < num_slots; slot++)
+		list_add(&ksm->slots[slot].idle_slot_node, &ksm->idle_slots);
+
+	spin_lock_init(&ksm->idle_slots_lock);
+
+	return ksm;
+}
+EXPORT_SYMBOL(keyslot_manager_create);
+
+static int find_and_grab_keyslot(struct keyslot_manager *ksm, const u8 *key,
+				 enum blk_crypt_mode_num crypt_mode,
+				 unsigned int data_unit_size)
+{
+	int slot;
+	unsigned long flags;
+
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypt_mode, data_unit_size);
+	if (slot < 0)
+		return slot;
+	if (WARN_ON(slot >= ksm->num_slots))
+		return -EINVAL;
+	if (atomic_inc_return(&ksm->slots[slot].slot_refs) == 1) {
+		/* Took first reference to this slot; remove it from LRU list */
+		spin_lock_irqsave(&ksm->idle_slots_lock, flags);
+		list_del(&ksm->slots[slot].idle_slot_node);
+		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+		atomic_dec(&ksm->num_idle_slots);
+	}
+	return slot;
+}
+
+/**
+ * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
+ * @ksm: The keyslot manager to program the key into.
+ * @key: Pointer to the bytes of the key to program. Must be the correct length
+ *      for the chosen @crypt_mode; see blk_crypt_modes in blk-crypto.c.
+ * @crypt_mode: Identifier for the encryption algorithm to use.
+ * @data_unit_size: The data unit size to use for en/decryption.
+ *
+ * Get a keyslot that's been programmed with the specified key, crypt_mode, and
+ * data_unit_size.  If one already exists, return it with incremented refcount.
+ * Otherwise, wait for a keyslot to become idle and program it.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ * Return: The keyslot on success, else a -errno value.
+ */
+int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_num crypt_mode,
+				     unsigned int data_unit_size)
+{
+	int slot;
+	int err;
+	struct keyslot *idle_slot;
+	unsigned long flags;
+
+	down_read(&ksm->lock);
+	slot = find_and_grab_keyslot(ksm, key, crypt_mode, data_unit_size);
+	up_read(&ksm->lock);
+	if (slot != -ENOKEY)
+		return slot;
+
+	while (true) {
+		down_write(&ksm->lock);
+		slot = find_and_grab_keyslot(ksm, key, crypt_mode,
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
+					      crypt_mode,
+					      data_unit_size,
+					      slot);
+
+	if (err) {
+		wake_up(&ksm->idle_slots_wait_queue);
+		up_write(&ksm->lock);
+		return err;
+	}
+
+	atomic_inc(&ksm->slots[slot].slot_refs);
+	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
+	list_del(&idle_slot->idle_slot_node);
+	spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+	atomic_dec(&ksm->num_idle_slots);
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
+	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
+	if (atomic_dec_and_test(&ksm->slots[slot].slot_refs)) {
+		list_add_tail(&ksm->slots[slot].idle_slot_node,
+			      &ksm->idle_slots);
+		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->idle_slots_wait_queue);
+	} else {
+		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
+	}
+}
+EXPORT_SYMBOL(keyslot_manager_put_slot);
+
+/**
+ * keyslot_manager_evict_key() - Evict a key from the lower layer device.
+ * @ksm - The keyslot manager to evict from
+ * @key - The key to evict
+ * @crypt_mode - The crypto algorithm the key was programmed with.
+ * @data_unit_size - The data_unit_size the key was programmed with.
+ *
+ * Finds the slot that the specified key, crypt_mode, data_unit_size combo
+ * was programmed into, and evicts that slot from the lower layer device if
+ * the refcount on the slot is 0. Returns -EBUSY if the refcount is not 0, and
+ * -errno on error.
+ *
+ * Context: Process context. Takes and releases ksm->lock.
+ */
+int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+			      const u8 *key,
+			      enum blk_crypt_mode_num crypt_mode,
+			      unsigned int data_unit_size)
+{
+	int slot;
+	int err = 0;
+
+	down_write(&ksm->lock);
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypt_mode,
+					    data_unit_size);
+
+	if (slot < 0) {
+		up_write(&ksm->lock);
+		return slot;
+	}
+
+	if (atomic_read(&ksm->slots[slot].slot_refs) == 0) {
+		err = ksm->ksm_ll_ops.keyslot_evict(ksm->ll_priv_data, key,
+						    crypt_mode,
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
+	if (!ksm)
+		return;
+	kvfree(ksm);
+}
+EXPORT_SYMBOL(keyslot_manager_destroy);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f87abaa898f0..ef9c6e2e92bc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -561,6 +561,17 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 }
 #endif
 
+enum blk_crypt_mode_num {
+	BLK_ENCRYPTION_MODE_AES_256_XTS	= 0,
+	/*
+	 * TODO: Support these too
+	 * BLK_ENCRYPTION_MODE_AES_256_CTS	= 1,
+	 * BLK_ENCRYPTION_MODE_AES_128_CBC	= 2,
+	 * BLK_ENCRYPTION_MODE_AES_128_CTS	= 3,
+	 * BLK_ENCRYPTION_MODE_ADIANTUM		= 4,
+	 */
+};
+
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..3bb4e7e1bd78 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -43,6 +43,7 @@ struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
+struct keyslot_manager;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -473,6 +474,11 @@ struct request_queue {
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
index 000000000000..ee97692997c8
--- /dev/null
+++ b/include/linux/keyslot-manager.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/bio.h>
+
+#ifndef __LINUX_KEYSLOT_MANAGER_H
+#define __LINUX_KEYSLOT_MANAGER_H
+
+/**
+ * struct keyslot_mgmt_ll_ops - functions to manage keyslots in hardware
+ * @keyslot_program:	Program the specified key and algorithm into the
+ *			specified slot in the inline encryption hardware.
+ * @keyslot_evict:	Evict key from the specified keyslot in the hardware.
+ *			The key, crypt_mode and data_unit_size are also passed
+ *			down so that for e.g. dm layers can evict keys from
+ *			the devices that they map over.
+ *			Returns 0 on success, -errno otherwise.
+ * @crypt_mode_supported:	Check whether a crypt_mode and data_unit_size
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
+			       enum blk_crypt_mode_num crypt_mode,
+			       unsigned int data_unit_size,
+			       unsigned int slot);
+	int (*keyslot_evict)(void *ll_priv_data, const u8 *key,
+			     enum blk_crypt_mode_num crypt_mode,
+			     unsigned int data_unit_size,
+			     unsigned int slot);
+	bool (*crypt_mode_supported)(void *ll_priv_data,
+				      enum blk_crypt_mode_num crypt_mode,
+				      unsigned int data_unit_size);
+	int (*keyslot_find)(void *ll_priv_data, const u8 *key,
+			    enum blk_crypt_mode_num crypt_mode,
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
+				 enum blk_crypt_mode_num crypt_mode,
+				 unsigned int data_unit_size);
+
+extern void keyslot_manager_get_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern void keyslot_manager_put_slot(struct keyslot_manager *ksm,
+				     unsigned int slot);
+
+extern int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_num crypt_mode,
+				     unsigned int data_unit_size);
+
+extern void keyslot_manager_destroy(struct keyslot_manager *ksm);
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.22.0.410.gd8fdbe21b5-goog

