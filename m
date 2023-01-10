Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D56664516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjAJPmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 10:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjAJPmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:42:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337F288;
        Tue, 10 Jan 2023 07:42:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z4-20020a17090a170400b00226d331390cso13866908pjd.5;
        Tue, 10 Jan 2023 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxJ1orvwaIz49UY3V+bZ+vpeGDcaph8FOsuYxslmG6M=;
        b=aYW+aq0ycwUP/MkfEZa4WVXk6q+pe/WbNH20icmeFkCU7s6wAYfifl6BVXgjKyhTJU
         tXoVrFDaocyCtWUp3jHAdSE6xwWPPi/+Vtd89vo7OWFy1UzKumtt2/5wh/lvVmcsE3Nk
         dan8tSm8O/KzuBDFEfYbAUBIQE/stKkAJ0/9LT79YlMXb2XM2B+jUWGa8nYkHzaYtL6C
         JJrN898RS437sCvyUHahiE5cNiWAGZ1xU6Pe5vsU2k7fJTZSHuMmQGfqr6FUwsktCvL6
         U2XpshkVH0CTOcZZ0wp2NtqT74TgY9Ty7k7+FqSJbwAjBNgsyHgKdUy8qYcP2tRDq4d/
         odjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxJ1orvwaIz49UY3V+bZ+vpeGDcaph8FOsuYxslmG6M=;
        b=sAmJJuXHASw73yCg4z5M2hJvjWHAq2g1S478ygiPhvOsmzN2366VLy9wD0G3N06i+F
         J2omWhgu7dbk83h6sXK7+euziZjwkcJ1tv3VDQ2YSIZZp38zURA5bhcEeKoYBIKAScAW
         /7Z0h5xwxZ0RKlw93jsLPpc/bQUXjJ6b/xbEBkZrZsizoGR1ofVECSGDsD0qXK5ChW1Y
         FzIa+vQtebAaIUfG+P+lrdlFoX/p8MI2TbZA8T/hMobIrKG5t9GVMQ0uGgRJWru/dKns
         YdzA9F0XNAwzUatJA9RWyWGGc/5w8H4DMz1bSAXVY3JLzaPtZ7X+ykf1rGKaaf5PfvxH
         KMsw==
X-Gm-Message-State: AFqh2krVS2e/KEalAguS/K3fWHOiUN52egiTWeCK1U9HauX3NvofP3M3
        GL5NIX/vtsC7v0L+ZwvcYPm9JQCVhLtl3Q==
X-Google-Smtp-Source: AMrXdXtpMAmNJns+vLc4olq8Qo31U/Mm1zW464AZ1MkOq6Wj9ba++76jyQmXfnSlitXbkqn6VaG1rw==
X-Received: by 2002:a17:903:2411:b0:192:d9dd:167d with SMTP id e17-20020a170903241100b00192d9dd167dmr28330586plo.43.1673365338141;
        Tue, 10 Jan 2023 07:42:18 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b001708c4ebbaesm8102660plk.309.2023.01.10.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:42:17 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] maple_tree: remove the parameter entry of mas_preallocate
Date:   Tue, 10 Jan 2023 23:42:11 +0800
Message-Id: <20230110154211.1758562-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The parameter entry of mas_preallocate is not used, so drop it.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 include/linux/maple_tree.h       |  2 +-
 lib/maple_tree.c                 |  3 +--
 mm/mmap.c                        | 16 ++++++++--------
 mm/nommu.c                       |  8 ++++----
 tools/testing/radix-tree/maple.c | 32 ++++++++++++++++----------------
 5 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e594db58a0f1..a0d43087f27a 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -456,7 +456,7 @@ int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp);
 void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
-int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
+int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 69be9d3db0c8..96fb4b416697 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5712,12 +5712,11 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 /**
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
- * @entry: The entry that will be stored
  * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -ENOMEM if memory could not be allocated.
  */
-int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
+int mas_preallocate(struct ma_state *mas, gfp_t gfp)
 {
 	int ret;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e06f9ae34ff8..64bdd38e8d8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -472,7 +472,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping = NULL;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	if (vma->vm_file) {
@@ -538,7 +538,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, GFP_KERNEL))
 		goto nomem;
 
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -712,7 +712,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -1934,7 +1934,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2015,7 +2015,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2307,7 +2307,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
 
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, GFP_KERNEL))
 		return -ENOMEM;
 
 	mas->last = end - 1;
@@ -2676,7 +2676,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		error = -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
@@ -2949,7 +2949,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
 		mas_set_range(mas, vma->vm_start, addr + len - 1);
-		if (mas_preallocate(mas, vma, GFP_KERNEL))
+		if (mas_preallocate(mas, GFP_KERNEL))
 			goto unacct_fail;
 
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
diff --git a/mm/nommu.c b/mm/nommu.c
index 214c70e1d059..0befa4060aea 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -602,7 +602,7 @@ static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -633,7 +633,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -1081,7 +1081,7 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, GFP_KERNEL))
 		goto error_maple_preallocate;
 
 	region->vm_usage = 1;
@@ -1358,7 +1358,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (mas_preallocate(&mas, GFP_KERNEL)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 			current->pid);
 		goto err_mas_preallocate;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 81fa7ec2e66a..8170ef39d8c4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35342,7 +35342,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35351,18 +35351,18 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35370,25 +35370,25 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	ma_free_rcu(mn);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35397,12 +35397,12 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35410,21 +35410,21 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35432,14 +35432,14 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mas_destroy(&mas);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35447,7 +35447,7 @@ static noinline void check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
-- 
2.34.1

