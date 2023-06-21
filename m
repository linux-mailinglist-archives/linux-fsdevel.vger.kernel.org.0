Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB5737E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFUJGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFUJGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:06:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D37DC;
        Wed, 21 Jun 2023 02:06:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59E7A1F8A3;
        Wed, 21 Jun 2023 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687338362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksn9DL4euc6H2A7h0Ot4A/++PR+e6lynq9oDzURShPo=;
        b=M3d8ITHPE0eQFP41CM0oe7L1YsDpyF2PztoNJa72R3fLgwG2TNRKq1SrUFZfvEK69bPqmO
        Jv5G3RRXhFHu0FqM6t68PohmWxvVDpgHTui+88TIS7vrvz9G86SxicDdn/enkVF9N+ACZp
        3YDj18nivxCKX79OeNy3Oo32lAkSbFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687338362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksn9DL4euc6H2A7h0Ot4A/++PR+e6lynq9oDzURShPo=;
        b=3/sAVLJc0jdcEkOMSB3RJQHtquBP1wCVRLeofJGBp3FbYlVR3EotEGeZrZBATclUW7fwHI
        QiEesQlUbVqowHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F4B9134B1;
        Wed, 21 Jun 2023 09:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rqx7Dnq9kmTbZQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 21 Jun 2023 09:06:02 +0000
Message-ID: <a25eb5ce-b71c-2a38-d8eb-f8de8b8b449e@suse.de>
Date:   Wed, 21 Jun 2023 11:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 3/4] block: set mapping order for the block cache in
 set_init_blocksize
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        david@fromorbit.com
Cc:     gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621083823.1724337-1-p.raghav@samsung.com>
 <CGME20230621083828eucas1p23222cae535297f9536f12dddd485f97b@eucas1p2.samsung.com>
 <20230621083823.1724337-4-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230621083823.1724337-4-p.raghav@samsung.com>
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
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Automatically set the minimum mapping order for block devices in
> set_init_blocksize(). The mapping order will be set only when the block
> device uses iomap based aops.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/bdev.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 9bb54d9d02a6..db8cede8a320 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -126,6 +126,7 @@ static void set_init_blocksize(struct block_device *bdev)
>   {
>   	unsigned int bsize = bdev_logical_block_size(bdev);
>   	loff_t size = i_size_read(bdev->bd_inode);
> +	int order, folio_order;
>   
>   	while (bsize < PAGE_SIZE) {
>   		if (size & bsize)
> @@ -133,6 +134,14 @@ static void set_init_blocksize(struct block_device *bdev)
>   		bsize <<= 1;
>   	}
>   	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
> +	order = bdev->bd_inode->i_blkbits - PAGE_SHIFT;
> +	folio_order = mapping_min_folio_order(bdev->bd_inode->i_mapping);
> +
> +	if (!IS_ENABLED(CONFIG_BUFFER_HEAD)) {
> +		/* Do not allow changing the folio order after it is set */
> +		WARN_ON_ONCE(folio_order && (folio_order != order));
> +		mapping_set_folio_orders(bdev->bd_inode->i_mapping, order, 31);
> +	}
>   }
>   
>   int set_blocksize(struct block_device *bdev, int size)
This really has nothing to do with buffer heads.

In fact, I've got a patchset to make it work _with_ buffer heads.

So please, don't make it conditional on CONFIG_BUFFER_HEAD.

And we should be calling into 'mapping_set_folio_order()' only if the 
'order' argument is larger than PAGE_ORDER, otherwise we end up enabling
large folio support for _every_ block device.
Which I doubt we want.

Cheers,

Hannes


