Return-Path: <linux-fsdevel+bounces-64061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D52BD6D04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB54F58D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C332FE58E;
	Mon, 13 Oct 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Em8FOyen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0692F1FD1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399794; cv=none; b=T+esUixwWCc462GKEsToefTlGYAUVKJMMdDeOWIzqOOePoNVfl0fKgcNMQO+m8SgnlvhcDxH4R0EbzDpxK3sIM0jI13feinBxAHLq58iE2/jnW7T27R4GNyz4y/F7UsM0ovdZGRMwCY+LU3w69YW6HZ8Q5b2R+TgPMhbTTfyx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399794; c=relaxed/simple;
	bh=Kd2/Hp8IfybPGmt1qPw68IvwiXdoH0oRA5Q2aXe5ddI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YEoihvHwJg598z+4KdBeP7cHTKvD5fx5Q+cFlcCyUW9BjLMqxDruSz2EsBFPommmRTpGXjzADmyHyPyF7a4lTtJXeLJQBzIr2RXIr2qd0SBNOjdZ6YSO2sppHYVoTWTjIVKr0rH9Se8IhJL6JKv+iArpW9VpPoyRy/lL2tVmQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Em8FOyen; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befd39so20451781a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399791; x=1761004591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPYU+2umQYN0e1OeO8X1leEMEVeMTLGsEK2ETVKaSgA=;
        b=Em8FOyen0R8j3jNigIoTe3oLSaZ3z5VepioaRyEiP1FO+VScyY0R5kMn/31w/qU1Qo
         UdxFKTuQFILYMggp35zyiiojfj9jUZYOWFIxWgF6jmO0CpbH8YKhoNKrpHp4JRieTgfC
         JOhvUujhtZVNHdiv2tusV1lgc0Nhv7ywF9rXHwfmyShA6aL6KOBPaqx+I7hzhEmxCob9
         Cdlxq/s8tS5YAT0nDMnYlKuzJqTyPWiVDV9gRZSYTYfHey29paIws6ceczdG8aLq1NG4
         oTl9vo9166xQe4n9fs1PB8c7RbJMFEdMtSm5FbGlJRyL8hs7rUYZc9MicIiNtV8PBsXr
         1SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399791; x=1761004591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPYU+2umQYN0e1OeO8X1leEMEVeMTLGsEK2ETVKaSgA=;
        b=eesRCY5o6c1hgyxeaZ8/wUIxQf92cp7ANv2+fPUrgq5hyOdL2Sjye+ml+HCVxfsrQq
         U/FxvhnYigmc7iHseJmqIAdUWU46viIAnzA6vSysixW97U7f6Rl9PH+K6aT3lcTjTIdr
         jnDrla5GClUYWPc3PxEG7/ySYQUYalehcnyns+v1Sp03sXGW9L57tE33U97ckKKH2cRU
         gZiN2fTVxp6tHWbqAPe19LEnpumKx6fKPQ/KFmINhiKm7wv7vNDCYkOyg4x9MQCG6eWK
         e1C5KJwaUAjyQgYjQVmDnYvrpuWT0UNZZ0FI4JmqSVYmO03vR707iKhFuFnJ5whvP3yJ
         0FAA==
X-Forwarded-Encrypted: i=1; AJvYcCWEemlZqYr5S2ZRAXFd4zBpQggL/Fy27c4s71XIadua4G9sW3PWJTwXEoFRDRMIshSbrMXG7STCgJfWvIf8@vger.kernel.org
X-Gm-Message-State: AOJu0YyNP+8awOVGb4hBC60pafLeHrk6kefhDxW9kAVb9TRBRuW/oqg3
	h5z+G/0scVldMxlWPA7p2Lhdllq8ZwelKgrake1vdjgm6wPFDFDQTr0tPmQg049YAdh4KmFUNP1
	AJDqW6/s7n0VctiM7mwl3uC+FdA==
X-Google-Smtp-Source: AGHT+IG8lrB7VX+K9dIOGBRbbEFaAljZfdwJaT5C/S0Dp/zoN1fe4Txo8ye3OLt4nWf6mVkw5tVIPzsscYSebRBbqg==
X-Received: from pjuu4.prod.google.com ([2002:a17:90b:5864:b0:33b:51fe:1a78])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8c:b0:338:3dca:e0a3 with SMTP id 98e67ed59e1d1-33b51118f99mr34203500a91.16.1760399791496;
 Mon, 13 Oct 2025 16:56:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:51:56 -0700
In-Reply-To: <20251013235259.589015-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013235259.589015-6-kaleshsingh@google.com>
Subject: [PATCH v3 5/5] mm/tracing: introduce trace_mm_insufficient_vma_slots event
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

Needed observability on in field devices can be collected with minimal
overhead and can be toggled on and off. Event driven telemetry can be
done with tracepoint BPF programs.

The process comm is provided for aggregation across devices and tgid is
to enable per-process aggregation per device.

This allows for observing the distribution of such problems in the
field, to deduce if there are legitimate bugs or if a bump to the limit is
warranted.

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
- capture the mm pointer as the unique identifier and capture
  the vma_count as well, instead of current task tgid, per Steve
- Add include/trace/events/vma.h to MEMORY MAPPING section in
  MAINTAINERS, per Lorenzo
- rename trace_max_vma_count_exceeded() to
  trace_mm_insufficient_vma_slots(), since this is a preemptive
  check, per Lorenzo
- Fix tools/testing/vma build errors, per Lorenzo

 MAINTAINERS                      |  1 +
 include/trace/events/vma.h       | 32 ++++++++++++++++++++++++++++++++
 mm/mmap.c                        |  5 ++++-
 mm/mremap.c                      | 10 ++++++++--
 mm/vma.c                         |  9 +++++++--
 mm/vma_internal.h                |  2 ++
 tools/testing/vma/vma_internal.h |  5 +++++
 7 files changed, 59 insertions(+), 5 deletions(-)
 create mode 100644 include/trace/events/vma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aa83e5893e16..d37215a8a829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16566,6 +16566,7 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/trace/events/mmap.h
+F:	include/trace/events/vma.h
 F:	mm/interval_tree.c
 F:	mm/mincore.c
 F:	mm/mlock.c
diff --git a/include/trace/events/vma.h b/include/trace/events/vma.h
new file mode 100644
index 000000000000..4540fa607f66
--- /dev/null
+++ b/include/trace/events/vma.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vma
+
+#if !defined(_TRACE_VMA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VMA_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mm_insufficient_vma_slots,
+
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+		__field(void *,	mm)
+		__field(int,	vma_count)
+	),
+
+	TP_fast_assign(
+		__entry->mm		= mm;
+		__entry->vma_count	= mm->vma_count;
+	),
+
+	TP_printk("mm=%p vma_count=%d", __entry->mm, __entry->vma_count)
+);
+
+#endif /*  _TRACE_VMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index b4eda47b88d8..4035f49ac963 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -56,6 +56,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmap.h>
+#include <trace/events/vma.h>
 
 #include "internal.h"
 
@@ -374,8 +375,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (!vma_count_remaining(mm))
+	if (!vma_count_remaining(mm)) {
+		trace_mm_insufficient_vma_slots(mm);
 		return -ENOMEM;
+	}
 
 	/*
 	 * addr is returned from get_unmapped_area,
diff --git a/mm/mremap.c b/mm/mremap.c
index 14d35d87e89b..a7f440a3737f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -30,6 +30,8 @@
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 
+#include <trace/events/vma.h>
+
 #include "internal.h"
 
 /* Classify the kind of remap operation being performed. */
@@ -1040,8 +1042,10 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (vma_count_remaining(current->mm) < 4)
+	if (vma_count_remaining(current->mm) < 4) {
+		trace_mm_insufficient_vma_slots(current->mm);
 		return -ENOMEM;
+	}
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
@@ -1817,8 +1821,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * the threshold. In other words, is the current map count + 6 at or
 	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if (vma_count_remaining(current->mm) < 6)
+	if (vma_count_remaining(current->mm) < 6) {
+		trace_mm_insufficient_vma_slots(current->mm);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/mm/vma.c b/mm/vma.c
index b35a4607cde4..6d8cef7f4d5f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -592,8 +592,10 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (!vma_count_remaining(vma->vm_mm))
+	if (!vma_count_remaining(vma->vm_mm)) {
+		trace_mm_insufficient_vma_slots(vma->vm_mm);
 		return -ENOMEM;
+	}
 
 	return __split_vma(vmi, vma, addr, new_below);
 }
@@ -1346,6 +1348,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 */
 		if (vms->end < vms->vma->vm_end &&
 		    !vma_count_remaining(vms->vma->vm_mm)) {
+			trace_mm_insufficient_vma_slots(vms->vma->vm_mm);
 			error = -ENOMEM;
 			goto vma_count_exceeded;
 		}
@@ -2797,8 +2800,10 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (!vma_count_remaining(mm))
+	if (!vma_count_remaining(mm)) {
+		trace_mm_insufficient_vma_slots(mm);
 		return -ENOMEM;
+	}
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index 2f05735ff190..86823ca6857b 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -52,4 +52,6 @@
 
 #include "internal.h"
 
+#include <trace/events/vma.h>
+
 #endif	/* __MM_VMA_INTERNAL_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 84760d901656..57e36d82b4c8 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1493,4 +1493,9 @@ static int vma_count_remaining(const struct mm_struct *mm)
 	return (max_count > vma_count) ? (max_count - vma_count) : 0;
 }
 
+/* Stub for trace_mm_insufficient_vma_slots */
+static inline void trace_mm_insufficient_vma_slots(struct mm_struct *mm)
+{
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0.760.g7b8bcc2412-goog


