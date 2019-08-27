Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8309F4D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfH0VPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 17:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfH0VPU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:15:20 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B34B2077B;
        Tue, 27 Aug 2019 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566940518;
        bh=iaghhaDV8j8qORBSTzVchX5sytlV1GHoa0Q1lTkIpvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFoC+cRDLCAASnXGhd5PexBhEEu0p3YaKDSvyT2OPqNuInaZrpfDuvYEa85/JD+1f
         JBydFcxKT/lBlaowRQ3FOu6aDiDZaeKn/y6mgofYnw2svZ8V49yzFvnKbx1nq1C0I/
         HYbprNd0CUsUJoG2q2JahCf73LJuGaGOLprmhD9E=
Date:   Tue, 27 Aug 2019 14:15:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v4 1/8] block: Keyslot Manager for Inline Encryption
Message-ID: <20190827211515.GB27166@gmail.com>
Mail-Followup-To: Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
References: <20190821075714.65140-1-satyat@google.com>
 <20190821075714.65140-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821075714.65140-2-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya, a few more minor comments:

On Wed, Aug 21, 2019 at 12:57:07AM -0700, Satya Tangirala wrote:
> +/**
> + * keyslot_manager_create() - Create a keyslot manager
> + * @num_slots: The number of key slots to manage.
> + * @ksm_ll_ops: The struct keyslot_mgmt_ll_ops for the device that this keyslot
> + *		manager will use to perform operations like programming and
> + *		evicting keys.
> + * @ll_priv_data: Private data passed as is to the functions in ksm_ll_ops.
> + *
> + * Allocate memory for and initialize a keyslot manager. Called by for e.g.
> + * storage drivers to set up a keyslot manager in their request_queue.

The word "for" in "Called by for e.g." shouldn't be there.

> + *
> + * Context: May sleep
> + * Return: Pointer to constructed keyslot manager or NULL on error.
> + */
> +struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
> +				const struct keyslot_mgmt_ll_ops *ksm_ll_ops,
> +				void *ll_priv_data)
> +{
> +	struct keyslot_manager *ksm;
> +	int slot;
> +
> +	if (num_slots == 0)
> +		return NULL;
> +
> +	/* Check that all ops are specified */
> +	if (ksm_ll_ops->keyslot_program == NULL ||
> +	    ksm_ll_ops->keyslot_evict == NULL ||
> +	    ksm_ll_ops->crypto_mode_supported == NULL ||
> +	    ksm_ll_ops->keyslot_find == NULL)
> +		return NULL;
> +
> +	ksm = kvzalloc(struct_size(ksm, slots, num_slots), GFP_KERNEL);
> +	if (!ksm)
> +		return NULL;
> +
> +	ksm->num_slots = num_slots;
> +	atomic_set(&ksm->num_idle_slots, num_slots);
> +	ksm->ksm_ll_ops = *ksm_ll_ops;
> +	ksm->ll_priv_data = ll_priv_data;
> +
> +	init_rwsem(&ksm->lock);
> +
> +	init_waitqueue_head(&ksm->idle_slots_wait_queue);
> +	INIT_LIST_HEAD(&ksm->idle_slots);
> +
> +	for (slot = 0; slot < num_slots; slot++)
> +		list_add(&ksm->slots[slot].idle_slot_node, &ksm->idle_slots);
> +

Since the keyslots are allocated from the head of the list, it might be more
logical to use list_add_tail() here, so that the keyslots get allocated in the
order 0, 1, 2, ... rather than in the order num_slots-1, num_slots-2, ...

It doesn't really matter, but the ascending order seems more natural.

> +static int find_and_grab_keyslot(struct keyslot_manager *ksm, const u8 *key,
> +				 enum blk_crypto_mode_num crypto_mode,
> +				 unsigned int data_unit_size)
> +{
> +	int slot;
> +	unsigned long flags;
> +
> +	slot = ksm->ksm_ll_ops.keyslot_find(ksm->ll_priv_data, key,
> +					    crypto_mode, data_unit_size);
> +	if (slot < 0)
> +		return slot;
> +	if (WARN_ON(slot >= ksm->num_slots))
> +		return -EINVAL;
> +	if (atomic_inc_return(&ksm->slots[slot].slot_refs) == 1) {
> +		/* Took first reference to this slot; remove it from LRU list */
> +		spin_lock_irqsave(&ksm->idle_slots_lock, flags);
> +		list_del(&ksm->slots[slot].idle_slot_node);
> +		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
> +		atomic_dec(&ksm->num_idle_slots);
> +	}
> +	return slot;
> +}

The code to remove a slot from the LRU list is duplicated both in
find_and_grab_keyslot() and in keyslot_manager_get_slot_for_key().
How about making them both call a helper function:

static void remove_slot_from_lru_list(struct keyslot_manager *ksm, int slot)
{
	unsigned long flags;

	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
	list_del(&ksm->slots[slot].idle_slot_node);
	spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);

	atomic_dec(&ksm->num_idle_slots);
}

> +
> +/**
> + * keyslot_manager_get_slot_for_key() - Program a key into a keyslot.
> + * @ksm: The keyslot manager to program the key into.
> + * @key: Pointer to the bytes of the key to program. Must be the correct length
> + *      for the chosen @crypto_mode; see blk_crypto_modes in blk-crypto.c.
> + * @crypto_mode: Identifier for the encryption algorithm to use.
> + * @data_unit_size: The data unit size to use for en/decryption.
> + *
> + * Get a keyslot that's been programmed with the specified key, crypto_mode, and
> + * data_unit_size.  If one already exists, return it with incremented refcount.
> + * Otherwise, wait for a keyslot to become idle and program it.
> + *
> + * Context: Process context. Takes and releases ksm->lock.
> + * Return: The keyslot on success, else a -errno value.
> + */
> +int keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
> +				     const u8 *key,
> +				     enum blk_crypto_mode_num crypto_mode,
> +				     unsigned int data_unit_size)
> +{
> +	int slot;
> +	int err;
> +	struct keyslot *idle_slot;
> +	unsigned long flags;
> +
> +	down_read(&ksm->lock);
> +	slot = find_and_grab_keyslot(ksm, key, crypto_mode, data_unit_size);
> +	up_read(&ksm->lock);
> +	if (slot != -ENOKEY)
> +		return slot;
> +
> +	while (true) {

Nit: in kernel code it's more common to use 'for (;;)'

> +		down_write(&ksm->lock);
> +		slot = find_and_grab_keyslot(ksm, key, crypto_mode,
> +					     data_unit_size);
> +		if (slot != -ENOKEY) {
> +			up_write(&ksm->lock);
> +			return slot;
> +		}
> +
> +		/*
> +		 * If we're here, that means there wasn't a slot that was
> +		 * already programmed with the key. So try to program it.
> +		 */
> +		if (atomic_read(&ksm->num_idle_slots) > 0)
> +			break;
> +
> +		up_write(&ksm->lock);
> +		wait_event(ksm->idle_slots_wait_queue,
> +			(atomic_read(&ksm->num_idle_slots) > 0));
> +	}
> +
> +	idle_slot = list_first_entry(&ksm->idle_slots, struct keyslot,
> +					     idle_slot_node);
> +	slot = idle_slot - ksm->slots;
> +
> +	err = ksm->ksm_ll_ops.keyslot_program(ksm->ll_priv_data, key,
> +					      crypto_mode,
> +					      data_unit_size,
> +					      slot);
> +
> +	if (err) {
> +		wake_up(&ksm->idle_slots_wait_queue);
> +		up_write(&ksm->lock);
> +		return err;
> +	}
> +
> +	atomic_inc(&ksm->slots[slot].slot_refs);

This could be optimized to:

	atomic_set(&ksm->slots[slot].slot_refs, 1);

... since no one else can be incrementing it from 0 here.

> +/**
> + * keyslot_manager_put_slot() - Release a reference to a slot
> + * @ksm: The keyslot manager to release the reference from.
> + * @slot: The slot to release the reference from.
> + *
> + * Context: Any context.
> + */
> +void keyslot_manager_put_slot(struct keyslot_manager *ksm, unsigned int slot)
> +{
> +	unsigned long flags;
> +
> +	if (WARN_ON(slot >= ksm->num_slots))
> +		return;
> +
> +	spin_lock_irqsave(&ksm->idle_slots_lock, flags);
> +	if (atomic_dec_and_test(&ksm->slots[slot].slot_refs)) {
> +		list_add_tail(&ksm->slots[slot].idle_slot_node,
> +			      &ksm->idle_slots);
> +		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
> +		atomic_inc(&ksm->num_idle_slots);
> +		wake_up(&ksm->idle_slots_wait_queue);
> +	} else {
> +		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
> +	}
> +}
> +EXPORT_SYMBOL(keyslot_manager_put_slot);

This should use atomic_dec_and_lock_irqsave(), since the spinlock only needs to
be taken if the reference count went to 0.

Separately: list_add_tail() is returning the keyslot to the end of the list.
Therefore, the allocator will cycle through all the keyslots before allocating
this one again.  I wonder if it should return it to the beginning of the list
instead (list_add())?  Again it shouldn't matter, but it might be more logical.
Or is it intentional that it cycles through the keyslots?

> +void keyslot_manager_destroy(struct keyslot_manager *ksm)
> +{
> +	if (!ksm)
> +		return;
> +	kvfree(ksm);
> +}
> +EXPORT_SYMBOL(keyslot_manager_destroy);

No need to check for NULL before calling kvfree().

> +enum blk_crypto_mode_num {
> +	BLK_ENCRYPTION_MODE_INVALID	= -1,
> +	BLK_ENCRYPTION_MODE_AES_256_XTS	= 0,
> +	/*
> +	 * TODO: Support these too
> +	 * BLK_ENCRYPTION_MODE_AES_256_CTS	= 1,
> +	 * BLK_ENCRYPTION_MODE_AES_128_CBC	= 2,
> +	 * BLK_ENCRYPTION_MODE_AES_128_CTS	= 3,
> +	 * BLK_ENCRYPTION_MODE_ADIANTUM		= 4,
> +	 */
> +};

I assume the list in this TODO comment came from available_modes[] in
fs/crypto/keyinfo.c.  But it doesn't make sense for CTS to be here because it's
used for filenames encryption only, not file contents encryption.  CTS isn't
something that really makes sense for disk encryption.  Also, CBC in fs/crypto/
is really CBC-ESSIV, not plain CBC; if we added it to blk-crypto we'd probably
want to put ESSIV in the name.

I suggest just removing this comment for now, to avoid these considerations.

> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> new file mode 100644
> index 000000000000..284f53973271
> --- /dev/null
> +++ b/include/linux/keyslot-manager.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/bio.h>
> +
> +#ifndef __LINUX_KEYSLOT_MANAGER_H
> +#define __LINUX_KEYSLOT_MANAGER_H
> +
> +/**
> + * struct keyslot_mgmt_ll_ops - functions to manage keyslots in hardware
> + * @keyslot_program:	Program the specified key and algorithm into the
> + *			specified slot in the inline encryption hardware.
> + * @keyslot_evict:	Evict key from the specified keyslot in the hardware.
> + *			The key, crypto_mode and data_unit_size are also passed
> + *			down so that for e.g. dm layers can evict keys from
> + *			the devices that they map over.
> + *			Returns 0 on success, -errno otherwise.

The word "for" in "so that for e.g. dm layers" shouldn't be there.

- Eric
