Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102553E868F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhHJXcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 19:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhHJXb6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1977C60FDA;
        Tue, 10 Aug 2021 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628638296;
        bh=FSj08AAW3P9O++pzNdzS3oQBdehBQ/2Enk0U0D8H4u0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3ByM0IXWzKuftFGqKcUgnsHAJtTMQzrbXKsUPUzERT/dKkvvEUL4hN6lbuGtyNXR
         3MpQdFKh/2aReHr8i51DmiVXL9Lslec4LmUKH8eWJhMcK6sjzi0ILG4GEPfrD5c4UK
         xi6w+9w6JjNIuA6tAzTgrvLeYlomrV/gHgNfDU2H6aIyVlVOFnayVlemAn0X1PuR+y
         bAlQ9QrfHi8ua+h/dTSEhLhDJfjBZLJx1YpPMOIdRw1aS4HYULeXPzb1kJ3p1G0BUe
         GOC4rSlDwHn4vsZyC8MekyIiBcuvqyyN28lddFLr87z/iTaOPMvQoKRimPBiTZHWPV
         BXQuLQPbonTOg==
Date:   Tue, 10 Aug 2021 16:31:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 10/30] iomap: fix the iomap_readpage_actor return value
 for inline data
Message-ID: <20210810233135.GJ3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:24AM +0200, Christoph Hellwig wrote:
> The actor should never return a larger value than the length that was
> passed in.  The current code handles this gracefully, but the opcoming
> iter model will be more picky.

s/opcoming/upcoming/

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 44587209e6d7c7..26e16cc9d44931 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,7 +205,7 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static int iomap_read_inline_data(struct inode *inode, struct page *page,
> +static loff_t iomap_read_inline_data(struct inode *inode, struct page *page,
>  		const struct iomap *iomap)
>  {
>  	size_t size = i_size_read(inode) - iomap->offset;
> @@ -253,7 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	sector_t sector;
>  
>  	if (iomap->type == IOMAP_INLINE)
> -		return iomap_read_inline_data(inode, page, iomap);
> +		return min(iomap_read_inline_data(inode, page, iomap), length);
>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> -- 
> 2.30.2
> 
