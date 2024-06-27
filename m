Return-Path: <linux-fsdevel+bounces-22611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C1F91A41D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A3D1F26A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9F14D2A6;
	Thu, 27 Jun 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEW0hGmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E514A4D8;
	Thu, 27 Jun 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484788; cv=none; b=LinV8mpaSB7RbkKhlKvUmMe+6YzTfCL2BaV+Q03hMaFDEGD16jikDVHAfjbUMeP3Bw0WWZK3zZdtcVLAYmnNRQ22dP+XTadQ1gg23gDyt1pmWiTFq6QklDsDQAmGhPNA02+VAehtJsibnxH5QgSDnyt42Z6yyqm1riryicQWJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484788; c=relaxed/simple;
	bh=U694kFw/6iD6YeJ6U++WTgl7iRE9GeOxuDo2+Lx4kbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJmKTyAGnoQ2YQy+B3pb1l+TLilDL+PZL1iykvzD49k+nviLcvn+yBabaTkgDTL7DWr8P7PF9eCSJMLzp6RTjRQdb0BX+2DUimtosMKBobmvO3CSKrM/FO/hFiya/Ky0zuT0lSFYcSxH5nGUR/Q0zmKpfO+IBtcophcFe/Ji7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEW0hGmy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso4302015e9.3;
        Thu, 27 Jun 2024 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484785; x=1720089585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1mI/XnHRRRa7DZ/i/QysM4CwVeQvYj4PXmQwzkmvuQ=;
        b=OEW0hGmy0UYSPU9hsCNIZSFTaD9MAU0AZ+R1ohJy/ORnceySrIL8jqg4fDyWznLA1n
         f5q8ZFql4svmrC13AA5W5bg46xVayCJO+AQ2sYc+fVwJlpSo5absHrx2lYy02am8f2ir
         R/zkNnWvBs49DeMmoRxERymWCWsWyTLRLKB0I2l1joyu0E/EQTyFros6FksACXFdVeM5
         Jlo51BUeOAiDzen88qvirIPTev7kXublD2SH5l9/JAeh9kxzmqQjKrRE2s0YWO/fYffO
         GqWMCztbpN1vs9XcEFchvExRwI7G8VdY7TOxpxmLh8VgNh8dB3sl5f3zd+1xjgjqOUVq
         WEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484785; x=1720089585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1mI/XnHRRRa7DZ/i/QysM4CwVeQvYj4PXmQwzkmvuQ=;
        b=AOjB+v8MPeom+Fhe8MckyFHUOyIbEa9QaXfWPhuZaPtv5/uxJUEAIt9rQgDdIDN5Mz
         bAGtRntwGvZa3Q+QUzIBVnPqK0m5s5GX7pD1BmTTG7NXsz1UYqMEE+vOXvI2t1P8zzIa
         uf9zdSCBmulevd9epbRSrzcw1VuGOR/moPykzqpje/KqpIW3K8XsP4uWdnv2k10vbDh3
         ALwsZ2F2ZyYQj4wit8at01tzAOsHWvrhyxWnVHy7pUD6GLhFPfyiZr7+bymquDMbALwJ
         tT7H97iKeWmu1IyMoNfpfAua7H822OZVlUlNzxLjBkEzC75eyjmJbFr2L5kw7yxY1pLI
         JXlA==
X-Forwarded-Encrypted: i=1; AJvYcCWtWjElELsqbhRhzL5Uf3nA8bbNzfP4rMvF0MoV2gb5mxGaJIzEpUVkYTtOJBGU2UY6J37jrfbfQ8KBRoBiudo8aQ9KrBbn5t/9Eghj
X-Gm-Message-State: AOJu0YwOF7sryQ0IOSGtW0+Zz0oKBYxX75+Axapv/Nvvl2xtyVKxTdxY
	EArspcQOVKaFS/jNHMYSlSK/51druMEHni0EZ/F1+s3QXiREwnXN
X-Google-Smtp-Source: AGHT+IG7XtPfOu6QjtFPWL6XQDzOQY6e7nTdOlOULBFnWOXjAikZ3KYpC/rd1SGYeQ5Q7BaVfA0Kww==
X-Received: by 2002:a05:600c:5692:b0:424:8dba:4a43 with SMTP id 5b1f17b1804b1-4248dba4d52mr109654595e9.5.1719484784917;
        Thu, 27 Jun 2024 03:39:44 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42564bb6caasm19957195e9.33.2024.06.27.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:39:43 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 3/7] mm: unexport vma_expand() / vma_shrink()
Date: Thu, 27 Jun 2024 11:39:28 +0100
Message-ID: <8c548bb3d0286bfaef2cd5e67d7bf698967a52a1.1719481836.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719481836.git.lstoakes@gmail.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma_expand() and vma_shrink() functions are core VMA manipulaion
functions which ultimately invoke VMA split/merge. In order to make these
testable, it is convenient to place all such core functions in a header
internal to mm/.

In addition, it is safer to abstract direct access to such functionality so
we can better control how other parts of the kernel use them, which
provides us the freedom to change how this functionality behaves as needed
without having to worry about how this functionality is used elsewhere.

In order to service both these requirements, we provide abstractions for
the sole external user of these functions, shift_arg_pages() in fs/exec.c.

We provide vma_expand_bottom() and vma_shrink_top() functions which better
match the semantics of what shift_arg_pages() is trying to accomplish by
explicitly wrapping the safe expansion of the bottom of a VMA and the
shrinking of the top of a VMA.

As a result, we place the vma_shrink() and vma_expand() functions into
mm/internal.h to unexport them from use by any other part of the kernel.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/exec.c          | 26 +++++--------------
 include/linux/mm.h |  9 +++----
 mm/internal.h      |  6 +++++
 mm/mmap.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..1cb3bf323e0f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -700,25 +700,14 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	unsigned long length = old_end - old_start;
 	unsigned long new_start = old_start - shift;
 	unsigned long new_end = old_end - shift;
-	VMA_ITERATOR(vmi, mm, new_start);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
+	int ret;
 
-	BUG_ON(new_start > new_end);
-
-	/*
-	 * ensure there are no vmas between where we want to go
-	 * and where we are
-	 */
-	if (vma != vma_next(&vmi))
-		return -EFAULT;
-
-	vma_iter_prev_range(&vmi);
-	/*
-	 * cover the whole range: [new_start, old_end)
-	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
-		return -ENOMEM;
+	ret = vma_expand_bottom(&vmi, vma, shift, &next);
+	if (ret)
+		return ret;
 
 	/*
 	 * move the page tables downwards, on failure we rely on
@@ -730,7 +719,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
-	next = vma_next(&vmi);
+
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
@@ -749,9 +738,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	}
 	tlb_finish_mmu(&tlb);
 
-	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink_top(&vmi, vma, shift);
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d2b5538925b..e3220439cf75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3273,11 +3273,10 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next);
-extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end, pgoff_t pgoff);
+extern int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
+			     unsigned long shift, struct vm_area_struct **next);
+extern int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
+			  unsigned long shift);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
diff --git a/mm/internal.h b/mm/internal.h
index c8177200c943..f7779727bb78 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
 			  vma_policy(vma), new_ctx, anon_vma_name(vma));
 }
 
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next);
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..574e69a04ebe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3940,6 +3940,71 @@ void mm_drop_all_locks(struct mm_struct *mm)
 	mutex_unlock(&mm_all_locks_mutex);
 }
 
+/*
+ * vma_expand_bottom() - Expands the bottom of a VMA downwards. An error will
+ *                       arise if there is another VMA in the expanded range, or
+ *                       if the expansion fails. This function leaves the VMA
+ *                       iterator, vmi, positioned at the newly expanded VMA.
+ * @vmi: The VMA iterator.
+ * @vma: The VMA to modify.
+ * @shift: The number of bytes by which to expand the bottom of the VMA.
+ * @next: Output parameter, pointing at the VMA immediately succeeding the newly
+ *        expanded VMA.
+ *
+ * Returns: 0 on success, an error code otherwise.
+ */
+int vma_expand_bottom(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		      unsigned long shift, struct vm_area_struct **next)
+{
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
+	unsigned long new_start = old_start - shift;
+	unsigned long new_end = old_end - shift;
+
+	BUG_ON(new_start > new_end);
+
+	vma_iter_set(vmi, new_start);
+
+	/*
+	 * ensure there are no vmas between where we want to go
+	 * and where we are
+	 */
+	if (vma != vma_next(vmi))
+		return -EFAULT;
+
+	vma_iter_prev_range(vmi);
+
+	/*
+	 * cover the whole range: [new_start, old_end)
+	 */
+	if (vma_expand(vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+		return -ENOMEM;
+
+	*next = vma_next(vmi);
+	vma_prev(vmi);
+
+	return 0;
+}
+
+/*
+ * vma_shrink_top() - Reduce an existing VMA's memory area by shift bytes from
+ *                    the top of the VMA.
+ * @vmi: The VMA iterator, must be positioned at the VMA.
+ * @vma: The VMA to modify.
+ * @shift: The number of bytes by which to shrink the VMA.
+ *
+ * Returns: 0 on success, an error code otherwise.
+ */
+int vma_shrink_top(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		   unsigned long shift)
+{
+	if (shift >= vma->vm_end - vma->vm_start)
+		return -EINVAL;
+
+	return vma_shrink(vmi, vma, vma->vm_start, vma->vm_end - shift,
+			  vma->vm_pgoff);
+}
+
 /*
  * initialise the percpu counter for VM
  */
-- 
2.45.1


