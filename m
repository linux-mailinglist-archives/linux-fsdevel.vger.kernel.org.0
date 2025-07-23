Return-Path: <linux-fsdevel+bounces-55880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E959B0F73A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FA21C83EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D01E8338;
	Wed, 23 Jul 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzOGRo6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78541F418F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285063; cv=none; b=l9mkTSBLa+TeyEWHNYhK8SKmgLEfJBCHP6pCCyQ55FkBXGMOwRTOlWm6ypVRABw3yd1GZa2vfFYm8RX0i3EWxTQM342YQqoUlJxNr9JmO+mojn0Hu7bIx+aG0ELgZUMlONOr2KXVEWO6kRfH5araNzo2DpcAYagJgYn3U/1W4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285063; c=relaxed/simple;
	bh=7CRXK5ESIsPT9bzgNuZ2dWDzChpae3BAB72GjoQHQ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCxOC2irXMlHOrzZXrgeTfjlUpRyQQWlVRFIbuKortBoB6tv3CUc3HUKEbZCtIxUnXkkNc2Iu/s8fzyAGxlND8JWNyoN/xirDDSpmFk7AkYyalPnKtrCPTKvM3d+I4+ULi2sRNOWhCscwFcjNBfyINkE1WV4adwkKfnwXFda2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzOGRo6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4DAC4CEE7;
	Wed, 23 Jul 2025 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285063;
	bh=7CRXK5ESIsPT9bzgNuZ2dWDzChpae3BAB72GjoQHQ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzOGRo6IHew5WOWDajeVbGuuKp8lyyvHY/X2kwF8yGHHz9QG0FWEFd5fbGItyzOib
	 BymuS7n6nHXWMOPMJ8OYpVBzSS69qbOWzAzr8+TkOeDjFtuDkgl5S3KhgJeUmoIwnY
	 6h0BeBbPyAtUE7Y1V/xmKSExRFs8pjBuaXnHPhlSa33ZLC+TSKB7rf2RksAhbno6wY
	 hHdl1bJRIOq+KYGI5B64XUn6V5ROTDHqIWyUmJ2yPG7B5fahw95rQAgEG5whrQcbnU
	 YanKub94G+hL2Avt79lX3sPCGsu1l8DbXCqlv+TbZmHsHxwVWpplqkeujD55JUHPWn
	 LKV7fH7gCqbQA==
Date: Wed, 23 Jul 2025 08:37:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu,
	bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250723153742.GH2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <20250719003215.GG2672029@frogsfrogsfrogs>
 <5ba49b0ff30f4e4f44440d393359a06a2515ab20.camel@kernel.org>
 <fda653661ea160cc65bd217c450c5291a7d3f3b1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda653661ea160cc65bd217c450c5291a7d3f3b1.camel@kernel.org>

On Tue, Jul 22, 2025 at 08:38:08AM -0400, Jeff Layton wrote:
> On Tue, 2025-07-22 at 08:30 -0400, Jeff Layton wrote:
> > On Fri, 2025-07-18 at 17:32 -0700, Darrick J. Wong wrote:
> > > On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > > > On Thu, Jul 17, 2025 at 4:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > 
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > > 
> > > > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> > > > > (see /var/tmp/fstests/generic/488.full for details)
> > > > > 
> > > > > This test opens a large number of files, unlinks them (which really just
> > > > > renames them to fuse hidden files), closes the program, unmounts the
> > > > > filesystem, and runs fsck to check that there aren't any inconsistencies
> > > > > in the filesystem.
> > > > > 
> > > > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > > > files left over in the filesystem, with incorrect link counts.  Tracing
> > > > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > > > commands that are queued up on behalf of the unlinked files at the time
> > > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > > > aborted, the fuse server would have responded to the RELEASE commands by
> > > > > removing the hidden files; instead they stick around.
> > > > 
> > > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> > > > of synchronous. For example for fuse servers that cache their data and
> > > > only write the buffer out to some remote filesystem when the file gets
> > > > closed, it seems useful for them to (like nfs) be able to return an
> > > > error to the client for close() if there's a failure committing that
> > > 
> > > I don't think supplying a return value for close() is as helpful as it
> > > seems -- the manage says that there is no guarantee that data has been
> > > flushed to disk; and if the file is removed from the process' fd table
> > > then the operation succeeded no matter the return value. :P
> > > 
> > > (Also C programmers tend to be sloppy and not check the return value.)
> > > 
> > 
> > The POSIX spec and manpage for close(2) make no mention of writeback
> > errors, so it's not 100% clear that returning them there is at all OK.
> > Everyone sort of assumes that it makes sense to do so, but it can be
> > actively harmful.
> > 
> 
> Actually, they do mention this, but I still argue that it's not a good
> idea to do so. If you want writeback errors use fsync() (or maybe the
> new ioctl() that someone was plumbing in that scrapes errors without
> doing writeback).
> 
> > Suppose we do this:
> > 
> > open() = 1
> > write(1)
> > close(1) 
> > open() = 2
> > fsync(2) = ???
> > 
> > Now, assume there was a writeback error that happens either before or
> > after the close.
> > 
> > With the way this works today, you will get back an error on that final
> > fsync() even if fd 2 was opened _after_ the writeback error occurred,
> > because nothing will have scraped it yet.
> > 
> > If you scrape the error to return it on the close though, then the
> > result of that fsync() would be inconclusive. If the error happens
> > before the close(), then fsync() will return 0. If it fails after the
> > close(), then the fsync() will see an error.

<nod> Given the horrible legacy of C programmers not really checking the
return value from close(), I think that /if/ the kernel is going to
check for writeback errors at close, it should sample the error state
but not clear it, so that the fsync returns accumulated errors.

(That said, my opinion is that after years of all of us telling
programmers that fsync is the golden standard for checking if bad stuff
happened, we really ought only be clearing error state during fsync.)

Evidently some projects do fsync-after-open assuming that close doesn't
flush and wait for writeback:
https://despairlabs.com/blog/posts/2025-03-13-fsync-after-open-is-an-elaborate-no-op/

--D

> > > > data; that also has clearer API semantics imo, eg users are guaranteed
> > > > that when close() returns, all the processing/cleanup for that file
> > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > > > the server holds local locks that get released in FUSE_RELEASE, if a
> > > 
> > > Yes.  I think it's only useful for the case outined in that patch, which
> > > is that a program started an asyncio operation and then closed the fd.
> > > In that particular case the program unambiguously doesn't care about the
> > > return value of close so it's ok to perform the release asynchronously.
> > > 
> > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > grabbing that lock, then we end up deadlocked if the server is
> > > > single-threaded.
> > > 
> > > Hrm.  I suppose if you had a script that ran two programs one after the
> > > other, each of which expected to be able to open and lock the same file,
> > > then you could run into problems if the lock isn't released by the time
> > > the second program is ready to open the file.
> > > 
> > > But having said that, some other program could very well open and lock
> > > the file as soon as the lock drops.
> > > 
> > > > I saw in your first patch that sending FUSE_RELEASE synchronously
> > > > leads to a deadlock under AIO but AFAICT, that happens because we
> > > > execute req->args->end() in fuse_request_end() synchronously; I think
> > > > if we execute that release asynchronously on a worker thread then that
> > > > gets rid of the deadlock.
> > > 
> > > <nod> Last time I think someone replied that maybe they should all be
> > > asynchronous.
> > > 
> > > > If FUSE_RELEASE must be asynchronous though, then your approach makes
> > > > sense to me.
> > > 
> > > I think it only has to be asynchronous for the weird case outlined in
> > > that patch (fuse server gets stuck closing its own client's fds).
> > > Personally I think release ought to be synchronous at least as far as
> > > the kernel doing all the stuff that close() says it has to do (removal
> > > of record locks, deleting the fd table entry).
> > > 
> > > Note that doesn't necessarily mean that the kernel has to be completely
> > > done with all the work that entails.  XFS defers freeing of unlinked
> > > files until a background garbage collector gets around to doing that.
> > > Other filesystems will actually make you wait while they free all the
> > > data blocks and the inode.  But the kernel has no idea what the fuse
> > > server actually does.
> > > 
> > > > > Create a function to push all the background requests to the queue and
> > > > > then wait for the number of pending events to hit zero, and call this
> > > > > before fuse_abort_conn.  That way, all the pending events are processed
> > > > > by the fuse server and we don't end up with a corrupt filesystem.
> > > > > 
> > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > ---
> > > > >  fs/fuse/fuse_i.h |    6 ++++++
> > > > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > > > >  fs/fuse/inode.c  |    1 +
> > > > >  3 files changed, 45 insertions(+)
> > > > > 
> > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > +/*
> > > > > + * Flush all pending requests and wait for them.  Only call this function when
> > > > > + * it is no longer possible for other threads to add requests.
> > > > > + */
> > > > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
> > > > 
> > > > It might be worth renaming this to something like
> > > > 'fuse_flush_bg_requests' to make it more clear that this only flushes
> > > > background requests
> > > 
> > > Hum.  Did I not understand the code correctly?  I thought that
> > > flush_bg_queue puts all the background requests onto the active queue
> > > and issues them to the fuse server; and the wait_event_timeout sits
> > > around waiting for all the requests to receive their replies?
> > > 
> > > I could be mistaken though.  This is my rough understanding of what
> > > happens to background requests:
> > > 
> > > 1. Request created
> > > 2. Put request on bg_queue
> > > 3. <wait>
> > > 4. Request removed from bg_queue
> > > 5. Request sent
> > > 6. <wait>
> > > 7. Reply received
> > > 8. Request ends and is _put.
> > > 
> > > Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
> > > fc->waiting tracks the number of requests that are anywhere between the
> > > end of step 1 and the start of step 8.
> > > 
> > > In any case, I want to push all the bg requests and wait until there are
> > > no more requests in the system.
> > > 
> > > --D
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

