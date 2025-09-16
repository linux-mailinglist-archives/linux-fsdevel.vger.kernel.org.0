Return-Path: <linux-fsdevel+bounces-61598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C1B58A2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77193B1555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047861C5F23;
	Tue, 16 Sep 2025 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwLlWigy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEECFC1D;
	Tue, 16 Sep 2025 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983949; cv=none; b=P7hclZ69Bz3TblLECHMDpQJPPRao34ZBqTRJigOvSaS9d8wRQD6c24/Lh4K/GvZN+moOaP/h18W8jqwXCjDkWc/MKX/7HibxeWc7YBfcq7avt+NNBg5w/DuSFxyOFX8+DrNJxF36lDg1zOX8GpRTbDvfYAKSEG3Z/jgacBkTI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983949; c=relaxed/simple;
	bh=AZUe6n5h+Y6vesMbm3T6tuMHWZXTUwGwk6Yo93nlVh0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy3w+VY6bUyNItkeXyZusvDz2r2z5PGyA8rBxntFHMMEgiONhM7YXX8XdLE8Y/K4TcH7hmFmzhuchguqC4UrArFByLoBfNR70chFJL7F8MU514gOf5ntPY/cbgNFQEJfqvdw6m99BHP1W2U6S0g/pn0zHfddnsk+gc7GJLIRQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwLlWigy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E76C4CEF1;
	Tue, 16 Sep 2025 00:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983949;
	bh=AZUe6n5h+Y6vesMbm3T6tuMHWZXTUwGwk6Yo93nlVh0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JwLlWigyOoKZkf99o7mmxre8nxyJ5VpKqUCQADLevgPVQrf+ua6FN8FeKUyCQ9mfn
	 abgI10/Rd7rC3rDUnI662Qxcj/WcC2DxPQNA/4oqDN+up4nqgSMZ68q3UuGICF3SIG
	 hEQ4GC5P2Gs8sTf+q77F/XcqHiilCx4dqgunNYyvCwSan3vpCi9DowXvVTX7PZM351
	 lw2XvnUs7qQghR+Bc9Z90L0Y2gNeRJmOBd/GxQW2PU0KFosEp62EGBxmX+JG2oVlOa
	 fTi55MMNL7Saattb9H/eO+rxhbW8WH1dokcDhYtN9iB4XAl+bsnFWExqNpMDXcUcuU
	 rm46Htq1UC8jw==
Date: Mon, 15 Sep 2025 17:52:28 -0700
Subject: [PATCH 07/21] libsupport: add a cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160902.389252.5074023840534966467.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Reuse the cache code from xfsprogs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h     |  139 +++++++++
 lib/support/list.h      |    7 
 lib/support/xbitops.h   |  128 ++++++++
 lib/support/Makefile.in |    8 -
 lib/support/cache.c     |  739 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1019 insertions(+), 2 deletions(-)
 create mode 100644 lib/support/cache.h
 create mode 100644 lib/support/xbitops.h
 create mode 100644 lib/support/cache.c


diff --git a/lib/support/cache.h b/lib/support/cache.h
new file mode 100644
index 00000000000000..16b17a9b7a1a51
--- /dev/null
+++ b/lib/support/cache.h
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2006 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __CACHE_H__
+#define __CACHE_H__
+
+/*
+ * initialisation flags
+ */
+/*
+ * xfs_db always writes changes immediately, and so we need to purge buffers
+ * when we get a buffer lookup mismatch due to reading the same block with a
+ * different buffer configuration.
+ */
+#define CACHE_MISCOMPARE_PURGE	(1 << 0)
+
+/*
+ * cache object campare return values
+ */
+enum {
+	CACHE_HIT,
+	CACHE_MISS,
+	CACHE_PURGE,
+};
+
+#define	HASH_CACHE_RATIO	8
+
+/*
+ * Cache priorities range from BASE to MAX.
+ *
+ * For prefetch support, the top half of the range starts at
+ * CACHE_PREFETCH_PRIORITY and everytime the buffer is fetched and is at or
+ * above this priority level, it is reduced to below this level (refer to
+ * libxfs_buf_get).
+ *
+ * If we have dirty nodes, we can't recycle them until they've been cleaned. To
+ * keep these out of the reclaimable lists (as there can be lots of them) give
+ * them their own priority that the shaker doesn't attempt to walk.
+ */
+
+#define CACHE_BASE_PRIORITY	0
+#define CACHE_PREFETCH_PRIORITY	8
+#define CACHE_MAX_PRIORITY	15
+#define CACHE_DIRTY_PRIORITY	(CACHE_MAX_PRIORITY + 1)
+#define CACHE_NR_PRIORITIES	CACHE_DIRTY_PRIORITY
+
+/*
+ * Simple, generic implementation of a cache (arbitrary data).
+ * Provides a hash table with a capped number of cache entries.
+ */
+
+struct cache;
+struct cache_node;
+
+typedef void *cache_key_t;
+
+typedef void (*cache_walk_t)(struct cache_node *);
+typedef struct cache_node * (*cache_node_alloc_t)(cache_key_t);
+typedef int (*cache_node_flush_t)(struct cache_node *);
+typedef void (*cache_node_relse_t)(struct cache_node *);
+typedef unsigned int (*cache_node_hash_t)(cache_key_t, unsigned int,
+					  unsigned int);
+typedef int (*cache_node_compare_t)(struct cache_node *, cache_key_t);
+typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
+typedef int (*cache_node_get_t)(struct cache_node *);
+typedef void (*cache_node_put_t)(struct cache_node *);
+
+struct cache_operations {
+	cache_node_hash_t	hash;
+	cache_node_alloc_t	alloc;
+	cache_node_flush_t	flush;
+	cache_node_relse_t	relse;
+	cache_node_compare_t	compare;
+	cache_bulk_relse_t	bulkrelse;	/* optional */
+	cache_node_get_t	get;		/* optional */
+	cache_node_put_t	put;		/* optional */
+};
+
+struct cache_hash {
+	struct list_head	ch_list;	/* hash chain head */
+	unsigned int		ch_count;	/* hash chain length */
+	pthread_mutex_t		ch_mutex;	/* hash chain mutex */
+};
+
+struct cache_mru {
+	struct list_head	cm_list;	/* MRU head */
+	unsigned int		cm_count;	/* MRU length */
+	pthread_mutex_t		cm_mutex;	/* MRU lock */
+};
+
+struct cache_node {
+	struct list_head	cn_hash;	/* hash chain */
+	struct list_head	cn_mru;		/* MRU chain */
+	unsigned int		cn_count;	/* reference count */
+	unsigned int		cn_hashidx;	/* hash chain index */
+	int			cn_priority;	/* priority, -1 = free list */
+	int			cn_old_priority;/* saved pre-dirty prio */
+	pthread_mutex_t		cn_mutex;	/* node mutex */
+};
+
+struct cache {
+	int			c_flags;	/* behavioural flags */
+	unsigned int		c_maxcount;	/* max cache nodes */
+	unsigned int		c_count;	/* count of nodes */
+	pthread_mutex_t		c_mutex;	/* node count mutex */
+	cache_node_hash_t	hash;		/* node hash function */
+	cache_node_alloc_t	alloc;		/* allocation function */
+	cache_node_flush_t	flush;		/* flush dirty data function */
+	cache_node_relse_t	relse;		/* memory free function */
+	cache_node_compare_t	compare;	/* comparison routine */
+	cache_bulk_relse_t	bulkrelse;	/* bulk release routine */
+	cache_node_get_t	get;		/* prepare cache node after get */
+	cache_node_put_t	put;		/* prepare to put cache node */
+	unsigned int		c_hashsize;	/* hash bucket count */
+	unsigned int		c_hashshift;	/* hash key shift */
+	struct cache_hash	*c_hash;	/* hash table buckets */
+	struct cache_mru	c_mrus[CACHE_DIRTY_PRIORITY + 1];
+	unsigned long long	c_misses;	/* cache misses */
+	unsigned long long	c_hits;		/* cache hits */
+	unsigned int 		c_max;		/* max nodes ever used */
+};
+
+struct cache *cache_init(int, unsigned int, const struct cache_operations *);
+void cache_destroy(struct cache *);
+void cache_walk(struct cache *, cache_walk_t);
+void cache_purge(struct cache *);
+void cache_flush(struct cache *);
+
+int cache_node_get(struct cache *, cache_key_t, struct cache_node **);
+void cache_node_put(struct cache *, struct cache_node *);
+void cache_node_set_priority(struct cache *, struct cache_node *, int);
+int cache_node_get_priority(struct cache_node *);
+int cache_node_purge(struct cache *, cache_key_t, struct cache_node *);
+void cache_report(FILE *fp, const char *, struct cache *);
+int cache_overflowed(struct cache *);
+
+#endif	/* __CACHE_H__ */
diff --git a/lib/support/list.h b/lib/support/list.h
index df6c99708e4a8e..0e00e446dd7214 100644
--- a/lib/support/list.h
+++ b/lib/support/list.h
@@ -17,6 +17,13 @@ struct list_head {
 	((type *)((char *)(ptr) - offsetof(type, member)))
 #endif
 
+static inline void list_head_destroy(struct list_head *list)
+{
+	list->next = list->prev = NULL;
+}
+
+#define list_head_init(list) INIT_LIST_HEAD(list)
+
 /*
  * Circular doubly linked list implementation.
  *
diff --git a/lib/support/xbitops.h b/lib/support/xbitops.h
new file mode 100644
index 00000000000000..78a8f2a8545f4c
--- /dev/null
+++ b/lib/support/xbitops.h
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __BITOPS_H__
+#define __BITOPS_H__
+
+/*
+ * fls: find last bit set.
+ */
+
+static inline int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x = (x & 0xffffu) << 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x = (x & 0xffffffu) << 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x = (x & 0xfffffffu) << 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x = (x & 0x3fffffffu) << 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		r -= 1;
+	}
+	return r;
+}
+
+static inline int fls64(uint64_t x)
+{
+	uint32_t h = x >> 32;
+	if (h)
+		return fls(h) + 32;
+	return fls(x);
+}
+
+static inline unsigned fls_long(unsigned long l)
+{
+        if (sizeof(l) == 4)
+                return fls(l);
+        return fls64(l);
+}
+
+/*
+ * ffz: find first zero bit.
+ * Result is undefined if no zero bit exists.
+ */
+#define ffz(x)	ffs(~(x))
+
+/*
+ * XFS bit manipulation routines.  Repeated here so that some programs
+ * don't have to link in all of libxfs just to have bit manipulation.
+ */
+
+/*
+ * masks with n high/low bits set, 64-bit values
+ */
+static inline uint64_t mask64hi(int n)
+{
+	return (uint64_t)-1 << (64 - (n));
+}
+static inline uint32_t mask32lo(int n)
+{
+	return ((uint32_t)1 << (n)) - 1;
+}
+static inline uint64_t mask64lo(int n)
+{
+	return ((uint64_t)1 << (n)) - 1;
+}
+
+/* Get high bit set out of 32-bit argument, -1 if none set */
+static inline int highbit32(uint32_t v)
+{
+	return fls(v) - 1;
+}
+
+/* Get high bit set out of 64-bit argument, -1 if none set */
+static inline int highbit64(uint64_t v)
+{
+	return fls64(v) - 1;
+}
+
+/* Get low bit set out of 32-bit argument, -1 if none set */
+static inline int lowbit32(uint32_t v)
+{
+	return ffs(v) - 1;
+}
+
+/* Get low bit set out of 64-bit argument, -1 if none set */
+static inline int lowbit64(uint64_t v)
+{
+	uint32_t	w = (uint32_t)v;
+	int		n = 0;
+
+	if (w) {	/* lower bits */
+		n = ffs(w);
+	} else {	/* upper bits */
+		w = (uint32_t)(v >> 32);
+		if (w) {
+			n = ffs(w);
+			if (n)
+				n += 32;
+		}
+	}
+	return n - 1;
+}
+
+/**
+ * __rounddown_pow_of_two() - round down to nearest power of two
+ * @n: value to round down
+ */
+static inline __attribute__((const))
+unsigned long __rounddown_pow_of_two(unsigned long n)
+{
+	return 1UL << (fls_long(n) - 1);
+}
+
+#define rounddown_pow_of_two(n) __rounddown_pow_of_two(n)
+
+#endif
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index 3f26cd30172f51..13d6f06f150afd 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -25,7 +25,8 @@ OBJS=		cstring.o \
 		quotaio_v2.o \
 		quotaio_tree.o \
 		dict.o \
-		devname.o
+		devname.o \
+		cache.o
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
@@ -40,7 +41,8 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/quotaio_tree.c \
 		$(srcdir)/quotaio_v2.c \
 		$(srcdir)/dict.c \
-		$(srcdir)/devname.c
+		$(srcdir)/devname.c \
+		$(srcdir)/cache.c
 
 LIBRARY= libsupport
 LIBDIR= support
@@ -183,3 +185,5 @@ dict.o: $(srcdir)/dict.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/dict.h
 devname.o: $(srcdir)/devname.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/devname.h $(srcdir)/nls-enable.h
+cache.o: $(srcdir)/cache.c $(top_builddir)/lib/config.h \
+ $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
diff --git a/lib/support/cache.c b/lib/support/cache.c
new file mode 100644
index 00000000000000..fe04f62f262aaa
--- /dev/null
+++ b/lib/support/cache.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2006 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include "list.h"
+#include "cache.h"
+#include "xbitops.h"
+
+#define CACHE_DEBUG 1
+#undef CACHE_DEBUG
+#define CACHE_DEBUG 1
+#undef CACHE_ABORT
+/* #define CACHE_ABORT 1 */
+
+#define CACHE_SHAKE_COUNT	64
+
+#ifdef CACHE_DEBUG
+# include <assert.h>
+# define ASSERT(x)		assert(x)
+#endif
+
+static unsigned int cache_generic_bulkrelse(struct cache *, struct list_head *);
+
+struct cache *
+cache_init(
+	int			flags,
+	unsigned int		hashsize,
+	const struct cache_operations	*cache_operations)
+{
+	struct cache *		cache;
+	unsigned int		i, maxcount;
+
+	maxcount = hashsize * HASH_CACHE_RATIO;
+
+	if (!(cache = malloc(sizeof(struct cache))))
+		return NULL;
+	if (!(cache->c_hash = calloc(hashsize, sizeof(struct cache_hash)))) {
+		free(cache);
+		return NULL;
+	}
+
+	cache->c_flags = flags;
+	cache->c_count = 0;
+	cache->c_max = 0;
+	cache->c_hits = 0;
+	cache->c_misses = 0;
+	cache->c_maxcount = maxcount;
+	cache->c_hashsize = hashsize;
+	cache->c_hashshift = fls(hashsize) - 1;
+	cache->hash = cache_operations->hash;
+	cache->alloc = cache_operations->alloc;
+	cache->flush = cache_operations->flush;
+	cache->relse = cache_operations->relse;
+	cache->compare = cache_operations->compare;
+	cache->bulkrelse = cache_operations->bulkrelse ?
+		cache_operations->bulkrelse : cache_generic_bulkrelse;
+	cache->get = cache_operations->get;
+	cache->put = cache_operations->put;
+	pthread_mutex_init(&cache->c_mutex, NULL);
+
+	for (i = 0; i < hashsize; i++) {
+		list_head_init(&cache->c_hash[i].ch_list);
+		cache->c_hash[i].ch_count = 0;
+		pthread_mutex_init(&cache->c_hash[i].ch_mutex, NULL);
+	}
+
+	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
+		list_head_init(&cache->c_mrus[i].cm_list);
+		cache->c_mrus[i].cm_count = 0;
+		pthread_mutex_init(&cache->c_mrus[i].cm_mutex, NULL);
+	}
+	return cache;
+}
+
+static void
+cache_expand(
+	struct cache *		cache)
+{
+	pthread_mutex_lock(&cache->c_mutex);
+#ifdef CACHE_DEBUG
+	fprintf(stderr, "doubling cache size to %d\n", 2 * cache->c_maxcount);
+#endif
+	cache->c_maxcount *= 2;
+	pthread_mutex_unlock(&cache->c_mutex);
+}
+
+void
+cache_walk(
+	struct cache *		cache,
+	cache_walk_t		visit)
+{
+	struct cache_hash *	hash;
+	struct list_head *	head;
+	struct list_head *	pos;
+	unsigned int		i;
+
+	for (i = 0; i < cache->c_hashsize; i++) {
+		hash = &cache->c_hash[i];
+		head = &hash->ch_list;
+		pthread_mutex_lock(&hash->ch_mutex);
+		for (pos = head->next; pos != head; pos = pos->next)
+			visit((struct cache_node *)pos);
+		pthread_mutex_unlock(&hash->ch_mutex);
+	}
+}
+
+#ifdef CACHE_ABORT
+#define cache_abort()	abort()
+#else
+#define cache_abort()	do { } while (0)
+#endif
+
+#ifdef CACHE_DEBUG
+static void
+cache_zero_check(
+	struct cache_node *	node)
+{
+	if (node->cn_count > 0) {
+		fprintf(stderr, "%s: refcount is %u, not zero (node=%p)\n",
+			__FUNCTION__, node->cn_count, node);
+		cache_abort();
+	}
+}
+#define cache_destroy_check(c)	cache_walk((c), cache_zero_check)
+#else
+#define cache_destroy_check(c)	do { } while (0)
+#endif
+
+void
+cache_destroy(
+	struct cache *		cache)
+{
+	unsigned int		i;
+
+	cache_destroy_check(cache);
+	for (i = 0; i < cache->c_hashsize; i++) {
+		list_head_destroy(&cache->c_hash[i].ch_list);
+		pthread_mutex_destroy(&cache->c_hash[i].ch_mutex);
+	}
+	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
+		list_head_destroy(&cache->c_mrus[i].cm_list);
+		pthread_mutex_destroy(&cache->c_mrus[i].cm_mutex);
+	}
+	pthread_mutex_destroy(&cache->c_mutex);
+	free(cache->c_hash);
+	free(cache);
+}
+
+static unsigned int
+cache_generic_bulkrelse(
+	struct cache *		cache,
+	struct list_head *	list)
+{
+	struct cache_node *	node;
+	unsigned int		count = 0;
+
+	while (!list_empty(list)) {
+		node = list_entry(list->next, struct cache_node, cn_mru);
+		pthread_mutex_destroy(&node->cn_mutex);
+		list_del_init(&node->cn_mru);
+		cache->relse(node);
+		count++;
+	}
+
+	return count;
+}
+
+/*
+ * Park unflushable nodes on their own special MRU so that cache_shake() doesn't
+ * end up repeatedly scanning them in the futile attempt to clean them before
+ * reclaim.
+ */
+static void
+cache_add_to_dirty_mru(
+	struct cache		*cache,
+	struct cache_node	*node)
+{
+	struct cache_mru	*mru = &cache->c_mrus[CACHE_DIRTY_PRIORITY];
+
+	pthread_mutex_lock(&mru->cm_mutex);
+	node->cn_old_priority = node->cn_priority;
+	node->cn_priority = CACHE_DIRTY_PRIORITY;
+	list_add(&node->cn_mru, &mru->cm_list);
+	mru->cm_count++;
+	pthread_mutex_unlock(&mru->cm_mutex);
+}
+
+/*
+ * We've hit the limit on cache size, so we need to start reclaiming nodes we've
+ * used. The MRU specified by the priority is shaken.  Returns new priority at
+ * end of the call (in case we call again). We are not allowed to reclaim dirty
+ * objects, so we have to flush them first. If flushing fails, we move them to
+ * the "dirty, unreclaimable" list.
+ *
+ * Hence we skip priorities > CACHE_MAX_PRIORITY unless "purge" is set as we
+ * park unflushable (and hence unreclaimable) buffers at these priorities.
+ * Trying to shake unreclaimable buffer lists when there is memory pressure is a
+ * waste of time and CPU and greatly slows down cache node recycling operations.
+ * Hence we only try to free them if we are being asked to purge the cache of
+ * all entries.
+ */
+static unsigned int
+cache_shake(
+	struct cache *		cache,
+	unsigned int		priority,
+	bool			purge)
+{
+	struct cache_mru	*mru;
+	struct cache_hash *	hash;
+	struct list_head	temp;
+	struct list_head *	head;
+	struct list_head *	pos;
+	struct list_head *	n;
+	struct cache_node *	node;
+	unsigned int		count;
+
+	ASSERT(priority <= CACHE_DIRTY_PRIORITY);
+	if (priority > CACHE_MAX_PRIORITY && !purge)
+		priority = 0;
+
+	mru = &cache->c_mrus[priority];
+	count = 0;
+	list_head_init(&temp);
+	head = &mru->cm_list;
+
+	pthread_mutex_lock(&mru->cm_mutex);
+	for (pos = head->prev, n = pos->prev; pos != head;
+						pos = n, n = pos->prev) {
+		node = list_entry(pos, struct cache_node, cn_mru);
+
+		if (pthread_mutex_trylock(&node->cn_mutex) != 0)
+			continue;
+
+		/* memory pressure is not allowed to release dirty objects */
+		if (cache->flush(node) && !purge) {
+			list_del(&node->cn_mru);
+			mru->cm_count--;
+			node->cn_priority = -1;
+			pthread_mutex_unlock(&node->cn_mutex);
+			cache_add_to_dirty_mru(cache, node);
+			continue;
+		}
+
+		hash = cache->c_hash + node->cn_hashidx;
+		if (pthread_mutex_trylock(&hash->ch_mutex) != 0) {
+			pthread_mutex_unlock(&node->cn_mutex);
+			continue;
+		}
+		ASSERT(node->cn_count == 0);
+		ASSERT(node->cn_priority == priority);
+		node->cn_priority = -1;
+
+		list_move(&node->cn_mru, &temp);
+		list_del_init(&node->cn_hash);
+		hash->ch_count--;
+		mru->cm_count--;
+		pthread_mutex_unlock(&hash->ch_mutex);
+		pthread_mutex_unlock(&node->cn_mutex);
+
+		count++;
+		if (!purge && count == CACHE_SHAKE_COUNT)
+			break;
+	}
+	pthread_mutex_unlock(&mru->cm_mutex);
+
+	if (count > 0) {
+		cache->bulkrelse(cache, &temp);
+
+		pthread_mutex_lock(&cache->c_mutex);
+		cache->c_count -= count;
+		pthread_mutex_unlock(&cache->c_mutex);
+	}
+
+	return (count == CACHE_SHAKE_COUNT) ? priority : ++priority;
+}
+
+/*
+ * Allocate a new hash node (updating atomic counter in the process),
+ * unless doing so will push us over the maximum cache size.
+ */
+static struct cache_node *
+cache_node_allocate(
+	struct cache *		cache,
+	cache_key_t		key)
+{
+	unsigned int		nodesfree;
+	struct cache_node *	node;
+
+	pthread_mutex_lock(&cache->c_mutex);
+	nodesfree = (cache->c_count < cache->c_maxcount);
+	if (nodesfree) {
+		cache->c_count++;
+		if (cache->c_count > cache->c_max)
+			cache->c_max = cache->c_count;
+	}
+	cache->c_misses++;
+	pthread_mutex_unlock(&cache->c_mutex);
+	if (!nodesfree)
+		return NULL;
+	node = cache->alloc(key);
+	if (node == NULL) {	/* uh-oh */
+		pthread_mutex_lock(&cache->c_mutex);
+		cache->c_count--;
+		pthread_mutex_unlock(&cache->c_mutex);
+		return NULL;
+	}
+	pthread_mutex_init(&node->cn_mutex, NULL);
+	list_head_init(&node->cn_mru);
+	node->cn_count = 1;
+	node->cn_priority = 0;
+	node->cn_old_priority = -1;
+	return node;
+}
+
+int
+cache_overflowed(
+	struct cache *		cache)
+{
+	return cache->c_maxcount == cache->c_max;
+}
+
+
+static int
+__cache_node_purge(
+	struct cache *		cache,
+	struct cache_node *	node)
+{
+	int			count;
+	struct cache_mru *	mru;
+
+	pthread_mutex_lock(&node->cn_mutex);
+	count = node->cn_count;
+	if (count != 0) {
+		pthread_mutex_unlock(&node->cn_mutex);
+		return count;
+	}
+
+	/* can't purge dirty objects */
+	if (cache->flush(node)) {
+		pthread_mutex_unlock(&node->cn_mutex);
+		return 1;
+	}
+
+	mru = &cache->c_mrus[node->cn_priority];
+	pthread_mutex_lock(&mru->cm_mutex);
+	list_del_init(&node->cn_mru);
+	mru->cm_count--;
+	pthread_mutex_unlock(&mru->cm_mutex);
+
+	pthread_mutex_unlock(&node->cn_mutex);
+	pthread_mutex_destroy(&node->cn_mutex);
+	list_del_init(&node->cn_hash);
+	cache->relse(node);
+	return 0;
+}
+
+/*
+ * Lookup in the cache hash table.  With any luck we'll get a cache
+ * hit, in which case this will all be over quickly and painlessly.
+ * Otherwise, we allocate a new node, taking care not to expand the
+ * cache beyond the requested maximum size (shrink it if it would).
+ * Returns one if hit in cache, otherwise zero.  A node is _always_
+ * returned, however.
+ */
+int
+cache_node_get(
+	struct cache *		cache,
+	cache_key_t		key,
+	struct cache_node **	nodep)
+{
+	struct cache_node *	node = NULL;
+	struct cache_hash *	hash;
+	struct cache_mru *	mru;
+	struct list_head *	head;
+	struct list_head *	pos;
+	struct list_head *	n;
+	unsigned int		hashidx;
+	int			priority = 0;
+	int			purged = 0;
+
+	hashidx = cache->hash(key, cache->c_hashsize, cache->c_hashshift);
+	hash = cache->c_hash + hashidx;
+	head = &hash->ch_list;
+
+	for (;;) {
+		pthread_mutex_lock(&hash->ch_mutex);
+		for (pos = head->next, n = pos->next; pos != head;
+						pos = n, n = pos->next) {
+			int result;
+
+			node = list_entry(pos, struct cache_node, cn_hash);
+			result = cache->compare(node, key);
+			switch (result) {
+			case CACHE_HIT:
+				break;
+			case CACHE_PURGE:
+				if ((cache->c_flags & CACHE_MISCOMPARE_PURGE) &&
+				    !__cache_node_purge(cache, node)) {
+					purged++;
+					hash->ch_count--;
+				}
+				/* FALL THROUGH */
+			case CACHE_MISS:
+				goto next_object;
+			}
+
+			/*
+			 * node found, bump node's reference count, remove it
+			 * from its MRU list, and update stats.
+			 */
+			pthread_mutex_lock(&node->cn_mutex);
+
+			if (node->cn_count == 0 && cache->get) {
+				int err = cache->get(node);
+				if (err) {
+					pthread_mutex_unlock(&node->cn_mutex);
+					goto next_object;
+				}
+			}
+			if (node->cn_count == 0) {
+				ASSERT(node->cn_priority >= 0);
+				ASSERT(!list_empty(&node->cn_mru));
+				mru = &cache->c_mrus[node->cn_priority];
+				pthread_mutex_lock(&mru->cm_mutex);
+				mru->cm_count--;
+				list_del_init(&node->cn_mru);
+				pthread_mutex_unlock(&mru->cm_mutex);
+				if (node->cn_old_priority != -1) {
+					ASSERT(node->cn_priority ==
+							CACHE_DIRTY_PRIORITY);
+					node->cn_priority = node->cn_old_priority;
+					node->cn_old_priority = -1;
+				}
+			}
+			node->cn_count++;
+
+			pthread_mutex_unlock(&node->cn_mutex);
+			pthread_mutex_unlock(&hash->ch_mutex);
+
+			pthread_mutex_lock(&cache->c_mutex);
+			cache->c_hits++;
+			pthread_mutex_unlock(&cache->c_mutex);
+
+			*nodep = node;
+			return 0;
+next_object:
+			continue;	/* what the hell, gcc? */
+		}
+		pthread_mutex_unlock(&hash->ch_mutex);
+		/*
+		 * not found, allocate a new entry
+		 */
+		node = cache_node_allocate(cache, key);
+		if (node)
+			break;
+		priority = cache_shake(cache, priority, false);
+		/*
+		 * We start at 0; if we free CACHE_SHAKE_COUNT we get
+		 * back the same priority, if not we get back priority+1.
+		 * If we exceed CACHE_MAX_PRIORITY all slots are full; grow it.
+		 */
+		if (priority > CACHE_MAX_PRIORITY) {
+			priority = 0;
+			cache_expand(cache);
+		}
+	}
+
+	node->cn_hashidx = hashidx;
+
+	/* add new node to appropriate hash */
+	pthread_mutex_lock(&hash->ch_mutex);
+	hash->ch_count++;
+	list_add(&node->cn_hash, &hash->ch_list);
+	pthread_mutex_unlock(&hash->ch_mutex);
+
+	if (purged) {
+		pthread_mutex_lock(&cache->c_mutex);
+		cache->c_count -= purged;
+		pthread_mutex_unlock(&cache->c_mutex);
+	}
+
+	*nodep = node;
+	return 1;
+}
+
+void
+cache_node_put(
+	struct cache *		cache,
+	struct cache_node *	node)
+{
+	struct cache_mru *	mru;
+
+	pthread_mutex_lock(&node->cn_mutex);
+#ifdef CACHE_DEBUG
+	if (node->cn_count < 1) {
+		fprintf(stderr, "%s: node put on refcount %u (node=%p)\n",
+				__FUNCTION__, node->cn_count, node);
+		cache_abort();
+	}
+	if (!list_empty(&node->cn_mru)) {
+		fprintf(stderr, "%s: node put on node (%p) in MRU list\n",
+				__FUNCTION__, node);
+		cache_abort();
+	}
+#endif
+	node->cn_count--;
+
+	if (node->cn_count == 0 && cache->put)
+		cache->put(node);
+	if (node->cn_count == 0) {
+		/* add unreferenced node to appropriate MRU for shaker */
+		mru = &cache->c_mrus[node->cn_priority];
+		pthread_mutex_lock(&mru->cm_mutex);
+		mru->cm_count++;
+		list_add(&node->cn_mru, &mru->cm_list);
+		pthread_mutex_unlock(&mru->cm_mutex);
+	}
+
+	pthread_mutex_unlock(&node->cn_mutex);
+}
+
+void
+cache_node_set_priority(
+	struct cache *		cache,
+	struct cache_node *	node,
+	int			priority)
+{
+	if (priority < 0)
+		priority = 0;
+	else if (priority > CACHE_MAX_PRIORITY)
+		priority = CACHE_MAX_PRIORITY;
+
+	pthread_mutex_lock(&node->cn_mutex);
+	ASSERT(node->cn_count > 0);
+	node->cn_priority = priority;
+	node->cn_old_priority = -1;
+	pthread_mutex_unlock(&node->cn_mutex);
+}
+
+int
+cache_node_get_priority(
+	struct cache_node *	node)
+{
+	int			priority;
+
+	pthread_mutex_lock(&node->cn_mutex);
+	priority = node->cn_priority;
+	pthread_mutex_unlock(&node->cn_mutex);
+
+	return priority;
+}
+
+
+/*
+ * Purge a specific node from the cache.  Reference count must be zero.
+ */
+int
+cache_node_purge(
+	struct cache *		cache,
+	cache_key_t		key,
+	struct cache_node *	node)
+{
+	struct list_head *	head;
+	struct list_head *	pos;
+	struct list_head *	n;
+	struct cache_hash *	hash;
+	int			count = -1;
+
+	hash = cache->c_hash + cache->hash(key, cache->c_hashsize,
+					   cache->c_hashshift);
+	head = &hash->ch_list;
+	pthread_mutex_lock(&hash->ch_mutex);
+	for (pos = head->next, n = pos->next; pos != head;
+						pos = n, n = pos->next) {
+		if ((struct cache_node *)pos != node)
+			continue;
+
+		count = __cache_node_purge(cache, node);
+		if (!count)
+			hash->ch_count--;
+		break;
+	}
+	pthread_mutex_unlock(&hash->ch_mutex);
+
+	if (count == 0) {
+		pthread_mutex_lock(&cache->c_mutex);
+		cache->c_count--;
+		pthread_mutex_unlock(&cache->c_mutex);
+	}
+#ifdef CACHE_DEBUG
+	if (count >= 1) {
+		fprintf(stderr, "%s: refcount was %u, not zero (node=%p)\n",
+				__FUNCTION__, count, node);
+		cache_abort();
+	}
+	if (count == -1) {
+		fprintf(stderr, "%s: purge node not found! (node=%p)\n",
+			__FUNCTION__, node);
+		cache_abort();
+	}
+#endif
+	return count == 0;
+}
+
+/*
+ * Purge all nodes from the cache.  All reference counts must be zero.
+ */
+void
+cache_purge(
+	struct cache *		cache)
+{
+	int			i;
+
+	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++)
+		cache_shake(cache, i, true);
+
+#ifdef CACHE_DEBUG
+	if (cache->c_count != 0) {
+		/* flush referenced nodes to disk */
+		cache_flush(cache);
+		fprintf(stderr, "%s: shake on cache %p left %u nodes!?\n",
+				__FUNCTION__, cache, cache->c_count);
+		cache_abort();
+	}
+#endif
+}
+
+/*
+ * Flush all nodes in the cache to disk.
+ */
+void
+cache_flush(
+	struct cache *		cache)
+{
+	struct cache_hash *	hash;
+	struct list_head *	head;
+	struct list_head *	pos;
+	struct cache_node *	node;
+	int			i;
+
+	if (!cache->flush)
+		return;
+
+	for (i = 0; i < cache->c_hashsize; i++) {
+		hash = &cache->c_hash[i];
+
+		pthread_mutex_lock(&hash->ch_mutex);
+		head = &hash->ch_list;
+		for (pos = head->next; pos != head; pos = pos->next) {
+			node = (struct cache_node *)pos;
+			pthread_mutex_lock(&node->cn_mutex);
+			cache->flush(node);
+			pthread_mutex_unlock(&node->cn_mutex);
+		}
+		pthread_mutex_unlock(&hash->ch_mutex);
+	}
+}
+
+#define	HASH_REPORT	(3 * HASH_CACHE_RATIO)
+void
+cache_report(
+	FILE		*fp,
+	const char	*name,
+	struct cache	*cache)
+{
+	int		i;
+	unsigned long	count, index, total;
+	unsigned long	hash_bucket_lengths[HASH_REPORT + 2];
+
+	if ((cache->c_hits + cache->c_misses) == 0)
+		return;
+
+	/* report cache summary */
+	fprintf(fp, "%s: %p\n"
+			"Max supported entries = %u\n"
+			"Max utilized entries = %u\n"
+			"Active entries = %u\n"
+			"Hash table size = %u\n"
+			"Hits = %llu\n"
+			"Misses = %llu\n"
+			"Hit ratio = %5.2f\n",
+			name, cache,
+			cache->c_maxcount,
+			cache->c_max,
+			cache->c_count,
+			cache->c_hashsize,
+			cache->c_hits,
+			cache->c_misses,
+			(double)cache->c_hits * 100 /
+				(cache->c_hits + cache->c_misses)
+	);
+
+	for (i = 0; i <= CACHE_MAX_PRIORITY; i++)
+		fprintf(fp, "MRU %d entries = %6u (%3u%%)\n",
+			i, cache->c_mrus[i].cm_count,
+			cache->c_mrus[i].cm_count * 100 / cache->c_count);
+
+	i = CACHE_DIRTY_PRIORITY;
+	fprintf(fp, "Dirty MRU %d entries = %6u (%3u%%)\n",
+		i, cache->c_mrus[i].cm_count,
+		cache->c_mrus[i].cm_count * 100 / cache->c_count);
+
+	/* report hash bucket lengths */
+	bzero(hash_bucket_lengths, sizeof(hash_bucket_lengths));
+
+	for (i = 0; i < cache->c_hashsize; i++) {
+		count = cache->c_hash[i].ch_count;
+		if (count > HASH_REPORT)
+			index = HASH_REPORT + 1;
+		else
+			index = count;
+		hash_bucket_lengths[index]++;
+	}
+
+	total = 0;
+	for (i = 0; i < HASH_REPORT + 1; i++) {
+		total += i * hash_bucket_lengths[i];
+		if (hash_bucket_lengths[i] == 0)
+			continue;
+		fprintf(fp, "Hash buckets with  %2d entries %6ld (%3ld%%)\n",
+			i, hash_bucket_lengths[i],
+			(i * hash_bucket_lengths[i] * 100) / cache->c_count);
+	}
+	if (hash_bucket_lengths[i])	/* last report bucket is the overflow bucket */
+		fprintf(fp, "Hash buckets with >%2d entries %6ld (%3ld%%)\n",
+			i - 1, hash_bucket_lengths[i],
+			((cache->c_count - total) * 100) / cache->c_count);
+}


