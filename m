Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825BC31CC92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhBPPDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 10:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhBPPD2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:03:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85828AD4E;
        Tue, 16 Feb 2021 15:02:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B78A1F2AA7; Tue, 16 Feb 2021 16:02:47 +0100 (CET)
Date:   Tue, 16 Feb 2021 16:02:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] fsnotify: support hashed notification queue
Message-ID: <20210216150247.GB21108@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202162010.305971-3-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-02-21 18:20:05, Amir Goldstein wrote:
> In order to improve event merge performance, support sharding the
> notification queue to several notification lists, hashed by an event
> merge key.
> 
> The fanotify event merge key is the object id reduced to 32bit hash.
> 
> At the moment, both inotify and fanotify still use a single notification
> list.
> 
> At the moment, reading events from the hashed queue is not by event
> insertion order.  A non-empty list is read until it is empty.
> 
> The max events limit is accounted for total events in all lists.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Style nit: Please try to stay within 80 columns...

Also I think this change would be more comprehensible if it was merged with
the following patch 3/8. Having code with TODOs is kind of awkward and
makes it more difficult to verify the result is actually correct.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8ff27d92d32c..dee12d927f8d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -635,6 +635,7 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  {
>  	struct fsnotify_group *group;
>  	struct fsnotify_event *fsn_event;
> +	struct list_head *list;
>  	void __user *p;
>  	int ret = -ENOTTY;
>  	size_t send_len = 0;
> @@ -646,8 +647,15 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>  	switch (cmd) {
>  	case FIONREAD:
>  		spin_lock(&group->notification_lock);
> -		list_for_each_entry(fsn_event, &group->notification_list, list)
> -			send_len += FAN_EVENT_METADATA_LEN;
> +		list = fsnotify_first_notification_list(group);
> +		/*
> +		 * With multi queue, send_len will be a lower bound
> +		 * on total events size.
> +		 */
> +		if (list) {
> +			list_for_each_entry(fsn_event, list, list)
> +				send_len += FAN_EVENT_METADATA_LEN;
> +		}

IMO we should just walk all the lists here. Otherwise reported length would
be just odd. That being said the returned value already is odd because we
don't properly account for different event sizes (unrelated problem). So if
we want to keep it simple for now, we can just return group->num_events *
FAN_EVENT_METADATA_LEN, can't we?

> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index ffd723ffe46d..b41ed68f9ff9 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -111,12 +116,20 @@ void fsnotify_put_group(struct fsnotify_group *group)
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_put_group);
>  
> -static struct fsnotify_group *__fsnotify_alloc_group(
> +static struct fsnotify_group *__fsnotify_alloc_group(unsigned int q_hash_bits,
>  				const struct fsnotify_ops *ops, gfp_t gfp)
>  {
>  	struct fsnotify_group *group;
> +	int i;
> +
> +#ifdef FSNOTIFY_HASHED_QUEUE
> +	if (WARN_ON_ONCE(q_hash_bits > FSNOTIFY_HASHED_QUEUE_MAX_BITS))
> +		q_hash_bits = FSNOTIFY_HASHED_QUEUE_MAX_BITS;
> +#else
> +	q_hash_bits = 0;
> +#endif

Why the check for q_hash_bits? We have in-kernel users only so I would not
be that paranoid :) Maybe I'd just let the group specify whether it wants
hashed queue or not and for hashed queues always set number of buckets to
128. So far we don't need anything more flexible and if we ever do, it's
easy enough to change the in-kernel API...

Also, honestly, I find these ifdefs ugly. I'd just leave hashed queues
unconditionally compiled in.

> -	group = kzalloc(sizeof(struct fsnotify_group), gfp);
> +	group = kzalloc(fsnotify_group_size(q_hash_bits), gfp);
>  	if (!group)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -126,8 +139,12 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>  	atomic_set(&group->user_waits, 0);
>  
>  	spin_lock_init(&group->notification_lock);
> -	INIT_LIST_HEAD(&group->notification_list);
>  	init_waitqueue_head(&group->notification_waitq);
> +	/* Initialize one or more notification lists */
> +	group->q_hash_bits = q_hash_bits;
> +	group->max_bucket = (1 << q_hash_bits) - 1;
> +	for (i = 0; i <= group->max_bucket; i++)
> +		INIT_LIST_HEAD(&group->notification_list[i]);
>  	group->max_events = UINT_MAX;
>  
>  	mutex_init(&group->mark_mutex);
> @@ -139,20 +156,24 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>  }
>  
>  /*
> - * Create a new fsnotify_group and hold a reference for the group returned.
> + * Create a new fsnotify_group with no events queue.

How come "no events queue"? There will be always at least one queue...

> + * Hold a reference for the group returned.
>   */
>  struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
>  {
> -	return __fsnotify_alloc_group(ops, GFP_KERNEL);
> +	return __fsnotify_alloc_group(0, ops, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
>  
>  /*
> - * Create a new fsnotify_group and hold a reference for the group returned.
> + * Create a new fsnotify_group with an events queue.
> + * If @q_hash_bits > 0, the queue is shareded into several notification lists.
> + * Hold a reference for the group returned.
>   */
> -struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
> +struct fsnotify_group *fsnotify_alloc_user_group(unsigned int q_hash_bits,
> +						 const struct fsnotify_ops *ops)
>  {
> -	return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
> +	return __fsnotify_alloc_group(q_hash_bits, ops, GFP_KERNEL_ACCOUNT);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
>  
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index d8830be60a9b..1c476b9485dc 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -288,6 +288,7 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
>  {
>  	struct fsnotify_group *group;
>  	struct fsnotify_event *fsn_event;
> +	struct list_head *list;
>  	void __user *p;
>  	int ret = -ENOTTY;
>  	size_t send_len = 0;
> @@ -300,10 +301,16 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case FIONREAD:
>  		spin_lock(&group->notification_lock);
> -		list_for_each_entry(fsn_event, &group->notification_list,
> -				    list) {
> -			send_len += sizeof(struct inotify_event);
> -			send_len += round_event_name_len(fsn_event);
> +		list = fsnotify_first_notification_list(group);
> +		/*
> +		 * With multi queue, send_len will be a lower bound
> +		 * on total events size.
> +		 */
> +		if (list) {
> +			list_for_each_entry(fsn_event, list, list) {
> +				send_len += sizeof(struct inotify_event);
> +				send_len += round_event_name_len(fsn_event);
> +			}

As I write below IMO we should enable hashed queues also for inotify (is
there good reason not to?) and here we should just walk through all the
lists.

>  		}
>  		spin_unlock(&group->notification_lock);
>  		ret = put_user(send_len, (int __user *) p);
> @@ -631,7 +638,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
>  	struct fsnotify_group *group;
>  	struct inotify_event_info *oevent;
>  
> -	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
> +	group = fsnotify_alloc_user_group(0, &inotify_fsnotify_ops);
>  	if (IS_ERR(group))
>  		return group;
>  
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index fcac2d72cbf5..58c8f6c1be1b 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
...
> @@ -74,10 +67,75 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
>  	group->ops->free_event(event);
>  }
>  
> +/* Check and fix inconsistencies in hashed queue */
> +static void fsnotify_queue_check(struct fsnotify_group *group)
> +{
> +#ifdef FSNOTIFY_HASHED_QUEUE
> +	struct list_head *list;
> +	int i, nbuckets = 0;
> +	bool first_empty, last_empty;
> +
> +	assert_spin_locked(&group->notification_lock);
> +
> +	pr_debug("%s: group=%p events: num=%u max=%u buckets: first=%u last=%u max=%u\n",
> +		 __func__, group, group->num_events, group->max_events,
> +		 group->first_bucket, group->last_bucket, group->max_bucket);
> +
> +	if (fsnotify_notify_queue_is_empty(group))
> +		return;
> +
> +	first_empty = list_empty(&group->notification_list[group->first_bucket]);
> +	last_empty = list_empty(&group->notification_list[group->last_bucket]);
> +
> +	list = &group->notification_list[0];
> +	for (i = 0; i <= group->max_bucket; i++, list++) {
> +		if (list_empty(list))
> +			continue;
> +		if (nbuckets++)
> +			continue;
> +		if (first_empty)
> +			group->first_bucket = i;
> +		if (last_empty)
> +			group->last_bucket = i;
> +	}
> +
> +	pr_debug("%s: %u non-empty buckets\n", __func__, nbuckets);
> +
> +	/* All buckets are empty, but non-zero num_events? */
> +	if (WARN_ON_ONCE(!nbuckets && group->num_events))
> +		group->num_events = 0;
> +#endif

Hum, what is this function about? I understand you might want to have this
around for debugging when developing the patch but is there are legitimate
reason for this in production?

I understand current patch uses this function for searching for next
non-empty list but after this patch is merged with the next one, is there
still a need for this?

> @@ -147,17 +228,21 @@ void fsnotify_remove_queued_event(struct fsnotify_group *group,
>  struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
>  {
>  	struct fsnotify_event *event;
> +	struct list_head *list;
>  
>  	assert_spin_locked(&group->notification_lock);
>  
> -	if (fsnotify_notify_queue_is_empty(group))
> +	list = fsnotify_first_notification_list(group);
> +	if (!list)
>  		return NULL;
>  
> -	pr_debug("%s: group=%p\n", __func__, group);
> +	pr_debug("%s: group=%p bucket=%u\n", __func__, group, group->first_bucket);
>  
> -	event = list_first_entry(&group->notification_list,
> -				 struct fsnotify_event, list);
> +	event = list_first_entry(list, struct fsnotify_event, list);

Perhaps the above could just reuse fsnotify_peek_first_event()? It is now
complex enough to be worth it I guess.

>  	fsnotify_remove_queued_event(group, event);
> +	/*
> +	 * TODO: update group->first_bucket to next_bucket in first event.
> +	 */
>  	return event;
>  }
>  
> @@ -167,13 +252,15 @@ struct fsnotify_event *fsnotify_remove_first_event(struct fsnotify_group *group)
>   */
>  struct fsnotify_event *fsnotify_peek_first_event(struct fsnotify_group *group)
>  {
> +	struct list_head *list;
> +
>  	assert_spin_locked(&group->notification_lock);
>  
> -	if (fsnotify_notify_queue_is_empty(group))
> +	list = fsnotify_first_notification_list(group);
> +	if (!list)
>  		return NULL;
>  
> -	return list_first_entry(&group->notification_list,
> -				struct fsnotify_event, list);
> +	return list_first_entry(list, struct fsnotify_event, list);
>  }
>  
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index e5409b83e731..b2a80bc00108 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -160,6 +160,11 @@ struct fsnotify_ops {
>  	void (*free_mark)(struct fsnotify_mark *mark);
>  };
>  
> +#ifdef CONFIG_FANOTIFY
> +#define FSNOTIFY_HASHED_QUEUE
> +#define FSNOTIFY_HASHED_QUEUE_MAX_BITS 8
> +#endif
> +

Would not inotify benefit from this work as well? Also I'd just compile in
hashed queues unconditionally. The ifdefs are ugly and IMHO not worth it.

...

> +static inline size_t fsnotify_group_size(unsigned int q_hash_bits)
> +{
> +	return sizeof(struct fsnotify_group) + (sizeof(struct list_head) << q_hash_bits);
> +}
> +
> +static inline unsigned int fsnotify_event_bucket(struct fsnotify_group *group,
> +						 struct fsnotify_event *event)
> +{
> +	/* High bits are better for hash */
> +	return (event->key >> (32 - group->q_hash_bits)) & group->max_bucket;
> +}

Why not use hash_32() here? IMHO better than just stripping bits...

> +
> +static inline struct list_head *fsnotify_event_notification_list(
> +						struct fsnotify_group *group,
> +						struct fsnotify_event *event)
> +{
> +	return &group->notification_list[fsnotify_event_bucket(group, event)];
> +}
> +

Any reason for this to be in a header? Will it ever have other user than
fsnotify_add_event()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
