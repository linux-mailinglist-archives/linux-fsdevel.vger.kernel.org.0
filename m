Return-Path: <linux-fsdevel+bounces-25702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FA94F554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E1B20C0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E918757D;
	Mon, 12 Aug 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWaIZji1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7902B9B5;
	Mon, 12 Aug 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481686; cv=none; b=R71aZhnFiLF8lDvq5zwdW/9QFnPzCLlp99ABBZZ+D7M8G1ydwJy/YwQpAyySwZVyYy4ZJjN1QwXLtyeyl5vjsx5SEVZyAyJ87LYEVzwDf30sRJTT/kuMwQO3zl2b25lkXoHhg9oSPpF5fcoFQAzSzTwlN00855LWOv8H8FqpDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481686; c=relaxed/simple;
	bh=VhKsm6Vvx9GssifaWoj9lqaR48p4bcYf72vm8qwKck8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXP+tZFzt+9TNhFhXaeTolsWZBNtJoHi3KAauV70g0rYJshUbe5/REMYhwF1mh8AxYowGlqSPLj9ZK/9grFqlPJkQq4dY7yqktE+zWtHUstwiRMjd286OA8/Bg9zZjMCgnFNL6yXwI5euXbVF+YBh0j9zNOpwVI2JNGTuwrmqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWaIZji1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80480C32782;
	Mon, 12 Aug 2024 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481685;
	bh=VhKsm6Vvx9GssifaWoj9lqaR48p4bcYf72vm8qwKck8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWaIZji1k1bSAWOOoAumyC+EtoNJhcQIPakTZeaPeVE3QFwZqE5g0brYO6/GBdHvs
	 20qzPWQShgm3EqGv7uGJ1p54kSIg3HUFhfmuviSHLFJINrkJQbFz7sKge6Q04/53X3
	 +x5tS+K+aaF+P27VPGPtNTvoVzrDAB932UAmaU6Pv3NrOXMvWiXVmgk9gYyIt2WrNA
	 /yskT6YPoV1+Pe5bq0nRwbywU783nmsWkImn5z+EmEvKG0lNY/nb/B9AInAfzj+5Mk
	 i+cmdayoSWBujPHokGqVD/EclQhj3uG0WwYD9d8Z/n2vdRl1Dn1sR8072jxS9ANXhR
	 61YZKYZNVfKQQ==
Date: Mon, 12 Aug 2024 09:54:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 6/6] iomap: reduce unnecessary state_lock when setting
 ifs uptodate and dirty bits
Message-ID: <20240812165444.GG6043@frogsfrogsfrogs>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-7-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:59PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When doing buffered write, we set uptodate and drity bits of the written
> range separately, it holds the ifs->state_lock twice when blocksize <
> folio size, which is redundant. After large folio is supported, the
> spinlock could affect more about the performance, merge them could
> reduce some unnecessary locking overhead and gets some performance gain.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Seems reasonable to me
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 96600405dbb5..67d7c1c22c98 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -182,6 +182,37 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
>  		ifs_set_range_dirty(folio, ifs, off, len);
>  }
>  
> +static void ifs_set_range_dirty_uptodate(struct folio *folio,
> +		struct iomap_folio_state *ifs, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = (off >> inode->i_blkbits);
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ifs->state_lock, flags);
> +	bitmap_set(ifs->state, first_blk, nr_blks);
> +	if (ifs_is_fully_uptodate(folio, ifs))
> +		folio_mark_uptodate(folio);
> +	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&ifs->state_lock, flags);
> +}
> +
> +static void iomap_set_range_dirty_uptodate(struct folio *folio,
> +		size_t off, size_t len)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	if (ifs)
> +		ifs_set_range_dirty_uptodate(folio, ifs, off, len);
> +	else
> +		folio_mark_uptodate(folio);
> +
> +	filemap_dirty_folio(folio->mapping, folio);
> +}
> +
>  static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>  		struct folio *folio, unsigned int flags)
>  {
> @@ -851,6 +882,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
> +	size_t from = offset_in_folio(folio, pos);
> +
>  	flush_dcache_folio(folio);
>  
>  	/*
> @@ -866,9 +899,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 */
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return false;
> -	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
> -	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
> -	filemap_dirty_folio(inode->i_mapping, folio);
> +
> +	iomap_set_range_dirty_uptodate(folio, from, copied);
>  	return true;
>  }
>  
> -- 
> 2.39.2
> 
> 

