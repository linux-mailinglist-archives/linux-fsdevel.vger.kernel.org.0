Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2129F71F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 22:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2Vpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 17:45:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32956 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Vpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:45:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLTLE9143644;
        Thu, 29 Oct 2020 21:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lVkSpCpdWLHgD8gFp7iFH+kz2DvbOKUCIkxdli4g6CA=;
 b=WIJnfQv+BoKwJwtXOc1CgmWes2PvstnRM1CprIGoEuXRGvGVc8YjUlwfqUDzb9fCOOPz
 u890OFHvZ5EYFfmfVABXtIv1ulgwaIYCBHrKY50qi4gcxeWEddjQVyCuGQhulJpfVWZ9
 OZ9kMou1QpINVYL/WLTe4FRQUHrP9yq1NSSprBUGf7sDSQMQmiAC2mHRFpVuf/nKMxb5
 iN3l0N1ro1ttDpsJ7waHCdejhC83F2uIEIlxnJGDs9F4Api1v2CdqK7+dWnzuT4CNQe1
 WVCvjLMAUwPLq8PWDzH/8O+rpAGFH2/b8YpR0qrZlLarE9BcNfZJPYGDrF2P+o1zOEyd 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9sb7ccq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:45:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLjR80049271;
        Thu, 29 Oct 2020 21:45:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6yyc2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:45:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TLjMXQ025568;
        Thu, 29 Oct 2020 21:45:23 GMT
Received: from localhost (/10.159.244.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:45:22 -0700
Date:   Thu, 29 Oct 2020 14:45:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2.1 2/3] iomap: support partial page discard on
 writeback block mapping failure
Message-ID: <20201029214521.GJ1061252@magnolia>
References: <20201029132325.1663790-3-bfoster@redhat.com>
 <20201029163313.1766967-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029163313.1766967-1-bfoster@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:33:13PM -0400, Brian Foster wrote:
> iomap writeback mapping failure only calls into ->discard_page() if
> the current page has not been added to the ioend. Accordingly, the
> XFS callback assumes a full page discard and invalidation. This is
> problematic for sub-page block size filesystems where some portion
> of a page might have been mapped successfully before a failure to
> map a delalloc block occurs. ->discard_page() is not called in that
> error scenario and the bio is explicitly failed by iomap via the
> error return from ->prepare_ioend(). As a result, the filesystem
> leaks delalloc blocks and corrupts the filesystem block counters.
> 
> Since XFS is the only user of ->discard_page(), tweak the semantics
> to invoke the callback unconditionally on mapping errors and provide
> the file offset that failed to map. Update xfs_discard_page() to
> discard the corresponding portion of the file and pass the range
> along to iomap_invalidatepage(). The latter already properly handles
> both full and sub-page scenarios by not changing any iomap or page
> state on sub-page invalidations.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the rebase,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> v2.1:
> - Rebased to v5.10-rc1.
> 
>  fs/iomap/buffered-io.c | 15 ++++++++-------
>  fs/xfs/xfs_aops.c      | 14 ++++++++------
>  include/linux/iomap.h  |  2 +-
>  3 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8180061b9e16..e4ea1f9f94d0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1382,14 +1382,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * appropriately.
>  	 */
>  	if (unlikely(error)) {
> +		/*
> +		 * Let the filesystem know what portion of the current page
> +		 * failed to map. If the page wasn't been added to ioend, it
> +		 * won't be affected by I/O completion and we must unlock it
> +		 * now.
> +		 */
> +		if (wpc->ops->discard_page)
> +			wpc->ops->discard_page(page, file_offset);
>  		if (!count) {
> -			/*
> -			 * If the current page hasn't been added to ioend, it
> -			 * won't be affected by I/O completions and we must
> -			 * discard and unlock it right here.
> -			 */
> -			if (wpc->ops->discard_page)
> -				wpc->ops->discard_page(page);
>  			ClearPageUptodate(page);
>  			unlock_page(page);
>  			goto done;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 55d126d4e096..5bf37afae5e9 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -527,13 +527,15 @@ xfs_prepare_ioend(
>   */
>  static void
>  xfs_discard_page(
> -	struct page		*page)
> +	struct page		*page,
> +	loff_t			fileoff)
>  {
>  	struct inode		*inode = page->mapping->host;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	loff_t			offset = page_offset(page);
> -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> +	unsigned int		pageoff = offset_in_page(fileoff);
> +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
> +	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
>  	int			error;
>  
>  	if (XFS_FORCED_SHUTDOWN(mp))
> @@ -541,14 +543,14 @@ xfs_discard_page(
>  
>  	xfs_alert_ratelimited(mp,
>  		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> -			page, ip->i_ino, offset);
> +			page, ip->i_ino, fileoff);
>  
>  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			i_blocks_per_page(inode, page));
> +			i_blocks_per_page(inode, page) - pageoff_fsb);
>  	if (error && !XFS_FORCED_SHUTDOWN(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> -	iomap_invalidatepage(page, 0, PAGE_SIZE);
> +	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
>  }
>  
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 172b3397a1a3..5bd3cac4df9c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -221,7 +221,7 @@ struct iomap_writeback_ops {
>  	 * Optional, allows the file system to discard state on a page where
>  	 * we failed to submit any I/O.
>  	 */
> -	void (*discard_page)(struct page *page);
> +	void (*discard_page)(struct page *page, loff_t fileoff);
>  };
>  
>  struct iomap_writepage_ctx {
> -- 
> 2.25.4
> 
