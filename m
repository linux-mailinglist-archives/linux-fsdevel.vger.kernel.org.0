Return-Path: <linux-fsdevel+bounces-20087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D68CE034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B70F1C222BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583313BBC1;
	Fri, 24 May 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFp08kfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5D3A29C;
	Fri, 24 May 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523841; cv=none; b=K1SQw2Qu74ovk/a3bZpScYCxPe+F6zKT0B13PNeVvMKSJVuohI7xKptnM12jF9DbEMD1qOZzDRksW5qfEx92jJ8/jbemCXAagBjU/zstHplMCI9+svrNTDAa09sAWJ8JV8Z25P3TroZczoIimGn1aqVTZZH+yNZ/LWQSYmcVCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523841; c=relaxed/simple;
	bh=cJ+pScGp7VQ+eleJC++23Mq/1Sbkvghbyy7uqJ0sROc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvD9RuqxBoWhUozNTYMkzz49OO3yKxc00j2o0t6KxLWUJnFwwUWFewvf0xx1R9vlBBDJpy2DPHiuP0+GBw0CtzFTYaBH7s1D12nZoVTCBzVqr60tR4/aBKK2E7636+1bowtE6E7lm2eC3vGWTkm/XU+GsdfxLIybsTfHZYCO9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFp08kfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06448C2BBFC;
	Fri, 24 May 2024 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716523841;
	bh=cJ+pScGp7VQ+eleJC++23Mq/1Sbkvghbyy7uqJ0sROc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFp08kfJT/u230KfRh8KqGt5sSUogcNzDpvTxTL3DehKhSM2HsZXTiaJaOUvv6DMn
	 W8/fhxdpRcolBrDIFowYh93P2QEDsWjAskP8Un7vrZyo7WCoS8QHczfNzVst468c0X
	 +SVv9r/Z8Q3Q5zo4tovdIn9zvdrdsBWI3Fih+kSlmUj1B0nqbi3i0DwkJc9+qO4TCF
	 1bI8tRsRzwCUEmvyyB7FlOknLWOgexqHRqK52owJf1l/rVDXIRrI+PsKW3BCwnupVN
	 eAbpq9A4Df1NN3hJaRAS5Xudvrxw3W5IZeJXr503yLUuMGhypQPSfhkXFXjRnTvJIA
	 +K7dt48W1qQUg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 1/9] mm: add find_vma()-like API but RCU protected and taking VMA lock
Date: Thu, 23 May 2024 21:10:23 -0700
Message-ID: <20240524041032.1048094-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing lock_vma_under_rcu() API assumes exact VMA match, so it's not
a 100% equivalent of find_vma(). There are use cases that do want
find_vma() semantics of finding an exact VMA or the next one.

Also, it's important for such an API to let user distinguish between not
being able to get per-VMA lock and not having any VMAs at or after
provided address.

As such, this patch adds a new find_vma()-like API,
find_and_lock_vma_rcu(), which finds exact or next VMA, attempts to take
per-VMA lock, and if that fails, returns ERR_PTR(-EBUSY). It still
returns NULL if there is no VMA at or after address. In successfuly case
it will return valid and non-isolated VMA with VMA lock taken.

This API will be used in subsequent patch in this patch set to implement
a new user-facing API for querying process VMAs.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/mm.h |  8 ++++++
 mm/memory.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..a6846401da77 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -776,6 +776,8 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 		mmap_assert_locked(vmf->vma->vm_mm);
 }
 
+struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
+					  unsigned long address);
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 					  unsigned long address);
 
@@ -790,6 +792,12 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
+struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
+					     unsigned long address)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		unsigned long address)
 {
diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..9d0413e98d8b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5824,6 +5824,68 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_PER_VMA_LOCK
+/*
+ * find_and_lock_vma_rcu() - Find and lock the VMA for a given address, or the
+ * next VMA. Search is done under RCU protection, without taking or assuming
+ * mmap_lock. Returned VMA is guaranteed to be stable and not isolated.
+
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next VMA.
+ * May return %NULL in the case of no VMA at addr or above.
+ * If the VMA is being modified and can't be locked, -EBUSY is returned.
+ */
+struct vm_area_struct *find_and_lock_vma_rcu(struct mm_struct *mm,
+					     unsigned long address)
+{
+	MA_STATE(mas, &mm->mm_mt, address, address);
+	struct vm_area_struct *vma;
+	int err;
+
+	rcu_read_lock();
+retry:
+	vma = mas_find(&mas, ULONG_MAX);
+	if (!vma) {
+		err = 0; /* no VMA, return NULL */
+		goto inval;
+	}
+
+	if (!vma_start_read(vma)) {
+		err = -EBUSY;
+		goto inval;
+	}
+
+	/*
+	 * Check since vm_start/vm_end might change before we lock the VMA.
+	 * Note, unlike lock_vma_under_rcu() we are searching for VMA covering
+	 * address or the next one, so we only make sure VMA wasn't updated to
+	 * end before the address.
+	 */
+	if (unlikely(vma->vm_end <= address)) {
+		err = -EBUSY;
+		goto inval_end_read;
+	}
+
+	/* Check if the VMA got isolated after we found it */
+	if (vma->detached) {
+		vma_end_read(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
+		/* The area was replaced with another one */
+		goto retry;
+	}
+
+	rcu_read_unlock();
+	return vma;
+
+inval_end_read:
+	vma_end_read(vma);
+inval:
+	rcu_read_unlock();
+	count_vm_vma_lock_event(VMA_LOCK_ABORT);
+	return ERR_PTR(err);
+}
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the
-- 
2.43.0


