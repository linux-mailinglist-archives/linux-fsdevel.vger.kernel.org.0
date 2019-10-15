Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7641D7E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfJOSFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:05:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:05:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmZjA099337;
        Tue, 15 Oct 2019 18:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=h/pDF50/xZASrhrF1O6hc1+y21gJKm84vSqY9+7tmaY=;
 b=DhtzFjYLry5GdvhS10jg/waTEXGMP9nYMbqylT0o9pRurOoRsfRq3CBZoDLLSxEWDZEi
 H09Yr5IrWQOtL4Ha24tPabPy9ysibUt6InHQitacVXlZGQ+3LQBZZN0DV9FALP9WvozT
 of78y19qcifDdC1qQ6+vo/xUajfCtXDtpIMHjyB7oceMtPaXzzB8enmGQ0bRDPGSuZh8
 E3/oItJU9/Bifnx2sZh+0inLEnr2yQdJUAOH+CYUxdOmpBayXVn3M5i9U1DnmNaBUFeR
 nO7HCvPMrozOU73Hbx3ckqSHDDZV7seQYtr0SRzd2bt8davPfKnpi2+uI096hNqPCCbW Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68uhw1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:05:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmH2F048939;
        Tue, 15 Oct 2019 18:05:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vnf7rnvy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:05:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FI5HQk008960;
        Tue, 15 Oct 2019 18:05:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 18:05:15 +0000
Date:   Tue, 15 Oct 2019 11:05:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: remove the fork fields in the writepage_ctx
 and ioend
Message-ID: <20191015180514.GS13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:39PM +0200, Christoph Hellwig wrote:
> In preparation for moving the writeback code to iomap.c, replace the
> XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 71 ++++++++++++++++++++++++++++++-----------------
>  fs/xfs/xfs_aops.h |  2 +-
>  2 files changed, 46 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index df5955388adc..00fe40b35f72 100644
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
> @@ -272,7 +271,7 @@ xfs_end_ioend(
>  	 */
>  	error = blk_status_to_errno(ioend->io_bio->bi_status);
>  	if (unlikely(error)) {
> -		if (ioend->io_fork == XFS_COW_FORK)
> +		if (ioend->io_flags & IOMAP_F_SHARED)
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
>  		goto done;
>  	}
> @@ -280,7 +279,7 @@ xfs_end_ioend(
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> -	if (ioend->io_fork == XFS_COW_FORK)
> +	if (ioend->io_flags & IOMAP_F_SHARED)
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
> @@ -304,7 +303,8 @@ xfs_ioend_can_merge(
>  {
>  	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
>  		return false;
> -	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ^
> +	    (next->io_flags & IOMAP_F_SHARED))
>  		return false;
>  	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
>  	    (next->io_type == IOMAP_UNWRITTEN))
> @@ -404,6 +404,13 @@ xfs_end_io(
>  	}
>  }
>  
> +static inline bool xfs_ioend_needs_workqueue(struct xfs_ioend *ioend)
> +{
> +	return ioend->io_private ||
> +		ioend->io_type == IOMAP_UNWRITTEN ||
> +		(ioend->io_flags & IOMAP_F_SHARED);
> +}
> +
>  STATIC void
>  xfs_end_bio(
>  	struct bio		*bio)
> @@ -413,9 +420,7 @@ xfs_end_bio(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	unsigned long		flags;
>  
> -	if (ioend->io_fork == XFS_COW_FORK ||
> -	    ioend->io_type == IOMAP_UNWRITTEN ||
> -	    ioend->io_private) {
> +	if (xfs_ioend_needs_workqueue(ioend)) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
>  		if (list_empty(&ip->i_ioend_list))
>  			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> @@ -444,7 +449,7 @@ xfs_imap_valid(
>  	 * covers the offset. Be careful to check this first because the caller
>  	 * can revalidate a COW mapping without updating the data seqno.
>  	 */
> -	if (wpc->fork == XFS_COW_FORK)
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
>  		return true;
>  
>  	/*
> @@ -474,6 +479,7 @@ static int
>  xfs_convert_blocks(
>  	struct xfs_writepage_ctx *wpc,
>  	struct xfs_inode	*ip,
> +	int			whichfork,
>  	loff_t			offset)
>  {
>  	int			error;
> @@ -485,8 +491,8 @@ xfs_convert_blocks(
>  	 * delalloc extent if free space is sufficiently fragmented.
>  	 */
>  	do {
> -		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
> -				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
> +		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
> +				&wpc->iomap, whichfork == XFS_COW_FORK ?
>  					&wpc->cow_seq : &wpc->data_seq);
>  		if (error)
>  			return error;
> @@ -507,6 +513,7 @@ xfs_map_blocks(
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
>  	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
> +	int			whichfork = XFS_DATA_FORK;
>  	struct xfs_bmbt_irec	imap;
>  	struct xfs_iext_cursor	icur;
>  	int			retries = 0;
> @@ -555,7 +562,7 @@ xfs_map_blocks(
>  		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
>  		xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -		wpc->fork = XFS_COW_FORK;
> +		whichfork = XFS_COW_FORK;
>  		goto allocate_blocks;
>  	}
>  
> @@ -578,8 +585,6 @@ xfs_map_blocks(
>  	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
>  	xfs_iunlock(ip, XFS_ILOCK_SHARED);
>  
> -	wpc->fork = XFS_DATA_FORK;
> -
>  	/* landed in a hole or beyond EOF? */
>  	if (imap.br_startoff > offset_fsb) {
>  		imap.br_blockcount = imap.br_startoff - offset_fsb;
> @@ -604,10 +609,10 @@ xfs_map_blocks(
>  		goto allocate_blocks;
>  
>  	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
> -	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
> +	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> -	error = xfs_convert_blocks(wpc, ip, offset);
> +	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
>  	if (error) {
>  		/*
>  		 * If we failed to find the extent in the COW fork we might have
> @@ -616,7 +621,7 @@ xfs_map_blocks(
>  		 * the former case, but prevent additional retries to avoid
>  		 * looping forever for the latter case.
>  		 */
> -		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
> +		if (error == -EAGAIN && whichfork == XFS_COW_FORK && !retries++)
>  			goto retry;
>  		ASSERT(error != -EAGAIN);
>  		return error;
> @@ -627,7 +632,7 @@ xfs_map_blocks(
>  	 * original delalloc one.  Trim the return extent to the next COW
>  	 * boundary again to force a re-lookup.
>  	 */
> -	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
> +	if (whichfork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
>  		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
>  
>  		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
> @@ -636,7 +641,7 @@ xfs_map_blocks(
>  
>  	ASSERT(wpc->iomap.offset <= offset);
>  	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
> -	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
> +	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
>  	return 0;
>  }
>  
> @@ -670,14 +675,14 @@ xfs_submit_ioend(
>  	nofs_flag = memalloc_nofs_save();
>  
>  	/* Convert CoW extents to regular */
> -	if (!status && ioend->io_fork == XFS_COW_FORK) {
> +	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
>  		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
>  				ioend->io_offset, ioend->io_size);
>  	}
>  
>  	/* Reserve log space if we might write beyond the on-disk inode size. */
>  	if (!status &&
> -	    (ioend->io_fork == XFS_COW_FORK ||
> +	    ((ioend->io_flags & IOMAP_F_SHARED) ||
>  	     ioend->io_type != IOMAP_UNWRITTEN) &&
>  	    xfs_ioend_is_append(ioend) &&
>  	    !ioend->io_private)
> @@ -724,8 +729,8 @@ xfs_alloc_ioend(
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_fork = wpc->fork;
>  	ioend->io_type = wpc->iomap.type;
> +	ioend->io_flags = wpc->iomap.flags;
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> @@ -759,6 +764,24 @@ xfs_chain_bio(
>  	return new;
>  }
>  
> +static bool
> +xfs_can_add_to_ioend(
> +	struct xfs_writepage_ctx *wpc,
> +	xfs_off_t		offset,
> +	sector_t		sector)
> +{
> +	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
> +	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
> +		return false;
> +	if (wpc->iomap.type != wpc->ioend->io_type)
> +		return false;
> +	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
> +		return false;
> +	if (sector != bio_end_sector(wpc->ioend->io_bio))
> +		return false;
> +	return true;
> +}
> +
>  /*
>   * Test to see if we have an existing ioend structure that we could append to
>   * first, otherwise finish off the current ioend and start another.
> @@ -778,11 +801,7 @@ xfs_add_to_ioend(
>  	unsigned		poff = offset & (PAGE_SIZE - 1);
>  	bool			merged, same_page = false;
>  
> -	if (!wpc->ioend ||
> -	    wpc->fork != wpc->ioend->io_fork ||
> -	    wpc->iomap.type != wpc->ioend->io_type ||
> -	    sector != bio_end_sector(wpc->ioend->io_bio) ||
> -	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
> +	if (!wpc->ioend || !xfs_can_add_to_ioend(wpc, offset, sector)) {
>  		if (wpc->ioend)
>  			list_add(&wpc->ioend->io_list, iolist);
>  		wpc->ioend = xfs_alloc_ioend(inode, wpc, offset, sector, wbc);
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 6a45d675dcba..4a0226cdad4f 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -13,8 +13,8 @@ extern struct bio_set xfs_ioend_bioset;
>   */
>  struct xfs_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
> -	int			io_fork;	/* inode fork written back */
>  	u16			io_type;
> +	u16			io_flags;	/* IOMAP_F_* */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> -- 
> 2.20.1
> 
