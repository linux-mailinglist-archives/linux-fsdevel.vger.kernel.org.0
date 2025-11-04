Return-Path: <linux-fsdevel+bounces-66981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E6C32C2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C91D18C04E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607562D47F3;
	Tue,  4 Nov 2025 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz75e+vu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEF2949E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284161; cv=none; b=tOQQuou5kXFP/2Onhg/d/AeksLSdXdopSS3SVIs+6d4MNvJOKNJiuAMx2PZd/136i6sG2hfgew2b9mkHvqlfTunJ/IdIW4iZD0NnnagPHlElCYCMdxzJM2HJ2dBACMC+vVAuykUlNeNiPhe5ZkfCswaNOVtgNMDjyUpB4G8w9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284161; c=relaxed/simple;
	bh=/xoEFE2ZIln2mJ5NJuIwT9W3DyDKavAk85+mARYsLKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCjfD8YICt1XnlJZEiptI/PPitwzOsBqbDWycdvTBt+QtJp6iFX0m1vFI6jhghwQjQ/Te3DYYOKNYB4A7+5eIZO7XCNdVBXnXgHqGw1NCytujnmMhhiDdwihq3cPJmYr7RFB1FGqx/d0lYkIQF5lDv2BLH+cd5Zk2YnGwXxvPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz75e+vu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88040cfadbfso1326146d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284159; x=1762888959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3NlQhyOh7MjDlJxG5d0Kht+8br5jgkgJR8dB2Xrv2Q=;
        b=Vz75e+vuHQgAd0HZ7A2muIqEM/K5kYPE9ncV8fOkO/zgD5RW5fO0LW4qIt3+w+SA92
         4NFhIuq4vxax/ignJRwGeNGX+QSBeyX5gO0ZG6lTvuIkw7/0zTAOQybbw3FQGBkkMhzx
         nF9IyQ/+6UOlHiR2xdmppCinY6NDk5FeOx8AczJsCNYThq1yHnnb9h7fM7VAE2hi0A49
         SoTwpHxhMH1aNcSRhnCAA383AwkDNz+H2wqnSgY8IMODpCmnH683C5rcofbKkoCA51Gq
         Ly5mBgg8P6Oswf72+Grz2NlCZ3LK3dEbuWWI1oYa/L7Jgdh1M5Gbt99Dgr3s2LAPgGox
         SGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284159; x=1762888959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3NlQhyOh7MjDlJxG5d0Kht+8br5jgkgJR8dB2Xrv2Q=;
        b=VKsUeZ6JBuQ3PEyQBNXhmvgUNd6coEfhIIMX+N4gPpZQz351JRG0g051cZR6vDayLx
         OWojCFUWlcw5haMIMqe9gm9PVp1AZnV4LcgHhWCl19HJhpy/XeJwPrrpYkcFOnYjP+Ka
         3SQLA+zQMe8J3HA3owJzR5VoAwOjKmicneLeu92T/EPvXu2UfXA2rlSUeWnawPFy9iza
         ALANuSVXzo9MiG+7q75PPvcChEK9OjaICv+V3+wY76Lo7zNPsvL69tg0SWKggy7uqny+
         r7XAt5bY1DP9v7icvXOpytr+eJLvg5hwub1fJBYb3AQrzZgQI9Y+T8tAgWQPnZ6eq6P8
         hAAg==
X-Forwarded-Encrypted: i=1; AJvYcCUY3ULOeX7au0XKhrTbjU7jdh3aBueaEku4J/EC0PBi3oUMaa7aRmtdW9PUw3SlL0ZhELTAoGSHrGxTWZoY@vger.kernel.org
X-Gm-Message-State: AOJu0YwMUleV+dipDey12HL/W7qeMrVbgbrqce17m6JYC5/Zn59d8e0G
	75OqetoqF2y5PSNRbSLfHadfnXLdKLL3DipAcLmhwKfBVbp0eoY73S+bAQ1kEpstD86i+VbNN4c
	GB8PDJuMHbWqMQC4m73SDdx8rHszzXSw=
X-Gm-Gg: ASbGncsgVebcmhK/qnT1c/tGy7ueZtlHBq7+nwW1jN4ni4n7+coIgjpQz7rqFqZytS/
	SKC1Fd/8lC7Hmshvs+IHUIDhmDcpeVSBI2FlV4M1HTij7VohyJNYrvSwKKjsoFYgqE61u/1P3mM
	lapIJbiBj2Sf7GeCIcVdHFGMm7YxB6Fe7bExBoKPIKV2dUgAYRUm2GeD86Jsxu5mgVprCm8Ehgd
	DkGUtM+LLcvSvJi4eBoAkG6ex2f/V7QValsmWYbX/m0jKGDhrP40pDko0Zu8Sbr+ecvmpfa4xqA
	Kwnqe7u+wX3j9FlL+W2/Sx9NL6X3X4t/
X-Google-Smtp-Source: AGHT+IERXAI2HsW4c7j1leXP7P/CukaiH8zUSb8w5bKxjwwjcVeMZl0lGfkfJiGEbLpIar0DRGtPFjQzBCPhuJytSAA=
X-Received: by 2002:a05:6214:29eb:b0:880:4cfb:ab57 with SMTP id
 6a1803df08f44-880711f394dmr11916376d6.25.1762284158518; Tue, 04 Nov 2025
 11:22:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com> <20251103221349.GE196370@frogsfrogsfrogs>
In-Reply-To: <20251103221349.GE196370@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Nov 2025 11:22:26 -0800
X-Gm-Features: AWmQ_bkyACsE2eZZy6Y_MH-p_4BoJV7iYOwgf2tfiSEPRFiCnzpWgVmhA88jd8s
Message-ID: <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 2:13=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Mon, Nov 03, 2025 at 09:20:26AM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > generic/488 fails with fuse2fs in the following fashion:
> > >
> > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf i=
s inconsistent
> > > (see /var/tmp/fstests/generic/488.full for details)
> > >
> > > This test opens a large number of files, unlinks them (which really j=
ust
> > > renames them to fuse hidden files), closes the program, unmounts the
> > > filesystem, and runs fsck to check that there aren't any inconsistenc=
ies
> > > in the filesystem.
> > >
> > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > files left over in the filesystem, with incorrect link counts.  Traci=
ng
> > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > commands that are queued up on behalf of the unlinked files at the ti=
me
> > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > aborted, the fuse server would have responded to the RELEASE commands=
 by
> > > removing the hidden files; instead they stick around.
> > >
> > > For upper-level fuse servers that don't use fuseblk mode this isn't a
> > > problem because libfuse responds to the connection going down by prun=
ing
> > > its inode cache and calling the fuse server's ->release for any open
> > > files before calling the server's ->destroy function.
> > >
> > > For fuseblk servers this is a problem, however, because the kernel se=
nds
> > > FUSE_DESTROY to the fuse server, and the fuse server has to close the
> > > block device before returning.  This means that the kernel must flush
> > > all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.
> > >
> > > Create a function to push all the background requests to the queue an=
d
> > > then wait for the number of pending events to hit zero, and call this
> > > before sending FUSE_DESTROY.  That way, all the pending events are
> > > processed by the fuse server and we don't end up with a corrupt
> > > filesystem.
> > >
> > > Note that we use a wait_event_timeout() loop to cause the process to
> > > schedule at least once per second to avoid a "task blocked" warning:
> > >
> > > INFO: task umount:1279 blocked for more than 20 seconds.
> > >       Not tainted 6.17.0-rc7-xfsx #rc7
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
ag.
> > > task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10=
690
> > >
> > > Earlier in the threads about this patch there was a (self-inflicted)
> > > dispute as to whether it was necessary to call touch_softlockup_watch=
dog
> > > in the loop body.  Because the process goes to sleep, it's not necess=
ary
> > > to touch the softlockup watchdog because we're not preventing another
> > > process from being scheduled on a CPU.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h |    5 +++++
> > >  fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
> > >  fs/fuse/inode.c  |   11 ++++++++++-
> > >  3 files changed, 50 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index c2f2a48156d6c5..aaa8574fd72775 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
> > >  void fuse_abort_conn(struct fuse_conn *fc);
> > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > >
> > > +/**
> > > + * Flush all pending requests and wait for them.
> > > + */
> > > +void fuse_flush_requests_and_wait(struct fuse_conn *fc);
> > > +
> > >  /* Check if any requests timed out */
> > >  void fuse_check_timeout(struct work_struct *work);
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 132f38619d7072..ecc0a5304c59d1 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/splice.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/nmi.h>
> > >
> > >  #include "fuse_trace.h"
> > >
> > > @@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
> > >         }
> > >  }
> > >
> > > +/*
> > > + * Flush all pending requests and wait for them.  Only call this fun=
ction when
> > > + * it is no longer possible for other threads to add requests.
> > > + */
> > > +void fuse_flush_requests_and_wait(struct fuse_conn *fc)
> > > +{
> > > +       spin_lock(&fc->lock);
> >
> > Do we need to grab the fc lock? fc->connected is protected under the
> > bg_lock, afaict from fuse_abort_conn().
>
> Oh, heh.  Yeah, it does indeed take both fc->lock and fc->bg_lock.
> Will fix that, thanks. :)
>
> FWIW I don't think it's a big deal if we see a stale connected=3D=3D1 val=
ue
> because the events will all get cancelled and the wait loop won't run
> anyway, but I agree with being consistent about lock ordering. :)
>
> > > +       if (!fc->connected) {
> > > +               spin_unlock(&fc->lock);
> > > +               return;
> > > +       }
> > > +
> > > +       /* Push all the background requests to the queue. */
> > > +       spin_lock(&fc->bg_lock);
> > > +       fc->blocked =3D 0;
> > > +       fc->max_background =3D UINT_MAX;
> > > +       flush_bg_queue(fc);
> > > +       spin_unlock(&fc->bg_lock);
> > > +       spin_unlock(&fc->lock);
> > > +
> > > +       /*
> > > +        * Wait for all pending fuse requests to complete or abort.  =
The fuse
> > > +        * server could take a significant amount of time to complete=
 a
> > > +        * request, so run this in a loop with a short timeout so tha=
t we don't
> > > +        * trip the soft lockup detector.
> > > +        */
> > > +       smp_mb();
> > > +       while (wait_event_timeout(fc->blocked_waitq,
> > > +                       !fc->connected || atomic_read(&fc->num_waitin=
g) =3D=3D 0,
> > > +                       HZ) =3D=3D 0) {
> > > +               /* empty */
> > > +       }
> >
> > I'm wondering if it's necessary to wait here for all the pending
> > requests to complete or abort?
>
> I'm not 100% sure what the fuse client shutdown sequence is supposed to
> be.  If someone kills a program with a large number of open unlinked
> files and immediately calls umount(), then the fuse client could be in
> the process of sending FUSE_RELEASE requests to the server.
>
> [background info, feel free to speedread this paragraph]
> For a non-fuseblk server, unmount aborts all pending requests and
> disconnects the fuse device.  This means that the fuse server won't see
> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> with a lot of .fuseXXXXX files that nobody cleans up.
>
> If you make ->destroy release all the remaining open files, now you run
> into a second problem, which is that if there are a lot of open unlinked
> files, freeing the inodes can collectively take enough time that the
> FUSE_DESTROY request times out.
>
> On a fuseblk server with libfuse running in multithreaded mode, there
> can be several threads reading fuse requests from the fusedev.  The
> kernel actually sends its own FUSE_DESTROY request, but there's no
> coordination between the fuse workers, which means that the fuse server
> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> processed, you end up with the same .fuseXXXXX file cleanup problem.

imo it is the responsibility of the server to coordinate this and make
sure it has handled all the requests it has received before it starts
executing the destruction logic. imo the only responsibility of the
kernel is to actually send the background requests before it sends the
FUSE_DESTROY. I think non-fuseblk servers should also receive the
FUSE_DESTROY request.

>
> Here, if you make a fuseblk server's ->destroy release all the remaining
> open files, you have an even worse problem, because that could race with
> an existing libfuse worker that's processing a FUSE_RELEASE for the same
> open file.
>
> In short, the client has a FUSE_RELEASE request that pairs with the
> FUSE_OPEN request.  During regular operations, an OPEN always ends with
> a RELEASE.  I don't understand why unmount is special in that it aborts
> release requests without even sending them to the server; that sounds
> like a bug to me.  Worse yet, I looked on Debian codesearch, and nearly
> all of the fuse servers I found do not appear to handle this correctly.
> My guess is that it's uncommon to close 100,000 unlinked open files on a
> fuse filesystem and immediately unmount it.  Network filesystems can get
> away with not caring.
>
> For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open files
> have been RELEASEd so that client can know that (a) the filesystem (at
> least as far as the kernel cares) is quiesced, and (b) the server
> persisted all dirty metadata to disk.  Only then would I send the
> FUSE_DESTROY.

Hmm, is FUSE_FLUSH not enough? As I recently learned (from Amir),
every close() triggers a FUSE_FLUSH. For dirty metadata related to
writeback, every release triggers a synchronous write_inode_now().

>
> > We are already guaranteeing that the
> > background requests get sent before we issue the FUSE_DESTROY, so it
> > seems to me like this is already enough and we could skip the wait
> > because the server should make sure it completes the prior requests
> > it's received before it executes the destruction logic.
>
> That's just the thing -- fuse_conn_destroy calls fuse_abort_conn which
> aborts all the pending background requests so the server never sees
> them.

The FUSE_DESTROY request gets sent before fuse_abort_conn() is called,
so to me, it seems like if we flush all the background requests and
then send the FUSE_DESTROY, that suffices.

With the "while (wait_event_timeout(fc->blocked_waitq, !fc->connected
|| atomic_read(&fc->num_waiting) =3D=3D 0...)" logic, I think this also
now means if a server is tripped up somewhere (eg if a remote network
connection is lost or it runs into a deadlock when servicing a
request) where it's unable to fulfill any one of its previous
requests, unmounting would hang.

Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Joanne
> >
> > > +}
> > > +
> > >  /*
> > >   * Abort all requests.
> > >   *
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index d1babf56f25470..d048d634ef46f5 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -2094,8 +2094,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> > >  {
> > >         struct fuse_conn *fc =3D fm->fc;
> > >
> > > -       if (fc->destroy)
> > > +       if (fc->destroy) {
> > > +               /*
> > > +                * Flush all pending requests (most of which will be
> > > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because=
 the fuse
> > > +                * server must close the filesystem before replying t=
o the
> > > +                * destroy message, because unmount is about to relea=
se its
> > > +                * O_EXCL hold on the block device.
> > > +                */
> > > +               fuse_flush_requests_and_wait(fc);
> > >                 fuse_send_destroy(fm);
> > > +       }
> > >
> > >         fuse_abort_conn(fc);
> > >         fuse_wait_aborted(fc);
> > >

