Return-Path: <linux-fsdevel+bounces-28692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F896D10E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5958B1F21641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACC194ACF;
	Thu,  5 Sep 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqxXrGSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E502192D8F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523087; cv=none; b=otw71nbBw4YtS+n/IkecLaD7NDzGqmz3EyGSIl+gjPrfEaLFIuixthJ1y/zObNQOoRg24RcfDgtl+BCrBUqxXqkJjhY9P7HlWy5ZORKKd6SoB/eVAflVN74tP6otSTmTUPIPyfB1AlEie+c9+E0dYwG0iuCnCMlBU0KkVoIMMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523087; c=relaxed/simple;
	bh=rwJKoUBiD4opsF3q3lc+9pnVXWY01qThhoh7PngENwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjuxKIHaozJFH7Uhl4BzMKaLto0b7D/+vQxkMz1nZSbinD5yWsd6+XRpLy8EBBWmE6HkDmWNknOnr21rMhL8pQ6zZXeM2X/gTvbxVZi6ZFxI4r8PPcx1gzpdx9kjlK1YoOJe7I21iCbB0taxjy7PbdKRJmKZ8ysHQe1Ar5Q7xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqxXrGSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F903C4CEC9;
	Thu,  5 Sep 2024 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523086;
	bh=rwJKoUBiD4opsF3q3lc+9pnVXWY01qThhoh7PngENwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UqxXrGSksmpwRA6ISWIfcsy2RBc0SFe/JRNtZg49zhcODYuHDz3xFWj156OUJxLZ+
	 wlgA48rZ4aVjDeDgAisVGRtKKDZSAUgVWYuH02G8IAvR1flVT5sBrD/kRxow7t9U/b
	 avyDBgagBqJmDSz3qCSe51VQ7h6c2PS6AnttGq5P2P8rnS3PPs8BJMOKtM7B0O91yS
	 TrSImZBnPOaVASgyaAjqy93Uugn9w9qq7b1L9P0Er6SKg16c3pVSoYGQMouoQRQjrO
	 0FMi80Rd1VmLqkkLYKgzSdFQJeQW52mEZPHMSWtDuXWaiDK9hDfmx/JgEGNqxTI1tB
	 U71j7fw3uPvdg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:59 +0200
Subject: [PATCH v4 16/17] slab: make __kmem_cache_create() static inline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-16-ed45d5380679@kernel.org>
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
In-Reply-To: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
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
 h=from:subject:message-id; bh=rwJKoUBiD4opsF3q3lc+9pnVXWY01qThhoh7PngENwk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPEuPu2j8kRPI0DSfXdC71rLqwZ7b+4XeG9n8f8WI
 9OWKwblHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRyWf4K+S264SiRNnN4pCy
 otf59c/vPTdSWrb90XZ2I713D2RXZjIyzJ4mt6dx8kq790bb0i95+X2PfXjqj82S4I29cxZ9uaN
 6mhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make __kmem_cache_create() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 13 ++++++++++---
 mm/slab_common.c     | 38 --------------------------------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d744397aa46f..597f6913cc0f 100644
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


