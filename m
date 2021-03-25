Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19334934C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYNtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 09:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhCYNt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AB10AA55;
        Thu, 25 Mar 2021 13:49:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 15BC61E4415; Thu, 25 Mar 2021 14:49:24 +0100 (CET)
Date:   Thu, 25 Mar 2021 14:49:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210325134924.GA13673@quack2.suse.cz>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz>
 <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
 <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com>
 <20210324114847.GA17458@quack2.suse.cz>
 <CAOQ4uxgjM8qC-Kre9ahMQzzhsOFtCXu4Vzd2HYUsSOstgf9Jyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgjM8qC-Kre9ahMQzzhsOFtCXu4Vzd2HYUsSOstgf9Jyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-03-21 17:50:52, Amir Goldstein wrote:
> > > So I have implemented this idea on fanotify_userns branch and the cost
> > > per "filtered" sb mark is quite low - its a pretty cheap check in
> > > send_to_group()
> > > But still, if an unbound number of users can add to the sb mark list it is
> > > not going to end well.
> >
> > Thinking out loud: So what is the cost going to be for the side generating
> > events? Ideally it would of O(number of fanotify groups receiving event).
> > We cannot get better than that and if the constants aren't too big I think
> > this is acceptable overhead. Sure this can mean total work of (number of
> > users) * (max number of subtree marks per user) for queueing notification
> > event but I don't think it is practical for a DoS attack and I also don't
> > think that in practice users will be watching overlapping subtrees that
> > much.
> >
> 
> Why overlapping?
> My concern is not so much from DoS attacks.
> My concern is more from innocent users adding unacceptable
> accumulated overhead.
> 
> Think of a filesystem mounted at /home/ with 100K directories at
> /home/user$N, every user gets its own idmapped mount from
> systemd-homed and may or may not choose to run a listener to
> get events generated under its own home dir (which is an idmapped
> mount). Even if we limit one sb mask per user, we can still have 100K
> marks list in sb.

I see but then you'd have to have 100K users using the same filesystem on
the server at the same time? Which doesn't look likely to me? I'd presume
the home dir is watched only if the user is actually running something on
that machine... So I'm not sure how realistic this example is. But yes,
maybe we need some more efficient algorithm for selecting which subtree
watch is actually relevant for an event.

> For this reason I think we need to limit the number of marks per sb.
> The simple way is a global config like max_queued_events, but I think
> we can do better than that.

Adding a global limit on number of sb marks is OK but still I'd like the
system to scale reasonably with say tens to hundreds watches...

> > The question is whether we can get that fast. Probably not because that
> > would have to attach subtree watches to directory inodes or otherwise
> > filter out unrelated fanotify groups in O(1). But the complexity of
> > O(number of groups receiving events + depth of dir where event is happening)
> > is probably achievable - we'd walk the tree up and have roots of watched
> > subtrees marked. What do you think?
> 
> I am for that. I already posted a POC along those lines [1].
> I was just not sure how to limit the potential accumulated overhead.
> 
> [1] https://github.com/amir73il/linux/commits/fanotify_subtree_mark

Yes, but AFAICT your solution was O((number of subtree marks on sb) * depth
of dir) while I'm speaking about O(number of *groups* on sb + depth of
dir). Which is significantly less and will require more careful setup to
achieve such complexity (like placing special marks in lists of watches for
directories that are roots of watched subtrees and checking such lists when
walking up the tree).

> > Also there is a somewhat related question what is the semantics of subtree
> > watches in presence of mounts - do subtree watches "see through" mount
> > points? Probably not but then with bind mounts this can be sometimes
> > inconvenient / confusing - e.g. if I have /tmp bind-mounted to /var/tmp and
> > I'm watching subtree of /var, I would not get events for what's in
> > /var/tmp... Which is logical if you spell it out like this but applications
> > often don't care how the mount hierarchy looks like, they just care about
> > locally visible directory structure.
> 
> Those are hard questions.  I think that userns/mountns developers needed
> to address them a while ago and I think there are some helpers that help
> with checking visibility of paths.
> 
> > > <hand waving>
> > > I think what we need here (thinking out loud) is to account the sb marks
> > > to the user that mounted the filesystem or to the user mapped to admin using
> > > idmapped mount, maybe to both(?), probably using a separate ucount entry
> > > (e.g. max_fanotify_filesystem_marks).
> >
> > I'm somewhat lost here. Are these two users different? We have /home/foo
> > which is a mounted filesystem. AFAIU it will be mounted in a special user
> > namespace for user 'foo' - let's call is 'foo-ns'. /home/foo has idmapping
> > attached so system [ug]ids and non-trivially mapped to on-disk [ug]ids. Now
> > we have a user - let's call it 'foo-usr' that has enough capabilities
> > (whatever they are) in 'foo-ns' to place fanotify subtree marks in
> > /home/foo. So these marks are naturally accounted towards 'foo-usr'. To
> > whom else you'd like to also account these marks and why?
> >
> 
> I would like the system admin to be able to limit 100 sb marks on /home
> (filtered or not) because that impacts the send_to_group iteration.

OK, so per-sb limitation of sb mark number...

> I would also like systemd to be able to grant a smaller quota of filtered
> sb marks per user when creating and mapping the idmapped mounts
> at /home/foo$N

... and a ucount to go with it?

> I *think* we can achieve that, by accounting the sb marks to uid 0
> (who mounted /home) in ucounts entry "fanotify_sb_marks".

But a superblock can be mounted in multiple places, in multiple user
namespaces, potentially by different users (think of nested containers)? So
if we want a per-sb limit on sb marks, I think that accounting those per
user won't really achieve that?

> If /home would have been a FS_USERNS_MOUNT mounted inside
> some userns, then all its sb marks would be accounted to uid 0 of
> that userns.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
