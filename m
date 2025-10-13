Return-Path: <linux-fsdevel+bounces-64059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC828BD6CE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 606BC4F715B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391C2FD1DD;
	Mon, 13 Oct 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar5+OXZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D822DE1E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399772; cv=none; b=oXLmWLHHFZ2EEIivxpOEin4d9zpS+cIK+0Khk3FbSFcQ0ascikqFSy3PvgrmputZfsfQGVcPfnSbZQjG0MXIYCojF+1nuXnUHuPhz1jtRkjVi4CNVY/y06gGccMQpmIx0NtEhLZm//7LEuZfmFPIimjFuF2EpbzLPQ3a5/k4fcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399772; c=relaxed/simple;
	bh=SJTTx4LsORAjZOJfF+qmSCgifzb7lteHMuDlMwA0+70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHaQE+vdlR5a/rrIoQI3LCTRDD+0pn6TD8ZWMwyu3WzoMxbZIHdOOw5ALHmFRAiGQJPnEx997WUO6xGvFtu6YHdWTpYpB8Q0sl3AiyI0bHarr2VgEArEYjkA8AKT7hrxRnACbxFEq4jMJqpk18pWmSdnZ+3WttzmSApwZluQLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ar5+OXZN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27eeb9730d9so93883905ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399769; x=1761004569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWS8JbZTybY/HgwtmvUUAsgUoQtqFfjRM6A15QtRFtc=;
        b=ar5+OXZNLytYtHwRsKOh3DDdWqiHRW8NUrBofikDDJfbVeQjzCxPSOMsMPWbASgy0w
         bnTmzLV0RoFt7lbpcOiPpppvL614908xpb+YFJSKourNKdKX/xOFqVwXHuv/YZc6npw/
         I0n6ikBc/Pi6wjvFQ/d/Hc0IcG5lwuMT+y4HZxHyUJYxGb3g5qwEzpRYwJ5VwXiPPoJr
         2cV4+9eLOumdnFm81zHYWEhgTqRpwkQ/rEDhaC5i2rcBs49jX45G9DZ1UUO8SD1JQoc7
         IrNyjwaYfIovXT+/ADGuoPhf1UA4jFY0/SK9FZN7mFFn/AUpHTA98I/yj4DD/EjNpWbp
         E7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399769; x=1761004569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWS8JbZTybY/HgwtmvUUAsgUoQtqFfjRM6A15QtRFtc=;
        b=qlXpVzRXYynCDJa6A/SWwmWvYREI6JQMMMAfVlRsfywKQSY/D4DapNzVQWeBOAhn/k
         vj+WBtQcABMoIxE9/z5rYSTg1r1TKimOL4jofkA/8/QpSut0UDBJIbhrvaUIsfYzni2Z
         msR9Qf0gJMDsYSe1CDiE9WyoxrAQ9FPPmbmB9btfaej4o4SAE4tQYTTgxQBf6yy4NL71
         DMtRMT61S+zc8+w80B2rs/eugsrBphTeMRPGY/Fx7zHdsDP/nd3QP8ZDCyWdmw7Hia4A
         BZl3qreImhF0aHdQ+HazFgelfeZHoP5O9o5HJ/Qfq+68ixYqbXYzPxjMNYtT/SRaKLT0
         OFYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOI3w+YTD42sEIZ+3GxyfA3SEdeOcCtCMOPo3vZFBzTxTRoNgCwju3hy0K92K47dY1k/IO6Slfu8Amh4b4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90CqTkKF0Pcomh2j/9sABhA61XBjeIQA7rHsODqMybFQiOmQE
	/s9LqEWp5caJ+8oWiS2If5xkN20TfcUeUzDym0EbVMO7epSTs8ehT23lu8Que8n15oGeARE+NB1
	LugwAlPU45TEkxenmRoC+vlGNmw==
X-Google-Smtp-Source: AGHT+IGz7Acs955+JHt6jWBnGAVlrb2i9ZFcEZvLhMTomk5H/KJdcpKZNG2gPSwMMx7169I77mG09nPrtox3WC7DAA==
X-Received: from plsd3.prod.google.com ([2002:a17:902:b703:b0:27d:6f45:42ec])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c2c:b0:24e:81d2:cfda with SMTP id d9443c01a7336-290272500c7mr257234325ad.0.1760399769577;
 Mon, 13 Oct 2025 16:56:09 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:51:54 -0700
In-Reply-To: <20251013235259.589015-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013235259.589015-4-kaleshsingh@google.com>
Subject: [PATCH v3 3/5] mm: introduce vma_count_remaining()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
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
available for a given mm.

The most common case of checking for a single new VMA can be done with
the convenience helper has_vma_count_remaining():

    if (!vma_count_remaining(mm))

And the complex checks in mremap.c become clearer by expressing the
required capacity directly:

    if (vma_count_remaining(mm) < 4)

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

Changes in v3:
 - Move vma_count_remaining() out of #if CONFIG_SYSCTL to fix build 
   failure
 - Use READ_ONCE() for sysclt_max_map_count, per David, Lorenzo
 - Remove use of ternary op in vma_count_remaining, per Lorenzo
 - Rebase on mm-new to fix conflicts in vma_internal.h and
   mm/internal.h

 include/linux/mm.h               |  2 --
 mm/internal.h                    |  3 +++
 mm/mmap.c                        | 24 +++++++++++++++++++++++-
 mm/mremap.c                      |  7 ++++---
 mm/nommu.c                       |  2 +-
 mm/util.c                        |  1 -
 mm/vma.c                         | 10 +++++-----
 tools/testing/vma/vma_internal.h |  9 +++++++++
 8 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5c01c4b59ca6..72ff386ef772 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -203,8 +203,6 @@ static inline void __mm_zero_struct_page(struct page *page)
 #define MAPCOUNT_ELF_CORE_MARGIN	(5)
 #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
 
-extern int sysctl_max_map_count;
-
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
 
diff --git a/mm/internal.h b/mm/internal.h
index a2555be247e5..289aca3bdb6c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1682,4 +1682,7 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
 	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
 }
 
+/* mmap.c */
+int vma_count_remaining(const struct mm_struct *mm);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index da2cbdc0f87b..d9ea029cd018 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	/*
@@ -1495,6 +1495,28 @@ struct vm_area_struct *_install_special_mapping(
 					&special_mapping_vmops);
 }
 
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
+	const int max_count = READ_ONCE(sysctl_max_map_count);
+
+	if (map_count >= max_count)
+		return 0;
+
+	return max_count - map_count;
+}
+
 #ifdef CONFIG_SYSCTL
 #if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
 		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
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
index c3a23b082adb..22e55e7c69c4 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1317,7 +1317,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	mm = vma->vm_mm;
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	region = kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
diff --git a/mm/util.c b/mm/util.c
index 088e1f8edcf5..3315e1136c69 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -752,7 +752,6 @@ EXPORT_SYMBOL(folio_mc_copy);
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
diff --git a/mm/vma.c b/mm/vma.c
index fba68f13e628..96ba37721002 100644
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
@@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count >= sysctl_max_map_count)
+	if (!vma_count_remaining(mm))
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3525f5c15e1b..70f11163ab72 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1484,4 +1484,13 @@ static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
 	return 0;
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
2.51.0.760.g7b8bcc2412-goog


