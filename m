Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657B24354F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhJTVKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJTVKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1232C061749;
        Wed, 20 Oct 2021 14:08:03 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h193so8235557pgc.1;
        Wed, 20 Oct 2021 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+z3eqMMzfIzuQ+RxCtglmKOkopke5dWPRTwRSWvGk8M=;
        b=EGNgpiaPYuKu4blYXfkF9jcPhXsXCgWMU1/oXkPYQ7X0sO7X4V7TVnk+McRzdFnyKs
         1EUqXDtT545PvfghAsMn2Pyfc3BHzldadTRrAqV6ZGJpjqt9qEwfP4CF/Ush7d9Q0o9+
         c4RDPRkKNA5/PyY3q3JDTS56eLQ6GbyKj2r8b9cUGzDXgYHf758ANLJ+J9Wkyeg8vUlU
         GOmbu9+SWnVngpoSSLFjiyjz9VxbK5xo7DuNFGyjd0VQNtg6oZ6rce+beUvp2b0wgVB8
         S2aGrMMfzzSoDkaYNw0GOLxLM/7u1I3hay49xmETyn8EC3wvywGjs36eaPoz7lQ4lEUB
         z3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+z3eqMMzfIzuQ+RxCtglmKOkopke5dWPRTwRSWvGk8M=;
        b=JuvoaqbeanJjKgl1v4YeNsSPujg4DUlpFHmKogY5Jgq2+e1sCS+MAyUtjk3xXE+tKn
         Oi++WDJyKwltXydkn5nI8ykJkm2Cn1VqCL8dWVr8Z0JgxHYaZNoLiuUv6jh3ljhHEYDQ
         SynpMc+tdfFqATa/VpqqHXVIazqQy8iGF4Wud5BwU3oIgVS0XPukWc8iSY52iKX7waaa
         7XaUrHWq91ZrNTirPg+zWeTg6cmqPGHnU3Wp1ZTEXLEjBvY7y7f6uLKB2vmW/aezu6GJ
         xSGcx5YfMdEceR3oUKQq4iEXoRL/6P9ZlYgelie4NywzLQwPzRa9JNxxtgpqkyf6GN5/
         NIiA==
X-Gm-Message-State: AOAM530CMcup2B3SyzMaUr+FZY9DXrKQ6tozVRSP6dLtx91RViL0kygl
        CmWRMyOjywCBaSvjIXhERYM=
X-Google-Smtp-Source: ABdhPJxNe3glBHdLRuDeDelEYzph3hnzhGzpZQbWSceE2Nsph+7DVmq6c2iwNuR4QwEsWO6hFrra5A==
X-Received: by 2002:aa7:8f12:0:b0:44c:833f:9dad with SMTP id x18-20020aa78f12000000b0044c833f9dadmr1119155pfr.35.1634764083078;
        Wed, 20 Oct 2021 14:08:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id i8sm3403143pfo.117.2021.10.20.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:02 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 2/6] mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
Date:   Wed, 20 Oct 2021 14:07:51 -0700
Message-Id: <20211020210755.23964-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211020210755.23964-1-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
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

In the regular fault path the THP could be PMD mapped as long as the corrupted
page is not accessed and the VMA fits.

This loophole could be fixed by iterating every subpage to check if any
of them is hwpoisoned or not, but it is somewhat costly in page fault path.

So introduce a new page flag called HasHWPoisoned on the first tail page.  It
indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
is found hwpoisoned by memory failure and after the refcount is bumped
successfully, then cleared when the THP is freed or split.

The soft offline path doesn't need this since soft offline handler just
marks a subpage hwpoisoned when the subpage is migrated successfully.
But shmem THP didn't get split then migrated at all.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Cc: <stable@vger.kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/page-flags.h | 23 +++++++++++++++++++++++
 mm/huge_memory.c           |  2 ++
 mm/memory-failure.c        | 14 ++++++++++++++
 mm/memory.c                |  9 +++++++++
 mm/page_alloc.c            |  4 +++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a558d67ee86f..fbfd3fad48f2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -171,6 +171,15 @@ enum pageflags {
 	/* Compound pages. Stored in first tail page's flags */
 	PG_double_map = PG_workingset,
 
+#ifdef CONFIG_MEMORY_FAILURE
+	/*
+	 * Compound pages. Stored in first tail page's flags.
+	 * Indicates that at least one subpage is hwpoisoned in the
+	 * THP.
+	 */
+	PG_has_hwpoisoned = PG_mappedtodisk,
+#endif
+
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
 
@@ -668,6 +677,20 @@ PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
 #endif
 
+#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+/*
+ * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the
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
index 73f68699e7ab..bdbbb32211a5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1694,6 +1694,20 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
+		/*
+		 * The flag must be set after the refcount is bumped
+		 * otherwise it may race with THP split.
+		 * And the flag can't be set in get_hwpoison_page() since
+		 * it is called by soft offline too and it is just called
+		 * for !MF_COUNT_INCREASE.  So here seems to be the best
+		 * place.
+		 *
+		 * Don't need care about the above error handling paths for
+		 * get_hwpoison_page() since they handle either free page
+		 * or unhandlable page.  The refcount is bumped iff the
+		 * page is a valid handlable page.
+		 */
+		SetPageHasHWPoisoned(hpage);
 		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			res = -EBUSY;
diff --git a/mm/memory.c b/mm/memory.c
index adf9b9ef8277..c52be6d6b605 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3906,6 +3906,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
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

