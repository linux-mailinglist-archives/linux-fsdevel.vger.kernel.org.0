Return-Path: <linux-fsdevel+bounces-13317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08E86E6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8F51C25235
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB38F65;
	Fri,  1 Mar 2024 17:07:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785646A4;
	Fri,  1 Mar 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312834; cv=none; b=IPOQbl3bvRqdO2UP81MCm8VsIC8egP5z4KR/0Quos6B8PsptzowHYTpzq0mEoBfOjXoAVnPToEyIAVAELegANUSoXo9Bj/WcSlcFwYBchvPiF9VZfKXfAzanAy0joLuonoq5FG4iohviWxAmdkyuCqtH6fH9mlZbfFLF1kI/QfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312834; c=relaxed/simple;
	bh=tRcNrdDwOlxAEXA83t7g4wJfIiyligzzo/g9KIbU0M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjnATXkxCDgv2HT4hj1cCoFwKpxOCgZrA7x8zk+KiVMZ7Jpz+bisIFx9A+5Kgp8zlA0iZl+ZFoTyvTFiiFgILfvgHrVR3Jx4B+NTwYnUrG4K2kiVjniLi0K32abiIqD33uKJsgVIp9j0mOgIB2bN0YgywC5jEp70ua/L6IRIJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4782207B6;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A05F613AB0;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FbfJj4L4mUcGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 17:07:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 01 Mar 2024 18:07:09 +0100
Subject: [PATCH RFC 2/4] mm, slab: move slab_memcg hooks to mm/memcontrol.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-slab-memcg-v1-2-359328a46596@suse.cz>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
In-Reply-To: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
 Muchun Song <muchun.song@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C4782207B6
X-Spam-Flag: NO

The hooks make multiple calls to functions in mm/memcontrol.c, including
to th current_obj_cgroup() marked __always_inline. It might be faster to
make a single call to the hook in mm/memcontrol.c instead. The hooks
also don't use almost anything from mm/slub.c. obj_full_size() can move
with the hooks and cache_vmstat_idx() to the internal mm/slab.h

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h       |  10 ++++++
 mm/slub.c       | 100 --------------------------------------------------------
 3 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..37ee9356a26c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3575,6 +3575,96 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+static inline size_t obj_full_size(struct kmem_cache *s)
+{
+	/*
+	 * For each accounted object there is an extra space which is used
+	 * to store obj_cgroup membership. Charge it too.
+	 */
+	return s->size + sizeof(struct obj_cgroup *);
+}
+
+bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
+				  gfp_t flags, size_t size, void **p)
+{
+	struct obj_cgroup *objcg;
+	struct slab *slab;
+	unsigned long off;
+	size_t i;
+
+	/*
+	 * The obtained objcg pointer is safe to use within the current scope,
+	 * defined by current task or set_active_memcg() pair.
+	 * obj_cgroup_get() is used to get a permanent reference.
+	 */
+	objcg = current_obj_cgroup();
+	if (!objcg)
+		return true;
+
+	/*
+	 * slab_alloc_node() avoids the NULL check, so we might be called with a
+	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
+	 * the whole requested size.
+	 * return success as there's nothing to free back
+	 */
+	if (unlikely(*p == NULL))
+		return true;
+
+	flags &= gfp_allowed_mask;
+
+	if (lru) {
+		int ret;
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		ret = memcg_list_lru_alloc(memcg, lru, flags);
+		css_put(&memcg->css);
+
+		if (ret)
+			return false;
+	}
+
+	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
+		return false;
+
+	for (i = 0; i < size; i++) {
+		slab = virt_to_slab(p[i]);
+
+		if (!slab_objcgs(slab) &&
+		    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
+			obj_cgroup_uncharge(objcg, obj_full_size(s));
+			continue;
+		}
+
+		off = obj_to_index(s, slab, p[i]);
+		obj_cgroup_get(objcg);
+		slab_objcgs(slab)[off] = objcg;
+		mod_objcg_state(objcg, slab_pgdat(slab),
+				cache_vmstat_idx(s), obj_full_size(s));
+	}
+
+	return true;
+}
+
+void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+			    void **p, int objects, struct obj_cgroup **objcgs)
+{
+	for (int i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off = obj_to_index(s, slab, p[i]);
+		objcg = objcgs[off];
+		if (!objcg)
+			continue;
+
+		objcgs[off] = NULL;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg);
+	}
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..3f170673fa55 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -541,6 +541,12 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
+static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
+{
+	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * slab_objcgs - get the object cgroups vector associated with a slab
@@ -564,6 +570,10 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
 				 gfp_t gfp, bool new_slab);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
+bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
+				  gfp_t flags, size_t size, void **p);
+void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+			    void **p, int objects, struct obj_cgroup **objcgs);
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 7022a1246bab..64da169d672a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1875,12 +1875,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 #endif
 #endif /* CONFIG_SLUB_DEBUG */
 
-static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
-{
-	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
@@ -1888,79 +1882,6 @@ static inline void memcg_free_slab_cgroups(struct slab *slab)
 	slab->memcg_data = 0;
 }
 
-static inline size_t obj_full_size(struct kmem_cache *s)
-{
-	/*
-	 * For each accounted object there is an extra space which is used
-	 * to store obj_cgroup membership. Charge it too.
-	 */
-	return s->size + sizeof(struct obj_cgroup *);
-}
-
-static bool __memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					 struct list_lru *lru,
-					 gfp_t flags, size_t size,
-					 void **p)
-{
-	struct obj_cgroup *objcg;
-	struct slab *slab;
-	unsigned long off;
-	size_t i;
-
-	/*
-	 * The obtained objcg pointer is safe to use within the current scope,
-	 * defined by current task or set_active_memcg() pair.
-	 * obj_cgroup_get() is used to get a permanent reference.
-	 */
-	objcg = current_obj_cgroup();
-	if (!objcg)
-		return true;
-
-	/*
-	 * slab_alloc_node() avoids the NULL check, so we might be called with a
-	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
-	 * the whole requested size.
-	 * return success as there's nothing to free back
-	 */
-	if (unlikely(*p == NULL))
-		return true;
-
-	flags &= gfp_allowed_mask;
-
-	if (lru) {
-		int ret;
-		struct mem_cgroup *memcg;
-
-		memcg = get_mem_cgroup_from_objcg(objcg);
-		ret = memcg_list_lru_alloc(memcg, lru, flags);
-		css_put(&memcg->css);
-
-		if (ret)
-			return false;
-	}
-
-	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
-		return false;
-
-	for (i = 0; i < size; i++) {
-		slab = virt_to_slab(p[i]);
-
-		if (!slab_objcgs(slab) &&
-		    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
-			continue;
-		}
-
-		off = obj_to_index(s, slab, p[i]);
-		obj_cgroup_get(objcg);
-		slab_objcgs(slab)[off] = objcg;
-		mod_objcg_state(objcg, slab_pgdat(slab),
-				cache_vmstat_idx(s), obj_full_size(s));
-	}
-
-	return true;
-}
-
 static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
 
 static __fastpath_inline
@@ -1986,27 +1907,6 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	return false;
 }
 
-static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-				   void **p, int objects,
-				   struct obj_cgroup **objcgs)
-{
-	for (int i = 0; i < objects; i++) {
-		struct obj_cgroup *objcg;
-		unsigned int off;
-
-		off = obj_to_index(s, slab, p[i]);
-		objcg = objcgs[off];
-		if (!objcg)
-			continue;
-
-		objcgs[off] = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
-		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
-				-obj_full_size(s));
-		obj_cgroup_put(objcg);
-	}
-}
-
 static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)

-- 
2.44.0


