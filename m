Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE11BF0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3HLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 03:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3HLV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:11:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9395B2082E;
        Thu, 30 Apr 2020 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588230680;
        bh=s4l9m6sDXPEeXraZWK6wigMAQG4mKfDnswEgISGvnS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOFPPzjWYYk044D2ZqXzNihzxX9ZCs2Qval8oNKQ5jkpKlAK60K2eo54sIknbSZka
         GDRnyym19w1K4XbzS+5amFW2gGHEZuL1NSNHCZhxN7SQk9dq7oQAebzSEcU3f7G90B
         oW5WU2MvB6hnKQWldY8GUKtiTgXqapiPHdOoqk98=
Date:   Thu, 30 Apr 2020 00:11:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v11 04/12] block: Make blk-integrity preclude hardware
 inline encryption
Message-ID: <20200430071119.GC16238@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
 <20200429072121.50094-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-5-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:21:13AM +0000, Satya Tangirala wrote:
> Whenever a device supports blk-integrity, the kernel will now always
> pretend that the device doesn't support inline encryption (essentially
> by setting the keyslot manager in the request queue to NULL).

"the kernel will now always" => "make the kernel", so that it's clear that this
patch is doing this.  I.e. it's not describing the state prior to the patch.

> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index ff1070edbb400..b45711fc37df4 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
>  	bi->tag_size = template->tag_size;
>  
>  	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	if (disk->queue->ksm) {
> +		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Unregistering keyslot manager from request queue, to disable hardware inline encryption.\n");
> +		blk_ksm_unregister(disk->queue);
> +	}
> +#endif
>  }

Make this shorter by removing the mention of the keyslot manager?:

	pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");


> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index b584723b392ad..834f45fdd33e2 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -25,6 +25,9 @@
>   * Upper layers will call blk_ksm_get_slot_for_key() to program a
>   * key into some slot in the inline encryption hardware.
>   */
> +
> +#define pr_fmt(fmt) "blk_crypto: " fmt

"blk-crypto", not "blk_crypto".

> +bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
> +{
> +	if (blk_integrity_queue_supports_integrity(q)) {
> +		pr_warn("Integrity and hardware inline encryption are not supported together. Hardware inline encryption is being disabled.\n");

"Disabling hardware inline encryption" to match my suggestion for the other one?

- Eric
