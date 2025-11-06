Return-Path: <linux-fsdevel+bounces-67234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F169C3874E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262A23A42CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B851662E7;
	Thu,  6 Nov 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1A5OGiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8710957;
	Thu,  6 Nov 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388356; cv=none; b=T/2/3wE6JQ3A3EdlZPZ3kWofIOIih2jhSmobT2e1BPFUSOiQUpZQW/P6RgRwxRcN+Cn2nKTAZijN4r+1EtktgU5RJLicQig942kh7Ef+Kt2A66xxDirdorBkjs2FKGHNHqGOXDQFn0Rl6rMgJa7JBugPuY2GHLWiiLvAdNnPVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388356; c=relaxed/simple;
	bh=yuz8cRWpXPaa88jkV7mgefpgHkZ19yoPK0xCS4Ul/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7w+Ptp2P9FIfHRFkhBXSQi2pg0pvvpxrOQhiL1tSIfx/oIZ58AONqdZQ18ZI3GQIbFtFC69jaYpdDLRaxk0cCO8azFPNkbG2pcWOxkIaqb2S3zJTcQTWL4EgEdggURPDk+vRtG+yh3XWzunROASUd5tAtXjmw0yF12UNyrS6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1A5OGiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229EBC4CEF5;
	Thu,  6 Nov 2025 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388355;
	bh=yuz8cRWpXPaa88jkV7mgefpgHkZ19yoPK0xCS4Ul/VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1A5OGiWP68niBI+otgdSkB33I3FvHoFZwPtlQ2+S2ILENyq30G7KJcdjvLPFVrmS
	 9/aan1z5hYSsu4PHxcYDmrM74iZ2ZP7DK0kpKf6MBBqv6EhIOc48qRKj5gL8XpCZFI
	 PHDBZ3dNLnzyAT6IfCfSGgXh2wCJKS+o7NFgaUpcfVWom/c3Ave7gz8SibOfk2EaVz
	 xxKrYZNVH4uUqNwrIIk6LKsvkPA1Dz9u49MnmGxYPNuDxFH4ZqzLAi1D8M6kkcfCWG
	 gd/4Fk4As0CzOl2wlcjffbHt2mVsRyvzf3og4/RfnJhPWirGFPIJz2xvdDOYG3rBKd
	 k3aDV+/PPQyyA==
Date: Wed, 5 Nov 2025 16:19:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251106001914.GI196358@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <a9c0c66e-c3ce-4cdd-bd83-dd04bc5f9379@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c0c66e-c3ce-4cdd-bd83-dd04bc5f9379@bsbernd.com>

On Tue, Nov 04, 2025 at 10:47:52PM +0100, Bernd Schubert wrote:
> 
> 
> On 11/4/25 20:22, Joanne Koong wrote:
> > On Mon, Nov 3, 2025 at 2:13 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >>
> >> On Mon, Nov 03, 2025 at 09:20:26AM -0800, Joanne Koong wrote:
> >>> On Tue, Oct 28, 2025 at 5:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>>
> >>>> From: Darrick J. Wong <djwong@kernel.org>
> >>>>
> >>>> generic/488 fails with fuse2fs in the following fashion:
> >>>>
> >>>> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> >>>> (see /var/tmp/fstests/generic/488.full for details)
> >>>>
> >>>> This test opens a large number of files, unlinks them (which really just
> >>>> renames them to fuse hidden files), closes the program, unmounts the
> >>>> filesystem, and runs fsck to check that there aren't any inconsistencies
> >>>> in the filesystem.
> >>>>
> >>>> Unfortunately, the 488.full file shows that there are a lot of hidden
> >>>> files left over in the filesystem, with incorrect link counts.  Tracing
> >>>> fuse_request_* shows that there are a large number of FUSE_RELEASE
> >>>> commands that are queued up on behalf of the unlinked files at the time
> >>>> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> >>>> aborted, the fuse server would have responded to the RELEASE commands by
> >>>> removing the hidden files; instead they stick around.
> >>>>
> >>>> For upper-level fuse servers that don't use fuseblk mode this isn't a
> >>>> problem because libfuse responds to the connection going down by pruning
> >>>> its inode cache and calling the fuse server's ->release for any open
> >>>> files before calling the server's ->destroy function.
> >>>>
> >>>> For fuseblk servers this is a problem, however, because the kernel sends
> >>>> FUSE_DESTROY to the fuse server, and the fuse server has to close the
> >>>> block device before returning.  This means that the kernel must flush
> >>>> all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.
> >>>>
> >>>> Create a function to push all the background requests to the queue and
> >>>> then wait for the number of pending events to hit zero, and call this
> >>>> before sending FUSE_DESTROY.  That way, all the pending events are
> >>>> processed by the fuse server and we don't end up with a corrupt
> >>>> filesystem.
> >>>>
> >>>> Note that we use a wait_event_timeout() loop to cause the process to
> >>>> schedule at least once per second to avoid a "task blocked" warning:
> >>>>
> >>>> INFO: task umount:1279 blocked for more than 20 seconds.
> >>>>       Not tainted 6.17.0-rc7-xfsx #rc7
> >>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
> >>>> task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690
> >>>>
> >>>> Earlier in the threads about this patch there was a (self-inflicted)
> >>>> dispute as to whether it was necessary to call touch_softlockup_watchdog
> >>>> in the loop body.  Because the process goes to sleep, it's not necessary
> >>>> to touch the softlockup watchdog because we're not preventing another
> >>>> process from being scheduled on a CPU.
> >>>>
> >>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>>> ---
> >>>>  fs/fuse/fuse_i.h |    5 +++++
> >>>>  fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
> >>>>  fs/fuse/inode.c  |   11 ++++++++++-
> >>>>  3 files changed, 50 insertions(+), 1 deletion(-)
> >>>>
> >>>>
> >>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>>> index c2f2a48156d6c5..aaa8574fd72775 100644
> >>>> --- a/fs/fuse/fuse_i.h
> >>>> +++ b/fs/fuse/fuse_i.h
> >>>> @@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
> >>>>  void fuse_abort_conn(struct fuse_conn *fc);
> >>>>  void fuse_wait_aborted(struct fuse_conn *fc);
> >>>>
> >>>> +/**
> >>>> + * Flush all pending requests and wait for them.
> >>>> + */
> >>>> +void fuse_flush_requests_and_wait(struct fuse_conn *fc);
> >>>> +
> >>>>  /* Check if any requests timed out */
> >>>>  void fuse_check_timeout(struct work_struct *work);
> >>>>
> >>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >>>> index 132f38619d7072..ecc0a5304c59d1 100644
> >>>> --- a/fs/fuse/dev.c
> >>>> +++ b/fs/fuse/dev.c
> >>>> @@ -24,6 +24,7 @@
> >>>>  #include <linux/splice.h>
> >>>>  #include <linux/sched.h>
> >>>>  #include <linux/seq_file.h>
> >>>> +#include <linux/nmi.h>
> >>>>
> >>>>  #include "fuse_trace.h"
> >>>>
> >>>> @@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
> >>>>         }
> >>>>  }
> >>>>
> >>>> +/*
> >>>> + * Flush all pending requests and wait for them.  Only call this function when
> >>>> + * it is no longer possible for other threads to add requests.
> >>>> + */
> >>>> +void fuse_flush_requests_and_wait(struct fuse_conn *fc)
> >>>> +{
> >>>> +       spin_lock(&fc->lock);
> >>>
> >>> Do we need to grab the fc lock? fc->connected is protected under the
> >>> bg_lock, afaict from fuse_abort_conn().
> >>
> >> Oh, heh.  Yeah, it does indeed take both fc->lock and fc->bg_lock.
> >> Will fix that, thanks. :)
> >>
> >> FWIW I don't think it's a big deal if we see a stale connected==1 value
> >> because the events will all get cancelled and the wait loop won't run
> >> anyway, but I agree with being consistent about lock ordering. :)
> >>
> >>>> +       if (!fc->connected) {
> >>>> +               spin_unlock(&fc->lock);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       /* Push all the background requests to the queue. */
> >>>> +       spin_lock(&fc->bg_lock);
> >>>> +       fc->blocked = 0;
> >>>> +       fc->max_background = UINT_MAX;
> >>>> +       flush_bg_queue(fc);
> >>>> +       spin_unlock(&fc->bg_lock);
> >>>> +       spin_unlock(&fc->lock);
> >>>> +
> >>>> +       /*
> >>>> +        * Wait for all pending fuse requests to complete or abort.  The fuse
> >>>> +        * server could take a significant amount of time to complete a
> >>>> +        * request, so run this in a loop with a short timeout so that we don't
> >>>> +        * trip the soft lockup detector.
> >>>> +        */
> >>>> +       smp_mb();
> >>>> +       while (wait_event_timeout(fc->blocked_waitq,
> >>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> >>>> +                       HZ) == 0) {
> >>>> +               /* empty */
> >>>> +       }
> >>>
> >>> I'm wondering if it's necessary to wait here for all the pending
> >>> requests to complete or abort?
> >>
> >> I'm not 100% sure what the fuse client shutdown sequence is supposed to
> >> be.  If someone kills a program with a large number of open unlinked
> >> files and immediately calls umount(), then the fuse client could be in
> >> the process of sending FUSE_RELEASE requests to the server.
> >>
> >> [background info, feel free to speedread this paragraph]
> >> For a non-fuseblk server, unmount aborts all pending requests and
> >> disconnects the fuse device.  This means that the fuse server won't see
> >> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> >> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> >> with a lot of .fuseXXXXX files that nobody cleans up.
> >>
> >> If you make ->destroy release all the remaining open files, now you run
> >> into a second problem, which is that if there are a lot of open unlinked
> >> files, freeing the inodes can collectively take enough time that the
> >> FUSE_DESTROY request times out.
> >>
> >> On a fuseblk server with libfuse running in multithreaded mode, there
> >> can be several threads reading fuse requests from the fusedev.  The
> >> kernel actually sends its own FUSE_DESTROY request, but there's no
> >> coordination between the fuse workers, which means that the fuse server
> >> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> >> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> >> processed, you end up with the same .fuseXXXXX file cleanup problem.
> > 
> > imo it is the responsibility of the server to coordinate this and make
> > sure it has handled all the requests it has received before it starts
> > executing the destruction logic. imo the only responsibility of the
> > kernel is to actually send the background requests before it sends the
> > FUSE_DESTROY. I think non-fuseblk servers should also receive the
> > FUSE_DESTROY request.
> 
> Hmm, good idea, I guess we can add that in libfuse, maybe with some kind
> of timeout.
> 
> There is something I don't understand though, how can FUSE_DESTROY
> happen before FUSE_RELEASE is completed?
> 
> ->release / fuse_release
>    fuse_release_common
>       fuse_file_release
>          fuse_file_put
>             fuse_simple_background
>             <userspace>
>             <userspace-reply>
>                fuse_release_end
>                   iput()
> 
> I.e. how can it release the superblock (which triggers FUSE_DESTROY)

The short answer is that fuse_file_put doesn't wait for the backgrounded
release request to complete and returns; and that FUSE_DESTROY is sent
synchronously and with args->force = true so it jumps the queue.

(See my longer reply to Joanne for more details)

--D

> 
> Thanks,
> Bernd
> 

