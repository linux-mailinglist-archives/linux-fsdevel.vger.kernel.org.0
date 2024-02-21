Return-Path: <linux-fsdevel+bounces-12336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B085E81D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32411C21B63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A975150990;
	Wed, 21 Feb 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1I6GY13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32515150991
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544511; cv=none; b=aI4H/x2iUOf53A65SkLFEXPYNQlqD401YRME86mIxmD1CEfnAiM6+HRzRI+hooGAVzh3msEeVxufgWm2kQiB+Z0FPVfdXWju/MPKQtdRcMk3GXGE8kmksGMd/f/BrqYQaD9R9pbXBhfRhhUd5IutJeAauCFwz7/yOlX2JxmO3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544511; c=relaxed/simple;
	bh=JzustN1IQYo+xt+L1yce+RwYFqWHkQ5NLkdXnO1NV9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihmgYNeu6+bV0+BIm3tcYvLfaqf368kSPoTr/Ck2ohqEm74q7KNVE+iW8x9fjpVipmbEu7saupvstEM8F2nBpQQvhbseOd1BxpTVX7wVlsBKSXX6Xuzu/MW2Qj+dSL0v5Q5bdqbYmW/2LEnN5Orv/usTfcQuZ9PULucorL+vjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1I6GY13; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso11860858276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544507; x=1709149307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9bBzslVXKxus/Eql90kYDF/kN1EZHGoql92bbefNg4=;
        b=p1I6GY130+6mt5R54vIM3D176BQSOyENWZalPuMuzEpQLeuT1ox+6TAmTqgvZDAa/X
         s1gSAyzoK8xu0Mb3E2UPaJfhNg9FcDTMvzlPPVtuC8TYCS4FYLUNY+Zg6uZy53D3tcpj
         7PJZ40V+xMsSe0+bKxY9Y2OL3m0TX/MQ+tydv4RvhDFPNXDzCWgn9wRnhluk5R9Jc1u6
         1r9FvfpjQ3KoPMkWBelBnRcWZ9Eq91KuEdjVbeC+OPlT9vLYPDZPPFiWd+LLdVspbU2c
         +1tbW/bJDa1NrNR3bWGxv1JMG0OoI5+fpO3tHqYbnUFkXLqVWKfPlQYd91o076MNpoOu
         Fydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544507; x=1709149307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9bBzslVXKxus/Eql90kYDF/kN1EZHGoql92bbefNg4=;
        b=qqJf+AGuOyiactLNbNqJRdIbiqDzzaeW3yBDFHajjUtsIXE+mwD1I4sGfxM8ZNZm4T
         VbH3CQ50fUWC86Xb24SFUi4C5dTMcdVCV4v98nNxLiIohszMW6xCmoHDFoGSsrAxz6Bb
         RB0p45bY38WSLCGoqZFYoSfGx6+olPjIuCreehJ4URahab28DzKXnZqfIjIGc23T6Ogz
         i9CWaBvTNRYJouohGUtinNj76Scyg9coCJ++Al5bzyGAcMVwdSrVnsmwbWoUNaIGwzCt
         EOgmsNqvL/C6gg6GkrlI3esHfOTiPHScqyD/7z1sU0Y+gLVKqlD8WBA74n55QHel6UNn
         mp6w==
X-Forwarded-Encrypted: i=1; AJvYcCUoCvDHnzEN1C6baPOvSpJuDqNGKgKNfrIeAGQTFMSBuTqdOHd1FDzICdR6T14CjI3u5k2uMGhd11SmKcjEg08IqosUkdTuUTbHbofdNw==
X-Gm-Message-State: AOJu0YxRfWVn/jpR8vjPs2KOI6eLQjQLC5IrTPsixE/Nbw30lR8k9r0+
	nQWfH147sfEY4Eu/PC/tNzwWcrKlPIqe38twiu8OdbKqwF/DLyIyTRQWyfkw4BpV5D8pSYNNnxl
	wqQ==
X-Google-Smtp-Source: AGHT+IEGw5nl2ExuOLala9gTYXJk9n6bTpGvYj0ETG5ZayMmW5LwulYLaI6C/wEhMG33SuMmfk11BFRCzc0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:ade6:0:b0:dc7:42:ecd with SMTP id
 d38-20020a25ade6000000b00dc700420ecdmr69488ybe.6.1708544507041; Wed, 21 Feb
 2024 11:41:47 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:36 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-24-surenb@google.com>
Subject: [PATCH v4 23/36] mm/slab: enable slab allocation tagging for kmalloc
 and friends
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

Redefine kmalloc, krealloc, kzalloc, kcalloc, etc. to record allocations
and deallocations done by these functions.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h |   5 +-
 include/linux/slab.h           | 169 +++++++++++++++++----------------
 include/linux/string.h         |   4 +-
 mm/slab_common.c               |   6 +-
 mm/slub.c                      |  52 +++++-----
 mm/util.c                      |  20 ++--
 6 files changed, 130 insertions(+), 126 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 89a6888f2f9e..55f66bd8a366 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -697,9 +697,9 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	return __real_memchr_inv(p, c, size);
 }
 
-extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup)
+extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup_noprof)
 								    __realloc_size(2);
-__FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
+__FORTIFY_INLINE void *kmemdup_noprof(const void * const POS0 p, size_t size, gfp_t gfp)
 {
 	const size_t p_size = __struct_size(p);
 
@@ -709,6 +709,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 		fortify_panic(__func__);
 	return __real_kmemdup(p, size, gfp);
 }
+#define kmemdup(...)	alloc_hooks(kmemdup_noprof(__VA_ARGS__))
 
 /**
  * strcpy - Copy a string into another string buffer
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 58794043ab5b..61e2a486d529 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -229,7 +229,10 @@ int kmem_cache_shrink(struct kmem_cache *s);
 /*
  * Common kmalloc functions provided by all allocators
  */
-void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags) __realloc_size(2);
+void * __must_check krealloc_noprof(const void *objp, size_t new_size,
+				    gfp_t flags) __realloc_size(2);
+#define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
+
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
@@ -481,7 +484,10 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 
-void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
+#include <linux/alloc_tag.h>
+
+void *__kmalloc_noprof(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
+#define __kmalloc(...)				alloc_hooks(__kmalloc_noprof(__VA_ARGS__))
 
 /**
  * kmem_cache_alloc - Allocate an object
@@ -493,9 +499,14 @@ void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_siz
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags) __assume_slab_alignment __malloc;
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			   gfp_t gfpflags) __assume_slab_alignment __malloc;
+void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
+			      gfp_t flags) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc(...)			alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
+
+void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
+			    gfp_t gfpflags) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
+
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
@@ -506,29 +517,40 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
  * Note that interrupts must be enabled when calling these functions.
  */
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
+
+int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
+#define kmem_cache_alloc_bulk(...)	alloc_hooks(kmem_cache_alloc_bulk_noprof(__VA_ARGS__))
 
 static __always_inline void kfree_bulk(size_t size, void **p)
 {
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
+void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
 							 __alloc_size(1);
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
-									 __malloc;
+#define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
+
+void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
+				   int node) __assume_slab_alignment __malloc;
+#define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
-void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
+void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
 		    __assume_kmalloc_alignment __alloc_size(3);
 
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-			 int node, size_t size) __assume_kmalloc_alignment
+void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
+		int node, size_t size) __assume_kmalloc_alignment
 						__alloc_size(4);
-void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+#define kmalloc_trace(...)			alloc_hooks(kmalloc_trace_noprof(__VA_ARGS__))
+
+#define kmalloc_node_trace(...)			alloc_hooks(kmalloc_node_trace_noprof(__VA_ARGS__))
+
+void *kmalloc_large_noprof(size_t size, gfp_t flags) __assume_page_alignment
 					      __alloc_size(1);
+#define kmalloc_large(...)			alloc_hooks(kmalloc_large_noprof(__VA_ARGS__))
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_alignment
+void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node) __assume_page_alignment
 							     __alloc_size(1);
+#define kmalloc_large_node(...)			alloc_hooks(kmalloc_large_node_noprof(__VA_ARGS__))
 
 /**
  * kmalloc - allocate kernel memory
@@ -584,37 +606,39 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
-static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large(size, flags);
+			return kmalloc_large_noprof(size, flags);
 
 		index = kmalloc_index(size);
-		return kmalloc_trace(
+		return kmalloc_trace_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
-	return __kmalloc(size, flags);
+	return __kmalloc_noprof(size, flags);
 }
+#define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
-static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_node(size, flags, node);
+			return kmalloc_large_node_noprof(size, flags, node);
 
 		index = kmalloc_index(size);
-		return kmalloc_node_trace(
+		return kmalloc_node_trace_noprof(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node(size, flags, node);
+	return __kmalloc_node_noprof(size, flags, node);
 }
+#define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
 /**
  * kmalloc_array - allocate memory for an array.
@@ -622,16 +646,17 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1, 2) void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
-		return kmalloc(bytes, flags);
-	return __kmalloc(bytes, flags);
+		return kmalloc_noprof(bytes, flags);
+	return kmalloc_noprof(bytes, flags);
 }
+#define kmalloc_array(...)			alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
 
 /**
  * krealloc_array - reallocate memory for an array.
@@ -640,18 +665,19 @@ static inline __alloc_size(1, 2) void *kmalloc_array(size_t n, size_t size, gfp_
  * @new_size: new size of a single member of the array
  * @flags: the type of memory to allocate (see kmalloc)
  */
-static inline __realloc_size(2, 3) void * __must_check krealloc_array(void *p,
-								      size_t new_n,
-								      size_t new_size,
-								      gfp_t flags)
+static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
+								       size_t new_n,
+								       size_t new_size,
+								       gfp_t flags)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
 		return NULL;
 
-	return krealloc(p, bytes, flags);
+	return krealloc_noprof(p, bytes, flags);
 }
+#define krealloc_array(...)			alloc_hooks(krealloc_array_noprof(__VA_ARGS__))
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
@@ -659,16 +685,12 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array(void *p,
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flags)
-{
-	return kmalloc_array(n, size, flags | __GFP_ZERO);
-}
+#define kcalloc(_n, _size, _flags)		kmalloc_array(_n, _size, (_flags) | __GFP_ZERO)
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
 				  unsigned long caller) __alloc_size(1);
-#define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
-				    _RET_IP_)
+#define kmalloc_node_track_caller(...)		\
+	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
 
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
@@ -678,11 +700,9 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
  * allocator where we care about the real place the memory allocation
  * request comes from.
  */
-#define kmalloc_track_caller(size, flags) \
-	__kmalloc_node_track_caller(size, flags, \
-				    NUMA_NO_NODE, _RET_IP_)
+#define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
 
-static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
+static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
 							  int node)
 {
 	size_t bytes;
@@ -690,75 +710,56 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size,
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
-		return kmalloc_node(bytes, flags, node);
-	return __kmalloc_node(bytes, flags, node);
+		return kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node_noprof(bytes, flags, node);
 }
+#define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
-static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
-{
-	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
-}
+#define kcalloc_node(_n, _size, _flags, _node)	\
+	kmalloc_array_node(_n, _size, (_flags) | __GFP_ZERO, _node)
 
 /*
  * Shortcuts
  */
-static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
-{
-	return kmem_cache_alloc(k, flags | __GFP_ZERO);
-}
+#define kmem_cache_zalloc(_k, _flags)		kmem_cache_alloc(_k, (_flags)|__GFP_ZERO)
 
 /**
  * kzalloc - allocate memory. The memory is set to zero.
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
+static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 {
-	return kmalloc(size, flags | __GFP_ZERO);
+	return kmalloc_noprof(size, flags | __GFP_ZERO);
 }
+#define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
+#define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-/**
- * kzalloc_node - allocate zeroed memory from a particular memory node.
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate (see kmalloc).
- * @node: memory node from which to allocate
- */
-static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int node)
-{
-	return kmalloc_node(size, flags | __GFP_ZERO, node);
-}
+extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_size(1);
+#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node) __alloc_size(1);
-static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc_node(size, flags, NUMA_NO_NODE);
-}
-static inline __alloc_size(1) void *kvzalloc_node(size_t size, gfp_t flags, int node)
-{
-	return kvmalloc_node(size, flags | __GFP_ZERO, node);
-}
-static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
-{
-	return kvmalloc(size, flags | __GFP_ZERO);
-}
+#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
+#define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
+
+#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
 
-static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *kvmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc(bytes, flags);
+	return kvmalloc_node_noprof(bytes, flags, NUMA_NO_NODE);
 }
 
-static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)
-{
-	return kvmalloc_array(n, size, flags | __GFP_ZERO);
-}
+#define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
+#define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__GFP_ZERO)
 
-extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
+#define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
+
 extern void kvfree(const void *addr);
 DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
 
diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..14e4fb4340f4 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -214,7 +214,9 @@ extern void kfree_const(const void *x);
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
+extern void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
+#define kmemdup(...)	alloc_hooks(kmemdup_noprof(__VA_ARGS__))
+
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..5f9e25626dc7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1184,7 +1184,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 		return (void *)p;
 	}
 
-	ret = kmalloc_track_caller(new_size, flags);
+	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
@@ -1208,7 +1208,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
  *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
-void *krealloc(const void *p, size_t new_size, gfp_t flags)
+void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
 
@@ -1223,7 +1223,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 
 	return ret;
 }
-EXPORT_SYMBOL(krealloc);
+EXPORT_SYMBOL(krealloc_noprof);
 
 /**
  * kfree_sensitive - Clear sensitive information in memory before freeing
diff --git a/mm/slub.c b/mm/slub.c
index a69b6b4c8df6..920b24b4140e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3920,7 +3920,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	return object;
 }
 
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+void *kmem_cache_alloc_noprof(struct kmem_cache *s, gfp_t gfpflags)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
 				    s->object_size);
@@ -3929,9 +3929,9 @@ void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(kmem_cache_alloc_noprof);
 
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags)
 {
 	void *ret = slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _RET_IP_,
@@ -3941,10 +3941,10 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
+EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
 /**
- * kmem_cache_alloc_node - Allocate an object on the specified node
+ * kmem_cache_alloc_node_noprof - Allocate an object on the specified node
  * @s: The cache to allocate from.
  * @gfpflags: See kmalloc().
  * @node: node number of the target node.
@@ -3956,7 +3956,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_lru);
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
+void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
@@ -3964,7 +3964,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
 /*
  * To avoid unnecessary overhead, we pass through large allocation requests
@@ -3981,7 +3981,7 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 		flags = kmalloc_fix_flags(flags);
 
 	flags |= __GFP_COMP;
-	folio = (struct folio *)alloc_pages_node(node, flags, order);
+	folio = (struct folio *)alloc_pages_node_noprof(node, flags, order);
 	if (folio) {
 		ptr = folio_address(folio);
 		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
@@ -3996,7 +3996,7 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
-void *kmalloc_large(size_t size, gfp_t flags)
+void *kmalloc_large_noprof(size_t size, gfp_t flags)
 {
 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
@@ -4004,9 +4004,9 @@ void *kmalloc_large(size_t size, gfp_t flags)
 		      flags, NUMA_NO_NODE);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large);
+EXPORT_SYMBOL(kmalloc_large_noprof);
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 {
 	void *ret = __kmalloc_large_node(size, flags, node);
 
@@ -4014,7 +4014,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 		      flags, node);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_node);
+EXPORT_SYMBOL(kmalloc_large_node_noprof);
 
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
@@ -4041,26 +4041,26 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	return __do_kmalloc_node(size, flags, node, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc_node);
+EXPORT_SYMBOL(__kmalloc_node_noprof);
 
-void *__kmalloc(size_t size, gfp_t flags)
+void *__kmalloc_noprof(size_t size, gfp_t flags)
 {
 	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc);
+EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
-				  int node, unsigned long caller)
+void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
+				       int node, unsigned long caller)
 {
 	return __do_kmalloc_node(size, flags, node, caller);
 }
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
+EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
 
-void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
 					    _RET_IP_, size);
@@ -4070,9 +4070,9 @@ void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_trace);
+EXPORT_SYMBOL(kmalloc_trace_noprof);
 
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
 			 int node, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
@@ -4082,7 +4082,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_node_trace);
+EXPORT_SYMBOL(kmalloc_node_trace_noprof);
 
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
@@ -4691,8 +4691,8 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 #endif /* CONFIG_SLUB_TINY */
 
 /* Note that interrupts must be enabled when calling this function. */
-int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
-			  void **p)
+int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
+				 void **p)
 {
 	int i;
 	struct obj_cgroup *objcg = NULL;
@@ -4720,7 +4720,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 	return i;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_bulk);
+EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..291f7945190f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -115,7 +115,7 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
 EXPORT_SYMBOL(kstrndup);
 
 /**
- * kmemdup - duplicate region of memory
+ * kmemdup_noprof - duplicate region of memory
  *
  * @src: memory region to duplicate
  * @len: memory region length
@@ -124,16 +124,16 @@ EXPORT_SYMBOL(kstrndup);
  * Return: newly allocated copy of @src or %NULL in case of error,
  * result is physically contiguous. Use kfree() to free.
  */
-void *kmemdup(const void *src, size_t len, gfp_t gfp)
+void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, gfp);
+	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
 	if (p)
 		memcpy(p, src, len);
 	return p;
 }
-EXPORT_SYMBOL(kmemdup);
+EXPORT_SYMBOL(kmemdup_noprof);
 
 /**
  * kvmemdup - duplicate region of memory
@@ -577,7 +577,7 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 EXPORT_SYMBOL(vm_mmap);
 
 /**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * kvmalloc_node_noprof - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
@@ -592,7 +592,7 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node(size_t size, gfp_t flags, int node)
+void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -614,7 +614,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node(size, kmalloc_flags, node);
+	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -643,7 +643,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(kvmalloc_node);
+EXPORT_SYMBOL(kvmalloc_node_noprof);
 
 /**
  * kvfree() - Free memory.
@@ -682,7 +682,7 @@ void kvfree_sensitive(const void *addr, size_t len)
 }
 EXPORT_SYMBOL(kvfree_sensitive);
 
-void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 {
 	void *newp;
 
@@ -695,7 +695,7 @@ void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 	kvfree(p);
 	return newp;
 }
-EXPORT_SYMBOL(kvrealloc);
+EXPORT_SYMBOL(kvrealloc_noprof);
 
 /**
  * __vmalloc_array - allocate memory for a virtually contiguous array.
-- 
2.44.0.rc0.258.g7320e95886-goog


