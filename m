Return-Path: <linux-fsdevel+bounces-66567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248CC24362
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751D4423A08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525832ED32;
	Fri, 31 Oct 2025 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KaxaaIF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A90329E52;
	Fri, 31 Oct 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903341; cv=none; b=dcKdGOYR3oksoUi5re/he4NKgO8F+EhgyrBBWfVqOGIGVhaFyskiXLLQqjCK25+eWfv7jZdsLmeVsvRgZeL2kZHaYTkFdIIryCTNpbf8bbv/+8apyn8Bu1Co5PJ0wOuL068VDKAs+OtYaC0NmFgF9tQicPv8MenPVo2WrRsrYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903341; c=relaxed/simple;
	bh=mngwLHzV4ROSc4a1hXRbT8jhe6rlPYWSad6OrvHWfG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDT0MpX3Km6UfKOhHBcP05ZaiLUqppwqyS9xiv51zMtNKWMzy6Bamkp8XSP5YW21XOwB5c4TpIXHZPNKeXDu95PrSwKUTQobO3k3UJHMjVEV/GtsDTCgvYersIfyaGFIUQNJlawZ+HOvOc/oPb7JclS37TPbWO1YF48VJnB2W0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KaxaaIF6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nuQqDH9i4//FEduS8ktJVpYT3Izhdhj+6SksuFO2tVc=; b=KaxaaIF6mxtlKDukKBNc6C60Su
	GlJCAmIzxsEkUM6JKoICqV+QZfYDDMiG5ebFuZBMqy9wVWa62PTlJqlbuAiOz9KC+rMRMbJCTrBYG
	FZryhL1Be+aJ4kqcLKLuK5D9JbDuoPzfmZF30QGZrLNM9vFINxmjkdTlQ0Lfjm0vB+AfI02FFpQvg
	USlIbegEUGsKKvmlVvmiIhMJL663VntxfDWe4zFyWZrheqQ0rKVlBK3RrB9mKDtSeJnn6CEZ8b0WL
	tjvKzj0hI8OJjaawwFEDNy2EFrsRJWiyBpMXB2jzyyZiS/gTNdxDTUAHFOiIGI5IraCP1+U9mpNx4
	NiE89rWg==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXl-00000005opy-2vLS;
	Fri, 31 Oct 2025 09:35:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/9] mempool: add mempool_{alloc,free}_bulk
Date: Fri, 31 Oct 2025 10:34:33 +0100
Message-ID: <20251031093517.1603379-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a version of the mempool allocator that works for batch allocations
of multiple objects.  Calling mempool_alloc in a loop is not safe because
it could deadlock if multiple threads are performing such an allocation
at the same time.

As an extra benefit the interface is build so that the same array can be
used for alloc_pages_bulk / release_pages so that at least for page
backed mempools the fast path can use a nice batch optimization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mempool.h |   7 ++
 mm/mempool.c            | 145 ++++++++++++++++++++++++++++------------
 2 files changed, 111 insertions(+), 41 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 34941a4b9026..486ed50776db 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -66,9 +66,16 @@ extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
+int mempool_alloc_bulk_noprof(mempool_t *pool, void **elem,
+		unsigned int count, gfp_t gfp_mask, unsigned long caller_ip);
+#define mempool_alloc_bulk(pool, elem, count, gfp_mask)			\
+	alloc_hooks(mempool_alloc_bulk_noprof(pool, elem, count, gfp_mask, \
+			_RET_IP_))
 
 extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
+unsigned int mempool_free_bulk(mempool_t *pool, void **elem,
+		unsigned int count);
 
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
diff --git a/mm/mempool.c b/mm/mempool.c
index 15581179c8b9..c980a0396986 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -381,23 +381,29 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 EXPORT_SYMBOL(mempool_resize);
 
 /**
- * mempool_alloc - allocate an element from a memory pool
+ * mempool_alloc_bulk - allocate multiple elements from a memory pool
  * @pool:	pointer to the memory pool
+ * @elem:	partially or fully populated elements array
+ * @count:	size (in entries) of @elem
  * @gfp_mask:	GFP_* flags.
  *
+ * Allocate elements for each slot in @elem that is non-%NULL.
+ *
  * Note: This function only sleeps if the alloc_fn callback sleeps or returns
  * %NULL.  Using __GFP_ZERO is not supported.
  *
- * Return: pointer to the allocated element or %NULL on error. This function
- * never returns %NULL when @gfp_mask allows sleeping.
+ * Return: 0 if successful, else -ENOMEM.  This function never returns -ENOMEM
+ * when @gfp_mask allows sleeping.
  */
-void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
+int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
+		unsigned int count, gfp_t gfp_mask, unsigned long caller_ip)
 {
-	void *element;
 	unsigned long flags;
 	wait_queue_entry_t wait;
 	gfp_t gfp_temp;
+	unsigned int i;
 
+	VM_WARN_ON_ONCE(count > pool->min_nr);
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
 
@@ -407,20 +413,31 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 
 	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
 
+	i = 0;
 repeat_alloc:
-	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
-		pr_info("forcing mempool usage for pool %pS\n",
-				(void *)_RET_IP_);
-		element = NULL;
-	} else {
-		element = pool->alloc(gfp_temp, pool->pool_data);
-		if (likely(element != NULL))
-			return element;
+	for (; i < count; i++) {
+		if (!elem[i]) {
+			if (should_fail_ex(&fail_mempool_alloc, 1,
+					FAULT_NOWARN)) {
+				pr_info("forcing pool usage for pool %pS\n",
+					(void *)caller_ip);
+				goto use_pool;
+			}
+			elem[i] = pool->alloc(gfp_temp, pool->pool_data);
+			if (unlikely(!elem[i]))
+				goto use_pool;
+		}
 	}
 
+	return 0;
+
+use_pool:
 	spin_lock_irqsave(&pool->lock, flags);
-	if (likely(pool->curr_nr)) {
-		element = remove_element(pool);
+	if (likely(pool->curr_nr >= count - i)) {
+		for (; i < count; i++) {
+			if (!elem[i])
+				elem[i] = remove_element(pool);
+		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 		/* paired with rmb in mempool_free(), read comment there */
 		smp_wmb();
@@ -428,8 +445,9 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 		 * Update the allocation stack trace as this is more useful
 		 * for debugging.
 		 */
-		kmemleak_update_trace(element);
-		return element;
+		for (i = 0; i < count; i++)
+			kmemleak_update_trace(elem[i]);
+		return 0;
 	}
 
 	/*
@@ -445,10 +463,12 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		return NULL;
+		if (i > 0)
+			mempool_free_bulk(pool, elem + i, count - i);
+		return -ENOMEM;
 	}
 
-	/* Let's wait for someone else to return an element to @pool */
+	/* Let's wait for someone else to return elements to @pool */
 	init_wait(&wait);
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
 
@@ -463,6 +483,27 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 	finish_wait(&pool->wait, &wait);
 	goto repeat_alloc;
 }
+EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
+
+/**
+ * mempool_alloc - allocate an element from a memory pool
+ * @pool:	pointer to the memory pool
+ * @gfp_mask:	GFP_* flags.
+ *
+ * Note: This function only sleeps if the alloc_fn callback sleeps or returns
+ * %NULL.  Using __GFP_ZERO is not supported.
+ *
+ * Return: pointer to the allocated element or %NULL on error. This function
+ * never returns %NULL when @gfp_mask allows sleeping.
+ */
+void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask)
+{
+	void *elem[1] = { };
+
+	if (mempool_alloc_bulk_noprof(pool, elem, 1, gfp_mask, _RET_IP_) < 0)
+		return NULL;
+	return elem[0];
+}
 EXPORT_SYMBOL(mempool_alloc_noprof);
 
 /**
@@ -502,21 +543,26 @@ void *mempool_alloc_preallocated(mempool_t *pool)
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
 /**
- * mempool_free - return an element to a mempool
- * @element:	pointer to element
+ * mempool_free_bulk - return elements to a mempool
  * @pool:	pointer to the memory pool
+ * @elem:	elements to return
+ * @count:	number of elements to return
  *
- * Returns @elem to @pool if its needs replenishing, else free it using
- * the free_fn callback in @pool.
+ * Returns elements from @elem to @pool if its needs replenishing and sets
+ * their slot in @elem to NULL.  Other elements are left in @elem.
+ *
+ * Return: number of elements transferred to @pool.  Elements are always
+ * transferred from the beginning of @elem, so the return value can be used as
+ * an offset into @elem for the freeing the remaining elements in the caller.
  *
  * This function only sleeps if the free_fn callback sleeps.
  */
-void mempool_free(void *element, mempool_t *pool)
+unsigned int mempool_free_bulk(struct mempool *pool, void **elem,
+		unsigned int count)
 {
 	unsigned long flags;
-
-	if (unlikely(element == NULL))
-		return;
+	bool added = false;
+	unsigned int freed = 0;
 
 	/*
 	 * Paired with the wmb in mempool_alloc().  The preceding read is
@@ -553,15 +599,11 @@ void mempool_free(void *element, mempool_t *pool)
 	 */
 	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
 		spin_lock_irqsave(&pool->lock, flags);
-		if (likely(pool->curr_nr < pool->min_nr)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
+		while (pool->curr_nr < pool->min_nr && freed < count) {
+			add_element(pool, elem[freed++]);
+			added = true;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
-	}
 
 	/*
 	 * Handle the min_nr = 0 edge case:
@@ -572,20 +614,41 @@ void mempool_free(void *element, mempool_t *pool)
 	 * allocation of element when both min_nr and curr_nr are 0, and
 	 * any active waiters are properly awakened.
 	 */
-	if (unlikely(pool->min_nr == 0 &&
+	} else if (unlikely(pool->min_nr == 0 &&
 		     READ_ONCE(pool->curr_nr) == 0)) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (likely(pool->curr_nr == 0)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
+			add_element(pool, elem[freed++]);
+			added = true;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
 
-	pool->free(element, pool->pool_data);
+	if (unlikely(added) && wq_has_sleeper(&pool->wait))
+		wake_up(&pool->wait);
+
+	return freed;
+}
+EXPORT_SYMBOL_GPL(mempool_free_bulk);
+
+/**
+ * mempool_free - return an element to the pool.
+ * @element:	element to return
+ * @pool:	pointer to the memory pool
+ *
+ * Returns @elem to @pool if its needs replenishing, else free it using
+ * the free_fn callback in @pool.
+ *
+ * This function only sleeps if the free_fn callback sleeps.
+ */
+void mempool_free(void *element, struct mempool *pool)
+{
+	if (likely(element)) {
+		void *elem[1] = { element };
+
+		if (!mempool_free_bulk(pool, elem, 1))
+			pool->free(element, pool->pool_data);
+	}
 }
 EXPORT_SYMBOL(mempool_free);
 
-- 
2.47.3


