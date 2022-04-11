Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A664FBA25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiDKKzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244531AbiDKKzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:55:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B840A1F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 03:53:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D456B1F7AC;
        Mon, 11 Apr 2022 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pnejr5RHTcGnTp5cZGmz0bh94YtQka0xQdNqYf4HA/U=;
        b=jN0A9DIG+p2D9/rLi41n4C6a6RH8Of/UENq+Ks5vCrYfrNsY3TAZJx/YNsxH7ZQMJtWql4
        Ax7Ggse0gF7K1c0J6eHi75ZydB1PppzPI63aNw7UFBXb2k9cBpjpu8tNtspp4p6i6vJDp8
        kUY6aRd1GK5crUhaS7YYaUm76dtuFjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pnejr5RHTcGnTp5cZGmz0bh94YtQka0xQdNqYf4HA/U=;
        b=+XDYTJC9b9trB2w6yqW7yZCa8fSY6fFT8FNB1ZEcEBswQYjyf/YKKtzR5UlWYdQqMFuqOZ
        dm7mffxKyIhfQFCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5D18A3B89;
        Mon, 11 Apr 2022 10:53:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1CFE3A061B; Mon, 11 Apr 2022 12:52:58 +0200 (CEST)
Date:   Mon, 11 Apr 2022 12:52:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/16] fanotify: factor out helper
 fanotify_mark_update_flags()
Message-ID: <20220411105258.uehi4kuuop4gwwy4@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-13-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074904.2980320-13-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-03-22 10:49:00, Amir Goldstein wrote:
> Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
> is called after updating the mark mask.
> 
> Move recalc of object mask inside fanotify_mark_add_to_mask() which
> makes the code a bit simpler to follow.
> 
> Add also helper to translate fsnotify mark flags to user visible
> fanotify mark flags.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 10 ++++++++
>  fs/notify/fanotify/fanotify_user.c | 39 +++++++++++++++++-------------
>  fs/notify/fdinfo.c                 |  6 ++---
>  3 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a3d5b751cac5..87142bc0131a 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -490,3 +490,13 @@ static inline unsigned int fanotify_event_hash_bucket(
>  {
>  	return event->hash & FANOTIFY_HTABLE_MASK;
>  }
> +
> +static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
> +{
> +	unsigned int mflags = 0;
> +
> +	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
> +		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
> +
> +	return mflags;
> +}

This, together with fdinfo change should probably be a separate commit. I
don't see a good reason to mix these two changes...

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 0f0db1efa379..6e78ea12239c 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1081,42 +1081,50 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
>  				    flags, umask);
>  }
>  
> -static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
> -					   __u32 mask, unsigned int flags,
> -					   __u32 *removed)
> +static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
> +				      unsigned int flags, bool *recalc)
>  {
> -	fsn_mark->ignored_mask |= mask;
> -
>  	/*
>  	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
>  	 * the removal of the FS_MODIFY bit in calculated mask if it was set
>  	 * because of an ignored mask that is now going to survive FS_MODIFY.
>  	 */
>  	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
> +	    (flags & FAN_MARK_IGNORED_MASK) &&
>  	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
>  		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
>  		if (!(fsn_mark->mask & FS_MODIFY))
> -			*removed = FS_MODIFY;
> +			*recalc = true;
>  	}
> +
> +	return 0;
>  }
>  
> -static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> -				       __u32 mask, unsigned int flags,
> -				       __u32 *removed)
> +static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> +				     __u32 mask, unsigned int flags)
>  {
> -	__u32 oldmask, newmask;
> +	__u32 oldmask;
> +	bool recalc = false;
> +	int ret;
>  
>  	spin_lock(&fsn_mark->lock);
>  	oldmask = fsnotify_calc_mask(fsn_mark);
>  	if (!(flags & FAN_MARK_IGNORED_MASK)) {
>  		fsn_mark->mask |= mask;
>  	} else {
> -		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
> +		fsn_mark->ignored_mask |= mask;
>  	}
> -	newmask = fsnotify_calc_mask(fsn_mark);
> +
> +	recalc = fsnotify_calc_mask(fsn_mark) & ~oldmask &
> +		~fsnotify_conn_mask(fsn_mark->connector);

oldmask should be a subset of fsnotify_conn_mask() so the above should be
equivalent to:

recalc = fsnotify_calc_mask(fsn_mark) & ~fsnotify_conn_mask(fsn_mark->connector)

shouldn't it?

Otherwise this looks like a nice cleanup!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
