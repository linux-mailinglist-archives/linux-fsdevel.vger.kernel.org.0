Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66FB9F6DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 01:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfH0XZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 19:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH0XZz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:25:55 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B093420856;
        Tue, 27 Aug 2019 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948354;
        bh=kMH6BdnXJ0P1hQ2TM0m1VxKP+jJ+UNc7nQOh8WbQ5Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzp493DGyrg1ykv7936i4fHAp9VPTqGr0lZM0f0hRIYmEY0Z0zFg/lz3/M2PXMOQh
         rllvYtJgcYjLzn+R5A7WBLebZR2yHRqIsRwDkBvrrwnwBG153NKuWW3w+i6Y+XYfzB
         G+W8UaZo4Jo98QfQkpkewv8SrDB/kJ1eUppmFsj4=
Date:   Tue, 27 Aug 2019 16:25:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v4 5/8] scsi: ufs: UFS crypto API
Message-ID: <20190827232550.GA92220@gmail.com>
Mail-Followup-To: Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
References: <20190821075714.65140-1-satyat@google.com>
 <20190821075714.65140-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821075714.65140-6-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:57:11AM -0700, Satya Tangirala wrote:
> +static int ufshcd_crypto_cap_find(void *hba_p,
> +			   enum blk_crypto_mode_num crypto_mode,
> +			   unsigned int data_unit_size)
> +{
> +	struct ufs_hba *hba = hba_p;
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
> +	/*
> +	 * case BLK_CRYPTO_ALG_BITLOCKER_AES_CBC:
> +	 *	ufs_alg = UFS_CRYPTO_ALG_BITLOCKER_AES_CBC;
> +	 *	break;
> +	 * case BLK_CRYPTO_ALG_AES_ECB:
> +	 *	ufs_alg = UFS_CRYPTO_ALG_AES_ECB;
> +	 *	break;
> +	 * case BLK_CRYPTO_ALG_ESSIV_AES_CBC:
> +	 *	ufs_alg = UFS_CRYPTO_ALG_ESSIV_AES_CBC;
> +	 *	break;
> +	 */

Perhaps just delete this comment... the constants are already outdated.

> +	hba->crypto_cfgs =
> +		devm_kcalloc(hba->dev,
> +			     hba->crypto_capabilities.config_count + 1,
> +			     sizeof(hba->crypto_cfgs[0]),
> +			     GFP_KERNEL);

Can use NUM_KEYSLOTS(hba) here, to avoid hardcoding the awkward '+ 1' again.

> +void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
> +					    struct request_queue *q)
> +{
> +	if (!ufshcd_hba_is_crypto_supported(hba))
> +		return;
> +
> +	if (q) {
> +		mutex_lock(&hba->ksm_lock);
> +		if (!hba->ksm) {
> +			hba->ksm = keyslot_manager_create(
> +				hba->crypto_capabilities.config_count + 1,
> +				&ufshcd_ksm_ops, hba);
> +			hba->ksm_num_refs = 0;

Same here.

> +		}
> +		hba->ksm_num_refs++;
> +		mutex_unlock(&hba->ksm_lock);
> +		q->ksm = hba->ksm;
> +	}
> +	/*
> +	 * If we fail we make it look like
> +	 * crypto is not supported, which will avoid issues
> +	 * with reset
> +	 */
> +	if (!q || !q->ksm) {
> +		ufshcd_crypto_disable(hba);
> +		hba->crypto_capabilities.reg_val = 0;
> +		devm_kfree(hba->dev, hba->crypto_cap_array);
> +		devm_kfree(hba->dev, hba->crypto_cfgs);
> +	}
> +}
> +
> +void ufshcd_crypto_destroy_rq_keyslot_manager(struct ufs_hba *hba,
> +					      struct request_queue *q)
> +{
> +	if (q && q->ksm) {
> +		q->ksm = NULL;
> +		mutex_lock(&hba->ksm_lock);
> +		hba->ksm_num_refs--;
> +		if (hba->ksm_num_refs == 0) {
> +			keyslot_manager_destroy(hba->ksm);
> +			hba->ksm = NULL;
> +		}
> +		mutex_unlock(&hba->ksm_lock);
> +	}
> +}

Why is the keyslot_manager reference counted?  Doesn't it live as long as the
individual devices do?  So, can't we just create the keyslot manager when the
ufs_hba is created, and destroy it when the ufs_hba is destroyed?  Then for each
device we'd just set 'q->ksm = hba->ksm;', with no refcounting needed.

- Eric
