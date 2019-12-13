Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1649B11DC14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 03:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfLMC11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 21:27:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52990 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfLMC11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:27:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD2OgHp016387;
        Fri, 13 Dec 2019 02:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ezI5Hm7Ylq9q8YZeLlKlEfbheDOvaElbiAJvafzEp7M=;
 b=Gh17UR+FmwF8t4a6ekezcTj2culQSvyApGdRNxqZp76Ihkv2QnisG8mSmuIT8RqNce1Z
 +u7VU0/K0to4IWLFyWaMK+fT34ttYsxJnh5A8z3uFwS/hKjSZ8zCtCYx+DHhIQ+qHWTN
 3x5/otkJSbMIfjxfH9kpVzXDhlMUhBupwI3/jLsUp2BhXMkvg3TzOtEWrt1yRc/jyFGN
 ovvbQThUjTYu8Q7A/QyQkaUxt8ciJXEiAE687ieLsQniLpj5SnyDdk9XRk/xSGE5w6AC
 NU/YrPGwGVgO76xNTxoDL8jew6xSQ71fGUPbFq6PCTV1DgHJEFZRkVG/JlqDxgeX6jw1 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wr41qphsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 02:26:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD2OTrk188698;
        Fri, 13 Dec 2019 02:26:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wumsabp0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 02:26:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBD2Qr4Y001936;
        Fri, 13 Dec 2019 02:26:53 GMT
Received: from localhost (/10.145.178.64) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Thu, 12 Dec 2019 18:26:35 -0800
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20191213022634.GA99868@magnolia>
Date:   Thu, 12 Dec 2019 18:26:34 -0800 (PST)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
References: <20191212190133.18473-1-axboe@kernel.dk>
 <20191212190133.18473-6-axboe@kernel.dk>
In-Reply-To: <20191212190133.18473-6-axboe@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130019
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:01:33PM -0700, Jens Axboe wrote:
> This adds support for RWF_UNCACHED for file systems using iomap to
> perform buffered writes. We use the generic infrastructure for this,
> by tracking pages we created and calling write_drop_cached_pages()
> to issue writeback and prune those pages.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>  fs/iomap/buffered-io.c | 23 +++++++++++++++++++----
>  include/linux/iomap.h  |  5 +++++
>  3 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index e76148db03b8..11b6812f7b37 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -92,5 +92,29 @@ iomap_apply(struct iomap_data *data, const struct iomap_ops *ops,
>  				     data->flags, &iomap);
>  	}
>  
> +	if (written && (data->flags & IOMAP_UNCACHED)) {

Hmmm... why is a chunk of buffered write(?) code landing in the iomap
apply function?

The #define for IOMAP_UNCACHED doesn't have a comment, so I don't know
what this is supposed to mean.  Judging from the one place it gets set
in the buffered write function I gather that this is how you implement
the "write through page cache and immediately unmap the page if it
wasn't there before" behavior?

So based on that, I think you want ...

if IOMAP_WRITE && _UNCACHED && !_DIRECT && written > 0:
	flush and invalidate

Since direct writes are never going to create page cache, right?

And in that case, why not put this at the end of iomap_write_actor?

(Sorry if this came up in the earlier discussions, I've been busy this
week and still have a long way to go for catching up...)

> +		struct address_space *mapping = data->inode->i_mapping;
> +
> +		end = data->pos + written;
> +		ret = filemap_write_and_wait_range(mapping, data->pos, end);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * No pages were created for this range, we're done
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
> index 0a1a195ed1cc..df9d6002858e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -659,6 +659,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
> +	unsigned aop_flags;
>  	struct page *page;
>  	int status = 0;
>  
> @@ -675,8 +676,11 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  			return status;
>  	}
>  
> +	aop_flags = AOP_FLAG_NOFS;
> +	if (flags & IOMAP_UNCACHED)
> +		aop_flags |= AOP_FLAG_UNCACHED;
>  	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
> -			AOP_FLAG_NOFS);
> +						aop_flags);
>  	if (!page) {
>  		status = -ENOMEM;
>  		goto out_no_page;
> @@ -818,6 +822,7 @@ iomap_write_actor(const struct iomap_data *data, struct iomap *iomap,
>  {
>  	struct inode *inode = data->inode;
>  	struct iov_iter *i = data->priv;
> +	unsigned flags = data->flags;
>  	loff_t length = data->len;
>  	loff_t pos = data->pos;
>  	long status = 0;
> @@ -851,10 +856,17 @@ iomap_write_actor(const struct iomap_data *data, struct iomap *iomap,
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
> +			if (status == -ENOMEM && (flags & IOMAP_UNCACHED)) {
> +				iomap->flags |= IOMAP_F_PAGE_CREATE;
> +				flags &= ~IOMAP_UNCACHED;
> +				goto retry;
> +			}
>  			break;
> +		}
>  
>  		if (mapping_writably_mapped(inode->i_mapping))
>  			flush_dcache_page(page);
> @@ -907,6 +919,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  	};
>  	loff_t ret = 0, written = 0;
>  
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		data.flags |= IOMAP_UNCACHED;
> +
>  	while (iov_iter_count(iter)) {
>  		data.len = iov_iter_count(iter);
>  		ret = iomap_apply(&data, ops, iomap_write_actor);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 30f40145a9e9..30bb248e1d0d 100644
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

I think these new flags need an update to the _STRINGS arrays in
fs/iomap/trace.h.
>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -121,6 +125,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_UNCACHED		(1 << 6)

No comment?

--D

>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.24.1
> 
