Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7074B7ACEEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIYD7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjIYD7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:59:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E99CF4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso4079149b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695614328; x=1696219128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuxzCiUZ2DltVBwaDerHzUDGuv+dY7UUUi86i/t9rYc=;
        b=LoUYQ7SUJa5qtkdfo5OKFD8pcWi+jh2Zuw7XbbU7mTJci+zvHt/nEep1nMXyFsuEpJ
         brpx+K7N14v4f7k4fMqEB+u42rcGdiMRfUf/l7p9jp2Pq+etUAxeTLjP20C0vEWGhKyJ
         kSBZcAphexmKzUtMJRqk138sW1Sr9Nun7XuHgbZN4zPBPLP+mb4KVhs02ceM/1I2SCR1
         nIlG5BdzoW8s7s9f4ojeSNVQMe+jYUdHyaOUO2XwMmDvRv51gvuizbZZ/SPqAsjsmdPV
         7po03mPpTsMvQWxCIej1rcV1Fkvu943ciSoAn9JODnuDJ5tffx7xEzOpZhq9DUwRCNLD
         uSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614328; x=1696219128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuxzCiUZ2DltVBwaDerHzUDGuv+dY7UUUi86i/t9rYc=;
        b=XQwM2eIZD1vPD93BztQZKgGM6mM74V1qGD09culiW2oDaJPhiEk4HaJZb5VorIQHlM
         htKGebkPTtEheaMRKe62x5lN3psWz5+Yid2gWwfy5wQM1e+gD2tL9YzOM+L4jvJElRG4
         SC0gk8QC1im9SVumuNluFs7IvuJ7wcYZadTgRCFD3R+leF7rZ5P3JxcesJheqgNr0P0s
         QX6OjVCcQI3KIgv0plAn8M0Vq3hH11Lh2ARR3TvEB/8LZmDeWNqQW4KxnlAiMtKbZl1j
         ON9wdyfj2yNTIUoYJ9bJ3sBoJcnOdrhgaUosPBnWHa0oEic8zpVqtxIA1mWAEh5n78q/
         s4GQ==
X-Gm-Message-State: AOJu0YyLbTNP6LW4kfqbTPz0TvYlmklh6OMHyz8DX8CIAqZmS7jAkdUT
        gc0bugXsG9ZR+dq+0vZD9wUaiQ==
X-Google-Smtp-Source: AGHT+IHw8XcQ7+xdyaLtlqVJu3dj2MsTxRgYeF9x/JPrG30bCLmD6fzrqcUdIisXeiq7bW/XX9H8sQ==
X-Received: by 2002:a05:6a20:7486:b0:159:c07d:66f0 with SMTP id p6-20020a056a20748600b00159c07d66f0mr8362964pzd.6.1695614328529;
        Sun, 24 Sep 2023 20:58:48 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm7025387pfb.43.2023.09.24.20.58.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Sep 2023 20:58:47 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date:   Mon, 25 Sep 2023 11:56:17 +0800
Message-Id: <20230925035617.84767-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
directly replacing the entries of VMAs in the new maple tree can result
in better performance. __mt_dup() uses DFS pre-order to duplicate the
maple tree, so it is very efficient. The average time complexity of
duplicating VMAs is reduced from O(n * log(n)) to O(n). The optimization
effect is proportional to the number of VMAs.

As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
fails, there will be a portion of VMAs that have not been duplicated in
the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
To solve this problem, undo_dup_mmap() is introduced to handle the failure
of dup_mmap(). I have carefully tested the failure path and so far it
seems there are no issues.

There is a "spawn" in byte-unixbench[1], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. By default, there are 21 VMAs. The first row
shows the number of additional VMAs added on top of the default. The last
two rows show the number of fork() calls per ten seconds. The test results
were obtained with CPU binding to avoid scheduler load balancing that
could cause unstable results. There are still some fluctuations in the
test results, but at least they are better than the original performance.

Increment of VMAs: 0      100     200     400     800     1600    3200    6400
next-20230921:     112326 75469   54529   34619   20750   11355   6115    3183
Apply this:        116505 85971   67121   46080   29722   16665   9050    4805
                   +3.72% +13.92% +23.09% +33.11% +43.24% +46.76% +48.00% +50.96%

[1] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/mm.h |  1 +
 kernel/fork.c      | 34 ++++++++++++++++++++----------
 mm/internal.h      |  3 ++-
 mm/memory.c        |  7 ++++---
 mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f1d0d6b8f20..10c59dc7ffaa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
+extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/kernel/fork.c b/kernel/fork.c
index 7ae36c2e7290..2f3d83e89fe6 100644
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
index 7a961d12b088..288ec81770cb 100644
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
index 983a40f8ee62..1fd66a0d5838 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
 
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
-		   unsigned long ceiling, bool mm_wr_locked)
+		   unsigned long ceiling, unsigned long tree_end,
+		   bool mm_wr_locked)
 {
 	do {
 		unsigned long addr = vma->vm_start;
@@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
 		 * be 0.  This will underflow and is okay.
 		 */
-		next = mas_find(mas, ceiling - 1);
+		next = mas_find(mas, tree_end - 1);
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
-				next = mas_find(mas, ceiling - 1);
+				next = mas_find(mas, tree_end - 1);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
diff --git a/mm/mmap.c b/mm/mmap.c
index 2ad950f773e4..daed3b423124 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	mas_set(mas, mt_start);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+				 tree_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned long len)
 }
 EXPORT_SYMBOL(vm_brk);
 
+void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
+{
+	unsigned long tree_end;
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma;
+	unsigned long nr_accounted = 0;
+	int count = 0;
+
+	/*
+	 * vma_end points to the first VMA that has not been duplicated. We need
+	 * to unmap all VMAs before it.
+	 * If vma_end is NULL, it means that all VMAs in the maple tree have
+	 * been duplicated, so setting tree_end to 0 will overflow to ULONG_MAX
+	 * when using it.
+	 */
+	if (vma_end) {
+		tree_end = vma_end->vm_start;
+		if (tree_end == 0)
+			goto destroy;
+	} else
+		tree_end = 0;
+
+	vma = mas_find(&vmi.mas, tree_end - 1);
+
+	if (vma) {
+		arch_unmap(mm, vma->vm_start, tree_end);
+		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
+			     tree_end, true);
+
+		mas_set(&vmi.mas, vma->vm_end);
+		do {
+			if (vma->vm_flags & VM_ACCOUNT)
+				nr_accounted += vma_pages(vma);
+			remove_vma(vma, true);
+			count++;
+			cond_resched();
+			vma = mas_find(&vmi.mas, tree_end - 1);
+		} while (vma != NULL);
+
+		BUG_ON(count != mm->map_count);
+
+		vm_unacct_memory(nr_accounted);
+	}
+
+destroy:
+	__mt_destroy(&mm->mm_mt);
+}
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
 	mt_clear_in_rcu(&mm->mm_mt);
 	mas_set(&mas, vma->vm_end);
 	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
-		      USER_PGTABLES_CEILING, true);
+		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
 	tlb_finish_mmu(&tlb);
 
 	/*
-- 
2.20.1

