Return-Path: <linux-fsdevel+bounces-67233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE80C3874B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814DD3B6A93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B8165F16;
	Thu,  6 Nov 2025 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjNNPcee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF411713;
	Thu,  6 Nov 2025 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388254; cv=none; b=BxLSvXlb7lWCcIKh8TGsyXDX8K3CnUd4ZY3n3oSAKzViYt7WIwFxIazQkE9ktZVSMZ8Zv3qELnaScXoLSUPqf2HtWo09tFQ9ggeaz+uUj4eDwcRnucZ6hOfglPOIPT2qi/Fb/VO4EodMjUrBN+ECCEI1D4SIgPD9bvovR27JnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388254; c=relaxed/simple;
	bh=z+0WNLafzEhsawWz9EmffLIKgyRs/HlNE250VKoZpJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+1cHStI6YZZicJXYXnQquSYF9yUK51nch+eUKce0P9CF11QnVvjbpHgAxlQvvReFPeEM2rm+z2bGZltDH6AvdKLCid7Mid/Nf9Sq7x1vHVSVLq0jxuRG3QVYSSVa/boDhl7wXuh01aV2MnlwoAe/8pEnUBbi2oogasDFCzrXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjNNPcee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EB3C4CEF5;
	Thu,  6 Nov 2025 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388251;
	bh=z+0WNLafzEhsawWz9EmffLIKgyRs/HlNE250VKoZpJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjNNPceeJugjOdMMoWYRyp3MIphBoXCLQojoJPNLBw2Xj8OykwF+H3RrDv4W4MuOI
	 pB7olNvb1H5Vo+fNpEYqb7nNoU6Q8CHh/ZeyTD/MjOzQrkhX1K/0gBR23LR0EaeN5c
	 qcIT1YO1kSCIX1Fm0j3QYqkrGHMIhGZAIOwWiSdRBtD+o02aRshhPH2ZBkbFUHY5n8
	 Cz0WAP0a8Xva1EIqgizsnyxAoDp3rFvoLbqvKq+A+9c5Xny17xjQCowTAgm4IEfoQf
	 ifb1skmObPKAXQG1iObihMUFm31aqFAoE3OUU+8Mh3Xws+tVUEz4VhKCHqHgDFalT0
	 gly5+bdRPUe/Q==
Date: Wed, 5 Nov 2025 16:17:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251106001730.GH196358@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>

On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:

<snipping here because this thread has gotten very long>

> > > > +       while (wait_event_timeout(fc->blocked_waitq,
> > > > +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> > > > +                       HZ) == 0) {
> > > > +               /* empty */
> > > > +       }
> > >
> > > I'm wondering if it's necessary to wait here for all the pending
> > > requests to complete or abort?
> >
> > I'm not 100% sure what the fuse client shutdown sequence is supposed to
> > be.  If someone kills a program with a large number of open unlinked
> > files and immediately calls umount(), then the fuse client could be in
> > the process of sending FUSE_RELEASE requests to the server.
> >
> > [background info, feel free to speedread this paragraph]
> > For a non-fuseblk server, unmount aborts all pending requests and
> > disconnects the fuse device.  This means that the fuse server won't see
> > all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> > fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> > with a lot of .fuseXXXXX files that nobody cleans up.
> >
> > If you make ->destroy release all the remaining open files, now you run
> > into a second problem, which is that if there are a lot of open unlinked
> > files, freeing the inodes can collectively take enough time that the
> > FUSE_DESTROY request times out.
> >
> > On a fuseblk server with libfuse running in multithreaded mode, there
> > can be several threads reading fuse requests from the fusedev.  The
> > kernel actually sends its own FUSE_DESTROY request, but there's no
> > coordination between the fuse workers, which means that the fuse server
> > can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> > If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> > processed, you end up with the same .fuseXXXXX file cleanup problem.
> 
> imo it is the responsibility of the server to coordinate this and make
> sure it has handled all the requests it has received before it starts
> executing the destruction logic.

I think we're all saying that some sort of fuse request reordering
barrier is needed here, but there's at least three opinions about where
that barrier should be implemented.  Clearly I think the barrier should
be in the kernel, but let me think more about where it could go if it
were somewhere else.

First, Joanne's suggestion for putting it in the fuse server itself:

I don't see how it's generally possible for the fuse server to know that
it's processed all the requests that the kernel might have sent it.
AFAICT each libfuse thread does roughly this:

1. read() a request from the fusedev fd
2. decode the request data and maybe do some allocations or transform it
3. call fuse server with request
4. fuse server does ... something with the request
5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX

Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
out if there are other fuse worker threads that are somewhere in steps
2 or 3?  AFAICT the library doesn't keep track of the number of threads
that are waiting in fuse_session_receive_buf_internal, so fuse servers
can't ask the library about that either.

Taking a narrower view, it might be possible for the fuse server to
figure this out by maintaining an open resource count.  It would
increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
the only kind of request that can be pending when a FUSE_DESTROY comes
in, then destroy just has to wait for the counter to hit zero.

Is the above assumption correct?

I don't see any fuse servers that actually *do* this, though.  I
perceive that there are a lot of fuse servers out there that aren't
packaged in Debian, though, so is this actually a common thing for
proprietary fuse servers which I wouldn't know about?

Downthread, Bernd suggested doing this in libfuse instead of making the
fuse servers do it.  He asks:

"There is something I don't understand though, how can FUSE_DESTROY
happen before FUSE_RELEASE is completed?

"->release / fuse_release
   fuse_release_common
      fuse_file_release
         fuse_file_put
            fuse_simple_background
            <userspace>
            <userspace-reply>
               fuse_release_end
                  iput()"

The answer to this is: fuse_file_release is always asynchronous now, so
the FUSE_RELEASE is queued to the background and the kernel moves on
with its life.

It's likely much more effective to put the reordering barrier in the
library (ignoring all the vendored libfuse out there) assuming that the
above assumption holds.  I think it wouldn't be hard to have _do_open
(fuse_lowlevel.c) increment a counter in fuse_session, decrement it in
_do_release, and then _do_destroy would wait for it to hit zero.

For a single-threaded fuse server I think this might not even be an
issue because the events are (AFAICT) processed in order.  However,
you'd have to be careful about how you did that for a multithreaded fuse
server.  You wouldn't want to spin in _do_destroy because that takes out
a thread that could be doing work.  Is there a way to park a request?

Note that both of these approaches come with the risk that the kernel
could decide to time out and abort the FUSE_DESTROY while the server is
still waiting for the counter to hit zero.

For a fuseblk filesystem this abort is very dangerous because the kernel
releases its O_EXCL hold on the block device in kill_block_super before
the fuse server has a chance to finish up and close the block device.
The fuseblk server itself could not have opened the block device O_EXCL
so that means there's a period where another process (or even another
fuseblk mount) could open the bdev O_EXCL and both try to write to the
block device.

(I actually have been wondering who uses the fuse request timeouts?  In
my testing even 30min wasn't sufficient to avoid aborts for some of the
truncate/inactivation fstests.)

Aside: The reason why I abandoned making fuse2fs a fuseblk server is
because I realized this exact trap -- the fuse server MUST have
exclusive write access to the device at all times, or else it can race
with other programs (e.g. tune2fs) and corrupt the filesystem.  In
fuseblk mode the kernel owns the exclusive access and but doesn't
install that file in the server's fd table.  At best the fuse server can
pretend that it has exclusive write access, but the kernel can make that
go away without telling the fuse server, which opens a world of hurt.

> imo the only responsibility of the
> kernel is to actually send the background requests before it sends the
> FUSE_DESTROY. I think non-fuseblk servers should also receive the
> FUSE_DESTROY request.

They do receive it because fuse_session_destroy calls ->destroy if no
event has been received from the kernel after the fusedev shuts down.

> >
> > Here, if you make a fuseblk server's ->destroy release all the remaining
> > open files, you have an even worse problem, because that could race with
> > an existing libfuse worker that's processing a FUSE_RELEASE for the same
> > open file.
> >
> > In short, the client has a FUSE_RELEASE request that pairs with the
> > FUSE_OPEN request.  During regular operations, an OPEN always ends with
> > a RELEASE.  I don't understand why unmount is special in that it aborts
> > release requests without even sending them to the server; that sounds
> > like a bug to me.  Worse yet, I looked on Debian codesearch, and nearly
> > all of the fuse servers I found do not appear to handle this correctly.
> > My guess is that it's uncommon to close 100,000 unlinked open files on a
> > fuse filesystem and immediately unmount it.  Network filesystems can get
> > away with not caring.
> >
> > For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open files
> > have been RELEASEd so that client can know that (a) the filesystem (at
> > least as far as the kernel cares) is quiesced, and (b) the server
> > persisted all dirty metadata to disk.  Only then would I send the
> > FUSE_DESTROY.
> 
> Hmm, is FUSE_FLUSH not enough? As I recently learned (from Amir),
> every close() triggers a FUSE_FLUSH. For dirty metadata related to
> writeback, every release triggers a synchronous write_inode_now().

It's not sufficient, because there might be other cached dirty metadata
that needs to be flushed out to disk.  A fuse server could respond to a
FUSE_FLUSH by pushing out that inode's dirty metadata to disk but go no
farther.  Plumbing in FUSE_SYNCFS for iomap helps a lot in that regard
because that's a signal that we need to push dirty ext4 bitmaps and
group descriptors and whatnot out to storage; without it we end up doing
all that at destroy time.

> > > We are already guaranteeing that the
> > > background requests get sent before we issue the FUSE_DESTROY, so it
> > > seems to me like this is already enough and we could skip the wait
> > > because the server should make sure it completes the prior requests
> > > it's received before it executes the destruction logic.
> >
> > That's just the thing -- fuse_conn_destroy calls fuse_abort_conn which
> > aborts all the pending background requests so the server never sees
> > them.
> 
> The FUSE_DESTROY request gets sent before fuse_abort_conn() is called,
> so to me, it seems like if we flush all the background requests and
> then send the FUSE_DESTROY, that suffices.

I think it's worse than that -- fuse_send_destroy sets fuse_args::force
and sends the request synchronously, which (afaict) means it jumps ahead
of the backgrounded requests.

> With the "while (wait_event_timeout(fc->blocked_waitq, !fc->connected
> || atomic_read(&fc->num_waiting) == 0...)" logic, I think this also
> now means if a server is tripped up somewhere (eg if a remote network
> connection is lost or it runs into a deadlock when servicing a
> request) where it's unable to fulfill any one of its previous
> requests, unmounting would hang.

Well yeah, I was only going to use this function for "local" filesystems
like fuseblk and iomap servers.  Definitely not for network fses!

(Though really, all local storage is network storage...)

--D

> Thanks,
> Joanne
> 
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> > > > +}
> > > > +
> > > >  /*
> > > >   * Abort all requests.
> > > >   *
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index d1babf56f25470..d048d634ef46f5 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -2094,8 +2094,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> > > >  {
> > > >         struct fuse_conn *fc = fm->fc;
> > > >
> > > > -       if (fc->destroy)
> > > > +       if (fc->destroy) {
> > > > +               /*
> > > > +                * Flush all pending requests (most of which will be
> > > > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because the fuse
> > > > +                * server must close the filesystem before replying to the
> > > > +                * destroy message, because unmount is about to release its
> > > > +                * O_EXCL hold on the block device.
> > > > +                */
> > > > +               fuse_flush_requests_and_wait(fc);
> > > >                 fuse_send_destroy(fm);
> > > > +       }
> > > >
> > > >         fuse_abort_conn(fc);
> > > >         fuse_wait_aborted(fc);
> > > >
> 

