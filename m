Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3BE162CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRR0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:26:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59030 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:26:13 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j46dL-0001r5-KS; Tue, 18 Feb 2020 17:26:07 +0000
Date:   Tue, 18 Feb 2020 18:26:06 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
Message-ID: <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
 <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
 <1582042260.3416.19.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582042260.3416.19.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:11:00AM -0800, James Bottomley wrote:
> On Tue, 2020-02-18 at 09:18 +0200, Amir Goldstein wrote:
> > On Mon, Feb 17, 2020 at 10:56 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> > > The object of this series is to replace shiftfs with a proper
> > > uid/gid shifting bind mount instead of the shiftfs hack of
> > > introducing something that looks similar to an overlay filesystem
> > > to do it.
> > > 
> > > The VFS still has the problem that in order to tell what vfsmount a
> > > dentry belongs to, struct path would have to be threaded everywhere
> > > struct dentry currently is.  However, this patch is structured only
> > > to require a rethreading of notify_change.  The rest of the
> > > knowledge that a shift is in operation is carried in the task
> > > structure by caching the unshifted credentials.
> > > 
> > > Note that although it is currently dependent on the new configfd
> > > interface for bind mounts, only patch 3/3 relies on this, and the
> > > whole thing could be redone as a syscall or any other mechanism
> > > (depending on how people eventually want to fix the problem with
> > > the new fsconfig mechanism being unable to reconfigure bind
> > > mounts).
> > > 
> > > The changes from v2 are I've added Amir's reviewed-by for the
> > > notify_change rethreading and I've implemented Serge's request for
> > > a base offset shift for the image.  It turned out to be much harder
> > > to implement a simple linear shift than simply to do it through a
> > > different userns, so that's how I've done it.  The userns you need
> > > to set up for the offset shifted image is one where the interior
> > > uid would see the shifted image as fake root.  I've introduced an
> > > additional "ns" config parameter, which must be specified when
> > > building the allow shift mount point (so it's done by the admin,
> > > not by the unprivileged user).  I've also taken care that the image
> > > shifted to zero (real root) is never visible in the
> > > filesystem.  Patch 3/3 explains how to use the additional "ns"
> > > parameter.
> > > 
> > > 
> > 
> > James,
> > 
> > To us common people who do not breath containers, your proposal seems
> > like a competing implementation to Christian's proposal [1].
> 
> I think we have three things that swirl around this space and aren't
> quite direct copies of each other's use cases but aren't entirely
> disjoint either: the superblock user namespace, this and the user
> namespace fsid mapping.
> 
> >  If it were a competing implementation, I think Christian's proposal
> > would have won by points for being less intrusive to VFS.
> 
> Heh, that one's subjective.  I think the current fsid code is missing

I honestly don't think it is subjective. Leaving aside that the patch
here is more invasive to the vfs just in how it needs to alter it, you
currently require a whole new set of syscalls for this feature. The
syscalls themselves even introduce a whole new API and complicated
semantics in the kernel and it's completely unclear whether they will
make it or not. Even if not, this feature will be tied to the new mount
api making it way harder and a longer process to adopt for userspace
given that not even all bits and pieces userspace needs are currently in
any released kernel.

But way more important: what Amir got right is that your approach and
fsid mappings don't stand in each others way at all. Shiftfed
bind-mounts can be implemented completely independent of fsid mappings
after the fact on top of it.

Your example, does this:

nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH */
configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);

as the ultimate step. Essentially marking a mountpoint as shifted
relative to that user namespace. Once fsid mappings are in all that you
need to do is replace your make_kuid()/from_kuid()/from_kuid_munged()
calls and so on in your patchset with
make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and you're done. So I
honestly don't currently see any need to block the patchsets on each
other. 

Christian
