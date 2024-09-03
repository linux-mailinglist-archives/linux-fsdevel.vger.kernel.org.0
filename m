Return-Path: <linux-fsdevel+bounces-28396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635B96A046
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333AD285B82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0E13D52E;
	Tue,  3 Sep 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsLWeAqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BE69D31
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373361; cv=none; b=EAgafqW+usFMrV9mPejWrkWYe5e3uD85dLAmtrdadvMi1dTebehHhMSDnlQcd7/Cv5ui1ooQrV0lzU6DOMTbDvhx4NQg21+OKXyjppuv/x2SIuV4V0q65xQlYUACRNvwxwc+EZvBli/fFiNbQCl2wLOwPSPs83prbTydKv2EFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373361; c=relaxed/simple;
	bh=LGtj/e6uWtTAC/2FfRENwjsuEXl8qpeXQfpfD6hAo/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vB/cXUPZDaEbWlEMABW7l0XoeicSnfwxl2R3XQFVfSPToqulci9B+9sPjndg1ydpYRA0Vr5KPI/LdE5VMXdhjsgbOQudb5rrhqXQWb/fptAct6ZmnE9Aaqp6kS7hRfJEG/UYGDrgWmOdjNnqkyYHs29NorYaT0QT+DADMSgKo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsLWeAqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8786DC4CEC4;
	Tue,  3 Sep 2024 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373361;
	bh=LGtj/e6uWtTAC/2FfRENwjsuEXl8qpeXQfpfD6hAo/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RsLWeAqc+DgpjX7fIXp3seQzC7Jou5QA3YNKQA96AB5ngZNz4PJaisGMq3sCixh5r
	 QOgA1QJdHZQNaRLR/leMrddYpzKBCE8vWScxNK+YiFqISZSXv84tau6h7mXHEVcpr0
	 HJYqlDlVWjsSc0SNm9i+pXjDw6ODPRoFutRQQfM3i/wA8qynyXkDQggEHsE/XfNbm/
	 mjXtmxEjDfgHqwCzhhcHS3NajIW1E/l41DICazy+Jl/afIq9+LHEEQ2buTp2tP1QlJ
	 1FKl0p/6/MdN+LRySJdd4+H+ILs5xRe5Gg8ifJHwc11AtaWaRaI8iB+luaLgDbU7YU
	 N8CBqhbYiO10w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:49 +0200
Subject: [PATCH v2 08/15] slab: pass struct kmem_cache_args to
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-8-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LGtj/e6uWtTAC/2FfRENwjsuEXl8qpeXQfpfD6hAo/g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl57zp/8H58sZpdqnOv5v877EcHrts//a9Txn2or0d
 272eOaU1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDW8ZGTrXHOfxNkk++6Bu
 Ud50/7Xu9itYrLle9Rboh6fcuH56Axsjw7cazcD7wjNt1i5aLMG87YLj89YNW27YnctQMQqyfjp
 Bnx0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and initialize most things in do_kmem_cache_create(). In a follow-up
patch we'll remove rcu_freeptr_offset from struct kmem_cache.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/slab.h        |  4 +++-
 mm/slab_common.c | 27 ++++++---------------------
 mm/slub.c        | 17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 684bb48c4f39..c7a4e0fc3cf1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -424,7 +424,9 @@ kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
-int do_kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
+int do_kmem_cache_create(struct kmem_cache *s, const char *name,
+			 unsigned int size, struct kmem_cache_args *args,
+			 slab_flags_t flags);
 
 void __init kmem_cache_init(void);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9baa61c9c670..19ae3dd6e36f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -224,20 +224,7 @@ static struct kmem_cache *create_cache(const char *name,
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
 		goto out;
-
-	s->name = name;
-	s->size = s->object_size = object_size;
-	if (args->use_freeptr_offset)
-		s->rcu_freeptr_offset = args->freeptr_offset;
-	else
-		s->rcu_freeptr_offset = UINT_MAX;
-	s->align = args->align;
-	s->ctor = args->ctor;
-#ifdef CONFIG_HARDENED_USERCOPY
-	s->useroffset = args->useroffset;
-	s->usersize = args->usersize;
-#endif
-	err = do_kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, name, object_size, args, flags);
 	if (err)
 		goto out_free_cache;
 
@@ -788,9 +775,7 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 {
 	int err;
 	unsigned int align = ARCH_KMALLOC_MINALIGN;
-
-	s->name = name;
-	s->size = s->object_size = size;
+	struct kmem_cache_args kmem_args = {};
 
 	/*
 	 * kmalloc caches guarantee alignment of at least the largest
@@ -799,14 +784,14 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	 */
 	if (flags & SLAB_KMALLOC)
 		align = max(align, 1U << (ffs(size) - 1));
-	s->align = calculate_alignment(flags, align, size);
+	kmem_args.align = calculate_alignment(flags, align, size);
 
 #ifdef CONFIG_HARDENED_USERCOPY
-	s->useroffset = useroffset;
-	s->usersize = usersize;
+	kmem_args.useroffset = useroffset;
+	kmem_args.usersize = usersize;
 #endif
 
-	err = do_kmem_cache_create(s, flags);
+	err = do_kmem_cache_create(s, name, size, &kmem_args, flags);
 
 	if (err)
 		panic("Creation of kmalloc slab %s size=%u failed. Reason %d\n",
diff --git a/mm/slub.c b/mm/slub.c
index 30f4ca6335c7..4719b60215b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5843,14 +5843,29 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 	return s;
 }
 
-int do_kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
+int do_kmem_cache_create(struct kmem_cache *s, const char *name,
+			 unsigned int size, struct kmem_cache_args *args,
+			 slab_flags_t flags)
 {
 	int err = -EINVAL;
 
+	s->name = name;
+	s->size = s->object_size = size;
+
 	s->flags = kmem_cache_flags(flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
 #endif
+	if (args->use_freeptr_offset)
+		s->rcu_freeptr_offset = args->freeptr_offset;
+	else
+		s->rcu_freeptr_offset = UINT_MAX;
+	s->align = args->align;
+	s->ctor = args->ctor;
+#ifdef CONFIG_HARDENED_USERCOPY
+	s->useroffset = args->useroffset;
+	s->usersize = args->usersize;
+#endif
 
 	if (!calculate_sizes(s))
 		goto out;

-- 
2.45.2


