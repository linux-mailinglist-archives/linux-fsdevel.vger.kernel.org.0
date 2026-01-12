Return-Path: <linux-fsdevel+bounces-73329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1785D15A8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3D33024B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03962BE05F;
	Mon, 12 Jan 2026 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBPfuQok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AA270EC1;
	Mon, 12 Jan 2026 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258282; cv=none; b=RLljTmdCzE/6rsc26jTq++8Jx7lao/5nXfS5aqO7KswFsLBDDGIDMO2wcTbxjjgUNm+F6fUqs4fVS8yqzuwvO2YRK35qa14bVGEaOCQiPBu7ga/k0wCkbqlwWeoFVaefYrP3xwyHsTx7p0F9s3LMsm/DbUsdt/waGiR/Mnft+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258282; c=relaxed/simple;
	bh=Vvyr6CNfq01x8Kl7lTwaXhiABol/IgvjzMtZ1HLcVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RInhj2jflkB74yo6fNZzjTIPl9aTPRJQQmcMXmqIlICnJL3LywHH/oFQdMZHapmxDBJwrx2EIkFKAF9rioQBBZtPy4aMxYtxpPyvptVG6+2tLrZY0gjJQNb78bOfMEU34yP+o5yvyYoWuwxNZnpmUjGIJl6NrnYN2tJKeA4Qa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBPfuQok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6584C19423;
	Mon, 12 Jan 2026 22:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768258282;
	bh=Vvyr6CNfq01x8Kl7lTwaXhiABol/IgvjzMtZ1HLcVa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBPfuQok1159IlEtUHCZwd1NyuEWroxlKyB/ZNbhB8aMvK3qLsio3Z2dQHj64H181
	 PNutywiPBo0Hmpx+z4zC9KGhbkqthgFBorVILEykmNqOqfa0/BjpJdm5ZT8jCqYpNS
	 DDLjKxDRVFhc0TBfmWPvqiHk93OLcV3FwH8sj1IQ1q2WUKtZGZWr+75Z7+/lYSSOsi
	 U5+BytCvdnf04wyNhB4FDjOo9/tysqsViH8keCg9l8EOv5TZIJI//+4bLkMDpT/evW
	 9pZ4lgCLjkN1gmDQVvIomkXCd1sL4XaCMSph4N5rTmdM5SaYFNlKkeGftNs4A5nN8U
	 KbiLEm3GlCu1A==
Date: Mon, 12 Jan 2026 14:51:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 15/22] xfs: add writeback and iomap reading of Merkle
 tree pages
Message-ID: <20260112225121.GQ15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <bkwfiiwnqleh3rr3mcge2fx6uucvvj2qzyl3sbzgb4b4sbjm27@nw2i3bz7xvrr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkwfiiwnqleh3rr3mcge2fx6uucvvj2qzyl3sbzgb4b4sbjm27@nw2i3bz7xvrr>

On Mon, Jan 12, 2026 at 03:51:36PM +0100, Andrey Albershteyn wrote:
> In the writeback path use unbound write interface, meaning that inode
> size is not updated and none of the file size checks are applied.
> 
> In read path let iomap know that data is stored beyond EOF via flag.
> This leads to skipping of post EOF zeroing.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_aops.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 56a5446384..30e38d5322 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -22,6 +22,7 @@
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
> +#include "xfs_fsverity.h"
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -334,6 +335,7 @@
>  	int			retries = 0;
>  	int			error = 0;
>  	unsigned int		*seq;
> +	unsigned int		iomap_flags = 0;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -427,7 +429,9 @@
>  	    isnullstartblock(imap.br_startblock))
>  		goto allocate_blocks;
>  
> -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_flags |= IOMAP_F_BEYOND_EOF;
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, XFS_WPC(wpc)->data_seq);
>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> @@ -470,6 +474,9 @@
>  			wpc->iomap.length = cow_offset - wpc->iomap.offset;
>  	}
>  
> +	if (offset >= XFS_FSVERITY_REGION_START)
> +		wpc->iomap.flags |= IOMAP_F_BEYOND_EOF;
> +
>  	ASSERT(wpc->iomap.offset <= offset);
>  	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
>  	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
> @@ -698,6 +705,17 @@
>  			},
>  		};
>  
> +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
> +			wbc->range_start = XFS_FSVERITY_REGION_START;
> +			wbc->range_end = LLONG_MAX;
> +			wbc->nr_to_write = LONG_MAX;
> +			/*
> +			 * Set IOMAP_F_BEYOND_EOF to skip initial EOF check
> +			 * The following iomap->flags would be set in
> +			 * xfs_map_blocks()
> +			 */
> +			wpc.ctx.iomap.flags |= IOMAP_F_BEYOND_EOF;

But won't xfs_map_blocks reset wpc.ctx.iomap.flags?

/me realizes that you /are/ using writeback for writing the fsverity
metadata now, so he'll go back and look at the iomap patches a little
closer.

--D

> +		}
>  		return iomap_writepages(&wpc.ctx);
>  	}
>  }
> 
> -- 
> - Andrey
> 
> 

