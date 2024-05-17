Return-Path: <linux-fsdevel+bounces-19691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90E8C8B00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B304D1F212DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A313DDCD;
	Fri, 17 May 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkHlWu8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AB13DDAE;
	Fri, 17 May 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966967; cv=none; b=Mv5BLHX1JZhZQHR/HTS4N3h85rM1tfjDewS9d48hYDIWEFVwY6xxAN7WVvytJwmSJuG0DMBqAQmTXh/KpHr1ZJ+N+WDtM8JhpRBV+w37Ag5YeshBRiw1W9b5UkhS0IRXrniiKNrd1lFm32cPDPpc8VCab+mlPFNzs4BUu33LumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966967; c=relaxed/simple;
	bh=57KFeH0CJFk0IzHj81Sv7aQwV6ykCtUoa0gInran8lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2NyictQVcLIwJG4RE49Io214+eBSVgH4OURCMTTaPWp6zlN3Pum11E0zk5+uOereqh3YeXOLzDbtM4ZbfHMPZ7y9aPJOEbBqIouh+6mVt1TLSMu8Rse4pFzEW6uv1NCvPbmtYwdI26osa3jgBZMd4QkvMb/XPRmyN3U7UscIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkHlWu8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE023C32781;
	Fri, 17 May 2024 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715966965;
	bh=57KFeH0CJFk0IzHj81Sv7aQwV6ykCtUoa0gInran8lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkHlWu8oa+Nx+is/m+EUrtWpqkEy/6Sx4md8tGvZ2JT9k8MbnP1W5uEo6/LZyeBbW
	 OI7l0NP0HpHJACnEW4EsYEjMrl3bBNMod8OWb69XZDcL8I4r1uNjisGXq7IyS6HUYJ
	 U1gJARxBb45EbET8F6aekp0eMsmRuLL3aEBUaUU9Ik0/GRWn6vy7CXPMetq+u2Fms4
	 RjSX0Twoy77rm0d9/nALnfF4giaddzQIycA4oGkXSAiazIO1enn15srMcxP8iZB3Uw
	 r+5JVE6lI9dy/uQU+7zfUaKFAdvb3eOWZCWxszK7yC+Rww4ng+v73ZrJOWse609zyz
	 N9wQxlHnunqaQ==
Date: Fri, 17 May 2024 10:29:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 1/3] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <20240517172925.GB360919@frogsfrogsfrogs>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517111355.233085-2-yi.zhang@huaweicloud.com>

On Fri, May 17, 2024 at 07:13:53PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> iomap_truncate_page() always assumes the block size of the truncating
> inode is i_blocksize(), this is not always true for some filesystems,
> e.g. XFS does extent size alignment for realtime inodes. Drop this
> assumption and pass the block size for zeroing into
> iomap_truncate_page(), allow filesystems to indicate the correct block
> size.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 13 +++++++++----
>  fs/xfs/xfs_iomap.c     |  3 ++-
>  include/linux/iomap.h  |  4 ++--
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0926d216a5af..a0a0ac2c659c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include <linux/math64.h>
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -1445,11 +1446,15 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
>  int
> -iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops)
> +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> +		bool *did_zero, const struct iomap_ops *ops)
>  {
> -	unsigned int blocksize = i_blocksize(inode);
> -	unsigned int off = pos & (blocksize - 1);
> +	unsigned int off;
> +
> +	if (is_power_of_2(blocksize))
> +		off = pos & (blocksize - 1);
> +	else
> +		div_u64_rem(pos, blocksize, &off);

I wish this was a helper in math64.h somewhere.

static inline u32 rem_u64(u64 dividend, u32 divisor)
{
	if (likely(is_power_of_2(divisor)))
		return dividend & (divisor - 1);

	return dividend % divisor;
}

That way we skip the second division in div_u64_rem entirely, and the
iomap/dax code becomes:

	unsigned int off = rem_u64(pos, blocksize); /* pos in block */

Otherwise this looks like a straightforward mechanical change to me.

--D

>  
>  	/* Block boundary? Nothing to do */
>  	if (!off)
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 2857ef1b0272..31ac07bb8425 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1467,10 +1467,11 @@ xfs_truncate_page(
>  	bool			*did_zero)
>  {
>  	struct inode		*inode = VFS_I(ip);
> +	unsigned int		blocksize = i_blocksize(inode);
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
>  					&xfs_dax_write_iomap_ops);
> -	return iomap_truncate_page(inode, pos, did_zero,
> +	return iomap_truncate_page(inode, pos, blocksize, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d..d67bf86ec582 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -273,8 +273,8 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops);
> -int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
> +int iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> +		bool *did_zero, const struct iomap_ops *ops);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -- 
> 2.39.2
> 
> 

