Return-Path: <linux-fsdevel+bounces-26502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF995A2E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2602A281380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37901AF4F8;
	Wed, 21 Aug 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7/yZDf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612214E2D4;
	Wed, 21 Aug 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258048; cv=none; b=gMNIpREf905oc9drW4ksrtsj3lCHeEBJ7X3e6UJ3c49ZQq3xbJFMpBb9Iy9IpJxunFWpf381ixH3+tRDuw2nDL4PcsJUtQZPJTR5446rn+waHmCywt915KqxWzlDL34eCgnXFnT+9AVcBlwdK4DDUvbsPfJOZemhOz9/m5D/ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258048; c=relaxed/simple;
	bh=+GRMHpiOSPDzrwAh3s0GXT01u191AcPXsvV3iIzbfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8sGRhGB48IqIGSmn1Oocty/GKyQ3yyUHPWiJhraHdKrUGf+3unzdY8qJKlx0/oGmoUBwkY2cgh4QF/iybOV6apntQtrRrdrGvHQuHwcF/cz0YH78jevu6I2cP2HmT74JfY9r/fkZqBmaLZlzvIkXQITYhnOoostQ3Ea86oDPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7/yZDf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA34C32781;
	Wed, 21 Aug 2024 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724258047;
	bh=+GRMHpiOSPDzrwAh3s0GXT01u191AcPXsvV3iIzbfXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7/yZDf3mcCp0vl1kiYml/Yjtc10BHf9Kh6OvTLb3sGtATNtZKKXI0J94nvrse0z1
	 e5c1bW/hld9CzNttJzliqroIzO/QhF/wW/y0c3g839tCeeY5k3BCym6vk9okt88w8L
	 qoghbiVkTZLvTGVQWgXMRtEzYXfdarKrqYiZKwpuujECEQagYZ7srUa16yQfua4M5j
	 bEL6qoxH6mIIzMtRyDMETO1LhxitpmR6KnHeD2/efRlw621DJNDfodkjZLiuPParNe
	 lxuMjpSYmxNUmGzfshXEnrJPwPSZ0ZMkmCeCRGutMO1dnGF4W1OegQ7V2hOABIjJ+A
	 u/v0P4fv4IeXA==
Date: Wed, 21 Aug 2024 09:34:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] xfs: move the tagged perag lookup helpers to
 xfs_icache.c
Message-ID: <20240821163407.GH865349@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063901.650776-3-hch@lst.de>

On Wed, Aug 21, 2024 at 08:38:29AM +0200, Christoph Hellwig wrote:
> The tagged perag helpers are only used in xfs_icache.c in the kernel code
> and not at all in xfsprogs.  Move them to xfs_icache.c in preparation for
> switching to an xarray, for which I have no plan to implement the tagged
> lookup functions for userspace.

I don't particularly like moving these functions to another file, but I
suppose the icache is the only user of these tags.  How hard is it to
make userspace stubs that assert if anyone ever tries to use it?

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_ag.c | 51 -------------------------------------
>  fs/xfs/libxfs/xfs_ag.h | 11 --------
>  fs/xfs/xfs_icache.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> index 4b5a39a83f7aed..87f00f0180846f 100644
> --- a/fs/xfs/libxfs/xfs_ag.c
> +++ b/fs/xfs/libxfs/xfs_ag.c
> @@ -56,31 +56,6 @@ xfs_perag_get(
>  	return pag;
>  }
>  
> -/*
> - * search from @first to find the next perag with the given tag set.
> - */
> -struct xfs_perag *
> -xfs_perag_get_tag(
> -	struct xfs_mount	*mp,
> -	xfs_agnumber_t		first,
> -	unsigned int		tag)
> -{
> -	struct xfs_perag	*pag;
> -	int			found;
> -
> -	rcu_read_lock();
> -	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, first, 1, tag);
> -	if (found <= 0) {
> -		rcu_read_unlock();
> -		return NULL;
> -	}
> -	trace_xfs_perag_get_tag(pag, _RET_IP_);
> -	atomic_inc(&pag->pag_ref);
> -	rcu_read_unlock();
> -	return pag;
> -}
> -
>  /* Get a passive reference to the given perag. */
>  struct xfs_perag *
>  xfs_perag_hold(
> @@ -127,32 +102,6 @@ xfs_perag_grab(
>  	return pag;
>  }
>  
> -/*
> - * search from @first to find the next perag with the given tag set.
> - */
> -struct xfs_perag *
> -xfs_perag_grab_tag(
> -	struct xfs_mount	*mp,
> -	xfs_agnumber_t		first,
> -	int			tag)
> -{
> -	struct xfs_perag	*pag;
> -	int			found;
> -
> -	rcu_read_lock();
> -	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, first, 1, tag);
> -	if (found <= 0) {
> -		rcu_read_unlock();
> -		return NULL;
> -	}
> -	trace_xfs_perag_grab_tag(pag, _RET_IP_);
> -	if (!atomic_inc_not_zero(&pag->pag_active_ref))
> -		pag = NULL;
> -	rcu_read_unlock();
> -	return pag;
> -}
> -
>  void
>  xfs_perag_rele(
>  	struct xfs_perag	*pag)
> diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
> index d62c266c0b44d5..d9cccd093b60e0 100644
> --- a/fs/xfs/libxfs/xfs_ag.h
> +++ b/fs/xfs/libxfs/xfs_ag.h
> @@ -153,15 +153,11 @@ void xfs_free_perag(struct xfs_mount *mp);
>  
>  /* Passive AG references */
>  struct xfs_perag *xfs_perag_get(struct xfs_mount *mp, xfs_agnumber_t agno);
> -struct xfs_perag *xfs_perag_get_tag(struct xfs_mount *mp, xfs_agnumber_t agno,
> -		unsigned int tag);
>  struct xfs_perag *xfs_perag_hold(struct xfs_perag *pag);
>  void xfs_perag_put(struct xfs_perag *pag);
>  
>  /* Active AG references */
>  struct xfs_perag *xfs_perag_grab(struct xfs_mount *, xfs_agnumber_t);
> -struct xfs_perag *xfs_perag_grab_tag(struct xfs_mount *, xfs_agnumber_t,
> -				   int tag);
>  void xfs_perag_rele(struct xfs_perag *pag);
>  
>  /*
> @@ -263,13 +259,6 @@ xfs_perag_next(
>  	(agno) = 0; \
>  	for_each_perag_from((mp), (agno), (pag))
>  
> -#define for_each_perag_tag(mp, agno, pag, tag) \
> -	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
> -		(pag) != NULL; \
> -		(agno) = (pag)->pag_agno + 1, \
> -		xfs_perag_rele(pag), \
> -		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
> -
>  static inline struct xfs_perag *
>  xfs_perag_next_wrap(
>  	struct xfs_perag	*pag,
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index cf629302d48e74..ac604640d36229 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -292,6 +292,64 @@ xfs_perag_clear_inode_tag(
>  	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
>  }
>  
> +/*
> + * Search from @first to find the next perag with the given tag set.
> + */
> +static struct xfs_perag *
> +xfs_perag_get_tag(
> +	struct xfs_mount	*mp,
> +	xfs_agnumber_t		first,
> +	unsigned int		tag)
> +{
> +	struct xfs_perag	*pag;
> +	int			found;
> +
> +	rcu_read_lock();
> +	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> +					(void **)&pag, first, 1, tag);
> +	if (found <= 0) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +	trace_xfs_perag_get_tag(pag, _RET_IP_);
> +	atomic_inc(&pag->pag_ref);
> +	rcu_read_unlock();
> +	return pag;
> +}
> +
> +/*
> + * Search from @first to find the next perag with the given tag set.
> + */
> +static struct xfs_perag *
> +xfs_perag_grab_tag(
> +	struct xfs_mount	*mp,
> +	xfs_agnumber_t		first,
> +	int			tag)
> +{
> +	struct xfs_perag	*pag;
> +	int			found;
> +
> +	rcu_read_lock();
> +	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> +					(void **)&pag, first, 1, tag);
> +	if (found <= 0) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +	trace_xfs_perag_grab_tag(pag, _RET_IP_);
> +	if (!atomic_inc_not_zero(&pag->pag_active_ref))
> +		pag = NULL;
> +	rcu_read_unlock();
> +	return pag;
> +}
> +
> +#define for_each_perag_tag(mp, agno, pag, tag) \
> +	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
> +		(pag) != NULL; \
> +		(agno) = (pag)->pag_agno + 1, \
> +		xfs_perag_rele(pag), \
> +		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
> +
>  /*
>   * When we recycle a reclaimable inode, we need to re-initialise the VFS inode
>   * part of the structure. This is made more complex by the fact we store
> -- 
> 2.43.0
> 
> 

