Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC326E7D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIQWDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:03:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIQWDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:03:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HLxlad048011;
        Thu, 17 Sep 2020 22:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x216MVKnAlycli97LKmjwosRBbLRqZxgIH7eOh8qQw8=;
 b=XSUpyYcXNrdeBd45Gyrs/kMNpXyHcC1ocmQM/kKh4ZiKFWs1SjR7rnetYswZ4D46vQAc
 ILLcQHpiaKuKHVKZf1FJOuYnRzZNDlCoiJ2B7/oLdza1i+CHgc2iNNYnc3+LKucR/+oR
 U/q/Om7SeD7E4BPUY+gBnDnWiohDJmPOQQfcqBomUr1zqgbrn3BLsOWMxvRHxNh11VeO
 SBxkPM/arf4WZupsaxkj7qjSycV2ce1kJBGwGJZi6u8JED3LsrRr2g/wh/egHCR7Ykm9
 kmfIPgmtK8qPvdlmN2cVBNQD2ldZns1ikeW00BRVW/2vVdI6+mgR37Owl9sttLlOhWnV Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrrc2nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 22:02:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM1Zmu079441;
        Thu, 17 Sep 2020 22:02:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h88ck8hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 22:02:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HM2eCZ030627;
        Thu, 17 Sep 2020 22:02:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 22:02:40 +0000
Date:   Thu, 17 Sep 2020 15:02:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 7/9] iomap: Convert write_count to write_bytes_pending
Message-ID: <20200917220238.GP7955@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-8-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:47:05AM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1cf976a8e55c..64a5cb383f30 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -27,7 +27,7 @@
>   */
>  struct iomap_page {
>  	atomic_t		read_bytes_pending;
> -	atomic_t		write_count;
> +	atomic_t		write_bytes_pending;
>  	spinlock_t		uptodate_lock;
>  	unsigned long		uptodate[];
>  };
> @@ -73,7 +73,7 @@ iomap_page_release(struct page *page)
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
> -	WARN_ON_ONCE(atomic_read(&iop->write_count));
> +	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
>  	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>  			PageUptodate(page));
>  	kfree(iop);
> @@ -1047,7 +1047,7 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
>  static void
>  iomap_finish_page_writeback(struct inode *inode, struct page *page,
> -		int error)
> +		int error, unsigned int len)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
>  
> @@ -1057,9 +1057,9 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
>  	}
>  
>  	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
> -	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
> +	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
>  
> -	if (!iop || atomic_dec_and_test(&iop->write_count))
> +	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
>  		end_page_writeback(page);
>  }
>  
> @@ -1093,7 +1093,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  		/* walk each page on bio, ending page IO on them */
>  		bio_for_each_segment_all(bv, bio, iter_all)
> -			iomap_finish_page_writeback(inode, bv->bv_page, error);
> +			iomap_finish_page_writeback(inode, bv->bv_page, error,
> +					bv->bv_len);
>  		bio_put(bio);
>  	}
>  	/* The ioend has been freed by bio_put() */
> @@ -1309,8 +1310,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  
>  	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
>  			&same_page);
> -	if (iop && !same_page)
> -		atomic_inc(&iop->write_count);
> +	if (iop)
> +		atomic_add(len, &iop->write_bytes_pending);
>  
>  	if (!merged) {
>  		if (bio_full(wpc->ioend->io_bio, len)) {
> @@ -1353,7 +1354,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	LIST_HEAD(submit_list);
>  
>  	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
> -	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
> +	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>  
>  	/*
>  	 * Walk through the page to find areas to write back. If we run off the
> -- 
> 2.28.0
> 
