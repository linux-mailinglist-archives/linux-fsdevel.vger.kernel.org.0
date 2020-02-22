Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D942168B5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 02:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBVBEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 20:04:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:04:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M12v9x008983;
        Sat, 22 Feb 2020 01:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XwXe3LeeqYnY95Gva2rrGwtbjccLl5UHo7DG2XsOdG8=;
 b=c3zODm1yb49i9kkytlSqFRehssnrFi/WsLe9PUH0MxVrgeD7Zcrv1AA3nHEFQUb+CgbY
 tBReygqfSVl/nokJAz6/uP5hWXG+u7MUCmMUWgpLlO9WX1pzxBbDgFcbyH5O8FJx9N8m
 JlJbPmd/lUzxodbbNLPQ3Tox7y/3o7XOiPnsE1DUvNynyQ/514T/kuANgBIjMU81iw0x
 yItNZwQnDV+DLw+Ofh96I18IA/pwrhJMrMyoQTvYx8bOswz0wLJICgR+WJnzg4ZgaGfR
 63HflMxNaV24t9qY1Xuy6oK4c2zjeSIrfU3d1mi6jAyeuzKIsRd5FXLnAr6b+2jonygi gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud1kkxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 01:03:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M12Sen061706;
        Sat, 22 Feb 2020 01:03:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2y8udg9kcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Feb 2020 01:03:56 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01M13tL8064544;
        Sat, 22 Feb 2020 01:03:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y8udg9kce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 01:03:55 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01M13tO0022000;
        Sat, 22 Feb 2020 01:03:55 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 17:03:55 -0800
Date:   Fri, 21 Feb 2020 17:03:53 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200222010353.GI9506@magnolia>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-23-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220003
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:01:01PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in iomap.  Convert XFS and ZoneFS to
> use it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Ok... so from what I saw in the mm patches, this series changes
readahead to shove the locked pages into the page cache before calling
the filesystem's ->readahead function.  Therefore, this (and the
previous patch) are more or less just getting rid of all the iomap
machinery to put pages in the cache and instead pulling them out of the
mapping prior to submitting a read bio?

If so,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 90 +++++++++++++++---------------------------
>  fs/iomap/trace.h       |  2 +-
>  fs/xfs/xfs_aops.c      | 13 +++---
>  fs/zonefs/super.c      |  7 ++--
>  include/linux/iomap.h  |  3 +-
>  5 files changed, 41 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 31899e6cb0f8..66cf453f4bb7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -214,9 +214,8 @@ iomap_read_end_io(struct bio *bio)
>  struct iomap_readpage_ctx {
>  	struct page		*cur_page;
>  	bool			cur_page_in_bio;
> -	bool			is_readahead;
>  	struct bio		*bio;
> -	struct list_head	*pages;
> +	struct readahead_control *rac;
>  };
>  
>  static void
> @@ -307,11 +306,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		if (ctx->bio)
>  			submit_bio(ctx->bio);
>  
> -		if (ctx->is_readahead) /* same as readahead_gfp_mask */
> +		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
>  		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
>  		ctx->bio->bi_opf = REQ_OP_READ;
> -		if (ctx->is_readahead)
> +		if (ctx->rac)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
>  		ctx->bio->bi_iter.bi_sector = sector;
>  		bio_set_dev(ctx->bio, iomap->bdev);
> @@ -367,36 +366,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readpage);
>  
> -static struct page *
> -iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
> -		loff_t length, loff_t *done)
> -{
> -	while (!list_empty(pages)) {
> -		struct page *page = lru_to_page(pages);
> -
> -		if (page_offset(page) >= (u64)pos + length)
> -			break;
> -
> -		list_del(&page->lru);
> -		if (!add_to_page_cache_lru(page, inode->i_mapping, page->index,
> -				GFP_NOFS))
> -			return page;
> -
> -		/*
> -		 * If we already have a page in the page cache at index we are
> -		 * done.  Upper layers don't care if it is uptodate after the
> -		 * readpages call itself as every page gets checked again once
> -		 * actually needed.
> -		 */
> -		*done += PAGE_SIZE;
> -		put_page(page);
> -	}
> -
> -	return NULL;
> -}
> -
>  static loff_t
> -iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> +iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
> @@ -404,10 +375,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  	while (done < length) {
>  		if (!ctx->cur_page) {
> -			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> -					pos, length, &done);
> -			if (!ctx->cur_page)
> -				break;
> +			ctx->cur_page = readahead_page(ctx->rac);
>  			ctx->cur_page_in_bio = false;
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> @@ -431,44 +399,48 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  	return done;
>  }
>  
> -int
> -iomap_readpages(struct address_space *mapping, struct list_head *pages,
> -		unsigned nr_pages, const struct iomap_ops *ops)
> +/**
> + * iomap_readahead - Attempt to read pages from a file.
> + * @rac: Describes the pages to be read.
> + * @ops: The operations vector for the filesystem.
> + *
> + * This function is for filesystems to call to implement their readahead
> + * address_space operation.
> + *
> + * Context: The file is pinned by the caller, and the pages to be read are
> + * all locked and have an elevated refcount.  This function will unlock
> + * the pages (once I/O has completed on them, or I/O has been determined to
> + * not be necessary).  It will also decrease the refcount once the pages
> + * have been submitted for I/O.  After this point, the page may be removed
> + * from the page cache, and should not be referenced.
> + */
> +void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  {
> +	struct inode *inode = rac->mapping->host;
> +	loff_t pos = readahead_pos(rac);
> +	loff_t length = readahead_length(rac);
>  	struct iomap_readpage_ctx ctx = {
> -		.pages		= pages,
> -		.is_readahead	= true,
> +		.rac	= rac,
>  	};
> -	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
>  
> -	trace_iomap_readpages(mapping->host, nr_pages);
> +	trace_iomap_readahead(inode, readahead_count(rac));
>  
>  	while (length > 0) {
> -		ret = iomap_apply(mapping->host, pos, length, 0, ops,
> -				&ctx, iomap_readpages_actor);
> +		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
> +				&ctx, iomap_readahead_actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> -			goto done;
> +			break;
>  		}
>  		pos += ret;
>  		length -= ret;
>  	}
> -	ret = 0;
> -done:
> +
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
>  	BUG_ON(ctx.cur_page);
> -
> -	/*
> -	 * Check that we didn't lose a page due to the arcance calling
> -	 * conventions..
> -	 */
> -	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
> -	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iomap_readpages);
> +EXPORT_SYMBOL_GPL(iomap_readahead);
>  
>  /*
>   * iomap_is_partially_uptodate checks whether blocks within a page are
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 6dc227b8c47e..d6ba705f938a 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -39,7 +39,7 @@ DEFINE_EVENT(iomap_readpage_class, name,	\
>  	TP_PROTO(struct inode *inode, int nr_pages), \
>  	TP_ARGS(inode, nr_pages))
>  DEFINE_READPAGE_EVENT(iomap_readpage);
> -DEFINE_READPAGE_EVENT(iomap_readpages);
> +DEFINE_READPAGE_EVENT(iomap_readahead);
>  
>  DECLARE_EVENT_CLASS(iomap_page_class,
>  	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 58e937be24ce..6e68eeb50b07 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -621,14 +621,11 @@ xfs_vm_readpage(
>  	return iomap_readpage(page, &xfs_read_iomap_ops);
>  }
>  
> -STATIC int
> -xfs_vm_readpages(
> -	struct file		*unused,
> -	struct address_space	*mapping,
> -	struct list_head	*pages,
> -	unsigned		nr_pages)
> +STATIC void
> +xfs_vm_readahead(
> +	struct readahead_control	*rac)
>  {
> -	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
> +	iomap_readahead(rac, &xfs_read_iomap_ops);
>  }
>  
>  static int
> @@ -644,7 +641,7 @@ xfs_iomap_swapfile_activate(
>  
>  const struct address_space_operations xfs_address_space_operations = {
>  	.readpage		= xfs_vm_readpage,
> -	.readpages		= xfs_vm_readpages,
> +	.readahead		= xfs_vm_readahead,
>  	.writepage		= xfs_vm_writepage,
>  	.writepages		= xfs_vm_writepages,
>  	.set_page_dirty		= iomap_set_page_dirty,
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 8bc6ef82d693..8327a01d3bac 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -78,10 +78,9 @@ static int zonefs_readpage(struct file *unused, struct page *page)
>  	return iomap_readpage(page, &zonefs_iomap_ops);
>  }
>  
> -static int zonefs_readpages(struct file *unused, struct address_space *mapping,
> -			    struct list_head *pages, unsigned int nr_pages)
> +static void zonefs_readahead(struct readahead_control *rac)
>  {
> -	return iomap_readpages(mapping, pages, nr_pages, &zonefs_iomap_ops);
> +	iomap_readahead(rac, &zonefs_iomap_ops);
>  }
>  
>  /*
> @@ -128,7 +127,7 @@ static int zonefs_writepages(struct address_space *mapping,
>  
>  static const struct address_space_operations zonefs_file_aops = {
>  	.readpage		= zonefs_readpage,
> -	.readpages		= zonefs_readpages,
> +	.readahead		= zonefs_readahead,
>  	.writepage		= zonefs_writepage,
>  	.writepages		= zonefs_writepages,
>  	.set_page_dirty		= iomap_set_page_dirty,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..bc20bd04c2a2 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -155,8 +155,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
>  int iomap_readpage(struct page *page, const struct iomap_ops *ops);
> -int iomap_readpages(struct address_space *mapping, struct list_head *pages,
> -		unsigned nr_pages, const struct iomap_ops *ops);
> +void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  int iomap_set_page_dirty(struct page *page);
>  int iomap_is_partially_uptodate(struct page *page, unsigned long from,
>  		unsigned long count);
> -- 
> 2.25.0
> 
