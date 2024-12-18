Return-Path: <linux-fsdevel+bounces-37744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A99F6C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81993188A02C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF81F8AF6;
	Wed, 18 Dec 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaRZII0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0E4A1D;
	Wed, 18 Dec 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542206; cv=none; b=TQA6sTH7J8ov4upAwqJNR5Ni244yxuLdOsFRl7XpGcEDHwBn7sndpwiyhOlR45lpTRpCGFluvIkFhtYHBEMW7RCbE7c6pZAd5bA1RycRq84RBzKgtwDrfkJ+IBh5m4ovrlluhE8sRSbObMN+1T2aFiFB+VNPlCJCl/RGyl3K4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542206; c=relaxed/simple;
	bh=vByKvfBxoRz2Ew61HCzPzSOCqlcnxTOUTykzOp1/1ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntcXmMJf6taDtf68cQ0Ge3yfF+Yb8PJKG07mHl0i6FJuguopRQJZNLpFtOWmpVnVntdaqxSsV9It88JhQu31JclaY9WEFP/dsRpOlw3Hja21/mlsdrKeZ+/SiIVxQKAgK1HEilJR4ZlhNBp5ut9oOZY9HdWGaJKgpsiO7l4Y3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaRZII0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C71C4CECD;
	Wed, 18 Dec 2024 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734542206;
	bh=vByKvfBxoRz2Ew61HCzPzSOCqlcnxTOUTykzOp1/1ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaRZII0XV6az6sQ50USic51NDQt/fhWVoYaA0YSNVF8wUYpBxoJhSrjQCGTK6ajMD
	 z44k3r2auvUrUCAQ2utziWzufJqHMxWXuyjupFw2hQDT4GtknGMBDIwv/yAYqbujzO
	 30CCkreSlXnX7bEvuNiMcv3X/KgZCvjfJ92T2tLmULVlTdo4UJ4eE8TL+mLSttbx8p
	 9mc3PfIVjxlmEs4uz9KMwzQaubt0ZtM0FbNMIwtm4XvZDZ0iIKywCsSTvbpiYkh8K8
	 ZMAkejSDmtJ60gpcz3HHFd7QMoSicq1hWSYwaIKB9HXHte41/NmPr73vJCAMZ5698y
	 t9dJEp6sKqvDg==
Date: Wed, 18 Dec 2024 12:16:44 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: flag as supporting FOP_DONTCACHE
Message-ID: <Z2MDfBWULaV7n9Pb@kernel.org>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:14AM -0700, Jens Axboe wrote:
> Hi,
> 
> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
> to do buffered IO that isn't page cache persistent. The approach back
> then was to have private pages for IO, and then get rid of them once IO
> was done. But that then runs into all the issues that O_DIRECT has, in
> terms of synchronizing with the page cache.
> 
> So here's a new approach to the same concent, but using the page cache
> as synchronization. Due to excessive bike shedding on the naming, this
> is now named RWF_DONTCACHE, and is less special in that it's just page
> cache IO, except it prunes the ranges once IO is completed.
> 
> Why do this, you may ask? The tldr is that device speeds are only
> getting faster, while reclaim is not. Doing normal buffered IO can be
> very unpredictable, and suck up a lot of resources on the reclaim side.
> This leads people to use O_DIRECT as a work-around, which has its own
> set of restrictions in terms of size, offset, and length of IO. It's
> also inherently synchronous, and now you need async IO as well. While
> the latter isn't necessarily a big problem as we have good options
> available there, it also should not be a requirement when all you want
> to do is read or write some data without caching.
> 
> Even on desktop type systems, a normal NVMe device can fill the entire
> page cache in seconds. On the big system I used for testing, there's a
> lot more RAM, but also a lot more devices. As can be seen in some of the
> results in the following patches, you can still fill RAM in seconds even
> when there's 1TB of it. Hence this problem isn't solely a "big
> hyperscaler system" issue, it's common across the board.
> 
> Common for both reads and writes with RWF_DONTCACHE is that they use the
> page cache for IO. Reads work just like a normal buffered read would,
> with the only exception being that the touched ranges will get pruned
> after data has been copied. For writes, the ranges will get writeback
> kicked off before the syscall returns, and then writeback completion
> will prune the range. Hence writes aren't synchronous, and it's easy to
> pipeline writes using RWF_DONTCACHE. Folios that aren't instantiated by
> RWF_DONTCACHE IO are left untouched. This means you that uncached IO
> will take advantage of the page cache for uptodate data, but not leave
> anything it instantiated/created in cache.
> 
> File systems need to support this. This patchset adds support for the
> generic read path, which covers file systems like ext4. Patches exist to
> add support for iomap/XFS and btrfs as well, which sit on top of this
> series. If RWF_DONTCACHE IO is attempted on a file system that doesn't
> support it, -EOPNOTSUPP is returned. Hence the user can rely on it
> either working as designed, or flagging and error if that's not the
> case. The intent here is to give the application a sensible fallback
> path - eg, it may fall back to O_DIRECT if appropriate, or just live
> with the fact that uncached IO isn't available and do normal buffered
> IO.
> 
> Adding "support" to other file systems should be trivial, most of the
> time just a one-liner adding FOP_DONTCACHE to the fop_flags in the
> file_operations struct.
> 
> Performance results are in patch 8 for reads, and you can find the write
> side results in the XFS patch adding support for DONTCACHE writes for
> XFS:
> 
> ://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached.9&id=edd7b1c910c5251941c6ba179f44b4c81a089019
> 
> with the tldr being that I see about a 65% improvement in performance
> for both, with fully predictable IO times. CPU reduction is substantial
> as well, with no kswapd activity at all for reclaim when using
> uncached IO.
> 
> Using it from applications is trivial - just set RWF_DONTCACHE for the
> read or write, using pwritev2(2) or preadv2(2). For io_uring, same
> thing, just set RWF_DONTCACHE in sqe->rw_flags for a buffered read/write
> operation. And that's it.
> 
> Patches 1..7 are just prep patches, and should have no functional
> changes at all. Patch 8 adds support for the filemap path for
> RWF_DONTCACHE reads, and patches 9..11 are just prep patches for
> supporting the write side of uncached writes. In the below mentioned
> branch, there are then patches to adopt uncached reads and writes for
> xfs, btrfs, and ext4. The latter currently relies on bit of a hack for
> passing whether this is an uncached write or not through
> ->write_begin(), which can hopefully go away once ext4 adopts iomap for
> buffered writes. I say this is a hack as it's not the prettiest way to
> do it, however it is fully solid and will work just fine.
> 
> Passes full xfstests and fsx overnight runs, no issues observed. That
> includes the vm running the testing also using RWF_DONTCACHE on the
> host. I'll post fsstress and fsx patches for RWF_DONTCACHE separately.
> As far as I'm concerned, no further work needs doing here.
> 
> And git tree for the patches is here:
> 
> https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.9
> 
>  include/linux/fs.h             | 21 +++++++-
>  include/linux/page-flags.h     |  5 ++
>  include/linux/pagemap.h        |  1 +
>  include/trace/events/mmflags.h |  3 +-
>  include/uapi/linux/fs.h        |  6 ++-
>  mm/filemap.c                   | 97 +++++++++++++++++++++++++++++-----
>  mm/internal.h                  |  2 +
>  mm/readahead.c                 | 22 ++++++--
>  mm/swap.c                      |  2 +
>  mm/truncate.c                  | 54 ++++++++++---------
>  10 files changed, 166 insertions(+), 47 deletions(-)
> 
> Since v6
> - Rename the PG_uncached flag to PG_dropbehind
> - Shuffle patches around a bit, most notably so the foliop_uncached
>   patch goes with the ext4 support
> - Get rid of foliop_uncached hack for btrfs (Christoph)
> - Get rid of passing in struct address_space to filemap_create_folio()
> - Inline invalidate_complete_folio2() in folio_unmap_invalidate() rather
>   than keep it as a separate helper
> - Rebase on top of current master
> 
> -- 
> Jens Axboe
> 
> 


Hi Jens,

You may recall I tested NFS to work with UNCACHED (now DONTCACHE).
I've rebased the required small changes, feel free to append this to
your series if you like.

More work is needed to inform knfsd to selectively use DONTCACHE, but
that will require more effort and coordination amongst the NFS kernel
team.

From: Mike Snitzer <snitzer@kernel.org>
Date: Thu, 14 Nov 2024 22:09:01 +0000
Subject: [PATCH] nfs: flag as supporting FOP_DONTCACHE

Jens says: "nfs just uses generic_file_read_iter(), so read side is
fine with the flag added and generic_perform_write() for the write
side, wrapped in some nfs jazz. So you can probably just set the flag
and be done with it."

Must also update nfs_write_begin() to set FGP_DONTCACHE in fgp flags
passed to __filemap_get_folio().

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/file.c     | 3 +++
 fs/nfs/nfs4file.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e466..ff5d4c97df494 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -354,6 +354,8 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 		file, mapping->host->i_ino, len, (long long) pos);
 
 	fgp |= fgf_set_order(len);
+	if (foliop_is_dropbehind(foliop))
+		fgp |= FGP_DONTCACHE;
 start:
 	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
 				    mapping_gfp_mask(mapping));
@@ -909,5 +911,6 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c280..83e2467b7c66f 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -467,4 +467,5 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+	.fop_flags	= FOP_DONTCACHE,
 };
-- 
2.44.0


