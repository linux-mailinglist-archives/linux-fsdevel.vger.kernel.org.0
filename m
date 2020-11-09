Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14C2ABE29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 15:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgKIODF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 09:03:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:45302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgKIODE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:03:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03FE7ABD1;
        Mon,  9 Nov 2020 14:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C38691E1311; Mon,  9 Nov 2020 15:03:02 +0100 (CET)
Date:   Mon, 9 Nov 2020 15:03:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: fix logic of reporting name info with watched
 parent
Message-ID: <20201109140302.GA28162@quack2.suse.cz>
References: <20201108105906.8493-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108105906.8493-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-11-20 12:59:06, Amir Goldstein wrote:
> The victim inode's parent and name info is required when an event
> needs to be delivered to a group interested in filename info OR
> when the inode's parent is interested in an event on its children.
> 
> Let us call the first condition 'parent_needed' and the second
> condition 'parent_interested'.
> 
> In fsnotify_parent(), the condition where the inode's parent is
> interested in some events on its children, but not necessarily
> interested the specific event is called 'parent_watched'.
> 
> fsnotify_parent() tests the condition (!parent_watched && !parent_needed)
> for sending the event without parent and name info, which is correct.
> 
> It then wrongly assumes that parent_watched implies !parent_needed
> and tests the condition (parent_watched && !parent_interested)
> for sending the event without parent and name info, which is wrong,
> because parent may still be needed by some group.
> 
> For example, after initializing a group with FAN_REPORT_DFID_NAME and
> adding a FAN_MARK_MOUNT with FAN_OPEN mask, open events on non-directory
> children of "testdir" are delivered with file name info.
> 
> After adding another mark to the same group on the parent "testdir"
> with FAN_CLOSE|FAN_EVENT_ON_CHILD mask, open events on non-directory
> children of "testdir" are no longer delivered with file name info.
> 
> Fix the logic and use auxiliary variables to clarify the conditions.
> 
> Fixes: 9b93f33105f5 ("fsnotify: send event with parent/name info to sb/mount/non-dir marks")
> Cc: stable@vger.kernel.org#v5.9
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks! I've queued the patch to my tree and will send it to Linus later
this week.

								Honza

> ---
> 
> Jan,
> 
> There is an LTP test for this bug at [1].
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/ltp/commits/fsnotify-fixes
> 
>  fs/notify/fsnotify.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index a960ec3a569a..8d3ad5ef2925 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -178,6 +178,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  	struct inode *inode = d_inode(dentry);
>  	struct dentry *parent;
>  	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
> +	bool parent_needed, parent_interested;
>  	__u32 p_mask;
>  	struct inode *p_inode = NULL;
>  	struct name_snapshot name;
> @@ -193,7 +194,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  		return 0;
>  
>  	parent = NULL;
> -	if (!parent_watched && !fsnotify_event_needs_parent(inode, mnt, mask))
> +	parent_needed = fsnotify_event_needs_parent(inode, mnt, mask);
> +	if (!parent_watched && !parent_needed)
>  		goto notify;
>  
>  	/* Does parent inode care about events on children? */
> @@ -205,17 +207,17 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  
>  	/*
>  	 * Include parent/name in notification either if some notification
> -	 * groups require parent info (!parent_watched case) or the parent is
> -	 * interested in this event.
> +	 * groups require parent info or the parent is interested in this event.
>  	 */
> -	if (!parent_watched || (mask & p_mask & ALL_FSNOTIFY_EVENTS)) {
> +	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS;
> +	if (parent_needed || parent_interested) {
>  		/* When notifying parent, child should be passed as data */
>  		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
>  
>  		/* Notify both parent and child with child name info */
>  		take_dentry_name_snapshot(&name, dentry);
>  		file_name = &name.name;
> -		if (parent_watched)
> +		if (parent_interested)
>  			mask |= FS_EVENT_ON_CHILD;
>  	}
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
