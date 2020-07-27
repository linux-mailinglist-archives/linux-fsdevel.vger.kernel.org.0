Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1422F554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgG0Qab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgG0Qab (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:30:31 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4AB2078A;
        Mon, 27 Jul 2020 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595867430;
        bh=w7MT//2ewKymg3G1SsBcSskJNwyMSzR/MTcAsHwJqGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjHfqr+5h0X9yX2o/fKrEaH/dzMW6Fsp+d3tzNdvc/YFjhNrDQ8sWncQo5oob0yOv
         xeyqbsw4f1b+853VGI/GgLR7E1Y5d7PCuCUk42B7oglZ4/DUH0ImAk+4rePHEtf/nI
         hjOYFHWcvYFIP2lqZR8ayeMXex0VHqkpy120MqCU=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v2 5/7] mm: secretmem: use PMD-size pages to amortize direct map fragmentation
Date:   Mon, 27 Jul 2020 19:29:33 +0300
Message-Id: <20200727162935.31714-6-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727162935.31714-1-rppt@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 107 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 9d29f3e1c49d..da609701e10e 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/pagemap.h>
+#include <linux/genalloc.h>
 #include <linux/syscalls.h>
 #include <linux/pseudo_fs.h>
 #include <linux/set_memory.h>
@@ -25,24 +26,66 @@
 #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
 
 struct secretmem_ctx {
+	struct gen_pool *pool;
 	unsigned int mode;
 };
 
-static struct page *secretmem_alloc_page(gfp_t gfp)
+static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
 {
-	/*
-	 * FIXME: use a cache of large pages to reduce the direct map
-	 * fragmentation
-	 */
-	return alloc_page(gfp);
+	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
+	struct gen_pool *pool = ctx->pool;
+	unsigned long addr;
+	struct page *page;
+	int err;
+
+	page = alloc_pages(gfp, PMD_PAGE_ORDER);
+	if (!page)
+		return -ENOMEM;
+
+	addr = (unsigned long)page_address(page);
+	split_page(page, PMD_PAGE_ORDER);
+
+	err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
+	if (err) {
+		__free_pages(page, PMD_PAGE_ORDER);
+		return err;
+	}
+
+	__kernel_map_pages(page, nr_pages, 0);
+
+	return 0;
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
-	unsigned long addr;
 	struct page *page;
 	int ret = 0;
 
@@ -51,7 +94,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 
 	page = find_get_entry(mapping, offset);
 	if (!page) {
-		page = secretmem_alloc_page(vmf->gfp_mask);
+		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
 		if (!page)
 			return vmf_error(-ENOMEM);
 
@@ -59,14 +102,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		if (unlikely(ret))
 			goto err_put_page;
 
-		ret = set_direct_map_invalid_noflush(page);
-		if (ret)
-			goto err_del_page_cache;
-
-		addr = (unsigned long)page_address(page);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
 		__SetPageUptodate(page);
+		set_page_private(page, (unsigned long)ctx);
 
 		ret = VM_FAULT_LOCKED;
 	}
@@ -74,8 +111,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	vmf->page = page;
 	return ret;
 
-err_del_page_cache:
-	delete_from_page_cache(page);
 err_put_page:
 	put_page(page);
 	return vmf_error(ret);
@@ -134,7 +169,11 @@ static int secretmem_migratepage(struct address_space *mapping,
 
 static void secretmem_freepage(struct page *page)
 {
-	set_direct_map_default_noflush(page);
+	unsigned long addr = (unsigned long)page_address(page);
+	struct secretmem_ctx *ctx = (struct secretmem_ctx *)page_private(page);
+	struct gen_pool *pool = ctx->pool;
+
+	gen_pool_free(pool, addr, PAGE_SIZE);
 }
 
 static const struct address_space_operations secretmem_aops = {
@@ -159,13 +198,18 @@ static struct file *secretmem_file_create(unsigned long flags)
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
 
@@ -179,6 +223,8 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 	return file;
 
+err_free_pool:
+	gen_pool_destroy(ctx->pool);
 err_free_ctx:
 	kfree(ctx);
 err_free_inode:
@@ -223,11 +269,34 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	return err;
 }
 
+static void secretmem_cleanup_chunk(struct gen_pool *pool,
+				    struct gen_pool_chunk *chunk, void *data)
+{
+	unsigned long start = chunk->start_addr;
+	unsigned long end = chunk->end_addr;
+	unsigned long nr_pages, addr;
+
+	nr_pages = (end - start + 1) / PAGE_SIZE;
+	__kernel_map_pages(virt_to_page(start), nr_pages, 1);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE)
+		put_page(virt_to_page(addr));
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
-- 
2.26.2

