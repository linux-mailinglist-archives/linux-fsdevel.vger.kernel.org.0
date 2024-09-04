Return-Path: <linux-fsdevel+bounces-28521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C396B838
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5011F2173E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28551CF285;
	Wed,  4 Sep 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2CX6esi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2F433C8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445343; cv=none; b=dOWUb3yW+x5Hi3XbPLRnlMd5XzA8TqqYMorFVQoHKaBDCqs+UMzC1dKCt00I8O9kzEYwkiWA5r91qZmsljaFgCdijRklJuanHkySSW5TlVNZwQJZBzat8dXRVO/geAvj90rCXN1rCCvQTaIo5IflCilz7jmYpN72Vkoh4DE3YlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445343; c=relaxed/simple;
	bh=Lf0x5OF2wU4gj/MS9gGKSdAWPtAXYg+UCtXI3xTY+oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEmy0ZzvhbTqse38zTGZqpnSoEvnwllAiI3KeFsAdjoMqYRgSkccpKCpVDbFO3iQfevUlfp04w1DSlQedV0XpKfRzfHihqoN2avG/JEhqDKeBJt8Z8Ijh+F80YJtYDhDyx9brLv3UX0C5cWtXtCem/W2so3TxwM33i+cUzaeI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2CX6esi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5504FC4CEC2;
	Wed,  4 Sep 2024 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445342;
	bh=Lf0x5OF2wU4gj/MS9gGKSdAWPtAXYg+UCtXI3xTY+oM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2CX6esieR2DSrAm/zlh8hGQRtYTUzTrBeRwPO4dtam+p9PJiYfG34rAxs0jMItFa
	 cOl2HPnbM7Ctg0Hs636nvcXa0OH8jdpw76Pu6lDoc32JoJjX7kyHUu4wHEzLpsfyyW
	 lYLPJETA7CzrJI3yMFTjxAGcUudA9zwJavBSnj39Nu7hjByuCpXZGz0fzWsyFJEgI0
	 pCXrMQuJqu2DWDPxk2rTXSaC2wvegM1eoS4ZR+atlIyIqKiEJtfQSOm0YkyEWBnmlq
	 VX8QOQWnaX6kz6xvhOCUP5lXZP0Ol7wkQWdBTPg+Z51NwMZ6G5hf1J0Fck4Wg3SmoY
	 Cau2hk1OwJSBg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:13 +0200
Subject: [PATCH v3 08/17] slab: pass struct kmem_cache_args to
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-8-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3919; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lf0x5OF2wU4gj/MS9gGKSdAWPtAXYg+UCtXI3xTY+oM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNl1+96yN7XuIidXBs55eepY8tVfXOd+KTMHvNO3z
 D1WGHAut6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAisf4M/zSZEzhbP0dUxJov
 OM0mnnX6RPbX2bdmNPX+Dz/1tjzplirD/5QuHrUktw1HP5dd3Mr0Xr8gq9tjo7WD85GFlvdMNRl
 4GQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and initialize most things in do_kmem_cache_create(). In a follow-up
patch we'll remove rcu_freeptr_offset from struct kmem_cache.

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


