Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6739145F077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbhKZPTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:19:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349962AbhKZPRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:17:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0113B1FC9E;
        Fri, 26 Nov 2021 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637939675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NssqB285mgLo1X+znBnXILORZfvQv1QAgYQuoeuKZFI=;
        b=qPp4n32/PfrzZFtlpZ8zaPnXFRQV0EpHkkwpJzRH9yZ2C08oqnfQYwuD2vtji4JRmzPpa6
        jqGfrTz9UJC8JuDFhLPTy8RT0b8xddC70fwk6O0c8NjT2vdY/fjfcdTm29RpjCfuJ1X8Ol
        7ldF9J62K61QPRAURtYT1MmYH4LTjWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637939675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NssqB285mgLo1X+znBnXILORZfvQv1QAgYQuoeuKZFI=;
        b=cxmFZhWYeTcbsJVWB0oeohKyeoJF+JNa+hTTODWaNaglpF/eeVhY2jigMPQm6qIMj306XN
        rUsg+bhcBZHFYTCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E39A7A3B83;
        Fri, 26 Nov 2021 15:14:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C1FA51E11F3; Fri, 26 Nov 2021 16:14:34 +0100 (CET)
Date:   Fri, 26 Nov 2021 16:14:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] fanotify: record either old name new name or both
 for FAN_RENAME
Message-ID: <20211126151434.GJ13004@quack2.suse.cz>
References: <20211119071738.1348957-1-amir73il@gmail.com>
 <20211119071738.1348957-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119071738.1348957-8-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-11-21 09:17:36, Amir Goldstein wrote:
> We do not want to report the dirfid+name of a directory whose
> inode/sb are not watched, because watcher may not have permissions
> to see the directory content.
> 
> The FAN_MOVED_FROM/TO flags are used internally to indicate to
> fanotify_alloc_event() if we need to record only the old parent+name,
> only the new parent+name or both.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c | 57 ++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 018b32a57702..c0a3fb1dd066 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -290,6 +290,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	__u32 marks_mask = 0, marks_ignored_mask = 0;
>  	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
>  				     FANOTIFY_EVENT_FLAGS;
> +	__u32 moved_mask = 0;
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>  	struct fsnotify_mark *mark;
> @@ -327,17 +328,44 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			continue;
>  
>  		/*
> -		 * If the event is on a child and this mark is on a parent not
> -		 * watching children, don't send it!
> +		 * In the special case of FAN_RENAME event, inode mark is the
> +		 * mark on the old dir and parent mark is the mark on the new
> +		 * dir.  We do not want to report the dirfid+name of a directory
> +		 * whose inode/sb are not watched.  The FAN_MOVE flags
> +		 * are used internally to indicate if we need to report only
> +		 * the old parent+name, only the new parent+name or both.
>  		 */
> -		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> -		    !(mark->mask & FS_EVENT_ON_CHILD))
> +		if (event_mask & FAN_RENAME) {
> +			/* Old dir sb are watched - report old info */
> +			if (type != FSNOTIFY_OBJ_TYPE_PARENT &&
> +			    (mark->mask & FAN_RENAME))
> +				moved_mask |= FAN_MOVED_FROM;
> +			/* New dir sb are watched - report new info */
> +			if (type != FSNOTIFY_OBJ_TYPE_INODE &&
> +			    (mark->mask & FAN_RENAME))
> +				moved_mask |= FAN_MOVED_TO;
> +		} else if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> +			   !(mark->mask & FS_EVENT_ON_CHILD)) {
> +			/*
> +			 * If the event is on a child and this mark is on
> +			 * a parent not watching children, don't send it!
> +			 */
>  			continue;
> +		}

It feels a bit hacky to mix the "what info to report" into the mask
especially as otherwise perfectly valid flags. Can we perhaps have a
separate function to find this out (like fanotify_rename_info_report_mask()
or something like that) and use it in fanotify_alloc_event() or directly in
fanotify_handle_event() and pass the result to fanotify_alloc_event()?
That would seem a bit cleaner to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
