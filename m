Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1653C1E11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 06:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGIE03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 00:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIE03 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:26:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 305BC600CC;
        Fri,  9 Jul 2021 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625804626;
        bh=zYrYpFHh+ic5c2t7VCTpfDE8HIyIp+/BUqxPvGY2Cbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtCQFOQ9u0XYPxWT39weq7fdDimGEtFMBjAYLrmGy584OogHWqJPQejDlZoHhMV00
         JLP3OWa1ZTUCWs5sgkGILugxppB1C7YvTv1kfDnyU57l+LkXcoG+mbYR+1kLrUVV51
         eWmESLu8XC8mrDR0ItD2V/cyQSZBw2p6mex5z1i6W1sqZDrmqCaLs0Jt2EgGhJKG3y
         7HXoaD5Tuk9XgGQk1O9AZq6DaCLAihJnXtH1EukCSj12M8hQhTVYGG4Zf3XH6f7CaB
         z6eaWYUD+NByveiENSG+fmlIWjoJZrpzheiTu8yKTIuo9vV33VE4iJeGgo0dC5q5zp
         vRBj3nArCQiOA==
Date:   Thu, 8 Jul 2021 21:23:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] iomap: Permit pages without an iop to enter
 writeback
Message-ID: <20210709042345.GS11588@locust>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707115524.2242151-2-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:55:22PM +0200, Andreas Gruenbacher wrote:
> Create an iop in the writeback path if one doesn't exist.  This allows us
> to avoid creating the iop in some cases.  We'll initially do that for pages
> with inline data, but it can be extended to pages which are entirely within
> an extent.  It also allows for an iop to be removed from pages in the
> future (eg page split).
> 
> Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Seems simple enough...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9023717c5188..598fcfabc337 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1334,14 +1334,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
> -- 
> 2.26.3
> 
