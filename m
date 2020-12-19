Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2922DEDE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLSJKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgLSJKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 04:10:43 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9845C0617B0;
        Sat, 19 Dec 2020 01:10:02 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q1so4449976ilt.6;
        Sat, 19 Dec 2020 01:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1wy7liFqMqVpv5JtwH/C3c5e9etpiGocBgOADyhFdM=;
        b=RndZ13ih4vKSuofRFlb/OT7+crLM7UarHW7UTafoYVQDGg/mMvijJ3UQx0dDP4KFNo
         Q6AAwBX9VKAJHEgkWcCKLCRWj+cN25Tav1mmxYxmdRuAZkduqgsPnSGVEBNgixQ9y+vC
         jisec+st7N7DPYftpu/iS5IQlH88lkn+CERhOXxj9b9UGSt0FEQ2QpROrspXhPA0dAP1
         +yQWOr3b9PeBCFLM2JrWzO4pakflvEP1+fyOTpJiCq5bDOUtv7lb0KK7XXaTYE6QMg1C
         5R3NO+ZPBmD0d9+COoJLk+LIaqn/y7tXrD+5R33oHn9y2pX5jrY82K4t/ZlUfMyx6Vks
         ihHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1wy7liFqMqVpv5JtwH/C3c5e9etpiGocBgOADyhFdM=;
        b=SuoFW6M+TlRPBXT0d9LnBUxlcWf6b5eYA/XjdTYx5ypISbytZ3HFKkvs9xJSqGN0tU
         fkTQfNpIo7zLCbukfg2SWul+cdsc5Xipxuzz1x7m5FqLHJ+OiFk7yQkhu4TQ9JS4+rHM
         MPsStj9Gh06RYSJfBNP4nMPo5RGbdlqzEgZ4fsk/J/ae/9zPoEvSDbwi7P2hJxjtr5+M
         IuXA2/hgW/XwNCIk/5tYoqjoV5KOiOnLxZPUI5jcLWyz6KMtXdWBcNOTyIWyf6i8OuL2
         rF4fmdMzQ3U9Ip6wW+jRZz28yNXjuY3bMns+Tjaboozlf68RJh+7BX28hvuyVBLGO5kC
         cSSg==
X-Gm-Message-State: AOAM532vtLwPZbB4o3ckQ7nX+/1haYrlQSDbR3oV8lgl5n0HYfTerg2u
        RElGP/DR/i1Cq2kYTJRpwI8XcTeL9ymuxb3FC8M=
X-Google-Smtp-Source: ABdhPJwwWbvnrzzQX1AlWcAafNjbUiwriB5icT7nHAJKwGV8XH45WLDoDpatq1Ir2rUDtiZHD1j9iDuo5M6s+gXoYJQ=
X-Received: by 2002:a92:da82:: with SMTP id u2mr8268140iln.137.1608369001800;
 Sat, 19 Dec 2020 01:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20201217150037.468787-1-jlayton@kernel.org> <20201217203523.GB28177@ircssh-2.c.rugged-nimbus-611.internal>
 <9e38d400ed1e6bf4a3909f69238e3e5001d908fb.camel@kernel.org>
 <20201218234427.GA17343@ircssh-2.c.rugged-nimbus-611.internal> <3e7c3521f8852ba662413042348a4a7894e42dc3.camel@kernel.org>
In-Reply-To: <3e7c3521f8852ba662413042348a4a7894e42dc3.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 19 Dec 2020 11:09:50 +0200
Message-ID: <CAOQ4uxi4UTUNejxn-0MX4DJkZSCCjsWos0jVwS1_toPc5PpP+g@mail.gmail.com>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 3:03 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-12-18 at 23:44 +0000, Sargun Dhillon wrote:
> > On Thu, Dec 17, 2020 at 04:18:49PM -0500, Jeff Layton wrote:
> > > On Thu, 2020-12-17 at 20:35 +0000, Sargun Dhillon wrote:
> > > > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > > > own purposes, without preventing a later opener from potentially seeing
> > > > > the error.
> > > > >
> > > > > The original reason for the ERRSEQ_SEEN flag was to make it so that we
> > > > > didn't need to increment the counter if nothing had observed the latest
> > > > > value and the error was the same. Eventually, a regression was reported
> > > > > in the errseq_t conversion, and we fixed that by using the ERRSEQ_SEEN
> > > > > flag to also mean that the error had been reported to userland at least
> > > > > once somewhere.
> > > > >
> > > > > Those are two different states, however. If we instead take a second
> > > > > flag bit from the counter, we can track these two things separately, and
> > > > > accomodate the overlayfs volatile mount use-case.
> > > > >
> > > > > Rename the ERRSEQ_SEEN flag to ERRSEQ_OBSERVED and use that to indicate
> > > > > that the counter must be incremented the next time an error is set.
> > > > > Also, add a new ERRSEQ_REPORTED flag that indicates whether the current
> > > > > error was returned to userland (and thus doesn't need to be reported on
> > > > > newly open file descriptions).
> > > > >
> > > > > Test only for the OBSERVED bit when deciding whether to increment the
> > > > > counter and only for the REPORTED bit when deciding what to return in
> > > > > errseq_sample.
> > > > >
> > > > > Add a new errseq_peek function to allow for the overlayfs use-case.
> > > > > This just grabs the latest counter and sets the OBSERVED bit, leaving the
> > > > > REPORTED bit untouched.
> > > > >
> > > > > errseq_check_and_advance must now handle a single special case where
> > > > > it races against a "peek" of an as of yet unseen value. The do/while
> > > > > loop looks scary, but shouldn't loop more than once.
> > > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  Documentation/core-api/errseq.rst |  22 +++--
> > > > >  include/linux/errseq.h            |   1 +
> > > > >  lib/errseq.c                      | 139 ++++++++++++++++++++++--------
> > > > >  3 files changed, 118 insertions(+), 44 deletions(-)
> > > > >
> > > > > v3: rename SEEN/MUSTINC flags to REPORTED/OBSERVED
> > > > >
> > > > > Hopefully the new flag names will make this a bit more clear. We could
> > > > > also rename some of the functions if that helps too. We could consider
> > > > > moving from errseq_sample/_check_and_advance to
> > > > > errseq_observe/errseq_report?  I'm not sure that helps anything though.
> > > > >
> > > > > I know that Vivek and Sargun are working on syncfs() for overlayfs, so
> > > > > we probably don't want to merge this until that work is ready. I think
> > > >
> > > > I disagree. I think that this work can land ahead of that, given that I think
> > > > this is probably backportable to v5.10 without much risk, with the addition of
> > > > your RFC v2 Overlay patch. I think the work proper long-term repair Vivek is
> > > > embarking upon seems like it may be far more invasive.
> > > >
> > > > > the errseq_peek call will need to be part of their solution for volatile
> > > > > mounts, however, so I'm fine with merging this via the overlayfs tree,
> > > > > once that work is complete.
> > > > >
> > > > > diff --git a/Documentation/core-api/errseq.rst b/Documentation/core-api/errseq.rst
> > > > > index ff332e272405..ce46ddcc1487 100644
> > > > > --- a/Documentation/core-api/errseq.rst
> > > > > +++ b/Documentation/core-api/errseq.rst
> > > > > @@ -18,18 +18,22 @@ these functions can be called from any context.
> > > > >  Note that there is a risk of collisions if new errors are being recorded
> > > > >  frequently, since we have so few bits to use as a counter.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > -To mitigate this, the bit between the error value and counter is used as
> > > > > -a flag to tell whether the value has been sampled since a new value was
> > > > > -recorded.  That allows us to avoid bumping the counter if no one has
> > > > > -sampled it since the last time an error was recorded.
> > > > > +To mitigate this, the bits between the error value and counter are used
> > > > > +as flags to tell whether the value has been sampled since a new value
> > > > > +was recorded, and whether the latest error has been seen by userland.
> > > > > +That allows us to avoid bumping the counter if no one has sampled it
> > > > > +since the last time an error was recorded, and also ensures that any
> > > > > +recorded error will be seen at least once.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >  Thus we end up with a value that looks something like this:
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > -+--------------------------------------+----+------------------------+
> > > > > -| 31..13                               | 12 | 11..0                  |
> > > > > -+--------------------------------------+----+------------------------+
> > > > > -| counter                              | SF | errno                  |
> > > > > -+--------------------------------------+----+------------------------+
> > > > > ++---------------------------------+----+----+------------------------+
> > > > > +| 31..14                          | 13 | 12 | 11..0                  |
> > > > > ++---------------------------------+----+----+------------------------+
> > > > > +| counter                         | OF | RF | errno                  |
> > > > > ++---------------------------------+----+----+------------------------+
> > > > > +OF = ERRSEQ_OBSERVED flag
> > > > > +RF = ERRSEQ_REPORTED flag
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >  The general idea is for "watchers" to sample an errseq_t value and keep
> > > > >  it as a running cursor.  That value can later be used to tell whether
> > > > > diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> > > > > index fc2777770768..7e3634269c95 100644
> > > > > --- a/include/linux/errseq.h
> > > > > +++ b/include/linux/errseq.h
> > > > > @@ -9,6 +9,7 @@ typedef u32     errseq_t;
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >  errseq_t errseq_set(errseq_t *eseq, int err);
> > > > >  errseq_t errseq_sample(errseq_t *eseq);
> > > > > +errseq_t errseq_peek(errseq_t *eseq);
> > > > >  int errseq_check(errseq_t *eseq, errseq_t since);
> > > > >  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
> > > > >  #endif
> > > > > diff --git a/lib/errseq.c b/lib/errseq.c
> > > > > index 81f9e33aa7e7..8fd6be134dcc 100644
> > > > > --- a/lib/errseq.c
> > > > > +++ b/lib/errseq.c
> > > > > @@ -21,10 +21,14 @@
> > > > >   * Note that there is a risk of collisions if new errors are being recorded
> > > > >   * frequently, since we have so few bits to use as a counter.
> > > > >   *
> > > > > - * To mitigate this, one bit is used as a flag to tell whether the value has
> > > > > - * been sampled since a new value was recorded. That allows us to avoid bumping
> > > > > - * the counter if no one has sampled it since the last time an error was
> > > > > - * recorded.
> > > > > + * To mitigate this, one bit is used as a flag to tell whether the value has been
> > > > > + * observed in some fashion. That allows us to avoid bumping the counter if no
> > > > > + * one has sampled it since the last time an error was recorded.
> > > > > + *
> > > > > + * A second flag bit is used to indicate whether the latest error that has been
> > > > > + * recorded has been reported to userland. If the REPORTED bit is not set when the
> > > > > + * file is opened, then we ensure that the opener will see the error by setting
> > > > > + * its sample to 0.
> > > >
> > > > Since there are only a few places that report to userland (as far as I can tell,
> > > > a bit of usage in ceph), does it make sense to maintain this specific flag that
> > > > indicates it's reported to userspace? Instead can userspace keep a snapshot
> > > > of the last errseq it reported (say on the superblock), and use that to drive
> > > > reports to userspace?
> > > >
> > > > It's a 32-bit sacrifice per SB though, but it means we can get rid of
> > > > errseq_check_and_advance and potentially remove any need for locking and just
> > > > rely on cmpxchg.
> > >
> > > I think it makes sense. You are essentially adding a new class of
> > > "samplers" that use the error for their own purposes and won't be
> > > reporting it to userland via normal channels (syncfs, etc.). A single
> > > bit to indicate whether it has only been observed by such samplers is
> > > not a huge sacrifice.
> > >
> > > I worry too about race conditions when tracking this information across
> > > multiple words. You'll either need to use some locking to manage that,
> > > or get clever with memory barriers. Keeping everything in one word makes
> > > things a lot simpler.
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >
> >
> > I'll wait for Amir or Miklos to chime in, but I'm happy with this, and it solves
> > my problems.
> >
> > Do you want to respin this patch with the overlayfs patch as well, so
> > we can cherry-pick to stable, and then focus on how we want to deal
> > with this problem in the future?
>
> Assuming no one sees issues with it and that this solves the problem of
> writeback errors on volatile mounts, I'm fine with this going in via the
> overlayfs tree, just ahead of the patch that adds the first caller of
> errseq_peek.
>

I like the ERRSEQ_OBSERVED/ERRSEQ_REPORTED abstraction.
I agree with Jeff that ERRSEQ_SEEN wrongly multiplexies two
completely different things.

We've had to maintain backward compact to the syncfs() behavior
expected by existing users, but I can also imagine that fsinfo() would
want to check for sb error without consuming it, so errseq_peek()
looks like the right direction to take.

> I think we're finding that the thornier problem is how to pass along
> writeback errors on non-volatile mounts. That's probably going to
> require some vfs-layer surgery, so it may be best to wait until the
> shape of that is clear.

I have to say, following the thread of each of those problems is pretty
challenging. Following both issues in several intewinding threads is a
workout...

Thanks,
Amir.
