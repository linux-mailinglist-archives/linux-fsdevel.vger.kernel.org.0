Return-Path: <linux-fsdevel+bounces-15306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53688BFC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DA21C3EA8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45B4DA18;
	Tue, 26 Mar 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCpllyKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWpFples";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PwnGi39Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CD1op1JG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500184A33;
	Tue, 26 Mar 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449476; cv=none; b=gpyfEdSIsze79IhbczRtQ5d3C6fmJtLo2r8skHXBMEs3q2TMBDkcQBePOqrkdnaNPfQYcFT10abYsdHAu/OAYlQ0qYlKRlU4rUeUxdcpvMWS0Jkq+YI7BtE7lcOEnR4zzKyeCm+MBEH4YuVhNyRHwmt7MnVPUPUWCv7QEVpQV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449476; c=relaxed/simple;
	bh=Ef6ry3rkXSHybfPVL08fo6mn1Sdgp7WIoOxeD10eQkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxlHGHEjcqchw5k3sCScjr6W3Z2UO0ZNj8ipkniUdQ3RD79fXGOrEuxBX/LEr8iENh5GzlDPiHdF8QHgKJhXUjEJr7WwBWfWkhoUiq8f7ZEvy4wC8FivlEptE61GRnqdRiZFxnSz/p3+bYhUETMxDnfQorrKItEL2COnGyfTFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCpllyKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWpFples; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PwnGi39Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CD1op1JG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 588C237A70;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDfSPXjTzI8NpXr42wOWxfoEVhCQpaMh0AnyozY6l0E=;
	b=GCpllyKECK9loiIlPQRKwi2+c3gbX7EqAX/DuIN9UOfwf582bMqb/kcgEu6N6BOF57ujTs
	hCl3BaveQ5DZDlmsYTVkTG6VOomCESkDZzV71nTMXLOw2FX1mGclnMtKXwYiAGSOdG1VC5
	Sw9ca5Ccbv3MNhmFkN/zjykq7ctx3Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDfSPXjTzI8NpXr42wOWxfoEVhCQpaMh0AnyozY6l0E=;
	b=oWpFples/lcvviFjY1gsgzeNjy0fmnQ/iUUb9UGyEJoymOebLjrCWuyli1vrlpAL31qhG+
	CoBlYMsrGLW2XFCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDfSPXjTzI8NpXr42wOWxfoEVhCQpaMh0AnyozY6l0E=;
	b=PwnGi39Q0EbhixY/+JdWiGWqkvZnIz8QuXyRhYQu+xQaRZdCzeUPJ0NURy6vbT8chtnl9H
	3F5+sk4xBNrR9zB1OhL2Wg7yhTdZJMM/SEqdfXQmoyqYEFQ68s3EI71q9sIbrKjzJihpzL
	12LN9twHBQ7SV2lK8UizSMc90KYLXGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDfSPXjTzI8NpXr42wOWxfoEVhCQpaMh0AnyozY6l0E=;
	b=CD1op1JGC7naV6cSaHPt/62+MZpbcpO4Vaix4IrNiKj2bN47TIka12TZn0esuqu4WUbvSd
	opbH8nSVxM89uBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31C9013939;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDffC3+lAmb/AwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 10:37:51 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 26 Mar 2024 11:37:39 +0100
Subject: [PATCH mm-unstable v3 2/2] mm, slab: move slab_memcg hooks to
 mm/memcontrol.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-slab-memcg-v3-2-d85d2563287a@suse.cz>
References: <20240326-slab-memcg-v3-0-d85d2563287a@suse.cz>
In-Reply-To: <20240326-slab-memcg-v3-0-d85d2563287a@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8601; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Ef6ry3rkXSHybfPVL08fo6mn1Sdgp7WIoOxeD10eQkM=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMaQxLa3xDFuuHCc3N/fF7zCxOu69gv5vt5YpK1T2x89fa
 aga9Di/k9GYhYGRg0FWTJGlevcJR9GZyh7TPHw/wgxiZQKZwsDFKQATYevlYOhyWq30JvCU97XL
 k3kuV6xfduSqpMH/y8a8fskh11+fF+A7tmUmW2iqtfx/1m4lz7LwN/7alhop8wTeyMo62HFdmbf
 3aPGjTXvslfas7yvg5r9V8ipCfkl2yYfiG523rYWFL3hElz3cf63wjV2xygKT98s5LXfky01wni
 LpJ6Xztj3qu+TNFYw/nCfX/IwztJu67GhlwyGbEn27KLv1aqtXeeW7Wy7REBN7YsrH7CApfnPzn
 IViD+eqtjWffnbjsSqf2Za5NTKBfTbh7pl5K7z+Tv+UoiCpLtMs8zVTxilLfOe5+a1R+RkvEg3r
 PO+uftl+UNo6dTZbq/HRqsxFZzeEzDXasc6n2Se6f2MtAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 R_RATELIMIT(0.00)[to_ip_from(RL8ogcagzi1y561i1mcnzpnkwh)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The hooks make multiple calls to functions in mm/memcontrol.c, including
to th current_obj_cgroup() marked __always_inline. It might be faster to
make a single call to the hook in mm/memcontrol.c instead. The hooks
also don't use almost anything from mm/slub.c. obj_full_size() can move
with the hooks and cache_vmstat_idx() to the internal mm/slab.h

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c |  90 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h       |  13 +++++++
 mm/slub.c       | 103 ++------------------------------------------------------
 3 files changed, 105 insertions(+), 101 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0a0720858ddb..1b3c3394a2ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3558,6 +3558,96 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
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
+		if (!slab_obj_exts(slab) &&
+		    alloc_slab_obj_exts(slab, s, flags, false)) {
+			obj_cgroup_uncharge(objcg, obj_full_size(s));
+			continue;
+		}
+
+		off = obj_to_index(s, slab, p[i]);
+		obj_cgroup_get(objcg);
+		slab_obj_exts(slab)[off].objcg = objcg;
+		mod_objcg_state(objcg, slab_pgdat(slab),
+				cache_vmstat_idx(s), obj_full_size(s));
+	}
+
+	return true;
+}
+
+void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+			    void **p, int objects, struct slabobj_ext *obj_exts)
+{
+	for (int i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
+
+		off = obj_to_index(s, slab, p[i]);
+		objcg = obj_exts[off].objcg;
+		if (!objcg)
+			continue;
+
+		obj_exts[off].objcg = NULL;
+		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg);
+	}
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
diff --git a/mm/slab.h b/mm/slab.h
index 1343bfa12cee..411251b9bdd1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -558,6 +558,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
 }
 
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+                        gfp_t gfp, bool new_slab);
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
@@ -567,7 +570,17 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
+{
+	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
+bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
+				  gfp_t flags, size_t size, void **p);
+void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
+			    void **p, int objects, struct slabobj_ext *obj_exts);
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 263ff2a9f251..f5b151a58b7d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1865,12 +1865,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 #endif
 #endif /* CONFIG_SLUB_DEBUG */
 
-static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
-{
-	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
-}
-
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
@@ -1929,8 +1923,8 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
 				__GFP_ACCOUNT | __GFP_NOFAIL)
 
-static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-			       gfp_t gfp, bool new_slab)
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+		        gfp_t gfp, bool new_slab)
 {
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long new_exts;
@@ -2089,78 +2083,6 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEMCG_KMEM
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
-		if (!slab_obj_exts(slab) &&
-		    alloc_slab_obj_exts(slab, s, flags, false)) {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
-			continue;
-		}
-
-		off = obj_to_index(s, slab, p[i]);
-		obj_cgroup_get(objcg);
-		slab_obj_exts(slab)[off].objcg = objcg;
-		mod_objcg_state(objcg, slab_pgdat(slab),
-				cache_vmstat_idx(s), obj_full_size(s));
-	}
-
-	return true;
-}
 
 static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
 
@@ -2187,27 +2109,6 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	return false;
 }
 
-static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-				   void **p, int objects,
-				   struct slabobj_ext *obj_exts)
-{
-	for (int i = 0; i < objects; i++) {
-		struct obj_cgroup *objcg;
-		unsigned int off;
-
-		off = obj_to_index(s, slab, p[i]);
-		objcg = obj_exts[off].objcg;
-		if (!objcg)
-			continue;
-
-		obj_exts[off].objcg = NULL;
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


