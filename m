Return-Path: <linux-fsdevel+bounces-28509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403F96B75C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD5BB28469
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B31CDFDC;
	Wed,  4 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaHKAzf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE91CFEDB
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443111; cv=none; b=hMSwhyMtNLpc5jpSmSYxrk+Z9WK1hzvhszN3+XgG72PrhHH6kfbv5HhVdvy7m6OKNCet2aMNBmhb7aoiEf5wQjlOF0qlO/j1hb5Cb+6kqo5UWcaWsLL/ZIfev6+A6tNjQRqFOrfbiZj/hxEF+dlUO6NOhhrMAjlEcHC1qVkpnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443111; c=relaxed/simple;
	bh=7VgDRqmx+Ik8PykBNr2uZycRwWkeQDI9rAEBtMLW9VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trTshTu9eACTogKGu5ZWCb312wc2fYfS4GFRS7XtWqKhJveJkBvH9IHpUn56mfDAh7zbIKEHOVCi8NfK88VSk/3ZdGQs5UX8RhwIfTeaiCd98x152ciRauD93X+JGN9ovs7dyCRKHYerkhCP9cFSU+IC3SLSh1I5chZsnwh7bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaHKAzf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069EFC4CEC6;
	Wed,  4 Sep 2024 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443111;
	bh=7VgDRqmx+Ik8PykBNr2uZycRwWkeQDI9rAEBtMLW9VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaHKAzf8okC6RU4aD7r1kxRBPo9J7x9RVLEC48KyPy09U+bjdje9w/zcKoVpSmmbZ
	 rOgU3bOVzYctw3312c/F0/WwpAj66C9a38684ytJMa8Hrog29r0d9QYHpW9BwyhoI6
	 wBYn4U0GzuPu7/YzspnHirYqpZTSZJPvyDf3jtmSHWtLE4htf79AXAUL8212SfeyDK
	 CdyMaELAUHfDxolnpeWUcE7lZVwsPIWXvvFNWdOIbtdVdlxMkMAyAUuX2Hm7XveCkp
	 HwGSzTJ5FS/CUyRmAHZ0BXEwcxCENhJDGtTs9lt/UH76agLfcmxUlodk7rBGTISiW3
	 h43WhOluJ5m0A==
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/16] slab: make __kmem_cache_create() static inline
Date: Wed,  4 Sep 2024 11:44:13 +0200
Message-ID: <20240904-musizieren-zicken-ee74f5e5c49f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZtfssAqDeyd_-4MJ@kernel.org>
References: <ZtfssAqDeyd_-4MJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3824; i=brauner@kernel.org; h=from:subject:message-id; bh=7VgDRqmx+Ik8PykBNr2uZycRwWkeQDI9rAEBtMLW9VU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd0BFhe/srK/NTn35KxZew11HWU8T2MFgstl+yePoyD Z+Fm55/6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIocOMDA0bbF7+rXCR+m2c PHXVzGNP1csiZIqPtq36dMLy9A0tDWaGf0bR/H6NT3+uS2uxMH774l+o6qNrZgaRf9vepD/c4mo rwQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Make __kmem_cache_create() a static inline function.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 39 ++++++++++++++++++++++++++++++++++++---
 mm/slab_common.c     | 38 --------------------------------------
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e224a1a9bcbc..3e16392fa37f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -262,9 +262,42 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    struct kmem_cache_args *args,
 					    slab_flags_t flags);
 
-struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
-				       unsigned int align, slab_flags_t flags,
-				       void (*ctor)(void *));
+/**
+ * __kmem_cache_create - Create a cache.
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
+ * @align: The required alignment for the objects.
+ * @flags: SLAB flags
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
+__kmem_cache_create(const char *name, unsigned int size, unsigned int align,
+		    slab_flags_t flags, void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align	= align,
+		.ctor	= ctor,
+	};
+
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


