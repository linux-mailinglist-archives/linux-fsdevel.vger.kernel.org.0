Return-Path: <linux-fsdevel+bounces-79648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJZ+Lv4Oq2nwZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:29:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A03072262C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DA830DDBAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08669466B7B;
	Fri,  6 Mar 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOIsInpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAB3659F8;
	Fri,  6 Mar 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817568; cv=none; b=DVrWKJYwA8FPSeoAGRulGHWgtHCfsyZt/B2Wta4M+6s61d4vxmEJEp2bZjMQGpLTArAuIzJvM8FHR6b0Dq9Tt1YIvsG4hWz4ThSK2xepnMvUS2cgwf/TNSUjucrrHfGZAMM3YoAGYnyguFyvPAmlX2C/hEpu0mJkT8V4oaxaZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817568; c=relaxed/simple;
	bh=Yw4D+/1fCurRlZ1OehdGpOfaYnZr4j87kF8uPGr9MdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QckUlVwwQSngnlixNx9j8EcMWRt+yjZ0AgNdJzzQEurNY9Gb6JKcYesemnfV8UNCRz7dXlxR1HCvfEPKlIKfb1blcMLAwsJhddNr/iNTt6oBcP1/KoZV5vNrUrALyGXcGXftzLX/0i1KKWz8WJAfRzNNsDFHGLV8kgz9dunMdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOIsInpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE03CC4CEF7;
	Fri,  6 Mar 2026 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817568;
	bh=Yw4D+/1fCurRlZ1OehdGpOfaYnZr4j87kF8uPGr9MdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOIsInpM53tHfARK9/OsmmAkYqqMvg1P5gi0oa4Uskn3kZmMY7h8qF2pnsqQ5NBdx
	 +9ofjRS3lA89zmcxhXMn09Jx08Wj0fAW4GdRmhhDm1edFlRNJvFQtGb/g0dyxZZNst
	 NrcgLM6mN0swuQlMGLF8uF/kRmE2Copw2JPWTG39PsCkoYSGQ6kA0/wUcHebfHkogl
	 ADQrm6Ul05U5z1d6MRhmGZ3BGlt6CRJQvaB/T9B+cGtK0xnlrVlgqIygemtPIqkh2+
	 qOHvIgjIexcJDiVLbD4Kzp62XELKwp6s9JjRY6P3RPw17sbB0+MmbV5MG1z9rRZbMV
	 D6QBfiVfC414A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 10/15] shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops
Date: Fri,  6 Mar 2026 19:18:10 +0200
Message-ID: <20260306171815.3160826-11-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306171815.3160826-1-rppt@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A03072262C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79648-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Add filemap_add() and filemap_remove() methods to vm_uffd_ops and use
them in __mfill_atomic_pte() to add shmem folios to page cache and
remove them in case of error.

Implement these methods in shmem along with vm_uffd_ops->alloc_folio()
and drop shmem_mfill_atomic_pte().

Since userfaultfd now does not reference any functions from shmem, drop
include if linux/shmem_fs.h from mm/userfaultfd.c

mfill_atomic_install_pte() is not used anywhere outside of
mm/userfaultfd, make it static.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/shmem_fs.h      |  14 ----
 include/linux/userfaultfd_k.h |  21 +++--
 mm/shmem.c                    | 148 ++++++++++++----------------------
 mm/userfaultfd.c              |  79 +++++++++---------
 4 files changed, 106 insertions(+), 156 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a8273b32e041..1a345142af7d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -221,20 +221,6 @@ static inline pgoff_t shmem_fallocend(struct inode *inode, pgoff_t eof)
 
 extern bool shmem_charge(struct inode *inode, long pages);
 
-#ifdef CONFIG_USERFAULTFD
-#ifdef CONFIG_SHMEM
-extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
-				  struct vm_area_struct *dst_vma,
-				  unsigned long dst_addr,
-				  unsigned long src_addr,
-				  uffd_flags_t flags,
-				  struct folio **foliop);
-#else /* !CONFIG_SHMEM */
-#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
-			       src_addr, flags, foliop) ({ BUG(); 0; })
-#endif /* CONFIG_SHMEM */
-#endif /* CONFIG_USERFAULTFD */
-
 /*
  * Used space is stored as unsigned 64-bit value in bytes but
  * quota core supports only signed 64-bit values so use that
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 4d8b879eed91..bf4e595ac914 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -93,10 +93,24 @@ struct vm_uffd_ops {
 	struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
 	/*
 	 * Called during resolution of UFFDIO_COPY request.
-	 * Should return allocate a and return folio or NULL if allocation fails.
+	 * Should allocate and return a folio or NULL if allocation
+	 * fails.
 	 */
 	struct folio *(*alloc_folio)(struct vm_area_struct *vma,
 				     unsigned long addr);
+	/*
+	 * Called during resolution of UFFDIO_COPY request.
+	 * Should lock the folio and add it to VMA's page cache.
+	 * Returns 0 on success, error code on failure.
+	 */
+	int (*filemap_add)(struct folio *folio, struct vm_area_struct *vma,
+			 unsigned long addr);
+	/*
+	 * Called during resolution of UFFDIO_COPY request on the error
+	 * handling path.
+	 * Should revert the operation of ->filemap_add().
+	 */
+	void (*filemap_remove)(struct folio *folio, struct vm_area_struct *vma);
 };
 
 /* A combined operation mode + behavior flags. */
@@ -130,11 +144,6 @@ static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_at
 /* Flags controlling behavior. These behavior changes are mode-independent. */
 #define MFILL_ATOMIC_WP MFILL_ATOMIC_FLAG(0)
 
-extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
-				    struct vm_area_struct *dst_vma,
-				    unsigned long dst_addr, struct page *page,
-				    bool newly_allocated, uffd_flags_t flags);
-
 extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				 unsigned long src_start, unsigned long len,
 				 uffd_flags_t flags);
diff --git a/mm/shmem.c b/mm/shmem.c
index 7bd887b64f62..68620caaf75f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3181,118 +3181,73 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 #endif /* CONFIG_TMPFS_QUOTA */
 
 #ifdef CONFIG_USERFAULTFD
-int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
-			   struct vm_area_struct *dst_vma,
-			   unsigned long dst_addr,
-			   unsigned long src_addr,
-			   uffd_flags_t flags,
-			   struct folio **foliop)
-{
-	struct inode *inode = file_inode(dst_vma->vm_file);
-	struct shmem_inode_info *info = SHMEM_I(inode);
+static struct folio *shmem_mfill_folio_alloc(struct vm_area_struct *vma,
+					     unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
 	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	pgoff_t pgoff = linear_page_index(vma, addr);
 	gfp_t gfp = mapping_gfp_mask(mapping);
-	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
-	void *page_kaddr;
 	struct folio *folio;
-	int ret;
-	pgoff_t max_off;
-
-	if (shmem_inode_acct_blocks(inode, 1)) {
-		/*
-		 * We may have got a page, returned -ENOENT triggering a retry,
-		 * and now we find ourselves with -ENOMEM. Release the page, to
-		 * avoid a BUG_ON in our caller.
-		 */
-		if (unlikely(*foliop)) {
-			folio_put(*foliop);
-			*foliop = NULL;
-		}
-		return -ENOMEM;
-	}
 
-	if (!*foliop) {
-		ret = -ENOMEM;
-		folio = shmem_alloc_folio(gfp, 0, info, pgoff);
-		if (!folio)
-			goto out_unacct_blocks;
+	if (unlikely(pgoff >= DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE)))
+		return NULL;
 
-		if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY)) {
-			page_kaddr = kmap_local_folio(folio, 0);
-			/*
-			 * The read mmap_lock is held here.  Despite the
-			 * mmap_lock being read recursive a deadlock is still
-			 * possible if a writer has taken a lock.  For example:
-			 *
-			 * process A thread 1 takes read lock on own mmap_lock
-			 * process A thread 2 calls mmap, blocks taking write lock
-			 * process B thread 1 takes page fault, read lock on own mmap lock
-			 * process B thread 2 calls mmap, blocks taking write lock
-			 * process A thread 1 blocks taking read lock on process B
-			 * process B thread 1 blocks taking read lock on process A
-			 *
-			 * Disable page faults to prevent potential deadlock
-			 * and retry the copy outside the mmap_lock.
-			 */
-			pagefault_disable();
-			ret = copy_from_user(page_kaddr,
-					     (const void __user *)src_addr,
-					     PAGE_SIZE);
-			pagefault_enable();
-			kunmap_local(page_kaddr);
-
-			/* fallback to copy_from_user outside mmap_lock */
-			if (unlikely(ret)) {
-				*foliop = folio;
-				ret = -ENOENT;
-				/* don't free the page */
-				goto out_unacct_blocks;
-			}
+	folio = shmem_alloc_folio(gfp, 0, info, pgoff);
+	if (!folio)
+		return NULL;
 
-			flush_dcache_folio(folio);
-		} else {		/* ZEROPAGE */
-			clear_user_highpage(&folio->page, dst_addr);
-		}
-	} else {
-		folio = *foliop;
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		*foliop = NULL;
+	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL)) {
+		folio_put(folio);
+		return NULL;
 	}
 
-	VM_BUG_ON(folio_test_locked(folio));
-	VM_BUG_ON(folio_test_swapbacked(folio));
+	return folio;
+}
+
+static int shmem_mfill_filemap_add(struct folio *folio,
+				   struct vm_area_struct *vma,
+				   unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t pgoff = linear_page_index(vma, addr);
+	gfp_t gfp = mapping_gfp_mask(mapping);
+	int err;
+
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
-	__folio_mark_uptodate(folio);
-
-	ret = -EFAULT;
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(pgoff >= max_off))
-		goto out_release;
 
-	ret = mem_cgroup_charge(folio, dst_vma->vm_mm, gfp);
-	if (ret)
-		goto out_release;
-	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp);
-	if (ret)
-		goto out_release;
+	err = shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp);
+	if (err)
+		goto err_unlock;
 
-	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       &folio->page, true, flags);
-	if (ret)
-		goto out_delete_from_cache;
+	if (shmem_inode_acct_blocks(inode, 1)) {
+		err = -ENOMEM;
+		goto err_delete_from_cache;
+	}
 
+	folio_add_lru(folio);
 	shmem_recalc_inode(inode, 1, 0);
-	folio_unlock(folio);
+
 	return 0;
-out_delete_from_cache:
+
+err_delete_from_cache:
 	filemap_remove_folio(folio);
-out_release:
+err_unlock:
+	folio_unlock(folio);
+	return err;
+}
+
+static void shmem_mfill_filemap_remove(struct folio *folio,
+				       struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	filemap_remove_folio(folio);
+	shmem_recalc_inode(inode, 0, 0);
 	folio_unlock(folio);
-	folio_put(folio);
-out_unacct_blocks:
-	shmem_inode_unacct_blocks(inode, 1);
-	return ret;
 }
 
 static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
@@ -3315,6 +3270,9 @@ static bool shmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
 static const struct vm_uffd_ops shmem_uffd_ops = {
 	.can_userfault		= shmem_can_userfault,
 	.get_folio_noalloc	= shmem_get_folio_noalloc,
+	.alloc_folio		= shmem_mfill_folio_alloc,
+	.filemap_add		= shmem_mfill_filemap_add,
+	.filemap_remove		= shmem_mfill_filemap_remove,
 };
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 31f3ab6a73e2..a0f8e67006d6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -14,7 +14,6 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/mmu_notifier.h>
 #include <linux/hugetlb.h>
-#include <linux/shmem_fs.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include "internal.h"
@@ -340,10 +339,10 @@ static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
  * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
  * and anon, and for both shared and private VMAs.
  */
-int mfill_atomic_install_pte(pmd_t *dst_pmd,
-			     struct vm_area_struct *dst_vma,
-			     unsigned long dst_addr, struct page *page,
-			     bool newly_allocated, uffd_flags_t flags)
+static int mfill_atomic_install_pte(pmd_t *dst_pmd,
+				    struct vm_area_struct *dst_vma,
+				    unsigned long dst_addr, struct page *page,
+				    uffd_flags_t flags)
 {
 	int ret;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -387,9 +386,6 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 		goto out_unlock;
 
 	if (page_in_cache) {
-		/* Usually, cache pages are already added to LRU */
-		if (newly_allocated)
-			folio_add_lru(folio);
 		folio_add_file_rmap_pte(folio, page, dst_vma);
 	} else {
 		folio_add_new_anon_rmap(folio, dst_vma, dst_addr, RMAP_EXCLUSIVE);
@@ -404,6 +400,9 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
+	if (page_in_cache)
+		folio_unlock(folio);
+
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 	ret = 0;
@@ -516,13 +515,22 @@ static int __mfill_atomic_pte(struct mfill_state *state,
 	 */
 	__folio_mark_uptodate(folio);
 
+	if (ops->filemap_add) {
+		ret = ops->filemap_add(folio, state->vma, state->dst_addr);
+		if (ret)
+			goto err_folio_put;
+	}
+
 	ret = mfill_atomic_install_pte(state->pmd, state->vma, dst_addr,
-				       &folio->page, true, flags);
+				       &folio->page, flags);
 	if (ret)
-		goto err_folio_put;
+		goto err_filemap_remove;
 
 	return 0;
 
+err_filemap_remove:
+	if (ops->filemap_remove)
+		ops->filemap_remove(folio, state->vma);
 err_folio_put:
 	folio_put(folio);
 	/* Don't return -ENOENT so that our caller won't retry */
@@ -535,6 +543,18 @@ static int mfill_atomic_pte_copy(struct mfill_state *state)
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
 
+	/*
+	 * The normal page fault path for a MAP_PRIVATE mapping in a
+	 * file-backed VMA will invoke the fault, fill the hole in the file and
+	 * COW it right away. The result generates plain anonymous memory.
+	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
+	 * generate anonymous memory directly without actually filling the
+	 * hole. For the MAP_PRIVATE case the robustness check only happens in
+	 * the pagetable (to verify it's still none) and not in the page cache.
+	 */
+	if (!(state->vma->vm_flags & VM_SHARED))
+		ops = &anon_uffd_ops;
+
 	return __mfill_atomic_pte(state, ops);
 }
 
@@ -554,7 +574,8 @@ static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 	spinlock_t *ptl;
 	int ret;
 
-	if (mm_forbids_zeropage(dst_vma->vm_mm))
+	if (mm_forbids_zeropage(dst_vma->vm_mm) ||
+	    (dst_vma->vm_flags & VM_SHARED))
 		return mfill_atomic_pte_zeroed_folio(state);
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
@@ -609,11 +630,10 @@ static int mfill_atomic_pte_continue(struct mfill_state *state)
 	}
 
 	ret = mfill_atomic_install_pte(dst_pmd, dst_vma, dst_addr,
-				       page, false, flags);
+				       page, flags);
 	if (ret)
 		goto out_release;
 
-	folio_unlock(folio);
 	return 0;
 
 out_release:
@@ -836,41 +856,18 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
 
 static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
 {
-	struct vm_area_struct *dst_vma = state->vma;
-	unsigned long src_addr = state->src_addr;
-	unsigned long dst_addr = state->dst_addr;
-	struct folio **foliop = &state->folio;
 	uffd_flags_t flags = state->flags;
-	pmd_t *dst_pmd = state->pmd;
-	ssize_t err;
 
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		return mfill_atomic_pte_continue(state);
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
 		return mfill_atomic_pte_poison(state);
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
+		return mfill_atomic_pte_copy(state);
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
+		return mfill_atomic_pte_zeropage(state);
 
-	/*
-	 * The normal page fault path for a shmem will invoke the
-	 * fault, fill the hole in the file and COW it right away. The
-	 * result generates plain anonymous memory. So when we are
-	 * asked to fill an hole in a MAP_PRIVATE shmem mapping, we'll
-	 * generate anonymous memory directly without actually filling
-	 * the hole. For the MAP_PRIVATE case the robustness check
-	 * only happens in the pagetable (to verify it's still none)
-	 * and not in the radix tree.
-	 */
-	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
-			err = mfill_atomic_pte_copy(state);
-		else
-			err = mfill_atomic_pte_zeropage(state);
-	} else {
-		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
-					     dst_addr, src_addr,
-					     flags, foliop);
-	}
-
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
-- 
2.51.0


