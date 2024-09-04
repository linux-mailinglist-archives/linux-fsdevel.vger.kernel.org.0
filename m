Return-Path: <linux-fsdevel+bounces-28632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17096C82D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E81F2331F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BFA1E766D;
	Wed,  4 Sep 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1ZUYDki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E909C40C03
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480635; cv=none; b=QDlapppu/vxEMJ3U9T2YCBLY48q1T0fqfxwgvogMWaI1YpzhawJKl43RzEurPPl0WdeLbi4/EqZc+sA2TEn2Ow8hhtVeAUItgUQiefNsCB5I8908VX0B29po8W0iOldqvTkT20uimiJ1v33+fLTidYaOqMvOzgePhUC3L2smR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480635; c=relaxed/simple;
	bh=BCTC0j7Sgt78nAVhjEBahOu6sqSOJXuTGyThZOs7DMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYhibt+EqTVcQel1ZYUIk5ee5VU7BBAJusE/i0XspMZ5NTHwUBMBklZJEgxBzNiybOTwx097YPhqBdAQrKDzCNlB6Chb4m46Szv5F1i1IOk8RuCXNskTkkPFlUh0vEbvJXDrKwM9mIt+apO2hCvAyBwuSKAIqLJDkaQcUXK0nGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1ZUYDki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E396C4CEC2;
	Wed,  4 Sep 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480632;
	bh=BCTC0j7Sgt78nAVhjEBahOu6sqSOJXuTGyThZOs7DMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1ZUYDki6pQzsFJbVYZ2mvnup9ye+l8CjwIpVH8rYWehMJ0ToPGg1fwvOA7xJydMl
	 wigBPsYCdZ7vdai7typmbwIY4M2yM2NCSl6sRltUPgKei26qhLJs/2AHVgXEwLmJ82
	 VZ7JOxn3jDWpq6cpRD9UUwMQHDwTLCMW36T2IVdseCvZayslrIfcyI+VYtH86RJDZX
	 Ikk392l2VhWYGA1asgKjwpM+oXYYgwdAKYpkQdNcaTdVjVKhtCn36KU4+WfMR+YQX6
	 uQDLJMoOfA01tLwXWYZFcZ2zy6WBx8UW5ztyCToO15wAQ/lK2kbrPIwRtPPQp9llts
	 SNiiKVDbVg5CA==
Date: Wed, 4 Sep 2024 22:10:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Message-ID: <20240904-kopfarbeit-zugbegleiter-c8f5dea4f6a5@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
 <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
 <ZtiH7UNQ7Rnftr0o@kernel.org>
 <3ade6827-701d-4b50-b9bd-96c60ba38658@suse.cz>
 <20240904-kauffreudig-bauch-c2890b265e7e@brauner>
 <CAHk-=wh=TVyNzdCvp2rzmR3_1ijMaT4fGtH68owiU5Zo-_7XaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dnhoovy3cfeicfu5"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=TVyNzdCvp2rzmR3_1ijMaT4fGtH68owiU5Zo-_7XaQ@mail.gmail.com>


--dnhoovy3cfeicfu5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Sep 04, 2024 at 11:53:05AM GMT, Linus Torvalds wrote:
> On Wed, 4 Sept 2024 at 11:21, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Sure. So can you fold your suggestion above and the small diff below
> > into the translation layer patch?
> 
> Please don't.
> 
> This seems horrible. First you have a _Generic() macro that turns NULL
> into the same function that a proper __kmem_cache_create_args() with a
> real argument uses, and then you make that function check for NULL and
> turn it into something else.
> 
> That seems *entirely* pointless.
> 
> I think the right model is to either
> 
>  (a) not allow a NULL pointer at all (ie not have a _Generic() case
> for 'void *') and just error for that behavior

Fine by me and what this did originally by erroring out with a compile
time error.

> 
> OR
> 
>  (b) make a NULL pointer explicitly go to some other function than the
> one that gets a proper pointer
> 
> but not this "do extra work in the function to make it accept the NULL
> we shunted to it".
> 
> IOW, something like this:
> 
>   #define kmem_cache_create(__name, __object_size, __args, ...)           \
>        _Generic((__args),                                              \
>                struct kmem_cache_args *: __kmem_cache_create_args,     \
>                void *: __kmem_cache_default_args,                       \
>               default: __kmem_cache_create)(__name, __object_size,
> __args, __VA_ARGS__)
> 
> and then we have
> 
>  static inline struct kmem_cache *__kmem_cache_default_args(const char *name,
>                                            unsigned int object_size,
>                                            struct kmem_cache_args *args,
>                                            slab_flags_t flags)
>   { WARN_ON_ONCE(args); // It had *better* be NULL, not some random 'void *'
>      return __kmem_cache_create_args(name, size, &kmem_args, flags); }
> 
> which basically just does a "turn NULL into &kmem_args" thing.
> 
> Notice how that does *not* add some odd NULL pointer check to the main
> path (and the WARN_ON_ONCE() check should be compiled away for any
> actual constant NULL argument, which is the only valid reason to have
> that 'void *' anyway).

Also fine by me. See appended updated patch.

--dnhoovy3cfeicfu5
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-slab-create-kmem_cache_create-compatibility-layer.patch"

From ede72f93668827497fb8d1c0f7286cfb4bd4f204 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 3 Sep 2024 14:49:49 +0200
Subject: [PATCH] slab: create kmem_cache_create() compatibility layer

Use _Generic() to create a compatibility layer that type switches on the
third argument to either call __kmem_cache_create() or
__kmem_cache_create_args(). If NULL is passed for the struct
kmem_cache_args argument use default args making porting for callers
that don't care about additional arguments easy.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/slab.h | 29 ++++++++++++++++++++++++++---
 mm/slab_common.c     | 10 +++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index aced16a08700..d406d00cabbb 100644
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
+			  const struct kmem_cache_args *args,
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


--dnhoovy3cfeicfu5--

