Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C406CDC31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjC2OUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjC2OSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A15FCD
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680099263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nU0M+T1DCbw3wZvEUGAhwFOIfw7rmUPAJ5895bBp2k=;
        b=b07jKPvbWVrwWabyE7jIvfiLFyBLtLlBPVBA4A3cYM2TuVLaf6dKlqif0deEmxVD7Uaqmb
        qTaVL2EX0ulfYnTFi5JSmX7Spizy7MDA5vfTruHlNibz7JEnAHujK/PaLw24UnSd24pxsF
        gCc36Y6R4TjMoTCUEHPieG+i7j4J06Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-MxenIVgtPHWZWtbUZgH7HA-1; Wed, 29 Mar 2023 10:14:22 -0400
X-MC-Unique: MxenIVgtPHWZWtbUZgH7HA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8DAB381459C;
        Wed, 29 Mar 2023 14:14:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62C781121330;
        Wed, 29 Mar 2023 14:14:16 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [RFC PATCH v2 07/48] mm: Make the page_frag_cache allocator use per-cpu
Date:   Wed, 29 Mar 2023 15:13:13 +0100
Message-Id: <20230329141354.516864-8-dhowells@redhat.com>
In-Reply-To: <20230329141354.516864-1-dhowells@redhat.com>
References: <20230329141354.516864-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the page_frag_cache allocator have a separate allocation bucket for
each cpu to avoid racing.  This means that no lock is required, other than
preempt disablement, to allocate from it, though if a softirq wants to
access it, then softirq disablement will need to be added.

Make the NVMe and mediatek drivers pass in NULL to page_frag_cache() and
use the default allocation buckets rather than defining their own.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Lorenzo Bianconi <lorenzo@kernel.org>
cc: Felix Fietkau <nbd@nbd.name>
cc: John Crispin <john@phrozen.org>
cc: Sean Wang <sean.wang@mediatek.com>
cc: Mark Lee <Mark-MC.Lee@mediatek.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Sagi Grimberg <sagi@grimberg.me>
cc: Chaitanya Kulkarni <kch@nvidia.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
cc: linux-nvme@lists.infradead.org
cc: linux-mediatek@lists.infradead.org
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c |  19 +--
 drivers/net/ethernet/mediatek/mtk_wed_wo.h |   2 -
 drivers/nvme/host/tcp.c                    |  19 +--
 drivers/nvme/target/tcp.c                  |  22 +--
 include/linux/gfp.h                        |  17 +-
 mm/page_frag_alloc.c                       | 182 +++++++++++++++------
 net/core/skbuff.c                          |  32 ++--
 7 files changed, 164 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 69fba29055e9..859f34447f2f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -143,7 +143,7 @@ mtk_wed_wo_queue_refill(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q,
 		dma_addr_t addr;
 		void *buf;
 
-		buf = page_frag_alloc(&q->cache, q->buf_size, GFP_ATOMIC);
+		buf = page_frag_alloc(NULL, q->buf_size, GFP_ATOMIC);
 		if (!buf)
 			break;
 
@@ -286,7 +286,6 @@ mtk_wed_wo_queue_free(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 static void
 mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
 	int i;
 
 	for (i = 0; i < q->n_desc; i++) {
@@ -297,20 +296,11 @@ mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 		skb_free_frag(entry->buf);
 		entry->buf = NULL;
 	}
-
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
 }
 
 static void
 mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
-
 	for (;;) {
 		void *buf = mtk_wed_wo_dequeue(wo, q, NULL, true);
 
@@ -319,13 +309,6 @@ mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 
 		skb_free_frag(buf);
 	}
-
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
 }
 
 static void
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index dbcf42ce9173..6f940db67fb8 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -210,8 +210,6 @@ struct mtk_wed_wo_queue_entry {
 struct mtk_wed_wo_queue {
 	struct mtk_wed_wo_queue_regs regs;
 
-	struct page_frag_cache cache;
-
 	struct mtk_wed_wo_queue_desc *desc;
 	dma_addr_t desc_dma;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7723a4989524..fa32969b532f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -147,8 +147,6 @@ struct nvme_tcp_queue {
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 
-	struct page_frag_cache	pf_cache;
-
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
@@ -470,9 +468,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	req->pdu = page_frag_alloc(&queue->pf_cache,
-		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
-		GFP_KERNEL | __GFP_ZERO);
+	req->pdu = page_frag_alloc(NULL, sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
+				   GFP_KERNEL | __GFP_ZERO);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1288,9 +1285,8 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	async->pdu = page_frag_alloc(&queue->pf_cache,
-		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
-		GFP_KERNEL | __GFP_ZERO);
+	async->pdu = page_frag_alloc(NULL, sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1300,7 +1296,6 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noreclaim_flag;
@@ -1311,12 +1306,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
-	if (queue->pf_cache.va) {
-		page = virt_to_head_page(queue->pf_cache.va);
-		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
-		queue->pf_cache.va = NULL;
-	}
-
 	noreclaim_flag = memalloc_noreclaim_save();
 	sock_release(queue->sock);
 	memalloc_noreclaim_restore(noreclaim_flag);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 66e8f9fd0ca7..d6cc557cc539 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -143,8 +143,6 @@ struct nvmet_tcp_queue {
 
 	struct nvmet_tcp_cmd	connect;
 
-	struct page_frag_cache	pf_cache;
-
 	void (*data_ready)(struct sock *);
 	void (*state_change)(struct sock *);
 	void (*write_space)(struct sock *);
@@ -1312,25 +1310,25 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	c->queue = queue;
 	c->req.port = queue->port->nport;
 
-	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+	c->cmd_pdu = page_frag_alloc(NULL, sizeof(*c->cmd_pdu) + hdgst,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!c->cmd_pdu)
 		return -ENOMEM;
 	c->req.cmd = &c->cmd_pdu->cmd;
 
-	c->rsp_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->rsp_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+	c->rsp_pdu = page_frag_alloc(NULL, sizeof(*c->rsp_pdu) + hdgst,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!c->rsp_pdu)
 		goto out_free_cmd;
 	c->req.cqe = &c->rsp_pdu->cqe;
 
-	c->data_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+	c->data_pdu = page_frag_alloc(NULL, sizeof(*c->data_pdu) + hdgst,
+				      GFP_KERNEL | __GFP_ZERO);
 	if (!c->data_pdu)
 		goto out_free_rsp;
 
-	c->r2t_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->r2t_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+	c->r2t_pdu = page_frag_alloc(NULL, sizeof(*c->r2t_pdu) + hdgst,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
@@ -1438,7 +1436,6 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
-	struct page *page;
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
@@ -1460,9 +1457,6 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-
-	page = virt_to_head_page(queue->pf_cache.va);
-	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
 	kfree(queue);
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..b208ca315882 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -304,14 +304,17 @@ extern void free_pages(unsigned long addr, unsigned int order);
 
 struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
-extern void *page_frag_alloc_align(struct page_frag_cache *nc,
-				   unsigned int fragsz, gfp_t gfp_mask,
-				   unsigned int align_mask);
-
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-			     unsigned int fragsz, gfp_t gfp_mask)
+extern void *page_frag_alloc_align(struct page_frag_cache __percpu *frag_cache,
+				   size_t fragsz, gfp_t gfp,
+				   unsigned long align_mask);
+extern void *page_frag_memdup(struct page_frag_cache __percpu *frag_cache,
+			      const void *p, size_t fragsz, gfp_t gfp,
+			      unsigned long align_mask);
+
+static inline void *page_frag_alloc(struct page_frag_cache __percpu *frag_cache,
+				    size_t fragsz, gfp_t gfp)
 {
-	return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return page_frag_alloc_align(frag_cache, fragsz, gfp, ULONG_MAX);
 }
 
 extern void page_frag_free(void *addr);
diff --git a/mm/page_frag_alloc.c b/mm/page_frag_alloc.c
index c3792b68ce32..7844398afe26 100644
--- a/mm/page_frag_alloc.c
+++ b/mm/page_frag_alloc.c
@@ -16,25 +16,23 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 
+static DEFINE_PER_CPU(struct page_frag_cache, page_frag_default_allocator);
+
 /*
  * Allocate a new folio for the frag cache.
  */
-static struct folio *page_frag_cache_refill(struct page_frag_cache *nc,
-					    gfp_t gfp_mask)
+static struct folio *page_frag_cache_refill(gfp_t gfp)
 {
-	struct folio *folio = NULL;
-	gfp_t gfp = gfp_mask;
+	struct folio *folio;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	gfp_mask |= __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	folio = folio_alloc(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER);
+	folio = folio_alloc(gfp | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC,
+			    PAGE_FRAG_CACHE_MAX_ORDER);
+	if (folio)
+		return folio;
 #endif
-	if (unlikely(!folio))
-		folio = folio_alloc(gfp, 0);
 
-	if (folio)
-		nc->folio = folio;
-	return folio;
+	return folio_alloc(gfp, 0);
 }
 
 void __page_frag_cache_drain(struct page *page, unsigned int count)
@@ -47,41 +45,68 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *page_frag_alloc_align(struct page_frag_cache *nc,
-		      unsigned int fragsz, gfp_t gfp_mask,
-		      unsigned int align_mask)
+/**
+ * page_frag_alloc_align - Allocate some memory for use in zerocopy
+ * @frag_cache: The frag cache to use (or NULL for the default)
+ * @fragsz: The size of the fragment desired
+ * @gfp: Allocation flags under which to make an allocation
+ * @align_mask: The required alignment
+ *
+ * Allocate some memory for use with zerocopy where protocol bits have to be
+ * mixed in with spliced/zerocopied data.  Unlike memory allocated from the
+ * slab, this memory's lifetime is purely dependent on the folio's refcount.
+ *
+ * The way it works is that a folio is allocated and fragments are broken off
+ * sequentially and returned to the caller with a ref until the folio no longer
+ * has enough spare space - at which point the allocator's ref is dropped and a
+ * new folio is allocated.  The folio remains in existence until the last ref
+ * held by, say, an sk_buff is discarded and then the page is returned to the
+ * page allocator.
+ *
+ * Returns a pointer to the memory on success and -ENOMEM on allocation
+ * failure.
+ *
+ * The allocated memory should be disposed of with folio_put().
+ */
+void *page_frag_alloc_align(struct page_frag_cache __percpu *frag_cache,
+			    size_t fragsz, gfp_t gfp, unsigned long align_mask)
 {
-	struct folio *folio = nc->folio;
+	struct page_frag_cache *nc;
+	struct folio *folio, *spare = NULL;
 	size_t offset;
+	void *p;
 
-	if (unlikely(!folio)) {
-refill:
-		folio = page_frag_cache_refill(nc, gfp_mask);
-		if (!folio)
-			return NULL;
-
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		folio_ref_add(folio, PAGE_FRAG_CACHE_MAX_SIZE);
+	if (!frag_cache)
+		frag_cache = &page_frag_default_allocator;
+	if (WARN_ON_ONCE(fragsz == 0))
+		fragsz = 1;
+	align_mask &= ~3UL;
 
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = folio_is_pfmemalloc(folio);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = folio_size(folio);
+	nc = get_cpu_ptr(frag_cache);
+reload:
+	folio = nc->folio;
+	offset = nc->offset;
+try_again:
+
+	/* Make the allocation if there's sufficient space. */
+	if (fragsz <= offset) {
+		nc->pagecnt_bias--;
+		offset = (offset - fragsz) & align_mask;
+		nc->offset = offset;
+		p = folio_address(folio) + offset;
+		put_cpu_ptr(frag_cache);
+		if (spare)
+			folio_put(spare);
+		return p;
 	}
 
-	offset = nc->offset;
-	if (unlikely(fragsz > offset)) {
-		/* Reuse the folio if everyone we gave it to has finished with it. */
-		if (!folio_ref_sub_and_test(folio, nc->pagecnt_bias)) {
-			nc->folio = NULL;
+	/* Insufficient space - see if we can refurbish the current folio. */
+	if (folio) {
+		if (!folio_ref_sub_and_test(folio, nc->pagecnt_bias))
 			goto refill;
-		}
 
 		if (unlikely(nc->pfmemalloc)) {
 			__folio_put(folio);
-			nc->folio = NULL;
 			goto refill;
 		}
 
@@ -91,27 +116,56 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = folio_size(folio);
-		if (unlikely(fragsz > offset)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			nc->offset = offset;
+		if (unlikely(fragsz > offset))
+			goto frag_too_big;
+		goto try_again;
+	}
+
+refill:
+	if (!spare) {
+		nc->folio = NULL;
+		put_cpu_ptr(frag_cache);
+
+		spare = page_frag_cache_refill(gfp);
+		if (!spare)
 			return NULL;
-		}
+
+		nc = get_cpu_ptr(frag_cache);
+		/* We may now be on a different cpu and/or someone else may
+		 * have refilled it
+		 */
+		nc->pfmemalloc = folio_is_pfmemalloc(spare);
+		if (nc->folio)
+			goto reload;
 	}
 
-	nc->pagecnt_bias--;
-	offset -= fragsz;
-	offset &= align_mask;
+	nc->folio = spare;
+	folio = spare;
+	spare = NULL;
+
+	/* Even if we own the page, we do not use atomic_set().  This would
+	 * break get_page_unless_zero() users.
+	 */
+	folio_ref_add(folio, PAGE_FRAG_CACHE_MAX_SIZE);
+
+	/* Reset page count bias and offset to start of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+	offset = folio_size(folio);
+	goto try_again;
+
+frag_too_big:
+	/*
+	 * The caller is trying to allocate a fragment with fragsz > PAGE_SIZE
+	 * but the cache isn't big enough to satisfy the request, this may
+	 * happen in low memory conditions.  We don't release the cache page
+	 * because it could make memory pressure worse so we simply return NULL
+	 * here.
+	 */
 	nc->offset = offset;
-
-	return folio_address(folio) + offset;
+	put_cpu_ptr(frag_cache);
+	if (spare)
+		folio_put(spare);
+	return NULL;
 }
 EXPORT_SYMBOL(page_frag_alloc_align);
 
@@ -123,3 +177,25 @@ void page_frag_free(void *addr)
 	folio_put(virt_to_folio(addr));
 }
 EXPORT_SYMBOL(page_frag_free);
+
+/**
+ * page_frag_memdup - Allocate a page fragment and duplicate some data into it
+ * @frag_cache: The frag cache to use (or NULL for the default)
+ * @fragsz: The amount of memory to copy (maximum 1/2 page).
+ * @p: The source data to copy
+ * @gfp: Allocation flags under which to make an allocation
+ * @align_mask: The required alignment
+ */
+void *page_frag_memdup(struct page_frag_cache __percpu *frag_cache,
+		       const void *p, size_t fragsz, gfp_t gfp,
+		       unsigned long align_mask)
+{
+	void *q;
+
+	q = page_frag_alloc_align(frag_cache, fragsz, gfp, align_mask);
+	if (!q)
+		return q;
+
+	return memcpy(q, p, fragsz);
+}
+EXPORT_SYMBOL(page_frag_memdup);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index eb7d33b41e71..0506e4cf1ed9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -222,13 +222,13 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
 #endif
 
 struct napi_alloc_cache {
-	struct page_frag_cache page;
 	struct page_frag_1k page_small;
 	unsigned int skb_count;
 	void *skb_cache[NAPI_SKB_CACHE_SIZE];
 };
 
 static DEFINE_PER_CPU(struct page_frag_cache, netdev_alloc_cache);
+static DEFINE_PER_CPU(struct page_frag_cache, napi_frag_cache);
 static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache);
 
 /* Double check that napi_get_frags() allocates skbs with
@@ -250,11 +250,9 @@ void napi_get_frags_check(struct napi_struct *napi)
 
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
-	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
-
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
-	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+	return page_frag_alloc_align(&napi_frag_cache, fragsz, GFP_ATOMIC, align_mask);
 }
 EXPORT_SYMBOL(__napi_alloc_frag_align);
 
@@ -264,15 +262,12 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
 	if (in_hardirq() || irqs_disabled()) {
-		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
-
-		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(&netdev_alloc_cache,
+					     fragsz, GFP_ATOMIC, align_mask);
 	} else {
-		struct napi_alloc_cache *nc;
-
 		local_bh_disable();
-		nc = this_cpu_ptr(&napi_alloc_cache);
-		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(&napi_frag_cache,
+					     fragsz, GFP_ATOMIC, align_mask);
 		local_bh_enable();
 	}
 	return data;
@@ -656,7 +651,6 @@ EXPORT_SYMBOL(__alloc_skb);
 struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 				   gfp_t gfp_mask)
 {
-	struct page_frag_cache *nc;
 	struct sk_buff *skb;
 	bool pfmemalloc;
 	void *data;
@@ -681,14 +675,12 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 		gfp_mask |= __GFP_MEMALLOC;
 
 	if (in_hardirq() || irqs_disabled()) {
-		nc = this_cpu_ptr(&netdev_alloc_cache);
-		data = page_frag_alloc(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		data = page_frag_alloc(&netdev_alloc_cache, len, gfp_mask);
+		pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
 	} else {
 		local_bh_disable();
-		nc = this_cpu_ptr(&napi_alloc_cache.page);
-		data = page_frag_alloc(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		data = page_frag_alloc(&napi_frag_cache, len, gfp_mask);
+		pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
 		local_bh_enable();
 	}
 
@@ -776,8 +768,8 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	} else {
 		len = SKB_HEAD_ALIGN(len);
 
-		data = page_frag_alloc(&nc->page, len, gfp_mask);
-		pfmemalloc = nc->page.pfmemalloc;
+		data = page_frag_alloc(&napi_frag_cache, len, gfp_mask);
+		pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
 	}
 
 	if (unlikely(!data))

