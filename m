Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA53CAE5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhGOVMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhGOVL7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F4C2613C3;
        Thu, 15 Jul 2021 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626383345;
        bh=MAxyyVaKY3GD4cnJ4LiMPgmv/Rs15AJKqkGtsFTJAg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObZm+IkXPYqHsR2V/ZesMW3EEKhaKW+5K4vQu2sx7bgk8VlptKZND3iPiwHId9uSy
         tfiBUuPxoZdr78FiiJAEitUwugWuO2suLRx7QZY67iq9nKwZJh4AFJ3967Yw5iZLCz
         xBNA+EkGd4vv8JUA3kcQZe4/e31DsBsfdakHJALprCDX2Yxwixhzq9XlBlZYUxrdhb
         WaS82tr6A/q+um43dMWfMk0RG7drqXaJsgPW81lXLCwzh5Y9Plu4JH+bGJkeKiTnXu
         kw2Wr2Gw84Xdcj1vKhT7/au1Yu94JBeM0HEE3C8MdHJZ5BRras5ZS+WTNSAAO5XuTR
         rjdJBJ6t8CQYg==
Date:   Thu, 15 Jul 2021 14:09:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 092/138] iomap: Convert to_iomap_page to take a folio
Message-ID: <20210715210904.GD22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-93-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-93-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:18AM +0100, Matthew Wilcox (Oracle) wrote:
> The big comment about only using a head page can go away now that
> it takes a folio argument.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks decent to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 41da4f14c00b..cd5c2f24cb7e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -22,8 +22,8 @@
>  #include "../internal.h"
>  
>  /*
> - * Structure allocated for each page or THP when block size < page size
> - * to track sub-page uptodate status and I/O completions.
> + * Structure allocated for each folio when block size < folio size
> + * to track sub-folio uptodate status and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_bytes_pending;
> @@ -32,17 +32,10 @@ struct iomap_page {
>  	unsigned long		uptodate[];
>  };
>  
> -static inline struct iomap_page *to_iomap_page(struct page *page)
> +static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  {
> -	/*
> -	 * per-block data is stored in the head page.  Callers should
> -	 * not be dealing with tail pages (and if they are, they can
> -	 * call thp_head() first.
> -	 */
> -	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> -
> -	if (page_has_private(page))
> -		return (struct iomap_page *)page_private(page);
> +	if (folio_test_private(folio))
> +		return folio_get_private(folio);
>  	return NULL;
>  }
>  
> @@ -51,7 +44,8 @@ static struct bio_set iomap_ioend_bioset;
>  static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	unsigned int nr_blocks = i_blocks_per_page(inode, page);
>  
>  	if (iop || nr_blocks <= 1)
> @@ -144,7 +138,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  static void
>  iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	struct inode *inode = page->mapping->host;
>  	unsigned first = off >> inode->i_blkbits;
>  	unsigned last = (off + len - 1) >> inode->i_blkbits;
> @@ -173,7 +168,8 @@ static void
>  iomap_read_page_end_io(struct bio_vec *bvec, int error)
>  {
>  	struct page *page = bvec->bv_page;
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  
>  	if (unlikely(error)) {
>  		ClearPageUptodate(page);
> @@ -433,7 +429,8 @@ int
>  iomap_is_partially_uptodate(struct page *page, unsigned long from,
>  		unsigned long count)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	struct inode *inode = page->mapping->host;
>  	unsigned len, first, last;
>  	unsigned i;
> @@ -1011,7 +1008,8 @@ static void
>  iomap_finish_page_writeback(struct inode *inode, struct page *page,
>  		int error, unsigned int len)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  
>  	if (error) {
>  		SetPageError(page);
> @@ -1304,7 +1302,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct page *page, u64 end_offset)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	u64 file_offset; /* file offset of page */
> -- 
> 2.30.2
> 
