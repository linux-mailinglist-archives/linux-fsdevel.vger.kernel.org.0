Return-Path: <linux-fsdevel+bounces-28528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E09A96B83F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8290F1C20B82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62C1CF5E5;
	Wed,  4 Sep 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDGa/Ivc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F11CF5D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445370; cv=none; b=d0krS8K11Qs9ensFiDIdiWtiVtroqZm0mRYVT2zA7E2i62tuVO9WUc5ewB5ifg7E0VEp+YEEiEIDDi6pmJiS2Hv73aTxAZBjvTB2grrzjPmeroIiJwXjqjMS4sWUicCH01lhsbCKscv1wYTkG1vaNHV1rIJt+bSfw8Tsw4s559Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445370; c=relaxed/simple;
	bh=otBPVDb5wSFqFX+emtlwUyqyvPQGIcX7yx9PMQsOqjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1yU1f6E7UbhUmxxm9i1QcYtA76zyFey1Ex+Qp32dcSr5fkuNLAQRNlEloOixPH1lYLvBcZ++JoBLvHd5agTAW9GBW9TcsgAfl3au9J2Af54lBvop9IROJsag5q1x6k5hcVDR92IatQYG7jRTy+6opCYZoVnHr0VSppOF4AbhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDGa/Ivc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F27C4CEC6;
	Wed,  4 Sep 2024 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445370;
	bh=otBPVDb5wSFqFX+emtlwUyqyvPQGIcX7yx9PMQsOqjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bDGa/IvcMSu4GQ4Irqb6p7xSlqntR0jiy/9X9+lLUcAnsYW4ttuniVZERzqaXh1Ud
	 L5gf8yBN5UrenlR2eXCqo6BbRFAIaCB3HS3bV6FfMmD5e7Hqls1vAKAXTJzFrET2yd
	 FmjH6Vci+98N//pLFtJiUJbDjmPzo5QXksmnLpMHV54wVjSgAK49ZZ81Te553Me8IL
	 62zOQ5vI8sERsbwrxVrAcjY02sCf/wPLkcUo0KNao3wJxWXMxsgvvXxx4uSN+6XxeB
	 f+bf1rb1OTj7j3A3Yy4zzHM7G2px1cBaa4TlMgvyO5h4+KNnEJ34t/hrIibFJufYrC
	 GFx5Z2ilhYzFA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:20 +0200
Subject: [PATCH v3 15/17] slab: make kmem_cache_create_usercopy() static
 inline
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-15-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4638; i=brauner@kernel.org;
 h=from:subject:message-id; bh=otBPVDb5wSFqFX+emtlwUyqyvPQGIcX7yx9PMQsOqjw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm97Phk78obioayNwPatj1TMDp+ZF9VYkVXH/O+B
 /Jt7LurOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby05ORYcKJiwsts2xFFzUX
 ugcwrBC8HHNuub3Sn9Q1jwL0kzvnP2X4n9DQlrdkZt8qM0XHb44egXPmcayWS+TjN9y5yis1Zgc
 zFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make kmem_cache_create_usercopy() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 mm/slab_common.c     | 45 ---------------------------------------------
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


