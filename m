Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CF517A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfFXPvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 11:51:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37474 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFXPvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:51:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFnPo5093890;
        Mon, 24 Jun 2019 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZJkWHA1Ir3UUoCYujr8Rku21r03VibQoMAT+2jQuxrE=;
 b=WXy9qQeg0ExNsQnQitLE65fFSJCAZMgqavdUN0rgZvl2vMGwOAtPUuyZy25KXdUjgnDp
 CME/QadsJh631N/L5pG7dLIL+5TE9UYNsph+aTInS7VeoCh49P5VbjnEzuFvTg/vype5
 wGPIQobMqPC+ZDAXn1lfplL0hmHdlXK8TtlfvOoRrrv2Hul4xKa6IQVc0tHowxRVnDFw
 dkeY6Bbie3OX2Ha1u9b39gdjqqD7pWpstoOPOvD45T3BqX9MWbQXwqA93g+Hu2O3qvwF
 C/1es7lu8gHK32JmJkwavJMxLVN9b0INDGFkqdzcVr0/lnUddLp0WuQkWWkQQpT1WthW Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brsy98y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:50:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFnM90052312;
        Mon, 24 Jun 2019 15:50:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tat7bqa3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:50:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OFokCg007981;
        Mon, 24 Jun 2019 15:50:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 08:50:45 -0700
Date:   Mon, 24 Jun 2019 08:50:43 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] xfs: use a struct iomap in xfs_writepage_ctx
Message-ID: <20190624155043.GL5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:46AM +0200, Christoph Hellwig wrote:
> In preparation for moving the XFS writeback code to fs/iomap.c, switch
> it to use struct iomap instead of the XFS-specific struct xfs_bmbt_irec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 14 +++++--
>  fs/xfs/libxfs/xfs_bmap.h |  3 +-
>  fs/xfs/xfs_aops.c        | 80 +++++++++++++++++++---------------------
>  fs/xfs/xfs_aops.h        |  2 +-
>  4 files changed, 50 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 4133bc461e3e..de35a0376156 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -39,6 +39,7 @@
>  #include "xfs_ag_resv.h"
>  #include "xfs_refcount.h"
>  #include "xfs_icache.h"
> +#include "xfs_iomap.h"
>  
>  
>  kmem_zone_t		*xfs_bmap_free_item_zone;
> @@ -4457,16 +4458,21 @@ int
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
> +
>  	/*
>  	 * Space for the extent and indirect blocks was reserved when the
>  	 * delalloc extent was created so there's no need to do so here.
> @@ -4496,7 +4502,7 @@ xfs_bmapi_convert_delalloc(
>  	 * the extent.  Just return the real extent at this offset.
>  	 */
>  	if (!isnullstartblock(bma.got.br_startblock)) {
> -		*imap = bma.got;
> +		xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
>  		*seq = READ_ONCE(ifp->if_seq);
>  		goto out_trans_cancel;
>  	}
> @@ -4529,7 +4535,7 @@ xfs_bmapi_convert_delalloc(
>  	XFS_STATS_INC(mp, xs_xstrat_quick);
>  
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
> -	*imap = bma.got;
> +	xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
>  	*seq = READ_ONCE(ifp->if_seq);
>  
>  	if (whichfork == XFS_COW_FORK) {
> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> index 8f597f9abdbe..3c3470f11648 100644
> --- a/fs/xfs/libxfs/xfs_bmap.h
> +++ b/fs/xfs/libxfs/xfs_bmap.h
> @@ -220,8 +220,7 @@ int	xfs_bmapi_reserve_delalloc(struct xfs_inode *ip, int whichfork,
>  		struct xfs_bmbt_irec *got, struct xfs_iext_cursor *cur,
>  		int eof);
>  int	xfs_bmapi_convert_delalloc(struct xfs_inode *ip, int whichfork,
> -		xfs_fileoff_t offset_fsb, struct xfs_bmbt_irec *imap,
> -		unsigned int *seq);
> +		xfs_off_t offset, struct iomap *iomap, unsigned int *seq);
>  int	xfs_bmap_add_extent_unwritten_real(struct xfs_trans *tp,
>  		struct xfs_inode *ip, int whichfork,
>  		struct xfs_iext_cursor *icur, struct xfs_btree_cur **curp,
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index dc60aec0c5a7..93a760f13017 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -27,7 +27,7 @@
>   * structure owned by writepages passed to individual writepage calls
>   */
>  struct xfs_writepage_ctx {
> -	struct xfs_bmbt_irec    imap;
> +	struct iomap		iomap;
>  	int			fork;
>  	unsigned int		data_seq;
>  	unsigned int		cow_seq;
> @@ -265,7 +265,7 @@ xfs_end_ioend(
>  	 */
>  	if (ioend->io_fork == XFS_COW_FORK)
>  		error = xfs_reflink_end_cow(ip, offset, size);
> -	else if (ioend->io_state == XFS_EXT_UNWRITTEN)
> +	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
>  	else
>  		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
> @@ -300,8 +300,8 @@ xfs_ioend_can_merge(
>  		return false;
>  	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
>  		return false;
> -	if ((ioend->io_state == XFS_EXT_UNWRITTEN) ^
> -	    (next->io_state == XFS_EXT_UNWRITTEN))
> +	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
> +	    (next->io_type == IOMAP_UNWRITTEN))
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> @@ -395,7 +395,7 @@ xfs_end_bio(
>  	unsigned long		flags;
>  
>  	if (ioend->io_fork == XFS_COW_FORK ||
> -	    ioend->io_state == XFS_EXT_UNWRITTEN ||
> +	    ioend->io_type == IOMAP_UNWRITTEN ||
>  	    ioend->io_append_trans != NULL) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
>  		if (list_empty(&ip->i_ioend_list))
> @@ -415,10 +415,10 @@ static bool
>  xfs_imap_valid(
>  	struct xfs_writepage_ctx	*wpc,
>  	struct xfs_inode		*ip,
> -	xfs_fileoff_t			offset_fsb)
> +	loff_t				offset)
>  {
> -	if (offset_fsb < wpc->imap.br_startoff ||
> -	    offset_fsb >= wpc->imap.br_startoff + wpc->imap.br_blockcount)
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length)
>  		return false;
>  	/*
>  	 * If this is a COW mapping, it is sufficient to check that the mapping
> @@ -445,7 +445,7 @@ xfs_imap_valid(
>  
>  /*
>   * Pass in a dellalloc extent and convert it to real extents, return the real
> - * extent that maps offset_fsb in wpc->imap.
> + * extent that maps offset_fsb in wpc->iomap.
>   *
>   * The current page is held locked so nothing could have removed the block
>   * backing offset_fsb, although it could have moved from the COW to the data
> @@ -455,23 +455,23 @@ static int
>  xfs_convert_blocks(
>  	struct xfs_writepage_ctx *wpc,
>  	struct xfs_inode	*ip,
> -	xfs_fileoff_t		offset_fsb)
> +	loff_t			offset)
>  {
>  	int			error;
>  
>  	/*
> -	 * Attempt to allocate whatever delalloc extent currently backs
> -	 * offset_fsb and put the result into wpc->imap.  Allocate in a loop
> -	 * because it may take several attempts to allocate real blocks for a
> -	 * contiguous delalloc extent if free space is sufficiently fragmented.
> +	 * Attempt to allocate whatever delalloc extent currently backs offset
> +	 * and put the result into wpc->imap.  Allocate in a loop because it may
> +	 * take several attempts to allocate real blocks for a contiguous
> +	 * delalloc extent if free space is sufficiently fragmented.
>  	 */
>  	do {
> -		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset_fsb,
> -				&wpc->imap, wpc->fork == XFS_COW_FORK ?
> +		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
> +				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
>  					&wpc->cow_seq : &wpc->data_seq);
>  		if (error)
>  			return error;
> -	} while (wpc->imap.br_startoff + wpc->imap.br_blockcount <= offset_fsb);
> +	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
>  
>  	return 0;
>  }
> @@ -511,7 +511,7 @@ xfs_map_blocks(
>  	 * against concurrent updates and provides a memory barrier on the way
>  	 * out that ensures that we always see the current value.
>  	 */
> -	if (xfs_imap_valid(wpc, ip, offset_fsb))
> +	if (xfs_imap_valid(wpc, ip, offset))
>  		return 0;
>  
>  	/*
> @@ -544,7 +544,7 @@ xfs_map_blocks(
>  	 * No COW extent overlap. Revalidate now that we may have updated
>  	 * ->cow_seq. If the data mapping is still valid, we're done.
>  	 */
> -	if (xfs_imap_valid(wpc, ip, offset_fsb)) {
> +	if (xfs_imap_valid(wpc, ip, offset)) {
>  		xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  		return 0;
>  	}
> @@ -584,11 +584,11 @@ xfs_map_blocks(
>  	    isnullstartblock(imap.br_startblock))
>  		goto allocate_blocks;
>  
> -	wpc->imap = imap;
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
>  	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
>  	return 0;
>  allocate_blocks:
> -	error = xfs_convert_blocks(wpc, ip, offset_fsb);
> +	error = xfs_convert_blocks(wpc, ip, offset);
>  	if (error) {
>  		/*
>  		 * If we failed to find the extent in the COW fork we might have
> @@ -608,12 +608,15 @@ xfs_map_blocks(
>  	 * original delalloc one.  Trim the return extent to the next COW
>  	 * boundary again to force a re-lookup.
>  	 */
> -	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF &&
> -	    cow_fsb < wpc->imap.br_startoff + wpc->imap.br_blockcount)
> -		wpc->imap.br_blockcount = cow_fsb - wpc->imap.br_startoff;
> +	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
> +		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
> +
> +		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
> +			wpc->iomap.length = cow_offset - wpc->iomap.offset;
> +	}
>  
> -	ASSERT(wpc->imap.br_startoff <= offset_fsb);
> -	ASSERT(wpc->imap.br_startoff + wpc->imap.br_blockcount > offset_fsb);
> +	ASSERT(wpc->iomap.offset <= offset);
> +	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
>  	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
>  	return 0;
>  }
> @@ -658,7 +661,7 @@ xfs_submit_ioend(
>  	/* Reserve log space if we might write beyond the on-disk inode size. */
>  	if (!status &&
>  	    (ioend->io_fork == XFS_COW_FORK ||
> -	     ioend->io_state != XFS_EXT_UNWRITTEN) &&
> +	     ioend->io_type != IOMAP_UNWRITTEN) &&
>  	    xfs_ioend_is_append(ioend) &&
>  	    !ioend->io_append_trans)
>  		status = xfs_setfilesize_trans_alloc(ioend);
> @@ -685,10 +688,8 @@ xfs_submit_ioend(
>  static struct xfs_ioend *
>  xfs_alloc_ioend(
>  	struct inode		*inode,
> -	int			fork,
> -	xfs_exntst_t		state,
> +	struct xfs_writepage_ctx *wpc,
>  	xfs_off_t		offset,
> -	struct block_device	*bdev,
>  	sector_t		sector,
>  	struct writeback_control *wbc)
>  {
> @@ -696,15 +697,15 @@ xfs_alloc_ioend(
>  	struct bio		*bio;
>  
>  	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
> -	bio_set_dev(bio, bdev);
> +	bio_set_dev(bio, wpc->iomap.bdev);
>  	bio->bi_iter.bi_sector = sector;
>  	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
>  	bio->bi_write_hint = inode->i_write_hint;
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_fork = fork;
> -	ioend->io_state = state;
> +	ioend->io_fork = wpc->fork;
> +	ioend->io_type = wpc->iomap.type;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> @@ -752,25 +753,20 @@ xfs_add_to_ioend(
>  	struct writeback_control *wbc,
>  	struct list_head	*iolist)
>  {
> -	struct xfs_inode	*ip = XFS_I(inode);
> -	struct xfs_mount	*mp = ip->i_mount;
> -	struct block_device	*bdev = xfs_find_bdev_for_inode(inode);
>  	unsigned		len = i_blocksize(inode);
>  	unsigned		poff = offset & (PAGE_SIZE - 1);
>  	sector_t		sector;
>  
> -	sector = xfs_fsb_to_db(ip, wpc->imap.br_startblock) +
> -		((offset - XFS_FSB_TO_B(mp, wpc->imap.br_startoff)) >> 9);
> +	sector = (wpc->iomap.addr + offset - wpc->iomap.offset) >> 9;
>  
>  	if (!wpc->ioend ||
>  	    wpc->fork != wpc->ioend->io_fork ||
> -	    wpc->imap.br_state != wpc->ioend->io_state ||
> +	    wpc->iomap.type != wpc->ioend->io_type ||
>  	    sector != bio_end_sector(wpc->ioend->io_bio) ||
>  	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
>  		if (wpc->ioend)
>  			list_add(&wpc->ioend->io_list, iolist);
> -		wpc->ioend = xfs_alloc_ioend(inode, wpc->fork,
> -				wpc->imap.br_state, offset, bdev, sector, wbc);
> +		wpc->ioend = xfs_alloc_ioend(inode, wpc, offset, sector, wbc);
>  	}
>  
>  	if (!__bio_try_merge_page(wpc->ioend->io_bio, page, len, poff, true)) {
> @@ -879,7 +875,7 @@ xfs_writepage_map(
>  		error = xfs_map_blocks(wpc, inode, file_offset);
>  		if (error)
>  			break;
> -		if (wpc->imap.br_startblock == HOLESTARTBLOCK)
> +		if (wpc->iomap.type == IOMAP_HOLE)
>  			continue;
>  		xfs_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
>  				 &submit_list);
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index f62b03186c62..72e30d1c3bdf 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -14,7 +14,7 @@ extern struct bio_set xfs_ioend_bioset;
>  struct xfs_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	int			io_fork;	/* inode fork written back */
> -	xfs_exntst_t		io_state;	/* extent state */
> +	u16			io_type;
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> -- 
> 2.20.1
> 
