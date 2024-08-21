Return-Path: <linux-fsdevel+bounces-26499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBD95A2D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E7B23D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20D51537BF;
	Wed, 21 Aug 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI++2yHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98C136643;
	Wed, 21 Aug 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257811; cv=none; b=ElgDkuQXYjbaaGegPY+/TnnNAb8kPc8WeY3RRgRv2laaLW6u7Z30b+KLTyLoyhOYX7OKVT69jmE6RNbGyCxZVV4kixooDYBTQ3HD0rkXGJTo34IhkRt4MxxWqq7fiYRV2z3fYF0MrHaEq/LTJDcnvX3B77QguBRVBPQy3lBWMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257811; c=relaxed/simple;
	bh=dIx/c3NKh7L3H9x0LLhlOOX8FCrtoWGrvblKSYK4urI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9DxTq9o6ohCnSlQMYr36tLt14mkoob25Og0F+7xSlKnJvrJ/84qReyN+9/OkVEAAgoaTttfp3JGDGEYTs+Q2Nz1bmQ4PEZGI/Y64OvA4dYK/FS6oG/DbE8bIel1ZWWuzNvUXHjRGGETMIMN0NjBwd9OJh03pzwksRvZ8ZJstsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI++2yHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A8C32781;
	Wed, 21 Aug 2024 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724257810;
	bh=dIx/c3NKh7L3H9x0LLhlOOX8FCrtoWGrvblKSYK4urI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI++2yHoPdce5cCefUuX/FCR74EE2aahqnHXDAUet/jlRGhw5pkTl5eB9MrHL/BAf
	 khBDkUzWsQSyN93+1jEt4TQN6T96yGwqz30mwMBalVgjgRYeI8c+qoAdYGt51WFT5V
	 5ZPQxwyeZMGPaekvjF+Zv56suAmYOILx+0NIIC4SqrBBv+vvaRxzR92yMWsz9Pbq8N
	 OLHjn5/P/NLoSee48RevjwzwLMqDYJ2dbsDR+9jXLIbhIsSjuNfaMWkCzSQ9HrrtS3
	 8TeuMxdGBSOsx8GZVNhmt6e0XS+r3VsXvziXFvgEbolGES7B1aD0OrwdyckBTDJTGr
	 TNXuR7eNpRW/A==
Date: Wed, 21 Aug 2024 09:30:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] xfs: simplify tagged perag iteration
Message-ID: <20240821163009.GG865349@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063901.650776-4-hch@lst.de>

On Wed, Aug 21, 2024 at 08:38:30AM +0200, Christoph Hellwig wrote:
> Pass the old perag structure to the tagged loop helpers so that they can
> grab the old agno before releasing the reference.  This removes the need
> to separately track the agno and the iterator macro, and thus also
> obsoletes the for_each_perag_tag syntactic sugar.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_icache.c | 69 +++++++++++++++++++++------------------------
>  fs/xfs/xfs_trace.h  |  4 +--
>  2 files changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index ac604640d36229..4d71fbfe71299a 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -296,60 +296,63 @@ xfs_perag_clear_inode_tag(
>   * Search from @first to find the next perag with the given tag set.
>   */
>  static struct xfs_perag *
> -xfs_perag_get_tag(
> +xfs_perag_get_next_tag(
>  	struct xfs_mount	*mp,
> -	xfs_agnumber_t		first,
> +	struct xfs_perag	*pag,
>  	unsigned int		tag)
>  {
> -	struct xfs_perag	*pag;
> +	unsigned long		index = 0;
>  	int			found;
>  
> +	if (pag) {
> +		index = pag->pag_agno + 1;
> +		xfs_perag_rele(pag);
> +	}

Please update the comment to reflect the replacement of @first with
@pag, and be sure to note that one starts the iteration by passing in
@pag == null, like you did below.

--D

> +
>  	rcu_read_lock();
>  	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, first, 1, tag);
> +					(void **)&pag, index, 1, tag);
>  	if (found <= 0) {
>  		rcu_read_unlock();
>  		return NULL;
>  	}
> -	trace_xfs_perag_get_tag(pag, _RET_IP_);
> +	trace_xfs_perag_get_next_tag(pag, _RET_IP_);
>  	atomic_inc(&pag->pag_ref);
>  	rcu_read_unlock();
>  	return pag;
>  }
>  
>  /*
> - * Search from @first to find the next perag with the given tag set.
> + * Find the next AG after @pag, or the first AG if @pag is NULL.
>   */
>  static struct xfs_perag *
> -xfs_perag_grab_tag(
> +xfs_perag_grab_next_tag(
>  	struct xfs_mount	*mp,
> -	xfs_agnumber_t		first,
> +	struct xfs_perag	*pag,
>  	int			tag)
>  {
> -	struct xfs_perag	*pag;
> +	unsigned long		index = 0;
>  	int			found;
>  
> +	if (pag) {
> +		index = pag->pag_agno + 1;
> +		xfs_perag_rele(pag);
> +	}
> +
>  	rcu_read_lock();
>  	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, first, 1, tag);
> +					(void **)&pag, index, 1, tag);
>  	if (found <= 0) {
>  		rcu_read_unlock();
>  		return NULL;
>  	}
> -	trace_xfs_perag_grab_tag(pag, _RET_IP_);
> +	trace_xfs_perag_grab_next_tag(pag, _RET_IP_);
>  	if (!atomic_inc_not_zero(&pag->pag_active_ref))
>  		pag = NULL;
>  	rcu_read_unlock();
>  	return pag;
>  }
>  
> -#define for_each_perag_tag(mp, agno, pag, tag) \
> -	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
> -		(pag) != NULL; \
> -		(agno) = (pag)->pag_agno + 1, \
> -		xfs_perag_rele(pag), \
> -		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
> -
>  /*
>   * When we recycle a reclaimable inode, we need to re-initialise the VFS inode
>   * part of the structure. This is made more complex by the fact we store
> @@ -1077,15 +1080,11 @@ long
>  xfs_reclaim_inodes_count(
>  	struct xfs_mount	*mp)
>  {
> -	struct xfs_perag	*pag;
> -	xfs_agnumber_t		ag = 0;
> +	struct xfs_perag	*pag = NULL;
>  	long			reclaimable = 0;
>  
> -	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
> -		ag = pag->pag_agno + 1;
> +	while ((pag = xfs_perag_get_next_tag(mp, pag, XFS_ICI_RECLAIM_TAG)))
>  		reclaimable += pag->pag_ici_reclaimable;
> -		xfs_perag_put(pag);
> -	}
>  	return reclaimable;
>  }
>  
> @@ -1427,14 +1426,13 @@ void
>  xfs_blockgc_start(
>  	struct xfs_mount	*mp)
>  {
> -	struct xfs_perag	*pag;
> -	xfs_agnumber_t		agno;
> +	struct xfs_perag	*pag = NULL;
>  
>  	if (xfs_set_blockgc_enabled(mp))
>  		return;
>  
>  	trace_xfs_blockgc_start(mp, __return_address);
> -	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
> +	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
>  		xfs_blockgc_queue(pag);
>  }
>  
> @@ -1550,21 +1548,19 @@ int
>  xfs_blockgc_flush_all(
>  	struct xfs_mount	*mp)
>  {
> -	struct xfs_perag	*pag;
> -	xfs_agnumber_t		agno;
> +	struct xfs_perag	*pag = NULL;
>  
>  	trace_xfs_blockgc_flush_all(mp, __return_address);
>  
>  	/*
> -	 * For each blockgc worker, move its queue time up to now.  If it
> -	 * wasn't queued, it will not be requeued.  Then flush whatever's
> -	 * left.
> +	 * For each blockgc worker, move its queue time up to now.  If it wasn't
> +	 * queued, it will not be requeued.  Then flush whatever is left.
>  	 */
> -	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
> +	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
>  		mod_delayed_work(pag->pag_mount->m_blockgc_wq,
>  				&pag->pag_blockgc_work, 0);
>  
> -	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
> +	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
>  		flush_delayed_work(&pag->pag_blockgc_work);
>  
>  	return xfs_inodegc_flush(mp);
> @@ -1810,12 +1806,11 @@ xfs_icwalk(
>  	enum xfs_icwalk_goal	goal,
>  	struct xfs_icwalk	*icw)
>  {
> -	struct xfs_perag	*pag;
> +	struct xfs_perag	*pag = NULL;
>  	int			error = 0;
>  	int			last_error = 0;
> -	xfs_agnumber_t		agno;
>  
> -	for_each_perag_tag(mp, agno, pag, goal) {
> +	while ((pag = xfs_perag_grab_next_tag(mp, pag, goal))) {
>  		error = xfs_icwalk_ag(pag, goal, icw);
>  		if (error) {
>  			last_error = error;
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 180ce697305a92..002d012ebd83cb 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -210,11 +210,11 @@ DEFINE_EVENT(xfs_perag_class, name,	\
>  	TP_PROTO(struct xfs_perag *pag, unsigned long caller_ip), \
>  	TP_ARGS(pag, caller_ip))
>  DEFINE_PERAG_REF_EVENT(xfs_perag_get);
> -DEFINE_PERAG_REF_EVENT(xfs_perag_get_tag);
> +DEFINE_PERAG_REF_EVENT(xfs_perag_get_next_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_hold);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_put);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_grab);
> -DEFINE_PERAG_REF_EVENT(xfs_perag_grab_tag);
> +DEFINE_PERAG_REF_EVENT(xfs_perag_grab_next_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_rele);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_set_inode_tag);
>  DEFINE_PERAG_REF_EVENT(xfs_perag_clear_inode_tag);
> -- 
> 2.43.0
> 
> 

