Return-Path: <linux-fsdevel+bounces-28402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7596A04C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9095128588C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099A6F076;
	Tue,  3 Sep 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgSzT5kw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2513C906
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373375; cv=none; b=qrzCy2mfxTs7wLRQNg6W/fLbGO1w6fsklUdRYsbWBhGiFgpucAQH6IBh31I4VseHwO+4juhElKsA0zM3TS/2TyDfPYMJF88IEXDykxzWIDShZ4l77BcumH3tNDfLnKlOCbtr66D9ly17NtajsMOSvMIHFx+N8tu8UYML+xMYTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373375; c=relaxed/simple;
	bh=6bG1JSwASGPcSbXbn/SP58oY4O44BFhaq6fvlGpwWZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xep7bJHaLoJwHkUi+kw8BlnzpnYWYnxNh0f+sflDPOXvMskeQHenhNcPVgLLWxT13NHC97vM9FPrsJdHkTpPwk5ZcTzdCV3AlwXH3hiW4Ba9vvHPnFPd60tEj1W1CrCDEabMZcB3TEStLO7xi418FUUpZ+03/zHJMtM/bQ4bmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgSzT5kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA42C4CEC8;
	Tue,  3 Sep 2024 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373375;
	bh=6bG1JSwASGPcSbXbn/SP58oY4O44BFhaq6fvlGpwWZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JgSzT5kw/kqZjtu62rKEOhtPQaXg6+GNpK7HPlu2JAeGj9bEhx9j07h95VDy1OKzE
	 O31WVPK0Aor2Wj0c2PJPqCQahWpa4akQrZOu+WDkA1EG1VHsmvxZMLB+IwkYLAS7+B
	 R/zTjA9ThANEe8EYIwWi34xcct3yVJpVNb6u5JrENfp3n1grX2Zkf/UYwZbIecoyWL
	 5R0XAn9j6JCIHIhZN/V6PZqVH8c1zEohmwqYI8wyr/khfF7xn4DXQ9pmAOR7954BDD
	 NiA1S6c/x6XZLb1vhIALBBWiPczImRVo3QYYPqxEV2Kg7cVyFUf2TJgorV4wcCsnHp
	 6WhEIvdcTTD/A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:55 +0200
Subject: [PATCH v2 14/15] slab: remove kmem_cache_create_rcu()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-14-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6bG1JSwASGPcSbXbn/SP58oY4O44BFhaq6fvlGpwWZw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl54jXPX8rdx6/mVLDkyd06KQtJU9c0HW1+iL/6LX5
 x2fsGtFdUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3ggyMrzjlnhzRLl04is9
 m658Z+1bFmmFCb+0pq91PPIj48bNz6sZGZZfsks55tTGvGBllGHuUrZpJ/xDDt5X2HtBaAHH9Hc
 dTMwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since we have kmem_cache_setup() and have ported kmem_cache_create_rcu()
users over to it is unused and can be removed.

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


