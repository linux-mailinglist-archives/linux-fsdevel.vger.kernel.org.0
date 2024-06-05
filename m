Return-Path: <linux-fsdevel+bounces-20998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43088FC0A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29C1B27C34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE813A86C;
	Wed,  5 Jun 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOGRQgVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5C13A401;
	Wed,  5 Jun 2024 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547114; cv=none; b=hx+n+MqyzMau9NajK00LRqQxC9+5+AE/x2P5nd65pq1RSFeWfffBgnbMDzlsUtWM+gKATNVv70m5cvcTOv+LR3Igp1Ua+/9Kbt/l2Agdg1JBxOAvABU7oeARdZQus2toS7T9T1XHuuM9Bh6b3VG+IAX9dbl5uKuxaXbfNbVYuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547114; c=relaxed/simple;
	bh=MdL1CnIYtJxVuaoJQ4v36gHWpY8r7Nqra5mr+RAHejU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/kYrKe8CHwhcTVFMzFZxwMJVJ1lcqC7DlUVOzjxBoynL+3vy3v3y4CAKoicTFZKHwRgFIlXmXbarP7R1fIvx4he9cBGkGQkO0eCCUqXJ1PON4dWtE6DJCFp168f2U1PewM+0K/j0slYCSqZfvsrahytlvd/MoTPOQ0M2kK1sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOGRQgVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E94C2BBFC;
	Wed,  5 Jun 2024 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547114;
	bh=MdL1CnIYtJxVuaoJQ4v36gHWpY8r7Nqra5mr+RAHejU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOGRQgVNavyC3fwxEaZyJrjxDcYUvSoz/8YM6QedZh1sBl8wowm7FizTiavEjNHn/
	 EvjD1syryMww2h/Cd4Bk1oUVRd0afZpPTXHLoi/FeUHaRnDFDDMMPRviTgxBJSCq12
	 tt9tGFK9cPMKulFga2lx7O7/gt+WZaNagmDdfWm6cGfLykpdKe8Wt4dLAvnv8fo30u
	 qTNSE/DJb4zv2vaKfCZ/NqrLUbBBvVZqt3vYDDF4cw4Wz8o6nIehEZOjQ2NDnzHcqM
	 gl4tEPY3uixZj4n7PhMAbTTCssXdChHgeYz/B+Quhh2vTHPQC0HknreP7LHgGlYcRy
	 WSMJWgtfEVf9w==
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
Subject: [PATCH v3 1/9] mm: add find_vma()-like API but RCU protected and taking VMA lock
Date: Tue,  4 Jun 2024 17:24:46 -0700
Message-ID: <20240605002459.4091285-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605002459.4091285-1-andrii@kernel.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
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
index c41c82bcbec2..3ab52b7e124c 100644
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
index eef4e482c0c2..c9517742bd6d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5913,6 +5913,68 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
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


