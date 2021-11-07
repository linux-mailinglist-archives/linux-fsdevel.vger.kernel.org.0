Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBAD4476C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 00:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhKHAAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 19:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhKHAAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 19:00:41 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB4C061570
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Nov 2021 15:57:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id l7-20020a622507000000b00494608c84a4so7530467pfl.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Nov 2021 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=R+t/urldu9YHqL+lDHl0HSLrbce7ecQGyIl+/EPH9I8=;
        b=jtvTOQvOVdGNvyQyeQqOgGXvjQRC942kwerWX6M5FsjL3Tf2acXkUvzNi3m/soosln
         smuise7b6YoEQSDMWni5RrgsRkFHhCkqDkNg/SvV2OrqbcUp89NTGHyz9K3zMkml9h8C
         H2FfEfYy8l1yITzXaM5pqtHa+/VgyFAP57qmtbkovAq/FbBzve5NMVOD0aeba8x4rKyf
         w5sBJ5g/iG7tk815O9LKpRjk0SZdl8e7vfYWFMybz0XoV7TCIsdNqjcKcLv3ChUSt6Op
         ftNIT54rBT3hSlbv8PxpftPfFCmvpmlYscqi3G7h6BTnfPp/UC/ZGZJxL78o0aupiqgV
         BpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=R+t/urldu9YHqL+lDHl0HSLrbce7ecQGyIl+/EPH9I8=;
        b=AzPrXg07AVBw92o7yRV+ePfff4S4IAJ8jPNA9AtBA+U3ZxwTIYnXLJq7PQHdb4WQPz
         hGxtaADTfk5+pM7JP89N4h0f7AlB76CV/3zxZT03vDnN2NF33PFFQ4Rn4GkCgVqxXqW7
         7LK0nU0S6oDIiWxCrYwF04tNKJSGmEEA7brz8n67S9rAR6/b2hixfIwCmogYwLod4SGo
         3GeWILZDumRiJ/NrjzaOaswvfCSDdH5kwzjdIPGg4+/0IhakoUXOubo0S8x0dPQQjute
         1vbtDImLC9FWkZVaYNYijaVh6s8LJbLyFSwh/twP9qLt4FEk0IYaQb3PdwCmniRhNvvm
         OUxg==
X-Gm-Message-State: AOAM532e55Kzrw4Hizbf298EAnEb0nsJBZzHxzXzvD5MxwQsyYqpIbGa
        TA91GtzDVrv61uOjZgBa8lCdhO2QDeo/dZAEzw==
X-Google-Smtp-Source: ABdhPJxvrhLtle5SS8aEghWIfAk3tWnJrCeqtk4DE1GvfdAPQan5xzgUAyKoMUQEhK3rRNz7sYMbQHZHVKUni4iHPw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:86c8:d4b:a94b:a8fe])
 (user=almasrymina job=sendgmr) by 2002:a63:4847:: with SMTP id
 x7mr47288917pgk.239.1636329477365; Sun, 07 Nov 2021 15:57:57 -0800 (PST)
Date:   Sun,  7 Nov 2021 15:57:54 -0800
Message-Id: <20211107235754.1395488-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
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

Changes in v4:
- Removed unnecessary moving of flags variable declaration

Changes in v3:
- Renamed PM_THP to PM_HUGE_THP_MAPPING
- Fixed checks to set PM_HUGE_THP_MAPPING
- Added PM_HUGE_THP_MAPPING docs

---
 Documentation/admin-guide/mm/pagemap.rst      |  3 ++-
 fs/proc/task_mmu.c                            |  3 +++
 tools/testing/selftests/vm/transhuge-stress.c | 21 +++++++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

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
index ad667dbc96f5c..6f1403f83b310 100644
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
@@ -1456,6 +1457,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,

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
