Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E038C9A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhEUPDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 11:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236387AbhEUPDd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 11:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4B9613AF;
        Fri, 21 May 2021 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621609330;
        bh=s9CnNkRQaK+pz+0ytxIlIgtNtBQTEg+8ZmkXnFElBck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4aQrpnO5Tqac68FN3/Vk24ND/brc7r+L0F7X0vz7sPAhToG3S0/2GJAIpJnM635E
         uJm5G8C9sgas+zvdVBUFBawQm0Js9dZ6cjwhQNlbP3B8F2OHJNL8BFOKe4Ux5bIe6O
         2Q8L4V1tee4x4SgSD18t49hJzz/5WJh+3S5HVQgEMfQf5yph3tfCMMtYSzLMwVyYj8
         gCod5cYcoeeKXf/i9lWWSlG8MuPKCkW/fzHT9nm+315gFNLNBDEOPMta8tz0DdJjvF
         JKxV2nSWYuSvDjG5y6Nqw/aT4hYBZ3kwAazJf9P0LWd7wbWCHaMDQzjG4ij95ASJaG
         OvQfY8I0vZnWw==
Date:   Fri, 21 May 2021 08:02:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, kernel@collabora.com,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 08/11] fanotify: Introduce FAN_ERROR event
Message-ID: <20210521150209.GB9617@magnolia>
References: <20210521024134.1032503-1-krisman@collabora.com>
 <20210521024134.1032503-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521024134.1032503-9-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 10:41:31PM -0400, Gabriel Krisman Bertazi wrote:
> The FAN_ERROR event is used by filesystem wide monitoring tools to
> receive notifications of type FS_ERROR_EVENT, emited by filesystems when
> a problem is detected.  The error notification includes a generic error
> descriptor.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Changes since v1:
>   - Pass dentry to fanotify_check_fsid (Amir)
>   - FANOTIFY_EVENT_TYPE_ERROR -> FANOTIFY_EVENT_TYPE_FS_ERROR
>   - Merge previous patch into it
>   - Use a single slot
> ---
>  fs/notify/fanotify/fanotify.c      |  74 ++++++++++++++++-
>  fs/notify/fanotify/fanotify.h      |  28 ++++++-
>  fs/notify/fanotify/fanotify_user.c | 123 ++++++++++++++++++++++++++---
>  include/linux/fanotify.h           |   6 +-
>  include/uapi/linux/fanotify.h      |  10 +++
>  5 files changed, 225 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 34e2ee759b39..197291a8c41d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -269,7 +269,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
> -	if (!fid_mode) {
> +	if (!fid_mode && data_type != FSNOTIFY_EVENT_ERROR) {
>  		/* Do we have path to open a file descriptor? */
>  		if (!path)
>  			return 0;
> @@ -657,6 +657,51 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	return event;
>  }
>  
> +static void fanotify_init_error_event(struct fanotify_error_event *event,
> +				      __kernel_fsid_t fsid,
> +				      const struct fs_error_report *report)
> +{
> +	event->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	event->err_count = 1;
> +	event->fsid = fsid;
> +	event->error = report->error;
> +	event->ino = (report->inode) ? report->inode->i_ino : 0;
> +}
> +
> +static int fanotify_queue_error_event(struct fsnotify_iter_info *iter_info,
> +				      struct fsnotify_group *group,
> +				      __kernel_fsid_t fsid,
> +				      const struct fs_error_report *report)
> +{
> +	struct fanotify_mark *mark;
> +	int type;
> +	int ret = -ENOMEM;
> +
> +	fsnotify_foreach_obj_type(type) {
> +		if (!fsnotify_iter_should_report_type(iter_info, type))
> +			continue;
> +		mark = FANOTIFY_MARK(iter_info->marks[type]);
> +	}
> +
> +	spin_lock(&mark->fsn_mark.lock);
> +	if (mark->error_event) {
> +		if (list_empty(&mark->error_event->fae.fse.list)) {
> +			fsnotify_get_mark(&mark->fsn_mark);
> +			fanotify_init_error_event(mark->error_event, fsid, report);
> +			ret = fsnotify_add_event(group, &mark->error_event->fae.fse,
> +						 NULL, NULL);
> +			if (ret)
> +				fsnotify_put_mark(&mark->fsn_mark);
> +		} else {
> +			mark->error_event->err_count++;
> +			ret = 0;
> +		}
> +	}
> +	spin_unlock(&mark->fsn_mark.lock);
> +
> +	return ret;
> +}
> +
>  /*
>   * Get cached fsid of the filesystem containing the object from any connector.
>   * All connectors are supposed to have the same fsid, but we do not verify that
> @@ -738,8 +783,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +	BUILD_BUG_ON(FAN_ERROR != FS_ERROR);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, mask, data,
>  					 data_type, dir);
> @@ -757,13 +803,20 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  			return 0;
>  	}
>  
> -	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
> +	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS) || fanotify_is_error_event(mask)) {
>  		fsid = fanotify_get_fsid(iter_info);
>  		/* Racing with mark destruction or creation? */
>  		if (!fsid.val[0] && !fsid.val[1])
>  			return 0;
>  	}
>  
> +	if (fanotify_is_error_event(mask)) {
> +		ret = fanotify_queue_error_event(iter_info, group, fsid, data);
> +		if (ret)
> +			fsnotify_queue_overflow(group);
> +		goto finish;
> +	}
> +
>  	event = fanotify_alloc_event(group, mask, data, data_type, dir,
>  				     file_name, &fsid);
>  	ret = -ENOMEM;
> @@ -833,6 +886,17 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>  	kfree(FANOTIFY_NE(event));
>  }
>  
> +static void fanotify_free_error_event(struct fanotify_event *event)
> +{
> +	/*
> +	 * Just drop the reference acquired by
> +	 * fanotify_queue_error_event.
> +	 *
> +	 * The actual memory is freed with the mark.
> +	 */
> +	fsnotify_put_mark(&(FANOTIFY_EE(event)->mark->fsn_mark));
> +}
> +
>  static void fanotify_free_event(struct fsnotify_event *fsn_event)
>  {
>  	struct fanotify_event *event;
> @@ -855,6 +919,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
>  	case FANOTIFY_EVENT_TYPE_OVERFLOW:
>  		kfree(event);
>  		break;
> +	case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +		fanotify_free_error_event(event);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  	}
> @@ -871,6 +938,7 @@ static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
>  {
>  	struct fanotify_mark *mark = FANOTIFY_MARK(fsn_mark);
>  
> +	kfree(mark->error_event);
>  	kmem_cache_free(fanotify_mark_cache, mark);
>  }
>  
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a399c5e2615d..ebe9e593dfbf 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -151,6 +151,7 @@ enum fanotify_event_type {
>  	FANOTIFY_EVENT_TYPE_PATH,
>  	FANOTIFY_EVENT_TYPE_PATH_PERM,
>  	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> +	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
>  	__FANOTIFY_EVENT_TYPE_NUM
>  };
>  
> @@ -206,12 +207,31 @@ FANOTIFY_NE(struct fanotify_event *event)
>  	return container_of(event, struct fanotify_name_event, fae);
>  }
>  
> +struct fanotify_error_event {
> +	struct fanotify_event fae;
> +	__kernel_fsid_t fsid;
> +	unsigned long ino;
> +	int error;
> +	u32 err_count;
> +
> +	/* Back reference to the mark this error refers to. */
> +	struct fanotify_mark *mark;
> +};
> +
> +static inline struct fanotify_error_event *
> +FANOTIFY_EE(struct fanotify_event *event)
> +{
> +	return container_of(event, struct fanotify_error_event, fae);
> +}
> +
>  static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_FID)
>  		return &FANOTIFY_FE(event)->fsid;
>  	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>  		return &FANOTIFY_NE(event)->fsid;
> +	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +		return &FANOTIFY_EE(event)->fsid;
>  	else
>  		return NULL;
>  }
> @@ -297,6 +317,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
>  	return container_of(fse, struct fanotify_event, fse);
>  }
>  
> +static inline bool fanotify_is_error_event(u32 mask)
> +{
> +	return mask & FANOTIFY_ERROR_EVENTS;
> +}
> +
>  static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  {
>  	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> @@ -325,7 +350,8 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>   */
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
> -	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
> +	return (!fanotify_is_perm_event(mask) && !fanotify_is_error_event(mask)
> +		&& !(mask & FS_Q_OVERFLOW));
>  }
>  
>  static inline unsigned int fanotify_event_hash_bucket(
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 00210535a78e..ea9b9f8f7c21 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -106,6 +106,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_INFO_HDR_LEN \
>  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> +#define FANOTIFY_INFO_ERROR_LEN \
> +	(sizeof(struct fanotify_event_info_error))
>  
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -126,6 +128,9 @@ static size_t fanotify_event_len(struct fanotify_event *event,
>  	int fh_len;
>  	int dot_len = 0;
>  
> +	if (fanotify_is_error_event(event->mask))
> +		return event_len + FANOTIFY_INFO_ERROR_LEN;
> +
>  	if (!fid_mode)
>  		return event_len;
>  
> @@ -149,6 +154,30 @@ static size_t fanotify_event_len(struct fanotify_event *event,
>  	return event_len;
>  }
>  
> +static struct fanotify_event *fanotify_dequeue_error_event(struct fsnotify_group *group,
> +							   struct fanotify_event *event,
> +							   struct fanotify_error_event *error_event)
> +{
> +	struct fsnotify_mark *mark = &(FANOTIFY_EE(event)->mark->fsn_mark);
> +	/*
> +	 * In order to avoid missing an error count update, the
> +	 * queued event is de-queued and duplicated to an
> +	 * in-stack fanotify_error_event while still inside
> +	 * mark->lock.  Once the event is dequeued, it can be
> +	 * immediately re-used for a new event.
> +	 *
> +	 * The ownership of the mark reference is dropped later
> +	 * by destroy_event.
> +	 */
> +	spin_lock(&mark->lock);
> +	memcpy(error_event, FANOTIFY_EE(event), sizeof(*error_event));
> +	fsnotify_init_event(&error_event->fae.fse);
> +	fsnotify_remove_queued_event(group, &event->fse);
> +	spin_unlock(&mark->lock);
> +
> +	return &error_event->fae;
> +}
> +
>  /*
>   * Remove an hashed event from merge hash table.
>   */
> @@ -173,7 +202,8 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
>   * updated accordingly.
>   */
>  static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> -					    size_t count)
> +					    size_t count,
> +					    struct fanotify_error_event *error_event)
>  {
>  	size_t event_size;
>  	struct fanotify_event *event = NULL;
> @@ -197,9 +227,14 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>  
>  	/*
>  	 * Held the notification_lock the whole time, so this is the
> -	 * same event we peeked above.
> +	 * same event we peeked above, unless it is copied to
> +	 * error_event.
>  	 */
> -	fsnotify_remove_first_event(group);
> +	if (fanotify_is_error_event(event->mask))
> +		event = fanotify_dequeue_error_event(group, event, error_event);
> +	else
> +		fsnotify_remove_first_event(group);
> +
>  	if (fanotify_is_perm_event(event->mask))
>  		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
>  	if (fanotify_is_hashed_event(event->mask))
> @@ -309,6 +344,30 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> +static size_t copy_error_info_to_user(struct fanotify_event *event,
> +				      char __user *buf, int count)
> +{
> +	struct fanotify_event_info_error info;
> +	struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +	info.hdr.pad = 0;
> +	info.hdr.len = sizeof(struct fanotify_event_info_error);
> +
> +	if (WARN_ON(count < info.hdr.len))
> +		return -EFAULT;
> +
> +	info.fsid = fee->fsid;
> +	info.error = fee->error;
> +	info.inode = fee->ino;
> +	info.error_count = fee->err_count;
> +
> +	if (copy_to_user(buf, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return info.hdr.len;
> +}
> +
>  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  			     int info_type, const char *name, size_t name_len,
>  			     char __user *buf, size_t count)
> @@ -523,6 +582,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		count -= ret;
>  	}
>  
> +	if (fanotify_is_error_event(event->mask)) {
> +		ret = copy_error_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			return ret;
> +		buf += ret;
> +		count -= ret;
> +	}
> +
>  	return metadata.event_len;
>  
>  out_close_fd:
> @@ -553,6 +620,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>  {
>  	struct fsnotify_group *group;
>  	struct fanotify_event *event;
> +	struct fanotify_error_event error_event;
>  	char __user *start;
>  	int ret;
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> @@ -569,7 +637,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>  		 * in case there are lots of available events.
>  		 */
>  		cond_resched();
> -		event = get_one_event(group, count);
> +		event = get_one_event(group, count, &error_event);
>  		if (IS_ERR(event)) {
>  			ret = PTR_ERR(event);
>  			break;
> @@ -888,16 +956,33 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
>  				    flags, umask);
>  }
>  
> -static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> -				       __u32 mask,
> -				       unsigned int flags)
> +static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> +				       __u32 mask, unsigned int flags,
> +				     __u32 *modified_mask)
>  {
> +	struct fanotify_mark *mark = FANOTIFY_MARK(fsn_mark);
> +	struct fanotify_error_event *error_event = NULL;
> +	bool addition = !(flags & FAN_MARK_IGNORED_MASK);
>  	__u32 oldmask = -1;
>  
> +	/* Only pre-alloc error_event if needed. */
> +	if (addition && (mask & FAN_ERROR) && !mark->error_event) {
> +		error_event = kzalloc(sizeof(*error_event), GFP_KERNEL);
> +		if (!error_event)
> +			return -ENOMEM;
> +		fanotify_init_event(&error_event->fae, 0, FS_ERROR);
> +		error_event->mark = mark;
> +	}
> +
>  	spin_lock(&fsn_mark->lock);
> -	if (!(flags & FAN_MARK_IGNORED_MASK)) {
> +	if (addition) {
>  		oldmask = fsn_mark->mask;
>  		fsn_mark->mask |= mask;
> +
> +		if (!mark->error_event) {
> +			mark->error_event = error_event;
> +			error_event = NULL;
> +		}
>  	} else {
>  		fsn_mark->ignored_mask |= mask;
>  		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
> @@ -905,7 +990,11 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>  	}
>  	spin_unlock(&fsn_mark->lock);
>  
> -	return mask & ~oldmask;
> +	kfree(error_event);
> +
> +	*modified_mask = mask & ~oldmask;
> +	return 0;
> +
>  }
>  
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
> @@ -955,6 +1044,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  {
>  	struct fsnotify_mark *fsn_mark;
>  	__u32 added;
> +	int ret = 0;
>  
>  	mutex_lock(&group->mark_mutex);
>  	fsn_mark = fsnotify_find_mark(connp, group);
> @@ -965,13 +1055,18 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  			return PTR_ERR(fsn_mark);
>  		}
>  	}
> -	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
> +	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &added);
> +	if (ret)
> +		goto out;
> +
>  	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
>  		fsnotify_recalc_mask(fsn_mark->connector);
> +
> +out:
>  	mutex_unlock(&group->mark_mutex);
>  
>  	fsnotify_put_mark(fsn_mark);
> -	return 0;
> +	return ret;
>  }
>  
>  static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
> @@ -1377,6 +1472,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  
>  		fsid = &__fsid;
>  	}
> +	if (mask & FAN_ERROR) {
> +		ret = fanotify_test_fsid(path.dentry, &__fsid);
> +		if (ret)
> +			goto path_put_and_out;
> +		fsid = &__fsid;
> +	}
>  
>  	/* inode held in place by reference to path; group by fget on fd */
>  	if (mark_type == FAN_MARK_INODE)
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index bad41bcb25df..05c929d588e4 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -81,9 +81,12 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
>  				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>  
> +#define FANOTIFY_ERROR_EVENTS	(FAN_ERROR)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
> -				 FANOTIFY_INODE_EVENTS)
> +				 FANOTIFY_INODE_EVENTS | \
> +				 FANOTIFY_ERROR_EVENTS)
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> @@ -95,6 +98,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  /* Events that may be reported to user */
>  #define FANOTIFY_OUTGOING_EVENTS	(FANOTIFY_EVENTS | \
>  					 FANOTIFY_PERM_EVENTS | \
> +					 FANOTIFY_ERROR_EVENTS | \
>  					 FAN_Q_OVERFLOW | FAN_ONDIR)
>  
>  #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index fbf9c5c7dd59..e3920597112f 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -20,6 +20,7 @@
>  #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
>  
>  #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
> +#define FAN_ERROR		0x00008000	/* Filesystem error */
>  
>  #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
>  #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
> @@ -123,6 +124,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_FID		1
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>  #define FAN_EVENT_INFO_TYPE_DFID	3
> +#define FAN_EVENT_INFO_TYPE_ERROR	4
>  
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -148,6 +150,14 @@ struct fanotify_event_info_fid {
>  	unsigned char handle[0];
>  };
>  
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	int error;
> +	__kernel_fsid_t fsid;
> +	unsigned long inode;

This ought to be __u64 (i.e. guaranteed 64-bit quantity) since this
struct is part of the is userspace ABI and you don't want to deal with
i386-on-x64 translation headaches.  The same goes for
fanotify_error_event.inode since it feeds this field.

--D

> +	__u32 error_count;
> +};
> +
>  struct fanotify_response {
>  	__s32 fd;
>  	__u32 response;
> -- 
> 2.31.0
> 
