Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF173CAE6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhGOVT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGOVTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5214613C1;
        Thu, 15 Jul 2021 21:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626383788;
        bh=CnrIyDI+hMYkodapZe7ZAAirBYSm1eZwp2RO6e4FtiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqW34Wx6L0x70i/9t+HwbrXUmhdDwCl9RALBzLL2ZGbLGEGmjcanDHEs5jugWDn36
         trB17qqEA4Lwppxf4fBNfzoTdcwCGcvvMG4VOQ4QaLwFxWke8Y8TyxA2/YA9lZ162l
         V9y+9gL11x3wd0Bx3hSitYGhGMzBYc4jjWhJPfxuCLby/sZXrc1Wq4rXCaASjdSEbU
         v7Sr63trssEHbeUH9xYkJ/5kObZKUCqKYX14Mvuj3Bl+viUj67Kovx9CIHRcawX+i8
         EfsfMBEIL8WXT7Yo7A8KcwiKJ0li151K4BNbvm/Dj/jIQYUPSlgmdOc9cFlIXjrbcs
         CbCnDDQlqGG/w==
Date:   Thu, 15 Jul 2021 14:16:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 093/138] iomap: Convert iomap_page_create to take a
 folio
Message-ID: <20210715211628.GF22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-94-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-94-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:19AM +0100, Matthew Wilcox (Oracle) wrote:
> This function already assumed it was being passed a head page, so
> just formalise that.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cd5c2f24cb7e..c15a0ac52a32 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -42,11 +42,10 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  static struct bio_set iomap_ioend_bioset;
>  
>  static struct iomap_page *
> -iomap_page_create(struct inode *inode, struct page *page)
> +iomap_page_create(struct inode *inode, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct iomap_page *iop = to_iomap_page(folio);
> -	unsigned int nr_blocks = i_blocks_per_page(inode, page);
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>  
>  	if (iop || nr_blocks <= 1)
>  		return iop;
> @@ -54,9 +53,9 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
>  			GFP_NOFS | __GFP_NOFAIL);
>  	spin_lock_init(&iop->uptodate_lock);
> -	if (PageUptodate(page))
> +	if (folio_test_uptodate(folio))
>  		bitmap_fill(iop->uptodate, nr_blocks);
> -	attach_page_private(page, iop);
> +	folio_attach_private(folio, iop);
>  	return iop;
>  }
>  
> @@ -235,7 +234,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
> -	struct iomap_page *iop = iomap_page_create(inode, page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
>  	unsigned poff, plen;
> @@ -547,7 +547,8 @@ static int
>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		struct page *page, struct iomap *srcmap)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = round_down(pos, block_size);
>  	loff_t block_end = round_up(pos + len, block_size);
> @@ -955,6 +956,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page = data;
> +	struct folio *folio = page_folio(page);
>  	int ret;
>  
>  	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> @@ -964,7 +966,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  		block_commit_write(page, 0, length);
>  	} else {
>  		WARN_ON_ONCE(!PageUptodate(page));
> -		iomap_page_create(inode, page);
> +		iomap_page_create(inode, folio);
>  		set_page_dirty(page);
>  	}
>  
> -- 
> 2.30.2
> 
