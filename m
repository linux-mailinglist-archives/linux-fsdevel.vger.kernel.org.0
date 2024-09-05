Return-Path: <linux-fsdevel+bounces-28690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9496D10C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DDDB25A26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A5194A6B;
	Thu,  5 Sep 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm9Sd2Di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0976193422
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523079; cv=none; b=aDCxXSOw8E4TQqw5yoaO95SH6MfBLv63RbwqJFZvbnPq32TEZ9qWcfKrXnVEUaW0VfMkgKi2B98jMQxeF6xGFCDJQfD5Nxu+ym7BDo7S5B+20+B9oNAHguYXfhtBVvWoX4sgB9fonA6nRrrSWbFslrjQklHyye0rjH7uUmz1mDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523079; c=relaxed/simple;
	bh=c9WyXR3UutI5YuOZDzru6g9A7doJ0To6Z/yCENECssA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnYXOZOhTS6+C3FffjFXG22S+K1gwU27j5uB5yyGc9zt4gQ9LON16PUmro3J6d8OIhQAMtXEyMxSf1rOfB9YUjqj7WslNa03nxGLe5/9qpFBiBekiiX6qX4PNoqSHYyO+WmLS9mxonLRLt3DQb7F0t5lVDLF8ea5CbJwjDw8CT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm9Sd2Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9920BC4CEC4;
	Thu,  5 Sep 2024 07:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523079;
	bh=c9WyXR3UutI5YuOZDzru6g9A7doJ0To6Z/yCENECssA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cm9Sd2DiCmnN0M4VfGZk7Ktm5XhL7pstZXSAV2/tXTU0vjUTxs17RLf9hjLGtOvjr
	 aJuzjiNbaXAw0LLzOGR4Kkckwn0fnE09r3ZmDZ/kHmLqzpeCr1buh5ukhX4ArhnWrg
	 PUQIGMuRq8rnFXLrp2CEa8HmM52xfYv66EJKiCyh1q3wy8/FOiQXi7vs9Tah2zsODe
	 CosxMcX8TUjUa8lTOHalsD5psOIeXV3QgYlKjByOBrBU7LF4R/gPR00gARG+pwrohn
	 DDHKwylYuoaxckibZsHQvhMGDCp7+cnBl1N65RZblKCkMhS8juxVlCdR9cqGkOs/5Y
	 AZuImLS0sp9dg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:57 +0200
Subject: [PATCH v4 14/17] slab: remove kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-14-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=brauner@kernel.org;
 h=from:subject:message-id; bh=c9WyXR3UutI5YuOZDzru6g9A7doJ0To6Z/yCENECssA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPG+F8+58dldnj9qzNtvnnm8aYfemt7vfz66bb2oG
 iHMce3Hwo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJxGsy/M/5INce7OTJUvjF
 Z33SiZQN9YV1DbtmHLIulz2wyily3XOGf/aFNUbt6q4vZqyd+vP26xvmEqsurtf8Lms8z/OtwNX
 yg+wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we have ported all users of kmem_cache_create_rcu() to struct
kmem_cache_args the function is unused and can be removed.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h |  3 ---
 mm/slab_common.c     | 43 -------------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index f74ceb788ac1..8246f9b28f43 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -270,9 +270,6 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 			slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize,
 			void (*ctor)(void *));
-struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
-					 unsigned int freeptr_offset,
-					 slab_flags_t flags);
 
 /* If NULL is passed for @args, use this variant with default arguments. */
 static inline struct kmem_cache *
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


