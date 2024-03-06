Return-Path: <linux-fsdevel+bounces-13802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E89873F40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A752877B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B614CAD6;
	Wed,  6 Mar 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqjpJoGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EA14C59E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749537; cv=none; b=o92XCtS8OW1XY+KBCYxGim9MUxeO7KLl4UVls5j7COtVLjcyRpOIG4p1GifX+2ar4uXpVROS1zT2o0grkE07iIgkUGmMC8+o6+c6kxVe8dmMh/H8m0yndrZhQRIkkH3MxI6sc11jeQmr1QKCTc9GsEW3mpSWqfPyVRdHygSv/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749537; c=relaxed/simple;
	bh=Z86ROT7Zdn1ciAfGWq9DAKpw0B6kxc7ufPJJCqX4DBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z7lDLBDZCeOoBdzVUZTiI/xwB5eAcsKbVeC+AZI+ERjUFKpCh6BHsznR4JWsyNNl9upKIwhTtHzJJ2Dln3lts7lI4S+KMP5VT7T53o0XCbmEoQRdz6IR4wAWuZbEe+aLbiXBCod3NK2rYn0PcVJsVA/WqPAHvZP9hKgsSqpq6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqjpJoGW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60987370f06so429997b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749534; x=1710354334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s15jajKF49lJj6S4Z8eIgzY9HreX5MNZRA5AU2XXX3Y=;
        b=oqjpJoGWdxnVNBJ85rFBUqk/zaz71D/r7R8+6Gifgd6JHc1LlCSaxjZksXvJkNjZYs
         8wlNfBA8VB/xxTvixtCsXu3x5OD3rYKf2ffcJB2eE9w4UAZ2HsbV8fdg8caDYxrm6KTH
         vGvaTYNWCdt7W3ESQ+XxBCI8c2w/NXw0teeNVoJvq0+1yksDpdv2zFQKn20KiqCWIkKi
         /feIYzH/vslrU1Qw5rTSqBN6L4QHzdrT9NPRP42CHDLifqDwHiLiPvQcrfZ0TxLcIZyV
         IQFYmaZUeEk8T8derrmHX2TzLQhKdDVLTIh0Mq8OYNMLAVomkyyaDJ9Mlkhgruf9uHUP
         xIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749534; x=1710354334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s15jajKF49lJj6S4Z8eIgzY9HreX5MNZRA5AU2XXX3Y=;
        b=f/wwxH0WfNFqP1n1qgMNY0pEis+BRR1TYBkyQJZnQufLswSTF7qc15HUsZh2yVXuEt
         amkoi0CZ5VVRsBi6ciX6NNsgggz4My2H0V8BbvGk4nT1EskB46GgaTY6tAZ7v/3UJ6WA
         hv6fGXStEQoy4vNEDYBNgeNMZNfSvFUSrTs8Ummy/JmJB4CD0ngPXTppI0q1MKe3Hw5e
         hJ0kQY4E5lUUEGjRPgccRjHKUI9LZ8KNX3dneKnBHT3rwHpFcJSu/NogYQbqmFglFUJ/
         LEuHOD3d4MvDzyRf2Ql6j+Dc+ZtsPIVLBcWDACn3TzGqWJv/XB6554yAPriTgQiQXekd
         Vc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWy9ci/7RC4x/TJtQS7RlSSYczBWMhoVtk93GKkmwN6e2DBkEj1DmLhAl9JYJKoQWjuK/CQjVoqqDRs8SWCMSaqtbWV5wv1dXAQtp8StA==
X-Gm-Message-State: AOJu0YzQJsRIuSBshoGw3gqCHBehGlIlZ3tspMvXjqfq1Qs0/K5XOOsV
	NlKBzieCeULGwvGp9x+9QbIkT1FPDqWvt+kEVTVbBIFd4+nKQLhk6YNVG7XC9kFKw5BEpQkAfpW
	9mg==
X-Google-Smtp-Source: AGHT+IGmcq8HQqCEBWeZhNDcRf4OQCj0ptCPLBS+QbTgQQ1y6EL/L/eLL61CpiC1ccJurAx7LcZUvWTR4g4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:82:b0:609:78d7:4e9 with SMTP id
 be2-20020a05690c008200b0060978d704e9mr3296801ywb.6.1709749534383; Wed, 06 Mar
 2024 10:25:34 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:21 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-24-surenb@google.com>
Subject: [PATCH v5 23/37] mm/slab: add allocation accounting into slab
 allocation and free paths
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Account slab allocations using codetag reference embedded into slabobj_ext.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index e94d3cc1b270..ea122aeb89fc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1942,7 +1942,69 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	kfree(obj_exts);
 	slab->obj_exts = 0;
 }
+
+static inline bool need_slab_obj_ext(void)
+{
+	if (mem_alloc_profiling_enabled())
+		return true;
+
+	/*
+	 * CONFIG_MEMCG_KMEM creates vector of obj_cgroup objects conditionally
+	 * inside memcg_slab_post_alloc_hook. No other users for now.
+	 */
+	return false;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	struct slab *slab;
+
+	if (!need_slab_obj_ext())
+		return NULL;
+
+	if (!p)
+		return NULL;
+
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
+	slab = virt_to_slab(p);
+	if (!slab_obj_exts(slab) &&
+	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
+		 "%s, %s: Failed to create slab extension vector!\n",
+		 __func__, s->name))
+		return NULL;
+
+	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+}
+
+static inline void
+alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
+			     int objects)
+{
+	struct slabobj_ext *obj_exts;
+	int i;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return;
+
+	for (i = 0; i < objects; i++) {
+		unsigned int off = obj_to_index(s, slab, p[i]);
+
+		alloc_tag_sub(&obj_exts[off].ref, s->size);
+	}
+}
+
 #else /* CONFIG_SLAB_OBJ_EXT */
+
 static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			       gfp_t gfp, bool new_slab)
 {
@@ -1952,6 +2014,24 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
+
+static inline bool need_slab_obj_ext(void)
+{
+	return false;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	return NULL;
+}
+
+static inline void
+alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
+			     int objects)
+{
+}
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -2381,7 +2461,7 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online())
+	if (memcg_kmem_online() || need_slab_obj_ext())
 		free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
@@ -3833,6 +3913,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 			  unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	struct slabobj_ext *obj_exts;
 	bool kasan_init = init;
 	size_t i;
 	gfp_t init_flags = flags & gfp_allowed_mask;
@@ -3875,6 +3956,12 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
+		obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+		/* obj_exts can be allocated for other reasons */
+		if (likely(obj_exts) && mem_alloc_profiling_enabled())
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+#endif
 	}
 
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
@@ -4353,6 +4440,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, &object, 1);
+	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
 	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
 		do_slab_free(s, slab, object, object, 1, addr);
@@ -4363,6 +4451,7 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		    void *tail, void **p, int cnt, unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
+	alloc_tagging_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
-- 
2.44.0.278.ge034bb2e1d-goog


