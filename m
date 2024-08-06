Return-Path: <linux-fsdevel+bounces-25163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EEF9497F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90EA1C20C74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A215688C;
	Tue,  6 Aug 2024 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqiW44dV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1B155731;
	Tue,  6 Aug 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970961; cv=none; b=Rj8Ft4htUUW44sDdZcXfFRlou2cdGY3zX+/e4sYfGpm7e5f0oURUXd/b2lH6PksP8G4317tmgvL0YftHj6MJnJn6u05fjpoz6fE9WJcDMgtoZUI1q1QmJFkqBZfnOWB2an8U7ZB5dwIKdJG4IrTr3oEaSsvi9fQKwzszWAY1XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970961; c=relaxed/simple;
	bh=tNlXjMLjQtNVke0XVdcG1dgVjNjKEpqPYYin22sNcMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgXEuHNx+4jwBXW85r3OH4wsfp/vnldfc20qqs3RN4pOzJWPuQCZEVlDijuGSMAtPq1VVsj7/dnyQGCr6Q4UMrtgRQkX848te/+OcYMD8/OxM8GWC0x8amaMBHCwAlK+S1x6hWdSo/wv89IA8+g7RnodPPEtSv+DFadIrls2g+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqiW44dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115F7C32786;
	Tue,  6 Aug 2024 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970961;
	bh=tNlXjMLjQtNVke0XVdcG1dgVjNjKEpqPYYin22sNcMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqiW44dVX4WvaUK5ZZkYhl3pgrQnWECsiSLGgO3wHUJ1P0sm7yue4tEmSrqvxoMYs
	 Bf5asoRXwEqkoG1gLisRWTQRaZTzQGWRO36eI6vlbTv7cUBV1EIdkdHG9MzYKgBH7k
	 cS/RkOMRdMRiAE26422S2T2GKLad2TOOrMacnf1qWAuQnrzIa/COa1RhkiYVq9fh7y
	 EfnZvwc5HsjGdCCdl/cegip+m4ntPaOMHLleMjV3csaxtT0MEmZouTsfso5cFqZ8Ua
	 gA+30XohsjVQcHqeuWHlHrR36+h+LZ6PqDsECDVFvvSvMM384BRLuCfSM+RMRXlLEu
	 B69Uw0XEqLUqg==
Date: Tue, 6 Aug 2024 12:02:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 08/14] xfs: Update xfs_inode_alloc_unitsize() for
 forcealign
Message-ID: <20240806190240.GK623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-9-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:51PM +0000, John Garry wrote:
> For forcealign enabled, the allocation unit size is in ip->i_extsize, and
> this must never be zero.
> 
> Add helper xfs_inode_alloc_fsbsize() to return alloc unit in FSBs, and use
> it in xfs_inode_alloc_unitsize().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.c | 17 +++++++++++++----
>  fs/xfs/xfs_inode.h |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 7dc6f326936c..5af12f35062d 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3107,17 +3107,26 @@ xfs_break_layouts(
>  	return error;
>  }
>  
> -/* Returns the size of fundamental allocation unit for a file, in bytes. */
>  unsigned int
> -xfs_inode_alloc_unitsize(
> +xfs_inode_alloc_fsbsize(
>  	struct xfs_inode	*ip)
>  {
>  	unsigned int		blocks = 1;
>  
> -	if (XFS_IS_REALTIME_INODE(ip))
> +	if (xfs_inode_has_forcealign(ip))
> +		blocks = ip->i_extsize;
> +	else if (XFS_IS_REALTIME_INODE(ip))
>  		blocks = ip->i_mount->m_sb.sb_rextsize;
>  
> -	return XFS_FSB_TO_B(ip->i_mount, blocks);
> +	return blocks;
> +}
> +
> +/* Returns the size of fundamental allocation unit for a file, in bytes. */
> +unsigned int
> +xfs_inode_alloc_unitsize(
> +	struct xfs_inode	*ip)
> +{
> +	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
>  }
>  
>  /* Should we always be using copy on write for file writes? */
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 3e7664ec4d6c..158afad8c7a4 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -641,6 +641,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
>  bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
>  void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
>  		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
> +unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
>  unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
>  
>  int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
> -- 
> 2.31.1
> 
> 

