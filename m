Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B963CAE77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGOVYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhGOVX7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC4261370;
        Thu, 15 Jul 2021 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626384066;
        bh=Rw8o6ytQU5EtxnBDGvOPJFHtFL+W8pEdTFS0nDyL4To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dA6woPO0Ue5JWodjxKVbr5qmYNQkNKPPqKYxy1sYKm2L1Iuim3imV4s7Lua/9+DhB
         3+l+oCbVncCxXEo5X98oYvxlQ9dpeElrdmJly0GA9UHPNFozxlfUE5WUfjBUms+L7b
         fIczy+qua3Ef6+vJFPyPX5BlJeyeF+bcviqkaNhKzeNoP3zWKxd+xAXO3bQtCFuMIm
         Cj4Rn35rSIgyU+lRzHcjOtjFE0hB6Nk3ScYq9XN4VE2vQMBVVuTXV2BP+ZiY3trNsF
         EkP2Z+jVLQkEYSRBEhsZ5Ndkn8Ofe27jlcKz0fpWXJ+n/aq8opXVjMbgCbWoant+FX
         hElOxz7WaPCHg==
Date:   Thu, 15 Jul 2021 14:21:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 097/138] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <20210715212105.GH22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-98-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-98-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:23AM +0100, Matthew Wilcox (Oracle) wrote:
> All but one caller already has the iomap_page, and we can avoid getting
> it again.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Took me a while to distinguish iomap_iop_set_range_uptodate and
iomap_set_range_uptodate, but yes, this looks pretty simple.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6b41019a51a3..fbe4ebc074ce 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -134,11 +134,9 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  	*lenp = plen;
>  }
>  
> -static void
> -iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
> +static void iomap_iop_set_range_uptodate(struct page *page,
> +		struct iomap_page *iop, unsigned off, unsigned len)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct iomap_page *iop = to_iomap_page(folio);
>  	struct inode *inode = page->mapping->host;
>  	unsigned first = off >> inode->i_blkbits;
>  	unsigned last = (off + len - 1) >> inode->i_blkbits;
> @@ -151,14 +149,14 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>  }
>  
> -static void
> -iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
> +static void iomap_set_range_uptodate(struct page *page,
> +		struct iomap_page *iop, unsigned off, unsigned len)
>  {
>  	if (PageError(page))
>  		return;
>  
> -	if (page_has_private(page))
> -		iomap_iop_set_range_uptodate(page, off, len);
> +	if (iop)
> +		iomap_iop_set_range_uptodate(page, iop, off, len);
>  	else
>  		SetPageUptodate(page);
>  }
> @@ -174,7 +172,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
>  		ClearPageUptodate(page);
>  		SetPageError(page);
>  	} else {
> -		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
> +		iomap_set_range_uptodate(page, iop, bvec->bv_offset,
> +						bvec->bv_len);
>  	}
>  
>  	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
> @@ -254,7 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
>  		zero_user(page, poff, plen);
> -		iomap_set_range_uptodate(page, poff, plen);
> +		iomap_set_range_uptodate(page, iop, poff, plen);
>  		goto done;
>  	}
>  
> @@ -583,7 +582,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  			if (status)
>  				return status;
>  		}
> -		iomap_set_range_uptodate(page, poff, plen);
> +		iomap_set_range_uptodate(page, iop, poff, plen);
>  	} while ((block_start += plen) < block_end);
>  
>  	return 0;
> @@ -645,6 +644,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		size_t copied, struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	flush_dcache_page(page);
>  
>  	/*
> @@ -660,7 +661,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 */
>  	if (unlikely(copied < len && !PageUptodate(page)))
>  		return 0;
> -	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> +	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
>  	__set_page_dirty_nobuffers(page);
>  	return copied;
>  }
> -- 
> 2.30.2
> 
