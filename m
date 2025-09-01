Return-Path: <linux-fsdevel+bounces-59798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E3FB3E12D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD31189FD51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473E3112DB;
	Mon,  1 Sep 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nlPUE/e7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxl/KWzB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nlPUE/e7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxl/KWzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CA31CA61
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724988; cv=none; b=eFBOakN76Q1/EVx6C8y+nDF+nMJx28zv1HK9Vf6gQ4u+kaWMwu5EciIsZsBrQBRi85Jt802re38GJev/3aHdHAw/TDdbGcG3iYdDJu6LExATwvmPUEpDm8QjgG9RW40IwRB+aaKncJD13lSNdthZH9DbaI1XgICSkkZvb+Gb20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724988; c=relaxed/simple;
	bh=dkkOcEsD7xn5yD67IHEifvMlDweLyNkUukV+EgT6MdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHGHI7x3lSOk5Fccv5k8cmlPyxqrUTvucDtF24W1NSfmcpaotaeSE8DHFeJod8P5YhfBU5W6YIqNnduW4OD2qkG5EBaGt7L1YsK8EXwpdsaC6LZaXdjX3rJ/GsLSFPndoJxSoF+uaxFV5kWlMzoLQ4kzeRyeysKdH7/4MQubOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nlPUE/e7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxl/KWzB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nlPUE/e7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxl/KWzB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2495F2117F;
	Mon,  1 Sep 2025 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gsZxO7UwDiPyyfTVlyF4n/52yTA0EMnZqzW234FbC8=;
	b=nlPUE/e7F+X8WrUw6J4qfcaLHa1uKKS4XsuggwRVtF7gTcz6nFif/WwVknP27fkOgF8s+Y
	c+EmrfkGo3vXsFVUVjzCG1vpuxoslzDrD/1Puf/BAybyr8hg2XeZZ68zHLelYE+w82cAC9
	XaT0ZxkP1W+ocEUdOALgCcVJZY1mdRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gsZxO7UwDiPyyfTVlyF4n/52yTA0EMnZqzW234FbC8=;
	b=wxl/KWzB0/GJpacisYIzHBgqZs9iqq7+mJn12vMwX9zQiiIWqooa/mHXaGDOtTjlqsCTbv
	FZdwNt8oIPrStaCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="nlPUE/e7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="wxl/KWzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gsZxO7UwDiPyyfTVlyF4n/52yTA0EMnZqzW234FbC8=;
	b=nlPUE/e7F+X8WrUw6J4qfcaLHa1uKKS4XsuggwRVtF7gTcz6nFif/WwVknP27fkOgF8s+Y
	c+EmrfkGo3vXsFVUVjzCG1vpuxoslzDrD/1Puf/BAybyr8hg2XeZZ68zHLelYE+w82cAC9
	XaT0ZxkP1W+ocEUdOALgCcVJZY1mdRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gsZxO7UwDiPyyfTVlyF4n/52yTA0EMnZqzW234FbC8=;
	b=wxl/KWzB0/GJpacisYIzHBgqZs9iqq7+mJn12vMwX9zQiiIWqooa/mHXaGDOtTjlqsCTbv
	FZdwNt8oIPrStaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E11A1378C;
	Mon,  1 Sep 2025 11:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oAwtA8Z+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:54 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:09:02 +0200
Subject: [PATCH 12/12] maple_tree: Convert forking to use the sheaf
 interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-12-d6a1166b53f2@suse.cz>
References: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
In-Reply-To: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-Rspamd-Queue-Id: 2495F2117F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the generic interface which should result in less bulk allocations
during a forking.

A part of this is to abstract the freeing of the sheaf or maple state
allocations into its own function so mas_destroy() and the tree
duplication code can use the same functionality to return any unused
resources.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 61a322f945c28f5c3297c506923f00bcce5c7bca..5ef15e39fda8c7c65035fb7ed125b82dfa52ca69 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1172,6 +1172,19 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	mas_set_err(mas, -ENOMEM);
 }
 
+static inline void mas_empty_nodes(struct ma_state *mas)
+{
+	mas->node_request = 0;
+	if (mas->sheaf) {
+		mt_return_sheaf(mas->sheaf);
+		mas->sheaf = NULL;
+	}
+
+	if (mas->alloc) {
+		kfree(mas->alloc);
+		mas->alloc = NULL;
+	}
+}
 
 /*
  * mas_free() - Free an encoded maple node
@@ -5408,15 +5421,7 @@ void mas_destroy(struct ma_state *mas)
 		mas->mas_flags &= ~MA_STATE_REBALANCE;
 	}
 	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
-
-	mas->node_request = 0;
-	if (mas->sheaf)
-		mt_return_sheaf(mas->sheaf);
-	mas->sheaf = NULL;
-
-	if (mas->alloc)
-		kfree(mas->alloc);
-	mas->alloc = NULL;
+	mas_empty_nodes(mas);
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -6504,7 +6509,7 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	struct maple_node *node = mte_to_node(mas->node);
 	struct maple_node *new_node = mte_to_node(new_mas->node);
 	enum maple_type type;
-	unsigned char request, count, i;
+	unsigned char count, i;
 	void __rcu **slots;
 	void __rcu **new_slots;
 	unsigned long val;
@@ -6512,20 +6517,17 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	/* Allocate memory for child nodes. */
 	type = mte_node_type(mas->node);
 	new_slots = ma_slots(new_node, type);
-	request = mas_data_end(mas) + 1;
-	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
-	if (unlikely(count < request)) {
-		memset(new_slots, 0, request * sizeof(void *));
-		mas_set_err(mas, -ENOMEM);
+	count = mas->node_request = mas_data_end(mas) + 1;
+	mas_alloc_nodes(mas, gfp);
+	if (unlikely(mas_is_err(mas)))
 		return;
-	}
 
-	/* Restore node type information in slots. */
 	slots = ma_slots(node, type);
 	for (i = 0; i < count; i++) {
 		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
 		val &= MAPLE_NODE_MASK;
-		((unsigned long *)new_slots)[i] |= val;
+		new_slots[i] = ma_mnode_ptr((unsigned long)mas_pop_node(mas) |
+					    val);
 	}
 }
 
@@ -6579,7 +6581,7 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 			/* Only allocate child nodes for non-leaf nodes. */
 			mas_dup_alloc(mas, new_mas, gfp);
 			if (unlikely(mas_is_err(mas)))
-				return;
+				goto empty_mas;
 		} else {
 			/*
 			 * This is the last leaf node and duplication is
@@ -6612,6 +6614,8 @@ static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
 	/* Make them the same height */
 	new_mas->tree->ma_flags = mas->tree->ma_flags;
 	rcu_assign_pointer(new_mas->tree->ma_root, root);
+empty_mas:
+	mas_empty_nodes(mas);
 }
 
 /**

-- 
2.51.0


