Return-Path: <linux-fsdevel+bounces-28683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B796D102
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95ED1F25D83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF1194C7A;
	Thu,  5 Sep 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObpeGRhp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9F194123
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523051; cv=none; b=OfY0cfHm6LlUo2BSzLsXyvtKJILSMvsfqFDrrcigwjVoh6bPyRVl14Vl5KoD1X+33MWjiBARkr5xATmZNyXqvFpbxDwMmtnVAaRYaLq6AvUDH9igXW6moOXIgAc88K3CJq3Lz7aazJ8X8I0pCna3SBD63yMo5XQT4Kd8Ro1epWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523051; c=relaxed/simple;
	bh=F4tMDDfenpBgeWRetu8ug4Xik9BM3oJX2qts2ZpcdrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poyqvW/jkChNX5CftNYHLmeLgkejyFomNZJB8S1rt2uhZn8Gexidc6JW3xeky3yHbkbPO1szUVz/LDqe+jPcDf/dhspPFLuyB1j2XKrA1BhqIgchJ8/+QjF1jAPbdPCEMm3KANI0ew0hwFcUO0hlLGnziVWvD5BJyerw07tQ3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObpeGRhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD4C4CEC6;
	Thu,  5 Sep 2024 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523051;
	bh=F4tMDDfenpBgeWRetu8ug4Xik9BM3oJX2qts2ZpcdrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ObpeGRhpLdQ/xuBN6oc6xnWemMqwQAuRAUt5YcF7NoCkWvjhAwlxQWyj0YMXbjEnA
	 xL+aJg6yRld7k9ZRH+ok+weCGJzWrsHl08suV/gG2HeJ3/bwtGoGhpv6BivMo7Gh/Y
	 UVXJXgjKC/yBQHHnVSSqhpPpIc46SKUmR3BUjov2sSc1Mi+CfEyraqEvSHni4F3tkZ
	 MzrzFsfHl0cO15XuhnUg81sW2N32QewmdDV6gkcmZXKczJ+sn1glfWxTCxgd4k3LwZ
	 vyBL3URCpolzi5OPCOlGEedhX0Hvc+I3WaG+oV2yYW7weQgP4k4TnhHF4l50gtempi
	 NTlN8VzUHGzvw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:50 +0200
Subject: [PATCH v4 07/17] slab: pull kmem_cache_open() into
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-7-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4372; i=brauner@kernel.org;
 h=from:subject:message-id; bh=F4tMDDfenpBgeWRetu8ug4Xik9BM3oJX2qts2ZpcdrM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPF+/LIxODE3/l71sjm8Yc+2flq/cFrAmkffmULnH
 w0LqTr5paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiDBEM/4sL0/4K6YoFeClI
 L/9byMhqxCZcLfdt52Kv+x5Zwh/nCzMybM5ddf7X++DrBstaBVet+fJQ5/yETMadStuc6jZ9r9f
 dwgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_kmem_cache_create() is the only caller and we're going to pass down
struct kmem_cache_args in a follow-up patch.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


