Return-Path: <linux-fsdevel+bounces-28691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20596D10D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6FC285581
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAD194ACD;
	Thu,  5 Sep 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCEn44ZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7819408C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523083; cv=none; b=VPNzJzf7EVn4kdmuj5Bp60YY+rs0KWl1L96977w4WKW2shQmTcSL2UPQKyDkLrV4QFApmuMPSYaufVqZllZOTDOYDyZnvD7z/BR9+0f636utUB/QK7IJxdgaBtBAgHd7ft7glIGyJDXnXoFQmbRumVsuwQHIhTjgDv6dlXd2kJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523083; c=relaxed/simple;
	bh=8MPF6aXbdUIaNsM6rCGkaQsu5CsscD0F2Lvkbk763C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmXX1d0s8lRLq642Wg2vGsOEhx5Q54bai1USFywhTMPE0A1d7ZUSiepHHFhqSPL62crIbi9yajojKRXNM5PF0bG9LAUWWabdSDkn3uXDXPuRALClZJNLy6Zj00bUX51RM1qG5LIJ1Pqksx8Z2KtCMcFVJYU9bqXveQsu4Y4sdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCEn44ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A91C4CEC7;
	Thu,  5 Sep 2024 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523083;
	bh=8MPF6aXbdUIaNsM6rCGkaQsu5CsscD0F2Lvkbk763C4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jCEn44ZWRCSA9HVoaikbAlgBU3BAXgX6znj1B8SQc1aXfEfaCf+J3Q4fxzbhZP5W6
	 rtBpLbe0X4Ib1EkGzQv0ekZvpN+Vm5TRW1iv0InpFeutCESIk0Oq2Iv3yKZ6p0qIl6
	 QSVsvTyShitYfBic6Btst0IgZwZnx7Vm99PJpan+xTk8Bls4i+lPzBOAM5x+yiHbh8
	 jXTpHM8wbwV/yThzpFhtxakWzjPis+aVldz5ERTyEslB6axT1eLYBPs9uVIcuBvkF5
	 VZtYBHZKRSMFz4439dzA3m9KwZl7r/7o9RkDdIIAKGVCkGGI69dWBHpykvc80J9e98
	 D7Fe9jhM5aZqg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:58 +0200
Subject: [PATCH v4 15/17] slab: make kmem_cache_create_usercopy() static
 inline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-15-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4607; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8MPF6aXbdUIaNsM6rCGkaQsu5CsscD0F2Lvkbk763C4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPHOYd487fKTZzb1T4RE484+Ejn26RbHH7HqspR89
 X8N+T0bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC2crw39fm9y5vhWt7lc81
 rOgSP+6hsrlmx0nlI8KaUU9rYqKlLzL8M8xa73bneNjG24EpL+wmRj02nvFzPZfN95w/rQ8/mJs
 9ZAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make kmem_cache_create_usercopy() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 mm/slab_common.c     | 45 ---------------------------------------------
 2 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8246f9b28f43..d744397aa46f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -265,11 +265,50 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
 				       unsigned int align, slab_flags_t flags,
 				       void (*ctor)(void *));
-struct kmem_cache *kmem_cache_create_usercopy(const char *name,
-			unsigned int size, unsigned int align,
-			slab_flags_t flags,
-			unsigned int useroffset, unsigned int usersize,
-			void (*ctor)(void *));
+
+/**
+ * kmem_cache_create_usercopy - Create a cache with a region suitable
+ * for copying to userspace
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
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
+static inline struct kmem_cache *
+kmem_cache_create_usercopy(const char *name, unsigned int size,
+			   unsigned int align, slab_flags_t flags,
+			   unsigned int useroffset, unsigned int usersize,
+			   void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align		= align,
+		.ctor		= ctor,
+		.useroffset	= useroffset,
+		.usersize	= usersize,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
+}
 
 /* If NULL is passed for @args, use this variant with default arguments. */
 static inline struct kmem_cache *
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9133b9fafcb1..3477a3918afd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -337,51 +337,6 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 }
 EXPORT_SYMBOL(__kmem_cache_create_args);
 
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
-kmem_cache_create_usercopy(const char *name, unsigned int size,
-			   unsigned int align, slab_flags_t flags,
-			   unsigned int useroffset, unsigned int usersize,
-			   void (*ctor)(void *))
-{
-	struct kmem_cache_args kmem_args = {
-		.align		= align,
-		.ctor		= ctor,
-		.useroffset	= useroffset,
-		.usersize	= usersize,
-	};
-
-	return __kmem_cache_create_args(name, size, &kmem_args, flags);
-}
-EXPORT_SYMBOL(kmem_cache_create_usercopy);
-
 /**
  * __kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.

-- 
2.45.2


