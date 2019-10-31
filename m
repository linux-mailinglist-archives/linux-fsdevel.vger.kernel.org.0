Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F4EB697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJaSEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:04:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaSEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6HWF9R69q+bGarY+/HC5Lk584D+wVdNWtJtDctzB8q0=; b=TEtnKh13JEKKq4wRkVL86Y5w9
        7iVHzu0iuZ8ezJjv4H2UHAd/n8maPHxbW9eNwbD3a+c8QX0cc802D/vBn56B4x+imP3oyyFtqjKVj
        Ckrdpp7SVuZB2MLxrI/Z7q5xtnE3d4u11miv9lJWYYSzLivn0UwC9OJs8lp7paRuSjSFjrymTx0Ms
        5CyATrnj8v+A7R2PZQc7NNbrt0xiC0nDud9k3oxZzdCYk/z7nfxj3h4qQrxgfYVg6WfFRW2fnAxQ2
        aPJawWzu6LUD3GXu/R4R0U4WhklGsjzJhO84sNvZNHGFs03d2qkFtH8dsmv2I9szMN5q10ogDI/ZD
        IZYtgPl0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQEoI-0002h1-Te; Thu, 31 Oct 2019 18:04:38 +0000
Date:   Thu, 31 Oct 2019 11:04:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20191031180438.GB23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-2-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:20:24AM -0700, Satya Tangirala wrote:
> +/*
> + * keyslot-manager.c

Never mention the file name in top of the file comments, it is going
to be out of data sooner than you'll get the series merged..

> +EXPORT_SYMBOL(keyslot_manager_create);

please use EXPORT_SYMBOL_GPL like all new low-level block layer exports.

> +EXPORT_SYMBOL(keyslot_manager_get_slot_for_key);

This is only used in block/bio-crypt-ctx.c, no need for an export.

> +void keyslot_manager_get_slot(struct keyslot_manager *ksm, unsigned int slot)
> +{
> +	if (WARN_ON(slot >= ksm->num_slots))
> +		return;
> +
> +	WARN_ON(atomic_inc_return(&ksm->slots[slot].slot_refs) < 2);
> +}
> +EXPORT_SYMBOL(keyslot_manager_get_slot);

Same here.

> +EXPORT_SYMBOL(keyslot_manager_put_slot);

And here.

> +bool keyslot_manager_crypto_mode_supported(struct keyslot_manager *ksm,
> +					   enum blk_crypto_mode_num crypto_mode,
> +					   unsigned int data_unit_size)
> +{
> +	if (!ksm)
> +		return false;
> +	return ksm->ksm_ll_ops.crypto_mode_supported(ksm->ll_priv_data,
> +						     crypto_mode,
> +						     data_unit_size);
> +}
> +EXPORT_SYMBOL(keyslot_manager_crypto_mode_supported);

And here as well.  In fact this one is so trivial that it is better
open coded into the two callers.

> +bool keyslot_manager_rq_crypto_mode_supported(struct request_queue *q,
> +					enum blk_crypto_mode_num crypto_mode,
> +					unsigned int data_unit_size)
> +{
> +	return keyslot_manager_crypto_mode_supported(q->ksm, crypto_mode,
> +						     data_unit_size);
> +}
> +EXPORT_SYMBOL(keyslot_manager_rq_crypto_mode_supported);

And this one is entirely unused.

> +EXPORT_SYMBOL(keyslot_manager_evict_key);

No used outside blk-crypto.c either.

In fact given how small block/blk-crypto.c and block/keyslot-manager.c
are, and given that all but two functions in the latter are only called
from the former you should seriously consider merging the two files.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 3cdb84cdc488..d0cb7c350cdc 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -564,6 +564,11 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
>  }
>  #endif
>  
> +enum blk_crypto_mode_num {
> +	BLK_ENCRYPTION_MODE_INVALID	= 0,
> +	BLK_ENCRYPTION_MODE_AES_256_XTS	= 1,
> +};

This one moves to include/linux/bio-crypt-ctx.h later in the series,
please introduce it in the right place from the start.  Also is there
a need to explicitly assign code points here?

> +extern struct keyslot_manager *keyslot_manager_create(unsigned int num_slots,
> +				const struct keyslot_mgmt_ll_ops *ksm_ops,
> +				void *ll_priv_data);

There is no nee for externs on function declarations in headers.
