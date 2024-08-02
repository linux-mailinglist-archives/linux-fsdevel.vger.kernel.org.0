Return-Path: <linux-fsdevel+bounces-24888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E194611B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63836B23653
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB017E72E;
	Fri,  2 Aug 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNDtAPh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CE17E709
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614207; cv=none; b=hBzNPZhTm/Uc+uKiRKQq5xbRXpn3dyvHfwyE//RLxnuoCwjKDlsBbop8MP3A8BitkMgiC7kbsGNfjpbl2zQHiNjNaeI8Jb4Wh74ZK0AFLADzocI52pZgCm5dUGIRZKE5MgQRX5s3bgVZizwREK6HnmD8qs5ig6RtNDFvo1sMOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614207; c=relaxed/simple;
	bh=BHfhJrsd92h4Q1KfRv5HAZdhBRATlXmf64EjgmZS4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr76l+R5pIZSehR+Yv6qt6zKbYCLDgR9n8jr5U/mksJ87Q+DLcDdpaD81Vpumk7AGlBnFqZdMpog/IpBTlxCU7H2sqKT3nV3hiFt2ArWGbGTggDENFcyJwfgpycS1wDu0mGIhRKDbQS29PWZnigcYbTjJBA7TGNU1/lunrQbT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNDtAPh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPEnEoi5Ma31G0FuCm1jYE13UYiHj4w8jLpqqbcOSIc=;
	b=UNDtAPh1piq8CNEFSq5O37ZwpYrE+n5QSZaUUjX2F6qkMJMGL0DKWCzsCkFZ+WiZ8aPGbu
	NRTOX2rOg2Cu4W/PYtn3BghGHgJPjqDTq7vYxiTZMwPYkNujJOiU0IwQgJDBnadDvo3pSP
	NVTIOxGihXiXQUWSFh1AR5L6tViteaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-6ny0YSGpPsS9rY-jD1QXAg-1; Fri,
 02 Aug 2024 11:56:42 -0400
X-MC-Unique: 6ny0YSGpPsS9rY-jD1QXAg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 420521944B27;
	Fri,  2 Aug 2024 15:56:39 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13545300018D;
	Fri,  2 Aug 2024 15:56:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 10/11] mm: remove follow_page()
Date: Fri,  2 Aug 2024 17:55:23 +0200
Message-ID: <20240802155524.517137-11-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

All users are gone, let's remove it and any leftovers in comments. We'll
leave any FOLL/follow_page_() naming cleanups as future work.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst |  6 +++---
 include/linux/mm.h             |  3 ---
 mm/filemap.c                   |  2 +-
 mm/gup.c                       | 24 +-----------------------
 mm/nommu.c                     |  6 ------
 5 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 1ba0ad63246c..a2cd8800d527 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -31,10 +31,10 @@ Design principles
   feature that applies to all dynamic high order allocations in the
   kernel)
 
-get_user_pages and follow_page
-==============================
+get_user_pages and pin_user_pages
+=================================
 
-get_user_pages and follow_page if run on a hugepage, will return the
+get_user_pages and pin_user_pages if run on a hugepage, will return the
 head or tail pages as usual (exactly as they would do on
 hugetlbfs). Most GUP users will only care about the actual physical
 address of the page and its temporary pinning to release after the I/O
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2f6c08b53e4f..ee8cea73d415 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3527,9 +3527,6 @@ static inline vm_fault_t vmf_fs_error(int err)
 	return VM_FAULT_SIGBUS;
 }
 
-struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
-			 unsigned int foll_flags);
-
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 {
 	if (vm_fault & VM_FAULT_OOM)
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..4130be74f6fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -112,7 +112,7 @@
  *    ->swap_lock		(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->i_pages lock		(try_to_unmap_one)
- *    ->lruvec->lru_lock	(follow_page->mark_page_accessed)
+ *    ->lruvec->lru_lock	(follow_page_mask->mark_page_accessed)
  *    ->lruvec->lru_lock	(check_pte_range->isolate_lru_page)
  *    ->private_lock		(folio_remove_rmap_pte->set_page_dirty)
  *    ->i_pages lock		(folio_remove_rmap_pte->set_page_dirty)
diff --git a/mm/gup.c b/mm/gup.c
index 3e8484c893aa..d19884e097fd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1072,28 +1072,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	return page;
 }
 
-struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
-			 unsigned int foll_flags)
-{
-	struct follow_page_context ctx = { NULL };
-	struct page *page;
-
-	if (vma_is_secretmem(vma))
-		return NULL;
-
-	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
-		return NULL;
-
-	/*
-	 * We never set FOLL_HONOR_NUMA_FAULT because callers don't expect
-	 * to fail on PROT_NONE-mapped pages.
-	 */
-	page = follow_page_mask(vma, address, foll_flags, &ctx);
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
-	return page;
-}
-
 static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		unsigned int gup_flags, struct vm_area_struct **vma,
 		struct page **page)
@@ -2519,7 +2497,7 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	 * These flags not allowed to be specified externally to the gup
 	 * interfaces:
 	 * - FOLL_TOUCH/FOLL_PIN/FOLL_TRIED/FOLL_FAST_ONLY are internal only
-	 * - FOLL_REMOTE is internal only and used on follow_page()
+	 * - FOLL_REMOTE is internal only, set in (get|pin)_user_pages_remote()
 	 * - FOLL_UNLOCKABLE is internal only and used if locked is !NULL
 	 */
 	if (WARN_ON_ONCE(gup_flags & INTERNAL_GUP_FLAGS))
diff --git a/mm/nommu.c b/mm/nommu.c
index 40cac1348b40..385b0c15add8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1578,12 +1578,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	return ret;
 }
 
-struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
-			 unsigned int foll_flags)
-{
-	return NULL;
-}
-
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-- 
2.45.2


