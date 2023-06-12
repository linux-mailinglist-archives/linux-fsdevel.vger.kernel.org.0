Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1672C347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjFLLmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjFLLkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:40:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED818C;
        Mon, 12 Jun 2023 04:35:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E150B2281F;
        Mon, 12 Jun 2023 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686569726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1onI1JNbCsu0x7eMgFnoMSWuE6d/qfVBdd3qHMjSvM=;
        b=W94uoe9jhEQK33oRNomuEJ1P0ArMRjrK17VU0XAcvNmChEB3G1EiLn8qgccrs1fVkJe1WR
        YwnFYmsb6lDv49L4AAViQ9SfguHIiSdS7/eng8wcVIM+8ibTJOqzj8JXQMjb/ZGQr6g1sC
        rXnNfvjwHffjV7l6H2xwdedve4EOMmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686569726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1onI1JNbCsu0x7eMgFnoMSWuE6d/qfVBdd3qHMjSvM=;
        b=RI9p567oHQ/Db//el3LPuq0tlWX6WcAag4asOCMBMOb4BSHlQH6N5KLAPOnAxqxYUCTj7N
        2SZXiOsqmiyitCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4A1D1357F;
        Mon, 12 Jun 2023 11:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FFDjM/4Ch2QjSwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 11:35:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6A282A0717; Mon, 12 Jun 2023 13:35:26 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:35:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230612113526.xfhpaohiqusq5ixt@quack3>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 11-06-23 20:15:28, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Jan Kara suggested that when one thread is in the middle of freezing a
> filesystem, another thread trying to freeze the same fs but with a
> different freeze_holder should wait until the freezer reaches either end
> state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> 
> Plumb in the extra coded needed to wait for the fs freezer to reach an
> end state and try the freeze again.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

You can maybe copy my reasoning from my reply to your patch 1/3 to the
changelog to explain why waiting is more desirable.

> @@ -1690,11 +1699,13 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
>   */
>  int freeze_super(struct super_block *sb, enum freeze_holder who)
>  {
> +	bool try_again = true;
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
>  
> +retry:
>  	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
>  		ret = freeze_frozen_super(sb, who);
>  		deactivate_locked_super(sb);
> @@ -1702,8 +1713,14 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	}
>  
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> -		deactivate_locked_super(sb);
> -		return -EBUSY;
> +		if (!try_again) {
> +			deactivate_locked_super(sb);
> +			return -EBUSY;
> +		}

Why only one retry? Do you envision someone will be freezing & thawing
filesystem so intensively that livelocks are possible? In that case I'd
think the system has other problems than freeze taking long... Honestly,
I'd be looping as long as we either succeed or return error for other
reasons.

What we could be doing to limit unnecessary waiting is that we'd update
freeze_holders already when we enter freeze_super() and lock s_umount
(bailing if our holder type is already set). That way we'd have at most one
process for each holder type freezing the fs / waiting for freezing to
complete.

> +
> +		wait_for_partially_frozen(sb);
> +		try_again = false;
> +		goto retry;
>  	}
>  
...
> @@ -1810,6 +1831,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.freeze_holders &= ~who;
>  		sb->s_writers.frozen = SB_UNFROZEN;
> +		wake_up_var(&sb->s_writers.frozen);
>  		goto out;
>  	}
>  
> @@ -1828,6 +1850,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  
>  	sb->s_writers.freeze_holders &= ~who;
>  	sb->s_writers.frozen = SB_UNFROZEN;
> +	wake_up_var(&sb->s_writers.frozen);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
>  	wake_up(&sb->s_writers.wait_unfrozen);

I don't think wakeups on thaw are really needed because the waiter should
be woken already once the freezing task exits from freeze_super(). I guess
you've sprinkled them here just for good measure?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
