Return-Path: <linux-fsdevel+bounces-13793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24B873EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9849B1F22F4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D71474D4;
	Wed,  6 Mar 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfZnAjTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEB13F440
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749518; cv=none; b=QzAEwPteiGgKTeHrlkgpUl0NziN9VsBQWWFuay2que3OXMRItcWZH/tkIHy+HZLHnFT4i3MhPH5tc6U/ycmk3Fx7oZ0j+3ct1KYQvGfAnNTOJ3005BUWVJmNzEDPR6PyoQi6xYUfGxEJuZrRBjux4w+HATmZsAyx3wAJ9Jtb4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749518; c=relaxed/simple;
	bh=3pKe8DymeGCzzCDzC7IH+hBg1k55V6+wJbdT27mHcek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSK4W6f1tDZhkxR1Xw9pQdEjdYLLNVdHtOAIfa7WgWiYB/2sk171CvM/1wAJHJqd4yXCeAt262icRic5NBjRNIypSOnfzFCyz4zHencIyqZAzbDnsluR72FebGq+rkrXdxxbCpRqnqrz7iQWGQrwDtBg/lzPMKpVcRaInwvyX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfZnAjTv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so13633849276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749515; x=1710354315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqAwBcStn3+iWVa0bV8AV7qbDJDX846MDYUJTJVUXBw=;
        b=BfZnAjTv/f13elJsdbe6AVJNr4VoW0mMjFTgWFFFR0Ou8YPOMk2DlrzM5cFBGtsYjg
         82qe/H7xZGEHLFalQoPsUXmz+AQIQFhQlY7UQ+cO/MJdSgb40QXp44oKE55z0MgVhZay
         bgs10xOKzhsFAUWlzGEwXB1dEXFK2tlZP3eBbsdyX/fouxdMgduVEER0pXwjveOLqVOY
         UvCfoCxINyTdp0sGRLDykVCpIvtP77oHaTX1zSLoluRtUqbGhjyv0l7aymb1UHUxnT/E
         VuJNS7SaXyfb8bvn0ty9JhtSflCjMdSpsrf+Kny8ld7EA5Glh+9GU2uYMfAhTn/wjILd
         QfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749515; x=1710354315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqAwBcStn3+iWVa0bV8AV7qbDJDX846MDYUJTJVUXBw=;
        b=Csqs5YLx/rl6Z3Dmka45b8KNlA7PhxcS4KpeTTZJOEuiPKkk4ll6+a4zK4XM/xVsMV
         g6Rfd9FBnLyGGN0Rp4svFHnENZBi/rHRxAOwqsXQSgFfTr95QjoYV6c622MbouxMzbWr
         /UdjyQUqGZvWzkq+8q194X5MceT1IlDAjJWWO/cCdl+LFxG9ZX5ktJaTLgERz0eOPAoV
         orXK4vr+U4qMY6UfpgcCcUpyz6usp2Oc8cqxOXPLa4bYp+ijdEjXOLpfP1YHkpf6j9t3
         hNmtq5snP90HFv4PUj/n+NgyS8Qo1r4Njy7/YrVXQGD4KK/4ce5cpCap3C82bK4QMoKK
         CvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR5QGVJ2WoDKvZpwY10nWAYy1P7/sPaE2ki9cCoQZ1WRy74j0CQ/CLRFgG/X3LcHKdOkv2G0bVPhXlmNcQ5CpUSm6q4uFvXre/3TcAYg==
X-Gm-Message-State: AOJu0YxJx/VaKshmmex1h/LtgGcgqUhNylo3bH6pvVbxywMHoUh5Q3Yn
	CdSu0puSAzsY5lnZFggHjJPHgUlMJcCYSnmRAB0dBqPer0HSmYHC3St2rx293GYwgM6EyN+rTlA
	cAw==
X-Google-Smtp-Source: AGHT+IHUeBGtAOO+/l11NzJyIxqA9udwD8w5OmuvXdYK78869+3pCDSzsZpyxOUQHcMci8NQK2ebtmqhDyo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1744:b0:dcf:6b50:9bd7 with SMTP id
 bz4-20020a056902174400b00dcf6b509bd7mr3993743ybb.7.1709749514977; Wed, 06 Mar
 2024 10:25:14 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:12 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-15-surenb@google.com>
Subject: [PATCH v5 14/37] lib: introduce support for page allocation tagging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce helper functions to easily instrument page allocators by
storing a pointer to the allocation tag associated with the code that
allocated the page in a page_ext field.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/page_ext.h    |  1 -
 include/linux/pgalloc_tag.h | 78 +++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           |  1 +
 lib/alloc_tag.c             | 17 ++++++++
 mm/mm_init.c                |  1 +
 mm/page_alloc.c             |  4 ++
 mm/page_ext.c               |  4 ++
 7 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pgalloc_tag.h

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index be98564191e6..07e0656898f9 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 #include <linux/stacktrace.h>
-#include <linux/stackdepot.h>
 
 struct pglist_data;
 
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
new file mode 100644
index 000000000000..b49ab955300f
--- /dev/null
+++ b/include/linux/pgalloc_tag.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * page allocation tagging
+ */
+#ifndef _LINUX_PGALLOC_TAG_H
+#define _LINUX_PGALLOC_TAG_H
+
+#include <linux/alloc_tag.h>
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+#include <linux/page_ext.h>
+
+extern struct page_ext_operations page_alloc_tagging_ops;
+extern struct page_ext *page_ext_get(struct page *page);
+extern void page_ext_put(struct page_ext *page_ext);
+
+static inline union codetag_ref *codetag_ref_from_page_ext(struct page_ext *page_ext)
+{
+	return (void *)page_ext + page_alloc_tagging_ops.offset;
+}
+
+static inline struct page_ext *page_ext_from_codetag_ref(union codetag_ref *ref)
+{
+	return (void *)ref - page_alloc_tagging_ops.offset;
+}
+
+/* Should be called only if mem_alloc_profiling_enabled() */
+static inline union codetag_ref *get_page_tag_ref(struct page *page)
+{
+	if (page) {
+		struct page_ext *page_ext = page_ext_get(page);
+
+		if (page_ext)
+			return codetag_ref_from_page_ext(page_ext);
+	}
+	return NULL;
+}
+
+static inline void put_page_tag_ref(union codetag_ref *ref)
+{
+	page_ext_put(page_ext_from_codetag_ref(ref));
+}
+
+static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
+				   unsigned int order)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			alloc_tag_add(ref, task->alloc_tag, PAGE_SIZE << order);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+
+static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			alloc_tag_sub(ref, PAGE_SIZE << order);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+
+#else /* CONFIG_MEM_ALLOC_PROFILING */
+
+static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
+				   unsigned int order) {}
+static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
+#endif /* _LINUX_PGALLOC_TAG_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0dd6ab986246..3e06320474d4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -978,6 +978,7 @@ config MEM_ALLOC_PROFILING
 	depends on PROC_FS
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
+	select PAGE_EXTENSION
 	help
 	  Track allocation source code and record total allocation size
 	  initiated at that code location. The mechanism can be used to track
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index f09c8a422bc2..cb5adec4b2e2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -3,6 +3,7 @@
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/page_ext.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
@@ -115,6 +116,22 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
+static __init bool need_page_alloc_tagging(void)
+{
+	return true;
+}
+
+static __init void init_page_alloc_tagging(void)
+{
+}
+
+struct page_ext_operations page_alloc_tagging_ops = {
+	.size = sizeof(union codetag_ref),
+	.need = need_page_alloc_tagging,
+	.init = init_page_alloc_tagging,
+};
+EXPORT_SYMBOL(page_alloc_tagging_ops);
+
 static struct ctl_table memory_allocation_profiling_sysctls[] = {
 	{
 		.procname	= "mem_profiling",
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..2fd9bf044a79 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -24,6 +24,7 @@
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
+#include <linux/stackdepot.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 16241906a368..9a91c8074556 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -54,6 +54,7 @@
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
+#include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 		/* Do not let hwpoison pages hit pcplists/buddy */
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
+		pgalloc_tag_sub(page, order);
 		return false;
 	}
 
@@ -1140,6 +1142,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
+	pgalloc_tag_sub(page, order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -1533,6 +1536,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+	pgalloc_tag_add(page, current, order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..3c58fe8a24df 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -10,6 +10,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
+#include <linux/pgalloc_tag.h>
 
 /*
  * struct page extension
@@ -82,6 +83,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	&page_alloc_tagging_ops,
+#endif
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
-- 
2.44.0.278.ge034bb2e1d-goog


