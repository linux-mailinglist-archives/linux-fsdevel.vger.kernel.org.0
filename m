Return-Path: <linux-fsdevel+bounces-59789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD80B3E119
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E7E3A5D70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AD3128BE;
	Mon,  1 Sep 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PVZniRDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNw4yh6E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PVZniRDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNw4yh6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23383126DC
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724945; cv=none; b=IxRAaMh2/RUjzDOBUcVUaYY3nJNsWAgeGgtfbSWSd3yfUCLqRCZGtB0fQITBMQNh/qGYyrYhFud+NUFD+t6UHe2txuqEC5dVRSsxlO485SwOUtzU272Zz/cX3wNCLGOMIzzp2+24zWW/GY5HIy744h3SDR+686umvUmmxV9OfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724945; c=relaxed/simple;
	bh=XbOoID+Ep0MW58l++b+mu3jOxsgzwD6mNlO9jVsuOMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4Fm1qud3UsC8MReZhG9n66z24d3QbgooFpHCr4hkdmaURJaMn1nSOfubcNHOl74Yt1twIXRdtr3yB65dKiK5iTU314BCCrCRQD0C9TfhW/FWheqbrWC0KHGye4oXFVYBR95YGW4xN7wPzZw1a7b/zPxb9ta3qAA5X7NiLmaYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PVZniRDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNw4yh6E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PVZniRDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNw4yh6E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 513AE1F388;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5fQlGn0LPWPBdKT0pIiyIhFFb2vklTM3tMRG9lg9Q=;
	b=PVZniRDU9YIsk3d628yJbZaolIEDlI0jypXglbbnmSBtZjPlSL5XPliyTp5GOh/N90t9rj
	my1TMACjoFK3dxKTPUO72yo3ulVeWw0AuBXuPcXOqT8RrIzFi0jpBbFB5cDjBVSIkdY0lh
	Kmg25I+7cDxrUWhd7+3RoFzvvVUyir8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5fQlGn0LPWPBdKT0pIiyIhFFb2vklTM3tMRG9lg9Q=;
	b=mNw4yh6EqE8Pv3Svnai5eEjVI3q6e4GghUize9gqB3v2thZp+HqgWCO7j3tzUDpxHBidlO
	jgQGcOtvGdHfn4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PVZniRDU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mNw4yh6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5fQlGn0LPWPBdKT0pIiyIhFFb2vklTM3tMRG9lg9Q=;
	b=PVZniRDU9YIsk3d628yJbZaolIEDlI0jypXglbbnmSBtZjPlSL5XPliyTp5GOh/N90t9rj
	my1TMACjoFK3dxKTPUO72yo3ulVeWw0AuBXuPcXOqT8RrIzFi0jpBbFB5cDjBVSIkdY0lh
	Kmg25I+7cDxrUWhd7+3RoFzvvVUyir8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5fQlGn0LPWPBdKT0pIiyIhFFb2vklTM3tMRG9lg9Q=;
	b=mNw4yh6EqE8Pv3Svnai5eEjVI3q6e4GghUize9gqB3v2thZp+HqgWCO7j3tzUDpxHBidlO
	jgQGcOtvGdHfn4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 334E113A3E;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mC43DMV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:52 +0200
Subject: [PATCH 02/12] tools: Add testing support for changes to slab for
 sheaves
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-2-d6a1166b53f2@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 513AE1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The slab changes for sheaves requires more effort in the testing code.
Unite all the kmem_cache work into the tools/include slab header for
both the vma and maple tree testing.

The vma test code also requires importing more #defines to allow for
seamless use of the shared kmem_cache code.

This adds the pthread header to the slab header in the tools directory
to allow for the pthread_mutex in linux.c.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h        | 137 ++++++++++++++++++++++++++++++++++++--
 tools/testing/shared/linux.c      |  26 ++------
 tools/testing/shared/maple-shim.c |   1 +
 tools/testing/vma/vma_internal.h  |  94 +-------------------------
 4 files changed, 142 insertions(+), 116 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index c87051e2b26f5a7fee0362697fae067076b8e84d..c5c5cc6db5668be2cc94c29065ccfa7ca7b4bb08 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -4,11 +4,31 @@
 
 #include <linux/types.h>
 #include <linux/gfp.h>
+#include <pthread.h>
 
-#define SLAB_PANIC 2
 #define SLAB_RECLAIM_ACCOUNT    0x00020000UL            /* Objects are reclaimable */
 
 #define kzalloc_node(size, flags, node) kmalloc(size, flags)
+enum _slab_flag_bits {
+	_SLAB_KMALLOC,
+	_SLAB_HWCACHE_ALIGN,
+	_SLAB_PANIC,
+	_SLAB_TYPESAFE_BY_RCU,
+	_SLAB_ACCOUNT,
+	_SLAB_FLAGS_LAST_BIT
+};
+
+#define __SLAB_FLAG_BIT(nr)	((unsigned int __force)(1U << (nr)))
+#define __SLAB_FLAG_UNUSED	((unsigned int __force)(0U))
+
+#define SLAB_HWCACHE_ALIGN	__SLAB_FLAG_BIT(_SLAB_HWCACHE_ALIGN)
+#define SLAB_PANIC		__SLAB_FLAG_BIT(_SLAB_PANIC)
+#define SLAB_TYPESAFE_BY_RCU	__SLAB_FLAG_BIT(_SLAB_TYPESAFE_BY_RCU)
+#ifdef CONFIG_MEMCG
+# define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
+#else
+# define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
+#endif
 
 void *kmalloc(size_t size, gfp_t gfp);
 void kfree(void *p);
@@ -23,6 +43,86 @@ enum slab_state {
 	FULL
 };
 
+struct kmem_cache {
+	pthread_mutex_t lock;
+	unsigned int size;
+	unsigned int align;
+	unsigned int sheaf_capacity;
+	int nr_objs;
+	void *objs;
+	void (*ctor)(void *);
+	bool non_kernel_enabled;
+	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
+	bool exec_callback;
+	void (*callback)(void *);
+	void *private;
+};
+
+struct kmem_cache_args {
+	/**
+	 * @align: The required alignment for the objects.
+	 *
+	 * %0 means no specific alignment is requested.
+	 */
+	unsigned int align;
+	/**
+	 * @sheaf_capacity: The maximum size of the sheaf.
+	 */
+	unsigned int sheaf_capacity;
+	/**
+	 * @useroffset: Usercopy region offset.
+	 *
+	 * %0 is a valid offset, when @usersize is non-%0
+	 */
+	unsigned int useroffset;
+	/**
+	 * @usersize: Usercopy region size.
+	 *
+	 * %0 means no usercopy region is specified.
+	 */
+	unsigned int usersize;
+	/**
+	 * @freeptr_offset: Custom offset for the free pointer
+	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 *
+	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
+	 * outside of the object. This might cause the object to grow in size.
+	 * Cache creators that have a reason to avoid this can specify a custom
+	 * free pointer offset in their struct where the free pointer will be
+	 * placed.
+	 *
+	 * Note that placing the free pointer inside the object requires the
+	 * caller to ensure that no fields are invalidated that are required to
+	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
+	 * details).
+	 *
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, %use_freeptr_offset must be set %true.
+	 *
+	 * Note that @ctor currently isn't supported with custom free pointers
+	 * as a @ctor requires an external free pointer.
+	 */
+	unsigned int freeptr_offset;
+	/**
+	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
+	 */
+	bool use_freeptr_offset;
+	/**
+	 * @ctor: A constructor for the objects.
+	 *
+	 * The constructor is invoked for each object in a newly allocated slab
+	 * page. It is the cache user's responsibility to free object in the
+	 * same state as after calling the constructor, or deal appropriately
+	 * with any differences between a freshly constructed and a reallocated
+	 * object.
+	 *
+	 * %NULL means no constructor.
+	 */
+	void (*ctor)(void *);
+};
+
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
 	return kmalloc(size, gfp | __GFP_ZERO);
@@ -37,9 +137,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache *cachep, int flags)
 }
 void kmem_cache_free(struct kmem_cache *cachep, void *objp);
 
-struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
-			unsigned int align, unsigned int flags,
-			void (*ctor)(void *));
+
+struct kmem_cache *
+__kmem_cache_create_args(const char *name, unsigned int size,
+		struct kmem_cache_args *args, unsigned int flags);
+
+/* If NULL is passed for @args, use this variant with default arguments. */
+static inline struct kmem_cache *
+__kmem_cache_default_args(const char *name, unsigned int size,
+		struct kmem_cache_args *args, unsigned int flags)
+{
+	struct kmem_cache_args kmem_default_args = {};
+
+	return __kmem_cache_create_args(name, size, &kmem_default_args, flags);
+}
+
+static inline struct kmem_cache *
+__kmem_cache_create(const char *name, unsigned int size, unsigned int align,
+		unsigned int flags, void (*ctor)(void *))
+{
+	struct kmem_cache_args kmem_args = {
+		.align	= align,
+		.ctor	= ctor,
+	};
+
+	return __kmem_cache_create_args(name, size, &kmem_args, flags);
+}
+
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	_Generic((__args),                                              \
+		struct kmem_cache_args *: __kmem_cache_create_args,	\
+		void *: __kmem_cache_default_args,			\
+		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)
 
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 0f97fb0d19e19c327aa4843a35b45cc086f4f366..97b8412ccbb6d222604c7b397c53c65618d8d51b 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -16,21 +16,6 @@ int nr_allocated;
 int preempt_count;
 int test_verbose;
 
-struct kmem_cache {
-	pthread_mutex_t lock;
-	unsigned int size;
-	unsigned int align;
-	int nr_objs;
-	void *objs;
-	void (*ctor)(void *);
-	unsigned int non_kernel;
-	unsigned long nr_allocated;
-	unsigned long nr_tallocated;
-	bool exec_callback;
-	void (*callback)(void *);
-	void *private;
-};
-
 void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *))
 {
 	cachep->callback = callback;
@@ -234,23 +219,26 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 }
 
 struct kmem_cache *
-kmem_cache_create(const char *name, unsigned int size, unsigned int align,
-		unsigned int flags, void (*ctor)(void *))
+__kmem_cache_create_args(const char *name, unsigned int size,
+			  struct kmem_cache_args *args,
+			  unsigned int flags)
 {
 	struct kmem_cache *ret = malloc(sizeof(*ret));
 
 	pthread_mutex_init(&ret->lock, NULL);
 	ret->size = size;
-	ret->align = align;
+	ret->align = args->align;
+	ret->sheaf_capacity = args->sheaf_capacity;
 	ret->nr_objs = 0;
 	ret->nr_allocated = 0;
 	ret->nr_tallocated = 0;
 	ret->objs = NULL;
-	ret->ctor = ctor;
+	ret->ctor = args->ctor;
 	ret->non_kernel = 0;
 	ret->exec_callback = false;
 	ret->callback = NULL;
 	ret->private = NULL;
+
 	return ret;
 }
 
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
index 640df76f483e09f3b6f85612786060dd273e2362..9d7b743415660305416e972fa75b56824211b0eb 100644
--- a/tools/testing/shared/maple-shim.c
+++ b/tools/testing/shared/maple-shim.c
@@ -3,5 +3,6 @@
 /* Very simple shim around the maple tree. */
 
 #include "maple-shared.h"
+#include <linux/slab.h>
 
 #include "../../../lib/maple_tree.c"
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3639aa8dd2b06ebe5b9cfcfe6669994fd38c482d..09732eff8dd84555563b3d485805ebab7b204584 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/slab.h>
 
 extern unsigned long stack_guard_gap;
 #ifdef CONFIG_MMU
@@ -509,65 +510,6 @@ struct pagetable_move_control {
 		.len_in = len_,						\
 	}
 
-struct kmem_cache_args {
-	/**
-	 * @align: The required alignment for the objects.
-	 *
-	 * %0 means no specific alignment is requested.
-	 */
-	unsigned int align;
-	/**
-	 * @useroffset: Usercopy region offset.
-	 *
-	 * %0 is a valid offset, when @usersize is non-%0
-	 */
-	unsigned int useroffset;
-	/**
-	 * @usersize: Usercopy region size.
-	 *
-	 * %0 means no usercopy region is specified.
-	 */
-	unsigned int usersize;
-	/**
-	 * @freeptr_offset: Custom offset for the free pointer
-	 * in &SLAB_TYPESAFE_BY_RCU caches
-	 *
-	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
-	 * outside of the object. This might cause the object to grow in size.
-	 * Cache creators that have a reason to avoid this can specify a custom
-	 * free pointer offset in their struct where the free pointer will be
-	 * placed.
-	 *
-	 * Note that placing the free pointer inside the object requires the
-	 * caller to ensure that no fields are invalidated that are required to
-	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
-	 * details).
-	 *
-	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
-	 * is specified, %use_freeptr_offset must be set %true.
-	 *
-	 * Note that @ctor currently isn't supported with custom free pointers
-	 * as a @ctor requires an external free pointer.
-	 */
-	unsigned int freeptr_offset;
-	/**
-	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
-	 */
-	bool use_freeptr_offset;
-	/**
-	 * @ctor: A constructor for the objects.
-	 *
-	 * The constructor is invoked for each object in a newly allocated slab
-	 * page. It is the cache user's responsibility to free object in the
-	 * same state as after calling the constructor, or deal appropriately
-	 * with any differences between a freshly constructed and a reallocated
-	 * object.
-	 *
-	 * %NULL means no constructor.
-	 */
-	void (*ctor)(void *);
-};
-
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -652,40 +594,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-struct kmem_cache {
-	const char *name;
-	size_t object_size;
-	struct kmem_cache_args *args;
-};
-
-static inline struct kmem_cache *__kmem_cache_create(const char *name,
-						     size_t object_size,
-						     struct kmem_cache_args *args)
-{
-	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
-
-	ret->name = name;
-	ret->object_size = object_size;
-	ret->args = args;
-
-	return ret;
-}
-
-#define kmem_cache_create(__name, __object_size, __args, ...)           \
-	__kmem_cache_create((__name), (__object_size), (__args))
-
-static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
-{
-	(void)gfpflags;
-
-	return calloc(s->object_size, 1);
-}
-
-static inline void kmem_cache_free(struct kmem_cache *s, void *x)
-{
-	free(x);
-}
-
 /*
  * These are defined in vma.h, but sadly vm_stat_account() is referenced by
  * kernel/fork.c, so we have to these broadly available there, and temporarily

-- 
2.51.0


