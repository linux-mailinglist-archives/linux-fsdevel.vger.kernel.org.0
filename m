Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CF2CD4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgLCLyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 06:54:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgLCLyS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:54:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8A1FAC90;
        Thu,  3 Dec 2020 11:53:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8992A1E12FF; Thu,  3 Dec 2020 12:53:36 +0100 (CET)
Date:   Thu, 3 Dec 2020 12:53:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fsnotify: fix events reported to watching parent and
 child
Message-ID: <20201203115336.GD11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
 <20201202120713.702387-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202120713.702387-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-12-20 14:07:09, Amir Goldstein wrote:
> fsnotify_parent() used to send two separate events to backends when a
> parent inode is watcing children and the child inode is also watching.
                     ^^ watching
 
> In an attempt to avoid duplicate events in fanotify, we unified the two
> backend callbacks to a single callback and handled the reporting of the
> two separate events for the relevant backends (inotify and dnotify).
> 
> The unified event callback with two inode marks (parent and child) is
> called when both parent and child inode are watched and interested in
> the event, but they could each be watched by a different group.
> 
> So before reporting the parent or child event flavor to backend we need
> to check that the group is really interested in that event flavor.

So I'm not 100% sure what is the actual visible problem - is it that we
could deliver events a group didn't ask for?

Also I'm confused by a "different group" argument above. AFAICT
fsnotify_iter_select_report_types() makes sure we always select marks from
a single group and only after that we look at mark's masks.

That being said I agree that the loop in send_to_group() will 'or' parent
and child masks and then check test_mask & marks_mask & ~marks_ignored_mask
so if either parent *or* child was interested in the event, we'll deliver
it to both parent and the child. Fanotify is not prone to this since it
does its own checks. Dnotify also isn't prone to the problem because it
has only events on directories (so there are never two inodes to deliver
to). Inotify is prone to the problem although only because we have 'wd' in
the event. So an inotify group can receive event also with a wrong 'wd'.

After more pondering about your patch I think what I write above isn't
actually a problem you were concerned about :) I think you were concerned
about the situation when event mask gets FS_EVENT_ON_CHILD because some
group has a mark on the parent which is interested in watching children
(and so __fsnotify_parent() sets this flag). But then *another* group has
a mark without FS_EVENT_ON_CHILD on the parent but we'll send the event to
it regardless. This can actually result in completely spurious event on
directory inode for inotify & dnotify.

If I understood the problem correctly, I suggest modifying beginning of the
changelog like below because I was able to figure it out but some poor
distro guy deciding whether this could be fixing the problem his customer
is hitting or not has a small chance...

"fsnotify_parent() used to send two separate events to backends when a
parent inode is watching children and the child inode is also watching.
In an attempt to avoid duplicate events in fanotify, we unified the two
backend callbacks to a single callback and handled the reporting of the
two separate events for the relevant backends (inotify and dnotify).
However the handling is buggy and can result in inotify and dnotify listeners
receiving events of the type they never asked for or spurious events."

> The semantics of INODE and CHILD marks were hard to follow and made the
> logic more complicated than it should have been.  Replace it with INODE
> and PARENT marks semantics to hopefully make the logic more clear.

Heh, wasn't I complaining about this when I was initially reviewing the
changes? ;)

> Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c    |  7 ++-
>  fs/notify/fsnotify.c             | 78 ++++++++++++++++++--------------
>  include/linux/fsnotify_backend.h |  6 +--
>  3 files changed, 51 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 9167884a61ec..1192c9953620 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -268,12 +268,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  			continue;
>  
>  		/*
> -		 * If the event is for a child and this mark is on a parent not
> +		 * If the event is on a child and this mark is on a parent not
>  		 * watching children, don't send it!
>  		 */
> -		if (event_mask & FS_EVENT_ON_CHILD &&
> -		    type == FSNOTIFY_OBJ_TYPE_INODE &&
> -		     !(mark->mask & FS_EVENT_ON_CHILD))
> +		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> +		    !(mark->mask & FS_EVENT_ON_CHILD))
>  			continue;
>  
>  		marks_mask |= mark->mask;
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index c5c68bcbaadf..0676ce4d3352 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -152,6 +152,13 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
>  	if (mask & FS_ISDIR)
>  		return false;
>  
> +	/*
> +	 * All events that are possible on child can also may be reported with
> +	 * parent/name info to inode/sb/mount.  Otherwise, a watching parent
> +	 * could result in events reported with unexpected name info to sb/mount.
> +	 */
> +	BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
> +
>  	/* Did either inode/sb/mount subscribe for events with parent/name? */
>  	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
>  	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
> @@ -249,6 +256,10 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>  	    path && d_unlinked(path->dentry))
>  		return 0;
>  
> +	/* Check interest of this mark in case event was sent with two marks */
> +	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
> +		return 0;
> +
>  	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
>  }
>  
> @@ -258,38 +269,40 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>  				 u32 cookie, struct fsnotify_iter_info *iter_info)
>  {
>  	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> -	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
> +	struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
>  	int ret;
>  
>  	if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
>  	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
>  		return 0;
>  
> -	/*
> -	 * An event can be sent on child mark iterator instead of inode mark
> -	 * iterator because of other groups that have interest of this inode
> -	 * and have marks on both parent and child.  We can simplify this case.
> -	 */
> -	if (!inode_mark) {
> -		inode_mark = child_mark;
> -		child_mark = NULL;
> +	if (parent_mark) {
> +		/*
> +		 * parent_mark indicates that the parent inode is watching children
> +		 * and interested in this event, which is an event possible on child.
> +		 * But is this mark watching children and interested in this event?
> +		 */
> +		if (parent_mark->mask & FS_EVENT_ON_CHILD) {

Is this really enough? I'd expect us to also check (mask &
parent_mark->mask & ALL_FSNOTIFY_EVENTS) != 0...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
