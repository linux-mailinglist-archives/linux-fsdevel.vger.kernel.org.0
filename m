Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3543477AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCXLtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:49:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231425AbhCXLst (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:48:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 494A7AD38;
        Wed, 24 Mar 2021 11:48:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC2F71F2C4D; Wed, 24 Mar 2021 12:48:47 +0100 (CET)
Date:   Wed, 24 Mar 2021 12:48:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210324114847.GA17458@quack2.suse.cz>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz>
 <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
 <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-03-21 20:38:32, Amir Goldstein wrote:
> > > > The problem here is that even if unprivileged users cannot compromise
> > > > security, they can still cause significant CPU overhead either queueing
> > > > events or filtering events and that is something I haven't been able to
> > > > figure out a way to escape from.
> > >
> > > WRT queueing overhead, given a user can place ~1M of directory watches, he
> > > can cause noticable total overhead for queueing events anyway. Furthermore
> >
> > I suppose so. But a user placing 1M dir watches at least adds this overhead
> > knowingly. Adding a overhead on the entire filesystem when just wanting to
> > watch a small subtree doesn't sound ideal. Especially in very nested setups.
> > So yes, we need to be careful.
> >
> 
> I was thinking about this some more and I think the answer is in your example.
> User can only place 1M dir watches if ucount marks limits permits it.
> 
> So whatever we allow to do with subtree or userns filtered marks should
> also be limited by ucounts.

Yes, agreed.

> > > the queue size is limited so unless the user spends time consuming events
> > > as well, the load won't last long. But I agree we need to be careful not to
> > > introduce too big latencies to operations generating events. So I think if
> > > we could quickly detect whether a generated event has a good chance of
> > > being relevant for some subtree watch of a group and queue it in that case
> > > and worry about permission checks only once events are received and thus
> > > receiver pays the cost of expensive checks, that might be fine as well.
> > >
> >
> > So far the only idea I had for "quickly detect" which I cannot find flaws in
> > is to filter by mnt_userms, but its power is limited.
> 
> So I have implemented this idea on fanotify_userns branch and the cost
> per "filtered" sb mark is quite low - its a pretty cheap check in
> send_to_group()
> But still, if an unbound number of users can add to the sb mark list it is
> not going to end well.

Thinking out loud: So what is the cost going to be for the side generating
events? Ideally it would of O(number of fanotify groups receiving event).
We cannot get better than that and if the constants aren't too big I think
this is acceptable overhead. Sure this can mean total work of (number of
users) * (max number of subtree marks per user) for queueing notification
event but I don't think it is practical for a DoS attack and I also don't
think that in practice users will be watching overlapping subtrees that
much.

The question is whether we can get that fast. Probably not because that
would have to attach subtree watches to directory inodes or otherwise
filter out unrelated fanotify groups in O(1). But the complexity of
O(number of groups receiving events + depth of dir where event is happening)
is probably achievable - we'd walk the tree up and have roots of watched
subtrees marked. What do you think?

Also there is a somewhat related question what is the semantics of subtree
watches in presence of mounts - do subtree watches "see through" mount
points? Probably not but then with bind mounts this can be sometimes
inconvenient / confusing - e.g. if I have /tmp bind-mounted to /var/tmp and
I'm watching subtree of /var, I would not get events for what's in
/var/tmp... Which is logical if you spell it out like this but applications
often don't care how the mount hierarchy looks like, they just care about
locally visible directory structure.

> <hand waving>
> I think what we need here (thinking out loud) is to account the sb marks
> to the user that mounted the filesystem or to the user mapped to admin using
> idmapped mount, maybe to both(?), probably using a separate ucount entry
> (e.g. max_fanotify_filesystem_marks).

I'm somewhat lost here. Are these two users different? We have /home/foo
which is a mounted filesystem. AFAIU it will be mounted in a special user
namespace for user 'foo' - let's call is 'foo-ns'. /home/foo has idmapping
attached so system [ug]ids and non-trivially mapped to on-disk [ug]ids. Now
we have a user - let's call it 'foo-usr' that has enough capabilities
(whatever they are) in 'foo-ns' to place fanotify subtree marks in
/home/foo. So these marks are naturally accounted towards 'foo-usr'. To
whom else you'd like to also account these marks and why?

> We can set this limit by default to a small number (128?) to limit the sb list
> iteration per filesystem event and container manager / systemd can further
> limit this resource when creating idmapped mounts, which would otherwise
> allow the mapped user to add "filtered" (*) sb marks.
> </hand waving>
>
> (*) "filtered" can refer to both the userns filter I proposed and going forward
>      also maybe to subtree filter

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
