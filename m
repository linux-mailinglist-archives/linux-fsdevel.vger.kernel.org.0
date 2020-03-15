Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816D4185FB9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgCOUQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 16:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgCOUQV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:16:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4834A205C9;
        Sun, 15 Mar 2020 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303380;
        bh=5VqbqRCMOuCKrwhIgRoKM6xoalmVSXXR/W2soqbZ1L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcUzhGIuXaHU9vfOPWYtMg5tNxsoTitGkBlfvXySVUWt6Iu1NQNDAB8LCd1+0Nvyt
         4XcWpBlIK/3A1T+NUUSkZwIzsU4SL3OLRuehrOjZp/6w9mEHq4mVL63J3TZCxfZEB0
         4hZ1adM0h2K2JuNo4FFTY29yf4DUchHuTWpNOS4I=
Date:   Sun, 15 Mar 2020 13:16:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 03/11] block: Make blk-integrity preclude hardware
 inline encryption
Message-ID: <20200315201618.GH1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:45AM -0700, Satya Tangirala wrote:
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index ff1070edbb40..793ba23e8688 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
>  	bi->tag_size = template->tag_size;
>  
>  	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
> +
> +#ifdef BLK_INLINE_ENCRYPTION
> +	if (disk->queue->ksm) {
> +		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Unregistering keyslot manager from request queue, to disable hardware inline encryption.");
> +		blk_ksm_unregister(disk->queue);
> +	}
> +#endif
>  }
>  EXPORT_SYMBOL(blk_integrity_register);

This ifdef is wrong, it should be CONFIG_BLK_INLINE_ENCRYPTION.

Also the log message is missing a trailing newline.

>  
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 38df0652df80..a7970e18a122 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -25,6 +25,9 @@
>   * Upper layers will call blk_ksm_get_slot_for_key() to program a
>   * key into some slot in the inline encryption hardware.
>   */
> +
> +#define pr_fmt(fmt) "blk_ksm: " fmt

People aren't going to know what "blk_ksm" means in the logs.
I think just use "blk-crypto" instead.

> +
>  #include <crypto/algapi.h>
>  #include <linux/keyslot-manager.h>
>  #include <linux/atomic.h>
> @@ -375,3 +378,20 @@ void blk_ksm_destroy(struct keyslot_manager *ksm)
>  	memzero_explicit(ksm, sizeof(*ksm));
>  }
>  EXPORT_SYMBOL_GPL(blk_ksm_destroy);
> +
> +bool blk_ksm_register(struct keyslot_manager *ksm, struct request_queue *q)
> +{
> +	if (blk_integrity_queue_supports_integrity(q)) {
> +		pr_warn("Integrity and hardware inline encryption are not supported together. Won't register keyslot manager with request queue.");
> +		return false;
> +	}
> +	q->ksm = ksm;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_register);


People reading the logs won't know what a keyslot manager is and why they should
care that one wasn't registered.  It would be better to say that hardware inline
encryption is being disabled.

Ideally the device name would be included in the message too.

> +
> +void blk_ksm_unregister(struct request_queue *q)
> +{
> +	q->ksm = NULL;
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_unregister);

blk_ksm_unregister() doesn't need to be exported.
