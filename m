Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5122163200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgBRUEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 15:04:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgBRUDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:03:49 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j495r-0000Zv-GH; Tue, 18 Feb 2020 20:03:43 +0000
Date:   Tue, 18 Feb 2020 21:03:41 +0100
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
        Eric Biederman <ebiederm@xmission.com>, stgraber@ubuntu.com
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
Message-ID: <20200218200341.tzrehiapskznovx5@wittgenstein>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
 <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
 <1582042260.3416.19.camel@HansenPartnership.com>
 <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
 <1582052748.16681.34.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582052748.16681.34.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:05:48AM -0800, James Bottomley wrote:
> On Tue, 2020-02-18 at 18:26 +0100, Christian Brauner wrote:
> > On Tue, Feb 18, 2020 at 08:11:00AM -0800, James Bottomley wrote:
> > > On Tue, 2020-02-18 at 09:18 +0200, Amir Goldstein wrote:
> > > > On Mon, Feb 17, 2020 at 10:56 PM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > 
> > > > > The object of this series is to replace shiftfs with a proper
> > > > > uid/gid shifting bind mount instead of the shiftfs hack of
> > > > > introducing something that looks similar to an overlay
> > > > > filesystem to do it.
> > > > > 
> > > > > The VFS still has the problem that in order to tell what
> > > > > vfsmount a dentry belongs to, struct path would have to be
> > > > > threaded everywhere struct dentry currently is.  However, this
> > > > > patch is structured only to require a rethreading of
> > > > > notify_change.  The rest of the knowledge that a shift is in
> > > > > operation is carried in the task structure by caching the
> > > > > unshifted credentials.
> > > > > 
> > > > > Note that although it is currently dependent on the new
> > > > > configfd interface for bind mounts, only patch 3/3 relies on
> > > > > this, and the whole thing could be redone as a syscall or any
> > > > > other mechanism (depending on how people eventually want to fix
> > > > > the problem with the new fsconfig mechanism being unable to
> > > > > reconfigure bind mounts).
> > > > > 
> > > > > The changes from v2 are I've added Amir's reviewed-by for the
> > > > > notify_change rethreading and I've implemented Serge's request
> > > > > for a base offset shift for the image.  It turned out to be
> > > > > much harder to implement a simple linear shift than simply to
> > > > > do it through a different userns, so that's how I've done
> > > > > it.  The userns you need to set up for the offset shifted image
> > > > > is one where the interior uid would see the shifted image as
> > > > > fake root.  I've introduced an additional "ns" config
> > > > > parameter, which must be specified when building the allow
> > > > > shift mount point (so it's done by the admin, not by the
> > > > > unprivileged user).  I've also taken care that the image
> > > > > shifted to zero (real root) is never visible in the
> > > > > filesystem.  Patch 3/3 explains how to use the additional "ns"
> > > > > parameter.
> > > > > 
> > > > > 
> > > > 
> > > > James,
> > > > 
> > > > To us common people who do not breath containers, your proposal
> > > > seems like a competing implementation to Christian's proposal
> > > > [1].
> > > 
> > > I think we have three things that swirl around this space and
> > > aren't quite direct copies of each other's use cases but aren't
> > > entirely disjoint either: the superblock user namespace, this and
> > > the user namespace fsid mapping.
> > > 
> > > >  If it were a competing implementation, I think Christian's
> > > > proposal would have won by points for being less intrusive to
> > > > VFS.
> > > 
> > > Heh, that one's subjective.  I think the current fsid code is
> > > missing
> > 
> > I honestly don't think it is subjective. Leaving aside that the patch
> > here is more invasive to the vfs just in how it needs to alter it,
> > you currently require a whole new set of syscalls for this feature. 
> 
> Well I really don't ... I'd like to replace about four existing
> syscalls (fspick/fsopen/fsconfig/fsmount) with two more general ones
> (configfd_open/configfd_action), but I kept the original four to
> demonstrate the two new ones could subsume their work.  However, I
> really think we should leave aside the activation mechanism discussion
> and concentrate on the internal implementation.
> 
> > The syscalls themselves even introduce a whole new API and
> > complicated semantics in the kernel and it's completely unclear
> > whether they will make it or not.
> 
> As I said in the cover letter.  I'm entirely mechanism agnostic. 
> Whatever solves our current rebind reconfigure problem will be usable
> for shifting bind mounts.  I like the idea of using the same fsconfig
> mechanism, but this patch isn't wedded to it, that's why 2/3 is
> implementation and 3/3 is activation.  The activation patch can be
> completely replaced without affecting the implementation mechanism.
> 
> >  Even if not, this feature will be tied to the new mount api making
> > it way harder and a longer process to adopt for userspace given that
> > not even all bits and pieces userspace needs are currently in
> > any released kernel.
> 
> Well, given that this problem and various proposed solutions have been
> around for years, I really don't think we're suddenly in any rush to
> get it out of the door and into user hands.
> 
> > But way more important: what Amir got right is that your approach and
> > fsid mappings don't stand in each others way at all. Shiftfed
> > bind-mounts can be implemented completely independent of fsid
> > mappings after the fact on top of it.
> > 
> > Your example, does this:
> > 
> > nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH */
> > configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
> > 
> > as the ultimate step. Essentially marking a mountpoint as shifted
> > relative to that user namespace. Once fsid mappings are in all that
> > you need to do is replace your
> > make_kuid()/from_kuid()/from_kuid_munged() calls and so on in your
> > patchset with make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and
> > you're done. So I honestly don't currently see any need to block the
> > patchsets on each other. 
> 
> Can I repeat: there's no rush to get upstream on this.  Let's pause to
> get the kernel implementation (the thing we have to maintain) right.  I
> realise we could each work around the other and get our implementations
> bent around each other so they all work independently thus making our
> disjoint user cabals happy but I don't think that would lead to the
> best outcome for kernel maintainability.

We have had the discussion with all major stakeholders in a single room
on what we need at LPC 2019. We agreed on what we need and fsids are a
concrete proposal for an implementation that appears to solve all discussed
major use-cases in a simple and elegant manner, which can also be cleanly
extended to cover your approach later.
Imho, there is no need to have the same discussion again at an
invite-only event focussed on kernel developers where most of the major
stakeholders are unlikely to be able to participate. The patch proposals
are here on all relevant list where everyone can participate and we can discuss
them right here.
I have not yet heard a concrete technical reason why the patch proposal is
inadequate and I see no reason to stall this.

> 
> I already think that history shows us that s_user_ns went upstream too
> fast and the fact that unprivileged fuse has yet to make it (and the

We've established on the other patchset that fsid mappings in no way interfere
nor care about s_user_ns so I'm not going to go into this again here. But for
the record, unprivileged fuse mounts are supported since:

commit 4ad769f3c346ec3d458e255548dec26ca5284cf6
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Tue May 29 09:04:46 2018 -0500

    fuse: Allow fully unprivileged mounts

    Now that the fuse and the vfs work is complete.  Allow the fuse filesystem
    to be mounted by the root user in a user namespace.

    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
    Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Christian
