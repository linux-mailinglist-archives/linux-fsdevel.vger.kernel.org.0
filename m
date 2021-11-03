Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830DC4444CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKCPpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 11:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKCPpq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D18561076;
        Wed,  3 Nov 2021 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635954190;
        bh=JrJPc27Pj0tqZ4ZP+BqiHNjvhEOsKrIRpVsSC3jH0zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3duK6HdKhrJ+gv7G4sdRhqAUI/wXrCFslo6C07CZfLiQRSjx6XWpSQTzPAdLZRGk
         EyUrTnHOx2NztJUGzcoDPzWbdgTGWZC6n1OCySF1sHGC8BR+z3VTKL5r5HoVovgepY
         TtN7YH7qSsOQXYWSd2oGB6VLotCVRxuDWn+nH0F4cuC44tuWRi0rHXJEcsxowEBOlx
         xJiD4m3z55u5ufJIfeNXuOfBmWcKni7/Ih1NaI0K5QXh0lS656M68MRz39ZWQPthgY
         6dZnu1G1TndELw1qOSMRnL9nmc1Rv0qmKmYdBMXyFRKdgJiq5KL36jGWfkdzsYCnkH
         01RDqlE4zJzqg==
Date:   Wed, 3 Nov 2021 08:43:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 17/21] iomap,xfs: Convert ->discard_page to
 ->discard_folio
Message-ID: <20211103154309.GK24307@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-18-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:25PM +0000, Matthew Wilcox (Oracle) wrote:
> XFS has the only implementation of ->discard_page today, so convert it
> to use folios in the same patch as converting the API.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c |  4 ++--
>  fs/xfs/xfs_aops.c      | 24 ++++++++++++------------
>  include/linux/iomap.h  |  2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6862487f4067..c50ae76835ca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1349,8 +1349,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		 * won't be affected by I/O completion and we must unlock it
>  		 * now.
>  		 */
> -		if (wpc->ops->discard_page)
> -			wpc->ops->discard_page(page, file_offset);
> +		if (wpc->ops->discard_folio)
> +			wpc->ops->discard_folio(page_folio(page), file_offset);
>  		if (!count) {
>  			ClearPageUptodate(page);
>  			unlock_page(page);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 34fc6148032a..c6c4d07d0d26 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -428,37 +428,37 @@ xfs_prepare_ioend(
>   * see a ENOSPC in writeback).
>   */
>  static void
> -xfs_discard_page(
> -	struct page		*page,
> -	loff_t			fileoff)
> +xfs_discard_folio(
> +	struct folio		*folio,
> +	loff_t			pos)
>  {
> -	struct inode		*inode = page->mapping->host;
> +	struct inode		*inode = folio->mapping->host;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	unsigned int		pageoff = offset_in_page(fileoff);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
> -	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
> +	size_t			offset = offset_in_folio(folio, pos);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, pos);
> +	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, offset);
>  	int			error;
>  
>  	if (xfs_is_shutdown(mp))
>  		goto out_invalidate;
>  
>  	xfs_alert_ratelimited(mp,
> -		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> -			page, ip->i_ino, fileoff);
> +		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
> +			folio, ip->i_ino, pos);
>  
>  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			i_blocks_per_page(inode, page) - pageoff_fsb);
> +			i_blocks_per_folio(inode, folio) - pageoff_fsb);
>  	if (error && !xfs_is_shutdown(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> -	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
> +	iomap_invalidate_folio(folio, offset, folio_size(folio) - offset);
>  }
>  
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
>  	.map_blocks		= xfs_map_blocks,
>  	.prepare_ioend		= xfs_prepare_ioend,
> -	.discard_page		= xfs_discard_page,
> +	.discard_folio		= xfs_discard_folio,
>  };
>  
>  STATIC int
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 91de58ca09fc..1a161314d7e4 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -285,7 +285,7 @@ struct iomap_writeback_ops {
>  	 * Optional, allows the file system to discard state on a page where
>  	 * we failed to submit any I/O.
>  	 */
> -	void (*discard_page)(struct page *page, loff_t fileoff);
> +	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
>  struct iomap_writepage_ctx {
> -- 
> 2.33.0
> 
