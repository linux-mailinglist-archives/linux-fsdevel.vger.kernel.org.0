Return-Path: <linux-fsdevel+bounces-75913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA4tE1Pde2kdJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:21:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C4B53FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB77E30173A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D736A023;
	Thu, 29 Jan 2026 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8vMkgeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DE337B81;
	Thu, 29 Jan 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725262; cv=none; b=RELHXjUW2rNwmZC1VVSkXuUXRColSMmSs1UjkxRgxrgoroPzS81YwsxK6RkC8cR49hvetgw1OsxrfDlv6aOkkAFFfr2Yh/vBvt9cRVUArKaasXbbwVPGFPQAyPyGfr+QbRbdNWavy4VKBAqzzQbGHfk7x7q35g13I4UysBwHAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725262; c=relaxed/simple;
	bh=Posmbe8NRA7G0It215WCxGe1hRREd15vgUGpBqnnnpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8C1vBHpmuBHOi+4J8Nk/jcs0fq/yAsHfjNa/5Tn26xlWzdEnUqGgtZOCNIhnu0+WzYnNJDQLO7ZAh/ySTVfUN1AUDkgr4VkC9DBNUcfdjRqExImwQq26vt/lUoc73EBydMWKpQbo0ZU72LvanyeevF7E7X8wOvSxXcQ7FqU4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8vMkgeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F6C4CEF7;
	Thu, 29 Jan 2026 22:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769725262;
	bh=Posmbe8NRA7G0It215WCxGe1hRREd15vgUGpBqnnnpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8vMkgeKVcy5lKEZp01o61YHZIl1gz4QvqJ2uEZB98oboavk2QUkITkulFzRfQYGW
	 bRertZklRSKjj56tPjT/040aLWZN6AADFD4yT19hNqTk5XmpkCRnFaLA6IHxMTCueL
	 aNW+xlVFo9tscW6gYv7yDevBTHF0g2RbkzG2/tK1/XiB93AsUFVtGpu5ibs8tS3/sW
	 O+Lsi1nWrPQnfD/AOYB0zUr+QNFmLoT0L5+8qU6qPB9oOY/GxsFft+7ou+OMzlibmw
	 M7s9AsVkvdJQO8DC7QbquohDjuhcre6fFC/Vp4IiQ+6nLxzdPyY0fjfEp6Enm9sNch
	 2744U5MxvXBdw==
Date: Thu, 29 Jan 2026 14:21:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 5/6] xfs: add per-AG writeback workqueue infrastructure
Message-ID: <20260129222101.GD7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0@epcas5p1.samsung.com>
 <20260116100818.7576-6-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116100818.7576-6-kundan.kumar@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75913-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B69C4B53FC
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 03:38:17PM +0530, Kundan Kumar wrote:
> Introduce per-AG writeback worker infrastructure at mount time.
> This patch adds initialization and teardown only, without changing
> writeback behavior.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_aops.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_aops.h  |  3 ++
>  fs/xfs/xfs_mount.c |  2 ++
>  fs/xfs/xfs_mount.h | 10 ++++++
>  fs/xfs/xfs_super.c |  2 ++
>  5 files changed, 96 insertions(+)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index a26f79815533..9d5b65922cd2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -23,6 +23,23 @@
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
>  
> +#define XFS_AG_TASK_POOL_MIN 1024
> +
> +struct xfs_ag_wb_task {
> +	struct list_head list;
> +	struct xfs_inode *ip;
> +	struct writeback_control wbc;
> +	xfs_agnumber_t agno;
> +};
> +
> +struct xfs_ag_wb {
> +	struct delayed_work ag_work;
> +	spinlock_t lock;
> +	struct list_head task_list;
> +	xfs_agnumber_t agno;
> +	struct xfs_mount *mp;
> +};

Help me understand the data structures here ... for each AG there's an
xfs_ag_wb object which can be run as a delayed workqueue item.  This
xfs_ag_wb is the head of a list of xfs_ag_wb_task items?

In turn, each xfs_ag_wb_task list item points to an inode and
(redundantly?) the agnumber?  So in effect each AG has a kworker that
can say "do all of this file's pagecache writeback for all dirty folios
tagged with the same agnumber"?

<shrug> It's hard to tell with no comments about how these two pieces of
data relate to each other.

--D

>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
>  	unsigned int		data_seq;
> @@ -666,6 +683,68 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>  	.writeback_submit	= xfs_zoned_writeback_submit,
>  };
>  
> +void
> +xfs_init_ag_writeback(struct xfs_mount *mp)
> +{
> +	xfs_agnumber_t agno;
> +
> +	mp->m_ag_wq = alloc_workqueue("xfs-ag-wb", WQ_UNBOUND | WQ_MEM_RECLAIM,
> +				      0);
> +	if (!mp->m_ag_wq)
> +		return;
> +
> +	mp->m_ag_wb = kcalloc(mp->m_sb.sb_agcount,
> +				sizeof(struct xfs_ag_wb),
> +				GFP_KERNEL);
> +
> +	if (!mp->m_ag_wb) {
> +		destroy_workqueue(mp->m_ag_wq);
> +		mp->m_ag_wq = NULL;
> +		return;
> +	}
> +
> +	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
> +		struct xfs_ag_wb *awb = &mp->m_ag_wb[agno];
> +
> +		spin_lock_init(&awb->lock);
> +		INIT_LIST_HEAD(&awb->task_list);
> +		awb->agno = agno;
> +		awb->mp = mp;

Can't you stuff this information in struct xfs_perag instead of asking
for a potentially huge allocation?

> +	}
> +
> +	mp->m_ag_task_cachep = kmem_cache_create("xfs_ag_wb_task",
> +						sizeof(struct xfs_ag_wb_task),
> +						0,
> +						SLAB_RECLAIM_ACCOUNT,
> +						NULL);
> +
> +	mp->m_ag_task_pool = mempool_create_slab_pool(XFS_AG_TASK_POOL_MIN,
> +	mp->m_ag_task_cachep);
> +
> +	if (!mp->m_ag_task_pool) {
> +		kmem_cache_destroy(mp->m_ag_task_cachep);
> +		mp->m_ag_task_cachep = NULL;
> +	}
> +}
> +
> +void
> +xfs_destroy_ag_writeback(struct xfs_mount *mp)
> +{
> +	if (mp->m_ag_wq) {
> +		flush_workqueue(mp->m_ag_wq);
> +		destroy_workqueue(mp->m_ag_wq);
> +		mp->m_ag_wq = NULL;
> +	}
> +	kfree(mp->m_ag_wb);
> +	mp->m_ag_wb = NULL;
> +
> +	mempool_destroy(mp->m_ag_task_pool);
> +	mp->m_ag_task_pool = NULL;
> +
> +	kmem_cache_destroy(mp->m_ag_task_cachep);
> +	mp->m_ag_task_cachep = NULL;
> +}
> +
>  STATIC int
>  xfs_vm_writepages(
>  	struct address_space	*mapping,
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 5a7a0f1a0b49..e84acb7e8ca8 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -12,4 +12,7 @@ extern const struct address_space_operations xfs_dax_aops;
>  int xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
>  void xfs_end_bio(struct bio *bio);
>  
> +void xfs_init_ag_writeback(struct xfs_mount *mp);
> +void xfs_destroy_ag_writeback(struct xfs_mount *mp);
> +
>  #endif /* __XFS_AOPS_H__ */
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 0953f6ae94ab..26224503c4bf 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -1323,6 +1323,8 @@ xfs_unmountfs(
>  
>  	xfs_qm_unmount(mp);
>  
> +	xfs_destroy_ag_writeback(mp);
> +
>  	/*
>  	 * Unreserve any blocks we have so that when we unmount we don't account
>  	 * the reserved free space as used. This is really only necessary for
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index b871dfde372b..c44155de2883 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -342,6 +342,16 @@ typedef struct xfs_mount {
>  
>  	/* Hook to feed dirent updates to an active online repair. */
>  	struct xfs_hooks	m_dir_update_hooks;
> +
> +
> +	/* global XFS AG writeback wq */
> +	struct workqueue_struct *m_ag_wq;
> +	/* array of [sb_agcount] */
> +	struct xfs_ag_wb        *m_ag_wb;
> +
> +	/* task cache and pool */
> +	struct kmem_cache *m_ag_task_cachep;
> +	mempool_t *m_ag_task_pool;
>  } xfs_mount_t;
>  
>  #define M_IGEO(mp)		(&(mp)->m_ino_geo)
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bc71aa9dcee8..73f8d2942df4 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1765,6 +1765,8 @@ xfs_fs_fill_super(
>  	if (error)
>  		goto out_free_sb;
>  
> +	xfs_init_ag_writeback(mp);
> +
>  	/*
>  	 * V4 support is undergoing deprecation.
>  	 *
> -- 
> 2.25.1
> 
> 

