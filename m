Return-Path: <linux-fsdevel+bounces-35607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79D9D64F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC62D282EE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13795188905;
	Fri, 22 Nov 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8ko+DAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E41DEFFC
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307942; cv=none; b=blU+BfOkMS4KEnOWJr9qM5RO04NFSpuFSaXhygo4c0ahA59ABJZX+/tsqf1D985cK9966EygXkI1fK4midrtExAfk+gS2Oro6ddwrIZoV2cFMUXAarlcpE7DL9up0v6BamxBSN/cYevAxj2HetaLbnocWPYaMjt42gSZ35adizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307942; c=relaxed/simple;
	bh=YcN5sv3AY2BFgon81zMLjIfNghyFepRA14QJt3JKHzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=entDxcPX0Xg6lPksChtXQwZtRBprN9BzOEtrIgvRf5sJH3g4UvTs8hhcS5mMQwhhPhoMao5tXP/+usmPwoOJoWUX4/OX1J2f4wOD1K1AJt8i5C0t0No0OUYnVR4muvsKrrdjliY9cQaQMgSoWXeElMH5ee77u91gxCVpABUk41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8ko+DAa; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab94452a7so93493939f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307939; x=1732912739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8XN/NPs91LN7p5/v86U/iFyl8u+jIuX77I4zRh/+yo=;
        b=B8ko+DAaCV8UHGTuPktOUcfYSl3eheoVYpXi4Duw+jL3y4EM6egkepA5Q/qy4YPRp3
         mQaQ0Nr3esJhGtYZti52MHwJ8xW+cpLhbkY9uEUOrlWln5hkuk5RJRYkzNSVWtyjp05g
         ZcrGof9oEGfHTgEbc6Tezm8esZHHZO0WyLPISwHBh3k7nVPTjJbjt6X79u+8XwWxSm0L
         4LRw3o5V120urNQZNvQOFktvTa8IypsxA4pjT2u0fSClnLIuoFR7FMWVdDmdBaYDAVkE
         Q6i3z7od7/3zzOhh5Puy3g/kiqgsunxCWJrOVHlAm7agwc5uO1U6NtPOkP97J7pk60Ku
         FM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307939; x=1732912739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8XN/NPs91LN7p5/v86U/iFyl8u+jIuX77I4zRh/+yo=;
        b=jM7b6vrIrSaF6PbWDNFaBOjNZ9qs1zzswzYDu8OjqmW8emZWlmFZXAtpU9dl/4JiaO
         eSLKuXYGSBGMre4BHMYLQQDH7F5+l2W8oi6UqSmGoC9FVtAuMZnBPRgr4xg5NE9fi4XX
         JKH4vTqLEDrS0otc45a/ZbzCApVyuTl6fTu5SpQu+Q8vyOWds2OW86T58qimreaIf07T
         jIu0fFjWLsMUyDmmGyjc6JRHiJ4b9lvI++joPp6+uGXnrD9OdJliccKeXdxHtVyKAXUr
         fqvpQfA8peUELGRg7+PllQjg8YXcl3zOwE2qpdsT3Kum2Fw7JZWGWzimnGM0YJhl7gtv
         CklQ==
X-Gm-Message-State: AOJu0Yyfcgi6VM9TWDBG2VKEtoN1giuRplEQOO8CFDer6Dpp24A3Hlyr
	ixizCm2ypEwNvt4iJipi3OY+BOmbXvyYlJwGDr0Vqo8UPydxzoLqEBWqvKsp
X-Gm-Gg: ASbGnctfD6Yjo1xZIRxBpDuhaNbIqnoeiyWlzfbFdEGZwMhcAmWZzDOEH/VUk5N/iIB
	0cT/b1TigS6DdrvOPPT9MOTGFTtOh9rsoBf388pgyl163qWylnWiTuyqARsBnUQ0EEm0X72LE/H
	znqizjK0/kZQ9pcS9kE5UAkh/c4OMCz67rDCMvMXS5niLDJtjqNSxjDMRosAo8cT72Izg78AVEg
	tWrG11NX6iwRdL14NOS9EKiBUB91JDTuJrYRrRnn6ynKDVAc9+oqTNPXya/EVAT3MgqQS5wpO8=
X-Google-Smtp-Source: AGHT+IFGF0YgsxuRMYsRn+VxY3M5jIVEBPETJACQYzRCGVbGpI02U73OdFerHCz5zK1jigOhwCCz7A==
X-Received: by 2002:a05:6602:6422:b0:83a:b500:3513 with SMTP id ca18e2360f4ac-83ecdc8b310mr507317939f.8.1732307939130;
        Fri, 22 Nov 2024 12:38:59 -0800 (PST)
Received: from manaslu.cs.wisc.edu (manaslu.cs.wisc.edu. [128.105.15.4])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe52506sm794682173.77.2024.11.22.12.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 12:38:58 -0800 (PST)
From: Bijan Tabatabai <bijan311@gmail.com>
X-Google-Original-From: Bijan Tabatabai <btabatabai@wisc.edu>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	btabatabai@wisc.edu
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mingo@redhat.com
Subject: [RFC PATCH 4/4] Add base implementation of an MFS
Date: Fri, 22 Nov 2024 14:38:30 -0600
Message-Id: <20241122203830.2381905-5-btabatabai@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122203830.2381905-1-btabatabai@wisc.edu>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mount by running
sudo mount -t BasicMFS BasicMFS -o numpages=<pages> <mntdir>

Where <pages> is the max number of 4KB pages it can use, and <mntdir> is
the directory to mount the filesystem to.

This patch is meant to serve as a reference for the reviewers and is not
intended to be upstreamed.

Signed-off-by: Bijan Tabatabai <btabatabai@wisc.edu>
---
 BasicMFS/Kconfig  |   3 +
 BasicMFS/Makefile |   8 +
 BasicMFS/basic.c  | 717 ++++++++++++++++++++++++++++++++++++++++++++++
 BasicMFS/basic.h  |  29 ++
 4 files changed, 757 insertions(+)
 create mode 100644 BasicMFS/Kconfig
 create mode 100644 BasicMFS/Makefile
 create mode 100644 BasicMFS/basic.c
 create mode 100644 BasicMFS/basic.h

diff --git a/BasicMFS/Kconfig b/BasicMFS/Kconfig
new file mode 100644
index 000000000000..3b536eded0ed
--- /dev/null
+++ b/BasicMFS/Kconfig
@@ -0,0 +1,3 @@
+config BASICMMFS
+    tristate "Adds the BasicMMFS"
+    default m
diff --git a/BasicMFS/Makefile b/BasicMFS/Makefile
new file mode 100644
index 000000000000..e50d27819c3c
--- /dev/null
+++ b/BasicMFS/Makefile
@@ -0,0 +1,8 @@
+obj-m += basicmfs.o
+basicmfs-y += basic.o
+
+all:
+	make -C ../kbuild M=$(PWD) modules
+
+clean:
+	make -C ../kbuild M=$(PWD) clean
diff --git a/BasicMFS/basic.c b/BasicMFS/basic.c
new file mode 100644
index 000000000000..88490de64db4
--- /dev/null
+++ b/BasicMFS/basic.c
@@ -0,0 +1,717 @@
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/gfp.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/pagemap.h>
+#include <linux/statfs.h>
+#include <linux/module.h>
+#include <linux/rmap.h>
+#include <linux/string.h>
+#include <linux/falloc.h>
+#include <linux/pagewalk.h>
+#include <linux/file_based_mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pagevec.h>
+
+#include <asm/tlbflush.h>
+
+#include "basic.h"
+
+static const struct super_operations basicmfs_ops;
+static const struct inode_operations basicmfs_dir_inode_operations;
+
+static struct basicmfs_sb_info *BMFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static struct basicmfs_inode_info *BMFS_I(struct inode *inode)
+{
+	return inode->i_private;
+}
+
+/*
+ * Allocate a base page and assign it to the inode at the given page offset
+ * Takes the sbi->lock.
+ * Returns the allocated page if there is one, else NULL
+ */
+static struct page *basicmfs_alloc_page(struct basicmfs_inode_info *inode_info,
+		struct basicmfs_sb_info *sbi, u64 page_offset)
+{
+	u8 *kaddr;
+	u64 pages_added;
+	u64 alloc_size = 64;
+	struct page *page = NULL;
+
+	spin_lock(&sbi->lock);
+
+	/* First, do we have any free pages available? */
+	if (sbi->free_pages == 0) {
+		/* Try to allocate more pages if we can */
+		alloc_size = min(alloc_size, sbi->max_pages - sbi->num_pages);
+		if (alloc_size == 0)
+			goto unlock;
+
+		pages_added = alloc_pages_bulk_list(GFP_HIGHUSER, alloc_size, &sbi->free_list);
+
+		if (pages_added == 0)
+			goto unlock;
+
+		sbi->num_pages += pages_added;
+		sbi->free_pages += pages_added;
+	}
+
+	page = list_first_entry(&sbi->free_list, struct page, lru);
+	list_del(&page->lru);
+	sbi->free_pages--;
+
+	/* Zero the page outside of the critical section */
+	spin_unlock(&sbi->lock);
+
+	kaddr = kmap_local_page(page);
+	memset(kaddr, 0, PAGE_SIZE);
+	kunmap_local(kaddr);
+
+	spin_lock(&sbi->lock);
+
+	list_add(&page->lru, &sbi->active_list);
+
+unlock:
+	spin_unlock(&sbi->lock);
+	return page;
+}
+
+static void basicmfs_return_page(struct page *page, struct basicmfs_sb_info *sbi)
+{
+	spin_lock(&sbi->lock);
+
+	list_del(&page->lru);
+	/*
+	 * We don't need to put page here for being unmapped that seems to have
+	 * been handled by the unmapping code.
+	 */
+
+	list_add_tail(&page->lru, &sbi->free_list);
+	sbi->free_pages++;
+
+	spin_unlock(&sbi->lock);
+}
+
+static void basicmfs_free_range(struct inode *inode, u64 offset, loff_t len)
+{
+	struct basicmfs_sb_info *sbi = BMFS_SB(inode->i_sb);
+	struct basicmfs_inode_info *inode_info = BMFS_I(inode);
+	struct address_space *mapping = inode_info->mapping;
+	struct folio_batch fbatch;
+	int i;
+	pgoff_t cur_offset = offset >> PAGE_SHIFT;
+	pgoff_t end_offset = (offset + len) >> PAGE_SHIFT;
+
+	folio_batch_init(&fbatch);
+	while (cur_offset < end_offset) {
+		filemap_get_folios(mapping, &cur_offset, end_offset - 1, &fbatch);
+
+		for (i = 0; i < fbatch.nr; i++) {
+			folio_lock(fbatch.folios[i]);
+			filemap_remove_folio(fbatch.folios[i]);
+			folio_unlock(fbatch.folios[i]);
+			basicmfs_return_page(folio_page(fbatch.folios[i], 0), sbi);
+		}
+
+		folio_batch_release(&fbatch);
+	}
+}
+
+static vm_fault_t basicmfs_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct inode *inode = vma->vm_file->f_inode;
+	struct basicmfs_inode_info *inode_info;
+	struct basicmfs_sb_info *sbi;
+	struct page *page = NULL;
+	bool new_page = true;
+	bool cow_fault = false;
+	u64 pgoff = ((vmf->address - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	vm_fault_t ret = 0;
+	pte_t entry;
+
+	inode_info = BMFS_I(inode);
+	sbi = BMFS_SB(inode->i_sb);
+
+	if (!vmf->pte) {
+		if (pte_alloc(vma->vm_mm, vmf->pmd))
+			return VM_FAULT_OOM;
+	}
+
+	vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+	vmf->orig_pte = *vmf->pte;
+	if (!pte_none(vmf->orig_pte) && pte_present(vmf->orig_pte)) {
+		if (!(vmf->flags & FAULT_FLAG_WRITE)) {
+			/*
+			 * It looks like the PTE is already populated,
+			 * so maybe two threads raced to first fault.
+			 */
+			ret = VM_FAULT_NOPAGE;
+			goto unmap;
+		}
+
+		cow_fault = true;
+	}
+
+	/* Get the page if it was preallocated */
+	page = mtree_erase(&inode_info->falloc_mt, pgoff);
+
+	/* Try to allocate the page if it hasn't been already */
+	if (!page) {
+		page = basicmfs_alloc_page(inode_info, sbi, pgoff);
+		if (!page) {
+			ret = VM_FAULT_OOM;
+			goto unmap;
+		}
+	}
+
+	if (!pte_none(vmf->orig_pte) && !pte_present(vmf->orig_pte)) {
+		/* Swapped out page */
+		struct page *ret_page;
+		swp_entry_t swp_entry = pte_to_swp_entry(vmf->orig_pte);
+
+		ret_page = fbmm_read_swap_entry(vmf, swp_entry, pgoff, page);
+		if (page != ret_page) {
+			/*
+			 * A physical page was already being used for this virt page
+			 * or there was an error, so we can return the page we allocated.
+			 */
+			basicmfs_return_page(page, sbi);
+			page = ret_page;
+			new_page = false;
+		}
+		if (!page) {
+			pr_warn("BasicMFS: Error swapping in page! %lx\n", vmf->address);
+			goto unmap;
+		}
+	}
+
+	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
+	spin_lock(vmf->ptl);
+	/* Check if some other thread faulted here */
+	if (!pte_same(vmf->orig_pte, *vmf->pte)) {
+		if (new_page)
+			basicmfs_return_page(page, sbi);
+		goto unlock;
+	}
+
+	/* Handle COW fault */
+	if (cow_fault) {
+		u8 *src_kaddr, *dst_kaddr;
+		struct page *old_page;
+		struct folio *old_folio;
+		unsigned long old_pfn;
+
+		old_pfn = pte_pfn(vmf->orig_pte);
+		old_page = pfn_to_page(old_pfn);
+
+		lock_page(old_page);
+
+		/*
+		 * If there's more than one reference to this page, we need to copy it.
+		 * Otherwise, we can just reuse it
+		 */
+		if (page_mapcount(old_page) > 1) {
+			src_kaddr = kmap_local_page(old_page);
+			dst_kaddr = kmap_local_page(page);
+			memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
+			kunmap_local(dst_kaddr);
+			kunmap_local(src_kaddr);
+		} else {
+			basicmfs_return_page(page, sbi);
+			page = old_page;
+		}
+		/*
+		 * Drop a reference to old_page even if we are going to keep it
+		 * because the reference will be increased at the end of the fault
+		 */
+		put_page(old_page);
+		/* Decrease the filepage and rmap count for the same reason */
+		percpu_counter_dec(&vma->vm_mm->rss_stat[MM_FILEPAGES]);
+		folio_remove_rmap_pte(page_folio(old_page), old_page, vma);
+
+		old_folio = page_folio(old_page);
+		/*
+		 * If we are copying a page for the process that originally faulted the
+		 * page, we have to replace the mapping.
+		 */
+		if (mapping == old_folio->mapping) {
+			if (old_page != page)
+				replace_page_cache_folio(old_folio, page_folio(page));
+			new_page = false;
+		}
+		unlock_page(old_page);
+	}
+
+	if (new_page)
+		/*
+		 * We want to manage the folio ourselves, and don't want it on the LRU lists,
+		 * so we use __filemap_add_folio instead of filemap_add_folio.
+		 */
+		__filemap_add_folio(mapping, page_folio(page), pgoff, GFP_KERNEL, NULL);
+
+	/* Construct the pte entry */
+	entry = mk_pte(page, vma->vm_page_prot);
+	entry = pte_mkyoung(entry);
+	if (vma->vm_flags & VM_WRITE)
+		entry = pte_mkwrite_novma(pte_mkdirty(entry));
+
+	folio_add_file_rmap_pte(page_folio(page), page, vma);
+	percpu_counter_inc(&vma->vm_mm->rss_stat[MM_FILEPAGES]);
+	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+
+	update_mmu_cache(vma, vmf->address, vmf->pte);
+	vmf->page = page;
+	get_page(page);
+	flush_tlb_page(vma, vmf->address);
+	ret = VM_FAULT_NOPAGE;
+
+unlock:
+	spin_unlock(vmf->ptl);
+unmap:
+	pte_unmap(vmf->pte);
+	return ret;
+}
+
+const struct vm_operations_struct basicmfs_vm_ops = {
+	.fault = basicmfs_fault,
+	.page_mkwrite = basicmfs_fault,
+	.pfn_mkwrite = basicmfs_fault,
+};
+
+static int basicmfs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	struct basicmfs_inode_info *inode_info = BMFS_I(inode);
+
+	file_accessed(file);
+	vma->vm_ops = &basicmfs_vm_ops;
+
+	inode_info->file_va_start = vma->vm_start - (vma->vm_pgoff << PAGE_SHIFT);
+	inode_info->mapping = file->f_mapping;
+
+	return 0;
+}
+
+static int basicmfs_release(struct inode *inode, struct file *file)
+{
+	struct basicmfs_sb_info *sbi = BMFS_SB(inode->i_sb);
+	struct basicmfs_inode_info *inode_info = BMFS_I(inode);
+	struct page *page;
+	unsigned long index = 0;
+	unsigned long free_count = 0;
+
+	basicmfs_free_range(inode, 0, inode->i_size);
+
+	mt_for_each(&inode_info->falloc_mt, page, index, ULONG_MAX) {
+		basicmfs_return_page(page, sbi);
+		free_count++;
+	}
+
+	mtree_destroy(&inode_info->falloc_mt);
+	kfree(inode_info);
+
+	return 0;
+}
+
+static long basicmfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	struct basicmfs_sb_info *sbi = BMFS_SB(inode->i_sb);
+	struct basicmfs_inode_info *inode_info = BMFS_I(inode);
+	struct page *page;
+	loff_t off;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		basicmfs_free_range(inode, offset, len);
+		return 0;
+	} else if (mode != 0) {
+		return -EOPNOTSUPP;
+	}
+
+	for (off = offset; off < offset + len; off += PAGE_SIZE) {
+		page = basicmfs_alloc_page(inode_info, sbi, off >> PAGE_SHIFT);
+		mtree_store(&inode_info->falloc_mt, off >> PAGE_SHIFT, page, GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+const struct file_operations basicmfs_file_operations = {
+	.mmap		= basicmfs_mmap,
+	.release	= basicmfs_release,
+	.fsync		= noop_fsync,
+	.llseek		= generic_file_llseek,
+	.get_unmapped_area	= generic_get_unmapped_area_topdown,
+	.fallocate = basicmfs_fallocate,
+};
+
+const struct inode_operations basicmfs_file_inode_operations = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
+
+const struct address_space_operations basicmfs_aops = {
+	.direct_IO = noop_direct_IO,
+	.dirty_folio = noop_dirty_folio,
+	.writepage = fbmm_writepage,
+};
+
+static struct inode *basicmfs_get_inode(struct super_block *sb,
+				const struct inode *dir, umode_t mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+	struct basicmfs_inode_info *info;
+
+	if (!inode)
+		return NULL;
+
+	info = kzalloc(sizeof(struct basicmfs_inode_info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	mt_init(&info->falloc_mt);
+	info->file_va_start = 0;
+
+	inode->i_ino = get_next_ino();
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+	inode->i_mapping->a_ops = &basicmfs_aops;
+	inode->i_flags |= S_DAX;
+	inode->i_private = info;
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &basicmfs_file_inode_operations;
+		inode->i_fop = &basicmfs_file_operations;
+		break;
+	case S_IFDIR:
+		inode->i_op = &basicmfs_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+
+		/* Directory inodes start off with i_nlink == 2 (for "." entry) */
+		inc_nlink(inode);
+		break;
+	default:
+		return NULL;
+	}
+
+	return inode;
+}
+
+static int basicmfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	struct inode *inode = basicmfs_get_inode(dir->i_sb, dir, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry); /* Extra count - pin the dentry in core */
+		error = 0;
+	}
+
+	return error;
+}
+
+static int basicmfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode)
+{
+	return -EINVAL;
+}
+
+static int basicmfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
+{
+	// TODO: Replace 0777 with mode and see if anything breaks
+	return basicmfs_mknod(idmap, dir, dentry, 0777 | S_IFREG, 0);
+}
+
+static int basicmfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, const char *symname)
+{
+	return -EINVAL;
+}
+
+static int basicmfs_tmpfile(struct mnt_idmap *idmap,
+			struct inode *dir, struct file *file, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = basicmfs_get_inode(dir->i_sb, dir, mode, 0);
+	if (!inode)
+		return -ENOSPC;
+	d_tmpfile(file, inode);
+	return finish_open_simple(file, 0);
+}
+
+static const struct inode_operations basicmfs_dir_inode_operations = {
+	.create		= basicmfs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.symlink	= basicmfs_symlink,
+	.mkdir		= basicmfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= basicmfs_mknod,
+	.rename		= simple_rename,
+	.tmpfile	= basicmfs_tmpfile,
+};
+
+static int basicmfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct basicmfs_sb_info *sbi = BMFS_SB(sb);
+
+	buf->f_type = sb->s_magic;
+	buf->f_bsize = PAGE_SIZE;
+	buf->f_blocks = sbi->num_pages;
+	buf->f_bfree = buf->f_bavail = sbi->free_pages;
+	buf->f_files = LONG_MAX;
+	buf->f_ffree = LONG_MAX;
+	buf->f_namelen = 255;
+
+	return 0;
+}
+
+static int basicmfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	return 0;
+}
+
+#define BASICMFS_MAX_PAGEOUT 512
+static long basicmfs_nr_cached_objects(struct super_block *sb, struct shrink_control *sc)
+{
+	struct basicmfs_sb_info *sbi = BMFS_SB(sb);
+	long nr = 0;
+
+	spin_lock(&sbi->lock);
+	if (sbi->free_pages > 0)
+		nr = sbi->free_pages;
+	else
+		nr = max(sbi->num_pages - sbi->free_pages, (u64)BASICMFS_MAX_PAGEOUT);
+	spin_unlock(&sbi->lock);
+
+	return nr;
+}
+
+static long basicmfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
+{
+	LIST_HEAD(folio_list);
+	LIST_HEAD(fail_list);
+	struct basicmfs_sb_info *sbi = BMFS_SB(sb);
+	struct page *page;
+	u64 i, num_scanned;
+
+	if (sbi->free_pages > 0) {
+		spin_lock(&sbi->lock);
+		for (i = 0; i < sc->nr_to_scan && i < sbi->free_pages; i++) {
+			page = list_first_entry(&sbi->free_list, struct page, lru);
+			list_del(&page->lru);
+			put_page(page);
+		}
+
+		sbi->num_pages -= i;
+		sbi->free_pages -= i;
+		spin_unlock(&sbi->lock);
+	} else if (sbi->num_pages > 0) {
+		spin_lock(&sbi->lock);
+		for (i = 0; i < sc->nr_to_scan && sbi->num_pages > 0; i++) {
+			page = list_first_entry(&sbi->active_list, struct page, lru);
+			list_move(&page->lru, &folio_list);
+			sbi->num_pages--;
+		}
+		spin_unlock(&sbi->lock);
+
+		num_scanned = i;
+		for (i = 0; i < num_scanned && !list_empty(&folio_list); i++) {
+			page = list_first_entry(&folio_list, struct page, lru);
+			list_del(&page->lru);
+			if (fbmm_swapout_folio(page_folio(page)))
+				list_add_tail(&page->lru, &fail_list);
+			else
+				put_page(page);
+		}
+
+		spin_lock(&sbi->lock);
+		while (!list_empty(&fail_list)) {
+			page = list_first_entry(&fail_list, struct page, lru);
+			list_del(&page->lru);
+			list_add_tail(&page->lru, &sbi->active_list);
+			sbi->num_pages++;
+		}
+		spin_unlock(&sbi->lock);
+
+	}
+
+	sc->nr_scanned = i;
+	return i;
+}
+
+static const struct super_operations basicmfs_ops = {
+	.statfs = basicmfs_statfs,
+	.drop_inode = generic_delete_inode,
+	.show_options = basicmfs_show_options,
+	.nr_cached_objects = basicmfs_nr_cached_objects,
+	.free_cached_objects = basicmfs_free_cached_objects,
+	.copy_page_range = fbmm_copy_page_range,
+};
+
+static int basicmfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct basicmfs_sb_info *sbi = kzalloc(sizeof(struct basicmfs_sb_info), GFP_KERNEL);
+	u64 nr_pages = *(u64 *)fc->fs_private;
+	u64 alloc_size = 1024;
+
+	if (!sbi)
+		return -ENOMEM;
+
+	sb->s_fs_info = sbi;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_magic = 0xDEADBEEF;
+	sb->s_op = &basicmfs_ops;
+	sb->s_time_gran = 1;
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+
+	spin_lock_init(&sbi->lock);
+	INIT_LIST_HEAD(&sbi->free_list);
+	INIT_LIST_HEAD(&sbi->active_list);
+	sbi->max_pages = nr_pages;
+	sbi->num_pages = 0;
+	for (int i = 0; i < nr_pages / alloc_size; i++)
+		sbi->num_pages += alloc_pages_bulk_list(GFP_HIGHUSER, alloc_size, &sbi->free_list);
+	sbi->free_pages = sbi->num_pages;
+
+	inode = basicmfs_get_inode(sb, NULL, S_IFDIR | 0755, 0);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root) {
+		kfree(sbi);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int basicmfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, basicmfs_fill_super);
+}
+
+enum basicmfs_param {
+	Opt_numpages,
+};
+
+const struct fs_parameter_spec basicmfs_fs_parameters[] = {
+	fsparam_u64("numpages", Opt_numpages),
+	{},
+};
+
+static int basicmfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	u64 *num_pages = (u64 *)fc->fs_private;
+	int opt;
+
+	opt = fs_parse(fc, basicmfs_fs_parameters, param, &result);
+	if (opt < 0) {
+		/*
+		 * We might like to report bad mount options here;
+		 * but traditionally ramfs has ignored all mount options,
+		 * and as it is used as a !CONFIG_SHMEM simple substitute
+		 * for tmpfs, better continue to ignore other mount options.
+		 */
+		if (opt == -ENOPARAM)
+			opt = 0;
+		return opt;
+	}
+
+	switch (opt) {
+	case Opt_numpages:
+		*num_pages = result.uint_64;
+		break;
+	};
+
+	return 0;
+}
+
+static void basicmfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations basicmfs_context_ops = {
+	.free = basicmfs_free_fc,
+	.parse_param = basicmfs_parse_param,
+	.get_tree = basicmfs_get_tree,
+};
+
+static int basicmfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &basicmfs_context_ops;
+
+	fc->fs_private = kzalloc(sizeof(u64), GFP_KERNEL);
+	/* Set a default number of pages to use */
+	*(u64 *)fc->fs_private = 128 * 1024;
+	return 0;
+}
+
+static void basicmfs_kill_sb(struct super_block *sb)
+{
+	struct basicmfs_sb_info *sbi = BMFS_SB(sb);
+	struct page *page, *tmp;
+
+	spin_lock(&sbi->lock);
+
+	/*
+	 * Return the pages we took to the kernel.
+	 * All the pages should be in the free list at this point
+	 */
+	list_for_each_entry_safe(page, tmp, &sbi->free_list, lru) {
+		list_del(&page->lru);
+		put_page(page);
+	}
+
+	spin_unlock(&sbi->lock);
+
+	kfree(sbi);
+
+	kill_litter_super(sb);
+}
+
+static struct file_system_type basicmfs_fs_type = {
+	.owner = THIS_MODULE,
+	.name = "BasicMFS",
+	.init_fs_context = basicmfs_init_fs_context,
+	.parameters = basicmfs_fs_parameters,
+	.kill_sb = basicmfs_kill_sb,
+	.fs_flags = FS_USERNS_MOUNT,
+};
+
+static int __init init_basicmfs(void)
+{
+	printk(KERN_INFO "Starting BasicMFS");
+	register_filesystem(&basicmfs_fs_type);
+
+	return 0;
+}
+module_init(init_basicmfs);
+
+static void cleanup_basicmfs(void)
+{
+	printk(KERN_INFO "Removing BasicMFS");
+	unregister_filesystem(&basicmfs_fs_type);
+}
+module_exit(cleanup_basicmfs);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bijan Tabatabai");
diff --git a/BasicMFS/basic.h b/BasicMFS/basic.h
new file mode 100644
index 000000000000..8e727201aca3
--- /dev/null
+++ b/BasicMFS/basic.h
@@ -0,0 +1,29 @@
+#ifndef BASIC_MMFS_H
+#define BASIC_MMFS_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/maple_tree.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+
+struct basicmfs_sb_info {
+	spinlock_t lock;
+	struct list_head free_list;
+	struct list_head active_list;
+	u64 num_pages;
+	u64 max_pages;
+	u64 free_pages;
+};
+
+struct basicmfs_inode_info {
+	// Maple tree mapping the page offset to the folio mapped to that offset
+	// Used to hold preallocated pages that haven't been mapped yet
+	struct maple_tree falloc_mt;
+	// The first virtual address this file is associated with.
+	u64 file_va_start;
+	// The file offset to folio mapping from the file
+	struct address_space *mapping;
+};
+
+#endif //BASIC_MMFS_H
-- 
2.34.1


