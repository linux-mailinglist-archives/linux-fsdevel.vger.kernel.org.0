Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580776EC95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjHCOdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjHCOdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDD1982
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691073141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4mj2S0TKyKcoVChRGDCiWswFcEXvTDuEU8gIwC6K6o=;
        b=TS2QemCLXeSFW7f8Imemx6PRIpZPaJbFhvWGanTb4F/IBMAlk/nwToEXimvQeKGGMILUNz
        1bHAsmQO7/B4MAm0zJqs5QVSdPgKQB8FyepFSp1zlO93D7df4YcEgLOuXK+R2206bXJZ0e
        fpyn2WKVIE1yIb5GdjWa4HxkWZEc7+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-HCWQv9YRPgScaImvEsTDUw-1; Thu, 03 Aug 2023 10:32:18 -0400
X-MC-Unique: HCWQv9YRPgScaImvEsTDUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 262F5891F20;
        Thu,  3 Aug 2023 14:32:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F931200B66C;
        Thu,  3 Aug 2023 14:32:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/7] mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
Date:   Thu,  3 Aug 2023 16:32:02 +0200
Message-ID: <20230803143208.383663-2-david@redhat.com>
In-Reply-To: <20230803143208.383663-1-david@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unfortunately commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
gup_can_follow_protnone()") missed that follow_page() and
follow_trans_huge_pmd() never implicitly set FOLL_NUMA because they really
don't want to fail on PROT_NONE-mapped pages -- either due to NUMA hinting
or due to inaccessible (PROT_NONE) VMAs.

As spelled out in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page
faults from gup/gup_fast"): "Other follow_page callers like KSM should not
use FOLL_NUMA, or they would fail to get the pages if they use follow_page
instead of get_user_pages."

liubo reported [1] that smaps_rollup results are imprecise, because they
miss accounting of pages that are mapped PROT_NONE. Further, it's easy
to reproduce that KSM no longer works on inaccessible VMAs on x86-64,
because pte_protnone()/pmd_protnone() also indictaes "true" in
inaccessible VMAs, and follow_page() refuses to return such pages right
now.

As KVM really depends on these NUMA hinting faults, removing the
pte_protnone()/pmd_protnone() handling in GUP code completely is not really
an option.

To fix the issues at hand, let's revive FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
to restore the original behavior for now and add better comments.

Set FOLL_HONOR_NUMA_FAULT independent of FOLL_FORCE in
is_valid_gup_args(), to add that flag for all external GUP users.

Note that there are three GUP-internal __get_user_pages() users that don't
end up calling is_valid_gup_args() and consequently won't get
FOLL_HONOR_NUMA_FAULT set.

1) get_dump_page(): we really don't want to handle NUMA hinting
   faults. It specifies FOLL_FORCE and wouldn't have honored NUMA
   hinting faults already.
2) populate_vma_page_range(): we really don't want to handle NUMA hinting
   faults. It specifies FOLL_FORCE on accessible VMAs, so it wouldn't have
   honored NUMA hinting faults already.
3) faultin_vma_page_range(): we similarly don't want to handle NUMA
   hinting faults.

To make the combination of FOLL_FORCE and FOLL_HONOR_NUMA_FAULT work in
inaccessible VMAs properly, we have to perform VMA accessibility checks in
gup_can_follow_protnone().

As GUP-fast should reject such pages either way in
pte_access_permitted()/pmd_access_permitted() -- for example on x86-64 and
arm64 that both implement pte_protnone() -- let's just always fallback
to ordinary GUP when stumbling over pte_protnone()/pmd_protnone().

As Linus notes [2], honoring NUMA faults might only make sense for
selected GUP users.

So we should really see if we can instead let relevant GUP callers specify
it manually, and not trigger NUMA hinting faults from GUP as default.
Prepare for that by making FOLL_HONOR_NUMA_FAULT an external GUP flag
and adding appropriate documenation.

While at it, remove a stale comment from follow_trans_huge_pmd(): That
comment for pmd_protnone() was added in commit 2b4847e73004 ("mm: numa:
serialise parallel get_user_page against THP migration"), which noted:

	THP does not unmap pages due to a lack of support for migration
	entries at a PMD level.  This allows races with get_user_pages

Nowadays, we do have PMD migration entries, so the comment no longer
applies. Let's drop it.

[1] https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
[2] https://lore.kernel.org/r/CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com

Reported-by: liubo <liubo254@huawei.com>
Closes: https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
Reported-by: Peter Xu <peterx@redhat.com>
Closes: https://lore.kernel.org/all/ZMKJjDaqZ7FW0jfe@x1n/
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 21 +++++++++++++++------
 include/linux/mm_types.h |  9 +++++++++
 mm/gup.c                 | 30 ++++++++++++++++++++++++------
 mm/huge_memory.c         |  3 +--
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 63edff994c32..ba38b78a1b84 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3525,15 +3525,24 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(unsigned int flags)
+static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+					   unsigned int flags)
 {
 	/*
-	 * FOLL_FORCE has to be able to make progress even if the VMA is
-	 * inaccessible. Further, FOLL_FORCE access usually does not represent
-	 * application behaviour and we should avoid triggering NUMA hinting
-	 * faults.
+	 * If callers don't want to honor NUMA hinting faults, no need to
+	 * determine if we would actually have to trigger a NUMA hinting fault.
 	 */
-	return flags & FOLL_FORCE;
+	if (!(flags & FOLL_HONOR_NUMA_FAULT))
+		return true;
+
+	/*
+	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
+	 *
+	 * Requiring a fault here even for inaccessible VMAs would mean that
+	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
+	 * refuses to process NUMA hinting faults in inaccessible VMAs.
+	 */
+	return !vma_is_accessible(vma);
 }
 
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index aae6af098031..291c05cacd48 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1278,6 +1278,15 @@ enum {
 	FOLL_PCI_P2PDMA = 1 << 10,
 	/* allow interrupts from generic signals */
 	FOLL_INTERRUPTIBLE = 1 << 11,
+	/*
+	 * Always honor (trigger) NUMA hinting faults.
+	 *
+	 * FOLL_WRITE implicitly honors NUMA hinting faults because a
+	 * PROT_NONE-mapped page is not writable (exceptions with FOLL_FORCE
+	 * apply). get_user_pages_fast_only() always implicitly honors NUMA
+	 * hinting faults.
+	 */
+	FOLL_HONOR_NUMA_FAULT = 1 << 12,
 
 	/* See also internal only FOLL flags in mm/internal.h */
 };
diff --git a/mm/gup.c b/mm/gup.c
index 2493ffa10f4b..3bbfae411880 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -597,7 +597,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto no_page;
-	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+	if (pte_protnone(pte) && !gup_can_follow_protnone(vma, flags))
 		goto no_page;
 
 	page = vm_normal_page(vma, address, pte);
@@ -714,7 +714,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
-	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags);
 
 	ptl = pmd_lock(mm, pmd);
@@ -844,6 +844,10 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
 		return NULL;
 
+	/*
+	 * We never set FOLL_HONOR_NUMA_FAULT because callers don't expect
+	 * to fail on PROT_NONE-mapped pages.
+	 */
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
@@ -2240,6 +2244,13 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 		gup_flags |= FOLL_UNLOCKABLE;
 	}
 
+	/*
+	 * For now, always trigger NUMA hinting faults. Some GUP users like
+	 * KVM require the hint to be as the calling context of GUP is
+	 * functionally similar to a memory reference from task context.
+	 */
+	gup_flags |= FOLL_HONOR_NUMA_FAULT;
+
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
 			 (FOLL_PIN | FOLL_GET)))
@@ -2564,7 +2575,14 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		struct page *page;
 		struct folio *folio;
 
-		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
+		/*
+		 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
+		 * pte_access_permitted() better should reject these pages
+		 * either way: otherwise, GUP-fast might succeed in
+		 * cases where ordinary GUP would fail due to VMA access
+		 * permissions.
+		 */
+		if (pte_protnone(pte))
 			goto pte_unmap;
 
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
@@ -2983,8 +3001,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
 			     pmd_devmap(pmd))) {
-			if (pmd_protnone(pmd) &&
-			    !gup_can_follow_protnone(flags))
+			/* See gup_pte_range() */
+			if (pmd_protnone(pmd))
 				return 0;
 
 			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
@@ -3164,7 +3182,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
 				       FOLL_FAST_ONLY | FOLL_NOFAULT |
-				       FOLL_PCI_P2PDMA)))
+				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e2e8a24cc71..0b709d2c46c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1467,8 +1467,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
 		return ERR_PTR(-EFAULT);
 
-	/* Full NUMA hinting faults to serialise migration in fault paths */
-	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
 		return NULL;
 
 	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
-- 
2.41.0

