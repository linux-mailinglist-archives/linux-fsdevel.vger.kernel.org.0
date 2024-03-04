Return-Path: <linux-fsdevel+bounces-13513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87808709D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752FD1F23B24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24378B53;
	Mon,  4 Mar 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBfUlYJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA962147
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578178; cv=none; b=B6Fd7KiUmYo7shL62koEjZYVaRYxeLXRB3Q8ibqxVy0ZEJev3fYSIhLzmCkB/zhdzLZdkqFyA1z78FH+rcASnaC+0Tk5LzVV1WIa/c1Y7u6H8I8vzKd4dp14wEA2qfWM7okoJ9TiGvc5XOc4AsFDRKNeCjkX1cekiXvcY+PlDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578178; c=relaxed/simple;
	bh=h85WkZi4o3uylzu/3xQb8d5MHb8DhVgIptaT/36yfQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSPWRiU9vBwPPtj1Nw3KP1sh9rHQJBhYsStffKV6GwM4GSeTQJwyOBzpQdJ/Qvh3LI3A39ulEigT0nAhBbCY19ipqWMJEjufosl0CNqE/aEWGxtRGW/2czE9itD0h8gz4DGEPTYPKuul3TclHzT/DnhC40tYevr0V2MqjP15eGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XBfUlYJh; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so3175843a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709578176; x=1710182976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMb+PmcOht+K9M0r7eBe/cOsz5NTpNrdAZ0O4xFPS4c=;
        b=XBfUlYJhMBybjlOMNRAj5jluBu/WLtbNctsJM++zZaY68hcfA2Mwo6tFe+9ub90Xwl
         fsIf/a+NPH9h02da4izV6Qhx2PerYhs1hZWzpgExEn4rVjwXYDZP801/Sm+QZqD1/z1k
         bq3W5H+cjtOQ3qGJl8/fLYZ2wAoXsPJCv/tUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578176; x=1710182976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMb+PmcOht+K9M0r7eBe/cOsz5NTpNrdAZ0O4xFPS4c=;
        b=h8L4FquvvDy85BmzCeqBjqbKX2spUBXm5jRRieY5/Ht/9vOy/KXnCys+Dxy0KjklgA
         YnYVrCkJhMDdtCmTNAQyvQpRWCy+vBrDYdMUQ8fVo0RMiMEimj7zDgZObpKqb8KO23hc
         tmR3MPxdshfbLNDMH1yvOG7BfdD1jZPeBklLv+t/axp5xJe/CWeDmcmj1blzLLmNoIPu
         4bcJQXCDlAAm7y91zhC9Ap3liUy1k8VjU1GP2mryw9+Rs3sdemGuS3DolpRzym2N+NAz
         lGGnAONp93PoXlJkarNVuGMGhR31BGKzvv8l2aIBxYw00qFaPD6jnVgNpbiLdJTMCg2f
         sq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAnDoYAxpomBarPnQJ47TU51R5PGT8u2mlBpP5pfC3VFY+BCzP1fmIeb31Au+nLI+iyyz8HNBWy/Yu5lwFlnwBc0LO/1kxzX0mYyd/wA==
X-Gm-Message-State: AOJu0YwnuH8zsSPYTa6NsWoR/JkqE9b/RRz/9mQTowCIfqOK/ptMi6KD
	p7XuKWFkpVIbnMPX4pvCdaZVUXVn4R7OQFfCqY+3W1pbI7Hdlmm/gjTOylAnJA==
X-Google-Smtp-Source: AGHT+IHXfzDDi+Jk/MGWJiolbgqaEdJ79sjoSCtqB+82MCn/uMPrW4nNSDO9Xzsngfqy/Yg749crOw==
X-Received: by 2002:a05:6a20:a11a:b0:1a1:4a21:1fe3 with SMTP id q26-20020a056a20a11a00b001a14a211fe3mr1759584pzk.0.1709578176143;
        Mon, 04 Mar 2024 10:49:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b006e56e5c09absm7810419pfn.14.2024.03.04.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:49:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] slab: Introduce dedicated bucket allocator
Date: Mon,  4 Mar 2024 10:49:29 -0800
Message-Id: <20240304184933.3672759-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304184252.work.496-kees@kernel.org>
References: <20240304184252.work.496-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5798; i=keescook@chromium.org;
 h=from:subject; bh=h85WkZi4o3uylzu/3xQb8d5MHb8DhVgIptaT/36yfQM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5he8a2IWxCB3p2pd4ASVvCAfbFqAl2DgpfxWQ
 QjMAXgEaQyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeYXvAAKCRCJcvTf3G3A
 Ju0qD/9wLY1KtAVlKpiIcbRaHdOPbTRV4/D+hFxL5B9cNYkqbIS1fUdUJI71wBUD6kJnhCd9kCz
 zY7AbWXcvcgkl2cA36q3sg5ftbAUAugShF8SRrO7cuJBDBjz61Sd3q8a2ajePTuRLXO+IkiOZSW
 fEs0uw7D3bTOvVIQAaqxYIRhm5g0wDeFJcikNAE06pyX++iA/ePzCLUTui8hhrErnor+Eok1Gio
 km/LhI+jGhbmoV8EFNFn5yCij/hBhmf/m80ThCIvRs4Lrfs+Jc6NOeSHI0vjyiNxh2dY+XB5kpD
 yrScvBaBU8MD0PtoCFyo3sqIlhB8epaO9WymgCqRuF+mYuac6RjWgjZh2wBApo+SwpQFUb8g2fH
 as59RRHY0OQj+s75GtR8Ra9PHvO03ZpOGrKZj/tZqCkbIt92ysyof2t2O2n5yBLKAnTWrUAbw5g
 SUF7DF0cRG3BfxkZknrhUe6vrhx7uHHB3EHgs3aqEPbc15a38JptIoGR6vga6dtfq38DvPQguDC
 2FQBjQRAQbIhYnATKR31hLJTYiwQ2n+HwHoOW0NawX/LV5lAFUf/Z6+hHodr5UK8PFA6Nd+44eM
 BnNhe+/usfeJyldh8jlzjBfT3UJIcUYGR+sfEjSE48hTeze4iwwNvv/OMOHmv417pCMNY8ohvDd m7Otqn2ryvvKzHg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Dedicated caches are available For fixed size allocations via
kmem_cache_alloc(), but for dynamically sized allocations there is only
the global kmalloc API's set of buckets available. This means it isn't
possible to separate specific sets of dynamically sized allocations into
a separate collection of caches.

This leads to a use-after-free exploitation weakness in the Linux
kernel since many heap memory spraying/grooming attacks depend on using
userspace-controllable dynamically sized allocations to collide with
fixed size allocations that end up in same cache.

While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
against these kinds of "type confusion" attacks, including for fixed
same-size heap objects, we can create a complementary deterministic
defense for dynamically sized allocations.

In order to isolate user-controllable sized allocations from system
allocations, introduce kmem_buckets_create() and kmem_buckets_alloc(),
which behave like kmem_cache_create() and like kmem_cache_alloc() for
confining allocations to a dedicated set of sized caches (which have
the same layout as the kmalloc caches).

This can also be used in the future once codetag allocation annotations
exist to implement per-caller allocation cache isolation[1] even for
dynamic allocations.

Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 26 ++++++++++++++++++
 mm/slab_common.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..4a4ff84534be 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -492,6 +492,16 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+struct kmem_buckets {
+	struct kmem_cache *caches[ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL])];
+};
+
+struct kmem_buckets *
+kmem_buckets_create(const char *name, unsigned int align, slab_flags_t flags,
+		    unsigned int useroffset, unsigned int usersize,
+		    void (*ctor)(void *));
+
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
@@ -594,6 +604,22 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+static __always_inline __alloc_size(2)
+void *kmem_buckets_alloc(struct kmem_buckets *b, size_t size, gfp_t flags)
+{
+	unsigned int index;
+
+	if (size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+	if (WARN_ON_ONCE(!b))
+		return NULL;
+	index = kmalloc_index(size);
+	if (WARN_ONCE(!b->caches[index],
+		      "missing cache for size %zu (index %d)\n", size, index))
+		return kmalloc(size, flags);
+	return kmalloc_trace(b->caches[index], flags, size);
+}
+
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..6002a182d014 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,66 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+static struct kmem_cache *kmem_buckets_cache __ro_after_init;
+
+struct kmem_buckets *
+kmem_buckets_create(const char *name, unsigned int align,
+		  slab_flags_t flags,
+		  unsigned int useroffset, unsigned int usersize,
+		  void (*ctor)(void *))
+{
+	struct kmem_buckets *b;
+	int idx;
+
+	if (WARN_ON(!kmem_buckets_cache))
+		return NULL;
+
+	b = kmem_cache_alloc(kmem_buckets_cache, GFP_KERNEL|__GFP_ZERO);
+	if (WARN_ON(!b))
+		return NULL;
+
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		char *short_size, *cache_name;
+		unsigned int size;
+
+		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
+			continue;
+
+		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
+		if (!size)
+			continue;
+
+		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
+		if (WARN_ON(!short_size))
+			goto fail;
+
+		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+		if (WARN_ON(!cache_name))
+			goto fail;
+
+		b->caches[idx] = kmem_cache_create_usercopy(cache_name, size,
+					align, flags, useroffset,
+					min(size - useroffset, usersize), ctor);
+		kfree(cache_name);
+		if (WARN_ON(!b->caches[idx]))
+			goto fail;
+	}
+
+	return b;
+
+fail:
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		if (b->caches[idx]) {
+			kfree(b->caches[idx]->name);
+			kmem_cache_destroy(b->caches[idx]);
+		}
+	}
+	kfree(b);
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_buckets_create);
+
 #ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
@@ -934,6 +994,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
+
+	kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
+				sizeof(struct kmem_buckets) * ARRAY_SIZE(kmalloc_info),
+				0, 0, NULL);
 }
 
 /**
-- 
2.34.1


