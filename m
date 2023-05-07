Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CC6FB0DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjEHNBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjEHNBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 09:01:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601943ACE0;
        Mon,  8 May 2023 06:01:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCE3B1FEB7;
        Mon,  8 May 2023 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGNeKfffk0EB6+xPJYEEBSpmuOZtEOgbN0SWpx0Kmdg=;
        b=FZG3chLUK3XUyjst/5VV4lS1yOZuItqiA94XFbdsGrXKgRvQFrJjLbWDuD3rxWEfq1ymlP
        k1LXV+1W3XwbgrE+56iI3mjEG85HMZ74q4DvwFMpfWwXbqF9vTTSm7MQf+sUrHfsO7v7dW
        TbR93RYZ90CgnjlDmXQvBIYw36xOX9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGNeKfffk0EB6+xPJYEEBSpmuOZtEOgbN0SWpx0Kmdg=;
        b=s+S+J0gqWiG265CSw3aKFKebIObIbNTpctTzxxWWwn6Ul9fq7KB3WGTZYm7v0oEzQoHQBw
        JU5M31Se3ouD51BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D80713499;
        Mon,  8 May 2023 13:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xJJdJqzyWGS+XQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 80B73A075B; Sun,  7 May 2023 21:09:51 +0200 (CEST)
Date:   Sun, 7 May 2023 21:09:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] block: turn bdev_lock into a mutex
Message-ID: <20230507190951.2yvzcekffhowlfbp@quack3>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-5-hch@lst.de>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-05-23 13:51:27, Christoph Hellwig wrote:
> There is no reason for this lock to spin, and being able to sleep under
> it will come in handy soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index f2c7181b0bba7d..bad75f6cf8edcd 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -308,7 +308,7 @@ EXPORT_SYMBOL(thaw_bdev);
>   * pseudo-fs
>   */
>  
> -static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(bdev_lock);
> +static  __cacheline_aligned_in_smp DEFINE_MUTEX(bdev_lock);
>  static struct kmem_cache * bdev_cachep __read_mostly;
>  
>  static struct inode *bdev_alloc_inode(struct super_block *sb)
> @@ -457,15 +457,14 @@ long nr_blockdev_pages(void)
>   *
>   * Test whether @bdev can be claimed by @holder.
>   *
> - * CONTEXT:
> - * spin_lock(&bdev_lock).
> - *
>   * RETURNS:
>   * %true if @bdev can be claimed, %false otherwise.
>   */
>  static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
>  			 void *holder)
>  {
> +	lockdep_assert_held(&bdev_lock);
> +
>  	if (bdev->bd_holder == holder)
>  		return true;	 /* already a holder */
>  	else if (bdev->bd_holder != NULL)
> @@ -500,10 +499,10 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
>  	if (WARN_ON_ONCE(!holder))
>  		return -EINVAL;
>  retry:
> -	spin_lock(&bdev_lock);
> +	mutex_lock(&bdev_lock);
>  	/* if someone else claimed, fail */
>  	if (!bd_may_claim(bdev, whole, holder)) {
> -		spin_unlock(&bdev_lock);
> +		mutex_unlock(&bdev_lock);
>  		return -EBUSY;
>  	}
>  
> @@ -513,7 +512,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
>  		DEFINE_WAIT(wait);
>  
>  		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> -		spin_unlock(&bdev_lock);
> +		mutex_unlock(&bdev_lock);
>  		schedule();
>  		finish_wait(wq, &wait);
>  		goto retry;
> @@ -521,7 +520,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder)
>  
>  	/* yay, all mine */
>  	whole->bd_claiming = holder;
> -	spin_unlock(&bdev_lock);
> +	mutex_unlock(&bdev_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
> @@ -547,7 +546,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
>  {
>  	struct block_device *whole = bdev_whole(bdev);
>  
> -	spin_lock(&bdev_lock);
> +	mutex_lock(&bdev_lock);
>  	BUG_ON(!bd_may_claim(bdev, whole, holder));
>  	/*
>  	 * Note that for a whole device bd_holders will be incremented twice,
> @@ -558,7 +557,7 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
>  	bdev->bd_holders++;
>  	bdev->bd_holder = holder;
>  	bd_clear_claiming(whole, holder);
> -	spin_unlock(&bdev_lock);
> +	mutex_unlock(&bdev_lock);
>  }
>  
>  /**
> @@ -572,9 +571,9 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
>   */
>  void bd_abort_claiming(struct block_device *bdev, void *holder)
>  {
> -	spin_lock(&bdev_lock);
> +	mutex_lock(&bdev_lock);
>  	bd_clear_claiming(bdev_whole(bdev), holder);
> -	spin_unlock(&bdev_lock);
> +	mutex_unlock(&bdev_lock);
>  }
>  EXPORT_SYMBOL(bd_abort_claiming);
>  
> @@ -587,7 +586,7 @@ static void bd_end_claim(struct block_device *bdev)
>  	 * Release a claim on the device.  The holder fields are protected with
>  	 * bdev_lock.  open_mutex is used to synchronize disk_holder unlinking.
>  	 */
> -	spin_lock(&bdev_lock);
> +	mutex_lock(&bdev_lock);
>  	WARN_ON_ONCE(--bdev->bd_holders < 0);
>  	WARN_ON_ONCE(--whole->bd_holders < 0);
>  	if (!bdev->bd_holders) {
> @@ -597,7 +596,7 @@ static void bd_end_claim(struct block_device *bdev)
>  	}
>  	if (!whole->bd_holders)
>  		whole->bd_holder = NULL;
> -	spin_unlock(&bdev_lock);
> +	mutex_unlock(&bdev_lock);
>  
>  	/*
>  	 * If this was the last claim, remove holder link and unblock evpoll if
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
