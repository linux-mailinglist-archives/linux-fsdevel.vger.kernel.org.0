Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A349B347DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhCXQ27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 12:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhCXQ2p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:28:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2373661A0D;
        Wed, 24 Mar 2021 16:28:42 +0000 (UTC)
Date:   Wed, 24 Mar 2021 17:28:38 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210324162838.spy7qotef3kxm3l4@wittgenstein>
References: <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein>
 <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
 <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
 <20210324143230.y36hga35xvpdb3ct@wittgenstein>
 <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:05:45PM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 4:32 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 03:57:12PM +0200, Amir Goldstein wrote:
> > > > > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > > > > inside userns and works fine, with two wrinkles I needed to iron:
> > > > >
> > > > > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> > > > >     zero f_fsid (easy to fix)
> > > > > 2. open_by_handle_at() is not userns aware (can relax for
> > > > >     FS_USERNS_MOUNT fs)
> > > > >
> > > > > Pushed these two fixes to branch fanotify_userns.
> > > >
> > > > Pushed another fix to mnt refcount bug in WIP and another commit to
> > > > add the last piece that could make fanotify usable for systemd-homed
> > > > setup - a filesystem watch filtered by mnt_userns (not tested yet).
> > > >
> > >
> > > Now I used mount-idmapped (from xfstest) to test that last piece.
> > > Found a minor bug and pushed a fix.
> > >
> > > It is working as expected, that is filtering only the events generated via
> > > the idmapped mount. However, because the listener I tested is capable in
> > > the mapped userns and not in the sb userns, the listener cannot
> > > open_ny_handle_at(), so the result is not as useful as one might hope.
> >
> > This is another dumb question probably but in general, are you saying
> > that someone watching a mount or directory and does _not_ want file
> > descriptors from fanotify to be returned has no other way of getting to
> > the path they want to open other than by using open_by_handle_at()?
> >
> 
> Well there is another way.
> It is demonstrated in my demo with intoifywatch --fanotify --recursive.
> It involved userspace iterating a subtree of interest to create fid->path
> map.

Ok, so this seems to be

inotifytools_filename_from_fid()
-> if (fanotify_mark_type != FAN_MARK_FILESYSTEM)
           watch_from_fid()
   -> read_path_from(/proc/self/fd/w->dirfd)

> 
> The fanotify recursive watch is similar but not exactly the same as the
> old intoify recursive watch, because with inotify recursive watch you
> can miss events.
> 
> With fanotify recursive watch, the listener (if capable) can setup a
> filesystem mark so events will not be missed. They will be recorded
> by fid with an unknown path and the path information can be found later
> by the crawler and updated in the map before the final report.
> 
> Events on fid that were not found by the crawler need not be reported.
> That's essentially a subtree watch for the poor implemented in userspace.

This is already a good improvement.
Honestly, having FAN_MARK_INODE workable unprivileged is already pretty
great. In addition having FAN_MARK_MOUNT workable with idmapped mounts
will likely get us what most users care about, afaict that is the POC
in:
https://github.com/amir73il/linux/commit/f0d5d462c5baeb82a658944c6df80704434f09a1

(I'm reading the source correctly that FAN_MARK_MOUNT works with
FAN_REPORT_FID as long as no inode event set in FANOTIFY_INODE_EVENTS is
set? I'm asking because my manpage - probably too old - seems to imply
that FAN_REPORT_FID can't be used with FAN_MARK_MOUNT although I might
just be stumbling over the phrasing.)

I think FAN_MARK_FILESYSTEM should simply stay under the s_userns_s
capable requirement. That's imho the cleanest semantics for this, i.e.
I'd drop:
https://github.com/amir73il/linux/commit/bd20e273f3c3a650805b3da32e493f01cc2a4763
This is neither an urgent use-case nor am I feeling very comfortable
with it.

> 
> I did not implement the combination --fanotify --global --recursive in my
> demo, because it did not make sense with the current permission model
> (listener that can setup a fs mark can always resolve fids to path), but it
> would be quite trivial to add.
> 
> 
> > >
> > > I guess we will also need to make open_by_handle_at() idmapped aware
> > > and use a variant of vfs_dentry_acceptable() that validates that the opened
> > > path is legitimately accessible via the idmapped mount.
> >
> > So as a first step, I think there's a legitimate case to be made for
> > open_by_handle_at() to be made useable inside user namespaces. That's a
> > change worth to be made independent of fanotify. For example, nowadays
> > cgroups have a 64 bit identifier that can be used with open_by_handle_at
> > to map a cgrp id to a path and back:
> > https://lkml.org/lkml/2020/12/2/1126
> > Right now this can't be used in user namespaces because of this
> > restriction but it is genuinely useful to have this feature available
> > since cgroups are FS_USERNS_MOUNT and that identifier <-> path mapping
> > is very convenient.
> 
> FS_USERNS_MOUNT is a simple case and I think it is safe.
> There is already a patch for that on my fanotify_userns branch.

Great!
Christian
