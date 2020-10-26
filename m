Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147A729887F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 09:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771890AbgJZIiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 04:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771883AbgJZIiw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:38:52 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B492240C;
        Mon, 26 Oct 2020 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603701530;
        bh=Pwsl8Tc6EOVzoiyLnDUdSZUlR28vyyInnMICPpQnLKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJKjKlMFdxXjbP2LcLE+ZVscbQ9oin6fqRoDXp90Hzf2oYUMikyA20S7dGZJrnWYN
         ctiAwtPFoKGmpPh14rfVtjvxzdiw45J9wR6+5YeGNaxepjcOpg91F3cMsEMAHb7Js/
         x4blDsii9GulxAp6wFHbUvLcjq5r1eIq2WJ+ykuE=
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v7 4/7] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Mon, 26 Oct 2020 10:37:49 +0200
Message-Id: <20201026083752.13267-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026083752.13267-1-rppt@kernel.org>
References: <20201026083752.13267-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Introduce "memfd_secret" system call with the ability to create memory
areas visible only in the context of the owning process and not mapped not
only to other processes but in the kernel page tables as well.

The user will create a file descriptor using the memfd_secret() system call
where flags supplied as a parameter to this system call will define the
desired protection mode for the memory associated with that file
descriptor.

The secret memory remains accessible in the process context using uaccess
primitives, but it is not accessible using direct/linear map addresses.

Functions in the follow_page()/get_user_page() family will refuse to return
a page that belongs to the secret memory area.

 Currently there are two protection modes:

* exclusive - the memory area is unmapped from the kernel direct map and it
              is present only in the page tables of the owning mm.
* uncached  - the memory area is present only in the page tables of the
              owning mm and it is mapped there as uncached.

The "exclusive" mode is enabled implicitly and it is the default mode for
memfd_secret().

The "uncached" mode requires architecture support and an architecture
should opt-in for this mode using HAVE_SECRETMEM_UNCACHED configuration
option.

For instance, the following example will create an uncached mapping (error
handling is omitted):

	fd = memfd_secret(SECRETMEM_UNCACHED);
	ftruncate(fd, MAP_SIZE);
	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/Kconfig                   |   7 +
 arch/x86/Kconfig               |   1 +
 include/uapi/linux/magic.h     |   1 +
 include/uapi/linux/secretmem.h |   8 +
 kernel/sys_ni.c                |   2 +
 mm/Kconfig                     |   4 +
 mm/Makefile                    |   1 +
 mm/gup.c                       |  10 ++
 mm/secretmem.c                 | 279 +++++++++++++++++++++++++++++++++
 9 files changed, 313 insertions(+)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..3da5727fe403 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1028,6 +1028,13 @@ config HAVE_STATIC_CALL_INLINE
 	bool
 	depends on HAVE_STATIC_CALL
 
+config HAVE_SECRETMEM_UNCACHED
+	bool
+	help
+	  An architecture can select this if its semantics of non-cached
+	  mappings can be used to prevent speculative loads and it is
+	  useful for secret protection.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..8aca235f338b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -222,6 +222,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select HAVE_SECRETMEM_UNCACHED
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
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
diff --git a/include/uapi/linux/secretmem.h b/include/uapi/linux/secretmem.h
new file mode 100644
index 000000000000..7cf9492c70d2
--- /dev/null
+++ b/include/uapi/linux/secretmem.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_SECRETMEM_H
+#define _UAPI_LINUX_SECRETMEM_H
+
+/* secretmem operation modes */
+#define SECRETMEM_UNCACHED	0x1
+
+#endif /* _UAPI_LINUX_SECRETMEM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f27ac94d5fa7..3cb8a45879cc 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -350,6 +350,8 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* memfd_secret */
+COND_SYSCALL(memfd_secret);
 
 /*
  * Architecture specific weak syscall entries.
diff --git a/mm/Kconfig b/mm/Kconfig
index d42423f884a7..a0f278d13eb5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,8 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config SECRETMEM
+	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+	select GENERIC_ALLOCATOR
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d73aed0fc99c..8d3ffbc372b1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_SECRETMEM) += secretmem.o
diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4..92b43c838d45 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -10,6 +10,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/secretmem.h>
 
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
@@ -793,6 +794,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	struct follow_page_context ctx = { NULL };
 	struct page *page;
 
+	if (vma_is_secretmem(vma))
+		return NULL;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -923,6 +927,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
 		return -EFAULT;
 
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
@@ -2188,6 +2195,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
+		if (page_is_secretmem(page))
+			goto pte_unmap;
+
 		head = try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
diff --git a/mm/secretmem.c b/mm/secretmem.c
new file mode 100644
index 000000000000..2a63db2ed132
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corporation, 2020
+ *
+ * Author: Mike Rapoport <rppt@linux.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/memfd.h>
+#include <linux/bitops.h>
+#include <linux/printk.h>
+#include <linux/pagemap.h>
+#include <linux/syscalls.h>
+#include <linux/pseudo_fs.h>
+#include <linux/set_memory.h>
+#include <linux/sched/signal.h>
+
+#include <uapi/linux/secretmem.h>
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
+ * Secret memory areas are always exclusive to owning mm and they are
+ * removed from the direct map.
+ */
+#ifdef CONFIG_HAVE_SECRETMEM_UNCACHED
+#define SECRETMEM_MODE_MASK	(SECRETMEM_UNCACHED)
+#else
+#define SECRETMEM_MODE_MASK	(0x0)
+#endif
+
+#define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
+
+struct secretmem_ctx {
+	unsigned int mode;
+};
+
+static struct page *secretmem_alloc_page(gfp_t gfp)
+{
+	/*
+	 * FIXME: use a cache of large pages to reduce the direct map
+	 * fragmentation
+	 */
+	return alloc_page(gfp);
+}
+
+static vm_fault_t secretmem_fault(struct vm_fault *vmf)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	pgoff_t offset = vmf->pgoff;
+	unsigned long addr;
+	struct page *page;
+	int ret = 0;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return vmf_error(-EINVAL);
+
+	page = find_get_entry(mapping, offset);
+	if (!page) {
+		page = secretmem_alloc_page(vmf->gfp_mask);
+		if (!page)
+			return vmf_error(-ENOMEM);
+
+		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
+		if (unlikely(ret))
+			goto err_put_page;
+
+		ret = set_direct_map_invalid_noflush(page, 1);
+		if (ret)
+			goto err_del_page_cache;
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+		__SetPageUptodate(page);
+
+		ret = VM_FAULT_LOCKED;
+	}
+
+	vmf->page = page;
+	return ret;
+
+err_del_page_cache:
+	delete_from_page_cache(page);
+err_put_page:
+	put_page(page);
+	return vmf_error(ret);
+}
+
+static const struct vm_operations_struct secretmem_vm_ops = {
+	.fault = secretmem_fault,
+};
+
+static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct secretmem_ctx *ctx = file->private_data;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
+	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+		return -EAGAIN;
+
+	if (ctx->mode & SECRETMEM_UNCACHED)
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	vma->vm_ops = &secretmem_vm_ops;
+	vma->vm_flags |= VM_LOCKED;
+
+	return 0;
+}
+
+bool vma_is_secretmem(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &secretmem_vm_ops;
+}
+
+const struct file_operations secretmem_fops = {
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
+}
+
+static const struct address_space_operations secretmem_aops = {
+	.freepage	= secretmem_freepage,
+	.migratepage	= secretmem_migratepage,
+	.isolate_page	= secretmem_isolate_page,
+};
+
+bool page_is_secretmem(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	if (!mapping)
+		return false;
+
+	return mapping->a_ops == &secretmem_aops;
+}
+
+static struct vfsmount *secretmem_mnt;
+
+static struct file *secretmem_file_create(unsigned long flags)
+{
+	struct file *file = ERR_PTR(-ENOMEM);
+	struct secretmem_ctx *ctx;
+	struct inode *inode;
+
+	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		goto err_free_inode;
+
+	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
+				 O_RDWR, &secretmem_fops);
+	if (IS_ERR(file))
+		goto err_free_ctx;
+
+	mapping_set_unevictable(inode->i_mapping);
+
+	inode->i_mapping->private_data = ctx;
+	inode->i_mapping->a_ops = &secretmem_aops;
+
+	/* pretend we are a normal file with zero size */
+	inode->i_mode |= S_IFREG;
+	inode->i_size = 0;
+
+	file->private_data = ctx;
+
+	ctx->mode = flags & SECRETMEM_MODE_MASK;
+
+	return file;
+
+err_free_ctx:
+	kfree(ctx);
+err_free_inode:
+	iput(inode);
+	return file;
+}
+
+SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
+{
+	struct file *file;
+	int fd, err;
+
+	/* make sure local flags do not confict with global fcntl.h */
+	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
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
+static void secretmem_evict_inode(struct inode *inode)
+{
+	struct secretmem_ctx *ctx = inode->i_private;
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+	kfree(ctx);
+}
+
+static const struct super_operations secretmem_super_ops = {
+	.evict_inode = secretmem_evict_inode,
+};
+
+static int secretmem_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, SECRETMEM_MAGIC);
+
+	if (!ctx)
+		return -ENOMEM;
+	ctx->ops = &secretmem_super_ops;
+
+	return 0;
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
+	secretmem_mnt = kern_mount(&secretmem_fs);
+	if (IS_ERR(secretmem_mnt))
+		ret = PTR_ERR(secretmem_mnt);
+
+	return ret;
+}
+fs_initcall(secretmem_init);
-- 
2.28.0

