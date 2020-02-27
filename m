Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A21727F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgB0Ssd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 13:48:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgB0Ssc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:48:32 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEE8246C6;
        Thu, 27 Feb 2020 18:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582829310;
        bh=6F5eBwIExz2pRbV8uz/NxfeoItn55B8grvYEoyUuWRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwRBzyUIjv0eiNQY+EZ9h3OG20DhpbuVFa3MDYHKHkkWzDLEzD1MPaFa3MaeyfqZb
         P+fHdXgLr57xqJvNfrn5SzyN0rvTl/yX/yaasPJapqqQAudlyz7hBbrUomvSVVtbwy
         vhaDc6eduxxI2nqIGWp3fOcNzfCLw8+wqEZmBBd0=
Date:   Thu, 27 Feb 2020 10:48:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20200227184829.GD877@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:42AM -0800, Satya Tangirala wrote:
> Inline Encryption hardware allows software to specify an encryption context
> (an encryption key, crypto algorithm, data unit num, data unit size) along
> with a data transfer request to a storage device, and the inline encryption
> hardware will use that context to en/decrypt the data. The inline
> encryption hardware is part of the storage device, and it conceptually sits
> on the data path between system memory and the storage device.
> 
> Inline Encryption hardware implementations often function around the
> concept of "keyslots". These implementations often have a limited number
> of "keyslots", each of which can hold an encryption context (we say that
> an encryption context can be "programmed" into a keyslot). Requests made
> to the storage device may have a keyslot associated with them, and the
> inline encryption hardware will en/decrypt the data in the requests using
> the encryption context programmed into that associated keyslot.

The second paragraph uses the phrase "encryption context" differently from the
first.  In the first it's (key, alg, dun, dusize) while in the second it's (key,
alg, dusize).  Maybe simply say "key" in the second?  "Key" is already used as
shorthand in lots of places without specifying that it really means also the
(alg, dusize), like in "keyslot" and "keyslot manager".

This inconsistency shows up in some other places in the patchset too.

> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> new file mode 100644
> index 000000000000..15dfc0c12c7f
> --- /dev/null
> +++ b/block/keyslot-manager.c
[...]
> +/**
> + * blk_ksm_init() - Initialize a keyslot manager
> + * @ksm: The keyslot_manager to initialize.
> + * @dev: Device for runtime power management (NULL if none)
> + * @num_slots: The number of key slots to manage.
> + *
> + * Allocate memory for keyslots and initialize a keyslot manager. Called by
> + * e.g. storage drivers to set up a keyslot manager in their request_queue.
> + *
> + * Return: 0 on success, or else a negative error code.
> + */
> +int blk_ksm_init(struct keyslot_manager *ksm, struct device *dev,
> +		 unsigned int num_slots)
> +{
> +	unsigned int slot;
> +	unsigned int i;
> +
> +	memset(ksm, 0, sizeof(*ksm));
> +
> +	if (num_slots == 0)
> +		return -EINVAL;
> +
> +	ksm->slots = kvzalloc(sizeof(ksm->slots[0]) * num_slots, GFP_KERNEL);
> +	if (!ksm->slots)
> +		return -ENOMEM;

This should use kvcalloc() so that an integer overflow check is included.

> +
> +	ksm->num_slots = num_slots;
> +	blk_ksm_set_dev(ksm, dev);
> +
> +	init_rwsem(&ksm->lock);
> +
> +	init_waitqueue_head(&ksm->idle_slots_wait_queue);
> +	INIT_LIST_HEAD(&ksm->idle_slots);
> +
> +	for (slot = 0; slot < num_slots; slot++) {
> +		list_add_tail(&ksm->slots[slot].idle_slot_node,
> +			      &ksm->idle_slots);
> +	}
> +
> +	spin_lock_init(&ksm->idle_slots_lock);
> +
> +	ksm->slot_hashtable_size = roundup_pow_of_two(num_slots);
> +	ksm->slot_hashtable = kvmalloc_array(ksm->slot_hashtable_size,
> +					     sizeof(ksm->slot_hashtable[0]),
> +					     GFP_KERNEL);
> +	if (!ksm->slot_hashtable)
> +		goto err_free_ksm;
> +	for (i = 0; i < ksm->slot_hashtable_size; i++)
> +		INIT_HLIST_HEAD(&ksm->slot_hashtable[i]);
> +
> +	return 0;
> +
> +err_free_ksm:
> +	blk_ksm_destroy(ksm);
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_init);

The label should be called 'err_destroy_ksm' now that it's not actually freeing
the memory of the 'struct keyslot_manager' itself.

> +/**
> + * blk_ksm_crypto_mode_supported() - Find out if a crypto_mode/data unit size
> + *				     combination is supported by a ksm.
> + * @ksm: The keyslot manager to check
> + * @crypto_mode: The crypto mode to check for.
> + * @blk_crypto_dun_bytes: The minimum number of bytes needed for specifying DUNs
> + * @data_unit_size: The data_unit_size for the mode.
> + *
> + * Checks for crypto_mode/data unit size support.
> + *
> + * Return: Whether or not this ksm supports the specified crypto_mode/
> + *	   data_unit_size combo.
> + */
> +bool blk_ksm_crypto_mode_supported(struct keyslot_manager *ksm,
> +				   const struct blk_crypto_key *key)
> +{
> +	if (!ksm)
> +		return false;
> +	if (WARN_ON((unsigned int)key->crypto_mode >= BLK_ENCRYPTION_MODE_MAX))
> +		return false;
> +	if (WARN_ON(!is_power_of_2(key->data_unit_size)))
> +		return false;
> +	return (ksm->crypto_modes_supported[key->crypto_mode] &
> +		key->data_unit_size) &&
> +	       (ksm->max_dun_bytes_supported[key->crypto_mode] >=
> +		key->dun_bytes);
> +}

The kerneldoc for this function is outdated now that it was changed to take in a
'struct blk_crypto_key'.

Also, since the crypto_mode and data_unit_size fields of 'struct blk_crypto_key'
are already validated by blk_crypto_init_key(), they don't really need to
validated again here anymore.

> +void blk_ksm_destroy(struct keyslot_manager *ksm)
> +{
> +	if (!ksm)
> +		return;
> +	kvfree(ksm->slot_hashtable);
> +	kvfree(ksm->slots);
> +	memzero_explicit(ksm, sizeof(*ksm));
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_destroy);

In v6 => v7, zeroing the keys was lost.  We need:

	memzero_explicit(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);

> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> new file mode 100644
> index 000000000000..b8d54eca1c0d
> --- /dev/null
> +++ b/include/linux/blk-crypto.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef __LINUX_BLK_CRYPTO_H
> +#define __LINUX_BLK_CRYPTO_H
> +
> +enum blk_crypto_mode_num {
> +	BLK_ENCRYPTION_MODE_INVALID,
> +	BLK_ENCRYPTION_MODE_AES_256_XTS,
> +	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
> +	BLK_ENCRYPTION_MODE_ADIANTUM,
> +	BLK_ENCRYPTION_MODE_MAX,
> +};
> +
> +#define BLK_CRYPTO_MAX_KEY_SIZE		64
> +
> +/**
> + * struct blk_crypto_key - an inline encryption key
> + * @crypto_mode: encryption algorithm this key is for
> + * @data_unit_size: the data unit size for all encryption/decryptions with this
> + *	key.  This is the size in bytes of each individual plaintext and
> + *	ciphertext.  This is always a power of 2.  It might be e.g. the
> + *	filesystem block size or the disk sector size.
> + * @data_unit_size_bits: log2 of data_unit_size
> + * @dun_bytes: the number of bytes of DUN used when using this key

Shouldn't @dun_bytes be:

	the maximum number of bytes of DUN needed when using this key

> +struct keyslot_manager {
> +	unsigned int num_slots;
> +
> +	/*
> +	 * The struct keyslot_mgmt_ll_ops that this keyslot manager will use
> +	 * to perform operations like programming and evicting keys on the
> +	 * device
> +	 */
> +	struct keyslot_mgmt_ll_ops ksm_ll_ops;
> +
> +	/*
> +	 * Array of size BLK_ENCRYPTION_MODE_MAX of bitmasks that represents
> +	 * whether a crypto mode and data unit size are supported. The i'th
> +	 * bit of crypto_mode_supported[crypto_mode] is set iff a data unit
> +	 * size of (1 << i) is supported. We only support data unit sizes
> +	 * that are powers of 2.
> +	 */
> +	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX];
> +	/*
> +	 * Array of size BLK_ENCRYPTION_MODE_MAX. The i'th entry specifies the
> +	 * maximum number of dun bytes supported by the i'th crypto mode.
> +	 */
> +	unsigned int max_dun_bytes_supported[BLK_ENCRYPTION_MODE_MAX];
> +
> +	/* Private data unused by keyslot_manager. */
> +	void *ll_priv_data;
> +
> +#ifdef CONFIG_PM
> +	/* Device for runtime power management (NULL if none) */
> +	struct device *dev;
> +#endif
> +
> +	/* Protects programming and evicting keys from the device */
> +	struct rw_semaphore lock;
> +
> +	/* List of idle slots, with least recently used slot at front */
> +	wait_queue_head_t idle_slots_wait_queue;
> +	struct list_head idle_slots;
> +	spinlock_t idle_slots_lock;
> +
> +	/*
> +	 * Hash table which maps key hashes to keyslots, so that we can find a
> +	 * key's keyslot in O(1) time rather than O(num_slots).  Protected by
> +	 * 'lock'.  A cryptographic hash function is used so that timing attacks
> +	 * can't leak information about the raw keys.
> +	 */
> +	struct hlist_head *slot_hashtable;
> +	unsigned int slot_hashtable_size;
> +
> +	/* Per-keyslot data */
> +	struct keyslot *slots;
> +};

Now that struct keyslot_manager is exposed to everyone, it would be helpful if
the comments and field order made the fields clearly divided into two parts: one
part that's public, and one part that's for keyslot manager use only.

- Eric
