Return-Path: <linux-fsdevel+bounces-27551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98954962555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234E61F23B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D016C42C;
	Wed, 28 Aug 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNOjJ3rS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07F16B3BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842630; cv=none; b=TYosndRfjTilYOsZJk9P+KmsJaRE9AnH0s+9qTraOtFtyr3U8SJ5YqBtzAT/97chbcC2aJMKgBUsKm0Xfgx11ccqgNVnHpewY3b1wF0SWXAmq0ulE600gNynoK8fLr4XqeGe/ORKwbRB7dHbgQRhbD+c+ZXegvAf/nhhaROwYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842630; c=relaxed/simple;
	bh=wNVAvroRRvpcORJPuYkDuLT0tHqBRq4ogN+7NtjeOC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OW6127AwFnu4BsiC8yQJ/pdfdNtxJe5k15VEvsPiSLubGF1Cn1LiFuoO6MeqECNlgbpXr4OyL346akZKolsFTC0tDXfRXLb4GTuaS/gbh7DzeV7PcUBKLnMvKEpnGF1WJ/voZMxvHWFCr3evvB+diwo0RkMT0s6KGoo6WYN63pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNOjJ3rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78779C4CACD;
	Wed, 28 Aug 2024 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842630;
	bh=wNVAvroRRvpcORJPuYkDuLT0tHqBRq4ogN+7NtjeOC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KNOjJ3rSY9QCIDCROpFWlqfF5Efb1VmHKi6WleD7nLsr/IuCwGZMkd/+g/VsE1o4m
	 UvhbZkb+8IVnySVeAzEe4UHsrnvr2bSoY3qA5EgHVZgFLmBgrPxxZJHOkH5ruE3pBv
	 T3FJT3o4fXGL7kY23O/yK0GAlaDOceXKTJLafQczX6KC2Y0nhbPK4ANkZf9Xxq6pi7
	 VQ70Qww2XfzW1RdNeOVfEjUL4p8HcYBmnLsyra0X6H2ongcCdNuDBZ6c65s6+pKhuL
	 B/ueXJs08jKi7Tl6ByIQUu2JNJbPUxo9dwEE3r3sJ63GlOEqLf8v096d2H+tQTEMV/
	 m3eS7x6p0Nvww==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 28 Aug 2024 12:56:24 +0200
Subject: [PATCH v3 2/3] mm: add kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-work-kmem_cache-rcu-v3-2-5460bc1f09f6@kernel.org>
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
In-Reply-To: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=11892; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wNVAvroRRvpcORJPuYkDuLT0tHqBRq4ogN+7NtjeOC8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdZ6rRYrBUadYONvdc0rbE+8DaIv0z3kdS+Xn3T/2RE
 GV6bMmJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksOsHIMH3bAfer+4W2Ct9i
 XsjmHv1UdGZ3Ks/0X+dlYv3mzmPe5svw33u3cUA685GXxitWRH9dcF/2y8up7Lte5x1glOWueJ/
 Nzw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
must be located outside of the object because we don't know what part of
the memory can safely be overwritten as it may be needed to prevent
object recycling.

That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
new cacheline. This is the case for e.g., struct file. After having it
shrunk down by 40 bytes and having it fit in three cachelines we still
have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
accommodate the free pointer.

Add a new kmem_cache_create_rcu() function that allows the caller to
specify an offset where the free pointer is supposed to be placed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h |   9 ++++
 mm/slab.h            |   2 +
 mm/slab_common.c     | 136 ++++++++++++++++++++++++++++++++++++---------------
 mm/slub.c            |  20 +++++---
 4 files changed, 121 insertions(+), 46 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..5b2da2cf31a8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -212,6 +212,12 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+/*
+ * freeptr_t represents a SLUB freelist pointer, which might be encoded
+ * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
+ */
+typedef struct { unsigned long v; } freeptr_t;
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
@@ -242,6 +248,9 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 			slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize,
 			void (*ctor)(void *));
+struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
+					 unsigned int freeptr_offset,
+					 slab_flags_t flags);
 void kmem_cache_destroy(struct kmem_cache *s);
 int kmem_cache_shrink(struct kmem_cache *s);
 
diff --git a/mm/slab.h b/mm/slab.h
index dcdb56b8e7f5..a6051385186e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -261,6 +261,8 @@ struct kmem_cache {
 	unsigned int object_size;	/* Object size without metadata */
 	struct reciprocal_value reciprocal_size;
 	unsigned int offset;		/* Free pointer offset */
+	/* Specific free pointer requested (if not UINT_MAX) */
+	unsigned int rcu_freeptr_offset;
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
 	unsigned int cpu_partial;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c8dd7e08c5f6..887f6b9855dd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -202,9 +202,10 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 }
 
 static struct kmem_cache *create_cache(const char *name,
-		unsigned int object_size, unsigned int align,
-		slab_flags_t flags, unsigned int useroffset,
-		unsigned int usersize, void (*ctor)(void *))
+		unsigned int object_size, unsigned int freeptr_offset,
+		unsigned int align, slab_flags_t flags,
+		unsigned int useroffset, unsigned int usersize,
+		void (*ctor)(void *))
 {
 	struct kmem_cache *s;
 	int err;
@@ -212,6 +213,13 @@ static struct kmem_cache *create_cache(const char *name,
 	if (WARN_ON(useroffset + usersize > object_size))
 		useroffset = usersize = 0;
 
+	/* If a custom freelist pointer is requested make sure it's sane. */
+	err = -EINVAL;
+	if (freeptr_offset != UINT_MAX &&
+	    (freeptr_offset >= object_size || !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     !IS_ALIGNED(freeptr_offset, sizeof(freeptr_t))))
+		goto out;
+
 	err = -ENOMEM;
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
@@ -219,13 +227,13 @@ static struct kmem_cache *create_cache(const char *name,
 
 	s->name = name;
 	s->size = s->object_size = object_size;
+	s->rcu_freeptr_offset = freeptr_offset;
 	s->align = align;
 	s->ctor = ctor;
 #ifdef CONFIG_HARDENED_USERCOPY
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 #endif
-
 	err = __kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
@@ -240,38 +248,10 @@ static struct kmem_cache *create_cache(const char *name,
 	return ERR_PTR(err);
 }
 
-/**
- * kmem_cache_create_usercopy - Create a cache with a region suitable
- * for copying to userspace
- * @name: A string which is used in /proc/slabinfo to identify this cache.
- * @size: The size of objects to be created in this cache.
- * @align: The required alignment for the objects.
- * @flags: SLAB flags
- * @useroffset: Usercopy region offset
- * @usersize: Usercopy region size
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
-struct kmem_cache *
-kmem_cache_create_usercopy(const char *name,
-		  unsigned int size, unsigned int align,
-		  slab_flags_t flags,
+static struct kmem_cache *
+do_kmem_cache_create_usercopy(const char *name,
+		  unsigned int size, unsigned int freeptr_offset,
+		  unsigned int align, slab_flags_t flags,
 		  unsigned int useroffset, unsigned int usersize,
 		  void (*ctor)(void *))
 {
@@ -331,7 +311,7 @@ kmem_cache_create_usercopy(const char *name,
 		goto out_unlock;
 	}
 
-	s = create_cache(cache_name, size,
+	s = create_cache(cache_name, size, freeptr_offset,
 			 calculate_alignment(flags, align, size),
 			 flags, useroffset, usersize, ctor);
 	if (IS_ERR(s)) {
@@ -355,6 +335,45 @@ kmem_cache_create_usercopy(const char *name,
 	}
 	return s;
 }
+
+/**
+ * kmem_cache_create_usercopy - Create a cache with a region suitable
+ * for copying to userspace
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
+ * @freeptr_offset: Custom offset for the free pointer in RCU caches
+ * @align: The required alignment for the objects.
+ * @flags: SLAB flags
+ * @useroffset: Usercopy region offset
+ * @usersize: Usercopy region size
+ * @ctor: A constructor for the objects.
+ *
+ * Cannot be called within a interrupt, but can be interrupted.
+ * The @ctor is run when new pages are allocated by the cache.
+ *
+ * The flags are
+ *
+ * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
+ * to catch references to uninitialised memory.
+ *
+ * %SLAB_RED_ZONE - Insert `Red` zones around the allocated memory to check
+ * for buffer overruns.
+ *
+ * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
+ * cacheline.  This can be beneficial if you're counting cycles as closely
+ * as davem.
+ *
+ * Return: a pointer to the cache on success, NULL on failure.
+ */
+struct kmem_cache *
+kmem_cache_create_usercopy(const char *name, unsigned int size,
+			   unsigned int align, slab_flags_t flags,
+			   unsigned int useroffset, unsigned int usersize,
+			   void (*ctor)(void *))
+{
+	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
+					     useroffset, usersize, ctor);
+}
 EXPORT_SYMBOL(kmem_cache_create_usercopy);
 
 /**
@@ -386,11 +405,50 @@ struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		slab_flags_t flags, void (*ctor)(void *))
 {
-	return kmem_cache_create_usercopy(name, size, align, flags, 0, 0,
-					  ctor);
+	return do_kmem_cache_create_usercopy(name, size, UINT_MAX, align, flags,
+					     0, 0, ctor);
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+/**
+ * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
+ * @freeptr_offset: The offset into the memory to the free pointer
+ * @flags: SLAB flags
+ *
+ * Cannot be called within an interrupt, but can be interrupted.
+ *
+ * See kmem_cache_create() for an explanation of possible @flags.
+ *
+ * By default SLAB_TYPESAFE_BY_RCU caches place the free pointer outside
+ * of the object. This might cause the object to grow in size. Callers
+ * that have a reason to avoid this can specify a custom free pointer
+ * offset in their struct where the free pointer will be placed.
+ *
+ * Note that placing the free pointer inside the object requires the
+ * caller to ensure that no fields are invalidated that are required to
+ * guard against object recycling (See SLAB_TYPESAFE_BY_RCU for
+ * details.).
+ *
+ * Using zero as a value for @freeptr_offset is valid. To request no
+ * offset UINT_MAX must be specified.
+ *
+ * Note that @ctor isn't supported with custom free pointers as a @ctor
+ * requires an external free pointer.
+ *
+ * Return: a pointer to the cache on success, NULL on failure.
+ */
+struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
+					 unsigned int freeptr_offset,
+					 slab_flags_t flags)
+{
+	return do_kmem_cache_create_usercopy(name, size, freeptr_offset, 0,
+					     flags | SLAB_TYPESAFE_BY_RCU, 0, 0,
+					     NULL);
+}
+EXPORT_SYMBOL(kmem_cache_create_rcu);
+
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
 /**
diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..9aa5da1e8e27 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -465,12 +465,6 @@ static struct workqueue_struct *flushwq;
  * 			Core slab cache functions
  *******************************************************************/
 
-/*
- * freeptr_t represents a SLUB freelist pointer, which might be encoded
- * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
- */
-typedef struct { unsigned long v; } freeptr_t;
-
 /*
  * Returns freelist pointer (ptr). With hardening, this is obfuscated
  * with an XOR of the address where the pointer is held and a per-cache
@@ -3921,6 +3915,9 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 /*
  * If the object has been wiped upon free, make sure it's fully initialized by
  * zeroing out freelist pointer.
+ *
+ * Note that we also wipe custom freelist pointers specified via
+ * s->rcu_freeptr_offset.
  */
 static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 						   void *obj)
@@ -5144,6 +5141,12 @@ static void set_cpu_partial(struct kmem_cache *s)
 #endif
 }
 
+/* Was a valid freeptr offset requested? */
+static inline bool has_freeptr_offset(const struct kmem_cache *s)
+{
+	return s->rcu_freeptr_offset != UINT_MAX;
+}
+
 /*
  * calculate_sizes() determines the order and the distribution of data within
  * a slab object.
@@ -5189,7 +5192,8 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) || s->ctor ||
+	if (((flags & SLAB_TYPESAFE_BY_RCU) && !has_freeptr_offset(s)) ||
+	    (flags & SLAB_POISON) || s->ctor ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -5210,6 +5214,8 @@ static int calculate_sizes(struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
+	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && has_freeptr_offset(s)) {
+		s->offset = s->rcu_freeptr_offset;
 	} else {
 		/*
 		 * Store freelist pointer near middle of object to keep

-- 
2.45.2


