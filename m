Return-Path: <linux-fsdevel+bounces-11221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5E85209C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8891C20A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96BF5DF26;
	Mon, 12 Feb 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPKU6Pq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CB5D757
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774040; cv=none; b=hkvUTNC5fdl0HUvzKq9dcZGvY/UfMXQKW9eXNMKX4d26mFYq0bZJa0V9jIMgjeTWSjoUwOaaKu5mZ3hm2Dh0TQluvxlqGgfkkBu+ir9klZ5wUr50kF0pEaks5MAzBIdmuH0UraUxWxEeQMwrHhnqxLsmdoYkzXxD2mWD+P6ontM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774040; c=relaxed/simple;
	bh=tCvhP3PYjDBZ2XkO8WMVqHxillTEc89au2Y0t57PRYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIWfqwAnTqH/LS7XaKFCYLEMShdt0S5KkC/PLCtJ6VoJOTAcPXCdJC+iJL3Q3ITAP0dnfi+hNOAXFkRROchLCHzyjDnibYHeU+wp/DZgkKpVNMkYrnnYURnOerUt05FC+VcUl9t+Aq5Owre5K57hj/VkdGEvnlAYn6Ie0fHNPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPKU6Pq1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso6361556276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774037; x=1708378837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGO51nbRXLBlE7dZyNty79pnfUUWZlGfdlbPBWriSco=;
        b=yPKU6Pq1LfM+A9L28L6Ke5x8igPWbKAeEor8EYgkugczHsYfkFokG0N4Lz6H//iChi
         oQjN/PfzrK/JNbn9iweCl2mfyuHm1HT2g3jeFa7SU16ZaB4FUXd2n3I/hDIHvreg+xIp
         G3oTfy4IJWt1eYA796CioaeQ3E0ZUrfI90vYyYJ0k/nhQkOXYeQxNJ3Z7f6O29OGhu2T
         +1+3pYrJA1lnr3c48R3+S5ciBgQqljL5+B2nHMM/mp5uxyOfv67Nmk9C4m0IfSaZXixk
         0Yr1xysqF9RDV1+UWRpDNB4cYQyatYNLBuOQyQ4Jv4ifiXSChRiDoGQMQTM8SwY6ZBK6
         ArXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774037; x=1708378837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGO51nbRXLBlE7dZyNty79pnfUUWZlGfdlbPBWriSco=;
        b=S5ny4tZip1b+34dgNiEyCWXHGKkYi0axpzYs9fWR7yGdrnUmfaNjkjvGR/M60Krg30
         94hQEEY5k82RmsDvoKfmgktTsUqBV7rqrmRKCs6Hlgx6hZ5LByFO+r0ebnozoQlpylsF
         fU2DylSIJtnMWGGqX9M4bDjQsO6LPNymdkwluJ8Xez5oVFCfLmtVztmuNUMI5ErEUCBL
         2kemrNXib+jvvY6zTAkOWREoliOZK45LRPkX6QoS6B6aNeBiWZwLRh0qxVm9DtRn9Fh7
         /A8IqLOF0KuOwzO5ZqEvHlGsYFvY8//yVftpiiqqZIoqkfxeCqJ6bDcXZukdMURFG9PS
         ZR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVD2gjYXddNilik0aRQLcNuRIdIbpq9fyDzImUPxtLVxXXNxQZHWkKbDS12X5ikko/khPx4WTxnEzbdHs/2qCkrjF2QIPEM2XYttwloQw==
X-Gm-Message-State: AOJu0Yz4SFx234cLgq5Ku98n4aKbR/pEuDAkepYsiLd37Eaq8UFOEPal
	yrPhV6b755CyJhOXM9xppbAVkdCXWQc9w5sCDWfHyHDmS3/YPG7kRyJJ8HuIY0XQ3as1u4Gn3kQ
	p5g==
X-Google-Smtp-Source: AGHT+IHmk8+MK6zpdhADLMK0RWOIRjTnTYcSM/aIheok3v5Ff3xU8ZgKrwhYoeQuPApfz/4RhyV47R9pCGQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:9c08:0:b0:dc6:f21f:64ac with SMTP id
 c8-20020a259c08000000b00dc6f21f64acmr2107909ybo.12.1707774037425; Mon, 12 Feb
 2024 13:40:37 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:16 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-31-surenb@google.com>
Subject: [PATCH v3 30/35] rhashtable: Plumb through alloc tag
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

This gives better memory allocation profiling results; rhashtable
allocations will be accounted to the code that initialized the
rhashtable.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/rhashtable-types.h | 11 +++++--
 lib/rhashtable.c                 | 52 +++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index b6f3797277ff..015c8298bebc 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_RHASHTABLE_TYPES_H
 #define _LINUX_RHASHTABLE_TYPES_H
 
+#include <linux/alloc_tag.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
@@ -88,6 +89,9 @@ struct rhashtable {
 	struct mutex                    mutex;
 	spinlock_t			lock;
 	atomic_t			nelems;
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	struct alloc_tag		*alloc_tag;
+#endif
 };
 
 /**
@@ -127,9 +131,12 @@ struct rhashtable_iter {
 	bool end_of_table;
 };
 
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params);
-int rhltable_init(struct rhltable *hlt,
+#define rhashtable_init(...)	alloc_hooks(rhashtable_init_noprof(__VA_ARGS__))
+
+int rhltable_init_noprof(struct rhltable *hlt,
 		  const struct rhashtable_params *params);
+#define rhltable_init(...)	alloc_hooks(rhltable_init_noprof(__VA_ARGS__))
 
 #endif /* _LINUX_RHASHTABLE_TYPES_H */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..b62116f332b8 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -63,6 +63,27 @@ EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #define ASSERT_RHT_MUTEX(HT)
 #endif
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline void rhashtable_alloc_tag_init(struct rhashtable *ht)
+{
+	ht->alloc_tag = current->alloc_tag;
+}
+
+static inline struct alloc_tag *rhashtable_alloc_tag_save(struct rhashtable *ht)
+{
+	return alloc_tag_save(ht->alloc_tag);
+}
+
+static inline void rhashtable_alloc_tag_restore(struct rhashtable *ht, struct alloc_tag *old)
+{
+	alloc_tag_restore(ht->alloc_tag, old);
+}
+#else
+#define rhashtable_alloc_tag_init(ht)
+static inline struct alloc_tag *rhashtable_alloc_tag_save(struct rhashtable *ht) { return NULL; }
+#define rhashtable_alloc_tag_restore(ht, old)
+#endif
+
 static inline union nested_table *nested_table_top(
 	const struct bucket_table *tbl)
 {
@@ -130,7 +151,7 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 	if (ntbl)
 		return ntbl;
 
-	ntbl = kzalloc(PAGE_SIZE, GFP_ATOMIC);
+	ntbl = kmalloc_noprof(PAGE_SIZE, GFP_ATOMIC|__GFP_ZERO);
 
 	if (ntbl && leaf) {
 		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0]); i++)
@@ -157,7 +178,7 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 
 	size = sizeof(*tbl) + sizeof(tbl->buckets[0]);
 
-	tbl = kzalloc(size, gfp);
+	tbl = kmalloc_noprof(size, gfp|__GFP_ZERO);
 	if (!tbl)
 		return NULL;
 
@@ -180,8 +201,10 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	size_t size;
 	int i;
 	static struct lock_class_key __key;
+	struct alloc_tag * __maybe_unused old = rhashtable_alloc_tag_save(ht);
 
-	tbl = kvzalloc(struct_size(tbl, buckets, nbuckets), gfp);
+	tbl = kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
+				   gfp|__GFP_ZERO, NUMA_NO_NODE);
 
 	size = nbuckets;
 
@@ -190,6 +213,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 		nbuckets = 0;
 	}
 
+	rhashtable_alloc_tag_restore(ht, old);
+
 	if (tbl == NULL)
 		return NULL;
 
@@ -975,7 +1000,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
 }
 
 /**
- * rhashtable_init - initialize a new hash table
+ * rhashtable_init_noprof - initialize a new hash table
  * @ht:		hash table to be initialized
  * @params:	configuration parameters
  *
@@ -1016,7 +1041,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.obj_hashfn = my_hash_fn,
  * };
  */
-int rhashtable_init(struct rhashtable *ht,
+int rhashtable_init_noprof(struct rhashtable *ht,
 		    const struct rhashtable_params *params)
 {
 	struct bucket_table *tbl;
@@ -1031,6 +1056,8 @@ int rhashtable_init(struct rhashtable *ht,
 	spin_lock_init(&ht->lock);
 	memcpy(&ht->p, params, sizeof(*params));
 
+	rhashtable_alloc_tag_init(ht);
+
 	if (params->min_size)
 		ht->p.min_size = roundup_pow_of_two(params->min_size);
 
@@ -1076,26 +1103,26 @@ int rhashtable_init(struct rhashtable *ht,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rhashtable_init);
+EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
 
 /**
- * rhltable_init - initialize a new hash list table
+ * rhltable_init_noprof - initialize a new hash list table
  * @hlt:	hash list table to be initialized
  * @params:	configuration parameters
  *
  * Initializes a new hash list table.
  *
- * See documentation for rhashtable_init.
+ * See documentation for rhashtable_init_noprof.
  */
-int rhltable_init(struct rhltable *hlt, const struct rhashtable_params *params)
+int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
 {
 	int err;
 
-	err = rhashtable_init(&hlt->ht, params);
+	err = rhashtable_init_noprof(&hlt->ht, params);
 	hlt->ht.rhlist = true;
 	return err;
 }
-EXPORT_SYMBOL_GPL(rhltable_init);
+EXPORT_SYMBOL_GPL(rhltable_init_noprof);
 
 static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
 				void (*free_fn)(void *ptr, void *arg),
@@ -1222,6 +1249,7 @@ struct rhash_lock_head __rcu **rht_bucket_nested_insert(
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	union nested_table *ntbl;
+	struct alloc_tag * __maybe_unused old = rhashtable_alloc_tag_save(ht);
 
 	ntbl = nested_table_top(tbl);
 	hash >>= tbl->nest;
@@ -1236,6 +1264,8 @@ struct rhash_lock_head __rcu **rht_bucket_nested_insert(
 					  size <= (1 << shift));
 	}
 
+	rhashtable_alloc_tag_restore(ht, old);
+
 	if (!ntbl)
 		return NULL;
 
-- 
2.43.0.687.g38aa6559b0-goog


