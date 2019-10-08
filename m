Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE218CFD49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJHPNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:13:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:13:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FBnSG083648;
        Tue, 8 Oct 2019 15:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=JHSKLueuLw5nP+2cy9UOEdiSW2gr1kxXzTcsbIXDiHc=;
 b=lSVOqcf+I3ODgPphhKhJE6/JWOMbbsTg7bkg53uHfjTgYttqOcPWESQ1ws0zxwUfNNxT
 aa/x1lHR5PBU2vqxKdNgMcOn64pHQ+8ZyIXLYMqLowYlxDOqrXe1URp+U3dU4dsN8rgo
 hXgWmgRgi+006XOTQuF03gCVJaMkJm+/xTSyPuRSweR2PK67D3ChXpxeQpMBFrFmcH6c
 eZgrPcWYOjXcaPPRig5IQmMxUhEdb+Um3nFroFu3zUkkBBXXdgiW9XhkJ3gH2BaL1Gpl
 nR79LVMlQ4Sh7WWVaoHcy90qWlM8PR+0eJCneB/RnkzGf2qz6TuYP+GEHlN04TxpRRIx rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4qdxp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:12:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98F7tsI175927;
        Tue, 8 Oct 2019 15:12:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vg1yw48xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:12:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98FCv1W011145;
        Tue, 8 Oct 2019 15:12:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:12:56 -0700
Date:   Tue, 8 Oct 2019 08:12:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/20] iomap: use write_begin to read pages to unshare
Message-ID: <20191008151255.GX13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:15:13AM +0200, Christoph Hellwig wrote:
> Use the existing iomap write_begin code to read the pages unshared
> by iomap_file_unshare.  That avoids the extra ->readpage call and
> extent tree lookup currently done by read_mapping_page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 49 ++++++++++++++----------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d5abd8e5dca7..ac1bbed71a9b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -548,6 +548,10 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  EXPORT_SYMBOL_GPL(iomap_migrate_page);
>  #endif /* CONFIG_MIGRATION */
>  
> +enum {
> +	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
> +};
> +
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -577,7 +581,7 @@ iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
>  }
>  
>  static int
> -__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
> +__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		struct page *page, struct iomap *iomap)
>  {
>  	struct iomap_page *iop = iomap_page_create(inode, page);
> @@ -596,11 +600,14 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  		if (plen == 0)
>  			break;
>  
> -		if ((from <= poff || from >= poff + plen) &&
> +		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
> +		    (from <= poff || from >= poff + plen) &&
>  		    (to <= poff || to >= poff + plen))
>  			continue;
>  
>  		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
> +			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
> +				return -EIO;
>  			zero_user_segments(page, poff, from, to, poff + plen);
>  			iomap_set_range_uptodate(page, poff, plen);
>  			continue;
> @@ -646,7 +653,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
> -		status = __iomap_write_begin(inode, pos, len, page, iomap);
> +		status = __iomap_write_begin(inode, pos, len, flags, page,
> +				iomap);
>  
>  	if (unlikely(status))
>  		goto out_unlock;
> @@ -869,22 +877,6 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> -static struct page *
> -__iomap_read_page(struct inode *inode, loff_t offset)
> -{
> -	struct address_space *mapping = inode->i_mapping;
> -	struct page *page;
> -
> -	page = read_mapping_page(mapping, offset >> PAGE_SHIFT, NULL);
> -	if (IS_ERR(page))
> -		return page;
> -	if (!PageUptodate(page)) {
> -		put_page(page);
> -		return ERR_PTR(-EIO);
> -	}
> -	return page;
> -}
> -
>  static loff_t
>  iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
> @@ -900,24 +892,15 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		return length;
>  
>  	do {
> -		struct page *page, *rpage;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> -
> -		offset = offset_in_page(pos);
> -		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> -
> -		rpage = __iomap_read_page(inode, pos);
> -		if (IS_ERR(rpage))
> -			return PTR_ERR(rpage);
> +		unsigned long offset = offset_in_page(pos);
> +		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
> +		struct page *page;
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
> -		put_page(rpage);
> +		status = iomap_write_begin(inode, pos, bytes,
> +				IOMAP_WRITE_F_UNSHARE, &page, iomap);
>  		if (unlikely(status))
>  			return status;
>  
> -		WARN_ON_ONCE(!PageUptodate(page));
> -
>  		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
>  		if (unlikely(status <= 0)) {
>  			if (WARN_ON_ONCE(status == 0))
> -- 
> 2.20.1
> 
