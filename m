Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1D28E495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgJNQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:35:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44978 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgJNQfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:35:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGUK9h088193;
        Wed, 14 Oct 2020 16:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=80XHxqPbf1mTULW9cTZ44rDWhSCJ9qRVBLotqhPfHuw=;
 b=wvB6xYwbbSqwVnYr9TDYAtQw77RWPaKNN0QHBGKlrl5JxQksIGCYmKRC2rWAL4haLhpY
 +iAt901UE7MUocO5OdtT8cC1KOQCQmTpNXGbDw7F7Ck6o0xIhPPsL7VsWHJQ9EkQ7Ntx
 cup1mQ23wl7AGNAHANQFJQUS3PjoQI18sZIiTiLoVuvTiWwC7VUICZekOd13wM4+ftRx
 5S82yJbhUAfPC5MJ4jB5fj130LG7k91W/Ts+sLDzj3r4Fnn6TSKyWA3Av/qc+0Cn/a5x
 am5e2eAE93tTipeutRUIjdp9awBOPg0AJ45iPzHUEYkDdlr5iiAccVv/mduA/WKwdbVQ Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3434wkrjg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 16:35:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EGVERk179032;
        Wed, 14 Oct 2020 16:33:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 343pv0k44g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 16:33:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09EGXnU3032612;
        Wed, 14 Oct 2020 16:33:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 09:33:48 -0700
Date:   Wed, 14 Oct 2020 09:33:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 05/14] iomap: Support THPs in invalidatepage
Message-ID: <20201014163347.GI9832@magnolia>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-6-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=904 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=921
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:48AM +0100, Matthew Wilcox (Oracle) wrote:
> If we're punching a hole in a THP, we need to remove the per-page
> iomap data as the THP is about to be split and each page will need
> its own.  This means that writepage can now come across a page with
> no iop allocated, so remove the assertion that there is already one,
> and just create one (with the uptodate bits set) if there isn't one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 95ac66731297..4633ebd03a3f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -60,6 +60,8 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
>  			GFP_NOFS | __GFP_NOFAIL);
>  	spin_lock_init(&iop->uptodate_lock);
> +	if (PageUptodate(page))
> +		bitmap_fill(iop->uptodate, nr_blocks);
>  	attach_page_private(page, iop);
>  	return iop;
>  }
> @@ -494,10 +496,14 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  	 * If we are invalidating the entire page, clear the dirty state from it
>  	 * and release it to avoid unnecessary buildup of the LRU.
>  	 */
> -	if (offset == 0 && len == PAGE_SIZE) {
> +	if (offset == 0 && len == thp_size(page)) {
>  		WARN_ON_ONCE(PageWriteback(page));
>  		cancel_dirty_page(page);
>  		iomap_page_release(page);
> +	} else if (PageTransHuge(page)) {
> +		/* Punching a hole in a THP requires releasing the iop */
> +		WARN_ON_ONCE(!PageUptodate(page) && PageDirty(page));
> +		iomap_page_release(page);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidatepage);
> @@ -1363,14 +1369,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct page *page, u64 end_offset)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct iomap_page *iop = iomap_page_create(inode, page);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	u64 file_offset; /* file offset of page */
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> -	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>  
>  	/*
> @@ -1415,7 +1420,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  			 */
>  			if (wpc->ops->discard_page)
>  				wpc->ops->discard_page(page);
> -			ClearPageUptodate(page);

Er, I don't get it -- why do we now leave the page up to date after
writeback fails?

--D

>  			unlock_page(page);
>  			goto done;
>  		}
> -- 
> 2.28.0
> 
