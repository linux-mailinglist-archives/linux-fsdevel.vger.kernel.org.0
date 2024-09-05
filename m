Return-Path: <linux-fsdevel+bounces-28678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A375496D0FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D3C1C22D23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10C3194A66;
	Thu,  5 Sep 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlCvUk1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41133193422
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523032; cv=none; b=Uanp1ed7OwbUBMOvUijsgKHlHmlHGE7x+g2GAHMOHiPzjBPkmQJAk4WvATmuJ1BgnHT8Ykoy6u8k6+wZ3JSs7y3hGJZwYr1fZ81cAe7V98WYgcB4FlOTJMu1KvGSCZlqcVIXd/We+w2/Pm9Y1FZDZHdR4AGa1TTueYoOmVc+REI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523032; c=relaxed/simple;
	bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MV4zB1H9mkPk0Ox4VOJkPtnktDW8zu1y+eWpI3t43bWZlrO+sYoymWBhoqy1aZ2RBmNRbP9WjPzvMq2BunjKKtAGV9dGWnSCaZfbN4lOPjVFNLYIktIbV3BW1oBVrJEdeH3ZOlFHww9oXkIBtxUI+AdBXXe9EAekQp84hZmkFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlCvUk1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639DFC4CEC6;
	Thu,  5 Sep 2024 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523031;
	bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RlCvUk1aAW1A2PTD5pA5BLm8yKdG5h9Nt+M5LC6cKKQZe2I8dRntcu8FyPewu3x5J
	 bPbBpiEdveTRgdl2rDXE02u69/PKcGxp4H2uFl4dCWQx0k4W96+0wwJ7e2MpqqErjU
	 jiLHLqE0gCi9Iivb/u2ycl8NEWOIb4HS+0v/dgFWitb1THmhvyhD6XJXIOa/u9H+tv
	 oLqtkwQfqy4mhDvTn2hhvtXkhRKGd4M5lIJIBbRIB7cH1wYLawsCDoihg623L76PHv
	 0ze59QHEhOpVT6y4uckiaW2M9CYoVqFlWcG1cYyb/+yuXiGNA2MakauPnqCJhQ3vg9
	 v/eKzN6tnn1Xw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:45 +0200
Subject: [PATCH v4 02/17] slab: add struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-2-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPFSL7jxYpd08eYXgeIGe5bWCPKWVF16ZvHq2XwLa
 363/g6djlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlozWb4zbI7r2Llq6MVPNum
 sxuH8z9azFfQ4R4//xLr78mf5jW9s2Vk+LRC82SZM8PUuc8EzDzOe63d90G9/pLulPkctmbFkdN
 7+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently we have multiple kmem_cache_create*() variants that take up to
seven separate parameters with one of the functions having to grow an
eigth parameter in the future to handle both usercopy and a custom
freelist pointer.

Add a struct kmem_cache_args structure and move less common parameters
into it. Core parameters such as name, object size, and flags continue
to be passed separately.

Add a new function __kmem_cache_create_args() that takes a struct
kmem_cache_args pointer and port do_kmem_cache_create_usercopy() over to
it.

In follow-up patches we will port the other kmem_cache_create*()
variants over to it as well.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 21 ++++++++++++++++
 mm/slab_common.c     | 67 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 5b2da2cf31a8..79d8c8bca4a4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -240,6 +240,27 @@ struct mem_cgroup;
  */
 bool slab_is_available(void);
 
+/**
+ * @align: The required alignment for the objects.
+ * @useroffset: Usercopy region offset
+ * @usersize: Usercopy region size
+ * @freeptr_offset: Custom offset for the free pointer in RCU caches
+ * @use_freeptr_offset: Whether a @freeptr_offset is used
+ * @ctor: A constructor for the objects.
+ */
+struct kmem_cache_args {
+	unsigned int align;
+	unsigned int useroffset;
+	unsigned int usersize;
+	unsigned int freeptr_offset;
+	bool use_freeptr_offset;
+	void (*ctor)(void *);
+};
+
+struct kmem_cache *__kmem_cache_create_args(const char *name,
+					    unsigned int object_size,
+					    struct kmem_cache_args *args,
+					    slab_flags_t flags);
 struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
 			unsigned int align, slab_flags_t flags,
 			void (*ctor)(void *));
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 91e0e36e4379..0f13c045b8d1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -248,14 +248,24 @@ static struct kmem_cache *create_cache(const char *name,
 	return ERR_PTR(err);
 }
 
-static struct kmem_cache *
-do_kmem_cache_create_usercopy(const char *name,
-		  unsigned int size, unsigned int freeptr_offset,
-		  unsigned int align, slab_flags_t flags,
-		  unsigned int useroffset, unsigned int usersize,
-		  void (*ctor)(void *))
+/**
+ * __kmem_cache_create_args - Create a kmem cache
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @object_size: The size of objects to be created in this cache.
+ * @args: Arguments for the cache creation (see struct kmem_cache_args).
+ * @flags: See %SLAB_* flags for an explanation of individual @flags.
+ *
+ * Cannot be called within a interrupt, but can be interrupted.
+ *
+ * Return: a pointer to the cache on success, NULL on failure.
+ */
+struct kmem_cache *__kmem_cache_create_args(const char *name,
+					    unsigned int object_size,
+					    struct kmem_cache_args *args,
+					    slab_flags_t flags)
 {
 	struct kmem_cache *s = NULL;
+	unsigned int freeptr_offset = UINT_MAX;
 	const char *cache_name;
 	int err;
 
@@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
 
 	mutex_lock(&slab_mutex);
 
-	err = kmem_cache_sanity_check(name, size);
+	err = kmem_cache_sanity_check(name, object_size);
 	if (err) {
 		goto out_unlock;
 	}
@@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
 
 	/* Fail closed on bad usersize of useroffset values. */
 	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
-	    WARN_ON(!usersize && useroffset) ||
-	    WARN_ON(size < usersize || size - usersize < useroffset))
-		usersize = useroffset = 0;
-
-	if (!usersize)
-		s = __kmem_cache_alias(name, size, align, flags, ctor);
+	    WARN_ON(!args->usersize && args->useroffset) ||
+	    WARN_ON(object_size < args->usersize ||
+		    object_size - args->usersize < args->useroffset))
+		args->usersize = args->useroffset = 0;
+
+	if (!args->usersize)
+		s = __kmem_cache_alias(name, object_size, args->align, flags,
+				       args->ctor);
 	if (s)
 		goto out_unlock;
 
@@ -311,9 +323,11 @@ do_kmem_cache_create_usercopy(const char *name,
 		goto out_unlock;
 	}
 
-	s = create_cache(cache_name, size, freeptr_offset,
-			 calculate_alignment(flags, align, size),
-			 flags, useroffset, usersize, ctor);
+	if (args->use_freeptr_offset)
+		freeptr_offset = args->freeptr_offset;
+	s = create_cache(cache_name, object_size, freeptr_offset,
+			 calculate_alignment(flags, args->align, object_size),
+			 flags, args->useroffset, args->usersize, args->ctor);
 	if (IS_ERR(s)) {
 		err = PTR_ERR(s);
 		kfree_const(cache_name);
@@ -335,6 +349,27 @@ do_kmem_cache_create_usercopy(const char *name,
 	}
 	return s;
 }
+EXPORT_SYMBOL(__kmem_cache_create_args);
+
+static struct kmem_cache *
+do_kmem_cache_create_usercopy(const char *name,
+                 unsigned int size, unsigned int freeptr_offset,
+                 unsigned int align, slab_flags_t flags,
+                 unsigned int useroffset, unsigned int usersize,
+                 void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align			= align,
+		.use_freeptr_offset	= freeptr_offset != UINT_MAX,
+		.freeptr_offset		= freeptr_offset,
+		.useroffset		= useroffset,
+		.usersize		= usersize,
+		.ctor			= ctor,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
+}
+
 
 /**
  * kmem_cache_create_usercopy - Create a cache with a region suitable

-- 
2.45.2


