Return-Path: <linux-fsdevel+bounces-55893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA7B0F959
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FA81887004
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C83222580;
	Wed, 23 Jul 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsB9DE6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E01F8F04
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292066; cv=none; b=S4o6lNKqNJvv+mwm58hg0BGmOAFBf8+z0ohQFkNlWQcF7lJaa1sV3+OT6c6yGFjg5MFUGou60rQ2WtMlDMX0/HXjw/JR6lZccC4JGy2md1zn76joO4bQciFWF2xkYXGu1br7wiaXLga5g1+k5l+sM//RU4iJJd+TLmyeSHEgFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292066; c=relaxed/simple;
	bh=0ImF+3Z4FolYbMhgf5rqIwCvWT0C91FEI+OPXH+Ntio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0ZZ7UvkbsXhEfzX635sO00dJteRzbIWc2Z49nxjNF9Z5PNbP3BjIz+BIah6zjZnJ0UGXFjV6dA8UQy7pIikXycazRASp+8w6T8mP90ulRRfwla4a274NoN2dcDJRjXVfdnOC9eYjeNS1lFosmWcaq0ZAkLZZ14f2OOVy79j7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsB9DE6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE48C4CEE7;
	Wed, 23 Jul 2025 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753292066;
	bh=0ImF+3Z4FolYbMhgf5rqIwCvWT0C91FEI+OPXH+Ntio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsB9DE6yJ+HUAsyZFOU4pEQlrYu3j8Qag/aEAo19jAj5zqQ6pbyjaW6nl4hPiTKaD
	 Ailfj/XCDQ4fRhD/m764sFmFcXHyNrWAWF3R2GqzVPvtvaBUD3xYLYT8h8wLtwELIR
	 BGN8nU+I08+jkLPqfeiyed5cBOxe8KPEoao7/0Z+XqfPrlVKG1ECUqPqiki4jsecAg
	 1N8Y6MQIrLbTECGonXGHSTOTVkhtmh7qkPe6Aal2nEUpQLln7wjtWNVspJdRSYoEqE
	 1wa3cYTKrMyn7u6YPFjsMCcwdtcD4697KpHNjUagf0GGcOEgVtgt/WYPWRl0rapndD
	 fzKCz7aTT5Ibw==
Date: Wed, 23 Jul 2025 10:34:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250723173425.GX2672070@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <20250719003215.GG2672029@frogsfrogsfrogs>
 <CAJnrk1YvGrgJK6qd0UPMzNUxyJ6QwY2b-HRhsj5QVrHsLxuQmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YvGrgJK6qd0UPMzNUxyJ6QwY2b-HRhsj5QVrHsLxuQmQ@mail.gmail.com>

On Mon, Jul 21, 2025 at 01:32:43PM -0700, Joanne Koong wrote:
> On Fri, Jul 18, 2025 at 5:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > > On Thu, Jul 17, 2025 at 4:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > generic/488 fails with fuse2fs in the following fashion:
> > > >
> > > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> > > > (see /var/tmp/fstests/generic/488.full for details)
> > > >
> > > > This test opens a large number of files, unlinks them (which really just
> > > > renames them to fuse hidden files), closes the program, unmounts the
> > > > filesystem, and runs fsck to check that there aren't any inconsistencies
> > > > in the filesystem.
> > > >
> > > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > > files left over in the filesystem, with incorrect link counts.  Tracing
> > > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > > commands that are queued up on behalf of the unlinked files at the time
> > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > > aborted, the fuse server would have responded to the RELEASE commands by
> > > > removing the hidden files; instead they stick around.
> > >
> > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> > > of synchronous. For example for fuse servers that cache their data and
> > > only write the buffer out to some remote filesystem when the file gets
> > > closed, it seems useful for them to (like nfs) be able to return an
> > > error to the client for close() if there's a failure committing that
> >
> > I don't think supplying a return value for close() is as helpful as it
> > seems -- the manage says that there is no guarantee that data has been
> > flushed to disk; and if the file is removed from the process' fd table
> > then the operation succeeded no matter the return value. :P
> >
> > (Also C programmers tend to be sloppy and not check the return value.)
> 
> Amir pointed out FUSE_FLUSH gets sent on the FUSE_RELEASE path so that
> addresses my worry. FUSE_FLUSH is sent synchronously (and close() will
> propagate any flush errors too), so now if there's an abort or
> something right after close() returns, the client is guaranteed that
> any data they wrote into a local cache has been flushed by the server.

<nod>

> >
> > > data; that also has clearer API semantics imo, eg users are guaranteed
> > > that when close() returns, all the processing/cleanup for that file
> > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > > the server holds local locks that get released in FUSE_RELEASE, if a
> >
> > Yes.  I think it's only useful for the case outined in that patch, which
> > is that a program started an asyncio operation and then closed the fd.
> > In that particular case the program unambiguously doesn't care about the
> > return value of close so it's ok to perform the release asynchronously.
> 
> I wonder why fuseblk devices need to be synchronously released. The
> comment says " Make the release synchronous if this is a fuseblk
> mount, synchronous RELEASE is allowed (and desirable)". Why is it
> desirable?

Err, which are you asking about?

Are you asking why it is that fuseblk mounts call FUSE_DESTROY from
unmount instead of letting libfuse synthesize it once the event loop
terminates?  I think that's because in the fuseblk case, the kernel has
the block device open for itself, so the fuse server must write and
flush all dirty data before the unmount() returns to the caller.

Or were you asking why synchronous RELEASE is done on fuseblk
filesystems?  Here is my speculation:

Synchronous RELEASE was added back in commit 5a18ec176c934c ("fuse: fix
hang of single threaded fuseblk filesystem").  I /think/ the idea behind
that patch was that for fuseblk servers, we're ok with issuing a
FUSE_DESTROY request from the kernel and waiting on it.

However, for that to work correctly, all previous pending requests
anywhere in the fuse mount have to be flushed to and completed by the
fuse server before we can send DESTROY, because destroy closes the
filesystem.

So I think the idea behind 5a18ec176c934c is that we make FUSE_RELEASE
synchronous so it's not possible to umount(8) until all the releases
requests are finished.

> > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > grabbing that lock, then we end up deadlocked if the server is
> > > single-threaded.
> >
> > Hrm.  I suppose if you had a script that ran two programs one after the
> > other, each of which expected to be able to open and lock the same file,
> > then you could run into problems if the lock isn't released by the time
> > the second program is ready to open the file.
> 
> I think in your scenario with the two programs, the worst outcome is
> that the open/lock acquiring can take a while but in the (contrived
> and probably far-fetched) scenario where it's single threaded, it
> would result in a complete deadlock.

<nod> I concede it's a minor point. :)

> > But having said that, some other program could very well open and lock
> > the file as soon as the lock drops.
> >
> > > I saw in your first patch that sending FUSE_RELEASE synchronously
> > > leads to a deadlock under AIO but AFAICT, that happens because we
> > > execute req->args->end() in fuse_request_end() synchronously; I think
> > > if we execute that release asynchronously on a worker thread then that
> > > gets rid of the deadlock.
> >
> > <nod> Last time I think someone replied that maybe they should all be
> > asynchronous.
> >
> > > If FUSE_RELEASE must be asynchronous though, then your approach makes
> > > sense to me.
> >
> > I think it only has to be asynchronous for the weird case outlined in
> > that patch (fuse server gets stuck closing its own client's fds).
> > Personally I think release ought to be synchronous at least as far as
> > the kernel doing all the stuff that close() says it has to do (removal
> > of record locks, deleting the fd table entry).
> >
> > Note that doesn't necessarily mean that the kernel has to be completely
> > done with all the work that entails.  XFS defers freeing of unlinked
> > files until a background garbage collector gets around to doing that.
> > Other filesystems will actually make you wait while they free all the
> > data blocks and the inode.  But the kernel has no idea what the fuse
> > server actually does.
> 
> I guess if that's important enough to the server, we could add
> something an FOPEN flag for that that servers could set on the file
> handle if they want synchronous release?

If a fuse server /did/ have background garbage collection, there are a
few things it could do -- every time it sees a FUSE_RELEASE of an
unlinked file, it could set a timer (say 50ms) after which it would kick
the gc thread to do its thing.  Or it could do wake up the background
thread in response to a FUSE_SYNCFS command and hope it finishes by the
time FUSE_DESTROY comes around.

(Speaking of which, can we enable syncfs for all fuse servers?)

But that said, not everyone wants the fancy background gc stuff that XFS
does.  FUSE_RELEASE would then be doing a lot of work.

> after Amir's point about FUSE_FLUSH, I'm in favor now of FUSE_RELEASE
> being asynchronous.
> >
> > > > Create a function to push all the background requests to the queue and
> > > > then wait for the number of pending events to hit zero, and call this
> > > > before fuse_abort_conn.  That way, all the pending events are processed
> > > > by the fuse server and we don't end up with a corrupt filesystem.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h |    6 ++++++
> > > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c  |    1 +
> > > >  3 files changed, 45 insertions(+)
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > +/*
> > > > + * Flush all pending requests and wait for them.  Only call this function when
> > > > + * it is no longer possible for other threads to add requests.
> > > > + */
> > > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
> > >
> > > It might be worth renaming this to something like
> > > 'fuse_flush_bg_requests' to make it more clear that this only flushes
> > > background requests
> >
> > Hum.  Did I not understand the code correctly?  I thought that
> > flush_bg_queue puts all the background requests onto the active queue
> > and issues them to the fuse server; and the wait_event_timeout sits
> > around waiting for all the requests to receive their replies?
> 
> Sorry, didn't mean to be confusing with my previous comment. What I
> was trying to say is that "fuse_flush_requests" implies that all
> requests get flushed to userspace but here only the background
> requests get flushed.

Oh, I see now, I /was/ mistaken.  Synchronous requests are ...

Wait, no, still confused :(

fuse_flush_requests waits until fuse_conn::num_waiting is zero.

Synchronous requests (aka the ones sent through fuse_simple_request)
bump num_waiting either directly in the args->force case or indirectly
via fuse_get_req.  num_waiting is decremented in fuse_put_request.
Therefore waiting for num_waiting to hit zero implements waiting for all
the requests that were in flight before fuse_flush_requests was called.

Background requests (aka the ones sent via fuse_simple_background) have
num_waiting set in the !args->force case or indirectly in
fuse_request_queue_background.  num_waiting is decremented in
fuse_put_request the same as is done for synchronous requests.

Therefore, it's correct to say that waiting for num_requests to become 0
is sufficient to wait for all pending requests anywhere in the
fuse_mount to complete.

Right?

Maybe this should be called fuse_flush_requests_and_wait. :)

--D

> Thanks,
> Joanne
> >
> > I could be mistaken though.  This is my rough understanding of what
> > happens to background requests:
> >
> > 1. Request created
> > 2. Put request on bg_queue
> > 3. <wait>
> > 4. Request removed from bg_queue
> > 5. Request sent
> > 6. <wait>
> > 7. Reply received
> > 8. Request ends and is _put.
> >
> > Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
> > fc->waiting tracks the number of requests that are anywhere between the
> > end of step 1 and the start of step 8.
> >
> > In any case, I want to push all the bg requests and wait until there are
> > no more requests in the system.
> >
> > --D
> 

