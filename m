Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB896FB0CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjEHNBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjEHNBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 09:01:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5B39180;
        Mon,  8 May 2023 06:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1436E1FEAA;
        Mon,  8 May 2023 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJzCtHtEsQ9hyaHheFbV5qVRxZR6ISxplO33W+6TSVI=;
        b=wXibhhlte9274Fdj/cdIZ/Mhyxvl/mAYa1KK4cXmxIDGmMpWtu0ry8blVAe8wpjNf7+ONB
        +U7I4pzKrC7+dAgsBZuDM4cAV12XqNi8fwnRdFa0as9Jm8vKqjFDDEFv+UBw+mtQvStIU/
        u5+7dxuyJgfdlDck44Jrp34avOpYzuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJzCtHtEsQ9hyaHheFbV5qVRxZR6ISxplO33W+6TSVI=;
        b=gBFh74GRak/Hny/wglhI6eogTt2xFsIkzT0AYm9P0+KVwG7I9sqlgEPX/9nPpFKXhqLlRt
        5Lg5jZaSKyxAxOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D87A713A0A;
        Mon,  8 May 2023 13:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TiPPNKryWGSgXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D8CB9A0757; Sun,  7 May 2023 21:08:47 +0200 (CEST)
Date:   Sun, 7 May 2023 21:08:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/9] block: factor out a bd_end_claim helper from
 blkdev_put
Message-ID: <20230507190847.cp2kp5nrbwxcsdg2@quack3>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-4-hch@lst.de>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-05-23 13:51:26, Christoph Hellwig wrote:
> Move all the logic to release an exclusive claim into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c | 63 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 850852fe4b78e1..f2c7181b0bba7d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -578,6 +578,37 @@ void bd_abort_claiming(struct block_device *bdev, void *holder)
>  }
>  EXPORT_SYMBOL(bd_abort_claiming);
>  
> +static void bd_end_claim(struct block_device *bdev)
> +{
> +	struct block_device *whole = bdev_whole(bdev);
> +	bool unblock = false;
> +
> +	/*
> +	 * Release a claim on the device.  The holder fields are protected with
> +	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
> +	 */
> +	spin_lock(&bdev_lock);
> +	WARN_ON_ONCE(--bdev->bd_holders < 0);
> +	WARN_ON_ONCE(--whole->bd_holders < 0);
> +	if (!bdev->bd_holders) {
> +		bdev->bd_holder = NULL;
> +		if (bdev->bd_write_holder)
> +			unblock = true;
> +	}
> +	if (!whole->bd_holders)
> +		whole->bd_holder = NULL;
> +	spin_unlock(&bdev_lock);
> +
> +	/*
> +	 * If this was the last claim, remove holder link and unblock evpoll if
> +	 * it was a write holder.
> +	 */
> +	if (unblock) {
> +		disk_unblock_events(bdev->bd_disk);
> +		bdev->bd_write_holder = false;
> +	}
> +}
> +
>  static void blkdev_flush_mapping(struct block_device *bdev)
>  {
>  	WARN_ON_ONCE(bdev->bd_holders);
> @@ -832,36 +863,8 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
>  		sync_blockdev(bdev);
>  
>  	mutex_lock(&disk->open_mutex);
> -	if (mode & FMODE_EXCL) {
> -		struct block_device *whole = bdev_whole(bdev);
> -		bool bdev_free;
> -
> -		/*
> -		 * Release a claim on the device.  The holder fields
> -		 * are protected with bdev_lock.  open_mutex is to
> -		 * synchronize disk_holder unlinking.
> -		 */
> -		spin_lock(&bdev_lock);
> -
> -		WARN_ON_ONCE(--bdev->bd_holders < 0);
> -		WARN_ON_ONCE(--whole->bd_holders < 0);
> -
> -		if ((bdev_free = !bdev->bd_holders))
> -			bdev->bd_holder = NULL;
> -		if (!whole->bd_holders)
> -			whole->bd_holder = NULL;
> -
> -		spin_unlock(&bdev_lock);
> -
> -		/*
> -		 * If this was the last claim, remove holder link and
> -		 * unblock evpoll if it was a write holder.
> -		 */
> -		if (bdev_free && bdev->bd_write_holder) {
> -			disk_unblock_events(disk);
> -			bdev->bd_write_holder = false;
> -		}
> -	}
> +	if (mode & FMODE_EXCL)
> +		bd_end_claim(bdev);
>  
>  	/*
>  	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
