Return-Path: <linux-fsdevel+bounces-59794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94152B3E123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EF4179918
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225831A063;
	Mon,  1 Sep 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOSewe5A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWOLqaNY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOSewe5A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWOLqaNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F35313E1F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724965; cv=none; b=m2jzLoou4fICKJ9VA/x4tfqcbZAjST53ALmqYIVG6I0VaZShEUMs33IyzyaZBzr1zLponTQxx1gnDYnwYpLqD+XSQ3pQN/Jkx/OKnwHHeZVZbmjGV0YbmY4QYxrxEnXW4Le7zpSmoXUUm/Bdm9jql17jjrnucwTRjTt81fGBGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724965; c=relaxed/simple;
	bh=9DVF5YlHhzvZ3QdPg/Fne3pqcsKvAT7L7x/2E24PN/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAYSowDGy7dNJco2AATc8C0g970cKHiS5ZrWed3W+/x+5FalrBIFkyG2cBNBUnCZNSDUbhhb20iBV4ae0EFA1SSNFzkKHFd6opipWnF2aP2HpKTkmzgtSYrrOmtv+ahUaLqDtXIDmDpdTGAYg7XGXZ4gczcFwyb2VSRRpmd7yFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOSewe5A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWOLqaNY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOSewe5A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWOLqaNY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D641F1F38C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htQ+/TA5SKDWSG5dnn2v4RIOWxXiBF6DNi9KcdkVFvU=;
	b=fOSewe5ApnD56gxuszMv1ZxWgYnHilfM5JvSQ57oZnziFZrZC2Cr0kGjzNbx4C598jb+RO
	XMazmhNa9fZfCpKrq1LNP2fKaPjv7tpHfZXZIVp00ITgoAZcbCJ19V2nnvgrEutWSGkkq1
	jb91GDUJlRoXd8ZBSEj6G1wlJjqtPB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htQ+/TA5SKDWSG5dnn2v4RIOWxXiBF6DNi9KcdkVFvU=;
	b=BWOLqaNYD0gV3me+lqMPb2sV/a5rtUVLASqnMxiAvcHVsCv4HPe7F/brqal5/xn99eBSa0
	usVtg+TSxavBBBCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fOSewe5A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BWOLqaNY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htQ+/TA5SKDWSG5dnn2v4RIOWxXiBF6DNi9KcdkVFvU=;
	b=fOSewe5ApnD56gxuszMv1ZxWgYnHilfM5JvSQ57oZnziFZrZC2Cr0kGjzNbx4C598jb+RO
	XMazmhNa9fZfCpKrq1LNP2fKaPjv7tpHfZXZIVp00ITgoAZcbCJ19V2nnvgrEutWSGkkq1
	jb91GDUJlRoXd8ZBSEj6G1wlJjqtPB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htQ+/TA5SKDWSG5dnn2v4RIOWxXiBF6DNi9KcdkVFvU=;
	b=BWOLqaNYD0gV3me+lqMPb2sV/a5rtUVLASqnMxiAvcHVsCv4HPe7F/brqal5/xn99eBSa0
	usVtg+TSxavBBBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFA781378C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UPGFLsV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:59 +0200
Subject: [PATCH 09/12] tools: Add sheaf to slab testing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-9-d6a1166b53f2@suse.cz>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D641F1F38C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email,oracle.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add the sheaf structs to the slab header and the functions to the
testing/shared/linux.c file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h   | 28 ++++++++++++++
 tools/testing/shared/linux.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index c5c5cc6db5668be2cc94c29065ccfa7ca7b4bb08..94937a699402bd1f31887dfb52b6fd0a3c986f43 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -123,6 +123,18 @@ struct kmem_cache_args {
 	void (*ctor)(void *);
 };
 
+struct slab_sheaf {
+	union {
+		struct list_head barn_list;
+		/* only used for prefilled sheafs */
+		unsigned int capacity;
+	};
+	struct kmem_cache *cache;
+	unsigned int size;
+	int node; /* only used for rcu_sheaf */
+	void *objects[];
+};
+
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
 	return kmalloc(size, gfp | __GFP_ZERO);
@@ -173,5 +185,21 @@ __kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 			  void **list);
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size);
+
+void *
+kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf);
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf);
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf **sheafp, unsigned int size);
+
+static inline unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf)
+{
+	return sheaf->size;
+}
 
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 97b8412ccbb6d222604c7b397c53c65618d8d51b..4ceff7969b78cf8e33cd1e021c68bc9f8a02a7a1 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -137,6 +137,12 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
 	if (kmalloc_verbose)
 		pr_debug("Bulk free %p[0-%zu]\n", list, size - 1);
 
+	if (cachep->exec_callback) {
+		if (cachep->callback)
+			cachep->callback(cachep->private);
+		cachep->exec_callback = false;
+	}
+
 	pthread_mutex_lock(&cachep->lock);
 	for (int i = 0; i < size; i++)
 		kmem_cache_free_locked(cachep, list[i]);
@@ -242,6 +248,89 @@ __kmem_cache_create_args(const char *name, unsigned int size,
 	return ret;
 }
 
+struct slab_sheaf *
+kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
+{
+	struct slab_sheaf *sheaf;
+	unsigned int capacity;
+
+	if (s->exec_callback) {
+		if (s->callback)
+			s->callback(s->private);
+		s->exec_callback = false;
+	}
+
+	capacity = max(size, s->sheaf_capacity);
+
+	sheaf = calloc(1, sizeof(*sheaf) + sizeof(void *) * capacity);
+	if (!sheaf)
+		return NULL;
+
+	sheaf->cache = s;
+	sheaf->capacity = capacity;
+	sheaf->size = kmem_cache_alloc_bulk(s, gfp, size, sheaf->objects);
+	if (!sheaf->size) {
+		free(sheaf);
+		return NULL;
+	}
+
+	return sheaf;
+}
+
+int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
+		 struct slab_sheaf **sheafp, unsigned int size)
+{
+	struct slab_sheaf *sheaf = *sheafp;
+	int refill;
+
+	if (sheaf->size >= size)
+		return 0;
+
+	if (size > sheaf->capacity) {
+		sheaf = kmem_cache_prefill_sheaf(s, gfp, size);
+		if (!sheaf)
+			return -ENOMEM;
+
+		kmem_cache_return_sheaf(s, gfp, *sheafp);
+		*sheafp = sheaf;
+		return 0;
+	}
+
+	refill = kmem_cache_alloc_bulk(s, gfp, size - sheaf->size,
+				       &sheaf->objects[sheaf->size]);
+	if (!refill)
+		return -ENOMEM;
+
+	sheaf->size += refill;
+	return 0;
+}
+
+void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
+		 struct slab_sheaf *sheaf)
+{
+	if (sheaf->size)
+		kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
+
+	free(sheaf);
+}
+
+void *
+kmem_cache_alloc_from_sheaf(struct kmem_cache *s, gfp_t gfp,
+		struct slab_sheaf *sheaf)
+{
+	void *obj;
+
+	if (sheaf->size == 0) {
+		printf("Nothing left in sheaf!\n");
+		return NULL;
+	}
+
+	obj = sheaf->objects[--sheaf->size];
+	sheaf->objects[sheaf->size] = NULL;
+
+	return obj;
+}
+
 /*
  * Test the test infrastructure for kem_cache_alloc/free and bulk counterparts.
  */

-- 
2.51.0


