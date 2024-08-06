Return-Path: <linux-fsdevel+bounces-25168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78A994982B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A341C20E24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E71420DD;
	Tue,  6 Aug 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfsroDnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A1762C1;
	Tue,  6 Aug 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972282; cv=none; b=pINbv6B0uJoSNcJmpXssP8dKqHi+4JYyxlNdX5SgBciE8Ff2P/2N5D+jM3PpyfUMQaXn3DI+8MBCMIJZsQgNIC9wmlEG+woDODybtAIUfHwFVahMYcIy7ZicClcnvkfJBm4SL3K9rFN/XsBQL8qEoT0BT8gkmrDo4LoZszbn+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972282; c=relaxed/simple;
	bh=KanH2dsOXDBjIaC/3ljdXiWmUXY7N4CM55GZvVkAZqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KslfIfCQT/5n0WVJWYt0sAkIDskbTRWEyFlgELkhxFyNfFSpbCNfDhIvyXqwFItY19PI/afgWK2mo2KrwXwGgSceFzTnmDW6A27y0cxXeyDNE1J9w8an2ZLqwMZjLQMbNjQULBLn9/82MiHxPhL0sX15lV3VXUyByE6a2jUKd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfsroDnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3334AC4AF0D;
	Tue,  6 Aug 2024 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972282;
	bh=KanH2dsOXDBjIaC/3ljdXiWmUXY7N4CM55GZvVkAZqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfsroDnxJeoQkrr8LTbXXj4qV6h65CT/s1tfiagL0/SjcS5Rl/TJBsB9YMwXqAE8q
	 Jrltu7ohmMQHALNGGUTy+qiqoHAOZlVRHlO1xdxgxpQjN8HbwcaqFpLPywZq4jqk93
	 SQfX5JawXfqwc7/I5x61Cl1rHb+2aMzlr36cArjeY/FXb9JhybX/BQGiK/KhnHCbcG
	 UkHgRf7cer9lsvwe4MqnpyLO0pUx/sF/zwm9PJpeXyj7NgMn6zUGZOo9BpxeoiBqpQ
	 3OrEx4dmzsO7TiW4VA1KSdoLe1aGqJuqdt1VbJcGEdrabM7cl9NESplbtF1QdLm0cy
	 fYGJu6IIuxyHA==
Date: Tue, 6 Aug 2024 12:24:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 10/14] xfs: Do not free EOF blocks for forcealign
Message-ID: <20240806192441.GM623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-11-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:53PM +0000, John Garry wrote:
> For when forcealign is enabled, we want the EOF to be aligned as well, so
> do not free EOF blocks.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  7 +++++--
>  fs/xfs/xfs_inode.c     | 14 ++++++++++++++
>  fs/xfs/xfs_inode.h     |  2 ++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index fe2e2c930975..60389ac8bd45 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -496,6 +496,7 @@ xfs_can_free_eofblocks(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		end_fsb;
>  	xfs_fileoff_t		last_fsb;
> +	xfs_fileoff_t		dummy_fsb;
>  	int			nimaps = 1;
>  	int			error;
>  
> @@ -537,8 +538,10 @@ xfs_can_free_eofblocks(
>  	 * forever.
>  	 */
>  	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> -	if (xfs_inode_has_bigrtalloc(ip))
> -		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> +
> +	/* Only try to free beyond the allocation unit that crosses EOF */
> +	xfs_roundout_to_alloc_fsbsize(ip, &dummy_fsb, &end_fsb);
> +
>  	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
>  	if (last_fsb <= end_fsb)
>  		return false;
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 5af12f35062d..d765dedebc15 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3129,6 +3129,20 @@ xfs_inode_alloc_unitsize(
>  	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
>  }
>  
> +void
> +xfs_roundout_to_alloc_fsbsize(
> +	struct xfs_inode	*ip,
> +	xfs_fileoff_t		*start,
> +	xfs_fileoff_t		*end)
> +{
> +	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
> +
> +	if (blocks == 1)
> +		return;
> +	*start = rounddown_64(*start, blocks);
> +	*end = roundup_64(*end, blocks);
> +}

This is probably going to start another round of shouting, but I think
it's silly to do two rounding operations when you only care about one
value.  In patch 12 it results in a bunch more dummy variables that you
then ignore.

Can't this be:

static inline xfs_fileoff_t
xfs_inode_rounddown_alloc_unit(
	struct xfs_inode	*ip,
	xfs_fileoff		off)
{
	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);

	if (rounding == 1)
		return off;
	return rounddown_64(off, rounding);
}

static inline xfs_fileoff_t
xfs_inode_roundup_alloc_unit(
	struct xfs_inode	*ip,
	xfs_fileoff		off)
{
	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);

	if (rounding == 1)
		return off;
	return roundup_64(off, rounding);
}

Then that callsite can be:

	end_fsb = xfs_inode_roundup_alloc_unit(ip,
			XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip)));

--D

> +
>  /* Should we always be using copy on write for file writes? */
>  bool
>  xfs_is_always_cow_inode(
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 158afad8c7a4..7f86c4781bd8 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -643,6 +643,8 @@ void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
>  		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
>  unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
>  unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
> +void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
> +		xfs_fileoff_t *start, xfs_fileoff_t *end);
>  
>  int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
>  		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
> -- 
> 2.31.1
> 
> 

