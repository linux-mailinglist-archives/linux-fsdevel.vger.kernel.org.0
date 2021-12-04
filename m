Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9314686BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhLDRsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 12:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDRsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:48:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE2BC061751;
        Sat,  4 Dec 2021 09:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B783B80CC3;
        Sat,  4 Dec 2021 17:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA4C341C0;
        Sat,  4 Dec 2021 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638639871;
        bh=tdPtUII1fRnZ1rUqrCV8xPrX1J4M7IiTb3hxZtz7sKc=;
        h=From:To:Cc:Subject:Date:From;
        b=RoFNbHhhNUcCtIyLfJEvy+AxDIY8qcVpD3FffcostuQzSxmuSwkN59IPBSMKTAUhk
         +BomHBNcQgqvfozSni+91KNLWlu9Zkqo2eq4GwT4gcAGG/Ld5svtsOeVhJ4S0bR+7r
         FJ/s1Z23iwoUAPl0nbWbLoL3sFCBfrE/JAT/WsvsQgECUhdIaBB3wZ5/iB0IXStuJL
         8DRM4aa0wpDL6sw3S5br31+VfVZ9ICJBMyQAPbU036EtVXK0zfPZOS8/Ydjyo0+GMX
         IOWribTtPYbJdJ5ZyDmNL13qO9lpjpb1S5uWO/dWcy3iOKpNX9MvaYUaXUtx3dE2A9
         rMtbWoT11Ew3A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Colin Cross <ccross@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: split out anon_vma declarations to separate header
Date:   Sat,  4 Dec 2021 18:42:17 +0100
Message-Id: <20211204174417.1025328-1-arnd@kernel.org>
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

Move the new functions to a separate header that is only included
where necessary to avoid bloating linux/mm_types.h further.

Fixes: 52f545eb6dd7 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/task_mmu.c       |  1 +
 fs/userfaultfd.c         |  1 +
 include/linux/anon_vma.h | 55 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 48 -----------------------------------
 kernel/fork.c            |  1 +
 mm/madvise.c             |  1 +
 mm/mempolicy.c           |  1 +
 mm/mlock.c               |  1 +
 mm/mmap.c                |  1 +
 mm/mprotect.c            |  1 +
 10 files changed, 63 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/anon_vma.h

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e6998652fd67..5b0106afa870 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
 #include <linux/vmacache.h>
+#include <linux/anon_vma.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5b2af7b82776..f1d9265e8581 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/mm.h>
+#include <linux/anon_vma.h>
 #include <linux/mmu_notifier.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
diff --git a/include/linux/anon_vma.h b/include/linux/anon_vma.h
new file mode 100644
index 000000000000..5ce8b5be31ae
--- /dev/null
+++ b/include/linux/anon_vma.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ANON_VMA_H
+#define _LINUX_ANON_VMA_H
+
+#include <linux/mm_types.h>
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
+#endif /* _LINUX_ANON_VMA_H */
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
index 7c06be0ca31b..8964e1559722 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,6 +42,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/anon_vma.h>
 #include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
diff --git a/mm/madvise.c b/mm/madvise.c
index c63aacbbfa78..4d0ab22b31c0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -18,6 +18,7 @@
 #include <linux/fadvise.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/anon_vma.h>
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e0066ca91d9a..58fbd8ec527f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -99,6 +99,7 @@
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
 #include <linux/mm_inline.h>
+#include <linux/anon_vma.h>
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..f3179d8169e4 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -9,6 +9,7 @@
 #include <linux/capability.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/anon_vma.h>
 #include <linux/sched/user.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ea9e6775fa3..289a40d1d4f3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
+#include <linux/anon_vma.h>
 #include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0138dfcdb1d8..96d57b1b41cd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -28,6 +28,7 @@
 #include <linux/ksm.h>
 #include <linux/uaccess.h>
 #include <linux/mm_inline.h>
+#include <linux/anon_vma.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-- 
2.29.2

