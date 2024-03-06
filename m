Return-Path: <linux-fsdevel+bounces-13808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD12873F78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2060C1F221B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7514F9F4;
	Wed,  6 Mar 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfLRKoKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99213F44E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749551; cv=none; b=M5Qds+zw9VZ/6YSbpjT3rpjQ/JV4WApHAX9Ep8AaWQoYTJNjDnXYFeyh+gF9u00Xu28w5zCenoUVHUT/KDeaxUyYdSiC8cNl6A9CZSCdpiv2Twf+A67FPBHx1vtqEbkDypMrzTVT5ptIQHdQb4DZPy+PS6fXEX1CIH927ppapt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749551; c=relaxed/simple;
	bh=werADFkk5SY7hZORWBY8KwUdwN4xoWBXtI7FULJOr3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iz5lv1XBYSPAZZdDYTmmmZ+l81wkjAc5uX2CqaefwW81M4lUz/y8xioJoGA2uOYxuxJJ9hWxfy/SAG3thYBhskingGI1p7xPEHuytsTVMImeBdtPZ/uEsLA/p9CPBIvMzXUchWF+fp8n/6xpMlnfki5PAedp7bBgcpUy78q2fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfLRKoKn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so10099837276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749548; x=1710354348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxoUvKCzEXXEdeRbYveeEvTG3TXaR8hRTTgS3Q5TXls=;
        b=ZfLRKoKnNgIcUD9jzoRUEeTwd0HeVyXWe/UI4GnYPAktYpKlbPuRl0k2bifovq4yzp
         xt3ee5Qwwm82XdHhES2t9tpEH+9NdazkxVIQeUkx2oZQ5ya1TYf/3CXh2wPLGT2OVwal
         IVzkknH8zg64n2hc2gqLAGvWnz2JH9ercdOgKSwmBB3VsBE3VKr7f4m3Y1maW95noxtL
         Uri14zUQqE6fzSukjTwZcKa4DLqZ3IRHhnvKvEvYuEjfKzgIqtCKVZ8bi178HqdN/Fg5
         0mHsBl23BQ4LgVMN3Rns/Eg3ZUkbhbjqowqud6Ht0ht9EGLwvhDIyFD7/VtD1QE5k4Ip
         eSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749548; x=1710354348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxoUvKCzEXXEdeRbYveeEvTG3TXaR8hRTTgS3Q5TXls=;
        b=UN1lJVlMt9qbPuk+NwrzRFYbjLNNKvEsP58ErklnP8NfsdeHktuIgQfRUeS7jB2Nfc
         OyECYMoSzJspUtpV2SIOY8K1h5T6JtY/8LylJRCSIlhWYnUHNjGMrb3b6gT8F4R7htfp
         UAdWy6e83iNiljVanwpiJHvd/JtDrOIyCZ4DI/REagbY08X3lOmaCHp/fS57+rC95Qz8
         cvjVSC+NRt7EkXd0V0ViKhGNju98JjFlSFtrW41ZTS9E/PCcD1cwtrL1xC2xcihO6VPw
         3Xrhp2Fr5MDJwcK9USukVCY3G9hyDwXbbyypqVoXQ54AF+oW7Ud++Ts0OIMl6xWWIfHK
         koHw==
X-Forwarded-Encrypted: i=1; AJvYcCXy86aeSqNwtdpf8rRyqri9J75NAJPlUFUPxI2T+roXg6BaNjVfuuXDEe/qBCa53djEsooTyackmnpcUTiJn8qTHHadHiut1qERqE1YrQ==
X-Gm-Message-State: AOJu0Yza0QNmWAvEWbn/XVSBH35aaencR+62ZwF/4BPehYoBpt/RzMhN
	T81FXurkBuO8XO307LhjXMxdcKIBDXNja8jGzImlOMaOR0eg6F31CInPSqTKFBvDRofIoNVGgw8
	cwQ==
X-Google-Smtp-Source: AGHT+IGiM8eS9ZI/wjAptyo7knt1Z9PGL0v/iP+d+T+GDYu7/A3uBJqs/ZKhwzkikTnjE1CsYg7wV6eZ1JE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:10c1:b0:dcd:59a5:7545 with SMTP id
 w1-20020a05690210c100b00dcd59a57545mr531845ybu.10.1709749547368; Wed, 06 Mar
 2024 10:25:47 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:27 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-30-surenb@google.com>
Subject: [PATCH v5 29/37] mm: percpu: enable per-cpu allocation tagging
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

Redefine __alloc_percpu, __alloc_percpu_gfp and __alloc_reserved_percpu
to record allocations and deallocations done by these functions.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/percpu.h | 23 ++++++++++-----
 mm/percpu.c            | 64 +++++-------------------------------------
 2 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 62b5eb45bd89..e54921c79c9a 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 
+#include <linux/alloc_tag.h>
 #include <linux/mmdebug.h>
 #include <linux/preempt.h>
 #include <linux/smp.h>
@@ -9,6 +10,7 @@
 #include <linux/pfn.h>
 #include <linux/init.h>
 #include <linux/cleanup.h>
+#include <linux/sched.h>
 
 #include <asm/percpu.h>
 
@@ -125,7 +127,6 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn);
 #endif
 
-extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align) __alloc_size(1);
 extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
@@ -133,14 +134,16 @@ extern bool is_kernel_percpu_address(unsigned long addr);
 extern void __init setup_per_cpu_areas(void);
 #endif
 
-extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
-extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
-extern void free_percpu(void __percpu *__pdata);
+extern void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
+				   gfp_t gfp) __alloc_size(1);
 extern size_t pcpu_alloc_size(void __percpu *__pdata);
 
-DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
-
-extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
+#define __alloc_percpu_gfp(_size, _align, _gfp)				\
+	alloc_hooks(pcpu_alloc_noprof(_size, _align, false, _gfp))
+#define __alloc_percpu(_size, _align)					\
+	alloc_hooks(pcpu_alloc_noprof(_size, _align, false, GFP_KERNEL))
+#define __alloc_reserved_percpu(_size, _align)				\
+	alloc_hooks(pcpu_alloc_noprof(_size, _align, true, GFP_KERNEL))
 
 #define alloc_percpu_gfp(type, gfp)					\
 	(typeof(type) __percpu *)__alloc_percpu_gfp(sizeof(type),	\
@@ -149,6 +152,12 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
 
+extern void free_percpu(void __percpu *__pdata);
+
+DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
+
+extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
+
 extern unsigned long pcpu_nr_pages(void);
 
 #endif /* __LINUX_PERCPU_H */
diff --git a/mm/percpu.c b/mm/percpu.c
index 90e9e4004ac9..dd7eeb370134 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1726,7 +1726,7 @@ static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t s
 #endif
 
 /**
- * pcpu_alloc - the percpu allocator
+ * pcpu_alloc_noprof - the percpu allocator
  * @size: size of area to allocate in bytes
  * @align: alignment of area (max PAGE_SIZE)
  * @reserved: allocate from the reserved chunk if available
@@ -1740,7 +1740,7 @@ static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t s
  * RETURNS:
  * Percpu pointer to the allocated area on success, NULL on failure.
  */
-static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
+void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 				 gfp_t gfp)
 {
 	gfp_t pcpu_gfp;
@@ -1907,6 +1907,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
+	pcpu_alloc_tag_alloc_hook(chunk, off, size);
+
 	return ptr;
 
 fail_unlock:
@@ -1935,61 +1937,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	return NULL;
 }
-
-/**
- * __alloc_percpu_gfp - allocate dynamic percpu area
- * @size: size of area to allocate in bytes
- * @align: alignment of area (max PAGE_SIZE)
- * @gfp: allocation flags
- *
- * Allocate zero-filled percpu area of @size bytes aligned at @align.  If
- * @gfp doesn't contain %GFP_KERNEL, the allocation doesn't block and can
- * be called from any context but is a lot more likely to fail. If @gfp
- * has __GFP_NOWARN then no warning will be triggered on invalid or failed
- * allocation requests.
- *
- * RETURNS:
- * Percpu pointer to the allocated area on success, NULL on failure.
- */
-void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp)
-{
-	return pcpu_alloc(size, align, false, gfp);
-}
-EXPORT_SYMBOL_GPL(__alloc_percpu_gfp);
-
-/**
- * __alloc_percpu - allocate dynamic percpu area
- * @size: size of area to allocate in bytes
- * @align: alignment of area (max PAGE_SIZE)
- *
- * Equivalent to __alloc_percpu_gfp(size, align, %GFP_KERNEL).
- */
-void __percpu *__alloc_percpu(size_t size, size_t align)
-{
-	return pcpu_alloc(size, align, false, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(__alloc_percpu);
-
-/**
- * __alloc_reserved_percpu - allocate reserved percpu area
- * @size: size of area to allocate in bytes
- * @align: alignment of area (max PAGE_SIZE)
- *
- * Allocate zero-filled percpu area of @size bytes aligned at @align
- * from reserved percpu area if arch has set it up; otherwise,
- * allocation is served from the same dynamic area.  Might sleep.
- * Might trigger writeouts.
- *
- * CONTEXT:
- * Does GFP_KERNEL allocation.
- *
- * RETURNS:
- * Percpu pointer to the allocated area on success, NULL on failure.
- */
-void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
-{
-	return pcpu_alloc(size, align, true, GFP_KERNEL);
-}
+EXPORT_SYMBOL_GPL(pcpu_alloc_noprof);
 
 /**
  * pcpu_balance_free - manage the amount of free chunks
@@ -2328,6 +2276,8 @@ void free_percpu(void __percpu *ptr)
 	spin_lock_irqsave(&pcpu_lock, flags);
 	size = pcpu_free_area(chunk, off);
 
+	pcpu_alloc_tag_free_hook(chunk, off, size);
+
 	pcpu_memcg_free_hook(chunk, off, size);
 
 	/*
-- 
2.44.0.278.ge034bb2e1d-goog


