Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83B1D1BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbgEMQ7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgEMQ7b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:59:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B515D2065D;
        Wed, 13 May 2020 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589389171;
        bh=0HQMOP0BpZgRgfro5Mx19xoVjR8i8Cp7hfF6JzMVoQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZSBuSCStcxLjCAB+/NCz5XuRjsEymEMhj0DzbMcXIZPg17N6m+05ljS1tpC2ZXSQ
         G7iMU/eF/ZGy+rh2C52IJnRrN+DEtntzxsiAtuUR+BQZisarEi9iOZ2ucnojqr23J8
         jelKPJj+XrbsiCkUqvAWLI+FTzNCHmr38Z5DdSuI=
Date:   Wed, 13 May 2020 09:59:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 02/12] block: Keyslot Manager for Inline Encryption
Message-ID: <20200513165928.GB1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:49AM +0000, Satya Tangirala wrote:
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

Looks good.  This already has my Co-developed-by, but if needed you can also add

    Reviewed-by: Eric Biggers <ebiggers@google.com>

A couple comments below for when you resend:

> +++ b/block/keyslot-manager.c
> @@ -0,0 +1,378 @@
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

"are limited" => "is limited".

> +/**
> + * struct blk_crypto_key - an inline encryption key
> + * @crypto_cfg: the crypto configuration (like crypto_mode, key size) for this
> + *		key
> + * @data_unit_size_bits: log2 of data_unit_size
> + * @size: size of this key in bytes (determined by @crypto_cfg.crypto_mode)
> + * @raw: the raw bytes of this key.  Only the first @size bytes are used.
> + *
> + * A blk_crypto_key is immutable once created, and many bios can reference it at
> + * the same time.  It must not be freed until all bios using it have completed.
> + */

Since eviction is now mandatory, the last sentence should be something like:

"It must not be freed until all bios using it have completed and it has been
evicted from all devices on which it may have been used."

- Eric
