Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADE44769C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Nov 2021 23:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKGXCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 18:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKGXCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 18:02:34 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D54C061570
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Nov 2021 14:59:50 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n2-20020a17090a2fc200b001a1bafb59bfso3643907pjm.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Nov 2021 14:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=RGyd5fiyOhy5GGKEzKJh8xi/Umvf6q20k85EJTXajbk=;
        b=chNygS8CqeKmDlPQFveSwxc2tvI/R+tMYlS4e00i48Ehiwsc1GLRsWF3YTYTWutBct
         mGuSqWFklUyiydxgheXtB34yv9IXiDAIGcB2HvldMCrPVt9nEKXS9R4rsz+FMUOIOW6f
         TklNTnd4e+sUSjhuYdoNP+54QWjdy5msxUUx0kHxhBUQvYHIObvM5YQKu/N1/WVn/Dgk
         Bg+DzJKwqVDpmOFl4v5lkqR1EEBcasQTHmgZz8Fy26IhJjbN+l8+xaAEZIIiwtfyRsQc
         sjOU7+ciZfCSb1sCW3vYp0GxGHwjrw7l3NcKbdyhlbZeoIdToPjGRO4NvBAv/P3UqlxC
         +s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=RGyd5fiyOhy5GGKEzKJh8xi/Umvf6q20k85EJTXajbk=;
        b=l30p7KK5G7VoMJFtsWknkAJtaV2Ri7iE3cc8Kcfk5J9WDyx4kaVVXIZZhQRRGBS5u9
         Ck1sizeqk086gS7WACnvDyCATm0c+O1OB+q/+R/GHWGKoVlPks+VC9vj8h5AJ37o18Ox
         qmAhaqRFnuMuWljEzfOsNWIoWYVoMWbPn8tb7S/ULniM3fFU6Pn6WDydtyVUJ8ikaIR/
         jL9EcVk/Pv+JSietkq22qQ3a+7xlF7cnBKqTrATDHN/5WZPAcZP24d9CMETahctnazrB
         TtBkptk1LrvI0eVigG+WO/BOE/e7ycl89BnGusRHgFEjN1l5PDldOi4v+vXnMncCug0g
         sOoQ==
X-Gm-Message-State: AOAM532WVdCvMAlHAGoqNuSrOwKHlG3qCC5j/9UeU5wnsl+zbaqTOsh1
        4FHoRmlLDd8AJJEoMERwdZU9l2zHECcOLUxStg==
X-Google-Smtp-Source: ABdhPJwt5nUAcpy2chlqCQQlPa8udRSH/MwnDkgO0xpWaRUaU1F1uUiexJxGrX23pi143MUAQRLdVrDx6o2gteVIZg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:86c8:d4b:a94b:a8fe])
 (user=almasrymina job=sendgmr) by 2002:a17:902:e88f:b0:141:f982:777 with SMTP
 id w15-20020a170902e88f00b00141f9820777mr44864402plg.68.1636325990117; Sun,
 07 Nov 2021 14:59:50 -0800 (PST)
Date:   Sun,  7 Nov 2021 14:59:47 -0800
Message-Id: <20211107225947.1287388-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add PM_HUGE_THP MAPPING to allow userspace to detect whether a given virt
address is currently mapped by a transparent huge page or not.

Example use case is a process requesting THPs from the kernel (via
a huge tmpfs mount for example), for a performance critical region of
memory.  The userspace may want to query whether the kernel is actually
backing this memory by hugepages or not.

PM_HUGE_THP_MAPPING bit is set if the virt address is mapped at the PMD
level and the underlying page is a transparent huge page.

Tested manually by adding logging into transhuge-stress, and by
allocating THP and querying the PM_HUGE_THP_MAPPING flag at those
virtual addresses.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes rientjes@google.com
Cc: Paul E. McKenney <paulmckrcu@fb.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc: Florian Schmidt <florian.schmidt@nutanix.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

---
 Documentation/admin-guide/mm/pagemap.rst      |  3 ++-
 fs/proc/task_mmu.c                            |  6 +++++-
 tools/testing/selftests/vm/transhuge-stress.c | 21 +++++++++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index fdc19fbc10839..8a0f0064ff336 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -23,7 +23,8 @@ There are four components to pagemap:
     * Bit  56    page exclusively mapped (since 4.2)
     * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
       :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
-    * Bits 57-60 zero
+    * Bit  58    page is a huge (PMD size) THP mapping
+    * Bits 59-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
     * Bit  63    page present
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5c..e10b59064c0b9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1302,6 +1302,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1409,12 +1410,13 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	struct pagemapread *pm = walk->private;
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
+	u64 flags = 0;
 	int err = 0;

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
-		u64 flags = 0, frame = 0;
+		u64 frame = 0;
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;

@@ -1456,6 +1458,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,

 		if (page && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
+		if (page && is_transparent_hugepage(page))
+			flags |= PM_HUGE_THP_MAPPING;

 		for (; addr != end; addr += PAGE_SIZE) {
 			pagemap_entry_t pme = make_pme(frame, flags);
diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
index fd7f1b4a96f94..7dce18981fff5 100644
--- a/tools/testing/selftests/vm/transhuge-stress.c
+++ b/tools/testing/selftests/vm/transhuge-stress.c
@@ -16,6 +16,12 @@
 #include <string.h>
 #include <sys/mman.h>

+/*
+ * We can use /proc/pid/pagemap to detect whether the kernel was able to find
+ * hugepages or no. This can be very noisy, so is disabled by default.
+ */
+#define NO_DETECT_HUGEPAGES
+
 #define PAGE_SHIFT 12
 #define HPAGE_SHIFT 21

@@ -23,6 +29,7 @@
 #define HPAGE_SIZE (1 << HPAGE_SHIFT)

 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
+#define PAGEMAP_THP(ent)	(((ent) & (1ull << 58)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))

 int pagemap_fd;
@@ -47,10 +54,16 @@ int64_t allocate_transhuge(void *ptr)
 			(uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
 		err(2, "read pagemap");

-	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
-	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
-	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
-		return PAGEMAP_PFN(ent[0]);
+	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1])) {
+#ifndef NO_DETECT_HUGEPAGES
+		if (!PAGEMAP_THP(ent[0]))
+			fprintf(stderr, "WARNING: detected non THP page\n");
+#endif
+		if (PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
+		    !(PAGEMAP_PFN(ent[0]) &
+		      ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
+			return PAGEMAP_PFN(ent[0]);
+	}

 	return -1;
 }
--
2.34.0.rc0.344.g81b53c2807-goog
