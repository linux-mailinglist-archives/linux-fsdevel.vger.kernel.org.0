Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B77BD642
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbjJIJF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbjJIJFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:05:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94BD40
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690ba63891dso3072965b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842289; x=1697447089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9NBeOeUOKV7MjQXBf0OcDJpNNzzRaiKWMLyPnHJUCM=;
        b=K8Vzzg6WSF5Wz9YEsPSykDvO83e4CR149kcGAxJ5YrWRBEiMUA+UY+2gt4N/HuVCnn
         TWN6LKwIFsntFPhHRJjUAAlvX9MLzFsXN8tkZM+nUlkp4aUIsHBQQF4hi3icRGVEMJJz
         ziOSUjqNfr68uvAtZJ6fD9Qec62Z2Mg43S3SDIWUXQcR2BsevGWV6i3ObDvx20M3Fv3t
         7P0va3kMqfoVlFdhSEGpTrEgh550oaM7X2htvRIXXNmHeI1Tqefl/S1ZPdWYE7h4P1cX
         DlFaZUqcCmx6hjp/p2xO63p4oXgsdg7lBPZXy62SA9sfQqyE0mouJonoKaF36pp+1KSN
         DQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842289; x=1697447089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9NBeOeUOKV7MjQXBf0OcDJpNNzzRaiKWMLyPnHJUCM=;
        b=m9tQpOS6zb/nALCYyhAofPfBu0mmzetdKkprDzVQexRwV8Nhf6HF3vsKMdtOV5NAEf
         HR3v91jqvLBDW0oopVo84AQjiN7ZE3vxGxYfjekouPkT3XpRfhyF8ktYQLPauk6N/zF/
         i8EGsfVDnZiSN4zwkTvSTHWnM0aRegTM4Pm9yHmS8foVGbmUw+KJu2lumJuC+VXfzirf
         6XjyJ4SkhhSbh0jIjsEqIQTLYFysvkf+Ejft2EETIVb/sN2j8y7yZGj1uEsxrfOSwTXJ
         O8VLhiCGZTU35xhD0mT9DJCWIEn/2Wth54PAEkzAIWvShJDKM+24257D6Oppeu6rJZhj
         WHCQ==
X-Gm-Message-State: AOJu0Yz7ryefKhKaKghGvpZRDfU5TQkn8oVVmldESTI6Oeo0fgywQdBG
        7s672zwAR4ypWzSOxLgBnzXUlg==
X-Google-Smtp-Source: AGHT+IFWmVZ8CGi7MzxRf4NhvVXp4nBgy8RRUrzo84/q27FPUoZvvNAnKU3L14fffrsvBYvtEh1KAw==
X-Received: by 2002:a05:6a21:1a6:b0:16b:afc2:3b69 with SMTP id le38-20020a056a2101a600b0016bafc23b69mr8158325pzb.36.1696842289307;
        Mon, 09 Oct 2023 02:04:49 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:48 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 10/10] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date:   Mon,  9 Oct 2023 17:03:20 +0800
Message-Id: <20231009090320.64565-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
directly replacing the entries of VMAs in the new maple tree can result
in better performance. __mt_dup() uses DFS pre-order to duplicate the
maple tree, so it is efficient.

The average time complexity of __mt_dup() is O(n), where n is the number
of VMAs. The proof of the time complexity is provided in the commit log
that introduces __mt_dup(). After duplicating the maple tree, each element
is traversed and replaced (ignoring the cases of deletion, which are rare).
Since it is only a replacement operation for each element, this process is
also O(n).

Analyzing the exact time complexity of the previous algorithm is
challenging because each insertion can involve appending to a node, pushing
data to adjacent nodes, or even splitting nodes. The frequency of each
action is difficult to calculate. The worst-case scenario for a single
insertion is when the tree undergoes splitting at every level. If we
consider each insertion as the worst-case scenario, we can determine that
the upper bound of the time complexity is O(n*log(n)), although this is a
loose upper bound. However, based on the test data, it appears that the
actual time complexity is likely to be O(n).

As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
fails, there will be a portion of VMAs that have not been duplicated in
the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
To solve this problem, undo_dup_mmap() is introduced to handle the failure
of dup_mmap(). I have carefully tested the failure path and so far it
seems there are no issues.

There is a "spawn" in byte-unixbench[1], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. The first row shows the number of VMAs.
The second and third rows show the number of fork() calls per ten seconds,
corresponding to next-20231006 and the this patchset, respectively. The
test results were obtained with CPU binding to avoid scheduler load
balancing that could cause unstable results. There are still some
fluctuations in the test results, but at least they are better than the
original performance.

21     121   221    421    821    1621   3221   6421   12821  25621  51221
112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%

[1] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/mm.h |  1 +
 kernel/fork.c      | 34 +++++++++++++++++++++----------
 mm/internal.h      |  3 ++-
 mm/memory.c        |  7 ++++---
 mm/mmap.c          | 50 ++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14e50925b76d..d039f10d258e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3248,6 +3248,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
+extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/kernel/fork.c b/kernel/fork.c
index 0ff2e0cd4109..5f24f6d68ea4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
@@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
 
-	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
-	if (retval)
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
 		goto out;
 
 	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(old_vmi, mpnt) {
+	for_each_vma(vmi, mpnt) {
 		struct file *file;
 
 		vma_start_write(mpnt);
 		if (mpnt->vm_flags & VM_DONTCOPY) {
+			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
+
+			/* If failed, undo all completed duplications. */
+			if (unlikely(mas_is_err(&vmi.mas))) {
+				retval = xa_err(vmi.mas.node);
+				goto loop_out;
+			}
+
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
 			continue;
 		}
@@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			hugetlb_dup_vma_private(tmp);
 
-		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		mas_store(&vmi.mas, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
 
-		if (retval)
+		if (retval) {
+			mpnt = vma_next(&vmi);
 			goto loop_out;
+		}
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
 	vma_iter_free(&vmi);
-	if (!retval)
+	if (likely(!retval))
 		mt_set_in_rcu(vmi.mas.tree);
+	else
+		undo_dup_mmap(mm, mpnt);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_vmi_store:
-	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
diff --git a/mm/internal.h b/mm/internal.h
index 18e360fa53bc..bcd92a5b5474 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
 
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
-		   unsigned long ceiling, bool mm_wr_locked);
+		   unsigned long ceiling, unsigned long tree_end,
+		   bool mm_wr_locked);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
 struct zap_details;
diff --git a/mm/memory.c b/mm/memory.c
index b320af6466cc..51bb1d16a54e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -363,7 +363,8 @@ void free_pgd_range(struct mmu_gather *tlb,
 
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
-		   unsigned long ceiling, bool mm_wr_locked)
+		   unsigned long ceiling, unsigned long tree_end,
+		   bool mm_wr_locked)
 {
 	do {
 		unsigned long addr = vma->vm_start;
@@ -373,7 +374,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
 		 * be 0.  This will underflow and is okay.
 		 */
-		next = mas_find(mas, ceiling - 1);
+		next = mas_find(mas, tree_end - 1);
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -394,7 +395,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
-				next = mas_find(mas, ceiling - 1);
+				next = mas_find(mas, tree_end - 1);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
diff --git a/mm/mmap.c b/mm/mmap.c
index 1855a2d84200..d044d68d1361 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2337,7 +2337,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	mas_set(mas, mt_start);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+				 tree_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3197,6 +3197,52 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
+void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
+{
+	unsigned long tree_end = USER_PGTABLES_CEILING;
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma;
+	unsigned long nr_accounted = 0;
+	int count = 0;
+
+	/*
+	 * vma_end points to the first VMA that has not been duplicated. We need
+	 * to unmap all VMAs before it.
+	 * If vma_end is NULL, it means that all VMAs in the maple tree have
+	 * been duplicated, so setting tree_end to USER_PGTABLES_CEILING will
+	 * unmap all VMAs in the maple tree.
+	 */
+	if (vma_end) {
+		tree_end = vma_end->vm_start;
+		if (tree_end == 0)
+			goto destroy;
+	}
+
+	vma = vma_find(&vmi, tree_end);
+	if (!vma)
+		goto destroy;
+
+	arch_unmap(mm, vma->vm_start, tree_end);
+
+	vma_iter_set(&vmi, vma->vm_end);
+	unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end, tree_end, true);
+
+	vma_iter_set(&vmi, vma->vm_end);
+	do {
+		if (vma->vm_flags & VM_ACCOUNT)
+			nr_accounted += vma_pages(vma);
+		remove_vma(vma, true);
+		count++;
+		cond_resched();
+	} for_each_vma_range(vmi, vma, tree_end);
+
+	BUG_ON(count != mm->map_count);
+	vm_unacct_memory(nr_accounted);
+
+destroy:
+	__mt_destroy(&mm->mm_mt);
+}
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -3236,7 +3282,7 @@ void exit_mmap(struct mm_struct *mm)
 	mt_clear_in_rcu(&mm->mm_mt);
 	mas_set(&mas, vma->vm_end);
 	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
-		      USER_PGTABLES_CEILING, true);
+		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/*
-- 
2.20.1

