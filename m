Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71264193881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 07:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZGWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 02:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCZGWQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:22:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21A220719;
        Thu, 26 Mar 2020 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585203735;
        bh=K+kHVF/Iujh5T5XgswnV6YpdFz4a2MkXO+R7tqFLY64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xglru3pt3HR7qeGgEGIn6HyiIUPw+zCBOTpQhQEW8n44G3VjtH5VjfEVp6yKixAch
         d6xQM3gmYjB8pZ1AzHNGTqB4RpEyuVrhFGYROivHxnbdIc/2Yq8PBe8YSlggBjIAmI
         I2kVCF5ZhhYnVlOBygbICXk8hrIm4ralc6GrJlEU=
Date:   Wed, 25 Mar 2020 23:22:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 01/11] block: Keyslot Manager for Inline Encryption
Message-ID: <20200326062213.GF858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:06:52PM -0700, Satya Tangirala wrote:
> Inline Encryption hardware allows software to specify an encryption context
> (an encryption key, crypto algorithm, data unit num, data unit size) along
> with a data transfer request to a storage device, and the inline encryption
> hardware will use that context to en/decrypt the data. The inline
> encryption hardware is part of the storage device, and it conceptually sits
> on the data path between system memory and the storage device.
> 
> Inline Encryption hardware implementations often function around the
> concept of "keyslots". These implementations often have a limited number
> of "keyslots", each of which can hold a key (we say that a key can be
> "programmed" into a keyslot). Requests made to the storage device may have
> a keyslot and a data unit number associated with them, and the inline
> encryption hardware will en/decrypt the data in the requests using the key
> programmed into that associated keyslot and the data unit number specified
> with the request.
> 
> As keyslots are limited, and programming keys may be expensive in many
> implementations, and multiple requests may use exactly the same encryption
> contexts, we introduce a Keyslot Manager to efficiently manage keyslots.
> 
> We also introduce a blk_crypto_key, which will represent the key that's
> programmed into keyslots managed by keyslot managers. The keyslot manager
> also functions as the interface that upper layers will use to program keys
> into inline encryption hardware. For more information on the Keyslot
> Manager, refer to documentation found in block/keyslot-manager.c and
> linux/keyslot-manager.h.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Thanks, this patch looks much better now.  I don't see any real issues, but as
usual here are a couple nits I noticed while reading through this latest version
:-)

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
> +int blk_ksm_init(struct blk_keyslot_manager *ksm, unsigned int num_slots)

The @dev parameter was removed, so its kerneldoc should be too.

One tip, you can check the validity of kerneldoc comments by running:

$ ./scripts/kernel-doc -v -none block/keyslot-manager.c
block/keyslot-manager.c:67: info: Scanning doc for blk_ksm_init
block/keyslot-manager.c:78: warning: Excess function parameter 'dev' description in 'blk_ksm_init'
block/keyslot-manager.c:180: info: Scanning doc for blk_ksm_get_slot_for_key
block/keyslot-manager.c:198: warning: Function parameter or member 'slot_ptr' not described in 'blk_ksm_get_slot_for_key'
block/keyslot-manager.c:198: warning: Excess function parameter 'keyslot' description in 'blk_ksm_get_slot_for_key'
block/keyslot-manager.c:258: info: Scanning doc for blk_ksm_put_slot
block/keyslot-manager.c:282: info: Scanning doc for blk_ksm_crypto_key_supported
block/keyslot-manager.c:303: info: Scanning doc for blk_ksm_evict_key
block/keyslot-manager.c:343: info: Scanning doc for blk_ksm_reprogram_all_keys
3 warnings

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
> + *	   allocated keyslot), or some other blk_status_t otherwise (and
> + *	   keyslot is set to NULL).
> + */

It's actually "BLK_STS_OK", not "BLK_STATUS_OK".

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f629d40c645cd..27d460d0a8508 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -43,6 +43,7 @@ struct pr_ops;
>  struct rq_qos;
>  struct blk_queue_stats;
>  struct blk_stat_callback;
> +struct blk_keyslot_manager;
>  
>  #define BLKDEV_MIN_RQ	4
>  #define BLKDEV_MAX_RQ	128	/* Default maximum */
> @@ -474,6 +475,11 @@ struct request_queue {
>  	unsigned int		dma_pad_mask;
>  	unsigned int		dma_alignment;
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	/* Inline crypto capabilities */
> +	struct blk_keyslot_manager *ksm;
> +#endif

I do still wonder whether the concept of inline crypto support should be more
separated from keyslot management, to be better prepared for device-mapper
passthrough support and for hardware that accepts keys directly.  (Such hardware
exists, though I'm not sure support for it will be upstreamed.)  For example,
the crypto capabilities could be stored in a 'struct blk_crypto_capabilities'
rather than in 'struct blk_keyslot_manager', and the latter could be optional.

What you have now is fine for the functionality in the current patchset though,
so I'm not really complaining.  Just something to think about.

- Eric
