Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470262B8A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiKPKd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiKPKc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A03C6E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fetjyNVdxegk0QG4w8mo8gn6x0g2HdvFN8vnJqqr3gA=;
        b=dalFN4tzJRMblko10CEnaRHPtOFdLle6BWJPvtKrSlrl6e6t73FVgf4s0GW2FXOVks7IGe
        DUxjc5OlQ+w6hlVKNBOn6fthPKa6sxuqsjUKR8tdqFawQ9XoADZQPzdtvncAVIugNkW+kb
        jH127oB8Cr9LGuRA61S3xW4EuF2qRxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-E78fxk5vOCySDX-MBsnqRQ-1; Wed, 16 Nov 2022 05:27:54 -0500
X-MC-Unique: E78fxk5vOCySDX-MBsnqRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6478027F5;
        Wed, 16 Nov 2022 10:27:53 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9344E2027064;
        Wed, 16 Nov 2022 10:27:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 04/20] mm: add early FAULT_FLAG_UNSHARE consistency checks
Date:   Wed, 16 Nov 2022 11:26:43 +0100
Message-Id: <20221116102659.70287-5-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, FAULT_FLAG_UNSHARE only applies to anonymous pages, which
implies a COW mapping. Let's hide FAULT_FLAG_UNSHARE early if we're not
dealing with a COW mapping, such that we treat it like a read fault as
documented and don't have to worry about the flag throughout all fault
handlers.

While at it, centralize the check for mutual exclusion of
FAULT_FLAG_UNSHARE and FAULT_FLAG_WRITE and just drop the check that
either flag is set in the WP handler.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  3 ---
 mm/hugetlb.c     |  5 -----
 mm/memory.c      | 23 ++++++++++++++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ed12cd3acbfd..68d00196b519 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1267,9 +1267,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
-	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
-
 	if (is_huge_zero_pmd(orig_pmd))
 		goto fallback;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1de986c62976..383b26069b33 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5314,9 +5314,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
-	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
-	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
-
 	/*
 	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
 	 * PTE mapped R/O such as maybe_mkwrite() would do.
@@ -5326,8 +5323,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		if (unlikely(unshare))
-			return 0;
 		set_huge_ptep_writable(vma, haddr, ptep);
 		return 0;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 2d453736f87c..e014435a87db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3344,9 +3344,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 
-	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
-
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -5161,6 +5158,22 @@ static void lru_gen_exit_fault(void)
 }
 #endif /* CONFIG_LRU_GEN */
 
+static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
+				       unsigned int *flags)
+{
+	if (unlikely(*flags & FAULT_FLAG_UNSHARE)) {
+		if (WARN_ON_ONCE(*flags & FAULT_FLAG_WRITE))
+			return VM_FAULT_SIGSEGV;
+		/*
+		 * FAULT_FLAG_UNSHARE only applies to COW mappings. Let's
+		 * just treat it like an ordinary read-fault otherwise.
+		 */
+		if (!is_cow_mapping(vma->vm_flags))
+			*flags &= ~FAULT_FLAG_UNSHARE;
+	}
+	return 0;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -5177,6 +5190,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	count_vm_event(PGFAULT);
 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
 
+	ret = sanitize_fault_flags(vma, &flags);
+	if (ret)
+		return ret;
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
-- 
2.38.1

