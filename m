Return-Path: <linux-fsdevel+bounces-13319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089986E6C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884181C25463
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFE10A2D;
	Fri,  1 Mar 2024 17:07:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825612568;
	Fri,  1 Mar 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312835; cv=none; b=b4/kvy6Xlh1kitVddBiw76qSuVMadggiFdeC7djlHEAaMbXur2mSv05UnUaDyHmvgUqt660tm38UFD6n5n/5inHJ6H3IJND69h7qxXCjXv4WTcnWyBYGwRktXcct402m1LB5zxEKOJif8gdykmD9QDsKIIVGBsVODyy++GR6rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312835; c=relaxed/simple;
	bh=zHTjE2s9eU4e8ejE9RWwR3BzqKotd3aHXC+td0OJ2X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2v8nSbcaEzcMqlR/wb3cfwLq4oBIrwDGtUmEnSqHY/dZ7gH3MJkFxn8I1iWOQ9N0lMFFxPhje4Pcg6FXvWId/uqnSuBIl47YBmtGIwlNBa5Uhf3+uDAvP2O8TrtMWlCCoqE1Bmi4RDzj4EYDFpznfxk29NVJbr77XDrij2l/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E827E33D2B;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C31ED13A59;
	Fri,  1 Mar 2024 17:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AAZcLz4L4mUcGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 17:07:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 01 Mar 2024 18:07:10 +0100
Subject: [PATCH RFC 3/4] mm, slab: introduce kmem_cache_charge()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-slab-memcg-v1-3-359328a46596@suse.cz>
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
X-Rspamd-Queue-Id: E827E33D2B
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

As suggested by Linus, introduce a slab API function to memcg-charge a
an object that was previously allocated without __GFP_ACCOUNT and from a
cache that's not SLAB_ACCOUNT. This may be useful when it's likely the
object is to be freed soon, and thus the charging/uncharging overhead
can be avoided.

In case kmem_cache_charge() is called on an already-charged object, it's
a no-op.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 10 ++++++++++
 mm/slub.c            | 29 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..0c3acb2fa3e6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -491,6 +491,16 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags) __assume_slab_ali
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
+#ifdef CONFIG_MEMCG_KMEM
+int kmem_cache_charge(struct kmem_cache *s, gfp_t flags, void *objp);
+#else
+static inline int
+kmem_cache_charge(struct kmem_cache *s, gfp_t flags, void *objp)
+{
+	return 0;
+}
+#endif
+
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/mm/slub.c b/mm/slub.c
index 64da169d672a..72b61b379ba1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4241,6 +4241,35 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+#ifdef CONFIG_MEMCG_KMEM
+int kmem_cache_charge(struct kmem_cache *s, gfp_t flags, void *x)
+{
+	struct obj_cgroup ** objcg;
+	struct slab *slab;
+
+	s = cache_from_obj(s, x);
+	if (!s)
+		return -EINVAL;
+
+	if (likely(!memcg_kmem_online()))
+		return 0;
+
+	/* was it already accounted? */
+	slab = virt_to_slab(x);
+	if ((objcg = slab_objcgs(slab))) {
+		unsigned int off = obj_to_index(s, slab, x);
+
+		if (objcg[off])
+			return 0;
+	}
+
+	if (!memcg_slab_post_alloc_hook(s, NULL, flags, 1, &x))
+		return -ENOMEM;
+
+	return 0;
+}
+#endif
+
 static void free_large_kmalloc(struct folio *folio, void *object)
 {
 	unsigned int order = folio_order(folio);

-- 
2.44.0


