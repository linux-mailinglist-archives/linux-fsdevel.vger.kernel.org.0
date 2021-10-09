Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492C427867
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhJIJ3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 05:29:01 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58933 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231653AbhJIJ3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:29:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ur5qOcb_1633771618;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Ur5qOcb_1633771618)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 17:27:01 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: [PATCH 2/3] mm, thp: make mapping address of libraries THP align
Date:   Sat,  9 Oct 2021 17:26:57 +0800
Message-Id: <20211009092658.59665-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For shared libraries, ld.so seems not to consider p_align well, as shown
below.
$ readelf -l /usr/lib64/libc-2.17.so
LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
               0x00000000001c2fe8 0x00000000001c2fe8  R E    200000
$ cat /proc/1/smaps
7fecc4072000-7fecc4235000 r-xp 00000000 08:03 655802  /usr/lib64/libc-2.17.so

This makes the mapping address allocated by 'get_unmapped_area'
align with 2M for libraries, to facilitate file THP for .text
section as far as possible.

Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h | 12 ++++++++++++
 mm/huge_memory.c        | 15 +++++++++++++++
 mm/mmap.c               | 18 ++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 95b718031ef3..ddbc0d19f90f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -147,8 +147,20 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 #define hugetext_enabled()			\
 	(transparent_hugepage_flags &		\
 	 (1<<TRANSPARENT_HUGEPAGE_HUGETEXT_ENABLED_FLAG))
+
+extern unsigned long hugetext_get_unmapped_area(struct file *filp,
+		unsigned long addr, unsigned long len, unsigned long pgoff,
+		unsigned long flags);
 #else
 #define hugetext_enabled()	false
+
+static inline unsigned long hugetext_get_unmapped_area(struct file *filp,
+		unsigned long addr, unsigned long len, unsigned long pgoff,
+		unsigned long flags)
+{
+	BUILD_BUG();
+	return 0;
+}
 #endif /* CONFIG_HUGETEXT */
 
 static inline bool vma_is_hugetext(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f6fffb5c5130..076a74cdc214 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -650,6 +650,21 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
+#ifdef CONFIG_HUGETEXT
+unsigned long hugetext_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	unsigned long ret;
+	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
+
+	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
+	if (ret)
+		return ret;
+
+	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+#endif /* CONFIG_HUGETEXT */
+
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 88dcc5c25225..cad94a13edc2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2242,8 +2242,26 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	get_area = current->mm->get_unmapped_area;
 	if (file) {
+#ifdef CONFIG_HUGETEXT
+		/*
+		 * Prior to the file->f_op->get_unmapped_area.
+		 *
+		 * If hugetext is enabled, except for MAP_FIXED, it always
+		 * make the mapping address of files that have executable
+		 * attribute be mapped in 2MB alignment.
+		 */
+		struct inode *inode = file_inode(file);
+
+		if (hugetext_enabled() && (inode->i_mode & 0111) &&
+				(!file->f_op->get_unmapped_area ||
+				 file->f_op->get_unmapped_area == thp_get_unmapped_area))
+			get_area = hugetext_get_unmapped_area;
+		else if (file->f_op->get_unmapped_area)
+			get_area = file->f_op->get_unmapped_area;
+#else
 		if (file->f_op->get_unmapped_area)
 			get_area = file->f_op->get_unmapped_area;
+#endif
 	} else if (flags & MAP_SHARED) {
 		/*
 		 * mmap_region() will call shmem_zero_setup() to create a file,
-- 
2.27.0

