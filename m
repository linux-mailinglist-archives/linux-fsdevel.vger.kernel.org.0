Return-Path: <linux-fsdevel+bounces-17912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F68B3B22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B926A286428
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE3156F43;
	Fri, 26 Apr 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4y7MUDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D660149E17;
	Fri, 26 Apr 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144725; cv=none; b=OBmx/doPBX4atzwlCMJ6RjLCq5ZJ2hg5w9oS8RFhOUuVrzoI70E2XtsdjNkbxrRAG0PzwxIf5yjJYgMgSn2ZeLAwIGCXLrqJoFs3NbYM99xNT3BjZIp6XTwHLdM+b0qvh8ik0OpeiNlIquWTTCmQg/5Of+pWZ6+tkeJ+Zefsna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144725; c=relaxed/simple;
	bh=iMSfAGShKd7YbJ5VcD2YOia5ZlLkkptKg528JtHK0kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXlM7ADupI5x31U1pUWFKIbp+aOAtpQldsxHyw0tpcsqsVLZkv2wdtb2Sk1BqjokmtqBGsuI1jT5Ho0waNkBDak0ZNfAGjW7T5u3Swl8P0ck7naQ/FhJSTGvkIHrr/rSSlPkDsDEg+WkRoQfLCmYIH5wJD/NTegp3o/86hjW39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4y7MUDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77878C113CD;
	Fri, 26 Apr 2024 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144724;
	bh=iMSfAGShKd7YbJ5VcD2YOia5ZlLkkptKg528JtHK0kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4y7MUDFUSoWtSFhptFDidEtAkjexq+z9Djlt/GbttVvkxEnjl3ydqNclRY1n/TtZ
	 92PRSZsFmO1P58TrQWvFhbJY7Dxu1ChOiSgA6jmeTzuqC5y53cd/q+/wQDztfTk4CP
	 LAFFhr0oNYqq+tyuKN3mEtXliPa5g5099kskUNDPiIwa00jDaNcQfTxEJ8Y1aAipMe
	 iKMGWT9ekThd9mhtyvihorTIQLZvC+z/DPbp+TG48LJ2hEM41WzGfEjUcvGgFm7Flf
	 8kfKIt5AoYHbfTakwI+QQUPRC4O8lHA2dkb65+mlGxtf9kh7mmQ68Qe08nTs4mz+oN
	 8sjT+izzxOCRw==
Date: Fri, 26 Apr 2024 08:18:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v4 08/11] xfs: use kvmalloc for xattr buffers
Message-ID: <20240426151844.GH360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-9-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-9-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:43PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Pankaj Raghav reported that when filesystem block size is larger
> than page size, the xattr code can use kmalloc() for high order
> allocations. This triggers a useless warning in the allocator as it
> is a __GFP_NOFAIL allocation here:
> 
> static inline
> struct page *rmqueue(struct zone *preferred_zone,
>                         struct zone *zone, unsigned int order,
>                         gfp_t gfp_flags, unsigned int alloc_flags,
>                         int migratetype)
> {
>         struct page *page;
> 
>         /*
>          * We most definitely don't want callers attempting to
>          * allocate greater than order-1 page units with __GFP_NOFAIL.
>          */
> >>>>    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> ...
> 
> Fix this by changing all these call sites to use kvmalloc(), which
> will strip the NOFAIL from the kmalloc attempt and if that fails
> will do a __GFP_NOFAIL vmalloc().
> 
> This is not an issue that productions systems will see as
> filesystems with block size > page size cannot be mounted by the
> kernel; Pankaj is developing this functionality right now.
> 
> Reported-by: Pankaj Raghav <kernel@pankajraghav.com>
> Fixes: f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Didn't this already go in for-next?

If not,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index ac904cc1a97b..969abc6efd70 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1059,10 +1059,7 @@ xfs_attr3_leaf_to_shortform(
>  
>  	trace_xfs_attr_leaf_to_sf(args);
>  
> -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> -	if (!tmpbuffer)
> -		return -ENOMEM;
> -
> +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>  
>  	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
> @@ -1125,7 +1122,7 @@ xfs_attr3_leaf_to_shortform(
>  	error = 0;
>  
>  out:
> -	kfree(tmpbuffer);
> +	kvfree(tmpbuffer);
>  	return error;
>  }
>  
> @@ -1533,7 +1530,7 @@ xfs_attr3_leaf_compact(
>  
>  	trace_xfs_attr_leaf_compact(args);
>  
> -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>  	memset(bp->b_addr, 0, args->geo->blksize);
>  	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
> @@ -1571,7 +1568,7 @@ xfs_attr3_leaf_compact(
>  	 */
>  	xfs_trans_log_buf(trans, bp, 0, args->geo->blksize - 1);
>  
> -	kfree(tmpbuffer);
> +	kvfree(tmpbuffer);
>  }
>  
>  /*
> @@ -2250,7 +2247,7 @@ xfs_attr3_leaf_unbalance(
>  		struct xfs_attr_leafblock *tmp_leaf;
>  		struct xfs_attr3_icleaf_hdr tmphdr;
>  
> -		tmp_leaf = kzalloc(state->args->geo->blksize,
> +		tmp_leaf = kvzalloc(state->args->geo->blksize,
>  				GFP_KERNEL | __GFP_NOFAIL);
>  
>  		/*
> @@ -2291,7 +2288,7 @@ xfs_attr3_leaf_unbalance(
>  		}
>  		memcpy(save_leaf, tmp_leaf, state->args->geo->blksize);
>  		savehdr = tmphdr; /* struct copy */
> -		kfree(tmp_leaf);
> +		kvfree(tmp_leaf);
>  	}
>  
>  	xfs_attr3_leaf_hdr_to_disk(state->args->geo, save_leaf, &savehdr);
> -- 
> 2.34.1
> 
> 

