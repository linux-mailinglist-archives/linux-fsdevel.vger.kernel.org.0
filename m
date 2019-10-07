Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC702CEEA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 23:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJGVy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 17:54:29 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47802 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728422AbfJGVy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:54:29 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DFACC362CC0;
        Tue,  8 Oct 2019 08:54:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHaxU-0001jh-0r; Tue, 08 Oct 2019 08:54:24 +1100
Date:   Tue, 8 Oct 2019 08:54:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH 08/11] xfs: use a struct iomap in xfs_writepage_ctx
Message-ID: <20191007215423.GB16973@dread.disaster.area>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006154608.24738-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=oSRWnQKYtL-N8EWQpG8A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 05:46:05PM +0200, Christoph Hellwig wrote:
> In preparation for moving the XFS writeback code to fs/iomap.c, switch
> it to use struct iomap instead of the XFS-specific struct xfs_bmbt_irec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 14 +++++--
>  fs/xfs/libxfs/xfs_bmap.h |  3 +-
>  fs/xfs/xfs_aops.c        | 82 +++++++++++++++++++---------------------
>  fs/xfs/xfs_aops.h        |  2 +-
>  4 files changed, 50 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 4edc25a2ba80..d0e7f9ef7b85 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -34,6 +34,7 @@
>  #include "xfs_ag_resv.h"
>  #include "xfs_refcount.h"
>  #include "xfs_icache.h"
> +#include "xfs_iomap.h"
>  
>  
>  kmem_zone_t		*xfs_bmap_free_item_zone;
> @@ -4454,16 +4455,21 @@ int
>  xfs_bmapi_convert_delalloc(
>  	struct xfs_inode	*ip,
>  	int			whichfork,
> -	xfs_fileoff_t		offset_fsb,
> -	struct xfs_bmbt_irec	*imap,
> +	xfs_off_t		offset,
> +	struct iomap		*iomap,
>  	unsigned int		*seq)
>  {
>  	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, whichfork);
>  	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	struct xfs_bmalloca	bma = { NULL };
> +	u16			flags = 0;
>  	struct xfs_trans	*tp;
>  	int			error;
>  
> +	if (whichfork == XFS_COW_FORK)
> +		flags |= IOMAP_F_SHARED;

That seems out of place - I don't see anywhere in this patch that
moves/removes setting the IOMAP_F_SHARED flag. i.e this looks like a
change of behaviour....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
