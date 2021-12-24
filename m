Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6547EC1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbhLXGXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351653AbhLXGXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D520C06175E;
        Thu, 23 Dec 2021 22:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Q0isz8WI1dRYHiEBg5IDdHPmjAQ8SBD2o3pbSMjbLk=; b=vsFGvk9HVnwrk27KUtLShPyqZC
        Dd+LiQt6FXHbproD4RJOQZuDp0lFhlkswFqp6qjer1YaU6lO0PqK7EPQeVdP4iD1Z8nQR5aBfOhHT
        rSnMTREbhd+LRZnZah80G+Fh5IR6JzqyNB4bDVKtWb8HvLHCG0GAsuFHwx2Sa1RWv5QcZ9c4j6x9g
        J15NZIPM6iWi+cn7rI87uZ/T5Khga9GQ+NtedNQUZ2px6jXgCC6fvLVVM94L7BNd9t+0R0tIfoqwW
        NETCfZZCd0amaOhDmBJSGAYW8R/tR4rKSRww10fN8/0qsf+HfrCMR+bqyGRuUBjhyVj9WgukNaqNS
        Y6NcwRHg==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dzA-00Dn9k-Kd; Fri, 24 Dec 2021 06:23:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 12/13] frontswap: remove support for multiple ops
Date:   Fri, 24 Dec 2021 07:22:45 +0100
Message-Id: <20211224062246.1258487-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is only a single instance of frontswap ops in the kernel, so
simplify the frontswap code by removing support for multiple operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h |  3 +--
 mm/frontswap.c            | 50 ++++++++++-----------------------------
 mm/zswap.c                |  8 +++++--
 3 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index c5b2848d22404..a631bac12220c 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -13,10 +13,9 @@ struct frontswap_ops {
 	int (*load)(unsigned, pgoff_t, struct page *); /* load a page */
 	void (*invalidate_page)(unsigned, pgoff_t); /* page no longer needed */
 	void (*invalidate_area)(unsigned); /* swap type just swapoff'ed */
-	struct frontswap_ops *next; /* private pointer to next ops */
 };
 
-extern void frontswap_register_ops(struct frontswap_ops *ops);
+int frontswap_register_ops(const struct frontswap_ops *ops);
 
 extern void frontswap_init(unsigned type, unsigned long *map);
 extern int __frontswap_store(struct page *page);
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 35040fa4eba83..6f69b044a8cc7 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -27,10 +27,7 @@ DEFINE_STATIC_KEY_FALSE(frontswap_enabled_key);
  * may be registered, but implementations can never deregister.  This
  * is a simple singly-linked list of all registered implementations.
  */
-static struct frontswap_ops *frontswap_ops __read_mostly;
-
-#define for_each_frontswap_ops(ops)		\
-	for ((ops) = frontswap_ops; (ops); (ops) = (ops)->next)
+static const struct frontswap_ops *frontswap_ops __read_mostly;
 
 #ifdef CONFIG_DEBUG_FS
 /*
@@ -97,18 +94,14 @@ static inline void inc_frontswap_invalidates(void) { }
 /*
  * Register operations for frontswap
  */
-void frontswap_register_ops(struct frontswap_ops *ops)
+int frontswap_register_ops(const struct frontswap_ops *ops)
 {
-	/*
-	 * Setting frontswap_ops must happen after the ops->init() calls
-	 * above; cmpxchg implies smp_mb() which will ensure the init is
-	 * complete at this point.
-	 */
-	do {
-		ops->next = frontswap_ops;
-	} while (cmpxchg(&frontswap_ops, ops->next, ops) != ops->next);
+	if (frontswap_ops)
+		return -EINVAL;
 
+	frontswap_ops = ops;
 	static_branch_inc(&frontswap_enabled_key);
+	return 0;
 }
 
 /*
@@ -117,7 +110,6 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 void frontswap_init(unsigned type, unsigned long *map)
 {
 	struct swap_info_struct *sis = swap_info[type];
-	struct frontswap_ops *ops;
 
 	VM_BUG_ON(sis == NULL);
 
@@ -133,9 +125,7 @@ void frontswap_init(unsigned type, unsigned long *map)
 	 * p->frontswap set to something valid to work properly.
 	 */
 	frontswap_map_set(sis, map);
-
-	for_each_frontswap_ops(ops)
-		ops->init(type);
+	frontswap_ops->init(type);
 }
 
 static bool __frontswap_test(struct swap_info_struct *sis,
@@ -174,7 +164,6 @@ int __frontswap_store(struct page *page)
 	int type = swp_type(entry);
 	struct swap_info_struct *sis = swap_info[type];
 	pgoff_t offset = swp_offset(entry);
-	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(!PageLocked(page));
@@ -188,16 +177,10 @@ int __frontswap_store(struct page *page)
 	 */
 	if (__frontswap_test(sis, offset)) {
 		__frontswap_clear(sis, offset);
-		for_each_frontswap_ops(ops)
-			ops->invalidate_page(type, offset);
+		frontswap_ops->invalidate_page(type, offset);
 	}
 
-	/* Try to store in each implementation, until one succeeds. */
-	for_each_frontswap_ops(ops) {
-		ret = ops->store(type, offset, page);
-		if (!ret) /* successful store */
-			break;
-	}
+	ret = frontswap_ops->store(type, offset, page);
 	if (ret == 0) {
 		__frontswap_set(sis, offset);
 		inc_frontswap_succ_stores();
@@ -220,7 +203,6 @@ int __frontswap_load(struct page *page)
 	int type = swp_type(entry);
 	struct swap_info_struct *sis = swap_info[type];
 	pgoff_t offset = swp_offset(entry);
-	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(!PageLocked(page));
@@ -230,11 +212,7 @@ int __frontswap_load(struct page *page)
 		return -1;
 
 	/* Try loading from each implementation, until one succeeds. */
-	for_each_frontswap_ops(ops) {
-		ret = ops->load(type, offset, page);
-		if (!ret) /* successful load */
-			break;
-	}
+	ret = frontswap_ops->load(type, offset, page);
 	if (ret == 0)
 		inc_frontswap_loads();
 	return ret;
@@ -247,7 +225,6 @@ int __frontswap_load(struct page *page)
 void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 {
 	struct swap_info_struct *sis = swap_info[type];
-	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(sis == NULL);
@@ -255,8 +232,7 @@ void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 	if (!__frontswap_test(sis, offset))
 		return;
 
-	for_each_frontswap_ops(ops)
-		ops->invalidate_page(type, offset);
+	frontswap_ops->invalidate_page(type, offset);
 	__frontswap_clear(sis, offset);
 	inc_frontswap_invalidates();
 }
@@ -268,7 +244,6 @@ void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 void __frontswap_invalidate_area(unsigned type)
 {
 	struct swap_info_struct *sis = swap_info[type];
-	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(sis == NULL);
@@ -276,8 +251,7 @@ void __frontswap_invalidate_area(unsigned type)
 	if (sis->frontswap_map == NULL)
 		return;
 
-	for_each_frontswap_ops(ops)
-		ops->invalidate_area(type);
+	frontswap_ops->invalidate_area(type);
 	atomic_set(&sis->frontswap_pages, 0);
 	bitmap_zero(sis->frontswap_map, sis->max);
 }
diff --git a/mm/zswap.c b/mm/zswap.c
index 7944e3e57e781..cdf6950fcb2e3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1378,7 +1378,7 @@ static void zswap_frontswap_init(unsigned type)
 	zswap_trees[type] = tree;
 }
 
-static struct frontswap_ops zswap_frontswap_ops = {
+static const struct frontswap_ops zswap_frontswap_ops = {
 	.store = zswap_frontswap_store,
 	.load = zswap_frontswap_load,
 	.invalidate_page = zswap_frontswap_invalidate_page,
@@ -1475,11 +1475,15 @@ static int __init init_zswap(void)
 	if (!shrink_wq)
 		goto fallback_fail;
 
-	frontswap_register_ops(&zswap_frontswap_ops);
+	ret = frontswap_register_ops(&zswap_frontswap_ops);
+	if (ret)
+		goto destroy_wq;
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
 	return 0;
 
+destroy_wq:
+	destroy_workqueue(shrink_wq);
 fallback_fail:
 	if (pool)
 		zswap_pool_destroy(pool);
-- 
2.30.2

