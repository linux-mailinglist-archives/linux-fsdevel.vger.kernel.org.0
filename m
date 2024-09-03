Return-Path: <linux-fsdevel+bounces-28397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D896A047
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A5E1C23228
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02D7581A;
	Tue,  3 Sep 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIqDi3Qn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9316F30B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373363; cv=none; b=ozvIZS5kVLGDML3HAA0gcYyCaNxXfwGZEwfefGPfKYmBmFBFSz9DD1DDt2i7yJtBHfz3OQTpS6zTVR+s5bZdcg1pdYOtJTBy/dlzo7Owm708ZBlqvO5t2zZ6QqUsvsEEl4GpPLZZegd4ejsIeLaIOuPdNIDCsSpcpBASRP7H1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373363; c=relaxed/simple;
	bh=+kTwNa1m6b/Hnr0YtIDtx0q9W42j7lzgwCx+jUzI5rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fmh/FYNm6bbfAXnQDKg3NVydWBBCMiZRlol59BBY5Fj5Npqf+v3sSTSCsBycUSnROdjzenbhHRUwPc9KB6J3eeSj7Th0E/YbV9maxFr4vBNm76u7ul7uIZQxFohNaIttiDXY58BRMicrDP4zeM8hX6wAq85AkiZ0sNG1RIp/U9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIqDi3Qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE620C4CEC4;
	Tue,  3 Sep 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373363;
	bh=+kTwNa1m6b/Hnr0YtIDtx0q9W42j7lzgwCx+jUzI5rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZIqDi3QnJT6V+K28/jD+UNtuaEDHlnJWqYR8lxhqiapVrTdtG0h22hWUu81vD5O2+
	 jXFZjjBzQ8TZLgYQuZUDqWdgcND9G8Rz9UOfeQPM2XeImc+frsoPSL6onkde1jl1tY
	 VAHgG1WziE9j9W4rFM9UIyvhpxLFqaxvTZkQ6SCPA8Gu4Mjyk55DAavUexXA9nChen
	 uI00cTePs9fVCgmjPnmJbiR3TTTuRimy87cmxjPvCWtB3zu5XJAE3ncQJwG/bdg/RC
	 6t2651rDtNYBxxp2lsxTdiw2E/iwWxq/nt4y7EyD2YVjPFboFkKnXucewOKJb5i21q
	 76YuSfJsqpdfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:50 +0200
Subject: [PATCH v2 09/15] sl*b: remove rcu_freeptr_offset from struct
 kmem_cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+kTwNa1m6b/Hnr0YtIDtx0q9W42j7lzgwCx+jUzI5rs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl57jvoPX02rSPSWTt/ddD73463HOrSVxeqTj4aOzw
 5g3SP541FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRBysY/unOE+Ll3uq9eeUC
 ieve17+IL5eOKJ3Vxv1pX/e6yVsDmu8yMvy9e2/elMKab78eFp99eugk338zkZNyMxfOisxszz/
 89zQ7AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we pass down struct kmem_cache_args to calculate_sizes() we
don't need it anymore.

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


