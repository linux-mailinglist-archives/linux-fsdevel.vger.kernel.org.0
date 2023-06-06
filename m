Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA5724C25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbjFFTEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbjFFTEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59787173A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5343c1d114cso5935809a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078266; x=1688670266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTPC0AoXX+NIzZnufKQytW8TkFDwziCOrc5ZhwaQeP0=;
        b=owBmv/2mMPcrWAYYeOz6IufYws8uNBVmJpdSLiIa/Oxif5X7cqv+vateNaoAbLjKN+
         9g8OIvY2fitd8/bF4vWCTRGtTW4cbQGYeFnSk7O/6JmITSXQUE0V5caWCidr9eoCizfR
         mnHihiIAiXJOu1//OF3fyNTkiIvpgOeBZOYv+VfEA9HuxcdSL1KjLzz1ww4jo+xPlynH
         cZu+282ONjHqqdAeelyqOrgfiIuIaT7NMZ4iSDTpZ4yPFrLEm9YlMCTiZ2Jg+4dOz9SD
         Af25fA3ecy4VQVCca8EotY/PKiVwegJai+On/aGLqcq8u80JQ1wIUoTEAC7FSVslSvP6
         ocKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078266; x=1688670266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTPC0AoXX+NIzZnufKQytW8TkFDwziCOrc5ZhwaQeP0=;
        b=kdhBs8vN4wDLd4YlUsaFlWP2xuzi0C92RZYdTf1blnOvbVeK3s6wVZ3OqPN7Y+XWQ5
         u9+pIgpFe+YgJFfkwDlFVLUG5si/eAFcZSy+20Qan2qi/OP72OtjNFawMialw4X6zZNZ
         0dVJtpSaVWUamOzxv2arDFLetbswJewkmH21Fp0CsfgMjr9sdU5/yEKwh4Um4F/ljEqy
         HFxmrZxOc5IlxlQTO8OGF7how0T+4Gzbe2CuwOQrjMj+T3eaxZ3onfE4xUJLXKsFiT5e
         XFekxaR3qR5ajlMG057sjkTzYY2+QoaJElnzwuFpJ0Ka0mzBDGPgkVc+tNJQNFAZ+pV8
         t3Ag==
X-Gm-Message-State: AC+VfDyuphBiLvqMsogtfH12oY43w81mc9NUyTVhupnLvSc6xQWQljDS
        LkBUHyyJs65/rAE6CadB7IAOaWSwuQDP3mqFzw==
X-Google-Smtp-Source: ACHHUZ7U7Xr5zqg3KoBTJpAqI34Pla/gmFzawbxWzmrT+4L/HPyaurNY1sqxQPPqj80dK4ECUufRqT2mO/+XHSgL7w==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a65:618a:0:b0:542:9fad:de1 with SMTP
 id c10-20020a65618a000000b005429fad0de1mr614686pgv.12.1686078265785; Tue, 06
 Jun 2023 12:04:25 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:52 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <508025e09425a98d52b17cfbdc07340ae05e3e32.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 07/19] mm: hugetlb: Refactor vma_*_reservation functions
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vma_*_reservation functions rely on vma_resv_map(), which assumes on a
hugetlbfs concept of the resv_map being stored in a specific field of
the inode.

This refactor enables vma_*_reservation functions, now renamed
resv_map_*_reservation, to be used with non-hugetlbfs filesystems,
further decoupling hugetlb from hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 184 +++++++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 85 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d16c6417b90f..d943f83d15a9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2643,89 +2643,81 @@ static void return_unused_surplus_pages(struct hstate *h,
 
 
 /*
- * vma_needs_reservation, vma_commit_reservation and vma_end_reservation
- * are used by the huge page allocation routines to manage reservations.
+ * resv_map_needs_reservation, resv_map_commit_reservation and
+ * resv_map_end_reservation are used by the huge page allocation routines to
+ * manage reservations.
  *
- * vma_needs_reservation is called to determine if the huge page at addr
- * within the vma has an associated reservation.  If a reservation is
- * needed, the value 1 is returned.  The caller is then responsible for
- * managing the global reservation and subpool usage counts.  After
- * the huge page has been allocated, vma_commit_reservation is called
- * to add the page to the reservation map.  If the page allocation fails,
- * the reservation must be ended instead of committed.  vma_end_reservation
- * is called in such cases.
+ * resv_map_needs_reservation is called to determine if the huge page at addr
+ * within the vma has an associated reservation.  If a reservation is needed,
+ * the value 1 is returned.  The caller is then responsible for managing the
+ * global reservation and subpool usage counts.  After the huge page has been
+ * allocated, resv_map_commit_reservation is called to add the page to the
+ * reservation map.  If the page allocation fails, the reservation must be ended
+ * instead of committed.  resv_map_end_reservation is called in such cases.
  *
- * In the normal case, vma_commit_reservation returns the same value
- * as the preceding vma_needs_reservation call.  The only time this
- * is not the case is if a reserve map was changed between calls.  It
- * is the responsibility of the caller to notice the difference and
- * take appropriate action.
+ * In the normal case, resv_map_commit_reservation returns the same value as the
+ * preceding resv_map_needs_reservation call.  The only time this is not the
+ * case is if a reserve map was changed between calls.  It is the responsibility
+ * of the caller to notice the difference and take appropriate action.
  *
- * vma_add_reservation is used in error paths where a reservation must
- * be restored when a newly allocated huge page must be freed.  It is
- * to be called after calling vma_needs_reservation to determine if a
- * reservation exists.
+ * resv_map_add_reservation is used in error paths where a reservation must be
+ * restored when a newly allocated huge page must be freed.  It is to be called
+ * after calling resv_map_needs_reservation to determine if a reservation
+ * exists.
  *
- * vma_del_reservation is used in error paths where an entry in the reserve
- * map was created during huge page allocation and must be removed.  It is to
- * be called after calling vma_needs_reservation to determine if a reservation
+ * resv_map_del_reservation is used in error paths where an entry in the reserve
+ * map was created during huge page allocation and must be removed.  It is to be
+ * called after calling resv_map_needs_reservation to determine if a reservation
  * exists.
  */
-enum vma_resv_mode {
-	VMA_NEEDS_RESV,
-	VMA_COMMIT_RESV,
-	VMA_END_RESV,
-	VMA_ADD_RESV,
-	VMA_DEL_RESV,
+enum resv_map_resv_mode {
+	RESV_MAP_NEEDS_RESV,
+	RESV_MAP_COMMIT_RESV,
+	RESV_MAP_END_RESV,
+	RESV_MAP_ADD_RESV,
+	RESV_MAP_DEL_RESV,
 };
-static long __vma_reservation_common(struct hstate *h,
-				struct vm_area_struct *vma, unsigned long addr,
-				enum vma_resv_mode mode)
+static long __resv_map_reservation_common(struct resv_map *resv, pgoff_t resv_index,
+					  bool may_be_shared_mapping,
+					  enum resv_map_resv_mode mode)
 {
-	struct resv_map *resv;
-	pgoff_t idx;
 	long ret;
 	long dummy_out_regions_needed;
 
-	resv = vma_resv_map(vma);
-	if (!resv)
-		return 1;
-
-	idx = vma_hugecache_offset(h, vma, addr);
 	switch (mode) {
-	case VMA_NEEDS_RESV:
-		ret = region_chg(resv, idx, idx + 1, &dummy_out_regions_needed);
+	case RESV_MAP_NEEDS_RESV:
+		ret = region_chg(resv, resv_index, resv_index + 1, &dummy_out_regions_needed);
 		/* We assume that vma_reservation_* routines always operate on
 		 * 1 page, and that adding to resv map a 1 page entry can only
 		 * ever require 1 region.
 		 */
 		VM_BUG_ON(dummy_out_regions_needed != 1);
 		break;
-	case VMA_COMMIT_RESV:
-		ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
+	case RESV_MAP_COMMIT_RESV:
+		ret = region_add(resv, resv_index, resv_index + 1, 1, NULL, NULL);
 		/* region_add calls of range 1 should never fail. */
 		VM_BUG_ON(ret < 0);
 		break;
-	case VMA_END_RESV:
-		region_abort(resv, idx, idx + 1, 1);
+	case RESV_MAP_END_RESV:
+		region_abort(resv, resv_index, resv_index + 1, 1);
 		ret = 0;
 		break;
-	case VMA_ADD_RESV:
-		if (vma->vm_flags & VM_MAYSHARE) {
-			ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
+	case RESV_MAP_ADD_RESV:
+		if (may_be_shared_mapping) {
+			ret = region_add(resv, resv_index, resv_index + 1, 1, NULL, NULL);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		} else {
-			region_abort(resv, idx, idx + 1, 1);
-			ret = region_del(resv, idx, idx + 1);
+			region_abort(resv, resv_index, resv_index + 1, 1);
+			ret = region_del(resv, resv_index, resv_index + 1);
 		}
 		break;
-	case VMA_DEL_RESV:
-		if (vma->vm_flags & VM_MAYSHARE) {
-			region_abort(resv, idx, idx + 1, 1);
-			ret = region_del(resv, idx, idx + 1);
+	case RESV_MAP_DEL_RESV:
+		if (may_be_shared_mapping) {
+			region_abort(resv, resv_index, resv_index + 1, 1);
+			ret = region_del(resv, resv_index, resv_index + 1);
 		} else {
-			ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
+			ret = region_add(resv, resv_index, resv_index + 1, 1, NULL, NULL);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
 		}
@@ -2734,7 +2726,7 @@ static long __vma_reservation_common(struct hstate *h,
 		BUG();
 	}
 
-	if (vma->vm_flags & VM_MAYSHARE || mode == VMA_DEL_RESV)
+	if (may_be_shared_mapping || mode == RESV_MAP_DEL_RESV)
 		return ret;
 	/*
 	 * We know private mapping must have HPAGE_RESV_OWNER set.
@@ -2758,34 +2750,39 @@ static long __vma_reservation_common(struct hstate *h,
 	return ret;
 }
 
-static long vma_needs_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long resv_map_needs_reservation(struct resv_map *resv, pgoff_t resv_index,
+				       bool may_be_shared_mapping)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_NEEDS_RESV);
+	return __resv_map_reservation_common(
+		resv, resv_index, may_be_shared_mapping, RESV_MAP_NEEDS_RESV);
 }
 
-static long vma_commit_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long resv_map_commit_reservation(struct resv_map *resv, pgoff_t resv_index,
+					bool may_be_shared_mapping)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_COMMIT_RESV);
+	return __resv_map_reservation_common(
+		resv, resv_index, may_be_shared_mapping, RESV_MAP_COMMIT_RESV);
 }
 
-static void vma_end_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static void resv_map_end_reservation(struct resv_map *resv, pgoff_t resv_index,
+				     bool may_be_shared_mapping)
 {
-	(void)__vma_reservation_common(h, vma, addr, VMA_END_RESV);
+	(void)__resv_map_reservation_common(
+		resv, resv_index, may_be_shared_mapping, RESV_MAP_END_RESV);
 }
 
-static long vma_add_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long resv_map_add_reservation(struct resv_map *resv, pgoff_t resv_index,
+				     bool may_be_shared_mapping)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_ADD_RESV);
+	return __resv_map_reservation_common(
+		resv, resv_index, may_be_shared_mapping, RESV_MAP_ADD_RESV);
 }
 
-static long vma_del_reservation(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long addr)
+static long resv_map_del_reservation(struct resv_map *resv, pgoff_t resv_index,
+				     bool may_be_shared_mapping)
 {
-	return __vma_reservation_common(h, vma, addr, VMA_DEL_RESV);
+	return __resv_map_reservation_common(
+		resv, resv_index, may_be_shared_mapping, RESV_MAP_DEL_RESV);
 }
 
 /*
@@ -2811,7 +2808,12 @@ static long vma_del_reservation(struct hstate *h,
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct folio *folio)
 {
-	long rc = vma_needs_reservation(h, vma, address);
+	long rc;
+	struct resv_map *resv = vma_resv_map(vma);
+	pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
+	bool may_share = vma->vm_flags & VM_MAYSHARE;
+
+	rc = resv_map_needs_reservation(resv, resv_index, may_share);
 
 	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
@@ -2828,9 +2830,9 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 */
 			folio_clear_hugetlb_restore_reserve(folio);
 		else if (rc)
-			(void)vma_add_reservation(h, vma, address);
+			(void)resv_map_add_reservation(resv, resv_index, may_share);
 		else
-			vma_end_reservation(h, vma, address);
+			resv_map_end_reservation(resv, resv_index, may_share);
 	} else {
 		if (!rc) {
 			/*
@@ -2841,7 +2843,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
 			 */
-			rc = vma_del_reservation(h, vma, address);
+			rc = resv_map_del_reservation(resv, resv_index, may_share);
 			if (rc < 0)
 				/*
 				 * VERY rare out of memory condition.  Since
@@ -2855,7 +2857,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 		} else if (rc < 0) {
 			/*
 			 * Rare out of memory condition from
-			 * vma_needs_reservation call.  Memory allocation is
+			 * resv_map_needs_reservation call.  Memory allocation is
 			 * only attempted if a new entry is needed.  Therefore,
 			 * this implies there is not an entry in the
 			 * reserve map.
@@ -2877,7 +2879,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			/*
 			 * No reservation present, do nothing
 			 */
-			 vma_end_reservation(h, vma, address);
+			 resv_map_end_reservation(resv, resv_index, may_share);
 	}
 }
 
@@ -3019,13 +3021,17 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 	struct hugetlb_cgroup *h_cg = NULL;
 	bool deferred_reserve;
 
+	struct resv_map *resv = vma_resv_map(vma);
+	pgoff_t resv_index = vma_hugecache_offset(h, vma, addr);
+	bool may_share = vma->vm_flags & VM_MAYSHARE;
+
 	idx = hstate_index(h);
 	/*
 	 * Examine the region/reserve map to determine if the process
 	 * has a reservation for the page to be allocated.  A return
 	 * code of zero indicates a reservation exists (no change).
 	 */
-	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
+	map_chg = gbl_chg = resv_map_needs_reservation(resv, resv_index, may_share);
 	if (map_chg < 0)
 		return ERR_PTR(-ENOMEM);
 
@@ -3039,7 +3045,7 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 	if (map_chg || avoid_reserve) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0) {
-			vma_end_reservation(h, vma, addr);
+			resv_map_end_reservation(resv, resv_index, may_share);
 			return ERR_PTR(-ENOSPC);
 		}
 
@@ -3104,11 +3110,11 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 
 	hugetlb_set_folio_subpool(folio, spool);
 
-	map_commit = vma_commit_reservation(h, vma, addr);
+	map_commit = resv_map_commit_reservation(resv, resv_index, may_share);
 	if (unlikely(map_chg > map_commit)) {
 		/*
 		 * The page was added to the reservation map between
-		 * vma_needs_reservation and vma_commit_reservation.
+		 * resv_map_needs_reservation and resv_map_commit_reservation.
 		 * This indicates a race with hugetlb_reserve_pages.
 		 * Adjust for the subpool count incremented above AND
 		 * in hugetlb_reserve_pages for the same page.  Also,
@@ -3134,7 +3140,7 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
-	vma_end_reservation(h, vma, addr);
+	resv_map_end_reservation(resv, resv_index, may_share);
 	return ERR_PTR(-ENOSPC);
 }
 
@@ -5901,12 +5907,16 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * the spinlock.
 	 */
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+		struct resv_map *resv = vma_resv_map(vma);
+		pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
+		bool may_share = vma->vm_flags & VM_MAYSHARE;
+
+		if (resv_map_needs_reservation(resv, resv_index, may_share) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		resv_map_end_reservation(resv, resv_index, may_share);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
@@ -6070,12 +6080,16 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+		struct resv_map *resv = vma_resv_map(vma);
+		pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
+		bool may_share = vma->vm_flags & VM_MAYSHARE;
+
+		if (resv_map_needs_reservation(resv, resv_index, may_share) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		resv_map_end_reservation(resv, resv_index, may_share);
 
 		pagecache_folio = filemap_lock_folio(mapping, idx);
 	}
-- 
2.41.0.rc0.172.g3f132b7071-goog

