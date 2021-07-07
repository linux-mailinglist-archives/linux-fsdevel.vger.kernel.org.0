Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27283BF035
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhGGTZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:25:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGTZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:25:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9CA49200F3;
        Wed,  7 Jul 2021 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625685767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNkwqsKgcTxXDmIyDwiv4itkoXQyBCYGIUT+cv7WsGs=;
        b=uyMABBkSfPgVbsSVfuyUhUQdPVkK6pKhytrHDkXS8vgvcpYSju6iFUUk5KEZoGMpPzZjIf
        5uUPVMUto60EBSRqriSeElAdl615BNsmdSpVn6kJZ3SW5Wu5iBC9Q+yEU05W1Y+o7htbZY
        brTlvfJB9y2P5p/tUIqOyn+uRp57f2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625685767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNkwqsKgcTxXDmIyDwiv4itkoXQyBCYGIUT+cv7WsGs=;
        b=fQaCtZXMj/HEWlwiM8jQ+ABRikgLAoiQ1VlicA3hrxAmZq5yHl1Msikf37SsHQex4audO0
        n/rQhwYlalv/GRDw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 8C1A4A3BB0;
        Wed,  7 Jul 2021 19:22:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 702991F2CD7; Wed,  7 Jul 2021 21:22:47 +0200 (CEST)
Date:   Wed, 7 Jul 2021 21:22:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 02/15] fanotify: Fold event size calculation to its
 own function
Message-ID: <20210707192247.GD18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-3-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:22, Gabriel Krisman Bertazi wrote:
> Every time this function is invoked, it is immediately added to
> FAN_EVENT_METADATA_LEN, since there is no need to just calculate the
> length of info records. This minor clean up folds the rest of the
> calculation into the function, which now operates in terms of events,
> returning the size of the entire event, including metadata.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v1:
>   - rebased on top of hashing patches
> ---
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 64864fb40b40..68a53d3534f8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -117,17 +117,24 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
>  	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
>  }
>  
> -static int fanotify_event_info_len(unsigned int fid_mode,
> -				   struct fanotify_event *event)
> +static size_t fanotify_event_len(struct fanotify_event *event,
> +				 unsigned int fid_mode)
>  {
> -	struct fanotify_info *info = fanotify_event_info(event);
> -	int dir_fh_len = fanotify_event_dir_fh_len(event);
> -	int fh_len = fanotify_event_object_fh_len(event);
> -	int info_len = 0;
> +	size_t event_len = FAN_EVENT_METADATA_LEN;
> +	struct fanotify_info *info;
> +	int dir_fh_len;
> +	int fh_len;
>  	int dot_len = 0;
>  
> +	if (!fid_mode)
> +		return event_len;
> +
> +	info = fanotify_event_info(event);
> +	dir_fh_len = fanotify_event_dir_fh_len(event);
> +	fh_len = fanotify_event_object_fh_len(event);
> +
>  	if (dir_fh_len) {
> -		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
> +		event_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
>  	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
>  		/*
>  		 * With group flag FAN_REPORT_NAME, if name was not recorded in
> @@ -137,9 +144,9 @@ static int fanotify_event_info_len(unsigned int fid_mode,
>  	}
>  
>  	if (fh_len)
> -		info_len += fanotify_fid_info_len(fh_len, dot_len);
> +		event_len += fanotify_fid_info_len(fh_len, dot_len);
>  
> -	return info_len;
> +	return event_len;
>  }
>  
>  /*
> @@ -168,7 +175,7 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
>  static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>  					    size_t count)
>  {
> -	size_t event_size = FAN_EVENT_METADATA_LEN;
> +	size_t event_size;
>  	struct fanotify_event *event = NULL;
>  	struct fsnotify_event *fsn_event;
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> @@ -181,8 +188,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>  		goto out;
>  
>  	event = FANOTIFY_E(fsn_event);
> -	if (fid_mode)
> -		event_size += fanotify_event_info_len(fid_mode, event);
> +	event_size = fanotify_event_len(event, fid_mode);
>  
>  	if (event_size > count) {
>  		event = ERR_PTR(-EINVAL);
> @@ -412,8 +418,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>  
> -	metadata.event_len = FAN_EVENT_METADATA_LEN +
> -				fanotify_event_info_len(fid_mode, event);
> +	metadata.event_len = fanotify_event_len(event, fid_mode);
>  	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
>  	metadata.vers = FANOTIFY_METADATA_VERSION;
>  	metadata.reserved = 0;
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
