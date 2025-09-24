Return-Path: <linux-fsdevel+bounces-62587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE2B9A837
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B30A7A6D60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C949D3126D8;
	Wed, 24 Sep 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="RG0JPtsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA5311958;
	Wed, 24 Sep 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726704; cv=none; b=dHMedOMelL/Us3YcMom6SmDmfr/ZTfEzkh3KjkgvqHZIrL+5WOW3PlQndhuF69/3JY3RnaszRG2D2opZXdqiz366jCb+v/5E90iZEhPsx10qB9mBo9nFiGPn6VZx8otqEcsveL3pH1davHBc8/NtwyHMXavDOfZiJgqdmUuvUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726704; c=relaxed/simple;
	bh=3YBCS8/vYWarW5mbcKqKFfx5mDgwFNabwIGUmQGdGtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b88XqDxYJ1kLFEVsqUfqQ4rm9b+SFvCLm5mKc9qbUYTxGGeP29QOH2MNeSeyy+DREYLxHm1jnp6TmINfEmao/LQzL7EUJjnDMk3V9mHMf9B1KaY5ZMdXsv0U/CaJq5IRLudlPegsw4eo/0sRJ7h0TvSUbbEWbgnxUq8pFXJz1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=RG0JPtsN; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4cX0gG6ylTzyYT;
	Wed, 24 Sep 2025 17:11:38 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=lm-postout21; i=@campus.lmu.de; t=
	1758726698; bh=s5H/qTs1nudTxJ8yEOOcf+EAL5JPehCIC+Q0Q8OSONs=; b=R
	G0JPtsN9UEnXJFQzBMPYDP/N9Zr6HWFbwVj6dUvA7EoG8DL/jYz7y8hH6z3trEt1
	XwBMiShMJ3IcI+u+YSfdNGHblQxBvI68hMBJT/keq4wZEigIgpXQWEQRElKWXHSY
	6eqcZKUt22Lok50/OVQmCaQaBb51+dwRowbZRL32rovBEOzY7q1kh8MwdUjwGZzR
	C8hRR/y2wKRfJJojJrhpgvVjWsmOoLqLm8JIEzzuO+K+KAC72t0ur6KeRFDsEE1x
	vj1DJBTQzTi/Omwqf+nFkrOrQQpxO5ZXTEbZM94dp/x0RjKM/TzIqSVMip4YQAjd
	oBlRCa+gdsek/xHfB2DCA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.887
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id KCYFCS0pWMYK; Wed, 24 Sep 2025 17:11:38 +0200 (CEST)
Received: from spacestation.cable.virginm.net (oxfd-27-b2-v4wan-164230-cust474.vm42.cable.virginm.net [86.22.133.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4cX0gC06QHzyXY;
	Wed, 24 Sep 2025 17:11:34 +0200 (CEST)
From: Patrick Roy <patrick.roy@campus.lmu.de>
To: 
Cc: Patrick Roy <roypat@amazon.co.uk>,
	pbonzini@redhat.com,
	corbet@lwn.net,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	shuah@kernel.org,
	seanjc@google.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.co.uk,
	derekmn@amazon.co.uk,
	tabba@google.com,
	ackerleytng@google.com
Subject: [PATCH v7 03/12] mm: introduce AS_NO_DIRECT_MAP
Date: Wed, 24 Sep 2025 16:10:43 +0100
Message-ID: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Patrick Roy <roypat@amazon.co.uk>

Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
set to not present . Currently, mappings that match this description are
secretmem mappings (memfd_secret()). Later, some guest_memfd
configurations will also fall into this category.

Reject this new type of mappings in all locations that currently reject
secretmem mappings, on the assumption that if secretmem mappings are
rejected somewhere, it is precisely because of an inability to deal with
folios without direct map entries, and then make memfd_secret() use
AS_NO_DIRECT_MAP on its address_space to drop its special
vma_is_secretmem()/secretmem_mapping() checks.

This drops a optimization in gup_fast_folio_allowed() where
secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
by default"), so the secretmem check did not actually end up elided in
most cases anymore anyway.

Use a new flag instead of overloading AS_INACCESSIBLE (which is already
set by guest_memfd) because not all guest_memfd mappings will end up
being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
can be mapped to userspace should also be GUP-able, and generally not
have restrictions on who can access it).

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/linux/pagemap.h   | 16 ++++++++++++++++
 include/linux/secretmem.h | 18 ------------------
 lib/buildid.c             |  4 ++--
 mm/gup.c                  | 19 +++++--------------
 mm/mlock.c                |  2 +-
 mm/secretmem.c            |  8 ++------
 6 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..1f5739f6a9f5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -211,6 +211,7 @@ enum mapping_flags {
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
+	AS_NO_DIRECT_MAP = 10,	/* Folios in the mapping are not in the direct map */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -346,6 +347,21 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_spac
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
+static inline void mapping_set_no_direct_map(struct address_space *mapping)
+{
+	set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
+}
+
+static inline bool mapping_no_direct_map(const struct address_space *mapping)
+{
+	return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
+}
+
+static inline bool vma_has_no_direct_map(const struct vm_area_struct *vma)
+{
+	return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index e918f96881f5..0ae1fb057b3d 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -4,28 +4,10 @@
 
 #ifdef CONFIG_SECRETMEM
 
-extern const struct address_space_operations secretmem_aops;
-
-static inline bool secretmem_mapping(struct address_space *mapping)
-{
-	return mapping->a_ops == &secretmem_aops;
-}
-
-bool vma_is_secretmem(struct vm_area_struct *vma);
 bool secretmem_active(void);
 
 #else
 
-static inline bool vma_is_secretmem(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline bool secretmem_mapping(struct address_space *mapping)
-{
-	return false;
-}
-
 static inline bool secretmem_active(void)
 {
 	return false;
diff --git a/lib/buildid.c b/lib/buildid.c
index c4b0f376fb34..89e567954284 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -65,8 +65,8 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
-	/* reject secretmem folios created with memfd_secret() */
-	if (secretmem_mapping(r->file->f_mapping))
+	/* reject folios without direct map entries (e.g. from memfd_secret() or guest_memfd()) */
+	if (mapping_no_direct_map(r->file->f_mapping))
 		return -EFAULT;
 
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..75a0cffdf37d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -11,7 +11,6 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
-#include <linux/secretmem.h>
 
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
@@ -1234,7 +1233,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_SPLIT_PMD) && is_vm_hugetlb_page(vma))
 		return -EOPNOTSUPP;
 
-	if (vma_is_secretmem(vma))
+	if (vma_has_no_direct_map(vma))
 		return -EFAULT;
 
 	if (write) {
@@ -2736,7 +2735,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * This call assumes the caller has pinned the folio, that the lowest page table
  * level still points to this folio, and that interrupts have been disabled.
  *
- * GUP-fast must reject all secretmem folios.
+ * GUP-fast must reject all folios without direct map entries (such as secretmem).
  *
  * Writing to pinned file-backed dirty tracked folios is inherently problematic
  * (see comment describing the writable_file_mapping_allowed() function). We
@@ -2751,7 +2750,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 {
 	bool reject_file_backed = false;
 	struct address_space *mapping;
-	bool check_secretmem = false;
 	unsigned long mapping_flags;
 
 	/*
@@ -2763,18 +2761,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 		reject_file_backed = true;
 
 	/* We hold a folio reference, so we can safely access folio fields. */
-
-	/* secretmem folios are always order-0 folios. */
-	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
-		check_secretmem = true;
-
-	if (!reject_file_backed && !check_secretmem)
-		return true;
-
 	if (WARN_ON_ONCE(folio_test_slab(folio)))
 		return false;
 
-	/* hugetlb neither requires dirty-tracking nor can be secretmem. */
+	/* hugetlb neither requires dirty-tracking nor can be without direct map. */
 	if (folio_test_hugetlb(folio))
 		return true;
 
@@ -2812,8 +2802,9 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	 * At this point, we know the mapping is non-null and points to an
 	 * address_space object.
 	 */
-	if (check_secretmem && secretmem_mapping(mapping))
+	if (mapping_no_direct_map(mapping))
 		return false;
+
 	/* The only remaining allowed file system is shmem. */
 	return !reject_file_backed || shmem_mapping(mapping);
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index a1d93ad33c6d..36f5e70faeb0 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -474,7 +474,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
+	    vma_is_dax(vma) || vma_has_no_direct_map(vma) || (oldflags & VM_DROPPABLE))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..f4d767c3fe2e 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -134,11 +134,6 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 	return 0;
 }
 
-bool vma_is_secretmem(struct vm_area_struct *vma)
-{
-	return vma->vm_ops == &secretmem_vm_ops;
-}
-
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
 	.mmap_prepare	= secretmem_mmap_prepare,
@@ -156,7 +151,7 @@ static void secretmem_free_folio(struct folio *folio)
 	folio_zero_segment(folio, 0, folio_size(folio));
 }
 
-const struct address_space_operations secretmem_aops = {
+static const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 	.free_folio	= secretmem_free_folio,
 	.migrate_folio	= secretmem_migrate_folio,
@@ -205,6 +200,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_unevictable(inode->i_mapping);
+	mapping_set_no_direct_map(inode->i_mapping);
 
 	inode->i_op = &secretmem_iops;
 	inode->i_mapping->a_ops = &secretmem_aops;
-- 
2.51.0


