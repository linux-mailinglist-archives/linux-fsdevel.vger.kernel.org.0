Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141BC42F100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhJOMgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 08:36:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41378 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhJOMgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:36:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A9B22199F;
        Fri, 15 Oct 2021 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634301284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySGEJPQ6JM2A+1KhXAPems8FH92AEnmkUlMEW9Yo4Pk=;
        b=K8RbZHPhvG6fJVpPKR7vg4QrrvPaqqy0uKioebeJCeiVia6dGefqzjNZD/XB+92uXHV7wr
        dJ5lCYfOzL1IAqBAeKayPXEFQAn/QVmONlgN5350kFQMTFELhdItlP0Z5abnv3umaIzES+
        i4PjCgZ0zaA3PMpYUZnpXoeHotHxEgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634301284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySGEJPQ6JM2A+1KhXAPems8FH92AEnmkUlMEW9Yo4Pk=;
        b=DpWFKj0U5rqHAQkBFFYOLYgeuwTG247MF97+XDnaTSVM93+yEPB1h7bT/Sw5cXnbstcrX4
        y6rO9e//CRNUY4Aw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 06801A3B81;
        Fri, 15 Oct 2021 12:34:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D6B8D1E0A40; Fri, 15 Oct 2021 14:34:40 +0200 (CEST)
Date:   Fri, 15 Oct 2021 14:34:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 20/28] fanotify: Support enqueueing of error events
Message-ID: <20211015123440.GJ23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-21-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-21-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:38, Gabriel Krisman Bertazi wrote:
> Once an error event is triggered, collect the data from the fs error
> report and enqueue it in the notification group, similarly to what is
> done for other events.  FAN_FS_ERROR is no longer handled specially,
> since the memory is now handled by a preallocated mempool.
> 
> For now, make the event unhashed.  A future patch implements merging for
> these kinds of events.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify.h |  6 ++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 01d68dfc74aa..9b970359570a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -574,6 +574,27 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  	return &fne->fae;
>  }
>  
> +static struct fanotify_event *fanotify_alloc_error_event(
> +						struct fsnotify_group *group,
> +						__kernel_fsid_t *fsid,
> +						const void *data, int data_type)
> +{
> +	struct fs_error_report *report =
> +			fsnotify_data_error_report(data, data_type);
> +	struct fanotify_error_event *fee;
> +
> +	if (WARN_ON(!report))
> +		return NULL;
> +
> +	fee = mempool_alloc(&group->fanotify_data.error_events_pool, GFP_NOFS);
> +	if (!fee)
> +		return NULL;
> +
> +	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +
> +	return &fee->fae;
> +}
> +
>  static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  						   u32 mask, const void *data,
>  						   int data_type, struct inode *dir,
> @@ -641,6 +662,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  
>  	if (fanotify_is_perm_event(mask)) {
>  		event = fanotify_alloc_perm_event(path, gfp);
> +	} else if (fanotify_is_error_event(mask)) {
> +		event = fanotify_alloc_error_event(group, fsid, data,
> +						   data_type);
>  	} else if (name_event && (file_name || child)) {
>  		event = fanotify_alloc_name_event(id, fsid, file_name, child,
>  						  &hash, gfp);
> @@ -850,6 +874,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>  	kfree(FANOTIFY_NE(event));
>  }
>  
> +static void fanotify_free_error_event(struct fsnotify_group *group,
> +				      struct fanotify_event *event)
> +{
> +	struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +	mempool_free(fee, &group->fanotify_data.error_events_pool);
> +}
> +
>  static void fanotify_free_event(struct fsnotify_group *group,
>  				struct fsnotify_event *fsn_event)
>  {
> @@ -873,6 +905,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
>  	case FANOTIFY_EVENT_TYPE_OVERFLOW:
>  		kfree(event);
>  		break;
> +	case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +		fanotify_free_error_event(group, event);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  	}
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a577e87fac2b..ebef952481fa 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -298,6 +298,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
>  	return container_of(fse, struct fanotify_event, fse);
>  }
>  
> +static inline bool fanotify_is_error_event(u32 mask)
> +{
> +	return mask & FAN_FS_ERROR;
> +}
> +
>  static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  {
>  	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> @@ -327,6 +332,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>  	return !(fanotify_is_perm_event(mask) ||
> +		 fanotify_is_error_event(mask) ||
>  		 fsnotify_is_overflow_event(mask));
>  }
>  
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
