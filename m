Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA2016615D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgBTPtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:49:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgBTPtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7g85dNFHzF/fBL9mBZEQmhhyGBt/I3eV6QDa1nqOoos=; b=IvfiRDAgsZm0A9toDG9h8/8uAA
        KbYE+2vwy69rK19el39MgBf1l8Zem4llp2DdKaoFaLssf9HIohLYHoTx3yLoNphAL3B4OW2a3TqaQ
        APCgNVOUP8g+TxCalGnh8EI42nuAFMrX9cE9OX4zt+hbxXsL+0/NJcWdbqDoY7JufhSpOQo1f3wfV
        fkGP7cFp6XG76uPR5pdo5zTHChgWTTy+EJ1gchARS9Yknu04TeExGo+IFyyvEtOZG64LP3eWb02w2
        WqzkFJXmy1vTEJVCbYJfZJxS0vJbpIavKWbr+CHQ6AfPHzIjCreIBNVndGPsy/9SPIGuaAwSRaJS4
        bnKVMu2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4o4e-0005Ks-N5; Thu, 20 Feb 2020 15:49:12 +0000
Date:   Thu, 20 Feb 2020 07:49:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200220154912.GC19577@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Isn't the context documentation something that belongs into the aop
documentation?  I've never really seen the value of duplicating this
information in method instances, as it is just bound to be out of date
rather sooner than later.
