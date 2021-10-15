Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE642F138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 14:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhJOMpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 08:45:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJOMpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:45:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DF431FD39;
        Fri, 15 Oct 2021 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634301818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+m/PiqSjqM6L0ouRH5QqyV+d3D9qzy/OTI2OyQ5Vr0=;
        b=uNKQlLukDqxpvLSXBVBf+ex0/hpBW/SpLf3giVgOdlJ2T9+30VSh6MyUv+KX4XCCMe9Zum
        xPgcPFCWUerXL28WkUgXxQVOWfpLnAbuFwQ9tQBRKrnYElHtwgN6gCDVLxsesVjEWNk1sV
        r5/323uxf1Bhw8nK+wy859h6nkWTCjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634301818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+m/PiqSjqM6L0ouRH5QqyV+d3D9qzy/OTI2OyQ5Vr0=;
        b=3pjg1dRR6MvZSvhYFBI5J8GulpF+um38dkY84ycKbshbLeIQTXcdRrwJTeNZ41XJjEBUFp
        +h/BVQVhjHcTPbBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 287AFA3B83;
        Fri, 15 Oct 2021 12:43:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F39761E0A40; Fri, 15 Oct 2021 14:43:37 +0200 (CEST)
Date:   Fri, 15 Oct 2021 14:43:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 21/28] fanotify: Support merging of error events
Message-ID: <20211015124337.GK23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-22-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-22-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:39, Gabriel Krisman Bertazi wrote:
> Error events (FAN_FS_ERROR) against the same file system can be merged
> by simply iterating the error count.  The hash is taken from the fsid,
> without considering the FH.  This means that only the first error object
> is reported.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

...

> +static void fanotify_merge_error_event(struct fanotify_error_event *dest,
> +				       struct fanotify_error_event *origin)
> +{
> +	dest->err_count++;
> +}
> +
> +static void fanotify_merge_event(struct fanotify_event *dest,
> +				 struct fanotify_event *origin)
> +{
> +	dest->mask |= origin->mask;
> +
> +	if (origin->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +		fanotify_merge_error_event(FANOTIFY_EE(dest),
> +					   FANOTIFY_EE(origin));
> +}
> +
>  /* Limit event merges to limit CPU overhead per event */
>  #define FANOTIFY_MAX_MERGE_EVENTS 128
>  
> @@ -175,7 +204,7 @@ static int fanotify_merge(struct fsnotify_group *group,
>  		if (++i > FANOTIFY_MAX_MERGE_EVENTS)
>  			break;
>  		if (fanotify_should_merge(old, new)) {
> -			old->mask |= new->mask;
> +			fanotify_merge_event(old, new);

I guess no need for two functions (fanotify_merge_event(),
fanotify_merge_error_event()) for three lines of code? I'd just put those
three lines into fanotify_merge().

> @@ -591,6 +621,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  		return NULL;
>  
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	fee->err_count = 1;
> +
> +	*hash ^= fanotify_hash_fsid(fsid);
>  
>  	return &fee->fae;
>  }

As Amir mentioned, you should set fsid here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
