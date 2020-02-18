Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053D1162A1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgBRQLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 11:11:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54816 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgBRQLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:11:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A62BE8EE367;
        Tue, 18 Feb 2020 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582042261;
        bh=CHkefOrOFnqDJ4NdqO/3WSx/KUyxU7yUgMTKSPwq7kg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ia4UVcATTHrxNxBkns3ExMAK/gYaxb1HfqzzsKc+hkq6xzbMW8n6/jowcXtXfkC3e
         EQOW323R+AZnsUJnEtf31qRVjpvPM4dRXTCqdrFz1Af5wTuagu5+3m0+4BcrxXIg13
         J6btwTuiEhqjnxIYUesgjwNT19L9TCuyT7OEu9Xg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tsYyjvAOdXuz; Tue, 18 Feb 2020 08:11:01 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D99948EE0D5;
        Tue, 18 Feb 2020 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582042261;
        bh=CHkefOrOFnqDJ4NdqO/3WSx/KUyxU7yUgMTKSPwq7kg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ia4UVcATTHrxNxBkns3ExMAK/gYaxb1HfqzzsKc+hkq6xzbMW8n6/jowcXtXfkC3e
         EQOW323R+AZnsUJnEtf31qRVjpvPM4dRXTCqdrFz1Af5wTuagu5+3m0+4BcrxXIg13
         J6btwTuiEhqjnxIYUesgjwNT19L9TCuyT7OEu9Xg=
Message-ID: <1582042260.3416.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Date:   Tue, 18 Feb 2020 08:11:00 -0800
In-Reply-To: <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
         <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-18 at 09:18 +0200, Amir Goldstein wrote:
> On Mon, Feb 17, 2020 at 10:56 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > The object of this series is to replace shiftfs with a proper
> > uid/gid shifting bind mount instead of the shiftfs hack of
> > introducing something that looks similar to an overlay filesystem
> > to do it.
> > 
> > The VFS still has the problem that in order to tell what vfsmount a
> > dentry belongs to, struct path would have to be threaded everywhere
> > struct dentry currently is.  However, this patch is structured only
> > to require a rethreading of notify_change.  The rest of the
> > knowledge that a shift is in operation is carried in the task
> > structure by caching the unshifted credentials.
> > 
> > Note that although it is currently dependent on the new configfd
> > interface for bind mounts, only patch 3/3 relies on this, and the
> > whole thing could be redone as a syscall or any other mechanism
> > (depending on how people eventually want to fix the problem with
> > the new fsconfig mechanism being unable to reconfigure bind
> > mounts).
> > 
> > The changes from v2 are I've added Amir's reviewed-by for the
> > notify_change rethreading and I've implemented Serge's request for
> > a base offset shift for the image.  It turned out to be much harder
> > to implement a simple linear shift than simply to do it through a
> > different userns, so that's how I've done it.  The userns you need
> > to set up for the offset shifted image is one where the interior
> > uid would see the shifted image as fake root.  I've introduced an
> > additional "ns" config parameter, which must be specified when
> > building the allow shift mount point (so it's done by the admin,
> > not by the unprivileged user).  I've also taken care that the image
> > shifted to zero (real root) is never visible in the
> > filesystem.  Patch 3/3 explains how to use the additional "ns"
> > parameter.
> > 
> > 
> 
> James,
> 
> To us common people who do not breath containers, your proposal seems
> like a competing implementation to Christian's proposal [1].

I think we have three things that swirl around this space and aren't
quite direct copies of each other's use cases but aren't entirely
disjoint either: the superblock user namespace, this and the user
namespace fsid mapping.

>  If it were a competing implementation, I think Christian's proposal
> would have won by points for being less intrusive to VFS.

Heh, that one's subjective.  I think the current fsid code is missing
quite a few use cases in the stat/attr/in_group_p cases.  I'm just
building the code now to run it through the shiftfs tests and see how
it fares.  I think once those cases are added, the VFS changes in fsid
will be the same as I have in patch 2/3 ... primarily because we all
have to shift the same thing at the same point.  If you include the
notify_change rethreading then, yes, you're correct, but that patch
does stand on its own and is consonant with a long term vfs goal of
using path instead of dentry.

> But it is not really a competing implementation, is it? Your
> proposals meet two different, but very overlapping, set of
> requirements. IMHO, none of you did a really good job of explaining
> that in the cover latter, let alone, refer to each others proposals
> (I am referring to your v3 posting of course).

Yes, I know, but the fsid one is only a few days old so I haven't had
time to absorb all of it yet.

> IIUC, Christian's proposal deals with single shared image per
> non-overlapping groups of containers. And it deals with this use case
> very elegantly IMO. From your comments on Christian's post, it does
> not seem that you oppose to his proposal, except that it does not
> meet the requirements for all of your use cases.

No, but I think it could.  It's one of these perennial problems of more
generic vs more specific to use case.  I'm a bit lost in really what we
need for containers.  In the original shiftfs I made it superblock
based precisely because that was the only way I could integrate
s_user_ns into it ... and I thought that was a good idea.

> IIUC, your proposal can deal with multiple shared images per
> overlapping groups of containers

That's right ... it does the shift based on path and user namespace. 
In theory it allows an image with shifted and unshifted pieces ...
however, I'm not sure there's even a use case for that granularity
because all my current image shifting use cases are all or nothing. 
The granularity is an accident of the bind mount implementation.

>  and it adds an element of "auto-reverse-mapping", which reduces the
> administration overhead of this to be nightmare of orchestration.

Right, but the same thing could be an option to the fsid proposal: the
default use could shift forward on kuid and back on the same map for
fsuid ... then it would do what shiftfs does.  Likewise, shiftfs could
pick up the shift from an existing namespace and thus look more like
what fsuid does.

> It seems to me, that you should look into working your patch set on
> top of fsid mapping and try to make use of it as much as possible.
> And to make things a bit more clear to the rest of us, you should
> probably market your feature as "auto back shifting mount" or
> something like that and explain the added value of the feature on top
> of plain fsid mapping

Well we both need the same shift points, so we could definitely both
work off a generic vfs encapsulation of "shift needed here".  Once
that's done it does become a question of use and activation.

I can't help feeling that now that we've been around the houses a few
times, s_user_ns is actually in the wrong place and it should be in the
mount struct not the superblock.  I get the impression we've got the
what we need to expose (the use cases) well established (at least in
our heads).  The big question your asking is implementation (the how)
and also whether there isn't a combination of the exposures that works
for everyone.  I think this might make a very good session at LSF/MM. 
The how piece is completely within the purview of kernel developers. 
The use case is more problematic because that does involve the
container orchestration community.  However, I think at LSF/MM if we
could get agreement on a unified implementation that covers the three
use cases we're in a much better position to have the container
orchestration conversation  because it's simply a case of tweaking the
activation mechanisms.  I'll propose it as a topic.

James

