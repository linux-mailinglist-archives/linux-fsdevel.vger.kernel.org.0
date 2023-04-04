Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585B6D6ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjDDRpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDDRpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6DE5;
        Tue,  4 Apr 2023 10:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62078637F2;
        Tue,  4 Apr 2023 17:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E2C433EF;
        Tue,  4 Apr 2023 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680630317;
        bh=TpBGYWXmu0ZMaGTU1v7jdnC7b4ToMkNPMoF8eSBNQ+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFaRQ0VoJehYzrWSubRhHz8RyOqnULvx0LcTCLgZ3VXGdPm32meTPyfFVBklmCLrV
         LqoCMuzO6LOBGvkR78AFo0ShxW/nN3Lt/IVNiUwxtLdcGy97KufX23q5HwZHxOJ5ts
         Fg+oZcDbDwBH6zFjCnU5Meu1trIxN5V0mGG3SfnaZA20982Kqy4HU+4KaBs2nnGuyL
         cY0MBChG0HRjQWcUowOQIWOQ5hi/hjwQmDriAEI/aVMx1z0oJdOIv1nG05/cUZ+ZGb
         +EkoV4CnqJmMxgkFSQs8krRDrUH/ONSOGCH4v98VJvHNVx7flel3vv3WJ9KQOoPvTT
         zMHDYcCVAaf4Q==
Date:   Tue, 4 Apr 2023 10:45:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: Re: [PATCH v11 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <20230404174517.GF109974@frogsfrogsfrogs>
References: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:41:46AM +0000, Shiyang Ruan wrote:
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> (or mapped device) on it to unmap all files in use and notify processes
> who are using those files.
> 
> Call trace:
> trigger unbind
>  -> unbind_store()
>   -> ... (skip)
>    -> devres_release_all()
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
>       `-> freeze_super()
>       `-> do xfs rmap
>       ` -> mf_dax_kill_procs()
>       `  -> collect_procs_fsdax()    // all associated
>       `  -> unmap_and_kill()
>       ` -> invalidate_inode_pages2() // drop file's cache
>       `-> thaw_super()
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  Freeze the filesystem to prevent new dax mapping being created.
> And do not shutdown filesystem directly if something not supported, or
> if failure range includes metadata area.  Make sure all files and
> processes are handled correctly.  Also drop the cache of associated
> files before pmem is removed.
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  3 +-
>  fs/xfs/xfs_notify_failure.c | 56 +++++++++++++++++++++++++++++++++----
>  include/linux/mm.h          |  1 +
>  mm/memory-failure.c         | 17 ++++++++---
>  4 files changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4c4728a36e4..2e1a35e82fce 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
>  
>  	if (dax_dev->holder_data != NULL)
> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> +				MF_MEM_PRE_REMOVE);
>  
>  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>  	synchronize_srcu(&dax_srcu);
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index 1e2eddb8f90f..1b4eff43f9b5 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/dax.h>
> +#include <linux/fs.h>
>  
>  struct xfs_failure_info {
>  	xfs_agblock_t		startblock;
> @@ -73,10 +74,16 @@ xfs_dax_failure_fn(
>  	struct xfs_mount		*mp = cur->bc_mp;
>  	struct xfs_inode		*ip;
>  	struct xfs_failure_info		*notify = data;
> +	struct address_space		*mapping;
> +	pgoff_t				pgoff;
> +	unsigned long			pgcnt;
>  	int				error = 0;
>  
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* The device is about to be removed.  Not a really failure. */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		notify->want_shutdown = true;
>  		return 0;
>  	}
> @@ -92,10 +99,18 @@ xfs_dax_failure_fn(
>  		return 0;
>  	}
>  
> -	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> -				  xfs_failure_pgoff(mp, rec, notify),
> -				  xfs_failure_pgcnt(mp, rec, notify),
> -				  notify->mf_flags);
> +	mapping = VFS_I(ip)->i_mapping;
> +	pgoff = xfs_failure_pgoff(mp, rec, notify);
> +	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
> +
> +	/* Continue the rmap query if the inode isn't a dax file. */
> +	if (dax_mapping(mapping))
> +		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
> +				notify->mf_flags);
> +
> +	/* Invalidate the cache anyway. */
> +	invalidate_inode_pages2_range(mapping, pgoff, pgoff + pgcnt - 1);
> +
>  	xfs_irele(ip);
>  	return error;
>  }
> @@ -164,11 +179,25 @@ xfs_dax_notify_ddev_failure(
>  	}
>  
>  	xfs_trans_cancel(tp);
> +
> +	/* Unfreeze filesystem anyway if it is freezed before. */
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		error = thaw_super(mp->m_super);
> +		if (error)
> +			return error;

If someone *else* wanders in and thaws the fs, you'll get EINVAL here.

I guess that's useful for knowing if someone's screwed up the freeze
state on us, but ... really, don't you want to make sure you've gotten
the freeze and nobody else can take it away?

I think you want the kernel-initiated freeze proposed by Luis here:
https://lore.kernel.org/linux-fsdevel/20230114003409.1168311-4-mcgrof@kernel.org/

Also: Is Fujitsu still pursuing pmem products?  Even though Optane is
dead?  I'm no longer sure of what the roadmap is for all this fsdax code
and whatnot.

--D

> +	}
> +
> +	/*
> +	 * Determine how to shutdown the filesystem according to the
> +	 * error code and flags.
> +	 */
>  	if (error || notify.want_shutdown) {
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		if (!error)
>  			error = -EFSCORRUPTED;
> -	}
> +	} else if (mf_flags & MF_MEM_PRE_REMOVE)
> +		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> +
>  	return error;
>  }
>  
> @@ -182,6 +211,7 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
>  
>  	if (!(mp->m_super->s_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> @@ -196,6 +226,8 @@ xfs_dax_notify_failure(
>  
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> @@ -209,6 +241,12 @@ xfs_dax_notify_failure(
>  	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>  	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>  
> +	/* Notify failure on the whole device. */
> +	if (offset == 0 && len == U64_MAX) {
> +		offset = ddev_start;
> +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
> +	}
> +
>  	/* Ignore the range out of filesystem area */
>  	if (offset + len - 1 < ddev_start)
>  		return -ENXIO;
> @@ -225,6 +263,14 @@ xfs_dax_notify_failure(
>  	if (offset + len - 1 > ddev_end)
>  		len = ddev_end - offset + 1;
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		/* Freeze the filesystem to prevent new mappings created. */
> +		error = freeze_super(mp->m_super);
> +		if (error)
> +			return error;
> +	}
> +
>  	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
>  			mf_flags);
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f79667824eb..ac3f22c20e1d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3436,6 +3436,7 @@ enum mf_flags {
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
>  	MF_NO_RETRY = 1 << 6,
> +	MF_MEM_PRE_REMOVE = 1 << 7,
>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fae9baf3be16..6e6acec45568 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -623,7 +623,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>   */
>  static void collect_procs_fsdax(struct page *page,
>  		struct address_space *mapping, pgoff_t pgoff,
> -		struct list_head *to_kill)
> +		struct list_head *to_kill, bool pre_remove)
>  {
>  	struct vm_area_struct *vma;
>  	struct task_struct *tsk;
> @@ -631,8 +631,15 @@ static void collect_procs_fsdax(struct page *page,
>  	i_mmap_lock_read(mapping);
>  	read_lock(&tasklist_lock);
>  	for_each_process(tsk) {
> -		struct task_struct *t = task_early_kill(tsk, true);
> +		struct task_struct *t = tsk;
>  
> +		/*
> +		 * Search for all tasks while MF_MEM_PRE_REMOVE, because the
> +		 * current may not be the one accessing the fsdax page.
> +		 * Otherwise, search for the current task.
> +		 */
> +		if (!pre_remove)
> +			t = task_early_kill(tsk, true);
>  		if (!t)
>  			continue;
>  		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> @@ -1732,6 +1739,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  	dax_entry_t cookie;
>  	struct page *page;
>  	size_t end = index + count;
> +	bool pre_remove = mf_flags & MF_MEM_PRE_REMOVE;
>  
>  	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
>  
> @@ -1743,9 +1751,10 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		if (!page)
>  			goto unlock;
>  
> -		SetPageHWPoison(page);
> +		if (!pre_remove)
> +			SetPageHWPoison(page);
>  
> -		collect_procs_fsdax(page, mapping, index, &to_kill);
> +		collect_procs_fsdax(page, mapping, index, &to_kill, pre_remove);
>  		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
>  				index, mf_flags);
>  unlock:
> -- 
> 2.39.2
> 
