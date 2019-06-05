Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6A367FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 01:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFEX2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 19:28:45 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50746 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFEX2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:28:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id g9so222319pgd.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wi8HzIkZkJbIKnEuZY8ieUlLZpxbcxFPQ0YPmCYVTdg=;
        b=C4wXqWTsJwJcq6X11RBfEZz34WC/j1g+19SU4GrRWhITz8m3Ui5qNWAgLhfkwHgNWI
         gBQUhSnFtw9PS4lOUKZs6G0/wYZV7Wk30Ir+XmvJjMbYk0zB8PxOpdmCw2LRGj6Zagie
         Cm5bBqaAL6ZN0tFlMEpttGzH0Jf2uP2X6q8D+T+QVcBXPzeel045cVVL3YEQ1p3/fk8t
         4foGZzPq85YNRUlRXXfyxOk/uLMQ8hChg1AszHKYxaL2xIMfK1+NEztaRzKeNYabD49I
         woQ14QfOjggoSHqh2dJ9xJeJoD9esEvKTxGC76b8xH/2HsxMeoiG075moNg2A9tnuKkW
         AQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wi8HzIkZkJbIKnEuZY8ieUlLZpxbcxFPQ0YPmCYVTdg=;
        b=gREuYAGXKMY8GF2GVIvJctVuJXepHkrtavVViIQGPVBkxPBF9/+H6ktoKEJNiGWwC1
         IsqUeKYu0jYsJCiuzbh7F1B/fWSl+Q6GCQrkToa2YAY0JUVEK2urniMR2xKAYWR2qRCM
         QLN52Ks/HdVH8DVXz7T3PE6LfPv+6EKmXQHYymjsQGai+hafynEOpeE6cw5h6W/5AvRQ
         KXQarLvS8Hfc5kRyFGkjsEkLhlJbuWCYalblJA/FM1XMWlffJhzShFwBXuZcnUDbRIYo
         7RiM5WL+h8RucohTzNlXV/1VWbOpxTn07IUWEZhJWhjjNCIRD6YfXNbpFT131aMdJHbi
         99yg==
X-Gm-Message-State: APjAAAXu3+Qsi88TepxsI+ldy4nO0Ecw6qMkF4P3wxajWOI6v2Zjlsnr
        CpWS/FkRpbI7kBbZcldI1ChfvqSfVCk=
X-Google-Smtp-Source: APXvYqwME9TzwEmDzECjNzKoF9WomqL43fRmIRS5/oPZHJiwc69FiCGy9EIaaX36evFBgXnyMlFSRS9E9ZU=
X-Received: by 2002:a63:3141:: with SMTP id x62mr391836pgx.282.1559777324348;
 Wed, 05 Jun 2019 16:28:44 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:30 -0700
In-Reply-To: <20190605232837.31545-1-satyat@google.com>
Message-Id: <20190605232837.31545-2-satyat@google.com>
Mime-Version: 1.0
References: <20190605232837.31545-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 1/8] block: Keyslot Manager for Inline Encryption
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

Known issues:
1) Keyslot Manager has a performance bug where the same encryption
   context may be programmed into multiple keyslots at the same time in
   certain situations when all keyslots are being used.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 315 ++++++++++++++++++++++++++++++++
 include/linux/blk_types.h       |  11 ++
 include/linux/blkdev.h          |   9 +
 include/linux/keyslot-manager.h | 116 ++++++++++++
 4 files changed, 451 insertions(+)
 create mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/keyslot-manager.h

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
new file mode 100644
index 000000000000..d4a5d6d78d2c
--- /dev/null
+++ b/block/keyslot-manager.c
@@ -0,0 +1,315 @@
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
+#include <linux/slab.h>
+#include <linux/keyslot-manager.h>
+#include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+struct keyslot_manager {
+	unsigned int num_slots;
+	atomic_t num_idle_slots;
+	struct keyslot_mgmt_ll_ops ksm_ll_ops;
+	void *ll_priv_data;
+	struct mutex lock;
+	wait_queue_head_t wait_queue;
+	u64 seq_num;
+	u64 *last_used_seq_nums;
+	atomic_t slot_refs[];
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
+	ksm = kzalloc(struct_size(ksm, slot_refs, num_slots), GFP_KERNEL);
+	if (!ksm)
+		return NULL;
+
+	ksm->num_slots = num_slots;
+	atomic_set(&ksm->num_idle_slots, num_slots);
+	ksm->ksm_ll_ops = *ksm_ll_ops;
+	ksm->ll_priv_data = ll_priv_data;
+
+	mutex_init(&ksm->lock);
+	init_waitqueue_head(&ksm->wait_queue);
+
+	ksm->last_used_seq_nums = kcalloc(num_slots, sizeof(u64), GFP_KERNEL);
+	if (!ksm->last_used_seq_nums) {
+		kzfree(ksm);
+		ksm = NULL;
+	}
+
+	return ksm;
+}
+EXPORT_SYMBOL(keyslot_manager_create);
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
+	int c;
+	int lru_idle_slot;
+	u64 min_seq_num;
+
+	mutex_lock(&ksm->lock);
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypt_mode,
+					    data_unit_size);
+
+	if (slot < 0 && slot != -ENOKEY) {
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	if (WARN_ON(slot >= (int)ksm->num_slots)) {
+		mutex_unlock(&ksm->lock);
+		return -EINVAL;
+	}
+
+	/* Try to use the returned slot */
+	if (slot != -ENOKEY) {
+		/*
+		 * NOTE: We may fail to get a slot if the number of refs
+		 * overflows UINT_MAX. I don't think we care enough about
+		 * that possibility to make the refcounts u64, considering
+		 * the only way for that to happen is for at least UINT_MAX
+		 * requests to be in flight at the same time.
+		 */
+		if ((unsigned int)atomic_read(&ksm->slot_refs[slot]) ==
+		    UINT_MAX) {
+			mutex_unlock(&ksm->lock);
+			return -EBUSY;
+		}
+
+		if (atomic_fetch_inc(&ksm->slot_refs[slot]) == 0)
+			atomic_dec(&ksm->num_idle_slots);
+
+		ksm->last_used_seq_nums[slot] = ++ksm->seq_num;
+
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	/*
+	 * If we're here, that means there wasn't a slot that
+	 * was already programmed with the key
+	 */
+
+	/* Wait till there is a free slot available */
+	while (atomic_read(&ksm->num_idle_slots) == 0) {
+		mutex_unlock(&ksm->lock);
+		wait_event(ksm->wait_queue,
+			   (atomic_read(&ksm->num_idle_slots) > 0));
+		mutex_lock(&ksm->lock);
+	}
+
+	/* Todo: fix linear scan? */
+	/* Find least recently used idle slot (i.e. slot with minimum number) */
+	lru_idle_slot  = -1;
+	min_seq_num = 0;
+	for (c = 0; c < ksm->num_slots; c++) {
+		if (atomic_read(&ksm->slot_refs[c]) != 0)
+			continue;
+
+		if (lru_idle_slot == -1 ||
+		    ksm->last_used_seq_nums[c] < min_seq_num) {
+			lru_idle_slot = c;
+			min_seq_num = ksm->last_used_seq_nums[c];
+		}
+	}
+
+	if (WARN_ON(lru_idle_slot == -1)) {
+		mutex_unlock(&ksm->lock);
+		return -EBUSY;
+	}
+
+	atomic_dec(&ksm->num_idle_slots);
+	atomic_inc(&ksm->slot_refs[lru_idle_slot]);
+	err = ksm->ksm_ll_ops.keyslot_program(ksm->ll_priv_data, key,
+					      crypt_mode,
+					      data_unit_size,
+					      lru_idle_slot);
+
+	if (err) {
+		atomic_dec(&ksm->slot_refs[lru_idle_slot]);
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->wait_queue);
+		mutex_unlock(&ksm->lock);
+		return err;
+	}
+
+	ksm->seq_num++;
+	ksm->last_used_seq_nums[lru_idle_slot] = ksm->seq_num;
+
+	mutex_unlock(&ksm->lock);
+	return lru_idle_slot;
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
+	WARN_ON(atomic_inc_return(&ksm->slot_refs[slot]) < 2);
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
+	if (WARN_ON(slot >= ksm->num_slots))
+		return;
+
+	if (atomic_dec_and_test(&ksm->slot_refs[slot])) {
+		atomic_inc(&ksm->num_idle_slots);
+		wake_up(&ksm->wait_queue);
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
+	mutex_lock(&ksm->lock);
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypt_mode,
+					    data_unit_size);
+
+	if (slot < 0) {
+		mutex_unlock(&ksm->lock);
+		return slot;
+	}
+
+	if (atomic_read(&ksm->slot_refs[slot]) == 0) {
+		err = ksm->ksm_ll_ops.keyslot_evict(ksm->ll_priv_data, key,
+						    crypt_mode,
+						    data_unit_size,
+						    slot);
+	} else {
+		err = -EBUSY;
+	}
+
+	mutex_unlock(&ksm->lock);
+	return err;
+}
+EXPORT_SYMBOL(keyslot_manager_evict_key);
+
+void keyslot_manager_destroy(struct keyslot_manager *ksm)
+{
+	if (!ksm)
+		return;
+	kzfree(ksm->last_used_seq_nums);
+	kzfree(ksm);
+}
+EXPORT_SYMBOL(keyslot_manager_destroy);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 95202f80676c..aafa96839f95 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -137,6 +137,17 @@ static inline void bio_issue_init(struct bio_issue *issue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
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
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..f76d5dff27fe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -385,6 +385,10 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+struct keyslot_manager;
+#endif
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
@@ -473,6 +477,11 @@ struct request_queue {
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
index 000000000000..76a9c255cb7e
--- /dev/null
+++ b/include/linux/keyslot-manager.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/types.h>
+#include <linux/blk_types.h>
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
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+struct keyslot_manager {};
+
+static inline struct keyslot_manager *
+keyslot_manager_create(unsigned int num_slots,
+		       const struct keyslot_mgmt_ll_ops *ksm_ops,
+		       void *ll_priv_data)
+{
+	return NULL;
+}
+
+static inline int
+keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
+				 const u8 *key,
+				 enum blk_crypt_mode_num crypt_mode,
+				 unsigned int data_unit_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void keyslot_manager_get_slot(struct keyslot_manager *ksm,
+					    unsigned int slot) { }
+
+static inline int keyslot_manager_put_slot(struct keyslot_manager *ksm,
+					   unsigned int slot)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int keyslot_manager_evict_key(struct keyslot_manager *ksm,
+				     const u8 *key,
+				     enum blk_crypt_mode_num crypt_mode,
+				     unsigned int data_unit_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void keyslot_manager_destroy(struct keyslot_manager *ksm)
+{ }
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+#endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.22.0.rc1.311.g5d7573a151-goog

