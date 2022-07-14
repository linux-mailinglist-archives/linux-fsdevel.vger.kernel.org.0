Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE6575446
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiGNRyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiGNRyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:54:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132F27177;
        Thu, 14 Jul 2022 10:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBDCAB82779;
        Thu, 14 Jul 2022 17:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEAAC34114;
        Thu, 14 Jul 2022 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657821255;
        bh=LgU+sYC6IUyCyX2o7fwrVIJ7cvKYLuT2/55WRReuVuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miK77TVEWJzTCgxOunLKwtg+bA4M2rbSH6kRxi8PeaYxE7T8a2fQkRJDBoyTOQjZ+
         P39e07+GfiM2KD0lvYiJd7QQNy6dpTtGIa9KUi8/E/0iSLcQ7JkUECWw1g4A6N71OO
         vv6++OCRidDQp0ekvihKIjwcgtB2DJ0URyILgMWdcpEwdnMZEGlwhkInw+RBelqDba
         soOqdmPgEN1XHEVM28Oln3izsHpXswM711d3W9X6m5wyEtnESil+ozOdJKGo27IykI
         nMU+ORrvI3wjsw+mC5KORWbTjzq7Au2FR7PlORe/B75JNMKd39FfyoIPGpzEX6SY7T
         lIHJXqNKwc21w==
Date:   Thu, 14 Jul 2022 10:54:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YtBYRrkSkuF4VU5e@magnolia>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:34:29AM +0000, ruansy.fnst@fujitsu.com wrote:
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
> ==
> Changes since v5:
>   1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
>   2. hold s_umount before sync_filesystem()
>   3. move sync_filesystem() after SB_BORN check
>   4. Rebased on next-20220714
> 
> Changes since v4:
>   1. sync_filesystem() at the beginning when MF_MEM_REMOVE
>   2. Rebased on next-20220706
> 
> [1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks reasonable to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  drivers/dax/super.c         |  3 ++-
>  fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
>  include/linux/mm.h          |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
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
> index 69d9c83ea4b2..6da6747435eb 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -76,6 +76,9 @@ xfs_dax_failure_fn(
>  
>  	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* Do not shutdown so early when device is to be removed */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
>  	}
> @@ -174,12 +177,22 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
>  
>  	if (!(mp->m_sb.sb_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>  		return -EIO;
>  	}
>  
> +	if (mf_flags & MF_MEM_PRE_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);
> +		up_write(&mp->m_super->s_umount);
> +		if (error)
> +			return error;
> +	}
> +
>  	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>  		xfs_warn(mp,
>  			 "notify_failure() not supported on realtime device!");
> @@ -188,6 +201,8 @@ xfs_dax_notify_failure(
>  
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4287bec50c28..2ddfb76c8a83 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3188,6 +3188,7 @@ enum mf_flags {
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
> +	MF_MEM_PRE_REMOVE = 1 << 6,
>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> -- 
> 2.37.0
