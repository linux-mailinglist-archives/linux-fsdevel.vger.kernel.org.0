Return-Path: <linux-fsdevel+bounces-55982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEAB11434
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4246DAC0E92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A723F417;
	Thu, 24 Jul 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGhuYUPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38314A4F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396495; cv=none; b=YW/3fhFhWx8OqbjyZ2X4+LQ/SXulHSchvt3nWzV3VwL7kl0GxN3dr8SsVqbkTXEc1JxeEazc/tQzlg4OHEeJ0sKfR/QZS2kdlJb8qQdXy7EpeUZoemhqfEpgu+Rtrre+BXV6nWvqJA9gORR7DmWarnelNaIBeMg+T1P5l8VelPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396495; c=relaxed/simple;
	bh=I2E90Zg1/2u8ot+C1qtRHrQZGIVr4xqGGq4f8UVkG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdvYo5mtzILSdEGunCdj1fldcl7CVMtBtDyB9aNe0id2/Gkj9abGnu1PP3CKlKaeglRqIn55QZoYLwpH4K+MX+lqd+xrGL1s85k+g4Gyq6u/4S3isubSdfVIG4sAwagkzx7BSrfYuRpyas8Zdf9je3vfOK+pZ+2oT7JDzc64Dh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGhuYUPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F540C4CEED;
	Thu, 24 Jul 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396495;
	bh=I2E90Zg1/2u8ot+C1qtRHrQZGIVr4xqGGq4f8UVkG0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGhuYUPQk4pXyV6pu8VjpWRv0wGApqs+7mp91DoTkc4jQhmk+BUa/tQc0hhYEilD1
	 zEhMGD9dMhA4SId/lNzL5ySwNPbqxTla3DkqYDjqhp4bsC+f2ZxJ0VOJl+V8Dk8SS9
	 PpAFanYe/wtZy0iN795OECatsz8tpantfJC4oXGIHYkTN7AkSFcf/zHu+puFAwgic5
	 yeB49uJttvcazkr67VK4z5iH+2h4nVYWFcgereTIifwqr9rz5BodaK9zOf3RbOThY7
	 LdIizfOjXXKz0IDuZSqDPKurhzRClFMSO1mHQh5zeLkYiBAFOicFoEYjlLVMCtOSV3
	 CMo0QkcIhELew==
Date: Thu, 24 Jul 2025 15:34:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu,
	bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250724223454.GP2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
 <CAJnrk1bE2ZHPNf-Pu+DBnOyqQWU=GZjvB+V-wvguszSwZTF0cQ@mail.gmail.com>
 <20250723170657.GI2672029@frogsfrogsfrogs>
 <CAJnrk1ac=m9udDX5Jq+scbD6ktqL5icGkoAPJO9d0AmMoMRyzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ac=m9udDX5Jq+scbD6ktqL5icGkoAPJO9d0AmMoMRyzg@mail.gmail.com>

On Wed, Jul 23, 2025 at 01:27:44PM -0700, Joanne Koong wrote:
> On Wed, Jul 23, 2025 at 10:06 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jul 21, 2025 at 01:05:02PM -0700, Joanne Koong wrote:
> > > On Sat, Jul 19, 2025 at 12:18 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Sat, Jul 19, 2025 at 12:23 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jul 17, 2025 at 4:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > >
> > > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > > >
> > > > > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > > > > files left over in the filesystem, with incorrect link counts.  Tracing
> > > > > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > > > > commands that are queued up on behalf of the unlinked files at the time
> > > > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > > > > aborted, the fuse server would have responded to the RELEASE commands by
> > > > > > removing the hidden files; instead they stick around.
> > > > >
> > > > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> > > > > of synchronous. For example for fuse servers that cache their data and
> > > > > only write the buffer out to some remote filesystem when the file gets
> > > > > closed, it seems useful for them to (like nfs) be able to return an
> > > > > error to the client for close() if there's a failure committing that
> > > > > data; that also has clearer API semantics imo, eg users are guaranteed
> > > > > that when close() returns, all the processing/cleanup for that file
> > > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > > > > the server holds local locks that get released in FUSE_RELEASE, if a
> > > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > > grabbing that lock, then we end up deadlocked if the server is
> > > > > single-threaded.
> > > > >
> > > >
> > > > There is a very good reason for keeping FUSE_FLUSH and FUSE_RELEASE
> > > > (as well as those vfs ops) separate.
> > >
> > > Oh interesting, I didn't realize FUSE_FLUSH gets also sent on the
> > > release path. I had assumed FUSE_FLUSH was for the sync()/fsync()
> >
> > (That's FUSE_FSYNC)
> >
> > > case. But I see now that you're right, close() makes a call to
> > > filp_flush() in the vfs layer. (and I now see there's FUSE_FSYNC for
> > > the fsync() case)
> >
> > Yeah, flush-on-close (FUSE_FLUSH) is generally a good idea for
> > "unreliable" filesystems -- either because they're remote, or because
> > the local storage they're on could get yanked at any time.  It's slow,
> > but it papers over a lot of bugs and "bad" usage.
> >
> > > > A filesystem can decide if it needs synchronous close() (not release).
> > > > And with FOPEN_NOFLUSH, the filesystem can decide that per open file,
> > > > (unless it conflicts with a config like writeback cache).
> > > >
> > > > I have a filesystem which can do very slow io and some clients
> > > > can get stuck doing open;fstat;close if close is always synchronous.
> > > > I actually found the libfuse feature of async flush (FUSE_RELEASE_FLUSH)
> > > > quite useful for my filesystem, so I carry a kernel patch to support it.
> > > >
> > > > The issue of racing that you mentioned sounds odd.
> > > > First of all, who runs a single threaded fuse server?
> > > > Second, what does it matter if release is sync or async,
> > > > FUSE_RELEASE will not be triggered by the same
> > > > task calling FUSE_OPEN, so if there is a deadlock, it will happen
> > > > with sync release as well.
> > >
> > > If the server is single-threaded, I think the FUSE_RELEASE would have
> > > to happen on the same task as FUSE_OPEN, so if the release is
> > > synchronous, this would avoid the deadlock because that guarantees the
> > > FUSE_RELEASE happens before the next FUSE_OPEN.
> >
> > On a single-threaded server(!) I would hope that the release would be
> > issued to the fuse server before the open.  (I'm not sure I understand
> 
> I don't think this is 100% guaranteed if fuse sends the release
> request asynchronously rather than synchronously (eg the request gets
> stalled on the bg queue if active_background >= max_background)

Humm, that /is/ weird one.  I guess there's nothing to prevent an OPEN
from racing with a RELEASE, since those two operations concern
themselves with *files*.  I suppose that means that if a fuse server
wants to hold a lock across fuse commands, then it had better be really
careful about that.

> > where this part of the thread went, because why would that happen?  And
> > why would the fuse server hold a lock across requests?)
> 
> The fuse server holding a lock across requests example was a contrived
> one to illustrate that an async release could be racy if a fuse server
> implementation has the (standard?) expectation that release and opens
> are always received in order.

<nod> I think it's quite common, since each open() call in userspace
creates a new struct file, even though they all point to the same inode.
That might be why you can't normally open-and-lock a resource.  opens
shouldn't stall indefinitely...(?)

--D

> >
> > > However now that you pointed out FUSE_FLUSH gets sent on the release
> > > path, that addresses my worry about async FUSE_RELEASE returning
> > > before the server has gotten a chance to write out their local buffer
> > > cache.
> >
> > <nod>
> >
> > --D
> >
> > > Thanks,
> > > Joanne
> > > >
> > > > Thanks,
> > > > Amir.
> > >
> 

