Return-Path: <linux-fsdevel+bounces-39247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC423A11DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85D4165305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE056241694;
	Wed, 15 Jan 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/fe7ymH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E8248198;
	Wed, 15 Jan 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933522; cv=none; b=X8jIO/90jG1+9J7O5gbTucVgeLkdpR2LhLBn6avYSqvhVPOFo7SFB/qaGwjXUdxg/cINRfKrW/W1fgKzninmZyFHdK425WO1arONKMSXmqCZtf8TOL1Rd7ri0KRJxsCSNDHx/GhtyqK/UtTj7hE+itw8lXSij/PZ07C8FkvkUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933522; c=relaxed/simple;
	bh=36JNq/EXbfsIL2m0ifCEwxvDf1m9iaObLYkanVED3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8dMb+BanDFOtZ8sXyWYQ1swG/1O5uXbnOK/eQthRwSEFOWLo+JKQB9I84fu77ixpMrixxEPm+gTYxgdiEEDQNvOvkf72swTLIEh5oPHPE9UHbcNXMaIdl+FIvkNkV6kvR+iH8Ho2GA73boY7DMRD7xOqLfPHd5h5WFPTFIFPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/fe7ymH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933520; x=1768469520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36JNq/EXbfsIL2m0ifCEwxvDf1m9iaObLYkanVED3nU=;
  b=R/fe7ymHFdAIGQaNerlUf8MjIVqXRsbO4k4V3g/gSu5W/0aMuqzjGLG4
   t4TAy+reGVMyesfeRwd4f6Jir+YSGo6pOrCSRzXDWcGKMg23UeaYQokci
   URAtkNE3zY0QKWJxZfqlT8LuTGi8G00tKdwAws7N+6nE91tk6yVX96jjY
   7Pa0TuTlEMs2kPabBDaASknPdA3dr3SwH161f9T48J3JIW4cFV66QV6KH
   VrtZTiMWVkicq46uZPl7rwW0sGe7M2XVIcEcADP4pZCBogitaVE5qOsDV
   2CCagUpzG6KIL+zV3L5v/HZCb32j/gtr+Z+1Rezh5nFeXklWIHfJrL3OW
   Q==;
X-CSE-ConnectionGUID: oMaqi8enSZKEPiGxb74HMg==
X-CSE-MsgGUID: DMW9vJcvQM2EXaFPLYklLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195103"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195103"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:59 -0800
X-CSE-ConnectionGUID: 7uc6MvmlRc2uU/scJlj9/A==
X-CSE-MsgGUID: LSjikbJtRki8UuqJ5Zqd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700874"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 721904BE; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead of deactivate_file_folio()
Date: Wed, 15 Jan 2025 11:31:29 +0200
Message-ID: <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
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
 mm/truncate.c |  2 +-
 3 files changed, 1 insertion(+), 92 deletions(-)

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
index e2e115adfbc5..864aaadc1e91 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			 * of interest and try to speed up its reclaim.
 			 */
 			if (!ret) {
-				deactivate_file_folio(folio);
+				folio_set_dropbehind(folio);
 				/* Likely in the lru cache of a remote CPU */
 				if (nr_failed)
 					(*nr_failed)++;
-- 
2.45.2


