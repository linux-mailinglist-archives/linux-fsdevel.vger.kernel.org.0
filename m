Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7073F890
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0JTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0JTY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:19:24 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0313BF;
        Tue, 27 Jun 2023 02:19:21 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 35R9HcE0076619;
        Tue, 27 Jun 2023 17:17:38 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Qqzcd589hz2LDdKh;
        Tue, 27 Jun 2023 17:17:05 +0800 (CST)
Received: from bj03382pcu.spreadtrum.com (10.0.73.76) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 27 Jun 2023 17:17:36 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: introduce statistic for inode's gen&tier
Date:   Tue, 27 Jun 2023 17:17:18 +0800
Message-ID: <1687857438-29142-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.76]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 35R9HcE0076619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As mglru scale page's activity more presiced than before, I would like to
introduce statistics over these two properties on all pages of the inode, which
could help some mechanisms have ability to judge the inode's activity, etc madivse.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/proc/task_mmu.c        |  9 +++++++++
 include/linux/fs.h        |  2 ++
 include/linux/mm_inline.h | 14 ++++++++++++++
 mm/filemap.c              | 11 +++++++++++
 mm/swap.c                 |  1 +
 5 files changed, 37 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e35a039..3ed30ef 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -283,17 +283,26 @@ static void show_vma_header_prefix(struct seq_file *m,
 	unsigned long start, end;
 	dev_t dev = 0;
 	const char *name = NULL;
+	long nrpages = 0, gen = 0, tier = 0;
 
 	if (file) {
 		struct inode *inode = file_inode(vma->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
+		nrpages = inode->i_mapping->nrpages;
+		gen = atomic_long_read(&inode->i_mapping->gen);
+		tier = atomic_long_read(&inode->i_mapping->tier);
 	}
 
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
+
+	seq_put_hex_ll(m, NULL, nrpages, 8);
+	seq_put_hex_ll(m, ":", gen, 8);
+	seq_put_hex_ll(m, ":", tier, 8);
+
 	if (mm)
 		anon_name = anon_vma_name(vma);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2..4f4c3a2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -434,6 +434,8 @@ struct address_space {
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
+	atomic_long_t		gen;
+	atomic_long_t		tier;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ff3f3f2..f68bd06 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -307,6 +307,20 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
+static inline int lru_tier_from_refs(int refs)
+{
+	return 0;
+}
+
+static inline int folio_lru_refs(struct folio *folio)
+{
+	return 0;
+}
+
+static inline int folio_lru_gen(struct folio *folio)
+{
+	return 0;
+}
 #endif /* CONFIG_LRU_GEN */
 
 static __always_inline
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace..a1c68a9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -45,6 +45,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
+#include <linux/mm_inline.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filemap.h>
@@ -126,6 +127,9 @@ static void page_cache_delete(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, folio->index);
 	long nr = 1;
+	int refs = folio_lru_refs(folio);
+	int tier = lru_tier_from_refs(refs);
+	int gen = folio_lru_gen(folio);
 
 	mapping_set_update(&xas, mapping);
 
@@ -143,6 +147,8 @@ static void page_cache_delete(struct address_space *mapping,
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
+	atomic_long_sub(gen, &mapping->gen);
+	atomic_long_sub(tier, &mapping->tier);
 }
 
 static void filemap_unaccount_folio(struct address_space *mapping,
@@ -844,6 +850,9 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	int huge = folio_test_hugetlb(folio);
 	bool charged = false;
 	long nr = 1;
+	int refs = folio_lru_refs(folio);
+	int tier = lru_tier_from_refs(refs);
+	int gen = folio_lru_gen(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -898,6 +907,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			goto unlock;
 
 		mapping->nrpages += nr;
+		atomic_long_add(gen, &mapping->gen);
+		atomic_long_add(tier, &mapping->tier);
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge) {
diff --git a/mm/swap.c b/mm/swap.c
index 70e2063..6322c1c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -468,6 +468,7 @@ static void folio_inc_refs(struct folio *folio)
 		new_flags += BIT(LRU_REFS_PGOFF);
 		new_flags |= old_flags & ~LRU_REFS_MASK;
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
+	atomic_long_inc(&folio->mapping->tier);
 }
 #else
 static void folio_inc_refs(struct folio *folio)
-- 
1.9.1

