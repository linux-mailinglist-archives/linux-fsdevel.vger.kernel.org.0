Return-Path: <linux-fsdevel+bounces-28522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A75E96B839
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DE9B21767
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED41CCB29;
	Wed,  4 Sep 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us9HEmIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3E433C8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445346; cv=none; b=S+XadaKZkxGqluXPJXw4Cs8eLA31NVPASw3mCWkFWLP1uFigT5OssSpnOOhbURc+jAYePWSj8GArmWY7/kfjkRRiWcR61EchAATSr3xeadyCsW5vzmFUtvSmQkxsyGT2F2b5nR/SByaGKWdso30lWcpERABGeG8KI+zRGxvC7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445346; c=relaxed/simple;
	bh=8hORSdr9O/EqElT2ajhJQ8gEdIqY6bU8s9Nue9pitwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vu1CXY1mqusXhyLq1a7/q/hRcjerI3jOOKnhHZ/3BVJZFE8OwYr37IaRH+qDc/NbzRw40uOt2n1SDXATZbMea/zz+KyUeXzPUg9RbALcKDQKiscXB7Xqb5ZnxRaHQEYj4muU5jjolVix2GY379foIjKA/VvDk9fs97q4M+DsaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us9HEmIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D50C4CEC6;
	Wed,  4 Sep 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445346;
	bh=8hORSdr9O/EqElT2ajhJQ8gEdIqY6bU8s9Nue9pitwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=us9HEmIzCgJ1DP9lrROrQhAb2zX+L5BEnnhdKkWq6pq0V3MhZk2lZ4bevheiquKzS
	 60XaBJaYfYppDbcqI/WDixM0L7NIaJA4M8LKXgTWMK0fphczOVIiFOsf9Atupsb1bj
	 UFfnioh3A2OD/lsX+87sFGf2cMJ/Xtal5GknHUeK0aBeZV2Hc3G2OFN09CIPtZSCNH
	 Bf9Xglj3Y62QKfyzei6gxD5Ilr4phgEjtoQX5dDDD2zqvwnJ9Fxs8c2MqhIwTYArAf
	 Q8EafrAHwYLvHu3mDnBU/gu2RKAk59ffY6BBz7AxxxC9klbM/s1gJ+x4RApnjLJkVA
	 iLHmH+bMcC5Gw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:14 +0200
Subject: [PATCH v3 09/17] slab: remove rcu_freeptr_offset from struct
 kmem_cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-9-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3911; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8hORSdr9O/EqElT2ajhJQ8gEdIqY6bU8s9Nue9pitwk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNk1Y2pnvP31qKVpOcJ5do+eigrNe3hBOWNSeo3uI
 obMvRKBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRMWFkeMCSwrpzXcROLyPf
 JzwXoxOe3hR/ovf8iI7sgtCN83NWVjMytJ4XPf57hZ7huRP6s2Z5+YTtMrRZIt6vpv7B7bDZisW
 +fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass down struct kmem_cache_args to calculate_sizes() so we can use
args->{use}_freeptr_offset directly. This allows us to remove
->rcu_freeptr_offset from struct kmem_cache.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab.h |  2 --
 mm/slub.c | 25 +++++++------------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index c7a4e0fc3cf1..36ac38e21fcb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -261,8 +261,6 @@ struct kmem_cache {
 	unsigned int object_size;	/* Object size without metadata */
 	struct reciprocal_value reciprocal_size;
 	unsigned int offset;		/* Free pointer offset */
-	/* Specific free pointer requested (if not UINT_MAX) */
-	unsigned int rcu_freeptr_offset;
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
 	unsigned int cpu_partial;
diff --git a/mm/slub.c b/mm/slub.c
index 4719b60215b8..a23c7036cd61 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3916,8 +3916,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
  * If the object has been wiped upon free, make sure it's fully initialized by
  * zeroing out freelist pointer.
  *
- * Note that we also wipe custom freelist pointers specified via
- * s->rcu_freeptr_offset.
+ * Note that we also wipe custom freelist pointers.
  */
 static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 						   void *obj)
@@ -5141,17 +5140,11 @@ static void set_cpu_partial(struct kmem_cache *s)
 #endif
 }
 
-/* Was a valid freeptr offset requested? */
-static inline bool has_freeptr_offset(const struct kmem_cache *s)
-{
-	return s->rcu_freeptr_offset != UINT_MAX;
-}
-
 /*
  * calculate_sizes() determines the order and the distribution of data within
  * a slab object.
  */
-static int calculate_sizes(struct kmem_cache *s)
+static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
@@ -5192,7 +5185,7 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if (((flags & SLAB_TYPESAFE_BY_RCU) && !has_freeptr_offset(s)) ||
+	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
 	    (flags & SLAB_POISON) || s->ctor ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
@@ -5214,8 +5207,8 @@ static int calculate_sizes(struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && has_freeptr_offset(s)) {
-		s->offset = s->rcu_freeptr_offset;
+	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
+		s->offset = args->freeptr_offset;
 	} else {
 		/*
 		 * Store freelist pointer near middle of object to keep
@@ -5856,10 +5849,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
 #endif
-	if (args->use_freeptr_offset)
-		s->rcu_freeptr_offset = args->freeptr_offset;
-	else
-		s->rcu_freeptr_offset = UINT_MAX;
 	s->align = args->align;
 	s->ctor = args->ctor;
 #ifdef CONFIG_HARDENED_USERCOPY
@@ -5867,7 +5856,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	s->usersize = args->usersize;
 #endif
 
-	if (!calculate_sizes(s))
+	if (!calculate_sizes(args, s))
 		goto out;
 	if (disable_higher_order_debug) {
 		/*
@@ -5877,7 +5866,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 		if (get_order(s->size) > get_order(s->object_size)) {
 			s->flags &= ~DEBUG_METADATA_FLAGS;
 			s->offset = 0;
-			if (!calculate_sizes(s))
+			if (!calculate_sizes(args, s))
 				goto out;
 		}
 	}

-- 
2.45.2


