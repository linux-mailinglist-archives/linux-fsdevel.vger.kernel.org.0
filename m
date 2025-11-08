Return-Path: <linux-fsdevel+bounces-67519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A07C4216B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 01:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AED94E65A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58521F956;
	Sat,  8 Nov 2025 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5DseiMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604CFC1D;
	Sat,  8 Nov 2025 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560176; cv=none; b=dN1zZiNBzFy3QhVjC3Zdi1y6mUFKH68DYzBcs6C7NarkURMseskmXb7AZL/ktgPtEd4FpEGDe5aP3q+i/9L4PrsUI2n0rdkM2m4m9qgIwkTLACnlxrLn5wv7x3XHR4aR6IS+JjzgQWFVWPUttuPvWnxh938fc4DQ3Ztf08tyUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560176; c=relaxed/simple;
	bh=viNt9afbNBdtQqi1Dc1Q/j7+Plf7H/XEwFpGMxTCOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFpXHDFgZdPplsH4C3pcdfLJ/vd5tzPypLzhZ0z6FxplY/FUJcIljJLGeG6hN7FaMaqJFu7xjN1CLedxi1JE6TZJEpQoNQzkFcv0YnacdKuej8vX2JoqguGg3T359nV0nHwiO3eLMX4Uqj4tilxr6Cbi5O0fGxNoA0cUag7+zjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5DseiMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849BFC116C6;
	Sat,  8 Nov 2025 00:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762560175;
	bh=viNt9afbNBdtQqi1Dc1Q/j7+Plf7H/XEwFpGMxTCOlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5DseiMzmvLusOH9gxk8iMToJaHV8GBC57kLneHq2mdC90oGQ9YT+Z9sk8VyBK252
	 iViivnBvYzJTWO/gojQ+2Vgwus0vyaRWdzqIcVV1OdhwBBQUACstwXLYvwwduikoT7
	 EQwD00ty3ghInmqVOFqy8BegCbwOXIx8CqNXXGQWpaQKbdt6aGFMQvIBuSYKQTFJ4d
	 PE0onTIwzmK7m5VrGTZzBY7jx9Ra9KhMbrl7OGmqr9O23zCjdPd5c1qEwXdjQ/QJWb
	 8Mbng12xMCEwm4ERBgO4axkOFW+PYtFpg69/n4fXCoUy2IqwJd9xN17jv5E5MEjQPU
	 bT05F1F21d+Qw==
Date: Fri, 7 Nov 2025 16:02:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251108000254.GK196391@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
 <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>

On Fri, Nov 07, 2025 at 11:03:24PM +0100, Bernd Schubert wrote:
> 
> 
> On 11/7/25 05:26, Darrick J. Wong wrote:
> > [I read this email backwards, like I do]
> > 
> > On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
> >> On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>
> >>> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
> >>>
> >>> <snipping here because this thread has gotten very long>
> >>>
> >>>>>>> +       while (wait_event_timeout(fc->blocked_waitq,
> >>>>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> >>>>>>> +                       HZ) == 0) {
> >>>>>>> +               /* empty */
> >>>>>>> +       }
> >>>>>>
> >>>>>> I'm wondering if it's necessary to wait here for all the pending
> >>>>>> requests to complete or abort?
> >>>>>
> >>>>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
> >>>>> be.  If someone kills a program with a large number of open unlinked
> >>>>> files and immediately calls umount(), then the fuse client could be in
> >>>>> the process of sending FUSE_RELEASE requests to the server.
> >>>>>
> >>>>> [background info, feel free to speedread this paragraph]
> >>>>> For a non-fuseblk server, unmount aborts all pending requests and
> >>>>> disconnects the fuse device.  This means that the fuse server won't see
> >>>>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> >>>>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> >>>>> with a lot of .fuseXXXXX files that nobody cleans up.
> >>>>>
> >>>>> If you make ->destroy release all the remaining open files, now you run
> >>>>> into a second problem, which is that if there are a lot of open unlinked
> >>>>> files, freeing the inodes can collectively take enough time that the
> >>>>> FUSE_DESTROY request times out.
> >>>>>
> >>>>> On a fuseblk server with libfuse running in multithreaded mode, there
> >>>>> can be several threads reading fuse requests from the fusedev.  The
> >>>>> kernel actually sends its own FUSE_DESTROY request, but there's no
> >>>>> coordination between the fuse workers, which means that the fuse server
> >>>>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> >>>>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> >>>>> processed, you end up with the same .fuseXXXXX file cleanup problem.
> >>>>
> >>>> imo it is the responsibility of the server to coordinate this and make
> >>>> sure it has handled all the requests it has received before it starts
> >>>> executing the destruction logic.
> >>>
> >>> I think we're all saying that some sort of fuse request reordering
> >>> barrier is needed here, but there's at least three opinions about where
> >>> that barrier should be implemented.  Clearly I think the barrier should
> >>> be in the kernel, but let me think more about where it could go if it
> >>> were somewhere else.
> >>>
> >>> First, Joanne's suggestion for putting it in the fuse server itself:
> >>>
> >>> I don't see how it's generally possible for the fuse server to know that
> >>> it's processed all the requests that the kernel might have sent it.
> >>> AFAICT each libfuse thread does roughly this:
> >>>
> >>> 1. read() a request from the fusedev fd
> >>> 2. decode the request data and maybe do some allocations or transform it
> >>> 3. call fuse server with request
> >>> 4. fuse server does ... something with the request
> >>> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
> >>>
> >>> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
> >>> out if there are other fuse worker threads that are somewhere in steps
> >>> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
> >>> that are waiting in fuse_session_receive_buf_internal, so fuse servers
> >>> can't ask the library about that either.
> >>>
> >>> Taking a narrower view, it might be possible for the fuse server to
> >>> figure this out by maintaining an open resource count.  It would
> >>> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
> >>> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
> >>> the only kind of request that can be pending when a FUSE_DESTROY comes
> >>> in, then destroy just has to wait for the counter to hit zero.
> >>
> >> I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
> >> if there are X worker threads that are all running fuse_do_work( )
> >> then if you get a FUSE_DESTROY on one of those threads that thread can
> >> set some se->destroyed field. At this point the other threads will
> >> have already called fuse_session_receive_buf_internal() on all the
> >> flushed background requests, so after they process it and return from
> >> fuse_session_process_buf_internal(), then they check if se->destroyed
> >> was set, and if it is they exit the thread, while in the thread that
> >> got the FUSE_DESTROY it sleeps until all the threads have completed
> >> and then it executes the destroy logic.That to me seems like the
> >> cleanest approach.
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
> 
> I will read through the rest (too tired right now) durig the weekend. 
> I was also thinking about counter. And let's please also do this right
> also handling io-uring. I.e. all CQEs needs to have been handled.
> Without io-uring it would be probably a counter in decreased in 
> fuse_free_req(), with io-uring it is a bit more complex.

Oh right, the uring backend.

Assuming that it's really true that the only requests pending during an
unmount are going to be FUSE_RELEASE (nobody's actually said that's
true) then it's *much* easier to count the number of open files in
fuse_session and make _do_destroy in the lowlevel library wait until the
open file count reaches zero.

--D

> Thanks,
> Bernd
> 

