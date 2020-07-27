Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366D622FB5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgG0V1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 17:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgG0V1k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 016D0B14B;
        Mon, 27 Jul 2020 21:27:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 442891E12C7; Mon, 27 Jul 2020 23:27:38 +0200 (CEST)
Date:   Mon, 27 Jul 2020 23:27:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fsnotify: create method handle_inode_event() in
 fsnotify_operations
Message-ID: <20200727212738.GK5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-9-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-9-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:48, Amir Goldstein wrote:
> The method handle_event() grew a lot of complexity due to the design of
> fanotify and merging of ignore masks.
> 
> Most backends do not care about this complex functionality, so we can hide
> this complexity from them.
> 
> Introduce a method handle_inode_event() that serves those backends and
> passes a single inode mark and less arguments.
> 
> This change converts all backends except fanotify and inotify to use the
> simplified handle_inode_event() method.  In pricipal, inotify could have
> also used the new method, but that would require passing more arguments
> on the simple helper (data, data_type, cookie), so we leave it with the
> handle_event() method.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks. Applied.

								Honza
> ---
>  fs/nfsd/filecache.c              | 12 +++-----
>  fs/notify/dnotify/dnotify.c      | 38 +++++------------------
>  fs/notify/fsnotify.c             | 52 ++++++++++++++++++++++++++++++--
>  include/linux/fsnotify_backend.h | 19 ++++++++++--
>  kernel/audit_fsnotify.c          | 20 +++++-------
>  kernel/audit_tree.c              | 10 +++---
>  kernel/audit_watch.c             | 17 +++++------
>  7 files changed, 97 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index bbc7892d2928..c8b9d2667ee6 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -598,14 +598,10 @@ static struct notifier_block nfsd_file_lease_notifier = {
>  };
>  
>  static int
> -nfsd_file_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
> -				const void *data, int data_type,
> -				struct inode *dir,
> -				const struct qstr *file_name, u32 cookie,
> -				struct fsnotify_iter_info *iter_info)
> +nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
> +				struct inode *inode, struct inode *dir,
> +				const struct qstr *name)
>  {
> -	struct inode *inode = fsnotify_data_inode(data, data_type);
> -
>  	trace_nfsd_file_fsnotify_handle_event(inode, mask);
>  
>  	/* Should be no marks on non-regular files */
> @@ -626,7 +622,7 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  
>  static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
> -	.handle_event = nfsd_file_fsnotify_handle_event,
> +	.handle_inode_event = nfsd_file_fsnotify_handle_event,
>  	.free_mark = nfsd_file_mark_free,
>  };
>  
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index ca78d3f78da8..5dcda8f20c04 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -70,8 +70,9 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
>   * destroy the dnotify struct if it was not registered to receive multiple
>   * events.
>   */
> -static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
> -			      struct fsnotify_mark *inode_mark)
> +static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
> +				struct inode *inode, struct inode *dir,
> +				const struct qstr *name)
>  {
>  	struct dnotify_mark *dn_mark;
>  	struct dnotify_struct *dn;
> @@ -79,6 +80,10 @@ static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
>  	struct fown_struct *fown;
>  	__u32 test_mask = mask & ~FS_EVENT_ON_CHILD;
>  
> +	/* not a dir, dnotify doesn't care */
> +	if (!dir && !(mask & FS_ISDIR))
> +		return 0;
> +
>  	dn_mark = container_of(inode_mark, struct dnotify_mark, fsn_mark);
>  
>  	spin_lock(&inode_mark->lock);
> @@ -100,33 +105,6 @@ static void dnotify_one_event(struct fsnotify_group *group, u32 mask,
>  	}
>  
>  	spin_unlock(&inode_mark->lock);
> -}
> -
> -static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
> -				const void *data, int data_type,
> -				struct inode *dir,
> -				const struct qstr *file_name, u32 cookie,
> -				struct fsnotify_iter_info *iter_info)
> -{
> -	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> -	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
> -
> -	/* not a dir, dnotify doesn't care */
> -	if (!dir && !(mask & FS_ISDIR))
> -		return 0;
> -
> -	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
> -		return 0;
> -
> -	/*
> -	 * Some events can be sent on both parent dir and subdir marks
> -	 * (e.g. DN_ATTRIB).  If both parent dir and subdir are watching,
> -	 * report the event once to parent dir and once to subdir.
> -	 */
> -	if (inode_mark)
> -		dnotify_one_event(group, mask, inode_mark);
> -	if (child_mark)
> -		dnotify_one_event(group, mask, child_mark);
>  
>  	return 0;
>  }
> @@ -143,7 +121,7 @@ static void dnotify_free_mark(struct fsnotify_mark *fsn_mark)
>  }
>  
>  static const struct fsnotify_ops dnotify_fsnotify_ops = {
> -	.handle_event = dnotify_handle_event,
> +	.handle_inode_event = dnotify_handle_event,
>  	.free_mark = dnotify_free_mark,
>  };
>  
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 494d5d70323f..a960ec3a569a 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -230,6 +230,49 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  }
>  EXPORT_SYMBOL_GPL(__fsnotify_parent);
>  
> +static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> +				 const void *data, int data_type,
> +				 struct inode *dir, const struct qstr *name,
> +				 u32 cookie, struct fsnotify_iter_info *iter_info)
> +{
> +	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> +	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
> +	struct inode *inode = fsnotify_data_inode(data, data_type);
> +	const struct fsnotify_ops *ops = group->ops;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!ops->handle_inode_event))
> +		return 0;
> +
> +	if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
> +	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
> +		return 0;
> +
> +	/*
> +	 * An event can be sent on child mark iterator instead of inode mark
> +	 * iterator because of other groups that have interest of this inode
> +	 * and have marks on both parent and child.  We can simplify this case.
> +	 */
> +	if (!inode_mark) {
> +		inode_mark = child_mark;
> +		child_mark = NULL;
> +		dir = NULL;
> +		name = NULL;
> +	}
> +
> +	ret = ops->handle_inode_event(inode_mark, mask, inode, dir, name);
> +	if (ret || !child_mark)
> +		return ret;
> +
> +	/*
> +	 * Some events can be sent on both parent dir and child marks
> +	 * (e.g. FS_ATTRIB).  If both parent dir and child are watching,
> +	 * report the event once to parent dir with name and once to child
> +	 * without name.
> +	 */
> +	return ops->handle_inode_event(child_mark, mask, inode, NULL, NULL);
> +}
> +
>  static int send_to_group(__u32 mask, const void *data, int data_type,
>  			 struct inode *dir, const struct qstr *file_name,
>  			 u32 cookie, struct fsnotify_iter_info *iter_info)
> @@ -275,8 +318,13 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>  	if (!(test_mask & marks_mask & ~marks_ignored_mask))
>  		return 0;
>  
> -	return group->ops->handle_event(group, mask, data, data_type, dir,
> -					file_name, cookie, iter_info);
> +	if (group->ops->handle_event) {
> +		return group->ops->handle_event(group, mask, data, data_type, dir,
> +						file_name, cookie, iter_info);
> +	}
> +
> +	return fsnotify_handle_event(group, mask, data, data_type, dir,
> +				     file_name, cookie, iter_info);
>  }
>  
>  static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 32104cfc27a5..f8529a3a2923 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -128,17 +128,30 @@ struct mem_cgroup;
>   * @cookie:	inotify rename cookie
>   * @iter_info:	array of marks from this group that are interested in the event
>   *
> + * handle_inode_event - simple variant of handle_event() for groups that only
> + *		have inode marks and don't have ignore mask
> + * @mark:	mark to notify
> + * @mask:	event type and flags
> + * @inode:	inode that event happened on
> + * @dir:	optional directory associated with event -
> + *		if @file_name is not NULL, this is the directory that
> + *		@file_name is relative to.
> + * @file_name:	optional file name associated with event
> + *
>   * free_group_priv - called when a group refcnt hits 0 to clean up the private union
>   * freeing_mark - called when a mark is being destroyed for some reason.  The group
> - * 		MUST be holding a reference on each mark and that reference must be
> - * 		dropped in this function.  inotify uses this function to send
> - * 		userspace messages that marks have been removed.
> + *		MUST be holding a reference on each mark and that reference must be
> + *		dropped in this function.  inotify uses this function to send
> + *		userspace messages that marks have been removed.
>   */
>  struct fsnotify_ops {
>  	int (*handle_event)(struct fsnotify_group *group, u32 mask,
>  			    const void *data, int data_type, struct inode *dir,
>  			    const struct qstr *file_name, u32 cookie,
>  			    struct fsnotify_iter_info *iter_info);
> +	int (*handle_inode_event)(struct fsnotify_mark *mark, u32 mask,
> +			    struct inode *inode, struct inode *dir,
> +			    const struct qstr *file_name);
>  	void (*free_group_priv)(struct fsnotify_group *group);
>  	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
>  	void (*free_event)(struct fsnotify_event *event);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index bd3a6b79316a..bfcfcd61adb6 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -152,35 +152,31 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
>  }
>  
>  /* Update mark data in audit rules based on fsnotify events. */
> -static int audit_mark_handle_event(struct fsnotify_group *group, u32 mask,
> -				   const void *data, int data_type,
> -				   struct inode *dir,
> -				   const struct qstr *dname, u32 cookie,
> -				   struct fsnotify_iter_info *iter_info)
> +static int audit_mark_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
> +				   struct inode *inode, struct inode *dir,
> +				   const struct qstr *dname)
>  {
> -	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
>  	struct audit_fsnotify_mark *audit_mark;
> -	const struct inode *inode = fsnotify_data_inode(data, data_type);
>  
>  	audit_mark = container_of(inode_mark, struct audit_fsnotify_mark, mark);
>  
> -	BUG_ON(group != audit_fsnotify_group);
> -
> -	if (WARN_ON(!inode))
> +	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group) ||
> +	    WARN_ON_ONCE(!inode))
>  		return 0;
>  
>  	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
>  		if (audit_compare_dname_path(dname, audit_mark->path, AUDIT_NAME_FULL))
>  			return 0;
>  		audit_update_mark(audit_mark, inode);
> -	} else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
> +	} else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF)) {
>  		audit_autoremove_mark_rule(audit_mark);
> +	}
>  
>  	return 0;
>  }
>  
>  static const struct fsnotify_ops audit_mark_fsnotify_ops = {
> -	.handle_event =	audit_mark_handle_event,
> +	.handle_inode_event = audit_mark_handle_event,
>  	.free_mark = audit_fsnotify_free_mark,
>  };
>  
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 2ce2ac1ce100..025d24abf15d 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -1037,11 +1037,9 @@ static void evict_chunk(struct audit_chunk *chunk)
>  		audit_schedule_prune();
>  }
>  
> -static int audit_tree_handle_event(struct fsnotify_group *group, u32 mask,
> -				   const void *data, int data_type,
> -				   struct inode *dir,
> -				   const struct qstr *file_name, u32 cookie,
> -				   struct fsnotify_iter_info *iter_info)
> +static int audit_tree_handle_event(struct fsnotify_mark *mark, u32 mask,
> +				   struct inode *inode, struct inode *dir,
> +				   const struct qstr *file_name)
>  {
>  	return 0;
>  }
> @@ -1070,7 +1068,7 @@ static void audit_tree_freeing_mark(struct fsnotify_mark *mark,
>  }
>  
>  static const struct fsnotify_ops audit_tree_ops = {
> -	.handle_event = audit_tree_handle_event,
> +	.handle_inode_event = audit_tree_handle_event,
>  	.freeing_mark = audit_tree_freeing_mark,
>  	.free_mark = audit_tree_destroy_watch,
>  };
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index e23d54bcc587..246e5ba704c0 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -464,20 +464,17 @@ void audit_remove_watch_rule(struct audit_krule *krule)
>  }
>  
>  /* Update watch data in audit rules based on fsnotify events. */
> -static int audit_watch_handle_event(struct fsnotify_group *group, u32 mask,
> -				    const void *data, int data_type,
> -				    struct inode *dir,
> -				    const struct qstr *dname, u32 cookie,
> -				    struct fsnotify_iter_info *iter_info)
> +static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
> +				    struct inode *inode, struct inode *dir,
> +				    const struct qstr *dname)
>  {
> -	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> -	const struct inode *inode = fsnotify_data_inode(data, data_type);
>  	struct audit_parent *parent;
>  
>  	parent = container_of(inode_mark, struct audit_parent, mark);
>  
> -	BUG_ON(group != audit_watch_group);
> -	WARN_ON(!inode);
> +	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group) ||
> +	    WARN_ON_ONCE(!inode))
> +		return 0;
>  
>  	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
>  		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
> @@ -490,7 +487,7 @@ static int audit_watch_handle_event(struct fsnotify_group *group, u32 mask,
>  }
>  
>  static const struct fsnotify_ops audit_watch_fsnotify_ops = {
> -	.handle_event = 	audit_watch_handle_event,
> +	.handle_inode_event =	audit_watch_handle_event,
>  	.free_mark =		audit_watch_free_mark,
>  };
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
