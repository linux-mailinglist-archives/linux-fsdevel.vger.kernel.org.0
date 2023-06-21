Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD634737E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFUJH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjFUJHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:07:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA43E1BC;
        Wed, 21 Jun 2023 02:07:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77CE31F8A3;
        Wed, 21 Jun 2023 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687338438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K123BJLeYyP4gB9oH8nDlTi1zXVyVv0YgJOvSJAhqdA=;
        b=QkDPG/iULymwOmArC3TUi53vdY7vLQcUjEC+exrFryHrRY8nagA/gyb1Jebte9kCs+8ilx
        zWMtV+76oOxgCc4qPuN8Mbjukl5ulJn7/anaSCfCgfCVeRc5XiOKfLXF7BiPZ6s/pNjQFR
        7K+yIByqQjlLqsR+TjmX6tA2uJsuq5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687338438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K123BJLeYyP4gB9oH8nDlTi1zXVyVv0YgJOvSJAhqdA=;
        b=5aGMYjk24dNI8lRLBvHUnxrnTGmj4UVfpxz1FevzyoHCGpmI7UJInxn0NxLU9NGr1HAam7
        rUZ0pUN3p8N2auDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 646C0134B1;
        Wed, 21 Jun 2023 09:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eYpOGMa9kmRzZgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 21 Jun 2023 09:07:18 +0000
Message-ID: <210519c3-b843-c2f5-f2eb-633543e2cc7f@suse.de>
Date:   Wed, 21 Jun 2023 11:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/4] nvme: enable logical block size > PAGE_SIZE
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        david@fromorbit.com
Cc:     gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621083823.1724337-1-p.raghav@samsung.com>
 <CGME20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb@eucas1p1.samsung.com>
 <20230621083823.1724337-5-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230621083823.1724337-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 10:38, Pankaj Raghav wrote:
> Don't set the capacity to zero for when logical block size > PAGE_SIZE
> as the block device with iomap aops support allocating block cache with
> a minimum folio order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 98bfb3d9c22a..36cf610f938c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1886,7 +1886,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	 * The block layer can't support LBA sizes larger than the page size
>   	 * yet, so catch this early and don't allow block I/O.
>   	 */
> -	if (ns->lba_shift > PAGE_SHIFT) {
> +	if ((ns->lba_shift > PAGE_SHIFT) && IS_ENABLED(CONFIG_BUFFER_HEAD)) {
>   		capacity = 0;
>   		bs = (1 << 9);
>   	}
Again, I can't see why this would be contingent on CONFIG_BUFFER_HEAD.
I'll be rebasing my patchset on your mapping_set_orders() patches and 
repost.

Cheers,

Hannes

