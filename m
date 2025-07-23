Return-Path: <linux-fsdevel+bounces-55887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D168B0F8A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E9A1AA7A9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664F20E00B;
	Wed, 23 Jul 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYgd9Mb0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C15204F9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290418; cv=none; b=izRb3sgE1pxXEXDUJhMZ6Gwgi0AxgoH2byP2fLriGYiQq3OgPmm2JxhXkzorZi2HwiccpwmEurFfIxjuUqLfTxJvILusmdylzJvaCLA7ZfgDu6TEIdvck3x54xkFLdCTenYMoaWWYArIqhhgGUUd05CfLVpg4/tiNeHpurYFK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290418; c=relaxed/simple;
	bh=lRDp0phi0fH/2+waLaUvuObmvJ0WSvdVQD/TnwcoaXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOJwTuZ3iGmm4vpppq69mMoZWpzBS9HLiHoZu55tJ6bJrHrFmukg4ZfZh2hdVUuWFurD/odCJNWpjdtUUvGHUtHSKq9OY3mVE3Zsji7sroOfvwXouaCH95EFQfJLTmGvqs9f05PLKuRlFnRIbUXhhslfki6u74s1O9cGqgVRZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYgd9Mb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1A9C4CEE7;
	Wed, 23 Jul 2025 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290417;
	bh=lRDp0phi0fH/2+waLaUvuObmvJ0WSvdVQD/TnwcoaXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYgd9Mb0NlupiPANP0vPwE3LKCorvH/4RsPR1kLDrCL+GTOf8ktVkixzx8Bn2LpMm
	 CPasT0P4pvefLMSSPPTwJB7Dezi1r5I98p8sZ7a7ARaFA5NtifSqMwrXo6jH6VWDT6
	 8c5XK2lf0ebvxDlXwNXhMk9A6+YjcqLVtylcmMDfG6/czUnCRcyJBgaKXjPFZbEXE3
	 du83pGOfQK9vMTseBBMZcpuJMlYRKKN6pgJFHNRKU1JAGIM+UYRw0FyEsPyrkgni2J
	 e7RHZpcrDRP0Ex3BZ0GsC0zoZrufbZPWvIkJ/II0/pArl1etK92KABI/rnOWtzSt6Z
	 ArgrFatxXM+Vw==
Date: Wed, 23 Jul 2025 10:06:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu,
	bernd@bsbernd.com
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250723170657.GI2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
 <CAJnrk1bE2ZHPNf-Pu+DBnOyqQWU=GZjvB+V-wvguszSwZTF0cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bE2ZHPNf-Pu+DBnOyqQWU=GZjvB+V-wvguszSwZTF0cQ@mail.gmail.com>

On Mon, Jul 21, 2025 at 01:05:02PM -0700, Joanne Koong wrote:
> On Sat, Jul 19, 2025 at 12:18 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Jul 19, 2025 at 12:23 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Thu, Jul 17, 2025 at 4:26 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > generic/488 fails with fuse2fs in the following fashion:
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
> > > data; that also has clearer API semantics imo, eg users are guaranteed
> > > that when close() returns, all the processing/cleanup for that file
> > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > > the server holds local locks that get released in FUSE_RELEASE, if a
> > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > grabbing that lock, then we end up deadlocked if the server is
> > > single-threaded.
> > >
> >
> > There is a very good reason for keeping FUSE_FLUSH and FUSE_RELEASE
> > (as well as those vfs ops) separate.
> 
> Oh interesting, I didn't realize FUSE_FLUSH gets also sent on the
> release path. I had assumed FUSE_FLUSH was for the sync()/fsync()

(That's FUSE_FSYNC)

> case. But I see now that you're right, close() makes a call to
> filp_flush() in the vfs layer. (and I now see there's FUSE_FSYNC for
> the fsync() case)

Yeah, flush-on-close (FUSE_FLUSH) is generally a good idea for
"unreliable" filesystems -- either because they're remote, or because
the local storage they're on could get yanked at any time.  It's slow,
but it papers over a lot of bugs and "bad" usage.

> > A filesystem can decide if it needs synchronous close() (not release).
> > And with FOPEN_NOFLUSH, the filesystem can decide that per open file,
> > (unless it conflicts with a config like writeback cache).
> >
> > I have a filesystem which can do very slow io and some clients
> > can get stuck doing open;fstat;close if close is always synchronous.
> > I actually found the libfuse feature of async flush (FUSE_RELEASE_FLUSH)
> > quite useful for my filesystem, so I carry a kernel patch to support it.
> >
> > The issue of racing that you mentioned sounds odd.
> > First of all, who runs a single threaded fuse server?
> > Second, what does it matter if release is sync or async,
> > FUSE_RELEASE will not be triggered by the same
> > task calling FUSE_OPEN, so if there is a deadlock, it will happen
> > with sync release as well.
> 
> If the server is single-threaded, I think the FUSE_RELEASE would have
> to happen on the same task as FUSE_OPEN, so if the release is
> synchronous, this would avoid the deadlock because that guarantees the
> FUSE_RELEASE happens before the next FUSE_OPEN.

On a single-threaded server(!) I would hope that the release would be
issued to the fuse server before the open.  (I'm not sure I understand
where this part of the thread went, because why would that happen?  And
why would the fuse server hold a lock across requests?)

> However now that you pointed out FUSE_FLUSH gets sent on the release
> path, that addresses my worry about async FUSE_RELEASE returning
> before the server has gotten a chance to write out their local buffer
> cache.

<nod>

--D

> Thanks,
> Joanne
> >
> > Thanks,
> > Amir.
> 

