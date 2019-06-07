Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEF398A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfFGW2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 18:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfFGW2P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:28:15 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA7A20449;
        Fri,  7 Jun 2019 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559946494;
        bh=n3YV4ps24JK3AADQ/A5wZZfvM2CoR/O3dsjCoRs1uTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG1FhOyZG6na+bsnIqg04r10/A8ASNNiiYyLJ1DCGyAOaooXZyHY78OHjSNM+Fv1o
         sxe31IjVCi4Zq3TJJOKFaNk2ksGJ0OBasTTGipNNBN1y7KuFtmTS1kGi6SklfEPS8S
         HittNRr7Hb7zTghMb44RRpsQKZtT/BRPEk0tbY54=
Date:   Fri, 7 Jun 2019 15:28:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 1/8] block: Keyslot Manager for Inline Encryption
Message-ID: <20190607222812.GF648@sol.localdomain>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605232837.31545-2-satyat@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, Jun 05, 2019 at 04:28:30PM -0700, Satya Tangirala wrote:
> 
> Known issues:
> 1) Keyslot Manager has a performance bug where the same encryption
>    context may be programmed into multiple keyslots at the same time in
>    certain situations when all keyslots are being used.

This is also a correctness bug, since keyslot_manager_evict_key() only evicts
one copy of the key.  It can be fixed by looking for the key again after waiting
for an idle slot.

> +
> +struct keyslot_manager {
> +	unsigned int num_slots;
> +	atomic_t num_idle_slots;
> +	struct keyslot_mgmt_ll_ops ksm_ll_ops;
> +	void *ll_priv_data;
> +	struct mutex lock;
> +	wait_queue_head_t wait_queue;
> +	u64 seq_num;
> +	u64 *last_used_seq_nums;
> +	atomic_t slot_refs[];
> +};

slot_refs[] and last_used_seq_nums[] both contain per-keyslot data.  It would be
cleaner to combine them into a single 'slots' array of 'struct keyslot'.  That
would also make it much easier to add or change per-keyslot data in the future.

> /**
>  * keyslot_manager_create() - Create a keyslot manager
>  * @num_slots: The number of key slots to manage.
>  * @ksm_ll_ops: The struct keyslot_mgmt_ll_ops for the device that this keyslot
>  *		manager will use to perform operations like programming and
>  *		evicting keys.
>  * @ll_priv_data: Private data passed as is to the functions in ksm_ll_ops.
>  *
>  * Allocate memory for and initialize a keyslot manager. Called by for e.g.
>  * storage drivers to set up a keyslot manager in their request_queue.
>  *
>  * Context: May sleep
>  * Return: Pointer to constructed keyslot manager or NULL on error.
>  */
> struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
> 				const struct keyslot_mgmt_ll_ops *ksm_ll_ops,
> 				void *ll_priv_data)
> {
> 	struct keyslot_manager *ksm;
> 
> 	if (num_slots == 0)
> 		return NULL;
> 
> 	/* Check that all ops are specified */
> 	if (ksm_ll_ops->keyslot_program == NULL ||
> 	    ksm_ll_ops->keyslot_evict == NULL ||
> 	    ksm_ll_ops->crypt_mode_supported == NULL ||
> 	    ksm_ll_ops->keyslot_find == NULL)
> 		return NULL;
> 
> 	ksm = kzalloc(struct_size(ksm, slot_refs, num_slots), GFP_KERNEL);
> 	if (!ksm)
> 		return NULL;

This should probably be kvzalloc(), just in case the number of keyslots is too
large to fit comfortably into kmalloc memory.  We don't need physically
contiguous memory here.

> +/**
> + * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
> + * @ksm: The keyslot manager to program the key into.
> + * @key: Pointer to the bytes of the key to program. Must be the correct length
> + *      for the chosen @crypt_mode; see blk_crypt_modes in blk-crypto.c.
> + * @crypt_mode: Identifier for the encryption algorithm to use.
> + * @data_unit_size: The data unit size to use for en/decryption.
> + *
> + * Get a keyslot that's been programmed with the specified key, crypt_mode, and
> + * data_unit_size.  If one already exists, return it with incremented refcount.
> + * Otherwise, wait for a keyslot to become idle and program it.
> + *
> + * Context: Process context. Takes and releases ksm->lock.
> + * Return: The keyslot on success, else a -errno value.
> + */
> +int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
> +				     const u8 *key,
> +				     enum blk_crypt_mode_num crypt_mode,
> +				     unsigned int data_unit_size)
> +{
> +	int slot;
> +	int err;
> +	int c;
> +	int lru_idle_slot;
> +	u64 min_seq_num;
> +
> +	mutex_lock(&ksm->lock);
> +	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
> +					    crypt_mode,
> +					    data_unit_size);
> +
> +	if (slot < 0 && slot != -ENOKEY) {
> +		mutex_unlock(&ksm->lock);
> +		return slot;
> +	}

This is the fast path: taking a reference to an existing key slot.  There could
be many processes issuing I/O concurrently, so I'm worried that the per-device
mutex here will be a bottleneck.  How about using a rw_semaphore instead?
->keyslot_find() would be called with (at least) the read lock, while
->keyslot_program() and ->keyslot_evict() would be called with the write lock.

> +	/* Todo: fix linear scan? */
> +	/* Find least recently used idle slot (i.e. slot with minimum number) */
> +	lru_idle_slot  = -1;
> +	min_seq_num = 0;
> +	for (c = 0; c < ksm->num_slots; c++) {
> +		if (atomic_read(&ksm->slot_refs[c]) != 0)
> +			continue;
> +
> +		if (lru_idle_slot == -1 ||
> +		    ksm->last_used_seq_nums[c] < min_seq_num) {
> +			lru_idle_slot = c;
> +			min_seq_num = ksm->last_used_seq_nums[c];
> +		}
> +	}

How about using a real LRU list instead?  I.e., a linked list containing all
keyslots with refs == 0 in order of last use.  Then you could just grab the head
of the list here, which would be much more efficient than iterating through
every keyslot as the code does now.

The current LRU implementation is also broken since it orders the entries by
when they were last removed from the LRU list (i.e. last *started* to be used),
not by when they were last added to the LRU list (i.e. last used).

To better show what I mean, here's an incremental patch (compile-tested only!)
that implements these changes:

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index d4a5d6d78d2c..dd2fad8319c2 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -34,16 +34,26 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 
+struct keyslot {
+	atomic_t refs;		/* Number of users of this keyslot */
+	struct list_head lru;	/* Link in idle_slots LRU list (if refs == 0) */
+};
+
 struct keyslot_manager {
 	unsigned int num_slots;
-	atomic_t num_idle_slots;
 	struct keyslot_mgmt_ll_ops ksm_ll_ops;
 	void *ll_priv_data;
-	struct mutex lock;
-	wait_queue_head_t wait_queue;
-	u64 seq_num;
-	u64 *last_used_seq_nums;
-	atomic_t slot_refs[];
+
+	/* Protects programming and evicting keys from the device */
+	struct rw_semaphore lock;
+
+	/* List of slots with refs == 0, with least recently used at front */
+	struct list_head idle_slots;
+	spinlock_t idle_slots_lock;
+	wait_queue_head_t idle_slots_wait_queue;
+
+	/* Per-keyslot data */
+	struct keyslot slots[];
 };
 
 /**
@@ -65,6 +75,7 @@ struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
 				void *ll_priv_data)
 {
 	struct keyslot_manager *ksm;
+	int slot;
 
 	if (num_slots == 0)
 		return NULL;
@@ -76,28 +87,47 @@ struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
 	    ksm_ll_ops->keyslot_find == NULL)
 		return NULL;
 
-	ksm = kzalloc(struct_size(ksm, slot_refs, num_slots), GFP_KERNEL);
+	ksm = kvzalloc(struct_size(ksm, slots, num_slots), GFP_KERNEL);
 	if (!ksm)
 		return NULL;
 
 	ksm->num_slots = num_slots;
-	atomic_set(&ksm->num_idle_slots, num_slots);
 	ksm->ksm_ll_ops = *ksm_ll_ops;
 	ksm->ll_priv_data = ll_priv_data;
 
-	mutex_init(&ksm->lock);
-	init_waitqueue_head(&ksm->wait_queue);
+	init_rwsem(&ksm->lock);
 
-	ksm->last_used_seq_nums = kcalloc(num_slots, sizeof(u64), GFP_KERNEL);
-	if (!ksm->last_used_seq_nums) {
-		kzfree(ksm);
-		ksm = NULL;
-	}
+	INIT_LIST_HEAD(&ksm->idle_slots);
+	spin_lock_init(&ksm->idle_slots_lock);
+	init_waitqueue_head(&ksm->idle_slots_wait_queue);
+	for (slot = 0; slot < num_slots; slot++)
+		list_add_tail(&ksm->slots[slot].lru, &ksm->idle_slots);
 
 	return ksm;
 }
 EXPORT_SYMBOL(keyslot_manager_create);
 
+static int find_and_grab_keyslot(struct keyslot_manager *ksm, const u8 *key,
+				 enum blk_crypt_mode_num crypt_mode,
+				 unsigned int data_unit_size)
+{
+	int slot;
+
+	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
+					    crypt_mode, data_unit_size);
+	if (slot < 0)
+		return slot;
+	if (WARN_ON(slot >= ksm->num_slots))
+		return -EINVAL;
+	if (atomic_inc_return(&ksm->slots[slot].refs) == 1) {
+		/* Took first reference to this slot; remove it from LRU list */
+		spin_lock(&ksm->idle_slots_lock);
+		list_del(&ksm->slots[slot].lru);
+		spin_unlock(&ksm->idle_slots_lock);
+	}
+	return slot;
+}
+
 /**
  * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
  * @ksm: The keyslot manager to program the key into.
@@ -110,7 +140,7 @@ EXPORT_SYMBOL(keyslot_manager_create);
  * data_unit_size.  If one already exists, return it with incremented refcount.
  * Otherwise, wait for a keyslot to become idle and program it.
  *
- * Context: Process context. Takes and releases ksm->lock.
+ * Context: Process context.
  * Return: The keyslot on success, else a -errno value.
  */
 int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
@@ -119,103 +149,60 @@ int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
 				     unsigned int data_unit_size)
 {
 	int slot;
+	struct keyslot *slotp;
 	int err;
-	int c;
-	int lru_idle_slot;
-	u64 min_seq_num;
-
-	mutex_lock(&ksm->lock);
-	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
-					    crypt_mode,
-					    data_unit_size);
-
-	if (slot < 0 && slot != -ENOKEY) {
-		mutex_unlock(&ksm->lock);
-		return slot;
-	}
 
-	if (WARN_ON(slot >= (int)ksm->num_slots)) {
-		mutex_unlock(&ksm->lock);
-		return -EINVAL;
-	}
-
-	/* Try to use the returned slot */
-	if (slot != -ENOKEY) {
-		/*
-		 * NOTE: We may fail to get a slot if the number of refs
-		 * overflows UINT_MAX. I don't think we care enough about
-		 * that possibility to make the refcounts u64, considering
-		 * the only way for that to happen is for at least UINT_MAX
-		 * requests to be in flight at the same time.
-		 */
-		if ((unsigned int)atomic_read(&ksm->slot_refs[slot]) ==
-		    UINT_MAX) {
-			mutex_unlock(&ksm->lock);
-			return -EBUSY;
-		}
-
-		if (atomic_fetch_inc(&ksm->slot_refs[slot]) == 0)
-			atomic_dec(&ksm->num_idle_slots);
-
-		ksm->last_used_seq_nums[slot] = ++ksm->seq_num;
-
-		mutex_unlock(&ksm->lock);
+	/*
+	 * Fast path: take reference to existing keyslot, if there is one.
+	 * For this we only need the read lock.
+	 */
+	down_read(&ksm->lock);
+	slot = find_and_grab_keyslot(ksm, key, crypt_mode, data_unit_size);
+	up_read(&ksm->lock);
+	if (slot != -ENOKEY)
 		return slot;
-	}
 
 	/*
-	 * If we're here, that means there wasn't a slot that
-	 * was already programmed with the key
+	 * Slow path: wait for a slot to become idle, *or* for someone else to
+	 * have programmed the key while we dropped the lock.
 	 */
+	for (;;) {
+		down_write(&ksm->lock);
+		slot = find_and_grab_keyslot(ksm, key, crypt_mode,
+					     data_unit_size);
+		if (slot != -ENOKEY) {
+			up_write(&ksm->lock);
+			return slot;
+		}
 
-	/* Wait till there is a free slot available */
-	while (atomic_read(&ksm->num_idle_slots) == 0) {
-		mutex_unlock(&ksm->lock);
-		wait_event(ksm->wait_queue,
-			   (atomic_read(&ksm->num_idle_slots) > 0));
-		mutex_lock(&ksm->lock);
-	}
+		spin_lock(&ksm->idle_slots_lock);
+		if (!list_empty(&ksm->idle_slots))
+			break;
+		spin_unlock(&ksm->idle_slots_lock);
 
-	/* Todo: fix linear scan? */
-	/* Find least recently used idle slot (i.e. slot with minimum number) */
-	lru_idle_slot  = -1;
-	min_seq_num = 0;
-	for (c = 0; c < ksm->num_slots; c++) {
-		if (atomic_read(&ksm->slot_refs[c]) != 0)
-			continue;
-
-		if (lru_idle_slot == -1 ||
-		    ksm->last_used_seq_nums[c] < min_seq_num) {
-			lru_idle_slot = c;
-			min_seq_num = ksm->last_used_seq_nums[c];
-		}
+		up_write(&ksm->lock);
+		wait_event(ksm->idle_slots_wait_queue,
+			   !list_empty(&ksm->idle_slots));
 	}
 
-	if (WARN_ON(lru_idle_slot == -1)) {
-		mutex_unlock(&ksm->lock);
-		return -EBUSY;
-	}
+	/* Remove least recently used idle slot from LRU list. */
+	slotp = list_first_entry(&ksm->idle_slots, struct keyslot, lru);
+	list_del(&slotp->lru);
+	atomic_set(&slotp->refs, 1);
+	spin_unlock(&ksm->idle_slots_lock);
+	slot = slotp - ksm->slots;
 
-	atomic_dec(&ksm->num_idle_slots);
-	atomic_inc(&ksm->slot_refs[lru_idle_slot]);
+	/* Program the key into it. */
 	err = ksm->ksm_ll_ops.keyslot_program(ksm->ll_priv_data, key,
-					      crypt_mode,
-					      data_unit_size,
-					      lru_idle_slot);
+					      crypt_mode, data_unit_size, slot);
+	up_write(&ksm->lock);
 
 	if (err) {
-		atomic_dec(&ksm->slot_refs[lru_idle_slot]);
-		atomic_inc(&ksm->num_idle_slots);
-		wake_up(&ksm->wait_queue);
-		mutex_unlock(&ksm->lock);
+		/* Oops, programming the key failed.  Return slot to LRU list */
+		keyslot_manager_put_slot(ksm, slot);
 		return err;
 	}
-
-	ksm->seq_num++;
-	ksm->last_used_seq_nums[lru_idle_slot] = ksm->seq_num;
-
-	mutex_unlock(&ksm->lock);
-	return lru_idle_slot;
+	return slot;
 }
 EXPORT_SYMBOL(keyslot_manager_get_slot_for_key);
 
@@ -236,7 +223,7 @@ void keyslot_manager_get_slot(struct keyslot_manager *ksm, unsigned int slot)
 	if (WARN_ON(slot >= ksm->num_slots))
 		return;
 
-	WARN_ON(atomic_inc_return(&ksm->slot_refs[slot]) < 2);
+	WARN_ON(atomic_inc_return(&ksm->slots[slot].refs) < 2);
 }
 EXPORT_SYMBOL(keyslot_manager_get_slot);
 
@@ -252,9 +239,12 @@ void keyslot_manager_put_slot(struct keyslot_manager *ksm, unsigned int slot)
 	if (WARN_ON(slot >= ksm->num_slots))
 		return;
 
-	if (atomic_dec_and_test(&ksm->slot_refs[slot])) {
-		atomic_inc(&ksm->num_idle_slots);
-		wake_up(&ksm->wait_queue);
+	if (atomic_dec_and_lock(&ksm->slots[slot].refs,
+				&ksm->idle_slots_lock)) {
+		/* Dropped last reference to this slot; add it to LRU list */
+		list_add_tail(&ksm->slots[slot].lru, &ksm->idle_slots);
+		spin_unlock(&ksm->idle_slots_lock);
+		wake_up(&ksm->idle_slots_wait_queue);
 	}
 }
 EXPORT_SYMBOL(keyslot_manager_put_slot);
@@ -271,7 +261,7 @@ EXPORT_SYMBOL(keyslot_manager_put_slot);
  * the refcount on the slot is 0. Returns -EBUSY if the refcount is not 0, and
  * -errno on error.
  *
- * Context: Process context. Takes and releases ksm->lock.
+ * Context: Process context.
  */
 int keyslot_manager_evict_key(struct keyslot_manager *ksm,
 			      const u8 *key,
@@ -279,37 +269,30 @@ int keyslot_manager_evict_key(struct keyslot_manager *ksm,
 			      unsigned int data_unit_size)
 {
 	int slot;
-	int err = 0;
+	int err;
 
-	mutex_lock(&ksm->lock);
+	down_write(&ksm->lock);
 	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
-					    crypt_mode,
-					    data_unit_size);
-
+					    crypt_mode, data_unit_size);
 	if (slot < 0) {
-		mutex_unlock(&ksm->lock);
+		up_write(&ksm->lock);
 		return slot;
 	}
 
-	if (atomic_read(&ksm->slot_refs[slot]) == 0) {
+	if (atomic_read(&ksm->slots[slot].refs) == 0) {
 		err = ksm->ksm_ll_ops.keyslot_evict(ksm->ll_priv_data, key,
-						    crypt_mode,
-						    data_unit_size,
+						    crypt_mode, data_unit_size,
 						    slot);
 	} else {
 		err = -EBUSY;
 	}
-
-	mutex_unlock(&ksm->lock);
+	up_write(&ksm->lock);
 	return err;
 }
 EXPORT_SYMBOL(keyslot_manager_evict_key);
 
 void keyslot_manager_destroy(struct keyslot_manager *ksm)
 {
-	if (!ksm)
-		return;
-	kzfree(ksm->last_used_seq_nums);
-	kzfree(ksm);
+	kvfree(ksm);
 }
 EXPORT_SYMBOL(keyslot_manager_destroy);
