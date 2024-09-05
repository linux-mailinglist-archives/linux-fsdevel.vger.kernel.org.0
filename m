Return-Path: <linux-fsdevel+bounces-28688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE9096D109
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3342D1C23C42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8B194A60;
	Thu,  5 Sep 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7HvquUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8D1946B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523071; cv=none; b=hCzAvfOlqUgf5PMq2Xhu3RuOn9RhDFHSWfXylS6r4OWTv/GsnhUd6yujvzuu7vp7BHxIzXRr8nmeUPKYVzf0uChzvxWOuSLG2r2+zwTEK1aA7Ua/4gYRyzDk8NBtoejx6U1Icl7gfAOkOR6z6+04BQL48EcVm1ZfoVjiENM1yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523071; c=relaxed/simple;
	bh=xO3vcgDDnoCbF7ELZ5lnFORM5yLOC/pUkBkeRwkJlfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jr/H3ySyiBvoFCLl1ISrFey+MUaOrLb3WjXJV/75gDxGbMGx9sIPho6Hantr9pbALjW5+CdDEoZ61DNccie21dslCHZY35o2Au+TlQHjK59ofJ2P2eW/cTZu8KKmcm9xAoCUlX95tZEccqJ5+JCnZ55o/u3ej6Cq2NXUkRJXVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7HvquUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D83C4CEC9;
	Thu,  5 Sep 2024 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523071;
	bh=xO3vcgDDnoCbF7ELZ5lnFORM5yLOC/pUkBkeRwkJlfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I7HvquUcEms6uaml8hK37xscwhQS72RhSKTnUPyh0vN66t2ZzapSWd1Gvi8uO6rhw
	 umvVp1zmu8b5gVdoEmQ/RkZVPFUZFdUddhPh6Z/DD38rDAsP8xSVXqXx6ZTX1QkApz
	 89BQ+AZbPcJBU/XOw9PXkxOKGsgt/flpFUZvv+hJzOMDTzNxLwcjMGeBnU+fRS/+qG
	 YGuLmL7irHDeC4iYwA9A8x36GNAJ7vj6gYJ3uhr6CIif750S1YMIKkrAzdal+WxfzE
	 gA542w9e/qVTZIpPda7NJzSMIT52pzB4GuW4/Ijqve1H4S0Xg5R030ZVEkEuL8kt0h
	 QZX8zNQI101Mw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Sep 2024 09:56:55 +0200
Subject: [PATCH v4 12/17] slab: create kmem_cache_create() compatibility
 layer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-work-kmem_cache_args-v4-12-ed45d5380679@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xO3vcgDDnoCbF7ELZ5lnFORM5yLOC/pUkBkeRwkJlfs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPGWnv7hec00zY7uWcHZa36fWJ7VU33/TDKP6lqLz
 PW/14vGd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk1kJGhmWHXumx3lsayv60
 +XC6uci3R/ZlmQHCfw+In94cNDlrqxQjw/v1V2ZwbjStnHKhNWCVFYNj/4XntZ8kj/4XWR3ftMu
 pggcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use _Generic() to create a compatibility layer that type switches on the
third argument to either call __kmem_cache_create() or
__kmem_cache_create_args(). If NULL is passed for the struct
kmem_cache_args argument use default args making porting for callers
that don't care about additional arguments easy.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 29 ++++++++++++++++++++++++++---
 mm/slab_common.c     | 10 +++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cb264dded324..f74ceb788ac1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 					    unsigned int object_size,
 					    struct kmem_cache_args *args,
 					    slab_flags_t flags);
-struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
-			unsigned int align, slab_flags_t flags,
-			void (*ctor)(void *));
+
+struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
+				       unsigned int align, slab_flags_t flags,
+				       void (*ctor)(void *));
 struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 			unsigned int size, unsigned int align,
 			slab_flags_t flags,
@@ -272,6 +273,28 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
 struct kmem_cache *kmem_cache_create_rcu(const char *name, unsigned int size,
 					 unsigned int freeptr_offset,
 					 slab_flags_t flags);
+
+/* If NULL is passed for @args, use this variant with default arguments. */
+static inline struct kmem_cache *
+__kmem_cache_default_args(const char *name, unsigned int size,
+			  struct kmem_cache_args *args,
+			  slab_flags_t flags)
+{
+	struct kmem_cache_args kmem_default_args = {};
+
+	/* Make sure we don't get passed garbage. */
+	if (WARN_ON_ONCE(args))
+		return NULL;
+
+	return __kmem_cache_create_args(name, size, &kmem_default_args, flags);
+}
+
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	_Generic((__args),                                              \
+		struct kmem_cache_args *: __kmem_cache_create_args,	\
+		void *: __kmem_cache_default_args,			\
+		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
+
 void kmem_cache_destroy(struct kmem_cache *s);
 int kmem_cache_shrink(struct kmem_cache *s);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 19ae3dd6e36f..418459927670 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -383,7 +383,7 @@ kmem_cache_create_usercopy(const char *name, unsigned int size,
 EXPORT_SYMBOL(kmem_cache_create_usercopy);
 
 /**
- * kmem_cache_create - Create a cache.
+ * __kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
  * @align: The required alignment for the objects.
@@ -407,9 +407,9 @@ EXPORT_SYMBOL(kmem_cache_create_usercopy);
  *
  * Return: a pointer to the cache on success, NULL on failure.
  */
-struct kmem_cache *
-kmem_cache_create(const char *name, unsigned int size, unsigned int align,
-		slab_flags_t flags, void (*ctor)(void *))
+struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
+				       unsigned int align, slab_flags_t flags,
+				       void (*ctor)(void *))
 {
 	struct kmem_cache_args kmem_args = {
 		.align	= align,
@@ -418,7 +418,7 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 
 	return __kmem_cache_create_args(name, size, &kmem_args, flags);
 }
-EXPORT_SYMBOL(kmem_cache_create);
+EXPORT_SYMBOL(__kmem_cache_create);
 
 /**
  * kmem_cache_create_rcu - Create a SLAB_TYPESAFE_BY_RCU cache.

-- 
2.45.2


