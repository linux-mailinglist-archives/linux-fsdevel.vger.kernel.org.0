Return-Path: <linux-fsdevel+bounces-59797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6AB3E12B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA34188EA13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871F312826;
	Mon,  1 Sep 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xBn0jzYN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0+y4jgm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xBn0jzYN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0+y4jgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AB30FF06
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724982; cv=none; b=ZvJLUHRE92mtm0ts/GK4bGTupaJsi//GtI/yoPbQrdeKYMDQDSq7rY2z3zl07l1E87Avkrz3G/V+yjzcWh6/oWpVAuVwUN8RgyqoV5aRLDHtzgynUMc7TLEw3CuVGqmu16xhwGGRqOyhQyZnJzkMumsXze20RdTCUrnDezpqP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724982; c=relaxed/simple;
	bh=qYYD8QB3+ZJl58441sYK9bECFC/e2CHKoe9h07tdYcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnXpMot7E9XOEi8Jj540XUDEixeBPAg8MXpz78n3c/Zu4dErSQE/KZW2q8zdISYThcgR8wU/SYl1gQDUpWWqK9Kx0qN7DQHpnxoe0OfZTBQErJLBtdvTzySDzbKuD1zcrqE5hUz2Ctk769NfeDVaMmGouOl5oV9h2UEJCSD9c+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xBn0jzYN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0+y4jgm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xBn0jzYN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0+y4jgm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 102C82117D;
	Mon,  1 Sep 2025 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yl47dy68ehTR4F5YItfKWugcgsVIsFegWRdmZS6Qxw=;
	b=xBn0jzYNn+cWvKcxEb5yLy9T7DeTegxMy0R03jKU+MfoNbZl71MKg1m7TEDKA/fyS2+ewb
	3qw9mwf1avZJU/Uwf7afiMvcrYAk7K8TUbDaJMkrzWNZZj0Sg9vqZUFanYxMcn11qU4ItF
	lBmQIO/JaIJnTz3KV59IzOgusHOcvgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yl47dy68ehTR4F5YItfKWugcgsVIsFegWRdmZS6Qxw=;
	b=L0+y4jgmKzcw6eFw93KihWmpq/qgGb6cdLN5yAiFn9CpX0iwJ97Bqa0iZ1w621WqRu86qA
	sXOYCLl6NGb93dCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yl47dy68ehTR4F5YItfKWugcgsVIsFegWRdmZS6Qxw=;
	b=xBn0jzYNn+cWvKcxEb5yLy9T7DeTegxMy0R03jKU+MfoNbZl71MKg1m7TEDKA/fyS2+ewb
	3qw9mwf1avZJU/Uwf7afiMvcrYAk7K8TUbDaJMkrzWNZZj0Sg9vqZUFanYxMcn11qU4ItF
	lBmQIO/JaIJnTz3KV59IzOgusHOcvgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yl47dy68ehTR4F5YItfKWugcgsVIsFegWRdmZS6Qxw=;
	b=L0+y4jgmKzcw6eFw93KihWmpq/qgGb6cdLN5yAiFn9CpX0iwJ97Bqa0iZ1w621WqRu86qA
	sXOYCLl6NGb93dCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED9E613A3E;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AM+6OcV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:09:01 +0200
Subject: [PATCH 11/12] maple_tree: Add single node allocation support to
 maple state
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-11-d6a1166b53f2@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLzz977skxseo48jckwk35q6sc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The fast path through a write will require replacing a single node in
the tree.  Using a sheaf (32 nodes) is too heavy for the fast path, so
special case the node store operation by just allocating one node in the
maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/maple_tree.h       |  4 +++-
 lib/maple_tree.c                 | 47 +++++++++++++++++++++++++++++++++++-----
 tools/testing/radix-tree/maple.c |  9 ++++++--
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 166fd67e00d882b1e6de1f80c1b590bba7497cd3..562a1e9e5132b5b1fa8f8402a7cadd8abb65e323 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -443,6 +443,7 @@ struct ma_state {
 	unsigned long min;		/* The minimum index of this node - implied pivot min */
 	unsigned long max;		/* The maximum index of this node - implied pivot max */
 	struct slab_sheaf *sheaf;	/* Allocated nodes for this operation */
+	struct maple_node *alloc;	/* allocated nodes */
 	unsigned long node_request;
 	enum maple_status status;	/* The status of the state (active, start, none, etc) */
 	unsigned char depth;		/* depth of tree descent during write */
@@ -491,8 +492,9 @@ struct ma_wr_state {
 		.status = ma_start,					\
 		.min = 0,						\
 		.max = ULONG_MAX,					\
-		.node_request= 0,					\
 		.sheaf = NULL,						\
+		.alloc = NULL,						\
+		.node_request= 0,					\
 		.mas_flags = 0,						\
 		.store_type = wr_invalid,				\
 	}
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cfe80c50a97e3118eefc24275fbcd2eec5e6e6e8..61a322f945c28f5c3297c506923f00bcce5c7bca 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1095,16 +1095,23 @@ static int mas_ascend(struct ma_state *mas)
  *
  * Return: A pointer to a maple node.
  */
-static inline struct maple_node *mas_pop_node(struct ma_state *mas)
+static __always_inline struct maple_node *mas_pop_node(struct ma_state *mas)
 {
 	struct maple_node *ret;
 
+	if (mas->alloc) {
+		ret = mas->alloc;
+		mas->alloc = NULL;
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!mas->sheaf))
 		return NULL;
 
 	ret = kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT, mas->sheaf);
-	memset(ret, 0, sizeof(*ret));
 
+out:
+	memset(ret, 0, sizeof(*ret));
 	return ret;
 }
 
@@ -1115,9 +1122,34 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
  */
 static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 {
-	if (unlikely(mas->sheaf)) {
-		unsigned long refill = mas->node_request;
+	if (!mas->node_request)
+		return;
+
+	if (mas->node_request == 1) {
+		if (mas->sheaf)
+			goto use_sheaf;
+
+		if (mas->alloc)
+			return;
 
+		mas->alloc = mt_alloc_one(gfp);
+		if (!mas->alloc)
+			goto error;
+
+		mas->node_request = 0;
+		return;
+	}
+
+use_sheaf:
+	if (unlikely(mas->alloc)) {
+		kfree(mas->alloc);
+		mas->alloc = NULL;
+	}
+
+	if (mas->sheaf) {
+		unsigned long refill;
+
+		refill = mas->node_request;
 		if(kmem_cache_sheaf_size(mas->sheaf) >= refill) {
 			mas->node_request = 0;
 			return;
@@ -5380,8 +5412,11 @@ void mas_destroy(struct ma_state *mas)
 	mas->node_request = 0;
 	if (mas->sheaf)
 		mt_return_sheaf(mas->sheaf);
-
 	mas->sheaf = NULL;
+
+	if (mas->alloc)
+		kfree(mas->alloc);
+	mas->alloc = NULL;
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -6079,7 +6114,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 		mas_alloc_nodes(mas, gfp);
 	}
 
-	if (!mas->sheaf)
+	if (!mas->sheaf && !mas->alloc)
 		return false;
 
 	mas->status = ma_start;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index da3e03d73b52162dab6fa5c368ad7b71b9e58521..89da991e12cd97e44971757ddc105ef46c68ea4c 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35095,10 +35095,15 @@ static unsigned char get_vacant_height(struct ma_wr_state *wr_mas, void *entry)
 
 static int mas_allocated(struct ma_state *mas)
 {
+	int total = 0;
+
+	if (mas->alloc)
+		total++;
+
 	if (mas->sheaf)
-		return kmem_cache_sheaf_size(mas->sheaf);
+		total += kmem_cache_sheaf_size(mas->sheaf);
 
-	return 0;
+	return total;
 }
 /* Preallocation testing */
 static noinline void __init check_prealloc(struct maple_tree *mt)

-- 
2.51.0


