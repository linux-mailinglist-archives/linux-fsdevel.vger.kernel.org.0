Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD43342CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhCJQOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhCJQOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:14:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFFC061760;
        Wed, 10 Mar 2021 08:14:35 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so11698590pgm.9;
        Wed, 10 Mar 2021 08:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txDbp7Wx2vX6YjkhEkbwKwYgP5c1xPLVUUyDZKo4vU0=;
        b=RqZkiJOX3AzUZI0tbgk2ZL2AhsevK4JuBLj9cn+6ODa4Ec8DKsNAVu3OOcWPsBeAn+
         jfFLTa5qDcsP53lb9sX/+eYM2fVU+IGHtE36xW1v1HW9p1oS7ftygo5d9gmSkAFQEkwH
         lEONCRwxPVxtQ12E6VAsz1FiN7XXoMnrqQLfOrhFjt1SSH1SQ9pzIBHgGYM94yHLVniC
         AZ2eJSQj+5Kv9eA/ow6Qi413f+H+9qVltIPQFLCehT0dlVaTfW+ghQYvvpkK+PNo6sN8
         L3wsMig1XfKGIdQUXxTpHWNVBcOpOHHiY2Y+Y05XABIY7UmzKRE81/UK/C3GvEoWMxEX
         gRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=txDbp7Wx2vX6YjkhEkbwKwYgP5c1xPLVUUyDZKo4vU0=;
        b=gzxPG8SIkgok5IkbY/RjJ1ojZcHwsLLaVYO90bwCyCKEb7+Y5XZXGX/8hd7aFifWUK
         8v3jbX04TmK7JuMSybFahsFzMg0LpeDQvdXou+BdMwVqpnoAY3a0Ef1/NRR7U+wKwHke
         ai3iFQIbm8frwr+vYC6KldsTDEAbfznX8Hl/jpywPynJVKwcYGWRYPUP82MifGNwqM9P
         YkPRwKPKaGvnCpNKSIuM8co3jc9HgrKtmg3+gv6EEXj4L5KydqoVeWGxktAPiUIhiXZK
         4x28RuGFu7fOKC9tWb9j9YvtFuR1DwIemhIXnI4h6C4RvtKd5060Wj+22AeEETWM5thy
         C0BQ==
X-Gm-Message-State: AOAM5313pO73wPB9XPilh6cq3097ZWp69Rx0U+jUHeGrpBH2JOEazH1I
        lHsHgRQGaTKxbrEWNfsn/xE=
X-Google-Smtp-Source: ABdhPJyWcNFIgTYVyW1GyKn81RImjZdoe1yYrSeMfSwu8whqA4bM2QbmpiG4gnMx36igaAIn9kSfRQ==
X-Received: by 2002:a65:6642:: with SMTP id z2mr3380674pgv.214.1615392875014;
        Wed, 10 Mar 2021 08:14:35 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id d1sm7121189pjc.24.2021.03.10.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 08:14:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 1/3] mm: replace migrate_prep with lru_add_drain_all
Date:   Wed, 10 Mar 2021 08:14:27 -0800
Message-Id: <20210310161429.399432-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, migrate_prep is merely a wrapper of lru_cache_add_all.
There is not much to gain from having additional abstraction.

Use lru_add_drain_all instead of migrate_prep, which would be more
descriptive.

note: migrate_prep_local in compaction.c changed into lru_add_drain
to avoid CPU schedule cost with involving many other CPUs to keep
keep old behavior.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/migrate.h |  5 -----
 mm/compaction.c         |  3 ++-
 mm/mempolicy.c          |  4 ++--
 mm/migrate.c            | 24 +-----------------------
 mm/page_alloc.c         |  2 +-
 mm/swap.c               |  5 +++++
 6 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..6155d97ec76c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -45,8 +45,6 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
-extern void migrate_prep(void);
-extern void migrate_prep_local(void);
 extern void migrate_page_states(struct page *newpage, struct page *page);
 extern void migrate_page_copy(struct page *newpage, struct page *page);
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
@@ -66,9 +64,6 @@ static inline struct page *alloc_migration_target(struct page *page,
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
 
-static inline int migrate_prep(void) { return -ENOSYS; }
-static inline int migrate_prep_local(void) { return -ENOSYS; }
-
 static inline void migrate_page_states(struct page *newpage, struct page *page)
 {
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f4476e68e..3be017ececc0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2319,7 +2319,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
 				cc->free_pfn, end_pfn, sync);
 
-	migrate_prep_local();
+	/* lru_add_drain_all could be expensive with involving other CPUs */
+	lru_add_drain();
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ab51132547b8..fc024e97be37 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1124,7 +1124,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	int err = 0;
 	nodemask_t tmp;
 
-	migrate_prep();
+	lru_add_drain_all();
 
 	mmap_read_lock(mm);
 
@@ -1323,7 +1323,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 
-		migrate_prep();
+		lru_add_drain_all();
 	}
 	{
 		NODEMASK_SCRATCH(scratch);
diff --git a/mm/migrate.c b/mm/migrate.c
index 62b81d5257aa..45f925e10f5a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,28 +57,6 @@
 
 #include "internal.h"
 
-/*
- * migrate_prep() needs to be called before we start compiling a list of pages
- * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
- * undesirable, use migrate_prep_local()
- */
-void migrate_prep(void)
-{
-	/*
-	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
-	 */
-	lru_add_drain_all();
-}
-
-/* Do the necessary work of migrate_prep but not if it involves other CPUs */
-void migrate_prep_local(void)
-{
-	lru_add_drain();
-}
-
 int isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct address_space *mapping;
@@ -1769,7 +1747,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	migrate_prep();
+	lru_add_drain_all();
 
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e8348936df8..f05a8db741ca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8467,7 +8467,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
-	migrate_prep();
+	lru_add_drain_all();
 
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..441d1ae1f285 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -729,6 +729,11 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
 }
 
 /*
+ * lru_add_drain_all() usually needs to be called before we start compiling
+ * a list of pages to be migrated using isolate_lru_page(). Note that pages
+ * may be moved off the LRU after we have drained them. Those pages will
+ * fail to migrate like other pages that may be busy.
+ *
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
  * executed on the offlined cpu.
-- 
2.30.1.766.gb4fecdf3b7-goog

