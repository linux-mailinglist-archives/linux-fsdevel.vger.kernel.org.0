Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88126168C6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 05:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBVE7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 23:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgBVE7m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 23:59:42 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3CE208C4;
        Sat, 22 Feb 2020 04:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582347581;
        bh=jdJmeQHWfLzP8iz4Tg3BFePEIfcyOXGqPSQppwKYUwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0HvI0crrpMhLs1nOWpn7ktNXLBProFVDGFa0wVWZuVo1gjW+5QBddmI96dXgFhxN
         rEuxK240Ae6MPYrnjIXaj0GJotk49aI+loEDIQ2lTYmrBXGaFRhEeIv6gWE+d6aa1x
         NmUalpfEJEEU2QAV4KffW/alTYtb+icN8cdA8YPY=
Date:   Fri, 21 Feb 2020 20:59:39 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 5/9] scsi: ufs: UFS crypto API
Message-ID: <20200222045939.GA848@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-6-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:46AM -0800, Satya Tangirala wrote:
> +static int ufshcd_crypto_cap_find(struct ufs_hba *hba,
> +				  enum blk_crypto_mode_num crypto_mode,
> +				  unsigned int data_unit_size)
> +{
> +	enum ufs_crypto_alg ufs_alg;
> +	u8 data_unit_mask;
> +	int cap_idx;
> +	enum ufs_crypto_key_size ufs_key_size;
> +	union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
> +
> +	if (!ufshcd_hba_is_crypto_supported(hba))
> +		return -EINVAL;
> +
> +	switch (crypto_mode) {
> +	case BLK_ENCRYPTION_MODE_AES_256_XTS:
> +		ufs_alg = UFS_CRYPTO_ALG_AES_XTS;
> +		ufs_key_size = UFS_CRYPTO_KEY_SIZE_256;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
[...]
> +bool ufshcd_blk_crypto_mode_num_for_alg_dusize(
> +					enum ufs_crypto_alg ufs_crypto_alg,
> +					enum ufs_crypto_key_size key_size,
> +					enum blk_crypto_mode_num *blk_mode_num,
> +					unsigned int *max_dun_bytes_supported)
> +{
> +	/*
> +	 * This is currently the only mode that UFS and blk-crypto both support.
> +	 */
> +	if (ufs_crypto_alg == UFS_CRYPTO_ALG_AES_XTS &&
> +	    key_size == UFS_CRYPTO_KEY_SIZE_256) {
> +		*blk_mode_num = BLK_ENCRYPTION_MODE_AES_256_XTS;
> +		*max_dun_bytes_supported = 8;
> +		return true;
> +	}
> +
> +	return false;
> +}

In UFS, max_dun_bytes_supported is always 8 because it's a property of how the
DUN is conveyed in the UFS standard, not specific to the crypto algorithm.  So,
ufshcd_hba_init_crypto() should just set to 8, and there's no need for this code
that pretends like it could be a per-algorithm thing.

Also, perhaps ufshcd_crypto_cap_find() and this would be better served by a
table that maps between the different conventions for representing the
algorithms?  For now it would just have one entry:

	static const struct {
		enum ufs_crypto_alg ufs_alg;
		enum ufs_crypto_key_size ufs_key_size;
		enum blk_crypto_mode_num blk_mode;
	} ufs_crypto_algs[] = {
		{
			.ufs_alg = UFS_CRYPTO_ALG_AES_XTS,
			.ufs_key_size = UFS_CRYPTO_KEY_SIZE_256, 
			.blk_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
		},
	};      

But then it would be super easy to add another entry later.

I think the only reason not to do that is if we didn't expect any more
algorithms to be added later.  But in that case it would be simpler to remove
ufshcd_blk_crypto_mode_num_for_alg_dusize() and just hard-code AES-256-XTS, and
likewise make ufshcd_crypto_cap_find() use 'if' instead of 'switch'.

(Note that ufshcd_blk_crypto_mode_num_for_alg_dusize() is also misnamed, as it
doesn't have anything to do with the data unit size. And it should be 'static'.)

> +
> +/**
> + * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
> + * @hba: Per adapter instance
> + *
> + * Return: 0 if crypto was initialized or is not supported, else a -errno value.
> + */
> +int ufshcd_hba_init_crypto(struct ufs_hba *hba)
> +{
> +	int cap_idx = 0;
> +	int err = 0;
> +	enum blk_crypto_mode_num blk_mode_num;
> +	unsigned int max_dun_bytes;
> +
> +	/* Default to disabling crypto */
> +	hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +
> +	/* Return 0 if crypto support isn't present */
> +	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
> +	    (hba->quirks & UFSHCD_QUIRK_BROKEN_CRYPTO))
> +		goto out;
> +
> +	/*
> +	 * Crypto Capabilities should never be 0, because the
> +	 * config_array_ptr > 04h. So we use a 0 value to indicate that
> +	 * crypto init failed, and can't be enabled.
> +	 */
> +	hba->crypto_capabilities.reg_val =
> +			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
> +	hba->crypto_cfg_register =
> +		(u32)hba->crypto_capabilities.config_array_ptr * 0x100;
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
> +	err = blk_ksm_init(&hba->ksm, hba->dev, ufshcd_num_keyslots(hba));
> +	if (err)
> +		goto out_free_caps;
> +
> +	hba->ksm.ksm_ll_ops = ufshcd_ksm_ops;
> +	hba->ksm.ll_priv_data = hba;

ll_priv_data isn't used anymore, so it should be removed.

> +
> +	memset(hba->ksm.crypto_modes_supported, 0,
> +	       sizeof(hba->ksm.crypto_modes_supported));
> +	memset(hba->ksm.max_dun_bytes_supported, 0,
> +	       sizeof(hba->ksm.max_dun_bytes_supported));

No need to zero these arrays here, since it's already done by blk_ksm_init().

> +	/*
> +	 * Store all the capabilities now so that we don't need to repeatedly
> +	 * access the device each time we want to know its capabilities
> +	 */

This comment is a bit misleading now, since now this loop also initializes the
crypto_modes_supported array, which is *required* and not just a performance
optimization.

- Eric
