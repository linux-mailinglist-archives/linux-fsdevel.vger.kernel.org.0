Return-Path: <linux-fsdevel+bounces-28529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D396B840
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E76D287262
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F31CF5D6;
	Wed,  4 Sep 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEfBh4WZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF2126C08
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445374; cv=none; b=hRs9qmgOV0AqPp9KH7o8wDP0Z6D1JG24o0lRl9rAWi3GNeYZVqXD9MZJQMlWcv5F8TIXL+qsV5BRaKBdY8kwo82V+4f8wDIrjtchpjPBg+WGvpyVRhjh85SXTUP/XzDTeO2VKd1347kXZ6CZsouolCT8T0x53i9ERBDbSvJ5Yrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445374; c=relaxed/simple;
	bh=YjxO66hJ+BVi0bwZydpu1jfLI/x58A7MkM0YNuLTP98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVZYav90qWyqiY9kiu9X+6i5+aNkzCJDHrtUgX1o8nA7z8EMsIPRhXigzSjW8IIcRKj5n4x4JQt2WiUv43qyYW2hA9FPzWJ/L4OTxw+2HMxoJ9MZn7jfJqExGXo13PmVznJ/sK9CgO7YRY9nCb8LiCyo7PV4QhhrZ1QbruVhf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEfBh4WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9B5C4CECC;
	Wed,  4 Sep 2024 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445374;
	bh=YjxO66hJ+BVi0bwZydpu1jfLI/x58A7MkM0YNuLTP98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AEfBh4WZJ7pNUvjtrYEMp5wXlLriDBDcZYoIuOd4xpupauIsqPzuDzphXZBV4kLV6
	 TcOZFri2K0HWuchx6mo47Vr+pxy16ovN7pPwNNUVXmGx0I8umtB4a6zQLkYasZBer6
	 EgvxZrHDnb2A9oa6qB+INgGpn+OS9/RinxZzTzVs8cq0WTzCD8+08jglfGHct+ZnCJ
	 4iQw5og6J5qluAYydkJv1Us4UU8C7+2Z6LC7mmnDe55ZZgS5PESq77XyMSI0d0jhf4
	 QX4v/aadFfTR4hnlXSjUP/2yB1sLSbB2OOapeSjVCTVtJ/5ispRbDWwt1+Kuy0mOVV
	 XzTmmcjshI5EQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:21 +0200
Subject: [PATCH v3 16/17] slab: make __kmem_cache_create() static inline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-16-05db2179a8c2@kernel.org>
References: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
In-Reply-To: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YjxO66hJ+BVi0bwZydpu1jfLI/x58A7MkM0YNuLTP98=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm9XjXnZfdPg79/rR6baEe3TpARutzz7eEu2WcW0
 a/LpL4zdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkHw/D/xKxXKeZEyNXL72z
 d+5/TQFl7seBn70y714QVhcpi3M61s3w38H/W79TX2P+vgf8U5M2bJ+yfGGtosqbiz4uVt1Cu89
 m8AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make __kmem_cache_create() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 13 ++++++++++---
 mm/slab_common.c     | 38 --------------------------------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e224a1a9bcbc..70a0f530b89f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -261,10 +261,17 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    unsigned int object_size,
 					    struct kmem_cache_args *args,
 					    slab_flags_t flags);
+static inline struct kmem_cache *
+__kmem_cache_create(const char *name, unsigned int size, unsigned int align,
+		    slab_flags_t flags, void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align	= align,
+		.ctor	= ctor,
+	};
 
-struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
-				       unsigned int align, slab_flags_t flags,
-				       void (*ctor)(void *));
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
+}
 
 /**
  * kmem_cache_create_usercopy - Create a cache with a region suitable
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3477a3918afd..30000dcf0736 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -337,44 +337,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 }
 EXPORT_SYMBOL(__kmem_cache_create_args);
 
-/**
- * __kmem_cache_create - Create a cache.
- * @name: A string which is used in /proc/slabinfo to identify this cache.
- * @size: The size of objects to be created in this cache.
- * @align: The required alignment for the objects.
- * @flags: SLAB flags
- * @ctor: A constructor for the objects.
- *
- * Cannot be called within a interrupt, but can be interrupted.
- * The @ctor is run when new pages are allocated by the cache.
- *
- * The flags are
- *
- * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
- * to catch references to uninitialised memory.
- *
- * %SLAB_RED_ZONE - Insert `Red` zones around the allocated memory to check
- * for buffer overruns.
- *
- * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
- * cacheline.  This can be beneficial if you're counting cycles as closely
- * as davem.
- *
- * Return: a pointer to the cache on success, NULL on failure.
- */
-struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
-				       unsigned int align, slab_flags_t flags,
-				       void (*ctor)(void *))
-{
-	struct kmem_cache_args kmem_args = {
-		.align	= align,
-		.ctor	= ctor,
-	};
-
-	return __kmem_cache_create_args(name, size, &kmem_args, flags);
-}
-EXPORT_SYMBOL(__kmem_cache_create);
-
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
 /**

-- 
2.45.2


