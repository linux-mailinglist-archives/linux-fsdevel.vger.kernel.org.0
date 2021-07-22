Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4E3D2CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 21:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhGVSzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 14:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhGVSzB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDFD960EB2;
        Thu, 22 Jul 2021 19:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626982536;
        bh=N87jrdM3XCEarm8/WN+mZ5vTU9sAfWIKvVhPEGfQx34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMfh/jtRFXutY0DkCr9OQAiZ4+1N4cMdmowRCDadY0dddXfWcyRx/H9DD4JTKjPmG
         KwCE8u2rbU5MeVHMAcb/MDbYLRBea66zYlKnuvxbzCxqgLKZ7Nt1elyPhWmTMGO6Pz
         fvHAo1KQycHydNZLNtsg7Vi5FtlIiVVzvio9dZOVpS6h71F4ho9Mb7uRZQyYsg7rEC
         91U7nQmH9dTL1AD8Rjg/lgSNRuWkROrwREPSZ6ID+5VeM/Z9IZ3hjix5HjMFwXOd12
         rl4RFkChNEsNO8SoWQcGRpZl+kLuPyHpEwtm6ih8jwjDzdtEFVO7ItLcTuEt0jBDNT
         YUvBqajcz1EXQ==
Date:   Thu, 22 Jul 2021 12:35:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] iomap: simplify iomap_add_to_ioend
Message-ID: <20210722193535.GN559212@magnolia>
References: <20210722054256.932965-1-hch@lst.de>
 <20210722054256.932965-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722054256.932965-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 07:42:56AM +0200, Christoph Hellwig wrote:
> Now that the outstanding writes are counted in bytes, there is no need
> to use the low-level __bio_try_merge_page API, we can switch back to
> always using bio_add_page and simply iomap_add_to_ioend again.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Pretty straightforward.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7898c1c47370e6..d31e0d3b50c683 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1252,7 +1252,6 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  	sector_t sector = iomap_sector(&wpc->iomap, offset);
>  	unsigned len = i_blocksize(inode);
>  	unsigned poff = offset & (PAGE_SIZE - 1);
> -	bool merged, same_page = false;
>  
>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
>  		if (wpc->ioend)
> @@ -1260,19 +1259,13 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
>  	}
>  
> -	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
> -			&same_page);
> -	if (iop)
> -		atomic_add(len, &iop->write_bytes_pending);
> -
> -	if (!merged) {
> -		if (bio_full(wpc->ioend->io_bio, len)) {
> -			wpc->ioend->io_bio =
> -				iomap_chain_bio(wpc->ioend->io_bio);
> -		}
> -		bio_add_page(wpc->ioend->io_bio, page, len, poff);
> +	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
> +		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
> +		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
>  	}
>  
> +	if (iop)
> +		atomic_add(len, &iop->write_bytes_pending);
>  	wpc->ioend->io_size += len;
>  	wbc_account_cgroup_owner(wbc, page, len);
>  }
> -- 
> 2.30.2
> 
