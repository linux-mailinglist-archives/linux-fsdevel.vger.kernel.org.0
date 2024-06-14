Return-Path: <linux-fsdevel+bounces-21692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F221908387
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 08:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78501F22F25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD71482F1;
	Fri, 14 Jun 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tmd1v7iE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E419D895;
	Fri, 14 Jun 2024 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345322; cv=none; b=IKdZ/lBQgruioeohN/DGd3XUXrxKIlUvpd+43ZNViJf8uE6sssUEeTkSYK/Jzk/lYheU9nierwGfcf8NO2iwOm+NLdabWWK+7k+7li6Gwqlx1ASNjNRUM8G0AA/ves24XpaWOUVVNuVyXSHA/MSisS+4gBwmTFoVhWLY+wAdglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345322; c=relaxed/simple;
	bh=8G/2mHwOwOhpItp5pcQRm+rnfp6/UqSj+cwzOmd5mMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhIjPR4Y6z/orvu8qRoLPe/yh3FSfcTw5i2Jvrs/DgVTxQVAE4PmGCM11mDREpmFH8oxCDUZj/9CAER6hVDKh/35ccNiWp+y1udFXIaILhanR3jd5otoTANEP5R5D1whIFSEBl1uZv+egjPvArxpDxuNj8DruAxi8DsIhkWUkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tmd1v7iE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lbxS/h3IReDeUhT/MBloXsxorV0i3LcgE2hrsf9Xl4k=; b=Tmd1v7iE6OjbLzsCwusZObQZ62
	NcQX7XnjUd5YPjCpUAhRvbCaBpechJQ67SE7IqkONRxIlVfD1+kgC1GS9BryUufXDCbc/q3P0fecY
	9Xp8LAnGoNkLbckqoSmLzd8yZwFAg+C+QvJWZTePfmfmKntIFOLcFT3nZyQbRTg3e9BkFQEJ8/Gem
	ip3GsDdusCX4VV1XdAdev3jB0q9tpAKolXvRH7t95JOy7dLQJkAtwICMmC/b5cPVkpxhJLMJy1o7I
	E7FLDxourTfE/9132eobG2R6D5OfiHlNQn8nVPT0ZWL/0zVx7mlTw4o7J+S5Wnqa8DiPlc4J+wW6S
	SfoQfeWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI075-00000001aSh-04js;
	Fri, 14 Jun 2024 06:08:39 +0000
Date: Thu, 13 Jun 2024 23:08:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH -next v5 7/8] xfs: speed up truncating down a big
 realtime inode
Message-ID: <ZmveZolfY0Q0--1k@infradead.org>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 13, 2024 at 05:00:32PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> If we truncate down a big realtime inode, zero out the entire aligned
> EOF extent could gets slow down as the rtextsize increases. Fortunately,
> __xfs_bunmapi() would align the unmapped range to rtextsize, split and
> convert the blocks beyond EOF to unwritten. So speed up this by
> adjusting the unitsize to the filesystem blocksize when truncating down
> a large realtime inode, let __xfs_bunmapi() convert the tail blocks to
> unwritten, this could improve the performance significantly.
> 
>  # mkfs.xfs -f -rrtdev=/dev/pmem1s -f -m reflink=0,rmapbt=0, \
>             -d rtinherit=1 -r extsize=$rtextsize /dev/pmem2s
>  # mount -ortdev=/dev/pmem1s /dev/pmem2s /mnt/scratch
>  # for i in {1..1000}; \
>    do dd if=/dev/zero of=/mnt/scratch/$i bs=$rtextsize count=1024; done
>  # sync
>  # time for i in {1..1000}; \
>    do xfs_io -c "truncate 4k" /mnt/scratch/$i; done
> 
>  rtextsize       8k      16k      32k      64k     256k     1024k
>  before:       9.601s  10.229s  11.153s  12.086s  12.259s  20.141s
>  after:        9.710s   9.642s   9.958s   9.441s  10.021s  10.526s
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_inode.c | 10 ++++++++--
>  fs/xfs/xfs_iops.c  |  9 +++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 92daa2279053..5e837ed093b0 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1487,6 +1487,7 @@ xfs_itruncate_extents_flags(
>  	struct xfs_trans	*tp = *tpp;
>  	xfs_fileoff_t		first_unmap_block;
>  	int			error = 0;
> +	unsigned int		unitsize = xfs_inode_alloc_unitsize(ip);
>  
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	if (atomic_read(&VFS_I(ip)->i_count))
> @@ -1510,9 +1511,14 @@ xfs_itruncate_extents_flags(
>  	 *
>  	 * We have to free all the blocks to the bmbt maximum offset, even if
>  	 * the page cache can't scale that far.
> +	 *
> +	 * For big realtime inode, don't aligned to allocation unitsize,
> +	 * it'll split the extent and convert the tail blocks to unwritten.
>  	 */
> +	if (xfs_inode_has_bigrtalloc(ip))
> +		unitsize = i_blocksize(VFS_I(ip));
> +	first_unmap_block = XFS_B_TO_FSB(mp, roundup_64(new_size, unitsize));

If you expand what xfs_inode_alloc_unitsize and xfs_inode_has_bigrtalloc
this is looking a bit silly:

	unsigned int            blocks = 1;

	if (XFS_IS_REALTIME_INODE(ip))
		blocks = ip->i_mount->m_sb.sb_rextsize;

	unitsize = XFS_FSB_TO_B(ip->i_mount, blocks);
	if (XFS_IS_REALTIME_INODE(ip) && ip->i_mount->m_sb.sb_rextsize > 1)
		unsitsize = i_blocksize(inode);

So I think we can simply drop this part now that the variant that zeroes
the entire rtextent is gone.

> @@ -862,6 +862,15 @@ xfs_setattr_truncate_data(
>  	/* Truncate down */
>  	blocksize = xfs_inode_alloc_unitsize(ip);
>  
> +	/*
> +	 * If it's a big realtime inode, zero out the entire EOF extent could
> +	 * get slow down as the rtextsize increases, speed it up by adjusting
> +	 * the blocksize to the filesystem blocksize, let __xfs_bunmapi() to
> +	 * split the extent and convert the tail blocks to unwritten.
> +	 */
> +	if (xfs_inode_has_bigrtalloc(ip))
> +		blocksize = i_blocksize(inode);

Same here.  And with that probably also the passing of the block size
to the truncate_page helpers.

