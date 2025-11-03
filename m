Return-Path: <linux-fsdevel+bounces-66861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6468C2E3C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 23:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B386E3BE581
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C372F1FE5;
	Mon,  3 Nov 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1H2RYpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10632F069D;
	Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208030; cv=none; b=emOP3guS4qYx1A6pCbXubINT5JFQ/iDLh+MOJkC085xEVyTEyqaIQX4206sw1N8zug/H/KQvtUmGaGVZWxBLfPRhUXylPWKjeO6U84K9nLPMdFl9mbgovTOAFBxwasIB5mzw9FAYrZMtCuXm28rMw2gqoyF/nW7+iLTaROQVXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208030; c=relaxed/simple;
	bh=h6l/2UmCCguLKcroMTcTCCpj1Im7S4mXXxzgAD3m4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfWZUI1myhPAY3ho67Vu6O9VPQR+N8pobnx+kruImNzTKpyTBLKPd1PDVLfSoHeXZh0kX7Cg7P/kmdBmJoRd9lng6SRgOYj/qvPgRN7X7J42+iiycDRNmF6rjWwGnrlUgPBLaUDd2NuLwJ4SnmuA3LfF9O/YtDMaYfnSLpdF1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1H2RYpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42498C113D0;
	Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762208030;
	bh=h6l/2UmCCguLKcroMTcTCCpj1Im7S4mXXxzgAD3m4gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1H2RYpMFd9WhBmbxUNdazEZO5h8t9gp332W6G4lDF9FQNqsLJBh4Mq/lQDHnJENo
	 TfO5HA2SQcJujKpp5xTE4lSQOg89ejrMwRUmBT/PkH5E1JmhSDog4MxW4kc76Qp14C
	 bWnZ85+2WhIhllapYiB8YbxsNeMFZDabVdxdIAzJ25yOXUyWzXkjDHf/TTsu6QjBmj
	 rTtZpf3yIQYPe4tQpbAKQY8LmpaKIyzB+qLA96krOIZXDgn14vSDLtwHOQ5GJ1AacR
	 Y8JmQOez27fx54d408wt9c61Ya9PYQEaTZKJkE4Ce7xv0g6jA0D1ULxNp98mB7oYWK
	 jio06APXyscAA==
Date: Mon, 3 Nov 2025 14:13:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251103221349.GE196370@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:20:26AM -0800, Joanne Koong wrote:
> On Tue, Oct 28, 2025 at 5:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > generic/488 fails with fuse2fs in the following fashion:
> >
> > generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> > (see /var/tmp/fstests/generic/488.full for details)
> >
> > This test opens a large number of files, unlinks them (which really just
> > renames them to fuse hidden files), closes the program, unmounts the
> > filesystem, and runs fsck to check that there aren't any inconsistencies
> > in the filesystem.
> >
> > Unfortunately, the 488.full file shows that there are a lot of hidden
> > files left over in the filesystem, with incorrect link counts.  Tracing
> > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > commands that are queued up on behalf of the unlinked files at the time
> > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > aborted, the fuse server would have responded to the RELEASE commands by
> > removing the hidden files; instead they stick around.
> >
> > For upper-level fuse servers that don't use fuseblk mode this isn't a
> > problem because libfuse responds to the connection going down by pruning
> > its inode cache and calling the fuse server's ->release for any open
> > files before calling the server's ->destroy function.
> >
> > For fuseblk servers this is a problem, however, because the kernel sends
> > FUSE_DESTROY to the fuse server, and the fuse server has to close the
> > block device before returning.  This means that the kernel must flush
> > all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.
> >
> > Create a function to push all the background requests to the queue and
> > then wait for the number of pending events to hit zero, and call this
> > before sending FUSE_DESTROY.  That way, all the pending events are
> > processed by the fuse server and we don't end up with a corrupt
> > filesystem.
> >
> > Note that we use a wait_event_timeout() loop to cause the process to
> > schedule at least once per second to avoid a "task blocked" warning:
> >
> > INFO: task umount:1279 blocked for more than 20 seconds.
> >       Not tainted 6.17.0-rc7-xfsx #rc7
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
> > task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690
> >
> > Earlier in the threads about this patch there was a (self-inflicted)
> > dispute as to whether it was necessary to call touch_softlockup_watchdog
> > in the loop body.  Because the process goes to sleep, it's not necessary
> > to touch the softlockup watchdog because we're not preventing another
> > process from being scheduled on a CPU.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    5 +++++
> >  fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
> >  fs/fuse/inode.c  |   11 ++++++++++-
> >  3 files changed, 50 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index c2f2a48156d6c5..aaa8574fd72775 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
> >  void fuse_abort_conn(struct fuse_conn *fc);
> >  void fuse_wait_aborted(struct fuse_conn *fc);
> >
> > +/**
> > + * Flush all pending requests and wait for them.
> > + */
> > +void fuse_flush_requests_and_wait(struct fuse_conn *fc);
> > +
> >  /* Check if any requests timed out */
> >  void fuse_check_timeout(struct work_struct *work);
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 132f38619d7072..ecc0a5304c59d1 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/splice.h>
> >  #include <linux/sched.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/nmi.h>
> >
> >  #include "fuse_trace.h"
> >
> > @@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
> >         }
> >  }
> >
> > +/*
> > + * Flush all pending requests and wait for them.  Only call this function when
> > + * it is no longer possible for other threads to add requests.
> > + */
> > +void fuse_flush_requests_and_wait(struct fuse_conn *fc)
> > +{
> > +       spin_lock(&fc->lock);
> 
> Do we need to grab the fc lock? fc->connected is protected under the
> bg_lock, afaict from fuse_abort_conn().

Oh, heh.  Yeah, it does indeed take both fc->lock and fc->bg_lock.
Will fix that, thanks. :)

FWIW I don't think it's a big deal if we see a stale connected==1 value
because the events will all get cancelled and the wait loop won't run
anyway, but I agree with being consistent about lock ordering. :)

> > +       if (!fc->connected) {
> > +               spin_unlock(&fc->lock);
> > +               return;
> > +       }
> > +
> > +       /* Push all the background requests to the queue. */
> > +       spin_lock(&fc->bg_lock);
> > +       fc->blocked = 0;
> > +       fc->max_background = UINT_MAX;
> > +       flush_bg_queue(fc);
> > +       spin_unlock(&fc->bg_lock);
> > +       spin_unlock(&fc->lock);
> > +
> > +       /*
> > +        * Wait for all pending fuse requests to complete or abort.  The fuse
> > +        * server could take a significant amount of time to complete a
> > +        * request, so run this in a loop with a short timeout so that we don't
> > +        * trip the soft lockup detector.
> > +        */
> > +       smp_mb();
> > +       while (wait_event_timeout(fc->blocked_waitq,
> > +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> > +                       HZ) == 0) {
> > +               /* empty */
> > +       }
> 
> I'm wondering if it's necessary to wait here for all the pending
> requests to complete or abort?

I'm not 100% sure what the fuse client shutdown sequence is supposed to
be.  If someone kills a program with a large number of open unlinked
files and immediately calls umount(), then the fuse client could be in
the process of sending FUSE_RELEASE requests to the server.

[background info, feel free to speedread this paragraph]
For a non-fuseblk server, unmount aborts all pending requests and
disconnects the fuse device.  This means that the fuse server won't see
all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
with a lot of .fuseXXXXX files that nobody cleans up.

If you make ->destroy release all the remaining open files, now you run
into a second problem, which is that if there are a lot of open unlinked
files, freeing the inodes can collectively take enough time that the
FUSE_DESTROY request times out.

On a fuseblk server with libfuse running in multithreaded mode, there
can be several threads reading fuse requests from the fusedev.  The
kernel actually sends its own FUSE_DESTROY request, but there's no
coordination between the fuse workers, which means that the fuse server
can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
If ->destroy closes the filesystem before the FUSE_RELEASE requests are
processed, you end up with the same .fuseXXXXX file cleanup problem.

Here, if you make a fuseblk server's ->destroy release all the remaining
open files, you have an even worse problem, because that could race with
an existing libfuse worker that's processing a FUSE_RELEASE for the same
open file.

In short, the client has a FUSE_RELEASE request that pairs with the
FUSE_OPEN request.  During regular operations, an OPEN always ends with
a RELEASE.  I don't understand why unmount is special in that it aborts
release requests without even sending them to the server; that sounds
like a bug to me.  Worse yet, I looked on Debian codesearch, and nearly
all of the fuse servers I found do not appear to handle this correctly.
My guess is that it's uncommon to close 100,000 unlinked open files on a
fuse filesystem and immediately unmount it.  Network filesystems can get
away with not caring.

For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open files
have been RELEASEd so that client can know that (a) the filesystem (at
least as far as the kernel cares) is quiesced, and (b) the server
persisted all dirty metadata to disk.  Only then would I send the
FUSE_DESTROY.

> We are already guaranteeing that the
> background requests get sent before we issue the FUSE_DESTROY, so it
> seems to me like this is already enough and we could skip the wait
> because the server should make sure it completes the prior requests
> it's received before it executes the destruction logic.

That's just the thing -- fuse_conn_destroy calls fuse_abort_conn which
aborts all the pending background requests so the server never sees
them.

--D

> Thanks,
> Joanne
> 
> > +}
> > +
> >  /*
> >   * Abort all requests.
> >   *
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index d1babf56f25470..d048d634ef46f5 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -2094,8 +2094,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> >  {
> >         struct fuse_conn *fc = fm->fc;
> >
> > -       if (fc->destroy)
> > +       if (fc->destroy) {
> > +               /*
> > +                * Flush all pending requests (most of which will be
> > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
> > +                * server must close the filesystem before replying to the
> > +                * destroy message, because unmount is about to release its
> > +                * O_EXCL hold on the block device.
> > +                */
> > +               fuse_flush_requests_and_wait(fc);
> >                 fuse_send_destroy(fm);
> > +       }
> >
> >         fuse_abort_conn(fc);
> >         fuse_wait_aborted(fc);
> >

