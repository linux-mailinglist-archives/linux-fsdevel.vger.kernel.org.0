Return-Path: <linux-fsdevel+bounces-76837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBv7OvYci2nSPwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:56:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710311A763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65EBF303CEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061C3271FD;
	Tue, 10 Feb 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRzcrZSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8CD326D4F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724583; cv=none; b=STkzHPqyLWAklEpquR+QyWhF407By+F4lRfx34NCI0jfMaIoTdikEPDDPunpQZvcKaY2qq3RaEL+UCuFsul/GQ2Iz12MNTvQJt2Z98HFfPc38QimyCA9Q5XsM4aL3LRtasXpYRFcuUBf9zwwgUYCMXHd3vh2KJYJjBvlckV1aOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724583; c=relaxed/simple;
	bh=xb0H8f0zij+2Lo5cSIubhLbaPZ+hPhQo2RxGO9SlgfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=kU3RLf6XAgvKpjVoLR7g9IO9/FNKTcS2f+VxWgWvudnvPM3kpC/CSNYAYyj6RqobM3X0lnGiswqOPoA22xpesG+PEidXbwPqg4KPuk3sUg9wjqRYiZp78aKVWaEVEpocS31GkeeczuGehcQmRL3+1o7L4OFPnSZqTgrQomCOEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRzcrZSc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f4e136481so2047456b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770724580; x=1771329380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh7yAl8rufONh7m/CgHms/EgFK1saZrvUpQU2nWdB00=;
        b=kRzcrZScGlMtVthGaxPh63kFFnIA2UUpZfQUAE1thEmSak1Dksxz984APw42CB09YV
         LVYNmHJvF3HwSq1tuPKcV66UyS5E5t5f5oJ0I+tGvBGLOZSqe5sMIwWzwogPXCFKTGGp
         i9I4G0wHhY+b78NxcC0qRJniib47Xz1uZTioXRZGm8wD3uQYNZaAZLjR2ClQD6toQ/op
         Qwjn0alu9OkTABxXKr7kLSnTkEiwJs98xLWHQ88BfjXcue14sCRDjrhlbJVebL/NeHPb
         wDSSwYF5PKmqIRYLsMADjOv9ykmQOa4vL+W09CdZAV05CcAIoTzfjgVE9iP2fpLiNHrV
         Nt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724580; x=1771329380;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh7yAl8rufONh7m/CgHms/EgFK1saZrvUpQU2nWdB00=;
        b=FFHfRdxO2JsFjjXGyyiJZIkjM5HHJWuifNgKGAA7jPSXVgIn8E1VTHXSQOmn1tXOJE
         8vRmMt7mdlnNpIOKZ1eDHCirv3T/YvC3HO9JY6I0uZryDYzMNSng16SSFx+nIyNgnn2g
         jrYqtfM5E6JreC1r0NNkkMNirwbXGE1vZ2q/0n5nmt0s7kH+NTFc5l0ScGOg5ljsjEkN
         sXZA0WlPpIuOvVubb5pewzAvXNWeVoml+SxHJlEd+eckFQvS4y+LAknz2XO12qVkJsSt
         DNT7SN/tOm5IqNdHSRL8DsgsIFNNgIOmAyFGYgbzPpgbJnXNU8QTspSsrdWdJKKwbKuC
         EWsA==
X-Gm-Message-State: AOJu0YzPrhleQTtqlBZf7kF5HWJ17djMujHr75eiZdf2BPLK8/3hn/Yw
	gIbRnXzvJIKdSUIGVzfjQmZLbUF9yyRXT6MxmlJcf1vZnHm6r4V7yjcxXyJVCH55
X-Gm-Gg: AZuq6aJqm3ejtu9gebLLlpnp24u2uscnrp3+i/RLWj5PUsJT0Ka5bJEcxIUePAG2yaX
	goFx60284JCbAwI5dxWT4F2yE6FmhKHcowUf7p4766Zrl+BYLDnz2e67YsJ+lcqt5pTY903JZps
	U/G3dMX3QKb67CDcxcHiyE/LvQG+6jtjLXs5yhxMa9x/6RtDVVDH0y2m6yZU7dpc5+brqwrBJRR
	HXddX904EGfDXuc7CbzZ4PMMkQA+ieunmrQ6qs3IDdJUVDZCVnKRe8XGIohShl+NZQyV75QYCsy
	aAfL54CUV1IaqP3xuJPPv09OJ7IjDRW9O4K/sCvaiwnBBZzNHQgoE1xcoCzaL5QrmcNh62kg8Z1
	rw0TO8DNH/uKMqJ+w9Iaiz4tOSOJjSPButiNVEnnAwHaGboad5Kk++uRZ2K2R055Yr+Yc62rMdm
	MrC6Wtx3Mrft13GpTMrCO0Jb8C9YuEoLplxpjh5Ea/FOLjzaofAZ0aRnabck+k0ZpE2l36Nxugv
	wbl
X-Received: by 2002:a05:6a00:4fd6:b0:81e:96c9:1325 with SMTP id d2e1a72fcca58-824417f97cbmr13212298b3a.70.1770724580368;
        Tue, 10 Feb 2026 03:56:20 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.208.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm12972619b3a.45.2026.02.10.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:56:19 -0800 (PST)
Message-ID: <46a56cbf1ead927d0bc109b8106ae3b5237ec721.camel@gmail.com>
Subject: Re: [PATCH v3 5/6] xfs: add per-AG writeback workqueue
 infrastructure
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org, 
 clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
 hch@lst.de,  ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
 cem@kernel.org,  wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com, 
	vishak.g@samsung.com, joshi.k@samsung.com
Date: Tue, 10 Feb 2026 17:26:11 +0530
In-Reply-To: <20260116100818.7576-6-kundan.kumar@samsung.com>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	 <CGME20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0@epcas5p1.samsung.com>
	 <20260116100818.7576-6-kundan.kumar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76837-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[samsung.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirjharroylists@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7710311A763
X-Rspamd-Action: no action

On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
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

agno where the ip resides or the agno of any one the blocks which belongs to this ip?
> +};

Nit: Coding style - tab between data type and the indentifier
> +
> +struct xfs_ag_wb {
> +	struct delayed_work ag_work;
> +	spinlock_t lock;
> +	struct list_head task_list;
> +	xfs_agnumber_t agno;
> +	struct xfs_mount *mp;
> +};
> +
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

Nit: I think we follow 2 tabs indentation of the parameter list length exceeds per line limit count.
Similar comments for such changes in the below function call sites.
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

Nit: 2 tabs indentation
> +
> +	if (!mp->m_ag_task_pool) {
> +		kmem_cache_destroy(mp->m_ag_task_cachep);
> +		mp->m_ag_task_cachep = NULL;

Shouldn't we be also freeing mp->m_ag_wq and the array mp->m_ag_wb[] array ?
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

Again Nit: - Coding style - tab between data type and the identifier


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

So if we are not able to init the write back workqueue infra, we are still okay to mount the fs
except that the AG aware write back facility won't be available i.e, we aren't treating it as a
fatal error, correct?
--NR
> +
>  	/*
>  	 * V4 support is undergoing deprecation.
>  	 *


