Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA9185EEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgCOSYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 14:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgCOSYr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:24:47 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D70206B1;
        Sun, 15 Mar 2020 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584296685;
        bh=uwkopX9avEqJCgFKoEfBqRzTAaUuijjsczsldr5tRRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZZiUmXrUiOiNuZ6ypJR142lt8rbM0AaSd6PYn7F5+ff8kJCBnXRv0WHS4PnXFkTO
         ofguVGFaQlg2BVhuO7pgcGe0//G0q+VIwJdVHdkFApM6wzwzDQjn5/5ohrxgKyFFkF
         1VhqG70iVOYjU5qug4UmtMhdBQpRX/CcsDpjwoO4=
Date:   Sun, 15 Mar 2020 11:24:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 06/11] scsi: ufs: UFS crypto API
Message-ID: <20200315182443.GC1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:48AM -0700, Satya Tangirala wrote:
> Introduce functions to manipulate UFS inline encryption hardware
> in line with the JEDEC UFSHCI v2.1 specification and to work with the
> block keyslot manager.
> 
> The UFS crypto API will assume by default that a vendor driver doesn't
> support UFS crypto, even if the hardware advertises the capability, because
> a lot of hardware requires some special handling that's not specified in
> the aforementioned JEDEC spec. Each vendor driver must explicity set
> hba->caps |= UFSHCD_CAP_CRYPTO before ufshcd_hba_init_crypto is called to
> opt-in to UFS crypto support.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/Kconfig         |   9 +
>  drivers/scsi/ufs/Makefile        |   1 +
>  drivers/scsi/ufs/ufshcd-crypto.c | 370 +++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd-crypto.h |  54 +++++
>  drivers/scsi/ufs/ufshcd.h        |  14 ++
>  5 files changed, 448 insertions(+)
>  create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
>  create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index d14c2243e02a..c69f1b49167b 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -160,3 +160,12 @@ config SCSI_UFS_BSG
>  
>  	  Select this if you need a bsg device node for your UFS controller.
>  	  If unsure, say N.
> +
> +config SCSI_UFS_CRYPTO
> +	bool "UFS Crypto Engine Support"
> +	depends on SCSI_UFSHCD && BLK_INLINE_ENCRYPTION
> +	help
> +	  Enable Crypto Engine Support in UFS.
> +	  Enabling this makes it possible for the kernel to use the crypto
> +	  capabilities of the UFS device (if present) to perform crypto
> +	  operations on data being transferred to/from the device.
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index 94c6c5d7334b..197e178f44bc 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
>  obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>  ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
> +ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO) += ufshcd-crypto.o
>  obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
>  obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
>  obj-$(CONFIG_SCSI_UFS_HISI) += ufs-hisi.o
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> new file mode 100644
> index 000000000000..8b6f7c83f77f
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/keyslot-manager.h>
> +#include "ufshcd.h"
> +#include "ufshcd-crypto.h"

Since keyslot-manager.h now has to be included in ufshcd.h anyway since now
there's a struct keyslot_manager embedded in struct ufs_hba, there's no need to
include keyslot-manager.h here and in ufshcd-crypto.h too.

> +
> +static inline int ufshcd_num_keyslots(struct ufs_hba *hba)
> +{
> +	return hba->crypto_capabilities.config_count + 1;
> +}
> +
> +static inline bool ufshcd_keyslot_valid(struct ufs_hba *hba, unsigned int slot)
> +{
> +	/*
> +	 * The actual number of configurations supported is (CFGC+1), so slot
> +	 * numbers range from 0 to config_count inclusive.
> +	 */
> +	return slot < ufshcd_num_keyslots(hba);
> +}
> +
> +static bool ufshcd_cap_idx_valid(struct ufs_hba *hba, unsigned int cap_idx)
> +{
> +	return cap_idx < hba->crypto_capabilities.num_crypto_cap;
> +}

ufshcd_cap_idx_valid() isn't needed since it's only used to check the return
value of ufshcd_crypto_cap_find().

> +
> +static u8 ufshcd_get_data_unit_size_mask(unsigned int data_unit_size)
> +{
> +	if (data_unit_size < 512 || data_unit_size > 65536 ||
> +	    !is_power_of_2(data_unit_size))
> +		return 0;
> +
> +	return data_unit_size / 512;
> +}

ufshcd_get_data_unit_size_mask() isn't needed since it's only used via
ufshcd_crypto_keyslot_program() which already knows it has a data_unit_size the
driver supports.  So just do 'ufs_data_unit_size = key->data_unit_size / 512'

> +
> +static size_t ufshcd_get_keysize_bytes(enum ufs_crypto_key_size size)
> +{
> +	switch (size) {
> +	case UFS_CRYPTO_KEY_SIZE_128:
> +		return 16;
> +	case UFS_CRYPTO_KEY_SIZE_192:
> +		return 24;
> +	case UFS_CRYPTO_KEY_SIZE_256:
> +		return 32;
> +	case UFS_CRYPTO_KEY_SIZE_512:
> +		return 64;
> +	default:
> +		return 0;
> +	}
> +}

ufshcd_get_keysize_bytes() isn't needed since it's only used via
ufshcd_crypto_keyslot_program() which already has access to key->size.

> +
> +/* Blk-crypto modes supported by UFS crypto */
> +static const struct {
> +	enum ufs_crypto_alg ufs_alg;
> +	enum ufs_crypto_key_size ufs_key_size;
> +	enum blk_crypto_mode_num blk_mode;
> +	bool supported;
> +} ufs_crypto_algs[BLK_ENCRYPTION_MODE_MAX] = {
> +	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
> +		.ufs_alg = UFS_CRYPTO_ALG_AES_XTS,
> +		.ufs_key_size = UFS_CRYPTO_KEY_SIZE_256,
> +		.blk_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
> +		.supported = true,
> +	},
> +};

The '.blk_mode' field is unnecessary since it's the same as the array index.

I was also confused by the '.supported' field and under what circumstances it
would be set to false.  It's actually just used to indicate that the array entry
is used.  That's not necessary since UFS_CRYPTO_KEY_SIZE_INVALID == 0.  (To make
the assumption clear, we can add BUILD_BUG_ON(UFS_CRYPTO_KEY_SIZE_INVALID != 0))

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
> +	if (!ufs_crypto_algs[crypto_mode].supported)
> +		return -EINVAL;
> +
> +	ufs_alg = ufs_crypto_algs[crypto_mode].ufs_alg;
> +	ufs_key_size = ufs_crypto_algs[crypto_mode].ufs_key_size;
> +
> +	data_unit_mask = ufshcd_get_data_unit_size_mask(data_unit_size);
> +
> +	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
> +	     cap_idx++) {
> +		if (ccap_array[cap_idx].algorithm_id == ufs_alg &&
> +		    (ccap_array[cap_idx].sdus_mask & data_unit_mask) &&
> +		    ccap_array[cap_idx].key_size == ufs_key_size)
> +			return cap_idx;
> +	}
> +
> +	return -EINVAL;
> +}

This is only called once.  It would be simpler to just inline it into the
caller.  The ufshcd_hba_is_crypto_supported() and
ufs_crypto_algs[crypto_mode].supported checks are also unnecessary.

> +
> +/**
> + * ufshcd_crypto_cfg_entry_write_key - Write a key into a crypto_cfg_entry
> + *
> + *	Writes the key with the appropriate format - for AES_XTS,
> + *	the first half of the key is copied as is, the second half is
> + *	copied with an offset halfway into the cfg->crypto_key array.
> + *	For the other supported crypto algs, the key is just copied.
> + *
> + * @cfg: The crypto config to write to
> + * @key: The key to write
> + * @cap: The crypto capability (which specifies the crypto alg and key size)
> + *
> + * Returns BLK_STS_OK on success, or BLK_STS_IOERR on error
> + */
> +static blk_status_t ufshcd_crypto_cfg_entry_write_key(
> +						union ufs_crypto_cfg_entry *cfg,
> +						const u8 *key,
> +						union ufs_crypto_cap_entry cap)
> +{
> +	size_t key_size_bytes = ufshcd_get_keysize_bytes(cap.key_size);
> +
> +	if (key_size_bytes == 0)
> +		return BLK_STS_IOERR;
> +
> +	switch (cap.algorithm_id) {
> +	case UFS_CRYPTO_ALG_AES_XTS:
> +		key_size_bytes *= 2;
> +		if (key_size_bytes > UFS_CRYPTO_KEY_MAX_SIZE)
> +			return BLK_STS_IOERR;
> +
> +		memcpy(cfg->crypto_key, key, key_size_bytes/2);
> +		memcpy(cfg->crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
> +		       key + key_size_bytes/2, key_size_bytes/2);
> +		return BLK_STS_OK;
> +	case UFS_CRYPTO_ALG_BITLOCKER_AES_CBC:
> +		/* fall through */
> +	case UFS_CRYPTO_ALG_AES_ECB:
> +		/* fall through */
> +	case UFS_CRYPTO_ALG_ESSIV_AES_CBC:
> +		memcpy(cfg->crypto_key, key, key_size_bytes);
> +		return BLK_STS_OK;
> +	}
> +
> +	return BLK_STS_IOERR;
> +}

Likewise, this is only called once, and the error checks are unnecessary as this
is only called from ufshcd_crypto_keyslot_program() where we know the algorithm
is supported by the UFS driver.  It would be much simpler to just inline this
into the caller.

The switch statement can also be simplified to an 'if', since XTS is the only
algorithm that requires special handling and it's likely to remain that way.
The "two keys" thing is pretty unique to XTS.

> +
> +static void ufshcd_program_key(struct ufs_hba *hba,
> +			       const union ufs_crypto_cfg_entry *cfg,
> +			       int slot)
> +{
> +	int i;
> +	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
> +
> +	ufshcd_hold(hba, false);
> +	/* Ensure that CFGE is cleared before programming the key */
> +	ufshcd_writel(hba, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
> +	for (i = 0; i < 16; i++) {
> +		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
> +			      slot_offset + i * sizeof(cfg->reg_val[0]));
> +	}
> +	/* Write dword 17 */
> +	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
> +		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
> +	/* Dword 16 must be written last */
> +	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
> +		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
> +	ufshcd_release(hba);
> +}
> +
> +static void ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
> +{
> +	union ufs_crypto_cfg_entry cfg = { 0 };
> +
> +	ufshcd_program_key(hba, &cfg, slot);
> +}

It may make sense to move ufshcd_clear_keyslot() to just above
ufshcd_crypto_keyslot_evict(), so that the key eviction code is grouped
together.

> +/* Clear all keyslots at driver init time */
> +static void ufshcd_clear_all_keyslots(struct ufs_hba *hba)
> +{
> +	int slot;
> +
> +	for (slot = 0; slot < ufshcd_num_keyslots(hba); slot++)
> +		ufshcd_clear_keyslot(hba, slot);
> +}

This is only called once.  It would be simpler to just inline it into
ufshcd_hba_init_crypto().

> +static blk_status_t ufshcd_crypto_keyslot_program(struct keyslot_manager *ksm,
> +					const struct blk_crypto_key *key,
> +					unsigned int slot)
> +{
> +	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
> +	blk_status_t err = BLK_STS_OK;
> +	u8 data_unit_mask;
> +	union ufs_crypto_cfg_entry cfg;
> +	int cap_idx;
> +
> +	cap_idx = ufshcd_crypto_cap_find(hba, key->crypto_mode,
> +					 key->data_unit_size);
> +
> +	if (!(hba->caps & UFSHCD_CAP_CRYPTO) ||
> +	    !ufshcd_keyslot_valid(hba, slot) ||
> +	    !ufshcd_cap_idx_valid(hba, cap_idx))
> +		return BLK_STS_IOERR;
> +
> +	data_unit_mask = ufshcd_get_data_unit_size_mask(key->data_unit_size);
> +
> +	if (!(data_unit_mask & hba->crypto_cap_array[cap_idx].sdus_mask))
> +		return BLK_STS_IOERR;
> +
> +	memset(&cfg, 0, sizeof(cfg));
> +	cfg.data_unit_size = data_unit_mask;
> +	cfg.crypto_cap_idx = cap_idx;
> +	cfg.config_enable |= UFS_CRYPTO_CONFIGURATION_ENABLE;
> +
> +	err = ufshcd_crypto_cfg_entry_write_key(&cfg, key->raw,
> +						hba->crypto_cap_array[cap_idx]);
> +	if (err)
> +		return err;
> +
> +	ufshcd_program_key(hba, &cfg, slot);
> +
> +	memzero_explicit(&cfg, sizeof(cfg));
> +	return BLK_STS_OK;
> +}

ufshcd_crypto_keyslot_program() is much more complicated than necessary.  It
calls several functions that are only called once, and could be simplified if
inlined.  It also does lots of checks that are unnecessary because the block
layer already guarantees that it's called with a valid keyslot and a
(crypto_mode, data unit_size) pair the driver supports.

I also don't see any benefit to the change from errno to blk_status_t here.
It's inconsistent with keyslot_evict(), which is going to cause confusion.  It
also doesn't match what blk-crypto-fallback wants.  It seems it would be better
to just have blk_ksm_get_slot_for_key() use errno_to_blk_status() instead.

So how about something like the following:

static int ufshcd_crypto_keyslot_program(struct keyslot_manager *ksm,
					 const struct blk_crypto_key *key,
					 unsigned int slot)
{
	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
	const union ufs_crypto_cap_entry *ccaps = hba->crypto_cap_array;
	const struct ufs_crypto_alg_entry *alg =
		&ufs_crypto_algs[key->crypto_mode];
	unsigned int ufs_data_unit_size = key->data_unit_size / 512;
	int cap_idx;
	union ufs_crypto_cfg_entry cfg = { 0 };

	/* Find the corresponding crypto capability */
	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
	     cap_idx++) {
		if (ccaps[cap_idx].algorithm_id == alg->ufs_alg &&
		    ccaps[cap_idx].key_size == alg->ufs_key_size &&
		    (ccaps[cap_idx].sdus_mask & ufs_data_unit_size))
			break;
	}
	if (WARN_ON(cap_idx == hba->crypto_capabilities.num_crypto_cap))
		return -EOPNOTSUPP;

	if (alg->ufs_alg == UFS_CRYPTO_ALG_AES_XTS) {
		memcpy(cfg.crypto_key, key->raw, key->size / 2);
		memcpy(&cfg.crypto_key[UFS_CRYPTO_KEY_MAX_SIZE / 2],
		       &key->raw[key->size / 2], key->size / 2);
	} else {
		memcpy(cfg.crypto_key, key->raw, key->size);
	}
	cfg.data_unit_size = ufs_data_unit_size;
	cfg.crypto_cap_idx = cap_idx;
	cfg.config_enable = UFS_CRYPTO_CONFIGURATION_ENABLE;

	ufshcd_program_key(hba, &cfg, slot);

	memzero_explicit(&cfg, sizeof(cfg));
	return 0;
}

That does make ufshcd_crypto_keyslot_program() slightly longer, but it
eliminates lots of other functions.  So overall it makes the code much shorter
and easier to understand.

> +static int ufshcd_crypto_keyslot_evict(struct keyslot_manager *ksm,
> +				       const struct blk_crypto_key *key,
> +				       unsigned int slot)
> +{
> +	struct ufs_hba *hba = container_of(ksm, struct ufs_hba, ksm);
> +
> +	if (!(hba->caps & UFSHCD_CAP_CRYPTO) ||
> +	    !ufshcd_keyslot_valid(hba, slot))
> +		return -EINVAL;

Similarly, there's need for these checks, since the block layer ensures this is
only called with a valid keyslot.

> +
> +	/*
> +	 * Clear the crypto cfg on the device. Clearing CFGE
> +	 * might not be sufficient, so just clear the entire cfg.
> +	 */
> +	ufshcd_clear_keyslot(hba, slot);

This comment seems to be in the wrong place.  It should be in
ufshcd_clear_keyslot(), where the cfg is actually initialized to 0.

> +void ufshcd_crypto_enable(struct ufs_hba *hba)
> +{
> +	if (!ufshcd_hba_is_crypto_supported(hba))
> +		return;
> +
> +	hba->caps |= UFSHCD_CAP_CRYPTO;
> +
> +	/* Reset might clear all keys, so reprogram all the keys. */
> +	blk_ksm_reprogram_all_keys(&hba->ksm);
> +}
> +
> +void ufshcd_crypto_disable(struct ufs_hba *hba)
> +{
> +	hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +}

What's the point of setting and clearing UFSHCD_CAP_CRYPTO every time the host
controller is stopped / started?  The block layer already ensures that the host
controller is runtime-resumed before calling any of the keyslot manager
functions.  So the crypto support isn't going to transiently go away.

Also, UFSHCD_CAP_CRYPTO is now the means by which the vendor driver indicates
that crypto is supported.  So what's the point of both
ufshcd_hba_is_crypto_supported() and UFSHCD_CAP_CRYPTO?  Why not just
consistently use UFSHCD_CAP_CRYPTO?

I.e., remove ufshcd_crypto_disable(), and ufshcd_crypto_enable() would be:

void ufshcd_crypto_enable(struct ufs_hba *hba)
{
        /* Reset might clear all keys, so reprogram all the keys. */
        if (hba->caps & UFSHCD_CAP_CRYPTO)
                blk_ksm_reprogram_all_keys(&hba->ksm);
}

ufshcd_hba_init_crypto() would then clear UFSHCD_CAP_CRYPTO if crypto
initialization failed / isn't supported.  ufshcd_hba_init_crypto() would be the
only place that checks the crypto capabilities register.

That all would be much simpler.  Any reason not to do that?

> +static enum blk_crypto_mode_num ufshcd_blk_crypto_mode_num_for_alg_keysize(
> +					enum ufs_crypto_alg ufs_crypto_alg,
> +					enum ufs_crypto_key_size key_size)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ufs_crypto_algs); i++) {
> +		if (ufs_crypto_algs[i].supported &&
> +		    ufs_crypto_algs[i].ufs_alg == ufs_crypto_alg &&
> +		    ufs_crypto_algs[i].ufs_key_size == key_size) {
> +			return ufs_crypto_algs[i].blk_mode;
> +		}
> +	}
> +	return BLK_ENCRYPTION_MODE_INVALID;
> +}

This function name is far too long.  Also, the 'supported' and 'blk_mode' fields
are unnecessary as I mentioned above.  Also, it would be simpler to pass in
'union ufs_crypto_cap_entry'.  So how about:

static enum blk_crypto_mode_num
ufshcd_find_blk_crypto_mode(union ufs_crypto_cap_entry cap)
{
        int i;

        for (i = 0; i < ARRAY_SIZE(ufs_crypto_algs); i++) {
                BUILD_BUG_ON(UFS_CRYPTO_KEY_SIZE_INVALID != 0);
                if (ufs_crypto_algs[i].ufs_alg == cap.algorithm_id &&
                    ufs_crypto_algs[i].ufs_key_size == cap.key_size)
                        return i;
        }
        return BLK_ENCRYPTION_MODE_INVALID;
}

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
> +
> +	/*
> +	 * Return 0 if crypto support isn't present/not advertised by vendor
> +	 * specific driver.
> +	 */
> +	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT) ||
> +	    !(hba->caps & UFSHCD_CAP_CRYPTO))
> +		goto out;

People will be confused by the difference between capabilities and caps.
This comment could use some elaboration, like:

        /*
         * Don't use crypto if either the hardware doesn't advertise the
         * standard crypto capability bit *or* if the vendor specific driver
         * hasn't advertised that crypto is supported.
         */

> +
> +	/*
> +	 * Crypto Capabilities should never be 0, because the
> +	 * config_array_ptr > 04h. So we use a 0 value to indicate that
> +	 * crypto init failed, and can't be enabled.
> +	 */

This comment would become unnecessary if we were to stop using the cached
hardware crypto capabilities register to indicate whether crypto is supported,
but rather just UFSHCD_CAP_CRYPTO -- as I suggested above.

> +	hba->crypto_capabilities.reg_val =
> +			cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
> +	hba->crypto_cfg_register =
> +		(u32)hba->crypto_capabilities.config_array_ptr * 0x100;
> +	hba->crypto_cap_array =
> +		devm_kcalloc(hba->dev,
> +			     hba->crypto_capabilities.num_crypto_cap,
> +			     sizeof(hba->crypto_cap_array[0]),
> +			     GFP_KERNEL);

The arguments to devm_kcalloc() can fit on two lines.

> +	if (!hba->crypto_cap_array) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	err = blk_ksm_init(&hba->ksm, hba->dev, ufshcd_num_keyslots(hba));
> +	if (err)
> +		goto out_free_caps;

If the unnecessary checks are removed from other places in this file, this would
be the only remaining caller of ufshcd_num_keyslots(), which could then be
removed and the comment about the off-by-one quirk could be moved to here:

        /* The actual number of configurations supported is (CFGC+1) */
        num_keyslots = hba->crypto_capabilities.config_count + 1;

	err = blk_ksm_init(&hba->ksm, hba->dev, num_keyslots);

	...


        /* Clear all keyslots at driver init time */
        for (slot = 0; slot < num_keyslots; slot++)
                ufshcd_clear_keyslot(hba, slot);

> +
> +	hba->ksm.ksm_ll_ops = ufshcd_ksm_ops;
> +	/* UFS only supports 8 bytes for any DUN */
> +	hba->ksm.max_dun_bytes_supported = 8;
> +
> +	/*
> +	 * Store all the capabilities and fill up the keyslot manager's
> +	 * supported crypto modes.
> +	 */

"fill up the keyslot manager's supported crypto modes" is what the code does,
but in comments it's better to describe the goal at a higher level, like

        /*
         * Cache all the UFS crypto capabilities and advertise the supported
         * crypto modes and data unit sizes to the block layer.
         */

> +	for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
> +	     cap_idx++) {
> +		hba->crypto_cap_array[cap_idx].reg_val =
> +			cpu_to_le32(ufshcd_readl(hba,
> +						 REG_UFS_CRYPTOCAP +
> +						 cap_idx * sizeof(__le32)));
> +		blk_mode_num = ufshcd_blk_crypto_mode_num_for_alg_keysize(
> +				hba->crypto_cap_array[cap_idx].algorithm_id,
> +				hba->crypto_cap_array[cap_idx].key_size);

As I mentioned above, this could simply pass the capability directly.

> +		if (blk_mode_num != BLK_ENCRYPTION_MODE_INVALID)
> +			hba->ksm.crypto_modes_supported[blk_mode_num] |=
> +				hba->crypto_cap_array[cap_idx].sdus_mask * 512;
> +	}
> +
> +	ufshcd_clear_all_keyslots(hba);
> +
> +	return 0;
> +
> +out_free_caps:
> +	devm_kfree(hba->dev, hba->crypto_cap_array);
> +out:
> +	/* Indicate that init failed by setting crypto_capabilities to 0 */
> +	hba->crypto_capabilities.reg_val = 0;
> +	return err;
> +}

As I mentioned above, why not clear UFSHCD_CAP_CRYPTO here instead of
crypto_capabilities, and use UFSHCD_CAP_CRYPTO consistently everywhere?

> +
> +void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
> +					    struct request_queue *q)
> +{
> +	if (!ufshcd_hba_is_crypto_supported(hba) || !q)
> +		return;
> +
> +	blk_ksm_register(&hba->ksm, q);
> +}
> +
> +void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
> +{
> +	blk_ksm_destroy(&hba->ksm);
> +}

q can't be NULL here.

> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 978781c538c4..ee37dd44d5e6 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -55,6 +55,7 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/keyslot-manager.h>
>  #include "unipro.h"
>  
>  #include <asm/irq.h>
> @@ -521,6 +522,10 @@ struct ufs_stats {
>   * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
>   *  device is known or not.
>   * @scsi_block_reqs_cnt: reference counting for scsi block requests
> + * @crypto_capabilities: Content of crypto capabilities register (0x100)
> + * @crypto_cap_array: Array of crypto capabilities
> + * @crypto_cfg_register: Start of the crypto cfg array
> + * @ksm: the keyslot manager tied to this hba
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -634,6 +639,7 @@ struct ufs_hba {
>  	 * enabled via HCE register.
>  	 */
>  	#define UFSHCI_QUIRK_BROKEN_HCE				0x400
> +
>  	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */

Unnecessary whitespace change.

>  
>  	/* Device deviations from standard UFS device spec. */
> @@ -735,6 +741,14 @@ struct ufs_hba {
>  
>  	struct device		bsg_dev;
>  	struct request_queue	*bsg_queue;
> +
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +	/* crypto */
> +	union ufs_crypto_capabilities crypto_capabilities;
> +	union ufs_crypto_cap_entry *crypto_cap_array;
> +	u32 crypto_cfg_register;
> +	struct keyslot_manager ksm;
> +#endif /* CONFIG_SCSI_UFS_CRYPTO */

These two comments don't really add anything.  It's already obviously "crypto"
fields based on the #ifdef and variable names.  And a 4 line #ifdef isn't long
enough for a comment on the #endif to be helpful.

- Eric
