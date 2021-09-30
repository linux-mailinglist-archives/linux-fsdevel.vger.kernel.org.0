Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8741E383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 23:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbhI3VzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbhI3VzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:55:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A7FC06176D;
        Thu, 30 Sep 2021 14:53:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id me1so5138015pjb.4;
        Thu, 30 Sep 2021 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0G7c4LhSRNiug469gqOVXc04H0fSoJM9Qw97+kE9Ts=;
        b=eFmxGV3bchn1BICobO1NnIZdYcBe58nEf/iELJBeCWqx+fsviFRsH93Ayp7NAWyNUD
         jIMSKA1q2vGcPrglfM3speGFsp6hDmYykDb1RMRHRdFkH9j2lu2O7SqGzN7RWu4kR5NS
         QYuDVPsO+Dqvq/A2zRp+4PHxT2OukGk6zxdVk64iugobN7Mj1Hq+DnJX+ry9iA7ejhIj
         FHrIzrvu8OzGoyPLmmjUQihNwrSATqDYAxyGN4VRuzymxTtpwZDjR+aT6En0bQVV6SZJ
         r1vYJlUEABF0LBWD9W7PJg8SNj1DJ7MEPsX6MxaEXdD+30p98DroDTrHqnc7Ro2/7GvE
         5h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0G7c4LhSRNiug469gqOVXc04H0fSoJM9Qw97+kE9Ts=;
        b=MaNAb3ULNB9XMEVGNmoGVtpLU8mdQKsLrT2y8RQZQuKar12jednVHWtrXA30c+exox
         Lj9qAE2wOGhrqq5R5F74f3iHJywdNSBtRIblQbj4zZLvSZ1EduRy2VNU3qoYpe59RpVJ
         YWaq8aeLnUeUOP2yAb3+ZkZv7cS1CrOJ7qTlokPaR5JXrIQ8Gvj80ea2149aPtuSDzrK
         BYXDTaBNjCtbwtW+czgvUVNiXVdbxTDJC8nYDIWHWe4/Vubpni1PgRe+qYRbX1yJ5huS
         ConqU+dXU5AQpQ416HAufNBxNoV51KL+A05u/c3WSKF9OiwheBebzXR6B6zM6x/yRysJ
         xTHA==
X-Gm-Message-State: AOAM533x7tLnkCoD3L74EZSbH0EpvzOAbgVALQFx+xOYT1CIlel3rI2k
        5r2nbTVL+BZqUhd1gQ1kk58=
X-Google-Smtp-Source: ABdhPJwhI2byiEFnBzgAZYP6i3J1aHhDP3W/uCSEfbEU6YqlBJpNfrBIWGov9VljG1ZkgE14gyVrqQ==
X-Received: by 2002:a17:902:ab8c:b0:13a:22d1:88d with SMTP id f12-20020a170902ab8c00b0013a22d1088dmr7446550plr.33.1633038800317;
        Thu, 30 Sep 2021 14:53:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p17sm5647535pjg.54.2021.09.30.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 14:53:19 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
Date:   Thu, 30 Sep 2021 14:53:08 -0700
Message-Id: <20210930215311.240774-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930215311.240774-1-shy828301@gmail.com>
References: <20210930215311.240774-1-shy828301@gmail.com>
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
is found hwpoisoned by memory failure and cleared when the THP is freed or
split.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Cc: <stable@vger.kernel.org>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/page-flags.h | 19 +++++++++++++++++++
 mm/filemap.c               | 12 ++++++------
 mm/huge_memory.c           |  2 ++
 mm/memory-failure.c        |  6 +++++-
 mm/memory.c                |  9 +++++++++
 mm/page_alloc.c            |  4 +++-
 6 files changed, 44 insertions(+), 8 deletions(-)

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
index dae481293b5d..2acc2b977f66 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	}
 
 	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
-	    vm_fault_t ret = do_set_pmd(vmf, page);
-	    if (!ret) {
-		    /* The page is mapped successfully, reference consumed. */
-		    unlock_page(page);
-		    return true;
-	    }
+		vm_fault_t ret = do_set_pmd(vmf, page);
+		if (!ret) {
+			/* The page is mapped successfully, reference consumed. */
+			unlock_page(page);
+			return true;
+		}
 	}
 
 	if (pmd_none(*vmf->pmd)) {
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
index ed28eba50f98..a79a38374a14 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1148,8 +1148,12 @@ static int __get_hwpoison_page(struct page *page)
 		return -EBUSY;
 
 	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
+		if (head == compound_head(page)) {
+			if (PageTransHuge(head))
+				SetPageHasHWPoisoned(head);
+
 			return 1;
+		}
 
 		pr_info("Memory failure: %#lx cannot catch tail\n",
 			page_to_pfn(page));
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

