Return-Path: <linux-fsdevel+bounces-46533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B9A8AF53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36A64422B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 04:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5B229B3C;
	Wed, 16 Apr 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="acJzc+8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E362DFA2D;
	Wed, 16 Apr 2025 04:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778772; cv=none; b=mUdQeAEeCnzXRLS4iDCZxidAMFAfUGGq9n+6eWZFG6A984YzeGUwVOVbiAzeps0IzGsEXomxhTq25T6wXPOyYChFD4GWaYcgJfMQQgAmZzze9z0vYzuNG2Ejm5Hgy7j0TiLO2za9ZzXRbO9rhpAbtP+i5CjYJWVkW3yWkl9J2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778772; c=relaxed/simple;
	bh=CaZ/wusnxnIx9hbYKNJzHxeAlgxSvkYs/zWkPRXi7VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDvxUwHgxfXnhDwGF+eb/WC/QpOubjxHUQP4rspoehQKQPTIGSX4Niy8qYt6uBkqvljJ50v02yefqv+Z0pIKK53nYYohKlNRBsYfeenll9YWHhmhFxhLg85KoSropXpnxSsWiSq1Ckg379x2g5PF6U9+r39s1IWlBl4v1ZhJB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=acJzc+8F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6FFkzQFTPC9we4OOy/omz/vWt9g7xQNMlGPGgd9EBXc=; b=acJzc+8F2kSGDSGEHwYfZ8J7Ad
	vK7IGl/M+16dZ0ww/OJN/y1fjkfcawqIgG1hwq6iQitpLMKRq1GGKHl9l6OJZ7XwhtsOHGgAmHpBK
	1kYw5gCHbI8G8Yb5A62Gd/SyZuK0XR+nGqXnYuFgbwmrJFdrfmTDH/TdDIEVfZeqM3pXSvR6EmVON
	iGeGDRCSKTJDIrQGUJRPE6v3nZjTBfg0n/MTjEL+uyjz6oHRHndiyOk/gz6rUp00Xs9r1adC25bx9
	vggnR0xszDQwaJ4+WeCfUksgs7+smFPjvbTzqrZFzJP0XWgvxKHyWoRQ/GdUJyZdxJhQOh0i8VAlV
	6Vyhkviw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uf3-00000008BL6-2hN1;
	Wed, 16 Apr 2025 04:46:09 +0000
Date: Tue, 15 Apr 2025 21:46:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	axboe@kernel.dk, Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>, Jack Vogel <jack.vogel@oracle.com>
Subject: Re: [RF[CRAP] 2/2] xfs: stop using set_blocksize
Message-ID: <Z_82ETKMHDxE4N2e@infradead.org>
References: <20250415001405.GA25659@frogsfrogsfrogs>
 <20250415003308.GE25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415003308.GE25675@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 14, 2025 at 05:33:08PM -0700, Darrick J. Wong wrote:
> +/*
> + * For bdev filesystems that do not use buffer heads, check that this block
> + * size is acceptable and flush dirty pagecache to disk.
> + */

Can you turn this into a full fledged kerneldoc comment?

> +int bdev_use_blocksize(struct file *file, int size)
> +{
> +	struct inode *inode = file->f_mapping->host;
> +	struct block_device *bdev = I_BDEV(inode);
> +
> +	if (blk_validate_block_size(size))
> +		return -EINVAL;
> +
> +	/* Size cannot be smaller than the size supported by the device */
> +	if (size < bdev_logical_block_size(bdev))
> +		return -EINVAL;
> +
> +	if (!file->private_data)
> +		return -EINVAL;

This private_data check looks really confusing.  Looking it up I see
that it is directly copied from set_blocksize, but it could really
use a comment.  Or in fact be removed here and kept in set_blocksize
only as we don't care about an exclusive opener at all.   Even there
a comment would be rather helpful, though.

> +
> +	return sync_blockdev(bdev);
> +}

I don't think we need sync_blockdev here as we don't touch the
bdev page cache.  Maybe XFS wants to still call it, but it feels
wrong in a helper just validating the block size.

So maybe drop it, rename the helper to bdev_validate_block_size
and use it in set_blocksize instead of duplicating the logic?

> +	error = bdev_use_blocksize(btp->bt_bdev_file, sectorsize);

.. and then split using it in XFS into a separate patch from adding
the block layer helper.


