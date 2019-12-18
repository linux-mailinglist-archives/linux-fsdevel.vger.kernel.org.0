Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA491252E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 21:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRUNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 15:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLRUNh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:13:37 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190D72176D;
        Wed, 18 Dec 2019 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576700015;
        bh=UMmD5Z5ygH9aVGZDCv0TmAgy4F+Uw50SpSAzO3KWdWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbjIZjZiaO/pegR8UQwIlCL+CIc0+MOpHINMa6Wa4XC7CpM10gILJCfLd78ffIIU/
         4MDsuaJ1sOmbJou6wzefCczQtvBOCDftxK3nH5Qq+4/htt5t0TPTY2emEjareiijLb
         KPiqBjfQ10vuK0cXSKCh74afokCgwFJp3dhC23cc=
Date:   Wed, 18 Dec 2019 12:13:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20191218201333.GA47399@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-2-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:28AM -0800, Satya Tangirala wrote:
> Inline Encryption hardware allows software to specify an encryption context
> (an encryption key, crypto algorithm, data unit num, data unit size, etc.)

These four things (key, algorithm, DUN, and data unit size) fully specify the
crypto that is done.  So the use of "etc." is a bit misleading.

> along with a data transfer request to a storage device, and the inline
> encryption hardware will use that context to en/decrypt the data. The
> inline encryption hardware is part of the storage device, and it
> conceptually sits on the data path between system memory and the storage
> device.
> 
> Inline Encryption hardware implementations often function around the
> concept of "keyslots". These implementations often have a limited number
> of "keyslots", each of which can hold an encryption context (we say that
> an encryption context can be "programmed" into a keyslot). Requests made
> to the storage device may have a keyslot associated with them, and the
> inline encryption hardware will en/decrypt the data in the requests using
> the encryption context programmed into that associated keyslot. As
> keyslots are limited, and programming keys may be expensive in many
> implementations, and multiple requests may use exactly the same encryption
> contexts, we introduce a Keyslot Manager to efficiently manage keyslots.
> We also introduce a blk_crypto_key, which will represent the key that's
> programmed into keyslots managed by keyslot managers. The keyslot manager
> also functions as the interface that upper layers will use to program keys
> into inline encryption hardware. For more information on the Keyslot
> Manager, refer to documentation found in block/keyslot-manager.c and
> linux/keyslot-manager.h.

Long paragraphs are hard to read.  Maybe split this into multiple paragraphs.

> +/**
> + * keyslot_manager_crypto_mode_supported() - Find out if a crypto_mode/data
> + *					     unit size combination is supported
> + *					     by a ksm.
> + * @ksm: The keyslot manager to check
> + * @crypto_mode: The crypto mode to check for.
> + * @data_unit_size: The data_unit_size for the mode.
> + *
> + * Calls and returns the result of the crypto_mode_supported function specified
> + * by the ksm.
> + *
> + * Context: Process context.
> + * Return: Whether or not this ksm supports the specified crypto_mode/
> + *	   data_unit_size combo.
> + */
> +bool keyslot_manager_crypto_mode_supported(struct keyslot_manager *ksm,
> +					   enum blk_crypto_mode_num crypto_mode,
> +					   unsigned int data_unit_size)
> +{
> +	if (!ksm)
> +		return false;
> +	if (WARN_ON(crypto_mode >= BLK_ENCRYPTION_MODE_MAX))
> +		return false;
> +	if (WARN_ON(!is_power_of_2(data_unit_size)))
> +		return false;
> +	return ksm->crypto_mode_supported[crypto_mode] & data_unit_size;
> +}

There's no crypto_mode_supported() function anymore, so the comment above this
function is outdated, including both the part that mentions
crypto_mode_supported() and the part that says "Process context".

Also, since C enums are signed, and there's already a check for invalid
crypto_mode, it might be a good idea to catch crypto_mode < 0 too:

	if (WARN_ON((unsigned int)crypto_mode >= BLK_ENCRYPTION_MODE_MAX))

> +/**
> + * keyslot_manager_evict_key() - Evict a key from the lower layer device.
> + * @ksm: The keyslot manager to evict from
> + * @key: The key to evict
> + *
> + * Find the keyslot that the specified key was programmed into, and evict that
> + * slot from the lower layer device if that slot is not currently in use.
> + *
> + * Context: Process context. Takes and releases ksm->lock.
> + * Return: 0 on success, -EBUSY if the key is still in use, or another
> + *	   -errno value on other error.
> + */
> +int keyslot_manager_evict_key(struct keyslot_manager *ksm,
> +			      const struct blk_crypto_key *key)
> +{
> +	int slot;
> +	int err;
> +	struct keyslot *slotp;
> +
> +	down_write(&ksm->lock);
> +	slot = find_keyslot(ksm, key);
> +	if (slot < 0) {
> +		err = slot;
> +		goto out_unlock;
> +	}

I think this function should return 0 (rather than fail with -ENOKEY) if the key
is not currently programmed into a keyslot.  Otherwise anyone who wants to print
a warning if key eviction failed will have to ignore the -ENOKEY error.

(Note that this change would require an small update to the function comment.)

- Eric
