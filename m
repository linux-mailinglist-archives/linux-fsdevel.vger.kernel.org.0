Return-Path: <linux-fsdevel+bounces-55492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AFB0ACD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 02:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F163BFF36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BA27462;
	Sat, 19 Jul 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqZHhR4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033623DE
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752885136; cv=none; b=t6shmagK3FYfw5/0C66RTC93YtpSXpkx4NTIKHaKh3OvdAGKEyZN+Ofl4gfz6j6qLiv3GMS7eEF2Mc24R+eHfhObe8hY5wcli820t16v8vJ1acmyeGIMvTLZ7MUKSiLOzpdUT7rewFzJVz2VxrlenJM3C4gRcXKdZgz+6ZT+rLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752885136; c=relaxed/simple;
	bh=7zKDnECApyThuAZh8hSalI1w5zNo74qJh8V69d4AeRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeCVldHirED+MqzqxZR6zrs8095b0kHXE8j2aQIA+JcNAxsb3F0p6mQrW7GkvyseLabqz6lYcTeBhKERpnTh5Pt4mKjpXpBLvwH59oc1yprMGdZ7VEbcVxSgYxpZZy2QLySj2rpBPV/tZkKVndH8UEzFRW1yXsU4idE4jqsmuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqZHhR4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC29DC4CEEB;
	Sat, 19 Jul 2025 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752885135;
	bh=7zKDnECApyThuAZh8hSalI1w5zNo74qJh8V69d4AeRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqZHhR4comGN3h5G2asI6Lug9s2/UQBZ5bEFcwlDnUKB/uB1tOec8ahOGL40V9Wf2
	 gdkAoxz51KtwRqeHWq4BCwaZANL/d0kiUIFBj/5OSdi/+tSR8M2J4PvaQi3BI2n8tY
	 3Vuf47JjD3f8TCaFFWbVQTJyQGkzg4FQGudPNabFkXPUNmplfG726VL8XeCgf7GBh/
	 KnQIeNSd6K9HxIDnzHfFMoyJcR2XSnB8nzEY3hrG9nJ+9H4ZWgQ3oM7I1uY1JmVN5q
	 gqB3FINH+AulwHIPV7zdI4UUPrUKLg58ZJipChv41Zn9XXSY+CmT3s8J2Nj0FhDN0m
	 +QoI3XHHYEJtQ==
Date: Fri, 18 Jul 2025 17:32:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250719003215.GG2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>

On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> On Thu, Jul 17, 2025 at 4:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
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
> 
> Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> of synchronous. For example for fuse servers that cache their data and
> only write the buffer out to some remote filesystem when the file gets
> closed, it seems useful for them to (like nfs) be able to return an
> error to the client for close() if there's a failure committing that

I don't think supplying a return value for close() is as helpful as it
seems -- the manage says that there is no guarantee that data has been
flushed to disk; and if the file is removed from the process' fd table
then the operation succeeded no matter the return value. :P

(Also C programmers tend to be sloppy and not check the return value.)

> data; that also has clearer API semantics imo, eg users are guaranteed
> that when close() returns, all the processing/cleanup for that file
> has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> the server holds local locks that get released in FUSE_RELEASE, if a

Yes.  I think it's only useful for the case outined in that patch, which
is that a program started an asyncio operation and then closed the fd.
In that particular case the program unambiguously doesn't care about the
return value of close so it's ok to perform the release asynchronously.

> subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> grabbing that lock, then we end up deadlocked if the server is
> single-threaded.

Hrm.  I suppose if you had a script that ran two programs one after the
other, each of which expected to be able to open and lock the same file,
then you could run into problems if the lock isn't released by the time
the second program is ready to open the file.

But having said that, some other program could very well open and lock
the file as soon as the lock drops.

> I saw in your first patch that sending FUSE_RELEASE synchronously
> leads to a deadlock under AIO but AFAICT, that happens because we
> execute req->args->end() in fuse_request_end() synchronously; I think
> if we execute that release asynchronously on a worker thread then that
> gets rid of the deadlock.

<nod> Last time I think someone replied that maybe they should all be
asynchronous.

> If FUSE_RELEASE must be asynchronous though, then your approach makes
> sense to me.

I think it only has to be asynchronous for the weird case outlined in
that patch (fuse server gets stuck closing its own client's fds).
Personally I think release ought to be synchronous at least as far as
the kernel doing all the stuff that close() says it has to do (removal
of record locks, deleting the fd table entry).

Note that doesn't necessarily mean that the kernel has to be completely
done with all the work that entails.  XFS defers freeing of unlinked
files until a background garbage collector gets around to doing that.
Other filesystems will actually make you wait while they free all the
data blocks and the inode.  But the kernel has no idea what the fuse
server actually does.

> > Create a function to push all the background requests to the queue and
> > then wait for the number of pending events to hit zero, and call this
> > before fuse_abort_conn.  That way, all the pending events are processed
> > by the fuse server and we don't end up with a corrupt filesystem.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    6 ++++++
> >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/inode.c  |    1 +
> >  3 files changed, 45 insertions(+)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > +/*
> > + * Flush all pending requests and wait for them.  Only call this function when
> > + * it is no longer possible for other threads to add requests.
> > + */
> > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
> 
> It might be worth renaming this to something like
> 'fuse_flush_bg_requests' to make it more clear that this only flushes
> background requests

Hum.  Did I not understand the code correctly?  I thought that
flush_bg_queue puts all the background requests onto the active queue
and issues them to the fuse server; and the wait_event_timeout sits
around waiting for all the requests to receive their replies?

I could be mistaken though.  This is my rough understanding of what
happens to background requests:

1. Request created
2. Put request on bg_queue
3. <wait>
4. Request removed from bg_queue
5. Request sent
6. <wait>
7. Reply received
8. Request ends and is _put.

Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
fc->waiting tracks the number of requests that are anywhere between the
end of step 1 and the start of step 8.

In any case, I want to push all the bg requests and wait until there are
no more requests in the system.

--D

