Return-Path: <linux-fsdevel+bounces-28520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8096B837
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99751F21540
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D901CEEA7;
	Wed,  4 Sep 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHNDkNyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58187198825
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445339; cv=none; b=Pbg92H0jGZe8/MzDKNUcMN5jWaXGpt/AEy5dspCg6YIGrMW68gz4wWhNJIM4cezb1lw2vFNYh4A2xf8BOHcofPLBVvi9ItO9YdtyFvY3tSKLzEJpp0HiCt5PW/vPV82hh75XDTno8fgSYAqhtaJEpCHFDPmViI2QeiRh8rCuIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445339; c=relaxed/simple;
	bh=XvA3OjNvZTXuO+1s1Yt+F4vUj5bmDXzlHdYPfx3s9dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDafSapCqxqmbITlI6NuyKWu6Ah8hWsdsPSeXPttRLMzjTQbQByoI/YWvhUkFb8ECBnc554gyZxSBfUBhfksW9IJzCtZpiQOTQRCV8dHktPiKEz0JmlIwmEdD/zHLCgtbsDhj8gwhx8Den5g+c0m/32C0T1cJQ5ZL7UOwtk14lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHNDkNyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF6C4CEC8;
	Wed,  4 Sep 2024 10:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445338;
	bh=XvA3OjNvZTXuO+1s1Yt+F4vUj5bmDXzlHdYPfx3s9dQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHNDkNyof6PXzmIXAY/8Nxv2qxyJEp6i9DMdtkFlhAvTa/5gvBP4elVrdQWCQbs/g
	 UqHo6xYX/3ja7Mla50VPP7g0eWGgcGcFZPdp6Xe/K9ksOQzVGHjDcZ/x/lg9hZrpI4
	 w7jrv19fpk/YrutcUmR+3sVhnY1AW/KTGxJ3a8PzpMu42uUBzCanWtarU3eHK/6i3w
	 GB39Wfo27w8EWKr07F9s5ue6ob2fFV97Z/9RKVmKTXiCez04wM5+4dsdQkfyKvkXPn
	 mGrUwTUx6TgmWhjgdb/JXbR9H/VGapduDWqswy7FQXdvKM3csBKfacz50Nm1GSP3J2
	 tLntU20O+Ds8A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:12 +0200
Subject: [PATCH v3 07/17] slab: pull kmem_cache_open() into
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-7-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4287; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XvA3OjNvZTXuO+1s1Yt+F4vUj5bmDXzlHdYPfx3s9dQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNm19VTQ/A31/Pcu2kyd5/7N9tnrK+eEj5TmndY0t
 DG4qP9lXkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEvK4wMrzY0Sn98yJDqfmu
 HNOPRaseRR7wXDt5jfvSf15amn62AQ8Z/oocyBH68vthrP6iL/4TN0+xFO8VmnIh98LPPQ5Lb9u
 1HeYHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_kmem_cache_create() is the only caller and we're going to pass down
struct kmem_cache_args in a follow-up patch.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slub.c | 132 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 62 insertions(+), 70 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 23d9d783ff26..30f4ca6335c7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5290,65 +5290,6 @@ static int calculate_sizes(struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
-static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
-{
-	s->flags = kmem_cache_flags(flags, s->name);
-#ifdef CONFIG_SLAB_FREELIST_HARDENED
-	s->random = get_random_long();
-#endif
-
-	if (!calculate_sizes(s))
-		goto error;
-	if (disable_higher_order_debug) {
-		/*
-		 * Disable debugging flags that store metadata if the min slab
-		 * order increased.
-		 */
-		if (get_order(s->size) > get_order(s->object_size)) {
-			s->flags &= ~DEBUG_METADATA_FLAGS;
-			s->offset = 0;
-			if (!calculate_sizes(s))
-				goto error;
-		}
-	}
-
-#ifdef system_has_freelist_aba
-	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
-		/* Enable fast mode */
-		s->flags |= __CMPXCHG_DOUBLE;
-	}
-#endif
-
-	/*
-	 * The larger the object size is, the more slabs we want on the partial
-	 * list to avoid pounding the page allocator excessively.
-	 */
-	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
-	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
-
-	set_cpu_partial(s);
-
-#ifdef CONFIG_NUMA
-	s->remote_node_defrag_ratio = 1000;
-#endif
-
-	/* Initialize the pre-computed randomized freelist if slab is up */
-	if (slab_state >= UP) {
-		if (init_cache_random_seq(s))
-			goto error;
-	}
-
-	if (!init_kmem_cache_nodes(s))
-		goto error;
-
-	if (alloc_kmem_cache_cpus(s))
-		return 0;
-
-error:
-	__kmem_cache_release(s);
-	return -EINVAL;
-}
-
 static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 			      const char *text)
 {
@@ -5904,26 +5845,77 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 
 int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 {
-	int err;
+	int err = -EINVAL;
 
-	err = kmem_cache_open(s, flags);
-	if (err)
-		return err;
+	s->flags = kmem_cache_flags(flags, s->name);
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	s->random = get_random_long();
+#endif
+
+	if (!calculate_sizes(s))
+		goto out;
+	if (disable_higher_order_debug) {
+		/*
+		 * Disable debugging flags that store metadata if the min slab
+		 * order increased.
+		 */
+		if (get_order(s->size) > get_order(s->object_size)) {
+			s->flags &= ~DEBUG_METADATA_FLAGS;
+			s->offset = 0;
+			if (!calculate_sizes(s))
+				goto out;
+		}
+	}
+
+#ifdef system_has_freelist_aba
+	if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
+		/* Enable fast mode */
+		s->flags |= __CMPXCHG_DOUBLE;
+	}
+#endif
+
+	/*
+	 * The larger the object size is, the more slabs we want on the partial
+	 * list to avoid pounding the page allocator excessively.
+	 */
+	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
+	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
+
+	set_cpu_partial(s);
+
+#ifdef CONFIG_NUMA
+	s->remote_node_defrag_ratio = 1000;
+#endif
+
+	/* Initialize the pre-computed randomized freelist if slab is up */
+	if (slab_state >= UP) {
+		if (init_cache_random_seq(s))
+			goto out;
+	}
+
+	if (!init_kmem_cache_nodes(s))
+		goto out;
+
+	if (!alloc_kmem_cache_cpus(s))
+		goto out;
 
 	/* Mutex is not taken during early boot */
-	if (slab_state <= UP)
-		return 0;
+	if (slab_state <= UP) {
+		err = 0;
+		goto out;
+	}
 
 	err = sysfs_slab_add(s);
-	if (err) {
-		__kmem_cache_release(s);
-		return err;
-	}
+	if (err)
+		goto out;
 
 	if (s->flags & SLAB_STORE_USER)
 		debugfs_slab_add(s);
 
-	return 0;
+out:
+	if (err)
+		__kmem_cache_release(s);
+	return err;
 }
 
 #ifdef SLAB_SUPPORTS_SYSFS

-- 
2.45.2


