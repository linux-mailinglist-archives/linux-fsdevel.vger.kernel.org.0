Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8927134FD68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhCaJqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 05:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhCaJqJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C70F619BC;
        Wed, 31 Mar 2021 09:46:07 +0000 (UTC)
Date:   Wed, 31 Mar 2021 11:46:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
 <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:56:25PM +0300, Amir Goldstein wrote:
> > > > My example probably would be something like:
> > > >
> > > > mount -t ext4 /dev/sdb /A
> > > >
> > > > 1. FAN_MARK_MOUNT(/A)
> > > >
> > > > mount --bind /A /B
> > > >
> > > > 2. FAN_MARK_MOUNT(/B)
> > > >
> > > > mount -t ecryptfs /B /C
> > > >
> > > > 3. FAN_MARK_MOUNT(/C)
> > > >
> > > > let's say I now do
> > > >
> > > > touch /C/bla
> > > >
> > > > I may be way off here but intuitively it seems both 1. and 2. should get
> > > > a creation event but not 3., right?
> > > >
> > >
> > > Why not 3?
> > > You explicitly set a mark on /C requesting to be notified when
> > > objects are created via /C.
> >
> > Sorry, that was a typo. I meant to write, both 2. and 3. should get a
> > creation event but not 1.
> >
> > >
> > > > But with your proposal would both 1. and 2. still get a creation event?
> > > >
> >
> > Same obvious typo. The correct question would be: with your proposal do
> > 2. and 3. both get an event?
> >
> > Because it feels like they both should since /C is mounted on top of /B
> > and ecryptfs acts as a shim. Both FAN_MARK_MOUNT(/B) and
> > FAN_MARK_MOUNT(/C) should get a creation event after all both will have
> > mnt->mnt_fsnotify_marks set.
> >
> 
> Right.
> 
> There are two ways to address this inconsistency:
> 1. Change internal callers of vfs_ helpers to use a private mount,
>     as you yourself suggested for ecryptfs and cachefiles

I feel like this is he correct thing to do independently of the fanotify
considerations. I think I'll send an RFC for this today or later this
week.

> 2. Add fsnotify_path_ hooks at caller site - that would be the
>     correct thing to do for nfsd IMO

I do not have an informed opinion yet on nfsd so I simply need to trust
you here. :)

> 
> > >
> > > They would not get an event, because fsnotify() looks for CREATE event
> > > subscribers on inode->i_fsnotify_marks and inode->i_sb_s_fsnotify_marks
> > > and does not find any.
> >
> > Well yes, but my example has FAN_MARK_MOUNT(/B) set. So fanotify
> > _should_ look at
> >             (!mnt || !mnt->mnt_fsnotify_marks) &&
> > and see that there are subscribers and should notify the subscribers in
> > /B even if the file is created through /C.
> >
> > My point is with your solution this can't be handled and I want to make
> > sure that this is ok. Because right now you'd not be notified about a
> > new file having been created in /B even though mnt->mnt_fsnotify_marks
> > is set and the creation went through /B via /C.
> >
> 
> If you are referring to the ecryptfs use case specifically, then I think it is
> ok. After all, whether ecryptfs uses a private mount clone or not is not
> something the user can know.
> 
> > _Unless_ we switch to an argument like overlayfs and say "This is a
> > private mount which is opaque and so we don't need to generate events.".
> > Overlayfs handles this cleanly due to clone_private_mount() which will
> > shed all mnt->mnt_fsnotify_marks and ecryptfs should too if that is the
> > argument we follow, no?
> >
> 
> There is simply no way that the user can infer from the documentation
> of FAN_MARK_MOUNT that the event on /B is expected when /B is
> underlying layer of ecryptfs or overlayfs.
> It requires deep internal knowledge of the stacked fs implementation.
> In best case, the user can infer that she MAY get an event on /B.
> Some users MAY also expect to get an event on /A because they do not
> understand the concept of bind mounts...
> Clone a mount ns and you will get more lost users...

I disagree to some extent. For example, a user might remount /B
read-only at which point /C is effectively read-only too which makes it
plain obvious to the user that /C piggy-backs on /B.
But leaving that aside my questioning is more concerned with whether the
implementation we're aiming for is consistent and intuitive and that
stacking example came to my mind pretty quickly.

> 
> > >
> > > The vfs_create() -> fsnotify_create() hook passes data_type inode to
> > > fsnotify() so there is no fsnotify_data_path() to extract mnt event
> > > subscribers from.
> >
> > Right, that was my point. You don't have the mnt context for the
> > underlying fs at a time when e.g. call vfs_link() which ultimately calls
> > fsnotify_create/link() which I'm saying might be a problem.
> >
> 
> It's a problem. If it wasn't a problem I wouldn't need to work around it ;-)
> 
> It would be a problem if people think that the FAN_MOUNT_MARK
> is a subtree mark, which it certainly is not. And I have no doubt that

I don't think subtree marks figure into the example above. But we
digress.

> as Jan said, people really do want a subtree mark.
> 
> My question to you with this RFC is: Does the ability to subscribe to
> CREATE/DELETE/MOVE events on a mount help any of your use
> cases? With or without the property that mount marks are allowed

Since I explicitly pointed on in a prior mail that it would be great to
have the same events as for a regular fanotify watch I think I already
answered that question. :)

> inside userns for idmapped mounts.

But if it helps then I'll do it once: yes, both would indeed be very
useful.

> 
> Note that if we think the semantics of this are useful for container
> managers, but too complex for most mortals, we may decide to
> restrict the ability to subscribe to those events to idmapped mounts(?).

I don't think it's too complex for most users. But supervisors and
container managers are prime users of a feature like this.

Christian
