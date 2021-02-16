Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4431CCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 16:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBPPKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 10:10:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhBPPKm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:10:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0880AC90;
        Tue, 16 Feb 2021 15:10:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7A9BE1F2AA7; Tue, 16 Feb 2021 16:10:00 +0100 (CET)
Date:   Tue, 16 Feb 2021 16:10:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fsnotify: read events from hashed notification queue
 by order of insertion
Message-ID: <20210216151000.GC21108@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202162010.305971-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-02-21 18:20:06, Amir Goldstein wrote:
> On 64bit arch, use the available 32bit in event for next_bucket field,
> that is used to chain all events by order of insertion.
> 
> The group has a cursor for the bucket containing the first event and
> every event stores the bucket of the next event to read.
> 
> On 32bit arch, hashed notification queue is disabled.

I would not bother with saving 4-bytes per event on 32-bit archs... IMHO it
is just not worth the additional code complexity and ifdefs...

Otherwise the patch looks fine.

								Honza

> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/notification.c         | 49 ++++++++++++++++++++++++--------
>  include/linux/fsnotify_backend.h | 42 +++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 58c8f6c1be1b..d98f4c8bfb0e 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -84,8 +84,8 @@ static void fsnotify_queue_check(struct fsnotify_group *group)
>  	if (fsnotify_notify_queue_is_empty(group))
>  		return;
>  
> -	first_empty = list_empty(&group->notification_list[group->first_bucket]);
> -	last_empty = list_empty(&group->notification_list[group->last_bucket]);
> +	first_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->first_bucket]));
> +	last_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->last_bucket]));
>  
>  	list = &group->notification_list[0];
>  	for (i = 0; i <= group->max_bucket; i++, list++) {
> @@ -121,12 +121,23 @@ static void fsnotify_queue_event(struct fsnotify_group *group,
>  
>  	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__, group, event, b);
>  
> -	/*
> -	 * TODO: set next_bucket of last event.
> -	 */
> -	group->last_bucket = b;
> -	if (!group->num_events)
> -		group->first_bucket = b;
> +	if (fsnotify_notify_queue_is_hashed(group)) {
> +		/*
> +		 * On first insert, set this event's list as the list to read first event.
> +		 * Otherwise, point from last event to this event's list.
> +		 */
> +		struct list_head *last_l = &group->notification_list[group->last_bucket];
> +
> +		if (!group->num_events) {
> +			group->first_bucket = b;
> +		} else if (!WARN_ON_ONCE(list_empty(last_l))) {
> +			struct fsnotify_event *last_e;
> +
> +			last_e = list_last_entry(last_l, struct fsnotify_event, list);
> +			fsnotify_event_set_next_bucket(last_e, b);
> +		}
> +		group->last_bucket = b;
> +	}
>  	group->num_events++;
>  	list_add_tail(&event->list, list);
>  }
> @@ -186,8 +197,8 @@ int fsnotify_add_event(struct fsnotify_group *group,
>  	return ret;
>  }
>  
> -void fsnotify_remove_queued_event(struct fsnotify_group *group,
> -				  struct fsnotify_event *event)
> +static void __fsnotify_remove_queued_event(struct fsnotify_group *group,
> +					   struct fsnotify_event *event)
>  {
>  	assert_spin_locked(&group->notification_lock);
>  	/*
> @@ -198,6 +209,17 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
>  	group->num_events--;
>  }
>  
> +void fsnotify_remove_queued_event(struct fsnotify_group *group,
> +				  struct fsnotify_event *event)
> +{
> +	/*
> +	 * if called for removal of event in the middle of a hashed queue,
> +	 * events may be read not in insertion order.
> +	 */
> +	WARN_ON_ONCE(fsnotify_notify_queue_is_hashed(group));
> +	__fsnotify_remove_queued_event(group, event);
> +}
> +
>  /* Return the notification list of the first event */
>  struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group)
>  {
> @@ -213,6 +235,7 @@ struct list_head *fsnotify_first_notification_list(struct fsnotify_group *group)
>  		return list;
>  
>  	/*
> +	 * Oops... first bucket is not supposed to be empty.
>  	 * Look for any non-empty bucket.
>  	 */
>  	fsnotify_queue_check(group);
> @@ -239,10 +262,12 @@ struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
>  	pr_debug("%s: group=%p bucket=%u\n", __func__, group, group->first_bucket);
>  
>  	event = list_first_entry(list, struct fsnotify_event, list);
> -	fsnotify_remove_queued_event(group, event);
> +	__fsnotify_remove_queued_event(group, event);
>  	/*
> -	 * TODO: update group->first_bucket to next_bucket in first event.
> +	 * Removed event points to the next list to read from.
>  	 */
> +	group->first_bucket = fsnotify_event_next_bucket(event);
> +
>  	return event;
>  }
>  
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b2a80bc00108..3fc3c9e4d21c 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -161,9 +161,12 @@ struct fsnotify_ops {
>  };
>  
>  #ifdef CONFIG_FANOTIFY
> +#if BITS_PER_LONG == 64
> +/* Use available 32bit of event for hashed queue support */
>  #define FSNOTIFY_HASHED_QUEUE
>  #define FSNOTIFY_HASHED_QUEUE_MAX_BITS 8
>  #endif
> +#endif
>  
>  /*
>   * all of the information about the original object we want to now send to
> @@ -173,6 +176,9 @@ struct fsnotify_ops {
>  struct fsnotify_event {
>  	struct list_head list;
>  	unsigned int key;		/* Key for hashed queue add/merge */
> +#ifdef FSNOTIFY_HASHED_QUEUE
> +	unsigned int next_bucket;	/* Bucket to read next event from */
> +#endif
>  };
>  
>  /*
> @@ -277,6 +283,41 @@ static inline struct list_head *fsnotify_event_notification_list(
>  	return &group->notification_list[fsnotify_event_bucket(group, event)];
>  }
>  
> +#ifdef FSNOTIFY_HASHED_QUEUE
> +static inline bool fsnotify_notify_queue_is_hashed(struct fsnotify_group *group)
> +{
> +	return group->max_bucket > 0;
> +}
> +
> +static inline unsigned int fsnotify_event_next_bucket(struct fsnotify_event *event)
> +{
> +	return event->next_bucket;
> +}
> +
> +static inline void fsnotify_event_set_next_bucket(struct fsnotify_event *event,
> +						  unsigned int b)
> +{
> +	event->next_bucket = b;
> +}
> +
> +#else
> +static inline bool fsnotify_notify_queue_is_hashed(struct fsnotify_group *group)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int fsnotify_event_next_bucket(struct fsnotify_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline void fsnotify_event_set_next_bucket(struct fsnotify_event *event,
> +						  unsigned int b)
> +{
> +}
> +
> +#endif
> +
>  /* When calling fsnotify tell it if the data is a path or inode */
>  enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
> @@ -620,6 +661,7 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
>  {
>  	INIT_LIST_HEAD(&event->list);
>  	event->key = key;
> +	fsnotify_event_set_next_bucket(event, 0);
>  }
>  
>  #else
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
