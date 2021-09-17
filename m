Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE540F76D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhIQMZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:25:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhIQMZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:25:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5F2C922277;
        Fri, 17 Sep 2021 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631881464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=232Dk0MKnQVqshpP5rO1fKeSoPXpmeF+S3slAZodlWE=;
        b=tTTIruiXXFuV/dUlnpnMZL17QxdWD3fubAVFy9HHVAN21IbZNCQ/neqMUjk+8PIhGkoEbs
        1iZiK5KsKiSdjGIGtg3JLK1ery9EUcrDZBzDMuhZcwF05WINCsirk2vZnOMVOb9l9DeP0S
        7VzyNgGWxzACt65sl3blKfQ4xn7xgtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631881464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=232Dk0MKnQVqshpP5rO1fKeSoPXpmeF+S3slAZodlWE=;
        b=4oxUgsRCi+dz2Nwc5fvToYA+mtQxbkR93MumR5+n2W4L6TyxaVQac5kNsKRapsZ0eQM2JV
        4fBSq9ka5/MS6DBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 50E12A3B8F;
        Fri, 17 Sep 2021 12:24:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2B4261E0CA7; Fri, 17 Sep 2021 14:24:24 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:24:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sheng Yong <shengyong2021@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Extend ioctl to allow to suppress events
Message-ID: <20210917122424.GB14905@quack2.suse.cz>
References: <20210916140649.1057-1-shengyong2021@gmail.com>
 <20210917084922.GC5284@quack2.suse.cz>
 <f52ff4e1-6d97-2d90-5b85-815311caea56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52ff4e1-6d97-2d90-5b85-815311caea56@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-09-21 20:05:28, Sheng Yong wrote:
> Hi, Honza,
> 
> On 2021/9/17 16:49, Jan Kara wrote:
> > On Thu 16-09-21 22:06:49, Sheng Yong wrote:
> > > This patch adds a new ioctl cmd INOTIFY_IOC_SUPRESS to stop queueing
> > > events temporarily. A second ioctl could resume queueing events again.
> > > With it enabled, we could easily suppress events instead of updating
> > > or removing watches, especially if we have losts of watches referring
> > > to one inotify instance, for example watching a directory recursively.
> > > 
> > > Signed-off-by: Sheng Yong <shengyong2021@gmail.com>
> > 
> > Thanks for the patch! This ioctl on its own is equivalent to shutting down
> > the notification group so I don't think it is really useful on its own.
> 
> Thanks for your reply.
> Yes, this ioctl reuses the stop-queueing-events procedure of shutdown.
> 
> > If you add ioctl to resume queueing, it makes some sense but can you
> > ellaborate a bit more why you need to stop receiving events temporarily?
> 
> The usecase is that we use rsync+inotify to backup files. Let's say there are
> two tasks: 1) "real-time" task reads events and syncs the file; 2) periodic
> task syncs all files recursively in the source directory.
> 
> If the queue get overflowed and new events are discarded, we have to start a
> recursive sync. But recursive sync takes a very long time to scan, compare and
> transmit data, we prefer a periodic task to do that, so that we could ignore
> overflow events.
> 
> When the periodic task is working, I think the "real-time" task should stop
> reading and handling new events temporarily to avoid duplicated IO in both
> sides. I think stop queueing new events is the easiest way to do that.

Well, but you can very easily avoid duplicated syncs by comparing mtimes of
source / destination (or perhaps keeping internal DB of copied files and
the times when you've copied them). Also if you stop processing events
while doing recursive copy, then you'll miss changes to files already
copied by recursive copy but happening while the recursive pass is still
copying other files. Finally, even if you decided you really want to ignore
events during recursive copying, the overhead of not processing them during
the recursive copy and then just discarding them all after recursive copy
is done isn't that big? Sure you can miss some changes but as I explained
that can happen anyway even with the "suspend" solution. So so far I'm not
convinced the new kernel API is useful enough...

								Honza

> > You'll have to rescan whole directory hierarchy anyway after resuming to be
> > able to see what has changed so the usefullness of this feature is unclear
> > to me...
> > 
> > Also we generally don't add new functionality to inotify and rather direct
> > that towards fanotify and finally I'm not sure ioctl() is the best API for
> > this but let's cover these questions once the usecase is clear.
> > 
> > 								Honza
> > 
> > > ---
> > >   fs/notify/fanotify/fanotify_user.c |  2 +-
> > >   fs/notify/group.c                  | 12 +++++++++---
> > >   fs/notify/inotify/inotify_user.c   |  4 ++++
> > >   fs/notify/mark.c                   |  3 ++-
> > >   fs/notify/notification.c           |  4 ++--
> > >   include/linux/fsnotify_backend.h   | 10 +++++++---
> > >   include/uapi/linux/inotify.h       |  3 +++
> > >   7 files changed, 28 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 6facdf476255..1e24738762d3 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -773,7 +773,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
> > >   	 * userspace cannot use fanotify fd anymore, no event can enter or
> > >   	 * leave access_list by now either.
> > >   	 */
> > > -	fsnotify_group_stop_queueing(group);
> > > +	fsnotify_group_stop_queueing(group, FS_GRP_SHUTDOWN);
> > >   	/*
> > >   	 * Process all permission events on access_list and notification queue
> > > diff --git a/fs/notify/group.c b/fs/notify/group.c
> > > index fb89c351295d..ce62ce6caf30 100644
> > > --- a/fs/notify/group.c
> > > +++ b/fs/notify/group.c
> > > @@ -34,10 +34,16 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
> > >    * Stop queueing new events for this group. Once this function returns
> > >    * fsnotify_add_event() will not add any new events to the group's queue.
> > >    */
> > > -void fsnotify_group_stop_queueing(struct fsnotify_group *group)
> > > +void fsnotify_group_stop_queueing(struct fsnotify_group *group, unsigned int st)
> > >   {
> > > +	if (st & ~FS_GRP_STOP_QUEUEING)
> > > +		return;
> > > +
> > >   	spin_lock(&group->notification_lock);
> > > -	group->shutdown = true;
> > > +	if (group->state & st)
> > > +		group->state &= ~st;
> > > +	else
> > > +		group->state |= st;
> > >   	spin_unlock(&group->notification_lock);
> > >   }
> > > @@ -55,7 +61,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
> > >   	 * fsnotify_destroy_group() is called and this makes the other callers
> > >   	 * of fsnotify_destroy_group() to see the same behavior.
> > >   	 */
> > > -	fsnotify_group_stop_queueing(group);
> > > +	fsnotify_group_stop_queueing(group, FS_GRP_SHUTDOWN);
> > >   	/* Clear all marks for this group and queue them for destruction */
> > >   	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
> > > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > > index 62051247f6d2..67cf47f1943b 100644
> > > --- a/fs/notify/inotify/inotify_user.c
> > > +++ b/fs/notify/inotify/inotify_user.c
> > > @@ -327,6 +327,10 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
> > >   		}
> > >   		break;
> > >   #endif /* CONFIG_CHECKPOINT_RESTORE */
> > > +	case INOTIFY_IOC_SUPPRESS:
> > > +		fsnotify_group_stop_queueing(group, FS_GRP_SUPPRESS);
> > > +		ret = 0;
> > > +		break;
> > >   	}
> > >   	return ret;
> > > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > > index fa1d99101f89..08f9d1e480de 100644
> > > --- a/fs/notify/mark.c
> > > +++ b/fs/notify/mark.c
> > > @@ -343,7 +343,8 @@ static void fsnotify_put_mark_wake(struct fsnotify_mark *mark)
> > >   		 * We abuse notification_waitq on group shutdown for waiting for
> > >   		 * all marks pinned when waiting for userspace.
> > >   		 */
> > > -		if (atomic_dec_and_test(&group->user_waits) && group->shutdown)
> > > +		if (atomic_dec_and_test(&group->user_waits) &&
> > > +		    group->state & FS_GRP_SHUTDOWN)
> > >   			wake_up(&group->notification_waitq);
> > >   	}
> > >   }
> > > diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> > > index 32f45543b9c6..6586e09e9141 100644
> > > --- a/fs/notify/notification.c
> > > +++ b/fs/notify/notification.c
> > > @@ -76,7 +76,7 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
> > >    * 0 if the event was added to a queue
> > >    * 1 if the event was merged with some other queued event
> > >    * 2 if the event was not queued - either the queue of events has overflown
> > > - *   or the group is shutting down.
> > > + *   or the group is suppressing or shutting down.
> > >    */
> > >   int fsnotify_add_event(struct fsnotify_group *group,
> > >   		       struct fsnotify_event *event,
> > > @@ -92,7 +92,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
> > >   	spin_lock(&group->notification_lock);
> > > -	if (group->shutdown) {
> > > +	if (group->state & FS_GRP_STOP_QUEUEING) {
> > >   		spin_unlock(&group->notification_lock);
> > >   		return 2;
> > >   	}
> > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > > index 1ce66748a2d2..1f9b2afb26cb 100644
> > > --- a/include/linux/fsnotify_backend.h
> > > +++ b/include/linux/fsnotify_backend.h
> > > @@ -103,6 +103,10 @@
> > >   #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_EVENTS | ALL_FSNOTIFY_FLAGS)
> > > +#define FS_GRP_SHUTDOWN 0x1	/* group is being shut down, don't queue more events */
> > > +#define FS_GRP_SUPPRESS 0x2	/* group is being suppressed, don't queue more events */
> > > +#define FS_GRP_STOP_QUEUEING (FS_GRP_SHUTDOWN | FS_GRP_SUPPRESS)
> > > +
> > >   struct fsnotify_group;
> > >   struct fsnotify_event;
> > >   struct fsnotify_mark;
> > > @@ -202,7 +206,7 @@ struct fsnotify_group {
> > >   	#define FS_PRIO_1	1 /* fanotify content based access control */
> > >   	#define FS_PRIO_2	2 /* fanotify pre-content access */
> > >   	unsigned int priority;
> > > -	bool shutdown;		/* group is being shut down, don't queue more events */
> > > +	unsigned int state;
> > >   	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
> > >   	struct mutex mark_mutex;	/* protect marks_list */
> > > @@ -472,8 +476,8 @@ extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_op
> > >   extern void fsnotify_get_group(struct fsnotify_group *group);
> > >   /* drop reference on a group from fsnotify_alloc_group */
> > >   extern void fsnotify_put_group(struct fsnotify_group *group);
> > > -/* group destruction begins, stop queuing new events */
> > > -extern void fsnotify_group_stop_queueing(struct fsnotify_group *group);
> > > +/* group destruction begins or suppresses, stop queuing new events */
> > > +extern void fsnotify_group_stop_queueing(struct fsnotify_group *group, unsigned int st);
> > >   /* destroy group */
> > >   extern void fsnotify_destroy_group(struct fsnotify_group *group);
> > >   /* fasync handler function */
> > > diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
> > > index 884b4846b630..07155241d5a9 100644
> > > --- a/include/uapi/linux/inotify.h
> > > +++ b/include/uapi/linux/inotify.h
> > > @@ -78,7 +78,10 @@ struct inotify_event {
> > >    *
> > >    * INOTIFY_IOC_SETNEXTWD: set desired number of next created
> > >    * watch descriptor.
> > > + *
> > > + * INOTIFY_IOC_SUPPRESS: suppress events temporarily.
> > >    */
> > >   #define INOTIFY_IOC_SETNEXTWD	_IOW('I', 0, __s32)
> > > +#define INOTIFY_IOC_SUPPRESS	_IOW('I', 1, __s32)
> > >   #endif /* _UAPI_LINUX_INOTIFY_H */
> > > -- 
> > > 2.20.1
> > > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
