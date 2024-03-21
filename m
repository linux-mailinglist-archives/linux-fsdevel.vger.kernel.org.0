Return-Path: <linux-fsdevel+bounces-14971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607548859DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DC1B2200E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02C885280;
	Thu, 21 Mar 2024 13:16:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099A84A24;
	Thu, 21 Mar 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027017; cv=none; b=o0b5uNBSGLnUU+Cg4RL7nQeA+XFF4kbyyRyaEtPe/aUgcGbJRKpO0tzaxVUQTvgBR9O7k26rp+QnxSHUBpePd1OAQLHyqPblYh3IL8cbZ4aMd3vqsfnbFVCd8P3FNlbGfKflWFSUtqV8vX9jvmtjgouv44MZ7dLcoKhJOnYIhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027017; c=relaxed/simple;
	bh=NsumehlTMfAmBoVBz4fEeLWxZOo7jZMjeA+jl2erW6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDC83FyhRn2YIwAaT0ThDkrq5dlx72RJIxq/yrcsLZ4UK7xf3bV0CrKO+HkcYaFz2y6HTS7qNP+Qyhx/4+aU0qEYA/B+ziidq33fVgrOc2ybBnKIX+rAp55Ta8yl+7dKJ+ku72vmZeMlQAktxVjEBqv3UAusu0AR0Vz8MHq0lRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0mBc6n98z1h39H;
	Thu, 21 Mar 2024 21:14:16 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 272291A0172;
	Thu, 21 Mar 2024 21:16:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:16:50 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/3] fs: aio: convert to ring_folios and internal_folios
Date: Thu, 21 Mar 2024 21:16:40 +0800
Message-ID: <20240321131640.948634-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
References: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Since aio use folios in most functions, convert ring/internal_pages
to ring/internal_folios, let's directly use folio instead of page
throughout aio to remove hidden calls to compound_head(), eg,
flush_dcache_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 62 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 738654b58bfb..fb22a17859c6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -122,7 +122,7 @@ struct kioctx {
 	unsigned long		mmap_base;
 	unsigned long		mmap_size;
 
-	struct page		**ring_pages;
+	struct folio		**ring_folios;
 	long			nr_pages;
 
 	struct rcu_work		free_rwork;	/* see free_ioctx() */
@@ -160,7 +160,7 @@ struct kioctx {
 		spinlock_t	completion_lock;
 	} ____cacheline_aligned_in_smp;
 
-	struct page		*internal_pages[AIO_RING_PAGES];
+	struct folio		*internal_folios[AIO_RING_PAGES];
 	struct file		*aio_ring_file;
 
 	unsigned		id;
@@ -334,20 +334,20 @@ static void aio_free_ring(struct kioctx *ctx)
 	put_aio_ring_file(ctx);
 
 	for (i = 0; i < ctx->nr_pages; i++) {
-		struct folio *folio = page_folio(ctx->ring_pages[i]);
+		struct folio *folio = ctx->ring_folios[i];
 
 		if (!folio)
 			continue;
 
 		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
 			 folio_ref_count(folio));
-		ctx->ring_pages[i] = NULL;
+		ctx->ring_folios[i] = NULL;
 		folio_put(folio);
 	}
 
-	if (ctx->ring_pages && ctx->ring_pages != ctx->internal_pages) {
-		kfree(ctx->ring_pages);
-		ctx->ring_pages = NULL;
+	if (ctx->ring_folios && ctx->ring_folios != ctx->internal_folios) {
+		kfree(ctx->ring_folios);
+		ctx->ring_folios = NULL;
 	}
 }
 
@@ -442,7 +442,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	idx = src->index;
 	if (idx < (pgoff_t)ctx->nr_pages) {
 		/* Make sure the old folio hasn't already been changed */
-		if (ctx->ring_pages[idx] != &src->page)
+		if (ctx->ring_folios[idx] != src)
 			rc = -EAGAIN;
 	} else
 		rc = -EINVAL;
@@ -466,8 +466,8 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	 */
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 	folio_migrate_copy(dst, src);
-	BUG_ON(ctx->ring_pages[idx] != &src->page);
-	ctx->ring_pages[idx] = &dst->page;
+	BUG_ON(ctx->ring_folios[idx] != src);
+	ctx->ring_folios[idx] = dst;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	/* The old folio is no longer accessible. */
@@ -517,11 +517,11 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	nr_events = (PAGE_SIZE * nr_pages - sizeof(struct aio_ring))
 			/ sizeof(struct io_event);
 
-	ctx->ring_pages = ctx->internal_pages;
+	ctx->ring_folios = ctx->internal_folios;
 	if (nr_pages > AIO_RING_PAGES) {
-		ctx->ring_pages = kcalloc(nr_pages, sizeof(struct page *),
-					  GFP_KERNEL);
-		if (!ctx->ring_pages) {
+		ctx->ring_folios = kcalloc(nr_pages, sizeof(struct folio *),
+					   GFP_KERNEL);
+		if (!ctx->ring_folios) {
 			put_aio_ring_file(ctx);
 			return -ENOMEM;
 		}
@@ -540,7 +540,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 			 folio_ref_count(folio));
 		folio_end_read(folio, true);
 
-		ctx->ring_pages[i] = &folio->page;
+		ctx->ring_folios[i] = folio;
 	}
 	ctx->nr_pages = i;
 
@@ -573,7 +573,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->user_id = ctx->mmap_base;
 	ctx->nr_events = nr_events; /* trusted copy */
 
-	ring = page_address(ctx->ring_pages[0]);
+	ring = folio_address(ctx->ring_folios[0]);
 	ring->nr = nr_events;	/* user copy */
 	ring->id = ~0U;
 	ring->head = ring->tail = 0;
@@ -581,7 +581,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ring->compat_features = AIO_RING_COMPAT_FEATURES;
 	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
 	ring->header_length = sizeof(struct aio_ring);
-	flush_dcache_page(ctx->ring_pages[0]);
+	flush_dcache_folio(ctx->ring_folios[0]);
 
 	return 0;
 }
@@ -692,9 +692,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 
 					/* While kioctx setup is in progress,
 					 * we are protected from page migration
-					 * changes ring_pages by ->ring_lock.
+					 * changes ring_folios by ->ring_lock.
 					 */
-					ring = page_address(ctx->ring_pages[0]);
+					ring = folio_address(ctx->ring_folios[0]);
 					ring->id = ctx->id;
 					return 0;
 				}
@@ -1036,7 +1036,7 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 		 * against ctx->completed_events below will make sure we do the
 		 * safe/right thing.
 		 */
-		ring = page_address(ctx->ring_pages[0]);
+		ring = folio_address(ctx->ring_folios[0]);
 		head = ring->head;
 
 		refill_reqs_available(ctx, head, ctx->tail);
@@ -1148,12 +1148,12 @@ static void aio_complete(struct aio_kiocb *iocb)
 	if (++tail >= ctx->nr_events)
 		tail = 0;
 
-	ev_page = page_address(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
+	ev_page = folio_address(ctx->ring_folios[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
 	*event = iocb->ki_res;
 
-	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
+	flush_dcache_folio(ctx->ring_folios[pos / AIO_EVENTS_PER_PAGE]);
 
 	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
 		 (void __user *)(unsigned long)iocb->ki_res.obj,
@@ -1166,10 +1166,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 	ctx->tail = tail;
 
-	ring = page_address(ctx->ring_pages[0]);
+	ring = folio_address(ctx->ring_folios[0]);
 	head = ring->head;
 	ring->tail = tail;
-	flush_dcache_page(ctx->ring_pages[0]);
+	flush_dcache_folio(ctx->ring_folios[0]);
 
 	ctx->completed_events++;
 	if (ctx->completed_events > 1)
@@ -1241,8 +1241,8 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	sched_annotate_sleep();
 	mutex_lock(&ctx->ring_lock);
 
-	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
-	ring = page_address(ctx->ring_pages[0]);
+	/* Access to ->ring_folios here is protected by ctx->ring_lock. */
+	ring = folio_address(ctx->ring_folios[0]);
 	head = ring->head;
 	tail = ring->tail;
 
@@ -1263,20 +1263,20 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	while (ret < nr) {
 		long avail;
 		struct io_event *ev;
-		struct page *page;
+		struct folio *folio;
 
 		avail = (head <= tail ?  tail : ctx->nr_events) - head;
 		if (head == tail)
 			break;
 
 		pos = head + AIO_EVENTS_OFFSET;
-		page = ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE];
+		folio = ctx->ring_folios[pos / AIO_EVENTS_PER_PAGE];
 		pos %= AIO_EVENTS_PER_PAGE;
 
 		avail = min(avail, nr - ret);
 		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
 
-		ev = page_address(page);
+		ev = folio_address(folio);
 		copy_ret = copy_to_user(event + ret, ev + pos,
 					sizeof(*ev) * avail);
 
@@ -1290,9 +1290,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		head %= ctx->nr_events;
 	}
 
-	ring = page_address(ctx->ring_pages[0]);
+	ring = folio_address(ctx->ring_folios[0]);
 	ring->head = head;
-	flush_dcache_page(ctx->ring_pages[0]);
+	flush_dcache_folio(ctx->ring_folios[0]);
 
 	pr_debug("%li  h%u t%u\n", ret, head, tail);
 out:
-- 
2.27.0


