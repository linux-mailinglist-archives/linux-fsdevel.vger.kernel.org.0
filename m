Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40622FB5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 23:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0V13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 17:27:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgG0V13 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:27:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCF45B14B;
        Mon, 27 Jul 2020 21:27:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1215B1E12C7; Mon, 27 Jul 2020 23:27:27 +0200 (CEST)
Date:   Mon, 27 Jul 2020 23:27:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/9] fsnotify: fix merge with parent mark masks
Message-ID: <20200727212727.GJ5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-8-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:47, Amir Goldstein wrote:
> When reporting event with parent/name info, we should not merge
> parent's mark mask and ignore mask, unless the parent has the flag
> FS_EVENT_ON_CHILD in the mask.
> 
> Therefore, in fsnotify_parent(), set the FS_EVENT_ON_CHILD flag in event
> mask only if parent is watching and use this flag to decide if the
> parent mark masks should be merged with child/sb/mount marks.
> 
> After this change, even groups that do not subscribe to events on
> children could get an event with mark iterator type TYPE_CHILD and
> without mark iterator type TYPE_INODE if fanotify has marks on the same
> objects.
> 
> dnotify and inotify event handlers can already cope with that situation.
> audit does not subscribe to events that are possible on child, so won't
> get to this situation. nfsd does not access the marks iterator from its
> event handler at the moment, so it is not affected.
> 
> This is a bit too fragile, so we should prepare all groups to cope with
> mark type TYPE_CHILD preferably using a generic helper.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20200716223441.GA5085@quack2.suse.cz/
> Fixes: ecf13b5f8fd6 ("fsnotify: send event with parent/name info to sb/mount/non-dir marks")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I've folded this into "fsnotify: send event with parent/name info to
sb/mount/non-dir marks".

									Honza

> ---
>  fs/notify/fanotify/fanotify.c |  2 +-
>  fs/notify/fsnotify.c          | 20 +++++++++++++-------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 03e3dce2a97c..3336157d895d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -538,7 +538,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		 * in addition to reporting the parent fid and maybe child name.
>  		 */
>  		if ((fid_mode & FAN_REPORT_FID) &&
> -		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
> +		    id != dirid && !(mask & FAN_ONDIR))
>  			child = id;
>  
>  		id = dirid;
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 3b805e05c02d..494d5d70323f 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -215,7 +215,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  		/* Notify both parent and child with child name info */
>  		take_dentry_name_snapshot(&name, dentry);
>  		file_name = &name.name;
> -		mask |= FS_EVENT_ON_CHILD;
> +		if (parent_watched)
> +			mask |= FS_EVENT_ON_CHILD;
>  	}
>  
>  notify:
> @@ -391,8 +392,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  		inode = dir;
>  	} else if (mask & FS_EVENT_ON_CHILD) {
>  		/*
> -		 * Event on child - report on TYPE_INODE to dir
> -		 * and on TYPE_CHILD to child.
> +		 * Event on child - report on TYPE_INODE to dir if it is
> +		 * watching children and on TYPE_CHILD to child.
>  		 */
>  		child = inode;
>  		inode = dir;
> @@ -406,14 +407,17 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	 * SRCU because we have no references to any objects and do not
>  	 * need SRCU to keep them "alive".
>  	 */
> -	if (!inode->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> +	if (!sb->s_fsnotify_marks &&
>  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
> +	    (!inode || !inode->i_fsnotify_marks) &&
>  	    (!child || !child->i_fsnotify_marks))
>  		return 0;
>  
> -	marks_mask = inode->i_fsnotify_mask | sb->s_fsnotify_mask;
> +	marks_mask = sb->s_fsnotify_mask;
>  	if (mnt)
>  		marks_mask |= mnt->mnt_fsnotify_mask;
> +	if (inode)
> +		marks_mask |= inode->i_fsnotify_mask;
>  	if (child)
>  		marks_mask |= child->i_fsnotify_mask;
>  
> @@ -428,14 +432,16 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  
>  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
>  
> -	iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> -		fsnotify_first_mark(&inode->i_fsnotify_marks);
>  	iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
>  		fsnotify_first_mark(&sb->s_fsnotify_marks);
>  	if (mnt) {
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
>  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
>  	}
> +	if (inode) {
> +		iter_info.marks[FSNOTIFY_OBJ_TYPE_INODE] =
> +			fsnotify_first_mark(&inode->i_fsnotify_marks);
> +	}
>  	if (child) {
>  		iter_info.marks[FSNOTIFY_OBJ_TYPE_CHILD] =
>  			fsnotify_first_mark(&child->i_fsnotify_marks);
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
