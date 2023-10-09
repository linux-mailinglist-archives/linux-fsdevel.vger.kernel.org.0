Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31A7BEC11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378202AbjJIUyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378141AbjJIUxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6925BA;
        Mon,  9 Oct 2023 13:53:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-327be5fe4beso4567157f8f.3;
        Mon, 09 Oct 2023 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696884816; x=1697489616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKLx1ja8HeC2i05aZCboTLTuiLTHyhLExxAZQjBx8ig=;
        b=Rp/EY+YdAxDEyoR5gc5tjT9s8gCvmm8ZYkM/uP9eCcXVdabjGgGpEJxyoJKAskuDMb
         cnVwf3zQ7xLkmg31pUY2ljiTN1Po6RST7Co5FMvDidde8qq5CBLEEBQy76p0vvAwvFKV
         8pxDv8sPqP059OpmPH0M3oIVBBad8gQa1Tp8JiJnqq4GiKl3ZBqcnZe15wbhQUQRqSaA
         g+piYWuZg6mEQ82cqQpf68VvoIyh128uLHzzv9S6+BPOvFxuMAAW0QQuZrQMe08j3/vN
         co9d/VtGLWwauT1bFi5zacEco8uWtEortPROphTE8c4QJgzhWGLwaZMe1sJBfGt43blq
         nPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884816; x=1697489616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKLx1ja8HeC2i05aZCboTLTuiLTHyhLExxAZQjBx8ig=;
        b=EIUqi1rlyeKYb6iN3qojftfF4gdonX2AoPuXr7DS50OPTBdodKS2W3BeI8e61OS98e
         SmYZA1+1ev1Njdonyc54XBouerhlbNCqPR99CzrEmouJ1Hkwv8QSfUEOdOpn9WHruZT/
         KavfhBm0z79AIKNk6CejFYxBXjPYWZXg3T6K39b+BGfXhtd/SXmCXJvlUyIBXUZUi8PB
         c8eVQD26ZH+wSaKQ65rjl5B8xGo/m6czxDazURdhimrCZJEZXsKjCXOxv1YVHhKYMM1A
         3PZ/bG3qjnENvWY9fo4hSw9M3Wsjd8Lz/NEl8PQl0FBle/S9btK5wlrAY2KtBDVqvEV7
         96wQ==
X-Gm-Message-State: AOJu0YyIgrWSMoWIOAPKCNy1LccL8kBX95reNpVulnJfL4qy/uSssF48
        tOMxsO5m73x5uc/5QpHYec0D/oFbUew=
X-Google-Smtp-Source: AGHT+IE9EsWvW05b+ffVnXE+d0/62Zwj6srI+4rcsUf3IhmIEVtijSpGOd4JlWGDSz6OraG+tmIFYA==
X-Received: by 2002:adf:f74f:0:b0:319:68ba:7c8e with SMTP id z15-20020adff74f000000b0031968ba7c8emr14458485wrp.38.1696884815913;
        Mon, 09 Oct 2023 13:53:35 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10578130wrq.11.2023.10.09.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:53:34 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 2/5] mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
Date:   Mon,  9 Oct 2023 21:53:17 +0100
Message-ID: <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696884493.git.lstoakes@gmail.com>
References: <cover.1696884493.git.lstoakes@gmail.com>
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

mprotect() and other functions which change VMA parameters over a range
each employ a pattern of:-

1. Attempt to merge the range with adjacent VMAs.
2. If this fails, and the range spans a subset of the VMA, split it
   accordingly.

This is open-coded and duplicated in each case. Also in each case most of
the parameters passed to vma_merge() remain the same.

Create a new function, vma_modify(), which abstracts this operation,
accepting only those parameters which can be changed.

To avoid the mess of invoking each function call with unnecessary
parameters, create inline wrapper functions for each of the modify
operations, parameterised only by what is required to perform the action.

Note that the userfaultfd_release() case works even though it does not
split VMAs - since start is set to vma->vm_start and end is set to
vma->vm_end, the split logic does not trigger.

In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
- vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
instance, this invocation will remain unchanged.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/userfaultfd.c   | 69 +++++++++++++++-------------------------------
 include/linux/mm.h | 60 ++++++++++++++++++++++++++++++++++++++++
 mm/madvise.c       | 32 ++++++---------------
 mm/mempolicy.c     | 22 +++------------
 mm/mlock.c         | 27 +++++-------------
 mm/mmap.c          | 45 ++++++++++++++++++++++++++++++
 mm/mprotect.c      | 35 +++++++----------------
 7 files changed, 157 insertions(+), 133 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a7c6ef764e63..ba44a67a0a34 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
-				 new_flags, vma->anon_vma,
-				 vma->vm_file, vma->vm_pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
+		prev = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
+					     vma->vm_end, new_flags,
+					     NULL_VM_UFFD_CTX);
+
 		if (prev) {
 			vma = prev;
 		} else {
@@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1484,28 +1482,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 ((struct vm_userfaultfd_ctx){ ctx }),
-				 anon_vma_name(vma));
-		if (prev) {
-			/* vma_merge() invalidated the mas */
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+		prev = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					     new_flags,
+					     (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(prev)) {
+			ret = PTR_ERR(prev);
+			break;
 		}
-	next:
+
+		if (prev)
+			vma = prev; /* vma_merge() invalidated the mas */
+
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
@@ -1568,7 +1555,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
-	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1671,26 +1657,15 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, pgoff,
-				 vma_policy(vma),
-				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev) {
-			vma = prev;
-			goto next;
-		}
-		if (vma->vm_start < start) {
-			ret = split_vma(&vmi, vma, start, 1);
-			if (ret)
-				break;
-		}
-		if (vma->vm_end > end) {
-			ret = split_vma(&vmi, vma, end, 0);
-			if (ret)
-				break;
+		prev = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					     new_flags, NULL_VM_UFFD_CTX);
+		if (IS_ERR(prev)) {
+			ret = PTR_ERR(prev);
+			break;
 		}
-	next:
+
+		if (prev)
+			vma = prev;
 		/*
 		 * In the vma_merge() successful mprotect-like case 8:
 		 * the next vma was merged into the current one and
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7b667786cde..83ee1f35febe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3253,6 +3253,66 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/madvise.c b/mm/madvise.c
index a4a20de50494..801d3c1bb7b3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -141,7 +141,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
-	pgoff_t pgoff;
+	struct vm_area_struct *merged;
 	VMA_ITERATOR(vmi, mm, start);
 
 	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
@@ -149,30 +149,16 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
-			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			  vma->vm_userfaultfd_ctx, anon_name);
-	if (*prev) {
-		vma = *prev;
-		goto success;
-	}
-
-	*prev = vma;
-
-	if (start != vma->vm_start) {
-		error = split_vma(&vmi, vma, start, 1);
-		if (error)
-			return error;
-	}
+	merged = vma_modify_flags_name(&vmi, *prev, vma, start, end, new_flags,
+				       anon_name);
+	if (IS_ERR(merged))
+		return PTR_ERR(merged);
 
-	if (end != vma->vm_end) {
-		error = split_vma(&vmi, vma, end, 0);
-		if (error)
-			return error;
-	}
+	if (merged)
+		vma = *prev = merged;
+	else
+		*prev = vma;
 
-success:
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b01922e88548..6b2e99db6dd5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -786,8 +786,6 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct vm_area_struct *merged;
 	unsigned long vmstart, vmend;
-	pgoff_t pgoff;
-	int err;
 
 	vmend = min(end, vma->vm_end);
 	if (start > vma->vm_start) {
@@ -802,27 +800,15 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return 0;
 	}
 
-	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
-	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
-			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	merged =  vma_modify_policy(vmi, *prev, vma, vmstart, vmend, new_pol);
+	if (IS_ERR(merged))
+		return PTR_ERR(merged);
+
 	if (merged) {
 		*prev = merged;
 		return vma_replace_policy(merged, new_pol);
 	}
 
-	if (vma->vm_start != vmstart) {
-		err = split_vma(vmi, vma, vmstart, 1);
-		if (err)
-			return err;
-	}
-
-	if (vma->vm_end != vmend) {
-		err = split_vma(vmi, vma, vmend, 0);
-		if (err)
-			return err;
-	}
-
 	*prev = vma;
 	return vma_replace_policy(vma, new_pol);
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index 42b6865f8f82..ae83a33c387e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -476,10 +476,10 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long end, vm_flags_t newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgoff_t pgoff;
 	int nr_pages;
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
+	struct vm_area_struct *merged;
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
@@ -487,28 +487,15 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
-			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*prev) {
-		vma = *prev;
-		goto success;
-	}
-
-	if (start != vma->vm_start) {
-		ret = split_vma(vmi, vma, start, 1);
-		if (ret)
-			goto out;
+	merged = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	if (IS_ERR(merged)) {
+		ret = PTR_ERR(merged);
+		goto out;
 	}
 
-	if (end != vma->vm_end) {
-		ret = split_vma(vmi, vma, end, 0);
-		if (ret)
-			goto out;
-	}
+	if (merged)
+		vma = *prev = merged;
 
-success:
 	/*
 	 * Keep track of amount of locked VM.
 	 */
diff --git a/mm/mmap.c b/mm/mmap.c
index 673429ee8a9e..22d968affc07 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2437,6 +2437,51 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
+/*
+ * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
+ * context and anonymous VMA name within the range [start, end).
+ *
+ * As a result, we might be able to merge the newly modified VMA range with an
+ * adjacent VMA with identical properties.
+ *
+ * If no merge is possible and the range does not span the entirety of the VMA,
+ * we then need to split the VMA to accommodate the change.
+ */
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name)
+{
+	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *merged;
+
+	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
+			   vma->anon_vma, vma->vm_file, pgoff, policy,
+			   uffd_ctx, anon_name);
+	if (merged)
+		return merged;
+
+	if (vma->vm_start < start) {
+		int err = split_vma(vmi, vma, start, 1);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	if (vma->vm_end > end) {
+		int err = split_vma(vmi, vma, end, 0);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return NULL;
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..6f85d99682ab 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -581,7 +581,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned int mm_cp_flags = 0;
 	unsigned long charged = 0;
-	pgoff_t pgoff;
+	struct vm_area_struct *merged;
 	int error;
 
 	if (newflags == oldflags) {
@@ -625,34 +625,19 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		}
 	}
 
-	/*
-	 * First try to merge with previous and/or next vma.
-	 */
-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
-			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-	if (*pprev) {
-		vma = *pprev;
-		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
-		goto success;
+	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
+	if (IS_ERR(merged)) {
+		error = PTR_ERR(merged);
+		goto fail;
 	}
 
-	*pprev = vma;
-
-	if (start != vma->vm_start) {
-		error = split_vma(vmi, vma, start, 1);
-		if (error)
-			goto fail;
-	}
-
-	if (end != vma->vm_end) {
-		error = split_vma(vmi, vma, end, 0);
-		if (error)
-			goto fail;
+	if (merged) {
+		vma = *pprev = merged;
+		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
+	} else {
+		*pprev = vma;
 	}
 
-success:
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
-- 
2.42.0

