Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829B3445BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhKDVtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhKDVtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:49:18 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22909C061203
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 14:46:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c140-20020a624e92000000b0044d3de98438so4713611pfb.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=XbB9YGB9sL1l4LUP+NB0RzevoG1AS/xVDDgvda7S2FE=;
        b=BahDfqNybrfQMKv8Fw5uQzouGUKWqfI06TTAjlzVF2Fm2QObOgA/NEHhVX6t9kjXLN
         qDvLqdTvtdMNXn1yxtSpnDtJdFKcnai60aGboMQT00XA2MKropwwnQjkVc1V/EasZcSK
         EEu9w87obvlAF8GLNZ89A4+3wFzjWABnOtcnScRq5d/dQ8AQUi+56Mr7XzsC3ONOtblG
         2+LUDnEpFNPYUAMTE7qi7EcG2D+vU+VZs38He8kjL+CayZ1lr93fq6BYVoc5YFgwccUi
         EPpmXaW+2qEIFxuNrFyJoFc8IEgIw1zAkp7/1RNiJ42luHYRiIN3E3N13bd4C5VqQTeC
         LG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=XbB9YGB9sL1l4LUP+NB0RzevoG1AS/xVDDgvda7S2FE=;
        b=BRPJfNcdajxy5ChzE5T9r/MxCCZFOb2pZXAAcBnPuvJB7REO7FcXGKivY5Z7avy58A
         n0Z9502tqHo2Cf0Zb+/nhAUk2UYNIyCUiiYGwgfedvjgO5dtDgVBaVRM/DIxCpP8U0iz
         8G6CQp/zZRymLhpVs7tGSYVF9PzFA1SCiNLbSszMcXF8xn5VofBjc0qHBb+yTkRWs9EV
         MX6gOsLecDCRkJkCTBMQ1fl3a45vSo2C+HLl9hNHHO+j/sQ/APMChxUWxuUvp9LjzVka
         Nhwdg8I+w2nHwRUIh5MoVlWXmZp0xR/GsO+B5X9SbFOtopIotCsDUm2dsRWRfnhfWb+E
         t7qw==
X-Gm-Message-State: AOAM531eAp5+Vbpk3600NcGxtZt7BggJnN2F3ootpkyqrQhlEKH9J6BK
        r7VPVeXmjCcqZb1hToAodJzsXyyq09CDwr1wrA==
X-Google-Smtp-Source: ABdhPJw6ni3y7lAn9ZTVUyYmmDy/A/Is/Ee5sb+M3gLrJ9xBRI6Ytbksgo2nfO2mKbKzDvU+YDRQiHxtyDQGlDcgeA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:a75b:b6d9:b323:af05])
 (user=almasrymina job=sendgmr) by 2002:aa7:914f:0:b0:44d:6f5e:f11a with SMTP
 id 15-20020aa7914f000000b0044d6f5ef11amr54109373pfi.10.1636062399468; Thu, 04
 Nov 2021 14:46:39 -0700 (PDT)
Date:   Thu,  4 Nov 2021 14:46:35 -0700
Message-Id: <20211104214636.450782-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2] mm: Add PM_THP to /proc/pid/pagemap
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add PM_THP to allow userspace to detect whether a given virt address is
currently mapped by a hugepage or not.

Example use case is a process requesting hugepages from the kernel (via
a huge tmpfs mount for example), for a performance critical region of
memory.  The userspace may want to query whether the kernel is actually
backing this memory by hugepages or not.

Tested manually by adding logging into transhuge-stress.

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: David Rientjes rientjes@google.com
Cc: Paul E. McKenney <paulmckrcu@fb.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Florian Schmidt <florian.schmidt@nutanix.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

---
 fs/proc/task_mmu.c                            |  5 +++++
 tools/testing/selftests/vm/transhuge-stress.c | 21 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5c..9847514937fc7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1302,6 +1302,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_THP			BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1396,6 +1397,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_FILE;
 	if (page && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
+	if (page && PageTransCompound(page))
+		flags |= PM_THP;
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;

@@ -1456,6 +1459,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,

 		if (page && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
+		if (page && PageTransCompound(page))
+			flags |= PM_THP;

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
