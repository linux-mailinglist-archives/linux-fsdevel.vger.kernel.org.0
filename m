Return-Path: <linux-fsdevel+bounces-28527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0593996B83E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B107F1F213E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E41CEEA7;
	Wed,  4 Sep 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRb8YchA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26114658C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445366; cv=none; b=rqrhqVj+bUJIXOXIvNCQwhUxE2vzlvl0bBxReigYyXvuvG0OPUxGUdJrH9lQCp5jruzvq2tPommAFHyGeLFPxefZSjG/veAocRdno5TIVSK7/ju4ty65FjjPx0IhFdkb41lfXNFST4jIeAbxIzTetd+OttKcmVksUtwG6a+XvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445366; c=relaxed/simple;
	bh=ob7tfSkKKaOFfsUNw54A8NnR55QWcUPRYRE0hGJ3b7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9al6XwOUE2EwV/gvxm0k5X50lNCBsv9HyMr5juld+b+UjniUmUwNco73vRTcNo/yVmrUHtYYXpRUngy7QDjyW7+RNe8ERj8rEeaUriclfzGOJTybaxJiqiUIYTRWQYlhL0PCutSevj6P8TOB2Fn4+THyngdXanaKtF9MS/QDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRb8YchA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD028C4CEC2;
	Wed,  4 Sep 2024 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445366;
	bh=ob7tfSkKKaOFfsUNw54A8NnR55QWcUPRYRE0hGJ3b7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JRb8YchA1ASqQ3gjaPNCb2ql7VsuECo83v0Lq+OcjYRob92h21b4kbDsuHmjJqRZW
	 qoSlLkVDQOxp2eAaBmMBDJ19GHaa/AAaD1r4SxRhIz4RQm1a1ONGWK/lFYPQDNafQ3
	 j7LA0AAPa4Zan7gvOn0W+nVU8RSDISc4ZRmuAKoXHPNA2jDH+On/sNA6mDW1anw+KL
	 4W54tzz2lLjzH42yg2+1h2f2SD6WBOQRajfBNgC5Mb/51bSWfOYXipxW/tHfzOaDjG
	 E3iiNtpx601BMCVUfuwfr5VoFgpooZwUU1wPcE8rttxqQ/My7vpCohzgD/t9OKIBvt
	 SL8JA2SyIL6Wg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 04 Sep 2024 12:21:19 +0200
Subject: [PATCH v3 14/17] slab: remove kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-work-kmem_cache_args-v3-14-05db2179a8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ob7tfSkKKaOFfsUNw54A8NnR55QWcUPRYRE0hGJ3b7c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNl9h8VC/ZrFR6Mzc6ZER+rs5dr4x2dKw/Pwh95OW
 tcSTRtkOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSf57hn45wDQOP2darxaJt
 NXwPNXi71KIeTUt7Nksl5J+fyc9l5xj+u3W69D4PXbsz+/GX+XE+Zgv5VPV9b/zcezK0m+nk2g/
 8TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we have ported all users of kmem_cache_create_rcu() to struct
kmem_cache_args the function is unused and can be removed.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h |  3 ---
 mm/slab_common.c     | 43 -------------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4292d67094c3..1176b30cd4b2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -270,9 +270,6 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 			slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize,
 			void (*ctor)(void *));
-struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
-					 unsigned int freeptr_offset,
-					 slab_flags_t flags);
 
 #define kmem_cache_create(__name, __object_size, __args, ...)           \
 	_Generic((__args),                                              \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 418459927670..9133b9fafcb1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -420,49 +420,6 @@ struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
 }
 EXPORT_SYMBOL(__kmem_cache_create);
 
-/**
- * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.
- * @name: A string which is used in /proc/slabinfo to identify this cache.
- * @size: The size of objects to be created in this cache.
- * @freeptr_offset: The offset into the memory to the free pointer
- * @flags: SLAB flags
- *
- * Cannot be called within an interrupt, but can be interrupted.
- *
- * See kmem_cache_create() for an explanation of possible @flags.
- *
- * By default SLAB_TYPESAFE_BY_RCU caches place the free pointer outside
- * of the object. This might cause the object to grow in size. Callers
- * that have a reason to avoid this can specify a custom free pointer
- * offset in their struct where the free pointer will be placed.
- *
- * Note that placing the free pointer inside the object requires the
- * caller to ensure that no fields are invalidated that are required to
- * guard against object recycling (See SLAB_TYPESAFE_BY_RCU for
- * details.).
- *
- * Using zero as a value for @freeptr_offset is valid. To request no
- * offset UINT_MAX must be specified.
- *
- * Note that @ctor isn't supported with custom free pointers as a @ctor
- * requires an external free pointer.
- *
- * Return: a pointer to the cache on success, NULL on failure.
- */
-struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
-					 unsigned int freeptr_offset,
-					 slab_flags_t flags)
-{
-	struct kmem_cache_args kmem_args = {
-		.freeptr_offset		= freeptr_offset,
-		.use_freeptr_offset	= true,
-	};
-
-	return __kmem_cache_create_args(name, size, &kmem_args,
-					flags | SLAB_TYPESAFE_BY_RCU);
-}
-EXPORT_SYMBOL(kmem_cache_create_rcu);
-
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
 /**

-- 
2.45.2


