Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2D5B8EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiINSPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiINSPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:15:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B69C24F31;
        Wed, 14 Sep 2022 11:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87798B81ADA;
        Wed, 14 Sep 2022 18:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A828C433D7;
        Wed, 14 Sep 2022 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663179328;
        bh=YbrYZ2ZhBJ5O8mFVCmYlQVg9rRG+9+sMUn6FrqNFaEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEX3cu8amwYEdl+IULxHyJbZrZI5Lw18m2LldchYADZr0be/U0CVllE2UkRLyMdPW
         UCKSEqCkmcj9JkRCElboZVVQ7lAJZDdKnRVszR3g7MTyM60gsiMUTLC+TD44/zcrsN
         8b1Ws5hTHeN2DQgwwygjWxhTH6R4VnZmyROYU0It6QCMY958Dbz0qn4qTRoCcTSGde
         Ls68gD5h1e/z4f/ph0BHPJnBPiFNDPRYfZWAWs7Yb9H6dSMsXqz0u5s+dphjTjiyGs
         6XSmRdI7WV2jhHjFVzC9eWFT18yVfgFlSUwxANMHwFtaWvDgX8TRp9Kbi6nbsI5/ra
         eArXctOiIXHDQ==
Date:   Wed, 14 Sep 2022 11:15:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YyIaP4EFNaYhqKkQ@magnolia>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1662114961-66-4-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662114961-66-4-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:36:01AM +0000, Shiyang Ruan wrote:
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
>      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>       -> xfs_dax_notify_failure()
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  So do not shutdown filesystem directly if something not
> supported, or if failure range includes metadata area.  Make sure all
> files and processes are handled correctly.
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/dax/super.c         |  3 ++-
>  fs/xfs/xfs_notify_failure.c | 23 +++++++++++++++++++++++
>  include/linux/mm.h          |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9b5e2a5eb0ae..cf9a64563fbe 100644
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
> index 3830f908e215..5e04ba7fa403 100644
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
> @@ -77,6 +78,9 @@ xfs_dax_failure_fn(
>  
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* The device is about to be removed.  Not a really failure. */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		notify->want_shutdown = true;
>  		return 0;
>  	}
> @@ -182,12 +186,23 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
>  
>  	if (!(mp->m_super->s_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>  		return -EIO;
>  	}
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);
> +		drop_pagecache_sb(mp->m_super, NULL);
> +		up_write(&mp->m_super->s_umount);
> +		if (error)
> +			return error;
> +	}
> +
>  	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>  		xfs_debug(mp,
>  			 "notify_failure() not supported on realtime device!");
> @@ -196,6 +211,8 @@ xfs_dax_notify_failure(
>  
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> @@ -209,6 +226,12 @@ xfs_dax_notify_failure(
>  	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
>  	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>  
> +	/* Notify failure on the whole device */
> +	if (offset == 0 && len == U64_MAX) {
> +		offset = ddev_start;
> +		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
> +	}

I wonder, won't the trimming code below take care of this?

The rest of the patch looks ok to me.

--D

> +
>  	/* Ignore the range out of filesystem area */
>  	if (offset + len - 1 < ddev_start)
>  		return -ENXIO;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21f8b27bd9fd..9122a1c57dd2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3183,6 +3183,7 @@ enum mf_flags {
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
>  	MF_NO_RETRY = 1 << 6,
> +	MF_MEM_PRE_REMOVE = 1 << 7,
>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> -- 
> 2.37.2
> 
