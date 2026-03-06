Return-Path: <linux-fsdevel+bounces-79640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEMEMZMPq2n1ZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:32:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27712263A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A06431CDBAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3342317C;
	Fri,  6 Mar 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLVM3J8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A87421F10;
	Fri,  6 Mar 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817518; cv=none; b=jukshoiDOqvj0GIM3k3aaB9Bn3vviDJKnmUmpLlC8KsxQK2c3+OocmDzA+oDM0+KgL8JJUfMXC4wHRWmZ028yCnGdyuaPSSztpP64bM3uCpo5O3htc2eXPIMtOna0eg44uExwmvguC/eTkuYk4g5+uqTHUBr+fBPSVak+28Jv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817518; c=relaxed/simple;
	bh=qeHJOG4jd2y41fBZrRJMl9E/6dNaSv4rX52hxPC5T7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArbCRnvJl/zVpS/jXfcFyhlFteQoxx18OtZWDTkNdscEIXBMDmRa1WQiNKI3xbxX1fqKlzcl0ln2fvxLvpZgWWAKRp6oAgK0jNU15/ssJkfNzFZZCN4coJhaPyc3gupjKd5gbXUXhzqu7g622p6sEBt7ivsfsuwMzhvxVqDN3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLVM3J8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5703C19425;
	Fri,  6 Mar 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817518;
	bh=qeHJOG4jd2y41fBZrRJMl9E/6dNaSv4rX52hxPC5T7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLVM3J8SAfmWzXoIaZeXe6pFUJFoevf1MSDJioG2T5eUPZs7IMQXtmiOWVbgRud/P
	 oy/5uBaBYuETtj9PWxF153gMPEWwKxZn4BTvliutLJiaKhW7Gk01l9awV29B7q3DAF
	 eXaRmKNGRzkMZrM85Qrc/+WnKWMAOn/EbHN/0YlGm91+NKYIP+juDmYThXH7N/hwUq
	 7KIr9bPgmOupOt3L3frD0a52Ec/f4ehdmrgrtylNuhqidjN7pyflY+K0n5qJ3xn/kU
	 8qP9RpAmXVD4+os6mFJSs6Xjv/BJpREZLcnTMHtPbVvjeaXuTtbsim/a7o0HQD6/4I
	 PpJm71VdMvKkA==
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
Subject: [PATCH v2 02/15] userfaultfd: introduce struct mfill_state
Date: Fri,  6 Mar 2026 19:18:02 +0200
Message-ID: <20260306171815.3160826-3-rppt@kernel.org>
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
X-Rspamd-Queue-Id: F27712263A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79640-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

mfill_atomic() passes a lot of parameters down to its callees.

Aggregate them all into mfill_state structure and pass this structure to
functions that implement various UFFDIO_ commands.

Tracking the state in a structure will allow moving the code that retries
copying of data for UFFDIO_COPY into mfill_atomic_pte_copy() and make the
loop in mfill_atomic() identical for all UFFDIO operations on PTE-mapped
memory.

The mfill_state definition is deliberately local to mm/userfaultfd.c, hence
shmem_mfill_atomic_pte() is not updated.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 148 ++++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 66 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 32637d557c95..e68d01743b03 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -20,6 +20,20 @@
 #include "internal.h"
 #include "swap.h"
 
+struct mfill_state {
+	struct userfaultfd_ctx *ctx;
+	unsigned long src_start;
+	unsigned long dst_start;
+	unsigned long len;
+	uffd_flags_t flags;
+
+	struct vm_area_struct *vma;
+	unsigned long src_addr;
+	unsigned long dst_addr;
+	struct folio *folio;
+	pmd_t *pmd;
+};
+
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
@@ -272,17 +286,17 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
 	return ret;
 }
 
-static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
-				 struct vm_area_struct *dst_vma,
-				 unsigned long dst_addr,
-				 unsigned long src_addr,
-				 uffd_flags_t flags,
-				 struct folio **foliop)
+static int mfill_atomic_pte_copy(struct mfill_state *state)
 {
-	int ret;
+	struct vm_area_struct *dst_vma = state->vma;
+	unsigned long dst_addr = state->dst_addr;
+	unsigned long src_addr = state->src_addr;
+	uffd_flags_t flags = state->flags;
+	pmd_t *dst_pmd = state->pmd;
 	struct folio *folio;
+	int ret;
 
-	if (!*foliop) {
+	if (!state->folio) {
 		ret = -ENOMEM;
 		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma,
 					dst_addr);
@@ -294,13 +308,13 @@ static int mfill_atomic_pte_copy(pmd_t *dst_pmd,
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
-			*foliop = folio;
+			state->folio = folio;
 			/* don't free the page */
 			goto out;
 		}
 	} else {
-		folio = *foliop;
-		*foliop = NULL;
+		folio = state->folio;
+		state->folio = NULL;
 	}
 
 	/*
@@ -357,10 +371,11 @@ static int mfill_atomic_pte_zeroed_folio(pmd_t *dst_pmd,
 	return ret;
 }
 
-static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
-				     struct vm_area_struct *dst_vma,
-				     unsigned long dst_addr)
+static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 {
+	struct vm_area_struct *dst_vma = state->vma;
+	unsigned long dst_addr = state->dst_addr;
+	pmd_t *dst_pmd = state->pmd;
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
 	int ret;
@@ -392,13 +407,14 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 }
 
 /* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
-static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
-				     struct vm_area_struct *dst_vma,
-				     unsigned long dst_addr,
-				     uffd_flags_t flags)
+static int mfill_atomic_pte_continue(struct mfill_state *state)
 {
-	struct inode *inode = file_inode(dst_vma->vm_file);
+	struct vm_area_struct *dst_vma = state->vma;
+	unsigned long dst_addr = state->dst_addr;
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
+	struct inode *inode = file_inode(dst_vma->vm_file);
+	uffd_flags_t flags = state->flags;
+	pmd_t *dst_pmd = state->pmd;
 	struct folio *folio;
 	struct page *page;
 	int ret;
@@ -436,15 +452,15 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 }
 
 /* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
-static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
-				   struct vm_area_struct *dst_vma,
-				   unsigned long dst_addr,
-				   uffd_flags_t flags)
+static int mfill_atomic_pte_poison(struct mfill_state *state)
 {
-	int ret;
+	struct vm_area_struct *dst_vma = state->vma;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
+	unsigned long dst_addr = state->dst_addr;
+	pmd_t *dst_pmd = state->pmd;
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
+	int ret;
 
 	_dst_pte = make_pte_marker(PTE_MARKER_POISONED);
 	ret = -EAGAIN;
@@ -668,22 +684,20 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
 				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
-						struct vm_area_struct *dst_vma,
-						unsigned long dst_addr,
-						unsigned long src_addr,
-						uffd_flags_t flags,
-						struct folio **foliop)
+static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
 {
+	struct vm_area_struct *dst_vma = state->vma;
+	unsigned long src_addr = state->src_addr;
+	unsigned long dst_addr = state->dst_addr;
+	struct folio **foliop = &state->folio;
+	uffd_flags_t flags = state->flags;
+	pmd_t *dst_pmd = state->pmd;
 	ssize_t err;
 
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
-		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
-						 dst_addr, flags);
-	} else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
-		return mfill_atomic_pte_poison(dst_pmd, dst_vma,
-					       dst_addr, flags);
-	}
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		return mfill_atomic_pte_continue(state);
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
+		return mfill_atomic_pte_poison(state);
 
 	/*
 	 * The normal page fault path for a shmem will invoke the
@@ -697,12 +711,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
 		if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
-			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
-						    dst_addr, src_addr,
-						    flags, foliop);
+			err = mfill_atomic_pte_copy(state);
 		else
-			err = mfill_atomic_pte_zeropage(dst_pmd,
-						 dst_vma, dst_addr);
+			err = mfill_atomic_pte_zeropage(state);
 	} else {
 		err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
 					     dst_addr, src_addr,
@@ -718,13 +729,20 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long len,
 					    uffd_flags_t flags)
 {
+	struct mfill_state state = (struct mfill_state){
+		.ctx = ctx,
+		.dst_start = dst_start,
+		.src_start = src_start,
+		.flags = flags,
+
+		.src_addr = src_start,
+		.dst_addr = dst_start,
+	};
 	struct mm_struct *dst_mm = ctx->mm;
 	struct vm_area_struct *dst_vma;
+	long copied = 0;
 	ssize_t err;
 	pmd_t *dst_pmd;
-	unsigned long src_addr, dst_addr;
-	long copied;
-	struct folio *folio;
 
 	/*
 	 * Sanitize the command parameters:
@@ -736,10 +754,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	VM_WARN_ON_ONCE(src_start + len <= src_start);
 	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
-	src_addr = src_start;
-	dst_addr = dst_start;
-	copied = 0;
-	folio = NULL;
 retry:
 	/*
 	 * Make sure the vma is not shared, that the dst range is
@@ -790,12 +804,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
-	while (src_addr < src_start + len) {
-		pmd_t dst_pmdval;
+	state.vma = dst_vma;
 
-		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
+	while (state.src_addr < src_start + len) {
+		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
+
+		pmd_t dst_pmdval;
 
-		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
+		dst_pmd = mm_alloc_pmd(dst_mm, state.dst_addr);
 		if (unlikely(!dst_pmd)) {
 			err = -ENOMEM;
 			break;
@@ -827,34 +843,34 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * tables under us; pte_offset_map_lock() will deal with that.
 		 */
 
-		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
-				       src_addr, flags, &folio);
+		state.pmd = dst_pmd;
+		err = mfill_atomic_pte(&state);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
-			uffd_mfill_unlock(dst_vma);
-			VM_WARN_ON_ONCE(!folio);
+			uffd_mfill_unlock(state.vma);
+			VM_WARN_ON_ONCE(!state.folio);
 
-			kaddr = kmap_local_folio(folio, 0);
+			kaddr = kmap_local_folio(state.folio, 0);
 			err = copy_from_user(kaddr,
-					     (const void __user *) src_addr,
+					     (const void __user *)state.src_addr,
 					     PAGE_SIZE);
 			kunmap_local(kaddr);
 			if (unlikely(err)) {
 				err = -EFAULT;
 				goto out;
 			}
-			flush_dcache_folio(folio);
+			flush_dcache_folio(state.folio);
 			goto retry;
 		} else
-			VM_WARN_ON_ONCE(folio);
+			VM_WARN_ON_ONCE(state.folio);
 
 		if (!err) {
-			dst_addr += PAGE_SIZE;
-			src_addr += PAGE_SIZE;
+			state.dst_addr += PAGE_SIZE;
+			state.src_addr += PAGE_SIZE;
 			copied += PAGE_SIZE;
 
 			if (fatal_signal_pending(current))
@@ -866,10 +882,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	uffd_mfill_unlock(dst_vma);
+	uffd_mfill_unlock(state.vma);
 out:
-	if (folio)
-		folio_put(folio);
+	if (state.folio)
+		folio_put(state.folio);
 	VM_WARN_ON_ONCE(copied < 0);
 	VM_WARN_ON_ONCE(err > 0);
 	VM_WARN_ON_ONCE(!copied && !err);
-- 
2.51.0


