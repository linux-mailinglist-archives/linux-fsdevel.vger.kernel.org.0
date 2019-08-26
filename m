Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DCB9CDE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfHZLQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 07:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbfHZLQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:16:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF8EFAC28;
        Mon, 26 Aug 2019 11:16:41 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 1/2] mm, sl[ou]b: improve memory accounting
Date:   Mon, 26 Aug 2019 13:16:26 +0200
Message-Id: <20190826111627.7505-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190826111627.7505-1-vbabka@suse.cz>
References: <20190826111627.7505-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SLOB currently doesn't account its pages at all, so in /proc/meminfo the Slab
field shows zero. Modifying a counter on page allocation and freeing should be
acceptable even for the small system scenarios SLOB is intended for.
Since reclaimable caches are not separated in SLOB, account everything as
unreclaimable.

SLUB currently doesn't account kmalloc() and kmalloc_node() allocations larger
than order-1 page, that are passed directly to the page allocator. As they also
don't appear in /proc/slabinfo, it might look like a memory leak. For
consistency, account them as well. (SLAB doesn't actually use page allocator
directly, so no change there).

Ideally SLOB and SLUB would be handled in separate patches, but due to the
shared kmalloc_order() function and different kfree() implementations, it's
easier to patch both at once to prevent inconsistencies.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  8 ++++++--
 mm/slob.c        | 20 ++++++++++++++++----
 mm/slub.c        | 14 +++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 807490fe217a..929c02a90fba 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1250,12 +1250,16 @@ void __init create_kmalloc_caches(slab_flags_t flags)
  */
 void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 {
-	void *ret;
+	void *ret = NULL;
 	struct page *page;
 
 	flags |= __GFP_COMP;
 	page = alloc_pages(flags, order);
-	ret = page ? page_address(page) : NULL;
+	if (likely(page)) {
+		ret = page_address(page);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
+				    1 << order);
+	}
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ret, size, 1, flags);
diff --git a/mm/slob.c b/mm/slob.c
index 7f421d0ca9ab..3dcde9cf2b17 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -190,7 +190,7 @@ static int slob_last(slob_t *s)
 
 static void *slob_new_pages(gfp_t gfp, int order, int node)
 {
-	void *page;
+	struct page *page;
 
 #ifdef CONFIG_NUMA
 	if (node != NUMA_NO_NODE)
@@ -202,14 +202,21 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
 	if (!page)
 		return NULL;
 
+	mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
+			    1 << order);
 	return page_address(page);
 }
 
 static void slob_free_pages(void *b, int order)
 {
+	struct page *sp = virt_to_page(b);
+
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
-	free_pages((unsigned long)b, order);
+
+	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
+			    -(1 << order));
+	__free_pages(sp, order);
 }
 
 /*
@@ -521,8 +528,13 @@ void kfree(const void *block)
 		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 		unsigned int *m = (unsigned int *)(block - align);
 		slob_free(m, *m + align);
-	} else
-		__free_pages(sp, compound_order(sp));
+	} else {
+		unsigned int order = compound_order(sp);
+		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
+				    -(1 << order));
+		__free_pages(sp, order);
+
+	}
 }
 EXPORT_SYMBOL(kfree);
 
diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..74365d083a1e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3819,11 +3819,15 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
+	unsigned int order = get_order(size);
 
 	flags |= __GFP_COMP;
-	page = alloc_pages_node(node, flags, get_order(size));
-	if (page)
+	page = alloc_pages_node(node, flags, order);
+	if (page) {
 		ptr = page_address(page);
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
+				    1 << order);
+	}
 
 	return kmalloc_large_node_hook(ptr, size, flags);
 }
@@ -3949,9 +3953,13 @@ void kfree(const void *x)
 
 	page = virt_to_head_page(x);
 	if (unlikely(!PageSlab(page))) {
+		unsigned int order = compound_order(page);
+
 		BUG_ON(!PageCompound(page));
 		kfree_hook(object);
-		__free_pages(page, compound_order(page));
+		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE,
+				    -(1 << order));
+		__free_pages(page, order);
 		return;
 	}
 	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
-- 
2.22.1

