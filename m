Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DBF33F761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhCQRqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:46:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37487 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhCQRpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:45:38 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMaEf-00009w-6B; Wed, 17 Mar 2021 17:45:33 +0000
Date:   Wed, 17 Mar 2021 18:45:32 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210317174532.cllfsiagoudoz42m@wittgenstein>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:19:57PM +0200, Amir Goldstein wrote:
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
> That may change when systemd home dirs feature starts to use
> idmapped mounts.
> Being able to watch the user's entire home directory is a big win
> already.

Hey Amir,
Hey Jan,

I think so too.

> 
> > subtree watches would be IMO interesting to much more users.
> 
> Agreed.

We have a use-case for subtree watches: One feature for containers we
have is that users can e.g. tell us that they want the container manager
to hotplug an arbitrary unix or block device into the container whenever
the relevant device shows up on the system. For example they could
instruct the container manager to plugin some new driver device when it
shows up in /dev. That works nicely because of uevents. But users quite
often also instruct us to plugin a path once it shows up in some
directory in the filesystem hierarchy and unplug it once it is removed.
Right now we're mainting an inotify-based hand-rolled recursive watch to
make this work so we detect that add and remove event. I would be wildly
excited if we could get rid of some of that complexity by using subtree
watches. The container manager on the host will be unaffected by this
feature since it will usually have root privileges and manage
unprivileged containers.
The unprivileged (userns use-case specifically here) subtree watches
will be necessary and really good to have to make this work for
container workloads and nested containers, i.e. where the container
manager itselfs runs in a container and starts new containres. Since the
subtree feature would be interesting for systemd itself and since our
container manager (ChromeOS etc.) runs systemd inside unprivileged
containers on a large scale it would be good if subtree watches could
work in userns too.

> 
> I was looking into that as well, using the example of nfsd_acceptable()
> to implement the subtree permission check.
> 
> The problem here is that even if unprivileged users cannot compromise
> security, they can still cause significant CPU overhead either queueing
> events or filtering events and that is something I haven't been able to
> figure out a way to escape from.
> 
> BUT, if you allow userns admin to setup subtree watches (a.k.a filtered
> filesystem marks) on a userns filesystem/idmapped mount, now users

I think that sounds reasonable.
If the mount really is idmapped, it might be interesting to consider
checking for privilege in the mnt_userns in addition to the regular
permission checks that fanotify performs. My (equally handwavy) thinking
is that this might allow for a nice feature where the creator of the
mount (e.g. systemd) can block the creation of subtree watches by
attaching a mnt_userns to the mnt that the user has no privilege in.
(Just a thought.).

Christian
