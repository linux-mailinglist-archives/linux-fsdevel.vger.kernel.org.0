Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2D3CE98E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353701AbhGSQ5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354287AbhGSQyq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:54:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3E4B610D2;
        Mon, 19 Jul 2021 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716122;
        bh=dETVzRC81+szm3W9dRbFGyOT17Rfuzddg+Gw8WA4Qxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrxxyzj2PAAwKui2bPk2/ovzpnfhtjbiKnjMqZ//jhnRc5htekAQtuPn41XnLgADL
         b07CwYuRul0VJ960Qg13uBNiQYWzerjgyYT2tmoDPhYNJGMEFb7XJSJ+P/Nfb0HZml
         gga/ptz6DA0oGvih5zVyOAHI6wXxB4e3xvLM2pgyGZSNGtCrnDi2d+kd7eblvMEXhP
         KQfZaMMmBtdVPYhA4df9hj4SicEPdCZeamd7NAlUsHqKiGx4IBH2XOKl+mHmoZFujE
         zLWX3O5Ae1g4GdhuxlNn8LrvHztRFgbGz9bG84iQqZAKAZqn0R0g2a2ghmE5emRGgx
         7Z7/qu/4dkMDg==
Date:   Mon, 19 Jul 2021 10:35:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 04/27] fs: mark the iomap argument to
 __block_write_begin_int const
Message-ID: <20210719173521.GD22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:57PM +0200, Christoph Hellwig wrote:
> __block_write_begin_int never modifies the passed in iomap, so mark it
> const.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/buffer.c   | 4 ++--
>  fs/internal.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 6290c3afdba488..bd6a9e9fbd64c9 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1912,7 +1912,7 @@ EXPORT_SYMBOL(page_zero_new_buffers);
>  
>  static void
>  iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
> -		struct iomap *iomap)
> +		const struct iomap *iomap)
>  {
>  	loff_t offset = block << inode->i_blkbits;
>  
> @@ -1966,7 +1966,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  }
>  
>  int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> -		get_block_t *get_block, struct iomap *iomap)
> +		get_block_t *get_block, const struct iomap *iomap)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
>  	unsigned to = from + len;
> diff --git a/fs/internal.h b/fs/internal.h
> index 3ce8edbaa3ca2f..9ad6b5157584b8 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -48,8 +48,8 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
>  /*
>   * buffer.c
>   */
> -extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> -		get_block_t *get_block, struct iomap *iomap);
> +int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> +		get_block_t *get_block, const struct iomap *iomap);
>  
>  /*
>   * char_dev.c
> -- 
> 2.30.2
> 
