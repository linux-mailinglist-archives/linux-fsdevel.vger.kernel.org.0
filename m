Return-Path: <linux-fsdevel+bounces-53982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F3AF9B49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390DF586D03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6B1E9B3D;
	Fri,  4 Jul 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF6B8xP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15EB72610;
	Fri,  4 Jul 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751658402; cv=none; b=cvJPSqjyaYCLOfpUNB6fDdpo51tPR0ZNWLoZEUAxOBcn2MVidmbjP9mbflvp5J9YHjXHDJsgp9iQ75Li6ugWkCNNhPiRujSlPVoJRxrwRSAkpdWERDlPuc+irmi87TYHY8TOAyCyKFHElas8cYIr13poQoeiJFkWARg6GOq4pcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751658402; c=relaxed/simple;
	bh=7sl222wGYOV12L1PGTz0kanazbA9ydr0iaCDXq1sMUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsR9VmqkQL24YF59hYnT7JTPmxckOunyuJaWMPd1/QcXnwvQ32GdBOTDOnAEPP1tuBcPSaaOAa5SDkwvcQ+JoLhDa7zFUO2nyyBy8Yrp6uwBWzKzwMKOktDWM8QbojaCpb6JAJhQGCkhEqXtkbd+ug0U9jCxTCkbfA2Lh6F7Ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF6B8xP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FF2C4CEE3;
	Fri,  4 Jul 2025 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751658402;
	bh=7sl222wGYOV12L1PGTz0kanazbA9ydr0iaCDXq1sMUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF6B8xP1AOvoVPSuIvbbJCV4Nm44DEXUhr1apKrNzKiF4fWzcs1t5kYcHnmQtivoM
	 BuX6VZ5m6djFPluF9hyuMTMRt2N8V55A+D0q7Iq/S5Lj741gOM5YIRNdSEnFLjj37q
	 sFjZbnhe2sIksXc/QH4ybrSe5irWxWumGQIkz91qaoOl3RdqKNv6ReHlLOgh6Xg5jw
	 9aXrSzBew/qEH9cG+2WaZ+nU2w5kz4CxlSv2eMaoHu+Q4oMh6prSWfvwukWI7NFjat
	 erRr7+u59iTa12nVWKL47ojbeop/v2N5P759k1p5lq/vc82dE1A/50LdChNQuSy7ke
	 3P3T+FedgjYcg==
Date: Fri, 4 Jul 2025 15:46:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	keith.mannthey@hammerspace.com
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aGgvoWo7p0oI90xE@kernel.org>
References: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org>
 <aFGkV1ILAlmtpGVJ@kernel.org>
 <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>
 <aFRwvhM-wdQpTDin@kernel.org>
 <3f91b4eb-6a6b-4a81-bf4e-ba5f4d6b407f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f91b4eb-6a6b-4a81-bf4e-ba5f4d6b407f@oracle.com>

On Mon, Jun 30, 2025 at 10:50:42AM -0400, Chuck Lever wrote:
> On 6/19/25 4:19 PM, Mike Snitzer wrote:
> > On Tue, Jun 17, 2025 at 01:31:23PM -0400, Chuck Lever wrote:
> >>
> >> If we were to make all NFS READ operations use O_DIRECT, then of course
> >> NFSD's splice read should be removed at that point.
> > 
> > Yes, that makes sense.  I still need to try Christoph's idea (hope to
> > do so over next 24hrs):
> > https://lore.kernel.org/linux-nfs/aEu3o9imaQQF9vyg@infradead.org/
> > 
> > But for now, here is my latest NFSD O_DIRECT/DONTCACHE work, think of
> > the top 6 commits as a preview of what'll be v2 of this series:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing
> 
> I was waiting for a series repost, but in the meantime...
> 
> The one thing that caught my eye was the relocation of fh_getattr().
> 
> - If fh_getattr() is to be moved to fs/nfsd/vfs.c, then it should be
>   renamed nfsd_getattr() (or similar) to match the API naming
>   convention in that file.
> 
> - If fh_getattr() is to keep its current name, then it should be
>   moved to where the other fh_yada() functions reside, in
>   fs/nfsd/nfsfh.c
> 
> In a private tree, I constructed a patch to do the latter. I can
> post that for comment.

Hi,

Sure, I can clean it up to take your patch into account.  Please share
your patch (either pointer to commit in a branch or via email).

Tangent to explain why I've fallen off the face of the earth:
I have just been focused on trying to get client-side misaligned
O_DIRECT READ IO to be expanded to be DIO-aligned like I did with
NFSD.  Turns out it is quite involved (took a week of focused
development to arrive at the fact that NFS client's nfs_page and
pagelist code's use of memory as an array is entirely incompatiable.
Discussed with Trond and the way forward would require having NFS
client fill in xdr_buf's bvec and manage manually.. but that's a
serious hack.  Better long term goal is to convert xdr_buf over to
using bio_vec like NFSD is using.

So rather than do any of that _now_, I just today implemented an NFS
LOCALIO fallback to issuing the misaligned DIO READ using remote call
to NFSD (able to do so on a per-IO basis if READ is misaligned).
Seems to work really well, but does force LOCALIO to go remote (over
loopback network) just so it can leverage our new NFSD mode to use
O_DIRECT and expand misaligned writes, which is enabled with:
  echo 2 > /sys/kernel/debug/nfsd/io_cache_read

All said, I'll get everything cleaned up and send out v2 of this
patchset on Monday.  (If you share your patch I can rebase ontop of it
and hopefully still get v2 out on Monday)

Thanks, and Happy 4th of July!
Mike

