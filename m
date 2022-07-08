Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D256BD8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiGHP2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiGHP2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6BB86B;
        Fri,  8 Jul 2022 08:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 862B5611FD;
        Fri,  8 Jul 2022 15:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA87C341C0;
        Fri,  8 Jul 2022 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657294113;
        bh=5LLM7Cns9F5FvxVMK5IvuU4OHW00Kt7A5+RS/2YlNSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxYu2yBLmGmn5ptn0dHqkO9nJiSNK2GQ9BtHbLGDjk7nUYDPhr85sKxBVg/TG83md
         OP+CsK+t4Jv9EJ0x8/ZuJB6djKsMi5bg8vJ52JySOH26zyyosqzEXqIj//6+6gl/Cp
         t7aarVM0kcOullnmKsGw6WyATVGsSzavbuRe20EXaU8Pk94gz60wdoe4MtMllESdxQ
         QH1mwr5jC1OaACAjlcC4yGQAKYfyBuveyk+bbDbBk+hhQlc6M1rbqAYIE/ntF2VfzS
         yki9WBxft/JYP14FlBL7Ljfx3isN8lX+54aXDs9+S6AGghGKnpx6yY7ZiButI62hC4
         qQg9rO+2P8Wig==
Date:   Fri, 8 Jul 2022 08:28:33 -0700
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
Subject: Re: [RFC PATCH v5] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <YshNIbT5YxcjGaCr@magnolia>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220708054216.825004-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708054216.825004-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 05:42:22AM +0000, ruansy.fnst@fujitsu.com wrote:
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
> Changes since v4:
>   1. sync_filesystem() at the beginning when MF_MEM_REMOVE
>   2. Rebased on next-20220706
> 
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
>  fs/xfs/xfs_notify_failure.c | 16 ++++++++++++++++
>  include/linux/mm.h          |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
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
> index aa8dc27c599c..728b0c1d0ddf 100644
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

Nit: no curly braces needed here.

>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
>  	}
> @@ -168,6 +173,14 @@ xfs_dax_notify_failure(
>  	struct xfs_mount	*mp = dax_holder(dax_dev);
>  	u64			ddev_start;
>  	u64			ddev_end;
> +	int			error;
> +
> +	if (mf_flags & MF_MEM_REMOVE) {
> +		xfs_info(mp, "device is about to be removed!");
> +		error = sync_filesystem(mp->m_super);

sync_filesystem requires callers to hold s_umount.  Does the dax media
failure code take that lock for us, or is this missing a lock?

Also, I'm not sure it's a good idea to sync_filesystem() before checking
if SB_BORN has been set.

> +		if (error)
> +			return error;
> +	}
>  
>  	if (!(mp->m_sb.sb_flags & SB_BORN)) {
>  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> @@ -182,6 +195,9 @@ xfs_dax_notify_failure(
>  
>  	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>  	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_REMOVE) {
> +			return 0;
> +		}

Same nit about not needing curly braces.

>  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>  		return -EFSCORRUPTED;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 794ad19b57f8..3eab2d7ba884 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3240,6 +3240,7 @@ enum mf_flags {
>  	MF_UNPOISON = 1 << 4,
>  	MF_SW_SIMULATED = 1 << 5,
>  	MF_NO_RETRY = 1 << 6,
> +	MF_MEM_REMOVE = 1 << 7,

This is more of a pre-removal notification, right?  I think the flag
value ought to be named that way too (MF_MEM_PRE_REMOVE).

--D

>  };
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
> -- 
> 2.37.0
