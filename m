Return-Path: <linux-fsdevel+bounces-5914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6710811651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DA32827AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6C33CDB;
	Wed, 13 Dec 2023 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQgFha+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1BF3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DyGf3YNSow+1Mki9omJNMosAIv6zOkX5qGi/JSZ9vQ=;
	b=BQgFha+cYVe0P+Zec6cyJq+h0vdkc9rt9NSmXNcIm+ZjSBNBQZkZY3BywfHwDUDDIqCDM4
	RHeH07kctHQmGPRebH+1TV3bXo9tgKsQUSZlL4N4cFZ+/aJmMReRVnMrhrnsj8oTDjCg41
	xGBOci7nZ/Nvt31wSBr9YCszENSoJ8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-uKlq7dhxPtW50Ig8cODnlQ-1; Wed, 13 Dec 2023 10:24:05 -0500
X-MC-Unique: uKlq7dhxPtW50Ig8cODnlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80524101A592;
	Wed, 13 Dec 2023 15:24:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32AC740C6EB9;
	Wed, 13 Dec 2023 15:24:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/39] netfs, fscache: Combine fscache with netfs
Date: Wed, 13 Dec 2023 15:23:12 +0000
Message-ID: <20231213152350.431591-3-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Now that the fscache code is moved to be colocated with the netfslib code
so that they combined into one module, do the combining.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---
 fs/netfs/Kconfig            |   4 +-
 fs/netfs/Makefile           |  24 ++--
 fs/netfs/fscache_internal.h | 267 +-----------------------------------
 fs/netfs/fscache_main.c     |  17 +--
 fs/netfs/internal.h         | 192 +++++++++++++++++++++++++-
 fs/netfs/main.c             |   4 +-
 fs/nfs/Kconfig              |   4 +-
 7 files changed, 213 insertions(+), 299 deletions(-)

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index b4378688357c..bec805e0c44c 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -23,8 +23,8 @@ config NETFS_STATS
 	  debugging purposes.  Saying 'Y' here is recommended.
 
 config FSCACHE
-	tristate "General filesystem local caching manager"
-	select NETFS_SUPPORT
+	bool "General filesystem local caching manager"
+	depends on NETFS_SUPPORT
 	help
 	  This option enables a generic filesystem caching manager that can be
 	  used by various network and other filesystems to cache data locally.
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index bbb2b824bd5e..b57162ef9cfb 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,17 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-fscache-y := \
-	fscache_cache.o \
-	fscache_cookie.o \
-	fscache_io.o \
-	fscache_main.o \
-	fscache_volume.o
-
-fscache-$(CONFIG_PROC_FS) += fscache_proc.o
-fscache-$(CONFIG_FSCACHE_STATS) += fscache_stats.o
-
-obj-$(CONFIG_FSCACHE) := fscache.o
-
 netfs-y := \
 	buffered_read.o \
 	io.o \
@@ -21,4 +9,16 @@ netfs-y := \
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
+netfs-$(CONFIG_FSCACHE) += \
+	fscache_cache.o \
+	fscache_cookie.o \
+	fscache_io.o \
+	fscache_main.o \
+	fscache_volume.o
+
+ifeq ($(CONFIG_PROC_FS),y)
+netfs-$(CONFIG_FSCACHE) += fscache_proc.o
+endif
+netfs-$(CONFIG_FSCACHE_STATS) += fscache_stats.o
+
 obj-$(CONFIG_NETFS_SUPPORT) += netfs.o
diff --git a/fs/netfs/fscache_internal.h b/fs/netfs/fscache_internal.h
index 1336f517e9b1..a09b948fcef2 100644
--- a/fs/netfs/fscache_internal.h
+++ b/fs/netfs/fscache_internal.h
@@ -5,273 +5,10 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include "internal.h"
+
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
 
 #define pr_fmt(fmt) "FS-Cache: " fmt
-
-#include <linux/slab.h>
-#include <linux/fscache-cache.h>
-#include <trace/events/fscache.h>
-#include <linux/sched.h>
-#include <linux/seq_file.h>
-
-/*
- * cache.c
- */
-#ifdef CONFIG_PROC_FS
-extern const struct seq_operations fscache_caches_seq_ops;
-#endif
-bool fscache_begin_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
-void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
-struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache);
-void fscache_put_cache(struct fscache_cache *cache, enum fscache_cache_trace where);
-
-static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
-{
-	return smp_load_acquire(&cache->state);
-}
-
-static inline bool fscache_cache_is_live(const struct fscache_cache *cache)
-{
-	return fscache_cache_state(cache) == FSCACHE_CACHE_IS_ACTIVE;
-}
-
-static inline void fscache_set_cache_state(struct fscache_cache *cache,
-					   enum fscache_cache_state new_state)
-{
-	smp_store_release(&cache->state, new_state);
-
-}
-
-static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
-						 enum fscache_cache_state old_state,
-						 enum fscache_cache_state new_state)
-{
-	return try_cmpxchg_release(&cache->state, &old_state, new_state);
-}
-
-/*
- * cookie.c
- */
-extern struct kmem_cache *fscache_cookie_jar;
-#ifdef CONFIG_PROC_FS
-extern const struct seq_operations fscache_cookies_seq_ops;
-#endif
-extern struct timer_list fscache_cookie_lru_timer;
-
-extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
-extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
-					enum fscache_access_trace why);
-
-static inline void fscache_see_cookie(struct fscache_cookie *cookie,
-				      enum fscache_cookie_trace where)
-{
-	trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
-			     where);
-}
-
-/*
- * main.c
- */
-extern unsigned fscache_debug;
-
-extern unsigned int fscache_hash(unsigned int salt, const void *data, size_t len);
-
-/*
- * proc.c
- */
-#ifdef CONFIG_PROC_FS
-extern int __init fscache_proc_init(void);
-extern void fscache_proc_cleanup(void);
-#else
-#define fscache_proc_init()	(0)
-#define fscache_proc_cleanup()	do {} while (0)
-#endif
-
-/*
- * stats.c
- */
-#ifdef CONFIG_FSCACHE_STATS
-extern atomic_t fscache_n_volumes;
-extern atomic_t fscache_n_volumes_collision;
-extern atomic_t fscache_n_volumes_nomem;
-extern atomic_t fscache_n_cookies;
-extern atomic_t fscache_n_cookies_lru;
-extern atomic_t fscache_n_cookies_lru_expired;
-extern atomic_t fscache_n_cookies_lru_removed;
-extern atomic_t fscache_n_cookies_lru_dropped;
-
-extern atomic_t fscache_n_acquires;
-extern atomic_t fscache_n_acquires_ok;
-extern atomic_t fscache_n_acquires_oom;
-
-extern atomic_t fscache_n_invalidates;
-
-extern atomic_t fscache_n_relinquishes;
-extern atomic_t fscache_n_relinquishes_retire;
-extern atomic_t fscache_n_relinquishes_dropped;
-
-extern atomic_t fscache_n_resizes;
-extern atomic_t fscache_n_resizes_null;
-
-static inline void fscache_stat(atomic_t *stat)
-{
-	atomic_inc(stat);
-}
-
-static inline void fscache_stat_d(atomic_t *stat)
-{
-	atomic_dec(stat);
-}
-
-#define __fscache_stat(stat) (stat)
-
-int fscache_stats_show(struct seq_file *m, void *v);
-#else
-
-#define __fscache_stat(stat) (NULL)
-#define fscache_stat(stat) do {} while (0)
-#define fscache_stat_d(stat) do {} while (0)
-#endif
-
-/*
- * volume.c
- */
-#ifdef CONFIG_PROC_FS
-extern const struct seq_operations fscache_volumes_seq_ops;
-#endif
-
-struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
-					  enum fscache_volume_trace where);
-void fscache_put_volume(struct fscache_volume *volume,
-			enum fscache_volume_trace where);
-bool fscache_begin_volume_access(struct fscache_volume *volume,
-				 struct fscache_cookie *cookie,
-				 enum fscache_access_trace why);
-void fscache_create_volume(struct fscache_volume *volume, bool wait);
-
-
-/*****************************************************************************/
-/*
- * debug tracing
- */
-#define dbgprintk(FMT, ...) \
-	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
-
-#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
-#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
-#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
-
-#define kjournal(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
-
-#ifdef __KDEBUG
-#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
-#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
-#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
-
-#elif defined(CONFIG_FSCACHE_DEBUG)
-#define _enter(FMT, ...)			\
-do {						\
-	if (__do_kdebug(ENTER))			\
-		kenter(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#define _leave(FMT, ...)			\
-do {						\
-	if (__do_kdebug(LEAVE))			\
-		kleave(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#define _debug(FMT, ...)			\
-do {						\
-	if (__do_kdebug(DEBUG))			\
-		kdebug(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#else
-#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
-#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
-#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
-#endif
-
-/*
- * determine whether a particular optional debugging point should be logged
- * - we need to go through three steps to persuade cpp to correctly join the
- *   shorthand in FSCACHE_DEBUG_LEVEL with its prefix
- */
-#define ____do_kdebug(LEVEL, POINT) \
-	unlikely((fscache_debug & \
-		  (FSCACHE_POINT_##POINT << (FSCACHE_DEBUG_ ## LEVEL * 3))))
-#define ___do_kdebug(LEVEL, POINT) \
-	____do_kdebug(LEVEL, POINT)
-#define __do_kdebug(POINT) \
-	___do_kdebug(FSCACHE_DEBUG_LEVEL, POINT)
-
-#define FSCACHE_DEBUG_CACHE	0
-#define FSCACHE_DEBUG_COOKIE	1
-#define FSCACHE_DEBUG_OBJECT	2
-#define FSCACHE_DEBUG_OPERATION	3
-
-#define FSCACHE_POINT_ENTER	1
-#define FSCACHE_POINT_LEAVE	2
-#define FSCACHE_POINT_DEBUG	4
-
-#ifndef FSCACHE_DEBUG_LEVEL
-#define FSCACHE_DEBUG_LEVEL CACHE
-#endif
-
-/*
- * assertions
- */
-#if 1 /* defined(__KDEBUGALL) */
-
-#define ASSERT(X)							\
-do {									\
-	if (unlikely(!(X))) {						\
-		pr_err("\n");					\
-		pr_err("Assertion failed\n");	\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTCMP(X, OP, Y)						\
-do {									\
-	if (unlikely(!((X) OP (Y)))) {					\
-		pr_err("\n");					\
-		pr_err("Assertion failed\n");	\
-		pr_err("%lx " #OP " %lx is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIF(C, X)							\
-do {									\
-	if (unlikely((C) && !(X))) {					\
-		pr_err("\n");					\
-		pr_err("Assertion failed\n");	\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIFCMP(C, X, OP, Y)					\
-do {									\
-	if (unlikely((C) && !((X) OP (Y)))) {				\
-		pr_err("\n");					\
-		pr_err("Assertion failed\n");	\
-		pr_err("%lx " #OP " %lx is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#else
-
-#define ASSERT(X)			do {} while (0)
-#define ASSERTCMP(X, OP, Y)		do {} while (0)
-#define ASSERTIF(C, X)			do {} while (0)
-#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
-
-#endif /* assert or not */
diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
index dad85fd84f6f..00600a4d9ce5 100644
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -8,18 +8,9 @@
 #define FSCACHE_DEBUG_LEVEL CACHE
 #include <linux/module.h>
 #include <linux/init.h>
-#define CREATE_TRACE_POINTS
 #include "internal.h"
-
-MODULE_DESCRIPTION("FS Cache Manager");
-MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
-
-unsigned fscache_debug;
-module_param_named(debug, fscache_debug, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_debug,
-		 "FS-Cache debugging mask");
+#define CREATE_TRACE_POINTS
+#include <trace/events/fscache.h>
 
 EXPORT_TRACEPOINT_SYMBOL(fscache_access_cache);
 EXPORT_TRACEPOINT_SYMBOL(fscache_access_volume);
@@ -92,7 +83,7 @@ static int __init fscache_init(void)
 		goto error_cookie_jar;
 	}
 
-	pr_notice("Loaded\n");
+	pr_notice("FS-Cache loaded\n");
 	return 0;
 
 error_cookie_jar:
@@ -115,7 +106,7 @@ static void __exit fscache_exit(void)
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
 	destroy_workqueue(fscache_wq);
-	pr_notice("Unloaded\n");
+	pr_notice("FS-Cache unloaded\n");
 }
 
 module_exit(fscache_exit);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e96432499eb2..43769ac606e8 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -9,8 +9,9 @@
 #include <linux/seq_file.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
+#include <linux/fscache-cache.h>
 #include <trace/events/netfs.h>
-#include "fscache_internal.h"
+#include <trace/events/fscache.h>
 
 #ifdef pr_fmt
 #undef pr_fmt
@@ -106,11 +107,143 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 #endif
 }
 
+/*
+ * fscache-cache.c
+ */
+#ifdef CONFIG_PROC_FS
+extern const struct seq_operations fscache_caches_seq_ops;
+#endif
+bool fscache_begin_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
+void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
+struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache);
+void fscache_put_cache(struct fscache_cache *cache, enum fscache_cache_trace where);
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
+ * fscache-cookie.c
+ */
+extern struct kmem_cache *fscache_cookie_jar;
+#ifdef CONFIG_PROC_FS
+extern const struct seq_operations fscache_cookies_seq_ops;
+#endif
+extern struct timer_list fscache_cookie_lru_timer;
+
+extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
+extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+					enum fscache_access_trace why);
+
+static inline void fscache_see_cookie(struct fscache_cookie *cookie,
+				      enum fscache_cookie_trace where)
+{
+	trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
+			     where);
+}
+
+/*
+ * fscache-main.c
+ */
+extern unsigned int fscache_hash(unsigned int salt, const void *data, size_t len);
+
+/*
+ * fscache-proc.c
+ */
+#ifdef CONFIG_PROC_FS
+extern int __init fscache_proc_init(void);
+extern void fscache_proc_cleanup(void);
+#else
+#define fscache_proc_init()	(0)
+#define fscache_proc_cleanup()	do {} while (0)
+#endif
+
+/*
+ * fscache-stats.c
+ */
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_volumes;
+extern atomic_t fscache_n_volumes_collision;
+extern atomic_t fscache_n_volumes_nomem;
+extern atomic_t fscache_n_cookies;
+extern atomic_t fscache_n_cookies_lru;
+extern atomic_t fscache_n_cookies_lru_expired;
+extern atomic_t fscache_n_cookies_lru_removed;
+extern atomic_t fscache_n_cookies_lru_dropped;
+
+extern atomic_t fscache_n_acquires;
+extern atomic_t fscache_n_acquires_ok;
+extern atomic_t fscache_n_acquires_oom;
+
+extern atomic_t fscache_n_invalidates;
+
+extern atomic_t fscache_n_relinquishes;
+extern atomic_t fscache_n_relinquishes_retire;
+extern atomic_t fscache_n_relinquishes_dropped;
+
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
+
+static inline void fscache_stat(atomic_t *stat)
+{
+	atomic_inc(stat);
+}
+
+static inline void fscache_stat_d(atomic_t *stat)
+{
+	atomic_dec(stat);
+}
+
+#define __fscache_stat(stat) (stat)
+
+int fscache_stats_show(struct seq_file *m, void *v);
+#else
+
+#define __fscache_stat(stat) (NULL)
+#define fscache_stat(stat) do {} while (0)
+#define fscache_stat_d(stat) do {} while (0)
+#endif
+
+/*
+ * fscache-volume.c
+ */
+#ifdef CONFIG_PROC_FS
+extern const struct seq_operations fscache_volumes_seq_ops;
+#endif
+
+struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
+					  enum fscache_volume_trace where);
+void fscache_put_volume(struct fscache_volume *volume,
+			enum fscache_volume_trace where);
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 struct fscache_cookie *cookie,
+				 enum fscache_access_trace why);
+void fscache_create_volume(struct fscache_volume *volume, bool wait);
+
 /*****************************************************************************/
 /*
  * debug tracing
  */
-#if 0
 #define dbgprintk(FMT, ...) \
 	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
 
@@ -147,4 +280,57 @@ do {						\
 #define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
 #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
 #endif
-#endif
+
+/*
+ * assertions
+ */
+#if 1 /* defined(__KDEBUGALL) */
+
+#define ASSERT(X)							\
+do {									\
+	if (unlikely(!(X))) {						\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTCMP(X, OP, Y)						\
+do {									\
+	if (unlikely(!((X) OP (Y)))) {					\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		pr_err("%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIF(C, X)							\
+do {									\
+	if (unlikely((C) && !(X))) {					\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIFCMP(C, X, OP, Y)					\
+do {									\
+	if (unlikely((C) && !((X) OP (Y)))) {				\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		pr_err("%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#else
+
+#define ASSERT(X)			do {} while (0)
+#define ASSERTCMP(X, OP, Y)		do {} while (0)
+#define ASSERTIF(C, X)			do {} while (0)
+#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
+
+#endif /* assert or not */
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 237c54a01d97..1ba8091fcf3e 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -8,8 +8,8 @@
 #include <linux/module.h>
 #include <linux/export.h>
 #include "internal.h"
-//#define CREATE_TRACE_POINTS
-//#include <trace/events/netfs.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/netfs.h>
 
 MODULE_DESCRIPTION("Network fs support");
 MODULE_AUTHOR("Red Hat, Inc.");
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 01ac733a6320..f7e32d76e34d 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -169,8 +169,8 @@ config ROOT_NFS
 
 config NFS_FSCACHE
 	bool "Provide NFS client caching support"
-	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
-	select NETFS_SUPPORT
+	depends on NFS_FS=m && NETFS_SUPPORT || NFS_FS=y && NETFS_SUPPORT=y
+	select FSCACHE
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
 	  the general filesystem cache manager


