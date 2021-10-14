Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3242E1E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhJNTSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhJNTSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388EC061753;
        Thu, 14 Oct 2021 12:16:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so5513519pji.2;
        Thu, 14 Oct 2021 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ldZhZ/xGIfJYUf6/yA/00RetTvsboOkml6EMWF3tVw=;
        b=G0StEhfsWMSyljCgqxjt+sPEKNzC3ovrYL+Zbp8T3hCaCP/0qlzrXPGY8yCCUhEYOF
         OPtz8XKdl8gDReolESfk3KTQRhJnAliY8Vi2E+iuvWwNZrhzajmnBPbJO6OzgNMXunR9
         N01R7tDioO5UI3g2CEvf8CWsjOyO+qajmz1qjvv379m+8VxFIGgjKyOhS8Zfp6M9jJ6v
         3/dxpvKlP8MmSTshSZXCX7YplwYTcbrS+sVvP+XuseYtjIgpAfWbiUvBhD+eIXo1V+YC
         qSOThp074JUkbt5/xlxvEKQ6pRDlLQEBxEW66inOSpIUgZy90cxVDyJZakUi9fTxgxJD
         voIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ldZhZ/xGIfJYUf6/yA/00RetTvsboOkml6EMWF3tVw=;
        b=O+p/ytCs80BQnddTLr2ygeC3hh29n4XFq9gpTVAqbVvjzwEq5Ru8o7/s+1yBmsLbJJ
         y3vzqPn9Lt4/gwYmBFHO8cpGSKUZac374R44/O3GyqDfpDkWqUxAc1SzXGsJb96Nbj6u
         sbO2sSbBIDeHt0J7uw3i5CBycKNWuyuOA8aNmI3DxptwEOW7ZvetLPZpTBV/6uHUjevv
         gUQ7OToOjr/dJ4AXO+f8kCX6FLs3/nZETwdHa3qU21am4szo4k3AGChhhg0tFdazdsmS
         41q9Mlj15x7YFBtbe2G4v+7Ri5Gyr4l+XKmV/3klP3TafHEBJyWFThHk23r3EtPRMtqN
         xihA==
X-Gm-Message-State: AOAM53299FhqkGKlhO5r7wVjiXAfOaKZ+qprO4OMxBSdhTnkArADaOho
        EyaEU+F9zrDpTaEjIxLQroY=
X-Google-Smtp-Source: ABdhPJzPyliaZ4MNS86oiwCRYgBarOd8I5WqbtdGAqHBV/uWURAcpkynOQOJ12Vp4US/Kqa0BcWeFA==
X-Received: by 2002:a17:90a:c70d:: with SMTP id o13mr22491506pjt.143.1634238986231;
        Thu, 14 Oct 2021 12:16:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:25 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/6] mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
Date:   Thu, 14 Oct 2021 12:16:11 -0700
Message-Id: <20211014191615.6674-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
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
index a558d67ee86f..901723d75677 100644
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
+ * PageHasHWPoisoned indicates that at least on subpage is hwpoisoned in the
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
index 73f68699e7ab..2809d12f16af 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1694,6 +1694,20 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
+		/*
+		 * The flag must be set after the refcount is bumpped
+		 * otherwise it may race with THP split.
+		 * And the flag can't be set in get_hwpoison_page() since
+		 * it is called by soft offline too and it is just called
+		 * for !MF_COUNT_INCREASE.  So here seems to be the best
+		 * place.
+		 *
+		 * Don't need care about the above error handling paths for
+		 * get_hwpoison_page() since they handle either free page
+		 * or unhandlable page.  The refcount is bumpped iff the
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

