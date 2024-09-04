Return-Path: <linux-fsdevel+bounces-28525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FE96B83C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB9AB26CF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7E1CF5D7;
	Wed,  4 Sep 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhZh9DXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1514658C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445359; cv=none; b=kwq34Fl+VHggO0u0HZh1LQlBxwfD2WASYMhS8dR0BylqvOXeLDu7CNQmzteoYEpIhEzW2drwJioBXoSU8xSWifEJAoLJOzIJ5DWXR5MR4y1rx3psxPBMOLFnGrd7dv09qiTq0VQ1MVljnMh2fE25azRXr1Jbr9n5JpWLlU94+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445359; c=relaxed/simple;
	bh=dnwP/c5HlqpuuYs6TocRpCymaBfpftG+kdwK6XKc1E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcQ1ML2zOFl/HO7j86JudRwFGHyodyFkxJyW5MmPt33lzqHBVMRc3HVzaqvKY4X1ehMEQyXQH4hFcGtJt7A5HbPugQF6dv4u52vh0/0pgIvrrTy36Vkexlb/03Oj5nBRH8V0N20xeVisTZVSjIIxo8c/gj+aj5oh+baPphoHCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhZh9DXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26DAC4CEC6;
	Wed,  4 Sep 2024 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445358;
	bh=dnwP/c5HlqpuuYs6TocRpCymaBfpftG+kdwK6XKc1E0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhZh9DXpXCPba9MpQZVKOy0Ru27OS0HEskSXwAoDug2DUBzvgpz64S98j7Hw1t/bC
	 BVj+HYC6e8qqlAqINxPAkWw3OhJM3Ou2+TOjNYfe+EPeKyLXxkaN31I3Uo6sUMGr+9
	 MmCk+iSDrssxm7ruDUw4wx6fAOPkz/++IWZjV1gD66ymm4gV9WFq+aOJGQH309H/7M
	 EFpGvoa7aVx0dDTnBfaX01Bd5+U3LjFbuYSjbLn/nqf9tHWtEepUycPqo+VXfDFM8L
	 9BehLMX+Y0F3ogbV8kHXUl0vnhsfc0ExXBSSmNz5GI5GDFX0yUHmZeScAnze6TYIEU
	 NN53xl5rTni6w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:17 +0200
Subject: [PATCH v3 12/17] slab: create kmem_cache_create() compatibility
 layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-12-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dnwP/c5HlqpuuYs6TocRpCymaBfpftG+kdwK6XKc1E0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNl15rbBxssX1ASll7Ntr2iuelPPt6tHsviFY87f+
 97vVoi4dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk7g2Gv/IhxWev+F9Q+PAl
 1O+De+AROQ+p2wpTl6p7Js2erjNNvoLhf7Z27Q3zJWyBfJVrtRhcdZ/UPjV03BB5ksl+6sHqBXl
 5bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use _Generic() to create a compatibility layer that type switches on the
third argument to either call __kmem_cache_create() or
__kmem_cache_create_args(). This can be kept in place until all callers
have been ported to struct kmem_cache_args.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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


