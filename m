Return-Path: <linux-fsdevel+bounces-61440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70772B5827C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34391A2066A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D415284684;
	Mon, 15 Sep 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVZCAX6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99D27B50F
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954833; cv=none; b=u3bY0v0Fv66cIToZ0qQNzJp7XRlWuu9D4qwsPJVYuI6zKEZRCezm+CAAB8xyAfDOrUNRxnttANNdEeRIP+6kQa6BVUdKX1CCUvQI3FaUSresWLtzhe/nXBgIp5ZgcxniNW0wISg4ZazSfcV2WOKkCuHSwXPNqudUKQ9GdrH312M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954833; c=relaxed/simple;
	bh=pvCfH5VsfNwVFReZuZTk36FRtKutRSyx+F6VGLxE6kM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=efbJ/MV/JlKGsz6ZQebT8gJpgS3vINN21vAzF+hLGDibKi5iOCcVwuoBS42tQAbNesLQTUYETPQp69fVK8EkJtyXl5msumhh/UR5qZxQ0bpqpKUnWppAblkqCta8yKPdq+zq9NFLzXlvcotxMAaetObj9KdziYbYuKt2qHwWICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVZCAX6H; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54c46337c9so2247658a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954830; x=1758559630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKwpABqpohuFqzMZ59NYGHVdaV3v0Z5awKHv0UgL8Ps=;
        b=gVZCAX6HJOPfCYrrcb8VP55QLCj2yQ1s6oyBe+OSHPAbX1XUOkOkyCYncQ+BeHO6qm
         H23YxZ9/AY0EpPXOgT3RmEvMMfhqFAuILCEebdYBFRECRLnNO4+KVkmdLYqBktY9RTxc
         2kxkNEycjsVQBB4QftNiRhNmGSU3FKvjuInNXx76ApzEKe/jfj2uwrrS8dCoAUaDAcvZ
         67P5JmI8cglRupSmoe3FLBdcqm7kKkhO6bbY9y7jf7RBuLFinschXcVgTz19dnHD2aZ2
         yhNKpF/eDBgyD0ajOzj4ojTL0Tn6eTEr6AShmYxf7RcLa1UYYFgXcYjjCD2d9ZYSHj3y
         zI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954830; x=1758559630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKwpABqpohuFqzMZ59NYGHVdaV3v0Z5awKHv0UgL8Ps=;
        b=S/+Bmf36owvXaFgvFcSVnUeD+5XKddmlezdGswFrzkjDWKhVmXhUJhcADFnRkHBZf7
         IEKMCTZ++7zPVsmDTMQyVNSSyLlnZ0rV8bWR0MLdOU/HFVILMqSMp78Wv6AH1miqYmhw
         OoelNxFqlvzvSvbEUA/ZNBvJaMTwCcoJazmdnmTJb1W+yttVSqblURE6bIkZii8aeCuS
         gW0XGf18sjpnpmltk35Gtk7RQVW3eOGHl6dbSwzRxAzdFRQUhFpqk8dH4rLHYw5YYlZ6
         gPK3lsrjhYL8y1CEIKUPxgOeiTLXi/ZXF+VqaTz8Lcn50xq9UKTqXDqGgDdWpluFlbnL
         eW9A==
X-Forwarded-Encrypted: i=1; AJvYcCXYdWytWVhICq3qneTz704ynRzzyResi2vEVYIHEmytYBLRlQID1t6Rjq/kP4Sre/4swVpiRe2reailBDRN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywverig0WTPj+7uiVfvC4rgry/XU886X8zu7eSsEGBFjdEIAplL
	cCVzOWsdPefV4TMc36MseIXMB+3qC97IJWy9sQUsmlWC5ytC2AJIeCK8pvOSlqANxb0Av0BFggR
	ybk5FMx0YDot+ukXk/6jSfNgBjA==
X-Google-Smtp-Source: AGHT+IHxs26EIdlIXz631Uz365/CGN6f9O6Xm7lLrsiaFhIbp7CDzVSSsE3TgFf9kclQMXvcquwmL00++yYPRtwtYA==
X-Received: from plbnb15.prod.google.com ([2002:a17:903:15cf:b0:24c:af07:f077])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2448:b0:267:a55a:8684 with SMTP id d9443c01a7336-267a55a8724mr34282065ad.2.1757954829980;
 Mon, 15 Sep 2025 09:47:09 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:37 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-7-kaleshsingh@google.com>
Subject: [PATCH v2 6/7] mm: add assertion for VMA count limit
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

Building on the vma_count helpers, add a VM_WARN_ON_ONCE() to detect
cases where the VMA count exceeds the sysctl_max_map_count limit.

This check will help catch future bugs or regressions where
the VMAs are allocated exceeding the limit.

The warning is placed in the main vma_count_*() helpers, while the
internal *_nocheck variants bypass it. _nocheck helpers are used to
ensure that the assertion does not trigger a false positive in
the legitimate case of a temporary VMA increase past the limit
by a VMA split in munmap().

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
  - Add assertions if exceeding max_vma_count limit, per Pedro

 include/linux/mm.h               | 12 ++++++--
 mm/internal.h                    |  1 -
 mm/vma.c                         | 49 +++++++++++++++++++++++++-------
 tools/testing/vma/vma_internal.h |  7 ++++-
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bad1454984c..3a3749d7015c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4219,19 +4219,27 @@ static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
 
 void snapshot_page(struct page_snapshot *ps, const struct page *page);
 
+int vma_count_remaining(const struct mm_struct *mm);
+
 static inline void vma_count_init(struct mm_struct *mm)
 {
 	ACCESS_PRIVATE(mm, __vma_count) = 0;
 }
 
-static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+static inline void __vma_count_add_nocheck(struct mm_struct *mm, int nr_vmas)
 {
 	ACCESS_PRIVATE(mm, __vma_count) += nr_vmas;
 }
 
+static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+{
+	VM_WARN_ON_ONCE(!vma_count_remaining(mm));
+	__vma_count_add_nocheck(mm, nr_vmas);
+}
+
 static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
 {
-	vma_count_add(mm, -nr_vmas);
+	__vma_count_add_nocheck(mm, -nr_vmas);
 }
 
 static inline void vma_count_inc(struct mm_struct *mm)
diff --git a/mm/internal.h b/mm/internal.h
index 39f1c9535ae5..e0567a3b64fa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1661,6 +1661,5 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
-int vma_count_remaining(const struct mm_struct *mm);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/vma.c b/mm/vma.c
index 0cd3cb472220..0e4fcaebe209 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,15 +323,17 @@ static void vma_prepare(struct vma_prepare *vp)
 }
 
 /*
- * vma_complete- Helper function for handling the unlocking after altering VMAs,
- * or for inserting a VMA.
+ * This is the internal, unsafe version of vma_complete(). Unlike its
+ * wrapper, this function bypasses runtime checks for VMA count limits by
+ * using the _nocheck vma_count* helpers.
  *
- * @vp: The vma_prepare struct
- * @vmi: The vma iterator
- * @mm: The mm_struct
+ * Its use is restricted to __split_vma() where the VMA count can be
+ * temporarily higher than the sysctl_max_map_count limit.
+ *
+ * All other callers must use vma_complete().
  */
-static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
-			 struct mm_struct *mm)
+static void __vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
+			   struct mm_struct *mm)
 {
 	if (vp->file) {
 		if (vp->adj_next)
@@ -352,7 +354,11 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * (it may either follow vma or precede it).
 		 */
 		vma_iter_store_new(vmi, vp->insert);
-		vma_count_inc(mm);
+		/*
+		 * Explicitly allow vma_count to exceed the threshold to prevent,
+		 * blocking munmap() freeing resources.
+		 */
+		__vma_count_add_nocheck(mm, 1);
 	}
 
 	if (vp->anon_vma) {
@@ -403,6 +409,26 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		uprobe_mmap(vp->insert);
 }
 
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
+			 struct mm_struct *mm)
+{
+	/*
+	 * __vma_complete() explicitly foregoes checking the new
+	 * vma_count against the sysctl_max_map_count limit, so
+	 * do it here.
+	 */
+	VM_WARN_ON_ONCE(!vma_count_remaining(mm));
+	__vma_complete(vp, vmi, mm);
+}
+
 /*
  * init_vma_prep() - Initializer wrapper for vma_prepare struct
  * @vp: The vma_prepare struct
@@ -564,8 +590,11 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma->vm_end = addr;
 	}
 
-	/* vma_complete stores the new vma */
-	vma_complete(&vp, vmi, vma->vm_mm);
+	/*
+	 * __vma_complete stores the new vma without checking against the
+	 * sysctl_max_map_count (vma_count) limit.
+	 */
+	__vma_complete(&vp, vmi, vma->vm_mm);
 	validate_mm(vma->vm_mm);

 	/* Success. */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 6e724ba1adf4..d084b1eb2a5c 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1534,11 +1534,16 @@ static inline void vma_count_init(struct mm_struct *mm)
 	mm->__vma_count = 0;
 }

-static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+static inline void __vma_count_add_nocheck(struct mm_struct *mm, int nr_vmas)
 {
 	mm->__vma_count += nr_vmas;
 }

+static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
+{
+	__vma_count_add_nocheck(mm, nr_vmas);
+}
+
 static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
 {
 	vma_count_add(mm, -nr_vmas);
-- 
2.51.0.384.g4c02a37b29-goog


