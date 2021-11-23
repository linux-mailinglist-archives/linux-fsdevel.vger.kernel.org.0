Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08945AFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhKWXO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhKWXO4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:14:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5269F60FC1;
        Tue, 23 Nov 2021 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637709107;
        bh=ZTlnPSW4uRfqMSrZ8pBUPB0UnrwhyCERlr2JBe83rv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiNdwi6nOvl+jinS30/OWqLPBXkI25uWs/nGWxVK0H6Xsfp+Nu/hkb0xqxWSEDI/o
         gnG45m+vE7yFS3I7ujdnufldh2m6J0g6sOr31wFROeyBYatlMFmwu29UrmSFGPAQPY
         e1qjLItq/M7Canekk6PCSnE8mkV26YGfdH7rgN+cRbEbIn3KX9RmTb8YfuLvqJcKOq
         1Qax6ZSDdzCdc+oPIUKtchewKVp63IkgDaiWDFGIdnboFoBXvkeSblr7zvlatkzpw4
         VOUe8jtY6fRswxo8tJAm2u9YW9AodIoK9fdWNm1URJYFH6KUoIOoRX6o4M6dxgJbsp
         cJCgg5mwc0iFQ==
Date:   Tue, 23 Nov 2021 15:11:46 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 26/29] fsdax: shift partition offset handling into the
 file systems
Message-ID: <20211123231146.GT266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-27-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:06AM +0100, Christoph Hellwig wrote:
> Remove the last user of ->bdev in dax.c by requiring the file system to
> pass in an address that already includes the DAX offset.  As part of the
> only set ->bdev or ->daxdev when actually required in the ->iomap_begin

As part of the ... ?

"...impending disentanglement of block_device and dax_device"?

Which I assume is why we make filesystems know about partition offsets
now?

> methods.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c                 |  6 +-----
>  fs/erofs/data.c          | 11 ++++++++--
>  fs/erofs/internal.h      |  1 +
>  fs/ext2/inode.c          |  8 +++++--
>  fs/ext4/inode.c          | 16 +++++++++-----
>  fs/xfs/libxfs/xfs_bmap.c |  4 ++--
>  fs/xfs/xfs_aops.c        |  2 +-
>  fs/xfs/xfs_iomap.c       | 45 +++++++++++++++++++++++++---------------
>  fs/xfs/xfs_iomap.h       |  5 +++--
>  fs/xfs/xfs_pnfs.c        |  2 +-
>  10 files changed, 63 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 0bd6cdcbacfc4..2c13c681edf09 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -711,11 +711,7 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  
>  static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
>  {
> -	phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
> -
> -	if (iomap->bdev)
> -		paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
> -	return PHYS_PFN(paddr);
> +	return PHYS_PFN(iomap->addr + (pos & PAGE_MASK) - iomap->offset);
>  }
>  
>  static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)

<skip to the xfs part, the ext* parts look ok and I didn't look at erofs>

> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 4dccd4d90622d..74198dd82b035 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4551,7 +4551,7 @@ xfs_bmapi_convert_delalloc(
>  	 * the extent.  Just return the real extent at this offset.
>  	 */
>  	if (!isnullstartblock(bma.got.br_startblock)) {
> -		xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
> +		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
>  		*seq = READ_ONCE(ifp->if_seq);
>  		goto out_trans_cancel;
>  	}
> @@ -4598,7 +4598,7 @@ xfs_bmapi_convert_delalloc(
>  	XFS_STATS_INC(mp, xs_xstrat_quick);
>  
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
> -	xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
> +	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
>  	*seq = READ_ONCE(ifp->if_seq);
>  
>  	if (whichfork == XFS_COW_FORK)
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index c8c15c3c31471..6ac3449a68ba0 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -359,7 +359,7 @@ xfs_map_blocks(
>  	    isnullstartblock(imap.br_startblock))
>  		goto allocate_blocks;
>  
> -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 704292c6ce0c7..74dbf1fd99d39 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -54,7 +54,8 @@ xfs_bmbt_to_iomap(
>  	struct xfs_inode	*ip,
>  	struct iomap		*iomap,
>  	struct xfs_bmbt_irec	*imap,
> -	u16			flags)
> +	unsigned int		flags,
> +	u16			iomap_flags)

The argument names confused me.  Do @flags contains IOMAP_$FOO flags,
whereas @iomap_flags contains IOMAP_F_$FOO flags?  Can these be changed
to "unsigned int iomap_flags" and "u16 iomap_f_flags" to make the flags
domain more obvious, please?

I'd also take "u16 mapping_flags" for the last parameter.

--D

>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> @@ -71,16 +72,22 @@ xfs_bmbt_to_iomap(
>  		iomap->type = IOMAP_DELALLOC;
>  	} else {
>  		iomap->addr = BBTOB(xfs_fsb_to_db(ip, imap->br_startblock));
> +		if (flags & IOMAP_DAX)
> +			iomap->addr += target->bt_dax_part_off;
> +
>  		if (imap->br_state == XFS_EXT_UNWRITTEN)
>  			iomap->type = IOMAP_UNWRITTEN;
>  		else
>  			iomap->type = IOMAP_MAPPED;
> +
>  	}
>  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> -	iomap->bdev = target->bt_bdev;
> -	iomap->dax_dev = target->bt_daxdev;
> -	iomap->flags = flags;
> +	if (flags & IOMAP_DAX)
> +		iomap->dax_dev = target->bt_daxdev;
> +	else
> +		iomap->bdev = target->bt_bdev;
> +	iomap->flags = iomap_flags;
>  
>  	if (xfs_ipincount(ip) &&
>  	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
> @@ -801,7 +808,7 @@ xfs_direct_write_iomap_begin(
>  
>  	xfs_iunlock(ip, lockmode);
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
>  
>  allocate_blocks:
>  	error = -EAGAIN;
> @@ -832,18 +839,19 @@ xfs_direct_write_iomap_begin(
>  		return error;
>  
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags | IOMAP_F_NEW);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> +				 iomap_flags | IOMAP_F_NEW);
>  
>  out_found_cow:
>  	xfs_iunlock(ip, lockmode);
>  	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
>  	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
>  	if (imap.br_startblock != HOLESTARTBLOCK) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
>  		if (error)
>  			return error;
>  	}
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
>  
>  out_unlock:
>  	if (lockmode)
> @@ -1053,23 +1061,24 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
>  
>  found_imap:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
>  
>  found_cow:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	if (imap.br_startoff <= offset_fsb) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
>  		if (error)
>  			return error;
> -		return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> +					 IOMAP_F_SHARED);
>  	}
>  
>  	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
>  
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> @@ -1178,7 +1187,8 @@ xfs_read_iomap_begin(
>  	if (error)
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared ? IOMAP_F_SHARED : 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> +				 shared ? IOMAP_F_SHARED : 0);
>  }
>  
>  const struct iomap_ops xfs_read_iomap_ops = {
> @@ -1237,7 +1247,8 @@ xfs_seek_iomap_begin(
>  		if (data_fsb < cow_fsb + cmap.br_blockcount)
>  			end_fsb = min(end_fsb, data_fsb);
>  		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
> -		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> +					  IOMAP_F_SHARED);
>  		/*
>  		 * This is a COW extent, so we must probe the page cache
>  		 * because there could be dirty page cache being backed
> @@ -1259,7 +1270,7 @@ xfs_seek_iomap_begin(
>  	imap.br_state = XFS_EXT_NORM;
>  done:
>  	xfs_trim_extent(&imap, offset_fsb, end_fsb);
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
>  	return error;
> @@ -1306,7 +1317,7 @@ xfs_xattr_iomap_begin(
>  	if (error)
>  		return error;
>  	ASSERT(nimaps);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
>  }
>  
>  const struct iomap_ops xfs_xattr_iomap_ops = {
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 5648262a71736..fe7a625361d95 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -18,8 +18,9 @@ int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
>  xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
>  		xfs_fileoff_t end_fsb);
>  
> -int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
> -		struct xfs_bmbt_irec *, u16);
> +int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
> +		struct xfs_bmbt_irec *imap, unsigned int flags,
> +		u16 iomap_flags);
>  
>  int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
>  		bool *did_zero);
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index e188e1cf97cc5..d6334abbc0b3e 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -173,7 +173,7 @@ xfs_fs_map_blocks(
>  	}
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
>  	*device_generation = mp->m_generation;
>  	return error;
>  out_unlock:
> -- 
> 2.30.2
> 
