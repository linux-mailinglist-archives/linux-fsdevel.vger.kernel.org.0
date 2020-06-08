Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA31F1D00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgFHQNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:13:32 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:47741 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730267AbgFHQNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:13:32 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 12:13:31 EDT
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id B20F01C33D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 17:06:15 +0100 (IST)
Received: (qmail 1248 invoked from network); 8 Jun 2020 16:06:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jun 2020 16:06:15 -0000
Date:   Mon, 8 Jun 2020 17:06:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200608160614.GH3127@techsingularity.net>
References: <20200608140557.GG3127@techsingularity.net>
 <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:03:56PM +0300, Amir Goldstein wrote:
> > @@ -315,17 +315,12 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> >         struct fsnotify_iter_info iter_info = {};
> >         struct super_block *sb = to_tell->i_sb;
> >         struct mount *mnt = NULL;
> > -       __u32 mnt_or_sb_mask = sb->s_fsnotify_mask;
> > +       __u32 mnt_or_sb_mask;
> >         int ret = 0;
> > -       __u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> > +       __u32 test_mask;
> >
> > -       if (path) {
> > +       if (path)
> >                 mnt = real_mount(path->mnt);
> > -               mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> > -       }
> > -       /* An event "on child" is not intended for a mount/sb mark */
> > -       if (mask & FS_EVENT_ON_CHILD)
> > -               mnt_or_sb_mask = 0;
> >
> >         /*
> >          * Optimization: srcu_read_lock() has a memory barrier which can
> > @@ -337,11 +332,21 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> >         if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> >             (!mnt || !mnt->mnt_fsnotify_marks))
> >                 return 0;
> > +
> > +       /* An event "on child" is not intended for a mount/sb mark */
> > +       mnt_or_sb_mask = 0;
> > +       if (!(mask & FS_EVENT_ON_CHILD)) {
> > +               mnt_or_sb_mask = sb->s_fsnotify_mask;
> > +               if (path)
> > +                       mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> > +       }
> > +
> 
> Are you sure that loading ->_fsnotify_mask is so much more expensive
> than only checking ->_fsnotify_marks? They are surely on the same cache line.
> Isn't it possible that you just moved the penalty to ->_fsnotify_marks check
> with this change?

The profile indicated that the cost was in this line

	mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;

as opposed to the other checks. Hence, I deferred the calculation of
mnt_or_sb_mask until it was definitely needed. However, it's perfectly
possible that the line simply looked hot because the function entry was
hot in general.

> Did you test performance with just the fsnotify_parent() change alone?
> 

No, but I can. I looked at the profile of fsnotify() first before moving
on to fsnotify_parent() but I didn't test them in isolation as deferring
unnecessarily calculations in a fast path seemed reasonable.

> In any case, this hunk seriously conflicts with a patch set I am working on,
> so I would rather not merging this change as is.
> 
> If you provide me the feedback that testing ->_fsnotify_marks before loading
> ->_fsnotify_mask is beneficial on its own, then I will work this change into
> my series.
> 

Will do. If the fsnotify_parent() changes are useful on their own, I'll
post a v2 of the patch with just that change.

> >         /*
> >          * if this is a modify event we may need to clear the ignored masks
> >          * otherwise return if neither the inode nor the vfsmount/sb care about
> >          * this type of event.
> >          */
> > +       test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> >         if (!(mask & FS_MODIFY) &&
> >             !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
> >                 return 0;
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index 5ab28f6c7d26..508f6bb0b06b 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -44,6 +44,16 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
> >         fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
> >  }
> >
> > +/* Notify this dentry's parent about a child's events. */
> > +static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
> > +                                 const void *data, int data_type)
> > +{
> > +       if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
> > +               return 0;
> > +
> > +       return __fsnotify_parent(dentry, mask, data, data_type);
> > +}
> > +
> 
> This change looks good as is, but I'm afraid my series is going to
> make it obsolete.
> It may very well be that my series will introduce more performance
> penalty to your workload.
> 
> It would be very much appreciated if you could run a test for me.
> I will gladly work in some more optimizations into my series.
> 
> You can find the relevant part of my work at:
> https://github.com/amir73il/linux/commits/fsnotify_name
> 

Sure.

> What this work does essentially is two things:
> 1. Call backend once instead of twice when both inode and parent are
>     watching.
> 2. Snapshot name and parent inode to pass to backend not only when
>     parent is watching, but also when an sb/mnt mark exists which
>     requests to get file names with events.
> 
> Compared to the existing implementation of fsnotify_parent(),
> my code needs to also test bits in inode->i_fsnotify_mask,
> inode->i_sb->s_fsnotify_mask and mnt->mnt_fsnotify_mask
> before the fast path can be taken.
> So its back to square one w.r.t your optimizations.
> 

Seems fair but it may be worth noting that the changes appear to be
optimising the case where there are watchers. The case where there are
no watchers at all is also interesting and probably a lot more common. I
didn't look too closely at your series as I'm not familiar with fsnotify
in general. However, at a glance it looks like fsnotify_parent() executes
a substantial amount of code even if there are no watchers but I could
be wrong.

-- 
Mel Gorman
SUSE Labs
