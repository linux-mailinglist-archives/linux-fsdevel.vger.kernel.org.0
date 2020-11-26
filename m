Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA132C52A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbgKZLKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 06:10:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:43322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388740AbgKZLKi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:10:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8546AE2D;
        Thu, 26 Nov 2020 11:10:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 76BA31E130F; Thu, 26 Nov 2020 12:10:36 +0100 (CET)
Date:   Thu, 26 Nov 2020 12:10:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20201126111036.GC422@quack2.suse.cz>
References: <20201109180016.80059-1-amir73il@gmail.com>
 <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz>
 <CAOQ4uxiaaQ9X8EBS-bd2DNMdg7ezNoRXCRvu+4idikx67OFbQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiaaQ9X8EBS-bd2DNMdg7ezNoRXCRvu+4idikx67OFbQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-11-20 14:34:16, Amir Goldstein wrote:
> On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> > In fact I was considering for a while that we could even make subtree
> > watches completely unpriviledged - when we walk the dir tree anyway, we
> > could also check permissions along the way. Due to locking this would be
> > difficult to do when generating the event but it might be actually doable
> > if we perform the permission check when reporting the event to userspace.
> > Just a food for thought...
> 
> Maybe... but there are some other advantages to restricting to mount.
> 
> One is that with btrfs subvolumes conn->fsid can actually cache the
> subvolume's fsid and we could remove the restriction of -EXDEV
> error of FAN_MARK_FILESYSTEM on subvolume.

I'm not sure I understand this - do you mean we could support
FAN_MARK_FILESYSTEM_SUBTREE on btrfs subvolumes? I agree with that. I'm
just not sure how subtree watches are related to general
FAN_MARK_FILESYSTEM marks on btrfs...

> Another has to do with performance optimization (see below).

This is a good point. Also we can start with supporting subtree watches
only for mountpoints and if there's a need and reasonable way to do it we can
always expand the support to any directory.

> > > > Also I think this is going to get expensive
> > > > (e.g. imagine each write to page cache having to traverse potentially deep
> > > > tree hierarchy potentially multiple times - once for each subtree). My
> > > > suspicion should be verified with actual performance measurement but if I'm
> > > > right and the overhead is indeed noticeable, I think we'll need to employ
> > > > some caching or so to avoid repeated lookups...
> > >
> > > It's true, but here is a different angle to analyse the overhead - claim:
> > > "If users don't have kernel subtree mark, they will use filesystem mark
> > >  and filter is userspace". If that claim is true, than one can argue that
> > > this is fair - let the listener process pay the CPU overhead which can be
> > > contained inside a cgroup and not everyone else. But what is the cost that
> > > everyone else will be paying in that case?
> > > Everyone will still pay the cost of the fanotify backend callback including
> > > allocate, pack and queue the event.
> > > The question then becomes, what is cheaper? The d_ancestor() traversal
> > > or all the fanotify backend handler code?
> > > Note that the former can be lockless and the latter does take locks.
> >
> > I understand and it's a fair point that queueing of the event is not cheap
> > either so I'd be interested in the numbers. Something like how deep subtree
> > walk is similar to a cost of queueing event. Or similarly checking of how many
> > subtree watches is similarly costly as queueing of one event?
> >
> 
> The cost shouldn't actually be sensitive to the number of subtree watches.
> We should never do more than a single ancestor traversal per event up to
> it's sb root and for each ancestor we should be able to check with O(1) if
> a subtree watch exists on that inode/dentry.

Yeah, if the subtree check will not depend on the number of watched
subtrees on the sb (i.e., single traversal and O(1) checks on each dentry)
then I'm much more relaxed about it ;).

> If we stay with the bind mount restriction then we can use the check
> d_mountpoint() on every ancestor which practically reduces the cost per
> ancestor to zero in most cases.

Yep, even better. Although now that I'm thinking about it, if we use
connector of the directory inode for subtree root to cache info whether it
is a root of a subtree for some watch, we can still do O(1) check for any
dir pretty easily. But d_mountpoint() is even cheaper (more likely to be
cache hot).

> > > I have a pretty good bet on the answer, but as you say only actual performance
> > > benchmarks can tell.
> > >
> > > From my experience, real life fsevent listeners do not listen on FAN_MODIFY
> > > but they listen on FAN_CLOSE_WRITE, because the the former is too noisy.
> >
> > Agreed.
> >
> > > The best case scenario is that users step forward to say that they want to
> > > use fanotify but need the subtree filterting and can provide us with real life
> > > performance measurement of the userspace vs. kernel alternatives (in terms
> > > of penalty on the rest of the system).
> >
> > With the cost of having to go to userspace and there do essentially the same
> > subtree walk as you do in the kernel, I have no doubt what's going to be
> > faster (by orders of magnitude). What I'm somewhat uncertain is whether the
> > subtree check is OK at the time of event generation or whether it should
> > better be moved to the moment when we are about to report the event to
> > userspace (when the cost of the subtree check goes to the process
> > interested in the event which is fine - but as you properly note we already
> > had to pay the cost of queueing the event so it isn't clear this is a win
> > even for the processes generating events).
> >
> 
> I think the only semantics that make sense are:
> 
> * If all object's present and past ancestors were always under subtree -
>    guaranty to get an event
> * If all object's present and past ancestors were never under subtree -
>    guaranty to not get an event
> * Otherwise - undefined
> 
> So I think it is ok to check for subtree on event generation time.

I meant that I'm uncertain whether the check is OK at the time of event
generation due to performance. Regarding semantics, I agree that both
options are fine. But after somewhat optimizing the subtree check as you
describe above, I'm not much concerned anymore. So the only reason I'd see
for moving the checks to event report time would be if we decided to do
more fancy stuff like permission checks (which I'd find really neat as that
would allow unpriviledged subtree watching and there are *lots* of users
for that from desktop world - but that's the next level ;))...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
