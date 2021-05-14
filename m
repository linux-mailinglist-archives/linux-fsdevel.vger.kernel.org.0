Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B476C380ACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhENN5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 09:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhENN5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 09:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6532B6101A;
        Fri, 14 May 2021 13:56:35 +0000 (UTC)
Date:   Fri, 14 May 2021 15:56:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
References: <20201126111725.GD422@quack2.suse.cz>
 <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein>
 <20210513105526.GG2734@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210513105526.GG2734@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 12:55:26PM +0200, Jan Kara wrote:
> On Wed 12-05-21 17:26:25, Christian Brauner wrote:
> > On Mon, May 10, 2021 at 02:37:59PM +0300, Amir Goldstein wrote:
> > > On Mon, May 10, 2021 at 1:13 PM Jan Kara <jack@suse.cz> wrote:
> > > > OK, so this feature would effectively allow sb-wide watching of events that
> > > > are generated from within the container (or its descendants). That sounds
> > > > useful. Just one question: If there's some part of a filesystem, that is
> > > > accesible by multiple containers (and thus multiple namespaces), or if
> > > > there's some change done to the filesystem say by container management SW,
> > > > then event for this change won't be visible inside the container (despite
> > > > that the fs change itself will be visible).
> > > 
> > > That is correct.
> > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > open and write to a file.
> > > 
> > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > > 
> > > I wonder if that is a problem that we need to fix...
> > > 
> > > > This is kind of a similar
> > > > problem to the one we had with mount marks and why sb marks were created.
> > > > So aren't we just repeating the mistake with mount marks? Because it seems
> > > > to me that more often than not, applications are interested in getting
> > > > notification when what they can actually access within the fs has changed
> > > > (and this is what they actually get with the inode marks) and they don't
> > > > care that much where the change came from... Do you have some idea how
> > > > frequent are such cross-ns filesystem changes?
> > > 
> > > The use case surely exist, the question is whether this use case will be
> > > handled by a single idmapped userns or multiple userns.
> > > 
> > > You see, we simplified the discussion to an idmapped mount that uses
> > > the same userns and the userns the container processes are associated
> > > with, but in fact, container A can use userns A container B userns B and they
> > > can both access a shared idmapped mount mapped with userns AB.
> > > 
> > > I think at this point in time, there are only ideas about how the shared data
> > > case would be managed, but Christian should know better than me.
> > 
> > I think there are two major immediate container use-cases right now that
> > are already actively used:
> > 1. idmapped rootfs
> > A container manager wants to avoid recursively chowning the rootfs or
> > image for a container. To this end an idmapped mount is created. The
> > idmapped mount can either share the same userns as the container itself
> > or a separate userns can be used. What people use depends on their
> > concept of a container.
> > For example, systemd has merged support for idmapping a containers
> > rootfs in [1]. The systemd approach to containers never puts the
> > container itself in control of most things including most of its mounts.
> > That is very much the approach of having it be a rather tightly managed
> > system. Specifically, this means that systemd currently uses a separate
> > userns to idmap.
> > In contrast other container managers usually treat the container as a
> > mostly separate system and put it in charge of all its mounts. This
> > means the userns used for the idmapped mount will be the same as the
> > container runs in (see [2]).
> 
> OK, thanks for explanation. So to make fanotify idmap-filtered marks work
> for systemd-style containers we would indeed need what Amir proposed -
> i.e., the container manager intercepts fanotify_mark calls and decides
> which namespace to setup the mark in as there's no sufficient priviledge
> within the container to do that AFAIU.

Yes, that's how that would work.

> 
> > 2. data sharing among containers or among the host and containers etc.
> > The most common use-case is to share data from the host with the
> > container such as a download folder or the Linux folder on ChromeOS.
> > Most container managers will simly re-use the container's userns for
> > that too. More complex cases arise where data is shared between
> > containers with different idmappings then often a separate userns will
> > have to be used.
> 
> OK, but if say on ChromeOS you copy something to the Linux folder by app A
> (say file manager) and containerized app B (say browser) watches that mount

For ChromeOS it is currently somewhat simple since they currently only
allow a single container by default. So everytime you start an app in
the container it's the same app so they all write to the Linux Files
folder through the same container. (I'm glossing over a range of details
but that's not really relevant to the general spirit of the example.).


> for changes with idmap-filtered mark, then it won't see notification for
> those changes because A presumably runs in a different namespace than B, am
> I imagining this right? So mark which filters events based on namespace of
> the originating process won't be usable for such usecase AFAICT.

Idmap filtered marks won't cover that use-case as envisioned now. Though
I'm not sure they really need to as the semantics are related to mount
marks. A mount mark would allow you to receive events based on the
originating mount. If two mounts A and B are separate but expose the
same files you wouldn't see events caused by B if you're watching A.
Similarly you would only see events from mounts that have been delegated
to you through the idmapped userns. I find this acceptable especially if
clearly documented.

Christian
