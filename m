Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C535373D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhEEOZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 10:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhEEOZI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 10:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D8961057;
        Wed,  5 May 2021 14:24:09 +0000 (UTC)
Date:   Wed, 5 May 2021 16:24:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210505142405.vx2wbtadozlrg25b@wittgenstein>
References: <20201109180016.80059-1-amir73il@gmail.com>
 <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz>
 <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz>
 <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505122815.GD29867@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 05, 2021 at 02:28:15PM +0200, Jan Kara wrote:
> On Mon 03-05-21 21:44:22, Amir Goldstein wrote:
> > > > Getting back to this old thread, because the "fs view" concept that
> > > > it presented is very close to two POCs I tried out recently which leverage
> > > > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> > > >
> > > > The first POC was replacing the is_subtree() check with in_userns()
> > > > which is far less expensive:
> > > >
> > > > https://github.com/amir73il/linux/commits/fanotify_in_userns
> > > >
> > > > This approach reduces the cost of check per mark, but there could
> > > > still be a significant number of sb marks to iterate for every fs op
> > > > in every container.
> > > >
> > > > The second POC is based off the first POC but takes the reverse
> > > > approach - instead of marking the sb object and filtering by userns,
> > > > it places a mark on the userns object and filters by sb:
> > > >
> > > > https://github.com/amir73il/linux/commits/fanotify_idmapped
> > > >
> > > > The common use case is a single host filesystem which is
> > > > idmapped via individual userns objects to many containers,
> > > > so normally, fs operations inside containers would have to
> > > > iterate a single mark.
> > > >
> > > > I am well aware of your comments about trying to implement full
> > > > blown subtree marks (up this very thread), but the userns-sb
> > > > join approach is so much more low hanging than full blown
> > > > subtree marks. And as a by-product, it very naturally provides
> > > > the correct capability checks so users inside containers are
> > > > able to "watch their world".
> > > >
> > > > Patches to allow resolving file handles inside userns with the
> > > > needed permission checks are also available on the POC branch,
> > > > which makes the solution a lot more useful.
> > > >
> > > > In that last POC, I introduced an explicit uapi flag
> > > > FAN_MARK_IDMAPPED in combination with
> > > > FAN_MARK_FILESYSTEM it provides the new capability.
> > > > This is equivalent to a new mark type, it was just an aesthetic
> > > > decision.
> > >
> > > So in principle, I have no problem with allowing mount marks for ns-capable
> > > processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> > > look OK to me (although if we extended mount marks to support directory
> > > events as you try elsewhere, would there be still be a compeling usecase for
> > > this?).
> > 
> > In my opinion it would. This is the reason why I stopped that direction.
> > The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
> > and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
> > a bind mount or cloning a mount ns while the former is "sticky" to all additions
> > to the mount tree that happen below the idmapped mount.
> 
> As far as I understood Christian, he was specifically interested in mount
> events for container runtimes because filtering by 'mount' was desirable
> for his usecase. But maybe I misunderstood. Christian? Also if you have

I discussed this with Amir about two weeks ago. For container runtimes
Amir's idea of generating events based on the userns the fsnotify
instance was created in is actually quite clever because it gives a way
for the container to receive events for all filesystems and idmapped
mounts if its userns is attached to it. The model as we discussed it -
Amir, please tell me if I'm wrong - is that you'd be setting up an
fsnotify watch in a given userns and you'd be seeing events from all
superblocks that have the caller's userns as s_user_ns and all mounts
that have the caller's userns as mnt_userns. I think that's safe.

The reason why I found mount marks to be so compelling initially was
that they also work in cases where the caller is not in the userns that
is attached to the mnt (Similar to how you don't need to be in the
s_user_ns of the superblock you attached a filesystem mark to.).
That's not per se a container use-case though as the container will
almost always be in the userns that is attached to the mount (They don't
have to be of course just as with s_usern_s. You can very well be clever
and make a superblock be visible outside of the mounter's userns.).

In addition the mount mark seemed to offer more granularity as the
caller can specifically select what they want to monitor. But I don't
think that justifies the complexity of the implementation that we would
need to push for.

> FAN_MARK_FILESYSTEM mark filtered by namespace, you still will not see
> events to your shared filesystem generated from another namespace. So
> "escaping" is just a matter of creating new namespace and mounting fs
> there?

Hm, that depends on the implementation. If Amir is using in_userns()
then the caller would be seeing events for their own userns and all
descendant userns. Since userns are hierarchical a container creating a
new userns wouldn't be able to "escape" the notifications.

>  
> > That is a key difference that can allow running system services that use sb
> > marks inside containers and actually be useful.
> > "All" the system service needs to do in order to become idmapped aware
> > is to check the path it is marking in /proc/self/mounts (or via syscall) and
> > set the FAN_MARK_IDMAPPED flag.
> > Everything else "just works" the same as in init user ns.
> > 
> > > My main concern is creating a sane API so that if we expand the
> > > functionality in the future we won't create a mess out of all
> > > possibilities.
> > >
> > 
> > Agreed.
> > If and when I post these patches, I will include the complete vision
> > for the API to show where this fits it.
> 
> OK, thanks.
> 
> > > So I think there are two, relatively orthogonal decicions to make:
> > >
> > > 1) How the API should look like? For mounts there's no question I guess.
> > > It's a mount mark as any other and we just relax the permission checks.
> > 
> > Right.
> > 
> > > For FAN_MARK_FILESYSTEM marks we have to me more careful - I think
> > > restricting mark to events generated only from a particular userns has to
> > > be an explicit flag when adding the mark. Otherwise process that is
> > > CAP_SYS_ADMIN in init_user_ns has no way of using these ns-filtered marks.
> > 
> > True. That's the reason I added the explicit flag in POC2.
> > 
> > > But this is also the reason why I'd like to think twice before adding this
> > > event filtering if we can cover similar usecases by expanding mount marks
> > > capabilities instead (it would certainly better fit overall API design).
> > >
> > 
> > I explained above why that would not be good enough IMO.
> > I think that expanding mount marks to support more events is nice for
> > the unified APIs, but it is not nice enough IMO to justify the efforts
> > related to
> > promoting the vfs API changes against resistance and testing all the affected
> > filesystems.
> 
> Understood. I agree if extending mount marks isn't enough for the container
> usecase, then it's probably not worth the effort at this point.

Yeah, the problem really is that we would need to make a very
fundamental change where the vfsmount itself matters. Arguably this is
already the case in a bunch of places and certainly for some stacking
filesystems but not in a fundamental sense. That would most certainly
need to change if we need to plumb it down through the vfs and through
the fsnotify infrastrucutre.

Christian
