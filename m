Return-Path: <linux-fsdevel+bounces-28684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3D96D103
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9721F2685C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F5194C8F;
	Thu,  5 Sep 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCMJJsA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EC1940BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523055; cv=none; b=SF37XR1oSqip3fsZw7skTSroNNN8iybAcuUSShjoXjJ4vWKInyoBjtpVrAXtQnjOMe9y8VBmrwzj2EPJC3UEbAEpzP6EcqfE4ZLlnZJmxG8p14cgjq7JdYEjHcHpi6dc5tEKrrJhpLdWLkysye3ACHmx0XhODMdiqV24FUJGqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523055; c=relaxed/simple;
	bh=68ks3+RK7luxREXLt0gNfsWbQ+8I8NfI8y27/qM8GTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGqnz/J9zTWoqRYAHr6iumLlhWtR2vo/RYrj4Vg4fIUY8a0m25kjSbOdvpsqvM1rzPjb5TglfrA098JWKFkgcnwvhON37ps2/z0TZT1RXUGsa8OqoQzquykDnUOW5+lfBtsfSsUDCP3txUraAN48VsKt5GwfN5mxtzSFicdszl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCMJJsA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B9FC4CEC3;
	Thu,  5 Sep 2024 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523055;
	bh=68ks3+RK7luxREXLt0gNfsWbQ+8I8NfI8y27/qM8GTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lCMJJsA2FYQgZ241Y/sVm4oECKak0msryTpe6Sxy0xhPqrJ4bz+KhoUhxL14XWa1c
	 7E+aemB9oTGTfc5vf7ZjV6+34ksKJNjfyrwdWGGVBINGAM5bGQEHyfHw0aanRFgDfr
	 95fU5OABVDgKWclGHd20xyuZDsq+ffWmV7zDnzjhyo5D2a+9PoWQZhHl9tt8+dkT7Q
	 UJVo/ISOhmxyzB8f/ZerRvzWyNLDq9UE4WkJcK7GI/AN2FVNQ96k1gBj2pqV6egzIm
	 iGbxOz4BJ5tXpM1QhItXBzVswa4b1k2vJkjww2yuXsrYFWrJ7pQlGvB8rpGUrNO8TA
	 TsQJqs2fi09KQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:51 +0200
Subject: [PATCH v4 08/17] slab: pass struct kmem_cache_args to
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-8-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=68ks3+RK7luxREXLt0gNfsWbQ+8I8NfI8y27/qM8GTo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPHe0MpoGSi7d66U3P/akqWzzBdPLC8ol1nexlAr+
 ncn67pdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZeoPhf8l6tcjWzRWT1WbF
 3H4W5XN1Ert36Ee5VbJvw3KvM/h5v2P4xbzkMcfhuDniFefderU3aERvNT+tKWEXWZq1K9iyqaC
 YBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and initialize most things in do_kmem_cache_create(). In a follow-up
patch we'll remove rcu_freeptr_offset from struct kmem_cache.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab.h        |  4 +++-
 mm/slab_common.c | 27 ++++++---------------------
 mm/slub.c        | 17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 684bb48c4f39..c7a4e0fc3cf1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -424,7 +424,9 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
-int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
+int do_kmem_cache_create(struct kmem_cache *s, const char *name,
+			 unsigned int size, struct kmem_cache_args *args,
+			 slab_flags_t flags);
 
 void __init kmem_cache_init(void);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9baa61c9c670..19ae3dd6e36f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -224,20 +224,7 @@ static struct kmem_cache *create_cache(const char *name,
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
 		goto out;
-
-	s->name = name;
-	s->size = s->object_size = object_size;
-	if (args->use_freeptr_offset)
-		s->rcu_freeptr_offset = args->freeptr_offset;
-	else
-		s->rcu_freeptr_offset = UINT_MAX;
-	s->align = args->align;
-	s->ctor = args->ctor;
-#ifdef CONFIG_HARDENED_USERCOPY
-	s->useroffset = args->useroffset;
-	s->usersize = args->usersize;
-#endif
-	err = do_kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, name, object_size, args, flags);
 	if (err)
 		goto out_free_cache;
 
@@ -788,9 +775,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 {
 	int err;
 	unsigned int align = ARCH_KMALLOC_MINALIGN;
-
-	s->name = name;
-	s->size = s->object_size = size;
+	struct kmem_cache_args kmem_args = {};
 
 	/*
 	 * kmalloc caches guarantee alignment of at least the largest
@@ -799,14 +784,14 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	 */
 	if (flags & SLAB_KMALLOC)
 		align = max(align, 1U << (ffs(size) - 1));
-	s->align = calculate_alignment(flags, align, size);
+	kmem_args.align = calculate_alignment(flags, align, size);
 
 #ifdef CONFIG_HARDENED_USERCOPY
-	s->useroffset = useroffset;
-	s->usersize = usersize;
+	kmem_args.useroffset = useroffset;
+	kmem_args.usersize = usersize;
 #endif
 
-	err = do_kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, name, size, &kmem_args, flags);
 
 	if (err)
 		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
diff --git a/mm/slub.c b/mm/slub.c
index 30f4ca6335c7..4719b60215b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5843,14 +5843,29 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 	return s;
 }
 
-int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
+int do_kmem_cache_create(struct kmem_cache *s, const char *name,
+			 unsigned int size, struct kmem_cache_args *args,
+			 slab_flags_t flags)
 {
 	int err = -EINVAL;
 
+	s->name = name;
+	s->size = s->object_size = size;
+
 	s->flags = kmem_cache_flags(flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
 #endif
+	if (args->use_freeptr_offset)
+		s->rcu_freeptr_offset = args->freeptr_offset;
+	else
+		s->rcu_freeptr_offset = UINT_MAX;
+	s->align = args->align;
+	s->ctor = args->ctor;
+#ifdef CONFIG_HARDENED_USERCOPY
+	s->useroffset = args->useroffset;
+	s->usersize = args->usersize;
+#endif
 
 	if (!calculate_sizes(s))
 		goto out;

-- 
2.45.2


