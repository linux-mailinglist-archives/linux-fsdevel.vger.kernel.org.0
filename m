Return-Path: <linux-fsdevel+bounces-28508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1A96B741
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86881F25D32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E01CFECC;
	Wed,  4 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVF3VDs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8471CFEB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443106; cv=none; b=b7Asr9E4zfjj2n7VhCrNYRfKWJiTTGDMiR0krZ7l4httWTy6CeiN4hlnVXa/3f8Bdveq5ybOeph6oVSxDbL5/tjJEmEb+PT81h1d0MUSm1LLdPTCPiaZkaigAULcj/fb0ISSXHVMESdDbr8DgtBljVitXn3uDt87wtCpktPCZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443106; c=relaxed/simple;
	bh=0TbYaIlAyW4MAXY6VAEmQDqD02yJBCeFBP+TG2hljGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1OpPFfCR2/4cd1coUnCZggVYXNPzJczluZN+yY+azot3nOfTLPdPkc8ZZjbxSJxvdIir9WpS+x0ZExaDnUemrFUjWGZA8sLl8Y7J2sMMDxYcVUqh6SR+nbZAUJIHrPUZ3E2l8eLV1YKeZrpPOaTA4FFLDdr6dN9U5hmgNyo3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVF3VDs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA1C4CEC2;
	Wed,  4 Sep 2024 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443105;
	bh=0TbYaIlAyW4MAXY6VAEmQDqD02yJBCeFBP+TG2hljGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVF3VDs06NfHifXprvecTcWgLyuIjjOZODyuarPgxP4k+4vZj9Xvac302QhHxQeFf
	 SMQSApucUVdM5guUbLcRTK+D6jcI0qdJYKZUalyVBJsy74gWc03qlsaiVmQo4xikpD
	 nW/CL8mNiZIDP3px2IzsFjRlmY9j7nzh6mru0N6b+KWsQK/8QyuBAJDVYtNlqKflUq
	 BE/FQ5IOUMrUUYEqrby/6c/0gqocPGDoQDpSP+IXhm6mVY9M9SCUb/YwGmLUvGaG8G
	 eGoLpj2P045rIPlI+sErjowEbWQ5Ly/NNOE9Inacod2qPzKBy4GeJv4+SCLYhVLeiY
	 mPpxMxhaLJysw==
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/16] slab: make kmem_cache_create_usercopy() static inline
Date: Wed,  4 Sep 2024 11:44:12 +0200
Message-ID: <20240904-schieben-hochdekoriert-5808b31c9f3c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZtfssAqDeyd_-4MJ@kernel.org>
References: <ZtfssAqDeyd_-4MJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4667; i=brauner@kernel.org; h=from:subject:message-id; bh=0TbYaIlAyW4MAXY6VAEmQDqD02yJBCeFBP+TG2hljGY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd0BG+rO3986DXU820qgiOTJEnO9YVrd7wYtHurnA9R tmApL2rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7A4jQ7OAU+ayqjzZul8G QT//LpjBHWRtfqo5/4rC7ZWR83YE+DIybLuTcbRC6kxAqeDRsDk7rxd+XrexYlb/jxWVkq7nf3N nMAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Make kmem_cache_create_usercopy() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---

Based on a suggestion by Mike.

---
 include/linux/slab.h | 49 +++++++++++++++++++++++++++++++++++++++-----
 mm/slab_common.c     | 45 ----------------------------------------
 2 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1176b30cd4b2..e224a1a9bcbc 100644
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
 
 #define kmem_cache_create(__name, __object_size, __args, ...)           \
 	_Generic((__args),                                              \
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


