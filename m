Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54445019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfFMXhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 19:37:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54408 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfFMXhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:37:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so452474wme.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oodRWfym8vGhEJNTwBcKhJMKuWNGLtph+QGLWfAyKO0=;
        b=BvbGJfCrFemSkbH88wzZyyFSZzIZCF3X5vaX3OL9UB8Lz6ZMFUlq6T7RtZ5xwzVe2m
         HGeBjbnEatgk9gSuh2WSiV+1vzf4BLyKfU6qbBz/4JMx/GGodTcx4WLzM+cUKFDgk7ut
         8X7p3+SL7XYNw8+ei+6PhnS02p01XJ+5Xzs1Fn/fGsDgjjxrjpq6INY/46Ooh+ZdhAGK
         Z+wGDUrYd+UR1Q8ZFuUHNrQwf4ValMHY33hco3gNPx00Auyxm4rAcRlWv9qKAvua0nBx
         yvAtdRmzcUviT0Kw+M6SucHg8julb2219C8fnqqt8ccGYQs4MvzsDL0f34FkR2JospN9
         pp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oodRWfym8vGhEJNTwBcKhJMKuWNGLtph+QGLWfAyKO0=;
        b=slLLHhG3qGC4OcZ2kOD/SoQE4XLLSlhlPhZWybyiJfnNGmYiVUZLqbkp0t3bJCjzyh
         GQRfAF6Es/LxxRLZNXjdHJ2scd7me0sgLOMy8jJ7T3yp6dVlPy+lUVAR4NkWN1aoQ1Fr
         L2wCkMMO08b5mWsVjzv6oNui+RuASgVgIwN78ZsE1dC0Ox4krNzzz7KUSl/kdRQiX3sI
         hritq6sh+QOnggcmdJjnXY5Nly6qXFG95yrTORBpKIJC2abevZmBzer4cOR/H7lodzHd
         DgwrBEku3Q544JSGvAmf/xBFcpoufP+M9Patmf8vftahBNVEmAdXTUhw8nNm48Uq8adK
         LF5Q==
X-Gm-Message-State: APjAAAUkdP7TrKAsXbTWIQzMsRuIZryX3epx3SongC2mOwf3OZrdmMGC
        C4aVEB48xHSHJqDd8YIAH/hFGw==
X-Google-Smtp-Source: APXvYqzEfhmewH9tg1rXq9RVwyKLlMT4ECRx5um77h5E2+ZurrtbqNeEBidyPPF+YuN7/SeF8pNtfw==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr5640506wmj.41.1560469029595;
        Thu, 13 Jun 2019 16:37:09 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f13sm2169960wrt.27.2019.06.13.16.37.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:37:09 -0700 (PDT)
Date:   Fri, 14 Jun 2019 01:37:07 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
Message-ID: <20190613233706.6k6struu7valxaxy@brauner.io>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
 <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
 <20190613132250.u65yawzvf4voifea@brauner.io>
 <871rzxwcz7.fsf@xmission.com>
 <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
 <878su5tadf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878su5tadf.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:59:24PM -0500, Eric W. Biederman wrote:
> Miklos Szeredi <miklos@szeredi.hu> writes:
> 
> > On Thu, Jun 13, 2019 at 8:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Christian Brauner <christian@brauner.io> writes:
> >>
> >> > On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
> >> >> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
> >> >> >
> >> >> > The commit changes the internal logic to lock mounts when propagating
> >> >> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> >> >> > to fail at:
> >> >>
> >> >> You mean 'do_move_mount()'.
> >> >>
> >> >> > if (old->mnt.mnt_flags & MNT_LOCKED)
> >> >> >         goto out;
> >> >> >
> >> >> > If that's indeed the case we should either revert this commit (reverts
> >> >> > cleanly, just tested it) or find a fix.
> >> >>
> >> >> Hmm.. I'm not entirely sure of the logic here, and just looking at
> >> >> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
> >> >> cross-userns copies") doesn't make me go "Ahh" either.
> >> >>
> >> >> Al? My gut feel is that we need to just revert, since this was in 5.1
> >> >> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
> >> >> don't be silly, this is easily fixed with this one-liner".
> >> >
> >> > David and I have been staring at that code today for a while together.
> >> > I think I made some sense of it.
> >> > One thing we weren't absolutely sure is if the old MS_MOVE behavior was
> >> > intentional or a bug. If it is a bug we have a problem since we quite
> >> > heavily rely on this...
> >>
> >> It was intentional.
> >>
> >> The only mounts that are locked in propagation are the mounts that
> >> propagate together.  If you see the mounts come in as individuals you
> >> can always see/manipulate/work with the underlying mount.
> >>
> >> I can think of only a few ways for MNT_LOCKED to become set:
> >> a) unshare(CLONE_NEWNS)
> >> b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
> >> c) mount --move /path/to/mnt/tree /path/to/propgation/point
> >>
> >> Nothing in the target namespace should be locked on the propgation point
> >> but all of the new mounts that came across as a unit should be locked
> >> together.
> >
> > Locked together means the root of the new mount tree doesn't have
> > MNT_LOCKED set, but all mounts below do have MNT_LOCKED, right?
> >
> > Isn't the bug here that the root mount gets MNT_LOCKED as well?

Yes, we suspected this as well. We just couldn't pinpoint where the
surgery would need to start.

> 
> Yes, and the code to remove MNT_LOCKED is still sitting there in
> propogate_one right after it calls copy_tree.  It should be a trivial
> matter of moving that change to after the lock_mnt_tree call.
> 
> Now that I have been elightened about anonymous mount namespaces
> I am suspecting that we want to take the user_namespace of the anonymous
> namespace into account when deciding to lock the mounts.
> 
> >> Then it breaking is definitely a regression that needs to be fixed.
> >>
> >> I believe the problematic change as made because the new mount
> >> api allows attaching floating mounts.  Or that was the plan last I
> >> looked.   Those floating mounts don't have a mnt_ns so will result
> >> in a NULL pointer dereference when they are attached.
> >
> > Well, it's called anonymous namespace.  So there *is* an mnt_ns, and
> > its lifetime is bound to the file returned by fsmount().
> 
> Interesting.  That has changed since I last saw the patches.
> 
> Below is what will probably be a straight forward fix for the regression.

Tested the patch just now applied on top of v5.1. It fixes the
regression.
Can you please send a proper patch, Eric?

Tested-by: Christian Brauner <christian@brauner.io>
Acked-by: Christian Brauner <christian@brauner.io>

> 
> Eric
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ffb13f0562b0..a39edeecbc46 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2105,6 +2105,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>                 /* Notice when we are propagating across user namespaces */
>                 if (child->mnt_parent->mnt_ns->user_ns != user_ns)
>                         lock_mnt_tree(child);
> +               child->mnt.mnt_flags &= ~MNT_LOCKED;
>                 commit_tree(child);
>         }
>         put_mountpoint(smp);
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 7ea6cfb65077..012be405fec0 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -262,7 +262,6 @@ static int propagate_one(struct mount *m)
>         child = copy_tree(last_source, last_source->mnt.mnt_root, type);
>         if (IS_ERR(child))
>                 return PTR_ERR(child);
> -       child->mnt.mnt_flags &= ~MNT_LOCKED;
>         mnt_set_mountpoint(m, mp, child);
>         last_dest = m;
>         last_source = child;
> 
> 
