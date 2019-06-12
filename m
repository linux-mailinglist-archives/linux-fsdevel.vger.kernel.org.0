Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4842EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfFLS0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfFLS0r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:26:47 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5852020B7C;
        Wed, 12 Jun 2019 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560364006;
        bh=8Xu/4/Hr77YJPOZLyjCSny/gZK/+Yxj5+W0FLM3fw9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7jI7F37dU7e+wWSQlP3Hr6YH0EpM0maaHmJ6ps96WG1LHHakgejJshKzKB1rBP5T
         kbLnI7ecNThT0nvN0VMlHB+D8xM89bFHbICIFgIcyRMPBrcs8pvUmbcnqFRFQc0q+i
         4yQ9AckVz9WZBTSVpQimMv/tMS5ljsEZ53OPYHjs=
Date:   Wed, 12 Jun 2019 11:26:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 1/8] block: Keyslot Manager for Inline Encryption
Message-ID: <20190612182642.GB18795@gmail.com>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605232837.31545-2-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:28:30PM -0700, Satya Tangirala wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..f76d5dff27fe 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -385,6 +385,10 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
>  
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +struct keyslot_manager;
> +#endif
> +

This should be placed with the other forward declarations at the beginning of
the file.  It also doesn't need to be behind an #ifdef.  See e.g. struct
blkcg_gq which is another conditional field in struct request_queue.

> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> new file mode 100644
> index 000000000000..76a9c255cb7e
> --- /dev/null
> +++ b/include/linux/keyslot-manager.h
[...]
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +struct keyslot_manager;
> +
> +extern struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
> +				const struct keyslot_mgmt_ll_ops *ksm_ops,
> +				void *ll_priv_data);
> +
> +extern int
> +keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
> +				 const u8 *key,
> +				 enum blk_crypt_mode_num crypt_mode,
> +				 unsigned int data_unit_size);
> +
> +extern void keyslot_manager_get_slot(struct keyslot_manager *ksm,
> +				     unsigned int slot);
> +
> +extern void keyslot_manager_put_slot(struct keyslot_manager *ksm,
> +				     unsigned int slot);
> +
> +extern int keyslot_manager_evict_key(struct keyslot_manager *ksm,
> +				     const u8 *key,
> +				     enum blk_crypt_mode_num crypt_mode,
> +				     unsigned int data_unit_size);
> +
> +extern void keyslot_manager_destroy(struct keyslot_manager *ksm);
> +
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +struct keyslot_manager {};

This is actually a struct definition, not a declaration.  This doesn't make
sense, since the CONFIG_BLK_INLINE_ENCRYPTION case only needs a forward
declaration here.  Both cases should just use a forward declaration.

> +
> +static inline struct keyslot_manager *
> +keyslot_manager_create(unsigned int num_slots,
> +		       const struct keyslot_mgmt_ll_ops *ksm_ops,
> +		       void *ll_priv_data)
> +{
> +	return NULL;
> +}
> +
> +static inline int
> +keyslot_manager_get_slot_for_key(struct keyslot_manager *ksm,
> +				 const u8 *key,
> +				 enum blk_crypt_mode_num crypt_mode,
> +				 unsigned int data_unit_size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void keyslot_manager_get_slot(struct keyslot_manager *ksm,
> +					    unsigned int slot) { }
> +
> +static inline int keyslot_manager_put_slot(struct keyslot_manager *ksm,
> +					   unsigned int slot)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int keyslot_manager_evict_key(struct keyslot_manager *ksm,
> +				     const u8 *key,
> +				     enum blk_crypt_mode_num crypt_mode,
> +				     unsigned int data_unit_size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void keyslot_manager_destroy(struct keyslot_manager *ksm)
> +{ }
> +
> +#endif /* CONFIG_BLK_INLINE_ENCRYPTION */

However, it seems we don't actually need these stub functions, since the
keyslot_manager_ functions are only called from .c files that are only compiled
when CONFIG_BLK_INLINE_ENCRYPTION, except for the call to
keyslot_manager_evict_key() in fscrypt_evict_crypt_key().  But it would make
more sense to stub out fscrypt_evict_crypt_key() instead.

So I suggest removing the keyslot_manager_* stubs for now.

- Eric
