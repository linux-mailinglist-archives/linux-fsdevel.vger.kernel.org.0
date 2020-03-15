Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4A185FAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgCOUIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 16:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgCOUIO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:08:14 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C74205ED;
        Sun, 15 Mar 2020 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584302893;
        bh=Ssco+4pYgONTp7ZfvK/vN+7ZlC1WiXKRne2NNmGbtQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hH61wGGIGKVQt6EL/9yLCEnVMdsS+NOazSWI2H+vsUtBwE50LoD1PA94Obfxgrsnf
         gmMOiqVAiAPeCHnMbuV/HDOOmgiSwBIQCXHapF7wcySwtq2KTjl/7HSkQ6l4Zr5k8K
         Dbfgmh+pFI+RffVdf88RUmuEHZC45BNTwDZ82p8Q=
Date:   Sun, 15 Mar 2020 13:08:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 01/11] block: Keyslot Manager for Inline Encryption
Message-ID: <20200315200811.GG1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:43AM -0700, Satya Tangirala wrote:
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
> +	ksm->slots = kvcalloc(num_slots, sizeof(ksm->slots[0]), GFP_KERNEL);
> +	if (!ksm->slots)
> +		return -ENOMEM;
> +
> +	ksm->num_slots = num_slots;
> +	ksm->dev = dev;

Seems that now that keyslot_manager::dev is an unconditional field and callers
initialize other fields of the keyslot_manager, the 'dev' parameter should be
removed from blk_ksm_init() and the caller should be responsible for setting
'dev' if they need runtime power management.

> +/**
> + * blk_ksm_get_slot_for_key() - Program a key into a keyslot.
> + * @ksm: The keyslot manager to program the key into.
> + * @key: Pointer to the key object to program, including the raw key, crypto
> + *	 mode, and data unit size.
> + * @keyslot: A pointer to return the pointer of the allocated keyslot.
> + *
> + * Get a keyslot that's been programmed with the specified key.  If one already
> + * exists, return it with incremented refcount.  Otherwise, wait for a keyslot
> + * to become idle and program it.
> + *
> + * Context: Process context. Takes and releases ksm->lock.
> + * Return: BLK_STATUS_OK on success (and keyslot is set to the pointer of the
> + *	   allocated keyslot), and BLK_STATUS_IOERR otherwise (and keyslot is
> + *	   set to NULL).
> + */

There can be other errors besides BLK_STATUS_IOERR returned.

> +/**
> + * blk_ksm_put_slot() - Release a reference to a slot
> + * @slot: The keyslot to release the reference of.
> + *
> + * Context: Any context.
> + */
> +void blk_ksm_put_slot(struct blk_ksm_keyslot *slot)
> +{
> +	struct keyslot_manager *ksm = slot->ksm;
> +	unsigned long flags;
> +
> +	if (!slot)
> +		return;
> +
> +	if (atomic_dec_and_lock_irqsave(&slot->slot_refs,
> +					&ksm->idle_slots_lock, flags)) {
> +		list_add_tail(&slot->idle_slot_node,
> +			      &ksm->idle_slots);

Nit: the arguments to list_add_tail() fit on one line

> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> new file mode 100644
> index 000000000000..7f88ed02faee
> --- /dev/null
> +++ b/include/linux/keyslot-manager.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef __LINUX_KEYSLOT_MANAGER_H
> +#define __LINUX_KEYSLOT_MANAGER_H
> +
> +#include <linux/bio.h>
> +#include <linux/blk-crypto.h>
> +
> +struct keyslot_manager;
> +
> +/**
> + * struct keyslot_mgmt_ll_ops - functions to manage keyslots in hardware
> + * @keyslot_program:	Program the specified key into the specified slot in the
> + *			inline encryption hardware.
> + * @keyslot_evict:	Evict key from the specified keyslot in the hardware.
> + *			The key is provided so that e.g. dm layers can evict
> + *			keys from the devices that they map over.
> + *			Returns 0 on success, -errno otherwise.
> + *
> + * This structure should be provided by storage device drivers when they set up
> + * a keyslot manager - this structure holds the function ptrs that the keyslot
> + * manager will use to manipulate keyslots in the hardware.
> + */
> +struct keyslot_mgmt_ll_ops {
> +	blk_status_t (*keyslot_program)(struct keyslot_manager *ksm,
> +					const struct blk_crypto_key *key,
> +					unsigned int slot);
> +	int (*keyslot_evict)(struct keyslot_manager *ksm,
> +			     const struct blk_crypto_key *key,
> +			     unsigned int slot);
> +};

As I mentioned on one of the UFS patches, I'm not sure it's better to make
keyslot_program return blk_status_t rather than errno as it did before.
blk_ksm_get_slot_for_key() could just do the translation to blk_status_t.

> +struct keyslot_manager {

Now that the "blk_" prefix has been added to all the functions, perhaps the
actual struct should be renamed to "blk_keyslot_manager" too?
And likewise "blk_keyslot_mgmt_ll_ops".
