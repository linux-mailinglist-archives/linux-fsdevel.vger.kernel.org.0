Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA6437D19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJVTEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233568AbhJVTD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aDCG26kpPf8CE+R9TGlLXB5nhezdv64wu8OoQs9ano=;
        b=QKEGEPxNhc8k/1B6XadMQ8zkPyEXLe0DO0D5fDB+jgFmsTchB/ScnXHVrRjX4OFlkXkKTI
        HG9ePZ5eB41AnV3jKtchEwDpBrW8WghvXohhRcHhMmV2S5lWEe1cgju7dYMdiKXg4QK6qg
        dp13VLLu8dM9AgxzvzbW46DW6jdKXBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-CuXi5imOOPiPV4r3E9-3bw-1; Fri, 22 Oct 2021 15:01:35 -0400
X-MC-Unique: CuXi5imOOPiPV4r3E9-3bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 592AB18D6A2A;
        Fri, 22 Oct 2021 19:01:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF185B826;
        Fri, 22 Oct 2021 19:01:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 09/53] fscache: Implement cache registration
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:01:24 +0100
Message-ID: <163492928450.1038219.14760455745083894643.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement helper functions to acquire a cache record and put a reference on
it.  These are used both as part of cache registration by the cache backend
and as part of cache request by the network filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/Makefile            |    1 
 fs/fscache/cache.c             |  229 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    8 +
 fs/fscache/proc.c              |    4 +
 include/linux/fscache-cache.h  |   60 ++++++++++
 include/trace/events/fscache.h |   37 ++++++
 6 files changed, 339 insertions(+)
 create mode 100644 fs/fscache/cache.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index f9722de32247..d9fc22c18090 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -4,6 +4,7 @@
 #
 
 fscache-y := \
+	cache.o \
 	main.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
new file mode 100644
index 000000000000..da08e29ee5b9
--- /dev/null
+++ b/fs/fscache/cache.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache cache handling
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/export.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+static LIST_HEAD(fscache_caches);
+DECLARE_RWSEM(fscache_addremove_sem);
+EXPORT_SYMBOL(fscache_addremove_sem);
+
+static atomic_t fscache_cache_debug_id;
+
+/*
+ * Allocate a cache cookie.
+ */
+static struct fscache_cache *fscache_alloc_cache(const char *name)
+{
+	struct fscache_cache *cache;
+
+	cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+	if (cache) {
+		if (name) {
+			cache->name = kstrdup(name, GFP_KERNEL);
+			if (!cache->name) {
+				kfree(cache);
+				return NULL;
+			}
+		}
+		refcount_set(&cache->ref, 1);
+		INIT_LIST_HEAD(&cache->cache_link);
+		cache->debug_id = atomic_inc_return(&fscache_cache_debug_id);
+	}
+	return cache;
+}
+
+static bool fscache_get_cache_maybe(struct fscache_cache *cache,
+				    enum fscache_cache_trace where)
+{
+	bool success;
+	int ref;
+
+	success = __refcount_inc_not_zero(&cache->ref, &ref);
+	if (success)
+		trace_fscache_cache(cache->debug_id, ref + 1, where);
+	return success;
+}
+
+/*
+ * Look up a cache cookie.
+ */
+struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache)
+{
+	struct fscache_cache *candidate, *cache, *unnamed = NULL;
+
+	/* firstly check for the existence of the cache under read lock */
+	down_read(&fscache_addremove_sem);
+
+	list_for_each_entry(cache, &fscache_caches, cache_link) {
+		if (cache->name && name && strcmp(cache->name, name) == 0 &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_r;
+		if (!cache->name && !name &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_r;
+	}
+
+	if (!name) {
+		list_for_each_entry(cache, &fscache_caches, cache_link) {
+			if (cache->name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_r;
+		}
+	}
+
+	up_read(&fscache_addremove_sem);
+
+	/* the cache does not exist - create a candidate */
+	candidate = fscache_alloc_cache(name);
+	if (!candidate)
+		return ERR_PTR(-ENOMEM);
+
+	/* write lock, search again and add if still not present */
+	down_write(&fscache_addremove_sem);
+
+	list_for_each_entry(cache, &fscache_caches, cache_link) {
+		if (cache->name && name && strcmp(cache->name, name) == 0 &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_w;
+		if (!cache->name) {
+			unnamed = cache;
+			if (!name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_w;
+		}
+	}
+
+	if (unnamed && is_cache &&
+	    fscache_get_cache_maybe(unnamed, fscache_cache_get_acquire))
+		goto use_unnamed_cache;
+
+	if (!name) {
+		list_for_each_entry(cache, &fscache_caches, cache_link) {
+			if (cache->name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_w;
+		}
+	}
+
+	list_add_tail(&candidate->cache_link, &fscache_caches);
+	trace_fscache_cache(candidate->debug_id,
+			    refcount_read(&candidate->ref),
+			    fscache_cache_new_acquire);
+	up_write(&fscache_addremove_sem);
+	return candidate;
+
+got_cache_r:
+	up_read(&fscache_addremove_sem);
+	return cache;
+use_unnamed_cache:
+	cache = unnamed;
+	cache->name = candidate->name;
+	candidate->name = NULL;
+got_cache_w:
+	up_write(&fscache_addremove_sem);
+	kfree(candidate->name);
+	kfree(candidate);
+	return cache;
+}
+
+/**
+ * fscache_acquire_cache - Acquire a cache record for a cache.
+ * @name: The name of the cache.
+ *
+ * Get a cache record for a cache.  If there is a nameless cache record
+ * available, this will acquire that and set its name, directing all the
+ * volumes using it to this cache.
+ */
+struct fscache_cache *fscache_acquire_cache(const char *name)
+{
+	ASSERT(name);
+	return fscache_lookup_cache(name, true);
+}
+EXPORT_SYMBOL(fscache_acquire_cache);
+
+void fscache_put_cache(struct fscache_cache *cache,
+		       enum fscache_cache_trace where)
+{
+	unsigned int debug_id = cache->debug_id;
+	bool zero;
+	int ref;
+
+	if (IS_ERR_OR_NULL(cache))
+		return;
+
+	zero = __refcount_dec_and_test(&cache->ref, &ref);
+	trace_fscache_cache(debug_id, ref - 1, where);
+
+	if (zero) {
+		down_write(&fscache_addremove_sem);
+		list_del_init(&cache->cache_link);
+		up_write(&fscache_addremove_sem);
+		kfree(cache->name);
+		kfree(cache);
+	}
+}
+EXPORT_SYMBOL(fscache_put_cache);
+
+#ifdef CONFIG_PROC_FS
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+
+/*
+ * Generate a list of caches in /proc/fs/fscache/caches
+ */
+static int fscache_caches_seq_show(struct seq_file *m, void *v)
+{
+	struct fscache_cache *cache;
+
+	if (v == &fscache_caches) {
+		seq_puts(m,
+			 "CACHE    REF   VOLS  OBJS  ACCES S NAME\n"
+			 "======== ===== ===== ===== ===== = ===============\n"
+			 );
+		return 0;
+	}
+
+	cache = list_entry(v, struct fscache_cache, cache_link);
+	seq_printf(m,
+		   "%08x %5d %5d %5d %5d %c %s\n",
+		   cache->debug_id,
+		   refcount_read(&cache->ref),
+		   atomic_read(&cache->n_volumes),
+		   atomic_read(&cache->object_count),
+		   atomic_read(&cache->n_accesses),
+		   fscache_cache_states[cache->state],
+		   cache->name ?: "-");
+	return 0;
+}
+
+static void *fscache_caches_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(fscache_addremove_sem)
+{
+	down_read(&fscache_addremove_sem);
+	return seq_list_start_head(&fscache_caches, *_pos);
+}
+
+static void *fscache_caches_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &fscache_caches, _pos);
+}
+
+static void fscache_caches_seq_stop(struct seq_file *m, void *v)
+	__releases(fscache_addremove_sem)
+{
+	up_read(&fscache_addremove_sem);
+}
+
+const struct seq_operations fscache_caches_seq_ops = {
+	.start  = fscache_caches_seq_start,
+	.next   = fscache_caches_seq_next,
+	.stop   = fscache_caches_seq_stop,
+	.show   = fscache_caches_seq_show,
+};
+#endif /* CONFIG_PROC_FS */
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 64767992bd15..8ac81294e43e 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -17,6 +17,14 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
+/*
+ * cache.c
+ */
+#ifdef CONFIG_PROC_FS
+extern const struct seq_operations fscache_caches_seq_ops;
+#endif
+struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache);
+
 /*
  * main.c
  */
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index b28003d7d63f..7400568bf85e 100644
--- a/fs/fscache/proc.c
+++ b/fs/fscache/proc.c
@@ -19,6 +19,10 @@ int __init fscache_proc_init(void)
 	if (!proc_mkdir("fs/fscache", NULL))
 		goto error_dir;
 
+	if (!proc_create_seq("fs/fscache/caches", S_IFREG | 0444, NULL,
+			     &fscache_caches_seq_ops))
+		goto error;
+
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
 				fscache_stats_show))
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index d6910a913918..f6429e5ba6e7 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -16,6 +16,66 @@
 
 #include <linux/fscache.h>
 
+struct fscache_cache;
+enum fscache_cache_trace;
+enum fscache_access_trace;
+
+enum fscache_cache_state {
+	FSCACHE_CACHE_IS_NOT_PRESENT,	/* No cache is present for this name */
+	FSCACHE_CACHE_IS_PREPARING,	/* A cache is preparing to come live */
+	FSCACHE_CACHE_IS_ACTIVE,	/* Attached cache is active and can be used */
+	FSCACHE_CACHE_GOT_IOERROR,	/* Attached cache stopped on I/O error */
+	FSCACHE_CACHE_IS_WITHDRAWN,	/* Attached cache is being withdrawn */
+#define NR__FSCACHE_CACHE_STATE (FSCACHE_CACHE_IS_WITHDRAWN + 1)
+};
+
+/*
+ * Cache cookie.
+ */
+struct fscache_cache {
+	struct list_head	cache_link;	/* Link in cache list */
+	void			*cache_priv;	/* Private cache data (or NULL) */
+	refcount_t		ref;
+	atomic_t		n_volumes;	/* Number of active volumes; */
+	atomic_t		n_accesses;	/* Number of in-progress accesses on the cache */
+	atomic_t		object_count;	/* no. of live objects in this cache */
+	unsigned int		debug_id;
+	enum fscache_cache_state state;
+	char			*name;
+};
+
+static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
+{
+	return smp_load_acquire(&cache->state);
+}
+
+static inline bool fscache_cache_is_live(const struct fscache_cache *cache)
+{
+	return fscache_cache_state(cache) == FSCACHE_CACHE_IS_ACTIVE;
+}
+
+static inline void fscache_set_cache_state(struct fscache_cache *cache,
+					   enum fscache_cache_state new_state)
+{
+	smp_store_release(&cache->state, new_state);
+
+}
+
+static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
+						 enum fscache_cache_state old_state,
+						 enum fscache_cache_state new_state)
+{
+	return try_cmpxchg_release(&cache->state, &old_state, new_state);
+}
+
+/*
+ * out-of-line cache backend functions
+ */
+extern struct rw_semaphore fscache_addremove_sem;
+extern struct fscache_cache *fscache_acquire_cache(const char *name);
+extern void fscache_put_cache(struct fscache_cache *cache,
+			      enum fscache_cache_trace where);
+
 extern struct workqueue_struct *fscache_wq;
 
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index fe214c5cc87f..3263cbf32961 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -19,11 +19,21 @@
 #ifndef __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
+enum fscache_cache_trace {
+	fscache_cache_collision,
+	fscache_cache_get_acquire,
+	fscache_cache_new_acquire,
+};
+
 #endif
 
 /*
  * Declare tracing information enums and their string mappings for display.
  */
+#define fscache_cache_traces						\
+	EM(fscache_cache_collision,		"*COLLIDE*")		\
+	EM(fscache_cache_get_acquire,		"GET acq  ")		\
+	E_(fscache_cache_new_acquire,		"NEW acq  ")
 
 /*
  * Export enum symbols via userspace.
@@ -33,6 +43,8 @@
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+fscache_cache_traces;
+
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
  * will be printed in the output.
@@ -43,6 +55,31 @@
 #define E_(a, b)	{ a, b }
 
 
+TRACE_EVENT(fscache_cache,
+	    TP_PROTO(unsigned int cache_debug_id,
+		     int usage,
+		     enum fscache_cache_trace where),
+
+	    TP_ARGS(cache_debug_id, usage, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cache		)
+		    __field(int,			usage		)
+		    __field(enum fscache_cache_trace,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cache	= cache_debug_id;
+		    __entry->usage	= usage;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("C=%08x %s r=%d",
+		      __entry->cache,
+		      __print_symbolic(__entry->where, fscache_cache_traces),
+		      __entry->usage)
+	    );
+
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


