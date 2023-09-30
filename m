Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69607B3DD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjI3Dcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjI3Dcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:32:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AEFBA
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:32:43 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a1d0fee86aso109597007b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044763; x=1696649563; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLFDDir+UoXbMx1glevMcvIlnqgdvYAatnW1ChgCi9k=;
        b=vLiMM/bxoa1vVYz9Hjqlg5djLADgF8njjFDJU1Ah1oEhcXAxomJch08jBg5JpdTIyY
         4swZHLFd3rTy9vL3JKPnkhiIEKqeaNUrZXr/OdJ2KX3pO/1JkNL/E9mpMaAur/owBSvD
         CSKNd6ByIWyNPmJRJEHHXIJ8N+zS2XC4dTo61IDGAtB4PSE4yooRLDjbPKIRNXGaSBfv
         VguCC8tsi0uCJK0Wx7xtuSzWMErjBvfcd1d6VEOo/X8aheL3C5ss1rk+fXUGV1qBhnNm
         90jOVa9BTxryt4M7ipEeVpQkaFfzBzrS+YJJXrLMnH1vx+bAVt0Xlr6Qnt9gUXOhXf6+
         xP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044763; x=1696649563;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLFDDir+UoXbMx1glevMcvIlnqgdvYAatnW1ChgCi9k=;
        b=OtvNs3ZT5fHXyf8Ve5EGA7dQt3Aj+f65y32e9sROKJG3KCqH+gXRE1731TITdQsJQA
         s6RmOxs1P/kjWFC6/IK6I0iBLAKcrk0n/NPOFlwAjgsvWfcl6dxBt77oUb0JwG9QVvqO
         k3NTh4zzSsX/61ej/T4kiVlYGm2+CxrIAvXfZdV1e7o5msl0M4LX+nqhfpW/3oSXwmSc
         lNR4o/iJ5ySucrxQ5arpt+ylF68XQtl4r/7IfLKLwyioGTglYYrmeLFTcXU/g/RGDQDJ
         IVOxhJujJ9yVaHTodclh21dHv1+dJ9DMT4t09HQPE9YuaGcvk/mb5TKG3gNXiUHB860Y
         I9Hg==
X-Gm-Message-State: AOJu0YwhSeBQh5Md8n9FwQo6pJlD2cLsynbSnLJ5pCLw0u4ZhOyiqZqE
        Vjq6g0fsNdtCbb+jMFu4EhxuuA==
X-Google-Smtp-Source: AGHT+IHWFfod1ajuoBsT7KhrXsYUjHQWaiJ/anqkA/cYNa4/2kw3W7fwQLS18Z3KXGOj6fs+CBR/pA==
X-Received: by 2002:a81:7951:0:b0:59b:ca2f:6eff with SMTP id u78-20020a817951000000b0059bca2f6effmr4258072ywc.40.1696044762549;
        Fri, 29 Sep 2023 20:32:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b005a1f7231cf5sm2704514ywc.142.2023.09.29.20.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:32:41 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:32:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 7/8] shmem: _add_to_page_cache() before
 shmem_inode_acct_blocks()
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <22ddd06-d919-33b-1219-56335c1bf28e@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There has been a recurring problem, that when a tmpfs volume is being
filled by racing threads, some fail with ENOSPC (or consequent SIGBUS
or EFAULT) even though all allocations were within the permitted size.

This was a problem since early days, but magnified and complicated by
the addition of huge pages.  We have often worked around it by adding
some slop to the tmpfs size, but it's hard to say how much is needed,
and some users prefer not to do that e.g. keeping sparse files in a
tightly tailored tmpfs helps to prevent accidental writing to holes.

This comes from the allocation sequence:
1. check page cache for existing folio
2. check and reserve from vm_enough_memory
3. check and account from size of tmpfs
4. if huge, check page cache for overlapping folio
5. allocate physical folio, huge or small
6. check and charge from mem cgroup limit
7. add to page cache (but maybe another folio already got in).

Concurrent tasks allocating at the same position could deplete the size
allowance and fail.  Doing vm_enough_memory and size checks before the
folio allocation was intentional (to limit the load on the page allocator
from this source) and still has some virtue; but memory cgroup never did
that, so I think it's better reordered to favour predictable behaviour.

1. check page cache for existing folio
2. if huge, check page cache for overlapping folio
3. allocate physical folio, huge or small
4. check and charge from mem cgroup limit
5. add to page cache (but maybe another folio already got in)
6. check and reserve from vm_enough_memory
7. check and account from size of tmpfs.

The folio lock held from allocation onwards ensures that the !uptodate
folio cannot be used by others, and can safely be deleted from the cache
if checks 6 or 7 subsequently fail (and those waiting on folio lock
already check that the folio was not truncated once they get the lock);
and the early addition to page cache ensures that racers find it before
they try to duplicate the accounting.

Seize the opportunity to tidy up shmem_get_folio_gfp()'s ENOSPC retrying,
which can be combined inside the new shmem_alloc_and_add_folio(): doing
2 splits twice (once huge, once nonhuge) is not exactly equivalent to
trying 5 splits (and giving up early on huge), but let's keep it simple
unless more complication proves necessary.

Userfaultfd is a foreign country: they do things differently there,
and for good reason - to avoid mmap_lock deadlock.  Leave ordering in
shmem_mfill_atomic_pte() untouched for now, but I would rather like to
mesh it better with shmem_get_folio_gfp() in the future.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 235 +++++++++++++++++++++++++++--------------------------
 1 file changed, 121 insertions(+), 114 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0a7f7b567b80..4f4ab26bc58a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -789,13 +789,11 @@ static int shmem_add_to_page_cache(struct folio *folio,
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-		if (folio_test_pmd_mappable(folio)) {
-			count_vm_event(THP_FILE_ALLOC);
+		if (folio_test_pmd_mappable(folio))
 			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
-		}
-		mapping->nrpages += nr;
 		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
 		__lruvec_stat_mod_folio(folio, NR_SHMEM, nr);
+		mapping->nrpages += nr;
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
@@ -1612,25 +1610,17 @@ static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
 		struct shmem_inode_info *info, pgoff_t index)
 {
 	struct vm_area_struct pvma;
-	struct address_space *mapping = info->vfs_inode.i_mapping;
-	pgoff_t hindex;
 	struct folio *folio;
 
-	hindex = round_down(index, HPAGE_PMD_NR);
-	if (xa_find(&mapping->i_pages, &hindex, hindex + HPAGE_PMD_NR - 1,
-								XA_PRESENT))
-		return NULL;
-
-	shmem_pseudo_vma_init(&pvma, info, hindex);
+	shmem_pseudo_vma_init(&pvma, info, index);
 	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, &pvma, 0, true);
 	shmem_pseudo_vma_destroy(&pvma);
-	if (!folio)
-		count_vm_event(THP_FILE_FALLBACK);
+
 	return folio;
 }
 
 static struct folio *shmem_alloc_folio(gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
+		struct shmem_inode_info *info, pgoff_t index)
 {
 	struct vm_area_struct pvma;
 	struct folio *folio;
@@ -1642,36 +1632,101 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 	return folio;
 }
 
-static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
-		pgoff_t index, bool huge)
+static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
+		struct inode *inode, pgoff_t index,
+		struct mm_struct *fault_mm, bool huge)
 {
+	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct folio *folio;
-	int nr;
-	int err;
+	long pages;
+	int error;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge = false;
-	nr = huge ? HPAGE_PMD_NR : 1;
 
-	err = shmem_inode_acct_blocks(inode, nr);
-	if (err)
-		goto failed;
+	if (huge) {
+		pages = HPAGE_PMD_NR;
+		index = round_down(index, HPAGE_PMD_NR);
+
+		/*
+		 * Check for conflict before waiting on a huge allocation.
+		 * Conflict might be that a huge page has just been allocated
+		 * and added to page cache by a racing thread, or that there
+		 * is already at least one small page in the huge extent.
+		 * Be careful to retry when appropriate, but not forever!
+		 * Elsewhere -EEXIST would be the right code, but not here.
+		 */
+		if (xa_find(&mapping->i_pages, &index,
+				index + HPAGE_PMD_NR - 1, XA_PRESENT))
+			return ERR_PTR(-E2BIG);
 
-	if (huge)
 		folio = shmem_alloc_hugefolio(gfp, info, index);
-	else
+		if (!folio)
+			count_vm_event(THP_FILE_FALLBACK);
+	} else {
+		pages = 1;
 		folio = shmem_alloc_folio(gfp, info, index);
-	if (folio) {
-		__folio_set_locked(folio);
-		__folio_set_swapbacked(folio);
-		return folio;
+	}
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	__folio_set_locked(folio);
+	__folio_set_swapbacked(folio);
+
+	gfp &= GFP_RECLAIM_MASK;
+	error = mem_cgroup_charge(folio, fault_mm, gfp);
+	if (error) {
+		if (xa_find(&mapping->i_pages, &index,
+				index + pages - 1, XA_PRESENT)) {
+			error = -EEXIST;
+		} else if (huge) {
+			count_vm_event(THP_FILE_FALLBACK);
+			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+		}
+		goto unlock;
 	}
 
-	err = -ENOMEM;
-	shmem_inode_unacct_blocks(inode, nr);
-failed:
-	return ERR_PTR(err);
+	error = shmem_add_to_page_cache(folio, mapping, index, NULL, gfp);
+	if (error)
+		goto unlock;
+
+	error = shmem_inode_acct_blocks(inode, pages);
+	if (error) {
+		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+		long freed;
+		/*
+		 * Try to reclaim some space by splitting a few
+		 * large folios beyond i_size on the filesystem.
+		 */
+		shmem_unused_huge_shrink(sbinfo, NULL, 2);
+		/*
+		 * And do a shmem_recalc_inode() to account for freed pages:
+		 * except our folio is there in cache, so not quite balanced.
+		 */
+		spin_lock(&info->lock);
+		freed = pages + info->alloced - info->swapped -
+			READ_ONCE(mapping->nrpages);
+		if (freed > 0)
+			info->alloced -= freed;
+		spin_unlock(&info->lock);
+		if (freed > 0)
+			shmem_inode_unacct_blocks(inode, freed);
+		error = shmem_inode_acct_blocks(inode, pages);
+		if (error) {
+			filemap_remove_folio(folio);
+			goto unlock;
+		}
+	}
+
+	shmem_recalc_inode(inode, pages, 0);
+	folio_add_lru(folio);
+	return folio;
+
+unlock:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ERR_PTR(error);
 }
 
 /*
@@ -1907,29 +1962,22 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct vm_fault *vmf, vm_fault_t *fault_type)
 {
 	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
-	struct address_space *mapping = inode->i_mapping;
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo;
 	struct mm_struct *fault_mm;
 	struct folio *folio;
-	pgoff_t hindex;
-	gfp_t huge_gfp;
 	int error;
-	int once = 0;
-	int alloced = 0;
+	bool alloced;
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
 repeat:
 	if (sgp <= SGP_CACHE &&
-	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
+	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
 		return -EINVAL;
-	}
 
-	sbinfo = SHMEM_SB(inode->i_sb);
+	alloced = false;
 	fault_mm = vma ? vma->vm_mm : NULL;
 
-	folio = filemap_get_entry(mapping, index);
+	folio = filemap_get_entry(inode->i_mapping, index);
 	if (folio && vma && userfaultfd_minor(vma)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
@@ -1951,7 +1999,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		folio_lock(folio);
 
 		/* Has the folio been truncated or swapped out? */
-		if (unlikely(folio->mapping != mapping)) {
+		if (unlikely(folio->mapping != inode->i_mapping)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			goto repeat;
@@ -1986,65 +2034,38 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (!shmem_is_huge(inode, index, false,
-			   vma ? vma->vm_mm : NULL, vma ? vma->vm_flags : 0))
-		goto alloc_nohuge;
+	if (shmem_is_huge(inode, index, false, fault_mm,
+			  vma ? vma->vm_flags : 0)) {
+		gfp_t huge_gfp;
 
-	huge_gfp = vma_thp_gfp_mask(vma);
-	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
-	folio = shmem_alloc_and_acct_folio(huge_gfp, inode, index, true);
-	if (IS_ERR(folio)) {
-alloc_nohuge:
-		folio = shmem_alloc_and_acct_folio(gfp, inode, index, false);
-	}
-	if (IS_ERR(folio)) {
-		int retry = 5;
-
-		error = PTR_ERR(folio);
-		folio = NULL;
-		if (error != -ENOSPC)
-			goto unlock;
-		/*
-		 * Try to reclaim some space by splitting a large folio
-		 * beyond i_size on the filesystem.
-		 */
-		while (retry--) {
-			int ret;
-
-			ret = shmem_unused_huge_shrink(sbinfo, NULL, 1);
-			if (ret == SHRINK_STOP)
-				break;
-			if (ret)
-				goto alloc_nohuge;
+		huge_gfp = vma_thp_gfp_mask(vma);
+		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
+		folio = shmem_alloc_and_add_folio(huge_gfp,
+				inode, index, fault_mm, true);
+		if (!IS_ERR(folio)) {
+			count_vm_event(THP_FILE_ALLOC);
+			goto alloced;
 		}
+		if (PTR_ERR(folio) == -EEXIST)
+			goto repeat;
+	}
+
+	folio = shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
+	if (IS_ERR(folio)) {
+		error = PTR_ERR(folio);
+		if (error == -EEXIST)
+			goto repeat;
+		folio = NULL;
 		goto unlock;
 	}
 
-	hindex = round_down(index, folio_nr_pages(folio));
-
-	if (sgp == SGP_WRITE)
-		__folio_set_referenced(folio);
-
-	error = mem_cgroup_charge(folio, fault_mm, gfp);
-	if (error) {
-		if (folio_test_pmd_mappable(folio)) {
-			count_vm_event(THP_FILE_FALLBACK);
-			count_vm_event(THP_FILE_FALLBACK_CHARGE);
-		}
-		goto unacct;
-	}
-
-	error = shmem_add_to_page_cache(folio, mapping, hindex, NULL, gfp);
-	if (error)
-		goto unacct;
-
-	folio_add_lru(folio);
-	shmem_recalc_inode(inode, folio_nr_pages(folio), 0);
+alloced:
 	alloced = true;
-
 	if (folio_test_pmd_mappable(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 					folio_next_index(folio) - 1) {
+		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+		struct shmem_inode_info *info = SHMEM_I(inode);
 		/*
 		 * Part of the large folio is beyond i_size: subject
 		 * to shrink under memory pressure.
@@ -2062,6 +2083,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		spin_unlock(&sbinfo->shrinklist_lock);
 	}
 
+	if (sgp == SGP_WRITE)
+		folio_set_referenced(folio);
 	/*
 	 * Let SGP_FALLOC use the SGP_WRITE optimization on a new folio.
 	 */
@@ -2085,11 +2108,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	/* Perhaps the file has been truncated since we checked */
 	if (sgp <= SGP_CACHE &&
 	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
-		if (alloced) {
-			folio_clear_dirty(folio);
-			filemap_remove_folio(folio);
-			shmem_recalc_inode(inode, 0, 0);
-		}
 		error = -EINVAL;
 		goto unlock;
 	}
@@ -2100,25 +2118,14 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	/*
 	 * Error recovery.
 	 */
-unacct:
-	shmem_inode_unacct_blocks(inode, folio_nr_pages(folio));
-
-	if (folio_test_large(folio)) {
-		folio_unlock(folio);
-		folio_put(folio);
-		goto alloc_nohuge;
-	}
 unlock:
+	if (alloced)
+		filemap_remove_folio(folio);
+	shmem_recalc_inode(inode, 0, 0);
 	if (folio) {
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	if (error == -ENOSPC && !once++) {
-		shmem_recalc_inode(inode, 0, 0);
-		goto repeat;
-	}
-	if (error == -EEXIST)
-		goto repeat;
 	return error;
 }
 
-- 
2.35.3

