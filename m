Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39DC4FEBBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 02:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiDMAGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDMAGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 20:06:47 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97DC59FD1;
        Tue, 12 Apr 2022 17:04:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6345553451E;
        Wed, 13 Apr 2022 10:04:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1neQUh-00H19U-LP; Wed, 13 Apr 2022 10:04:23 +1000
Date:   Wed, 13 Apr 2022 10:04:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v12 6/7] xfs: Implement ->notify_failure() for XFS
Message-ID: <20220413000423.GK1544202@dread.disaster.area>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
 <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6256138a
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=4dCMZFeZnbfWj20spA0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:09:03AM +0800, Shiyang Ruan wrote:
> Introduce xfs_notify_failure.c to handle failure related works, such as
> implement ->notify_failure(), register/unregister dax holder in xfs, and
> so on.
> 
> If the rmap feature of XFS enabled, we can query it to find files and
> metadata which are associated with the corrupt data.  For now all we do
> is kill processes with that file mapped into their address spaces, but
> future patches could actually do something about corrupt metadata.
> 
> After that, the memory failure needs to notify the processes who are
> using those files.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/Makefile             |   5 +
>  fs/xfs/xfs_buf.c            |   7 +-
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 219 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_super.h          |   1 +
>  6 files changed, 233 insertions(+), 3 deletions(-)
>  create mode 100644 fs/xfs/xfs_notify_failure.c
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 04611a1068b4..09f5560e29f2 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -128,6 +128,11 @@ xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
>  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
>  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
>  
> +# notify failure
> +ifeq ($(CONFIG_MEMORY_FAILURE),y)
> +xfs-$(CONFIG_FS_DAX)		+= xfs_notify_failure.o
> +endif
> +
>  # online scrub/repair
>  ifeq ($(CONFIG_XFS_ONLINE_SCRUB),y)
>  
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index f9ca08398d32..9064b8dfbc66 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -5,6 +5,7 @@
>   */
>  #include "xfs.h"
>  #include <linux/backing-dev.h>
> +#include <linux/dax.h>
>  
>  #include "xfs_shared.h"
>  #include "xfs_format.h"
> @@ -1911,7 +1912,7 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> -	fs_put_dax(btp->bt_daxdev, NULL);
> +	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  
>  	kmem_free(btp);
>  }
> @@ -1964,8 +1965,8 @@ xfs_alloc_buftarg(
>  	btp->bt_mount = mp;
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
> -	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, NULL,
> -					    NULL);
> +	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, mp,
> +					    &xfs_dax_holder_operations);

I see a problem with this: we are setting up notify callbacks before
we've even read in the superblock during mount. i.e. we don't even
kow yet if we've got an XFS filesystem on this block device.

Hence if we get a notification immediately after registering this
notification callback....

[...]

> +
> +static int
> +xfs_dax_notify_ddev_failure(
> +	struct xfs_mount	*mp,
> +	xfs_daddr_t		daddr,
> +	xfs_daddr_t		bblen,
> +	int			mf_flags)
> +{
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_buf		*agf_bp = NULL;
> +	int			error = 0;
> +	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
> +	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);

.... none of this code is going to function correctly because it
is dependent on the superblock having been read, validated and
copied to the in-memory superblock.

> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;

... and it's not valid to use transactions (even empty ones) before
log recovery has completed and set the log up correctly.

> +
> +	for (; agno <= end_agno; agno++) {
> +		struct xfs_rmap_irec	ri_low = { };
> +		struct xfs_rmap_irec	ri_high;
> +		struct failure_info	notify;
> +		struct xfs_agf		*agf;
> +		xfs_agblock_t		agend;
> +
> +		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +		if (error)
> +			break;
> +
> +		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);

... and none of the structures this rmapbt walk is dependent on
(e.g. perag structures) have been initialised yet so there's null
pointer dereferences going to happen here.

Perhaps even worse is that the rmapbt is not guaranteed to be in
consistent state until after log recovery has completed, so this
walk could get stuck forever in a stale on-disk cycle that
recovery would have corrected....

Hence these notifications need to be delayed until after the
filesystem is mounted, all the internal structures have been set up
and log recovery has completed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
