Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD8415600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhIWDaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhIWDaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:30:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3CC061574;
        Wed, 22 Sep 2021 20:28:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so3112083pls.6;
        Wed, 22 Sep 2021 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L73Wo9W9HNFfCQZNH7vnv7PBAtWSuL4iMpzvZ9oV57A=;
        b=DlhRfef0wm9RQIHDUoMltF6Fl1ae/QjMynQtiQjkBy7RSWyZZ1FQsfpHu1K/OjWrwD
         lC40P+9KDlG4G/slC65tKyQJl1UjINgwibzZpFm/z4hZjNat7i9MMhdQVe3UN/XaJniU
         qjMl6k7jJYNjwRv/8+GOjkxJri1K3X3ABCoZtl4TKb/+2ORx5WXlnHHfiTjRmhB93Zt+
         omyAIKPUhRg2yVdwIKmdT/QI0F1hTZJgkShXU0Q7pf8TVqZIRDnEpg93c4b6soLHJ1Vt
         dD7gLYMe3fPzVfZPi6MVhhfEliC9AN8DeH1krSrPtC7yWBlPFS0xKiC4+wCQd0ADE5fm
         QA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L73Wo9W9HNFfCQZNH7vnv7PBAtWSuL4iMpzvZ9oV57A=;
        b=D663c4IR/wtvLsm3ZQOAUQPZXyD7GmQ5almXuZNUGInA3Cet5PtYW7OP0rv9G95rIg
         JVIXvYLdRMz2nYfmEI1UMzPJeQdQiZMmOW7nPrEA7y1aSzRx4iqUJglHeJBc5AzmhhVq
         waj6S9dWjIhEO6hABd+5qFI7BDQedhjrX2j2UIsd1/bZtf/hct0XO4QIY96Ge/1q0TGw
         IShu4FmXI03+uXHw21Z2/05Dt73rL4ECooC8mhZiqGn7UCcMwwh8t4v6cmIKPLrGorL7
         q0ounXCVXwGdDIKg1iWXHNOCyI7HwpkJePduwVZEDr07L37IZbDuRsST5aXbkC+QNdzo
         LlBw==
X-Gm-Message-State: AOAM533d1t8C+uO+6bESqOYduYYcJuR8Q2TqCue6WyfMnTxrf8gQjtZD
        dEV0Wgp+SpPqtvlS8IqAQf0=
X-Google-Smtp-Source: ABdhPJw/Wx92TTkQLGU1qB4d4XVgn8HofDtq+ukKz/VKsQP0awUfmDTEQnQhjCW0uiBL5mjGlOYGeA==
X-Received: by 2002:a17:902:b410:b0:13a:3f4a:db58 with SMTP id x16-20020a170902b41000b0013a3f4adb58mr2239986plr.12.1632367729074;
        Wed, 22 Sep 2021 20:28:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x8sm3699696pfq.131.2021.09.22.20.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:28:48 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/5] mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
Date:   Wed, 22 Sep 2021 20:28:26 -0700
Message-Id: <20210923032830.314328-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210923032830.314328-1-shy828301@gmail.com>
References: <20210923032830.314328-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When handling shmem page fault the THP with corrupted subpage could be PMD
mapped if certain conditions are satisfied.  But kernel is supposed to
send SIGBUS when trying to map hwpoisoned page.

There are two paths which may do PMD map: fault around and regular fault.

Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
the thing was even worse in fault around path.  The THP could be PMD mapped as
long as the VMA fits regardless what subpage is accessed and corrupted.  After
this commit as long as head page is not corrupted the THP could be PMD mapped.

In the regulat fault path the THP could be PMD mapped as long as the corrupted
page is not accessed and the VMA fits.

This loophole could be fixed by iterating every subpage to check if any
of them is hwpoisoned or not, but it is somewhat costly in page fault path.

So introduce a new page flag called HasHWPoisoned on the first tail page.  It
indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
is found hwpoisoned by memory failure and cleared when the THP is freed or
split.

Cc: <stable@vger.kernel.org>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/page-flags.h | 19 +++++++++++++++++++
 mm/filemap.c               | 15 +++++++++------
 mm/huge_memory.c           |  2 ++
 mm/memory-failure.c        |  4 ++++
 mm/memory.c                |  9 +++++++++
 mm/page_alloc.c            |  4 +++-
 6 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a558d67ee86f..a357b41b3057 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -171,6 +171,11 @@ enum pageflags {
 	/* Compound pages. Stored in first tail page's flags */
 	PG_double_map = PG_workingset,
 
+#ifdef CONFIG_MEMORY_FAILURE
+	/* Compound pages. Stored in first tail page's flags */
+	PG_has_hwpoisoned = PG_mappedtodisk,
+#endif
+
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
 
@@ -668,6 +673,20 @@ PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
 #endif
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+/*
+ * PageHasPoisoned indicates that at least on subpage is hwpoisoned in the
+ * compound page.
+ *
+ * This flag is set by hwpoison handler.  Cleared by THP split or free page.
+ */
+PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
+	TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
+#else
+PAGEFLAG_FALSE(HasHWPoisoned)
+	TESTSCFLAG_FALSE(HasHWPoisoned)
+#endif
+
 /*
  * Check if a page is currently marked HWPoisoned. Note that this check is
  * best effort only and inherently racy: there is no way to synchronize with
diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..740b7afe159a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	}
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (ret == VM_FAULT_FALLBACK)
+			goto out;
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
 	if (pmd_none(*vmf->pmd)) {
@@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 		return true;
 	}
 
+out:
 	return false;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..0574b1613714 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
 	lruvec = lock_page_lruvec(head);
 
+	ClearPageHasHWPoisoned(head);
+
 	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond EOF: drop them from page cache */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 54879c339024..93ae0ce90ab8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1663,6 +1663,10 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	orig_head = hpage = compound_head(p);
+
+	if (PageTransHuge(hpage))
+		SetPageHasHWPoisoned(orig_head);
+
 	num_poisoned_pages_inc();
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..738f4e1df81e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3905,6 +3905,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (compound_order(page) != HPAGE_PMD_ORDER)
 		return ret;
 
+	/*
+	 * Just backoff if any subpage of a THP is corrupted otherwise
+	 * the corrupted page may mapped by PMD silently to escape the
+	 * check.  This kind of THP just can be PTE mapped.  Access to
+	 * the corrupted subpage should trigger SIGBUS as expected.
+	 */
+	if (unlikely(PageHasHWPoisoned(page)))
+		return ret;
+
 	/*
 	 * Archs like ppc64 need additional space to store information
 	 * related to pte entry. Use the preallocated table for that.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..7f37652f0287 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1312,8 +1312,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
 
-		if (compound)
+		if (compound) {
 			ClearPageDoubleMap(page);
+			ClearPageHasHWPoisoned(page);
+		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-- 
2.26.2

