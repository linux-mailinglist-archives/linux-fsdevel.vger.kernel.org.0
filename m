Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02F22F916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 21:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgG0TcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 15:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0TcU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:32:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FED1AD43;
        Mon, 27 Jul 2020 19:32:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8C2DE1E12C7; Mon, 27 Jul 2020 21:32:18 +0200 (CEST)
Date:   Mon, 27 Jul 2020 21:32:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] fsnotify: simplify dir argument to handle_event()
Message-ID: <20200727193218.GH5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-6-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:45, Amir Goldstein wrote:
> The meaning of dir argument could be simplified a lot to just the base
> of file_name it we let the only backends that care about it (fanotify and
> dnotify) cope with the case of NULL file_name themselves, which is easy.
> 
> This will make dir argument meaning generic enough so we can use the
> same argument for fsnotify() without causing confusion.
> 
> Fixes: e2c9d9039c3f ("fsnotify: pass dir argument to handle_event() callback")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I've folded this patch into "fsnotify: pass dir argument to handle_event()
callback" and int "fanotify: add basic support for FAN_REPORT_DIR_FID".

								Honza

> ---
>  fs/notify/dnotify/dnotify.c      | 2 +-
>  fs/notify/fanotify/fanotify.c    | 7 ++++---
>  fs/notify/fsnotify.c             | 2 +-
>  include/linux/fsnotify_backend.h | 4 +---
>  4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 305e5559560a..ca78d3f78da8 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -112,7 +112,7 @@ static int dnotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
>  
>  	/* not a dir, dnotify doesn't care */
> -	if (!dir)
> +	if (!dir && !(mask & FS_ISDIR))
>  		return 0;
>  
>  	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 36ea0cd6387e..03e3dce2a97c 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -245,7 +245,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			return 0;
>  	} else if (!(fid_mode & FAN_REPORT_FID)) {
>  		/* Do we have a directory inode to report? */
> -		if (!dir)
> +		if (!dir && !(event_mask & FS_ISDIR))
>  			return 0;
>  	}
>  
> @@ -525,12 +525,13 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	struct fanotify_event *event = NULL;
>  	gfp_t gfp = GFP_KERNEL_ACCOUNT;
>  	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
> +	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>  	struct inode *child = NULL;
>  	bool name_event = false;
>  
> -	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
> +	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
>  		/*
>  		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
>  		 * report the child fid for events reported on a non-dir child
> @@ -540,7 +541,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
>  			child = id;
>  
> -		id = fanotify_dfid_inode(mask, data, data_type, dir);
> +		id = dirid;
>  
>  		/*
>  		 * We record file name only in a group with FAN_REPORT_NAME
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 277af3d5efce..834775f61f6b 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -365,7 +365,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	struct fsnotify_iter_info iter_info = {};
>  	struct super_block *sb = to_tell->i_sb;
> -	struct inode *dir = S_ISDIR(to_tell->i_mode) ? to_tell : NULL;
> +	struct inode *dir = file_name ? to_tell : NULL;
>  	struct mount *mnt = NULL;
>  	struct inode *child = NULL;
>  	int ret = 0;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 9bd75d0582b4..d94a50e0445a 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -123,9 +123,7 @@ struct mem_cgroup;
>   * @data_type:	type of object for fanotify_data_XXX() accessors
>   * @dir:	optional directory associated with event -
>   *		if @file_name is not NULL, this is the directory that
> - *		@file_name is relative to. Otherwise, @dir is the object
> - *		inode if event happened on directory and NULL if event
> - *		happenned on a non-directory.
> + *		@file_name is relative to
>   * @file_name:	optional file name associated with event
>   * @cookie:	inotify rename cookie
>   * @iter_info:	array of marks from this group that are interested in the event
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
