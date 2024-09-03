Return-Path: <linux-fsdevel+bounces-28400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4696A04A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A01C230C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFB113E025;
	Tue,  3 Sep 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI5fCg6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6713D245
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373370; cv=none; b=MOkRqy624b1ZNyy+bS1/cbDj2w6f/D16MsoSRv6UFru0U9nY7O09S1czF4UKsZGey2QN0GKS9146RjN/+pftv5/0IMi+A4k5VZs0p+sVsM3PPENWTz+vBu2MWnKHtSbVG6TjUhHgDhnmpYnzXDP7ZNOsTgXxVbHbxV2rp977EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373370; c=relaxed/simple;
	bh=t7al+h/ze5pARsr5Uki/kfE3prWidx+wEHKqUnyvBao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXJGRrfngWzzriuFgpkhPkCYfwWfT3tMfflLsXw9FCUWdNLoLVAoWa2MisYJwIAjE2HXO8j/om2IV3Gz7b/dRNkjwRbJ4iqWON9WBOIJi4aYs6hL5nCCYZvKpVWIRgX07+mkJaF8DxqYPJv+3F8qPc7T+yczo/kTYkt2QwsdaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI5fCg6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E3C4CECA;
	Tue,  3 Sep 2024 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373370;
	bh=t7al+h/ze5pARsr5Uki/kfE3prWidx+wEHKqUnyvBao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GI5fCg6wE9JAbDFx38ntWbqoJ4WArMJXqs+IUMdUmibbQuKyzYDFU7hPngI66qys1
	 84hwKKRC0v19spyU7/Ipnv6ToPmsngH01J4aNuWZq+PqtCMZRclX2BEVtyRnXhuao8
	 fh95UuYYzzM4XjhZ7C/bRmv+10JsT54xgRGHRplcXiB21sYmQ0IYu/ePK7b3ul9xOC
	 bVE1u96ZUhjkwFEFNiTs9fLMZbW45mYXTlJISeY08zRLxaBOtGu8yk6hXqlyYtCPqE
	 2vdul7RHzgcegdYpsD1x+41OOCNSIGvPIrjkKRkOYS089YiaU7mGycV1dG4FvFdDfA
	 gLl9qU5veRI+g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:53 +0200
Subject: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t7al+h/ze5pARsr5Uki/kfE3prWidx+wEHKqUnyvBao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl57ze9V/3sgcXvbTlm733/ZNcmz8HvPm6rLvVVH3j
 H8EMYe97ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6muGfyoS11b0Juc8q/Gb
 ynZ2SvHzuLkblG8F3Fh+ekXt4eVT0sIZ/pfzhm3/rHB5W/Mh18BrNztnn33+9KO/V8eEkCMimUK
 68/gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use _Generic() to create a compatibility layer that type switches on the
third argument to either call __kmem_cache_create() or
__kmem_cache_create_args(). This can be kept in place until all callers
have been ported to struct kmem_cache_args.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 13 ++++++++++---
 mm/slab_common.c     | 10 +++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index aced16a08700..4292d67094c3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    unsigned int object_size,
 					    struct kmem_cache_args *args,
 					    slab_flags_t flags);
-struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
-			unsigned int align, slab_flags_t flags,
-			void (*ctor)(void *));
+
+struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
+				       unsigned int align, slab_flags_t flags,
+				       void (*ctor)(void *));
 struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 			unsigned int size, unsigned int align,
 			slab_flags_t flags,
@@ -272,6 +273,12 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
 					 unsigned int freeptr_offset,
 					 slab_flags_t flags);
+
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	_Generic((__args),                                              \
+		struct kmem_cache_args *: __kmem_cache_create_args,	\
+		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
+
 void kmem_cache_destroy(struct kmem_cache *s);
 int kmem_cache_shrink(struct kmem_cache *s);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 19ae3dd6e36f..418459927670 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -383,7 +383,7 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
 EXPORT_SYMBOL(kmem_cache_create_usercopy);
 
 /**
- * kmem_cache_create - Create a cache.
+ * __kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
  * @align: The required alignment for the objects.
@@ -407,9 +407,9 @@ EXPORT_SYMBOL(kmem_cache_create_usercopy);
  *
  * Return: a pointer to the cache on success, NULL on failure.
  */
-struct kmem_cache *
-kmem_cache_create(const char *name, unsigned int size, unsigned int align,
-		slab_flags_t flags, void (*ctor)(void *))
+struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
+				       unsigned int align, slab_flags_t flags,
+				       void (*ctor)(void *))
 {
 	struct kmem_cache_args kmem_args = {
 		.align	= align,
@@ -418,7 +418,7 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 
 	return __kmem_cache_create_args(name, size, &kmem_args, flags);
 }
-EXPORT_SYMBOL(kmem_cache_create);
+EXPORT_SYMBOL(__kmem_cache_create);
 
 /**
  * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.

-- 
2.45.2


