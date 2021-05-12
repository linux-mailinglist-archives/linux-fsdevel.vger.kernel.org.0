Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE037D04C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhELRcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 13:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244177AbhELQmk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 12:42:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C36261D35;
        Wed, 12 May 2021 16:11:22 +0000 (UTC)
Date:   Wed, 12 May 2021 18:11:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210512161119.4jpyxeav44cs322m@wittgenstein>
References: <20201125110156.GB16944@quack2.suse.cz>
 <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz>
 <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 02:37:59PM +0300, Amir Goldstein wrote:
> On Mon, May 10, 2021 at 1:13 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 05-05-21 16:24:05, Christian Brauner wrote:
> > > On Wed, May 05, 2021 at 02:28:15PM +0200, Jan Kara wrote:
> > > > On Mon 03-05-21 21:44:22, Amir Goldstein wrote:
> > > > > > > Getting back to this old thread, because the "fs view" concept that
> > > > > > > it presented is very close to two POCs I tried out recently which leverage
> > > > > > > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> > > > > > >
> > > > > > > The first POC was replacing the is_subtree() check with in_userns()
> > > > > > > which is far less expensive:
> > > > > > >
> > > > > > > https://github.com/amir73il/linux/commits/fanotify_in_userns
> > > > > > >
> > > > > > > This approach reduces the cost of check per mark, but there could
> > > > > > > still be a significant number of sb marks to iterate for every fs op
> > > > > > > in every container.
> > > > > > >
> > > > > > > The second POC is based off the first POC but takes the reverse
> > > > > > > approach - instead of marking the sb object and filtering by userns,
> > > > > > > it places a mark on the userns object and filters by sb:
> > > > > > >
> > > > > > > https://github.com/amir73il/linux/commits/fanotify_idmapped
> > > > > > >
> > > > > > > The common use case is a single host filesystem which is
> > > > > > > idmapped via individual userns objects to many containers,
> > > > > > > so normally, fs operations inside containers would have to
> > > > > > > iterate a single mark.
> > > > > > >
> > > > > > > I am well aware of your comments about trying to implement full
> > > > > > > blown subtree marks (up this very thread), but the userns-sb
> > > > > > > join approach is so much more low hanging than full blown
> > > > > > > subtree marks. And as a by-product, it very naturally provides
> > > > > > > the correct capability checks so users inside containers are
> > > > > > > able to "watch their world".
> > > > > > >
> > > > > > > Patches to allow resolving file handles inside userns with the
> > > > > > > needed permission checks are also available on the POC branch,
> > > > > > > which makes the solution a lot more useful.
> > > > > > >
> > > > > > > In that last POC, I introduced an explicit uapi flag
> > > > > > > FAN_MARK_IDMAPPED in combination with
> > > > > > > FAN_MARK_FILESYSTEM it provides the new capability.
> > > > > > > This is equivalent to a new mark type, it was just an aesthetic
> > > > > > > decision.
> > > > > >
> > > > > > So in principle, I have no problem with allowing mount marks for ns-capable
> > > > > > processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> > > > > > look OK to me (although if we extended mount marks to support directory
> > > > > > events as you try elsewhere, would there be still be a compeling usecase for
> > > > > > this?).
> > > > >
> > > > > In my opinion it would. This is the reason why I stopped that direction.
> > > > > The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
> > > > > and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
> > > > > a bind mount or cloning a mount ns while the former is "sticky" to all additions
> > > > > to the mount tree that happen below the idmapped mount.
> > > >
> > > > As far as I understood Christian, he was specifically interested in mount
> > > > events for container runtimes because filtering by 'mount' was desirable
> > > > for his usecase. But maybe I misunderstood. Christian? Also if you have
> > >
> > > I discussed this with Amir about two weeks ago. For container runtimes
> > > Amir's idea of generating events based on the userns the fsnotify
> > > instance was created in is actually quite clever because it gives a way
> > > for the container to receive events for all filesystems and idmapped
> > > mounts if its userns is attached to it. The model as we discussed it -
> > > Amir, please tell me if I'm wrong - is that you'd be setting up an
> > > fsnotify watch in a given userns and you'd be seeing events from all
> > > superblocks that have the caller's userns as s_user_ns and all mounts
> > > that have the caller's userns as mnt_userns. I think that's safe.
> >
> > OK, so this feature would effectively allow sb-wide watching of events that
> > are generated from within the container (or its descendants). That sounds
> > useful. Just one question: If there's some part of a filesystem, that is
> > accesible by multiple containers (and thus multiple namespaces), or if
> > there's some change done to the filesystem say by container management SW,
> > then event for this change won't be visible inside the container (despite
> > that the fs change itself will be visible).
> 
> That is correct.
> FYI, a privileged user can already mount an overlayfs in order to indirectly
> open and write to a file.
> 
> Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> 
> I wonder if that is a problem that we need to fix...
> 
> > This is kind of a similar
> > problem to the one we had with mount marks and why sb marks were created.
> > So aren't we just repeating the mistake with mount marks? Because it seems
> > to me that more often than not, applications are interested in getting
> > notification when what they can actually access within the fs has changed
> > (and this is what they actually get with the inode marks) and they don't
> > care that much where the change came from... Do you have some idea how
> > frequent are such cross-ns filesystem changes?
> 
> The use case surely exist, the question is whether this use case will be
> handled by a single idmapped userns or multiple userns.
> 
> You see, we simplified the discussion to an idmapped mount that uses
> the same userns and the userns the container processes are associated
> with, but in fact, container A can use userns A container B userns B and they
> can both access a shared idmapped mount mapped with userns AB.
> 
> I think at this point in time, there are only ideas about how the shared data
> case would be managed, but Christian should know better than me.

(Hm, my prior mail somehow got deleted it seems when mutt failed to send
it so retyping it.)

There are two main use-cases for now. The first is idmapped mounts for
rootfses, the second is idmapped mounts to share data between
containers.
The first case allows the container manager to keep the container's
rootfs or image completely untouched and just map the rootfs to the
container user namespace. This is implemented and used by systemd and
LXD already, i.e. merged and available to users (see [1] and [2]).
The second case is data sharing. That happens for example when sharing a
Download folder or the "Linux Files" folder on ChromeOS with a
container. The second case usually covers sharing data between the host
and the container and sharing data among multiple containers (and the
host).
In both cases the approach chosen can differ depending on how the
container manager envisions a container. For example, systemd usually
never puts the container in charge of resources it delegates to it this
includes a lot of the mounts it creates for the container. So systemd
chose in [1] to use a separate userns to attach to the container's
rootfs so that only the manager can delegate associated features that
are and will be based on the mnt_userns.
In contrast lxd treats containers as a mostly autonomous systems on a
par with a virtual machine and so chose to attach the container's userns
to idmap the rootfs.
Data sharing will work similarly. systemd will use a separate userns and
lxd and others will use the same userns.
If you share data among containers with different idmappings then you
will need to use different mounts with different idmappings attached to
them. That is not the common case but we do have such users.

[1]: https://github.com/systemd/systemd/pull/19438
[2]: https://github.com/lxc/lxc/pull/3709

> 
> > I fully appreciate the
> > simplicity of Amir's proposal but I'm trying to estimate when (or how many)
> > users are going to come back complaining it is not good enough ;).
> >
> 
> IMO we should seriously consider the following model:
> 1. Implement userns-filtered sb marks, WITHOUT relaxing capability checks -
>     setting userns-filtered sb marks requires the same capability as sb marks
> 2. When container users call fanotify_{init,mark}(), container manager can
>     intercept these calls (this is standard practice) and setup userns-filtered
>     sb marks on their behalf
> 3. Container manager has all the knowledge about shared data, so when
>     container A asks to watch the shared fs, container manager can do the
>     right thing and set filtered marks for userns A, B, AB or a subset depending
>     on configuration
> 4. Is it up to container manager to decide, per configuration, whether container
>     users should be able to get events on changes made on filesystem from the
>     host userns. Per configuration, container manager can decide to convert
>     a request for sb mark to a filtered sb mark, reject it, or allow
> it and filter by
>     subtree in userspace.
> 
> IOW, if we only implement the "simple" technical solution of the beast
> called "idmapped filesystem mark", container manager SW can leverage
> that to a lot more.

Yes, that should work. We already know how to do that and this is
essentially equivalent to how we manage bpf() for a container right now
(see [3] for an example).
The container manager would just need to intercept fanotify_mark() and
then use pidfd_getfd() to retrieve the fanotify fd and the dirfd,
perform the fanotify_mark() call for the container and then let seccomp
report success to the container process that called fanotify_mark(). The
infrastructure for that is already in place.

[3]: https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in-unprivileged-container-development
     https://people.kernel.org/brauner/the-seccomp-notifier-cranking-up-the-crazy-with-bpf

> 
> Having said that, I think we need to wait to see the deployed container
> management solutions that will be built on top of idmapped mounts and
> wait for feature requests for specific use cases.
> 
> Then we can see if the plan above makes sense.
> 
> I think we need to wait to see the deployed container management solutions
> that build on top of idmapped mounts and wait for feature requests for
> specific use cases.
> 
> Christian,
> 
> If you feel there is already a concrete use case to discuss, you may
> bring in the relevant users to discuss it.
> Otherwise, I would wait for the dust to settle before we continue this
> effort.

Ok, sure.
Christian
