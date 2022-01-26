Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA89F49D092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiAZRUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:20:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAZRUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:20:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A0661B01;
        Wed, 26 Jan 2022 17:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FEFC340E3;
        Wed, 26 Jan 2022 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643217643;
        bh=HOWUcGn+Ne0yghnHJ/JTu0kmJVm5jV/l9Vtq3A67YlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eo+8446w61uaICtTMWXGJP1Xpazgyckvmj+RJJPCafv0annEwwCgLdZjQepFP1tJP
         SN9apMejqQ2+skLYSrTKrUMXbUSEm4rOoTtmsRZ38FjUp2i8dmE03c9d3qLtrbJJc4
         yom+FUNj+RB5OQkbEZDDJ5fyJYSL+CVcGZt9iAoPTZt9pybvFMwgoJtuC5Hg+oCWA/
         x3I1B3RyYEIMOJOQ82cXK0v27y11sHIW6Hg2zRA1qc5A0GfLMuiu0N+hPzpvqKrsFe
         fmagQ6uD8ELFIkiFFPmrBHfO5POHnHneWCo3/wE1MEr9i24cbLlcynrxMaSnAVmmod
         6qhCGLDvcWQ/Q==
Date:   Wed, 26 Jan 2022 09:20:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs, iomap: limit individual ioend chain lengths in
 writeback
Message-ID: <20220126172042.GA13540@magnolia>
References: <20220120034733.221737-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120034733.221737-1-david@fromorbit.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:47:33PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Trond Myklebust reported soft lockups in XFS IO completion such as
> this:
> 
>  watchdog: BUG: soft lockup - CPU#12 stuck for 23s! [kworker/12:1:3106]
>  CPU: 12 PID: 3106 Comm: kworker/12:1 Not tainted 4.18.0-305.10.2.el8_4.x86_64 #1
>  Workqueue: xfs-conv/md127 xfs_end_io [xfs]
>  RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
>  Call Trace:
>   wake_up_page_bit+0x8a/0x110
>   iomap_finish_ioend+0xd7/0x1c0
>   iomap_finish_ioends+0x7f/0xb0
>   xfs_end_ioend+0x6b/0x100 [xfs]
>   xfs_end_io+0xb9/0xe0 [xfs]
>   process_one_work+0x1a7/0x360
>   worker_thread+0x1fa/0x390
>   kthread+0x116/0x130
>   ret_from_fork+0x35/0x40
> 
> Ioends are processed as an atomic completion unit when all the
> chained bios in the ioend have completed their IO. Logically
> contiguous ioends can also be merged and completed as a single,
> larger unit.  Both of these things can be problematic as both the
> bio chains per ioend and the size of the merged ioends processed as
> a single completion are both unbound.
> 
> If we have a large sequential dirty region in the page cache,
> write_cache_pages() will keep feeding us sequential pages and we
> will keep mapping them into ioends and bios until we get a dirty
> page at a non-sequential file offset. These large sequential runs
> can will result in bio and ioend chaining to optimise the io
> patterns. The pages iunder writeback are pinned within these chains
> until the submission chaining is broken, allowing the entire chain
> to be completed. This can result in huge chains being processed
> in IO completion context.
> 
> We get deep bio chaining if we have large contiguous physical
> extents. We will keep adding pages to the current bio until it is
> full, then we'll chain a new bio to keep adding pages for writeback.
> Hence we can build bio chains that map millions of pages and tens of
> gigabytes of RAM if the page cache contains big enough contiguous
> dirty file regions. This long bio chain pins those pages until the
> final bio in the chain completes and the ioend can iterate all the
> chained bios and complete them.
> 
> OTOH, if we have a physically fragmented file, we end up submitting
> one ioend per physical fragment that each have a small bio or bio
> chain attached to them. We do not chain these at IO submission time,
> but instead we chain them at completion time based on file
> offset via iomap_ioend_try_merge(). Hence we can end up with unbound
> ioend chains being built via completion merging.
> 
> XFS can then do COW remapping or unwritten extent conversion on that
> merged chain, which involves walking an extent fragment at a time
> and running a transaction to modify the physical extent information.
> IOWs, we merge all the discontiguous ioends together into a
> contiguous file range, only to then process them individually as
> discontiguous extents.
> 
> This extent manipulation is computationally expensive and can run in
> a tight loop, so merging logically contiguous but physically
> discontigous ioends gains us nothing except for hiding the fact the
> fact we broke the ioends up into individual physical extents at
> submission and then need to loop over those individual physical
> extents at completion.
> 
> Hence we need to have mechanisms to limit ioend sizes and
> to break up completion processing of large merged ioend chains:
> 
> 1. bio chains per ioend need to be bound in length. Pure overwrites
> go straight to iomap_finish_ioend() in softirq context with the
> exact bio chain attached to the ioend by submission. Hence the only
> way to prevent long holdoffs here is to bound ioend submission
> sizes because we can't reschedule in softirq context.
> 
> 2. iomap_finish_ioends() has to handle unbound merged ioend chains
> correctly. This relies on any one call to iomap_finish_ioend() being
> bound in runtime so that cond_resched() can be issued regularly as
> the long ioend chain is processed. i.e. this relies on mechanism #1
> to limit individual ioend sizes to work correctly.
> 
> 3. filesystems have to loop over the merged ioends to process
> physical extent manipulations. This means they can loop internally,
> and so we break merging at physical extent boundaries so the
> filesystem can easily insert reschedule points between individual
> extent manipulations.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reported-and-tested-by: Trond Myklebust <trondmy@hammerspace.com>

Looks good, sorry I didn't get to this earlier...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++++++++++++++----
>  fs/xfs/xfs_aops.c      | 16 ++++++++++++-
>  include/linux/iomap.h  |  2 ++
>  3 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c938bbad075e..6c51a75d0be6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -21,6 +21,8 @@
>  
>  #include "../internal.h"
>  
> +#define IOEND_BATCH_SIZE	4096
> +
>  /*
>   * Structure allocated for each folio when block size < folio size
>   * to track sub-folio uptodate status and I/O completions.
> @@ -1039,7 +1041,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>   * state, release holds on bios, and finally free up memory.  Do not use the
>   * ioend after this.
>   */
> -static void
> +static u32
>  iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  {
>  	struct inode *inode = ioend->io_inode;
> @@ -1048,6 +1050,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  	u64 start = bio->bi_iter.bi_sector;
>  	loff_t offset = ioend->io_offset;
>  	bool quiet = bio_flagged(bio, BIO_QUIET);
> +	u32 folio_count = 0;
>  
>  	for (bio = &ioend->io_inline_bio; bio; bio = next) {
>  		struct folio_iter fi;
> @@ -1062,9 +1065,11 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  			next = bio->bi_private;
>  
>  		/* walk all folios in bio, ending page IO on them */
> -		bio_for_each_folio_all(fi, bio)
> +		bio_for_each_folio_all(fi, bio) {
>  			iomap_finish_folio_write(inode, fi.folio, fi.length,
>  					error);
> +			folio_count++;
> +		}
>  		bio_put(bio);
>  	}
>  	/* The ioend has been freed by bio_put() */
> @@ -1074,20 +1079,36 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  "%s: writeback error on inode %lu, offset %lld, sector %llu",
>  			inode->i_sb->s_id, inode->i_ino, offset, start);
>  	}
> +	return folio_count;
>  }
>  
> +/*
> + * Ioend completion routine for merged bios. This can only be called from task
> + * contexts as merged ioends can be of unbound length. Hence we have to break up
> + * the writeback completions into manageable chunks to avoid long scheduler
> + * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
> + * good batch processing throughput without creating adverse scheduler latency
> + * conditions.
> + */
>  void
>  iomap_finish_ioends(struct iomap_ioend *ioend, int error)
>  {
>  	struct list_head tmp;
> +	u32 completions;
> +
> +	might_sleep();
>  
>  	list_replace_init(&ioend->io_list, &tmp);
> -	iomap_finish_ioend(ioend, error);
> +	completions = iomap_finish_ioend(ioend, error);
>  
>  	while (!list_empty(&tmp)) {
> +		if (completions > IOEND_BATCH_SIZE * 8) {
> +			cond_resched();
> +			completions = 0;
> +		}
>  		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
>  		list_del_init(&ioend->io_list);
> -		iomap_finish_ioend(ioend, error);
> +		completions += iomap_finish_ioend(ioend, error);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_ioends);
> @@ -1108,6 +1129,18 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> +	/*
> +	 * Do not merge physically discontiguous ioends. The filesystem
> +	 * completion functions will have to iterate the physical
> +	 * discontiguities even if we merge the ioends at a logical level, so
> +	 * we don't gain anything by merging physical discontiguities here.
> +	 *
> +	 * We cannot use bio->bi_iter.bi_sector here as it is modified during
> +	 * submission so does not point to the start sector of the bio at
> +	 * completion.
> +	 */
> +	if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
> +		return false;
>  	return true;
>  }
>  
> @@ -1209,8 +1242,10 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>  	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
> +	ioend->io_folios = 0;
>  	ioend->io_offset = offset;
>  	ioend->io_bio = bio;
> +	ioend->io_sector = sector;
>  	return ioend;
>  }
>  
> @@ -1251,6 +1286,13 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
>  		return false;
>  	if (sector != bio_end_sector(wpc->ioend->io_bio))
>  		return false;
> +	/*
> +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> +	 * also prevents long tight loops ending page writeback on all the
> +	 * folios in the ioend.
> +	 */
> +	if (wpc->ioend->io_folios >= IOEND_BATCH_SIZE)
> +		return false;
>  	return true;
>  }
>  
> @@ -1335,6 +1377,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  				 &submit_list);
>  		count++;
>  	}
> +	if (count)
> +		wpc->ioend->io_folios++;
>  
>  	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
>  	WARN_ON_ONCE(!folio_test_locked(folio));
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2705f91bdd0d..9d6a67c7d227 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -136,7 +136,20 @@ xfs_end_ioend(
>  	memalloc_nofs_restore(nofs_flag);
>  }
>  
> -/* Finish all pending io completions. */
> +/*
> + * Finish all pending IO completions that require transactional modifications.
> + *
> + * We try to merge physical and logically contiguous ioends before completion to
> + * minimise the number of transactions we need to perform during IO completion.
> + * Both unwritten extent conversion and COW remapping need to iterate and modify
> + * one physical extent at a time, so we gain nothing by merging physically
> + * discontiguous extents here.
> + *
> + * The ioend chain length that we can be processing here is largely unbound in
> + * length and we may have to perform significant amounts of work on each ioend
> + * to complete it. Hence we have to be careful about holding the CPU for too
> + * long in this loop.
> + */
>  void
>  xfs_end_io(
>  	struct work_struct	*work)
> @@ -157,6 +170,7 @@ xfs_end_io(
>  		list_del_init(&ioend->io_list);
>  		iomap_ioend_try_merge(ioend, &tmp);
>  		xfs_end_ioend(ioend);
> +		cond_resched();
>  	}
>  }
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b55bd49e55f5..97a3a2edb585 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -263,9 +263,11 @@ struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_type;
>  	u16			io_flags;	/* IOMAP_F_* */
> +	u32			io_folios;	/* folios added to ioend */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
> +	sector_t		io_sector;	/* start sector of ioend */
>  	struct bio		*io_bio;	/* bio being built */
>  	struct bio		io_inline_bio;	/* MUST BE LAST! */
>  };
> -- 
> 2.33.0
> 
