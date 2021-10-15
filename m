Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D997142ED96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhJOJ3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:29:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhJOJ3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:29:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B4AC21969;
        Fri, 15 Oct 2021 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634290014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g026Y5XefWgCqdcOuW97QFWzNDNtWTYikVdz51xMTWc=;
        b=v4YJsZSxdA6x2V3DRXjTfJZ9xPn5314UNTf3mqfzGEtQUaD0XBLYY1l73TVtmaa6hN2w2d
        N3xZZOTAuTgidZYdMZPJVXb6LiGSTjEhT27hWBVnuWa70iWzQZeAapUu14n8WcL6qrAuy/
        FPqUkYIjs6GIdOuABysvJ16s1+RXek0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634290014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g026Y5XefWgCqdcOuW97QFWzNDNtWTYikVdz51xMTWc=;
        b=d42iKPiwvsBGa2ZAMuP+Ci2Rk+abnmVqn6l/JdoImhmqSwn5oL499pMGoiUCQbxlUNlJkG
        Ep2t/kNJEiChIJBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8463EA3B87;
        Fri, 15 Oct 2021 09:26:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 629D11E0A40; Fri, 15 Oct 2021 11:26:54 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:26:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 11/28] fsnotify: Pass group argument to free_event
Message-ID: <20211015092654.GE23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-12-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-12-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:29, Gabriel Krisman Bertazi wrote:
> For group-wide mempool backed events, like FS_ERROR, the free_event
> callback will need to reference the group's mempool to free the memory.
> Wire that argument into the current callers.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c        | 3 ++-
>  fs/notify/group.c                    | 2 +-
>  fs/notify/inotify/inotify_fsnotify.c | 3 ++-
>  fs/notify/notification.c             | 2 +-
>  include/linux/fsnotify_backend.h     | 2 +-
>  5 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index f82e20228999..c620b4f6fe12 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -835,7 +835,8 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>  	kfree(FANOTIFY_NE(event));
>  }
>  
> -static void fanotify_free_event(struct fsnotify_event *fsn_event)
> +static void fanotify_free_event(struct fsnotify_group *group,
> +				struct fsnotify_event *fsn_event)
>  {
>  	struct fanotify_event *event;
>  
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index fb89c351295d..6a297efc4788 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -88,7 +88,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
>  	 * that deliberately ignores overflow events.
>  	 */
>  	if (group->overflow_event)
> -		group->ops->free_event(group->overflow_event);
> +		group->ops->free_event(group, group->overflow_event);
>  
>  	fsnotify_put_group(group);
>  }
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index a96582cbfad1..d92d7b0adc9a 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -177,7 +177,8 @@ static void inotify_free_group_priv(struct fsnotify_group *group)
>  		dec_inotify_instances(group->inotify_data.ucounts);
>  }
>  
> -static void inotify_free_event(struct fsnotify_event *fsn_event)
> +static void inotify_free_event(struct fsnotify_group *group,
> +			       struct fsnotify_event *fsn_event)
>  {
>  	kfree(INOTIFY_E(fsn_event));
>  }
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 44bb10f50715..9022ae650cf8 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -64,7 +64,7 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
>  		WARN_ON(!list_empty(&event->list));
>  		spin_unlock(&group->notification_lock);
>  	}
> -	group->ops->free_event(event);
> +	group->ops->free_event(group, event);
>  }
>  
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 035438fe4a43..1e69e9fe45c9 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -155,7 +155,7 @@ struct fsnotify_ops {
>  			    const struct qstr *file_name, u32 cookie);
>  	void (*free_group_priv)(struct fsnotify_group *group);
>  	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
> -	void (*free_event)(struct fsnotify_event *event);
> +	void (*free_event)(struct fsnotify_group *group, struct fsnotify_event *event);
>  	/* called on final put+free to free memory */
>  	void (*free_mark)(struct fsnotify_mark *mark);
>  };
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
