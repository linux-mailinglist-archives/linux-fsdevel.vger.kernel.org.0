Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDDA56758E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiGER0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGER0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:26:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263E1CB03;
        Tue,  5 Jul 2022 10:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 953ADB817CE;
        Tue,  5 Jul 2022 17:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A384C341C7;
        Tue,  5 Jul 2022 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657041964;
        bh=4Zdi0gj1V9biGaqF3ho4TehXBAAmFn8ky14G82fpvD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuIzM+kSE1RzV7Diz++pApSM1OKkvA20PoCUL4AzVsM6Fu6zo8fLRDV65imgqVHq3
         L6d49PaGRnKO9dsrX63RxZ4ASWtzd2e8heQUD51/NzTPy0lTEbD4keI84B0EC0ZwhV
         K6w8kn+nokR9Mj5Ujxjwafj6LcRFfD+TrzpTL9xRzgpl5paAkBRPMFNLuBB/ZMjmwo
         IPVcSGNnE0BQWRYXc6vfjdnB25Y7mHFiKheqqsJD6Z691UxWDZ5Vo+HQCrTiJFYLb9
         Vp2uZIDYsoku9U4dxYZLCKk3C5dKO7l4HvyyP2w9TTqu5g6Kl95I0gGn0UrgFY/L4p
         7sGRKAVDEaPxw==
Date:   Tue, 5 Jul 2022 10:26:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [RFC PATCH v4] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YsR0K3wOUl3Ytc1R@magnolia>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220703130838.3518127-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703130838.3518127-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 09:08:38PM +0800, Shiyang Ruan wrote:
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
>    -> devres_release_all()   # was pmem driver ->remove() in v1
>     -> kill_dax()
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE)
>       -> xfs_dax_notify_failure()
> 
> Introduce MF_MEM_REMOVE to let filesystem know this is a remove event.
> So do not shutdown filesystem directly if something not supported, or if
> failure range includes metadata area.  Make sure all files and processes
> are handled correctly.
> 
> ==
> Changes since v3:
>   1. Flush dirty files and logs when pmem is about to be removed.
>   2. Rebased on next-20220701
> 
> Changes since v2:
>   1. Rebased on next-20220615
> 
> Changes since v1:
>   1. Drop the needless change of moving {kill,put}_dax()
>   2. Rebased on '[PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink'[2]
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2]: https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  2 +-
>  fs/xfs/xfs_notify_failure.c | 23 ++++++++++++++++++++++-
>  include/linux/mm.h          |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9b5e2a5eb0ae..d4bc83159d46 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -323,7 +323,7 @@ void kill_dax(struct dax_device *dax_dev)
>  		return;
> 
>  	if (dax_dev->holder_data != NULL)
> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE);
> 
>  	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>  	synchronize_srcu(&dax_srcu);
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index aa8dc27c599c..269e21b3341c 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -18,6 +18,7 @@
>  #include "xfs_rmap_btree.h"
>  #include "xfs_rtalloc.h"
>  #include "xfs_trans.h"
> +#include "xfs_log.h"
> 
>  #include <linux/mm.h>
>  #include <linux/dax.h>
> @@ -75,6 +76,10 @@ xfs_dax_failure_fn(
> 
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* Do not shutdown so early when device is to be removed */
> +		if (notify->mf_flags & MF_MEM_REMOVE) {
> +			return 0;
> +		}
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
>  	}
> @@ -168,6 +173,7 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
> 
>  	if (!(mp->m_sb.sb_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> @@ -182,6 +188,13 @@ xfs_dax_notify_failure(
> 
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_REMOVE) {
> +			/* Flush the log since device is about to be removed. */

If MF_MEM_REMOVE means "storage is about to go away" then perhaps the
only thing we need to do in xfs_dax_notify_failure is log a message
about the pending failure and then call sync_filesystem()?  This I think
could come before we even start looking at which device -- if any of the
filesystem blockdevs are about to be removed, the best we can do is
flush all the dirty data to disk.

--D

> +			error = xfs_log_force(mp, XFS_LOG_SYNC);
> +			if (error)
> +				return error;
> +			return -EOPNOTSUPP;
> +		}
>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> @@ -211,8 +224,16 @@ xfs_dax_notify_failure(
>  	if (offset + len > ddev_end)
>  		len -= ddev_end - offset;
> 
> -	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
> +	error = xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
>  			mf_flags);
> +	if (error)
> +		return error;
> +
> +	if (mf_flags & MF_MEM_REMOVE) {
> +		xfs_flush_inodes(mp);
> +		error = xfs_log_force(mp, XFS_LOG_SYNC);
> +	}
> +	return error;
>  }
> 
>  const struct dax_holder_operations xfs_dax_holder_operations = {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2270e35a676..e66d23188323 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3236,6 +3236,7 @@ enum mf_flags {
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
> +	MF_MEM_REMOVE = 1 << 6,
>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> --
> 2.36.1
> 
> 
> 
