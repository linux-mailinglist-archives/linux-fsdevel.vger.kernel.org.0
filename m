Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4792F16845B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBUREf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:04:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgBUREf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r3W9uQBOJlV/Av1C4P5QJ8rWtko3f0+LGkNeNqVgIXE=; b=AV6Cw8ovuehrTohFGMfQ7n0kse
        bjrdnD9nESXI0I3PhTjjlM1TLq5ja8b35TsbwUSuOz6O3K1S8kAcssyZP1MCGHcG4kw/lfza5fkeb
        QOnZfCeaRELcgK09zo2800vd04X5tYSYTSi6pR24Pv7o7U2qmROm4epqCjmdubnrlnmVFNqKTUfNu
        87qqVl3NeMxxEMlK1BEUhoafXDd8nMTCXTvOtVD3ptQxLN36wRRJoYUQ/FDv2hQsUqZ5LFEcVCpUg
        Nt8pMcATyiWCCDn6xIrWVuAgQbk1q7RAv8dNR7WD1b0IYd/UQOWjvoWynx1dI6wC7JPPah9Nr35ng
        KSATh/Qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Bj8-0004qU-9u; Fri, 21 Feb 2020 17:04:34 +0000
Date:   Fri, 21 Feb 2020 09:04:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20200221170434.GA438@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-2-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +#ifdef CONFIG_PM
> +static inline void blk_ksm_set_dev(struct keyslot_manager *ksm,
> +				   struct device *dev)
> +{
> +	ksm->dev = dev;
> +}
> +
> +/* If there's an underlying device and it's suspended, resume it. */
> +static inline void blk_ksm_pm_get(struct keyslot_manager *ksm)
> +{
> +	if (ksm->dev)
> +		pm_runtime_get_sync(ksm->dev);
> +}
> +
> +static inline void blk_ksm_pm_put(struct keyslot_manager *ksm)
> +{
> +	if (ksm->dev)
> +		pm_runtime_put_sync(ksm->dev);
> +}
> +#else /* CONFIG_PM */
> +static inline void blk_ksm_set_dev(struct keyslot_manager *ksm,
> +				   struct device *dev)
> +{
> +}
> +
> +static inline void blk_ksm_pm_get(struct keyslot_manager *ksm)
> +{
> +}
> +
> +static inline void blk_ksm_pm_put(struct keyslot_manager *ksm)
> +{
> +}
> +#endif /* !CONFIG_PM */

I think no one is hurt by an unused dev field for the non-pm case.
I'd suggest to define the field unconditionally, and replace all
the above with direct calls below.

> +/**
> + * blk_ksm_get_slot() - Increment the refcount on the specified slot.
> + * @ksm: The keyslot manager that we want to modify.
> + * @slot: The slot to increment the refcount of.
> + *
> + * This function assumes that there is already an active reference to that slot
> + * and simply increments the refcount. This is useful when cloning a bio that
> + * already has a reference to a keyslot, and we want the cloned bio to also have
> + * its own reference.
> + *
> + * Context: Any context.
> + */
> +void blk_ksm_get_slot(struct keyslot_manager *ksm, unsigned int slot)

This function doesn't appear to be used at all in the whole series.

> +/**
> + * blk_ksm_put_slot() - Release a reference to a slot
> + * @ksm: The keyslot manager to release the reference from.
> + * @slot: The slot to release the reference from.
> + *
> + * Context: Any context.
> + */
> +void blk_ksm_put_slot(struct keyslot_manager *ksm, unsigned int slot)
> +{
> +	unsigned long flags;
> +
> +	if (WARN_ON(slot >= ksm->num_slots))
> +		return;
> +
> +	if (atomic_dec_and_lock_irqsave(&ksm->slots[slot].slot_refs,
> +					&ksm->idle_slots_lock, flags)) {
> +		list_add_tail(&ksm->slots[slot].idle_slot_node,
> +			      &ksm->idle_slots);
> +		spin_unlock_irqrestore(&ksm->idle_slots_lock, flags);
> +		wake_up(&ksm->idle_slots_wait_queue);
> +	}

Given that blk_ksm_get_slot_for_key returns a signed keyslot that
can return errors, and the only callers stores it in a signed variable
I think this function should take a signed slot as well, and the check
for a non-negative slot should be moved here from the only caller.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 853d92ceee64..b2103e207ed5 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -8,6 +8,7 @@
>  #include <linux/highmem.h>
>  #include <linux/mempool.h>
>  #include <linux/ioprio.h>
> +#include <linux/blk-crypto.h>
>  
>  #ifdef CONFIG_BLOCK
>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */

This doesn't belong here, but into the patch that actually requires
crypto definitions in bio.h.
