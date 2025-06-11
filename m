Return-Path: <linux-fsdevel+bounces-51322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69129AD5704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1937917E81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1E28937B;
	Wed, 11 Jun 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib/ZUXnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F935897;
	Wed, 11 Jun 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648656; cv=none; b=g1Ytvv9LAlAcEpopDLzifu65UoydWpisIWSOIVSlPtO9thJsk0mPEqR1nBBLQVeo7NpP7oL1oFNhhVbUxDI/+G+UoNxjVNQ8csEwQNXIxn9/4ClkZ+QEH28b7jf2WGncm5lQHj6EdGm8qzt7qlWn3M/5VQHyHWn6cg1L8Ot60g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648656; c=relaxed/simple;
	bh=GUGz0+21sMoIfiL2In3f9xbvbUG5x3zI/S4GvQY7nfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUkiX6hCnfcvvTVhMNs2iQPjVcaZExo9Va1rvqFbiW6q0UssrK0gVaiHTpavZ8rpEeE4QWhcRwvVmywRZQZyrgSeLYIZv/92DbYCDLV97O5y0czcYmYpdhY7EyL8gXipzbVgwy+GCkKWroe/19VF++nUMoVYIaYxHQmccYegpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib/ZUXnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE93C4CEEE;
	Wed, 11 Jun 2025 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648655;
	bh=GUGz0+21sMoIfiL2In3f9xbvbUG5x3zI/S4GvQY7nfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ib/ZUXnBy8DmU56fIRfNvQVsMUMyBi2giTpXywwbm2XtnS9ZzSpETBwPrTYUov5bL
	 UUYuhveQp6AYkwfbwhoNNx5C9XvX5Rj12+f/QlVmw2rMCKvfGywgH1oaD99lLL8gJN
	 qsn8hUgR8wFbo/J1HFX6a3Kv+fzh29YFPytPsYKQNbI83Pwi2ixA5T5OCWpsHwnsdU
	 9e20hKkYtyzRIduvZBPQcCfxodjb+0fwGF/sYLVs2x5niZltagAtMH0P8DuAwarhTk
	 JlQQLnJIiQU4l6i9I3tKzatZffx5fIKN51BelcC7p+Q1E4qOJbX1lFBz/2AZi27TOX
	 J1Qtun7MWj6EQ==
Message-ID: <b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Dave Chinner
	 <david@fromorbit.com>
Date: Wed, 11 Jun 2025 09:30:54 -0400
In-Reply-To: <aEl1RhqybSCAzv3H@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
	 <20250610205737.63343-6-snitzer@kernel.org>
	 <aEkpcmZG4rtAZk-3@infradead.org> <aEl1RhqybSCAzv3H@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 08:23 -0400, Mike Snitzer wrote:
> On Wed, Jun 11, 2025 at 12:00:02AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 10, 2025 at 04:57:36PM -0400, Mike Snitzer wrote:
> > > IO must be aligned, otherwise it falls back to using buffered IO.
> > >=20
> > > RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> > > nfsd/enable-dontcache=3D1) because it works against us (due to RMW
> > > needing to read without benefit of cache), whereas buffered IO enable=
s
> > > misaligned IO to be more performant.
> >=20
> > This seems to "randomly" mix direct I/O and buffered I/O on a file.
>=20
> It isn't random, if the IO is DIO-aligned it uses direct I/O.
>=20
> > That's basically asking for data corruption due to invalidation races.
>=20
> I've seen you speak of said dragons in other threads and even commit
> headers, etc.  Could be they are lurking, but I took the approach of
> "implement it [this patchset] and see what breaks".  It hasn't broken
> yet, despite my having thrown a large battery of testing at it (which
> includes all of Hammerspace's automated sanities testing that uses
> many testsuites, e.g. xfstests, mdtest, etc, etc).
>=20

I'm concerned here too. Invalidation races can mean silent data
corruption. We'll need to ensure that this is safe.

Incidentally, is there a good testcase for this? Something that does
buffered and direct I/O from different tasks and looks for
inconsistencies?

> But the IOR "hard" workload, which checks for corruption and uses
> 47008 blocksize to force excessive RMW, hasn't yet been ran with my
> "[PATCH 6/6] NFSD: issue READs using O_DIRECT even if IO is
> misaligned" [0]. That IOR "hard" testing will likely happen today.
>=20
> > But maybe also explain what this is trying to address to start with?
>=20
> Ha, I suspect you saw my too-many-words 0th patch header [1] and
> ignored it?  Solid feedback, I need to be more succinct and I'm
> probably too close to this work to see the gaps in introduction and
> justification but will refine, starting now:
>=20
> Overview: NFSD currently only uses buffered IO and it routinely falls
> over due to the problems RWF_DONTCACHE was developed to workaround.
> But RWF_DONTCACHE also uses buffered IO and page cache and also
> suffers from inefficiencies that direct IO doesn't.  Buffered IO's cpu
> and memory consumption is particularly unwanted for resource
> constrained systems.
>=20
> Maybe some pictures are worth 1000+ words.
>=20
> Here is a flamegraph showing buffered IO causing reclaim to bring the
> system to a halt (when workload's working set far exceeds available
> memory): https://original.art/buffered_read.svg
>=20
> Here is flamegraph for the same type of workload but using DONTCACHE
> instead of normal buffered IO: https://original.art/dontcache_read.svg
>=20
> Dave Chinner provided his analysis of why DONTCACHE was struggling
> [2].  And I gave further context to others and forecast that I'd be
> working on implementing NFSD support for using O_DIRECT [3].  Then I
> discussed how to approach the implementation with Chuck, Jeff and
> others at the recent NFS Bakeathon.  This series implements my take on
> what was discussed.
>=20
> This graph shows O_DIRECT vs buffered IO for the IOR "easy" workload
> ("easy" because it uses aligned 1 MiB IOs rather than 47008 bytes like
> IOR "hard"): https://original.art/NFSD_direct_vs_buffered_IO.jpg
>=20
> Buffered IO is generally worse across the board.  DONTCACHE provides
> welcome reclaim storm relief without the alignment requirements of
> O_DIRECT but there really is no substitute for O_DIRECT if we're able
> to use it.  My patchset shows NFSD can and that it is much more
> deterministic and less resource hungry.
>=20
> Direct I/O is definitely the direction we need to go, with DONTCACHE
> fallback for misaligned write IO (once it is able to delay its
> dropbehind to work better with misaligned IO).
>=20
> Mike
>=20
> [0]: https://lore.kernel.org/linux-nfs/20250610205737.63343-7-snitzer@ker=
nel.org/
> [1]: https://lore.kernel.org/linux-nfs/20250610205737.63343-1-snitzer@ker=
nel.org/
> [2]: https://lore.kernel.org/linux-nfs/aBrKbOoj4dgUvz8f@dread.disaster.ar=
ea/
> [3]: https://lore.kernel.org/linux-nfs/aBvVltbDKdHXMtLL@kernel.org/

To summarize: the basic problem is that the pagecache is pretty useless
for satisfying READs from nfsd. Most NFS workloads don't involve I/O to
the same files from multiple clients. The client ends up having most of
the data in its cache already and only very rarely do we need to
revisit the data on the server.=C2=A0

At the same time, it's really easy to overwhelm the storage with
pagecache writeback with modern memory sizes. Having nfsd bypass the
pagecache altogether is potentially a huge performance win, if it can
be made to work safely.
--=20
Jeff Layton <jlayton@kernel.org>

