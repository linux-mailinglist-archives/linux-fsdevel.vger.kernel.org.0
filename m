Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBD34091F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCRPom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhCRPoP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:44:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B5B6AB8C;
        Thu, 18 Mar 2021 15:44:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E013D1F2BBF; Thu, 18 Mar 2021 16:44:13 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:44:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210318154413.GA21462@quack2.suse.cz>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-03-21 14:19:57, Amir Goldstein wrote:
> On Wed, Mar 17, 2021 at 1:42 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 17-03-21 13:01:35, Amir Goldstein wrote:
> > > On Tue, Mar 16, 2021 at 5:55 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 04-03-21 13:29:19, Amir Goldstein wrote:
> > > > > Jan,
> > > > >
> > > > > These patches try to implement a minimal set and least controversial
> > > > > functionality that we can allow for unprivileged users as a starting
> > > > > point.
> > > > >
> > > > > The patches were tested on top of v5.12-rc1 and the fanotify_merge
> > > > > patches using the unprivileged listener LTP tests written by Matthew
> > > > > and another LTP tests I wrote to test the sysfs tunable limits [1].
> > > >
> > > > Thanks. I've added both patches to my tree.
> > >
> > > Great!
> > > I'll go post the LTP tests and work on the man page updates.
> > >
> > > BTW, I noticed that you pushed the aggregating for_next branch,
> > > but not the fsnotify topic branch.
> > >
> > > Is this intentional?
> >
> > Not really, pushed now. Thanks for reminder.
> >
> > > I am asking because I am usually basing my development branches
> > > off of your fsnotify branch, but I can base them on the unpushed branch.
> > >
> > > Heads up. I am playing with extra privileges we may be able to
> > > allow an ns_capable user.
> > > For example, watching a FS_USERNS_MOUNT filesystem that the user
> > > itself has mounted inside userns.
> > >
> > > Another feature I am investigating is how to utilize the new idmapped
> > > mounts to get a subtree watch functionality. This requires attaching a
> > > userns to the group on fanotify_init().
> > >
> > > <hand waving>
> > > If the group's userns are the same or below the idmapped mount userns,
> > > then all the objects accessed via that idmapped mount are accessible
> > > to the group's userns admin. We can use that fact to filter events very
> > > early based on their mnt_userns and the group's userns, which should be
> > > cheaper than any subtree permission checks.
> > > <\hand waving>
> >
> > Yeah, I agree this should work. Just it seems to me the userbase for this
> > functionality will be (at least currently) rather limited. While full
> 
> That may change when systemd home dirs feature starts to use idmapped
> mounts. Being able to watch the user's entire home directory is a big
> win already.

Do you mean that home directory would be an extra mount with userns in
which the user has CAP_SYS_ADMIN so he'd be able to watch subtrees on that
mount?

> > subtree watches would be IMO interesting to much more users.
> 
> Agreed.
> 
> I was looking into that as well, using the example of nfsd_acceptable()
> to implement the subtree permission check.
> 
> The problem here is that even if unprivileged users cannot compromise
> security, they can still cause significant CPU overhead either queueing
> events or filtering events and that is something I haven't been able to
> figure out a way to escape from.

WRT queueing overhead, given a user can place ~1M of directory watches, he
can cause noticable total overhead for queueing events anyway. Furthermore
the queue size is limited so unless the user spends time consuming events
as well, the load won't last long. But I agree we need to be careful not to
introduce too big latencies to operations generating events. So I think if
we could quickly detect whether a generated event has a good chance of
being relevant for some subtree watch of a group and queue it in that case
and worry about permission checks only once events are received and thus
receiver pays the cost of expensive checks, that might be fine as well.

								Honza
 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
