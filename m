Return-Path: <linux-fsdevel+bounces-38612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287FA04E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125E93A330C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 00:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2BA1E89C;
	Wed,  8 Jan 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwRmTWaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29CDF5C;
	Wed,  8 Jan 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297458; cv=none; b=TeyedEaz8EfUYDZkiHdpJAQjqBF29nSTniDCh7vI+uN+t8kw6MA04PrwHEd1x/+u7zsjT4JPmfEJ54liwAihVb894/jrqBYnyIBxI+1VrSpM30Mrr5wcTukKcFU18R2TLeqTPJmxvoeKEJzEC0ALkT66GXamvggAYq0u62EMpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297458; c=relaxed/simple;
	bh=BAG8ipZJxkKdxzWNqSzpOw+Diky0f1w7Rm4XNZXLgCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBcD0qEwsVLOGANvIYKt+W2d5tNBXxDzMVRUssfRE8YNhcM1pTinyNDFVM1yhi3C0tT5j/07rQw3oxVZ5BMQrPAQ3UYoL7mBjrEUQdHTcSYejcT6/CeabFb2tLMa9lu7ABxC1e9C5Eaj3Tu7z/P6dRQCimROgxILIMojvxwUTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwRmTWaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED53C4CEDF;
	Wed,  8 Jan 2025 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736297458;
	bh=BAG8ipZJxkKdxzWNqSzpOw+Diky0f1w7Rm4XNZXLgCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwRmTWazvAUE0/BsVkicrFWs1PUqBEhuNL1foWTVpeloTCxUadGpvpfS32VcKTeIa
	 XUO+K67VjQnpOLk9Rh7MG4z2W4CLY7qE6gYtmsKbLhFTrGebDJi/Mw9lb4G+54HerV
	 vsM9W3SDaxwSIGf/yXF5kFatjUl7W2QP+QO6jWE30RBx57hx1jb/qvY5r3vaEurx6V
	 M1735eaGX7dzx9ZpTOL1xp88t0eL0+e9mSNloHb7gXdTcJNM2idn36cDHzFpfgSxHT
	 /6eONekppFex/pxmJtzuxS4f0MZGA7qaIPphiucK2Fctfd5++fKCnaJDYGrEWicOHO
	 dh+okEQuXQBzQ==
Date: Tue, 7 Jan 2025 16:50:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 5/7] xfs: Switch atomic write size check in
 xfs_file_write_iter()
Message-ID: <20250108005057.GB1306365@frogsfrogsfrogs>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
 <20250102140411.14617-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102140411.14617-6-john.g.garry@oracle.com>

On Thu, Jan 02, 2025 at 02:04:09PM +0000, John Garry wrote:
> Currently atomic writes size permitted is fixed at the blocksize.
> 
> To start to remove this restriction, use xfs_get_atomic_write_attr() to
> find the per-inode atomic write limits and check according to that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Seems reasonable to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 12 +++++-------
>  fs/xfs/xfs_iops.c |  2 +-
>  fs/xfs/xfs_iops.h |  2 ++
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 2c810f75dbbd..68c22c0ab235 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -949,14 +949,12 @@ xfs_file_write_iter(
>  		return xfs_file_dax_write(iocb, from);
>  
>  	if (iocb->ki_flags & IOCB_ATOMIC) {
> -		/*
> -		 * Currently only atomic writing of a single FS block is
> -		 * supported. It would be possible to atomic write smaller than
> -		 * a FS block, but there is no requirement to support this.
> -		 * Note that iomap also does not support this yet.
> -		 */
> -		if (ocount != ip->i_mount->m_sb.sb_blocksize)
> +		unsigned int unit_min, unit_max;
> +
> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> +		if (ocount < unit_min || ocount > unit_max)
>  			return -EINVAL;
> +
>  		ret = generic_atomic_write_valid(iocb, from);
>  		if (ret)
>  			return ret;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 207e0dadffc3..883ec45ae708 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -572,7 +572,7 @@ xfs_stat_blksize(
>  	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
>  }
>  
> -static void
> +void
>  xfs_get_atomic_write_attr(
>  	struct xfs_inode	*ip,
>  	unsigned int		*unit_min,
> diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
> index 3c1a2605ffd2..82d3ffbf7024 100644
> --- a/fs/xfs/xfs_iops.h
> +++ b/fs/xfs/xfs_iops.h
> @@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
>  extern void xfs_setup_inode(struct xfs_inode *ip);
>  extern void xfs_setup_iops(struct xfs_inode *ip);
>  extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
> +extern void xfs_get_atomic_write_attr(struct xfs_inode	*ip,
> +		unsigned int *unit_min, unsigned int *unit_max);
>  
>  #endif /* __XFS_IOPS_H__ */
> -- 
> 2.31.1
> 
> 

