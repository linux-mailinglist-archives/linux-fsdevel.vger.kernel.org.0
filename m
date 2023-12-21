Return-Path: <linux-fsdevel+bounces-6700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619F81B788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13CF284CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AD77F17;
	Thu, 21 Dec 2023 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eht+OoZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3B77B29
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SA2e+AT0D8Xecdm+5qoAFJ9VHZF0BNy5y5SRdd09T2U=;
	b=eht+OoZQy4jf5JI9dxyUWtekLTxp2gqWpuZaDWsUmXDKkO+PFG3VyJUXy3+LDYXQEvkjup
	oo1VurTzFbssnrSDyukK2NERRm/tOrs4bciHpx9ROhT4gOsv6ctvqU3EFHXekJNaz6/2LU
	1P/yyMx5pu38bstWxI9tfjA9WYYZEpw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-GS-SAE97PsKn0zP5nEL3AA-1; Thu,
 21 Dec 2023 08:24:22 -0500
X-MC-Unique: GS-SAE97PsKn0zP5nEL3AA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F3D21C0652A;
	Thu, 21 Dec 2023 13:24:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA1951D5;
	Thu, 21 Dec 2023 13:24:18 +0000 (UTC)
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
Subject: [PATCH v5 04/40] netfs, fscache: Combine fscache with netfs
Date: Thu, 21 Dec 2023 13:22:59 +0000
Message-ID: <20231221132400.1601991-5-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Now that the fscache code is moved to be colocated with the netfslib code
so that they combined into one module, do the combining.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---

Notes:
    Changes
    =======
    ver #5)
     - Cachefiles needs to depend on NETFS_SUPPORT also now.
     - Change arch defconfigs to have NETFS_SUPPORT=m and FSCACHE=y when
       FSCACHE was m.

 arch/arm/configs/mxs_defconfig        |   3 +-
 arch/csky/configs/defconfig           |   3 +-
 arch/mips/configs/ip27_defconfig      |   3 +-
 arch/mips/configs/lemote2f_defconfig  |   3 +-
 arch/mips/configs/loongson3_defconfig |   3 +-
 arch/mips/configs/pic32mzda_defconfig |   3 +-
 arch/s390/configs/debug_defconfig     |   3 +-
 arch/s390/configs/defconfig           |   3 +-
 arch/sh/configs/sdk7786_defconfig     |   3 +-
 fs/cachefiles/Kconfig                 |   2 +-
 fs/netfs/Kconfig                      |   4 +-
 fs/netfs/Makefile                     |  24 +--
 fs/netfs/fscache_internal.h           | 267 +-------------------------
 fs/netfs/fscache_main.c               |  17 +-
 fs/netfs/internal.h                   | 192 +++++++++++++++++-
 fs/netfs/main.c                       |   4 +-
 fs/nfs/Kconfig                        |   4 +-
 17 files changed, 232 insertions(+), 309 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index feb38a94c1a7..43bc1255a5db 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -138,7 +138,8 @@ CONFIG_PWM_MXS=y
 CONFIG_NVMEM_MXS_OCOTP=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_VFAT_FS=y
diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
index af722e4dfb47..ff559e5162aa 100644
--- a/arch/csky/configs/defconfig
+++ b/arch/csky/configs/defconfig
@@ -34,7 +34,8 @@ CONFIG_GENERIC_PHY=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA=y
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_MSDOS_FS=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index b51f738a39a0..4714074c8bd7 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -287,7 +287,8 @@ CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 38f17b658421..3389e6e885d9 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -238,7 +238,8 @@ CONFIG_BTRFS_FS=m
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=m
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 07839a4b397e..78f498752066 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -356,7 +356,8 @@ CONFIG_QFMT_V2=m
 CONFIG_AUTOFS_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_VIRTIO_FS=m
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
index 166d2ad372d1..54774f90c23e 100644
--- a/arch/mips/configs/pic32mzda_defconfig
+++ b/arch/mips/configs/pic32mzda_defconfig
@@ -68,7 +68,8 @@ CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=m
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index dd0608629310..005cdd3152b9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -635,8 +635,9 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
+CONFIG_NETFS_SUPPORT=m
 CONFIG_NETFS_STATS=y
-CONFIG_FSCACHE=m
+CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 1b8150e50f6a..9d1d1ed62080 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -620,8 +620,9 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_VIRTIO_FS=m
 CONFIG_OVERLAY_FS=m
+CONFIG_NETFS_SUPPORT=m
 CONFIG_NETFS_STATS=y
-CONFIG_FSCACHE=m
+CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index cf59b98446e4..7b427c17fbfe 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -171,7 +171,8 @@ CONFIG_BTRFS_FS=y
 CONFIG_AUTOFS_FS=m
 CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
-CONFIG_FSCACHE=m
+CONFIG_NETFS_SUPPORT=m
+CONFIG_FSCACHE=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 8df715640a48..c5a070550ee3 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -2,7 +2,7 @@
 
 config CACHEFILES
 	tristate "Filesystem caching on files"
-	depends on FSCACHE && BLOCK
+	depends on NETFS_SUPPORT && FSCACHE && BLOCK
 	help
 	  This permits use of a mounted filesystem as a cache for other
 	  filesystems - primarily networking filesystems - thus allowing fast
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


