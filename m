Return-Path: <linux-fsdevel+bounces-40372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6AA22B29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA59F3A90C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA01DED4F;
	Thu, 30 Jan 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXUt/KnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845941B85F6;
	Thu, 30 Jan 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231284; cv=none; b=dxCY6Q22vlxxnM5z+/KnoSViqz10hrXxL2ZvWAdn46o/fqSESyJ5xvIjKbszS+J0TJhHHCuiyW9niIwEkRjezHafkf1xlxhPIFNfmlbwNdAUu9k05jQkzGVlJkedc0Ea8MqGWp/rryvRFR+zvBYhawWFheg4PCivY1EizB4e7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231284; c=relaxed/simple;
	bh=bSDJ3F3koSrA0Iqp0ErSGMFZJet+A87xTcyf884hYLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XULcUOZSpkYek/k34pSQX+2x5rsYWTakeK6gaGZTlT/7N23cfOy6aS03kLYVLjych4JV3dzlTStOTWi9BsgU1+Qgawtkbb8b0Oy7WiTVs0xmIQZ6AHRc5s7HpJ6PNnVmAJoP6YrXQFi2ibG1XfgAn2RdG7xHsp0nBW7IcM5H/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXUt/KnL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231282; x=1769767282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSDJ3F3koSrA0Iqp0ErSGMFZJet+A87xTcyf884hYLs=;
  b=UXUt/KnLhD59pg+09nQlMYnBIHBI1mGlNYtIIMWJ7EHZr2DS+K3eZJGk
   fn+BwurHS7qevoBJFyEgoiTmhgXZeGDCk9BzqLtLzH6TW+HLGIwydGwtI
   bwcgiDUhigJX61PJVlHekSD6aiBctg+rb5cNWa+mFQe0q9h09EMHkKe/4
   MGs3SneU5fdlZFRSTf2PaJAPX1whPVONqAIx/YCKzAznDjdS9DHrHP7R/
   livJOPd8OQ58thgpJ04Lhp+UqMn63lKJMbP44SWl1muajrKubguDyxDEx
   wrZPRzD3VrgYuy1JaxGj7FpIgZrBkzPut/k2BAd7RuUhaEAiLu4YZck2m
   Q==;
X-CSE-ConnectionGUID: cPMnkBnMTTuIrrqpwncQiA==
X-CSE-MsgGUID: tBK4CsMdTGKiqmFrABVP2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="49752473"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="49752473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:20 -0800
X-CSE-ConnectionGUID: /TQ93vBuTha3LJza9XOU3w==
X-CSE-MsgGUID: jYDt27dDQGi5SZd9YtqzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="109187924"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jan 2025 02:01:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DE129157; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 05/11] mm/truncate: Use folio_set_dropbehind() instead of deactivate_file_folio()
Date: Thu, 30 Jan 2025 12:00:43 +0200
Message-ID: <20250130100050.1868208-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently introduced PG_dropbehind allows for freeing folios
immediately after writeback. Unlike PG_reclaim, it does not need vmscan
to be involved to get the folio freed.

The new flag allows to replace whole deactivate_file_folio() machinery
with simple folio_set_dropbehind().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/internal.h |  1 -
 mm/swap.c     | 90 ---------------------------------------------------
 mm/truncate.c |  5 ++-
 3 files changed, 4 insertions(+), 92 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..93e6dac2077a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -379,7 +379,6 @@ static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
-void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
diff --git a/mm/swap.c b/mm/swap.c
index fc8281ef4241..7a0dffd5973a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -54,7 +54,6 @@ struct cpu_fbatches {
 	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
-	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
 #ifdef CONFIG_SMP
@@ -524,68 +523,6 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
 		folio_add_lru(folio);
 }
 
-/*
- * If the folio cannot be invalidated, it is moved to the
- * inactive list to speed up its reclaim.  It is moved to the
- * head of the list, rather than the tail, to give the flusher
- * threads some time to write it out, as this is much more
- * effective than the single-page writeout from reclaim.
- *
- * If the folio isn't mapped and dirty/writeback, the folio
- * could be reclaimed asap using the reclaim flag.
- *
- * 1. active, mapped folio -> none
- * 2. active, dirty/writeback folio -> inactive, head, reclaim
- * 3. inactive, mapped folio -> none
- * 4. inactive, dirty/writeback folio -> inactive, head, reclaim
- * 5. inactive, clean -> inactive, tail
- * 6. Others -> none
- *
- * In 4, it moves to the head of the inactive list so the folio is
- * written out by flusher threads as this is much more efficient
- * than the single-page writeout from reclaim.
- */
-static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
-{
-	bool active = folio_test_active(folio) || lru_gen_enabled();
-	long nr_pages = folio_nr_pages(folio);
-
-	if (folio_test_unevictable(folio))
-		return;
-
-	/* Some processes are using the folio */
-	if (folio_mapped(folio))
-		return;
-
-	lruvec_del_folio(lruvec, folio);
-	folio_clear_active(folio);
-	folio_clear_referenced(folio);
-
-	if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
-		/*
-		 * Setting the reclaim flag could race with
-		 * folio_end_writeback() and confuse readahead.  But the
-		 * race window is _really_ small and  it's not a critical
-		 * problem.
-		 */
-		lruvec_add_folio(lruvec, folio);
-		folio_set_reclaim(folio);
-	} else {
-		/*
-		 * The folio's writeback ended while it was in the batch.
-		 * We move that folio to the tail of the inactive list.
-		 */
-		lruvec_add_folio_tail(lruvec, folio);
-		__count_vm_events(PGROTATED, nr_pages);
-	}
-
-	if (active) {
-		__count_vm_events(PGDEACTIVATE, nr_pages);
-		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
-				     nr_pages);
-	}
-}
-
 static void lru_deactivate(struct lruvec *lruvec, struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
@@ -652,10 +589,6 @@ void lru_add_drain_cpu(int cpu)
 		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
 	}
 
-	fbatch = &fbatches->lru_deactivate_file;
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_deactivate_file);
-
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate);
@@ -667,28 +600,6 @@ void lru_add_drain_cpu(int cpu)
 	folio_activate_drain(cpu);
 }
 
-/**
- * deactivate_file_folio() - Deactivate a file folio.
- * @folio: Folio to deactivate.
- *
- * This function hints to the VM that @folio is a good reclaim candidate,
- * for example if its invalidation fails due to the folio being dirty
- * or under writeback.
- *
- * Context: Caller holds a reference on the folio.
- */
-void deactivate_file_folio(struct folio *folio)
-{
-	/* Deactivating an unevictable folio will not accelerate reclaim */
-	if (folio_test_unevictable(folio))
-		return;
-
-	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
-		return;
-
-	folio_batch_add_and_move(folio, lru_deactivate_file, true);
-}
-
 /*
  * folio_deactivate - deactivate a folio
  * @folio: folio to deactivate
@@ -772,7 +683,6 @@ static bool cpu_needs_drain(unsigned int cpu)
 	/* Check these in order of likelihood that they're not zero */
 	return folio_batch_count(&fbatches->lru_add) ||
 		folio_batch_count(&fbatches->lru_move_tail) ||
-		folio_batch_count(&fbatches->lru_deactivate_file) ||
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
 		folio_batch_count(&fbatches->lru_activate) ||
diff --git a/mm/truncate.c b/mm/truncate.c
index e2e115adfbc5..8efa4e325e54 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,7 +486,10 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			 * of interest and try to speed up its reclaim.
 			 */
 			if (!ret) {
-				deactivate_file_folio(folio);
+				if (!folio_test_unevictable(folio) &&
+				    !folio_mapped(folio))
+					folio_set_dropbehind(folio);
+
 				/* Likely in the lru cache of a remote CPU */
 				if (nr_failed)
 					(*nr_failed)++;
-- 
2.47.2


