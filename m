Return-Path: <linux-fsdevel+bounces-13809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E6873F80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF9C1C20349
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03ED150985;
	Wed,  6 Mar 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmuoIUkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCC14F9CB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749554; cv=none; b=SsDg8Tk0bVLgqmXu1zasJoCdJTq5rA9BzDxoAXZMp/5eMd3oTY4DxpfBsOz7maSqJoj5v4whgLuKP9iKOoqav7PkAhzCQ7MjrEA9WictCWFjlugDMC7RZc1OzFYXNcCmsjKqQT6qoDSq9sM5ILOLWWj+uK8oc041IjV689b1kFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749554; c=relaxed/simple;
	bh=tTmi62O9ihL0HyYaRhS4G+ifrmq/P5mNas9xPIGk56s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0coQyjdDG11CTum6v2lbmERWGJ/qEghYqOyLcjo/u1u0TTCNpkaU/z3+xq4ITEqxASH1tO9/ac+7+QegDyrrio1MlQqQB3jBrU5AUrGn7vKnLV3hG6RcN+Px7sVMpvri7HoQwE0MEeQUUTQtfda5eDt75vcTQCEgVyc/wdZrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmuoIUkJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so11998317276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749549; x=1710354349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUUmukvCnHiMs6J38hCV2D1Gmer1PXmykJXdn9XXZgU=;
        b=ZmuoIUkJPBqdrIN/3FD5JyJakwJDiQMbhEe8e5HP01ZbeSAcMA8BtLnOmqj2Ht5Pql
         bOgKViK7uZRJHopiEtS71a/+QoGDq+qfTH7hNrUmrqgNPevZesOgxUXQ8TcICI17oVF9
         Q6XBFft+u1tTiLGFjJFgHdZ5FHJHrDa7S0+pNJ/+NvUxuDegC+dk3vYlboy5KPpMOXbT
         +u3vKlpz6P62FQsx5P7dGjuIYqcEo1t0ebf51Wd85j6XG40lroCVImerdMUkrJQBGuVk
         GxHqTj7EzZXh5gKVLxnojRtUU6C4fAavT6mtDhJAcRr3wt2RaM/v+/joqWRaTFnUs8A9
         L4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749549; x=1710354349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUUmukvCnHiMs6J38hCV2D1Gmer1PXmykJXdn9XXZgU=;
        b=PzzK0C6xLG+S+gFXtByILc3t+rRB5vCNPMmfnQ9IfnXbiSSIz5VTNgqNl4tH4yRBQ9
         dT1bU+fcs6SsFtwWtulZslxIdekwdrPsCvmo795VQbs7g4u6I2KBR7l/lzDSlShIZVqs
         7wNoCEsGdH7QnNiSPUmKtCVOCvxeWhcvXHd0ZBMEiSQQlMSBB3JBvPJHSCppcI4C6jug
         5NrMauEIgPLYyvmo2+fTsJy9Yo0y9IVBUAej922cPhgSq5strCNqrabikE0UhBDzSVgw
         9wL3WOnkJIdkT+LTVb4vnZ/ncuz44//RpTUP2d0njBCiBLO/71MSqFUBtQhjWkcd/R+I
         s59A==
X-Forwarded-Encrypted: i=1; AJvYcCX4bgqkYyUdsitxx9M2Mn0IgCRAOUIL2LxfLX6V8CMbKzs7C98UqYxGivf0Qsn6HHVL20ji6E1PWL5WTb9Pmt/4yvBqWDRHspi80fFKLA==
X-Gm-Message-State: AOJu0YzM9Yp13CLWKTxXUDGUyPumEmEFIFg8glM8M6Sg+5+zwcia2UMP
	95QsXz7YfYKI8aC8+huchRp1UnkdBeWY9uANEZ1NRp1YHaKYxIS74buHakBiijvQq7CR4KcJ6kr
	Iqw==
X-Google-Smtp-Source: AGHT+IEBo/NBBvAf4BoVrOGimhE8C4YGAKQr5UNfJ7TptyEuCaWEABum2H7J9Iawx0gApOTdXdiUztbnIiA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1891:b0:dcc:54d0:85e0 with SMTP id
 cj17-20020a056902189100b00dcc54d085e0mr4037988ybb.11.1709749549455; Wed, 06
 Mar 2024 10:25:49 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:28 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-31-surenb@google.com>
Subject: [PATCH v5 30/37] mm: vmalloc: Enable memory allocation profiling
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
 mm/nommu.c                                  | 64 +++++++--------
 mm/util.c                                   | 24 +++---
 mm/vmalloc.c                                | 88 ++++++++++-----------
 6 files changed, 135 insertions(+), 105 deletions(-)

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
index 91810b4e9510..af97cacdab37 100644
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
index 8a689b4ff4f9..2f84896a7bcb 100644
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
diff --git a/mm/nommu.c b/mm/nommu.c
index 5ec8f44e7ce9..69a6f3b4d156 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -137,28 +137,28 @@ void vfree(const void *addr)
 }
 EXPORT_SYMBOL(vfree);
 
-void *__vmalloc(unsigned long size, gfp_t gfp_mask)
+void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
 	/*
 	 *  You can't specify __GFP_HIGHMEM with kmalloc() since kmalloc()
 	 * returns only a logical address.
 	 */
-	return kmalloc(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
+	return kmalloc_noprof(size, (gfp_mask | __GFP_COMP) & ~__GFP_HIGHMEM);
 }
-EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(__vmalloc_noprof);
 
-void *__vmalloc_node_range(unsigned long size, unsigned long align,
+void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		unsigned long start, unsigned long end, gfp_t gfp_mask,
 		pgprot_t prot, unsigned long vm_flags, int node,
 		const void *caller)
 {
-	return __vmalloc(size, gfp_mask);
+	return __vmalloc_noprof(size, gfp_mask);
 }
 
-void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
+void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller)
 {
-	return __vmalloc(size, gfp_mask);
+	return __vmalloc_noprof(size, gfp_mask);
 }
 
 static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
@@ -179,11 +179,11 @@ static void *__vmalloc_user_flags(unsigned long size, gfp_t flags)
 	return ret;
 }
 
-void *vmalloc_user(unsigned long size)
+void *vmalloc_user_noprof(unsigned long size)
 {
 	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
 }
-EXPORT_SYMBOL(vmalloc_user);
+EXPORT_SYMBOL(vmalloc_user_noprof);
 
 struct page *vmalloc_to_page(const void *addr)
 {
@@ -217,13 +217,13 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
  *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
-void *vmalloc(unsigned long size)
+void *vmalloc_noprof(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL);
+	return __vmalloc_noprof(size, GFP_KERNEL);
 }
-EXPORT_SYMBOL(vmalloc);
+EXPORT_SYMBOL(vmalloc_noprof);
 
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc);
+void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc_noprof);
 
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
@@ -237,14 +237,14 @@ void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc)
  *	For tight control over page level allocator and protection flags
  *	use __vmalloc() instead.
  */
-void *vzalloc(unsigned long size)
+void *vzalloc_noprof(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_noprof(size, GFP_KERNEL | __GFP_ZERO);
 }
-EXPORT_SYMBOL(vzalloc);
+EXPORT_SYMBOL(vzalloc_noprof);
 
 /**
- * vmalloc_node - allocate memory on a specific node
+ * vmalloc_node_noprof - allocate memory on a specific node
  * @size:	allocation size
  * @node:	numa node
  *
@@ -254,14 +254,14 @@ EXPORT_SYMBOL(vzalloc);
  * For tight control over page level allocator and protection flags
  * use __vmalloc() instead.
  */
-void *vmalloc_node(unsigned long size, int node)
+void *vmalloc_node_noprof(unsigned long size, int node)
 {
-	return vmalloc(size);
+	return vmalloc_noprof(size);
 }
-EXPORT_SYMBOL(vmalloc_node);
+EXPORT_SYMBOL(vmalloc_node_noprof);
 
 /**
- * vzalloc_node - allocate memory on a specific node with zero fill
+ * vzalloc_node_noprof - allocate memory on a specific node with zero fill
  * @size:	allocation size
  * @node:	numa node
  *
@@ -272,27 +272,27 @@ EXPORT_SYMBOL(vmalloc_node);
  * For tight control over page level allocator and protection flags
  * use __vmalloc() instead.
  */
-void *vzalloc_node(unsigned long size, int node)
+void *vzalloc_node_noprof(unsigned long size, int node)
 {
-	return vzalloc(size);
+	return vzalloc_noprof(size);
 }
-EXPORT_SYMBOL(vzalloc_node);
+EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
+ * vmalloc_32_noprof  -  allocate virtually contiguous memory (32bit addressable)
  *	@size:		allocation size
  *
  *	Allocate enough 32bit PA addressable pages to cover @size from the
  *	page level allocator and map them into contiguous kernel virtual space.
  */
-void *vmalloc_32(unsigned long size)
+void *vmalloc_32_noprof(unsigned long size)
 {
-	return __vmalloc(size, GFP_KERNEL);
+	return __vmalloc_noprof(size, GFP_KERNEL);
 }
-EXPORT_SYMBOL(vmalloc_32);
+EXPORT_SYMBOL(vmalloc_32_noprof);
 
 /**
- * vmalloc_32_user - allocate zeroed virtually contiguous 32bit memory
+ * vmalloc_32_user_noprof - allocate zeroed virtually contiguous 32bit memory
  *	@size:		allocation size
  *
  * The resulting memory area is 32bit addressable and zeroed so it can be
@@ -301,15 +301,15 @@ EXPORT_SYMBOL(vmalloc_32);
  * VM_USERMAP is set on the corresponding VMA so that subsequent calls to
  * remap_vmalloc_range() are permissible.
  */
-void *vmalloc_32_user(unsigned long size)
+void *vmalloc_32_user_noprof(unsigned long size)
 {
 	/*
 	 * We'll have to sort out the ZONE_DMA bits for 64-bit,
 	 * but for now this can simply use vmalloc_user() directly.
 	 */
-	return vmalloc_user(size);
+	return vmalloc_user_noprof(size);
 }
-EXPORT_SYMBOL(vmalloc_32_user);
+EXPORT_SYMBOL(vmalloc_32_user_noprof);
 
 void *vmap(struct page **pages, unsigned int count, unsigned long flags, pgprot_t prot)
 {
diff --git a/mm/util.c b/mm/util.c
index 9b8774d8dabb..cb79cf4def6b 100644
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
index 25a8df497255..12caa794abd4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3435,12 +3435,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
 
@@ -3470,9 +3470,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
@@ -3529,10 +3529,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
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
@@ -3615,7 +3615,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 }
 
 /**
- * __vmalloc_node_range - allocate virtually contiguous memory
+ * __vmalloc_node_range_noprof - allocate virtually contiguous memory
  * @size:		  allocation size
  * @align:		  desired alignment
  * @start:		  vm area range start
@@ -3642,7 +3642,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  *
  * Return: the address of the area or %NULL on failure
  */
-void *__vmalloc_node_range(unsigned long size, unsigned long align,
+void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller)
@@ -3771,7 +3771,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 }
 
 /**
- * __vmalloc_node - allocate virtually contiguous memory
+ * __vmalloc_node_noprof - allocate virtually contiguous memory
  * @size:	    allocation size
  * @align:	    desired alignment
  * @gfp_mask:	    flags for the page level allocator
@@ -3789,10 +3789,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
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
@@ -3801,15 +3801,15 @@ void *__vmalloc_node(unsigned long size, unsigned long align,
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
@@ -3823,12 +3823,12 @@ EXPORT_SYMBOL(__vmalloc);
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
@@ -3842,16 +3842,16 @@ EXPORT_SYMBOL(vmalloc);
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
@@ -3863,12 +3863,12 @@ EXPORT_SYMBOL_GPL(vmalloc_huge);
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
@@ -3879,17 +3879,17 @@ EXPORT_SYMBOL(vzalloc);
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
@@ -3901,15 +3901,15 @@ EXPORT_SYMBOL(vmalloc_user);
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
@@ -3919,12 +3919,12 @@ EXPORT_SYMBOL(vmalloc_node);
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
@@ -3939,7 +3939,7 @@ EXPORT_SYMBOL(vzalloc_node);
 #endif
 
 /**
- * vmalloc_32 - allocate virtually contiguous memory (32bit addressable)
+ * vmalloc_32_noprof - allocate virtually contiguous memory (32bit addressable)
  * @size:	allocation size
  *
  * Allocate enough 32bit PA addressable pages to cover @size from the
@@ -3947,15 +3947,15 @@ EXPORT_SYMBOL(vzalloc_node);
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
@@ -3963,14 +3963,14 @@ EXPORT_SYMBOL(vmalloc_32);
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
2.44.0.278.ge034bb2e1d-goog


