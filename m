Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC03E1146
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhHEJ2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 05:28:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHEJ2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:28:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 301332226C;
        Thu,  5 Aug 2021 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628155684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlYdohB95unYz6/tvW7hBNGYrUXFl+shMJ6xvA7lPuU=;
        b=xCebBMjhkUU4ztmF70ADRaFzeGGWIuBAy38NANVRsi1ehti5sIHfCbCcP12rYT2WoFs6k/
        1fM4zqPvRI+kuGryodq5+ON4zRXTtfhHIkPqGsKRYEMuIL1KrVl6/UoVXzSxhABJtvIRvO
        I7tnS5/VCXGF2ikPBrnH8wywMkih2iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628155684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlYdohB95unYz6/tvW7hBNGYrUXFl+shMJ6xvA7lPuU=;
        b=Y0Q09UN4fOWcpDKuspcOHZxV3+BCjsEQicWAOA9qqX+eebudbnVPpAVEhPzP1zOqRpcWEv
        iz4o4EAehCgGxjAg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 16A36A3B92;
        Thu,  5 Aug 2021 09:28:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A76241E1514; Thu,  5 Aug 2021 11:28:03 +0200 (CEST)
Date:   Thu, 5 Aug 2021 11:28:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 08/23] fsnotify: Add wrapper around fsnotify_add_event
Message-ID: <20210805092803.GD14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-9-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:05:57, Gabriel Krisman Bertazi wrote:
> fsnotify_add_event is growing in number of parameters, which is most
							      ^^ in most
cases...

> case are just passed a NULL pointer.  So, split out a new
> fsnotify_insert_event function to clean things up for users who don't
> need an insert hook.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c        |  4 ++--
>  fs/notify/inotify/inotify_fsnotify.c |  2 +-
>  fs/notify/notification.c             | 12 ++++++------
>  include/linux/fsnotify_backend.h     | 23 ++++++++++++++++-------
>  4 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index c3eefe3f6494..acf78c0ed219 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -781,8 +781,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	}
>  
>  	fsn_event = &event->fse;
> -	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -				 fanotify_insert_event);
> +	ret = fsnotify_insert_event(group, fsn_event, fanotify_merge,
> +				    fanotify_insert_event);
>  	if (ret) {
>  		/* Permission events shouldn't be merged */
>  		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index d1a64daa0171..a96582cbfad1 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  	if (len)
>  		strcpy(event->name, name->name);
>  
> -	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
> +	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
>  	if (ret) {
>  		/* Our event wasn't used in the end. Free it. */
>  		fsnotify_destroy_event(group, fsn_event);
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 32f45543b9c6..44bb10f50715 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -78,12 +78,12 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
>   * 2 if the event was not queued - either the queue of events has overflown
>   *   or the group is shutting down.
>   */
> -int fsnotify_add_event(struct fsnotify_group *group,
> -		       struct fsnotify_event *event,
> -		       int (*merge)(struct fsnotify_group *,
> -				    struct fsnotify_event *),
> -		       void (*insert)(struct fsnotify_group *,
> -				      struct fsnotify_event *))
> +int fsnotify_insert_event(struct fsnotify_group *group,
> +			  struct fsnotify_event *event,
> +			  int (*merge)(struct fsnotify_group *,
> +				       struct fsnotify_event *),
> +			  void (*insert)(struct fsnotify_group *,
> +					 struct fsnotify_event *))
>  {
>  	int ret = 0;
>  	struct list_head *list = &group->notification_list;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 2b5fb9327a77..cd4ca11f129e 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -495,16 +495,25 @@ extern int fsnotify_fasync(int fd, struct file *file, int on);
>  extern void fsnotify_destroy_event(struct fsnotify_group *group,
>  				   struct fsnotify_event *event);
>  /* attach the event to the group notification queue */
> -extern int fsnotify_add_event(struct fsnotify_group *group,
> -			      struct fsnotify_event *event,
> -			      int (*merge)(struct fsnotify_group *,
> -					   struct fsnotify_event *),
> -			      void (*insert)(struct fsnotify_group *,
> -					     struct fsnotify_event *));
> +extern int fsnotify_insert_event(struct fsnotify_group *group,
> +				 struct fsnotify_event *event,
> +				 int (*merge)(struct fsnotify_group *,
> +					      struct fsnotify_event *),
> +				 void (*insert)(struct fsnotify_group *,
> +						struct fsnotify_event *));
> +
> +static inline int fsnotify_add_event(struct fsnotify_group *group,
> +				     struct fsnotify_event *event,
> +				     int (*merge)(struct fsnotify_group *,
> +						  struct fsnotify_event *))
> +{
> +	return fsnotify_insert_event(group, event, merge, NULL);
> +}
> +
>  /* Queue overflow event to a notification group */
>  static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>  {
> -	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
> +	fsnotify_add_event(group, group->overflow_event, NULL);
>  }
>  
>  static inline bool fsnotify_is_overflow_event(u32 mask)
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
