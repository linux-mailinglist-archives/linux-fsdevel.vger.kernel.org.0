Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02DE4337F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhJSOF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:05:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSOF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:05:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 459602196B;
        Tue, 19 Oct 2021 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634652194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaZdfAFbiWST4kRcczCi6W+CZd3xcnf9Hcgr/RYGrao=;
        b=HtjyLYDG7pfLSy81G1JqM1sLrwPbzkg43ku/JC3uswJ8kXRafSc4C3UFpKrKWLUd1VRCYG
        IKbZjmd24RFE4stkNhz+Nzy4u6CT+ss4Y4GM+0smnjhth4Q3a4SWSlKYz7Pr093TJEVDiZ
        +hhiOMUAs0feriTo/WOuk+8CIdewEak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634652194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaZdfAFbiWST4kRcczCi6W+CZd3xcnf9Hcgr/RYGrao=;
        b=wy7ncyjohOc6sz/CrzBOriUExvUZjfKGJrrfrrCNmMeQCbV9n+zpCEG7dxlM7fJviZiMF3
        uzThAazj8ZAnsxBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2CA06A3B85;
        Tue, 19 Oct 2021 14:03:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A3AE1E0983; Tue, 19 Oct 2021 16:03:14 +0200 (CEST)
Date:   Tue, 19 Oct 2021 16:03:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 24/32] fanotify: Add helpers to decide whether to
 report FID/DFID
Message-ID: <20211019140314.GM3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-25-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-25-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:07, Gabriel Krisman Bertazi wrote:
> Now that there is an event that reports FID records even for a zeroed
> file handle, wrap the logic that deides whether to issue the records
				    ^^^^ decides

> into helper functions.  This shouldn't have any impact on the code, but
> simplifies further patches.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me but I agree with Amir there's no need to explicit true /
false returns when checking just a simple condition.

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 13 +++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a5e81d759f65..bdf01ad4f9bf 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -265,6 +265,19 @@ static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
>  	return info ? fanotify_info_dir_fh_len(info) : 0;
>  }
>  
> +static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
> +{
> +	if (fanotify_event_object_fh_len(event) > 0)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool fanotify_event_has_dir_fh(struct fanotify_event *event)
> +{
> +	return (fanotify_event_dir_fh_len(event) > 0) ? true : false;
> +}
> +
>  struct fanotify_path_event {
>  	struct fanotify_event fae;
>  	struct path path;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a860c286e885..ae848306a017 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -140,10 +140,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  		return event_len;
>  
>  	info = fanotify_event_info(event);
> -	dir_fh_len = fanotify_event_dir_fh_len(event);
> -	fh_len = fanotify_event_object_fh_len(event);
>  
> -	if (dir_fh_len) {
> +	if (fanotify_event_has_dir_fh(event)) {
> +		dir_fh_len = fanotify_event_dir_fh_len(event);
>  		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
>  	} else if ((info_mode & FAN_REPORT_NAME) &&
>  		   (event->mask & FAN_ONDIR)) {
> @@ -157,8 +156,10 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  	if (info_mode & FAN_REPORT_PIDFD)
>  		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
>  
> -	if (fh_len)
> +	if (fanotify_event_has_object_fh(event)) {
> +		fh_len = fanotify_event_object_fh_len(event);
>  		event_len += fanotify_fid_info_len(fh_len, dot_len);
> +	}
>  
>  	return event_len;
>  }
> @@ -451,7 +452,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  	/*
>  	 * Event info records order is as follows: dir fid + name, child fid.
>  	 */
> -	if (fanotify_event_dir_fh_len(event)) {
> +	if (fanotify_event_has_dir_fh(event)) {
>  		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
>  					     FAN_EVENT_INFO_TYPE_DFID;
>  		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> @@ -467,7 +468,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  		total_bytes += ret;
>  	}
>  
> -	if (fanotify_event_object_fh_len(event)) {
> +	if (fanotify_event_has_object_fh(event)) {
>  		const char *dot = NULL;
>  		int dot_len = 0;
>  
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
