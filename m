Return-Path: <linux-fsdevel+bounces-61437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD3B58271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AB71A211F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B22877D2;
	Mon, 15 Sep 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yU9zVeT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE5285CB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954785; cv=none; b=bFHZ5KZTJXpHqLQfU4DZ6SY5BZiIufclm1IlehXDoNVArGAuVeqFLXedGiZAYf7yMSGFaH2RcSk4NJSxQo8Ci2FJDjSV3VH2+GwQopPtUiFTMQ9hhUvGgveYkFffcK/4m9Vv6UiHhEO4oSwfjX1aLAKkgGaHvnv4d/vCCsD0xGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954785; c=relaxed/simple;
	bh=lBWlwS7JcG7Bq/AWf4HTbFz+jYysV8dehUYeg6ZHX+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVdJYgqG6qFOnvmIH1YZOlE60fdsy8JkHD6VGPjzJcESprSqPBLclNsorICT3d2/y1sPmKdiHNDiPg/yPx2VgrAMrSwKae46dGP5ig51jQnj+iNCRXLQxKw/bHVlnLFrZSWbAKoU40DTkwScxsbs6zgP3OO6t/1uDl/0f94xByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yU9zVeT3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-252afdfafe1so46773455ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954783; x=1758559583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvhIc5Qwm2MSlXgaqDt0tPsJi6Fn6VtZiCytLA6TTWs=;
        b=yU9zVeT3pmDrQ8UAASYsebznUX/oI10RS8RbKZE2oeH6l1pSMmASgj7Ww4qlEhy0zR
         fsrCL2CJCx/fqi3ANRRzAGM7c4j2rNfkO+CWnbYX+gAdruP/oEBOfxUlsZGMbOXhzd9P
         HzRPsAbD4mbw4yXUlPg4n5ofIJ+lhDRbsjMvMDxdmCxkqeWskN/tReNcR3zuC53qLP9c
         MMStveY5rq8LvSkT2dwD6CYZ1995U8uvBmeHiLc7qTE+N2GYRj+GKLFWfSmky9EeZGHo
         tx0tJrxnFVA5wiJL3B4xo4c1ZxvnWYuFgiqTelYI7S0xD9OGTXayj757q9IJjVzQh1Yx
         GxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954783; x=1758559583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvhIc5Qwm2MSlXgaqDt0tPsJi6Fn6VtZiCytLA6TTWs=;
        b=bGHPhfqAQhYm2hD1aGKYbGsLLC7DK7w7tgYh3D9eQ1SpZqzCsD5sHSN6nkh9P1WHuK
         XE5iDZv7qETKJxETRuwkSuVN5vWGaDyuy8IQj/+NpyV01x0z2Kd0aUiQImKogjJIh/7a
         lWFAjwKIG7dInYvrHN+0xfCiv/qR05p6rx9DJdHyTxnJ6fwpdiLnFElVGSmkwgyt9ZIX
         pQpAhkq27u00m8l0of+AceveQ6WcJ4iGC27MQy/4W/uY0+zrl/4QMaZcRk7Lg4FJ0uU2
         IJRbmtNUF4CYPbUNBqXb8ZCHnrR71S7tZLis9hzd3ny/UrNaM8M2Z/eFRX9rjBaXu95U
         +WFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0vNJS52rgybeLr9eHNnu9rplYI1AhZ9tNycYdhitVwypPagkzcG6Nk/EqRepU49LlmAYJSWcygwnS12Bw@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9vkyj80XvRruWqdCAeUE+XZWTbBTuUrXoHI65xQCAfppuGMo
	lWo5uFp4NF5RJ1ZuExtjni+smhQUWs6HrBaxkNIxHW6OU7iPTCww6Oc+WxD7tyokb6RbMwjtopK
	QCN6GZPcsQ1Aw0KpynFQudriatQ==
X-Google-Smtp-Source: AGHT+IETjSAgl4Bq7YGi4NHOQLEhA++l/mjHETWNYuPpSZDm1ovOxLN6UFeAYtoyBJbEGZn5mcnKagruLzvaK22crw==
X-Received: from plap12.prod.google.com ([2002:a17:902:f08c:b0:264:3c1f:6385])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:240c:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-25d23e13c87mr190358195ad.2.1757954783437;
 Mon, 15 Sep 2025 09:46:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:34 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-4-kaleshsingh@google.com>
Subject: [PATCH v2 3/7] mm: introduce vma_count_remaining()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The checks against sysctl_max_map_count are open-coded in multiple
places. While simple checks are manageable, the logic in places like
mremap.c involves arithmetic with magic numbers that can be difficult
to reason about. e.g. ... >= sysctl_max_map_count - 3

To improve readability and centralize the logic, introduce a new helper,
vma_count_remaining(). This function returns the VMA count headroom
available for a givine process.

The most common case of checking for a single new VMA can be done with
the convenience helper has_vma_count_remaining():

    if (!vma_count_remaining(mm))

And the complex checks in mremap.c become clearer by expressing the
required capacity directly:

    if (vma_count_remaining(mm) <  4)

While a capacity-based function could be misused (e.g., with an
incorrect '<' vs '<=' comparison), the improved readability at the call
sites makes such errors less likely than with the previous open-coded
arithmetic.

As part of this change, sysctl_max_map_count is made static to
mm/mmap.c to improve encapsulation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Fix documentation comment for vma_count_remaining(), per Mike
  - Remove extern in header, per Mike and Pedro
  - Move declaration to mm/internal.h, per Mike
  - Replace exceeds_max_map_count() with capacity-based vma_count_remaining(),
       per Lorenzo.
  - Fix tools/testing/vma, per Lorenzo.

 include/linux/mm.h               |  2 --
 mm/internal.h                    |  2 ++
 mm/mmap.c                        | 21 ++++++++++++++++++++-
 mm/mremap.c                      |  7 ++++---
 mm/nommu.c                       |  2 +-
 mm/util.c                        |  1 -
 mm/vma.c                         | 10 +++++-----
 tools/testing/vma/vma_internal.h |  9 +++++++++
 8 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..138bab2988f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -192,8 +192,6 @@ static inline void __mm_zero_struct_page(struct page *page)
 #define MAPCOUNT_ELF_CORE_MARGIN	(5)
 #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
 
-extern int sysctl_max_map_count;
-
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..39f1c9535ae5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1661,4 +1661,6 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
+int vma_count_remaining(const struct mm_struct *mm);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index e5370e7fcd8f..af88ce1fbb5f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	/*
@@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
 int sysctl_legacy_va_layout;
 #endif
 
+static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
+
+/**
+ * vma_count_remaining - Determine available VMA slots
+ * @mm: The memory descriptor for the process.
+ *
+ * Check how many more VMAs can be created for the given @mm
+ * before hitting the sysctl_max_map_count limit.
+ *
+ * Return: The number of new VMAs the process can accommodate.
+ */
+int vma_count_remaining(const struct mm_struct *mm)
+{
+	const int map_count = mm->map_count;
+	const int max_count = sysctl_max_map_count;
+
+	return (max_count > map_count) ? (max_count - map_count) : 0;
+}
+
 static const struct ctl_table mmap_table[] = {
 		{
 				.procname       = "max_map_count",
diff --git a/mm/mremap.c b/mm/mremap.c
index 35de0a7b910e..14d35d87e89b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (current->mm->map_count >= sysctl_max_map_count - 3)
+	if (vma_count_remaining(current->mm) < 4)
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
@@ -1814,9 +1814,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * split in 3 before unmapping it.
 	 * That means 2 more maps (1 for each) to the ones we already hold.
 	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 * the threshold. In other words, is the current map count + 6 at or
+	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+	if (vma_count_remaining(current->mm) < 6)
 		return -ENOMEM;
 
 	return 0;
diff --git a/mm/nommu.c b/mm/nommu.c
index 8b819fafd57b..dd75f2334812 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1316,7 +1316,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	mm = vma->vm_mm;
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	region = kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
diff --git a/mm/util.c b/mm/util.c
index f814e6a59ab1..b6e83922cafe 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -751,7 +751,6 @@ EXPORT_SYMBOL(folio_mc_copy);
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
diff --git a/mm/vma.c b/mm/vma.c
index 033a388bc4b1..df0e8409f63d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -491,8 +491,8 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 }
 
 /*
- * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
- * has already been checked or doesn't make sense to fail.
+ * __split_vma() bypasses vma_count_remaining() checks. We use this where
+ * it has already been checked or doesn't make sense to fail.
  * VMA Iterator will point to the original VMA.
  */
 static __must_check int
@@ -592,7 +592,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (vma->vm_mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(vma->vm_mm))
 		return -ENOMEM;
 
 	return __split_vma(vmi, vma, addr, new_below);
@@ -1345,7 +1345,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
+		    !vma_count_remaining(vms->vma->vm_mm)) {
 			error = -ENOMEM;
 			goto map_count_exceeded;
 		}
@@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3639aa8dd2b0..52cd7ddc73f4 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1517,4 +1517,13 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 	return vm_flags;
 }
 
+/* Helper to get VMA count capacity */
+static int vma_count_remaining(const struct mm_struct *mm)
+{
+	const int map_count = mm->map_count;
+	const int max_count = sysctl_max_map_count;
+
+	return (max_count > map_count) ? (max_count - map_count) : 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0.384.g4c02a37b29-goog


