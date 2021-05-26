Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406C2390DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 03:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhEZBVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 21:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhEZBVr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 21:21:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB5C613CD;
        Wed, 26 May 2021 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621992016;
        bh=Le8taBmDkId1qFfhU0v7LOZwz3w7W8jTlYyWpLUSoN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXhaILod9te3X5dmSJvIYu5qNtSO4LgOlOGYyjR3CTxkZzaG/Lg2NIx8pjOpgWLjW
         IhPTJtqLGhxpZzJt+ZEAPDdSCGVn8PCNT/VWLAZ08Gk8wL6FveSEt0ocTUntq1yWaO
         EYxWvnw9vnqiOt+4ItErm58rpH0f2mrLticoUqUzu3KVub8RBL2bsdDjjz4cZfpMAA
         0yhmLGRx59witc4eFV57xfbSsUXq3Bqk9dEmCpUGhf9iTIPqhtQofVEE4KHBmxf9FK
         /5Jfy5IV3yViqyExWFSyuI/xsg9NPX5bj4JpJYk4s63r9/SuVaFP0RKKEwsfYIunFW
         rnvPTXTDm7h4A==
Date:   Tue, 25 May 2021 18:20:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] xfs: kick large ioends to completion workqueue
Message-ID: <20210526012016.GF202078@locust>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-3-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171722.1266878-3-bfoster@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 01:17:21PM -0400, Brian Foster wrote:
> We've had reports of soft lockup warnings in the iomap ioend
> completion path due to very large bios and/or bio chains. This
> occurs because ioend completion touches every page associated with
> the ioend. It generally requires exceedingly large (i.e. multi-GB)
> bios or bio chains to reproduce a soft lockup warning, but even with
> smaller ioends there's really no good reason to incur the cost of
> potential cacheline misses in bio completion context. Divert ioends
> larger than 1MB to the workqueue so completion occurs in non-atomic
> context and can reschedule to avoid soft lockup warnings.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Will give this a spin on the test farm overnight but at least in
principle this seems fine to me:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 84cd6cf46b12..05b1bb146f17 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -30,6 +30,13 @@ XFS_WPC(struct iomap_writepage_ctx *ctx)
>  	return container_of(ctx, struct xfs_writepage_ctx, ctx);
>  }
>  
> +/*
> + * Completion touches every page associated with the ioend. Send anything
> + * larger than 1MB (based on 4k pages) or so to the completion workqueue to
> + * avoid this work in bio completion context.
> + */
> +#define XFS_LARGE_IOEND	(256ULL << PAGE_SHIFT)
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -409,9 +416,14 @@ xfs_prepare_ioend(
>  
>  	memalloc_nofs_restore(nofs_flag);
>  
> -	/* send ioends that might require a transaction to the completion wq */
> +	/*
> +	 * Send ioends that might require a transaction or are large enough that
> +	 * we don't want to do page processing in bio completion context to the
> +	 * wq.
> +	 */
>  	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
> -	    (ioend->io_flags & IOMAP_F_SHARED))
> +	    (ioend->io_flags & IOMAP_F_SHARED) ||
> +	    ioend->io_size >= XFS_LARGE_IOEND)
>  		ioend->io_bio->bi_end_io = xfs_end_bio;
>  	return status;
>  }
> -- 
> 2.26.3
> 
