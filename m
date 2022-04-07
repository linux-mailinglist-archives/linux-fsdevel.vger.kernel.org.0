Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE504F81DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiDGOiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiDGOiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:38:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6667B138367
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 07:35:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1547C1F85E;
        Thu,  7 Apr 2022 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649342153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y44GgrTfiaJSKRrhB/WjfGaJ4GhRmijbxD7TrF5CCwQ=;
        b=y/hDUfBT8rGuo0eSeZoyTUBYDEPW9SclKXPEHTYPhMmCYNXb8N2Lp4HSTyktMB6E5rrD37
        gS/Y/nDK9E3rfMWX0dQGYRvuSpKWyewXlvqFbSp1mTdmsvgtjmt++2aoLaPvZ3U1WJzs3N
        cJBQ8lPSsCsBUYgZOhV76Nyt9R1A89c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649342153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y44GgrTfiaJSKRrhB/WjfGaJ4GhRmijbxD7TrF5CCwQ=;
        b=RjHVbZMjGdJfBE+PAUJcTOMLSixiKTVRW0m4UfL5r5+DtpyFLaI4qdjOHTrBUJrrOoOfTn
        mn54dfZyoC4C5ODA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAAB1A3B87;
        Thu,  7 Apr 2022 14:35:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6F8F9A061A; Thu,  7 Apr 2022 16:35:52 +0200 (CEST)
Date:   Thu, 7 Apr 2022 16:35:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] fsnotify: create helpers for group mark_mutex
 lock
Message-ID: <20220407143552.c6cddwtus6eaut2j@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329074904.2980320-7-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-03-22 10:48:54, Amir Goldstein wrote:
> Create helpers to take and release the group mark_mutex lock.
> 
> Define a flag FSNOTIFY_GROUP_NOFS in fsnotify backend operations struct
> that determines if the mark_mutex lock is fs reclaim safe or not.
> If not safe, the nofs lock helpers should be used to take the lock and
> disable direct fs reclaim.
> 
> In that case we annotate the mutex with different lockdep class to
> express to lockdep that an allocation of mark of an fs reclaim safe group
> may take the group lock of another "NOFS" group to evict inodes.
> 
> For now, converted only the callers in common code and no backend
> defines the NOFS flag.  It is intended to be set by fanotify for
> evictable marks support.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

A few design question here:

1) Why do you store the FSNOTIFY_GROUP_NOFS flag in ops? Sure, this
particular flag is probably going to be the same per backend type but it
seems a bit strange to have it in ops instead of in the group itself...

2) Why do we have fsnotify_group_nofs_lock() as well as
fsnotify_group_lock()? We could detect whether we should set nofs based on
group flag anyway. Is that so that callers don't have to bother with passing
around the 'nofs'? Is it too bad? We could also store the old value of
'nofs' inside the group itself after locking it and then unlock can restore
it without the caller needing to care about anything...

								Honza

> ---
>  fs/notify/fdinfo.c               |  5 ++--
>  fs/notify/group.c                | 11 ++++++++
>  fs/notify/mark.c                 | 28 ++++++++++---------
>  include/linux/fsnotify_backend.h | 48 ++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 3451708fd035..754a546d647d 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -27,14 +27,15 @@ static void show_fdinfo(struct seq_file *m, struct file *f,
>  {
>  	struct fsnotify_group *group = f->private_data;
>  	struct fsnotify_mark *mark;
> +	unsigned int nofs;
>  
> -	mutex_lock(&group->mark_mutex);
> +	nofs = fsnotify_group_nofs_lock(group);
>  	list_for_each_entry(mark, &group->marks_list, g_list) {
>  		show(m, mark);
>  		if (seq_has_overflowed(m))
>  			break;
>  	}
> -	mutex_unlock(&group->mark_mutex);
> +	fsnotify_group_nofs_unlock(group, nofs);
>  }
>  
>  #if defined(CONFIG_EXPORTFS)
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index b7d4d64f87c2..0f585febf3d7 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -114,6 +114,7 @@ EXPORT_SYMBOL_GPL(fsnotify_put_group);
>  static struct fsnotify_group *__fsnotify_alloc_group(
>  				const struct fsnotify_ops *ops, gfp_t gfp)
>  {
> +	static struct lock_class_key nofs_marks_lock;
>  	struct fsnotify_group *group;
>  
>  	group = kzalloc(sizeof(struct fsnotify_group), gfp);
> @@ -133,6 +134,16 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>  	INIT_LIST_HEAD(&group->marks_list);
>  
>  	group->ops = ops;
> +	/*
> +	 * For most backends, eviction of inode with a mark is not expected,
> +	 * because marks hold a refcount on the inode against eviction.
> +	 *
> +	 * Use a different lockdep class for groups that support evictable
> +	 * inode marks, because with evictable marks, mark_mutex is NOT
> +	 * fs-reclaim safe - the mutex is taken when evicting inodes.
> +	 */
> +	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
> +		lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
>  
>  	return group;
>  }
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 3faf47def7d8..94d53f9d2b5f 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -383,9 +383,7 @@ void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
>   */
>  void fsnotify_detach_mark(struct fsnotify_mark *mark)
>  {
> -	struct fsnotify_group *group = mark->group;
> -
> -	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
> +	fsnotify_group_assert_locked(mark->group);
>  	WARN_ON_ONCE(!srcu_read_lock_held(&fsnotify_mark_srcu) &&
>  		     refcount_read(&mark->refcnt) < 1 +
>  			!!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED));
> @@ -437,9 +435,11 @@ void fsnotify_free_mark(struct fsnotify_mark *mark)
>  void fsnotify_destroy_mark(struct fsnotify_mark *mark,
>  			   struct fsnotify_group *group)
>  {
> -	mutex_lock(&group->mark_mutex);
> +	unsigned int nofs;
> +
> +	nofs = fsnotify_group_nofs_lock(group);
>  	fsnotify_detach_mark(mark);
> -	mutex_unlock(&group->mark_mutex);
> +	fsnotify_group_nofs_unlock(group, nofs);
>  	fsnotify_free_mark(mark);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_destroy_mark);
> @@ -658,7 +658,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  	struct fsnotify_group *group = mark->group;
>  	int ret = 0;
>  
> -	BUG_ON(!mutex_is_locked(&group->mark_mutex));
> +	fsnotify_group_assert_locked(group);
>  
>  	/*
>  	 * LOCKING ORDER!!!!
> @@ -697,10 +697,11 @@ int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
>  {
>  	int ret;
>  	struct fsnotify_group *group = mark->group;
> +	unsigned int nofs;
>  
> -	mutex_lock(&group->mark_mutex);
> +	nofs = fsnotify_group_nofs_lock(group);
>  	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
> -	mutex_unlock(&group->mark_mutex);
> +	fsnotify_group_nofs_unlock(group, nofs);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_add_mark);
> @@ -739,6 +740,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
>  	struct fsnotify_mark *lmark, *mark;
>  	LIST_HEAD(to_free);
>  	struct list_head *head = &to_free;
> +	unsigned int nofs;
>  
>  	/* Skip selection step if we want to clear all marks. */
>  	if (obj_type == FSNOTIFY_OBJ_TYPE_ANY) {
> @@ -754,24 +756,24 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
>  	 * move marks to free to to_free list in one go and then free marks in
>  	 * to_free list one by one.
>  	 */
> -	mutex_lock(&group->mark_mutex);
> +	nofs = fsnotify_group_nofs_lock(group);
>  	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
>  		if (mark->connector->type == obj_type)
>  			list_move(&mark->g_list, &to_free);
>  	}
> -	mutex_unlock(&group->mark_mutex);
> +	fsnotify_group_nofs_unlock(group, nofs);
>  
>  clear:
>  	while (1) {
> -		mutex_lock(&group->mark_mutex);
> +		nofs = fsnotify_group_nofs_lock(group);
>  		if (list_empty(head)) {
> -			mutex_unlock(&group->mark_mutex);
> +			fsnotify_group_nofs_unlock(group, nofs);
>  			break;
>  		}
>  		mark = list_first_entry(head, struct fsnotify_mark, g_list);
>  		fsnotify_get_mark(mark);
>  		fsnotify_detach_mark(mark);
> -		mutex_unlock(&group->mark_mutex);
> +		fsnotify_group_nofs_unlock(group, nofs);
>  		fsnotify_free_mark(mark);
>  		fsnotify_put_mark(mark);
>  	}
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 9e8b5b52b9de..083333ad451c 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -20,6 +20,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/refcount.h>
>  #include <linux/mempool.h>
> +#include <linux/sched/mm.h>
>  
>  /*
>   * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
> @@ -152,6 +153,10 @@ struct mem_cgroup;
>   *		userspace messages that marks have been removed.
>   */
>  struct fsnotify_ops {
> +#define FSNOTIFY_GROUP_NOFS	0x01 /* group lock is not direct reclaim safe */
> +#define FSNOTIFY_GROUP_FLAG(group, flag) \
> +	((group)->ops->group_flags & FSNOTIFY_GROUP_ ## flag)
> +	int group_flags;
>  	int (*handle_event)(struct fsnotify_group *group, u32 mask,
>  			    const void *data, int data_type, struct inode *dir,
>  			    const struct qstr *file_name, u32 cookie,
> @@ -250,6 +255,49 @@ struct fsnotify_group {
>  	};
>  };
>  
> +/*
> + * Use this from common code to prevent deadlock when reclaiming inodes with
> + * evictable marks of the same group that is allocating a new mark.
> + */
> +static inline unsigned int fsnotify_group_nofs_lock(
> +						struct fsnotify_group *group)
> +{
> +	unsigned int nofs = current->flags & PF_MEMALLOC_NOFS;
> +
> +	mutex_lock(&group->mark_mutex);
> +	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
> +		nofs = memalloc_nofs_save();
> +	return nofs;
> +}
> +
> +static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
> +{
> +	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
> +	if (FSNOTIFY_GROUP_FLAG(group, NOFS))
> +		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
> +}
> +
> +static inline void fsnotify_group_nofs_unlock(struct fsnotify_group *group,
> +					      unsigned int nofs)
> +{
> +	memalloc_nofs_restore(nofs);
> +	mutex_unlock(&group->mark_mutex);
> +}
> +
> +/*
> + * Use this from common code that does not allocate memory or from backends
> + * who are known to be fs reclaim safe (i.e. no evictable inode marks).
> + */
> +static inline void fsnotify_group_lock(struct fsnotify_group *group)
> +{
> +	mutex_lock(&group->mark_mutex);
> +}
> +
> +static inline void fsnotify_group_unlock(struct fsnotify_group *group)
> +{
> +	mutex_unlock(&group->mark_mutex);
> +}
> +
>  /* When calling fsnotify tell it if the data is a path or inode */
>  enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
