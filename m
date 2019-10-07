Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA640CEEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 23:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfJGV7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 17:59:49 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50395 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728422AbfJGV7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:59:49 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6720E3639CD;
        Tue,  8 Oct 2019 08:59:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHb2e-0001sm-E9; Tue, 08 Oct 2019 08:59:44 +1100
Date:   Tue, 8 Oct 2019 08:59:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH 09/11] xfs: remove the fork fields in the writepage_ctx
 and ioend
Message-ID: <20191007215944.GC16973@dread.disaster.area>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006154608.24738-10-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=pWr0rBs94VfbQ7lI_PoA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 05:46:06PM +0200, Christoph Hellwig wrote:
> In preparation for moving the writeback code to iomap.c, replace the
> XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.

"In preparation for switching XFS to use the fs/iomap writeback
code..."?

I suspect the IOMAP_F_SHARED hunk I pointed out in the previous
patch should be in this one...

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/xfs/xfs_aops.c | 42 ++++++++++++++++++++++--------------------
>  fs/xfs/xfs_aops.h |  2 +-
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9f22885902ef..8c101081e3b1 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -23,7 +23,6 @@
>   */
>  struct xfs_writepage_ctx {
>  	struct iomap		iomap;
> -	int			fork;
>  	unsigned int		data_seq;
>  	unsigned int		cow_seq;
>  	struct xfs_ioend	*ioend;
> @@ -257,7 +256,7 @@ xfs_end_ioend(
>  	 */
>  	error = blk_status_to_errno(ioend->io_bio->bi_status);
>  	if (unlikely(error)) {
> -		if (ioend->io_fork == XFS_COW_FORK)
> +		if (ioend->io_flags & IOMAP_F_SHARED)
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
>  		goto done;
>  	}
> @@ -265,7 +264,7 @@ xfs_end_ioend(
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> -	if (ioend->io_fork == XFS_COW_FORK)
> +	if (ioend->io_flags & IOMAP_F_SHARED)
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
> @@ -298,7 +297,8 @@ xfs_ioend_can_merge(
>  {
>  	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
>  		return false;
> -	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ^
> +	    (next->io_flags & IOMAP_F_SHARED))
>  		return false;
>  	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
>  	    (next->io_type == IOMAP_UNWRITTEN))

These probably should be indented too, as they are continuations,
not separate logic statements.

> @@ -768,7 +769,8 @@ xfs_add_to_ioend(
>  	bool			merged, same_page = false;
>  
>  	if (!wpc->ioend ||
> -	    wpc->fork != wpc->ioend->io_fork ||
> +	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
> +	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||

Same here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
