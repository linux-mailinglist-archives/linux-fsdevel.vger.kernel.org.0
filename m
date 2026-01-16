Return-Path: <linux-fsdevel+bounces-74102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E20D2F693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471FD310A647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274035C1B3;
	Fri, 16 Jan 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BrclL0mt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305531960D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558385; cv=none; b=SQ8oziusMgp5FaSrNF34kQmNTsfkMleBMyIsO7YY9fIbF+IyZspRgdGoHhLmC9ir9Ej11mNMMICJSisphbIMdtU2kp4v0Omjbzspmrttmisp/PTh+ZcwQVesK+Gve0GOo0o5ECAaxSTcbU4ACG1wAIt9pOtrz8WKgVn1QI9eqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558385; c=relaxed/simple;
	bh=hw+48KrJDWnjNARStBSMZCyx2BFfVFgdrv8M4wLJtek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=T6QnaYnGMJ24lI6f+7GhJF7S8x4wierfcK/TLBtCIx/xYuDAbNfHqQHR6YRoIvSgGy5KYmZ6bXGZzF0oCMB7gJ7yRfBD9378SctK8dlnZ6cDu/DUN8Rg1oUOsjgKUyBad3jeDeALRfHWnXASDug/NAIxd5CfXZPmmnmLNNrm8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BrclL0mt; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260116101302epoutp03d945bcddcc889d38c70d8bb373886e1a~LLnp3PqlA2690126901epoutp03Z
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260116101302epoutp03d945bcddcc889d38c70d8bb373886e1a~LLnp3PqlA2690126901epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768558382;
	bh=LEudv48FbYI3jxGKm1EoFln+VzTAerZ867l6GxD+u1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrclL0mtcL/9mebcncNQJLEd+K9SZWXqC4LSYx5RokpaDy4Ij9PDzjIzfnsgoJMB9
	 Yxg6ypw4X6pyA3eL9hyR6XVlEpebQcZy/GEF/hJFzLfaVY6JB3qTeZiqGzjM9UjkK7
	 cYADjPTlHIZJ6VuVu/2wyvYbMZz0DFC57Bw7D5Ew=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260116101301epcas5p1dabcbcbc983d060bfd774a6b49d2621e~LLnpNvqxI1616916169epcas5p1i;
	Fri, 16 Jan 2026 10:13:01 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dswf42lMvz2SSKd; Fri, 16 Jan
	2026 10:13:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0~LLnnsIu7V0902909029epcas5p1_;
	Fri, 16 Jan 2026 10:12:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101256epsmtip2c5338bdbb107259573618ff7a08310b7~LLnkrm3ds0821508215epsmtip2J;
	Fri, 16 Jan 2026 10:12:56 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, kundan.kumar@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3 5/6] xfs: add per-AG writeback workqueue infrastructure
Date: Fri, 16 Jan 2026 15:38:17 +0530
Message-Id: <20260116100818.7576-6-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116100818.7576-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101259epcas5p1cfa6ab02e5a01f7c46cc78df95c57ce0@epcas5p1.samsung.com>

Introduce per-AG writeback worker infrastructure at mount time.
This patch adds initialization and teardown only, without changing
writeback behavior.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_aops.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_aops.h  |  3 ++
 fs/xfs/xfs_mount.c |  2 ++
 fs/xfs/xfs_mount.h | 10 ++++++
 fs/xfs/xfs_super.c |  2 ++
 5 files changed, 96 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..9d5b65922cd2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -23,6 +23,23 @@
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
 
+#define XFS_AG_TASK_POOL_MIN 1024
+
+struct xfs_ag_wb_task {
+	struct list_head list;
+	struct xfs_inode *ip;
+	struct writeback_control wbc;
+	xfs_agnumber_t agno;
+};
+
+struct xfs_ag_wb {
+	struct delayed_work ag_work;
+	spinlock_t lock;
+	struct list_head task_list;
+	xfs_agnumber_t agno;
+	struct xfs_mount *mp;
+};
+
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
 	unsigned int		data_seq;
@@ -666,6 +683,68 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_submit	= xfs_zoned_writeback_submit,
 };
 
+void
+xfs_init_ag_writeback(struct xfs_mount *mp)
+{
+	xfs_agnumber_t agno;
+
+	mp->m_ag_wq = alloc_workqueue("xfs-ag-wb", WQ_UNBOUND | WQ_MEM_RECLAIM,
+				      0);
+	if (!mp->m_ag_wq)
+		return;
+
+	mp->m_ag_wb = kcalloc(mp->m_sb.sb_agcount,
+				sizeof(struct xfs_ag_wb),
+				GFP_KERNEL);
+
+	if (!mp->m_ag_wb) {
+		destroy_workqueue(mp->m_ag_wq);
+		mp->m_ag_wq = NULL;
+		return;
+	}
+
+	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
+		struct xfs_ag_wb *awb = &mp->m_ag_wb[agno];
+
+		spin_lock_init(&awb->lock);
+		INIT_LIST_HEAD(&awb->task_list);
+		awb->agno = agno;
+		awb->mp = mp;
+	}
+
+	mp->m_ag_task_cachep = kmem_cache_create("xfs_ag_wb_task",
+						sizeof(struct xfs_ag_wb_task),
+						0,
+						SLAB_RECLAIM_ACCOUNT,
+						NULL);
+
+	mp->m_ag_task_pool = mempool_create_slab_pool(XFS_AG_TASK_POOL_MIN,
+	mp->m_ag_task_cachep);
+
+	if (!mp->m_ag_task_pool) {
+		kmem_cache_destroy(mp->m_ag_task_cachep);
+		mp->m_ag_task_cachep = NULL;
+	}
+}
+
+void
+xfs_destroy_ag_writeback(struct xfs_mount *mp)
+{
+	if (mp->m_ag_wq) {
+		flush_workqueue(mp->m_ag_wq);
+		destroy_workqueue(mp->m_ag_wq);
+		mp->m_ag_wq = NULL;
+	}
+	kfree(mp->m_ag_wb);
+	mp->m_ag_wb = NULL;
+
+	mempool_destroy(mp->m_ag_task_pool);
+	mp->m_ag_task_pool = NULL;
+
+	kmem_cache_destroy(mp->m_ag_task_cachep);
+	mp->m_ag_task_cachep = NULL;
+}
+
 STATIC int
 xfs_vm_writepages(
 	struct address_space	*mapping,
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 5a7a0f1a0b49..e84acb7e8ca8 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -12,4 +12,7 @@ extern const struct address_space_operations xfs_dax_aops;
 int xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
 void xfs_end_bio(struct bio *bio);
 
+void xfs_init_ag_writeback(struct xfs_mount *mp);
+void xfs_destroy_ag_writeback(struct xfs_mount *mp);
+
 #endif /* __XFS_AOPS_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 0953f6ae94ab..26224503c4bf 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1323,6 +1323,8 @@ xfs_unmountfs(
 
 	xfs_qm_unmount(mp);
 
+	xfs_destroy_ag_writeback(mp);
+
 	/*
 	 * Unreserve any blocks we have so that when we unmount we don't account
 	 * the reserved free space as used. This is really only necessary for
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b871dfde372b..c44155de2883 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -342,6 +342,16 @@ typedef struct xfs_mount {
 
 	/* Hook to feed dirent updates to an active online repair. */
 	struct xfs_hooks	m_dir_update_hooks;
+
+
+	/* global XFS AG writeback wq */
+	struct workqueue_struct *m_ag_wq;
+	/* array of [sb_agcount] */
+	struct xfs_ag_wb        *m_ag_wb;
+
+	/* task cache and pool */
+	struct kmem_cache *m_ag_task_cachep;
+	mempool_t *m_ag_task_pool;
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bc71aa9dcee8..73f8d2942df4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1765,6 +1765,8 @@ xfs_fs_fill_super(
 	if (error)
 		goto out_free_sb;
 
+	xfs_init_ag_writeback(mp);
+
 	/*
 	 * V4 support is undergoing deprecation.
 	 *
-- 
2.25.1


