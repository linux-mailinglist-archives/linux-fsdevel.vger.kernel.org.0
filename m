Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0D37FD84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEMSuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 14:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231793AbhEMSt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 14:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2003461404;
        Thu, 13 May 2021 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620931728;
        bh=VtJAYfyrc3gxC/XvOCaw01neY2bi3oqkVkh87QwQCkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM6iH+Gl39bM4/FopxJ84lTTSyi2wAjOhgInqaoCIpLZ9+5/7yJ8FkKeQeWoJKMiT
         tf1c94BKgmx4Xs3r90wqw25CxsH2B7+VsBMqFr0LVC2Y4rXIrEvy1VQ05zAhOet/c7
         2eZeoTa8gWbqBHDrWZAsRmgk6vR+eHOymx2CW71jYl7XmIGBPnDFcOXEimTXAQv2Z/
         zArzIyBzaJ+ZVRHHvKZrmzTUrbtYhZ++20IUf8kSqVW2qg+mVVoC5CyhGNy/wPux6u
         +GsoJifvOPJuA5N7Ub7u333FACy4oARfbTLqUDLNAwO98LvzMcYkgne7TxG/JTOtZU
         yJvNs23pwaGtA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v19 5/8] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Thu, 13 May 2021 21:47:31 +0300
Message-Id: <20210513184734.29317-6-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513184734.29317-1-rppt@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Introduce "memfd_secret" system call with the ability to create memory
areas visible only in the context of the owning process and not mapped not
only to other processes but in the kernel page tables as well.

The secretmem feature is off by default and the user must explicitly enable
it at the boot time.

Once secretmem is enabled, the user will be able to create a file
descriptor using the memfd_secret() system call. The memory areas created
by mmap() calls from this file descriptor will be unmapped from the kernel
direct map and they will be only mapped in the page table of the processes
that have access to the file descriptor.

The file descriptor based memory has several advantages over the
"traditional" mm interfaces, such as mlock(), mprotect(), madvise(). File
descriptor approach allows explict and controlled sharing of the memory
areas, it allows to seal the operations. Besides, file descriptor based
memory paves the way for VMMs to remove the secret memory range from the
userpace hipervisor process, for instance QEMU. Andy Lutomirski says:

  "Getting fd-backed memory into a guest will take some possibly major work
   in the kernel, but getting vma-backed memory into a guest without
   mapping it in the host user address space seems much, much worse."

memfd_secret() is made a dedicated system call rather than an extention to
memfd_create() because it's purpose is to allow the user to create more
secure memory mappings rather than to simply allow file based access to the
memory. Nowadays a new system call cost is negligible while it is way
simpler for userspace to deal with a clear-cut system calls than with a
multiplexer or an overloaded syscall. Moreover, the initial implementation
of memfd_secret() is completely distinct from memfd_create() so there is no
much sense in overloading memfd_create() to begin with. If there will be a
need for code sharing between these implementation it can be easily
achieved without a need to adjust user visible APIs.

The secret memory remains accessible in the process context using uaccess
primitives, but it is not exposed to the kernel otherwise; secret memory
areas are removed from the direct map and functions in the
follow_page()/get_user_page() family will refuse to return a page that
belongs to the secret memory area.

Once there will be a use case that will require exposing secretmem to the
kernel it will be an opt-in request in the system call flags so that user
would have to decide what data can be exposed to the kernel.

Removing of the pages from the direct map may cause its fragmentation on
architectures that use large pages to map the physical memory which affects
the system performance. However, the original Kconfig text for
CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct map "... can
improve the kernel's performance a tiny bit ..." (commit 00d1c5e05736
("x86: add gbpages switches")) and the recent report [1] showed that "...
although 1G mappings are a good default choice, there is no compelling
evidence that it must be the only choice". Hence, it is sufficient to have
secretmem disabled by default with the ability of a system administrator to
enable it at boot time.

Pages in the secretmem regions are unevictable and unmovable to avoid
accidental exposure of the sensitive data via swap or during page
migration.

Since the secretmem mappings are locked in memory they cannot exceed
RLIMIT_MEMLOCK. Since these mappings are already locked independently from
mlock(), an attempt to mlock()/munlock() secretmem range would fail and
mlockall()/munlockall() will ignore secretmem mappings.

However, unlike mlock()ed memory, secretmem currently behaves more like
long-term GUP: secretmem mappings are unmovable mappings directly consumed
by user space. With default limits, there is no excessive use of secretmem
and it poses no real problem in combination with ZONE_MOVABLE/CMA, but in
the future this should be addressed to allow balanced use of large amounts
of secretmem along with ZONE_MOVABLE/CMA.

A page that was a part of the secret memory area is cleared when it is
freed to ensure the data is not exposed to the next user of that page.

The following example demonstrates creation of a secret mapping (error
handling is omitted):

	fd = memfd_secret(0);
	ftruncate(fd, MAP_SIZE);
	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
		   MAP_SHARED, fd, 0);

[1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 drivers/char/mem.c         |   4 +
 include/linux/secretmem.h  |  48 ++++++++
 include/uapi/linux/magic.h |   1 +
 kernel/sys_ni.c            |   2 +
 mm/Kconfig                 |   4 +
 mm/Makefile                |   1 +
 mm/gup.c                   |  12 ++
 mm/mlock.c                 |   3 +-
 mm/secretmem.c             | 239 +++++++++++++++++++++++++++++++++++++
 9 files changed, 313 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/secretmem.h
 create mode 100644 mm/secretmem.c

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 15dc54fa1d47..95741f93a6cd 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -31,6 +31,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/secretmem.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -64,6 +65,9 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 #ifdef CONFIG_STRICT_DEVMEM
 static inline int page_is_allowed(unsigned long pfn)
 {
+	if (pfn_valid(pfn) && page_is_secretmem(pfn_to_page(pfn)))
+		return 0;
+
 	return devmem_is_allowed(pfn);
 }
 static inline int range_is_allowed(unsigned long pfn, unsigned long size)
diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
new file mode 100644
index 000000000000..e617b4afcc62
--- /dev/null
+++ b/include/linux/secretmem.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_SECRETMEM_H
+#define _LINUX_SECRETMEM_H
+
+#ifdef CONFIG_SECRETMEM
+
+extern const struct address_space_operations secretmem_aops;
+
+static inline bool page_is_secretmem(struct page *page)
+{
+	struct address_space *mapping;
+
+	/*
+	 * Using page_mapping() is quite slow because of the actual call
+	 * instruction and repeated compound_head(page) inside the
+	 * page_mapping() function.
+	 * We know that secretmem pages are not compound and LRU so we can
+	 * save a couple of cycles here.
+	 */
+	if (PageCompound(page) || !PageLRU(page))
+		return false;
+
+	mapping = (struct address_space *)
+		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
+
+	if (mapping != page->mapping)
+		return false;
+
+	return mapping->a_ops == &secretmem_aops;
+}
+
+bool vma_is_secretmem(struct vm_area_struct *vma);
+
+#else
+
+static inline bool vma_is_secretmem(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline bool page_is_secretmem(struct page *page)
+{
+	return false;
+}
+
+#endif /* CONFIG_SECRETMEM */
+
+#endif /* _LINUX_SECRETMEM_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f3956fc11de6..35687dcb1a42 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -97,5 +97,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
+#define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ea8128468c3..4d7e377a74f3 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -358,6 +358,8 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* memfd_secret */
+COND_SYSCALL(memfd_secret);
 
 /*
  * Architecture specific weak syscall entries.
diff --git a/mm/Kconfig b/mm/Kconfig
index 02d44e3420f5..f61e7d33c7bf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -901,4 +901,8 @@ config KMAP_LOCAL
 # struct io_mapping based helper.  Selected by drivers that need them
 config IO_MAPPING
 	bool
+
+config SECRETMEM
+	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index bf71e295e9f6..7bb6ed5e42e8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -125,3 +125,4 @@ obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
+obj-$(CONFIG_SECRETMEM) += secretmem.o
diff --git a/mm/gup.c b/mm/gup.c
index 0697134b6a12..6515f82b0f32 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -10,6 +10,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/secretmem.h>
 
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
@@ -816,6 +817,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	struct follow_page_context ctx = { NULL };
 	struct page *page;
 
+	if (vma_is_secretmem(vma))
+		return NULL;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -949,6 +953,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
@@ -2077,6 +2084,11 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (!head)
 			goto pte_unmap;
 
+		if (unlikely(page_is_secretmem(page))) {
+			put_compound_head(head, 1, flags);
+			goto pte_unmap;
+		}
+
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 			put_compound_head(head, 1, flags);
 			goto pte_unmap;
diff --git a/mm/mlock.c b/mm/mlock.c
index df590fda5688..5e9f4dea4e96 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -23,6 +23,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
+#include <linux/secretmem.h>
 
 #include "internal.h"
 
@@ -503,7 +504,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 
 	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma))
+	    vma_is_dax(vma) || vma_is_secretmem(vma))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
new file mode 100644
index 000000000000..1ae50089adf1
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corporation, 2021
+ *
+ * Author: Mike Rapoport <rppt@linux.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/swap.h>
+#include <linux/mount.h>
+#include <linux/memfd.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <linux/pagemap.h>
+#include <linux/syscalls.h>
+#include <linux/pseudo_fs.h>
+#include <linux/secretmem.h>
+#include <linux/set_memory.h>
+#include <linux/sched/signal.h>
+
+#include <uapi/linux/magic.h>
+
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "secretmem: " fmt
+
+/*
+ * Define mode and flag masks to allow validation of the system call
+ * parameters.
+ */
+#define SECRETMEM_MODE_MASK	(0x0)
+#define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
+
+static bool secretmem_enable __ro_after_init;
+module_param_named(enable, secretmem_enable, bool, 0400);
+MODULE_PARM_DESC(secretmem_enable,
+		 "Enable secretmem and memfd_secret(2) system call");
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	pgoff_t offset = vmf->pgoff;
+	gfp_t gfp = vmf->gfp_mask;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return vmf_error(-EINVAL);
+
+retry:
+	page = find_lock_page(mapping, offset);
+	if (!page) {
+		page = alloc_page(gfp | __GFP_ZERO);
+		if (!page)
+			return VM_FAULT_OOM;
+
+		err = set_direct_map_invalid_noflush(page, 1);
+		if (err) {
+			put_page(page);
+			return vmf_error(err);
+		}
+
+		__SetPageUptodate(page);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp);
+		if (unlikely(err)) {
+			put_page(page);
+			/*
+			 * If a split of large page was required, it
+			 * already happened when we marked the page invalid
+			 * which guarantees that this call won't fail
+			 */
+			set_direct_map_default_noflush(page, 1);
+			if (err == -EEXIST)
+				goto retry;
+
+			return vmf_error(err);
+		}
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	}
+
+	vmf->page = page;
+	return VM_FAULT_LOCKED;
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+};
+
+static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
+	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+		return -EAGAIN;
+
+	vma->vm_flags |= VM_LOCKED | VM_DONTDUMP;
+	vma->vm_ops = &secretmem_vm_ops;
+
+	return 0;
+}
+
+bool vma_is_secretmem(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &secretmem_vm_ops;
+}
+
+static const struct file_operations secretmem_fops = {
+	.mmap		= secretmem_mmap,
+};
+
+static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
+{
+	return false;
+}
+
+static int secretmem_migratepage(struct address_space *mapping,
+				 struct page *newpage, struct page *page,
+				 enum migrate_mode mode)
+{
+	return -EBUSY;
+}
+
+static void secretmem_freepage(struct page *page)
+{
+	set_direct_map_default_noflush(page, 1);
+	clear_highpage(page);
+}
+
+const struct address_space_operations secretmem_aops = {
+	.freepage	= secretmem_freepage,
+	.migratepage	= secretmem_migratepage,
+	.isolate_page	= secretmem_isolate_page,
+};
+
+static struct vfsmount *secretmem_mnt;
+
+static struct file *secretmem_file_create(unsigned long flags)
+{
+	struct file *file = ERR_PTR(-ENOMEM);
+	struct inode *inode;
+
+	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
+				 O_RDWR, &secretmem_fops);
+	if (IS_ERR(file))
+		goto err_free_inode;
+
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_unevictable(inode->i_mapping);
+
+	inode->i_mapping->a_ops = &secretmem_aops;
+
+	/* pretend we are a normal file with zero size */
+	inode->i_mode |= S_IFREG;
+	inode->i_size = 0;
+
+	return file;
+
+err_free_inode:
+	iput(inode);
+	return file;
+}
+
+SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
+{
+	struct file *file;
+	int fd, err;
+
+	/* make sure local flags do not confict with global fcntl.h */
+	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
+
+	if (!secretmem_enable)
+		return -ENOSYS;
+
+	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
+		return -EINVAL;
+
+	fd = get_unused_fd_flags(flags & O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	file = secretmem_file_create(flags);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+
+	fd_install(fd, file);
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+	return err;
+}
+
+static int secretmem_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type secretmem_fs = {
+	.name		= "secretmem",
+	.init_fs_context = secretmem_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int secretmem_init(void)
+{
+	int ret = 0;
+
+	if (!secretmem_enable)
+		return ret;
+
+	secretmem_mnt = kern_mount(&secretmem_fs);
+	if (IS_ERR(secretmem_mnt))
+		ret = PTR_ERR(secretmem_mnt);
+
+	/* prevent secretmem mappings from ever getting PROT_EXEC */
+	secretmem_mnt->mnt_flags |= MNT_NOEXEC;
+
+	return ret;
+}
+fs_initcall(secretmem_init);
-- 
2.28.0

