Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0B3BF88F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhGHKvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 06:51:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGHKu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:50:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50D8E220E7;
        Thu,  8 Jul 2021 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625741297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viOkx9/mHi+uWQ9D7jlCqliHm70px7w4MSJ55k0DGQ0=;
        b=R6SuXyVTNW+2dpQFjbsPYHPsqAsLEicyYwZ+rHbCLkB2/L9LvIP2Xxkodyc/nt+0OfhLvy
        3IRZx27RWb9shvwEPMdQ0d5gEpqMNvVQZRdKn8y3JuNEarrP0ABdIxRlHrjw6E1EM9NvL4
        CrdPpy9s7jNEY/ZeX9oSk4M4B9PNcX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625741297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viOkx9/mHi+uWQ9D7jlCqliHm70px7w4MSJ55k0DGQ0=;
        b=lUAcfmnAQBFI4GGhOEGjNaF4OR6c8gou1Jz8LBZE3HQQCBE3kLZvWsEqdMP8k60onuq1mS
        qB8h+5k6Zn2tw+Bw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 36648A3B8A;
        Thu,  8 Jul 2021 10:48:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C0CF1E62E4; Thu,  8 Jul 2021 12:48:17 +0200 (CEST)
Date:   Thu, 8 Jul 2021 12:48:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 08/15] fsnotify: Support passing argument to insert
 callback on add_event
Message-ID: <20210708104817.GB1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-9-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:28, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR requires some initialization to happen from inside the
> insert hook.  This allows a user of fanotify_add_event to pass an
> argument to be sent to the insert callback.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c        | 5 +++--
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  fs/notify/notification.c             | 6 ++++--
>  include/linux/fsnotify_backend.h     | 7 +++++--
>  4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4f2febb15e94..aba06b84da91 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -695,7 +695,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
>   * Add an event to hash table for faster merge.
>   */
>  static void fanotify_insert_event(struct fsnotify_group *group,
> -				  struct fsnotify_event *fsn_event)
> +				  struct fsnotify_event *fsn_event,
> +				  const void *data)
>  {
>  	struct fanotify_event *event = FANOTIFY_E(fsn_event);
>  	unsigned int bucket = fanotify_event_hash_bucket(group, event);
> @@ -779,7 +780,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  	fsn_event = &event->fse;
>  	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -				 fanotify_insert_event);
> +				 fanotify_insert_event, NULL);
>  	if (ret) {
>  		/* Permission events shouldn't be merged */
>  		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index d1a64daa0171..a003a64ff8ee 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -116,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  	if (len)
>  		strcpy(event->name, name->name);
>  
> -	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL);
> +	ret = fsnotify_add_event(group, fsn_event, inotify_merge, NULL, NULL);
>  	if (ret) {
>  		/* Our event wasn't used in the end. Free it. */
>  		fsnotify_destroy_event(group, fsn_event);
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 32f45543b9c6..0d9ba592d725 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -83,7 +83,9 @@ int fsnotify_add_event(struct fsnotify_group *group,
>  		       int (*merge)(struct fsnotify_group *,
>  				    struct fsnotify_event *),
>  		       void (*insert)(struct fsnotify_group *,
> -				      struct fsnotify_event *))
> +				      struct fsnotify_event *,
> +				      const void *),
> +		       const void *insert_data)
>  {
>  	int ret = 0;
>  	struct list_head *list = &group->notification_list;
> @@ -121,7 +123,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
>  	group->q_len++;
>  	list_add_tail(&event->list, list);
>  	if (insert)
> -		insert(group, event);
> +		insert(group, event, insert_data);
>  	spin_unlock(&group->notification_lock);
>  
>  	wake_up(&group->notification_waitq);
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b1590f654ade..8222fe12a6c9 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -526,11 +526,14 @@ extern int fsnotify_add_event(struct fsnotify_group *group,
>  			      int (*merge)(struct fsnotify_group *,
>  					   struct fsnotify_event *),
>  			      void (*insert)(struct fsnotify_group *,
> -					     struct fsnotify_event *));
> +					     struct fsnotify_event *,
> +					     const void *),
> +			      const void *insert_data);
> +
>  /* Queue overflow event to a notification group */
>  static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
>  {
> -	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
> +	fsnotify_add_event(group, group->overflow_event, NULL, NULL, NULL);
>  }
>  
>  static inline bool fsnotify_is_overflow_event(u32 mask)
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
