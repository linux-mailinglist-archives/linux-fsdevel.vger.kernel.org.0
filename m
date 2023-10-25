Return-Path: <linux-fsdevel+bounces-1196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B37D714E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6F61C20750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DCD2E633;
	Wed, 25 Oct 2023 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W54CbY5o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYYM9lc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597E2E627
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:54:43 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86312F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:54:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45AF11FF80;
	Wed, 25 Oct 2023 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698249280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=et2vc3k+Ies66qUxZ3ekoQpDPvAKd1lNvxvP0cTifpQ=;
	b=W54CbY5oawyeobccoti4MBPKaRMYqvEI0m2Wu+UYxrf2UEXO40sWwnrA1ONT5hASzYoz6i
	VXE72MmtCfW5cGKK5Gty0c5YklDAFzXF0xKiKZvN0j2K1ai3+mCrylbUAdwKh0VK4c4DKg
	ziHZYkKkJuyUIU0xPBMBH2J2Sdo/uUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698249280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=et2vc3k+Ies66qUxZ3ekoQpDPvAKd1lNvxvP0cTifpQ=;
	b=AYYM9lc8Jk3vWYWQulqpy9mncqY7AvvTQBc5lc8VVQbGY8VXkSj8b0Z7Xhs/ndcp2OIB4D
	qRTrNZZxGXvBpzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37E4013524;
	Wed, 25 Oct 2023 15:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yqaaDUA6OWWZRAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 15:54:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFCE9A0679; Wed, 25 Oct 2023 17:54:39 +0200 (CEST)
Date: Wed, 25 Oct 2023 17:54:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] bdev: simplify waiting for concurrent claimers
Message-ID: <20231025155439.5otniolu5mydjoon@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231024-vfs-super-rework-v1-4-37a8aa697148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-rework-v1-4-37a8aa697148@kernel.org>

On Tue 24-10-23 16:53:42, Christian Brauner wrote:
> Simplify the mechanism to wait for concurrent block devices claimers
> and make it possible to introduce an additional state in the following
> patches.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

The simplification looks good but a few notes below:

> diff --git a/block/bdev.c b/block/bdev.c
> index 9deacd346192..7d19e04a8df8 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -482,6 +482,14 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
>  	return true;
>  }
>  
> +static bool wait_claimable(const struct block_device *bdev)
> +{
> +	enum bd_claim bd_claim;
> +
> +	bd_claim = smp_load_acquire(&bdev->bd_claim);
> +	return bd_claim == BD_CLAIM_DEFAULT;
> +}

Aren't you overdoing it here a bit? Given this is used only in a retry
loop and all the checks that need to be reliable are done under bdev_lock,
I'd say having:

	return READ_ONCE(bdev->bd_claim) == BD_CLAIM_DEFAULT;

shound be fine here? And probably just inline that into the
wait_var_event() call...

> @@ -511,31 +519,25 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
>  	}
>  
>  	/* if claiming is already in progress, wait for it to finish */
> -	if (whole->bd_claiming) {
> -		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
> -		DEFINE_WAIT(wait);
> -
> -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> +	if (whole->bd_claim) {

This test implicitely assumes that 0 is BD_CLAIM_DEFAULT. I guess that's
fine although I somewhat prefer explicit value test like:

	if (whole->bd_claim != BD_CLAIM_DEFAULT)

>  		mutex_unlock(&bdev_lock);
> -		schedule();
> -		finish_wait(wq, &wait);
> +		wait_var_event(&whole->bd_claim, wait_claimable(whole));
>  		goto retry;
>  	}
>  
>  	/* yay, all mine */
> -	whole->bd_claiming = holder;
> +	whole->bd_claim = BD_CLAIM_ACQUIRE;

Here I'd use WRITE_ONCE() to avoid KCSAN warnings and having to think
whether this can race with wait_claimable() or not.

>  	mutex_unlock(&bdev_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
>  
> -static void bd_clear_claiming(struct block_device *whole, void *holder)
> +static void bd_clear_claiming(struct block_device *whole)
>  {
>  	lockdep_assert_held(&bdev_lock);
> -	/* tell others that we're done */
> -	BUG_ON(whole->bd_claiming != holder);
> -	whole->bd_claiming = NULL;
> -	wake_up_bit(&whole->bd_claiming, 0);
> +	smp_store_release(&whole->bd_claim, BD_CLAIM_DEFAULT);
> +	smp_mb();
> +	wake_up_var(&whole->bd_claim);

And here since we are under bdev_lock and the waiter is going to check
under bdev_lock as well, we should be able to do:

	WRITE_ONCE(whole->bd_claim, BD_CLAIM_DEFAULT);
	/* Pairs with barrier in prepare_to_wait_event() -> set_current_state() */
	smp_mb();
	wake_up_var(&whole->bd_claim);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

