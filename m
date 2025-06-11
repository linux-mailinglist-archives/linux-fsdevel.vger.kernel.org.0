Return-Path: <linux-fsdevel+bounces-51318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D848AD5564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A075918920E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A327FD49;
	Wed, 11 Jun 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/gvWzEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CE27C150;
	Wed, 11 Jun 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644619; cv=none; b=rdgjUWWvyk6tGeeTW6bKPU6A3BsBrOboHAoiTIU4VbPJPh43xz5Xd1si9w9x+AlpbztX463ZXp2VjRrvNyZNwB8aOgq4O2qquE+l6Lf8kObkjGUKUz6ohQjWGDo1Z1XTulvBmec/gUjf+CGULOlYWihjlqHXcagapG+OgbJpf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644619; c=relaxed/simple;
	bh=e7rZEaxOwN2SgrYxFk1SXAqh8V6sNK2c5Wesu6qmQPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwevmDZLYGO3/vbGEsg0OxYyTDwBtv6IQUDaMtyqAPIB4d7PEi1q4o1nnSBOCIcmDAIK7vO5MD75CEOOOyCfN1NnhmpSHPSZzf9meL2PNqmah+Byy2UD56O0E/0X7Z4lQdvI5O/1hG0TmwVo39cHyoI/rcJAgii5O1wf4Aawjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/gvWzEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B493C4CEEE;
	Wed, 11 Jun 2025 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644615;
	bh=e7rZEaxOwN2SgrYxFk1SXAqh8V6sNK2c5Wesu6qmQPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/gvWzEWOoeshpEr4vNnWTx0sR1uUzIL21FMc8AyoRpXw2jI1qWDO8O9DP9GhsNO/
	 KoTtKsIRs1U1u07U20u/SjTYlifhAqcb83IyC8bHpQbdvC5Q0NLwaXqPCGEg18YAx0
	 7TOtsA72AwktDSaGLnehTa//Pk9IfZUnpyYEZEHuI17wZdACI3T/aCtp5hE9x5B6tE
	 OmYuRZL1zi67ncr3Xlvnm50quOIm3CcMi6CNWLkMxFML3N4zeOIEJ/W3wm9cgBvyXt
	 iliw2Z2xtD+9BA35WhzziOHmimv4lwFEYyfD0NT0i2s00wxu7hTcBvTlAUe8LOVNOs
	 VBnmsfTiQC85A==
Date: Wed, 11 Jun 2025 08:23:34 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEl1RhqybSCAzv3H@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <aEkpcmZG4rtAZk-3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEkpcmZG4rtAZk-3@infradead.org>

On Wed, Jun 11, 2025 at 12:00:02AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 04:57:36PM -0400, Mike Snitzer wrote:
> > IO must be aligned, otherwise it falls back to using buffered IO.
> > 
> > RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> > nfsd/enable-dontcache=1) because it works against us (due to RMW
> > needing to read without benefit of cache), whereas buffered IO enables
> > misaligned IO to be more performant.
> 
> This seems to "randomly" mix direct I/O and buffered I/O on a file.

It isn't random, if the IO is DIO-aligned it uses direct I/O.

> That's basically asking for data corruption due to invalidation races.

I've seen you speak of said dragons in other threads and even commit
headers, etc.  Could be they are lurking, but I took the approach of
"implement it [this patchset] and see what breaks".  It hasn't broken
yet, despite my having thrown a large battery of testing at it (which
includes all of Hammerspace's automated sanities testing that uses
many testsuites, e.g. xfstests, mdtest, etc, etc).

But the IOR "hard" workload, which checks for corruption and uses
47008 blocksize to force excessive RMW, hasn't yet been ran with my
"[PATCH 6/6] NFSD: issue READs using O_DIRECT even if IO is
misaligned" [0]. That IOR "hard" testing will likely happen today.

> But maybe also explain what this is trying to address to start with?

Ha, I suspect you saw my too-many-words 0th patch header [1] and
ignored it?  Solid feedback, I need to be more succinct and I'm
probably too close to this work to see the gaps in introduction and
justification but will refine, starting now:

Overview: NFSD currently only uses buffered IO and it routinely falls
over due to the problems RWF_DONTCACHE was developed to workaround.
But RWF_DONTCACHE also uses buffered IO and page cache and also
suffers from inefficiencies that direct IO doesn't.  Buffered IO's cpu
and memory consumption is particularly unwanted for resource
constrained systems.

Maybe some pictures are worth 1000+ words.

Here is a flamegraph showing buffered IO causing reclaim to bring the
system to a halt (when workload's working set far exceeds available
memory): https://original.art/buffered_read.svg

Here is flamegraph for the same type of workload but using DONTCACHE
instead of normal buffered IO: https://original.art/dontcache_read.svg

Dave Chinner provided his analysis of why DONTCACHE was struggling
[2].  And I gave further context to others and forecast that I'd be
working on implementing NFSD support for using O_DIRECT [3].  Then I
discussed how to approach the implementation with Chuck, Jeff and
others at the recent NFS Bakeathon.  This series implements my take on
what was discussed.

This graph shows O_DIRECT vs buffered IO for the IOR "easy" workload
("easy" because it uses aligned 1 MiB IOs rather than 47008 bytes like
IOR "hard"): https://original.art/NFSD_direct_vs_buffered_IO.jpg

Buffered IO is generally worse across the board.  DONTCACHE provides
welcome reclaim storm relief without the alignment requirements of
O_DIRECT but there really is no substitute for O_DIRECT if we're able
to use it.  My patchset shows NFSD can and that it is much more
deterministic and less resource hungry.

Direct I/O is definitely the direction we need to go, with DONTCACHE
fallback for misaligned write IO (once it is able to delay its
dropbehind to work better with misaligned IO).

Mike

[0]: https://lore.kernel.org/linux-nfs/20250610205737.63343-7-snitzer@kernel.org/
[1]: https://lore.kernel.org/linux-nfs/20250610205737.63343-1-snitzer@kernel.org/
[2]: https://lore.kernel.org/linux-nfs/aBrKbOoj4dgUvz8f@dread.disaster.area/
[3]: https://lore.kernel.org/linux-nfs/aBvVltbDKdHXMtLL@kernel.org/

