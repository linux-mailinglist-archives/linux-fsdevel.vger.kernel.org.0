Return-Path: <linux-fsdevel+bounces-11220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0D852096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A3F1F230E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE45D916;
	Mon, 12 Feb 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx+EcmrU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D85D495
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774039; cv=none; b=nZIiNfYGpTQgAaI0Lj43omRvyFBYdWM4v/alf7A5Pw6b4Vu6vaHFhnGIuTCARXtG+fwkbyXlJ5oFWhIvABH225hzkwXmxE88L77C67Q56S4H2r2kFzmgg2f7PrjXL13qLh2eb9aq8ez6Pg/KJGXiCo3pavor4tN6IxKICld2hTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774039; c=relaxed/simple;
	bh=ttEGIhrFvH2c/OJV9eSjoMC8GLBsvFW1OqwaAhSEK2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JvnpgVfnrEPKoQ02c53hpuwhn9qzEJ6rKJgV7pG6wrvMcDjJxZ2XhxPKAF3TODZVelo9KhjjTpmxZf+Rr8Vu1EgkHwo5o/EX+x55XW2/x5uaH2wb2IfQbQQvR6dbCzzAT9uHcQEdunyElHlBWNQgXOUBv6et0UQmlmx3SehbtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx+EcmrU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso6232212276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774035; x=1708378835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4cusAtaCctZ7K3pFyusQLmD/gTJ9EMe3N2uM61S6cPw=;
        b=Xx+EcmrUZOVGqqJm/gHONpptE8no30vM1Ulf4XbGW5HKxAITLkKs/0oIS7yhL2K89F
         /Q6wEfi1KSIngscU6uPZr7lb06fwr2HarAmq4f1nGqwSw9fgs6vne99+YakJ/HJO2D4z
         XCW/Y7URvu4TmlG77bTlcjAp/5/gSMKtqtSP0CGZt8IT8MmF7SGUWMCVmi8jNTUtpe6B
         n/+8PPhDBHhUua8RViCzvxw9qRs6d8tzQ1zmHwP1kN1Q8+ZzLuZ+ESZ5OEFmezENni70
         szWsXOtrSUlQvwDDT6GSAOM70zk1e60E5vOWgzJ8imCwv0wXowANL3GKmqjzxUWfbP1U
         W0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774035; x=1708378835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cusAtaCctZ7K3pFyusQLmD/gTJ9EMe3N2uM61S6cPw=;
        b=edvxPQV7N/1UX6BQzjF/ZIFP++h/YrCA0GH5mTh7wVTmC5P0ReInfrQlbBXVKD57cJ
         xatEjMgwT/DvHqWooFyT4kQB2Qjh5b473TcjkTK98HkOGoUnAcYv3UTBvcqlbBPsqRTK
         6SecB4aBC8L3pIsQA5hY3h1ybFecrJ3yP4Ewe0qP3WbhZEBUUosw3joA4gdL6LcaCWtc
         A60GxN0e/mXwnZ0msqvNMF8C/I67eRUsMZJtDPAkaOltLAvuYZSh4wsRg7iVR1Hb77/3
         ejEeONo1tip+0p7xQmnvhuppUsZY9hLfHWiOL3pfRbCaTd8XXNGxko0IOtSny96qLgUj
         xOMw==
X-Gm-Message-State: AOJu0YydPb4F41CHx/weChrSXIqGi+8ojzkfiNwrOYsqUryI0CsynGbs
	emRe3YwY0Ri4rHoBKGOEg8qQqXHpeA6OXYsQ78QRclMcUft+zUEwGvXS45eBJnb+ac3lewbYe+/
	9pw==
X-Google-Smtp-Source: AGHT+IF2lAJfAQMKJa+dwJUeCTuXNowNKuBbS7XvK2jtWHY6jXD0O3VIO4SDQSUEkESVpV0NowOi7s2lO00=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:102e:b0:dc6:e884:2342 with SMTP id
 x14-20020a056902102e00b00dc6e8842342mr148128ybt.5.1707774035250; Mon, 12 Feb
 2024 13:40:35 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:15 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-30-surenb@google.com>
Subject: [PATCH v3 29/35] mm: vmalloc: Enable memory allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

This wrapps all external vmalloc allocation functions with the
alloc_hooks() wrapper, and switches internal allocations to _noprof
variants where appropriate, for the new memory allocation profiling
feature.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c |  2 +-
 include/linux/vmalloc.h                     | 60 ++++++++++----
 kernel/kallsyms_selftest.c                  |  2 +-
 mm/util.c                                   | 24 +++---
 mm/vmalloc.c                                | 88 ++++++++++-----------
 5 files changed, 103 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index bb12644fd033..3e2899ad8517 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -205,7 +205,7 @@ static ia_css_ptr __hmm_alloc(size_t bytes, enum hmm_bo_type type,
 	}
 
 	dev_dbg(atomisp_dev, "pages: 0x%08x (%zu bytes), type: %d, vmalloc %p\n",
-		bo->start, bytes, type, vmalloc);
+		bo->start, bytes, type, vmalloc_noprof);
 
 	return bo->start;
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..106d78e75606 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_VMALLOC_H
 #define _LINUX_VMALLOC_H
 
+#include <linux/alloc_tag.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -137,26 +139,54 @@ extern unsigned long vmalloc_nr_pages(void);
 static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 #endif
 
-extern void *vmalloc(unsigned long size) __alloc_size(1);
-extern void *vzalloc(unsigned long size) __alloc_size(1);
-extern void *vmalloc_user(unsigned long size) __alloc_size(1);
-extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
-extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
-extern void *vmalloc_32(unsigned long size) __alloc_size(1);
-extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
-extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
-extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
+extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
+#define vmalloc(...)		alloc_hooks(vmalloc_noprof(__VA_ARGS__))
+
+extern void *vzalloc_noprof(unsigned long size) __alloc_size(1);
+#define vzalloc(...)		alloc_hooks(vzalloc_noprof(__VA_ARGS__))
+
+extern void *vmalloc_user_noprof(unsigned long size) __alloc_size(1);
+#define vmalloc_user(...)	alloc_hooks(vmalloc_user_noprof(__VA_ARGS__))
+
+extern void *vmalloc_node_noprof(unsigned long size, int node) __alloc_size(1);
+#define vmalloc_node(...)	alloc_hooks(vmalloc_node_noprof(__VA_ARGS__))
+
+extern void *vzalloc_node_noprof(unsigned long size, int node) __alloc_size(1);
+#define vzalloc_node(...)	alloc_hooks(vzalloc_node_noprof(__VA_ARGS__))
+
+extern void *vmalloc_32_noprof(unsigned long size) __alloc_size(1);
+#define vmalloc_32(...)		alloc_hooks(vmalloc_32_noprof(__VA_ARGS__))
+
+extern void *vmalloc_32_user_noprof(unsigned long size) __alloc_size(1);
+#define vmalloc_32_user(...)	alloc_hooks(vmalloc_32_user_noprof(__VA_ARGS__))
+
+extern void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+#define __vmalloc(...)		alloc_hooks(__vmalloc_noprof(__VA_ARGS__))
+
+extern void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller) __alloc_size(1);
-void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
+#define __vmalloc_node_range(...)	alloc_hooks(__vmalloc_node_range_noprof(__VA_ARGS__))
+
+void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+#define __vmalloc_node(...)	alloc_hooks(__vmalloc_node_noprof(__VA_ARGS__))
+
+void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+#define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
+
+extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
+#define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
+
+extern void *vmalloc_array_noprof(size_t n, size_t size) __alloc_size(1, 2);
+#define vmalloc_array(...)	alloc_hooks(vmalloc_array_noprof(__VA_ARGS__))
+
+extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
+#define __vcalloc(...)		alloc_hooks(__vcalloc_noprof(__VA_ARGS__))
 
-extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
-extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
-extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
-extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
+extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
+#define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index b4cac76ea5e9..3ea9be364e32 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -82,7 +82,7 @@ static struct test_item test_items[] = {
 	ITEM_FUNC(kallsyms_test_func_static),
 	ITEM_FUNC(kallsyms_test_func),
 	ITEM_FUNC(kallsyms_test_func_weak),
-	ITEM_FUNC(vmalloc),
+	ITEM_FUNC(vmalloc_noprof),
 	ITEM_FUNC(vfree),
 #ifdef CONFIG_KALLSYMS_ALL
 	ITEM_DATA(kallsyms_test_var_bss_static),
diff --git a/mm/util.c b/mm/util.c
index 291f7945190f..19c90036d3cc 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -639,7 +639,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 	 * about the resulting pointer, and cannot play
 	 * protection games.
 	 */
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
@@ -698,12 +698,12 @@ void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flag
 EXPORT_SYMBOL(kvrealloc_noprof);
 
 /**
- * __vmalloc_array - allocate memory for a virtually contiguous array.
+ * __vmalloc_array_noprof - allocate memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
+void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
@@ -711,18 +711,18 @@ void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
 		return NULL;
 	return __vmalloc(bytes, flags);
 }
-EXPORT_SYMBOL(__vmalloc_array);
+EXPORT_SYMBOL(__vmalloc_array_noprof);
 
 /**
- * vmalloc_array - allocate memory for a virtually contiguous array.
+ * vmalloc_array_noprof - allocate memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  */
-void *vmalloc_array(size_t n, size_t size)
+void *vmalloc_array_noprof(size_t n, size_t size)
 {
 	return __vmalloc_array(n, size, GFP_KERNEL);
 }
-EXPORT_SYMBOL(vmalloc_array);
+EXPORT_SYMBOL(vmalloc_array_noprof);
 
 /**
  * __vcalloc - allocate and zero memory for a virtually contiguous array.
@@ -730,22 +730,22 @@ EXPORT_SYMBOL(vmalloc_array);
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-void *__vcalloc(size_t n, size_t size, gfp_t flags)
+void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
 {
 	return __vmalloc_array(n, size, flags | __GFP_ZERO);
 }
-EXPORT_SYMBOL(__vcalloc);
+EXPORT_SYMBOL(__vcalloc_noprof);
 
 /**
- * vcalloc - allocate and zero memory for a virtually contiguous array.
+ * vcalloc_noprof - allocate and zero memory for a virtually contiguous array.
  * @n: number of elements.
  * @size: element size.
  */
-void *vcalloc(size_t n, size_t size)
+void *vcalloc_noprof(size_t n, size_t size)
 {
 	return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
 }
-EXPORT_SYMBOL(vcalloc);
+EXPORT_SYMBOL(vcalloc_noprof);
 
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..5239f2c9ecae 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3025,12 +3025,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
+				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
 							nr_pages_request,
 							pages + nr_allocated);
 
 			else
-				nr = alloc_pages_bulk_array_node(bulk_gfp, nid,
+				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -3060,9 +3060,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages(alloc_gfp, order);
+			page = alloc_pages_noprof(alloc_gfp, order);
 		else
-			page = alloc_pages_node(nid, alloc_gfp, order);
+			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
 		if (unlikely(!page)) {
 			if (!nofail)
 				break;
@@ -3119,10 +3119,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
-		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
+		area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
 					area->caller);
 	} else {
-		area->pages = kmalloc_node(array_size, nested_gfp, node);
+		area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
 	}
 
 	if (!area->pages) {
@@ -3205,7 +3205,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 }
 
 /**
- * __vmalloc_node_range - allocate virtually contiguous memory
+ * __vmalloc_node_range_noprof - allocate virtually contiguous memory
  * @size:		  allocation size
  * @align:		  desired alignment
  * @start:		  vm area range start
@@ -3232,7 +3232,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  *
  * Return: the address of the area or %NULL on failure
  */
-void *__vmalloc_node_range(unsigned long size, unsigned long align,
+void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller)
@@ -3361,7 +3361,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 }
 
 /**
- * __vmalloc_node - allocate virtually contiguous memory
+ * __vmalloc_node_noprof - allocate virtually contiguous memory
  * @size:	    allocation size
  * @align:	    desired alignment
  * @gfp_mask:	    flags for the page level allocator
@@ -3379,10 +3379,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *__vmalloc_node(unsigned long size, unsigned long align,
+void *__vmalloc_node_noprof(unsigned long size, unsigned long align,
 			    gfp_t gfp_mask, int node, const void *caller)
 {
-	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
 				gfp_mask, PAGE_KERNEL, 0, node, caller);
 }
 /*
@@ -3391,15 +3391,15 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
  * than that.
  */
 #ifdef CONFIG_TEST_VMALLOC_MODULE
-EXPORT_SYMBOL_GPL(__vmalloc_node);
+EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 #endif
 
-void *__vmalloc(unsigned long size, gfp_t gfp_mask)
+void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node(size, 1, gfp_mask, NUMA_NO_NODE,
+	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
-EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(__vmalloc_noprof);
 
 /**
  * vmalloc - allocate virtually contiguous memory
@@ -3413,12 +3413,12 @@ EXPORT_SYMBOL(__vmalloc);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc(unsigned long size)
+void *vmalloc_noprof(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
+	return __vmalloc_node_noprof(size, 1, GFP_KERNEL, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_noprof);
 
 /**
  * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
@@ -3432,16 +3432,16 @@ EXPORT_SYMBOL(vmalloc);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
 				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 				    NUMA_NO_NODE, __builtin_return_address(0));
 }
-EXPORT_SYMBOL_GPL(vmalloc_huge);
+EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
 
 /**
- * vzalloc - allocate virtually contiguous memory with zero fill
+ * vzalloc_noprof - allocate virtually contiguous memory with zero fill
  * @size:    allocation size
  *
  * Allocate enough pages to cover @size from the page level
@@ -3453,12 +3453,12 @@ EXPORT_SYMBOL_GPL(vmalloc_huge);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vzalloc(unsigned long size)
+void *vzalloc_noprof(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+	return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
-EXPORT_SYMBOL(vzalloc);
+EXPORT_SYMBOL(vzalloc_noprof);
 
 /**
  * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
@@ -3469,17 +3469,17 @@ EXPORT_SYMBOL(vzalloc);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_user(unsigned long size)
+void *vmalloc_user_noprof(unsigned long size)
 {
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
 				    VM_USERMAP, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_user);
+EXPORT_SYMBOL(vmalloc_user_noprof);
 
 /**
- * vmalloc_node - allocate memory on a specific node
+ * vmalloc_node_noprof - allocate memory on a specific node
  * @size:	  allocation size
  * @node:	  numa node
  *
@@ -3491,15 +3491,15 @@ EXPORT_SYMBOL(vmalloc_user);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_node(unsigned long size, int node)
+void *vmalloc_node_noprof(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, node,
+	return __vmalloc_node_noprof(size, 1, GFP_KERNEL, node,
 			__builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_node);
+EXPORT_SYMBOL(vmalloc_node_noprof);
 
 /**
- * vzalloc_node - allocate memory on a specific node with zero fill
+ * vzalloc_node_noprof - allocate memory on a specific node with zero fill
  * @size:	allocation size
  * @node:	numa node
  *
@@ -3509,12 +3509,12 @@ EXPORT_SYMBOL(vmalloc_node);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vzalloc_node(unsigned long size, int node)
+void *vzalloc_node_noprof(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
+	return __vmalloc_node_noprof(size, 1, GFP_KERNEL | __GFP_ZERO, node,
 				__builtin_return_address(0));
 }
-EXPORT_SYMBOL(vzalloc_node);
+EXPORT_SYMBOL(vzalloc_node_noprof);
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
@@ -3529,7 +3529,7 @@ EXPORT_SYMBOL(vzalloc_node);
 #endif
 
 /**
- * vmalloc_32 - allocate virtually contiguous memory (32bit addressable)
+ * vmalloc_32_noprof - allocate virtually contiguous memory (32bit addressable)
  * @size:	allocation size
  *
  * Allocate enough 32bit PA addressable pages to cover @size from the
@@ -3537,15 +3537,15 @@ EXPORT_SYMBOL(vzalloc_node);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_32(unsigned long size)
+void *vmalloc_32_noprof(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
+	return __vmalloc_node_noprof(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
 			__builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_32);
+EXPORT_SYMBOL(vmalloc_32_noprof);
 
 /**
- * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
+ * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
  * @size:	     allocation size
  *
  * The resulting memory area is 32bit addressable and zeroed so it can be
@@ -3553,14 +3553,14 @@ EXPORT_SYMBOL(vmalloc_32);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_32_user(unsigned long size)
+void *vmalloc_32_user_noprof(unsigned long size)
 {
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range_noprof(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
 				    VM_USERMAP, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_32_user);
+EXPORT_SYMBOL(vmalloc_32_user_noprof);
 
 /*
  * Atomically zero bytes in the iterator.
-- 
2.43.0.687.g38aa6559b0-goog


