Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7555504B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358064AbiFVPy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359763AbiFVPxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:53:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A1CE35;
        Wed, 22 Jun 2022 08:53:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C8E3721C10;
        Wed, 22 Jun 2022 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655913171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDybUhlXPjzwC9jJdp7b3hPv6c4lM2q2OAfx4WizXnA=;
        b=Wmai+dySOWNDIipW1Y7gI+/dPR0+umcTZBXqpN7VAqRxN+PiwoocAKri6YujpvHq1RDgps
        iOEB4tzTK4fJle9rmXKHa82yo+j9JGv8yCkBIU57jxjGYsHCo3JCGXcYZxbyDhUkxavZbD
        BuD2j2grPHbqv5djdDwsQ9CzWy4Qu3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655913171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDybUhlXPjzwC9jJdp7b3hPv6c4lM2q2OAfx4WizXnA=;
        b=WzvECKr9CIhOps9NeTBzRzHRtMk1wf7/Xeg3RbmR0pIVXNjVZKJal4oRIcO5xokXfOZlA5
        Uz4IaDVwO89NiCBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6D572C141;
        Wed, 22 Jun 2022 15:52:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5F308A062B; Wed, 22 Jun 2022 17:52:48 +0200 (CEST)
Date:   Wed, 22 Jun 2022 17:52:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore
 mask
Message-ID: <20220622155248.d6oywn3rkurbijs6@quack3.lan>
References: <20220620134551.2066847-1-amir73il@gmail.com>
 <20220620134551.2066847-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620134551.2066847-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> ignore mask is always implicitly applied to events on directories.
> 
> Define a mark flag that replaces this legacy behavior with logic of
> applying the ignore mask according to event flags in ignore mask.
> 
> Implement the new logic to prepare for supporting an ignore mask that
> ignores events on children and ignore mask that does not ignore events
> on directories.
> 
> To emphasize the change in terminology, also rename ignored_mask mark
> member to ignore_mask and use accessor to get only ignored events or
> events and flags.
> 
> This change in terminology finally aligns with the "ignore mask"
> language in man pages and in most of the comments.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks mostly good to me. Just one question / suggestion: You are
introducing helpers fsnotify_ignore_mask() and fsnotify_ignored_events().
So shouldn't we be using these helpers as much as possible throughout the
code? Because in several places I had to check the code around whether
using mark->ignore_mask directly is actually fine. In particular:

> @@ -315,19 +316,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			return 0;
>  	} else if (!(fid_mode & FAN_REPORT_FID)) {
>  		/* Do we have a directory inode to report? */
> -		if (!dir && !(event_mask & FS_ISDIR))
> +		if (!dir && !ondir)
>  			return 0;
>  	}
>  
>  	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> -		/* Apply ignore mask regardless of mark's ISDIR flag */
> -		marks_ignored_mask |= mark->ignored_mask;
> +		/*
> +		 * Apply ignore mask depending on whether FAN_ONDIR flag in
> +		 * ignore mask should be checked to ignore events on dirs.
> +		 */
> +		if (!ondir || fsnotify_ignore_mask(mark) & FAN_ONDIR)
> +			marks_ignore_mask |= mark->ignore_mask;
>  
>  		/*
>  		 * If the event is on dir and this mark doesn't care about
>  		 * events on dir, don't send it!
>  		 */
> -		if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
> +		if (ondir && !(mark->mask & FAN_ONDIR))
>  			continue;
>  
>  		marks_mask |= mark->mask;

So for example here I'm wondering whether a helper should not be used...

> @@ -336,7 +341,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  		*match_mask |= 1U << type;
>  	}
>  
> -	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
> +	test_mask = event_mask & marks_mask & ~marks_ignore_mask;

Especially because here if say FAN_EVENT_ON_CHILD becomes a part of
marks_ignore_mask it can result in clearing this flag in the returned
'mask' which is likely not what we want if there are some events left
unignored in the 'mask'?
  
> @@ -344,14 +344,16 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
>  		group = mark->group;
>  		marks_mask |= mark->mask;
> -		marks_ignored_mask |= mark->ignored_mask;
> +		if (!(mask & FS_ISDIR) ||
> +		    (fsnotify_ignore_mask(mark) & FS_ISDIR))
> +			marks_ignore_mask |= mark->ignore_mask;
>  	}
>  
> -	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
> -		 __func__, group, mask, marks_mask, marks_ignored_mask,
> +	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
> +		 __func__, group, mask, marks_mask, marks_ignore_mask,
>  		 data, data_type, dir, cookie);
>  
> -	if (!(test_mask & marks_mask & ~marks_ignored_mask))
> +	if (!(test_mask & marks_mask & ~marks_ignore_mask))
>  		return 0;

And I'm wondering about similar things here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
