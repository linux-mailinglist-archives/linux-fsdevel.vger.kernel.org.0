Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1E22F3E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgG0Pdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 11:33:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:55542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgG0Pdg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:33:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6D1CAD87;
        Mon, 27 Jul 2020 15:33:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 660A91E12C5; Mon, 27 Jul 2020 17:33:34 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:33:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] inotify: do not set FS_EVENT_ON_CHILD in non-dir
 mark mask
Message-ID: <20200727153334.GE5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-3-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:42, Amir Goldstein wrote:
> Since commit ecf13b5f8fd6 ("fsnotify: send event with parent/name info
> to sb/mount/non-dir marks") the flag FS_EVENT_ON_CHILD has a meaning in
> mask of a mark on a non-dir inode.  It means that group is interested
> in the name of the file with events.
> 
> Since inotify is only intereseted in names of children of a watching
> parent, do not sete FS_EVENT_ON_CHILD flag for marks on non-dir.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I've placed this commit in the series before "fsnotify: send event with
parent/name info to sb/mount/non-dir marks" and updated changelog
accordingly.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 5385d5817dd9..186722ba3894 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -75,15 +75,17 @@ struct ctl_table inotify_table[] = {
>  };
>  #endif /* CONFIG_SYSCTL */
>  
> -static inline __u32 inotify_arg_to_mask(u32 arg)
> +static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
>  {
>  	__u32 mask;
>  
>  	/*
> -	 * everything should accept their own ignored, cares about children,
> -	 * and should receive events when the inode is unmounted
> +	 * Everything should accept their own ignored and should receive events
> +	 * when the inode is unmounted.  All directories care about children.
>  	 */
> -	mask = (FS_IN_IGNORED | FS_EVENT_ON_CHILD | FS_UNMOUNT);
> +	mask = (FS_IN_IGNORED | FS_UNMOUNT);
> +	if (S_ISDIR(inode->i_mode))
> +		mask |= FS_EVENT_ON_CHILD;
>  
>  	/* mask off the flags used to open the fd */
>  	mask |= (arg & (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK));
> @@ -512,7 +514,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  	int create = (arg & IN_MASK_CREATE);
>  	int ret;
>  
> -	mask = inotify_arg_to_mask(arg);
> +	mask = inotify_arg_to_mask(inode, arg);
>  
>  	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
>  	if (!fsn_mark)
> @@ -565,7 +567,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
>  	struct idr *idr = &group->inotify_data.idr;
>  	spinlock_t *idr_lock = &group->inotify_data.idr_lock;
>  
> -	mask = inotify_arg_to_mask(arg);
> +	mask = inotify_arg_to_mask(inode, arg);
>  
>  	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_KERNEL);
>  	if (unlikely(!tmp_i_mark))
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
