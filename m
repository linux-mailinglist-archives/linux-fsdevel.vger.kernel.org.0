Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12310448CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfFMRLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfFMRLR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:11:17 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF022063F;
        Thu, 13 Jun 2019 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560445875;
        bh=FBWMxYgWxiNu6570dn7YwBKk4jtYzSoOQbyjngxdWio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onyQ0TF6UDHFdLqBxVbYoaq8Vmetqt3XjxdkKH0dS0Gl8rOx6CanWFVNqTD5fhlPW
         CmhHjh0De9XgMRHLmahJfqiLW0NbrhZWZXtRyjPTdqDxYTvTI0JiEhV0DUFGfC4ypv
         Ebrd89F9zTt1JacElWfJJLosLuVPvJO62FCNDpVc=
Date:   Thu, 13 Jun 2019 10:11:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 5/8] scsi: ufs: UFS crypto API
Message-ID: <20190613171113.GB686@sol.localdomain>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605232837.31545-6-satyat@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, Jun 05, 2019 at 04:28:34PM -0700, Satya Tangirala wrote:
> Introduce functions to manipulate UFS inline encryption hardware
> in line with the JEDEC UFSHCI v2.1 specification and to work with the
> block keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/Kconfig         |  10 +
>  drivers/scsi/ufs/Makefile        |   1 +
>  drivers/scsi/ufs/ufshcd-crypto.c | 438 +++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd-crypto.h |  69 +++++
>  4 files changed, 518 insertions(+)
>  create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
>  create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
> 

There is a build error after this patch because it adds code that uses the
crypto fields in struct ufs_hba, but those aren't added until the next patch.

It needs to be possible to compile a working kernel after each patch.
Otherwise it breaks bisection.

So, perhaps add the fields in this patch instead.

> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <crypto/algapi.h>
> +
> +#include "ufshcd.h"
> +#include "ufshcd-crypto.h"
> +
> +bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
> +{
> +	return hba->crypto_capabilities.reg_val != 0;
> +}
> +
> +bool ufshcd_is_crypto_enabled(struct ufs_hba *hba)
> +{
> +	return hba->caps & UFSHCD_CAP_CRYPTO;
> +}
> +
> +static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
> +{
> +	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
> +}
> +
> +#define NUM_KEYSLOTS(hba) (hba->crypto_capabilities.config_count + 1)
> +
> +bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
> +{
> +	/*
> +	 * The actual number of configurations supported is (CFGC+1), so slot
> +	 * numbers range from 0 to config_count inclusive.
> +	 */
> +	return slot < NUM_KEYSLOTS(hba);
> +}

Since ufshcd_hba_is_crypto_supported(), ufshcd_is_crypto_enabled(), and
ufshcd_keyslot_valid() are one-liners, don't access any private structures, and
are used outside this file including on the command submission path, how about
making them inline functions in ufshcd-crypto.h?

> +
> +static int ufshcd_crypto_alg_find(void *hba_p,
> +			   enum blk_crypt_mode_num crypt_mode,
> +			   unsigned int data_unit_size)
> +{

Now that the concept of "crypto alg IDs" is gone, rename this to
ufshcd_crypto_cap_find() and rename the crypto_alg_id variables to cap_idx.

This would make it consistent with using cap_idx elsewhere in the code and avoid
confusion with ufs_crypto_cap_entry::algorithm_id.

> +
> +static int ufshcd_crypto_keyslot_program(void *hba_p, const u8 *key,
> +					 enum blk_crypt_mode_num crypt_mode,
> +					 unsigned int data_unit_size,
> +					 unsigned int slot)
> +{
> +	struct ufs_hba *hba = hba_p;
> +	int err = 0;
> +	u8 data_unit_mask;
> +	union ufs_crypto_cfg_entry cfg;
> +	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
> +	int crypto_alg_id;
> +
> +	crypto_alg_id = ufshcd_crypto_alg_find(hba_p, crypt_mode,
> +					       data_unit_size);
> +
> +	if (!ufshcd_is_crypto_enabled(hba) ||
> +	    !ufshcd_keyslot_valid(hba, slot) ||
> +	    !ufshcd_cap_idx_valid(hba, crypto_alg_id))
> +		return -EINVAL;
> +
> +	data_unit_mask = get_data_unit_size_mask(data_unit_size);
> +
> +	if (!(data_unit_mask &
> +	      hba->crypto_cap_array[crypto_alg_id].sdus_mask))
> +		return -EINVAL;

Nit: the 'if' expression with data_unit_mask fits on one line.

> +static int ufshcd_crypto_keyslot_find(void *hba_p,
> +				      const u8 *key,
> +				      enum blk_crypt_mode_num crypt_mode,
> +				      unsigned int data_unit_size)
> +{
> +	struct ufs_hba *hba = hba_p;
> +	int err = 0;
> +	int slot;
> +	u8 data_unit_mask;
> +	union ufs_crypto_cfg_entry cfg;
> +	union ufs_crypto_cfg_entry *cfg_arr = hba->crypto_cfgs;
> +	int crypto_alg_id;
> +
> +	crypto_alg_id = ufshcd_crypto_alg_find(hba_p, crypt_mode,
> +					       data_unit_size);
> +
> +	if (!ufshcd_is_crypto_enabled(hba) ||
> +	    !ufshcd_cap_idx_valid(hba, crypto_alg_id))
> +		return -EINVAL;
> +
> +	data_unit_mask = get_data_unit_size_mask(data_unit_size);
> +
> +	if (!(data_unit_mask &
> +	      hba->crypto_cap_array[crypto_alg_id].sdus_mask))
> +		return -EINVAL;

Same here.

> +	for (slot = 0; slot < NUM_KEYSLOTS(hba); slot++) {
> +		if ((cfg_arr[slot].config_enable &
> +		     UFS_CRYPTO_CONFIGURATION_ENABLE) &&
> +		    data_unit_mask == cfg_arr[slot].data_unit_size &&
> +		    crypto_alg_id == cfg_arr[slot].crypto_cap_idx &&
> +		    crypto_memneq(&cfg.crypto_key, cfg_arr[slot].crypto_key,
> +				  UFS_CRYPTO_KEY_MAX_SIZE) == 0) {
> +			memzero_explicit(&cfg, sizeof(cfg));
> +			return slot;
> +		}
> +	}

Nit: as I've mentioned before, I think !crypto_memneq() is easier to read than
'crypto_memneq() == 0'.

> +	hba->crypto_cap_array =
> +		devm_kcalloc(hba->dev,
> +			     hba->crypto_capabilities.num_crypto_cap,
> +			     sizeof(hba->crypto_cap_array[0]),
> +			     GFP_KERNEL);
> +	if (!hba->crypto_cap_array) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	hba->crypto_cfgs =
> +		devm_kcalloc(hba->dev,
> +			     hba->crypto_capabilities.config_count + 1,
> +			     sizeof(union ufs_crypto_cfg_entry),
> +			     GFP_KERNEL);
> +	if (!hba->crypto_cfgs) {
> +		err = -ENOMEM;
> +		goto out_cfg_mem;
> +	}

Nit: use 'sizeof(hba->crypto_cfgs[0])' rather than 'sizeof(union
ufs_crypto_cfg_entry)', for consistency with the other array allocation.

Thanks,

- Eric
