Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E241E3CAE86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGOVc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhGOVc4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B43611F1;
        Thu, 15 Jul 2021 21:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626384602;
        bh=D3QDdLM89cxBk7tfEwcimk2qfKuQ6CQwajjunO6VrTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUhEnZIwp986F3rBuWYAaDd4TiNr5DR8eh2sxjLi/w42J398gXfMwbgAEmi4ywjUr
         ifqr5c/KxRc880gZ4KZStYXI9dgotUfWRN1rSigbaNGqqrdhnSSp2M0CSSCTXMNoWP
         SlovpvnTmKi2iI6IuhXCBA1X8h1+nMWGXFUeD57MwvN9Q/jCsxrAM9zg22IuxSaLaC
         MlorCXh99D1IScq7On/UVWNUu2+gVd6nARD2JwP9eLBQQXfqPquaZHsuCVR1AlghPQ
         q78ogM224/iOjcQ5munLr/tODl12zY/6nUlW3E7BNNTdxc7uvFuak1UHYmxiuHTPSB
         SVz1E8koAPtRw==
Date:   Thu, 15 Jul 2021 14:30:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 099/138] iomap: Convert bio completions to use folios
Message-ID: <20210715213002.GJ22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-100-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-100-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:25AM +0100, Matthew Wilcox (Oracle) wrote:
> Use bio_for_each_folio() to iterate over each folio in the bio
> instead of iterating over each page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Neat conversion,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 46 +++++++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 707a96e36651..4732298f74e1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -161,36 +161,29 @@ static void iomap_set_range_uptodate(struct folio *folio,
>  		folio_mark_uptodate(folio);
>  }
>  
> -static void
> -iomap_read_page_end_io(struct bio_vec *bvec, int error)
> +static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> +		size_t len, int error)
>  {
> -	struct page *page = bvec->bv_page;
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = to_iomap_page(folio);
>  
>  	if (unlikely(error)) {
>  		folio_clear_uptodate(folio);
>  		folio_set_error(folio);
>  	} else {
> -		size_t off = (page - &folio->page) * PAGE_SIZE +
> -				bvec->bv_offset;
> -
> -		iomap_set_range_uptodate(folio, iop, off, bvec->bv_len);
> +		iomap_set_range_uptodate(folio, iop, offset, len);
>  	}
>  
> -	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
> +	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
>  		folio_unlock(folio);
>  }
>  
> -static void
> -iomap_read_end_io(struct bio *bio)
> +static void iomap_read_end_io(struct bio *bio)
>  {
>  	int error = blk_status_to_errno(bio->bi_status);
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> +	struct folio_iter fi;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all)
> -		iomap_read_page_end_io(bvec, error);
> +	bio_for_each_folio_all(fi, bio)
> +		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
>  	bio_put(bio);
>  }
>  
> @@ -1014,23 +1007,21 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
> -static void
> -iomap_finish_page_writeback(struct inode *inode, struct page *page,
> -		int error, unsigned int len)
> +static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> +		size_t len, int error)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = to_iomap_page(folio);
>  
>  	if (error) {
> -		SetPageError(page);
> +		folio_set_error(folio);
>  		mapping_set_error(inode->i_mapping, -EIO);
>  	}
>  
> -	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
> +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
>  
>  	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
> -		end_page_writeback(page);
> +		folio_end_writeback(folio);
>  }
>  
>  /*
> @@ -1049,8 +1040,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  	bool quiet = bio_flagged(bio, BIO_QUIET);
>  
>  	for (bio = &ioend->io_inline_bio; bio; bio = next) {
> -		struct bio_vec *bv;
> -		struct bvec_iter_all iter_all;
> +		struct folio_iter fi;
>  
>  		/*
>  		 * For the last bio, bi_private points to the ioend, so we
> @@ -1061,10 +1051,10 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  		else
>  			next = bio->bi_private;
>  
> -		/* walk each page on bio, ending page IO on them */
> -		bio_for_each_segment_all(bv, bio, iter_all)
> -			iomap_finish_page_writeback(inode, bv->bv_page, error,
> -					bv->bv_len);
> +		/* walk all folios in bio, ending page IO on them */
> +		bio_for_each_folio_all(fi, bio)
> +			iomap_finish_folio_write(inode, fi.folio, fi.length,
> +					error);
>  		bio_put(bio);
>  	}
>  	/* The ioend has been freed by bio_put() */
> -- 
> 2.30.2
> 
