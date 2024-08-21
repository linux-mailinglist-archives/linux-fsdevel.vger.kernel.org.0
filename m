Return-Path: <linux-fsdevel+bounces-26497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2B95A2B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6533B270FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28D14F9F4;
	Wed, 21 Aug 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP81BOLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522D14E2EF;
	Wed, 21 Aug 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257325; cv=none; b=HBsh2HjhZNDlloieqbgnTLCpLvUOm1K2GiO1Vc2YGZwtSAWGjyMtWC7hzWfyCqpiF6ozKgwUnCpQXPAfJEySMIfERWFWSpOPxD9RcEt0zaIJV3rJ11CvgLDOVh7rHrX7enMuzCUXIidkaUmw9/OSHc0ON8Fu25XvaZ9RX68WAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257325; c=relaxed/simple;
	bh=4/aPe8isJuO27fYjkz3nd2ULL9gylCH9DC56i1v8taE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSVk5AI6nuHQZ8lcLFs6PG6ZWKgORuRwZEnmmXUZ8WTvx+qoP1yGDDKZeSXZUfdEtqnDlPWEI5vlARA2YxDoEU7tEmfnx/qGMFB0k3QPkRiyxBhyh+73IJmu8uTzEFNnzRRV5p/98Qsm+YXXORrxDozCldLQZXIAHI3mAGSe5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP81BOLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B99C32781;
	Wed, 21 Aug 2024 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724257325;
	bh=4/aPe8isJuO27fYjkz3nd2ULL9gylCH9DC56i1v8taE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CP81BOLunHUqSlArmkevUKobouXpFJVWICAC9qWpytbiPFJ8lMk6/tYQFf/I4MQJT
	 ytloY7bE5hD2cN+30lcg/CUOdUUMsN9zlatHDSyfDkSaoDF0XxPFAZx2e9MwIueQBw
	 7/4Hb5CHM9e2kUqAGWWiPjWMga88ERCgIlSWQwFCpTGNi84WNxoVZGgyAzMJHJ+1rq
	 m1K8pGZ9Ytjk1Xka+UQN5bpDxTAeBG5zP42GdlvFvYkVLlV9i1Vk3Z17BDuj6RxHG6
	 FsfPw/7ggVIEEHMeuScZBm334l/SlRe+u7TrwkcXcMv/Bo6b6T+UUj43eWvugaObp/
	 HoIu4DnvTs+CA==
Date: Wed, 21 Aug 2024 09:22:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] xfs: use xas_for_each_marked in
 xfs_reclaim_inodes_count
Message-ID: <20240821162204.GE865349@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063901.650776-6-hch@lst.de>

On Wed, Aug 21, 2024 at 08:38:32AM +0200, Christoph Hellwig wrote:
> xfs_reclaim_inodes_count iterates over all AGs to sum up the reclaimable
> inodes counts.  There is no point in grabbing a reference to the them or
> unlock the RCU critical section for each iteration, so switch to the
> more efficient xas_for_each_marked iterator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Clever!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_icache.c | 36 ++++++++----------------------------
>  fs/xfs/xfs_trace.h  |  2 +-
>  2 files changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 5bca845e702f1d..d36dbaba660013 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -300,32 +300,6 @@ xfs_perag_clear_inode_tag(
>  	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
>  }
>  
> -/*
> - * Search from @first to find the next perag with the given tag set.
> - */
> -static struct xfs_perag *
> -xfs_perag_get_next_tag(
> -	struct xfs_mount	*mp,
> -	struct xfs_perag	*pag,
> -	unsigned int		tag)
> -{
> -	unsigned long		index = 0;
> -
> -	if (pag) {
> -		index = pag->pag_agno + 1;
> -		xfs_perag_rele(pag);
> -	}
> -
> -	rcu_read_lock();
> -	pag = xa_find(&mp->m_perags, &index, ULONG_MAX, ici_tag_to_mark(tag));
> -	if (pag) {
> -		trace_xfs_perag_get_next_tag(pag, _RET_IP_);
> -		atomic_inc(&pag->pag_ref);
> -	}
> -	rcu_read_unlock();
> -	return pag;
> -}
> -
>  /*
>   * Find the next AG after @pag, or the first AG if @pag is NULL.
>   */
> @@ -1080,11 +1054,17 @@ long
>  xfs_reclaim_inodes_count(
>  	struct xfs_mount	*mp)
>  {
> -	struct xfs_perag	*pag = NULL;
> +	XA_STATE		(xas, &mp->m_perags, 0);
>  	long			reclaimable = 0;
> +	struct xfs_perag	*pag;
>  
> -	while ((pag = xfs_perag_get_next_tag(mp, pag, XFS_ICI_RECLAIM_TAG)))
> +	rcu_read_lock();
> +	xas_for_each_marked(&xas, pag, ULONG_MAX, XFS_PERAG_RECLAIM_MARK) {
> +		trace_xfs_reclaim_inodes_count(pag, _THIS_IP_);
>  		reclaimable += pag->pag_ici_reclaimable;
> +	}
> +	rcu_read_unlock();
> +
>  	return reclaimable;
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 002d012ebd83cb..d73c0a49d9dc29 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -210,7 +210,6 @@ DEFINE_EVENT(xfs_perag_class, name,	\
>  	TP_PROTO(struct xfs_perag *pag, unsigned long caller_ip), \
>  	TP_ARGS(pag, caller_ip))
>  DEFINE_PERAG_REF_EVENT(xfs_perag_get);
> -DEFINE_PERAG_REF_EVENT(xfs_perag_get_next_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_hold);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_put);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_grab);
> @@ -218,6 +217,7 @@ DEFINE_PERAG_REF_EVENT(xfs_perag_grab_next_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_rele);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_set_inode_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_clear_inode_tag);
> +DEFINE_PERAG_REF_EVENT(xfs_reclaim_inodes_count);
>  
>  TRACE_EVENT(xfs_inodegc_worker,
>  	TP_PROTO(struct xfs_mount *mp, unsigned int shrinker_hits),
> -- 
> 2.43.0
> 
> 

