Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41698350008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhCaMSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 08:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235014AbhCaMRZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A4386198A;
        Wed, 31 Mar 2021 12:17:22 +0000 (UTC)
Date:   Wed, 31 Mar 2021 14:17:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210331121719.adj2zk7yhjn3jfri@wittgenstein>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
 <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:29:04PM +0300, Amir Goldstein wrote:
> On Wed, Mar 31, 2021 at 12:46 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Tue, Mar 30, 2021 at 05:56:25PM +0300, Amir Goldstein wrote:
> > > > > > My example probably would be something like:
> > > > > >
> > > > > > mount -t ext4 /dev/sdb /A
> > > > > >
> > > > > > 1. FAN_MARK_MOUNT(/A)
> > > > > >
> > > > > > mount --bind /A /B
> > > > > >
> > > > > > 2. FAN_MARK_MOUNT(/B)
> > > > > >
> > > > > > mount -t ecryptfs /B /C
> > > > > >
> > > > > > 3. FAN_MARK_MOUNT(/C)
> > > > > >
> > > > > > let's say I now do
> > > > > >
> > > > > > touch /C/bla
> > > > > >
> > > > > > I may be way off here but intuitively it seems both 1. and 2. should get
> > > > > > a creation event but not 3., right?
> > > > > >
> > > > >
> > > > > Why not 3?
> > > > > You explicitly set a mark on /C requesting to be notified when
> > > > > objects are created via /C.
> > > >
> > > > Sorry, that was a typo. I meant to write, both 2. and 3. should get a
> > > > creation event but not 1.
> > > >
> > > > >
> > > > > > But with your proposal would both 1. and 2. still get a creation event?
> > > > > >
> > > >
> > > > Same obvious typo. The correct question would be: with your proposal do
> > > > 2. and 3. both get an event?
> > > >
> > > > Because it feels like they both should since /C is mounted on top of /B
> > > > and ecryptfs acts as a shim. Both FAN_MARK_MOUNT(/B) and
> > > > FAN_MARK_MOUNT(/C) should get a creation event after all both will have
> > > > mnt->mnt_fsnotify_marks set.
> > > >
> > >
> > > Right.
> > >
> > > There are two ways to address this inconsistency:
> > > 1. Change internal callers of vfs_ helpers to use a private mount,
> > >     as you yourself suggested for ecryptfs and cachefiles
> >

[1]:

> > I feel like this is he correct thing to do independently of the fanotify
> > considerations. I think I'll send an RFC for this today or later this
> > week.
> >
> > > 2. Add fsnotify_path_ hooks at caller site - that would be the
> > >     correct thing to do for nfsd IMO
> >
> > I do not have an informed opinion yet on nfsd so I simply need to trust
> > you here. :)
> >
> 
> As long as "exp_export: export of idmapped mounts not yet supported.\n"
> I don't think it matters much.
> It feels like adding idmapped mounts to nfsd is on your roadmap.
> When you get to that we can discuss adding fsnotify path hooks to nfsd
> if Jan agrees to the fsnotify path hooks concept.
> 
> > >
> > > > >
> > > > > They would not get an event, because fsnotify() looks for CREATE event
> > > > > subscribers on inode->i_fsnotify_marks and inode->i_sb_s_fsnotify_marks
> > > > > and does not find any.
> > > >
> > > > Well yes, but my example has FAN_MARK_MOUNT(/B) set. So fanotify
> > > > _should_ look at
> > > >             (!mnt || !mnt->mnt_fsnotify_marks) &&
> > > > and see that there are subscribers and should notify the subscribers in
> > > > /B even if the file is created through /C.
> > > >
> > > > My point is with your solution this can't be handled and I want to make
> > > > sure that this is ok. Because right now you'd not be notified about a
> > > > new file having been created in /B even though mnt->mnt_fsnotify_marks
> > > > is set and the creation went through /B via /C.
> > > >
> > >
> > > If you are referring to the ecryptfs use case specifically, then I think it is
> > > ok. After all, whether ecryptfs uses a private mount clone or not is not
> > > something the user can know.
> > >
> > > > _Unless_ we switch to an argument like overlayfs and say "This is a
> > > > private mount which is opaque and so we don't need to generate events.".
> > > > Overlayfs handles this cleanly due to clone_private_mount() which will
> > > > shed all mnt->mnt_fsnotify_marks and ecryptfs should too if that is the
> > > > argument we follow, no?
> > > >
> > >
> > > There is simply no way that the user can infer from the documentation
> > > of FAN_MARK_MOUNT that the event on /B is expected when /B is
> > > underlying layer of ecryptfs or overlayfs.
> > > It requires deep internal knowledge of the stacked fs implementation.
> > > In best case, the user can infer that she MAY get an event on /B.
> > > Some users MAY also expect to get an event on /A because they do not
> > > understand the concept of bind mounts...
> > > Clone a mount ns and you will get more lost users...
> >
> > I disagree to some extent. For example, a user might remount /B
> > read-only at which point /C is effectively read-only too which makes it
> > plain obvious to the user that /C piggy-backs on /B.
> 
> Yes, but that is a bug. /C should not become read-only. It should use

I agree. That's why I said they should use one. :)
I just pointed out how it is today for two filesystems.

> a private clone of /B, so I don't see where this is going.

It's going to [1] above. :)

> 
> > But leaving that aside my questioning is more concerned with whether the
> > implementation we're aiming for is consistent and intuitive and that
> > stacking example came to my mind pretty quickly.
> >
> 
> This implementation is a compromise for not having clear user mount
> context in all places that call for an event.
> For every person you find that thinks it is intuitive to get an event on /B
> for touch C/bla, you will find another person that thinks it is not intuitive

And I think here we disagree. The technical implementation currently
requires this since the two mounts are both clearly marked and the first
mount creates objects by going through the other mount and they don't
have a private mount. All I was saying is that the current patchset
can't handle this case and asked whether we are ok with that and if not
what we do to fix it.
My proposal two or three mails ago and then picked up by you is: make
them both use a private clone mount which is - as I said in earlier
mails - the correct solution anyway and falls in line with overlayfs
too.

> to get an event. I think we are way beyond the stage with mount
> namespaces where intuition alone suffice.
> 
> w.r.t consistent, you gave a few examples and I suggested how IMO
> they should be fixed to behave consistently.
> If you have other examples of alleged inconsistencies, please list them.

It feels like I somehow upset you with this. Again, I agree with the
push of the patchset in general and I'm grateful you're doing that work
and we agree on the fix for the two filesystems. As I said, I'll try to
get an RFC fix out for both.

> 
> > >
> > > > >
> > > > > The vfs_create() -> fsnotify_create() hook passes data_type inode to
> > > > > fsnotify() so there is no fsnotify_data_path() to extract mnt event
> > > > > subscribers from.
> > > >
> > > > Right, that was my point. You don't have the mnt context for the
> > > > underlying fs at a time when e.g. call vfs_link() which ultimately calls
> > > > fsnotify_create/link() which I'm saying might be a problem.
> > > >
> > >
> > > It's a problem. If it wasn't a problem I wouldn't need to work around it ;-)
> > >
> > > It would be a problem if people think that the FAN_MOUNT_MARK
> > > is a subtree mark, which it certainly is not. And I have no doubt that
> >
> > I don't think subtree marks figure into the example above. But we
> > digress.
> >
> > > as Jan said, people really do want a subtree mark.
> > >
> > > My question to you with this RFC is: Does the ability to subscribe to
> > > CREATE/DELETE/MOVE events on a mount help any of your use
> > > cases? With or without the property that mount marks are allowed
> >
> > Since I explicitly pointed on in a prior mail that it would be great to
> > have the same events as for a regular fanotify watch I think I already
> > answered that question. :)
> >
> > > inside userns for idmapped mounts.
> >
> > But if it helps then I'll do it once: yes, both would indeed be very
> > useful.
> >
> 
> OK. I understand that the "promise" of those abilities is very useful.
> Please also confirm once you tested the demo code that the new
> events on an idmapped mount will "actually" be useful to container
> managers. If you can work my demo code into a demo branch for
> the bind mount injection or something that would be best.
> 
> The reason I am asking this is because while I was working on
> enabling sb/mount marks inside userns I found several other issues
> (e.g. open_by_handle_at()) without fixing them the demo would have
> been much less impressive and much less useful in practice.
> 
> So I would like to know that we really have all the pieces needed for
> a useful solution, before proposing the fanotify patches.

Sure, if you think that you have your branch in the shape that you want
to. So far it has been evolving quite rapidly as you said yourself. :)
I can probably test this soon early next week seems most likely since I
need to find a timeslot to actually do the work you're asking. Hope that
works.

Thanks!
Christian
