Return-Path: <linux-fsdevel+bounces-39253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DBA11E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BF07A2F55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA830243852;
	Wed, 15 Jan 2025 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jv3yrw1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15224169E;
	Wed, 15 Jan 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933528; cv=none; b=Ph7/opBSROIWYZP1suyKUS2K/W9EVCbdbTccrWEpDLZXUU0rjFqsxCww+kxZN4GnfAcpLTManfUuOEkIe4mQQ4Py42tTgzYYmtQCmIK5dgphAeFJPgplpBQYaOuossIR82Sx95F6dgUWdCPVYJ8lML9ihwL6bBQfz7yUtWUzAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933528; c=relaxed/simple;
	bh=zy80qLdpxNB+wsWLFwR+1Pwxfqf8k1Y4He9PQtq4Feo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4/ayUJbA8nJ2ODLeFU6JMN5SShMk5aFaQbNxWETsMX5+KwHRmKmOiI50ykgP4qwFviLAKDO2D8iKot3cHtsk/cboR12z/8htqdfXxJgElarjojqJqbQH0hq+431I5eh7r8/DTLnUDuxrFx9yaaOTLy8iySm1DWBVM0hjyAQa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jv3yrw1u; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933526; x=1768469526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zy80qLdpxNB+wsWLFwR+1Pwxfqf8k1Y4He9PQtq4Feo=;
  b=Jv3yrw1uDe0BsHS5D7URTHCs2NJUVr+WflkYKgI1L7Y4cCOtVZIBnsw3
   apUH4Zt04WdLpyPg4lRxWdcVohDv61tJIAPOIaEIX5Qk1vMGv0/zqY6gR
   hapq6SywWsj6Cwiu1lwORWFQ87CrcCDJGxLyFip9CyD0tSoUl1QFub9B9
   FxjYqj3J+Fpf3ZQsf7/bX79F8YRIPfQVSCq7jgAu+CTUSPl2oHzVFf59a
   Vhf+CL7SXCCnuNCDzwl0T9EOERLIciJUDa4yv3APNEQ5CeijQ85Pv40Dn
   lwcOIBB62+PlPId9HzaNLOBvRA+LWc077YIVes8tvXqQ/cMOGpf836cg1
   w==;
X-CSE-ConnectionGUID: SvsN6nJ7TTCwZzSn28CjVw==
X-CSE-MsgGUID: ldpIgkRbRiupUY9vKxW/5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36540319"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36540319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:02 -0800
X-CSE-ConnectionGUID: uKZs4AquScymUYYHoD/EPw==
X-CSE-MsgGUID: 9mVe3DwCT3mvJbk9e9v9kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105153461"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 01:31:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D1F2D771; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 11/11] mm: Rename PG_dropbehind to PG_reclaim
Date: Wed, 15 Jan 2025 11:31:35 +0200
Message-ID: <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
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

Now as PG_reclaim is gone, its name can be reclaimed for better
use :)

Rename PG_dropbehind to PG_reclaim and rename all helpers around it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
 include/linux/mm_inline.h                 |  2 +-
 include/linux/page-flags.h                |  8 +++---
 include/linux/pagemap.h                   |  2 +-
 include/trace/events/mmflags.h            |  2 +-
 mm/filemap.c                              | 34 +++++++++++------------
 mm/migrate.c                              |  4 +--
 mm/readahead.c                            |  4 +--
 mm/swap.c                                 |  2 +-
 mm/truncate.c                             |  2 +-
 mm/vmscan.c                               | 22 +++++++--------
 mm/zswap.c                                |  2 +-
 12 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index c1724847c001..e543e6bfb093 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -329,7 +329,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio)) {
 			int ret;
 
-			folio_set_dropbehind(folio);
+			folio_set_reclaim(folio);
 			ret = mapping->a_ops->writepage(&folio->page, &wbc);
 			if (!ret)
 				goto put;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e5049a975579..9077ba15bc36 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -241,7 +241,7 @@ static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct foli
 	else if (reclaiming)
 		gen = MAX_NR_GENS;
 	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
-		 folio_test_dropbehind(folio))
+		 folio_test_reclaim(folio))
 		gen = MIN_NR_GENS;
 	else
 		gen = MAX_NR_GENS - folio_test_workingset(folio);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8f59fd8b86c9..f5a058761188 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,7 +110,7 @@ enum pageflags {
 	PG_readahead,
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
-	PG_dropbehind,		/* drop pages on IO completion */
+	PG_reclaim,		/* drop pages on IO completion */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -595,9 +595,9 @@ FOLIO_FLAG(mappedtodisk, FOLIO_HEAD_PAGE)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
-FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
-	FOLIO_TEST_CLEAR_FLAG(dropbehind, FOLIO_HEAD_PAGE)
-	__FOLIO_SET_FLAG(dropbehind, FOLIO_HEAD_PAGE)
+FOLIO_FLAG(reclaim, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(reclaim, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(reclaim, FOLIO_HEAD_PAGE)
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d0be5f36082a..72488f1c50bb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1371,7 +1371,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
-	bool dropbehind;
+	bool reclaim;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 15d92784a745..c635d97c4065 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -117,7 +117,7 @@
 	DEF_PAGEFLAG_NAME(readahead),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
-	DEF_PAGEFLAG_NAME(dropbehind)					\
+	DEF_PAGEFLAG_NAME(reclaim)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
diff --git a/mm/filemap.c b/mm/filemap.c
index 8951c37c8a38..92cec1dd9a6b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1590,11 +1590,11 @@ int folio_wait_private_2_killable(struct folio *folio)
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
 /*
- * If folio was marked as dropbehind, then pages should be dropped when writeback
+ * If folio was marked as reclaim, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
- * just reset dropbehind for that case and latter completions should invalidate.
+ * just reset reclaim for that case and latter completions should invalidate.
  */
-static void folio_end_dropbehind_write(struct folio *folio)
+static void folio_end_reclaim_write(struct folio *folio)
 {
 	/*
 	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
@@ -1620,7 +1620,7 @@ static void folio_end_dropbehind_write(struct folio *folio)
  */
 void folio_end_writeback(struct folio *folio)
 {
-	bool folio_dropbehind = false;
+	bool folio_reclaim = false;
 
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
@@ -1632,13 +1632,13 @@ void folio_end_writeback(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_test_dirty(folio))
-		folio_dropbehind = folio_test_clear_dropbehind(folio);
+		folio_reclaim = folio_test_clear_reclaim(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
 
-	if (folio_dropbehind)
-		folio_end_dropbehind_write(folio);
+	if (folio_reclaim)
+		folio_end_reclaim_write(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
@@ -1962,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
 			if (fgp_flags & FGP_DONTCACHE)
-				__folio_set_dropbehind(folio);
+				__folio_set_reclaim(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -1986,8 +1986,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 	if (!folio)
 		return ERR_PTR(-ENOENT);
 	/* not an uncached lookup, clear uncached if set */
-	if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE))
-		folio_clear_dropbehind(folio);
+	if (folio_test_reclaim(folio) && !(fgp_flags & FGP_DONTCACHE))
+		folio_clear_reclaim(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
@@ -2485,7 +2485,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	if (!folio)
 		return -ENOMEM;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
-		__folio_set_dropbehind(folio);
+		__folio_set_reclaim(folio);
 
 	/*
 	 * Protect against truncate / hole punch. Grabbing invalidate_lock
@@ -2532,7 +2532,7 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
-		ractl.dropbehind = 1;
+		ractl.reclaim = 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
@@ -2563,7 +2563,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
 		if (iocb->ki_flags & IOCB_DONTCACHE)
-			ractl.dropbehind = 1;
+			ractl.reclaim = 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
@@ -2611,15 +2611,15 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
-static void filemap_end_dropbehind_read(struct address_space *mapping,
+static void filemap_end_reclaim_read(struct address_space *mapping,
 					struct folio *folio)
 {
-	if (!folio_test_dropbehind(folio))
+	if (!folio_test_reclaim(folio))
 		return;
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
 		return;
 	if (folio_trylock(folio)) {
-		if (folio_test_clear_dropbehind(folio))
+		if (folio_test_clear_reclaim(folio))
 			folio_unmap_invalidate(mapping, folio, 0);
 		folio_unlock(folio);
 	}
@@ -2741,7 +2741,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			filemap_end_dropbehind_read(mapping, folio);
+			filemap_end_reclaim_read(mapping, folio);
 			folio_put(folio);
 		}
 		folio_batch_init(&fbatch);
diff --git a/mm/migrate.c b/mm/migrate.c
index 2bf9f08c4f84..72702e0607af 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -683,8 +683,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_dirty(newfolio);
 
 	/* TODO: free the folio on migration? */
-	if (folio_test_dropbehind(folio))
-		folio_set_dropbehind(newfolio);
+	if (folio_test_reclaim(folio))
+		folio_set_reclaim(newfolio);
 
 	if (folio_test_young(folio))
 		folio_set_young(newfolio);
diff --git a/mm/readahead.c b/mm/readahead.c
index 6a4e96b69702..73ec47a67708 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -184,8 +184,8 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 	struct folio *folio;
 
 	folio = filemap_alloc_folio(gfp_mask, order);
-	if (folio && ractl->dropbehind)
-		__folio_set_dropbehind(folio);
+	if (folio && ractl->reclaim)
+		__folio_set_reclaim(folio);
 
 	return folio;
 }
diff --git a/mm/swap.c b/mm/swap.c
index 96892a0d2491..6250e21e1a73 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -406,7 +406,7 @@ static bool lru_gen_clear_refs(struct folio *folio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
-	if (folio_test_dropbehind(folio))
+	if (folio_test_reclaim(folio))
 		return;
 	if (lru_gen_enabled()) {
 		lru_gen_inc_refs(folio);
diff --git a/mm/truncate.c b/mm/truncate.c
index 864aaadc1e91..37f94bc9fbd4 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			 * of interest and try to speed up its reclaim.
 			 */
 			if (!ret) {
-				folio_set_dropbehind(folio);
+				folio_set_reclaim(folio);
 				/* Likely in the lru cache of a remote CPU */
 				if (nr_failed)
 					(*nr_failed)++;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0b8a6e0f384c..11d503e9d079 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -692,13 +692,13 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 		if (shmem_mapping(mapping) && folio_test_large(folio))
 			wbc.list = folio_list;
 
-		folio_set_dropbehind(folio);
+		folio_set_reclaim(folio);
 
 		res = mapping->a_ops->writepage(&folio->page, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, folio, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
-			folio_clear_dropbehind(folio);
+			folio_clear_reclaim(folio);
 			return PAGE_ACTIVATE;
 		}
 
@@ -1140,7 +1140,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * for immediate reclaim are making it to the end of
 		 * the LRU a second time.
 		 */
-		if (writeback && folio_test_dropbehind(folio))
+		if (writeback && folio_test_reclaim(folio))
 			stat->nr_congested += nr_pages;
 
 		/*
@@ -1149,7 +1149,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 *
 		 * 1) If reclaim is encountering an excessive number
 		 *    of folios under writeback and this folio has both
-		 *    the writeback and dropbehind flags set, then it
+		 *    the writeback and reclaim flags set, then it
 		 *    indicates that folios are being queued for I/O but
 		 *    are being recycled through the LRU before the I/O
 		 *    can complete. Waiting on the folio itself risks an
@@ -1174,7 +1174,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 *    would probably show more reasons.
 		 *
 		 * 3) Legacy memcg encounters a folio that already has the
-		 *    dropbehind flag set. memcg does not have any dirty folio
+		 *    reclaim flag set. memcg does not have any dirty folio
 		 *    throttling so we could easily OOM just because too many
 		 *    folios are in writeback and there is nothing else to
 		 *    reclaim. Wait for the writeback to complete.
@@ -1193,17 +1193,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			/* Case 1 above */
 			if (current_is_kswapd() &&
-			    folio_test_dropbehind(folio) &&
+			    folio_test_reclaim(folio) &&
 			    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
 				stat->nr_immediate += nr_pages;
 				goto activate_locked;
 
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
-			    !folio_test_dropbehind(folio) ||
+			    !folio_test_reclaim(folio) ||
 			    !may_enter_fs(folio, sc->gfp_mask) ||
 			    (mapping && mapping_writeback_indeterminate(mapping))) {
-				folio_set_dropbehind(folio);
+				folio_set_reclaim(folio);
 				stat->nr_writeback += nr_pages;
 				goto activate_locked;
 
@@ -1235,7 +1235,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * Before reclaiming the folio, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass && !folio_test_dropbehind(folio) &&
+		if (do_demote_pass && !folio_test_reclaim(folio) &&
 		    (thp_migration_supported() || !folio_test_large(folio))) {
 			list_add(&folio->lru, &demote_folios);
 			folio_unlock(folio);
@@ -1358,7 +1358,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 */
 			if (folio_is_file_lru(folio) &&
 			    (!current_is_kswapd() ||
-			     !folio_test_dropbehind(folio) ||
+			     !folio_test_reclaim(folio) ||
 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
 				/*
 				 * Immediately reclaim when written back.
@@ -1368,7 +1368,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				 */
 				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
 						nr_pages);
-				folio_set_dropbehind(folio);
+				folio_set_reclaim(folio);
 
 				goto activate_locked;
 			}
diff --git a/mm/zswap.c b/mm/zswap.c
index c20bad0b0978..2d02336ea839 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1097,7 +1097,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_mark_uptodate(folio);
 
 	/* free the folio after writeback */
-	folio_set_dropbehind(folio);
+	folio_set_reclaim(folio);
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-- 
2.45.2


