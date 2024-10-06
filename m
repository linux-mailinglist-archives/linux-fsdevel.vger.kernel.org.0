Return-Path: <linux-fsdevel+bounces-31130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB5991F9C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A941F218F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F07189BAE;
	Sun,  6 Oct 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD6eH49R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982E3612D;
	Sun,  6 Oct 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232215; cv=none; b=ubuPRtf7GUwGPnrKVyNo4/Gk45FtNtOWGnIPVW2vzOS7cUaag3AVik/2aNhX1PoGP4ieIUpzaMRMWS5+AzeYobZ8sXvgvs7KS0xMDT3QDSpl/d8yVtRQUfYxB6SGUDiAH3mcRKl6XrpGaZqelcR6X34BUXjIoUi0vJG07ELI/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232215; c=relaxed/simple;
	bh=YLTxaa4rlZ1R9oWn/maBdJz76nxQN5hwIhK7lcLkftA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSNfxStX/Mz6Wox1de+2CiPuBo8o0W6AOJL+5XI13frnH1RneBO/91Wv0PyAnkmQTjeOmNPHBzoky2cS4btidlwsWWVANaherMfm/1OWQ6EWSU2a92W1KE5xdBpv1IbcqWKDZPy3WZgBIkhPUM1G0rK9Krl3e+UgthH7Kx4VljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD6eH49R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F6AC4CEC5;
	Sun,  6 Oct 2024 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728232214;
	bh=YLTxaa4rlZ1R9oWn/maBdJz76nxQN5hwIhK7lcLkftA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sD6eH49Rrt8mnC9UyRPCiOwTNAANG+W30C82QwzTPDK0y0L90Rn0jByuuUNAkkO8r
	 BaBl4pWJtZeWEdlXHFQc14koFiKczKyZLb6F+qe9KU+9mjYB2m7re/sfEEhTIxd9qk
	 /Dnv+YPQNtZ3jZHK8s83h6fyfBuNWnSibbMyZnudGnbH50U68A9tBKY9F2UWvgm9Jc
	 3+2JQKA6RaR3cBLeLoJ0NATp60cRDN62+wWkuoETdOpmumpW3J5ETHViU4RhYfYUdM
	 RJ7m2EHVsLZfkH9Xv8QqsEeQ7YXFW9d+3hKd0PmB3AFqRMkbUt4WBJX4TlLqLjl+Da
	 V9eCS42WqrauQ==
Date: Sun, 6 Oct 2024 09:30:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: jack@suse.cz, hch@infradead.org, willy@infradead.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <20241006163013.GN21853@frogsfrogsfrogs>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
 <20241006152849.247152-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006152849.247152-4-yizhou.tang@shopee.com>

On Sun, Oct 06, 2024 at 11:28:49PM +0800, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Since commit 1a12d8bd7b29 ("writeback: scale IO chunk size up to half
> device bandwidth"), macro MAX_WRITEBACK_PAGES has been removed from the
> writeback path. Therefore, the MAX_WRITEBACK_PAGES comments in
> xfs_direct_write_iomap_begin() and xfs_buffered_write_iomap_begin() appear
> outdated.
> 
> In addition, Christoph mentioned that the xfs iomap process should be
> similar to writeback, so xfs_max_map_length() was written following the
> logic of writeback_chunk_size().
> 
> v2: Thanks for Christoph's advice. Resync with the writeback code.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  fs/fs-writeback.c         |  5 ----
>  fs/xfs/xfs_iomap.c        | 52 ++++++++++++++++++++++++---------------
>  include/linux/writeback.h |  5 ++++
>  3 files changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..31c72e207e1b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -31,11 +31,6 @@
>  #include <linux/memcontrol.h>
>  #include "internal.h"
>  
> -/*
> - * 4MB minimal write chunk size
> - */
> -#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> -
>  /*
>   * Passed into wb_writeback(), essentially a subset of writeback_control
>   */
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0..80f759fa9534 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2016-2018 Christoph Hellwig.
>   * All Rights Reserved.
>   */
> +#include <linux/writeback.h>
> +
>  #include "xfs.h"
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
> @@ -744,6 +746,34 @@ xfs_ilock_for_iomap(
>  	return 0;
>  }
>  
> +/*
> + * We cap the maximum length we map to a sane size to keep the chunks
> + * of work done where somewhat symmetric with the work writeback does.
> + * This is a completely arbitrary number pulled out of thin air as a
> + * best guess for initial testing.
> + *
> + * Following the logic of writeback_chunk_size(), the length will be
> + * rounded to the nearest 4MB boundary.
> + *
> + * Note that the values needs to be less than 32-bits wide until the
> + * lower level functions are updated.
> + */
> +static loff_t
> +xfs_max_map_length(struct inode *inode, loff_t length)
> +{
> +	struct bdi_writeback *wb;
> +	long pages;
> +
> +	spin_lock(&inode->i_lock);

Why's it necessary to hold a spinlock?  AFAICT writeback_chunk_size
doesn't hold it.

> +	wb = inode_to_wb(wb);

Hmm, it looks like you're trying to cap writes based on storage device
bandwidth instead of a static limit.  That could be nifty, but does this
work for a file on the realtime device?  Or any device that isn't the
super_block s_bdi?

> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	spin_unlock(&inode->i_lock);
> +	pages = round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
> +
> +	return min_t(loff_t, length, pages * PAGE_SIZE);
> +}

There's nothing in here that's xfs-specific, shouldn't this be a
fs-writeback.c function for any other filesystem that might want to cap
the size of a write?

--D

> +
>  /*
>   * Check that the imap we are going to return to the caller spans the entire
>   * range that the caller requested for the IO.
> @@ -878,16 +908,7 @@ xfs_direct_write_iomap_begin(
>  	if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY))
>  		goto out_unlock;
>  
> -	/*
> -	 * We cap the maximum length we map to a sane size  to keep the chunks
> -	 * of work done where somewhat symmetric with the work writeback does.
> -	 * This is a completely arbitrary number pulled out of thin air as a
> -	 * best guess for initial testing.
> -	 *
> -	 * Note that the values needs to be less than 32-bits wide until the
> -	 * lower level functions are updated.
> -	 */
> -	length = min_t(loff_t, length, 1024 * PAGE_SIZE);
> +	length = xfs_max_map_length(inode, length);
>  	end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  
>  	if (offset + length > XFS_ISIZE(ip))
> @@ -1096,16 +1117,7 @@ xfs_buffered_write_iomap_begin(
>  		allocfork = XFS_COW_FORK;
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  	} else {
> -		/*
> -		 * We cap the maximum length we map here to MAX_WRITEBACK_PAGES
> -		 * pages to keep the chunks of work done where somewhat
> -		 * symmetric with the work writeback does.  This is a completely
> -		 * arbitrary number pulled out of thin air.
> -		 *
> -		 * Note that the values needs to be less than 32-bits wide until
> -		 * the lower level functions are updated.
> -		 */
> -		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
> +		count = xfs_max_map_length(inode, count);
>  		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  
>  		if (xfs_is_always_cow_inode(ip))
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index d6db822e4bb3..657bc4dd22d0 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -17,6 +17,11 @@ struct bio;
>  
>  DECLARE_PER_CPU(int, dirty_throttle_leaks);
>  
> +/*
> + * 4MB minimal write chunk size
> + */
> +#define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
> +
>  /*
>   * The global dirty threshold is normally equal to the global dirty limit,
>   * except when the system suddenly allocates a lot of anonymous memory and
> -- 
> 2.25.1
> 
> 

