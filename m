Return-Path: <linux-fsdevel+bounces-79642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOxpE2wOq2nwZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:27:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41842261CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4181B3064F13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781A426D1B;
	Fri,  6 Mar 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0ECtBkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E402421F05;
	Fri,  6 Mar 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817531; cv=none; b=YwvpcVaXdXNoW0AEjtpTXFbPcyFgeSyYp7ucGVnCKVLPzPJYL8OMl7IG15Vt4Li7TGw3/sNUF3E5noowFxzGTBKONrx0mKWBSoyIcvOZ5cVf4eCzeWQbEy367GJQuNgl1KHE/nTWk33jDHqLyFZMaTRvD/UQ3r8aiN5IifOif90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817531; c=relaxed/simple;
	bh=G5arZbl8cQ1Z8+AqNUYSv0raYqzUJNHuE3AX6opuyHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCfBFLE0SiiBp6qU3JrND3No877XCzu2owtix9U59pIPXZzUr61QQwgdHym7dHRkHpebj9XaFEiLn/AqqjVy4wkT5+ybBwwNx76j+imQcB5Nw2DzwsHsUBQPU0R7QkzRM4KGDykYZQWjjOGPfz6sLyglig1AQ3bn5d1xBCALd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0ECtBkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5992AC4CEF7;
	Fri,  6 Mar 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817531;
	bh=G5arZbl8cQ1Z8+AqNUYSv0raYqzUJNHuE3AX6opuyHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0ECtBkCqhwlPUhpp20EDW+OTbsO/AwZiJOU8EVYFYjbLEOyU/XGLaAJ7uTlhSiah
	 P8aV4/SPGl5vj+fQEn4d4QaUgyOY/3GUt2qQ4j2J4/5ygt1wuZJ1nH1U88SQ2VETvY
	 GGfEz46WwjatfHliclfeBvPhTpZyYow7bP9jvr5yGANcXBimwFy/o+ho67ia/OCRYr
	 v2AKW/h1tbBX4pmQYCaxLmMITsalTlShiLAHSmWCmqUAxYFat6eCslXF4NSDjm86A/
	 l8Yx5r1NPEasv72Jw2fTXxml9jJdYhvB7Xk8tq4oZj3CAf4W3iBrq2EHnRPJvZZMco
	 C4uhnR215Vu0g==
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
Subject: [PATCH v2 04/15] userfaultfd: introduce mfill_get_vma() and mfill_put_vma()
Date: Fri,  6 Mar 2026 19:18:04 +0200
Message-ID: <20260306171815.3160826-5-rppt@kernel.org>
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
X-Rspamd-Queue-Id: E41842261CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79642-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Split the code that finds, locks and verifies VMA from mfill_atomic()
into a helper function.

This function will be used later during refactoring of
mfill_atomic_pte_copy().

Add a counterpart mfill_put_vma() helper that unlocks the VMA and
releases map_changing_lock.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 124 ++++++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 51 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 224b55804f99..baff11e83101 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -157,6 +157,73 @@ static void uffd_mfill_unlock(struct vm_area_struct *vma)
 }
 #endif
 
+static void mfill_put_vma(struct mfill_state *state)
+{
+	up_read(&state->ctx->map_changing_lock);
+	uffd_mfill_unlock(state->vma);
+	state->vma = NULL;
+}
+
+static int mfill_get_vma(struct mfill_state *state)
+{
+	struct userfaultfd_ctx *ctx = state->ctx;
+	uffd_flags_t flags = state->flags;
+	struct vm_area_struct *dst_vma;
+	int err;
+
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	dst_vma = uffd_mfill_lock(ctx->mm, state->dst_start, state->len);
+	if (IS_ERR(dst_vma))
+		return PTR_ERR(dst_vma);
+
+	/*
+	 * If memory mappings are changing because of non-cooperative
+	 * operation (e.g. mremap) running in parallel, bail out and
+	 * request the user to retry later
+	 */
+	down_read(&ctx->map_changing_lock);
+	err = -EAGAIN;
+	if (atomic_read(&ctx->mmap_changing))
+		goto out_unlock;
+
+	err = -EINVAL;
+
+	/*
+	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
+	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
+	 */
+	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
+	    dst_vma->vm_flags & VM_SHARED))
+		goto out_unlock;
+
+	/*
+	 * validate 'mode' now that we know the dst_vma: don't allow
+	 * a wrprotect copy if the userfaultfd didn't register as WP.
+	 */
+	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+		goto out_unlock;
+
+	if (is_vm_hugetlb_page(dst_vma))
+		goto out;
+
+	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+		goto out_unlock;
+	if (!vma_is_shmem(dst_vma) &&
+	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		goto out_unlock;
+
+out:
+	state->vma = dst_vma;
+	return 0;
+
+out_unlock:
+	mfill_put_vma(state);
+	return err;
+}
+
 static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 {
 	pgd_t *pgd;
@@ -768,8 +835,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		.src_addr = src_start,
 		.dst_addr = dst_start,
 	};
-	struct mm_struct *dst_mm = ctx->mm;
-	struct vm_area_struct *dst_vma;
 	long copied = 0;
 	ssize_t err;
 
@@ -784,57 +849,17 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
 retry:
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	dst_vma = uffd_mfill_lock(dst_mm, dst_start, len);
-	if (IS_ERR(dst_vma)) {
-		err = PTR_ERR(dst_vma);
+	err = mfill_get_vma(&state);
+	if (err)
 		goto out;
-	}
-
-	/*
-	 * If memory mappings are changing because of non-cooperative
-	 * operation (e.g. mremap) running in parallel, bail out and
-	 * request the user to retry later
-	 */
-	down_read(&ctx->map_changing_lock);
-	err = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
-		goto out_unlock;
-
-	err = -EINVAL;
-	/*
-	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
-	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
-	 */
-	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
-	    dst_vma->vm_flags & VM_SHARED))
-		goto out_unlock;
-
-	/*
-	 * validate 'mode' now that we know the dst_vma: don't allow
-	 * a wrprotect copy if the userfaultfd didn't register as WP.
-	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
-		goto out_unlock;
 
 	/*
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
-	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
+	if (is_vm_hugetlb_page(state.vma))
+		return  mfill_atomic_hugetlb(ctx, state.vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
-		goto out_unlock;
-
-	state.vma = dst_vma;
-
 	while (state.src_addr < src_start + len) {
 		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
 
@@ -853,8 +878,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		if (unlikely(err == -ENOENT)) {
 			void *kaddr;
 
-			up_read(&ctx->map_changing_lock);
-			uffd_mfill_unlock(state.vma);
+			mfill_put_vma(&state);
 			VM_WARN_ON_ONCE(!state.folio);
 
 			kaddr = kmap_local_folio(state.folio, 0);
@@ -883,9 +907,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 	}
 
-out_unlock:
-	up_read(&ctx->map_changing_lock);
-	uffd_mfill_unlock(state.vma);
+	mfill_put_vma(&state);
 out:
 	if (state.folio)
 		folio_put(state.folio);
-- 
2.51.0


