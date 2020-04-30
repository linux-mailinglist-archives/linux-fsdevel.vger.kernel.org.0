Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192CE1BF07B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD3GqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 02:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3GqY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:46:24 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B66C8214D8;
        Thu, 30 Apr 2020 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588229183;
        bh=S8VnrcC8lJzFcPUaXFPCvyn46mx7gp2QMp+KtHDb6+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnHSkbJzWg0a+1u5u9ySsA8JJGJo6Pq7XgC03hxGia+a3xwYv0092zLFCF3QnpAmA
         R4z1iy7z2j2vd4IB8SXqek9ackjWIhsx9Xkdt4njmPINY3adLhUHAJbz5HoRzHDybp
         vR9e01b8EZprxcbpv7WK50etU4yWaGtZxHT7uueg=
Date:   Wed, 29 Apr 2020 23:46:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v11 02/12] block: Keyslot Manager for Inline Encryption
Message-ID: <20200430064621.GA16238@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
 <20200429072121.50094-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few very minor comments:

On Wed, Apr 29, 2020 at 07:21:11AM +0000, Satya Tangirala wrote:
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> new file mode 100644
> index 0000000000000..b584723b392ad
> --- /dev/null
> +++ b/block/keyslot-manager.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +/**
> + * DOC: The Keyslot Manager
> + *
> + * Many devices with inline encryption support have a limited number of "slots"
> + * into which encryption contexts may be programmed, and requests can be tagged
> + * with a slot number to specify the key to use for en/decryption.
> + *
> + * As the number of slots are limited, and programming keys is expensive on
> + * many inline encryption hardware, we don't want to program the same key into
> + * multiple slots - if multiple requests are using the same key, we want to
> + * program just one slot with that key and use that slot for all requests.
> + *
> + * The keyslot manager manages these keyslots appropriately, and also acts as
> + * an abstraction between the inline encryption hardware and the upper layers.
> + *
> + * Lower layer devices will set up a keyslot manager in their request queue
> + * and tell it how to perform device specific operations like programming/
> + * evicting keys from keyslots.
> + *
> + * Upper layers will call blk_ksm_get_slot_for_key() to program a
> + * key into some slot in the inline encryption hardware.
> + */
> +#include <crypto/algapi.h>

Now that this file doesn't use crypto_memneq(), the include of <crypto/algapi.h>
can be removed.

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
> + * Return: BLK_STS_OK on success (and keyslot is set to the pointer of the
> + *	   allocated keyslot), or some other blk_status_t otherwise (and
> + *	   keyslot is set to NULL).
> + */
> +blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
> +				      const struct blk_crypto_key *key,
> +				      struct blk_ksm_keyslot **slot_ptr)

The comment should say @slot_ptr, not @keyslot.  You can find kerneldoc warnings
using 'scripts/kernel-doc -v -none $file'.

> +/**
> + * blk_ksm_crypto_cfg_supported() - Find out if the crypto_mode, dusize, dun
> + *				    bytes of a crypto_config are supported by a
> + *				    ksm.

IMO, shorten this a bit to something like "Find out if a crypto configuration is
supported by a ksm", so that less of the comment becomes outdated when someone
adds a new field.

> + * @ksm: The keyslot manager to check
> + * @cfg: The crypto configuration to check for.
> + *
> + * Checks for crypto_mode/data unit size/dun bytes support.
> + *
> + * Return: Whether or not this ksm supports the specified crypto key.

"config", not "key".

- Eric
