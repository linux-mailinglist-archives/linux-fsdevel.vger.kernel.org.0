Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337592C404A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 13:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgKYMe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 07:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgKYMe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:34:28 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEADC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 04:34:28 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t13so1995916ilp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeqwOazZr9d6M9+ZfE+h2IFvwQ5KGwAmH3MImI3f72k=;
        b=kyvo1Z9kLBoPSylRFtI7VX7creUq6xDKSNd8PiXqO7+P6c8k40uqujZwPDywL0TdGt
         IG1P9ygX1jY+kO1uP26a+gKRcVhqET1cBGD34YFBdanqaW7r6ovNTq3GE8sdBqXsq17p
         XAxDPb2FbMNtFBLsd0N9yAYOY7J8P5n3J0sQoD4XOc3hKluas30dXXIHPlvXU4+SJs2m
         M2d0EWw4yKSj+nQrmC5aw8AD1RzCoHlRARQzhOeG8z0YHe8zKYoVwukRk3ciDMauMkZm
         3vbg9D1qDOtKephWtUdEhwKQgqXWOVjucjtcGr9MCq9nMwrqB4+2jrREStIG0k4HVoAW
         zqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeqwOazZr9d6M9+ZfE+h2IFvwQ5KGwAmH3MImI3f72k=;
        b=IirnkI6nDJT5ThMu+BDjZeZVYPKP2+evqd7xVW0LLKfjwCUyOQUT6BINDIubKTEmc6
         EGZ1k7qI048U/vPJPFHCPYg18i7oW+Urf1S588BTy5bBqBPX5GKucx45Ui19HxVWvkaS
         PJ8wZ9dpbm4L8z9CAV9YIvEJGdmspTlSwsP4gYFDpUGU2UbfKa703GXDFhpIZiqBUr1t
         dhEzGSfrYE2GACXenD8/PnRig+r8KBNN4AJ2Cz0DHBQJM4m4CUlM/tzC+Ud1CludYXYY
         WziO/nppEiJj8Xr/gT3+i2zJSXiugvzLIemnLtn+06mVyyGxdoNl+06jLil09dw//Oh4
         3c4g==
X-Gm-Message-State: AOAM530a+GsJR55Ij1VKIOSFozeqNCjc/JDBHZbPMi5aMWBgQx9NctlI
        zPvaPl8UIaiA+j2fkdZ/a/ZqUKDq4P+HQ1ZhhzcC94RtgCY=
X-Google-Smtp-Source: ABdhPJzcjw88Bv2aD6N66Rr/5b7Ikccijz2909gMHslMgV9EGz2L5JRPASD9a6WgfKdJnCHvhDNpOsrGXh6SVS0D74A=
X-Received: by 2002:a92:da82:: with SMTP id u2mr1180686iln.137.1606307667603;
 Wed, 25 Nov 2020 04:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com> <20201125110156.GB16944@quack2.suse.cz>
In-Reply-To: <20201125110156.GB16944@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Nov 2020 14:34:16 +0200
Message-ID: <CAOQ4uxiaaQ9X8EBS-bd2DNMdg7ezNoRXCRvu+4idikx67OFbQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-11-20 16:47:41, Amir Goldstein wrote:
> > On Tue, Nov 24, 2020 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 09-11-20 20:00:16, Amir Goldstein wrote:
> > > > A filesystem view is a subtree of a filesystem accessible from a specific
> > > > mount point.  When marking an FS view, user expects to get events on all
> > > > inodes that are accessible from the marked mount, even if the events
> > > > were generated from another mount.
> > > >
> > > > In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> > > > are not delivered to a mount mark can be delivered to an FS view mark.
> > > >
> > > > One example of a filesystem view is btrfs subvolume, which cannot be
> > > > marked with a regular filesystem mark.
> > > >
> > > > Another example of a filesystem view is a bind mount, not on the root of
> > > > the filesystem, such as the bind mounts used for containers.
> > > >
> > > > A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> > > > The filesystem view mark is connected to the head sb mark and the head
> > > > sb mark is connected to the sb object. The mask of the head sb mask is
> > > > a cumulative mask of all the associated sb_view mark masks.
> > > >
> > > > Filesystem view marks cannot co-exist with a regular filesystem mark on
> > > > the same filesystem.
> > > >
> > > > When an event is generated on the head sb mark, fsnotify iterates the
> > > > list of associated sb_view marks and filter events that happen outside
> > > > of the sb_view mount's root.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I gave this just a high-level look (no detailed review) and here are my
> > > thoughts:
> > >
> > > 1) I like the functionality. IMO this is what a lot of people really want
> > > when looking for "filesystem wide fs monitoring".
> > >
> > > 2) I don't quite like the API you propose though. IMO it exposes details of
> > > implementation in the API. I'd rather like to have API the same as for
> > > mount marks but with a dedicated mark type flag in the API - like
> > > FAN_MARK_FILESYSTEM_SUBTREE (or we can keep VIEW if you like it but I think
> > > the less terms the better ;).
> >
> > Sure, FAN_MARK_FS_VIEW is a dedicated mark type.
> > The fact that is it a bitwise OR of MOUNT and FILESYSTEM is just a fun fact.
> > Sorry if that wasn't clear.
> > FAN_MARK_FILESYSTEM_SUBTREE sounds better for uapi.
> >
> > But I suppose you also meant that we should not limit the subtree root
> > to bind mount points?
> >
> > The reason I used a reference to mnt for a sb_view and not dentry
> > is because we have fsnotify_clear_marks_by_mount() callback to
> > handle cleanup of the sb_view marks (which I left as TODO).
> >
> > Alternatively, we can play cache pinning games with the subtree root dentry
> > like the case with inode mark, but I didn't want to get into that nor did I know
> > if we should - if subtree mark requires CAP_SYS_ADMIN anyway, why not
> > require a bind mount as its target, which is something much more visible to
> > admins.
>
> Yeah, I don't have problems with bind mounts in particular. Just I was
> thinking that concievably we could make these marks less priviledged (just
> with CAP_DAC_SEARCH or so) and then mountpoints may be unnecessarily
> restricting. I don't think pinning of subtree root dentry would be
> problematic as such - inode marks pin the inode anyway, this is not
> substantially different - if we can make it work reliably...
>

I'm going to need your help for that ;-)

> In fact I was considering for a while that we could even make subtree
> watches completely unpriviledged - when we walk the dir tree anyway, we
> could also check permissions along the way. Due to locking this would be
> difficult to do when generating the event but it might be actually doable
> if we perform the permission check when reporting the event to userspace.
> Just a food for thought...

Maybe... but there are some other advantages to restricting to mount.

One is that with btrfs subvolumes conn->fsid can actually cache the
subvolume's fsid and we could remove the restriction of -EXDEV
error of FAN_MARK_FILESYSTEM on subvolume.

Another has to do with performance optimization (see below).

>
> > > Also I think this is going to get expensive
> > > (e.g. imagine each write to page cache having to traverse potentially deep
> > > tree hierarchy potentially multiple times - once for each subtree). My
> > > suspicion should be verified with actual performance measurement but if I'm
> > > right and the overhead is indeed noticeable, I think we'll need to employ
> > > some caching or so to avoid repeated lookups...
> >
> > It's true, but here is a different angle to analyse the overhead - claim:
> > "If users don't have kernel subtree mark, they will use filesystem mark
> >  and filter is userspace". If that claim is true, than one can argue that
> > this is fair - let the listener process pay the CPU overhead which can be
> > contained inside a cgroup and not everyone else. But what is the cost that
> > everyone else will be paying in that case?
> > Everyone will still pay the cost of the fanotify backend callback including
> > allocate, pack and queue the event.
> > The question then becomes, what is cheaper? The d_ancestor() traversal
> > or all the fanotify backend handler code?
> > Note that the former can be lockless and the latter does take locks.
>
> I understand and it's a fair point that queueing of the event is not cheap
> either so I'd be interested in the numbers. Something like how deep subtree
> walk is similar to a cost of queueing event. Or similarly checking of how many
> subtree watches is similarly costly as queueing of one event?
>

The cost shouldn't actually be sensitive to the number of subtree watches.
We should never do more than a single ancestor traversal per event up to
it's sb root and for each ancestor we should be able to check with O(1) if
a subtree watch exists on that inode/dentry.

If we stay with the bind mount restriction then we can use the check
d_mountpoint() on every ancestor which practically reduces the cost per
ancestor to zero in most cases.


> > I have a pretty good bet on the answer, but as you say only actual performance
> > benchmarks can tell.
> >
> > From my experience, real life fsevent listeners do not listen on FAN_MODIFY
> > but they listen on FAN_CLOSE_WRITE, because the the former is too noisy.
>
> Agreed.
>
> > The best case scenario is that users step forward to say that they want to
> > use fanotify but need the subtree filterting and can provide us with real life
> > performance measurement of the userspace vs. kernel alternatives (in terms
> > of penalty on the rest of the system).
>
> With the cost of having to go to userspace and there do essentially the same
> subtree walk as you do in the kernel, I have no doubt what's going to be
> faster (by orders of magnitude). What I'm somewhat uncertain is whether the
> subtree check is OK at the time of event generation or whether it should
> better be moved to the moment when we are about to report the event to
> userspace (when the cost of the subtree check goes to the process
> interested in the event which is fine - but as you properly note we already
> had to pay the cost of queueing the event so it isn't clear this is a win
> even for the processes generating events).
>

I think the only semantics that make sense are:

* If all object's present and past ancestors were always under subtree -
   guaranty to get an event
* If all object's present and past ancestors were never under subtree -
   guaranty to not get an event
* Otherwise - undefined

So I think it is ok to check for subtree on event generation time.

Thanks,
Amir.

Thanks,
Amir.
