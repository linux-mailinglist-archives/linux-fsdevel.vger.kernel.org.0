Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF542F14F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhJOMvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 08:51:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56084 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhJOMvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:51:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45C2B1FD4B;
        Fri, 15 Oct 2021 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634302141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIJYCiWrYcWMRRL2abr87VDNh8SztOrCekPC0VkD/OY=;
        b=XjbywHJkMGtArmGyZX8lBpXnng6M8Rqee/t6qOzt/leZmg+shRyl0ohIV/hMA5GuheK8jl
        dWq/FK8xGBmUCDJynREDK0tNgzAyKbDVPROwczKdOObUasKj9TnA620bpwsIaocfp98g0L
        n3yTzRorFbQkX6HGSadH6qR2tLTgeRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634302141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIJYCiWrYcWMRRL2abr87VDNh8SztOrCekPC0VkD/OY=;
        b=IxRLigLeU80djlI4YtheVUevFIgtHQ6xThR0+yb+A7A/rCokvqSVK3hLKieagDTr3sWm72
        DYajrLIRgwI2vzBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 30C27A3B81;
        Fri, 15 Oct 2021 12:49:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0F3271E0A40; Fri, 15 Oct 2021 14:49:01 +0200 (CEST)
Date:   Fri, 15 Oct 2021 14:49:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 25/28] fanotify: Allow users to request FAN_FS_ERROR
 events
Message-ID: <20211015124901.GM23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-26-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-26-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:43, Gabriel Krisman Bertazi wrote:
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
> 
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

No other comment besides what Amir has written...

								Honza

> ---
>  fs/notify/fanotify/fanotify.c      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  include/linux/fanotify.h           | 6 +++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 47e28f418711..d449a23d603f 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -827,7 +827,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, mask, data,
>  					 data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 8f7c2f4ce674..5edfd7e3f356 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1585,6 +1585,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		fsid = &__fsid;
>  	}
>  
> +	if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
> +		ret = -EINVAL;
> +		goto path_put_and_out;
> +	}
> +
>  	/* inode held in place by reference to path; group by fget on fd */
>  	if (mark_type == FAN_MARK_INODE)
>  		inode = path.dentry->d_inode;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 52d464802d99..616af2ea20f3 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -91,9 +91,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
>  				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>  
> +/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
> +#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
> -				 FANOTIFY_INODE_EVENTS)
> +				 FANOTIFY_INODE_EVENTS | \
> +				 FANOTIFY_ERROR_EVENTS)
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
