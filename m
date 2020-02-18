Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE912162F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBRTFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 14:05:52 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58482 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgBRTFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:05:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 474CA8EE367;
        Tue, 18 Feb 2020 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582052751;
        bh=k6ZgI2QmoQm1jOehULWKPrA6/A/mMdQgj2W0g+v4y6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Uc5ZBmjeF7mmR1a3/sV9r/Wuu/9W89G1pRll7/68j1Nib/ObsuC9WEjnDp6zg6koa
         JT9hcwllzVrDc4BU4fcK0LvP/QfEmZVuWWDW2zzo7TvYKSMBzpov4iHewuptwcfRA9
         WyHm05yIrPYZgYX2lZT37APhUCHxTB8jDHPK2UDU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9RwNB4VOfTil; Tue, 18 Feb 2020 11:05:50 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 34A078EE0D5;
        Tue, 18 Feb 2020 11:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582052750;
        bh=k6ZgI2QmoQm1jOehULWKPrA6/A/mMdQgj2W0g+v4y6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ef1/Uqa2prpeuSrt9tB33V+FJeAbgTWx0TfTmBcCalefsK74PqdY5QLUph1NcxSXr
         ZreT9W6PhHtSDrDyjzyfIxHsWJmtQiyuwBR8IwN4q/SK7bV9SVh8xtqBKK9WBJbPZT
         w6ApvxOnGN58t/RaHuSLU+h9AZ7/B07pRPzK1Xxc=
Message-ID: <1582052748.16681.34.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Date:   Tue, 18 Feb 2020 11:05:48 -0800
In-Reply-To: <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
         <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
         <1582042260.3416.19.camel@HansenPartnership.com>
         <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-18 at 18:26 +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 08:11:00AM -0800, James Bottomley wrote:
> > On Tue, 2020-02-18 at 09:18 +0200, Amir Goldstein wrote:
> > > On Mon, Feb 17, 2020 at 10:56 PM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > The object of this series is to replace shiftfs with a proper
> > > > uid/gid shifting bind mount instead of the shiftfs hack of
> > > > introducing something that looks similar to an overlay
> > > > filesystem to do it.
> > > > 
> > > > The VFS still has the problem that in order to tell what
> > > > vfsmount a dentry belongs to, struct path would have to be
> > > > threaded everywhere struct dentry currently is.  However, this
> > > > patch is structured only to require a rethreading of
> > > > notify_change.  The rest of the knowledge that a shift is in
> > > > operation is carried in the task structure by caching the
> > > > unshifted credentials.
> > > > 
> > > > Note that although it is currently dependent on the new
> > > > configfd interface for bind mounts, only patch 3/3 relies on
> > > > this, and the whole thing could be redone as a syscall or any
> > > > other mechanism (depending on how people eventually want to fix
> > > > the problem with the new fsconfig mechanism being unable to
> > > > reconfigure bind mounts).
> > > > 
> > > > The changes from v2 are I've added Amir's reviewed-by for the
> > > > notify_change rethreading and I've implemented Serge's request
> > > > for a base offset shift for the image.  It turned out to be
> > > > much harder to implement a simple linear shift than simply to
> > > > do it through a different userns, so that's how I've done
> > > > it.  The userns you need to set up for the offset shifted image
> > > > is one where the interior uid would see the shifted image as
> > > > fake root.  I've introduced an additional "ns" config
> > > > parameter, which must be specified when building the allow
> > > > shift mount point (so it's done by the admin, not by the
> > > > unprivileged user).  I've also taken care that the image
> > > > shifted to zero (real root) is never visible in the
> > > > filesystem.  Patch 3/3 explains how to use the additional "ns"
> > > > parameter.
> > > > 
> > > > 
> > > 
> > > James,
> > > 
> > > To us common people who do not breath containers, your proposal
> > > seems like a competing implementation to Christian's proposal
> > > [1].
> > 
> > I think we have three things that swirl around this space and
> > aren't quite direct copies of each other's use cases but aren't
> > entirely disjoint either: the superblock user namespace, this and
> > the user namespace fsid mapping.
> > 
> > >  If it were a competing implementation, I think Christian's
> > > proposal would have won by points for being less intrusive to
> > > VFS.
> > 
> > Heh, that one's subjective.  I think the current fsid code is
> > missing
> 
> I honestly don't think it is subjective. Leaving aside that the patch
> here is more invasive to the vfs just in how it needs to alter it,
> you currently require a whole new set of syscalls for this feature. 

Well I really don't ... I'd like to replace about four existing
syscalls (fspick/fsopen/fsconfig/fsmount) with two more general ones
(configfd_open/configfd_action), but I kept the original four to
demonstrate the two new ones could subsume their work.  However, I
really think we should leave aside the activation mechanism discussion
and concentrate on the internal implementation.

> The syscalls themselves even introduce a whole new API and
> complicated semantics in the kernel and it's completely unclear
> whether they will make it or not.

As I said in the cover letter.  I'm entirely mechanism agnostic. 
Whatever solves our current rebind reconfigure problem will be usable
for shifting bind mounts.  I like the idea of using the same fsconfig
mechanism, but this patch isn't wedded to it, that's why 2/3 is
implementation and 3/3 is activation.  The activation patch can be
completely replaced without affecting the implementation mechanism.

>  Even if not, this feature will be tied to the new mount api making
> it way harder and a longer process to adopt for userspace given that
> not even all bits and pieces userspace needs are currently in
> any released kernel.

Well, given that this problem and various proposed solutions have been
around for years, I really don't think we're suddenly in any rush to
get it out of the door and into user hands.

> But way more important: what Amir got right is that your approach and
> fsid mappings don't stand in each others way at all. Shiftfed
> bind-mounts can be implemented completely independent of fsid
> mappings after the fact on top of it.
> 
> Your example, does this:
> 
> nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH */
> configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
> 
> as the ultimate step. Essentially marking a mountpoint as shifted
> relative to that user namespace. Once fsid mappings are in all that
> you need to do is replace your
> make_kuid()/from_kuid()/from_kuid_munged() calls and so on in your
> patchset with make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and
> you're done. So I honestly don't currently see any need to block the
> patchsets on each other. 

Can I repeat: there's no rush to get upstream on this.  Let's pause to
get the kernel implementation (the thing we have to maintain) right.  I
realise we could each work around the other and get our implementations
bent around each other so they all work independently thus making our
disjoint user cabals happy but I don't think that would lead to the
best outcome for kernel maintainability.

I already think that history shows us that s_user_ns went upstream too
fast and the fact that unprivileged fuse has yet to make it (and the
reception the original shiftfs got) indicates there may be an
abstraction problem with s_user_ns (I have to confess here that while I
think I understand the unprivileged fuse issues for both the daemon and
the consumer, I don't have a clear insight into the f2fs use case ...
it's something androidy that no-one has fully explained).  So I think
the implementors of all three features need to come up with a generic
VFS shifting abstraction that covers all the use cases.  We also need
to decide which user_ns we care about: the one above us in current, the
one captured when the mnt_ns got unshared, the one captured in
s_user_ns when the mount was done or the new one I introduced which
captures the user_ns at struct mount creation/clone time ... I really
don't think we need them all so we should work out what do they all
mean and which should we care about and start ruthlessly eliminating
any one we believe we don't care about.

We're really like people building a castle by each working on our own
turret and my fear is the weight of all the turrets, even if it doesn't
cause the whole castle simply to collapse, is weakening our security
posture.

James

