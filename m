Return-Path: <linux-fsdevel+bounces-36663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC129E7789
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8D62825B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17AF2206A9;
	Fri,  6 Dec 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGIiHYdR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CE220681;
	Fri,  6 Dec 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506672; cv=none; b=Avi5XKkQdu0vyUKgHD6tilhR/smpduOZkjspeZh1ovXI7h5Vv2ueykU5m48ZYrMWXE6tIqrvsyvjQzfNqlIHgd/1E7q8PaPhm6ReF442FpJeHlsnpoSPDB+aGHC0/u409ovaC+DufYCLoRojrm3CABMkWxZJyAZyOPJjAyHPVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506672; c=relaxed/simple;
	bh=IMQdqHnVMmnVveXaXPZhwcJ+Y+8PN18XLTmAIod2sbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ1UdzsrQ1GKFpp2GpJlon+oR/CWywjBMbZw/7fItImb0aeYaZd2ufhBTUfxNUZVoppICgbj5/8NhfWBeWIma4KCoWHLMLulUDnmLoMJs/2DoQWOSh/8bgbUXPuZ4QN2wYYh1wOuYAYgSfbREJDoXC2g4Fv05XWpC41LtlhVtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGIiHYdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB9CC4CED1;
	Fri,  6 Dec 2024 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733506671;
	bh=IMQdqHnVMmnVveXaXPZhwcJ+Y+8PN18XLTmAIod2sbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGIiHYdR5bhTNld8HW4xECXXWtPWfGDzIESExICVOVOz9y28SgY7ADMZlLRNj2rgU
	 AcKZJhCJ3ljbC5SzI7m47So1zwFp2eQBNmdTKrWbvrCACFGhl8Oza3jNC5pRmA8DuR
	 5ebXSTZRQ3MJ/SITEJlvoPbtSu1XlD1CULQfxaAo4WYtPZZ9WQHPH1B5DWrWxG0HTE
	 kBShH2hdeawqLnWvp/90Qc3yb0eQ9oJ/RUKbqYRJR8uLaZV2yeQI4wULudwLldhEVQ
	 bzh35laHmfui839t5ZR+1xCP9gagrWCTuwmGYmISmplelD4QHEdTeDRPW4sOr+pE0X
	 jMAeFDsQe/yJA==
Date: Fri, 6 Dec 2024 09:37:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
Message-ID: <20241206173751.GI7864@frogsfrogsfrogs>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>

On Tue, Dec 03, 2024 at 08:31:36AM -0700, Jens Axboe wrote:
> Hi,
> 
> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
> to do buffered IO that isn't page cache persistent. The approach back
> then was to have private pages for IO, and then get rid of them once IO
> was done. But that then runs into all the issues that O_DIRECT has, in
> terms of synchronizing with the page cache.
> 
> So here's a new approach to the same concent, but using the page cache
> as synchronization. That makes RWF_UNCACHED less special, in that it's
> just page cache IO, except it prunes the ranges once IO is completed.
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
> Common for both reads and writes with RWF_UNCACHED is that they use the
> page cache for IO. Reads work just like a normal buffered read would,
> with the only exception being that the touched ranges will get pruned
> after data has been copied. For writes, the ranges will get writeback
> kicked off before the syscall returns, and then writeback completion
> will prune the range. Hence writes aren't synchronous, and it's easy to
> pipeline writes using RWF_UNCACHED. Folios that aren't instantiated by
> RWF_UNCACHED IO are left untouched. This means you that uncached IO
> will take advantage of the page cache for uptodate data, but not leave
> anything it instantiated/created in cache.
> 
> File systems need to support this. The patches add support for the
> generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
> supporting it. The last patch adds support for btrfs as well, lightly
> tested. The read side is already done by filemap, only the write side
> needs a bit of help. The amount of code here is really trivial, and the
> only reason the fs opt-in is necessary is to have an RWF_UNCACHED IO
> return -EOPNOTSUPP just in case the fs doesn't use either the generic
> paths or iomap. Adding "support" to other file systems should be
> trivial, most of the time just a one-liner adding FOP_UNCACHED to the
> fop_flags in the file_operations struct.
> 
> Performance results are in patch 8 for reads and patch 10 for writes,
> with the tldr being that I see about a 65% improvement in performance
> for both, with fully predictable IO times. CPU reduction is substantial
> as well, with no kswapd activity at all for reclaim when using uncached
> IO.
> 
> Using it from applications is trivial - just set RWF_UNCACHED for the
> read or write, using pwritev2(2) or preadv2(2). For io_uring, same
> thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
> operation. And that's it.
> 
> Patches 1..7 are just prep patches, and should have no functional
> changes at all. Patch 8 adds support for the filemap path for
> RWF_UNCACHED reads, patch 11 adds support for filemap RWF_UNCACHED
> writes. In the below mentioned branch, there are then patches to
> adopt uncached reads and writes for ext4, xfs, and btrfs.
> 
> Passes full xfstests and fsx overnight runs, no issues observed. That
> includes the vm running the testing also using RWF_UNCACHED on the host.
> I'll post fsstress and fsx patches for RWF_UNCACHED separately. As far
> as I'm concerned, no further work needs doing here.
> 
> And git tree for the patches is here:
> 
> https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.8

Oh good, I much prefer browsing git branches these days. :)

 * mm/filemap: change filemap_create_folio() to take a struct kiocb
 * mm/readahead: add folio allocation helper
 * mm: add PG_uncached page flag
 * mm/readahead: add readahead_control->uncached member
 * mm/filemap: use page_cache_sync_ra() to kick off read-ahead
 * mm/truncate: add folio_unmap_invalidate() helper

The mm patches look ok to me, but I think you ought to get at least an
ack from willy since they're largely pagecache changes.

 * fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag

See more detailed reply in the thread.

 * mm/filemap: add read support for RWF_UNCACHED

Looks cleaner now that we don't even unmap the page if it's dirty.

 * mm/filemap: drop uncached pages when writeback completes
 * mm/filemap: add filemap_fdatawrite_range_kick() helper
 * mm/filemap: make buffered writes work with RWF_UNCACHED

See more detailed reply in the thread.

 * mm: add FGP_UNCACHED folio creation flag

I appreciate that !UNCACHED callers of __filemap_get_folio now clear the
uncached bit if it's set.

Now I proceed into the rest of your branch, because I felt like it:

 * ext4: add RWF_UNCACHED write support

(Dunno about the WARN_ON removals in this patch, but this is really
Ted's call anyway).

 * iomap: make buffered writes work with RWF_UNCACHED

The commit message references a "iocb_uncached_write" but I don't find
any such function in the extended patchset?  Otherwise this looks ready
to me.  Thanks for changing it only to set uncached if we're actually
creating a folio, and not just returning one that was already in the
pagecache.

 * xfs: punt uncached write completions to the completion wq

Dumb nit: spaces between "IOMAP_F_SHARED|IOMAP_F_UNCACHED" in this
patch.

 * xfs: flag as supporting FOP_UNCACHED

Otherwise the xfs changes look ready too.

 * btrfs: add support for uncached writes
 * block: support uncached IO

Not sure why the definition of bio_dirty_lock gets moved around, but in
principle this looks ok to me too.

For the whole pile of mm changes (aka patches 1-6,8-10,12),
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
>  include/linux/fs.h             |  21 +++++-
>  include/linux/page-flags.h     |   5 ++
>  include/linux/pagemap.h        |  14 ++++
>  include/trace/events/mmflags.h |   3 +-
>  include/uapi/linux/fs.h        |   6 +-
>  mm/filemap.c                   | 114 +++++++++++++++++++++++++++++----
>  mm/readahead.c                 |  22 +++++--
>  mm/swap.c                      |   2 +
>  mm/truncate.c                  |  35 ++++++----
>  9 files changed, 187 insertions(+), 35 deletions(-)
> 
> Since v5
> - Skip invalidation in filemap_uncached_read() if the folio is dirty
>   as well, retaining the uncached setting for later cleaning to do
>   the actual invalidation.
> - Use the same trylock approach in read invalidation as the writeback
>   invalidation does.
> - Swap order of patches 10 and 11 to fix a bisection issue.
> - Split core mm changes and fs series patches. Once the generic side
>   has been approved, I'll send out the fs series separately.
> - Rebase on 6.13-rc1
> 
> -- 
> Jens Axboe
> 
> 

