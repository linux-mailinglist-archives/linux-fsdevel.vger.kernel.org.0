Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA2123CB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLRBxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:53:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42228 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRBxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:53:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1nDcU036140;
        Wed, 18 Dec 2019 01:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=pwc4uUbIm0raZr9rq3UNMRxIneY2e1xYjoRCYFRwDlg=;
 b=ZsmlMmlxp/uC455VJU7+6WUPBkv9bewfHU2VOWheAh9SOAvcLxLz8HSbJq9Y3UXIHAXw
 msthpHe/iG8TZOGkm2y0mnxunfgKaIn1jAV45V7JBr5FzLViEQ7kiMza9WsuZJBk5avO
 WW36kpFx8LUy+AycA5ST+qCCqaJq5qNIqXQCdH651twHRdtQi2zz6MCiY6B7YPLoeuk4
 0KOI/1Bz1IWOCOvVVWwXpE6uZiCkU/9eK3WYLvUZaADtCY/XDKJdENVpGm8Zh0FBJk/G
 RHw3/WT0mTj60c0bNFHIxqUpaQRTbsczGjEeWhozDcpLGv8VUgKGPenBa+419PJhCs8Y lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wvrcracjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:53:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1nKbq104522;
        Wed, 18 Dec 2019 01:53:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wxm4wn1y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:53:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBI1r19j008559;
        Wed, 18 Dec 2019 01:53:01 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 17:53:01 -0800
Date:   Tue, 17 Dec 2019 17:52:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 5/6] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191218015259.GJ12766@magnolia>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217143948.26380-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180013
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:39:47AM -0700, Jens Axboe wrote:
> This adds support for RWF_UNCACHED for file systems using iomap to
> perform buffered writes. We use the generic infrastructure for this,
> by tracking pages we created and calling write_drop_cached_pages()
> to issue writeback and prune those pages.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap/apply.c       | 35 +++++++++++++++++++++++++++++++++++
>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
>  fs/iomap/trace.h       |  4 +++-
>  include/linux/iomap.h  |  5 +++++
>  4 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 792079403a22..687e86945b27 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -92,5 +92,40 @@ iomap_apply(struct iomap_ctx *data, const struct iomap_ops *ops,
>  				     data->flags, &iomap);
>  	}
>  
> +	if (written <= 0)
> +		goto out;
> +
> +	/*
> +	 * If this is an uncached write, then we need to write and sync this
> +	 * range of data. This is only true for a buffered write, not for
> +	 * O_DIRECT.
> +	 */

I tracked down the original conversation, where Dave had this to say:

"Hence, IMO, this is the wrong layer in iomap to be dealing with¬
writeback and cache residency for uncached IO. We should be caching¬
residency/invalidation at a per-IO level, not a per-page level."

He's right, but I still think it doesn't quite smell right to be putting
this in iomap_apply, since that's a generic function that implements
iteration and shouldn't be messing with cache invalidation.

So I have two possible suggestions for where to put this:

(1) Add the "flush and maybe invalidate" behavior to the bottom of
iomap_write_actor like I said in the v4 patchset.  That will issue
writeback and invalidate pagecache in smallish quantities.

(2) Find a way to pass the IOMAP_F_PAGE_CREATE state from
iomap_write_actor back to iomap_file_buffered_write and do the
flush-and-invalidate for the entire write request once at the end.

> +	if ((data->flags & (IOMAP_WRITE|IOMAP_DIRECT|IOMAP_UNCACHED)) ==
> +			(IOMAP_WRITE|IOMAP_UNCACHED)) {
> +		struct address_space *mapping = data->inode->i_mapping;
> +
> +		end = data->pos + written;
> +		ret = filemap_write_and_wait_range(mapping, data->pos, end);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * No pages were created for this range, we're done. We only
> +		 * invalidate the range if no pages were created for the
> +		 * entire range.
> +		 */
> +		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
> +			goto out;
> +
> +		/*
> +		 * Try to invalidate cache pages for the range we just wrote.
> +		 * We don't care if invalidation fails as the write has still
> +		 * worked and leaving clean uptodate pages in the page cache
> +		 * isn't a corruption vector for uncached IO.
> +		 */
> +		invalidate_inode_pages2_range(mapping,
> +				data->pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +	}
> +out:
>  	return written ? written : ret;
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7f8300bce767..328afeba950f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -582,6 +582,7 @@ EXPORT_SYMBOL_GPL(iomap_migrate_page);
>  
>  enum {
>  	IOMAP_WRITE_F_UNSHARE		= (1 << 0),
> +	IOMAP_WRITE_F_UNCACHED		= (1 << 1),
>  };
>  
>  static void
> @@ -659,6 +660,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> +	unsigned aop_flags;
>  	struct page *page;
>  	int status = 0;
>  
> @@ -675,8 +677,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  			return status;
>  	}
>  
> +	aop_flags = AOP_FLAG_NOFS;
> +	if (flags & IOMAP_WRITE_F_UNCACHED)
> +		aop_flags |= AOP_FLAG_UNCACHED;
>  	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> -			AOP_FLAG_NOFS);
> +						aop_flags);
>  	if (!page) {
>  		status = -ENOMEM;
>  		goto out_no_page;
> @@ -820,9 +825,13 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
>  	struct iov_iter *i = data->priv;
>  	loff_t length = data->len;
>  	loff_t pos = data->pos;
> +	unsigned flags = 0;
>  	long status = 0;
>  	ssize_t written = 0;
>  
> +	if (data->flags & IOMAP_UNCACHED)
> +		flags |= IOMAP_WRITE_F_UNCACHED;
> +
>  	do {
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
> @@ -851,10 +860,18 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> -				srcmap);
> -		if (unlikely(status))
> +retry:
> +		status = iomap_write_begin(inode, pos, bytes, flags,
> +						&page, iomap, srcmap);
> +		if (unlikely(status)) {
> +			if (status == -ENOMEM &&
> +			    (flags & IOMAP_WRITE_F_UNCACHED)) {
> +				iomap->flags |= IOMAP_F_PAGE_CREATE;
> +				flags &= ~IOMAP_WRITE_F_UNCACHED;

What's the strategy here?  We couldn't get a page for an uncached write,
so try again as a regular cached write?

Thanks for making the updates, it's looking better.

--D

> +				goto retry;
> +			}
>  			break;
> +		}
>  
>  		if (mapping_writably_mapped(inode->i_mapping))
>  			flush_dcache_page(page);
> @@ -907,6 +924,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  	};
>  	loff_t ret = 0, written = 0;
>  
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		data.flags |= IOMAP_UNCACHED;
> +
>  	while (iov_iter_count(iter)) {
>  		data.len = iov_iter_count(iter);
>  		ret = iomap_apply(&data, ops, iomap_write_actor);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 6dc227b8c47e..63c771e3eef5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -93,7 +93,8 @@ DEFINE_PAGE_EVENT(iomap_invalidatepage);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_UNCACHED,	"UNCACHED" }
>  
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> @@ -101,6 +102,7 @@ DEFINE_PAGE_EVENT(iomap_invalidatepage);
>  	{ IOMAP_F_SHARED,	"SHARED" }, \
>  	{ IOMAP_F_MERGED,	"MERGED" }, \
>  	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
> +	{ IOMAP_F_PAGE_CREATE,	"PAGE_CREATE" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
>  
>  DECLARE_EVENT_CLASS(iomap_class,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 00e439aac8ea..58311b6fdfdd 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -48,12 +48,16 @@ struct vm_fault;
>   *
>   * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
>   * buffer heads for this mapping.
> + *
> + * IOMAP_F_PAGE_CREATE indicates that pages had to be allocated to satisfy
> + * this operation.
>   */
>  #define IOMAP_F_NEW		0x01
>  #define IOMAP_F_DIRTY		0x02
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> +#define IOMAP_F_PAGE_CREATE	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -121,6 +125,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_UNCACHED		(1 << 6) /* uncached IO */
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.24.1
> 
