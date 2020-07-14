Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B208821EFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGNLyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 07:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGNLyy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD4EBB000;
        Tue, 14 Jul 2020 11:54:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F1BAB1E12C9; Tue, 14 Jul 2020 13:54:51 +0200 (CEST)
Date:   Tue, 14 Jul 2020 13:54:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
Message-ID: <20200714115451.GE23073@quack2.suse.cz>
References: <20200702125744.10535-1-amir73il@gmail.com>
 <20200702125744.10535-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702125744.10535-5-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 02-07-20 15:57:38, Amir Goldstein wrote:
> Similar to events "on child" to watching directory, send event "on child"
> with parent/name info if sb/mount/non-dir marks are interested in
> parent/name info.
> 
> The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> interest in parent/name info for events on non-directory inodes.
> 
> Events on "orphan" children (disconnected dentries) are sent without
> parent/name info.
> 
> Events on direcories are send with parent/name info only if the parent
> directory is watching.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c             | 50 +++++++++++++++++++++++---------
>  include/linux/fsnotify.h         | 10 +++++--
>  include/linux/fsnotify_backend.h | 32 +++++++++++++++++---
>  3 files changed, 73 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7c6e624b24c9..6683c77a5b13 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -144,27 +144,55 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  
>  /*
>   * Notify this dentry's parent about a child's events with child name info
> - * if parent is watching.
> - * Notify only the child without name info if parent is not watching.
> + * if parent is watching or if inode/sb/mount are interested in events with
> + * parent and name info.
> + *
> + * Notify only the child without name info if parent is not watching and
> + * inode/sb/mount are not interested in events with parent and name info.
>   */
>  int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  		      int data_type)
>  {

Ugh, I have to say this function is now pretty difficult to digest. I was
staring at it for an hour before I could make some sence of it...

> +	const struct path *path = fsnotify_data_path(data, data_type);
> +	struct mount *mnt = path ? real_mount(path->mnt) : NULL;
>  	struct inode *inode = d_inode(dentry);
>  	struct dentry *parent;
> +	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
> +	__u32 p_mask, test_mask, marks_mask = 0;
>  	struct inode *p_inode;
>  	int ret = 0;
>  
> +	/*
> +	 * Do inode/sb/mount care about parent and name info on non-dir?
> +	 * Do they care about any event at all?
> +	 */
> +	if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
> +	    (!mnt || !mnt->mnt_fsnotify_marks)) {
> +		if (!parent_watched)
> +			return 0;
> +	} else if (!(mask & FS_ISDIR) && !IS_ROOT(dentry)) {
> +		marks_mask |= fsnotify_want_parent(inode->i_fsnotify_mask);
> +		marks_mask |= fsnotify_want_parent(inode->i_sb->s_fsnotify_mask);
> +		if (mnt)
> +			marks_mask |= fsnotify_want_parent(mnt->mnt_fsnotify_mask);
> +	}

OK, so AFAIU at this point (mask & marks_mask) tells us whether we need to
grab parent because some mark needs parent into reported. Correct?

Maybe I'd rename fsnotify_want_parent() (which seems like it returns bool)
to fsnotify_parent_needed_mask() or something like that. Also I'd hide all
those checks in a helper function like:

	fsnotify_event_needs_parent(mnt, inode, mask)

So we'd then have just something like:
	if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
	    (!mnt || !mnt->mnt_fsnotify_marks) && !parent_watched)
		return 0;
	if (!parent_watched && !fsnotify_event_needs_parent(mnt, inode, mask))
		goto notify_child;
	...

> +
>  	parent = NULL;
> -	if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> +	test_mask = mask & FS_EVENTS_POSS_TO_PARENT;
> +	if (!(marks_mask & test_mask) && !parent_watched)
>  		goto notify_child;
>  
> +	/* Does parent inode care about events on children? */
>  	parent = dget_parent(dentry);
>  	p_inode = parent->d_inode;
> +	p_mask = fsnotify_inode_watches_children(p_inode);
>  
> -	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
> +	if (p_mask)
> +		marks_mask |= p_mask;
> +	else if (unlikely(parent_watched))
>  		__fsnotify_update_child_dentry_flags(p_inode);
> -	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
> +
> +	if ((marks_mask & test_mask) && p_inode != inode) {
					^^ this is effectively
!IS_ROOT(dentry), isn't it? But since you've checked that above can it ever
be that p_inode == inode?

Also if marks_mask & test_mask == 0, why do you go to a branch that
notifies child? There shouldn't be anything to report there either. Am I
missing something? ... Oh, I see, the FS_EVENTS_POSS_TO_PARENT masking
above could cause that child is still interested. Because mask & marks_mask
can still contain something. Maybe it would be more comprehensible if we
restructure the above like:

	p_mask = fsnotify_inode_watches_children(p_inode);
	if (unlikely(parent_watched && !p_mask))
		__fsnotify_update_child_dentry_flags(p_inode);
	/*
	 * Include parent in notification either if some notification
	 * groups require parent info (!parent_watched case) or the parent is
	 * interested in this event.
	 */
	if (!parent_watched || (mask & p_mask & ALL_FSNOTIFY_EVENTS)) {
		...
	}

>  		struct name_snapshot name;
>  
>  		/* When notifying parent, child should be passed as data */
> @@ -346,15 +374,11 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_type,
>  	    (!child || !child->i_fsnotify_marks))
>  		return 0;
>  
> -	/* An event "on child" is not intended for a mount/sb mark */
> -	marks_mask = to_tell->i_fsnotify_mask;
> -	if (!child) {
> -		marks_mask |= sb->s_fsnotify_mask;
> -		if (mnt)
> -			marks_mask |= mnt->mnt_fsnotify_mask;
> -	} else {
> +	marks_mask = to_tell->i_fsnotify_mask | sb->s_fsnotify_mask;
> +	if (mnt)
> +		marks_mask |= mnt->mnt_fsnotify_mask;
> +	if (child)
>  		marks_mask |= child->i_fsnotify_mask;
> -	}

This hunk seems to belong to the previous patch... It fixes the problem
I've spotted there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
