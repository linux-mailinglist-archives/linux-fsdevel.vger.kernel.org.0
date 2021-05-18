Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC8387630
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbhERKM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241827AbhERKM6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:12:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C629460D07;
        Tue, 18 May 2021 10:11:39 +0000 (UTC)
Date:   Tue, 18 May 2021 12:11:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210518101135.jrldavggoibfpjhs@wittgenstein>
References: <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein>
 <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
 <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 15, 2021 at 05:28:27PM +0300, Amir Goldstein wrote:
> On Fri, May 14, 2021 at 4:56 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Thu, May 13, 2021 at 12:55:26PM +0200, Jan Kara wrote:
> > > On Wed 12-05-21 17:26:25, Christian Brauner wrote:
> > > > On Mon, May 10, 2021 at 02:37:59PM +0300, Amir Goldstein wrote:
> > > > > On Mon, May 10, 2021 at 1:13 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > OK, so this feature would effectively allow sb-wide watching of events that
> > > > > > are generated from within the container (or its descendants). That sounds
> > > > > > useful. Just one question: If there's some part of a filesystem, that is
> > > > > > accesible by multiple containers (and thus multiple namespaces), or if
> > > > > > there's some change done to the filesystem say by container management SW,
> > > > > > then event for this change won't be visible inside the container (despite
> > > > > > that the fs change itself will be visible).
> > > > >
> > > > > That is correct.
> > > > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > > > open and write to a file.
> > > > >
> > > > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > > > >
> > > > > I wonder if that is a problem that we need to fix...
> > > > >
> > > > > > This is kind of a similar
> > > > > > problem to the one we had with mount marks and why sb marks were created.
> > > > > > So aren't we just repeating the mistake with mount marks? Because it seems
> > > > > > to me that more often than not, applications are interested in getting
> > > > > > notification when what they can actually access within the fs has changed
> > > > > > (and this is what they actually get with the inode marks) and they don't
> > > > > > care that much where the change came from... Do you have some idea how
> > > > > > frequent are such cross-ns filesystem changes?
> > > > >
> > > > > The use case surely exist, the question is whether this use case will be
> > > > > handled by a single idmapped userns or multiple userns.
> > > > >
> > > > > You see, we simplified the discussion to an idmapped mount that uses
> > > > > the same userns and the userns the container processes are associated
> > > > > with, but in fact, container A can use userns A container B userns B and they
> > > > > can both access a shared idmapped mount mapped with userns AB.
> > > > >
> > > > > I think at this point in time, there are only ideas about how the shared data
> > > > > case would be managed, but Christian should know better than me.
> > > >
> > > > I think there are two major immediate container use-cases right now that
> > > > are already actively used:
> > > > 1. idmapped rootfs
> > > > A container manager wants to avoid recursively chowning the rootfs or
> > > > image for a container. To this end an idmapped mount is created. The
> > > > idmapped mount can either share the same userns as the container itself
> > > > or a separate userns can be used. What people use depends on their
> > > > concept of a container.
> > > > For example, systemd has merged support for idmapping a containers
> > > > rootfs in [1]. The systemd approach to containers never puts the
> > > > container itself in control of most things including most of its mounts.
> > > > That is very much the approach of having it be a rather tightly managed
> > > > system. Specifically, this means that systemd currently uses a separate
> > > > userns to idmap.
> > > > In contrast other container managers usually treat the container as a
> > > > mostly separate system and put it in charge of all its mounts. This
> > > > means the userns used for the idmapped mount will be the same as the
> > > > container runs in (see [2]).
> > >
> > > OK, thanks for explanation. So to make fanotify idmap-filtered marks work
> > > for systemd-style containers we would indeed need what Amir proposed -
> > > i.e., the container manager intercepts fanotify_mark calls and decides
> > > which namespace to setup the mark in as there's no sufficient priviledge
> > > within the container to do that AFAIU.
> >
> > Yes, that's how that would work.
> >
> > >
> > > > 2. data sharing among containers or among the host and containers etc.
> > > > The most common use-case is to share data from the host with the
> > > > container such as a download folder or the Linux folder on ChromeOS.
> > > > Most container managers will simly re-use the container's userns for
> > > > that too. More complex cases arise where data is shared between
> > > > containers with different idmappings then often a separate userns will
> > > > have to be used.
> > >
> > > OK, but if say on ChromeOS you copy something to the Linux folder by app A
> > > (say file manager) and containerized app B (say browser) watches that mount
> >
> > For ChromeOS it is currently somewhat simple since they currently only
> > allow a single container by default. So everytime you start an app in
> > the container it's the same app so they all write to the Linux Files
> > folder through the same container. (I'm glossing over a range of details
> > but that's not really relevant to the general spirit of the example.).
> >
> >
> > > for changes with idmap-filtered mark, then it won't see notification for
> > > those changes because A presumably runs in a different namespace than B, am
> > > I imagining this right? So mark which filters events based on namespace of
> > > the originating process won't be usable for such usecase AFAICT.
> >
> > Idmap filtered marks won't cover that use-case as envisioned now. Though
> > I'm not sure they really need to as the semantics are related to mount
> > marks.
> 
> We really need to refer to those as filesystem marks. They are definitely
> NOT mount marks. We are trying to design a better API that will not share
> as many flaws with mount marks...
> 
> > A mount mark would allow you to receive events based on the
> > originating mount. If two mounts A and B are separate but expose the
> > same files you wouldn't see events caused by B if you're watching A.
> > Similarly you would only see events from mounts that have been delegated
> > to you through the idmapped userns. I find this acceptable especially if
> > clearly documented.
> >
> 
> The way I see it, we should delegate all the decisions over to userspace,
> but I agree that the current "simple" proposal may not provide a good
> enough answer to the case of a subtree that is shared with the host.

I was focussed on what happens if you set an idmapped filtered mark for
a container for a set of files that is exposed to another container via
another idmapped mount. And it seemed to me that it was ok if the
container A doesn't see events from container B.

You seem to be looking at this from the host's perspective right now
which is interesting as well.

> 
> IMO, it should be a container manager decision whether changes done by
> the host are:
> a) Not visible to containerized application

Yes, that seems ok.

> b) Watched in host via recursive inode watches
> c) Watched in host by filesystem mark filtered in userspace
> d) Watched in host by an "noop" idmapped mount in host, through
>      which all relevant apps in host access the shared folder

So b)-d) are concerned with the host getting notifcations for changes
done from any container that uses a given set of files possibly through
different mounts.

> 
> We can later provide the option of "subtree filtered filesystem mark"
> which can be choice (e). It will incur performance overhead on the system
> that is higher than option (d) but lower than option (c).
> 
> In the end, it all depends on the individual use case.
> 
> The way forward as I see it is:
> 1. Need to write a proposal where FAN_MARK_IDMAPPED is the
>     first step towards a wider API that also includes subtree marks -
>     whether we end up implementing subtree mark or not
> 2. Need to make sure that setting up N idmapped marks
>     does not have O(N) performance overhead on the system
> 3. Need to make sure that the idmapped marks proposal is deemed
>     desired by concrete container manager project and use cases
> 
> If there are no objections to this roadmap, I will prepare the
> proposal on my next context switch.

Yes, sounds good.

Christian

