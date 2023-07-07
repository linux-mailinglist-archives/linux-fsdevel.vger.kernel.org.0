Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38574B8E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjGGV4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjGGVzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:55:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357492105
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:55:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5cea5773e8so2661881276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766945; x=1691358945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B70uVhggCX8fJNIY7gzg1xZOvXHfmALP4G5DZO4j1xc=;
        b=QMS3WZg30DM3nklkucAdvPFP0qPy5/mGc8Rq4F6Mwo5PRAhSuGlTM9nPNReje+qJWC
         f1YvL6DSuMLBGxMiN9ZA+jOZADIPR58nXsdTRYufCEWE9hX/dgGQPjcnQHU/ptHtbA+9
         K379J7XgV5wYOIAA5PCuZJq/1ezJ6yKLgiGrkY3x1i1vRjn3NPhlmy7BCmaa8YXJTdTC
         iU2C/h2e81QUxqrVVHcgF7b7xoU5eKKYm/ylPoAsrvZChDqpRSthCfTNtjv/ZaK4k4Vo
         6icDFibzuF8Uix1QTjV4alO5LLAQ7WtSuUVkGB8I2FcVe15qGjiEueapzQTQ/lMJWfMt
         9vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766945; x=1691358945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B70uVhggCX8fJNIY7gzg1xZOvXHfmALP4G5DZO4j1xc=;
        b=jicMd1QGLSdmVuB3Hnn0cFw0qe5FR7cVXqCYI16tFGmLar+U7ihijIqvjphHwLT6CO
         EzcXC/7us/HBT26dNlAplynPkjg2vJcESLC7LxvM2pDHloxeg54nxYm3SRAX0V4fto/J
         Xy8HgSZ5h4fVyR9UCNrHRd1i680ChNDiJZfyDiJEWdAX9ad7Ysp+g0oxiOxAqVypBSYO
         2HvF9jz803ZM5/ICGFhi1zaI8PCPTPpMIIiBzjnLGjaoYMII8aWKAl3yi1PSbcJ8RJO4
         GbdLzw0mguhdNrch4bR7WXr8+OCZd1y1ZlAnluxVfSmENTd5/3oENCyN/TBpOnCmagt1
         OeUw==
X-Gm-Message-State: ABy/qLZXP5PP5+GET5I8GBEC9TroRwuu2EsidJM4rkphjfeaJDbXWD2u
        fb6YQ5fj6OZJzDCCBVwFcHWn7IUmAAIGKLa1KjBO
X-Google-Smtp-Source: APBJJlFO+dy0OuzOto98GK6Ib07YvcCh2JXDJhvTyNfjxaAmDvRpFN8QngXCTxnAVEaKVcdA8r/3KCXJmrdI1PcwvNw1
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a25:694e:0:b0:c72:2386:7d26 with
 SMTP id e75-20020a25694e000000b00c7223867d26mr3509ybc.0.1688766945429; Fri,
 07 Jul 2023 14:55:45 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:33 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-2-axelrasmussen@google.com>
Subject: [PATCH v4 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Future patches will re-use PTE_MARKER_SWAPIN_ERROR to implement
UFFDIO_POISON, so make some various preparations for that:

First, rename it to just PTE_MARKER_POISONED. The "SWAPIN" can be
confusing since we're going to re-use it for something not really
related to swap. This can be particularly confusing for things like
hugetlbfs, which doesn't support swap whatsoever. Also rename some
various helper functions.

Next, fix pte marker copying for hugetlbfs. Previously, it would WARN on
seeing a PTE_MARKER_SWAPIN_ERROR, since hugetlbfs doesn't support swap.
But, since we're going to re-use it, we want it to go ahead and copy it
just like non-hugetlbfs memory does today. Since the code to do this is
more complicated now, pull it out into a helper which can be re-used in
both places. While we're at it, also make it slightly more explicit in
its handling of e.g. uffd wp markers.

For non-hugetlbfs page faults, instead of returning VM_FAULT_SIGBUS for
an error entry, return VM_FAULT_HWPOISON. For most cases this change
doesn't matter, e.g. a userspace program would receive a SIGBUS either
way. But for UFFDIO_POISON, this change will let KVM guests get an MCE
out of the box, instead of giving a SIGBUS to the hypervisor and
requiring it to somehow inject an MCE.

Finally, for hugetlbfs faults, handle PTE_MARKER_POISONED, and return
VM_FAULT_HWPOISON_LARGE in such cases. Note that this can't happen today
because the lack of swap support means we'll never end up with such a
PTE anyway, but this behavior will be needed once such entries *can*
show up via UFFDIO_POISON.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mm_inline.h | 19 +++++++++++++++++++
 include/linux/swapops.h   | 15 ++++++++++-----
 mm/hugetlb.c              | 32 +++++++++++++++++++++-----------
 mm/madvise.c              |  2 +-
 mm/memory.c               | 15 +++++++++------
 mm/mprotect.c             |  4 ++--
 mm/shmem.c                |  4 ++--
 mm/swapfile.c             |  2 +-
 8 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 21d6c72bcc71..a86c84600787 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -523,6 +523,25 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+/*
+ * Computes the pte marker to copy from the given source entry into dst_vma.
+ * If no marker should be copied, returns 0.
+ * The caller should insert a new pte created with make_pte_marker().
+ */
+static inline pte_marker copy_pte_marker(
+		swp_entry_t entry, struct vm_area_struct *dst_vma)
+{
+	pte_marker srcm = pte_marker_get(entry);
+	/* Always copy error entries. */
+	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+
+	/* Only copy PTE markers if UFFD register matches. */
+	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
+		dstm |= PTE_MARKER_UFFD_WP;
+
+	return dstm;
+}
+
 /*
  * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
  * replace a none pte.  NOTE!  This should only be called when *pte is already
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 4c932cb45e0b..bff1e8d97de0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -393,7 +393,12 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP			BIT(0)
-#define  PTE_MARKER_SWAPIN_ERROR		BIT(1)
+/*
+ * "Poisoned" here is meant in the very general sense of "future accesses are
+ * invalid", instead of referring very specifically to hardware memory errors.
+ * This marker is meant to represent any of various different causes of this.
+ */
+#define  PTE_MARKER_POISONED			BIT(1)
 #define  PTE_MARKER_MASK			(BIT(2) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
@@ -421,15 +426,15 @@ static inline pte_t make_pte_marker(pte_marker marker)
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
 }
 
-static inline swp_entry_t make_swapin_error_entry(void)
+static inline swp_entry_t make_poisoned_swp_entry(void)
 {
-	return make_pte_marker_entry(PTE_MARKER_SWAPIN_ERROR);
+	return make_pte_marker_entry(PTE_MARKER_POISONED);
 }
 
-static inline int is_swapin_error_entry(swp_entry_t entry)
+static inline int is_poisoned_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_SWAPIN_ERROR);
+	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..66225b21c64e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -34,6 +34,7 @@
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
 #include <linux/memory.h>
+#include <linux/mm_inline.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -5101,15 +5102,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
-			/* No swap on hugetlb */
-			WARN_ON_ONCE(
-			    is_swapin_error_entry(pte_to_swp_entry(entry)));
-			/*
-			 * We copy the pte marker only if the dst vma has
-			 * uffd-wp enabled.
-			 */
-			if (userfaultfd_wp(dst_vma))
-				set_huge_pte_at(dst, addr, dst_pte, entry);
+			pte_marker marker = copy_pte_marker(
+				pte_to_swp_entry(entry), dst_vma);
+
+			if (marker)
+				set_huge_pte_at(dst, addr, dst_pte,
+						make_pte_marker(marker));
 		} else {
 			entry = huge_ptep_get(src_pte);
 			pte_folio = page_folio(pte_page(entry));
@@ -6090,14 +6088,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	entry = huge_ptep_get(ptep);
-	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry))
+	if (huge_pte_none_mostly(entry)) {
+		if (is_pte_marker(entry)) {
+			pte_marker marker =
+				pte_marker_get(pte_to_swp_entry(entry));
+
+			if (marker & PTE_MARKER_POISONED) {
+				ret = VM_FAULT_HWPOISON_LARGE;
+				goto out_mutex;
+			}
+		}
+
 		/*
+		 * Other PTE markers should be handled the same way as none PTE.
+		 *
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
 				      entry, flags);
+	}
 
 	ret = 0;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 886f06066622..a317aa0a92b8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -660,7 +660,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				free_swap_and_cache(entry);
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			} else if (is_hwpoison_entry(entry) ||
-				   is_swapin_error_entry(entry)) {
+				   is_poisoned_swp_entry(entry)) {
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			}
 			continue;
diff --git a/mm/memory.c b/mm/memory.c
index 0ae594703021..6309a4b9a79d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -860,8 +860,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			return -EBUSY;
 		return -ENOENT;
 	} else if (is_pte_marker_entry(entry)) {
-		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))
-			set_pte_at(dst_mm, addr, dst_pte, pte);
+		pte_marker marker = copy_pte_marker(entry, dst_vma);
+
+		if (marker)
+			set_pte_at(dst_mm, addr, dst_pte,
+				   make_pte_marker(marker));
 		return 0;
 	}
 	if (!userfaultfd_wp(dst_vma))
@@ -1500,7 +1503,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			    !zap_drop_file_uffd_wp(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
-			   is_swapin_error_entry(entry)) {
+			   is_poisoned_swp_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
 		} else {
@@ -3647,7 +3650,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 * none pte.  Otherwise it means the pte could have changed, so retry.
 	 *
 	 * This should also cover the case where e.g. the pte changed
-	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_SWAPIN_ERROR.
+	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_POISONED.
 	 * So is_pte_marker() check is not enough to safely drop the pte.
 	 */
 	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
@@ -3693,8 +3696,8 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/* Higher priority than uffd-wp when data corrupted */
-	if (marker & PTE_MARKER_SWAPIN_ERROR)
-		return VM_FAULT_SIGBUS;
+	if (marker & PTE_MARKER_POISONED)
+		return VM_FAULT_HWPOISON;
 
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..5c3112d92466 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -230,10 +230,10 @@ static long change_pte_range(struct mmu_gather *tlb,
 					newpte = pte_swp_mkuffd_wp(newpte);
 			} else if (is_pte_marker_entry(entry)) {
 				/*
-				 * Ignore swapin errors unconditionally,
+				 * Ignore error swap entries unconditionally,
 				 * because any access should sigbus anyway.
 				 */
-				if (is_swapin_error_entry(entry))
+				if (is_poisoned_swp_entry(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..ebfde8416bb3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1707,7 +1707,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	swp_entry_t swapin_error;
 	void *old;
 
-	swapin_error = make_swapin_error_entry();
+	swapin_error = make_poisoned_swp_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
 			     swp_to_radix_entry(swap),
 			     swp_to_radix_entry(swapin_error), 0);
@@ -1752,7 +1752,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*foliop);
 	*foliop = NULL;
 
-	if (is_swapin_error_entry(swap))
+	if (is_poisoned_swp_entry(swap))
 		return -EIO;
 
 	si = get_swap_device(swap);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..3dbc6d37df60 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1773,7 +1773,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 			swp_entry = make_hwpoison_entry(swapcache);
 			page = swapcache;
 		} else {
-			swp_entry = make_swapin_error_entry();
+			swp_entry = make_poisoned_swp_entry();
 		}
 		new_pte = swp_entry_to_pte(swp_entry);
 		ret = 0;
-- 
2.41.0.255.g8b1d071c50-goog

