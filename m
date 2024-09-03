Return-Path: <linux-fsdevel+bounces-28390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859896A040
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1C5B23AF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731A80C02;
	Tue,  3 Sep 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQJr2KSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047186F315
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373348; cv=none; b=nyCnJZziJAYiq1y8ZT2KhFf4xjfPXUsyvmJFmrM/i7IidppEusKsRkxmax9Kuyp779N1MFYjAgdO7GoZtL1MlMbPJYauzKRoGmnSI7IQYKxUY4VuMWSroJK0PEn2TaNcGW7TzQxGibp/+KDX5Pd8lrmSZbqfVTumEqp6E38BqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373348; c=relaxed/simple;
	bh=2h5DOrmEliYOEskMyLdOlS+a422lNEm7iLYnRuCn078=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEs10oCvu6StLC8czoUi8Aif5yMdRqqN6mIraI4sFJLw4HOa/Ai6GhLkatiEMzbr5zCszJJz3RHTFyAmi0gZzBqAUFUuthg/TGaL+EWXZeMKnC6cxIyTwQPc37iXqRCGQM/42H+SzpcwO9pZpjR1Dhu5Dden0P/wqiUjc9a+d/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQJr2KSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D032DC4CEC7;
	Tue,  3 Sep 2024 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373347;
	bh=2h5DOrmEliYOEskMyLdOlS+a422lNEm7iLYnRuCn078=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQJr2KSYx/rknS/FfpX+JxiEROKLTM5PnAYZ+o7XEVv6NgP3Ss7tjJhNVLJDjAYmg
	 V1w3/5f+g0CdyNTOTYOk+MyMT016PpeTQSQ9CVWlQjEmYiiidRhd5oBc/sSsG1zBIa
	 e2QfgbzfX02r9yFo7QRX2G58gqj7RaPb+Tur00aybamWoo1hRqz8NyWQLbQXnL5bTq
	 9TJ8oEHrOK+F3C/N/OCCnqLEonwIvdHgPRKO+9swiWGr5ikMlWxa7lOaY4WvE2YHLg
	 NAXHIZBEH3+euJk3IsDszxZJDMupI0XClXyaDEV4YW6f5o0YzZ0GNF3IuO1vHXJZhy
	 CdnYHOYX2nb8w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:43 +0200
Subject: [PATCH v2 02/15] slab: add struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=5053; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2h5DOrmEliYOEskMyLdOlS+a422lNEm7iLYnRuCn078=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl559e5Opz1zVj/eFzHY8dLq47YuR2uY7dlX5wfVT8
 wO/B7+80lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRgrmMDJvP/rf4f7iw78yF
 f8xdB6L/NnxZxs9957/CyR9zXj9dJerAyDC/eIqDhMKq5ZGlvj+2LF9+QOFBocTslZo74hdGpq9
 /+YcBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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


