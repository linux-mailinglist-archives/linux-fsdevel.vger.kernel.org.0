Return-Path: <linux-fsdevel+bounces-26498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16795A2C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DD2281314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACA1509A8;
	Wed, 21 Aug 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvQOKPoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CF14F9DA;
	Wed, 21 Aug 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257691; cv=none; b=ZRJuc2AFiv1NHxdw4OJtqM3PMXvEGrU1v5neGLGxVI35CM8fSUXRDs9FMStqnbztKfVL2y7IUp22mewD0avnqXSSBV044AUEaFcLa2HZpRAcW1uCDdFYxutv0bZkM6pWnH6s1X7Ay90aU1jneQO6KlUrUlexzngWHIAJIH5dGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257691; c=relaxed/simple;
	bh=tF3TUpcsJ8MMwqBGwZmRy8okx9pMuuOgQ1cCbTNud54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjuVXIFlsTD7vOc7jDivfNyMtdpFkJRUWhtTUWl8GqqFLoJyXvWSYaxZF0KCA6z0IpMxnJAzYB9RVkqsy7XMZ3lguvcAgRPVQdUg/VIS/oZUOcpFNDMfMbR0a/VdSVms0xzP6iyvzSdNWvbDf0oxDpRoKAGRyB5+VJGCk/6ncNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvQOKPoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A859C32781;
	Wed, 21 Aug 2024 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724257691;
	bh=tF3TUpcsJ8MMwqBGwZmRy8okx9pMuuOgQ1cCbTNud54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvQOKPoD2KFppaz+8HYtTJI51/Y/alAVQx2javjenXSt4xGRFeTm+TrGd7WuJxJfN
	 ZTKRe4r9Vc+DbYbzyhOdFFHM7rpBoxNY9/JcCH5Bjdc2j90OsES8902dV49SgiU6rG
	 X2HWgfYjn35RpECI6YZJrB9fWN8c1EXUSzDrtdKhgPMus/b8YbQv5COLBCh/5Vxx/b
	 4+q9mTbm/VZv2Mb03FiPFSwXqYINxKpXv+fovbgI92oXRjOyuAkkkrNEvAsOUN4a9j
	 gNPLT78Kr4arDT1gvVZiJ58zPrnTgS6qLHOITPT6Fgi3ZuLoGJvAUMs3udwerty5aW
	 4ADVS2VI5TeAA==
Date: Wed, 21 Aug 2024 09:28:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: convert perag lookup to xarray
Message-ID: <20240821162810.GF865349@frogsfrogsfrogs>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821063901.650776-5-hch@lst.de>

On Wed, Aug 21, 2024 at 08:38:31AM +0200, Christoph Hellwig wrote:
> Convert the perag lookup from the legacy radix tree to the xarray,
> which allows for much nicer iteration and bulk lookup semantics.

Looks like a pretty straightforward covnersion.  Is there a good
justification for converting the ici radix tree too?  Or is it too
sparse to be worth doing?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_ag.c | 31 +++++++-------------------
>  fs/xfs/xfs_icache.c    | 50 +++++++++++++++++++++---------------------
>  fs/xfs/xfs_mount.h     |  3 +--
>  fs/xfs/xfs_super.c     |  3 +--
>  4 files changed, 35 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> index 87f00f0180846f..5f0494702e0b55 100644
> --- a/fs/xfs/libxfs/xfs_ag.c
> +++ b/fs/xfs/libxfs/xfs_ag.c
> @@ -46,7 +46,7 @@ xfs_perag_get(
>  	struct xfs_perag	*pag;
>  
>  	rcu_read_lock();
> -	pag = radix_tree_lookup(&mp->m_perag_tree, agno);
> +	pag = xa_load(&mp->m_perags, agno);
>  	if (pag) {
>  		trace_xfs_perag_get(pag, _RET_IP_);
>  		ASSERT(atomic_read(&pag->pag_ref) >= 0);
> @@ -92,7 +92,7 @@ xfs_perag_grab(
>  	struct xfs_perag	*pag;
>  
>  	rcu_read_lock();
> -	pag = radix_tree_lookup(&mp->m_perag_tree, agno);
> +	pag = xa_load(&mp->m_perags, agno);
>  	if (pag) {
>  		trace_xfs_perag_grab(pag, _RET_IP_);
>  		if (!atomic_inc_not_zero(&pag->pag_active_ref))
> @@ -195,9 +195,7 @@ xfs_free_perag(
>  	xfs_agnumber_t		agno;
>  
>  	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
> -		spin_lock(&mp->m_perag_lock);
> -		pag = radix_tree_delete(&mp->m_perag_tree, agno);
> -		spin_unlock(&mp->m_perag_lock);
> +		pag = xa_erase(&mp->m_perags, agno);
>  		ASSERT(pag);
>  		XFS_IS_CORRUPT(pag->pag_mount, atomic_read(&pag->pag_ref) != 0);
>  		xfs_defer_drain_free(&pag->pag_intents_drain);
> @@ -286,9 +284,7 @@ xfs_free_unused_perag_range(
>  	xfs_agnumber_t		index;
>  
>  	for (index = agstart; index < agend; index++) {
> -		spin_lock(&mp->m_perag_lock);
> -		pag = radix_tree_delete(&mp->m_perag_tree, index);
> -		spin_unlock(&mp->m_perag_lock);
> +		pag = xa_erase(&mp->m_perags, index);
>  		if (!pag)
>  			break;
>  		xfs_buf_cache_destroy(&pag->pag_bcache);
> @@ -329,20 +325,11 @@ xfs_initialize_perag(
>  		pag->pag_agno = index;
>  		pag->pag_mount = mp;
>  
> -		error = radix_tree_preload(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> -		if (error)
> -			goto out_free_pag;
> -
> -		spin_lock(&mp->m_perag_lock);
> -		if (radix_tree_insert(&mp->m_perag_tree, index, pag)) {
> -			WARN_ON_ONCE(1);
> -			spin_unlock(&mp->m_perag_lock);
> -			radix_tree_preload_end();
> -			error = -EEXIST;
> +		error = xa_insert(&mp->m_perags, index, pag, GFP_KERNEL);
> +		if (error) {
> +			WARN_ON_ONCE(error == -EBUSY);
>  			goto out_free_pag;
>  		}
> -		spin_unlock(&mp->m_perag_lock);
> -		radix_tree_preload_end();
>  
>  #ifdef __KERNEL__
>  		/* Place kernel structure only init below this point. */
> @@ -390,9 +377,7 @@ xfs_initialize_perag(
>  
>  out_remove_pag:
>  	xfs_defer_drain_free(&pag->pag_intents_drain);
> -	spin_lock(&mp->m_perag_lock);
> -	radix_tree_delete(&mp->m_perag_tree, index);
> -	spin_unlock(&mp->m_perag_lock);
> +	pag = xa_erase(&mp->m_perags, index);
>  out_free_pag:
>  	kfree(pag);
>  out_unwind_new_pags:
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 4d71fbfe71299a..5bca845e702f1d 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -65,6 +65,18 @@ static int xfs_icwalk_ag(struct xfs_perag *pag,
>  					 XFS_ICWALK_FLAG_RECLAIM_SICK | \
>  					 XFS_ICWALK_FLAG_UNION)
>  
> +/* Marks for the perag xarray */
> +#define XFS_PERAG_RECLAIM_MARK	XA_MARK_0
> +#define XFS_PERAG_BLOCKGC_MARK	XA_MARK_1
> +
> +static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
> +{
> +	if (tag == XFS_ICI_RECLAIM_TAG)
> +		return XFS_PERAG_RECLAIM_MARK;
> +	ASSERT(tag == XFS_ICI_BLOCKGC_TAG);
> +	return XFS_PERAG_BLOCKGC_MARK;
> +}
> +
>  /*
>   * Allocate and initialise an xfs_inode.
>   */
> @@ -191,7 +203,7 @@ xfs_reclaim_work_queue(
>  {
>  
>  	rcu_read_lock();
> -	if (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
> +	if (xa_marked(&mp->m_perags, XFS_PERAG_RECLAIM_MARK)) {
>  		queue_delayed_work(mp->m_reclaim_workqueue, &mp->m_reclaim_work,
>  			msecs_to_jiffies(xfs_syncd_centisecs / 6 * 10));
>  	}
> @@ -241,9 +253,7 @@ xfs_perag_set_inode_tag(
>  		return;
>  
>  	/* propagate the tag up into the perag radix tree */
> -	spin_lock(&mp->m_perag_lock);
> -	radix_tree_tag_set(&mp->m_perag_tree, pag->pag_agno, tag);
> -	spin_unlock(&mp->m_perag_lock);
> +	xa_set_mark(&mp->m_perags, pag->pag_agno, ici_tag_to_mark(tag));
>  
>  	/* start background work */
>  	switch (tag) {
> @@ -285,9 +295,7 @@ xfs_perag_clear_inode_tag(
>  		return;
>  
>  	/* clear the tag from the perag radix tree */
> -	spin_lock(&mp->m_perag_lock);
> -	radix_tree_tag_clear(&mp->m_perag_tree, pag->pag_agno, tag);
> -	spin_unlock(&mp->m_perag_lock);
> +	xa_clear_mark(&mp->m_perags, pag->pag_agno, ici_tag_to_mark(tag));
>  
>  	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
>  }
> @@ -302,7 +310,6 @@ xfs_perag_get_next_tag(
>  	unsigned int		tag)
>  {
>  	unsigned long		index = 0;
> -	int			found;
>  
>  	if (pag) {
>  		index = pag->pag_agno + 1;
> @@ -310,14 +317,11 @@ xfs_perag_get_next_tag(
>  	}
>  
>  	rcu_read_lock();
> -	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, index, 1, tag);
> -	if (found <= 0) {
> -		rcu_read_unlock();
> -		return NULL;
> +	pag = xa_find(&mp->m_perags, &index, ULONG_MAX, ici_tag_to_mark(tag));
> +	if (pag) {
> +		trace_xfs_perag_get_next_tag(pag, _RET_IP_);
> +		atomic_inc(&pag->pag_ref);
>  	}
> -	trace_xfs_perag_get_next_tag(pag, _RET_IP_);
> -	atomic_inc(&pag->pag_ref);
>  	rcu_read_unlock();
>  	return pag;
>  }
> @@ -332,7 +336,6 @@ xfs_perag_grab_next_tag(
>  	int			tag)
>  {
>  	unsigned long		index = 0;
> -	int			found;
>  
>  	if (pag) {
>  		index = pag->pag_agno + 1;
> @@ -340,15 +343,12 @@ xfs_perag_grab_next_tag(
>  	}
>  
>  	rcu_read_lock();
> -	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
> -					(void **)&pag, index, 1, tag);
> -	if (found <= 0) {
> -		rcu_read_unlock();
> -		return NULL;
> +	pag = xa_find(&mp->m_perags, &index, ULONG_MAX, ici_tag_to_mark(tag));
> +	if (pag) {
> +		trace_xfs_perag_grab_next_tag(pag, _RET_IP_);
> +		if (!atomic_inc_not_zero(&pag->pag_active_ref))
> +			pag = NULL;
>  	}
> -	trace_xfs_perag_grab_next_tag(pag, _RET_IP_);
> -	if (!atomic_inc_not_zero(&pag->pag_active_ref))
> -		pag = NULL;
>  	rcu_read_unlock();
>  	return pag;
>  }
> @@ -1038,7 +1038,7 @@ xfs_reclaim_inodes(
>  	if (xfs_want_reclaim_sick(mp))
>  		icw.icw_flags |= XFS_ICWALK_FLAG_RECLAIM_SICK;
>  
> -	while (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
> +	while (xa_marked(&mp->m_perags, XFS_PERAG_RECLAIM_MARK)) {
>  		xfs_ail_push_all_sync(mp->m_ail);
>  		xfs_icwalk(mp, XFS_ICWALK_RECLAIM, &icw);
>  	}
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index d0567dfbc0368d..dce2d832e1e6d1 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -208,8 +208,7 @@ typedef struct xfs_mount {
>  	 */
>  	atomic64_t		m_allocbt_blks;
>  
> -	struct radix_tree_root	m_perag_tree;	/* per-ag accounting info */
> -	spinlock_t		m_perag_lock;	/* lock for m_perag_tree */
> +	struct xarray		m_perags;	/* per-ag accounting info */
>  	uint64_t		m_resblks;	/* total reserved blocks */
>  	uint64_t		m_resblks_avail;/* available reserved blocks */
>  	uint64_t		m_resblks_save;	/* reserved blks @ remount,ro */
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7fc..c41b543f2e9121 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2009,8 +2009,7 @@ static int xfs_init_fs_context(
>  		return -ENOMEM;
>  
>  	spin_lock_init(&mp->m_sb_lock);
> -	INIT_RADIX_TREE(&mp->m_perag_tree, GFP_ATOMIC);
> -	spin_lock_init(&mp->m_perag_lock);
> +	xa_init(&mp->m_perags);
>  	mutex_init(&mp->m_growlock);
>  	INIT_WORK(&mp->m_flush_inodes_work, xfs_flush_inodes_worker);
>  	INIT_DELAYED_WORK(&mp->m_reclaim_work, xfs_reclaim_worker);
> -- 
> 2.43.0
> 
> 

