Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739662B8FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiKPKhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiKPKf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872BDFCC2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MyRNKgE9VejcvK3KnE6hG0vB3Gd3R9NfE1yvuVtmrG0=;
        b=az/oN5oGXt9xMmLMV1E7eMRsaCAVLSXrJpPoMRktWJ2u2PqxA/IUAs+hngxVxgt+MyXi2u
        MCfCuyQoERN2U2bYv9eI4Xw0mTTSWD8CJ+iJU7PreAR4aVXJ3WjT5Ui/56/8MOJrGM1c5D
        dbbx3B0Z+C8FAGO7Dwlzl2bwELqXWKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-x5l38RKeO-CqL_8lbQ5Wdg-1; Wed, 16 Nov 2022 05:28:31 -0500
X-MC-Unique: x5l38RKeO-CqL_8lbQ5Wdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96DF7101A528;
        Wed, 16 Nov 2022 10:28:29 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 287292028E8F;
        Wed, 16 Nov 2022 10:28:23 +0000 (UTC)
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
Subject: [PATCH mm-unstable v1 09/20] mm/gup: reliable R/O long-term pinning in COW mappings
Date:   Wed, 16 Nov 2022 11:26:48 +0100
Message-Id: <20221116102659.70287-10-david@redhat.com>
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

We already support reliable R/O pinning of anonymous memory. However,
assume we end up pinning (R/O long-term) a pagecache page or the shared
zeropage inside a writable private ("COW") mapping. The next write access
will trigger a write-fault and replace the pinned page by an exclusive
anonymous page in the process page tables to break COW: the pinned page no
longer corresponds to the page mapped into the process' page table.

Now that FAULT_FLAG_UNSHARE can break COW on anything mapped into a
COW mapping, let's properly break COW first before R/O long-term
pinning something that's not an exclusive anon page inside a COW
mapping. FAULT_FLAG_UNSHARE will break COW and map an exclusive anon page
instead that can get pinned safely.

With this change, we can stop using FOLL_FORCE|FOLL_WRITE for reliable
R/O long-term pinning in COW mappings.

With this change, the new R/O long-term pinning tests for non-anonymous
memory succeed:
  # [RUN] R/O longterm GUP pin ... with shared zeropage
  ok 151 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP pin ... with memfd
  ok 152 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP pin ... with tmpfile
  ok 153 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP pin ... with huge zeropage
  ok 154 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP pin ... with memfd hugetlb (2048 kB)
  ok 155 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP pin ... with memfd hugetlb (1048576 kB)
  ok 156 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with shared zeropage
  ok 157 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with memfd
  ok 158 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with tmpfile
  ok 159 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with huge zeropage
  ok 160 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (2048 kB)
  ok 161 Longterm R/O pin is reliable
  # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (1048576 kB)
  ok 162 Longterm R/O pin is reliable

Note 1: We don't care about short-term R/O-pinning, because they have
snapshot semantics: they are not supposed to observe modifications that
happen after pinning.

As one example, assume we start direct I/O to read from a page and store
page content into a file: modifications to page content after starting
direct I/O are not guaranteed to end up in the file. So even if we'd pin
the shared zeropage, the end result would be as expected -- getting zeroes
stored to the file.

Note 2: For shared mappings we'll now always fallback to the slow path to
lookup the VMA when R/O long-term pining. While that's the necessary price
we have to pay right now, it's actually not that bad in practice: most
FOLL_LONGTERM users already specify FOLL_WRITE, for example, along with
FOLL_FORCE because they tried dealing with COW mappings correctly ...

Note 3: For users that use FOLL_LONGTERM right now without FOLL_WRITE,
such as VFIO, we'd now no longer pin the shared zeropage. Instead, we'd
populate exclusive anon pages that we can pin. There was a concern that
this could affect the memlock limit of existing setups.

For example, a VM running with VFIO could run into the memlock limit and
fail to run. However, we essentially had the same behavior already in
commit 17839856fd58 ("gup: document and work around "COW can break either
way" issue") which got merged into some enterprise distros, and there were
not any such complaints. So most probably, we're fine.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 27 ++++++++++++++++++++++++---
 mm/gup.c           | 10 +++++-----
 mm/huge_memory.c   |  2 +-
 mm/hugetlb.c       |  7 ++++---
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6bd2ee5872dd..e8cc838f42f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3095,8 +3095,12 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Must be called with the (sub)page that's actually referenced via the
  * page table entry, which might not necessarily be the head page for a
  * PTE-mapped THP.
+ *
+ * If the vma is NULL, we're coming from the GUP-fast path and might have
+ * to fallback to the slow path just to lookup the vma.
  */
-static inline bool gup_must_unshare(unsigned int flags, struct page *page)
+static inline bool gup_must_unshare(struct vm_area_struct *vma,
+				    unsigned int flags, struct page *page)
 {
 	/*
 	 * FOLL_WRITE is implicitly handled correctly as the page table entry
@@ -3109,8 +3113,25 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
 	 * Note: PageAnon(page) is stable until the page is actually getting
 	 * freed.
 	 */
-	if (!PageAnon(page))
-		return false;
+	if (!PageAnon(page)) {
+		/*
+		 * We only care about R/O long-term pining: R/O short-term
+		 * pinning does not have the semantics to observe successive
+		 * changes through the process page tables.
+		 */
+		if (!(flags & FOLL_LONGTERM))
+			return false;
+
+		/* We really need the vma ... */
+		if (!vma)
+			return true;
+
+		/*
+		 * ... because we only care about writable private ("COW")
+		 * mappings where we have to break COW early.
+		 */
+		return is_cow_mapping(vma->vm_flags);
+	}
 
 	/* Paired with a memory barrier in page_try_share_anon_rmap(). */
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
diff --git a/mm/gup.c b/mm/gup.c
index 5182abaaecde..01116699c863 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -578,7 +578,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		}
 	}
 
-	if (!pte_write(pte) && gup_must_unshare(flags, page)) {
+	if (!pte_write(pte) && gup_must_unshare(vma, flags, page)) {
 		page = ERR_PTR(-EMLINK);
 		goto out;
 	}
@@ -2338,7 +2338,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			goto pte_unmap;
 		}
 
-		if (!pte_write(pte) && gup_must_unshare(flags, page)) {
+		if (!pte_write(pte) && gup_must_unshare(NULL, flags, page)) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
@@ -2506,7 +2506,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!pte_write(pte) && gup_must_unshare(flags, &folio->page)) {
+	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2572,7 +2572,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;
 	}
 
-	if (!pmd_write(orig) && gup_must_unshare(flags, &folio->page)) {
+	if (!pmd_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2612,7 +2612,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;
 	}
 
-	if (!pud_write(orig) && gup_must_unshare(flags, &folio->page)) {
+	if (!pud_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 68d00196b519..dec7a7c0eca8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1434,7 +1434,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
 		return NULL;
 
-	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
+	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 383b26069b33..c3aab6d5b7aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6195,7 +6195,8 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
-static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
+static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
+					       unsigned int flags, pte_t *pte,
 					       bool *unshare)
 {
 	pte_t pteval = huge_ptep_get(pte);
@@ -6207,7 +6208,7 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
 		return false;
 	if (flags & FOLL_WRITE)
 		return true;
-	if (gup_must_unshare(flags, pte_page(pteval))) {
+	if (gup_must_unshare(vma, flags, pte_page(pteval))) {
 		*unshare = true;
 		return true;
 	}
@@ -6336,7 +6337,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * directly from any kind of swap entries.
 		 */
 		if (absent ||
-		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
+		    __follow_hugetlb_must_fault(vma, flags, pte, &unshare)) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
-- 
2.38.1

