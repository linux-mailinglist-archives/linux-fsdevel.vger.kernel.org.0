Return-Path: <linux-fsdevel+bounces-38613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854ADA04E71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2603C188820A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 00:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC94F218;
	Wed,  8 Jan 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIxM5+7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A9DF5C;
	Wed,  8 Jan 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297753; cv=none; b=Pq0n+4HL2U3c9SFwZTNAFp2SDaof7LT9s6jEfwhYuTjM8dXBbFyNqcb77R7Rzxt4pRGThFtWFMHezAA08CIroBP/KUUA6FUSYLAoGsQpdCND6wBxgdqPnjxzGiTTOBj6iidS5XwPRwXOQcca2eFYmIyaqw9LJmYXmvJVg4zjlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297753; c=relaxed/simple;
	bh=Mh8QScLHlDVI3WEWBMp+kgOLsC29k25yFqYXrMPB2yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmFbjeG99PBQXIKTcGjAREdjWdglpqTjo9tJCCRUrHX2QbEACipxnwfnBo3R2lVST41Br5yRFhpmjQfb9S+C6J2XLwnXZJH4EcoHmxm5JgjGGU9KU52O49rRSY1rtBlhhnHv1cw80VGa8moRy1DpG7b/tu0vykZseuYJZYJq2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIxM5+7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3CEC4CED6;
	Wed,  8 Jan 2025 00:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736297753;
	bh=Mh8QScLHlDVI3WEWBMp+kgOLsC29k25yFqYXrMPB2yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIxM5+7C1NvQ+8lujx7HRDVnemNNCx9DAxp8l7BAJaa67RX/ASepKIN/UKIuISvV2
	 244q727fqgQHURXZDR0eQ5wyZo0kAdTq7808vandcYwc7UIGWllFnGWxndiOtgks60
	 3DzwX2DHy8SkzAQW9wKuK2dtgLWe699MzcGC1elTqBzj0b9MggwDELfO/ZxgUB5/9E
	 S18ZtebpqyKg/ZqgqcW75cfqIG39i++yw4GcsY3s9PMEXlcYzXwzGGmFukfxGuXJZa
	 d8WjEt4+7hbZFaBPMeQqLWk45CwyZBl+kvhqwVWgbPOzyJqjogndrC52I+3XARuLlt
	 6keUPJVlHWuAQ==
Date: Tue, 7 Jan 2025 16:55:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 6/7] xfs: Add RT atomic write unit max to xfs_mount
Message-ID: <20250108005552.GC1306365@frogsfrogsfrogs>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
 <20250102140411.14617-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102140411.14617-7-john.g.garry@oracle.com>

On Thu, Jan 02, 2025 at 02:04:10PM +0000, John Garry wrote:
> rtvol guarantees alloc unit alignment through rt_extsize. As such, it is
> possible to atomically write multiple FS blocks in a rtvol (up to
> rt_extsize).
> 
> Add a member to xfs_mount to hold the pre-calculated atomic write unit max.
> 
> The value in rt_extsize is not necessarily a power-of-2, so find the
> largest power-of-2 evenly divisible into rt_extsize.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I guess that works.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_sb.c |  3 +++
>  fs/xfs/xfs_mount.h     |  1 +
>  fs/xfs/xfs_rtalloc.c   | 23 +++++++++++++++++++++++
>  fs/xfs/xfs_rtalloc.h   |  4 ++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 3b5623611eba..6381060df901 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -25,6 +25,7 @@
>  #include "xfs_da_format.h"
>  #include "xfs_health.h"
>  #include "xfs_ag.h"
> +#include "xfs_rtalloc.h"
>  #include "xfs_rtbitmap.h"
>  #include "xfs_exchrange.h"
>  #include "xfs_rtgroup.h"
> @@ -1149,6 +1150,8 @@ xfs_sb_mount_rextsize(
>  		rgs->blklog = 0;
>  		rgs->blkmask = (uint64_t)-1;
>  	}
> +
> +	xfs_rt_awu_update(mp);
>  }
>  
>  /* Update incore sb rt extent size, then recompute the cached rt geometry. */
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index db9dade7d22a..f2f1d2c667cc 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -191,6 +191,7 @@ typedef struct xfs_mount {
>  	bool			m_fail_unmount;
>  	bool			m_finobt_nores; /* no per-AG finobt resv. */
>  	bool			m_update_sb;	/* sb needs update in mount */
> +	xfs_extlen_t		m_rt_awu_max;   /* rt atomic write unit max */
>  
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
> diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
> index fcfa6e0eb3ad..e3093f3c7670 100644
> --- a/fs/xfs/xfs_rtalloc.c
> +++ b/fs/xfs/xfs_rtalloc.c
> @@ -735,6 +735,28 @@ xfs_rtginode_ensure(
>  	return xfs_rtginode_create(rtg, type, true);
>  }
>  
> +void
> +xfs_rt_awu_update(
> +	struct xfs_mount	*mp)
> +{
> +	xfs_agblock_t		rsize = mp->m_sb.sb_rextsize;
> +	xfs_extlen_t		awu_max;
> +
> +	if (is_power_of_2(rsize)) {
> +		mp->m_rt_awu_max = rsize;
> +		return;
> +	}
> +
> +	/* Find highest power-of-2 evenly divisible into sb_rextsize */
> +	awu_max = 1;
> +	while (1) {
> +		if (rsize % (awu_max * 2))
> +			break;
> +		awu_max *= 2;
> +	}
> +	mp->m_rt_awu_max = awu_max;
> +}
> +
>  static struct xfs_mount *
>  xfs_growfs_rt_alloc_fake_mount(
>  	const struct xfs_mount	*mp,
> @@ -969,6 +991,7 @@ xfs_growfs_rt_bmblock(
>  	 */
>  	mp->m_rsumlevels = nmp->m_rsumlevels;
>  	mp->m_rsumblocks = nmp->m_rsumblocks;
> +	mp->m_rt_awu_max = nmp->m_rt_awu_max;
>  
>  	/*
>  	 * Recompute the growfsrt reservation from the new rsumsize.
> diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
> index 8e2a07b8174b..fcb7bb3df470 100644
> --- a/fs/xfs/xfs_rtalloc.h
> +++ b/fs/xfs/xfs_rtalloc.h
> @@ -42,6 +42,10 @@ xfs_growfs_rt(
>  	struct xfs_mount	*mp,	/* file system mount structure */
>  	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
>  
> +void
> +xfs_rt_awu_update(
> +	struct xfs_mount	*mp);
> +
>  int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
>  #else
>  # define xfs_growfs_rt(mp,in)				(-ENOSYS)
> -- 
> 2.31.1
> 
> 

