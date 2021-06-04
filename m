Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEF39B432
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFDHpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 03:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhFDHpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:45:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F71613BF;
        Fri,  4 Jun 2021 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622792614;
        bh=KcpDllYntCGEccutp+5+uZemHVbRkAgxD2H6s9Sfmx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atEAqQNRK3w6Us64by6BDZs96Zg0vjL24eHVXgF5CaC/dQKY5RJ4vg6dFgEtXWIy1
         Vz3hPkGrxuKuxTC8mKyaPqQOwXm2E8JX6uijBj9rg4GOxIRT2f30/XyrXWp04qHhOg
         4BsAI2HUs4jrxV8USZFkgdeeYF6qBMM9AcxZC0y7ERCEvWrmTBiXKr7m/POeiiF+WX
         pOdWzWfecIaqCOgFC7lD8U2NDHb8QDshrNu1ANdoyxEWhfpZK9Duxoy+ct/Eg7kHeL
         e+LvVeUWE10o9yHnYq+ZgOGlwRnjpJXjxtWSw2Qdw3+nBjK3TlekccWlolIagndP4I
         q/o5yK3kNKeAg==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 1/2] mm: make "vm_flags" be an u64
Date:   Fri,  4 Jun 2021 00:43:21 -0700
Message-Id: <1622792602-40459-2-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622792602-40459-1-git-send-email-mlin@kernel.org>
References: <1622792602-40459-1-git-send-email-mlin@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So we can have enough bits on 32-bit architectures.

Use vm_flags_t instead of "unsigned long".
Also fix build warnings for many print code.

Signed-off-by: Ming Lin <mlin@kernel.org>
---
 arch/arm64/Kconfig                        |   1 -
 arch/powerpc/Kconfig                      |   1 -
 arch/x86/Kconfig                          |   1 -
 drivers/android/binder.c                  |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c   |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c     |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c  |   4 +-
 fs/exec.c                                 |   2 +-
 fs/userfaultfd.c                          |   6 +-
 include/linux/huge_mm.h                   |   4 +-
 include/linux/ksm.h                       |   4 +-
 include/linux/mm.h                        | 106 ++++++++++++++----------------
 include/linux/mm_types.h                  |   6 +-
 include/linux/mman.h                      |   4 +-
 mm/Kconfig                                |   2 -
 mm/debug.c                                |   4 +-
 mm/khugepaged.c                           |   2 +-
 mm/ksm.c                                  |   2 +-
 mm/madvise.c                              |   2 +-
 mm/memory.c                               |   4 +-
 mm/mmap.c                                 |  10 +--
 mm/mprotect.c                             |   4 +-
 mm/mremap.c                               |   2 +-
 25 files changed, 87 insertions(+), 98 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d856..c6960ea 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1658,7 +1658,6 @@ config ARM64_MTE
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
 	depends on ARM64_PAN
-	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2a..5c1b49e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -940,7 +940,6 @@ config PPC_MEM_KEYS
 	prompt "PowerPC Memory Protection Keys"
 	def_bool y
 	depends on PPC_BOOK3S_64
-	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b..a885336 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1874,7 +1874,6 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	def_bool y
 	# Note: only available in 64-bit mode
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
-	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcec598..2a56b8b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4947,7 +4947,7 @@ static void binder_vma_open(struct vm_area_struct *vma)
 	struct binder_proc *proc = vma->vm_private_data;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
-		     "%d open vm area %lx-%lx (%ld K) vma %lx pagep %lx\n",
+		     "%d open vm area %lx-%lx (%ld K) vma %llx pagep %lx\n",
 		     proc->pid, vma->vm_start, vma->vm_end,
 		     (vma->vm_end - vma->vm_start) / SZ_1K, vma->vm_flags,
 		     (unsigned long)pgprot_val(vma->vm_page_prot));
@@ -4958,7 +4958,7 @@ static void binder_vma_close(struct vm_area_struct *vma)
 	struct binder_proc *proc = vma->vm_private_data;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
-		     "%d close vm area %lx-%lx (%ld K) vma %lx pagep %lx\n",
+		     "%d close vm area %lx-%lx (%ld K) vma %llx pagep %lx\n",
 		     proc->pid, vma->vm_start, vma->vm_end,
 		     (vma->vm_end - vma->vm_start) / SZ_1K, vma->vm_flags,
 		     (unsigned long)pgprot_val(vma->vm_page_prot));
@@ -4984,7 +4984,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
-		     "%s: %d %lx-%lx (%ld K) vma %lx pagep %lx\n",
+		     "%s: %d %lx-%lx (%ld K) vma %llx pagep %lx\n",
 		     __func__, proc->pid, vma->vm_start, vma->vm_end,
 		     (vma->vm_end - vma->vm_start) / SZ_1K, vma->vm_flags,
 		     (unsigned long)pgprot_val(vma->vm_page_prot));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 43de260..3a1726b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1957,7 +1957,7 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	pr_debug("pasid 0x%x mapping mmio page\n"
 		 "     target user address == 0x%08llX\n"
 		 "     physical address    == 0x%08llX\n"
-		 "     vm_flags            == 0x%04lX\n"
+		 "     vm_flags            == 0x%08llX\n"
 		 "     size                == 0x%04lX\n",
 		 process->pasid, (unsigned long long) vma->vm_start,
 		 address, vma->vm_flags, PAGE_SIZE);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 768d153..002462b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -150,7 +150,7 @@ int kfd_doorbell_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	pr_debug("Mapping doorbell page\n"
 		 "     target user address == 0x%08llX\n"
 		 "     physical address    == 0x%08llX\n"
-		 "     vm_flags            == 0x%04lX\n"
+		 "     vm_flags            == 0x%08llX\n"
 		 "     size                == 0x%04lX\n",
 		 (unsigned long long) vma->vm_start, address, vma->vm_flags,
 		 kfd_doorbell_process_slice(dev));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ba2c2ce..e25ff04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -808,7 +808,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
 	pr_debug("     start user address  == 0x%08lx\n", vma->vm_start);
 	pr_debug("     end user address    == 0x%08lx\n", vma->vm_end);
 	pr_debug("     pfn                 == 0x%016lX\n", pfn);
-	pr_debug("     vm_flags            == 0x%08lX\n", vma->vm_flags);
+	pr_debug("     vm_flags            == 0x%08llX\n", vma->vm_flags);
 	pr_debug("     size                == 0x%08lX\n",
 			vma->vm_end - vma->vm_start);
 
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 3b7bbc7..a40410f 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -569,7 +569,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 
 	vma->vm_flags = flags;
 	hfi1_cdbg(PROC,
-		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
+		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%llx\n",
 		    ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
 		    vma->vm_end - vma->vm_start, vma->vm_flags);
 	if (vmf) {
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index c60e79d..9bd34e6 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -846,7 +846,7 @@ static int mmap_rcvegrbufs(struct vm_area_struct *vma,
 
 	if (vma->vm_flags & VM_WRITE) {
 		qib_devinfo(dd->pcidev,
-			"Can't map eager buffers as writable (flags=%lx)\n",
+			"Can't map eager buffers as writable (flags=%llx)\n",
 			vma->vm_flags);
 		ret = -EPERM;
 		goto bail;
@@ -935,7 +935,7 @@ static int mmap_kvaddr(struct vm_area_struct *vma, u64 pgaddr,
 		/* rcvegrbufs are read-only on the slave */
 		if (vma->vm_flags & VM_WRITE) {
 			qib_devinfo(dd->pcidev,
-				 "Can't map eager buffers as writable (flags=%lx)\n",
+				 "Can't map eager buffers as writable (flags=%llx)\n",
 				 vma->vm_flags);
 			ret = -EPERM;
 			goto bail;
diff --git a/fs/exec.c b/fs/exec.c
index 18594f1..8dcf8a5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -748,7 +748,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
 	struct vm_area_struct *prev = NULL;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	unsigned long stack_base;
 	unsigned long stack_size;
 	unsigned long stack_expand;
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f9228..b958055 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -846,7 +846,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
-	unsigned long new_flags;
+	vm_flags_t new_flags;
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -1284,7 +1284,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags, new_flags;
+	vm_flags_t vm_flags, new_flags;
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
@@ -1510,7 +1510,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct vm_area_struct *vma, *prev, *cur;
 	int ret;
 	struct uffdio_range uffdio_unregister;
-	unsigned long new_flags;
+	vm_flags_t new_flags;
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9626fda..2f524f0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -215,7 +215,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
-int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
+int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
 		     int advice);
 void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, long adjust_next);
@@ -403,7 +403,7 @@ static inline void split_huge_pmd_address(struct vm_area_struct *vma,
 	do { } while (0)
 
 static inline int hugepage_madvise(struct vm_area_struct *vma,
-				   unsigned long *vm_flags, int advice)
+				   vm_flags_t *vm_flags, int advice)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 161e816..9f57409 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -20,7 +20,7 @@
 
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags);
+		unsigned long end, int advice, vm_flags_t *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
 
@@ -67,7 +67,7 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+		unsigned long end, int advice, vm_flags_t *vm_flags)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75..9e86ca1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -264,73 +264,68 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+#define VM_FLAGS_BIT(N)	(1ULL << (N))
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
 #define VM_NONE		0x00000000
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_READ		VM_FLAGS_BIT(0)	 /* currently active flags */
+#define VM_WRITE	VM_FLAGS_BIT(1)
+#define VM_EXEC		VM_FLAGS_BIT(2)
+#define VM_SHARED	VM_FLAGS_BIT(3)
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
-
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
-
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#define VM_MAYREAD	VM_FLAGS_BIT(4)	 /* limits for mprotect() etc */
+#define VM_MAYWRITE	VM_FLAGS_BIT(5)
+#define VM_MAYEXEC	VM_FLAGS_BIT(6)
+#define VM_MAYSHARE	VM_FLAGS_BIT(7)
+
+#define VM_GROWSDOWN	VM_FLAGS_BIT(8)	 /* general info on the segment */
+#define VM_UFFD_MISSING	VM_FLAGS_BIT(9)	 /* missing pages tracking */
+#define VM_PFNMAP	VM_FLAGS_BIT(10) /* Page-ranges managed without "struct page", just pure PFN */
+#define VM_DENYWRITE	VM_FLAGS_BIT(11) /* ETXTBSY on write attempts.. */
+#define VM_UFFD_WP	VM_FLAGS_BIT(12) /* wrprotect pages tracking */
+
+#define VM_LOCKED	VM_FLAGS_BIT(13)
+#define VM_IO           VM_FLAGS_BIT(14) /* Memory mapped I/O or similar */
+
+					 /* Used by sys_madvise() */
+#define VM_SEQ_READ	VM_FLAGS_BIT(15) /* App will access data sequentially */
+#define VM_RAND_READ	VM_FLAGS_BIT(16) /* App will not benefit from clustered reads */
+
+#define VM_DONTCOPY	VM_FLAGS_BIT(17) /* Do not copy this vma on fork */
+#define VM_DONTEXPAND	VM_FLAGS_BIT(18) /* Cannot expand with mremap() */
+#define VM_LOCKONFAULT	VM_FLAGS_BIT(19) /* Lock the pages covered when they are faulted in */
+#define VM_ACCOUNT	VM_FLAGS_BIT(20) /* Is a VM accounted object */
+#define VM_NORESERVE	VM_FLAGS_BIT(21) /* should the VM suppress accounting */
+#define VM_HUGETLB	VM_FLAGS_BIT(22) /* Huge TLB Page VM */
+#define VM_SYNC		VM_FLAGS_BIT(23) /* Synchronous page faults */
+#define VM_ARCH_1	VM_FLAGS_BIT(24) /* Architecture-specific flag */
+#define VM_WIPEONFORK	VM_FLAGS_BIT(25) /* Wipe VMA contents in child. */
+#define VM_DONTDUMP	VM_FLAGS_BIT(26) /* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+# define VM_SOFTDIRTY	VM_FLAGS_BIT(27) /* Not soft dirty clean area */
 #else
 # define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
-
-#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
-#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+#define VM_MIXEDMAP	VM_FLAGS_BIT(28) /* Can contain "struct page" and pure PFN pages */
+#define VM_HUGEPAGE	VM_FLAGS_BIT(29) /* MADV_HUGEPAGE marked this vma */
+#define VM_NOHUGEPAGE	VM_FLAGS_BIT(30) /* MADV_NOHUGEPAGE marked this vma */
+#define VM_MERGEABLE	VM_FLAGS_BIT(31) /* KSM may merge identical pages */
+
+#define VM_HIGH_ARCH_0	VM_FLAGS_BIT(32)
+#define VM_HIGH_ARCH_1	VM_FLAGS_BIT(33)
+#define VM_HIGH_ARCH_2	VM_FLAGS_BIT(34)
+#define VM_HIGH_ARCH_3	VM_FLAGS_BIT(35)
+#define VM_HIGH_ARCH_4	VM_FLAGS_BIT(36)
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
+# define VM_PKEY_SHIFT	32
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
@@ -373,8 +368,7 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	37
-# define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
+# define VM_UFFD_MINOR		VM_FLAGS_BIT(37)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
@@ -1894,7 +1888,7 @@ extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
-			  unsigned long end, unsigned long newflags);
+			  unsigned long end, vm_flags_t newflags);
 
 /*
  * doesn't attempt to fault and will return short.
@@ -2545,7 +2539,7 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 }
 extern struct vm_area_struct *vma_merge(struct mm_struct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
+	vm_flags_t vm_flags, struct anon_vma *, struct file *, pgoff_t,
 	struct mempolicy *, struct vm_userfaultfd_ctx);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
@@ -2626,7 +2620,7 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
 
 /* These take the mm semaphore themselves */
 extern int __must_check vm_brk(unsigned long, unsigned long);
-extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
+extern int __must_check vm_brk_flags(unsigned long, unsigned long, vm_flags_t);
 extern int vm_munmap(unsigned long, size_t);
 extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
         unsigned long, unsigned long,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c..cb612d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -264,7 +264,7 @@ struct page_frag_cache {
 	bool pfmemalloc;
 };
 
-typedef unsigned long vm_flags_t;
+typedef u64 vm_flags_t;
 
 /*
  * A region containing a mapping of a non-memory backed file under NOMMU
@@ -330,7 +330,7 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+	vm_flags_t vm_flags;			/* Flags, see mm.h. */
 
 	/*
 	 * For areas with an address space and backing store,
@@ -478,7 +478,7 @@ struct mm_struct {
 		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
 		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
 		unsigned long stack_vm;	   /* VM_STACK */
-		unsigned long def_flags;
+		vm_flags_t def_flags;
 
 		spinlock_t arg_lock; /* protect the below fields */
 		unsigned long start_code, end_code, start_data, end_data;
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 629cefc..b2cbae9 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -135,7 +135,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 /*
  * Combine the mmap "prot" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
 {
 	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
@@ -147,7 +147,7 @@ static inline bool arch_validate_flags(unsigned long flags)
 /*
  * Combine the mmap "flags" argument into "vm_flags" used internally.
  */
-static inline unsigned long
+static inline vm_flags_t
 calc_vm_flag_bits(unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
diff --git a/mm/Kconfig b/mm/Kconfig
index 02d44e3..aa8efba 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -830,8 +830,6 @@ config DEVICE_PRIVATE
 config VMAP_PFN
 	bool
 
-config ARCH_USES_HIGH_VMA_FLAGS
-	bool
 config ARCH_HAS_PKEYS
 	bool
 
diff --git a/mm/debug.c b/mm/debug.c
index 0bdda84..6165b5f 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -202,7 +202,7 @@ void dump_vma(const struct vm_area_struct *vma)
 		"next %px prev %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
-		"flags: %#lx(%pGv)\n",
+		"flags: %#llx(%pGv)\n",
 		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
 		vma->vm_prev, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
@@ -240,7 +240,7 @@ void dump_mm(const struct mm_struct *mm)
 		"numa_next_scan %lu numa_scan_offset %lu numa_scan_seq %d\n"
 #endif
 		"tlb_flush_pending %d\n"
-		"def_flags: %#lx(%pGv)\n",
+		"def_flags: %#llx(%pGv)\n",
 
 		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
 #ifdef CONFIG_MMU
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185f..ad76bde 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -345,7 +345,7 @@ struct attribute_group khugepaged_attr_group = {
 #endif /* CONFIG_SYSFS */
 
 int hugepage_madvise(struct vm_area_struct *vma,
-		     unsigned long *vm_flags, int advice)
+		     vm_flags_t *vm_flags, int advice)
 {
 	switch (advice) {
 	case MADV_HUGEPAGE:
diff --git a/mm/ksm.c b/mm/ksm.c
index 2f3aaeb..257147c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2431,7 +2431,7 @@ static int ksm_scan_thread(void *nothing)
 }
 
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+		unsigned long end, int advice, vm_flags_t *vm_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
diff --git a/mm/madvise.c b/mm/madvise.c
index 63e489e..5105393 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -71,7 +71,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	int error = 0;
 	pgoff_t pgoff;
-	unsigned long new_flags = vma->vm_flags;
+	vm_flags_t new_flags = vma->vm_flags;
 
 	switch (behavior) {
 	case MADV_NORMAL:
diff --git a/mm/memory.c b/mm/memory.c
index 730daa0..8d5e583 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -550,7 +550,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
 	if (page)
 		dump_page(page, "bad pte");
-	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
+	pr_alert("addr:%px vm_flags:%08llx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps readpage:%ps\n",
 		 vma->vm_file,
@@ -1241,7 +1241,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			struct page *page;
 
 			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(details) && page) {
+			if (unlikely(details) && page && !(vma->vm_flags & VM_NOSIGBUS)) {
 				/*
 				 * unmap_shared_mapping_pages() wants to
 				 * invalidate cache without truncating:
diff --git a/mm/mmap.c b/mm/mmap.c
index 0584e54..8bed547 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -191,7 +191,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	return next;
 }
 
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
+static int do_brk_flags(unsigned long addr, unsigned long request, vm_flags_t flags,
 		struct list_head *uf);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
@@ -1160,7 +1160,7 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
  */
 struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
+			unsigned long end, vm_flags_t vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
 			pgoff_t pgoff, struct mempolicy *policy,
 			struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
@@ -1353,7 +1353,7 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 }
 
 static inline int mlock_future_check(struct mm_struct *mm,
-				     unsigned long flags,
+				     vm_flags_t flags,
 				     unsigned long len)
 {
 	unsigned long locked, lock_limit;
@@ -3050,7 +3050,7 @@ int vm_munmap(unsigned long start, size_t len)
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long flags, struct list_head *uf)
+static int do_brk_flags(unsigned long addr, unsigned long len, vm_flags_t flags, struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -3118,7 +3118,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	return 0;
 }
 
-int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
+int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t flags)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long len;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e7a4431..0433db7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -397,10 +397,10 @@ static int prot_none_test(unsigned long addr, unsigned long next,
 
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
-	unsigned long start, unsigned long end, unsigned long newflags)
+	unsigned long start, unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long oldflags = vma->vm_flags;
+	vm_flags_t oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	pgoff_t pgoff;
diff --git a/mm/mremap.c b/mm/mremap.c
index 47c255b..bf9a661 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -489,7 +489,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma;
-	unsigned long vm_flags = vma->vm_flags;
+	vm_flags_t vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
 	unsigned long excess = 0;
-- 
1.8.3.1

