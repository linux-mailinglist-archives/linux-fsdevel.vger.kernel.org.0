Return-Path: <linux-fsdevel+bounces-15305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16AE88BFBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BB31F28DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1E495FD;
	Tue, 26 Mar 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6JfQaVG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="poNlEcWM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Bpz1pQK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n3gJJFTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE74A24;
	Tue, 26 Mar 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449476; cv=none; b=DKD46vX9ZW/nYZiOg857l68jFUR++tpw5afMJHyL65B7AN0HcNeqCaSwtxnmEG8zTezvY7Ud3Z7oK2hsTCxGw0VTDF4jvN7ueVa4/oE4WYRK2nfslvV7LfLwSm4t1CgDMDyFSLC7+RSzq/13/KeF0eJraOIZWmmbC+BIj+7spgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449476; c=relaxed/simple;
	bh=v8BpMQZJx/jvHbswkGC9Q5pVkesuLjgllv/l4RdaIt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmAw+0Dl6/ovG4HIS3SjqUlwyX2mFZ+E8UaGLJX0rONzYZOmQrWF+EzS7TfDesrBgoKpgKjz4IEA5sVk9Mj2pvpl+Qvo9MkGq14B1H4g3LWdymrf6oZFusJUi4lfr3K4soxSQN2hEkK79j1Ilmzl0VLglEBYl5rdRDEM6a5b5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6JfQaVG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=poNlEcWM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Bpz1pQK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n3gJJFTR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3831237A6B;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdqpTNfBL6CDPsW+4XIFGU0dAIIklmVOKONFz+wRod4=;
	b=p6JfQaVGlBOAcnOm0QHMN9V3GMRqStWz/eJ5fpu45cysS/p/Lfuj95fv7MDUSsR4TCwyl9
	IhSlVXQabcmTkZ/ereOxnTr6u9ubW5WAcmVxVv/D7kigB6lhWJBDXHtcft/n8aQMZq42Bl
	pa6PXRebIE6B3P3wAzSKPQiLQLSshnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdqpTNfBL6CDPsW+4XIFGU0dAIIklmVOKONFz+wRod4=;
	b=poNlEcWMJfuSQ9MrQW7HILiTVogJ7HWHHVe9FcRuVR4qgVZnKblvvaAfU6+AklIpvYjarm
	WFsM+T1YXp5VLHCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711449471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdqpTNfBL6CDPsW+4XIFGU0dAIIklmVOKONFz+wRod4=;
	b=1Bpz1pQKjMkK4KAZT0LcHpQ/KzwlqAJyV07KCdM4xF85yQXweRf3eHqiSaU2TJWZUrgAuJ
	yi8wCcfSNOQdW40CKce7qUVYUrRa+0l2KH7rui9vOIS0zipTCJxt0c55HE2pQX15+n5PtD
	DpQlzRoEEDwecyW5FC/tVAch3RtMu28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711449471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdqpTNfBL6CDPsW+4XIFGU0dAIIklmVOKONFz+wRod4=;
	b=n3gJJFTR05soFbll0onq0dgeqNEx8cIfiCanw3NXYhi5jtzRsOyN+twfsV5tljhJGlH32X
	7LhKgM1514TkEjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF3513931;
	Tue, 26 Mar 2024 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JVhA3+lAmb/AwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 10:37:51 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 26 Mar 2024 11:37:38 +0100
Subject: [PATCH mm-unstable v3 1/2] mm, slab: move memcg charging to
 post-alloc hook
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-slab-memcg-v3-1-d85d2563287a@suse.cz>
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
 Vlastimil Babka <vbabka@suse.cz>, Chengming Zhou <chengming.zhou@linux.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10626; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=v8BpMQZJx/jvHbswkGC9Q5pVkesuLjgllv/l4RdaIt0=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmAqV5p4vALUxpS4sW6IQ8HQ9z906F1bgJ44ngi
 7qGfjwD+aOJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZgKleQAKCRC74LB10kWI
 mjqYB/oDcOQmJEhS/JjtgM8SVghbqNGDKMUWHK25Dk421AR7DfO/cEKQdYMp3aIAeT3i47odpQJ
 F3dW9GCNEvOw9ZAdgWY9mtgE3CpQZE6zkShwuV4x7xJBqtxlvZ8S/UJDX0+ZknSfjiWu0pdq2mU
 pm4B53rkC6Fr8GvVzq4vSQnK9EeL0JkpuXw6g5yj2wpdR66aMXiqpUGvJToS6XjgA+rDTb2nkJ+
 BAL8LkqcygUAb0iWpruutA/SPjA1/9miGu6qzqj1/cY5VavlK3yD1J3rQqEtzS8ZbqeeoAykRdq
 9iQFPgve7fOpMFj6LBiu61FVkOi4DCFU41vgNeY/eOFSiRVD
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,linux.dev,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[25];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Bpz1pQK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n3gJJFTR
X-Rspamd-Queue-Id: 3831237A6B

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
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
 1 file changed, 77 insertions(+), 103 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7b68a3451eb9..263ff2a9f251 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2098,23 +2098,36 @@ static inline size_t obj_full_size(struct kmem_cache *s)
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
@@ -2127,71 +2140,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 			return false;
 	}
 
-	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
+	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
 		return false;
 
-	*objcgp = objcg;
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
-			if (!slab_obj_exts(slab) &&
-			    alloc_slab_obj_exts(slab, s, flags, false)) {
-				obj_cgroup_uncharge(objcg, obj_full_size(s));
-				continue;
-			}
+	if (likely(__memcg_slab_post_alloc_hook(s, lru, flags, size, p)))
+		return true;
 
-			off = obj_to_index(s, slab, p[i]);
-			obj_cgroup_get(objcg);
-			slab_obj_exts(slab)[off].objcg = objcg;
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
@@ -2230,40 +2223,19 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
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
@@ -3943,10 +3915,7 @@ noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
 
 static __fastpath_inline
-struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-				       struct list_lru *lru,
-				       struct obj_cgroup **objcgp,
-				       size_t size, gfp_t flags)
+struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
 
@@ -3955,14 +3924,11 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
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
@@ -4024,7 +3990,7 @@ void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
 		}
 	}
 
-	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
+	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
 }
 
 /*
@@ -4041,10 +4007,9 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
-	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
-	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
+	s = slab_pre_alloc_hook(s, gfpflags);
 	if (unlikely(!s))
 		return NULL;
 
@@ -4061,8 +4026,10 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
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
@@ -4502,6 +4469,16 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
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
@@ -4838,29 +4815,26 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
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
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);

-- 
2.44.0


