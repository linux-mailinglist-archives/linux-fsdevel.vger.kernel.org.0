Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E02FD80A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbhATSOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391885AbhATSIF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:08:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3001233FE;
        Wed, 20 Jan 2021 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611166043;
        bh=4YvS0l9ZltriJWgmrfL3AgQinHOWaDlCYnJEzu2Ekg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYlVokO/sG2wQGhkV7oxVSkUcXToE2DnCTTAcUETUchiTkPf8hzUo4Rp6oub+ZqMC
         ZZvXgQEJiTuV42j5FyB/u3R9ou2hrHWAamCOCVPk2S+/9QdmsPRRqWxIqhAAh3iU+e
         EvogblHJeNDhv6aui4x5PX56OGTDMF9SitNT24k9dY2edS/qloxVuyc6LrahnegH/p
         VnNKft5JTNEd0MfFaFRzCCxx/F/Tjm3roF5vt/WyH0b5rGZnxUlyfGwABKZH7Kk+zj
         dE09IT4MNkM0Vxh91uQRDgM6CHoWFacMxh/Q6uDC++8BDnciHgHM9164FQD868+vn6
         TeCXKcB+AETog==
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
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v15 06/11] mm: introduce memfd_secret system call to create "secret" memory areas
Date:   Wed, 20 Jan 2021 20:06:07 +0200
Message-Id: <20210120180612.1058-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210120180612.1058-1-rppt@kernel.org>
References: <20210120180612.1058-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Introduce "memfd_secret" system call with the ability to create memory
areas visible only in the context of the owning process and not mapped not
only to other processes but in the kernel page tables as well.

The user will create a file descriptor using the memfd_secret() system
call. The memory areas created by mmap() calls from this file descriptor
will be unmapped from the kernel direct map and they will be only mapped in
the page table of the owning mm.

The secret memory remains accessible in the process context using uaccess
primitives, but it is not accessible using direct/linear map addresses.

Functions in the follow_page()/get_user_page() family will refuse to return
a page that belongs to the secret memory area.

A page that was a part of the secret memory area is cleared when it is
freed.

The following example demonstrates creation of a secret mapping (error
handling is omitted):

	fd = memfd_secret(0);
	ftruncate(fd, MAP_SIZE);
	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

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
Cc: David Hildenbrand <david@redhat.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
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
 include/linux/secretmem.h  |  24 ++++
 include/uapi/linux/magic.h |   1 +
 kernel/sys_ni.c            |   2 +
 mm/Kconfig                 |   3 +
 mm/Makefile                |   1 +
 mm/gup.c                   |  10 ++
 mm/secretmem.c             | 276 +++++++++++++++++++++++++++++++++++++
 7 files changed, 317 insertions(+)
 create mode 100644 include/linux/secretmem.h
 create mode 100644 mm/secretmem.c

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
new file mode 100644
index 000000000000..70e7db9f94fe
--- /dev/null
+++ b/include/linux/secretmem.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_SECRETMEM_H
+#define _LINUX_SECRETMEM_H
+
+#ifdef CONFIG_SECRETMEM
+
+bool vma_is_secretmem(struct vm_area_struct *vma);
+bool page_is_secretmem(struct page *page);
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
index 769ad6225ab1..869aa6b5bf34 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -355,6 +355,8 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* memfd_secret */
+COND_SYSCALL(memfd_secret);
 
 /*
  * Architecture specific weak syscall entries.
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..5f8243442f66 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,7 @@ config MAPPING_DIRTY_HELPERS
 config KMAP_LOCAL
 	bool
 
+config SECRETMEM
+	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..b2a564eec27f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_SECRETMEM) += secretmem.o
diff --git a/mm/gup.c b/mm/gup.c
index e4c224cd9661..3e086b073624 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -10,6 +10,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/secretmem.h>
 
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
@@ -759,6 +760,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	struct follow_page_context ctx = { NULL };
 	struct page *page;
 
+	if (vma_is_secretmem(vma))
+		return NULL;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -892,6 +896,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
@@ -2031,6 +2038,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
index 000000000000..2b4c20113412
--- /dev/null
+++ b/mm/secretmem.c
@@ -0,0 +1,276 @@
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
+	int err;
+
+	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
+		return vmf_error(-EINVAL);
+
+retry:
+	page = find_lock_page(mapping, offset);
+	if (!page) {
+		page = secretmem_alloc_page(vmf->gfp_mask);
+		if (!page)
+			return VM_FAULT_OOM;
+
+		err = set_direct_map_invalid_noflush(page, 1);
+		if (err)
+			return vmf_error(err);
+
+		__SetPageUptodate(page);
+		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
+		if (unlikely(err)) {
+			put_page(page);
+			if (err == -EEXIST)
+				goto retry;
+			goto err_restore_direct_map;
+		}
+
+		addr = (unsigned long)page_address(page);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	}
+
+	vmf->page = page;
+	return VM_FAULT_LOCKED;
+
+err_restore_direct_map:
+	/*
+	 * If a split of large page was required, it already happened
+	 * when we marked the page invalid which guarantees that this call
+	 * won't fail
+	 */
+	set_direct_map_default_noflush(page, 1);
+	return vmf_error(err);
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

