Return-Path: <linux-fsdevel+bounces-67523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49155C42247
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05B474EDA04
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF3283C83;
	Sat,  8 Nov 2025 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDhdLF1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD591FBC8E;
	Sat,  8 Nov 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562584; cv=none; b=S4sDUfNqE3yxPqRi+gylOTDA++bNh/yroyjGCOzl31QmZ/AcDabsWoKr8B+L5eMbcAdKPFMgw5LoYmZUe1QrYK55q+E/mJgZPdmNR5CqplUdPn4xL2KDxC7LDep/hUmXm7ubd0Hj8syTk8JXvWGQzG3sqZT1/ZtHUzCrJK6oiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562584; c=relaxed/simple;
	bh=ulHpxB9JZKh9cp1iDm6npE/+i3YrZm82kKD4/C8mFTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZhGR/VUbcmwa1dLIJVXT9pE98f8Yv3Py+7QGhv5qS1OSu5DZOh9zqaNXC5y2YNOq3eoGn7EtoygOTsBQiH5MgtNZq0UjYlQkw9a+c53zmuScmOAJmyRsx7U1aZk80jms/ZSG92LdwTa5QHsMCOmFf0uYW15PkDrsDOg+LUWeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDhdLF1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5BAC4CEF5;
	Sat,  8 Nov 2025 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762562584;
	bh=ulHpxB9JZKh9cp1iDm6npE/+i3YrZm82kKD4/C8mFTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDhdLF1Sa9cNp5b+Nh0KdBNmd685Vk9yu0VZkieyl+bt5Hro8PEREAuBPBhw5b3nL
	 bZ7S+qRSMy2POnPqVHYDNjdAgEzJAh1sVMe8TcuSecKO8rwIy8eNQrhji4ji9p8Sth
	 76oiOZibdkDAgHoKy+BFZJ+IJAjR6aHEdOoZJdtJxVWY0DA1keUNLerJVffp9PSd0m
	 0VFPX5qfGVXC/fNOKcPOTJtRwUKB9NOh7xW9INlbpmaxMXpeD4TKA/gMN3TpfeYOKK
	 v48huhF2pv0R5iRjVhlAoUpvJ/R4BxQkRpLDz6WtHdAO04f7BWzncraU6o5U8mRCQK
	 JHY8v4kLWJ55g==
Date: Fri, 7 Nov 2025 16:43:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251108004303.GX196362@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
 <CAJnrk1Yqy5t5U3Y3VHgdtTTaK7NRkDu0UBy4zGEnq=tvXEhoiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yqy5t5U3Y3VHgdtTTaK7NRkDu0UBy4zGEnq=tvXEhoiQ@mail.gmail.com>

On Fri, Nov 07, 2025 at 11:18:33AM -0800, Joanne Koong wrote:
> On Thu, Nov 6, 2025 at 8:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > [I read this email backwards, like I do]
> >
> > On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
> > > On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
> > > >
> > > > <snipping here because this thread has gotten very long>
> > > >
> > > > > > > > +       while (wait_event_timeout(fc->blocked_waitq,
> > > > > > > > +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> > > > > > > > +                       HZ) == 0) {
> > > > > > > > +               /* empty */
> > > > > > > > +       }
> > > > > > >
> > > > > > > I'm wondering if it's necessary to wait here for all the pending
> > > > > > > requests to complete or abort?
> > > > > >
> > > > > > I'm not 100% sure what the fuse client shutdown sequence is supposed to
> > > > > > be.  If someone kills a program with a large number of open unlinked
> > > > > > files and immediately calls umount(), then the fuse client could be in
> > > > > > the process of sending FUSE_RELEASE requests to the server.
> > > > > >
> > > > > > [background info, feel free to speedread this paragraph]
> > > > > > For a non-fuseblk server, unmount aborts all pending requests and
> > > > > > disconnects the fuse device.  This means that the fuse server won't see
> > > > > > all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> > > > > > fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> > > > > > with a lot of .fuseXXXXX files that nobody cleans up.
> > > > > >
> > > > > > If you make ->destroy release all the remaining open files, now you run
> > > > > > into a second problem, which is that if there are a lot of open unlinked
> > > > > > files, freeing the inodes can collectively take enough time that the
> > > > > > FUSE_DESTROY request times out.
> > > > > >
> > > > > > On a fuseblk server with libfuse running in multithreaded mode, there
> > > > > > can be several threads reading fuse requests from the fusedev.  The
> > > > > > kernel actually sends its own FUSE_DESTROY request, but there's no
> > > > > > coordination between the fuse workers, which means that the fuse server
> > > > > > can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> > > > > > If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> > > > > > processed, you end up with the same .fuseXXXXX file cleanup problem.
> > > > >
> > > > > imo it is the responsibility of the server to coordinate this and make
> > > > > sure it has handled all the requests it has received before it starts
> > > > > executing the destruction logic.
> > > >
> > > > I think we're all saying that some sort of fuse request reordering
> > > > barrier is needed here, but there's at least three opinions about where
> > > > that barrier should be implemented.  Clearly I think the barrier should
> > > > be in the kernel, but let me think more about where it could go if it
> > > > were somewhere else.
> > > >
> > > > First, Joanne's suggestion for putting it in the fuse server itself:
> > > >
> > > > I don't see how it's generally possible for the fuse server to know that
> > > > it's processed all the requests that the kernel might have sent it.
> > > > AFAICT each libfuse thread does roughly this:
> > > >
> > > > 1. read() a request from the fusedev fd
> > > > 2. decode the request data and maybe do some allocations or transform it
> > > > 3. call fuse server with request
> > > > 4. fuse server does ... something with the request
> > > > 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
> > > >
> > > > Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
> > > > out if there are other fuse worker threads that are somewhere in steps
> > > > 2 or 3?  AFAICT the library doesn't keep track of the number of threads
> > > > that are waiting in fuse_session_receive_buf_internal, so fuse servers
> > > > can't ask the library about that either.
> > > >
> > > > Taking a narrower view, it might be possible for the fuse server to
> > > > figure this out by maintaining an open resource count.  It would
> > > > increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
> > > > decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
> > > > the only kind of request that can be pending when a FUSE_DESTROY comes
> > > > in, then destroy just has to wait for the counter to hit zero.
> > >
> > > I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
> > > if there are X worker threads that are all running fuse_do_work( )
> > > then if you get a FUSE_DESTROY on one of those threads that thread can
> > > set some se->destroyed field. At this point the other threads will
> > > have already called fuse_session_receive_buf_internal() on all the
> > > flushed background requests, so after they process it and return from
> > > fuse_session_process_buf_internal(), then they check if se->destroyed
> > > was set, and if it is they exit the thread, while in the thread that
> > > got the FUSE_DESTROY it sleeps until all the threads have completed
> > > and then it executes the destroy logic.That to me seems like the
> > > cleanest approach.
> >
> > Hrm.  Well now (scrolling to the bottom and back) that I know that the
> > FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
> > think that /could/ work.
> >
> > One tricky thing with having worker threads check a flag and exit is
> > that they can be sleeping in the kernel (from _fuse_session_receive_buf)
> > when the "just go away" flag gets set.  If the thread never wakes up,
> > then it'll never exit.  In theory you could have the FUSE_DESTROY thread
> > call pthread_cancel on all the other worker threads to eliminate them
> > once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
> > nightmares from adventures in pthread_cancel at Sun in 2002. :P
> >
> > Maybe an easier approach would be to have fuse_do_work increment a
> > counter when it receives a buffer and decrement it when it finishes with
> > that buffer.  The FUSE_DESTROY thread merely has to wait for that
> > counter to reach 1, at which point it's the only thread with a request
> > to process, so it can call do_destroy.  That at least would avoid adding
> > a new user of pthread_cancel() into the mt loop code.
> >
> > > >
> > > > Is the above assumption correct?
> > > >
> > > > I don't see any fuse servers that actually *do* this, though.  I
> > > > perceive that there are a lot of fuse servers out there that aren't
> > > > packaged in Debian, though, so is this actually a common thing for
> > > > proprietary fuse servers which I wouldn't know about?
> > > >
> > > > Downthread, Bernd suggested doing this in libfuse instead of making the
> > > > fuse servers do it.  He asks:
> > > >
> > > > "There is something I don't understand though, how can FUSE_DESTROY
> > > > happen before FUSE_RELEASE is completed?
> > > >
> > > > "->release / fuse_release
> > > >    fuse_release_common
> > > >       fuse_file_release
> > > >          fuse_file_put
> > > >             fuse_simple_background
> > > >             <userspace>
> > > >             <userspace-reply>
> > > >                fuse_release_end
> > > >                   iput()"
> > > >
> > > > The answer to this is: fuse_file_release is always asynchronous now, so
> > > > the FUSE_RELEASE is queued to the background and the kernel moves on
> > > > with its life.
> > > >
> > > > It's likely much more effective to put the reordering barrier in the
> > > > library (ignoring all the vendored libfuse out there) assuming that the
> > > > above assumption holds.  I think it wouldn't be hard to have _do_open
> > > > (fuse_lowlevel.c) increment a counter in fuse_session, decrement it in
> > > > _do_release, and then _do_destroy would wait for it to hit zero.
> > > >
> > > > For a single-threaded fuse server I think this might not even be an
> > > > issue because the events are (AFAICT) processed in order.  However,
> > > > you'd have to be careful about how you did that for a multithreaded fuse
> > > > server.  You wouldn't want to spin in _do_destroy because that takes out
> > > > a thread that could be doing work.  Is there a way to park a request?
> > >
> > > If the background requests are flushed before the destroy request,
> > > then this doesn't take out a thread because al the background requests
> > > will already have been or are being serviced.
> >
> > <nod>
> >
> > I'm still concerned about a few things with the libfuse approach though.
> > The kernel is the initiator, so it knows the data dependencies between
> > requests.  Consequently, it's in the best position to know that if
> > request R2 depends on R1, then it shouldn't issue R2 until it has
> > received an acknowledgement for R1.  The fuse server is the target, it
> > shouldn't be second-guessing what the initiator wants.
> >
> > The second concern is that if a request timeout is in effect, then all
> > the time that libfuse spends waiting for other request to drain is
> > charged to that request.  IOWs, if the timeout is 60s and libfuse holds
> > the FUSE_DESTROY for 40s, the fuse server only has 20s to reply to the
> > request whereas the sysadmin might have assumed that the server would
> > have a full 60s to flush the filesystem and exit.
> >
> > If you're worried about no-timeout fuse servers hanging the unmount
> > process, what about killing the fuse server?  Or telling the kernel to
> > abort the connection?  Either should suffice to kill the wait_event
> > loop.
> >
> > The third thing is that the iomap patchset will change the unmount
> > request sequence:
> >
> > 1. <some number of FUSE_RELEASEs>
> > 2. FUSE_SYNCFS to tell the fuse server to write all its dirty data
> > 3. FUSE_DESTROY to close the filesystem
> 
> imo it's the responsibility of FUSE_DESTROY to write out any lingering
> dirty data before tearing down state and there shouldn't need to be an
> extra FUSE_SYNCFS issued before the destroy.
> 
> >
> > If we put the ordering barrier in libfuse, then we'll have to modify
> > libfuse to flush all of (1) before processing (2), and then wait for (2)
> > to finish before processing (3).  But libfuse doesn't know that a
> > particular FUSE_SYNCFS will be succeeded by a FUSE_DESTROY.  I could
> > drop the SYNCFS and let DESTROY handle all the flushing.  But again, the
> > kernel already knows the ordering that it requires, so it should enforce
> > that ordering directly.
> >
> > (Sorry, I feel like I'm belaboring the point excessively, I'll stop)
> >
> > The libfuse approach /does/ have the small advantage that it can start
> > working on the FUSE_DESTROY as soon as the other workers quiesce because
> > it doesn't have to wait for the kernel to see the last FUSE_RELEASE
> > reply and generate the DESTROY request.
> 
> imo the main advantage is that handling this in userspace offers
> servers a lot more flexibility for controlling unmount/destroy
> behavior. If we have this logic in the kernel, we're guaranteeing that
> all previous requests must be completed (no matter how long they take)
> before the server sees FUSE_DESTROY. For example if some servers in
> the future want to prioritize fast unmounts over having lingering
> unlinked files, then this allows for that. Or if the server wants to
> write out data while RELEASE is happening, they can do that too
> instead of having to wait for the RELEASE to finish.
> 
> I'm not sure if we even really do need to wait for RELEASE to finish
> before replying back to the DESTROY request. For unlinking files and
> writing data out to storage for example, can't you do all of that
> still even after replying back to the DESTROY request? The connection
> will be aborted but that seems fine, that just means the client can't
> communicate with the server. This would let the unmount finish quickly
> while meanwhile the server logic can run still even after the unmount
> / connection abort, and the server could then do/finish all the
> unlinking logic / writing to storage. Then when all of that is
> finished, the server could officially clean everything up and exit.

No, because fuseblk and fuse-iomap servers MUST close the block devices
before the umount(2) call returns so that an immediate mount(8) doesn't
fail because the block device is still open O_EXCL.  This is a
fundamental behavior of all local filesystems because O_EXCL is the
*only* mechanism that prevents two separate mounts of the same device,
and mount(2) fails immediately if it can't open a block device O_EXCL.

fstests and many other scripts rely on the behavior that the block
device is always free when umount returns.  I know it's tempting to make
regular unmount return ASAP even if the filesystem isn't quite done, but
that's what umount -l is for.

--D

> > > > For a fuseblk filesystem this abort is very dangerous because the kernel
> > > > releases its O_EXCL hold on the block device in kill_block_super before
> > > > the fuse server has a chance to finish up and close the block device.
> > > > The fuseblk server itself could not have opened the block device O_EXCL
> > > > so that means there's a period where another process (or even another
> > > > fuseblk mount) could open the bdev O_EXCL and both try to write to the
> > > > block device.
> > > >
> > > > (I actually have been wondering who uses the fuse request timeouts?  In
> > > > my testing even 30min wasn't sufficient to avoid aborts for some of the
> > > > truncate/inactivation fstests.)
> > >
> > > Meta uses fuse request timeouts. We saw a few cases of deadlocks in
> > > some buggy fuse server implementations, so we now enforce default
> > > timeouts. The timeout is set to a pretty large number though. Our main
> > > use of it is to free/cleanup system resources if the server is
> > > deadlocked.
> >
> > If you can share, how long of a timeout?  I've noticed that some clouds
> > set their iscsi timeouts to 12h or more(!) and that's for a single SCSI
> > command.
> 
> Right now the default is 30 minutes.
> 
> Thanks,
> Joanne
> 
> >
> > > If it takes 30 minutes to do all the cleanup, then I think it's worse
> > > to have unmounting take that long, than to just do a quicker unmount
> >
> > If you don't handle unlinked lists in a O(n) (or O(1) way) then
> > unprivileged userspace programs can manipulate the filesystem so that it
> > actually /can/ take hours to unmount.  XFS, ext4, and now fuse4fs have
> > learned that the hard way. ;)
> >
> > > and have lingering unlinked files on the server. As a user, if I were
> > > unmounting something and it took that long, I would probably just kill
> > > the whole thing anyways.
> >
> > That very much depends on what you're going to do with that filesystem.
> > If you're disposing of a container then, meh, fire away.  Some people
> > "use" FS_IOC_SHUTDOWN to "terminate" containers quickly.
> >
> > > >
> > > > Aside: The reason why I abandoned making fuse2fs a fuseblk server is
> > > > because I realized this exact trap -- the fuse server MUST have
> > > > exclusive write access to the device at all times, or else it can race
> > > > with other programs (e.g. tune2fs) and corrupt the filesystem.  In
> > > > fuseblk mode the kernel owns the exclusive access and but doesn't
> > > > install that file in the server's fd table.  At best the fuse server can
> > > > pretend that it has exclusive write access, but the kernel can make that
> > > > go away without telling the fuse server, which opens a world of hurt.
> > > >
> > > > > imo the only responsibility of the
> > > > > kernel is to actually send the background requests before it sends the
> > > > > FUSE_DESTROY. I think non-fuseblk servers should also receive the
> > > > > FUSE_DESTROY request.
> > > >
> > > > They do receive it because fuse_session_destroy calls ->destroy if no
> > > > event has been received from the kernel after the fusedev shuts down.
> > > >
> > > > > >
> > > > > > Here, if you make a fuseblk server's ->destroy release all the remaining
> > > > > > open files, you have an even worse problem, because that could race with
> > > > > > an existing libfuse worker that's processing a FUSE_RELEASE for the same
> > > > > > open file.
> > > > > >
> > > > > > In short, the client has a FUSE_RELEASE request that pairs with the
> > > > > > FUSE_OPEN request.  During regular operations, an OPEN always ends with
> > > > > > a RELEASE.  I don't understand why unmount is special in that it aborts
> > > > > > release requests without even sending them to the server; that sounds
> > > > > > like a bug to me.  Worse yet, I looked on Debian codesearch, and nearly
> > > > > > all of the fuse servers I found do not appear to handle this correctly.
> > > > > > My guess is that it's uncommon to close 100,000 unlinked open files on a
> > > > > > fuse filesystem and immediately unmount it.  Network filesystems can get
> > > > > > away with not caring.
> > > > > >
> > > > > > For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open files
> > > > > > have been RELEASEd so that client can know that (a) the filesystem (at
> > > > > > least as far as the kernel cares) is quiesced, and (b) the server
> > > > > > persisted all dirty metadata to disk.  Only then would I send the
> > > > > > FUSE_DESTROY.
> > > > >
> > > > > Hmm, is FUSE_FLUSH not enough? As I recently learned (from Amir),
> > > > > every close() triggers a FUSE_FLUSH. For dirty metadata related to
> > > > > writeback, every release triggers a synchronous write_inode_now().
> > > >
> > > > It's not sufficient, because there might be other cached dirty metadata
> > > > that needs to be flushed out to disk.  A fuse server could respond to a
> > > > FUSE_FLUSH by pushing out that inode's dirty metadata to disk but go no
> > > > farther.  Plumbing in FUSE_SYNCFS for iomap helps a lot in that regard
> > > > because that's a signal that we need to push dirty ext4 bitmaps and
> > > > group descriptors and whatnot out to storage; without it we end up doing
> > > > all that at destroy time.
> > > >
> > > > > > > We are already guaranteeing that the
> > > > > > > background requests get sent before we issue the FUSE_DESTROY, so it
> > > > > > > seems to me like this is already enough and we could skip the wait
> > > > > > > because the server should make sure it completes the prior requests
> > > > > > > it's received before it executes the destruction logic.
> > > > > >
> > > > > > That's just the thing -- fuse_conn_destroy calls fuse_abort_conn which
> > > > > > aborts all the pending background requests so the server never sees
> > > > > > them.
> > > > >
> > > > > The FUSE_DESTROY request gets sent before fuse_abort_conn() is called,
> > > > > so to me, it seems like if we flush all the background requests and
> > > > > then send the FUSE_DESTROY, that suffices.
> > > >
> > > > I think it's worse than that -- fuse_send_destroy sets fuse_args::force
> > > > and sends the request synchronously, which (afaict) means it jumps ahead
> > > > of the backgrounded requests.
> > >
> > > Hmm, where are you seeing that? afaict, args->force forces the request
> > > to be sent to userspace even if interrupted and it skips the
> > > fuse_block_alloc() check.
> >
> > Oh!  You're right, the FUSE_DESTROY request is list_add_tail'd to
> > fiq->pending, just like every other req, because they all go through
> > fuse_dev_queue_req.  Sorry about misreading that, but thank /you/ for
> > pointing it out! :)
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > >
> 

