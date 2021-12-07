Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC40F46BBF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhLGNAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhLGNAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:00:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CCC061574;
        Tue,  7 Dec 2021 04:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9181B817AD;
        Tue,  7 Dec 2021 12:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D73C341CA;
        Tue,  7 Dec 2021 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881841;
        bh=KEhKHTD8C1fi/r8hfgqvAxw5aYOP7uaiIolMPLgBW8w=;
        h=From:To:Cc:Subject:Date:From;
        b=YV/Og6kVenojEYjECtMuP1p5dq4BOid6MQqqbn/r04H/KIXGbBK1gWeB5KGIYBJHb
         J47o7PbDRmNFV81IxtJ/67FJIslLxAOpLtx7idRKrrxD9IMUMOBuewdaDXKKLXl/23
         mBZYrzCk7hwOsGF0qraFbCDx5AVZzJYc5c4YQ17SPqJyPgZfdrPESkUaP+yYbj2ZRE
         56ep/2H0WxyL6SFl8DaBvVtw6XG/oiB6U9U28B8wud+EnEllQZbUSS4X1y2XP4CaZt
         pgHXq2Wll/dNoO23neXoEQInOdnt9IcJjL8SvBSDBlZT24YRFQbKIUlp6IJrKKg6IJ
         piFlaHtSVO1Ew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] [v2] mm: move anon_vma declarations to linux/mm_inline.h
Date:   Tue,  7 Dec 2021 13:55:43 +0100
Message-Id: <20211207125710.2503446-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The patch to add anonymous vma names causes a build failure in
some configurations:

include/linux/mm_types.h: In function 'is_same_vma_anon_name':
include/linux/mm_types.h:924:37: error: implicit declaration of function 'strcmp' [-Werror=implicit-function-declaration]
  924 |         return name && vma_name && !strcmp(name, vma_name);
      |                                     ^~~~~~
include/linux/mm_types.h:22:1: note: 'strcmp' is defined in header '<string.h>'; did you forget to '#include <string.h>'?

This should not really be part of linux/mm_types.h in the first
place, as that header is meant to only contain structure defintions
and need a minimum set of indirect includes itself. While the
header clearly includes more than it should at this point, let's
not make it worse by including string.h as well, which would
pull in the expensive (compile-speed wise) fortify-string logic.

Move the new functions into a separate header that only needs
to be included in a couple of locations.

Fixes: 52f545eb6dd7 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/task_mmu.c        |  1 +
 fs/userfaultfd.c          |  1 +
 include/linux/mm_inline.h | 50 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h  | 48 -------------------------------------
 kernel/fork.c             |  1 +
 mm/madvise.c              |  1 +
 mm/mmap.c                 |  1 +
 7 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e6998652fd67..18f8c3acbb85 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
 #include <linux/vmacache.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5b2af7b82776..e26b10132d47 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e2ec68b0515c..47d96d2647ca 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,7 @@
 
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
+#include <linux/string.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -135,4 +136,53 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 {
 	lruvec_del_folio(lruvec, page_folio(page));
 }
+
+#ifdef CONFIG_ANON_VMA_NAME
+/*
+ * mmap_lock should be read-locked when calling vma_anon_name() and while using
+ * the returned pointer.
+ */
+extern const char *vma_anon_name(struct vm_area_struct *vma);
+
+/*
+ * mmap_lock should be read-locked for orig_vma->vm_mm.
+ * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
+ * isolated.
+ */
+extern void dup_vma_anon_name(struct vm_area_struct *orig_vma,
+			      struct vm_area_struct *new_vma);
+
+/*
+ * mmap_lock should be write-locked or vma should have been isolated under
+ * write-locked mmap_lock protection.
+ */
+extern void free_vma_anon_name(struct vm_area_struct *vma);
+
+/* mmap_lock should be read-locked */
+static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
+					 const char *name)
+{
+	const char *vma_name = vma_anon_name(vma);
+
+	/* either both NULL, or pointers to same string */
+	if (vma_name == name)
+		return true;
+
+	return name && vma_name && !strcmp(name, vma_name);
+}
+#else /* CONFIG_ANON_VMA_NAME */
+static inline const char *vma_anon_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
+			      struct vm_area_struct *new_vma) {}
+static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
+static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
+					 const char *name)
+{
+	return true;
+}
+#endif  /* CONFIG_ANON_VMA_NAME */
+
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 850e71986b9d..555f51de1fe0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -890,52 +890,4 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
-#ifdef CONFIG_ANON_VMA_NAME
-/*
- * mmap_lock should be read-locked when calling vma_anon_name() and while using
- * the returned pointer.
- */
-extern const char *vma_anon_name(struct vm_area_struct *vma);
-
-/*
- * mmap_lock should be read-locked for orig_vma->vm_mm.
- * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
- * isolated.
- */
-extern void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-			      struct vm_area_struct *new_vma);
-
-/*
- * mmap_lock should be write-locked or vma should have been isolated under
- * write-locked mmap_lock protection.
- */
-extern void free_vma_anon_name(struct vm_area_struct *vma);
-
-/* mmap_lock should be read-locked */
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
-{
-	const char *vma_name = vma_anon_name(vma);
-
-	/* either both NULL, or pointers to same string */
-	if (vma_name == name)
-		return true;
-
-	return name && vma_name && !strcmp(name, vma_name);
-}
-#else /* CONFIG_ANON_VMA_NAME */
-static inline const char *vma_anon_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
-			      struct vm_area_struct *new_vma) {}
-static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
-static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
-					 const char *name)
-{
-	return true;
-}
-#endif  /* CONFIG_ANON_VMA_NAME */
-
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 7c06be0ca31b..1c989cc4208a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,6 +42,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
diff --git a/mm/madvise.c b/mm/madvise.c
index c63aacbbfa78..5604064df464 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -18,6 +18,7 @@
 #include <linux/fadvise.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ea9e6775fa3..3f48d0928e6b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
-- 
2.29.2

