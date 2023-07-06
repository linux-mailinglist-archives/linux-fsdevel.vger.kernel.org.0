Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069774A735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGFWu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGFWuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:50:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B131723
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:50:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso1261920276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683851; x=1691275851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=axERsIn3EwMGffTL4fWJaIzLcp6XXXIYiFKDUzVzBqY=;
        b=yiBN+5aT9dRdKtxMwsd3u/C1Xvh33zuWSJWtyc3b2oqUAezQBMDYehbTlZSQ43q9rc
         GjxiS4tCHuYh72lUDHDWnhv1RNBmlVhS7uMGqqF6xgkO8xPXMZwt06lYIEgO4HT0GePH
         vDCilEspj/9gvKK6E/Xlu0bf+76WPjOT9jJ/vO5uQtiepbi44/uGZ+K0VB7otdT5xt0v
         Qw3dpYo216D1CFQLlt2k1rfsnwsPsRhpOt1hZF/IcAy4lMynJc8FNYjbTCbEFXlclhiW
         saVTIojFJ1zVagbeXVsgf0uniofnqL9UTOGwJEomvRE02Enf5Gry/gezLCRdZ5MsxGyZ
         mU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683851; x=1691275851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axERsIn3EwMGffTL4fWJaIzLcp6XXXIYiFKDUzVzBqY=;
        b=MriZMfM+Q5gNSBHBgPHZ1Gd4traLTGbEaz0c6kc59VrIQeTqwMx8we82KaniScVvhH
         L+fbGNeCYGrp0GMhRbMLaoZKPklvpzOz1n1zKBeybBn7Cta5neoh8xDxXNGZXPQs025d
         syJ14MzQeoFo0VdpHFNk5xXn+NcbLI/ryY20Bni2qsGmaI+A0xDjY2EHDH7cexN2hu/2
         Tc161Xaxp+XzyWaHp9e95mTmbzY5teUZ7YlQWPjCibCtz5VOyxmqIZelyMWk9iGmUgbo
         ls/S3N6CosgaaWSyQ6d9H7yrLDVKnFvxVPiKedPTI96GyDZOKIH0TAirT9PBmqqb0UL7
         F92A==
X-Gm-Message-State: ABy/qLbPOwZ/sLXOIY0WwLqgsOer4nyrlxwj/cBx8wSGdLAi35Ykp3cJ
        YR/Z89T4lKU/B5mVShCudIQUbzSn3K/Oe/HsYU7B
X-Google-Smtp-Source: APBJJlEW6RQNFcBDV4u0eUIIqgKV8wvUZrxJlNc8y+4BgE1qPhkLJw0lh7sQLrM0PWWyfIF59ugMgar+7EWrCClJ8tE/
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:30b:b0:c67:ebc5:de5d with
 SMTP id b11-20020a056902030b00b00c67ebc5de5dmr18087ybs.4.1688683851353; Thu,
 06 Jul 2023 15:50:51 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:29 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-2-axelrasmussen@google.com>
Subject: [PATCH v3 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
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

First, rename it to just PTE_MARKER_ERROR. The "SWAPIN" can be confusing
since we're going to re-use it for something not really related to swap.
This can be particularly confusing for things like hugetlbfs, which
doesn't support swap whatsoever. Also rename some various helper
functions.

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

Finally, for hugetlbfs faults, handle PTE_MARKER_ERROR, and return
VM_FAULT_HWPOISON_LARGE in such cases. Note that this can't happen today
because the lack of swap support means we'll never end up with such a
PTE anyway, but this behavior will be needed once such entries *can*
show up via UFFDIO_POISON.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/mm_inline.h | 19 +++++++++++++++++++
 include/linux/swapops.h   | 10 +++++-----
 mm/hugetlb.c              | 32 +++++++++++++++++++++-----------
 mm/madvise.c              |  2 +-
 mm/memory.c               | 15 +++++++++------
 mm/mprotect.c             |  4 ++--
 mm/shmem.c                |  4 ++--
 mm/swapfile.c             |  2 +-
 8 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 21d6c72bcc71..329bd9370b49 100644
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
+	pte_marker dstm = srcm & PTE_MARKER_ERROR;
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
index 4c932cb45e0b..5f1818d48dd6 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -393,7 +393,7 @@ static inline bool is_migration_entry_dirty(swp_entry_t entry)
 typedef unsigned long pte_marker;
 
 #define  PTE_MARKER_UFFD_WP			BIT(0)
-#define  PTE_MARKER_SWAPIN_ERROR		BIT(1)
+#define  PTE_MARKER_ERROR			BIT(1)
 #define  PTE_MARKER_MASK			(BIT(2) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
@@ -421,15 +421,15 @@ static inline pte_t make_pte_marker(pte_marker marker)
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
 }
 
-static inline swp_entry_t make_swapin_error_entry(void)
+static inline swp_entry_t make_error_swp_entry(void)
 {
-	return make_pte_marker_entry(PTE_MARKER_SWAPIN_ERROR);
+	return make_pte_marker_entry(PTE_MARKER_ERROR);
 }
 
-static inline int is_swapin_error_entry(swp_entry_t entry)
+static inline int is_error_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_SWAPIN_ERROR);
+	    (pte_marker_get(entry) & PTE_MARKER_ERROR);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bce28cca73a1..934e129d9939 100644
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
+			if (marker & PTE_MARKER_ERROR) {
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
index 886f06066622..59e954586e2a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -660,7 +660,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				free_swap_and_cache(entry);
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			} else if (is_hwpoison_entry(entry) ||
-				   is_swapin_error_entry(entry)) {
+				   is_error_swp_entry(entry)) {
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			}
 			continue;
diff --git a/mm/memory.c b/mm/memory.c
index 0ae594703021..c8b6de99d14c 100644
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
+			   is_error_swp_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
 		} else {
@@ -3647,7 +3650,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 * none pte.  Otherwise it means the pte could have changed, so retry.
 	 *
 	 * This should also cover the case where e.g. the pte changed
-	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_SWAPIN_ERROR.
+	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_ERROR.
 	 * So is_pte_marker() check is not enough to safely drop the pte.
 	 */
 	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
@@ -3693,8 +3696,8 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	/* Higher priority than uffd-wp when data corrupted */
-	if (marker & PTE_MARKER_SWAPIN_ERROR)
-		return VM_FAULT_SIGBUS;
+	if (marker & PTE_MARKER_ERROR)
+		return VM_FAULT_HWPOISON;
 
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..47d255c8c2f2 100644
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
+				if (is_error_swp_entry(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..c0f408c2c020 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1707,7 +1707,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	swp_entry_t swapin_error;
 	void *old;
 
-	swapin_error = make_swapin_error_entry();
+	swapin_error = make_error_swp_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
 			     swp_to_radix_entry(swap),
 			     swp_to_radix_entry(swapin_error), 0);
@@ -1752,7 +1752,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*foliop);
 	*foliop = NULL;
 
-	if (is_swapin_error_entry(swap))
+	if (is_error_swp_entry(swap))
 		return -EIO;
 
 	si = get_swap_device(swap);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..72e110387e67 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1773,7 +1773,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 			swp_entry = make_hwpoison_entry(swapcache);
 			page = swapcache;
 		} else {
-			swp_entry = make_swapin_error_entry();
+			swp_entry = make_error_swp_entry();
 		}
 		new_pte = swp_entry_to_pte(swp_entry);
 		ret = 0;
-- 
2.41.0.255.g8b1d071c50-goog

