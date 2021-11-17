Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E229A454E2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKQTwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 14:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhKQTv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:51:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28DC061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 11:49:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so5661839ybj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PpBiG+58AqKHL1Onxjj1GmKlritKFJFCrusKbqqq2FE=;
        b=maTz4mTJBef5LXTAVKIznYcBVXrKhhbFl6Sjn9+9n+vlBMXlBUpILx8hnFowMWNKVR
         D5WvRhfmcQYN9632bBuUjcDJOx0Za+nMrkTvrkrULLFOWc2kOQ3RSu585cCQti/p2JWv
         UMg5QLlPEBP8hPnpQRW9cFEfW6yVss7tPH8vlStqQCRWpJAShgXCeKnibT1V8bMN4P2v
         RUYNNQvus91tdcZRcsUg/JgE6h0Z1Z9++YOloTZhtQaBPg01FDrZrzt+K/BB2qqxhye5
         qD+NIdQfbgxdJPi8SqdTS8bVBGoHQdw+pchl5ktr/ug9I7tGRBmUWsLFGspntZ9ehaKW
         kODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PpBiG+58AqKHL1Onxjj1GmKlritKFJFCrusKbqqq2FE=;
        b=ulJx7FSRIpNLMEPz+I+IT1TCXdGBvd2oHkZM3z/G68s/nzB7v6JsETAWEqsGAtfNQK
         865ns4eoa+qqF6DS9liy1xeDazPjRDrrMiHJ18N/uNcXsZnGesraO81EV0e0wh1+Y4r+
         IeiNDxmPzUY0nyDtWGODCSW12czBMBzFo+i4kfFdxELzc2Wy7eOrkggQKuq0pBE6riyH
         T4B/T/zal79PsBrN3whAp+kY3XjNYKVpMyqEN60qGL3M2h3HMIs9alcrFrgkjeHygw1w
         c7p1LHxVgPrO3C9I1EjOcfKqPGfPc0m6pruAu/6/faM/E+xA+FZeRGiZQuMhInoZXso8
         m0qQ==
X-Gm-Message-State: AOAM532w8bnZlK1C5akXVcI8gB1SuX/CEC4Uda9wGCWuOyXHcGaiw91C
        gUSY/QN9HHqCzHTt1G+wld3X2IeQGxiv+rPQ8Q==
X-Google-Smtp-Source: ABdhPJx/1FP76tKslX0j28CU2KgGpu+lsjLSgUFFLnvLWteC3/S8VHTgPQGZlFFscWKnSWSFZmyke9EFBaUr2IVJMA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:ab13:f492:fd91:a37d])
 (user=almasrymina job=sendgmr) by 2002:a25:bfd2:: with SMTP id
 q18mr13117865ybm.542.1637178539930; Wed, 17 Nov 2021 11:48:59 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:48:54 -0800
Message-Id: <20211117194855.398455-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v6] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
From:   Mina Almasry <almasrymina@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mina Almasry <almasrymina@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
address is currently mapped by a transparent huge page or not.  Example
use case is a process requesting THPs from the kernel (via a huge tmpfs
mount for example), for a performance critical region of memory.  The
userspace may want to query whether the kernel is actually backing this
memory by hugepages or not.

PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
level and the underlying page is a transparent huge page.

A few options were considered:
1. Add /proc/pid/pageflags that exports the same info as
   /proc/kpageflags.  This is not appropriate because many kpageflags are
   inappropriate to expose to userspace processes.
2. Simply get this info from the existing /proc/pid/smaps interface.
   There are a couple of issues with that:
   1. /proc/pid/smaps output is human readable and unfriendly to
      programatically parse.
   2. /proc/pid/smaps is slow.  The cost of reading /proc/pid/smaps into
      userspace buffers is about ~800us per call, and this doesn't
      include parsing the output to get the information you need. The
      cost of querying 1 virt address in /proc/pid/pagemaps however is
      around 5-7us.

Tested manually by adding logging into transhuge-stress, and by
allocating THP and querying the PM_THP_MAPPED flag at those
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

Changes in v6:
- Renamed to PM_THP_MAPPED
- Removed changes to transhuge-stress

Changes in v5:
- Added justification for this interface in the commit message!

Changes in v4:
- Removed unnecessary moving of flags variable declaration

Changes in v3:
- Renamed PM_THP to PM_HUGE_THP_MAPPING
- Fixed checks to set PM_HUGE_THP_MAPPING
- Added PM_HUGE_THP_MAPPING docs
---
 Documentation/admin-guide/mm/pagemap.rst | 3 ++-
 fs/proc/task_mmu.c                       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index ad667dbc96f5c..d784a97aa209a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1302,6 +1302,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_THP_MAPPED		BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1456,6 +1457,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,

 		if (page && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
+		if (page && is_transparent_hugepage(page))
+			flags |= PM_THP_MAPPED;

 		for (; addr != end; addr += PAGE_SIZE) {
 			pagemap_entry_t pme = make_pme(frame, flags);
--
2.34.0.rc2.393.gf8c9666880-goog
