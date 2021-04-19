Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E75364573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbhDSN4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 09:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241094AbhDSN4W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:56:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09EEFAFC9;
        Mon, 19 Apr 2021 13:55:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C29471F2C6A; Mon, 19 Apr 2021 15:55:50 +0200 (CEST)
Date:   Mon, 19 Apr 2021 15:55:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Matthew Bobrowski <repnop@google.com>, jack@suse.cz,
        amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <20210419135550.GH8706@quack2.suse.cz>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 15:20:20, Christian Brauner wrote:
> On Fri, Apr 16, 2021 at 09:22:25AM +1000, Matthew Bobrowski wrote:
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd is to be
> > returned instead of a pid for `struct fanotify_event_metadata.pid`.
> > 
> > FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> > pidfd API is currently restricted to only support pidfd generation for
> > thread-group leaders. Attempting to set them both when calling
> > fanotify_init(2) will result in -EINVAL being returned to the
> > caller. As the pidfd API evolves and support is added for tids, this
> > is something that could be relaxed in the future.
> > 
> > If pidfd creation fails, the pid in struct fanotify_event_metadata is
> > set to FAN_NOPIDFD(-1). Falling back and providing a pid instead of a
> > pidfd on pidfd creation failures was considered, although this could
> > possibly lead to confusion and unpredictability within userspace
> > applications as distinguishing between whether an actual pidfd or pid
> > was returned could be difficult, so it's best to be explicit.
> > 
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
> >  include/linux/fanotify.h           |  2 +-
> >  include/uapi/linux/fanotify.h      |  2 ++
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 9e0c1afac8bd..fd8ae88796a8 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  	struct fanotify_info *info = fanotify_event_info(event);
> >  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> >  	struct file *f = NULL;
> > -	int ret, fd = FAN_NOFD;
> > +	int ret, pidfd, fd = FAN_NOFD;
> >  	int info_type = 0;
> >  
> >  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >  	metadata.vers = FANOTIFY_METADATA_VERSION;
> >  	metadata.reserved = 0;
> >  	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > -	metadata.pid = pid_vnr(event->pid);
> > +
> > +	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> > +		pid_has_task(event->pid, PIDTYPE_TGID)) {
> > +		/*
> > +		 * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> > +		 * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> > +		 * blindly lifted without pidfds for threads actually being
> > +		 * supported.
> > +		 */
> > +		WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > +
> > +		pidfd = pidfd_create(event->pid, 0);
> > +		if (unlikely(pidfd < 0))
> > +			metadata.pid = FAN_NOPIDFD;
> > +		else
> > +			metadata.pid = pidfd;
> 
> I'm not a fan of overloading fields (Yes, we did this for the _legacy_
> clone() syscall for CLONE_PIDFD/CLONE_PARENT_SETTID but in general it's
> never a good idea if there are other options, imho.).
> Could/should we consider the possibility of adding a new pidfd field to
> struct fanotify_event_metadata?

I'm not a huge fan of overloading fields either but in this particular case
I'm fine with that because:

a) storage size & type matches
b) it describes exactly the same information, just in a different way

It is not possible to store the pidfd elsewhere in fanotify_event_metadata.
But it is certainly possible to use extended event info to return pidfd
instead - similarly to how we return e.g. handle + fsid for some
notification groups. It just means somewhat longer events and more
complicated parsing of structured events in userspace. But as I write
above, in this case I don't think it is worth it - only if we think that
returning both pid and pidfd could ever be useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
