Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAD34313C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJRJsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 05:48:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhJRJsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:48:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D70F91FD6D;
        Mon, 18 Oct 2021 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634550352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSqSWdYZHwDJMR2nnmt6Z+iMd6dthkHw4jJTW3QfW+Q=;
        b=PAn3RUoZi2s0u+HshJ+xn5B53Uf9e8XqBLOcJLeQDyVuM1x9xdKT99jktIu4n1dZP1+I48
        ofa1Wie9DZf3Vn5V74EQQOelrPlTayr4nRTUEyW4uNbEVGVPE6b84v8Llf3iQHrT1+ra4O
        W+qfJBZh8b9apyumBNo/qoHZ4bvfHH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634550352;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSqSWdYZHwDJMR2nnmt6Z+iMd6dthkHw4jJTW3QfW+Q=;
        b=3uBmJGBFGJOnDR6DiLhuPWSbBQ2lIfkQk2yonJVXPY/7LODx1KWwDwNu+yJXrEtWT8t0DJ
        5y59tym+5QcYBRBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8C59DA3B81;
        Mon, 18 Oct 2021 09:45:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0FAA51E0875; Mon, 18 Oct 2021 11:45:52 +0200 (CEST)
Date:   Mon, 18 Oct 2021 11:45:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     rong wang <wangrong@uniontech.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: extend fsnotify for event broadcast
Message-ID: <20211018094552.GC29715@quack2.suse.cz>
References: <20211018064411.10269-1-wangrong@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018064411.10269-1-wangrong@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 14:44:11, rong wang wrote:
> In practical applications, a common requirement is to monitor the changes
> of the entire file system, but the current inotify can only monitor the
> specified target and cannot do anything to monitor the entire file system.
> The limited monitoring of inotify originates from the inode-based event
> dispatch mechanism of fsnotify. In order to monitor the changes of the
> entire file system, consider adding a new event dispatch mechanism, the
> core of which is to broadcast the event once before the event is filtered.
> That is, other modules of the kernel first register the broadcast listener
> with fsnotify. After receiving the event, fsnotify will send the event to
> all the listeners without filtering.
> 
> Signed-off-by: rong wang <wangrong@uniontech.com>

Thanks for the patch but can you ellaborate a bit more on why exactly you
need this mechanism? What would be using it? Without in kernel users it is
useless anyway. Also, since this will execute on each and every filesystem
operation, there will be noticeable overhead on the system unless you are
really careful. So more details please...

Finally also note that fanotify already does support filesystem
(superblock) wide notification events so maybe that is enough for your
purposes?

								Honza

> ---
>  fs/notify/fsnotify.c             | 72 ++++++++++++++++++++++++++++++++
>  include/linux/fsnotify.h         |  8 ++++
>  include/linux/fsnotify_backend.h | 16 +++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 963e6ce75b96..cd235af8c24b 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -14,6 +14,78 @@
>  #include <linux/fsnotify_backend.h>
>  #include "fsnotify.h"
>  
> +/* fs event broadcast */
> +static unsigned int fsnotify_broadcast_listeners_count;
> +static DEFINE_RWLOCK(fsnotify_broadcast_listeners_lock);
> +static LIST_HEAD(fsnotify_broadcast_listeners);
> +
> +struct fsnotify_broadcast_listener {
> +	struct list_head list;
> +	fsnotify_broadcast_listener_t listener;
> +};
> +
> +int fsnotify_register_broadcast_listener(fsnotify_broadcast_listener_t listener)
> +{
> +	struct fsnotify_broadcast_listener *event_listener;
> +
> +	if (unlikely(listener == 0))
> +		return -EINVAL;
> +
> +	event_listener = kmalloc(sizeof(*event_listener), GFP_KERNEL);
> +	if (unlikely(!event_listener))
> +		return -ENOMEM;
> +	event_listener->listener = listener;
> +
> +	write_lock(&fsnotify_broadcast_listeners_lock);
> +	list_add_tail(&event_listener->list, &fsnotify_broadcast_listeners);
> +	++fsnotify_broadcast_listeners_count;
> +	write_unlock(&fsnotify_broadcast_listeners_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_register_broadcast_listener);
> +
> +void fsnotify_unregister_broadcast_listener(fsnotify_broadcast_listener_t listener)
> +{
> +	struct list_head *p, *next;
> +	struct fsnotify_broadcast_listener *event_listener;
> +
> +	write_lock(&fsnotify_broadcast_listeners_lock);
> +	list_for_each_safe(p, next, &fsnotify_broadcast_listeners) {
> +		event_listener = list_entry(p, struct fsnotify_broadcast_listener, list);
> +		if (listener == event_listener->listener) {
> +			list_del(p);
> +			kfree(event_listener);
> +			--fsnotify_broadcast_listeners_count;
> +			break;
> +		}
> +	}
> +	write_unlock(&fsnotify_broadcast_listeners_lock);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_unregister_broadcast_listener);
> +
> +void fsnotify_broadcast(__u32 mask, const void *data, int data_type,
> +			struct inode *dir, const struct qstr *file_name,
> +			struct inode *inode, u32 cookie)
> +{
> +	struct fsnotify_broadcast_listener *event_listener;
> +
> +	if (!fsnotify_broadcast_listeners_count)
> +		return;
> +
> +	if (inode && S_ISDIR(inode->i_mode))
> +		mask |= FS_ISDIR;
> +
> +	read_lock(&fsnotify_broadcast_listeners_lock);
> +	list_for_each_entry(event_listener,
> +			    &fsnotify_broadcast_listeners, list) {
> +		event_listener->listener(mask, data, data_type, dir,
> +				       file_name, inode, cookie);
> +	}
> +	read_unlock(&fsnotify_broadcast_listeners_lock);
> +}
> +EXPORT_SYMBOL_GPL(fsnotify_broadcast);
> +
>  /*
>   * Clear all of the marks on an inode when it is being evicted from core
>   */
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 12d3a7d308ab..22924cb22102 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -30,6 +30,9 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
>  				 struct inode *child,
>  				 const struct qstr *name, u32 cookie)
>  {
> +	fsnotify_broadcast(mask, child, FSNOTIFY_EVENT_INODE,
> +			   dir, name, NULL, cookie);
> +
>  	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
>  		return;
>  
> @@ -44,6 +47,9 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  
>  static inline void fsnotify_inode(struct inode *inode, __u32 mask)
>  {
> +	fsnotify_broadcast(mask, inode, FSNOTIFY_EVENT_INODE,
> +			   NULL, NULL, inode, 0);
> +
>  	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
>  		return;
>  
> @@ -59,6 +65,8 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>  {
>  	struct inode *inode = d_inode(dentry);
>  
> +	fsnotify_broadcast(mask, data, data_type, NULL, NULL, inode, 0);
> +
>  	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
>  		return 0;
>  
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..27d926c38eb5 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -418,6 +418,9 @@ extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
>  extern u32 fsnotify_get_cookie(void);
> +extern void fsnotify_broadcast(__u32 mask, const void *data, int data_type,
> +			struct inode *dir, const struct qstr *file_name,
> +			struct inode *inode, u32 cookie);
>  
>  static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
>  {
> @@ -586,6 +589,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
>  	INIT_LIST_HEAD(&event->list);
>  }
>  
> +/* fs event broadcast */
> +typedef void (*fsnotify_broadcast_listener_t) (__u32 mask, const void *data, int data_type,
> +				    struct inode *dir, const struct qstr *file_name,
> +				    struct inode *inode, u32 cookie);
> +extern int fsnotify_register_broadcast_listener(fsnotify_broadcast_listener_t listener);
> +extern void fsnotify_unregister_broadcast_listener(fsnotify_broadcast_listener_t listener);
> +
>  #else
>  
>  static inline int fsnotify(__u32 mask, const void *data, int data_type,
> @@ -618,6 +628,12 @@ static inline u32 fsnotify_get_cookie(void)
>  	return 0;
>  }
>  
> +static inline void fsnotify_broadcast(__u32 mask, const void *data,
> +				      int data_type, struct inode *dir,
> +				      const struct qstr *file_name,
> +				      struct inode *inode, u32 cookie)
> +{}
> +
>  static inline void fsnotify_unmount_inodes(struct super_block *sb)
>  {}
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
