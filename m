Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32925222D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHYUtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 16:49:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgHYUtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:49:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKhkYR034030;
        Tue, 25 Aug 2020 20:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SPZ/f0yJOsDKoFKdvXMqq4kIOM96Ih8E00klWJf1bAE=;
 b=uNl0Rz2hUupsXiMa+QAP7KzhqcN/4nkiIUqxMpKxIStNaqMejVD8D0/x3mHC2SxN436o
 Tph9N7hemv+9Gx2+GfzbD2FCs3BnM6bIhwpcqsBY8dw6HkbtXVAkiPJrnW4vbTA1i3yq
 vjeiIg2b2K2GWQw3ihrbnQLSS8ldOGqxGtARg5T459yVvlrQU4SWtcJLS2C8Ff5eOebL
 6QmJXKcuEgIvkjZrBF976wMgnk2RCM0I1oYFaVbqcmZ2Ll1aAK+GNkR0RuHGIHX6i8BQ
 +/sAkSxRyLnSIArCKdfluIrmmPGxcqlzOsMmVbzdNI1xyFrE805a4x3dyyFjz6vYc6IA Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 333dbrvv2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 20:49:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKjJJr034224;
        Tue, 25 Aug 2020 20:49:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9k25a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 20:49:28 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PKnNtJ006526;
        Tue, 25 Aug 2020 20:49:23 GMT
Received: from localhost (/10.159.234.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 13:49:23 -0700
Date:   Tue, 25 Aug 2020 13:49:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] fs: Introduce i_blocks_per_page
Message-ID: <20200825204922.GG6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-3-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:03PM +0100, Matthew Wilcox (Oracle) wrote:
> This helper is useful for both THPs and for supporting block size larger
> than page size.  Convert all users that I could find (we have a few
> different ways of writing this idiom, and I may have missed some).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

/me wonders what will happen when someone tries to make blocksz >
pagesize work, but as the most likely someone already rvb'd this I guess
it's fine:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c  |  8 ++++----
>  fs/jfs/jfs_metapage.c   |  2 +-
>  fs/xfs/xfs_aops.c       |  2 +-
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cffd575e57b6..13d5cdab8dcd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
>  
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;
>  
>  	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> @@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	unsigned int i;
>  
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> +	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
>  		if (i >= first && i <= last)
>  			set_bit(i, iop->uptodate);
>  		else if (!test_bit(i, iop->uptodate))
> @@ -1078,7 +1078,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
>  		mapping_set_error(inode->i_mapping, -EIO);
>  	}
>  
> -	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
>  
>  	if (!iop || atomic_dec_and_test(&iop->write_count))
> @@ -1374,7 +1374,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> -	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
>  
>  	/*
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index a2f5338a5ea1..176580f54af9 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -473,7 +473,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
>  	struct inode *inode = page->mapping->host;
>  	struct bio *bio = NULL;
>  	int block_offset;
> -	int blocks_per_page = PAGE_SIZE >> inode->i_blkbits;
> +	int blocks_per_page = i_blocks_per_page(inode, page);
>  	sector_t page_start;	/* address of page in fs blocks */
>  	sector_t pblock;
>  	int xlen;
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b35611882ff9..55d126d4e096 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -544,7 +544,7 @@ xfs_discard_page(
>  			page, ip->i_ino, offset);
>  
>  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			PAGE_SIZE / i_blocksize(inode));
> +			i_blocks_per_page(inode, page));
>  	if (error && !XFS_FORCED_SHUTDOWN(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7de11dcd534d..853733286138 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -899,4 +899,20 @@ static inline int page_mkwrite_check_truncate(struct page *page,
>  	return offset;
>  }
>  
> +/**
> + * i_blocks_per_page - How many blocks fit in this page.
> + * @inode: The inode which contains the blocks.
> + * @page: The page (head page if the page is a THP).
> + *
> + * If the block size is larger than the size of this page, return zero.
> + *
> + * Context: The caller should hold a refcount on the page to prevent it
> + * from being split.
> + * Return: The number of filesystem blocks covered by this page.
> + */
> +static inline
> +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
> +{
> +	return thp_size(page) >> inode->i_blkbits;
> +}
>  #endif /* _LINUX_PAGEMAP_H */
> -- 
> 2.28.0
> 
