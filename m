Return-Path: <linux-fsdevel+bounces-39252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCDA11E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8257A06C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D724226A;
	Wed, 15 Jan 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTzZhyzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DD2416AA;
	Wed, 15 Jan 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933526; cv=none; b=CyW4tMsXL8PFhsTD/FBzSmf7RKLvxqYnFnOZAQOFy/VZfX4ieedxyHthVRuzrxYaXvWDkwhSrZkW70LSCduQd2pwO2MEYzeCptvfdp7YEK1fIoi4X5LPmtv6V/mXwDR7l/aHiBYNkpeU7/XUX22bQowVDDlf7Q8hDm7LzT2R38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933526; c=relaxed/simple;
	bh=qlcvUWkNXPs+I4sRu7nXXq1shN3OcaQUE+kllyJJ/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2FvbYNNcYZNGIzt43zZ0DX4Yvf+x4u8Q2MxrdgwqmmEuPYjSQ7aPDufxRgGYv/u5ALcfDvRbaFY2KFacOxghUkhoO+8M3Ig4ar025HzKDQTpRaQRmJZ0ca5Omp50ALD1gyYbPFF4axo4amfpEgBI5wge3MF2nm3+MGlAZeWp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTzZhyzF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933524; x=1768469524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlcvUWkNXPs+I4sRu7nXXq1shN3OcaQUE+kllyJJ/aA=;
  b=PTzZhyzFsOkPLNzsbE7WBAf+tcZiFAcwUX/2GFMxAnfCfBFWctp7wuvb
   vAX417hBg+fRfs/yVufH79800rctUU13n+Fo88NdqG/0OuNro4hVwLNoO
   t5Z/LRSKmEZXdMqyQv9zSz6jzWE906DbyexcMKuxaSCLXbsOu9dFgL4H3
   QKzfbiQBSkPtDsdUK8AV1TgAhSrSFk8YbLWg9/84s6eCSFmLg3mSMrkrW
   QPPl39GbZRiLUD5qp+h5CsVCTwFJXhV4yBnXe3AliQMLtLGIGZEw3P0TO
   iBkxmUFFhtWS6eAQw+9hyJNApDL04PT/28/WQn8k4PYmnCJHq/J/xIwM1
   w==;
X-CSE-ConnectionGUID: Tb7WpZM5QGGwpICv3w9ilg==
X-CSE-MsgGUID: WhCXhcZbRm+oa0J2R7EjAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36540288"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36540288"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:01 -0800
X-CSE-ConnectionGUID: GlVCCYhSTl+nFq5iyy7XmQ==
X-CSE-MsgGUID: ZyKi2pmcR/eEfP2pfD8jdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105153454"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B2EDD748; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 09/11] mm: Remove PG_reclaim
Date: Wed, 15 Jan 2025 11:31:33 +0200
Message-ID: <20250115093135.3288234-10-kirill.shutemov@linux.intel.com>
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

Nobody sets the flag anymore.

Remove the PG_reclaim, making PG_readhead exclusive user of the page
flag bit.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 fs/fuse/dev.c                          |  2 +-
 fs/proc/page.c                         |  2 +-
 include/linux/mm_inline.h              | 15 -------
 include/linux/page-flags.h             | 15 +++----
 include/trace/events/mmflags.h         |  2 +-
 include/uapi/linux/kernel-page-flags.h |  2 +-
 mm/filemap.c                           | 12 -----
 mm/migrate.c                           | 10 +----
 mm/page-writeback.c                    | 16 +------
 mm/page_io.c                           | 15 +++----
 mm/swap.c                              | 61 ++------------------------
 mm/vmscan.c                            |  7 ---
 tools/mm/page-types.c                  |  8 +---
 13 files changed, 22 insertions(+), 145 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..20005e2e1d28 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -827,7 +827,7 @@ static int fuse_check_folio(struct folio *folio)
 	       1 << PG_lru |
 	       1 << PG_active |
 	       1 << PG_workingset |
-	       1 << PG_reclaim |
+	       1 << PG_readahead |
 	       1 << PG_waiters |
 	       LRU_GEN_MASK | LRU_REFS_MASK))) {
 		dump_page(&folio->page, "fuse: trying to steal weird page");
diff --git a/fs/proc/page.c b/fs/proc/page.c
index a55f5acefa97..59860ba2393c 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -189,7 +189,7 @@ u64 stable_page_flags(const struct page *page)
 	u |= kpf_copy_bit(k, KPF_LRU,		PG_lru);
 	u |= kpf_copy_bit(k, KPF_REFERENCED,	PG_referenced);
 	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
-	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
+	u |= kpf_copy_bit(k, KPF_READAHEAD,	PG_readahead);
 
 #define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
 	if ((k & SWAPCACHE) == SWAPCACHE)
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f353d3c610ac..e5049a975579 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -270,7 +270,6 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
 
 	lru_gen_update_size(lruvec, folio, -1, gen);
-	/* for folio_rotate_reclaimable() */
 	if (reclaiming)
 		list_add_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 	else
@@ -349,20 +348,6 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 		list_add(&folio->lru, &lruvec->lists[lru]);
 }
 
-static __always_inline
-void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
-{
-	enum lru_list lru = folio_lru_list(folio);
-
-	if (lru_gen_add_folio(lruvec, folio, true))
-		return;
-
-	update_lru_size(lruvec, lru, folio_zonenum(folio),
-			folio_nr_pages(folio));
-	/* This is not expected to be used on LRU_UNEVICTABLE */
-	list_add_tail(&folio->lru, &lruvec->lists[lru]);
-}
-
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2414e7921eea..8f59fd8b86c9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -63,8 +63,8 @@
  * might lose their PG_swapbacked flag when they simply can be dropped (e.g. as
  * a result of MADV_FREE).
  *
- * PG_referenced, PG_reclaim are used for page reclaim for anonymous and
- * file-backed pagecache (see mm/vmscan.c).
+ * PG_referenced is used for page reclaim for anonymous and file-backed
+ * pagecache (see mm/vmscan.c).
  *
  * PG_arch_1 is an architecture specific page state bit.  The generic code
  * guarantees that this bit is cleared for a page when it first is entered into
@@ -107,7 +107,7 @@ enum pageflags {
 	PG_reserved,
 	PG_private,		/* If pagecache, has fs-private data */
 	PG_private_2,		/* If pagecache, has fs aux data */
-	PG_reclaim,		/* To be reclaimed asap */
+	PG_readahead,
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
 	PG_dropbehind,		/* drop pages on IO completion */
@@ -129,8 +129,6 @@ enum pageflags {
 #endif
 	__NR_PAGEFLAGS,
 
-	PG_readahead = PG_reclaim,
-
 	/* Anonymous memory (and shmem) */
 	PG_swapcache = PG_owner_priv_1, /* Swap page: swp_entry_t in private */
 	/* Some filesystems */
@@ -168,7 +166,7 @@ enum pageflags {
 	PG_xen_remapped = PG_owner_priv_1,
 
 	/* non-lru isolated movable page */
-	PG_isolated = PG_reclaim,
+	PG_isolated = PG_readahead,
 
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
@@ -187,7 +185,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
-	PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
+	PG_partially_mapped = PG_readahead, /* was identified to be partially mapped */
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -594,9 +592,6 @@ TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
 	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
 FOLIO_FLAG(mappedtodisk, FOLIO_HEAD_PAGE)
 
-/* PG_readahead is only used for reads; PG_reclaim is only for writes */
-PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
-	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 3bc8656c8359..15d92784a745 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -114,7 +114,7 @@
 	DEF_PAGEFLAG_NAME(private_2),					\
 	DEF_PAGEFLAG_NAME(writeback),					\
 	DEF_PAGEFLAG_NAME(head),					\
-	DEF_PAGEFLAG_NAME(reclaim),					\
+	DEF_PAGEFLAG_NAME(readahead),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable),					\
 	DEF_PAGEFLAG_NAME(dropbehind)					\
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index ff8032227876..e5a9a113e079 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -15,7 +15,7 @@
 #define KPF_ACTIVE		6
 #define KPF_SLAB		7
 #define KPF_WRITEBACK		8
-#define KPF_RECLAIM		9
+#define KPF_READAHEAD		9
 #define KPF_BUDDY		10
 
 /* 11-20: new additions in 2.6.31 */
diff --git a/mm/filemap.c b/mm/filemap.c
index 5ca26f5e7238..8951c37c8a38 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1624,18 +1624,6 @@ void folio_end_writeback(struct folio *folio)
 
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
-	/*
-	 * folio_test_clear_reclaim() could be used here but it is an
-	 * atomic operation and overkill in this particular case. Failing
-	 * to shuffle a folio marked for immediate reclaim is too mild
-	 * a gain to justify taking an atomic operation penalty at the
-	 * end of every folio writeback.
-	 */
-	if (folio_test_reclaim(folio)) {
-		folio_clear_reclaim(folio);
-		folio_rotate_reclaimable(folio);
-	}
-
 	/*
 	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
diff --git a/mm/migrate.c b/mm/migrate.c
index 690efa064bee..2bf9f08c4f84 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -690,6 +690,8 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_young(newfolio);
 	if (folio_test_idle(folio))
 		folio_set_idle(newfolio);
+	if (folio_test_readahead(folio))
+		folio_set_readahead(newfolio);
 
 	folio_migrate_refs(newfolio, folio);
 	/*
@@ -732,14 +734,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	if (folio_test_writeback(newfolio))
 		folio_end_writeback(newfolio);
 
-	/*
-	 * PG_readahead shares the same bit with PG_reclaim.  The above
-	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
-	 * bit after that.
-	 */
-	if (folio_test_readahead(folio))
-		folio_set_readahead(newfolio);
-
 	folio_copy_owner(newfolio, folio);
 	pgalloc_tag_swap(newfolio, folio);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4f5970723cf2..f2b94a2cbfcf 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2888,22 +2888,8 @@ bool folio_mark_dirty(struct folio *folio)
 {
 	struct address_space *mapping = folio_mapping(folio);
 
-	if (likely(mapping)) {
-		/*
-		 * readahead/folio_deactivate could remain
-		 * PG_readahead/PG_reclaim due to race with folio_end_writeback
-		 * About readahead, if the folio is written, the flags would be
-		 * reset. So no problem.
-		 * About folio_deactivate, if the folio is redirtied,
-		 * the flag will be reset. So no problem. but if the
-		 * folio is used by readahead it will confuse readahead
-		 * and make it restart the size rampup process. But it's
-		 * a trivial problem.
-		 */
-		if (folio_test_reclaim(folio))
-			folio_clear_reclaim(folio);
+	if (likely(mapping))
 		return mapping->a_ops->dirty_folio(mapping, folio);
-	}
 
 	return noop_dirty_folio(mapping, folio);
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..0cb71f318fb1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -37,14 +37,11 @@ static void __end_swap_bio_write(struct bio *bio)
 		 * Re-dirty the page in order to avoid it being reclaimed.
 		 * Also print a dire warning that things will go BAD (tm)
 		 * very quickly.
-		 *
-		 * Also clear PG_reclaim to avoid folio_rotate_reclaimable()
 		 */
 		folio_mark_dirty(folio);
 		pr_alert_ratelimited("Write-error on swap-device (%u:%u:%llu)\n",
 				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
 				     (unsigned long long)bio->bi_iter.bi_sector);
-		folio_clear_reclaim(folio);
 	}
 	folio_end_writeback(folio);
 }
@@ -350,19 +347,17 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 
 	if (ret != sio->len) {
 		/*
-		 * In the case of swap-over-nfs, this can be a
-		 * temporary failure if the system has limited
-		 * memory for allocating transmit buffers.
-		 * Mark the page dirty and avoid
-		 * folio_rotate_reclaimable but rate-limit the
-		 * messages.
+		 * In the case of swap-over-nfs, this can be a temporary failure
+		 * if the system has limited memory for allocating transmit
+		 * buffers.
+		 *
+		 * Mark the page dirty but rate-limit the messages.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
 				   ret, swap_dev_pos(page_swap_entry(page)));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
-			ClearPageReclaim(page);
 		}
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index 7a0dffd5973a..96892a0d2491 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -59,14 +59,10 @@ struct cpu_fbatches {
 #ifdef CONFIG_SMP
 	struct folio_batch lru_activate;
 #endif
-	/* Protecting the following batches which require disabling interrupts */
-	local_lock_t lock_irq;
-	struct folio_batch lru_move_tail;
 };
 
 static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
 	.lock = INIT_LOCAL_LOCK(lock),
-	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
 };
 
 static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
@@ -175,29 +171,20 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
-		struct folio *folio, move_fn_t move_fn,
-		bool on_lru, bool disable_irq)
+		struct folio *folio, move_fn_t move_fn, bool on_lru)
 {
-	unsigned long flags;
-
 	if (on_lru && !folio_test_clear_lru(folio))
 		return;
 
 	folio_get(folio);
 
-	if (disable_irq)
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-	else
-		local_lock(&cpu_fbatches.lock);
+	local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
 	    lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
-	if (disable_irq)
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
-	else
-		local_unlock(&cpu_fbatches.lock);
+	local_unlock(&cpu_fbatches.lock);
 }
 
 #define folio_batch_add_and_move(folio, op, on_lru)						\
@@ -205,37 +192,9 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		&cpu_fbatches.op,								\
 		folio,										\
 		op,										\
-		on_lru,										\
-		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
+		on_lru										\
 	)
 
-static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
-{
-	if (folio_test_unevictable(folio))
-		return;
-
-	lruvec_del_folio(lruvec, folio);
-	folio_clear_active(folio);
-	lruvec_add_folio_tail(lruvec, folio);
-	__count_vm_events(PGROTATED, folio_nr_pages(folio));
-}
-
-/*
- * Writeback is about to end against a folio which has been marked for
- * immediate reclaim.  If it still appears to be reclaimable, move it
- * to the tail of the inactive list.
- *
- * folio_rotate_reclaimable() must disable IRQs, to prevent nasty races.
- */
-void folio_rotate_reclaimable(struct folio *folio)
-{
-	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
-	    folio_test_unevictable(folio))
-		return;
-
-	folio_batch_add_and_move(folio, lru_move_tail, true);
-}
-
 void lru_note_cost(struct lruvec *lruvec, bool file,
 		   unsigned int nr_io, unsigned int nr_rotated)
 {
@@ -578,17 +537,6 @@ void lru_add_drain_cpu(int cpu)
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_add);
 
-	fbatch = &fbatches->lru_move_tail;
-	/* Disabling interrupts below acts as a compiler barrier. */
-	if (data_race(folio_batch_count(fbatch))) {
-		unsigned long flags;
-
-		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-		folio_batch_move_lru(fbatch, lru_move_tail);
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
-	}
-
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate);
@@ -682,7 +630,6 @@ static bool cpu_needs_drain(unsigned int cpu)
 
 	/* Check these in order of likelihood that they're not zero */
 	return folio_batch_count(&fbatches->lru_add) ||
-		folio_batch_count(&fbatches->lru_move_tail) ||
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
 		folio_batch_count(&fbatches->lru_activate) ||
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bb5ec22f97b5..e61e88e63511 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3216,9 +3216,6 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 
 		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_FLAGS);
 		new_flags |= (new_gen + 1UL) << LRU_GEN_PGOFF;
-		/* for folio_end_writeback() */
-		if (reclaiming)
-			new_flags |= BIT(PG_reclaim);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 
 	lru_gen_update_size(lruvec, folio, old_gen, new_gen);
@@ -4460,9 +4457,6 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 	if (!folio_test_referenced(folio))
 		set_mask_bits(&folio->flags, LRU_REFS_MASK, 0);
 
-	/* for shrink_folio_list() */
-	folio_clear_reclaim(folio);
-
 	success = lru_gen_del_folio(lruvec, folio, true);
 	VM_WARN_ON_ONCE_FOLIO(!success, folio);
 
@@ -4659,7 +4653,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 			continue;
 		}
 
-		/* retry folios that may have missed folio_rotate_reclaimable() */
 		if (!skip_retry && !folio_test_active(folio) && !folio_mapped(folio) &&
 		    !folio_test_dirty(folio) && !folio_test_writeback(folio)) {
 			list_move(&folio->lru, &clean);
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index bcac7ebfb51f..c06647501370 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -85,7 +85,6 @@
  * not part of kernel API
  */
 #define KPF_ANON_EXCLUSIVE	47
-#define KPF_READAHEAD		48
 #define KPF_SLUB_FROZEN		50
 #define KPF_SLUB_DEBUG		51
 #define KPF_FILE		61
@@ -108,7 +107,7 @@ static const char * const page_flag_names[] = {
 	[KPF_ACTIVE]		= "A:active",
 	[KPF_SLAB]		= "S:slab",
 	[KPF_WRITEBACK]		= "W:writeback",
-	[KPF_RECLAIM]		= "I:reclaim",
+	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_BUDDY]		= "B:buddy",
 
 	[KPF_MMAP]		= "M:mmap",
@@ -139,7 +138,6 @@ static const char * const page_flag_names[] = {
 	[KPF_ARCH_2]		= "H:arch_2",
 
 	[KPF_ANON_EXCLUSIVE]	= "d:anon_exclusive",
-	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_SLUB_FROZEN]	= "A:slub_frozen",
 	[KPF_SLUB_DEBUG]	= "E:slub_debug",
 
@@ -484,10 +482,6 @@ static uint64_t expand_overloaded_flags(uint64_t flags, uint64_t pme)
 			flags ^= BIT(ERROR) | BIT(SLUB_DEBUG);
 	}
 
-	/* PG_reclaim is overloaded as PG_readahead in the read path */
-	if ((flags & (BIT(RECLAIM) | BIT(WRITEBACK))) == BIT(RECLAIM))
-		flags ^= BIT(RECLAIM) | BIT(READAHEAD);
-
 	if (pme & PM_SOFT_DIRTY)
 		flags |= BIT(SOFTDIRTY);
 	if (pme & PM_FILE)
-- 
2.45.2


