Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23D427869
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhJIJ3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 05:29:02 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33624 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231698AbhJIJ3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:29:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ur5qOcb_1633771618;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Ur5qOcb_1633771618)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 17:27:00 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: [PATCH 1/3] mm, thp: support binaries transparent use of file THP
Date:   Sat,  9 Oct 2021 17:26:56 +0800
Message-Id: <20211009092658.59665-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file THP for .text is not convenient to use at present.
Applications need to explicitly madvise MADV_HUGEPAGE for .text,
which is not friendly for tasks in the production environment.

This patch extends READ_ONLY_THP_FOR_FS, introduces a new sysfs
interface: hugetext_enabled, to make the read-only file-backed
pages THPeligible proactively and transparently.

Compared with original design, It not depend on 'madvise()' any
more. And because of 'hugetext_enabled' introduced, users are
no longer limited to 'enabled' setting (e.g., always, madvise
and never).

There are two methods to enable or disable this feature:
To enable hugetext:
1. echo 1 > /sys/kernel/mm/transparent_hugepage/hugetext_enabled
2. hugetext=1 in boot cmdline

To disable hugetext:
1. echo 0 > /sys/kernel/mm/transparent_hugepage/hugetext_enabled
2. hugetext=0 in boot cmdline

This feature is disabled by default.

Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h    | 24 ++++++++++++++++
 include/linux/khugepaged.h |  9 ++++++
 mm/Kconfig                 | 11 ++++++++
 mm/huge_memory.c           | 57 ++++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c            |  4 +++
 mm/memory.c                | 12 ++++++++
 6 files changed, 117 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f123e15d966e..95b718031ef3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -87,6 +87,9 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+#ifdef CONFIG_HUGETEXT
+	TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG,
+#endif
 };
 
 struct kobject;
@@ -140,6 +143,27 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 	return true;
 }
 
+#ifdef CONFIG_HUGETEXT
+#define hugetext_enabled()			\
+	(transparent_hugepage_flags &		\
+	 (1<<TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG))
+#else
+#define hugetext_enabled()	false
+#endif /* CONFIG_HUGETEXT */
+
+static inline bool vma_is_hugetext(struct vm_area_struct *vma,
+				   unsigned long vm_flags)
+{
+	if (!(vm_flags & VM_EXEC))
+		return false;
+
+	if (vma->vm_file && !inode_is_open_for_write(vma->vm_file->f_inode))
+		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
+				HPAGE_PMD_NR);
+
+	return false;
+}
+
 /*
  * to be used on vmas which are known to support THP.
  * Use transparent_hugepage_active otherwise
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 2fcc01891b47..ad56f75a2fda 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -26,10 +26,18 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 }
 #endif
 
+#ifdef CONFIG_HUGETEXT
+#define khugepaged_enabled()					\
+	(transparent_hugepage_flags &				\
+	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |			\
+	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG) |		\
+	  (1<<TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG)))
+#else
 #define khugepaged_enabled()					       \
 	(transparent_hugepage_flags &				       \
 	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
 	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
+#endif
 #define khugepaged_always()				\
 	(transparent_hugepage_flags &			\
 	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
@@ -59,6 +67,7 @@ static inline int khugepaged_enter(struct vm_area_struct *vma,
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
 		if ((khugepaged_always() ||
 		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
+		     (hugetext_enabled() && vma_is_hugetext(vma, vm_flags)) ||
 		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
 		    !(vm_flags & VM_NOHUGEPAGE) &&
 		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
diff --git a/mm/Kconfig b/mm/Kconfig
index d16ba9249bc5..5aa3fa86e7b1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -868,6 +868,17 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config HUGETEXT
+	bool "THP for text segments"
+	depends on READ_ONLY_THP_FOR_FS
+
+	help
+	  Allow khugepaged to put read-only file-backed pages, including
+	  shared libraries, as well as the anonymous and executable pages
+	  in THP.
+
+	  This feature builds on and extends READ_ONLY_THP_FOR_FS.
+
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..f6fffb5c5130 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -330,6 +330,35 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+#ifdef CONFIG_HUGETEXT
+static ssize_t hugetext_enabled_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return single_hugepage_flag_show(kobj, attr, buf,
+			TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG);
+}
+
+static ssize_t hugetext_enabled_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	ssize_t ret = count;
+
+	ret = single_hugepage_flag_store(kobj, attr, buf, count,
+			TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG);
+
+	if (ret > 0) {
+		int err = start_stop_khugepaged();
+
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+struct kobj_attribute hugetext_enabled_attr =
+	__ATTR(hugetext_enabled, 0644, hugetext_enabled_show, hugetext_enabled_store);
+#endif /* CONFIG_HUGETEXT */
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -337,6 +366,9 @@ static struct attribute *hugepage_attr[] = {
 	&hpage_pmd_size_attr.attr,
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
+#endif
+#ifdef CONFIG_HUGETEXT
+	&hugetext_enabled_attr.attr,
 #endif
 	NULL,
 };
@@ -491,6 +523,31 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
+#ifdef CONFIG_HUGETEXT
+static int __init setup_hugetext(char *str)
+{
+	int ret = 0;
+
+	if (!str)
+		goto out;
+	if (!strcmp(str, "1")) {
+		set_bit(TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG,
+			  &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "0")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG,
+			&transparent_hugepage_flags);
+		ret = 1;
+	}
+
+out:
+	if (!ret)
+		pr_warn("hugetext= cannot parse, ignored\n");
+	return ret;
+}
+__setup("hugetext=", setup_hugetext);
+#endif
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..2810bc1962b3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -451,6 +451,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 				HPAGE_PMD_NR);
 	}
 
+	/* Make hugetext independent of THP settings */
+	if (hugetext_enabled() && vma_is_hugetext(vma, vm_flags))
+		return true;
+
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
diff --git a/mm/memory.c b/mm/memory.c
index adf9b9ef8277..b0d0889af6ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -73,6 +73,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/khugepaged.h>
 
 #include <trace/events/kmem.h>
 
@@ -4157,6 +4158,17 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
+#ifdef CONFIG_HUGETEXT
+	/* Add the candidate hugetext vma into khugepaged scan list */
+	if (pmd_none(*vmf->pmd) && hugetext_enabled()
+			&& vma_is_hugetext(vma, vma->vm_flags)) {
+		unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+
+		if (transhuge_vma_suitable(vma, haddr))
+			khugepaged_enter(vma, vma->vm_flags);
+	}
+#endif
+
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
 	 * if page by the offset is not ready to be mapped (cold cache or
-- 
2.27.0

