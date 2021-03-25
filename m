Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD39348EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCYLM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 07:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhCYLMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6DEC61A25;
        Thu, 25 Mar 2021 11:12:06 +0000 (UTC)
Date:   Thu, 25 Mar 2021 12:12:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210325111203.5o6ovkqgigxc3ihk@wittgenstein>
References: <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
 <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
 <20210324143230.y36hga35xvpdb3ct@wittgenstein>
 <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
 <20210324162838.spy7qotef3kxm3l4@wittgenstein>
 <CAOQ4uxjcCEtuqyawNo7kCkb3213=vrstMupZt-KnGyanqKv=9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjcCEtuqyawNo7kCkb3213=vrstMupZt-KnGyanqKv=9Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 07:07:17PM +0200, Amir Goldstein wrote:
> > > Well there is another way.
> > > It is demonstrated in my demo with intoifywatch --fanotify --recursive.
> > > It involved userspace iterating a subtree of interest to create fid->path
> > > map.
> >
> > Ok, so this seems to be
> >
> > inotifytools_filename_from_fid()
> > -> if (fanotify_mark_type != FAN_MARK_FILESYSTEM)
> >            watch_from_fid()
> >    -> read_path_from(/proc/self/fd/w->dirfd)
> >
> 
> Yes.
> 
> > >
> > > The fanotify recursive watch is similar but not exactly the same as the
> > > old intoify recursive watch, because with inotify recursive watch you
> > > can miss events.
> > >
> > > With fanotify recursive watch, the listener (if capable) can setup a
> > > filesystem mark so events will not be missed. They will be recorded
> > > by fid with an unknown path and the path information can be found later
> > > by the crawler and updated in the map before the final report.
> > >
> > > Events on fid that were not found by the crawler need not be reported.
> > > That's essentially a subtree watch for the poor implemented in userspace.
> >
> > This is already a good improvement.
> > Honestly, having FAN_MARK_INODE workable unprivileged is already pretty
> 
> I'm not so sure why you say that, because unprivileged FAN_MARK_INODE
> watches are pretty close in functionality to inotify.
> There are only subtle differences.

Simply because until now we couldn't use fanotify in any way because of
the capable() restriction.

> 
> > great. In addition having FAN_MARK_MOUNT workable with idmapped mounts
> > will likely get us what most users care about, afaict that is the POC
> > in:
> > https://github.com/amir73il/linux/commit/f0d5d462c5baeb82a658944c6df80704434f09a1
> >
> 
> Hmm, the problem is the limited set of events you can get from
> FAN_MARK_MOUNT which does not include FAN_CREATE.

Yes, that's what I gathered from perusing the code.

> 
> > (I'm reading the source correctly that FAN_MARK_MOUNT works with
> > FAN_REPORT_FID as long as no inode event set in FANOTIFY_INODE_EVENTS is
> > set? I'm asking because my manpage - probably too old - seems to imply
> > that FAN_REPORT_FID can't be used with FAN_MARK_MOUNT although I might
> > just be stumbling over the phrasing.)
> >
> 
> commit d71c9b4a5c6fbc7164007b52dba1de410d018292
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Mon Apr 20 21:42:56 2020 +0300
> 
>     fanotify_mark.2: Clarification about FAN_MARK_MOUNT and FAN_REPORT_FID
> 
>     It is not true that FAN_MARK_MOUNT cannot be used with a group
>     that was initialized with flag FAN_REPORT_FID.

Btw, I don't see FAN_MARK_INODE in the man2 in the upstream repository.
I know it's essentially the 0 or default value but it would still be
worthwhile to mention it in the manpage.

>  ...
> 
> IOW, no FAN_CREATE, FAN_DELETE, FAN_MOVE
> 
> The technical reason for that is Al's objection to pass the mnt context
> into vfs helpers (and then fsnotify hooks).

Ah yes, I remember that.

> 
> > I think FAN_MARK_FILESYSTEM should simply stay under the s_userns_s
> > capable requirement. That's imho the cleanest semantics for this, i.e.
> > I'd drop:
> > https://github.com/amir73il/linux/commit/bd20e273f3c3a650805b3da32e493f01cc2a4763
> > This is neither an urgent use-case nor am I feeling very comfortable
> > with it.
> >
> 
> The purpose of this commit is to provide FAN_CREATE, FAN_DELETE
> FAN_MOVE events filtered by (an idmapped) mount.

I see.

I wanted to write a few words about the use-case you mention and the
need for subtree watches for this particular case:

"A common use case for of a filesystem subtree is a bind mount, not on
the root of the filesystem, such as the bind mounts used for
containers."

Which presumably means you want to point fanotify to the rootfs mount of
the container and have it watch everything under that rootfs including
any submounts in there. While this certainly might be useful I'm not
sure it's a very common use-case or really necessary to support.

Assuming a full system-like container setup like runC, systemd-nspawn,
LXD, and similar runtimes do it we end up with a few additonal mounts.
They are usually performed in the containers mount+user namespace.
The standard ones, i.e. the ones most container runtimes setup are:
- sysfs
- cgroupfs
- procfs
- mqueue
- devpts
- tmpfs on /dev (as a substitute for devtmpfs not being namespaced)
  - tmpfs on /dev/shm
  - bind mounts of a few host device files into /dev:
    - /dev/fuse
    - /dev/net/tun
    - /dev/full
    - /dev/null
    - /dev/random
    - /dev/tty
    - /dev/urandom
    - /dev/zero
    - /dev/console
I think most of these mounts aren't very interesting to monitor. It's in
general not very common to monitor full pseudo fileystems such as proc,
sysfs, or devpts afaik.
Notably, systemd - both outside and inside containers - will use some
inotify watches but it's always on specific directories and never across
mount borders.

In addition to the default mounts above - I've mentioned this before -
the container manager might choose to inject mounts into a running
container (to share data or whatever). There are different strategies on
how to do this.
I1. The first strategy is to inject the mount into the container in such
    a way that the container has full control over it, i.e. it can
    unmount and remount (with the restriction that some flags might
    become locked when moving the mount across user namespaces).
I2. The second strategy is to inject the mount in such a way that the
    container doesn't have control over it, i.e. the container can't
    umount or remount.

Most container runtimes will support I1. but systemd-nspawn uses I2.
There might be use-cases where the container manager would like to watch
those mounts too. But then the container manager will just call
fanotify_mark() and add that mount to the list of watched mounts when
injecting it.
I get that there are other use-cases that make subtree watches very
interesting but I don't think the container use-case is a particularly
pressing one.

> I don't like it so much myself, but I have not had any better idea how to
> achieve that goal so far.

The limitations of FAN_MARK_MOUNT as I now understand them are indeed
unpleasant. If we could get FAN_MARK_MOUNT with the same event support
as FAN_MARK_INODE that would be great.
I think the delegation model that makes sense to me is to allow
FAN_MARK_MOUNT when the caller is ns_capable(mnt->mnt_userns) and of
course ns_capable() in the userns they called fanotify_init() in. That
feels ok and supportable.
But I don't think anything beyond that like the sb filter patch that you
showed is the right approach.

Christian
