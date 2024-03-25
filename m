Return-Path: <linux-fsdevel+bounces-15194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B188A18B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3E2C2886
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C7157E77;
	Mon, 25 Mar 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="knfY3406";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B7ZjA+xY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKp9U3Q7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1hSbzsvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CA14EC59;
	Mon, 25 Mar 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354872; cv=none; b=aEW0v8udLtWbQ3WmZp4MfokMjqQH9MzDuk3Ga8gcprbwmWCBn00aUT393Becl0WCmnUJ3WkBpPg6XU8iK2V1k0vz+wXZUkfDQf0qcE05X6ChBdkd3rRBtDxsSy17+MYCpvpQjzx01EaaZlyaI47EMTtpdbWqWS+4dCoWNx3FdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354872; c=relaxed/simple;
	bh=ZXVKQAcpsecEUJrLf6SMbGT4m0x0VupUvlNRbOOhWz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mf8AE/xeS89VyTCxmxWRcn1jY6gkbJZHj9YTguFoMgTvSqrjUQPzFEwEJTkaAckByDBkSm+lmsgZ7Q/0ELyqN1KIJcI+YHheCeu1gnuV/7tCfAcnBtyDC3ZzU13+EeAVW7TmlEMh0GvxyUxfF18zkNcb8ifhQiO2dJMb1OoMb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=knfY3406; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B7ZjA+xY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKp9U3Q7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1hSbzsvT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC4D534F0D;
	Mon, 25 Mar 2024 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711354867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5FujWhE4ePSZABvJJY1Hjqo6a8La3zymd24T6fptk=;
	b=knfY3406+qtqcyYqNGEeleYSScdJKPTl+tYGIkaYRnxsX9ObPJTUR+por0ziqXd0joWWGE
	P5it5IDBnHaAfUtlN9YPJsg4byjCfmGAuVd0cO9cJFu+Xg/D9p0MazBx/JQyr0OeyGmgJW
	1f6/Ad0DP+bseTiTIj+lnDW1cESeiAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711354867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5FujWhE4ePSZABvJJY1Hjqo6a8La3zymd24T6fptk=;
	b=B7ZjA+xYbbMJNB2Q3+hxPYkHZY9dpu8bWhMq24q7D6wYSqD+NJlOBPFjS0YTr/aQMlnqqX
	q90VLofJMJsFbcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711354865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5FujWhE4ePSZABvJJY1Hjqo6a8La3zymd24T6fptk=;
	b=hKp9U3Q7NN+Eo+d57QIoPzID+K0Vacn4hOBbK1fRyjzXIqfEjAzQQygjEz7HeHs9MX/UW4
	+DLp3Umjlr8Zw7+updM4oS9Hj28AU5X7Lrwu1B9yBLvEjpo1siC1RAc0LYG1WB3oJCYhzG
	chrafWrIvw/u1Iid5kVskLehNM7SOAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711354865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5FujWhE4ePSZABvJJY1Hjqo6a8La3zymd24T6fptk=;
	b=1hSbzsvTE7u8hb5Y6OxbRRAQkz5qIXUAUGMRilWI/nOyYEFYGA7J2DSZG3TtU60ld+rwXR
	4tzmC+OC5g70LUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8877F137EB;
	Mon, 25 Mar 2024 08:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gEAKIfEzAWZdHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 08:21:05 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 25 Mar 2024 09:20:33 +0100
Subject: [PATCH v2 2/2] mm, slab: move slab_memcg hooks to mm/memcontrol.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-slab-memcg-v2-2-900a458233a6@suse.cz>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
In-Reply-To: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7960; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=ZXVKQAcpsecEUJrLf6SMbGT4m0x0VupUvlNRbOOhWz8=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmATPtqqfjDNILmUB7ToGV79nSfofuBNG/8B0z3
 V/UTeKLnsmJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZgEz7QAKCRC74LB10kWI
 mqxyB/9AqeFQWjXz1ARTA0lp91IjDyuq3WsUEJJaVjfyJOX42Uuqle+axIyEYvNVG3MvhKbpIxQ
 D9deAf2gsFjJaGw3Ec8C3p42QB0e4mgHNqIss7ZWN42CKeEgIQc4ognHl5WC/Uj6hlEN4OgyhmS
 mxHCNXMotOhu61sRiwPtv0XfcSSL9cNMTm13UjruoA1fEf3pVtH+wS5u0tkFUp5UrhrARkB0yit
 JNLCbfW5hQxzM0J4QMfjcjKoV33zFcpAY7s5MkP7TM49hxr38/gFt16NRbiSl+yY0vUP59uQJqP
 NORledQ++brCmzAm7XFCvYPYw3ttV5gsYfC9BoRqwjMmvDPf
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL8ogcagzi1y561i1mcnzpnkwh)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.dev:email];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

The hooks make multiple calls to functions in mm/memcontrol.c, including
to th current_obj_cgroup() marked __always_inline. It might be faster to
make a single call to the hook in mm/memcontrol.c instead. The hooks
also don't use almost anything from mm/slub.c. obj_full_size() can move
with the hooks and cache_vmstat_idx() to the internal mm/slab.h

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h       |  10 ++++++
 mm/slub.c       | 100 --------------------------------------------------------
 3 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c69..fb101ff1f37c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3602,6 +3602,96 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
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
index d2bc9b191222..d8052dda78d7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -536,6 +536,12 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
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
@@ -559,6 +565,10 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
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
index 2440984503c8..87fa76c1105e 100644
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
 #ifdef CONFIG_MEMCG_KMEM
 static inline void memcg_free_slab_cgroups(struct slab *slab)
 {
@@ -1878,79 +1872,6 @@ static inline void memcg_free_slab_cgroups(struct slab *slab)
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
@@ -1976,27 +1897,6 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
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


