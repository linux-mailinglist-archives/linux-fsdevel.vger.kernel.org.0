Return-Path: <linux-fsdevel+bounces-59796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3BB3E127
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9F7AB9F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015631B11A;
	Mon,  1 Sep 2025 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4Vj+JP2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uehvyEa+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7RHCXFy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="99AyC0vR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA631AF08
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724975; cv=none; b=e/zJo70CEesat5Kmp1/20pDnqy0zWCO6k6zqdMQyMprASZBP+A5zmA1Qm3ZSGnj6UjmD5DE7je9G5aBy375k1Q7dNpoVdcbcDySZWQC9Hx1EP4LPU5yU7T7CR9JQYQnQU5AqMd0jqa23g+7wnoZewAJS8KTxBVhlvFSk/Mp/RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724975; c=relaxed/simple;
	bh=rcDxtjdz4Ghoo1ymRr7DS+ySy65r5C3QYO2Bl8V9/G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx1poFEI+SJ8P59KKMqHQdoKTYuUrONv5377fkWAOPJ+vrCwJTdmQQh/qVz46fdrUh+tII/3mmahNLGScNpQbBSFvucNgJwm8zTU3Uz36WOUMnQqjsegg7+HvsqiR1JmvQ2gsUkUWaWRKtlxqecBIX6+m6K/0Cx76/Uir/woNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4Vj+JP2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uehvyEa+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j7RHCXFy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=99AyC0vR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F03862117C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=240g5gOvCSTSQtFdroGNL/n4PS7v1EePvChrfoLWaKs=;
	b=i4Vj+JP2PCBpH0KMX3lXYaPstnXUFWkc9J1aiaBW7yhVGZZpIfGQXmMwzBSGv7ADKmJjz/
	KSr4YEHadxfCM2xYPh+sqKMrOBCwTUjMTTPBIKed6emchi3XHxEXnjI7ylmO+GhGesgub0
	UWnFibUll++lziv1FFyWAYSXhx1gN+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=240g5gOvCSTSQtFdroGNL/n4PS7v1EePvChrfoLWaKs=;
	b=uehvyEa+LJKHl5A8ZS8Csn2aIOq4a3jvkD0Mps6i6zkMiVoBrkKJZUO5Wdf2UhG8lh0z+v
	ABO6QQK99khZOYAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j7RHCXFy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=99AyC0vR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=240g5gOvCSTSQtFdroGNL/n4PS7v1EePvChrfoLWaKs=;
	b=j7RHCXFyq+VM9Is0qcDDQimAV9o+rj9F9p5psPg5QKhILw7mg288pu00DvqyN+qEuCec6A
	JsbXaiRlwGZclfL3igmXrmHAj9zTBjiQ05Z3fZoh7u6n/H71A2MtoH2+Pdd/5lg+9N0v7U
	ZvNjGbg75V6t0exrG85NFemDZ7X/1X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=240g5gOvCSTSQtFdroGNL/n4PS7v1EePvChrfoLWaKs=;
	b=99AyC0vRpSTT51zWCBDYBH1Uj0rF88H3Dk9K7W5hpxLtUOk5MeUybh7ShH9PDIP2dVze2f
	ZJc0Tj3BGVlOS2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D46CD13A31;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iBuXM8V+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:09:00 +0200
Subject: [PATCH 10/12] maple_tree: Sheaf conversion and testing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-10-d6a1166b53f2@suse.cz>
References: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
In-Reply-To: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5jz3zk9nm44ai14dcppf93zb)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F03862117C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Use sheaves instead of bulk allocations.  This should speed up the
allocations and the return path of unused allocations.

Remove the push and pop of nodes from the maple state as this is now
handled by the slab layer with sheaves.

Testing has been removed as necessary since the features of the tree
have been reduced.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/maple_tree.h       |   6 +-
 lib/maple_tree.c                 | 329 ++++++---------------------
 lib/test_maple_tree.c            |   8 +
 tools/testing/radix-tree/maple.c | 464 ++-------------------------------------
 tools/testing/shared/linux.c     |   5 +-
 5 files changed, 99 insertions(+), 713 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index bafe143b1f783202e27b32567fffee4149e8e266..166fd67e00d882b1e6de1f80c1b590bba7497cd3 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -442,7 +442,8 @@ struct ma_state {
 	struct maple_enode *node;	/* The node containing this entry */
 	unsigned long min;		/* The minimum index of this node - implied pivot min */
 	unsigned long max;		/* The maximum index of this node - implied pivot max */
-	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
+	struct slab_sheaf *sheaf;	/* Allocated nodes for this operation */
+	unsigned long node_request;
 	enum maple_status status;	/* The status of the state (active, start, none, etc) */
 	unsigned char depth;		/* depth of tree descent during write */
 	unsigned char offset;
@@ -490,7 +491,8 @@ struct ma_wr_state {
 		.status = ma_start,					\
 		.min = 0,						\
 		.max = ULONG_MAX,					\
-		.alloc = NULL,						\
+		.node_request= 0,					\
+		.sheaf = NULL,						\
 		.mas_flags = 0,						\
 		.store_type = wr_invalid,				\
 	}
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b361b484cfcaacd99472dd4c2b8de9260b307425..cfe80c50a97e3118eefc24275fbcd2eec5e6e6e8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -186,6 +186,22 @@ static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
 }
 
+static void mt_return_sheaf(struct slab_sheaf *sheaf)
+{
+	kmem_cache_return_sheaf(maple_node_cache, GFP_KERNEL, sheaf);
+}
+
+static struct slab_sheaf *mt_get_sheaf(gfp_t gfp, int count)
+{
+	return kmem_cache_prefill_sheaf(maple_node_cache, gfp, count);
+}
+
+static int mt_refill_sheaf(gfp_t gfp, struct slab_sheaf **sheaf,
+		unsigned int size)
+{
+	return kmem_cache_refill_sheaf(maple_node_cache, gfp, sheaf, size);
+}
+
 /*
  * ma_free_rcu() - Use rcu callback to free a maple node
  * @node: The node to free
@@ -578,67 +594,6 @@ static __always_inline bool mte_dead_node(const struct maple_enode *enode)
 	return ma_dead_node(node);
 }
 
-/*
- * mas_allocated() - Get the number of nodes allocated in a maple state.
- * @mas: The maple state
- *
- * The ma_state alloc member is overloaded to hold a pointer to the first
- * allocated node or to the number of requested nodes to allocate.  If bit 0 is
- * set, then the alloc contains the number of requested nodes.  If there is an
- * allocated node, then the total allocated nodes is in that node.
- *
- * Return: The total number of nodes allocated
- */
-static inline unsigned long mas_allocated(const struct ma_state *mas)
-{
-	if (!mas->alloc || ((unsigned long)mas->alloc & 0x1))
-		return 0;
-
-	return mas->alloc->total;
-}
-
-/*
- * mas_set_alloc_req() - Set the requested number of allocations.
- * @mas: the maple state
- * @count: the number of allocations.
- *
- * The requested number of allocations is either in the first allocated node,
- * located in @mas->alloc->request_count, or directly in @mas->alloc if there is
- * no allocated node.  Set the request either in the node or do the necessary
- * encoding to store in @mas->alloc directly.
- */
-static inline void mas_set_alloc_req(struct ma_state *mas, unsigned long count)
-{
-	if (!mas->alloc || ((unsigned long)mas->alloc & 0x1)) {
-		if (!count)
-			mas->alloc = NULL;
-		else
-			mas->alloc = (struct maple_alloc *)(((count) << 1U) | 1U);
-		return;
-	}
-
-	mas->alloc->request_count = count;
-}
-
-/*
- * mas_alloc_req() - get the requested number of allocations.
- * @mas: The maple state
- *
- * The alloc count is either stored directly in @mas, or in
- * @mas->alloc->request_count if there is at least one node allocated.  Decode
- * the request count if it's stored directly in @mas->alloc.
- *
- * Return: The allocation request count.
- */
-static inline unsigned int mas_alloc_req(const struct ma_state *mas)
-{
-	if ((unsigned long)mas->alloc & 0x1)
-		return (unsigned long)(mas->alloc) >> 1;
-	else if (mas->alloc)
-		return mas->alloc->request_count;
-	return 0;
-}
-
 /*
  * ma_pivots() - Get a pointer to the maple node pivots.
  * @node: the maple node
@@ -1142,77 +1097,15 @@ static int mas_ascend(struct ma_state *mas)
  */
 static inline struct maple_node *mas_pop_node(struct ma_state *mas)
 {
-	struct maple_alloc *ret, *node = mas->alloc;
-	unsigned long total = mas_allocated(mas);
-	unsigned int req = mas_alloc_req(mas);
+	struct maple_node *ret;
 
-	/* nothing or a request pending. */
-	if (WARN_ON(!total))
+	if (WARN_ON_ONCE(!mas->sheaf))
 		return NULL;
 
-	if (total == 1) {
-		/* single allocation in this ma_state */
-		mas->alloc = NULL;
-		ret = node;
-		goto single_node;
-	}
-
-	if (node->node_count == 1) {
-		/* Single allocation in this node. */
-		mas->alloc = node->slot[0];
-		mas->alloc->total = node->total - 1;
-		ret = node;
-		goto new_head;
-	}
-	node->total--;
-	ret = node->slot[--node->node_count];
-	node->slot[node->node_count] = NULL;
-
-single_node:
-new_head:
-	if (req) {
-		req++;
-		mas_set_alloc_req(mas, req);
-	}
-
+	ret = kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT, mas->sheaf);
 	memset(ret, 0, sizeof(*ret));
-	return (struct maple_node *)ret;
-}
-
-/*
- * mas_push_node() - Push a node back on the maple state allocation.
- * @mas: The maple state
- * @used: The used maple node
- *
- * Stores the maple node back into @mas->alloc for reuse.  Updates allocated and
- * requested node count as necessary.
- */
-static inline void mas_push_node(struct ma_state *mas, struct maple_node *used)
-{
-	struct maple_alloc *reuse = (struct maple_alloc *)used;
-	struct maple_alloc *head = mas->alloc;
-	unsigned long count;
-	unsigned int requested = mas_alloc_req(mas);
 
-	count = mas_allocated(mas);
-
-	reuse->request_count = 0;
-	reuse->node_count = 0;
-	if (count) {
-		if (head->node_count < MAPLE_ALLOC_SLOTS) {
-			head->slot[head->node_count++] = reuse;
-			head->total++;
-			goto done;
-		}
-		reuse->slot[0] = head;
-		reuse->node_count = 1;
-	}
-
-	reuse->total = count + 1;
-	mas->alloc = reuse;
-done:
-	if (requested > 1)
-		mas_set_alloc_req(mas, requested - 1);
+	return ret;
 }
 
 /*
@@ -1222,75 +1115,32 @@ static inline void mas_push_node(struct ma_state *mas, struct maple_node *used)
  */
 static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 {
-	struct maple_alloc *node;
-	unsigned long allocated = mas_allocated(mas);
-	unsigned int requested = mas_alloc_req(mas);
-	unsigned int count;
-	void **slots = NULL;
-	unsigned int max_req = 0;
-
-	if (!requested)
-		return;
+	if (unlikely(mas->sheaf)) {
+		unsigned long refill = mas->node_request;
 
-	mas_set_alloc_req(mas, 0);
-	if (mas->mas_flags & MA_STATE_PREALLOC) {
-		if (allocated)
+		if(kmem_cache_sheaf_size(mas->sheaf) >= refill) {
+			mas->node_request = 0;
 			return;
-		WARN_ON(!allocated);
-	}
-
-	if (!allocated || mas->alloc->node_count == MAPLE_ALLOC_SLOTS) {
-		node = (struct maple_alloc *)mt_alloc_one(gfp);
-		if (!node)
-			goto nomem_one;
-
-		if (allocated) {
-			node->slot[0] = mas->alloc;
-			node->node_count = 1;
-		} else {
-			node->node_count = 0;
 		}
 
-		mas->alloc = node;
-		node->total = ++allocated;
-		node->request_count = 0;
-		requested--;
-	}
+		if (mt_refill_sheaf(gfp, &mas->sheaf, refill))
+			goto error;
 
-	node = mas->alloc;
-	while (requested) {
-		max_req = MAPLE_ALLOC_SLOTS - node->node_count;
-		slots = (void **)&node->slot[node->node_count];
-		max_req = min(requested, max_req);
-		count = mt_alloc_bulk(gfp, max_req, slots);
-		if (!count)
-			goto nomem_bulk;
-
-		if (node->node_count == 0) {
-			node->slot[0]->node_count = 0;
-			node->slot[0]->request_count = 0;
-		}
+		mas->node_request = 0;
+		return;
+	}
 
-		node->node_count += count;
-		allocated += count;
-		/* find a non-full node*/
-		do {
-			node = node->slot[0];
-		} while (unlikely(node->node_count == MAPLE_ALLOC_SLOTS));
-		requested -= count;
+	mas->sheaf = mt_get_sheaf(gfp, mas->node_request);
+	if (likely(mas->sheaf)) {
+		mas->node_request = 0;
+		return;
 	}
-	mas->alloc->total = allocated;
-	return;
 
-nomem_bulk:
-	/* Clean up potential freed allocations on bulk failure */
-	memset(slots, 0, max_req * sizeof(unsigned long));
-	mas->alloc->total = allocated;
-nomem_one:
-	mas_set_alloc_req(mas, requested);
+error:  
 	mas_set_err(mas, -ENOMEM);
 }
 
+
 /*
  * mas_free() - Free an encoded maple node
  * @mas: The maple state
@@ -1301,42 +1151,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
  */
 static inline void mas_free(struct ma_state *mas, struct maple_enode *used)
 {
-	struct maple_node *tmp = mte_to_node(used);
-
-	if (mt_in_rcu(mas->tree))
-		ma_free_rcu(tmp);
-	else
-		mas_push_node(mas, tmp);
-}
-
-/*
- * mas_node_count_gfp() - Check if enough nodes are allocated and request more
- * if there is not enough nodes.
- * @mas: The maple state
- * @count: The number of nodes needed
- * @gfp: the gfp flags
- */
-static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gfp)
-{
-	unsigned long allocated = mas_allocated(mas);
-
-	if (allocated < count) {
-		mas_set_alloc_req(mas, count - allocated);
-		mas_alloc_nodes(mas, gfp);
-	}
-}
-
-/*
- * mas_node_count() - Check if enough nodes are allocated and request more if
- * there is not enough nodes.
- * @mas: The maple state
- * @count: The number of nodes needed
- *
- * Note: Uses GFP_NOWAIT | __GFP_NOWARN for gfp flags.
- */
-static void mas_node_count(struct ma_state *mas, int count)
-{
-	return mas_node_count_gfp(mas, count, GFP_NOWAIT | __GFP_NOWARN);
+	ma_free_rcu(mte_to_node(used));
 }
 
 /*
@@ -2511,10 +2326,7 @@ static inline void mas_topiary_node(struct ma_state *mas,
 	enode = tmp_mas->node;
 	tmp = mte_to_node(enode);
 	mte_set_node_dead(enode);
-	if (in_rcu)
-		ma_free_rcu(tmp);
-	else
-		mas_push_node(mas, tmp);
+	ma_free_rcu(tmp);
 }
 
 /*
@@ -4162,7 +3974,7 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
  *
  * Return: Number of nodes required for preallocation.
  */
-static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
+static inline void mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 {
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char height = mas_mt_height(mas);
@@ -4208,7 +4020,7 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 		WARN_ON_ONCE(1);
 	}
 
-	return ret;
+	mas->node_request = ret;
 }
 
 /*
@@ -4269,15 +4081,15 @@ static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
  */
 static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
 {
-	int request;
+	struct ma_state *mas = wr_mas->mas;
 
 	mas_wr_prealloc_setup(wr_mas);
-	wr_mas->mas->store_type = mas_wr_store_type(wr_mas);
-	request = mas_prealloc_calc(wr_mas, entry);
-	if (!request)
+	mas->store_type = mas_wr_store_type(wr_mas);
+	mas_prealloc_calc(wr_mas, entry);
+	if (!mas->node_request)
 		return;
 
-	mas_node_count(wr_mas->mas, request);
+	mas_alloc_nodes(mas, GFP_NOWAIT | __GFP_NOWARN);
 }
 
 /**
@@ -5390,7 +5202,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
  */
 void *mas_store(struct ma_state *mas, void *entry)
 {
-	int request;
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	trace_ma_write(__func__, mas, 0, entry);
@@ -5420,11 +5231,11 @@ void *mas_store(struct ma_state *mas, void *entry)
 		return wr_mas.content;
 	}
 
-	request = mas_prealloc_calc(&wr_mas, entry);
-	if (!request)
+	mas_prealloc_calc(&wr_mas, entry);
+	if (!mas->node_request)
 		goto store;
 
-	mas_node_count(mas, request);
+	mas_alloc_nodes(mas, GFP_NOWAIT | __GFP_NOWARN);
 	if (mas_is_err(mas))
 		return NULL;
 
@@ -5512,20 +5323,19 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	int ret = 0;
-	int request;
 
 	mas_wr_prealloc_setup(&wr_mas);
 	mas->store_type = mas_wr_store_type(&wr_mas);
-	request = mas_prealloc_calc(&wr_mas, entry);
-	if (!request)
+	mas_prealloc_calc(&wr_mas, entry);
+	if (!mas->node_request)
 		goto set_flag;
 
 	mas->mas_flags &= ~MA_STATE_PREALLOC;
-	mas_node_count_gfp(mas, request, gfp);
+	mas_alloc_nodes(mas, gfp);
 	if (mas_is_err(mas)) {
-		mas_set_alloc_req(mas, 0);
-		ret = xa_err(mas->node);
+		int ret = xa_err(mas->node);
+
+		mas->node_request = 0;
 		mas_destroy(mas);
 		mas_reset(mas);
 		return ret;
@@ -5533,7 +5343,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 set_flag:
 	mas->mas_flags |= MA_STATE_PREALLOC;
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
 
@@ -5547,9 +5357,6 @@ EXPORT_SYMBOL_GPL(mas_preallocate);
  */
 void mas_destroy(struct ma_state *mas)
 {
-	struct maple_alloc *node;
-	unsigned long total;
-
 	/*
 	 * When using mas_for_each() to insert an expected number of elements,
 	 * it is possible that the number inserted is less than the expected
@@ -5570,21 +5377,11 @@ void mas_destroy(struct ma_state *mas)
 	}
 	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
 
-	total = mas_allocated(mas);
-	while (total) {
-		node = mas->alloc;
-		mas->alloc = node->slot[0];
-		if (node->node_count > 1) {
-			size_t count = node->node_count - 1;
-
-			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
-			total -= count;
-		}
-		kfree(ma_mnode_ptr(node));
-		total--;
-	}
+	mas->node_request = 0;
+	if (mas->sheaf)
+		mt_return_sheaf(mas->sheaf);
 
-	mas->alloc = NULL;
+	mas->sheaf = NULL;
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -5634,7 +5431,8 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
+	mas->node_request = nr_nodes + 3;
+	mas_alloc_nodes(mas, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
@@ -6281,7 +6079,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 		mas_alloc_nodes(mas, gfp);
 	}
 
-	if (!mas_allocated(mas))
+	if (!mas->sheaf)
 		return false;
 
 	mas->status = ma_start;
@@ -7676,8 +7474,9 @@ void mas_dump(const struct ma_state *mas)
 
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
-	pr_err("     min=%lx max=%lx alloc=" PTR_FMT ", depth=%u, flags=%x\n",
-	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
+	pr_err("     min=%lx max=%lx sheaf=" PTR_FMT ", request %lu depth=%u, flags=%x\n",
+	       mas->min, mas->max, mas->sheaf, mas->node_request, mas->depth,
+	       mas->mas_flags);
 	if (mas->index > mas->last)
 		pr_err("Check index & last\n");
 }
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index cb3936595b0d56a9682ff100eba54693a1427829..1848d127eb50650e7cc2b9dfbb15ed93aa889f01 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2746,6 +2746,7 @@ static noinline void __init check_fuzzer(struct maple_tree *mt)
 	mtree_test_erase(mt, ULONG_MAX - 10);
 }
 
+#if 0
 /* duplicate the tree with a specific gap */
 static noinline void __init check_dup_gaps(struct maple_tree *mt,
 				    unsigned long nr_entries, bool zero_start,
@@ -2770,6 +2771,7 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 		mtree_store_range(mt, i*10, (i+1)*10 - gap,
 				  xa_mk_value(i), GFP_KERNEL);
 
+	mt_dump(mt, mt_dump_dec);
 	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_non_kernel(99999);
 	down_write(&newmt_lock);
@@ -2779,9 +2781,12 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 
 	rcu_read_lock();
 	mas_for_each(&mas, tmp, ULONG_MAX) {
+		printk("%lu nodes %lu\n", mas.index,
+		       kmem_cache_sheaf_count(newmas.sheaf));
 		newmas.index = mas.index;
 		newmas.last = mas.last;
 		mas_store(&newmas, tmp);
+		mt_dump(&newmt, mt_dump_dec);
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
@@ -2878,6 +2883,7 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		cond_resched();
 	}
 }
+#endif
 
 static noinline void __init check_bnode_min_spanning(struct maple_tree *mt)
 {
@@ -4077,9 +4083,11 @@ static int __init maple_tree_seed(void)
 	check_fuzzer(&tree);
 	mtree_destroy(&tree);
 
+#if 0
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_dup(&tree);
 	mtree_destroy(&tree);
+#endif
 
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_bnode_min_spanning(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 7fe91f24849b35723ec6aadbe45ec7d2abedcc11..da3e03d73b52162dab6fa5c368ad7b71b9e58521 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -57,430 +57,6 @@ struct rcu_reader_struct {
 	struct rcu_test_struct2 *test;
 };
 
-static int get_alloc_node_count(struct ma_state *mas)
-{
-	int count = 1;
-	struct maple_alloc *node = mas->alloc;
-
-	if (!node || ((unsigned long)node & 0x1))
-		return 0;
-	while (node->node_count) {
-		count += node->node_count;
-		node = node->slot[0];
-	}
-	return count;
-}
-
-static void check_mas_alloc_node_count(struct ma_state *mas)
-{
-	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
-	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
-	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
-	mas_destroy(mas);
-}
-
-/*
- * check_new_node() - Check the creation of new nodes and error path
- * verification.
- */
-static noinline void __init check_new_node(struct maple_tree *mt)
-{
-
-	struct maple_node *mn, *mn2, *mn3;
-	struct maple_alloc *smn;
-	struct maple_node *nodes[100];
-	int i, j, total;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	check_mas_alloc_node_count(&mas);
-
-	/* Try allocating 3 nodes */
-	mtree_lock(mt);
-	mt_set_non_kernel(0);
-	/* request 3 nodes to be allocated. */
-	mas_node_count(&mas, 3);
-	/* Allocation request of 3. */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 3);
-	/* Allocate failed. */
-	MT_BUG_ON(mt, mas.node != MA_ERROR(-ENOMEM));
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-
-	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, not_empty(mn));
-	MT_BUG_ON(mt, mn == NULL);
-	MT_BUG_ON(mt, mas.alloc == NULL);
-	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
-	mas_push_node(&mas, mn);
-	mas_reset(&mas);
-	mas_destroy(&mas);
-	mtree_unlock(mt);
-
-
-	/* Try allocating 1 node, then 2 more */
-	mtree_lock(mt);
-	/* Set allocation request to 1. */
-	mas_set_alloc_req(&mas, 1);
-	/* Check Allocation request of 1. */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 1);
-	mas_set_err(&mas, -ENOMEM);
-	/* Validate allocation request. */
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	/* Eat the requested node. */
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, not_empty(mn));
-	MT_BUG_ON(mt, mn == NULL);
-	MT_BUG_ON(mt, mn->slot[0] != NULL);
-	MT_BUG_ON(mt, mn->slot[1] != NULL);
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-
-	mn->parent = ma_parent_ptr(mn);
-	ma_free_rcu(mn);
-	mas.status = ma_start;
-	mas_destroy(&mas);
-	/* Allocate 3 nodes, will fail. */
-	mas_node_count(&mas, 3);
-	/* Drop the lock and allocate 3 nodes. */
-	mas_nomem(&mas, GFP_KERNEL);
-	/* Ensure 3 are allocated. */
-	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
-	/* Allocation request of 0. */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 0);
-
-	MT_BUG_ON(mt, mas.alloc == NULL);
-	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
-	MT_BUG_ON(mt, mas.alloc->slot[1] == NULL);
-	/* Ensure we counted 3. */
-	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
-	/* Free. */
-	mas_reset(&mas);
-	mas_destroy(&mas);
-
-	/* Set allocation request to 1. */
-	mas_set_alloc_req(&mas, 1);
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 1);
-	mas_set_err(&mas, -ENOMEM);
-	/* Validate allocation request. */
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	MT_BUG_ON(mt, mas_allocated(&mas) != 1);
-	/* Check the node is only one node. */
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, not_empty(mn));
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mn == NULL);
-	MT_BUG_ON(mt, mn->slot[0] != NULL);
-	MT_BUG_ON(mt, mn->slot[1] != NULL);
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	mas_push_node(&mas, mn);
-	MT_BUG_ON(mt, mas_allocated(&mas) != 1);
-	MT_BUG_ON(mt, mas.alloc->node_count);
-
-	mas_set_alloc_req(&mas, 2); /* request 2 more. */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 2);
-	mas_set_err(&mas, -ENOMEM);
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
-	MT_BUG_ON(mt, mas.alloc == NULL);
-	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
-	MT_BUG_ON(mt, mas.alloc->slot[1] == NULL);
-	for (i = 2; i >= 0; i--) {
-		mn = mas_pop_node(&mas);
-		MT_BUG_ON(mt, mas_allocated(&mas) != i);
-		MT_BUG_ON(mt, !mn);
-		MT_BUG_ON(mt, not_empty(mn));
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-	}
-
-	total = 64;
-	mas_set_alloc_req(&mas, total); /* request 2 more. */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != total);
-	mas_set_err(&mas, -ENOMEM);
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	for (i = total; i > 0; i--) {
-		unsigned int e = 0; /* expected node_count */
-
-		if (!MAPLE_32BIT) {
-			if (i >= 35)
-				e = i - 34;
-			else if (i >= 5)
-				e = i - 4;
-			else if (i >= 2)
-				e = i - 1;
-		} else {
-			if (i >= 4)
-				e = i - 3;
-			else if (i >= 1)
-				e = i - 1;
-			else
-				e = 0;
-		}
-
-		MT_BUG_ON(mt, mas.alloc->node_count != e);
-		mn = mas_pop_node(&mas);
-		MT_BUG_ON(mt, not_empty(mn));
-		MT_BUG_ON(mt, mas_allocated(&mas) != i - 1);
-		MT_BUG_ON(mt, !mn);
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-	}
-
-	total = 100;
-	for (i = 1; i < total; i++) {
-		mas_set_alloc_req(&mas, i);
-		mas_set_err(&mas, -ENOMEM);
-		MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-		for (j = i; j > 0; j--) {
-			mn = mas_pop_node(&mas);
-			MT_BUG_ON(mt, mas_allocated(&mas) != j - 1);
-			MT_BUG_ON(mt, !mn);
-			MT_BUG_ON(mt, not_empty(mn));
-			mas_push_node(&mas, mn);
-			MT_BUG_ON(mt, mas_allocated(&mas) != j);
-			mn = mas_pop_node(&mas);
-			MT_BUG_ON(mt, not_empty(mn));
-			MT_BUG_ON(mt, mas_allocated(&mas) != j - 1);
-			mn->parent = ma_parent_ptr(mn);
-			ma_free_rcu(mn);
-		}
-		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-
-		mas_set_alloc_req(&mas, i);
-		mas_set_err(&mas, -ENOMEM);
-		MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-		for (j = 0; j <= i/2; j++) {
-			MT_BUG_ON(mt, mas_allocated(&mas) != i - j);
-			nodes[j] = mas_pop_node(&mas);
-			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
-		}
-
-		while (j) {
-			j--;
-			mas_push_node(&mas, nodes[j]);
-			MT_BUG_ON(mt, mas_allocated(&mas) != i - j);
-		}
-		MT_BUG_ON(mt, mas_allocated(&mas) != i);
-		for (j = 0; j <= i/2; j++) {
-			MT_BUG_ON(mt, mas_allocated(&mas) != i - j);
-			mn = mas_pop_node(&mas);
-			MT_BUG_ON(mt, not_empty(mn));
-			mn->parent = ma_parent_ptr(mn);
-			ma_free_rcu(mn);
-			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
-		}
-		mas_reset(&mas);
-		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
-		mas_destroy(&mas);
-
-	}
-
-	/* Set allocation request. */
-	total = 500;
-	mas_node_count(&mas, total);
-	/* Drop the lock and allocate the nodes. */
-	mas_nomem(&mas, GFP_KERNEL);
-	MT_BUG_ON(mt, !mas.alloc);
-	i = 1;
-	smn = mas.alloc;
-	while (i < total) {
-		for (j = 0; j < MAPLE_ALLOC_SLOTS; j++) {
-			i++;
-			MT_BUG_ON(mt, !smn->slot[j]);
-			if (i == total)
-				break;
-		}
-		smn = smn->slot[0]; /* next. */
-	}
-	MT_BUG_ON(mt, mas_allocated(&mas) != total);
-	mas_reset(&mas);
-	mas_destroy(&mas); /* Free. */
-
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	for (i = 1; i < 128; i++) {
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		MT_BUG_ON(mt, mas_allocated(&mas) != i); /* check request filled */
-		for (j = i; j > 0; j--) { /*Free the requests */
-			mn = mas_pop_node(&mas); /* get the next node. */
-			MT_BUG_ON(mt, mn == NULL);
-			MT_BUG_ON(mt, not_empty(mn));
-			mn->parent = ma_parent_ptr(mn);
-			ma_free_rcu(mn);
-		}
-		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	}
-
-	for (i = 1; i < MAPLE_NODE_MASK + 1; i++) {
-		MA_STATE(mas2, mt, 0, 0);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		MT_BUG_ON(mt, mas_allocated(&mas) != i); /* check request filled */
-		for (j = 1; j <= i; j++) { /* Move the allocations to mas2 */
-			mn = mas_pop_node(&mas); /* get the next node. */
-			MT_BUG_ON(mt, mn == NULL);
-			MT_BUG_ON(mt, not_empty(mn));
-			mas_push_node(&mas2, mn);
-			MT_BUG_ON(mt, mas_allocated(&mas2) != j);
-		}
-		MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-		MT_BUG_ON(mt, mas_allocated(&mas2) != i);
-
-		for (j = i; j > 0; j--) { /*Free the requests */
-			MT_BUG_ON(mt, mas_allocated(&mas2) != j);
-			mn = mas_pop_node(&mas2); /* get the next node. */
-			MT_BUG_ON(mt, mn == NULL);
-			MT_BUG_ON(mt, not_empty(mn));
-			mn->parent = ma_parent_ptr(mn);
-			ma_free_rcu(mn);
-		}
-		MT_BUG_ON(mt, mas_allocated(&mas2) != 0);
-	}
-
-
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
-	MT_BUG_ON(mt, mas.node != MA_ERROR(-ENOMEM));
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS);
-
-	mn = mas_pop_node(&mas); /* get the next node. */
-	MT_BUG_ON(mt, mn == NULL);
-	MT_BUG_ON(mt, not_empty(mn));
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS);
-	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS - 1);
-
-	mas_push_node(&mas, mn);
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS);
-
-	/* Check the limit of pop/push/pop */
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 2); /* Request */
-	MT_BUG_ON(mt, mas_alloc_req(&mas) != 1);
-	MT_BUG_ON(mt, mas.node != MA_ERROR(-ENOMEM));
-	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
-	MT_BUG_ON(mt, mas_alloc_req(&mas));
-	MT_BUG_ON(mt, mas.alloc->node_count != 1);
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, not_empty(mn));
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count  != MAPLE_ALLOC_SLOTS);
-	mas_push_node(&mas, mn);
-	MT_BUG_ON(mt, mas.alloc->node_count != 1);
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, not_empty(mn));
-	mn->parent = ma_parent_ptr(mn);
-	ma_free_rcu(mn);
-	for (i = 1; i <= MAPLE_ALLOC_SLOTS + 1; i++) {
-		mn = mas_pop_node(&mas);
-		MT_BUG_ON(mt, not_empty(mn));
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-	}
-	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-
-
-	for (i = 3; i < MAPLE_NODE_MASK * 3; i++) {
-		mas.node = MA_ERROR(-ENOMEM);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mas_push_node(&mas, mn); /* put it back */
-		mas_destroy(&mas);
-
-		mas.node = MA_ERROR(-ENOMEM);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn2 = mas_pop_node(&mas); /* get the next node. */
-		mas_push_node(&mas, mn); /* put them back */
-		mas_push_node(&mas, mn2);
-		mas_destroy(&mas);
-
-		mas.node = MA_ERROR(-ENOMEM);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn2 = mas_pop_node(&mas); /* get the next node. */
-		mn3 = mas_pop_node(&mas); /* get the next node. */
-		mas_push_node(&mas, mn); /* put them back */
-		mas_push_node(&mas, mn2);
-		mas_push_node(&mas, mn3);
-		mas_destroy(&mas);
-
-		mas.node = MA_ERROR(-ENOMEM);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-		mas_destroy(&mas);
-
-		mas.node = MA_ERROR(-ENOMEM);
-		mas_node_count(&mas, i); /* Request */
-		mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-		mn = mas_pop_node(&mas); /* get the next node. */
-		mn->parent = ma_parent_ptr(mn);
-		ma_free_rcu(mn);
-		mas_destroy(&mas);
-	}
-
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, 5); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	MT_BUG_ON(mt, mas_allocated(&mas) != 5);
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, 10); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.status = ma_start;
-	MT_BUG_ON(mt, mas_allocated(&mas) != 10);
-	mas_destroy(&mas);
-
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS - 1); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS - 1);
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, 10 + MAPLE_ALLOC_SLOTS - 1); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.status = ma_start;
-	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
-	mas_destroy(&mas);
-
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.status = ma_start;
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 2);
-	mas_destroy(&mas);
-
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 1);
-	mas.node = MA_ERROR(-ENOMEM);
-	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
-	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.status = ma_start;
-	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 3 + 2);
-	mas_destroy(&mas);
-
-	mtree_unlock(mt);
-}
-
 /*
  * Check erasing including RCU.
  */
@@ -35452,8 +35028,7 @@ static void check_dfs_preorder(struct maple_tree *mt)
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	mas_reset(&mas);
 	mt_zero_nr_tallocated();
-	mt_set_non_kernel(200);
-	mas_expected_entries(&mas, max);
+	mt_set_non_kernel(1000);
 	for (count = 0; count <= max; count++) {
 		mas.index = mas.last = count;
 		mas_store(&mas, xa_mk_value(count));
@@ -35518,6 +35093,13 @@ static unsigned char get_vacant_height(struct ma_wr_state *wr_mas, void *entry)
 	return vacant_height;
 }
 
+static int mas_allocated(struct ma_state *mas)
+{
+	if (mas->sheaf)
+		return kmem_cache_sheaf_size(mas->sheaf);
+
+	return 0;
+}
 /* Preallocation testing */
 static noinline void __init check_prealloc(struct maple_tree *mt)
 {
@@ -35536,7 +35118,10 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 
 	/* Spanning store */
 	mas_set_range(&mas, 470, 500);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
+
+	mas_wr_preallocate(&wr_mas, ptr);
+	MT_BUG_ON(mt, mas.store_type != wr_spanning_store);
+	MT_BUG_ON(mt, mas_is_err(&mas));
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	vacant_height = get_vacant_height(&wr_mas, ptr);
@@ -35546,6 +35131,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
+	mas_wr_preallocate(&wr_mas, ptr);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35586,20 +35172,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
-	allocated = mas_allocated(&mas);
-	height = mas_mt_height(&mas);
-	vacant_height = get_vacant_height(&wr_mas, ptr);
-	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
-	mn = mas_pop_node(&mas);
-	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	mas_push_node(&mas, mn);
-	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
-	mas_destroy(&mas);
-	allocated = mas_allocated(&mas);
-	MT_BUG_ON(mt, allocated != 0);
-
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -36400,11 +35972,17 @@ static void check_nomem_writer_race(struct maple_tree *mt)
 	check_load(mt, 6, xa_mk_value(0xC));
 	mtree_unlock(mt);
 
+	mt_set_non_kernel(0);
 	/* test for the same race but with mas_store_gfp() */
 	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
 	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
 
 	mas_set_range(&mas, 0, 5);
+
+	/* setup writer 2 that will trigger the race condition */
+	mt_set_private(mt);
+	mt_set_callback(writer2);
+
 	mtree_lock(mt);
 	mas_store_gfp(&mas, NULL, GFP_KERNEL);
 
@@ -36546,10 +36124,6 @@ void farmer_tests(void)
 	check_erase_testset(&tree);
 	mtree_destroy(&tree);
 
-	mt_init_flags(&tree, 0);
-	check_new_node(&tree);
-	mtree_destroy(&tree);
-
 	if (!MAPLE_32BIT) {
 		mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 		check_rcu_simulated(&tree);
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 4ceff7969b78cf8e33cd1e021c68bc9f8a02a7a1..8c72571559583759456c2b469a2abc2611117c13 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -64,7 +64,8 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 
 	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
 		if (!cachep->non_kernel) {
-			cachep->exec_callback = true;
+			if (cachep->callback)
+				cachep->exec_callback = true;
 			return NULL;
 		}
 
@@ -210,6 +211,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 		for (i = 0; i < size; i++)
 			__kmem_cache_free_locked(cachep, p[i]);
 		pthread_mutex_unlock(&cachep->lock);
+		if (cachep->callback)
+			cachep->exec_callback = true;
 		return 0;
 	}
 

-- 
2.51.0


