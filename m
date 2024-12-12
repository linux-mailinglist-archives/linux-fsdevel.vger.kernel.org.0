Return-Path: <linux-fsdevel+bounces-37218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2636A9EFA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02E928C79B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5512397A6;
	Thu, 12 Dec 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y34KeZOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D413238E22;
	Thu, 12 Dec 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026749; cv=none; b=lAQGA9pCppUAzA5ks3q+Y6xv8Csmnle4i31/erKkvLyy7ciyjy1w3+DpwmvKhGtLjsd5PB8o0WP/0cgEF5N52xO77/9H7UZLnOhV70a0B2XU0jsuop0ltsM7hr1BX210dw5FOswCy/QtniD3CC/AWuLZnw6NjBUgA3ZfCBZqxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026749; c=relaxed/simple;
	bh=b09BzlkBn5ZiBIoQnAg52vaknsVsSNo2dwq6sHm5mxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU+5DZvh2Nht2d48Ze0W2F4A/KGqN+wnQYrDeoqqq8XCJs5TiMqlcsJgpUI499Dw2jSqLA+kZUqXIecVNAXDh4G5jf0YByEvAUKhoi4cd6Si8UkGUXbyPVLAzw4TP08ZrO5h9mc0hXM7VDKnO48Srov+ZB/cbSOz654+mWNvquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y34KeZOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A958C4CECE;
	Thu, 12 Dec 2024 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026748;
	bh=b09BzlkBn5ZiBIoQnAg52vaknsVsSNo2dwq6sHm5mxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y34KeZODEvWrSL1yC6Yd7RBMc1CPGfQSNUT8uujWHXDy6iaz5KQjIf5fC243sdtCT
	 Ve31kxVKlksK/u7wsBxxjnFEJpX4OsibvdwT/2+1ZZXFF+SDl+0voCGu8lL72SEzcU
	 EJoywt5e0BrwjP2m+uQM/+h405g/BOfKzhJFeT16h12oIP+HWi+D5e5+Yr9GfZacuv
	 zylARX1hnS7vPF5+AzHFOChdTJAv98EP6LwwrowA6gal6xI4LUl89yUm+Wb4rYWnNL
	 sdXcZVTVuAjaln7k5hd6PtRi1WUHTmUA9ZaU/gW2ZdU4X8Asabfu2uUGdB0RZJGgTp
	 dIymKqHHSIycg==
Date: Thu, 12 Dec 2024 10:05:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] iomap: add a IOMAP_F_ZONE_APPEND flag
Message-ID: <20241212180547.GG6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-4-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:43AM +0100, Christoph Hellwig wrote:
> This doesn't much - just always returns the start block number for each

"This doesn't much" - I don't understand the sentence very well.  How
about:

"Add a new IOMAP_F_ZONE_APPEND flag for the filesystem to indicate that
the storage device must inform us where it wrote the data, so that the
filesystem can update its own internal mapping metadata.  The filesystem
should set the starting address of the zone in iomap::addr, and extract
the LBA address from the bio during ioend processing.  iomap builds
bios unconstrained by the hardware limits and will split them in the bio
submission handler."

The splitting happens whenever IOMAP_F_BOUNDARY gets set by
->map_blocks, right?

> iomap instead of increasing it.  This is because we'll keep building bios
> unconstrained by the hardware limits and just split them in file system
> submission handler.
> 
> Maybe we should find another name for it, because it might be useful for
> btrfs compressed bio submissions as well, but I can't come up with a
> good one.

Since you have to tell the device the starting LBA of the zone you want
to write to, I think _ZONE_APPEND is a reasonable name.  The code looks
correct though.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 19 ++++++++++++++++---
>  include/linux/iomap.h  |  7 +++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3176dc996fb7..129cd96c6c96 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1744,9 +1744,22 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>  		return false;
>  	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
>  		return false;
> -	if (iomap_sector(&wpc->iomap, pos) !=
> -	    bio_end_sector(&wpc->ioend->io_bio))
> -		return false;
> +	if (wpc->iomap.flags & IOMAP_F_ZONE_APPEND) {
> +		/*
> +		 * For Zone Append command, bi_sector points to the zone start
> +		 * before submission.  We can merge all I/O for the same zone.
> +		 */
> +		if (iomap_sector(&wpc->iomap, pos) !=
> +		    wpc->ioend->io_bio.bi_iter.bi_sector)
> +			return false;
> +	} else {
> +		/*
> +		 * For regular writes, the disk blocks needs to be contiguous.
> +		 */
> +		if (iomap_sector(&wpc->iomap, pos) !=
> +		    bio_end_sector(&wpc->ioend->io_bio))
> +			return false;
> +	}
>  	/*
>  	 * Limit ioend bio chain lengths to minimise IO completion latency. This
>  	 * also prevents long tight loops ending page writeback on all the
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 1d8658c7beb8..173d490c20ba 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -56,6 +56,10 @@ struct vm_fault;
>   *
>   * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
>   * never be merged with the mapping before it.
> + *
> + * IOMAP_F_ZONE_APPEND indicates that (write) I/O should be done as a zone
> + * append command for zoned devices.  Note that the file system needs to
> + * override the bi_end_io handler to record the actual written sector.
>   */
>  #define IOMAP_F_NEW		(1U << 0)
>  #define IOMAP_F_DIRTY		(1U << 1)
> @@ -68,6 +72,7 @@ struct vm_fault;
>  #endif /* CONFIG_BUFFER_HEAD */
>  #define IOMAP_F_XATTR		(1U << 5)
>  #define IOMAP_F_BOUNDARY	(1U << 6)
> +#define IOMAP_F_ZONE_APPEND	(1U << 7)

Needs a corresponding update in Documentation/iomap/ before we merge
this series.

--D

>  
>  /*
>   * Flags set by the core iomap code during operations:
> @@ -111,6 +116,8 @@ struct iomap {
>  
>  static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
> +	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> +		return iomap->addr >> SECTOR_SHIFT;
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>  
> -- 
> 2.45.2
> 
> 

