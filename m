Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10822CD302
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgLCJ4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 04:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:60176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbgLCJ4O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F116AC55;
        Thu,  3 Dec 2020 09:55:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 24AA51E12FF; Thu,  3 Dec 2020 10:55:32 +0100 (CET)
Date:   Thu, 3 Dec 2020 10:55:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] inotify: convert to handle_inode_event() interface
Message-ID: <20201203095532.GB11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
 <20201202120713.702387-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202120713.702387-3-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-12-20 14:07:08, Amir Goldstein wrote:
> Convert inotify to use the simple handle_inode_event() interface to
> get rid of the code duplication between the generic helper
> fsnotify_handle_event() and the inotify_handle_event() callback, which
> also happen to be buggy code.
> 
> The bug will be fixed in the generic helper.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/inotify/inotify.h          |  9 +++---
>  fs/notify/inotify/inotify_fsnotify.c | 47 ++++++----------------------
>  fs/notify/inotify/inotify_user.c     |  7 +----
>  3 files changed, 15 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
> index 4327d0e9c364..7fc3782b2fb8 100644
> --- a/fs/notify/inotify/inotify.h
> +++ b/fs/notify/inotify/inotify.h
> @@ -24,11 +24,10 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
>  
>  extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
>  					   struct fsnotify_group *group);
> -extern int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> -				const void *data, int data_type,
> -				struct inode *dir,
> -				const struct qstr *file_name, u32 cookie,
> -				struct fsnotify_iter_info *iter_info);
> +extern int inotify_handle_event(struct fsnotify_group *group,
> +				struct fsnotify_mark *inode_mark, u32 mask,
> +				struct inode *inode, struct inode *dir,
> +				const struct qstr *name, u32 cookie);
>  
>  extern const struct fsnotify_ops inotify_fsnotify_ops;
>  extern struct kmem_cache *inotify_inode_mark_cachep;
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 9ddcbadc98e2..f348c1d3b358 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -55,10 +55,10 @@ static int inotify_merge(struct list_head *list,
>  	return event_compare(last_event, event);
>  }
>  
> -static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> -			     struct fsnotify_mark *inode_mark,
> -			     const struct path *path,
> -			     const struct qstr *file_name, u32 cookie)
> +int inotify_handle_event(struct fsnotify_group *group,
> +			 struct fsnotify_mark *inode_mark, u32 mask,
> +			 struct inode *inode, struct inode *dir,
> +			 const struct qstr *file_name, u32 cookie)
>  {
>  	struct inotify_inode_mark *i_mark;
>  	struct inotify_event_info *event;
> @@ -68,10 +68,6 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
>  	int alloc_len = sizeof(struct inotify_event_info);
>  	struct mem_cgroup *old_memcg;
>  
> -	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
> -	    path && d_unlinked(path->dentry))
> -		return 0;
> -
>  	if (file_name) {
>  		len = file_name->len;
>  		alloc_len += len + 1;
> @@ -131,35 +127,12 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
>  	return 0;
>  }
>  
> -int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> -			 const void *data, int data_type, struct inode *dir,
> -			 const struct qstr *file_name, u32 cookie,
> -			 struct fsnotify_iter_info *iter_info)
> +static int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> +				      struct inode *inode, struct inode *dir,
> +				      const struct qstr *name, u32 cookie)
>  {

Looking at this I'd just fold inotify_handle_event() into
inotify_handle_inode_event() as the only difference is the 'group' argument
and that can be always fetched from inode_mark->group...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
