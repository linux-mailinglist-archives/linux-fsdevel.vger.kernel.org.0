Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884EE7C035C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJJSYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbjJJSXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E7EA;
        Tue, 10 Oct 2023 11:23:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40666aa674fso56557175e9.0;
        Tue, 10 Oct 2023 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962207; x=1697567007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFbKpQ6SsRHnWdu3vxpCFtAo2jAJKsxmAumC1+QExjY=;
        b=mRSdmMNVTB5GIWtcJ+byR1R+0scp6lLn+E5v+EXh/U1xudSkWEYIkaue6+vRcWXquQ
         QaDbPpZ7e4vfUfj9bL36rBX0FwGpAMdXWZ1TAap7ney4pK0sogdr/9KL2tHQyDS51zRf
         Eda2jZYZbawrgOyMtHdt2G6vewABiy4H9jVgF2Cp3SQ19eAJ29fILvOrH8fBTLGWvcGr
         BVlCFCRGfqtkmJ4Mpc7tLcbOaS+dJaXFpydqFPTqo27oggv2KphLEe2w4q3t4lEuago9
         CQrbwSrrhn5btTNCB1G7isduNMaioxEfP8Qmgsn12dnGbSVdLuLBKo3VXN1zbku2LWkx
         3saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962207; x=1697567007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFbKpQ6SsRHnWdu3vxpCFtAo2jAJKsxmAumC1+QExjY=;
        b=Ln73uclyzEgeCHoLM7Q6WW2RzxpNHshhXxAAAziohI269DDImHOMo9xaRJQm2+NZ57
         jau9x4ZkViUh7k4SxlixbrrzeUuSq8VHTcn7t6WbvkT9tcKC8b/PTMRfFBPKQ2ljThwn
         PKqLIViotrG3rU3KqYR8eVsGSBQW5HFUszzDrWy/3nmUhnpetJuUkiFVQwBypE3N4ENe
         /b9miaI0dOqWQLm9ZPnueeaG1CznUJQoTxL7+RGA5Iit7P7ebzBrFtgHiCIHwI8chUeB
         0QO9k+cbqBnCfQQwuAscue5+LoTSkR9p/07vRh3WBUHIJXM2krjl2BDqlXtf4+XNzkN1
         sIqw==
X-Gm-Message-State: AOJu0Yy6HXWNAArDdAk1mNTsZ4wJtYQWIzBGymkC/lg5a8tflq0mV6m+
        U3ELtQ6J1EI/xisbgVYWGc8=
X-Google-Smtp-Source: AGHT+IHv1LOl5HKi62e1HGQi+SAntjdzxRBlNr+hjRg05MokHXX/rE8OMoNY9iwhCLEYBLbo73Wz5A==
X-Received: by 2002:a05:6000:1cca:b0:320:8d6:74f5 with SMTP id bf10-20020a0560001cca00b0032008d674f5mr15754499wrb.28.1696962207032;
        Tue, 10 Oct 2023 11:23:27 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm13225312wru.16.2023.10.10.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:23:25 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 5/5] mm: abstract VMA merge and extend into vma_merge_extend() helper
Date:   Tue, 10 Oct 2023 19:23:08 +0100
Message-ID: <8134bfa4b1accb98645be3e8cb2af8ac5a92c469.1696929425.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696929425.git.lstoakes@gmail.com>
References: <cover.1696929425.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mremap uses vma_merge() in the case where a VMA needs to be extended. This
can be significantly simplified and abstracted.

This makes it far easier to understand what the actual function is doing,
avoids future mistakes in use of the confusing vma_merge() function and
importantly allows us to make future changes to how vma_merge() is
implemented by knowing explicitly which merge cases each invocation uses.

Note that in the mremap() extend case, we perform this merge only when
old_len == vma->vm_end - addr. The extension_start, i.e. the start of the
extended portion of the VMA is equal to addr + old_len, i.e. vma->vm_end.

With this refactoring, vma_merge() is no longer required anywhere except
mm/mmap.c, so mark it static.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/internal.h |  8 +++-----
 mm/mmap.c     | 31 ++++++++++++++++++++++++-------
 mm/mremap.c   | 30 +++++++++++++-----------------
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ddaeb9f2d9d7..6fa722b07a94 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1014,11 +1014,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 /*
  * mm/mmap.c
  */
-struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
-	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
-	unsigned long end, unsigned long vm_flags, struct anon_vma *,
-	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
-	struct anon_vma_name *);
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta);
 
 enum {
 	/* mark page accessed */
diff --git a/mm/mmap.c b/mm/mmap.c
index db3842601a88..fb0b8f2b8010 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -860,13 +860,13 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
-struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
+static struct vm_area_struct
+*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
+	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
+	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
+	   pgoff_t pgoff, struct mempolicy *policy,
+	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+	   struct anon_vma_name *anon_name)
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
@@ -2501,6 +2501,23 @@ static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
+/*
+ * Expand vma by delta bytes, potentially merging with an immediately adjacent
+ * VMA with identical properties.
+ */
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta)
+{
+	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+
+	/* vma is specified as prev, so case 1 or 2 will apply. */
+	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
+			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
+			 vma_policy(vma), vma->vm_userfaultfd_ctx,
+			 anon_vma_name(vma));
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
diff --git a/mm/mremap.c b/mm/mremap.c
index ce8a23ef325a..38d98465f3d8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1096,14 +1096,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/* old_len exactly to the end of the area..
 	 */
 	if (old_len == vma->vm_end - addr) {
+		unsigned long delta = new_len - old_len;
+
 		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, new_len - old_len)) {
-			long pages = (new_len - old_len) >> PAGE_SHIFT;
-			unsigned long extension_start = addr + old_len;
-			unsigned long extension_end = addr + new_len;
-			pgoff_t extension_pgoff = vma->vm_pgoff +
-				((extension_start - vma->vm_start) >> PAGE_SHIFT);
-			VMA_ITERATOR(vmi, mm, extension_start);
+		if (vma_expandable(vma, delta)) {
+			long pages = delta >> PAGE_SHIFT;
+			VMA_ITERATOR(vmi, mm, vma->vm_end);
 			long charged = 0;
 
 			if (vma->vm_flags & VM_ACCOUNT) {
@@ -1115,17 +1113,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			}
 
 			/*
-			 * Function vma_merge() is called on the extension we
-			 * are adding to the already existing vma, vma_merge()
-			 * will merge this extension with the already existing
-			 * vma (expand operation itself) and possibly also with
-			 * the next vma if it becomes adjacent to the expanded
-			 * vma and  otherwise compatible.
+			 * Function vma_merge_extend() is called on the
+			 * extension we are adding to the already existing vma,
+			 * vma_merge_extend() will merge this extension with the
+			 * already existing vma (expand operation itself) and
+			 * possibly also with the next vma if it becomes
+			 * adjacent to the expanded vma and otherwise
+			 * compatible.
 			 */
-			vma = vma_merge(&vmi, mm, vma, extension_start,
-				extension_end, vma->vm_flags, vma->anon_vma,
-				vma->vm_file, extension_pgoff, vma_policy(vma),
-				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma = vma_merge_extend(&vmi, vma, delta);
 			if (!vma) {
 				vm_unacct_memory(charged);
 				ret = -ENOMEM;
-- 
2.42.0

