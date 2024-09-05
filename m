Return-Path: <linux-fsdevel+bounces-28685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677B96D106
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983B91F25E48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7581946A2;
	Thu,  5 Sep 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT0XIJG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A12194123
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523059; cv=none; b=SIeAahyWWP3mO5IfwosioiggKZAV27v4s8h5TyXbdR313NQyCCAAicEwqLYs03sMmGsGrvt+nPVM2QFTFTcB+amIuC2UoZDaP5qlif9gr+ggO/GzH685bLPJrdtzvm+CPLvUjsnJoFHmo0REMeOEnZjrF7eSMGd0spHcH7pCVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523059; c=relaxed/simple;
	bh=Zf6O0R24GKVW0QtPgh/qra6wApA/id2hJZ9TPx/ME9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h38/Hwh//3ZqLiqLCUuTvyp8u8Yh9pdUO7nqxzmOTqQ+aQFJ2DJRSYHOikD6cOPo+v8CBR1cMPfnu4eJdFDIPbMKOJc0hLNEtA+e6n7gH5krTSssB+S0aq4lJ9ynqsi2NgBrDV1f9WP7VNSuYzPTPjO9vYwYsU8sfalhLaD6lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT0XIJG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B0C4CEC3;
	Thu,  5 Sep 2024 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523059;
	bh=Zf6O0R24GKVW0QtPgh/qra6wApA/id2hJZ9TPx/ME9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pT0XIJG5jf6UweHnX3PnusUh7KGghRnwnSRbHnn3xA4ShIU+NmamAtaK6vBrYk2mi
	 H6So88w+HbyvPAA6PDRnnFNIX0mSLfAAN1ytfggZbn5Czz9MLNbo0wEr/26NW+zctS
	 NbjwmB9y12/NwWbSHwQ95npLdiS3NL9NjuEc79Da+qVyQ3KrGqzzXIuDfMpyu6Z60L
	 90wpyQFvLYUI15pVE3ZdqZtstQx6165hHWkrJaTTk9Y1v70sc8xzly8D/iwtpDHXlq
	 FrL8ueGzjJSOMor9BAJg0BpmFwFpTKugigsDRLEcIUjr0aax7uYvEm1co7kpgV+KT8
	 qFafnPFKwZwwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:52 +0200
Subject: [PATCH v4 09/17] slab: remove rcu_freeptr_offset from struct
 kmem_cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-9-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Zf6O0R24GKVW0QtPgh/qra6wApA/id2hJZ9TPx/ME9U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPG+VWf2/MDpjftOT9Dq6BX8s4SRRaTC3vkMS+kit
 vQu1Ze/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCEsjwh2d513G2xGq1PKvE
 d3ETuZ0Wbma+rL342ZUPPB2sn12X2jD8L0n7/Zo7ePHZ5tUKqYdmx3dnZx0WiJ1mnrW6d0fuGlM
 dbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass down struct kmem_cache_args to calculate_sizes() so we can use
args->{use}_freeptr_offset directly. This allows us to remove
->rcu_freeptr_offset from struct kmem_cache.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


