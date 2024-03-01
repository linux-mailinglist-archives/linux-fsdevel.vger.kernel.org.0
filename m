Return-Path: <linux-fsdevel+bounces-13320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E586E6C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC24728BC11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97D19479;
	Fri,  1 Mar 2024 17:07:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825972571;
	Fri,  1 Mar 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312835; cv=none; b=YgHiBCCspc1Or7Cpfog9PuvfRaY3z/t/o063qu0I8Mox7P35ZS7M0ig9j4O8upDmAXsVVSQgOtUSy42G184Fwd+fr3ZQVOi3eGP4RBE7bG0c5jEE4dpGzuL8uVI0pqsZFSBfZc4Lzda42bHP8dRHAx0wObPSsgF/0yLwdO163pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312835; c=relaxed/simple;
	bh=Ss/e4gGxC24daD3nyMEINkiPC9L7D1njVPpAZVM+9sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5muM0cTLIdxbHj2QWTOyU3PkSGhlaTw34/m7y/Ok/UQ4SrJrIZ6NTrNsuiCJwPbsF8kKZ8gFFhjR1/za8AdreoGilGsDWXQ3qgpgg/71/vv5xwcdKKupDnB5qsvGiXM2xj4QuEIvmBoSbevzqoTYvBYh8fDaiVF7u1zxCn0Zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B170733D2C;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD6813AA3;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PIzHj4L4mUcGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 17:07:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 01 Mar 2024 18:07:08 +0100
Subject: [PATCH RFC 1/4] mm, slab: move memcg charging to post-alloc hook
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B170733D2C
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The MEMCG_KMEM integration with slab currently relies on two hooks
during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
to the allocated object(s).

As Linus pointed out, this is unnecessarily complex. Failing to charge
due to memcg limits should be rare, so we can optimistically allocate
the object(s) and do the charging together with assigning the objcg
pointer in a single post_alloc hook. In the rare case the charging
fails, we can free the object(s) back.

This simplifies the code (no need to pass around the objcg pointer) and
potentially allows to separate charging from allocation in cases where
it's common that the allocation would be immediately freed, and the
memcg handling overhead could be saved.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
 1 file changed, 77 insertions(+), 103 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..7022a1246bab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1897,23 +1897,36 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 	return s->size + sizeof(struct obj_cgroup *);
 }
 
-/*
- * Returns false if the allocation should fail.
- */
-static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-					struct list_lru *lru,
-					struct obj_cgroup **objcgp,
-					size_t objects, gfp_t flags)
+static bool __memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					 struct list_lru *lru,
+					 gfp_t flags, size_t size,
+					 void **p)
 {
+	struct obj_cgroup *objcg;
+	struct slab *slab;
+	unsigned long off;
+	size_t i;
+
 	/*
 	 * The obtained objcg pointer is safe to use within the current scope,
 	 * defined by current task or set_active_memcg() pair.
 	 * obj_cgroup_get() is used to get a permanent reference.
 	 */
-	struct obj_cgroup *objcg = current_obj_cgroup();
+	objcg = current_obj_cgroup();
 	if (!objcg)
 		return true;
 
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
 	if (lru) {
 		int ret;
 		struct mem_cgroup *memcg;
@@ -1926,71 +1939,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 			return false;
 	}
 
-	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
+	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
 		return false;
 
-	*objcgp = objcg;
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
 	return true;
 }
 
-/*
- * Returns false if the allocation should fail.
- */
+static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
+
 static __fastpath_inline
-bool memcg_slab_pre_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
-			       struct obj_cgroup **objcgp, size_t objects,
-			       gfp_t flags)
+bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
+				gfp_t flags, size_t size, void **p)
 {
-	if (!memcg_kmem_online())
+	if (likely(!memcg_kmem_online()))
 		return true;
 
 	if (likely(!(flags & __GFP_ACCOUNT) && !(s->flags & SLAB_ACCOUNT)))
 		return true;
 
-	return likely(__memcg_slab_pre_alloc_hook(s, lru, objcgp, objects,
-						  flags));
-}
-
-static void __memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					 struct obj_cgroup *objcg,
-					 gfp_t flags, size_t size,
-					 void **p)
-{
-	struct slab *slab;
-	unsigned long off;
-	size_t i;
-
-	flags &= gfp_allowed_mask;
-
-	for (i = 0; i < size; i++) {
-		if (likely(p[i])) {
-			slab = virt_to_slab(p[i]);
-
-			if (!slab_objcgs(slab) &&
-			    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
-				obj_cgroup_uncharge(objcg, obj_full_size(s));
-				continue;
-			}
+	if (likely(__memcg_slab_post_alloc_hook(s, lru, flags, size, p)))
+		return true;
 
-			off = obj_to_index(s, slab, p[i]);
-			obj_cgroup_get(objcg);
-			slab_objcgs(slab)[off] = objcg;
-			mod_objcg_state(objcg, slab_pgdat(slab),
-					cache_vmstat_idx(s), obj_full_size(s));
-		} else {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
-		}
+	if (likely(size == 1)) {
+		memcg_alloc_abort_single(s, p);
+		*p = NULL;
+	} else {
+		kmem_cache_free_bulk(s, size, p);
 	}
-}
-
-static __fastpath_inline
-void memcg_slab_post_alloc_hook(struct kmem_cache *s, struct obj_cgroup *objcg,
-				gfp_t flags, size_t size, void **p)
-{
-	if (likely(!memcg_kmem_online() || !objcg))
-		return;
 
-	return __memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
+	return false;
 }
 
 static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
@@ -2029,14 +2022,6 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, objcgs);
 }
-
-static inline
-void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
-			   struct obj_cgroup *objcg)
-{
-	if (objcg)
-		obj_cgroup_uncharge(objcg, objects * obj_full_size(s));
-}
 #else /* CONFIG_MEMCG_KMEM */
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
@@ -2047,31 +2032,18 @@ static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
 }
 
-static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-					     struct list_lru *lru,
-					     struct obj_cgroup **objcgp,
-					     size_t objects, gfp_t flags)
-{
-	return true;
-}
-
-static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct obj_cgroup *objcg,
+static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct list_lru *lru,
 					      gfp_t flags, size_t size,
 					      void **p)
 {
+	return true;
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
-
-static inline
-void memcg_slab_alloc_error_hook(struct kmem_cache *s, int objects,
-				 struct obj_cgroup *objcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
@@ -3751,10 +3723,7 @@ noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
 
 static __fastpath_inline
-struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-				       struct list_lru *lru,
-				       struct obj_cgroup **objcgp,
-				       size_t size, gfp_t flags)
+struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
 
@@ -3763,14 +3732,11 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 	if (unlikely(should_failslab(s, flags)))
 		return NULL;
 
-	if (unlikely(!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags)))
-		return NULL;
-
 	return s;
 }
 
 static __fastpath_inline
-void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
+bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			  gfp_t flags, size_t size, void **p, bool init,
 			  unsigned int orig_size)
 {
@@ -3819,7 +3785,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		kmsan_slab_alloc(s, p[i], init_flags);
 	}
 
-	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
+	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
 }
 
 /*
@@ -3836,10 +3802,9 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
-	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
-	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
+	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
 		return NULL;
 
@@ -3856,8 +3821,10 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	/*
 	 * When init equals 'true', like for kzalloc() family, only
 	 * @orig_size bytes might be zeroed instead of s->object_size
+	 * In case this fails due to memcg_slab_post_alloc_hook(),
+	 * object is set to NULL
 	 */
-	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
+	slab_post_alloc_hook(s, lru, gfpflags, 1, &object, init, orig_size);
 
 	return object;
 }
@@ -4300,6 +4267,16 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+/* Do not inline the rare memcg charging failed path into the allocation path */
+static noinline
+void memcg_alloc_abort_single(struct kmem_cache *s, void *object)
+{
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+		do_slab_free(s, virt_to_slab(object), object, object, 1, _RET_IP_);
+}
+#endif
+
 static __fastpath_inline
 void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		    void *tail, void **p, int cnt, unsigned long addr)
@@ -4635,29 +4612,26 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
 	int i;
-	struct obj_cgroup *objcg = NULL;
 
 	if (!size)
 		return 0;
 
-	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
+	s = slab_pre_alloc_hook(s, flags);
 	if (unlikely(!s))
 		return 0;
 
 	i = __kmem_cache_alloc_bulk(s, flags, size, p);
+	if (unlikely(i == 0))
+		return 0;
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
 	 * Done outside of the IRQ disabled fastpath loop.
 	 */
-	if (likely(i != 0)) {
-		slab_post_alloc_hook(s, objcg, flags, size, p,
-			slab_want_init_on_alloc(flags, s), s->object_size);
-	} else {
-		memcg_slab_alloc_error_hook(s, size, objcg);
+	if (unlikely(!slab_post_alloc_hook(s, NULL, flags, size, p,
+		    slab_want_init_on_alloc(flags, s), s->object_size))) {
+		return 0;
 	}
-
 	return i;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);

-- 
2.44.0


