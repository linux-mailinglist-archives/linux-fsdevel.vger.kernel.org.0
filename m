Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9258173D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiGZQVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbiGZQVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:21:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16727171;
        Tue, 26 Jul 2022 09:21:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [203.135.47.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B07F96601967;
        Tue, 26 Jul 2022 17:20:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658852465;
        bh=s6eqXFSk6GZEoo/gcU7nGfRgAO8upesyCU6wcU5FTRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWOW0yfY+fyhwjzIf9jeBedeg2FkBZ2QYDN0yyceKZGGy9yc9gTtgTDNBLI1cQzqp
         V2Rg96D7b/kLJfPs3jCkgQqUppHkLuYyZ8HeegcgGfCBmECyjvcllWUrpjj1RYghb2
         mPQ6oVoLoBt4WkFlC2lrX+0D/uUs2QE7tWE2q9dVHwblbo1R4LpmmlFBj31sPW+x69
         qxB5E1eyfdPjhtg0ffGmglaXK6TIzFiOoXuP+DXZ42za/ih2ztHq56o5Dzrbaga2sy
         LQIpirxwZuZl7QxEgdiQeU24/ikR72RKWA/enkxpIQ3ISlaOUKu75GkNEac+ok9jsd
         qZEGKbTPexd+Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-api@vger.kernel.org (open list:ABI/API),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        krisman@collabora.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/5] mm: Implement process_memwatch syscall
Date:   Tue, 26 Jul 2022 21:18:51 +0500
Message-Id: <20220726161854.276359-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This syscall can be used to watch the process's memory and perform
atomic operations which aren't possible through procfs. Two operations
have been implemented. MEMWATCH_SD_GET is used to get the soft dirty
pages. MEMWATCH_SD_CLEAR clears the soft dirty bit from dirty pages.
MEMWATCH_SD_IGNORE_VMA can be specified to ignore VMA dirty flags.
These operations can be used collectively in one operation as well.

NAME
       process_memwatch - get process's memory information

SYNOPSIS
       #include <linux/memwatch.h>   /* Definition of MEMWATCH_*
constants */

       long process_memwatch(int pidfd, unsigned long start, int len,
                             unsigned int flags, void *vec,
                             int vec_len);

       Note:  Glibc does not provide a wrapper for this system call;
       call it using syscall(2).

DESCRIPTION
       process_memwatch() system call is  used  to  get  information
       about the memory of the process.

   Arguments
       pidfd specifies the pidfd of process whose memory needs to be
       watched. The calling process must have PTRACE_MODE_ATTACH_FS‐
       CREDS  capabilities  over  the  process  whose pidfd has been
       specified.  It can be zero which means that the process wants
       to  watch  its  own  memory.  The  operation is determined by
       flags.  The start argument must be a multiple of  the  system
       page  size.  The  len  argument need not be a multiple of the
       page size, but since the  information  is  returned  for  the
       whole pages, len is effectively rounded up to the next multi‐
       ple of the page size.

       vec is an output array in which the offsets of the pages  are
       returned.  Offset is calculated from start address. User lets
       the kernel know about the size of the vec by passing size  in
       vec_len.   The  system  call returns when the whole range has
       been searched or vec is completely filled.  The  whole  range
       isn't cleared if vec fills up completely.

   Operations
       The  flags  argument specifies the operation to be performed.
       The MEMWATCH_SD_GET and MEMWATCH_SD_CLEAR operations  can  be
       used  separately  or  together to perform MEMWATCH_SD_GET and
       MEMWATCH_SD_CLEAR atomically as one operation.

       MEMWATCH_SD_GET
              Get the page offsets which are soft dirty.

       MEMWATCH_SD_CLEAR
              Clear the pages which are soft dirty.

       MEMWATCH_SD_NO_REUSED_REGIONS
              This optional flag can  be  specified  in  combination
              with other flags. VM_SOFTDIRTY is ignored for the VMAs
              for performance reasons. This flag  shows  only  those
              pages  dirty  which  have been written by the user ex‐
              plicitly. All new allocations are not be  returned  as
              dirty.

RETURN VALUE
       The  0  or  positive  value  is returned on success. Positive
       value when returned shows the number of dirty pages filled in
       vec.    In   the   event  of  an  error  (and  assuming  that
       process_memwatch() was invoked via  syscall(2)),  all  opera‐
       tions return -1 and set errno to indicate the error.

ERRORS
       EINVAL invalid arguments.

       ESRCH  Cannot access the process.

       EIO    I/O error.

This is based on a patch from Gabriel Krisman Bertazi.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 include/uapi/linux/memwatch.h |  12 ++
 mm/Makefile                   |   2 +-
 mm/memwatch.c                 | 285 ++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/memwatch.h
 create mode 100644 mm/memwatch.c

diff --git a/include/uapi/linux/memwatch.h b/include/uapi/linux/memwatch.h
new file mode 100644
index 000000000000..7e86ffdc10f5
--- /dev/null
+++ b/include/uapi/linux/memwatch.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _MEMWATCH_H
+#define _MEMWATCH_H
+
+/* memwatch operations */
+#define MEMWATCH_SD_GET			0x1
+#define MEMWATCH_SD_CLEAR		0x2
+#define MEMWATCH_SD_NO_REUSED_REGIONS	0x4
+
+#endif
+
diff --git a/mm/Makefile b/mm/Makefile
index 8083fa85a348..aa72e4ced1f3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -37,7 +37,7 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= highmem.o memory.o memwatch.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
 			   pgtable-generic.o rmap.o vmalloc.o
diff --git a/mm/memwatch.c b/mm/memwatch.c
new file mode 100644
index 000000000000..9be09bc431d2
--- /dev/null
+++ b/mm/memwatch.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Collabora Ltd.
+ */
+#include <linux/pagewalk.h>
+#include <linux/vmalloc.h>
+#include <linux/syscalls.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+#include <linux/sched/mm.h>
+#include <linux/mm_inline.h>
+#include <uapi/linux/memwatch.h>
+#include <uapi/asm-generic/errno-base.h>
+#include <linux/compat.h>
+#include <linux/minmax.h>
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define MEMWATCH_SD_OPS_MASK (MEMWATCH_SD_GET | MEMWATCH_SD_CLEAR | \
+			      MEMWATCH_SD_NO_REUSED_REGIONS)
+
+struct memwatch_sd_private {
+	unsigned long start;
+	unsigned int flags;
+	unsigned int index;
+	unsigned int vec_len;
+	unsigned long *vec;
+};
+
+static int memwatch_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long end, struct mm_walk *walk)
+{
+	struct memwatch_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long start = addr;
+	spinlock_t *ptl;
+	pte_t *pte;
+	int dirty;
+	bool dirty_vma = (p->flags & MEMWATCH_SD_NO_REUSED_REGIONS) ? 0 :
+			 (vma->vm_flags & VM_SOFTDIRTY);
+
+	end = min(end, walk->vma->vm_end);
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (dirty_vma || check_soft_dirty_pmd(vma, addr, pmd, false)) {
+			/*
+			 * Break huge page into small pages if operation needs to be performed is
+			 * on a portion of the huge page or the return buffer cannot store complete
+			 * data. Then process this PMD as having normal pages.
+			 */
+			if (((p->flags & MEMWATCH_SD_CLEAR) && (end - addr < HPAGE_SIZE)) ||
+			    ((p->flags & MEMWATCH_SD_GET) &&
+			     (p->index + HPAGE_SIZE/PAGE_SIZE > p->vec_len))) {
+				spin_unlock(ptl);
+				split_huge_pmd(vma, pmd, addr);
+				goto process_pages;
+			} else {
+				dirty = check_soft_dirty_pmd(vma, addr, pmd,
+							     p->flags & MEMWATCH_SD_CLEAR);
+				if ((p->flags & MEMWATCH_SD_GET) && (dirty_vma || dirty)) {
+					for (; addr != end && p->index < p->vec_len;
+					     addr += PAGE_SIZE)
+						p->vec[p->index++] = addr - p->start;
+				}
+			}
+		}
+		spin_unlock(ptl);
+		return 0;
+	}
+
+process_pages:
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		dirty = check_soft_dirty(vma, addr, pte, p->flags & MEMWATCH_SD_CLEAR);
+
+		if ((p->flags & MEMWATCH_SD_GET) && (dirty_vma || dirty)) {
+			p->vec[p->index++] = addr - p->start;
+			WARN_ON(p->index > p->vec_len);
+		}
+	}
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
+
+	if (p->flags & MEMWATCH_SD_CLEAR)
+		flush_tlb_mm_range(vma->vm_mm, start, end, PAGE_SHIFT, false);
+
+	return 0;
+}
+
+static int memwatch_pte_hole(unsigned long addr, unsigned long end, int depth,
+			     struct mm_walk *walk)
+{
+	struct memwatch_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (p->flags & MEMWATCH_SD_NO_REUSED_REGIONS)
+		return 0;
+
+	if (vma && (vma->vm_flags & VM_SOFTDIRTY) && (p->flags & MEMWATCH_SD_GET)) {
+		for (; addr != end && p->index < p->vec_len; addr += PAGE_SIZE)
+			p->vec[p->index++] = addr - p->start;
+	}
+
+	return 0;
+}
+
+static int memwatch_pre_vma(unsigned long start, unsigned long end, struct mm_walk *walk)
+{
+	struct memwatch_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	int ret;
+	unsigned long end_cut = end;
+
+	if (p->flags & MEMWATCH_SD_NO_REUSED_REGIONS)
+		return 0;
+
+	if ((p->flags & MEMWATCH_SD_CLEAR) && (vma->vm_flags & VM_SOFTDIRTY)) {
+		if (vma->vm_start < start) {
+			ret = split_vma(vma->vm_mm, vma, start, 1);
+			if (ret)
+				return ret;
+		}
+
+		if (p->flags & MEMWATCH_SD_GET)
+			end_cut = min(start + p->vec_len * PAGE_SIZE, end);
+
+		if (vma->vm_end > end_cut) {
+			ret = split_vma(vma->vm_mm, vma, end_cut, 0);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void memwatch_post_vma(struct mm_walk *walk)
+{
+	struct memwatch_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if (p->flags & MEMWATCH_SD_NO_REUSED_REGIONS)
+		return;
+
+	if ((p->flags & MEMWATCH_SD_CLEAR) && (vma->vm_flags & VM_SOFTDIRTY)) {
+		vma->vm_flags &= ~VM_SOFTDIRTY;
+		vma_set_page_prot(vma);
+	}
+}
+
+static int memwatch_pmd_test_walk(unsigned long start, unsigned long end,
+				  struct mm_walk *walk)
+{
+	struct memwatch_sd_private *p = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	if ((p->flags & MEMWATCH_SD_GET) && (p->index == p->vec_len))
+		return -1;
+
+	if (vma->vm_flags & VM_PFNMAP)
+		return 1;
+
+	return 0;
+}
+
+static const struct mm_walk_ops memwatch_ops = {
+	.test_walk = memwatch_pmd_test_walk,
+	.pre_vma = memwatch_pre_vma,
+	.pmd_entry = memwatch_pmd_entry,
+	.pte_hole = memwatch_pte_hole,
+	.post_vma = memwatch_post_vma,
+};
+
+static long do_process_memwatch(int pidfd, void __user *start_addr, int len,
+				unsigned int flags, loff_t __user *vec, int vec_len)
+{
+	struct memwatch_sd_private watch;
+	struct mmu_notifier_range range;
+	unsigned long start, end;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	unsigned int f_flags;
+	int ret;
+
+	start = (unsigned long)untagged_addr(start_addr);
+	if ((!IS_ALIGNED(start, PAGE_SIZE)) || !access_ok((void __user *)start, len))
+		return -EINVAL;
+
+	if ((flags == 0) || (flags == MEMWATCH_SD_NO_REUSED_REGIONS) ||
+	    (flags & ~MEMWATCH_SD_OPS_MASK))
+		return -EINVAL;
+
+	if ((flags & MEMWATCH_SD_GET) && ((vec_len == 0) || (!vec) ||
+	    !access_ok(vec, vec_len)))
+		return -EINVAL;
+
+	end = start + len;
+	watch.start = start;
+	watch.flags = flags;
+	watch.index = 0;
+	watch.vec_len = vec_len;
+
+	if (pidfd) {
+		task = pidfd_get_task(pidfd, &f_flags);
+		if (IS_ERR(task))
+			return PTR_ERR(task);
+	} else {
+		task = current;
+	}
+
+	if (flags & MEMWATCH_SD_GET) {
+		watch.vec = vzalloc(vec_len * sizeof(loff_t));
+		if (!watch.vec) {
+			ret = -ENOMEM;
+			goto put_task;
+		}
+	}
+
+	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	if (IS_ERR_OR_NULL(mm)) {
+		ret = mm ? PTR_ERR(mm) : -ESRCH;
+		goto free_watch;
+	}
+
+	if (flags & MEMWATCH_SD_CLEAR) {
+		mmap_write_lock(mm);
+
+		mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY, 0, NULL,
+					mm, start, end);
+		mmu_notifier_invalidate_range_start(&range);
+		inc_tlb_flush_pending(mm);
+	} else {
+		mmap_read_lock(mm);
+	}
+
+	ret = walk_page_range(mm, start, end, &memwatch_ops, &watch);
+
+	if (flags & MEMWATCH_SD_CLEAR) {
+		mmu_notifier_invalidate_range_end(&range);
+		dec_tlb_flush_pending(mm);
+
+		mmap_write_unlock(mm);
+	} else {
+		mmap_read_unlock(mm);
+	}
+
+	mmput(mm);
+
+	if (ret < 0)
+		goto free_watch;
+
+	if (flags & MEMWATCH_SD_GET) {
+		ret = copy_to_user(vec, watch.vec, watch.index * sizeof(loff_t));
+		if (ret) {
+			ret = -EIO;
+			goto free_watch;
+		}
+		ret = watch.index;
+	} else {
+		ret = 0;
+	}
+
+free_watch:
+	if (flags & MEMWATCH_SD_GET)
+		vfree(watch.vec);
+put_task:
+	if (pidfd)
+		put_task_struct(task);
+
+	return ret;
+}
+#endif
+
+SYSCALL_DEFINE6(process_memwatch, int, pidfd, void __user*, start,
+		int, len, unsigned int, flags, loff_t __user *, vec, int, vec_len)
+{
+	int ret = -EPERM;
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	ret = do_process_memwatch(pidfd, start, len, flags, vec, vec_len);
+#endif
+	return ret;
+}
-- 
2.30.2

