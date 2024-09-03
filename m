Return-Path: <linux-fsdevel+bounces-28395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B796A045
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D85B23EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07AB13D518;
	Tue,  3 Sep 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC8yw4Sz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AF626CB
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373359; cv=none; b=lwtVd7tXT/bMu277+hIvYpJvGfgUGbTIl1yl0WEEZZCiQtJcR+7RrVW/IFYmUIy6Sc1CYBREy+g2fsAH/EToZ74OY/cRANb49ppblTVnK4G9fvsWswlKdMh++CSdTdnxMpekhUzbaxgQK4J49X1a8ZMOZpVtPdfQ7TRfQpuL5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373359; c=relaxed/simple;
	bh=NICKa5KUOQG+AjRPua/q+Zy7rozMk7chEiygU85Xzfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtfzUarwoMsLIIQvTI0Nf9GCvFWsZEp4MkUtbkUD4hNaidaAnNitUuf7SHMQYAfGHgAeadl5593S+/mwNGqeRWeFjk2nE5u5DsvJSAZsLDSejBcFLk8LA9d+HZSOTUhoZ9iVLLtBcY5gHaRxViiiWQyx0E91pYlUo6szSD82Qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC8yw4Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9BDC4CECA;
	Tue,  3 Sep 2024 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373359;
	bh=NICKa5KUOQG+AjRPua/q+Zy7rozMk7chEiygU85Xzfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iC8yw4SzaTmXOI0hC0s8OsuBU5aCzpjtbsOXChYJgSb+rOOw8TJqTrZReqPkClcGK
	 ZNgy01bxU/uKUhxj7oMkaQhQAQx/3DyNu5CeaR/EV1moRwRvMHEMwMUAnyjEI/TDMW
	 skD2yBxQE+vFthDy+IfReCtlevTldr3uCMhDIvE8Z+T4hQhePNd2ER/HHlrrFD/4JJ
	 0kGkpS2svFTSfpQC/Q40LPhG3ke3P4HRh3ee0tF902OveKbf7i3QXXtYpW3TGeBec6
	 Vrza4B7lPz457uYQqrZhBLocJthwFr5XglrmZMgfN9bATDcthv/vrHLusm04OqJSJH
	 +goSwi9E619bA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:48 +0200
Subject: [PATCH v2 07/15] slub: pull kmem_cache_open() into
 do_kmem_cache_create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-7-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4182; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NICKa5KUOQG+AjRPua/q+Zy7rozMk7chEiygU85Xzfw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl55TEKXz8vYFK94ZvtNPxHhluBqE8J9eprm0vqG4t
 aFTqWhWRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETUFzAyHK382DX77OSW782/
 Tyb0tolO+W8Z9G1hP99sobz366eZKTP8L/Lb0Wjtcnz14nu562PZJ+ZXWnRa+BqwelZ9XbLf9vo
 9VgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_kmem_cache_create() is the only caller and we're going to pass down
struct kmem_cache_args in a follow-up patch.

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


