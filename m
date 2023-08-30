Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694378DBBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjH3Shf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbjH3M6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:58:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADA1B2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0ecb9a075so23532535ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400278; x=1694005078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yWpUOFFGV0pFtikzJZ55MStl9p8vL9hqNAbNokJEAE=;
        b=VEn31CjsPWihCIC3/0e4qz3VNlKzPvkl/Rqp1B5PPv9Mang1f30xJT/J3yRfE6yh2B
         3wx3t5kE1JTFKTS5dpc9Z3Bb0wdi9PlZkmB2Oul+nc5ERxNubeKn4yEZ4OBR86XbKsF4
         AeF+DuYzuBNmqEUFdmmqQA9++4JI7tQ3/YacwUS3Y0Mx3X5PRwYeZluglypRvTD8FJgZ
         Xu0aCM8e8lo5nLJSv/TfoDa/ZXM4nY56TcPhSMj6LrO1qPW6QrwBTvKHxwSb96AN4G70
         ayD1C2XoG/lD38I+4F8cskDKoKnAJ3v+/4Tsd3gzalj/b1/mO9W9XMIhLl45+yk412lA
         AUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400278; x=1694005078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yWpUOFFGV0pFtikzJZ55MStl9p8vL9hqNAbNokJEAE=;
        b=VCUQfWblzSzWjfjmLipoyxVGW6ABuiFCXxs+J6Cvnf/2Se1n3sUCUznmKtaeZZgKxQ
         ZuWpnoYGdYkvYmvmz1ga50XaLej1ZnGp3+i9nvO07c7+gp6qCgUGpsxRsC8LMBr+Jm5u
         +dVmTyvY/A6lCqIm17jh7NQ4aAPhBxbheqXTgvP6hsPH9hZkLYtCMNVwNk0mI7x8F71K
         gN1H4A/4s/v9A5r8qOFN9HtPrksyP0MmGizIaILPyWv9lerXuEaZXRl+HXvk6b0Dg7hS
         jJgaIxWldEAO3wMYhG9w/QycL+P9fHpMU6ubLhRrf88WTnH52c2gMSJCxE8ofz0Ka+FY
         4d6w==
X-Gm-Message-State: AOJu0Yxnl3ucOZONLim2E4biye5QjAbY2i/jRvvUN2AyrIdB6Z/XE6gv
        C36Y4fNGd0uygslF3TrXYFlNig==
X-Google-Smtp-Source: AGHT+IHrE4rTvkXO7RwqgnTEvxw+lDK+ANzha4IBQF+qFVxQo+OdsPaqgZdwuRA69Q5Iw9LfoqglQw==
X-Received: by 2002:a17:902:da8c:b0:1bf:78d:5cde with SMTP id j12-20020a170902da8c00b001bf078d5cdemr1986513plx.59.1693400278469;
        Wed, 30 Aug 2023 05:57:58 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:58 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date:   Wed, 30 Aug 2023 20:56:54 +0800
Message-Id: <20230830125654.21257-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
directly modify the entries of VMAs in the new maple tree, which can
get better performance. The optimization effect is proportional to the
number of VMAs.

There is a "spawn" in byte-unixbench[1], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test numbers. There are 21 VMAs by default. The first row
indicates the number of added VMAs. The following two lines are the
number of fork() calls every 10 seconds. These numbers are different
from the test results in v1 because this time the benchmark is bound to
a CPU. This way the numbers are more stable.

  Increment of VMAs: 0      100     200     400     800     1600    3200    6400
6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6110    3158
Apply this patchset: 114531 85420   64541   44592   28660   16371   9038    4831
                     +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% +47.92% +52.98%

[1] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 kernel/fork.c | 34 ++++++++++++++++++++++++++--------
 mm/mmap.c     | 14 ++++++++++++--
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..e6299adefbd8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
@@ -678,17 +677,39 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
 
-	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
-	if (retval)
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_NOWARN);
+	if (unlikely(retval))
 		goto out;
 
 	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(old_vmi, mpnt) {
+	for_each_vma(vmi, mpnt) {
 		struct file *file;
 
 		vma_start_write(mpnt);
 		if (mpnt->vm_flags & VM_DONTCOPY) {
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+
+			/*
+			 * Since the new tree is exactly the same as the old one,
+			 * we need to remove the unneeded VMAs.
+			 */
+			mas_store(&vmi.mas, NULL);
+
+			/*
+			 * Even removing an entry may require memory allocation,
+			 * and if removal fails, we use XA_ZERO_ENTRY to mark
+			 * from which VMA it failed. The case of encountering
+			 * XA_ZERO_ENTRY will be handled in exit_mmap().
+			 */
+			if (unlikely(mas_is_err(&vmi.mas))) {
+				retval = xa_err(vmi.mas.node);
+				mas_reset(&vmi.mas);
+				if (mas_find(&vmi.mas, ULONG_MAX))
+					mas_store(&vmi.mas, XA_ZERO_ENTRY);
+				goto loop_out;
+			}
+
 			continue;
 		}
 		charge = 0;
@@ -750,8 +771,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			hugetlb_dup_vma_private(tmp);
 
 		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
+		mas_store(&vmi.mas, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_vmi_store:
-	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..dfc6881be81c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3196,7 +3196,11 @@ void exit_mmap(struct mm_struct *mm)
 	arch_exit_mmap(mm);
 
 	vma = mas_find(&mas, ULONG_MAX);
-	if (!vma) {
+	/*
+	 * If dup_mmap() fails to remove a VMA marked VM_DONTCOPY,
+	 * xa_is_zero(vma) may be true.
+	 */
+	if (!vma || xa_is_zero(vma)) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_read_unlock(mm);
 		return;
@@ -3234,7 +3238,13 @@ void exit_mmap(struct mm_struct *mm)
 		remove_vma(vma, true);
 		count++;
 		cond_resched();
-	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
+		vma = mas_find(&mas, ULONG_MAX);
+		/*
+		 * If xa_is_zero(vma) is true, it means that subsequent VMAs
+		 * donot need to be removed. Can happen if dup_mmap() fails to
+		 * remove a VMA marked VM_DONTCOPY.
+		 */
+	} while (vma != NULL && !xa_is_zero(vma));
 
 	BUG_ON(count != mm->map_count);
 
-- 
2.20.1

