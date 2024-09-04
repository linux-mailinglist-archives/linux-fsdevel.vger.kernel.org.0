Return-Path: <linux-fsdevel+bounces-28515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB096B832
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258641F2152B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FD71CCB29;
	Wed,  4 Sep 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1y/uMG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518B1CC89A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445319; cv=none; b=KZwGEW9IYXtFMptTOl8U30V7WhlL7lXLlLubgTbb+XWclYJZqz9MZuqaFBk+r72WvgQ+acwk+UB8F8vRZqJbtViN5ojIQOJgcWfjSxHj3cUfHdeJtk/5jyv4z/E6E45fYcwtZo3nHUS6rhVw/U56WzDn4zXi1tgA3x6bBNjSNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445319; c=relaxed/simple;
	bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6GY2X9V1HSffBxvSv8R2ULKxKDiU+AzlsS0Xv0TVBp6MVkWMkli+y6A9tIhBBjl/EL79Znua3OfN5R7HxTsb05lGVxV8Tr+MTRie7f1BwaAn/d3+U+GPEavnK1Fz8p8xytfObEOxu8PqDDkUfGpTy/XxFJDmTPYU8ip+REUb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1y/uMG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB0C4CEC6;
	Wed,  4 Sep 2024 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445319;
	bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R1y/uMG6e0aaQJlJr5qnvCpHQ3FGR8xCSzgrJj43XHhClJcTH4aQgaRS0vIgoHBt1
	 jw1g4OsII1pDgv1IGB/YhIhdBx2fO2Ffq3uhe3aCPNGgyPcF/W3VCB+Q7u79OOzaUD
	 cVhFkmhqSf5uA3i4oRlL38Oe6CMmbIMWymgqw+7gO/ElkY7Mp2Bac/wpTba6o4VAZ/
	 jEZvnnO9LHyDpghOuFNmjRsPUZl40k3dCPjCFn3294/WQRCsfb7Y6FnjVZQwM8XgOS
	 y4FhlZBWVAFW601oThoHu20D5kW0/nsSXsajbVjzMdaPQqDh3LPyIF+xk17yYUY9Wj
	 WbK8uxxKCt+AA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:07 +0200
Subject: [PATCH v3 02/17] slab: add struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-2-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YrF0YLTWmhzO7ohK2/AAEF++N1Zrk2GGMPwzT5f/roQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNn5Zy1b43m913E1vBfFXhlN6hf4K6t8o4d1sZH0D
 NOX0RkaHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxncrw32W15y+9mCesh/rF
 jnjanXMQy1z6QeRw3pwetYV7bfi1LjMyfM0T6tlg35cW4vT058FtGzhnW3B/aNK0zY/a8sgoNP0
 6MwA=
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


