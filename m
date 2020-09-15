Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14187269F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIOHJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 03:09:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIOHIr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:08:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D467AAF6F;
        Tue, 15 Sep 2020 07:08:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6D7581E12EF; Tue, 15 Sep 2020 09:08:41 +0200 (CEST)
Date:   Tue, 15 Sep 2020 09:08:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] inotify: add support watch open exec event
Message-ID: <20200915070841.GF4863@quack2.suse.cz>
References: <20200914172737.GA5011@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914172737.GA5011@192.168.3.9>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> Now the IN_OPEN event can report all open events for a file, but it can
> not distinguish if the file was opened for execute or read/write.
> This patch add a new event IN_OPEN_EXEC to support that. If user only
> want to monitor a file was opened for execute, they can pass a more
> precise event IN_OPEN_EXEC to inotify_add_watch.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Thanks for the patch but what I'm missing is a justification for it. Is
there any application that cannot use fanotify that needs to distinguish
IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
specialized purposes (e.g. audit) which are generally priviledged and need
to use fanotify anyway so I don't see this as an interesting feature for
inotify...

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 3 ++-
>  include/linux/inotify.h          | 2 +-
>  include/uapi/linux/inotify.h     | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 186722ba3894..eb42d11a9988 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -819,8 +819,9 @@ static int __init inotify_user_setup(void)
>  	BUILD_BUG_ON(IN_EXCL_UNLINK != FS_EXCL_UNLINK);
>  	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
>  	BUILD_BUG_ON(IN_ONESHOT != FS_IN_ONESHOT);
> +	BUILD_BUG_ON(IN_OPEN_EXEC != FS_OPEN_EXEC);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 23);
>  
>  	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark,
>  					       SLAB_PANIC|SLAB_ACCOUNT);
> diff --git a/include/linux/inotify.h b/include/linux/inotify.h
> index 6a24905f6e1e..88fc82c8cf2a 100644
> --- a/include/linux/inotify.h
> +++ b/include/linux/inotify.h
> @@ -15,7 +15,7 @@ extern struct ctl_table inotify_table[]; /* for sysctl */
>  #define ALL_INOTIFY_BITS (IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
>  			  IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
>  			  IN_MOVED_TO | IN_CREATE | IN_DELETE | \
> -			  IN_DELETE_SELF | IN_MOVE_SELF | IN_UNMOUNT | \
> +			  IN_DELETE_SELF | IN_MOVE_SELF | IN_OPEN_EXEC | IN_UNMOUNT | \
>  			  IN_Q_OVERFLOW | IN_IGNORED | IN_ONLYDIR | \
>  			  IN_DONT_FOLLOW | IN_EXCL_UNLINK | IN_MASK_ADD | \
>  			  IN_MASK_CREATE | IN_ISDIR | IN_ONESHOT)
> diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
> index 884b4846b630..f19ea046cc87 100644
> --- a/include/uapi/linux/inotify.h
> +++ b/include/uapi/linux/inotify.h
> @@ -39,6 +39,7 @@ struct inotify_event {
>  #define IN_DELETE		0x00000200	/* Subfile was deleted */
>  #define IN_DELETE_SELF		0x00000400	/* Self was deleted */
>  #define IN_MOVE_SELF		0x00000800	/* Self was moved */
> +#define IN_OPEN_EXEC		0x00001000	/* File was opened */
>  
>  /* the following are legal events.  they are sent as needed to any watch */
>  #define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
> @@ -66,7 +67,7 @@ struct inotify_event {
>  #define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
>  			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
>  			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF | \
> -			 IN_MOVE_SELF)
> +			 IN_MOVE_SELF | IN_OPEN_EXEC)
>  
>  /* Flags for sys_inotify_init1.  */
>  #define IN_CLOEXEC O_CLOEXEC
> -- 
> 2.18.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
