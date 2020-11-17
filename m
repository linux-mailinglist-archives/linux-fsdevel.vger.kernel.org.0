Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8442B6A30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 17:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgKQQap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 11:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgKQQao (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:30:44 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CF224686;
        Tue, 17 Nov 2020 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605630642;
        bh=t8+CG9uImG+jx42xaZW3Lx0tl2DbM1OgovkRrtLhfSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaaXR0s/jU+CecEBhCR62e5pV86qFRcQ6T2SiJkBK9g6d0Z0hEK9/D6/dnzDBzdd6
         iG34tCa8xMZUvS/v7sVzxFPWE0ZQgekUWsp6r+yU+zdI7+2k8EOxYazfzEJ3M6myZ+
         7wPFiBCTXZCM11tdzzXauargEM6I8DV7kzISZwl4=
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
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v9 5/9] secretmem: use PMD-size pages to amortize direct map fragmentation
Date:   Tue, 17 Nov 2020 18:29:28 +0200
Message-Id: <20201117162932.13649-6-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117162932.13649-1-rppt@kernel.org>
References: <20201117162932.13649-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Removing a PAGE_SIZE page from the direct map every time such page is
allocated for a secret memory mapping will cause severe fragmentation of
the direct map. This fragmentation can be reduced by using PMD-size pages
as a pool for small pages for secret memory mappings.

Add a gen_pool per secretmem inode and lazily populate this pool with
PMD-size pages.

As pages allocated by secretmem become unmovable, use CMA to back large
page caches so that page allocator won't be surprised by failing attempt to
migrate these pages.

The CMA area used by secretmem is controlled by the "secretmem=" kernel
parameter. This allows explicit control over the memory available for
secretmem and provides upper hard limit for secretmem consumption.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/Kconfig     |   2 +
 mm/secretmem.c | 152 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 135 insertions(+), 19 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index d8d170fa5210..e0e789398421 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -886,5 +886,7 @@ config MAPPING_DIRTY_HELPERS
 
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+	select GENERIC_ALLOCATOR
+	select CMA
 
 endmenu
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 4be4c9ecac45..d4c44fc568a4 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -7,12 +7,15 @@
 
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/cma.h>
 #include <linux/mount.h>
 #include <linux/memfd.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/pagemap.h>
+#include <linux/genalloc.h>
 #include <linux/syscalls.h>
+#include <linux/memblock.h>
 #include <linux/pseudo_fs.h>
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
@@ -41,25 +44,80 @@
 #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
 
 struct secretmem_ctx {
+	struct gen_pool *pool;
 	unsigned int mode;
 };
 
-static struct page *secretmem_alloc_page(gfp_t gfp)
+static struct cma *secretmem_cma;
+
+static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
+	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
+	struct gen_pool *pool = ctx->pool;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	page = cma_alloc(secretmem_cma, nr_pages, PMD_SIZE, gfp & __GFP_NOWARN);
+	if (!page)
+		return -ENOMEM;
+
+	err = set_direct_map_invalid_noflush(page, nr_pages);
+	if (err)
+		goto err_cma_release;
+
+	addr = (unsigned long)page_address(page);
+	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
+	if (err)
+		goto err_set_direct_map;
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+
+	return 0;
+
+err_set_direct_map:
 	/*
-	 * FIXME: use a cache of large pages to reduce the direct map
-	 * fragmentation
+	 * If a split of PUD-size page was required, it already happened
+	 * when we marked the pages invalid which guarantees that this call
+	 * won't fail
 	 */
-	return alloc_page(gfp);
+	set_direct_map_default_noflush(page, nr_pages);
+err_cma_release:
+	cma_release(secretmem_cma, page, nr_pages);
+	return err;
+}
+
+static struct page *secretmem_alloc_page(struct secretmem_ctx *ctx,
+					 gfp_t gfp)
+{
+	struct gen_pool *pool = ctx->pool;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	if (gen_pool_avail(pool) < PAGE_SIZE) {
+		err = secretmem_pool_increase(ctx, gfp);
+		if (err)
+			return NULL;
+	}
+
+	addr = gen_pool_alloc(pool, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+
+	page = virt_to_page(addr);
+	get_page(page);
+
+	return page;
 }
 
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 {
+	struct secretmem_ctx *ctx = vmf->vma->vm_file->private_data;
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	pgoff_t offset = vmf->pgoff;
 	vm_fault_t ret = 0;
-	unsigned long addr;
 	struct page *page;
 	int err;
 
@@ -68,8 +126,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 
 	page = find_get_page(mapping, offset);
 	if (!page) {
-
-		page = secretmem_alloc_page(vmf->gfp_mask);
+		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
 		if (!page)
 			return vmf_error(-ENOMEM);
 
@@ -77,14 +134,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		if (unlikely(err))
 			goto err_put_page;
 
-		err = set_direct_map_invalid_noflush(page, 1);
-		if (err)
-			goto err_del_page_cache;
-
-		addr = (unsigned long)page_address(page);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
 		__SetPageUptodate(page);
+		set_page_private(page, (unsigned long)ctx);
 
 		ret = VM_FAULT_LOCKED;
 	}
@@ -92,8 +143,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	vmf->page = page;
 	return ret;
 
-err_del_page_cache:
-	delete_from_page_cache(page);
 err_put_page:
 	put_page(page);
 	return vmf_error(err);
@@ -146,8 +195,11 @@ static int secretmem_migratepage(struct address_space *mapping,
 
 static void secretmem_freepage(struct page *page)
 {
-	set_direct_map_default_noflush(page, 1);
-	clear_highpage(page);
+	unsigned long addr = (unsigned long)page_address(page);
+	struct secretmem_ctx *ctx = (struct secretmem_ctx *)page_private(page);
+	struct gen_pool *pool = ctx->pool;
+
+	gen_pool_free(pool, addr, PAGE_SIZE);
 }
 
 static const struct address_space_operations secretmem_aops = {
@@ -182,13 +234,18 @@ static struct file *secretmem_file_create(unsigned long flags)
 	if (!ctx)
 		goto err_free_inode;
 
+	ctx->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!ctx->pool)
+		goto err_free_ctx;
+
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-		goto err_free_ctx;
+		goto err_free_pool;
 
 	mapping_set_unevictable(inode->i_mapping);
 
+	inode->i_private = ctx;
 	inode->i_mapping->private_data = ctx;
 	inode->i_mapping->a_ops = &secretmem_aops;
 
@@ -202,6 +259,8 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 	return file;
 
+err_free_pool:
+	gen_pool_destroy(ctx->pool);
 err_free_ctx:
 	kfree(ctx);
 err_free_inode:
@@ -220,6 +279,9 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
 		return -EINVAL;
 
+	if (!secretmem_cma)
+		return -ENOMEM;
+
 	fd = get_unused_fd_flags(flags & O_CLOEXEC);
 	if (fd < 0)
 		return fd;
@@ -240,11 +302,37 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	return err;
 }
 
+static void secretmem_cleanup_chunk(struct gen_pool *pool,
+				    struct gen_pool_chunk *chunk, void *data)
+{
+	unsigned long start = chunk->start_addr;
+	unsigned long end = chunk->end_addr;
+	struct page *page = virt_to_page(start);
+	unsigned long nr_pages = (end - start + 1) / PAGE_SIZE;
+	int i;
+
+	set_direct_map_default_noflush(page, nr_pages);
+
+	for (i = 0; i < nr_pages; i++)
+		clear_highpage(page + i);
+
+	cma_release(secretmem_cma, page, nr_pages);
+}
+
+static void secretmem_cleanup_pool(struct secretmem_ctx *ctx)
+{
+	struct gen_pool *pool = ctx->pool;
+
+	gen_pool_for_each_chunk(pool, secretmem_cleanup_chunk, ctx);
+	gen_pool_destroy(pool);
+}
+
 static void secretmem_evict_inode(struct inode *inode)
 {
 	struct secretmem_ctx *ctx = inode->i_private;
 
 	truncate_inode_pages_final(&inode->i_data);
+	secretmem_cleanup_pool(ctx);
 	clear_inode(inode);
 	kfree(ctx);
 }
@@ -281,3 +369,29 @@ static int secretmem_init(void)
 	return ret;
 }
 fs_initcall(secretmem_init);
+
+static int __init secretmem_setup(char *str)
+{
+	phys_addr_t align = PMD_SIZE;
+	unsigned long reserved_size;
+	int err;
+
+	reserved_size = memparse(str, NULL);
+	if (!reserved_size)
+		return 0;
+
+	if (reserved_size * 2 > PUD_SIZE)
+		align = PUD_SIZE;
+
+	err = cma_declare_contiguous(0, reserved_size, 0, align, 0, false,
+				     "secretmem", &secretmem_cma);
+	if (err) {
+		pr_err("failed to create CMA: %d\n", err);
+		return err;
+	}
+
+	pr_info("reserved %luM\n", reserved_size >> 20);
+
+	return 0;
+}
+__setup("secretmem=", secretmem_setup);
-- 
2.28.0

