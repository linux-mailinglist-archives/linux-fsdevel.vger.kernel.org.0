Return-Path: <linux-fsdevel+bounces-24889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D714946122
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08746284304
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C81A34AF;
	Fri,  2 Aug 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRs79Jng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A091A34AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614215; cv=none; b=BS6ACICFHN8qanyRfc2cuo5FCFxppDN6rmsRpJKWxeZ1VJtZD4HlGqoSukysn6BVPz3j1aUUkCDTdtgDEEmoTK/o2M/cPZyDZJEZVgf9PvtSQQytE7bdTTGND7CyF9saLvQtkj1Yc1ZB7OM3f5kxhRJcCEiguaHQCqldf8G3OoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614215; c=relaxed/simple;
	bh=B9QpgUZqHBSgII4REwP9lD0/53JlrVZdILJpl6GeaCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U410A5CmdsKT+rti1To8ERwTy1pWlaTUst0uG0EaEgzz6HKwlyqcHHT41HLxsuY4lhN79wlcZ3kDvYlBSQRROmgImmpacQsGwjcLorxTdSePhLoIJgLD5z9sLtO0UebpVoakudCwkf/uJQmN0L3I5ZS/fXlQzjHL/dMWRO43lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRs79Jng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XisBOloUEP3qStGU5kEnvOleMULjhsDMvLI1Qb38ywI=;
	b=bRs79JngCOolXYl6SE8bhilS+fN80odEh/eRydoWwxJN8AjBqFFLj5kg7WF3wDih2IoqH7
	UNs/LJWKYY9+/2O67KJhSIVMC3pUVndkTz6oJbiZJSrU16IYahp7aubDaPYugWxc4yUCmW
	FDm2opal3XUeyBQulg3EF3x0HuuA0Hg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-7fMx_I3IMvS20EQpewJYGQ-1; Fri,
 02 Aug 2024 11:56:48 -0400
X-MC-Unique: 7fMx_I3IMvS20EQpewJYGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 833C51955D4D;
	Fri,  2 Aug 2024 15:56:45 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B30F4300018D;
	Fri,  2 Aug 2024 15:56:39 +0000 (UTC)
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
Subject: [PATCH v1 11/11] mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk
Date: Fri,  2 Aug 2024 17:55:24 +0200
Message-ID: <20240802155524.517137-12-david@redhat.com>
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

Let's simplify by reusing folio_walk. Keep the existing behavior by
handling migration entries and zeropages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 63 ++++++++++++++------------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0f5b2bba4ef0..8e53666bc7b0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -608,47 +608,6 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
-			struct mm_walk *walk)
-{
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t *pte;
-	pte_t ptent;
-	int ret;
-
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte)
-		return 0;
-	ptent = ptep_get(pte);
-	if (pte_present(ptent)) {
-		page = vm_normal_page(walk->vma, addr, ptent);
-	} else if (!pte_none(ptent)) {
-		swp_entry_t entry = pte_to_swp_entry(ptent);
-
-		/*
-		 * As KSM pages remain KSM pages until freed, no need to wait
-		 * here for migration to end.
-		 */
-		if (is_migration_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
-	}
-	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	ret = (page && PageKsm(page)) || is_ksm_zero_pte(ptent);
-	pte_unmap_unlock(pte, ptl);
-	return ret;
-}
-
-static const struct mm_walk_ops break_ksm_ops = {
-	.pmd_entry = break_ksm_pmd_entry,
-	.walk_lock = PGWALK_RDLOCK,
-};
-
-static const struct mm_walk_ops break_ksm_lock_vma_ops = {
-	.pmd_entry = break_ksm_pmd_entry,
-	.walk_lock = PGWALK_WRLOCK,
-};
-
 /*
  * We use break_ksm to break COW on a ksm page by triggering unsharing,
  * such that the ksm page will get replaced by an exclusive anonymous page.
@@ -665,16 +624,26 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
 {
 	vm_fault_t ret = 0;
-	const struct mm_walk_ops *ops = lock_vma ?
-				&break_ksm_lock_vma_ops : &break_ksm_ops;
+
+	if (lock_vma)
+		vma_start_write(vma);
 
 	do {
-		int ksm_page;
+		bool ksm_page = false;
+		struct folio_walk fw;
+		struct folio *folio;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
-		if (WARN_ON_ONCE(ksm_page < 0))
-			return ksm_page;
+		folio = folio_walk_start(&fw, vma, addr,
+					 FW_MIGRATION | FW_ZEROPAGE);
+		if (folio) {
+			/* Small folio implies FW_LEVEL_PTE. */
+			if (!folio_test_large(folio) &&
+			    (folio_test_ksm(folio) || is_ksm_zero_pte(fw.pte)))
+				ksm_page = true;
+			folio_walk_end(&fw, vma);
+		}
+
 		if (!ksm_page)
 			return 0;
 		ret = handle_mm_fault(vma, addr,
-- 
2.45.2


