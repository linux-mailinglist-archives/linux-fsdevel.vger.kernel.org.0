Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6D762FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjGZIYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjGZIX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:23:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93DB72B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-563de62f861so473370a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359052; x=1690963852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgnuXatC2qbxaqbZ65LcEyHnR8tMExq1rwNTS9IK9fs=;
        b=kHc9/HMqaF9R8G/rXM59e0F3CbnZX/wdeNMwFdC4XbxVCwGzgEppqL5qnyB3vNmNVg
         c8cJwfifm5dQn0XdItECcYmL7213bc+olR8WIHI+oZFMOk9CMsY7zzqyGkHUyoCUbS5O
         dEHqxuqR01Hr6wkpXFSSeIiFRl0E2XvoCppdLpSz0jYGs9bX0Vjkjgcf/CoG7h0V+GT0
         hgH6/mckjlLMtGPSbuo3RnGG1oclyUlcIARBc+DEe60f642YycPhYk3JYCpHJAImiCtD
         q04bJ/2nn8P7ybfvGd8hRKKdkHJCH61syEN3XyDj2vXfd5qQFV1ojWAT1xwPxp7AAMlx
         S/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359052; x=1690963852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgnuXatC2qbxaqbZ65LcEyHnR8tMExq1rwNTS9IK9fs=;
        b=Z1tc48YcQVtJn/o73rGbeZiHssw4HvIikZ8kJoq46GlNe3axzjok4J2dHhIT0MAhhx
         SJk3Jkva7SbKHoEX0StFMilvs/R5OYBAqPGwqRv+wh100aTtD4nI+2ariO5FhBXDS1/N
         0HKKVViZ1GNIIeWUn2KwzSHkzUfoEjwAkqFyDvIRp1AcSpFkMh9zcBT6Z1NPl3By3xWV
         bIRKUSF5VGDTKYOEH8jQdsfmvbvdkI1z2v5CMN29DM4oXBn/SRk+mIbiTVAMRoG1Gngr
         soBsmBfegbEZCDAjQfSiffN+6j2Gfj5PX5tkKO7T+ORRJ75/lzOd/yVbyaHTygjQT0tY
         vT/A==
X-Gm-Message-State: ABy/qLaADEvEVeIItJgBjcEwFia9WOKqMz6qWtLrDssnLRx/0Tjay/+6
        KuBc70DM/BaxuWwP/JwXj1JnIA==
X-Google-Smtp-Source: APBJJlE/k5FlCPp9wjkDmS2lNntkmIxAcglpNb71TQX77k742PkAt1Hf8XjFuPAOgyeUv3smQ4YSOQ==
X-Received: by 2002:a17:90a:6344:b0:263:e423:5939 with SMTP id v4-20020a17090a634400b00263e4235939mr1066813pjs.28.1690359052249;
        Wed, 26 Jul 2023 01:10:52 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:52 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 11/11] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date:   Wed, 26 Jul 2023 16:09:16 +0800
Message-Id: <20230726080916.17454-12-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
directly modify the entries of VMAs in the new maple tree, which can
get better performance. dup_mmap() is used by fork(), so this patch
optimizes fork(). The optimization effect is proportional to the number
of VMAs.

Due to the introduction of this method, the optimization in
(maple_tree: add a fast path case in mas_wr_slot_store())[1] no longer
has an effect here, but it is also an optimization of the maple tree.

There is a unixbench test suite[2] where 'spawn' is used to test fork().
'spawn' only has 23 VMAs by default, so I tweaked the benchmark code a
bit to use mmap() to control the number of VMAs. Therefore, the
performance under different numbers of VMAs can be measured.

Insert code like below into 'spawn':
for (int i = 0; i < 200; ++i) {
	size_t size = 10 * getpagesize();
	void *addr;

	if (i & 1) {
		addr = mmap(NULL, size, PROT_READ,
			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	} else {
		addr = mmap(NULL, size, PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	}
	if (addr == MAP_FAILED)
		...
}

Based on next-20230721, use 'spawn' under 23, 203, and 4023 VMAs, test
4 times in 30 seconds each time, and get the following numbers. These
numbers are the number of fork() successes in 30s (average of the best
3 out of 4). By the way, based on next-20230725, I reverted [1], and
tested it together as a comparison. In order to ensure the reliability
of the test results, these tests were run on a physical machine.

		23VMAs		223VMAs		4023VMAs
revert [1]:	159104.00	73316.33	6787.00

		+0.77%		+0.42%		+0.28%
next-20230721:	160321.67	73624.67	6806.33

		+2.77%		+15.42%		+29.86%
apply this:	164751.67	84980.33	8838.67

It can be seen that the performance improvement is proportional to
the number of VMAs. With 23 VMAs, performance improves by about 3%,
with 223 VMAs, performance improves by about 15%, and with 4023 VMAs,
performance improves by about 30%.

[1] https://lore.kernel.org/lkml/20230628073657.75314-4-zhangpeng.00@bytedance.com/
[2] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 kernel/fork.c | 35 +++++++++++++++++++++++++++--------
 mm/mmap.c     | 14 ++++++++++++--
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f81149739eb9..ef80025b62d6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
@@ -678,17 +677,40 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
+					mas_replace_entry(&vmi.mas,
+							  XA_ZERO_ENTRY);
+				goto loop_out;
+			}
+
 			continue;
 		}
 		charge = 0;
@@ -750,8 +772,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			hugetlb_dup_vma_private(tmp);
 
 		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
+		mas_replace_entry(&vmi.mas, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -778,8 +799,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_vmi_store:
-	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
diff --git a/mm/mmap.c b/mm/mmap.c
index bc91d91261ab..5bfba2fb0e39 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3184,7 +3184,11 @@ void exit_mmap(struct mm_struct *mm)
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
@@ -3222,7 +3226,13 @@ void exit_mmap(struct mm_struct *mm)
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

