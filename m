Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBADF7A06C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjINOBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbjINOBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:01:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC31BF8;
        Thu, 14 Sep 2023 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694700090; x=1726236090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bMbySF0Aym3FISZYXplxC5HZ57L1umCzqTokVBP0sTA=;
  b=mM0RnwtPgdHH1FrelchCpFstBIqqBYp+yifaXuPfOqRHmsW9RSh9tnIn
   2DBroPt+RgQNT+voZBRfUiSxacQJR98nwmHugYHQvoz24lAnENoiqWsCk
   INNxSFNqErc/FBjCKDIzTFMtCr17htg+PIWGlnnDUy8SKNQ+kS7R3kGx3
   M32WB+cgVTStj9mMkjjf6MaQULU7MRJqQ/1goQNT+EapI/R+wPQnYhmsQ
   xYyKQ9RAfYdARXbaXhkbn/o3AMoiSl8touq8711gwtHGEcGr+pdrnNTlP
   DVhefrXQNd0EJaDX+teFkcGVnd8FtXtcSNE4MPH1kcBVAeGDmcKcP6rOL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364003901"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364003901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 06:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991392762"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="991392762"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 06:47:41 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     oliver.sang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH] filemap: add filemap_map_order0_folio() to handle order0 folio
Date:   Thu, 14 Sep 2023 21:47:41 +0800
Message-Id: <20230914134741.1937654-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel test robot reported regressions for several benchmarks [1].
The regression are related with commit:
de74976eb65151a2f568e477fc2e0032df5b22b4 ("filemap: add filemap_map_folio_range()")

It turned out that function filemap_map_folio_range() brings these
regressions when handle folio with order0.

Add filemap_map_order0_folio() to handle order0 folio. The benefit
come from two perspectives:
  - the code size is smaller (around 126 bytes)
  - no loop

Testing showed the regressions reported by 0day [1] all are fixed:
commit 9f1f5b60e76d44fa: parent commit of de74976eb65151a2
commit fbdf9263a3d7fdbd: latest mm-unstable commit
commit 7fbfe2003f84686d: this fixing patch

9f1f5b60e76d44fa fbdf9263a3d7fdbd            7fbfe2003f84686d
---------------- --------------------------- ---------------------------
   3843810           -21.4%    3020268            +4.6%    4018708      stress-ng.bad-altstack.ops
     64061           -21.4%      50336            +4.6%      66977      stress-ng.bad-altstack.ops_per_sec

   1709026           -14.4%    1462102            +2.4%    1750757      stress-ng.fork.ops
     28483           -14.4%      24368            +2.4%      29179      stress-ng.fork.ops_per_sec

   3685088           -53.6%    1710976            +0.5%    3702454      stress-ng.zombie.ops
     56732           -65.3%      19667            +0.7%      57107      stress-ng.zombie.ops_per_sec

     61874           -12.1%      54416            +0.4%      62136      vm-scalability.median
  13527663           -11.7%   11942117            -0.1%   13513946      vm-scalability.throughput
 4.066e+09           -11.7%   3.59e+09            -0.1%  4.061e+09      vm-scalability.workload

[1]:
https://lore.kernel.org/oe-lkp/72e017b9-deb6-44fa-91d6-716ee2c39cbc@intel.com/T/#m7d2bba30f75a9cee8eab07e5809abd9b3b206c84

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309111556.b2aa3d7a-oliver.sang@intel.com
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/filemap.c | 69 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8962d1255905..e712c99717de 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3461,13 +3461,11 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
  */
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
-			unsigned long addr, unsigned int nr_pages)
+			unsigned long addr, unsigned int nr_pages,
+			unsigned int *mmap_miss)
 {
 	vm_fault_t ret = 0;
-	struct vm_area_struct *vma = vmf->vma;
-	struct file *file = vma->vm_file;
 	struct page *page = folio_page(folio, start);
-	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	unsigned int count = 0;
 	pte_t *old_ptep = vmf->pte;
 
@@ -3475,8 +3473,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (PageHWPoison(page + count))
 			goto skip;
 
-		if (mmap_miss > 0)
-			mmap_miss--;
+		(*mmap_miss)++;
 
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
@@ -3511,7 +3508,35 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	}
 
 	vmf->pte = old_ptep;
-	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
+
+	return ret;
+}
+
+static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
+		struct folio *folio, unsigned long addr,
+		unsigned int *mmap_miss)
+{
+	vm_fault_t ret = 0;
+	struct page *page = &folio->page;
+
+	if (PageHWPoison(page))
+		return ret;
+
+	(*mmap_miss)++;
+
+	/*
+	 * NOTE: If there're PTE markers, we'll leave them to be
+	 * handled in the specific fault path, and it'll prohibit
+	 * the fault-around logic.
+	 */
+	if (!pte_none(ptep_get(vmf->pte)))
+		return ret;
+
+	if (vmf->address == addr)
+		ret = VM_FAULT_NOPAGE;
+
+	set_pte_range(vmf, folio, page, 1, addr);
+	folio_ref_inc(folio);
 
 	return ret;
 }
@@ -3527,7 +3552,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
 	vm_fault_t ret = 0;
-	int nr_pages = 0;
+	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3555,25 +3580,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		end = folio->index + folio_nr_pages(folio) - 1;
 		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
 
-		/*
-		 * NOTE: If there're PTE markers, we'll leave them to be
-		 * handled in the specific fault path, and it'll prohibit the
-		 * fault-around logic.
-		 */
-		if (!pte_none(ptep_get(vmf->pte)))
-			goto unlock;
-
-		ret |= filemap_map_folio_range(vmf, folio,
-				xas.xa_index - folio->index, addr, nr_pages);
+		if (!folio_test_large(folio))
+			ret |= filemap_map_order0_folio(vmf,
+					folio, addr, &mmap_miss);
+		else
+			ret |= filemap_map_folio_range(vmf, folio,
+					xas.xa_index - folio->index, addr,
+					nr_pages, &mmap_miss);
 
-unlock:
 		folio_unlock(folio);
 		folio_put(folio);
-		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
-	} while (folio);
+	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
+
+	mmap_miss_saved = READ_ONCE(file->f_ra.mmap_miss);
+	if (mmap_miss >= mmap_miss_saved)
+		WRITE_ONCE(file->f_ra.mmap_miss, 0);
+	else
+		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss_saved - mmap_miss);
+
 	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
-- 
2.39.2

