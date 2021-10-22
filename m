Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB944437CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhJVTB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhJVTB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acJIyao892WGtpGja184dVbEmLJbyr8Svm5Z/fBfSns=;
        b=Mse9aiAZb62nxq5DjIfXOoUZIuJBv/pvfaT2T+9KTw+gN/G5rtVc2iYAeiWAwwBQKxVOh7
        WEou6TP5N72c6csCyZ3C2JG5YJGaTfLzj+Nt1kk2uBwKXH9moaOtNTd3LZR49LhFNdkoXM
        jxLDEbAFTFVeLM41pbJI0iscRUnbwC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-UDhgtn-iPlK3N3n1U_x5RQ-1; Fri, 22 Oct 2021 14:59:04 -0400
X-MC-Unique: UDhgtn-iPlK3N3n1U_x5RQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8154318D6A2A;
        Fri, 22 Oct 2021 18:59:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1CF25C1A3;
        Fri, 22 Oct 2021 18:58:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 01/53] fscache_old: Move the old fscache driver to one side
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
Date:   Fri, 22 Oct 2021 19:58:54 +0100
Message-ID: <163492913404.1038219.12631331392207857857.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the old fscache driver to fs/fscache_old/ and rename its header files
to match.  This leaves fs/fscache/ free for a rewritten driver.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/9p/cache.h                      |    2 
 fs/Kconfig                         |    2 
 fs/Makefile                        |    2 
 fs/afs/internal.h                  |    2 
 fs/afs/write.c                     |    2 
 fs/cachefiles/internal.h           |    2 
 fs/ceph/super.h                    |    2 
 fs/cifs/fscache.h                  |    2 
 fs/fscache/Kconfig                 |   40 -
 fs/fscache/Makefile                |   20 -
 fs/fscache/cache.c                 |  410 -------------
 fs/fscache/cookie.c                | 1061 ----------------------------------
 fs/fscache/fsdef.c                 |   98 ---
 fs/fscache/internal.h              |  409 -------------
 fs/fscache/io.c                    |  224 -------
 fs/fscache/main.c                  |  230 -------
 fs/fscache/netfs.c                 |   74 --
 fs/fscache/object.c                | 1123 ------------------------------------
 fs/fscache/operation.c             |  633 --------------------
 fs/fscache/page.c                  |  176 ------
 fs/fscache/proc.c                  |   71 --
 fs/fscache/stats.c                 |  226 -------
 fs/fscache_old/Kconfig             |   40 +
 fs/fscache_old/Makefile            |   20 +
 fs/fscache_old/cache.c             |  410 +++++++++++++
 fs/fscache_old/cookie.c            | 1061 ++++++++++++++++++++++++++++++++++
 fs/fscache_old/fsdef.c             |   98 +++
 fs/fscache_old/internal.h          |  409 +++++++++++++
 fs/fscache_old/io.c                |  224 +++++++
 fs/fscache_old/main.c              |  230 +++++++
 fs/fscache_old/netfs.c             |   74 ++
 fs/fscache_old/object.c            | 1123 ++++++++++++++++++++++++++++++++++++
 fs/fscache_old/operation.c         |  633 ++++++++++++++++++++
 fs/fscache_old/page.c              |   92 +++
 fs/fscache_old/proc.c              |   71 ++
 fs/fscache_old/stats.c             |  226 +++++++
 fs/nfs/fscache.h                   |    2 
 include/linux/fscache-cache.h      |  434 --------------
 include/linux/fscache.h            |  645 ---------------------
 include/linux/fscache_old-cache.h  |  434 ++++++++++++++
 include/linux/fscache_old.h        |  645 +++++++++++++++++++++
 include/trace/events/fscache.h     |  523 -----------------
 include/trace/events/fscache_old.h |  523 +++++++++++++++++
 43 files changed, 6322 insertions(+), 6406 deletions(-)
 delete mode 100644 fs/fscache/Kconfig
 delete mode 100644 fs/fscache/Makefile
 delete mode 100644 fs/fscache/cache.c
 delete mode 100644 fs/fscache/cookie.c
 delete mode 100644 fs/fscache/fsdef.c
 delete mode 100644 fs/fscache/internal.h
 delete mode 100644 fs/fscache/io.c
 delete mode 100644 fs/fscache/main.c
 delete mode 100644 fs/fscache/netfs.c
 delete mode 100644 fs/fscache/object.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 delete mode 100644 fs/fscache/proc.c
 delete mode 100644 fs/fscache/stats.c
 create mode 100644 fs/fscache_old/Kconfig
 create mode 100644 fs/fscache_old/Makefile
 create mode 100644 fs/fscache_old/cache.c
 create mode 100644 fs/fscache_old/cookie.c
 create mode 100644 fs/fscache_old/fsdef.c
 create mode 100644 fs/fscache_old/internal.h
 create mode 100644 fs/fscache_old/io.c
 create mode 100644 fs/fscache_old/main.c
 create mode 100644 fs/fscache_old/netfs.c
 create mode 100644 fs/fscache_old/object.c
 create mode 100644 fs/fscache_old/operation.c
 create mode 100644 fs/fscache_old/page.c
 create mode 100644 fs/fscache_old/proc.c
 create mode 100644 fs/fscache_old/stats.c
 delete mode 100644 include/linux/fscache-cache.h
 delete mode 100644 include/linux/fscache.h
 create mode 100644 include/linux/fscache_old-cache.h
 create mode 100644 include/linux/fscache_old.h
 delete mode 100644 include/trace/events/fscache.h
 create mode 100644 include/trace/events/fscache_old.h

diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index cfafa89b972c..b940c5ffd9e3 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -9,7 +9,7 @@
 #define _9P_CACHE_H
 
 #define FSCACHE_USE_NEW_IO_API
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 
 #ifdef CONFIG_9P_FSCACHE
 
diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..966361e471bc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -131,7 +131,7 @@ source "fs/overlayfs/Kconfig"
 menu "Caches"
 
 source "fs/netfs/Kconfig"
-source "fs/fscache/Kconfig"
+source "fs/fscache_old/Kconfig"
 source "fs/cachefiles/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 84c5e4cdfee5..8b87c9406ecc 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
-obj-$(CONFIG_FSCACHE)		+= fscache/
+obj-$(CONFIG_FSCACHE)		+= fscache_old/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
 # We place ext4 before ext2 so that clean ext3 root fs's do NOT mount using the
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0ad97a8fc0d4..a70451bf5b33 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -15,7 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/sched.h>
 #define FSCACHE_USE_NEW_IO_API
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
 #include <linux/mm_types.h>
diff --git a/fs/afs/write.c b/fs/afs/write.c
index f24370f5c774..8e9cb1fcb412 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -12,7 +12,7 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/netfs.h>
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 #include "internal.h"
 
 /*
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index de982f4f513f..7dee24d1c6f2 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -12,7 +12,7 @@
 #define pr_fmt(fmt) "CacheFiles: " fmt
 
 
-#include <linux/fscache-cache.h>
+#include <linux/fscache_old-cache.h>
 #include <linux/timer.h>
 #include <linux/wait_bit.h>
 #include <linux/cred.h>
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a40eb14c282a..b523dc41ff36 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_CEPH_FSCACHE
 #define FSCACHE_USE_NEW_IO_API
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 #endif
 
 /* f_type in struct statfs */
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 081481645b77..704c7354ace1 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -10,7 +10,7 @@
 #define _CIFS_FSCACHE_H
 
 #define FSCACHE_USE_FALLBACK_IO_API
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 
 #include "cifsglob.h"
 
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
deleted file mode 100644
index b313a978ae0a..000000000000
--- a/fs/fscache/Kconfig
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-config FSCACHE
-	tristate "General filesystem local caching manager"
-	select NETFS_SUPPORT
-	help
-	  This option enables a generic filesystem caching manager that can be
-	  used by various network and other filesystems to cache data locally.
-	  Different sorts of caches can be plugged in, depending on the
-	  resources available.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_STATS
-	bool "Gather statistical information on local caching"
-	depends on FSCACHE && PROC_FS
-	select NETFS_STATS
-	help
-	  This option causes statistical information to be gathered on local
-	  caching and exported through file:
-
-		/proc/fs/fscache/stats
-
-	  The gathering of statistics adds a certain amount of overhead to
-	  execution as there are a quite a few stats gathered, and on a
-	  multi-CPU system these may be on cachelines that keep bouncing
-	  between CPUs.  On the other hand, the stats are very useful for
-	  debugging purposes.  Saying 'Y' here is recommended.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_DEBUG
-	bool "Debug FS-Cache"
-	depends on FSCACHE
-	help
-	  This permits debugging to be dynamically enabled in the local caching
-	  management module.  If this is set, the debugging output may be
-	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
deleted file mode 100644
index 03a871d689bb..000000000000
--- a/fs/fscache/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for general filesystem caching code
-#
-
-fscache-y := \
-	cache.o \
-	cookie.o \
-	fsdef.o \
-	io.o \
-	main.o \
-	netfs.o \
-	object.o \
-	operation.o \
-	page.o
-
-fscache-$(CONFIG_PROC_FS) += proc.o
-fscache-$(CONFIG_FSCACHE_STATS) += stats.o
-
-obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
deleted file mode 100644
index cfa60c2faf68..000000000000
--- a/fs/fscache/cache.c
+++ /dev/null
@@ -1,410 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache cache handling
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-LIST_HEAD(fscache_cache_list);
-DECLARE_RWSEM(fscache_addremove_sem);
-DECLARE_WAIT_QUEUE_HEAD(fscache_cache_cleared_wq);
-EXPORT_SYMBOL(fscache_cache_cleared_wq);
-
-static LIST_HEAD(fscache_cache_tag_list);
-
-/*
- * look up a cache tag
- */
-struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
-{
-	struct fscache_cache_tag *tag, *xtag;
-
-	/* firstly check for the existence of the tag under read lock */
-	down_read(&fscache_addremove_sem);
-
-	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
-		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
-			up_read(&fscache_addremove_sem);
-			return tag;
-		}
-	}
-
-	up_read(&fscache_addremove_sem);
-
-	/* the tag does not exist - create a candidate */
-	xtag = kzalloc(sizeof(*xtag) + strlen(name) + 1, GFP_KERNEL);
-	if (!xtag)
-		/* return a dummy tag if out of memory */
-		return ERR_PTR(-ENOMEM);
-
-	atomic_set(&xtag->usage, 1);
-	strcpy(xtag->name, name);
-
-	/* write lock, search again and add if still not present */
-	down_write(&fscache_addremove_sem);
-
-	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
-		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
-			up_write(&fscache_addremove_sem);
-			kfree(xtag);
-			return tag;
-		}
-	}
-
-	list_add_tail(&xtag->link, &fscache_cache_tag_list);
-	up_write(&fscache_addremove_sem);
-	return xtag;
-}
-
-/*
- * release a reference to a cache tag
- */
-void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
-{
-	if (tag != ERR_PTR(-ENOMEM)) {
-		down_write(&fscache_addremove_sem);
-
-		if (atomic_dec_and_test(&tag->usage))
-			list_del_init(&tag->link);
-		else
-			tag = NULL;
-
-		up_write(&fscache_addremove_sem);
-
-		kfree(tag);
-	}
-}
-
-/*
- * select a cache in which to store an object
- * - the cache addremove semaphore must be at least read-locked by the caller
- * - the object will never be an index
- */
-struct fscache_cache *fscache_select_cache_for_object(
-	struct fscache_cookie *cookie)
-{
-	struct fscache_cache_tag *tag;
-	struct fscache_object *object;
-	struct fscache_cache *cache;
-
-	_enter("");
-
-	if (list_empty(&fscache_cache_list)) {
-		_leave(" = NULL [no cache]");
-		return NULL;
-	}
-
-	/* we check the parent to determine the cache to use */
-	spin_lock(&cookie->lock);
-
-	/* the first in the parent's backing list should be the preferred
-	 * cache */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		object = hlist_entry(cookie->backing_objects.first,
-				     struct fscache_object, cookie_link);
-
-		cache = object->cache;
-		if (fscache_object_is_dying(object) ||
-		    test_bit(FSCACHE_IOERROR, &cache->flags))
-			cache = NULL;
-
-		spin_unlock(&cookie->lock);
-		_leave(" = %s [parent]", cache ? cache->tag->name : "NULL");
-		return cache;
-	}
-
-	/* the parent is unbacked */
-	if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		/* cookie not an index and is unbacked */
-		spin_unlock(&cookie->lock);
-		_leave(" = NULL [cookie ub,ni]");
-		return NULL;
-	}
-
-	spin_unlock(&cookie->lock);
-
-	if (!cookie->def->select_cache)
-		goto no_preference;
-
-	/* ask the netfs for its preference */
-	tag = cookie->def->select_cache(cookie->parent->netfs_data,
-					cookie->netfs_data);
-	if (!tag)
-		goto no_preference;
-
-	if (tag == ERR_PTR(-ENOMEM)) {
-		_leave(" = NULL [nomem tag]");
-		return NULL;
-	}
-
-	if (!tag->cache) {
-		_leave(" = NULL [unbacked tag]");
-		return NULL;
-	}
-
-	if (test_bit(FSCACHE_IOERROR, &tag->cache->flags))
-		return NULL;
-
-	_leave(" = %s [specific]", tag->name);
-	return tag->cache;
-
-no_preference:
-	/* netfs has no preference - just select first cache */
-	cache = list_entry(fscache_cache_list.next,
-			   struct fscache_cache, link);
-	_leave(" = %s [first]", cache->tag->name);
-	return cache;
-}
-
-/**
- * fscache_init_cache - Initialise a cache record
- * @cache: The cache record to be initialised
- * @ops: The cache operations to be installed in that record
- * @idfmt: Format string to define identifier
- * @...: sprintf-style arguments
- *
- * Initialise a record of a cache and fill in the name.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-void fscache_init_cache(struct fscache_cache *cache,
-			const struct fscache_cache_ops *ops,
-			const char *idfmt,
-			...)
-{
-	va_list va;
-
-	memset(cache, 0, sizeof(*cache));
-
-	cache->ops = ops;
-
-	va_start(va, idfmt);
-	vsnprintf(cache->identifier, sizeof(cache->identifier), idfmt, va);
-	va_end(va);
-
-	INIT_WORK(&cache->op_gc, fscache_operation_gc);
-	INIT_LIST_HEAD(&cache->link);
-	INIT_LIST_HEAD(&cache->object_list);
-	INIT_LIST_HEAD(&cache->op_gc_list);
-	spin_lock_init(&cache->object_list_lock);
-	spin_lock_init(&cache->op_gc_list_lock);
-}
-EXPORT_SYMBOL(fscache_init_cache);
-
-/**
- * fscache_add_cache - Declare a cache as being open for business
- * @cache: The record describing the cache
- * @ifsdef: The record of the cache object describing the top-level index
- * @tagname: The tag describing this cache
- *
- * Add a cache to the system, making it available for netfs's to use.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-int fscache_add_cache(struct fscache_cache *cache,
-		      struct fscache_object *ifsdef,
-		      const char *tagname)
-{
-	struct fscache_cache_tag *tag;
-
-	ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
-	BUG_ON(!cache->ops);
-	BUG_ON(!ifsdef);
-
-	cache->flags = 0;
-	ifsdef->event_mask =
-		((1 << NR_FSCACHE_OBJECT_EVENTS) - 1) &
-		~(1 << FSCACHE_OBJECT_EV_CLEARED);
-	__set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &ifsdef->flags);
-
-	if (!tagname)
-		tagname = cache->identifier;
-
-	BUG_ON(!tagname[0]);
-
-	_enter("{%s.%s},,%s", cache->ops->name, cache->identifier, tagname);
-
-	/* we use the cache tag to uniquely identify caches */
-	tag = __fscache_lookup_cache_tag(tagname);
-	if (IS_ERR(tag))
-		goto nomem;
-
-	if (test_and_set_bit(FSCACHE_TAG_RESERVED, &tag->flags))
-		goto tag_in_use;
-
-	cache->kobj = kobject_create_and_add(tagname, fscache_root);
-	if (!cache->kobj)
-		goto error;
-
-	ifsdef->cache = cache;
-	cache->fsdef = ifsdef;
-
-	down_write(&fscache_addremove_sem);
-
-	tag->cache = cache;
-	cache->tag = tag;
-
-	/* add the cache to the list */
-	list_add(&cache->link, &fscache_cache_list);
-
-	/* add the cache's netfs definition index object to the cache's
-	 * list */
-	spin_lock(&cache->object_list_lock);
-	list_add_tail(&ifsdef->cache_link, &cache->object_list);
-	spin_unlock(&cache->object_list_lock);
-
-	/* add the cache's netfs definition index object to the top level index
-	 * cookie as a known backing object */
-	spin_lock(&fscache_fsdef_index.lock);
-
-	hlist_add_head(&ifsdef->cookie_link,
-		       &fscache_fsdef_index.backing_objects);
-
-	refcount_inc(&fscache_fsdef_index.ref);
-
-	/* done */
-	spin_unlock(&fscache_fsdef_index.lock);
-	up_write(&fscache_addremove_sem);
-
-	pr_notice("Cache \"%s\" added (type %s)\n",
-		  cache->tag->name, cache->ops->name);
-	kobject_uevent(cache->kobj, KOBJ_ADD);
-
-	_leave(" = 0 [%s]", cache->identifier);
-	return 0;
-
-tag_in_use:
-	pr_err("Cache tag '%s' already in use\n", tagname);
-	__fscache_release_cache_tag(tag);
-	_leave(" = -EXIST");
-	return -EEXIST;
-
-error:
-	__fscache_release_cache_tag(tag);
-	_leave(" = -EINVAL");
-	return -EINVAL;
-
-nomem:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-EXPORT_SYMBOL(fscache_add_cache);
-
-/**
- * fscache_io_error - Note a cache I/O error
- * @cache: The record describing the cache
- *
- * Note that an I/O error occurred in a cache and that it should no longer be
- * used for anything.  This also reports the error into the kernel log.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-void fscache_io_error(struct fscache_cache *cache)
-{
-	if (!test_and_set_bit(FSCACHE_IOERROR, &cache->flags))
-		pr_err("Cache '%s' stopped due to I/O error\n",
-		       cache->ops->name);
-}
-EXPORT_SYMBOL(fscache_io_error);
-
-/*
- * request withdrawal of all the objects in a cache
- * - all the objects being withdrawn are moved onto the supplied list
- */
-static void fscache_withdraw_all_objects(struct fscache_cache *cache,
-					 struct list_head *dying_objects)
-{
-	struct fscache_object *object;
-
-	while (!list_empty(&cache->object_list)) {
-		spin_lock(&cache->object_list_lock);
-
-		if (!list_empty(&cache->object_list)) {
-			object = list_entry(cache->object_list.next,
-					    struct fscache_object, cache_link);
-			list_move_tail(&object->cache_link, dying_objects);
-
-			_debug("withdraw %x", object->cookie->debug_id);
-
-			/* This must be done under object_list_lock to prevent
-			 * a race with fscache_drop_object().
-			 */
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
-		}
-
-		spin_unlock(&cache->object_list_lock);
-		cond_resched();
-	}
-}
-
-/**
- * fscache_withdraw_cache - Withdraw a cache from the active service
- * @cache: The record describing the cache
- *
- * Withdraw a cache from service, unbinding all its cache objects from the
- * netfs cookies they're currently representing.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-void fscache_withdraw_cache(struct fscache_cache *cache)
-{
-	LIST_HEAD(dying_objects);
-
-	_enter("");
-
-	pr_notice("Withdrawing cache \"%s\"\n",
-		  cache->tag->name);
-
-	/* make the cache unavailable for cookie acquisition */
-	if (test_and_set_bit(FSCACHE_CACHE_WITHDRAWN, &cache->flags))
-		BUG();
-
-	down_write(&fscache_addremove_sem);
-	list_del_init(&cache->link);
-	cache->tag->cache = NULL;
-	up_write(&fscache_addremove_sem);
-
-	/* make sure all pages pinned by operations on behalf of the netfs are
-	 * written to disk */
-	fscache_stat(&fscache_n_cop_sync_cache);
-	cache->ops->sync_cache(cache);
-	fscache_stat_d(&fscache_n_cop_sync_cache);
-
-	/* we now have to destroy all the active objects pertaining to this
-	 * cache - which we do by passing them off to thread pool to be
-	 * disposed of */
-	_debug("destroy");
-
-	fscache_withdraw_all_objects(cache, &dying_objects);
-
-	/* wait for all extant objects to finish their outstanding operations
-	 * and go away */
-	_debug("wait for finish");
-	wait_event(fscache_cache_cleared_wq,
-		   atomic_read(&cache->object_count) == 0);
-	_debug("wait for clearance");
-	wait_event(fscache_cache_cleared_wq,
-		   list_empty(&cache->object_list));
-	_debug("cleared");
-	ASSERT(list_empty(&dying_objects));
-
-	kobject_put(cache->kobj);
-
-	clear_bit(FSCACHE_TAG_RESERVED, &cache->tag->flags);
-	fscache_release_cache_tag(cache->tag);
-	cache->tag = NULL;
-
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_withdraw_cache);
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
deleted file mode 100644
index 8a850c3d0775..000000000000
--- a/fs/fscache/cookie.c
+++ /dev/null
@@ -1,1061 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* netfs cookie management
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See Documentation/filesystems/caching/netfs-api.rst for more information on
- * the netfs API.
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-struct kmem_cache *fscache_cookie_jar;
-
-static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
-
-#define fscache_cookie_hash_shift 15
-static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
-static LIST_HEAD(fscache_cookies);
-static DEFINE_RWLOCK(fscache_cookies_lock);
-
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
-					    loff_t object_size);
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie);
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object);
-
-static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-{
-	struct fscache_object *object;
-	struct hlist_node *o;
-	const u8 *k;
-	unsigned loop;
-
-	pr_err("%c-cookie c=%08x [p=%08x fl=%lx nc=%u na=%u]\n",
-	       prefix,
-	       cookie->debug_id,
-	       cookie->parent ? cookie->parent->debug_id : 0,
-	       cookie->flags,
-	       atomic_read(&cookie->n_children),
-	       atomic_read(&cookie->n_active));
-	pr_err("%c-cookie d=%p{%s} n=%p\n",
-	       prefix,
-	       cookie->def,
-	       cookie->def ? cookie->def->name : "?",
-	       cookie->netfs_data);
-
-	o = READ_ONCE(cookie->backing_objects.first);
-	if (o) {
-		object = hlist_entry(o, struct fscache_object, cookie_link);
-		pr_err("%c-cookie o=%u\n", prefix, object->debug_id);
-	}
-
-	pr_err("%c-key=[%u] '", prefix, cookie->key_len);
-	k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
-		cookie->inline_key : cookie->key;
-	for (loop = 0; loop < cookie->key_len; loop++)
-		pr_cont("%02x", k[loop]);
-	pr_cont("'\n");
-}
-
-void fscache_free_cookie(struct fscache_cookie *cookie)
-{
-	if (cookie) {
-		BUG_ON(!hlist_empty(&cookie->backing_objects));
-		write_lock(&fscache_cookies_lock);
-		list_del(&cookie->proc_link);
-		write_unlock(&fscache_cookies_lock);
-		if (cookie->aux_len > sizeof(cookie->inline_aux))
-			kfree(cookie->aux);
-		if (cookie->key_len > sizeof(cookie->inline_key))
-			kfree(cookie->key);
-		kmem_cache_free(fscache_cookie_jar, cookie);
-	}
-}
-
-/*
- * Set the index key in a cookie.  The cookie struct has space for a 16-byte
- * key plus length and hash, but if that's not big enough, it's instead a
- * pointer to a buffer containing 3 bytes of hash, 1 byte of length and then
- * the key data.
- */
-static int fscache_set_key(struct fscache_cookie *cookie,
-			   const void *index_key, size_t index_key_len)
-{
-	u32 *buf;
-	int bufs;
-
-	bufs = DIV_ROUND_UP(index_key_len, sizeof(*buf));
-
-	if (index_key_len > sizeof(cookie->inline_key)) {
-		buf = kcalloc(bufs, sizeof(*buf), GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-		cookie->key = buf;
-	} else {
-		buf = (u32 *)cookie->inline_key;
-	}
-
-	memcpy(buf, index_key, index_key_len);
-	cookie->key_hash = fscache_hash(0, buf, bufs);
-	return 0;
-}
-
-static long fscache_compare_cookie(const struct fscache_cookie *a,
-				   const struct fscache_cookie *b)
-{
-	const void *ka, *kb;
-
-	if (a->key_hash != b->key_hash)
-		return (long)a->key_hash - (long)b->key_hash;
-	if (a->parent != b->parent)
-		return (long)a->parent - (long)b->parent;
-	if (a->key_len != b->key_len)
-		return (long)a->key_len - (long)b->key_len;
-	if (a->type != b->type)
-		return (long)a->type - (long)b->type;
-
-	if (a->key_len <= sizeof(a->inline_key)) {
-		ka = &a->inline_key;
-		kb = &b->inline_key;
-	} else {
-		ka = a->key;
-		kb = b->key;
-	}
-	return memcmp(ka, kb, a->key_len);
-}
-
-static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
-
-/*
- * Allocate a cookie.
- */
-struct fscache_cookie *fscache_alloc_cookie(
-	struct fscache_cookie *parent,
-	const struct fscache_cookie_def *def,
-	const void *index_key, size_t index_key_len,
-	const void *aux_data, size_t aux_data_len,
-	void *netfs_data,
-	loff_t object_size)
-{
-	struct fscache_cookie *cookie;
-
-	/* allocate and initialise a cookie */
-	cookie = kmem_cache_zalloc(fscache_cookie_jar, GFP_KERNEL);
-	if (!cookie)
-		return NULL;
-
-	cookie->key_len = index_key_len;
-	cookie->aux_len = aux_data_len;
-
-	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
-		goto nomem;
-
-	if (cookie->aux_len <= sizeof(cookie->inline_aux)) {
-		memcpy(cookie->inline_aux, aux_data, cookie->aux_len);
-	} else {
-		cookie->aux = kmemdup(aux_data, cookie->aux_len, GFP_KERNEL);
-		if (!cookie->aux)
-			goto nomem;
-	}
-
-	refcount_set(&cookie->ref, 1);
-	atomic_set(&cookie->n_children, 0);
-	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
-
-	/* We keep the active count elevated until relinquishment to prevent an
-	 * attempt to wake up every time the object operations queue quiesces.
-	 */
-	atomic_set(&cookie->n_active, 1);
-
-	cookie->def		= def;
-	cookie->parent		= parent;
-	cookie->netfs_data	= netfs_data;
-	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
-	cookie->type		= def->type;
-	spin_lock_init(&cookie->lock);
-	INIT_HLIST_HEAD(&cookie->backing_objects);
-
-	write_lock(&fscache_cookies_lock);
-	list_add_tail(&cookie->proc_link, &fscache_cookies);
-	write_unlock(&fscache_cookies_lock);
-	return cookie;
-
-nomem:
-	fscache_free_cookie(cookie);
-	return NULL;
-}
-
-/*
- * Attempt to insert the new cookie into the hash.  If there's a collision, we
- * return the old cookie if it's not in use and an error otherwise.
- */
-struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
-{
-	struct fscache_cookie *cursor;
-	struct hlist_bl_head *h;
-	struct hlist_bl_node *p;
-	unsigned int bucket;
-
-	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
-	h = &fscache_cookie_hash[bucket];
-
-	hlist_bl_lock(h);
-	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
-		if (fscache_compare_cookie(candidate, cursor) == 0)
-			goto collision;
-	}
-
-	__set_bit(FSCACHE_COOKIE_ACQUIRED, &candidate->flags);
-	fscache_cookie_get(candidate->parent, fscache_cookie_get_acquire_parent);
-	atomic_inc(&candidate->parent->n_children);
-	hlist_bl_add_head(&candidate->hash_link, h);
-	hlist_bl_unlock(h);
-	return candidate;
-
-collision:
-	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
-		trace_fscache_cookie(cursor->debug_id, refcount_read(&cursor->ref),
-				     fscache_cookie_collision);
-		pr_err("Duplicate cookie detected\n");
-		fscache_print_cookie(cursor, 'O');
-		fscache_print_cookie(candidate, 'N');
-		hlist_bl_unlock(h);
-		return NULL;
-	}
-
-	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
-	hlist_bl_unlock(h);
-	return cursor;
-}
-
-/*
- * request a cookie to represent an object (index, datafile, xattr, etc)
- * - parent specifies the parent object
- *   - the top level index cookie for each netfs is stored in the fscache_netfs
- *     struct upon registration
- * - def points to the definition
- * - the netfs_data will be passed to the functions pointed to in *def
- * - all attached caches will be searched to see if they contain this object
- * - index objects aren't stored on disk until there's a dependent file that
- *   needs storing
- * - other objects are stored in a selected cache immediately, and all the
- *   indices forming the path to it are instantiated if necessary
- * - we never let on to the netfs about errors
- *   - we may set a negative cookie pointer, but that's okay
- */
-struct fscache_cookie *__fscache_acquire_cookie(
-	struct fscache_cookie *parent,
-	const struct fscache_cookie_def *def,
-	const void *index_key, size_t index_key_len,
-	const void *aux_data, size_t aux_data_len,
-	void *netfs_data,
-	loff_t object_size,
-	bool enable)
-{
-	struct fscache_cookie *candidate, *cookie;
-
-	BUG_ON(!def);
-
-	_enter("{%s},{%s},%p,%u",
-	       parent ? (char *) parent->def->name : "<no-parent>",
-	       def->name, netfs_data, enable);
-
-	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
-		return NULL;
-	if (!aux_data || !aux_data_len) {
-		aux_data = NULL;
-		aux_data_len = 0;
-	}
-
-	fscache_stat(&fscache_n_acquires);
-
-	/* if there's no parent cookie, then we don't create one here either */
-	if (!parent) {
-		fscache_stat(&fscache_n_acquires_null);
-		_leave(" [no parent]");
-		return NULL;
-	}
-
-	/* validate the definition */
-	BUG_ON(!def->name[0]);
-
-	BUG_ON(def->type == FSCACHE_COOKIE_TYPE_INDEX &&
-	       parent->type != FSCACHE_COOKIE_TYPE_INDEX);
-
-	candidate = fscache_alloc_cookie(parent, def,
-					 index_key, index_key_len,
-					 aux_data, aux_data_len,
-					 netfs_data, object_size);
-	if (!candidate) {
-		fscache_stat(&fscache_n_acquires_oom);
-		_leave(" [ENOMEM]");
-		return NULL;
-	}
-
-	cookie = fscache_hash_cookie(candidate);
-	if (!cookie) {
-		trace_fscache_cookie(candidate->debug_id, 1,
-				     fscache_cookie_discard);
-		goto out;
-	}
-
-	if (cookie == candidate)
-		candidate = NULL;
-
-	switch (cookie->type) {
-	case FSCACHE_COOKIE_TYPE_INDEX:
-		fscache_stat(&fscache_n_cookie_index);
-		break;
-	case FSCACHE_COOKIE_TYPE_DATAFILE:
-		fscache_stat(&fscache_n_cookie_data);
-		break;
-	default:
-		fscache_stat(&fscache_n_cookie_special);
-		break;
-	}
-
-	trace_fscache_acquire(cookie);
-
-	if (enable) {
-		/* if the object is an index then we need do nothing more here
-		 * - we create indices on disk when we need them as an index
-		 * may exist in multiple caches */
-		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-			if (fscache_acquire_non_index_cookie(cookie, object_size) == 0) {
-				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-			} else {
-				atomic_dec(&parent->n_children);
-				fscache_cookie_put(cookie,
-						   fscache_cookie_put_acquire_nobufs);
-				fscache_stat(&fscache_n_acquires_nobufs);
-				_leave(" = NULL");
-				return NULL;
-			}
-		} else {
-			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-		}
-	}
-
-	fscache_stat(&fscache_n_acquires_ok);
-
-out:
-	fscache_free_cookie(candidate);
-	return cookie;
-}
-EXPORT_SYMBOL(__fscache_acquire_cookie);
-
-/*
- * Enable a cookie to permit it to accept new operations.
- */
-void __fscache_enable_cookie(struct fscache_cookie *cookie,
-			     const void *aux_data,
-			     loff_t object_size,
-			     bool (*can_enable)(void *data),
-			     void *data)
-{
-	_enter("%x", cookie->debug_id);
-
-	trace_fscache_enable(cookie);
-
-	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
-			 TASK_UNINTERRUPTIBLE);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-		goto out_unlock;
-
-	if (can_enable && !can_enable(data)) {
-		/* The netfs decided it didn't want to enable after all */
-	} else if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		/* Wait for outstanding disablement to complete */
-		__fscache_wait_on_invalidate(cookie);
-
-		if (fscache_acquire_non_index_cookie(cookie, object_size) == 0)
-			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-	} else {
-		set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-	}
-
-out_unlock:
-	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
-}
-EXPORT_SYMBOL(__fscache_enable_cookie);
-
-/*
- * acquire a non-index cookie
- * - this must make sure the index chain is instantiated and instantiate the
- *   object representation too
- */
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
-					    loff_t object_size)
-{
-	struct fscache_object *object;
-	struct fscache_cache *cache;
-	int ret;
-
-	_enter("");
-
-	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-	/* now we need to see whether the backing objects for this cookie yet
-	 * exist, if not there'll be nothing to search */
-	down_read(&fscache_addremove_sem);
-
-	if (list_empty(&fscache_cache_list)) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = 0 [no caches]");
-		return 0;
-	}
-
-	/* select a cache in which to store the object */
-	cache = fscache_select_cache_for_object(cookie->parent);
-	if (!cache) {
-		up_read(&fscache_addremove_sem);
-		fscache_stat(&fscache_n_acquires_no_cache);
-		_leave(" = -ENOMEDIUM [no cache]");
-		return -ENOMEDIUM;
-	}
-
-	_debug("cache %s", cache->tag->name);
-
-	set_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-
-	/* ask the cache to allocate objects for this cookie and its parent
-	 * chain */
-	ret = fscache_alloc_object(cache, cookie);
-	if (ret < 0) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = %d", ret);
-		return ret;
-	}
-
-	spin_lock(&cookie->lock);
-	if (hlist_empty(&cookie->backing_objects)) {
-		spin_unlock(&cookie->lock);
-		goto unavailable;
-	}
-
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	fscache_set_store_limit(object, object_size);
-
-	/* initiate the process of looking up all the objects in the chain
-	 * (done by fscache_initialise_object()) */
-	fscache_raise_event(object, FSCACHE_OBJECT_EV_NEW_CHILD);
-
-	spin_unlock(&cookie->lock);
-
-	/* we may be required to wait for lookup to complete at this point */
-	if (!fscache_defer_lookup) {
-		wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
-			    TASK_UNINTERRUPTIBLE);
-		if (test_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags))
-			goto unavailable;
-	}
-
-	up_read(&fscache_addremove_sem);
-	_leave(" = 0 [deferred]");
-	return 0;
-
-unavailable:
-	up_read(&fscache_addremove_sem);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-
-/*
- * recursively allocate cache object records for a cookie/cache combination
- * - caller must be holding the addremove sem
- */
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie)
-{
-	struct fscache_object *object;
-	int ret;
-
-	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->def->name);
-
-	spin_lock(&cookie->lock);
-	hlist_for_each_entry(object, &cookie->backing_objects,
-			     cookie_link) {
-		if (object->cache == cache)
-			goto object_already_extant;
-	}
-	spin_unlock(&cookie->lock);
-
-	/* ask the cache to allocate an object (we may end up with duplicate
-	 * objects at this stage, but we sort that out later) */
-	fscache_stat(&fscache_n_cop_alloc_object);
-	object = cache->ops->alloc_object(cache, cookie);
-	fscache_stat_d(&fscache_n_cop_alloc_object);
-	if (IS_ERR(object)) {
-		fscache_stat(&fscache_n_object_no_alloc);
-		ret = PTR_ERR(object);
-		goto error;
-	}
-
-	ASSERTCMP(object->cookie, ==, cookie);
-	fscache_stat(&fscache_n_object_alloc);
-
-	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
-
-	_debug("ALLOC OBJ%x: %s {%lx}",
-	       object->debug_id, cookie->def->name, object->events);
-
-	ret = fscache_alloc_object(cache, cookie->parent);
-	if (ret < 0)
-		goto error_put;
-
-	/* only attach if we managed to allocate all we needed, otherwise
-	 * discard the object we just allocated and instead use the one
-	 * attached to the cookie */
-	if (fscache_attach_object(cookie, object) < 0) {
-		fscache_stat(&fscache_n_cop_put_object);
-		cache->ops->put_object(object, fscache_obj_put_attach_fail);
-		fscache_stat_d(&fscache_n_cop_put_object);
-	}
-
-	_leave(" = 0");
-	return 0;
-
-object_already_extant:
-	ret = -ENOBUFS;
-	if (fscache_object_is_dying(object) ||
-	    fscache_cache_is_broken(object)) {
-		spin_unlock(&cookie->lock);
-		goto error;
-	}
-	spin_unlock(&cookie->lock);
-	_leave(" = 0 [found]");
-	return 0;
-
-error_put:
-	fscache_stat(&fscache_n_cop_put_object);
-	cache->ops->put_object(object, fscache_obj_put_alloc_fail);
-	fscache_stat_d(&fscache_n_cop_put_object);
-error:
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * attach a cache object to a cookie
- */
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object)
-{
-	struct fscache_object *p;
-	struct fscache_cache *cache = object->cache;
-	int ret;
-
-	_enter("{%s},{OBJ%x}", cookie->def->name, object->debug_id);
-
-	ASSERTCMP(object->cookie, ==, cookie);
-
-	spin_lock(&cookie->lock);
-
-	/* there may be multiple initial creations of this object, but we only
-	 * want one */
-	ret = -EEXIST;
-	hlist_for_each_entry(p, &cookie->backing_objects, cookie_link) {
-		if (p->cache == object->cache) {
-			if (fscache_object_is_dying(p))
-				ret = -ENOBUFS;
-			goto cant_attach_object;
-		}
-	}
-
-	/* pin the parent object */
-	spin_lock_nested(&cookie->parent->lock, 1);
-	hlist_for_each_entry(p, &cookie->parent->backing_objects,
-			     cookie_link) {
-		if (p->cache == object->cache) {
-			if (fscache_object_is_dying(p)) {
-				ret = -ENOBUFS;
-				spin_unlock(&cookie->parent->lock);
-				goto cant_attach_object;
-			}
-			object->parent = p;
-			spin_lock(&p->lock);
-			p->n_children++;
-			spin_unlock(&p->lock);
-			break;
-		}
-	}
-	spin_unlock(&cookie->parent->lock);
-
-	/* attach to the cache's object list */
-	if (list_empty(&object->cache_link)) {
-		spin_lock(&cache->object_list_lock);
-		list_add(&object->cache_link, &cache->object_list);
-		spin_unlock(&cache->object_list_lock);
-	}
-
-	/* Attach to the cookie.  The object already has a ref on it. */
-	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
-	ret = 0;
-
-cant_attach_object:
-	spin_unlock(&cookie->lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * Invalidate an object.  Callable with spinlocks held.
- */
-void __fscache_invalidate(struct fscache_cookie *cookie)
-{
-	struct fscache_object *object;
-
-	_enter("{%s}", cookie->def->name);
-
-	fscache_stat(&fscache_n_invalidates);
-
-	/* Only permit invalidation of data files.  Invalidating an index will
-	 * require the caller to release all its attachments to the tree rooted
-	 * there, and if it's doing that, it may as well just retire the
-	 * cookie.
-	 */
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
-
-	/* If there's an object, we tell the object state machine to handle the
-	 * invalidation on our behalf, otherwise there's nothing to do.
-	 */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		spin_lock(&cookie->lock);
-
-		if (fscache_cookie_enabled(cookie) &&
-		    !hlist_empty(&cookie->backing_objects) &&
-		    !test_and_set_bit(FSCACHE_COOKIE_INVALIDATING,
-				      &cookie->flags)) {
-			object = hlist_entry(cookie->backing_objects.first,
-					     struct fscache_object,
-					     cookie_link);
-			if (fscache_object_is_live(object))
-				fscache_raise_event(
-					object, FSCACHE_OBJECT_EV_INVALIDATE);
-		}
-
-		spin_unlock(&cookie->lock);
-	}
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_invalidate);
-
-/*
- * Wait for object invalidation to complete.
- */
-void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	_enter("%x", cookie->debug_id);
-
-	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
-		    TASK_UNINTERRUPTIBLE);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_wait_on_invalidate);
-
-/*
- * update the index entries backing a cookie
- */
-void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
-{
-	struct fscache_object *object;
-
-	fscache_stat(&fscache_n_updates);
-
-	if (!cookie) {
-		fscache_stat(&fscache_n_updates_null);
-		_leave(" [no cookie]");
-		return;
-	}
-
-	_enter("{%s}", cookie->def->name);
-
-	spin_lock(&cookie->lock);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (fscache_cookie_enabled(cookie)) {
-		/* update the index entry on disk in each cache backing this
-		 * cookie.
-		 */
-		hlist_for_each_entry(object,
-				     &cookie->backing_objects, cookie_link) {
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_UPDATE);
-		}
-	}
-
-	spin_unlock(&cookie->lock);
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_update_cookie);
-
-/*
- * Disable a cookie to stop it from accepting new requests from the netfs.
- */
-void __fscache_disable_cookie(struct fscache_cookie *cookie,
-			      const void *aux_data,
-			      bool invalidate)
-{
-	struct fscache_object *object;
-	bool awaken = false;
-
-	_enter("%x,%u", cookie->debug_id, invalidate);
-
-	trace_fscache_disable(cookie);
-
-	ASSERTCMP(atomic_read(&cookie->n_active), >, 0);
-
-	if (atomic_read(&cookie->n_children) != 0) {
-		pr_err("Cookie '%s' still has children\n",
-		       cookie->def->name);
-		BUG();
-	}
-
-	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
-			 TASK_UNINTERRUPTIBLE);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (!test_and_clear_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-		goto out_unlock_enable;
-
-	/* If the cookie is being invalidated, wait for that to complete first
-	 * so that we can reuse the flag.
-	 */
-	__fscache_wait_on_invalidate(cookie);
-
-	/* Dispose of the backing objects */
-	set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags);
-
-	spin_lock(&cookie->lock);
-	if (!hlist_empty(&cookie->backing_objects)) {
-		hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
-			if (invalidate)
-				set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
-			clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
-		}
-	} else {
-		if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-			awaken = true;
-	}
-	spin_unlock(&cookie->lock);
-	if (awaken)
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-
-	/* Wait for cessation of activity requiring access to the netfs (when
-	 * n_active reaches 0).  This makes sure outstanding reads and writes
-	 * have completed.
-	 */
-	if (!atomic_dec_and_test(&cookie->n_active)) {
-		wait_var_event(&cookie->n_active,
-			       !atomic_read(&cookie->n_active));
-	}
-
-	/* Reset the cookie state if it wasn't relinquished */
-	if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags)) {
-		atomic_inc(&cookie->n_active);
-		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-	}
-
-out_unlock_enable:
-	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_disable_cookie);
-
-/*
- * release a cookie back to the cache
- * - the object will be marked as recyclable on disk if retire is true
- * - all dependents of this cookie must have already been unregistered
- *   (indices/files/pages)
- */
-void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
-				 const void *aux_data,
-				 bool retire)
-{
-	fscache_stat(&fscache_n_relinquishes);
-	if (retire)
-		fscache_stat(&fscache_n_relinquishes_retire);
-
-	if (!cookie) {
-		fscache_stat(&fscache_n_relinquishes_null);
-		_leave(" [no cookie]");
-		return;
-	}
-
-	_enter("%x{%s,%d},%d",
-	       cookie->debug_id, cookie->def->name,
-	       atomic_read(&cookie->n_active), retire);
-
-	trace_fscache_relinquish(cookie, retire);
-
-	/* No further netfs-accessing operations on this cookie permitted */
-	if (test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags))
-		BUG();
-
-	__fscache_disable_cookie(cookie, aux_data, retire);
-
-	/* Clear pointers back to the netfs */
-	cookie->netfs_data	= NULL;
-	cookie->def		= NULL;
-
-	if (cookie->parent) {
-		ASSERTCMP(refcount_read(&cookie->parent->ref), >, 0);
-		ASSERTCMP(atomic_read(&cookie->parent->n_children), >, 0);
-		atomic_dec(&cookie->parent->n_children);
-	}
-
-	/* Dispose of the netfs's link to the cookie */
-	fscache_cookie_put(cookie, fscache_cookie_put_relinquish);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_relinquish_cookie);
-
-/*
- * Remove a cookie from the hash table.
- */
-static void fscache_unhash_cookie(struct fscache_cookie *cookie)
-{
-	struct hlist_bl_head *h;
-	unsigned int bucket;
-
-	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
-	h = &fscache_cookie_hash[bucket];
-
-	hlist_bl_lock(h);
-	hlist_bl_del(&cookie->hash_link);
-	hlist_bl_unlock(h);
-}
-
-/*
- * Drop a reference to a cookie.
- */
-void fscache_cookie_put(struct fscache_cookie *cookie,
-			enum fscache_cookie_trace where)
-{
-	struct fscache_cookie *parent;
-	int ref;
-
-	_enter("%x", cookie->debug_id);
-
-	do {
-		unsigned int cookie_debug_id = cookie->debug_id;
-		bool zero = __refcount_dec_and_test(&cookie->ref, &ref);
-
-		trace_fscache_cookie(cookie_debug_id, ref - 1, where);
-		if (!zero)
-			return;
-
-		parent = cookie->parent;
-		fscache_unhash_cookie(cookie);
-		fscache_free_cookie(cookie);
-
-		cookie = parent;
-		where = fscache_cookie_put_parent;
-	} while (cookie);
-
-	_leave("");
-}
-
-/*
- * Get a reference to a cookie.
- */
-struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
-					  enum fscache_cookie_trace where)
-{
-	int ref;
-
-	__refcount_inc(&cookie->ref, &ref);
-	trace_fscache_cookie(cookie->debug_id, ref + 1, where);
-	return cookie;
-}
-
-/*
- * check the consistency between the netfs inode and the backing cache
- *
- * NOTE: it only serves no-index type
- */
-int __fscache_check_consistency(struct fscache_cookie *cookie,
-				const void *aux_data)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("%p,", cookie);
-
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	if (hlist_empty(&cookie->backing_objects))
-		return 0;
-
-	op = kzalloc(sizeof(*op), GFP_NOIO | __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!op)
-		return -ENOMEM;
-
-	fscache_operation_init(cookie, op, NULL, NULL, NULL);
-	op->flags = FSCACHE_OP_MYTHREAD |
-		(1 << FSCACHE_OP_WAITING) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_check_consistency);
-
-	spin_lock(&cookie->lock);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto inconsistent;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-	if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
-		goto inconsistent;
-
-	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_op(object, op) < 0)
-		goto submit_failed;
-
-	/* the work queue now carries its own ref on the object */
-	spin_unlock(&cookie->lock);
-
-	ret = fscache_wait_for_operation_activation(object, op, NULL, NULL);
-	if (ret == 0) {
-		/* ask the cache to honour the operation */
-		ret = object->cache->ops->check_consistency(op);
-		fscache_op_complete(op, false);
-	} else if (ret == -ENOBUFS) {
-		ret = 0;
-	}
-
-	fscache_put_operation(op);
-	_leave(" = %d", ret);
-	return ret;
-
-submit_failed:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-inconsistent:
-	spin_unlock(&cookie->lock);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	kfree(op);
-	_leave(" = -ESTALE");
-	return -ESTALE;
-}
-EXPORT_SYMBOL(__fscache_check_consistency);
-
-/*
- * Generate a list of extant cookies in /proc/fs/fscache/cookies
- */
-static int fscache_cookies_seq_show(struct seq_file *m, void *v)
-{
-	struct fscache_cookie *cookie;
-	unsigned int keylen = 0, auxlen = 0;
-	char _type[3], *type;
-	u8 *p;
-
-	if (v == &fscache_cookies) {
-		seq_puts(m,
-			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF              NETFS_DATA\n"
-			 "======== ======== ===== ===== === == === ================ ==========\n"
-			 );
-		return 0;
-	}
-
-	cookie = list_entry(v, struct fscache_cookie, proc_link);
-
-	switch (cookie->type) {
-	case 0:
-		type = "IX";
-		break;
-	case 1:
-		type = "DT";
-		break;
-	default:
-		snprintf(_type, sizeof(_type), "%02u",
-			 cookie->type);
-		type = _type;
-		break;
-	}
-
-	seq_printf(m,
-		   "%08x %08x %5u %5u %3u %s %03lx %-16s %px",
-		   cookie->debug_id,
-		   cookie->parent ? cookie->parent->debug_id : 0,
-		   refcount_read(&cookie->ref),
-		   atomic_read(&cookie->n_children),
-		   atomic_read(&cookie->n_active),
-		   type,
-		   cookie->flags,
-		   cookie->def->name,
-		   cookie->netfs_data);
-
-	keylen = cookie->key_len;
-	auxlen = cookie->aux_len;
-
-	if (keylen > 0 || auxlen > 0) {
-		seq_puts(m, " ");
-		p = keylen <= sizeof(cookie->inline_key) ?
-			cookie->inline_key : cookie->key;
-		for (; keylen > 0; keylen--)
-			seq_printf(m, "%02x", *p++);
-		if (auxlen > 0) {
-			seq_puts(m, ", ");
-			p = auxlen <= sizeof(cookie->inline_aux) ?
-				cookie->inline_aux : cookie->aux;
-			for (; auxlen > 0; auxlen--)
-				seq_printf(m, "%02x", *p++);
-		}
-	}
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static void *fscache_cookies_seq_start(struct seq_file *m, loff_t *_pos)
-	__acquires(fscache_cookies_lock)
-{
-	read_lock(&fscache_cookies_lock);
-	return seq_list_start_head(&fscache_cookies, *_pos);
-}
-
-static void *fscache_cookies_seq_next(struct seq_file *m, void *v, loff_t *_pos)
-{
-	return seq_list_next(v, &fscache_cookies, _pos);
-}
-
-static void fscache_cookies_seq_stop(struct seq_file *m, void *v)
-	__releases(rcu)
-{
-	read_unlock(&fscache_cookies_lock);
-}
-
-
-const struct seq_operations fscache_cookies_seq_ops = {
-	.start  = fscache_cookies_seq_start,
-	.next   = fscache_cookies_seq_next,
-	.stop   = fscache_cookies_seq_stop,
-	.show   = fscache_cookies_seq_show,
-};
diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
deleted file mode 100644
index 0402673c680e..000000000000
--- a/fs/fscache/fsdef.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Filesystem index definition
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
-#include "internal.h"
-
-static
-enum fscache_checkaux fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
-						    const void *data,
-						    uint16_t datalen,
-						    loff_t object_size);
-
-/*
- * The root index is owned by FS-Cache itself.
- *
- * When a netfs requests caching facilities, FS-Cache will, if one doesn't
- * already exist, create an entry in the root index with the key being the name
- * of the netfs ("AFS" for example), and the auxiliary data holding the index
- * structure version supplied by the netfs:
- *
- *				     FSDEF
- *				       |
- *				 +-----------+
- *				 |           |
- *				NFS         AFS
- *			       [v=1]       [v=1]
- *
- * If an entry with the appropriate name does already exist, the version is
- * compared.  If the version is different, the entire subtree from that entry
- * will be discarded and a new entry created.
- *
- * The new entry will be an index, and a cookie referring to it will be passed
- * to the netfs.  This is then the root handle by which the netfs accesses the
- * cache.  It can create whatever objects it likes in that index, including
- * further indices.
- */
-static struct fscache_cookie_def fscache_fsdef_index_def = {
-	.name		= ".FS-Cache",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-
-struct fscache_cookie fscache_fsdef_index = {
-	.debug_id	= 1,
-	.ref		= REFCOUNT_INIT(1),
-	.n_active	= ATOMIC_INIT(1),
-	.lock		= __SPIN_LOCK_UNLOCKED(fscache_fsdef_index.lock),
-	.backing_objects = HLIST_HEAD_INIT,
-	.def		= &fscache_fsdef_index_def,
-	.flags		= 1 << FSCACHE_COOKIE_ENABLED,
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-EXPORT_SYMBOL(fscache_fsdef_index);
-
-/*
- * Definition of an entry in the root index.  Each entry is an index, keyed to
- * a specific netfs and only applicable to a particular version of the index
- * structure used by that netfs.
- */
-struct fscache_cookie_def fscache_fsdef_netfs_def = {
-	.name		= "FSDEF.netfs",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-	.check_aux	= fscache_fsdef_netfs_check_aux,
-};
-
-/*
- * check that the index structure version number stored in the auxiliary data
- * matches the one the netfs gave us
- */
-static enum fscache_checkaux fscache_fsdef_netfs_check_aux(
-	void *cookie_netfs_data,
-	const void *data,
-	uint16_t datalen,
-	loff_t object_size)
-{
-	struct fscache_netfs *netfs = cookie_netfs_data;
-	uint32_t version;
-
-	_enter("{%s},,%hu", netfs->name, datalen);
-
-	if (datalen != sizeof(version)) {
-		_leave(" = OBSOLETE [dl=%d v=%zu]", datalen, sizeof(version));
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	memcpy(&version, data, sizeof(version));
-	if (version != netfs->version) {
-		_leave(" = OBSOLETE [ver=%x net=%x]", version, netfs->version);
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	_leave(" = OKAY");
-	return FSCACHE_CHECKAUX_OKAY;
-}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
deleted file mode 100644
index 6eb3f51d7275..000000000000
--- a/fs/fscache/internal.h
+++ /dev/null
@@ -1,409 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Internal definitions for FS-Cache
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-/*
- * Lock order, in the order in which multiple locks should be obtained:
- * - fscache_addremove_sem
- * - cookie->lock
- * - cookie->parent->lock
- * - cache->object_list_lock
- * - object->lock
- * - object->parent->lock
- * - cookie->stores_lock
- * - fscache_thread_lock
- *
- */
-
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "FS-Cache: " fmt
-
-#include <linux/fscache-cache.h>
-#include <trace/events/fscache.h>
-#include <linux/sched.h>
-#include <linux/seq_file.h>
-
-#define FSCACHE_MIN_THREADS	4
-#define FSCACHE_MAX_THREADS	32
-
-/*
- * cache.c
- */
-extern struct list_head fscache_cache_list;
-extern struct rw_semaphore fscache_addremove_sem;
-
-extern struct fscache_cache *fscache_select_cache_for_object(
-	struct fscache_cookie *);
-
-/*
- * cookie.c
- */
-extern struct kmem_cache *fscache_cookie_jar;
-extern const struct seq_operations fscache_cookies_seq_ops;
-
-extern void fscache_free_cookie(struct fscache_cookie *);
-extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
-						   const struct fscache_cookie_def *,
-						   const void *, size_t,
-						   const void *, size_t,
-						   void *, loff_t);
-extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
-extern struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *,
-						 enum fscache_cookie_trace);
-extern void fscache_cookie_put(struct fscache_cookie *,
-			       enum fscache_cookie_trace);
-
-static inline void fscache_cookie_see(struct fscache_cookie *cookie,
-				      enum fscache_cookie_trace where)
-{
-	trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
-			     where);
-}
-
-/*
- * fsdef.c
- */
-extern struct fscache_cookie fscache_fsdef_index;
-extern struct fscache_cookie_def fscache_fsdef_netfs_def;
-
-/*
- * main.c
- */
-extern unsigned fscache_defer_lookup;
-extern unsigned fscache_defer_create;
-extern unsigned fscache_debug;
-extern struct kobject *fscache_root;
-extern struct workqueue_struct *fscache_object_wq;
-extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
-extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
-
-static inline bool fscache_object_congested(void)
-{
-	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
-}
-
-/*
- * object.c
- */
-extern void fscache_enqueue_object(struct fscache_object *);
-
-/*
- * operation.c
- */
-extern int fscache_submit_exclusive_op(struct fscache_object *,
-				       struct fscache_operation *);
-extern int fscache_submit_op(struct fscache_object *,
-			     struct fscache_operation *);
-extern int fscache_cancel_op(struct fscache_operation *, bool);
-extern void fscache_cancel_all_ops(struct fscache_object *);
-extern void fscache_abort_object(struct fscache_object *);
-extern void fscache_start_operations(struct fscache_object *);
-extern void fscache_operation_gc(struct work_struct *);
-
-/*
- * page.c
- */
-extern int fscache_wait_for_deferred_lookup(struct fscache_cookie *);
-extern int fscache_wait_for_operation_activation(struct fscache_object *,
-						 struct fscache_operation *,
-						 atomic_t *,
-						 atomic_t *);
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
-extern atomic_t fscache_n_ops_processed[FSCACHE_MAX_THREADS];
-extern atomic_t fscache_n_objs_processed[FSCACHE_MAX_THREADS];
-
-extern atomic_t fscache_n_op_pend;
-extern atomic_t fscache_n_op_run;
-extern atomic_t fscache_n_op_enqueue;
-extern atomic_t fscache_n_op_deferred_release;
-extern atomic_t fscache_n_op_initialised;
-extern atomic_t fscache_n_op_release;
-extern atomic_t fscache_n_op_gc;
-extern atomic_t fscache_n_op_cancelled;
-extern atomic_t fscache_n_op_rejected;
-
-extern atomic_t fscache_n_attr_changed;
-extern atomic_t fscache_n_attr_changed_ok;
-extern atomic_t fscache_n_attr_changed_nobufs;
-extern atomic_t fscache_n_attr_changed_nomem;
-extern atomic_t fscache_n_attr_changed_calls;
-
-extern atomic_t fscache_n_retrievals;
-extern atomic_t fscache_n_retrievals_ok;
-extern atomic_t fscache_n_retrievals_wait;
-extern atomic_t fscache_n_retrievals_nodata;
-extern atomic_t fscache_n_retrievals_nobufs;
-extern atomic_t fscache_n_retrievals_intr;
-extern atomic_t fscache_n_retrievals_nomem;
-extern atomic_t fscache_n_retrievals_object_dead;
-extern atomic_t fscache_n_retrieval_ops;
-extern atomic_t fscache_n_retrieval_op_waits;
-
-extern atomic_t fscache_n_stores;
-extern atomic_t fscache_n_stores_ok;
-extern atomic_t fscache_n_stores_again;
-extern atomic_t fscache_n_stores_nobufs;
-extern atomic_t fscache_n_stores_intr;
-extern atomic_t fscache_n_stores_oom;
-extern atomic_t fscache_n_store_ops;
-extern atomic_t fscache_n_stores_object_dead;
-extern atomic_t fscache_n_store_op_waits;
-
-extern atomic_t fscache_n_acquires;
-extern atomic_t fscache_n_acquires_null;
-extern atomic_t fscache_n_acquires_no_cache;
-extern atomic_t fscache_n_acquires_ok;
-extern atomic_t fscache_n_acquires_nobufs;
-extern atomic_t fscache_n_acquires_oom;
-
-extern atomic_t fscache_n_invalidates;
-extern atomic_t fscache_n_invalidates_run;
-
-extern atomic_t fscache_n_updates;
-extern atomic_t fscache_n_updates_null;
-extern atomic_t fscache_n_updates_run;
-
-extern atomic_t fscache_n_relinquishes;
-extern atomic_t fscache_n_relinquishes_null;
-extern atomic_t fscache_n_relinquishes_waitcrt;
-extern atomic_t fscache_n_relinquishes_retire;
-
-extern atomic_t fscache_n_cookie_index;
-extern atomic_t fscache_n_cookie_data;
-extern atomic_t fscache_n_cookie_special;
-
-extern atomic_t fscache_n_object_alloc;
-extern atomic_t fscache_n_object_no_alloc;
-extern atomic_t fscache_n_object_lookups;
-extern atomic_t fscache_n_object_lookups_negative;
-extern atomic_t fscache_n_object_lookups_positive;
-extern atomic_t fscache_n_object_lookups_timed_out;
-extern atomic_t fscache_n_object_created;
-extern atomic_t fscache_n_object_avail;
-extern atomic_t fscache_n_object_dead;
-
-extern atomic_t fscache_n_checkaux_none;
-extern atomic_t fscache_n_checkaux_okay;
-extern atomic_t fscache_n_checkaux_update;
-extern atomic_t fscache_n_checkaux_obsolete;
-
-extern atomic_t fscache_n_cop_alloc_object;
-extern atomic_t fscache_n_cop_lookup_object;
-extern atomic_t fscache_n_cop_lookup_complete;
-extern atomic_t fscache_n_cop_grab_object;
-extern atomic_t fscache_n_cop_invalidate_object;
-extern atomic_t fscache_n_cop_update_object;
-extern atomic_t fscache_n_cop_drop_object;
-extern atomic_t fscache_n_cop_put_object;
-extern atomic_t fscache_n_cop_sync_cache;
-extern atomic_t fscache_n_cop_attr_changed;
-
-extern atomic_t fscache_n_cache_no_space_reject;
-extern atomic_t fscache_n_cache_stale_objects;
-extern atomic_t fscache_n_cache_retired_objects;
-extern atomic_t fscache_n_cache_culled_objects;
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
- * raise an event on an object
- * - if the event is not masked for that object, then the object is
- *   queued for attention by the thread pool.
- */
-static inline void fscache_raise_event(struct fscache_object *object,
-				       unsigned event)
-{
-	BUG_ON(event >= NR_FSCACHE_OBJECT_EVENTS);
-#if 0
-	printk("*** fscache_raise_event(OBJ%d{%lx},%x)\n",
-	       object->debug_id, object->event_mask, (1 << event));
-#endif
-	if (!test_and_set_bit(event, &object->events) &&
-	    test_bit(event, &object->event_mask))
-		fscache_enqueue_object(object);
-}
-
-/*
- * Update the auxiliary data on a cookie.
- */
-static inline
-void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
-{
-	void *p;
-
-	if (!aux_data)
-		return;
-	if (cookie->aux_len <= sizeof(cookie->inline_aux))
-		p = cookie->inline_aux;
-	else
-		p = cookie->aux;
-
-	if (memcmp(p, aux_data, cookie->aux_len) != 0) {
-		memcpy(p, aux_data, cookie->aux_len);
-		set_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags);
-	}
-}
-
-/*****************************************************************************/
-/*
- * debug tracing
- */
-#define dbgprintk(FMT, ...) \
-	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
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
-#define FSCACHE_DEBUG_PAGE	2
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
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
deleted file mode 100644
index e633808ba813..000000000000
--- a/fs/fscache/io.c
+++ /dev/null
@@ -1,224 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Cache data I/O routines
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL PAGE
-#include <linux/module.h>
-#define FSCACHE_USE_NEW_IO_API
-#define FSCACHE_USE_FALLBACK_IO_API
-#include <linux/fscache-cache.h>
-#include <linux/uio.h>
-#include <linux/bvec.h>
-#include <linux/slab.h>
-#include <linux/netfs.h>
-#include "internal.h"
-
-/*
- * Start a cache operation.
- * - we return:
- *   -ENOMEM	- out of memory, some pages may be being read
- *   -ERESTARTSYS - interrupted, some pages may be being read
- *   -ENOBUFS	- no backing object or space available in which to cache any
- *                pages not being read
- *   -ENODATA	- no data available in the backing object for some or all of
- *                the pages
- *   0		- dispatched a read on all pages
- */
-int __fscache_begin_operation(struct netfs_cache_resources *cres,
-			      struct fscache_cookie *cookie,
-			      bool for_write)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("c=%08x", cres->debug_id);
-
-	if (for_write)
-		fscache_stat(&fscache_n_stores);
-	else
-		fscache_stat(&fscache_n_retrievals);
-
-	if (hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
-	}
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
-
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op)
-		return -ENOMEM;
-
-	fscache_operation_init(cookie, op, NULL, NULL, NULL);
-	op->flags = FSCACHE_OP_MYTHREAD |
-		(1UL << FSCACHE_OP_WAITING) |
-		(1UL << FSCACHE_OP_UNUSE_COOKIE);
-
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_retr_multi);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs_unlock;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	atomic_inc(&object->n_reads);
-	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags);
-
-	if (fscache_submit_op(object, op) < 0)
-		goto nobufs_unlock_dec;
-	spin_unlock(&cookie->lock);
-
-	/* we wait for the operation to become active, and then process it
-	 * *here*, in this thread, and not in the thread pool */
-	if (for_write) {
-		fscache_stat(&fscache_n_store_ops);
-
-		ret = fscache_wait_for_operation_activation(
-			object, op,
-			__fscache_stat(&fscache_n_store_op_waits),
-			__fscache_stat(&fscache_n_stores_object_dead));
-	} else {
-		fscache_stat(&fscache_n_retrieval_ops);
-
-		ret = fscache_wait_for_operation_activation(
-			object, op,
-			__fscache_stat(&fscache_n_retrieval_op_waits),
-			__fscache_stat(&fscache_n_retrievals_object_dead));
-	}
-	if (ret < 0)
-		goto error;
-
-	/* ask the cache to honour the operation */
-	ret = object->cache->ops->begin_operation(cres, op);
-
-error:
-	if (for_write) {
-		if (ret == -ENOMEM)
-			fscache_stat(&fscache_n_stores_oom);
-		else if (ret == -ERESTARTSYS)
-			fscache_stat(&fscache_n_stores_intr);
-		else if (ret < 0)
-			fscache_stat(&fscache_n_stores_nobufs);
-		else
-			fscache_stat(&fscache_n_stores_ok);
-	} else {
-		if (ret == -ENOMEM)
-			fscache_stat(&fscache_n_retrievals_nomem);
-		else if (ret == -ERESTARTSYS)
-			fscache_stat(&fscache_n_retrievals_intr);
-		else if (ret == -ENODATA)
-			fscache_stat(&fscache_n_retrievals_nodata);
-		else if (ret < 0)
-			fscache_stat(&fscache_n_retrievals_nobufs);
-		else
-			fscache_stat(&fscache_n_retrievals_ok);
-	}
-
-	fscache_put_operation(op);
-	_leave(" = %d", ret);
-	return ret;
-
-nobufs_unlock_dec:
-	atomic_dec(&object->n_reads);
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs_unlock:
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-nobufs:
-	if (for_write)
-		fscache_stat(&fscache_n_stores_nobufs);
-	else
-		fscache_stat(&fscache_n_retrievals_nobufs);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_begin_operation);
-
-/*
- * Clean up an operation.
- */
-static void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	cres->ops->end_operation(cres);
-}
-
-/*
- * Fallback page reading interface.
- */
-int __fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
-{
-	struct netfs_cache_resources cres;
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	int ret;
-
-	_enter("%lx", page->index);
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = fscache_begin_read_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
-			   NULL, NULL);
-	fscache_end_operation(&cres);
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(__fscache_fallback_read_page);
-
-/*
- * Fallback page writing interface.
- */
-int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
-{
-	struct netfs_cache_resources cres;
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	int ret;
-
-	_enter("%lx", page->index);
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = __fscache_begin_operation(&cres, cookie, true);
-	if (ret < 0)
-		return ret;
-
-	ret = cres.ops->prepare_fallback_write(&cres, page_index(page));
-	if (ret < 0)
-		goto out;
-
-	ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
-out:
-	fscache_end_operation(&cres);
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(__fscache_fallback_write_page);
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
deleted file mode 100644
index 4207f98e405f..000000000000
--- a/fs/fscache/main.c
+++ /dev/null
@@ -1,230 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* General filesystem local caching manager
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/seq_file.h>
-#define CREATE_TRACE_POINTS
-#include "internal.h"
-
-MODULE_DESCRIPTION("FS Cache Manager");
-MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
-
-unsigned fscache_defer_lookup = 1;
-module_param_named(defer_lookup, fscache_defer_lookup, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_lookup,
-		 "Defer cookie lookup to background thread");
-
-unsigned fscache_defer_create = 1;
-module_param_named(defer_create, fscache_defer_create, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_create,
-		 "Defer cookie creation to background thread");
-
-unsigned fscache_debug;
-module_param_named(debug, fscache_debug, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_debug,
-		 "FS-Cache debugging mask");
-
-struct kobject *fscache_root;
-struct workqueue_struct *fscache_object_wq;
-struct workqueue_struct *fscache_op_wq;
-
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
-/* these values serve as lower bounds, will be adjusted in fscache_init() */
-static unsigned fscache_object_max_active = 4;
-static unsigned fscache_op_max_active = 2;
-
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_header *fscache_sysctl_header;
-
-static int fscache_max_active_sysctl(struct ctl_table *table, int write,
-				     void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct workqueue_struct **wqp = table->extra1;
-	unsigned int *datap = table->data;
-	int ret;
-
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (ret == 0)
-		workqueue_set_max_active(*wqp, *datap);
-	return ret;
-}
-
-static struct ctl_table fscache_sysctls[] = {
-	{
-		.procname	= "object_max_active",
-		.data		= &fscache_object_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_object_wq,
-	},
-	{
-		.procname	= "operation_max_active",
-		.data		= &fscache_op_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_op_wq,
-	},
-	{}
-};
-
-static struct ctl_table fscache_sysctls_root[] = {
-	{
-		.procname	= "fscache",
-		.mode		= 0555,
-		.child		= fscache_sysctls,
-	},
-	{}
-};
-#endif
-
-/*
- * Mixing scores (in bits) for (7,20):
- * Input delta: 1-bit      2-bit
- * 1 round:     330.3     9201.6
- * 2 rounds:   1246.4    25475.4
- * 3 rounds:   1907.1    31295.1
- * 4 rounds:   2042.3    31718.6
- * Perfect:    2048      31744
- *            (32*64)   (32*31/2 * 64)
- */
-#define HASH_MIX(x, y, a)	\
-	(	x ^= (a),	\
-	y ^= x,	x = rol32(x, 7),\
-	x += y,	y = rol32(y,20),\
-	y *= 9			)
-
-static inline unsigned int fold_hash(unsigned long x, unsigned long y)
-{
-	/* Use arch-optimized multiply if one exists */
-	return __hash_32(y ^ __hash_32(x));
-}
-
-/*
- * Generate a hash.  This is derived from full_name_hash(), but we want to be
- * sure it is arch independent and that it doesn't change as bits of the
- * computed hash value might appear on disk.  The caller also guarantees that
- * the hashed data will be a series of aligned 32-bit words.
- */
-unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
-{
-	unsigned int a, x = 0, y = salt;
-
-	for (; n; n--) {
-		a = *data++;
-		HASH_MIX(x, y, a);
-	}
-	return fold_hash(x, y);
-}
-
-/*
- * initialise the fs caching module
- */
-static int __init fscache_init(void)
-{
-	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
-	int ret;
-
-	fscache_object_max_active =
-		clamp_val(nr_cpus,
-			  fscache_object_max_active, WQ_UNBOUND_MAX_ACTIVE);
-
-	ret = -ENOMEM;
-	fscache_object_wq = alloc_workqueue("fscache_object", WQ_UNBOUND,
-					    fscache_object_max_active);
-	if (!fscache_object_wq)
-		goto error_object_wq;
-
-	fscache_op_max_active =
-		clamp_val(fscache_object_max_active / 2,
-			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
-
-	ret = -ENOMEM;
-	fscache_op_wq = alloc_workqueue("fscache_operation", WQ_UNBOUND,
-					fscache_op_max_active);
-	if (!fscache_op_wq)
-		goto error_op_wq;
-
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
-	ret = fscache_proc_init();
-	if (ret < 0)
-		goto error_proc;
-
-#ifdef CONFIG_SYSCTL
-	ret = -ENOMEM;
-	fscache_sysctl_header = register_sysctl_table(fscache_sysctls_root);
-	if (!fscache_sysctl_header)
-		goto error_sysctl;
-#endif
-
-	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
-					       sizeof(struct fscache_cookie),
-					       0, 0, NULL);
-	if (!fscache_cookie_jar) {
-		pr_notice("Failed to allocate a cookie jar\n");
-		ret = -ENOMEM;
-		goto error_cookie_jar;
-	}
-
-	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
-	if (!fscache_root)
-		goto error_kobj;
-
-	pr_notice("Loaded\n");
-	return 0;
-
-error_kobj:
-	kmem_cache_destroy(fscache_cookie_jar);
-error_cookie_jar:
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-error_sysctl:
-#endif
-	fscache_proc_cleanup();
-error_proc:
-	destroy_workqueue(fscache_op_wq);
-error_op_wq:
-	destroy_workqueue(fscache_object_wq);
-error_object_wq:
-	return ret;
-}
-
-fs_initcall(fscache_init);
-
-/*
- * clean up on module removal
- */
-static void __exit fscache_exit(void)
-{
-	_enter("");
-
-	kobject_put(fscache_root);
-	kmem_cache_destroy(fscache_cookie_jar);
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-#endif
-	fscache_proc_cleanup();
-	destroy_workqueue(fscache_op_wq);
-	destroy_workqueue(fscache_object_wq);
-	pr_notice("Unloaded\n");
-}
-
-module_exit(fscache_exit);
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
deleted file mode 100644
index d6bdb7b5e723..000000000000
--- a/fs/fscache/netfs.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache netfs (client) registration
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-/*
- * register a network filesystem for caching
- */
-int __fscache_register_netfs(struct fscache_netfs *netfs)
-{
-	struct fscache_cookie *candidate, *cookie;
-
-	_enter("{%s}", netfs->name);
-
-	/* allocate a cookie for the primary index */
-	candidate = fscache_alloc_cookie(&fscache_fsdef_index,
-					 &fscache_fsdef_netfs_def,
-					 netfs->name, strlen(netfs->name),
-					 &netfs->version, sizeof(netfs->version),
-					 netfs, 0);
-	if (!candidate) {
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	candidate->flags = 1 << FSCACHE_COOKIE_ENABLED;
-
-	/* check the netfs type is not already present */
-	cookie = fscache_hash_cookie(candidate);
-	if (!cookie)
-		goto already_registered;
-	if (cookie != candidate) {
-		trace_fscache_cookie(candidate->debug_id, 1, fscache_cookie_discard);
-		fscache_free_cookie(candidate);
-	}
-
-	fscache_cookie_get(cookie->parent, fscache_cookie_get_register_netfs);
-	atomic_inc(&cookie->parent->n_children);
-
-	netfs->primary_index = cookie;
-
-	pr_notice("Netfs '%s' registered for caching\n", netfs->name);
-	trace_fscache_netfs(netfs);
-	_leave(" = 0");
-	return 0;
-
-already_registered:
-	fscache_cookie_put(candidate, fscache_cookie_put_dup_netfs);
-	_leave(" = -EEXIST");
-	return -EEXIST;
-}
-EXPORT_SYMBOL(__fscache_register_netfs);
-
-/*
- * unregister a network filesystem from the cache
- * - all cookies must have been released first
- */
-void __fscache_unregister_netfs(struct fscache_netfs *netfs)
-{
-	_enter("{%s.%u}", netfs->name, netfs->version);
-
-	fscache_relinquish_cookie(netfs->primary_index, NULL, false);
-	pr_notice("Netfs '%s' unregistered from caching\n", netfs->name);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_unregister_netfs);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
deleted file mode 100644
index 86ad941726f7..000000000000
--- a/fs/fscache/object.c
+++ /dev/null
@@ -1,1123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache object state machine handler
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See Documentation/filesystems/caching/object.rst for a description of the
- * object state machine and the in-kernel representations.
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/prefetch.h>
-#include "internal.h"
-
-static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *, int);
-static const struct fscache_state *fscache_kill_dependents(struct fscache_object *, int);
-static const struct fscache_state *fscache_drop_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_initialise_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_invalidate_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *, int);
-static const struct fscache_state *fscache_kill_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_lookup_failure(struct fscache_object *, int);
-static const struct fscache_state *fscache_look_up_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_object_available(struct fscache_object *, int);
-static const struct fscache_state *fscache_parent_ready(struct fscache_object *, int);
-static const struct fscache_state *fscache_update_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_object_dead(struct fscache_object *, int);
-
-#define __STATE_NAME(n) fscache_osm_##n
-#define STATE(n) (&__STATE_NAME(n))
-
-/*
- * Define a work state.  Work states are execution states.  No event processing
- * is performed by them.  The function attached to a work state returns a
- * pointer indicating the next state to which the state machine should
- * transition.  Returning NO_TRANSIT repeats the current state, but goes back
- * to the scheduler first.
- */
-#define WORK_STATE(n, sn, f) \
-	const struct fscache_state __STATE_NAME(n) = {			\
-		.name = #n,						\
-		.short_name = sn,					\
-		.work = f						\
-	}
-
-/*
- * Returns from work states.
- */
-#define transit_to(state) ({ prefetch(&STATE(state)->work); STATE(state); })
-
-#define NO_TRANSIT ((struct fscache_state *)NULL)
-
-/*
- * Define a wait state.  Wait states are event processing states.  No execution
- * is performed by them.  Wait states are just tables of "if event X occurs,
- * clear it and transition to state Y".  The dispatcher returns to the
- * scheduler if none of the events in which the wait state has an interest are
- * currently pending.
- */
-#define WAIT_STATE(n, sn, ...) \
-	const struct fscache_state __STATE_NAME(n) = {			\
-		.name = #n,						\
-		.short_name = sn,					\
-		.work = NULL,						\
-		.transitions = { __VA_ARGS__, { 0, NULL } }		\
-	}
-
-#define TRANSIT_TO(state, emask) \
-	{ .events = (emask), .transit_to = STATE(state) }
-
-/*
- * The object state machine.
- */
-static WORK_STATE(INIT_OBJECT,		"INIT", fscache_initialise_object);
-static WORK_STATE(PARENT_READY,		"PRDY", fscache_parent_ready);
-static WORK_STATE(ABORT_INIT,		"ABRT", fscache_abort_initialisation);
-static WORK_STATE(LOOK_UP_OBJECT,	"LOOK", fscache_look_up_object);
-static WORK_STATE(OBJECT_AVAILABLE,	"AVBL", fscache_object_available);
-static WORK_STATE(JUMPSTART_DEPS,	"JUMP", fscache_jumpstart_dependents);
-
-static WORK_STATE(INVALIDATE_OBJECT,	"INVL", fscache_invalidate_object);
-static WORK_STATE(UPDATE_OBJECT,	"UPDT", fscache_update_object);
-
-static WORK_STATE(LOOKUP_FAILURE,	"LCFL", fscache_lookup_failure);
-static WORK_STATE(KILL_OBJECT,		"KILL", fscache_kill_object);
-static WORK_STATE(KILL_DEPENDENTS,	"KDEP", fscache_kill_dependents);
-static WORK_STATE(DROP_OBJECT,		"DROP", fscache_drop_object);
-static WORK_STATE(OBJECT_DEAD,		"DEAD", fscache_object_dead);
-
-static WAIT_STATE(WAIT_FOR_INIT,	"?INI",
-		  TRANSIT_TO(INIT_OBJECT,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
-
-static WAIT_STATE(WAIT_FOR_PARENT,	"?PRN",
-		  TRANSIT_TO(PARENT_READY,	1 << FSCACHE_OBJECT_EV_PARENT_READY));
-
-static WAIT_STATE(WAIT_FOR_CMD,		"?CMD",
-		  TRANSIT_TO(INVALIDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_INVALIDATE),
-		  TRANSIT_TO(UPDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_UPDATE),
-		  TRANSIT_TO(JUMPSTART_DEPS,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
-
-static WAIT_STATE(WAIT_FOR_CLEARANCE,	"?CLR",
-		  TRANSIT_TO(KILL_OBJECT,	1 << FSCACHE_OBJECT_EV_CLEARED));
-
-/*
- * Out-of-band event transition tables.  These are for handling unexpected
- * events, such as an I/O error.  If an OOB event occurs, the state machine
- * clears and disables the event and forces a transition to the nominated work
- * state (acurrently executing work states will complete first).
- *
- * In such a situation, object->state remembers the state the machine should
- * have been in/gone to and returning NO_TRANSIT returns to that.
- */
-static const struct fscache_transition fscache_osm_init_oob[] = {
-	   TRANSIT_TO(ABORT_INIT,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static const struct fscache_transition fscache_osm_lookup_oob[] = {
-	   TRANSIT_TO(LOOKUP_FAILURE,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static const struct fscache_transition fscache_osm_run_oob[] = {
-	   TRANSIT_TO(KILL_OBJECT,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static int  fscache_get_object(struct fscache_object *,
-			       enum fscache_obj_ref_trace);
-static void fscache_put_object(struct fscache_object *,
-			       enum fscache_obj_ref_trace);
-static bool fscache_enqueue_dependents(struct fscache_object *, int);
-static void fscache_dequeue_object(struct fscache_object *);
-static void fscache_update_aux_data(struct fscache_object *);
-
-/*
- * we need to notify the parent when an op completes that we had outstanding
- * upon it
- */
-static inline void fscache_done_parent_op(struct fscache_object *object)
-{
-	struct fscache_object *parent = object->parent;
-
-	_enter("OBJ%x {OBJ%x,%x}",
-	       object->debug_id, parent->debug_id, parent->n_ops);
-
-	spin_lock_nested(&parent->lock, 1);
-	parent->n_obj_ops--;
-	parent->n_ops--;
-	if (parent->n_ops == 0)
-		fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
-	spin_unlock(&parent->lock);
-}
-
-/*
- * Object state machine dispatcher.
- */
-static void fscache_object_sm_dispatcher(struct fscache_object *object)
-{
-	const struct fscache_transition *t;
-	const struct fscache_state *state, *new_state;
-	unsigned long events, event_mask;
-	bool oob;
-	int event = -1;
-
-	ASSERT(object != NULL);
-
-	_enter("{OBJ%x,%s,%lx}",
-	       object->debug_id, object->state->name, object->events);
-
-	event_mask = object->event_mask;
-restart:
-	object->event_mask = 0; /* Mask normal event handling */
-	state = object->state;
-restart_masked:
-	events = object->events;
-
-	/* Handle any out-of-band events (typically an error) */
-	if (events & object->oob_event_mask) {
-		_debug("{OBJ%x} oob %lx",
-		       object->debug_id, events & object->oob_event_mask);
-		oob = true;
-		for (t = object->oob_table; t->events; t++) {
-			if (events & t->events) {
-				state = t->transit_to;
-				ASSERT(state->work != NULL);
-				event = fls(events & t->events) - 1;
-				__clear_bit(event, &object->oob_event_mask);
-				clear_bit(event, &object->events);
-				goto execute_work_state;
-			}
-		}
-	}
-	oob = false;
-
-	/* Wait states are just transition tables */
-	if (!state->work) {
-		if (events & event_mask) {
-			for (t = state->transitions; t->events; t++) {
-				if (events & t->events) {
-					new_state = t->transit_to;
-					event = fls(events & t->events) - 1;
-					trace_fscache_osm(object, state,
-							  true, false, event);
-					clear_bit(event, &object->events);
-					_debug("{OBJ%x} ev %d: %s -> %s",
-					       object->debug_id, event,
-					       state->name, new_state->name);
-					object->state = state = new_state;
-					goto execute_work_state;
-				}
-			}
-
-			/* The event mask didn't include all the tabled bits */
-			BUG();
-		}
-		/* Randomly woke up */
-		goto unmask_events;
-	}
-
-execute_work_state:
-	_debug("{OBJ%x} exec %s", object->debug_id, state->name);
-
-	trace_fscache_osm(object, state, false, oob, event);
-	new_state = state->work(object, event);
-	event = -1;
-	if (new_state == NO_TRANSIT) {
-		_debug("{OBJ%x} %s notrans", object->debug_id, state->name);
-		if (unlikely(state == STATE(OBJECT_DEAD))) {
-			_leave(" [dead]");
-			return;
-		}
-		fscache_enqueue_object(object);
-		event_mask = object->oob_event_mask;
-		goto unmask_events;
-	}
-
-	_debug("{OBJ%x} %s -> %s",
-	       object->debug_id, state->name, new_state->name);
-	object->state = state = new_state;
-
-	if (state->work) {
-		if (unlikely(state == STATE(OBJECT_DEAD))) {
-			_leave(" [dead]");
-			return;
-		}
-		goto restart_masked;
-	}
-
-	/* Transited to wait state */
-	event_mask = object->oob_event_mask;
-	for (t = state->transitions; t->events; t++)
-		event_mask |= t->events;
-
-unmask_events:
-	object->event_mask = event_mask;
-	smp_mb();
-	events = object->events;
-	if (events & event_mask)
-		goto restart;
-	_leave(" [msk %lx]", event_mask);
-}
-
-/*
- * execute an object
- */
-static void fscache_object_work_func(struct work_struct *work)
-{
-	struct fscache_object *object =
-		container_of(work, struct fscache_object, work);
-
-	_enter("{OBJ%x}", object->debug_id);
-
-	fscache_object_sm_dispatcher(object);
-	fscache_put_object(object, fscache_obj_put_work);
-}
-
-/**
- * fscache_object_init - Initialise a cache object description
- * @object: Object description
- * @cookie: Cookie object will be attached to
- * @cache: Cache in which backing object will be found
- *
- * Initialise a cache object description to its basic values.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-void fscache_object_init(struct fscache_object *object,
-			 struct fscache_cookie *cookie,
-			 struct fscache_cache *cache)
-{
-	const struct fscache_transition *t;
-
-	atomic_inc(&cache->object_count);
-
-	object->state = STATE(WAIT_FOR_INIT);
-	object->oob_table = fscache_osm_init_oob;
-	object->flags = 1 << FSCACHE_OBJECT_IS_LIVE;
-	spin_lock_init(&object->lock);
-	INIT_LIST_HEAD(&object->cache_link);
-	INIT_HLIST_NODE(&object->cookie_link);
-	INIT_WORK(&object->work, fscache_object_work_func);
-	INIT_LIST_HEAD(&object->dependents);
-	INIT_LIST_HEAD(&object->dep_link);
-	INIT_LIST_HEAD(&object->pending_ops);
-	object->n_children = 0;
-	object->n_ops = object->n_in_progress = object->n_exclusive = 0;
-	object->events = 0;
-	object->store_limit = 0;
-	object->store_limit_l = 0;
-	object->cache = cache;
-	object->cookie = cookie;
-	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
-	object->parent = NULL;
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	RB_CLEAR_NODE(&object->objlist_link);
-#endif
-
-	object->oob_event_mask = 0;
-	for (t = object->oob_table; t->events; t++)
-		object->oob_event_mask |= t->events;
-	object->event_mask = object->oob_event_mask;
-	for (t = object->state->transitions; t->events; t++)
-		object->event_mask |= t->events;
-}
-EXPORT_SYMBOL(fscache_object_init);
-
-/*
- * Mark the object as no longer being live, making sure that we synchronise
- * against op submission.
- */
-static inline void fscache_mark_object_dead(struct fscache_object *object)
-{
-	spin_lock(&object->lock);
-	clear_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
-	spin_unlock(&object->lock);
-}
-
-/*
- * Abort object initialisation before we start it.
- */
-static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *object,
-								int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_event_mask = 0;
-	fscache_dequeue_object(object);
-	return transit_to(KILL_OBJECT);
-}
-
-/*
- * initialise an object
- * - check the specified object's parent to see if we can make use of it
- *   immediately to do a creation
- * - we may need to start the process of creating a parent and we need to wait
- *   for the parent's lookup and creation to complete if it's not there yet
- */
-static const struct fscache_state *fscache_initialise_object(struct fscache_object *object,
-							     int event)
-{
-	struct fscache_object *parent;
-	bool success;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	ASSERT(list_empty(&object->dep_link));
-
-	parent = object->parent;
-	if (!parent) {
-		_leave(" [no parent]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	_debug("parent: %s of:%lx", parent->state->name, parent->flags);
-
-	if (fscache_object_is_dying(parent)) {
-		_leave(" [bad parent]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	if (fscache_object_is_available(parent)) {
-		_leave(" [ready]");
-		return transit_to(PARENT_READY);
-	}
-
-	_debug("wait");
-
-	spin_lock(&parent->lock);
-	fscache_stat(&fscache_n_cop_grab_object);
-	success = false;
-	if (fscache_object_is_live(parent) &&
-	    object->cache->ops->grab_object(object, fscache_obj_get_add_to_deps)) {
-		list_add(&object->dep_link, &parent->dependents);
-		success = true;
-	}
-	fscache_stat_d(&fscache_n_cop_grab_object);
-	spin_unlock(&parent->lock);
-	if (!success) {
-		_leave(" [grab failed]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	/* fscache_acquire_non_index_cookie() uses this
-	 * to wake the chain up */
-	fscache_raise_event(parent, FSCACHE_OBJECT_EV_NEW_CHILD);
-	_leave(" [wait]");
-	return transit_to(WAIT_FOR_PARENT);
-}
-
-/*
- * Once the parent object is ready, we should kick off our lookup op.
- */
-static const struct fscache_state *fscache_parent_ready(struct fscache_object *object,
-							int event)
-{
-	struct fscache_object *parent = object->parent;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	ASSERT(parent != NULL);
-
-	spin_lock(&parent->lock);
-	parent->n_ops++;
-	parent->n_obj_ops++;
-	spin_unlock(&parent->lock);
-
-	_leave("");
-	return transit_to(LOOK_UP_OBJECT);
-}
-
-/*
- * look an object up in the cache from which it was allocated
- * - we hold an "access lock" on the parent object, so the parent object cannot
- *   be withdrawn by either party till we've finished
- */
-static const struct fscache_state *fscache_look_up_object(struct fscache_object *object,
-							  int event)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	struct fscache_object *parent = object->parent;
-	int ret;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_table = fscache_osm_lookup_oob;
-
-	ASSERT(parent != NULL);
-	ASSERTCMP(parent->n_ops, >, 0);
-	ASSERTCMP(parent->n_obj_ops, >, 0);
-
-	/* make sure the parent is still available */
-	ASSERT(fscache_object_is_available(parent));
-
-	if (fscache_object_is_dying(parent) ||
-	    test_bit(FSCACHE_IOERROR, &object->cache->flags) ||
-	    !fscache_use_cookie(object)) {
-		_leave(" [unavailable]");
-		return transit_to(LOOKUP_FAILURE);
-	}
-
-	_debug("LOOKUP \"%s\" in \"%s\"",
-	       cookie->def->name, object->cache->tag->name);
-
-	fscache_stat(&fscache_n_object_lookups);
-	fscache_stat(&fscache_n_cop_lookup_object);
-	ret = object->cache->ops->lookup_object(object);
-	fscache_stat_d(&fscache_n_cop_lookup_object);
-
-	fscache_unuse_cookie(object);
-
-	if (ret == -ETIMEDOUT) {
-		/* probably stuck behind another object, so move this one to
-		 * the back of the queue */
-		fscache_stat(&fscache_n_object_lookups_timed_out);
-		_leave(" [timeout]");
-		return NO_TRANSIT;
-	}
-
-	if (ret < 0) {
-		_leave(" [error]");
-		return transit_to(LOOKUP_FAILURE);
-	}
-
-	_leave(" [ok]");
-	return transit_to(OBJECT_AVAILABLE);
-}
-
-/**
- * fscache_object_lookup_negative - Note negative cookie lookup
- * @object: Object pointing to cookie to mark
- *
- * Note negative lookup, permitting those waiting to read data from an already
- * existing backing object to continue as there's no data for them to read.
- */
-void fscache_object_lookup_negative(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
-
-	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
-		fscache_stat(&fscache_n_object_lookups_negative);
-
-		/* Allow write requests to begin stacking up and read requests to begin
-		 * returning ENODATA.
-		 */
-		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-	}
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_object_lookup_negative);
-
-/**
- * fscache_obtained_object - Note successful object lookup or creation
- * @object: Object pointing to cookie to mark
- *
- * Note successful lookup and/or creation, permitting those waiting to write
- * data to a backing object to continue.
- *
- * Note that after calling this, an object's cookie may be relinquished by the
- * netfs, and so must be accessed with object lock held.
- */
-void fscache_obtained_object(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
-
-	/* if we were still looking up, then we must have a positive lookup
-	 * result, in which case there may be data available */
-	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
-		fscache_stat(&fscache_n_object_lookups_positive);
-
-		/* We do (presumably) have data */
-		clear_bit_unlock(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-		/* Allow write requests to begin stacking up and read requests
-		 * to begin shovelling data.
-		 */
-		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-	} else {
-		fscache_stat(&fscache_n_object_created);
-	}
-
-	set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_obtained_object);
-
-/*
- * handle an object that has just become available
- */
-static const struct fscache_state *fscache_object_available(struct fscache_object *object,
-							    int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_table = fscache_osm_run_oob;
-
-	spin_lock(&object->lock);
-
-	fscache_done_parent_op(object);
-	if (object->n_in_progress == 0) {
-		if (object->n_ops > 0) {
-			ASSERTCMP(object->n_ops, >=, object->n_obj_ops);
-			fscache_start_operations(object);
-		} else {
-			ASSERT(list_empty(&object->pending_ops));
-		}
-	}
-	spin_unlock(&object->lock);
-
-	fscache_stat(&fscache_n_cop_lookup_complete);
-	object->cache->ops->lookup_complete(object);
-	fscache_stat_d(&fscache_n_cop_lookup_complete);
-
-	fscache_stat(&fscache_n_object_avail);
-
-	_leave("");
-	return transit_to(JUMPSTART_DEPS);
-}
-
-/*
- * Wake up this object's dependent objects now that we've become available.
- */
-static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *object,
-								int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_PARENT_READY))
-		return NO_TRANSIT; /* Not finished; requeue */
-	return transit_to(WAIT_FOR_CMD);
-}
-
-/*
- * Handle lookup or creation failute.
- */
-static const struct fscache_state *fscache_lookup_failure(struct fscache_object *object,
-							  int event)
-{
-	struct fscache_cookie *cookie;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_event_mask = 0;
-
-	fscache_stat(&fscache_n_cop_lookup_complete);
-	object->cache->ops->lookup_complete(object);
-	fscache_stat_d(&fscache_n_cop_lookup_complete);
-
-	set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags);
-
-	cookie = object->cookie;
-	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-
-	fscache_done_parent_op(object);
-	return transit_to(KILL_OBJECT);
-}
-
-/*
- * Wait for completion of all active operations on this object and the death of
- * all child objects of this object.
- */
-static const struct fscache_state *fscache_kill_object(struct fscache_object *object,
-						       int event)
-{
-	_enter("{OBJ%x,%d,%d},%d",
-	       object->debug_id, object->n_ops, object->n_children, event);
-
-	fscache_mark_object_dead(object);
-	object->oob_event_mask = 0;
-
-	if (test_bit(FSCACHE_OBJECT_RETIRED, &object->flags)) {
-		/* Reject any new read/write ops and abort any that are pending. */
-		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-		fscache_cancel_all_ops(object);
-	}
-
-	if (list_empty(&object->dependents) &&
-	    object->n_ops == 0 &&
-	    object->n_children == 0)
-		return transit_to(DROP_OBJECT);
-
-	if (object->n_in_progress == 0) {
-		spin_lock(&object->lock);
-		if (object->n_ops > 0 && object->n_in_progress == 0)
-			fscache_start_operations(object);
-		spin_unlock(&object->lock);
-	}
-
-	if (!list_empty(&object->dependents))
-		return transit_to(KILL_DEPENDENTS);
-
-	return transit_to(WAIT_FOR_CLEARANCE);
-}
-
-/*
- * Kill dependent objects.
- */
-static const struct fscache_state *fscache_kill_dependents(struct fscache_object *object,
-							   int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_KILL))
-		return NO_TRANSIT; /* Not finished */
-	return transit_to(WAIT_FOR_CLEARANCE);
-}
-
-/*
- * Drop an object's attachments
- */
-static const struct fscache_state *fscache_drop_object(struct fscache_object *object,
-						       int event)
-{
-	struct fscache_object *parent = object->parent;
-	struct fscache_cookie *cookie = object->cookie;
-	struct fscache_cache *cache = object->cache;
-	bool awaken = false;
-
-	_enter("{OBJ%x,%d},%d", object->debug_id, object->n_children, event);
-
-	ASSERT(cookie != NULL);
-	ASSERT(!hlist_unhashed(&object->cookie_link));
-
-	if (test_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags)) {
-		_debug("final update");
-		fscache_update_aux_data(object);
-	}
-
-	/* Make sure the cookie no longer points here and that the netfs isn't
-	 * waiting for us.
-	 */
-	spin_lock(&cookie->lock);
-	hlist_del_init(&object->cookie_link);
-	if (hlist_empty(&cookie->backing_objects) &&
-	    test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		awaken = true;
-	spin_unlock(&cookie->lock);
-
-	if (awaken)
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-
-
-	/* Prevent a race with our last child, which has to signal EV_CLEARED
-	 * before dropping our spinlock.
-	 */
-	spin_lock(&object->lock);
-	spin_unlock(&object->lock);
-
-	/* Discard from the cache's collection of objects */
-	spin_lock(&cache->object_list_lock);
-	list_del_init(&object->cache_link);
-	spin_unlock(&cache->object_list_lock);
-
-	fscache_stat(&fscache_n_cop_drop_object);
-	cache->ops->drop_object(object);
-	fscache_stat_d(&fscache_n_cop_drop_object);
-
-	/* The parent object wants to know when all it dependents have gone */
-	if (parent) {
-		_debug("release parent OBJ%x {%d}",
-		       parent->debug_id, parent->n_children);
-
-		spin_lock(&parent->lock);
-		parent->n_children--;
-		if (parent->n_children == 0)
-			fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
-		spin_unlock(&parent->lock);
-		object->parent = NULL;
-	}
-
-	/* this just shifts the object release to the work processor */
-	fscache_put_object(object, fscache_obj_put_drop_obj);
-	fscache_stat(&fscache_n_object_dead);
-
-	_leave("");
-	return transit_to(OBJECT_DEAD);
-}
-
-/*
- * get a ref on an object
- */
-static int fscache_get_object(struct fscache_object *object,
-			      enum fscache_obj_ref_trace why)
-{
-	int ret;
-
-	fscache_stat(&fscache_n_cop_grab_object);
-	ret = object->cache->ops->grab_object(object, why) ? 0 : -EAGAIN;
-	fscache_stat_d(&fscache_n_cop_grab_object);
-	return ret;
-}
-
-/*
- * Discard a ref on an object
- */
-static void fscache_put_object(struct fscache_object *object,
-			       enum fscache_obj_ref_trace why)
-{
-	fscache_stat(&fscache_n_cop_put_object);
-	object->cache->ops->put_object(object, why);
-	fscache_stat_d(&fscache_n_cop_put_object);
-}
-
-/**
- * fscache_object_destroy - Note that a cache object is about to be destroyed
- * @object: The object to be destroyed
- *
- * Note the imminent destruction and deallocation of a cache object record.
- */
-void fscache_object_destroy(struct fscache_object *object)
-{
-	/* We can get rid of the cookie now */
-	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
-	object->cookie = NULL;
-}
-EXPORT_SYMBOL(fscache_object_destroy);
-
-/*
- * enqueue an object for metadata-type processing
- */
-void fscache_enqueue_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
-		wait_queue_head_t *cong_wq =
-			&get_cpu_var(fscache_object_cong_wait);
-
-		if (queue_work(fscache_object_wq, &object->work)) {
-			if (fscache_object_congested())
-				wake_up(cong_wq);
-		} else
-			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
-	}
-}
-
-/**
- * fscache_object_sleep_till_congested - Sleep until object wq is congested
- * @timeoutp: Scheduler sleep timeout
- *
- * Allow an object handler to sleep until the object workqueue is congested.
- *
- * The caller must set up a wake up event before calling this and must have set
- * the appropriate sleep mode (such as TASK_UNINTERRUPTIBLE) and tested its own
- * condition before calling this function as no test is made here.
- *
- * %true is returned if the object wq is congested, %false otherwise.
- */
-bool fscache_object_sleep_till_congested(signed long *timeoutp)
-{
-	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
-	DEFINE_WAIT(wait);
-
-	if (fscache_object_congested())
-		return true;
-
-	add_wait_queue_exclusive(cong_wq, &wait);
-	if (!fscache_object_congested())
-		*timeoutp = schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
-
-	return fscache_object_congested();
-}
-EXPORT_SYMBOL_GPL(fscache_object_sleep_till_congested);
-
-/*
- * Enqueue the dependents of an object for metadata-type processing.
- *
- * If we don't manage to finish the list before the scheduler wants to run
- * again then return false immediately.  We return true if the list was
- * cleared.
- */
-static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
-{
-	struct fscache_object *dep;
-	bool ret = true;
-
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (list_empty(&object->dependents))
-		return true;
-
-	spin_lock(&object->lock);
-
-	while (!list_empty(&object->dependents)) {
-		dep = list_entry(object->dependents.next,
-				 struct fscache_object, dep_link);
-		list_del_init(&dep->dep_link);
-
-		fscache_raise_event(dep, event);
-		fscache_put_object(dep, fscache_obj_put_enq_dep);
-
-		if (!list_empty(&object->dependents) && need_resched()) {
-			ret = false;
-			break;
-		}
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * remove an object from whatever queue it's waiting on
- */
-static void fscache_dequeue_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (!list_empty(&object->dep_link)) {
-		spin_lock(&object->parent->lock);
-		list_del_init(&object->dep_link);
-		spin_unlock(&object->parent->lock);
-	}
-
-	_leave("");
-}
-
-/**
- * fscache_check_aux - Ask the netfs whether an object on disk is still valid
- * @object: The object to ask about
- * @data: The auxiliary data for the object
- * @datalen: The size of the auxiliary data
- * @object_size: The size of the object according to the server.
- *
- * This function consults the netfs about the coherency state of an object.
- * The caller must be holding a ref on cookie->n_active (held by
- * fscache_look_up_object() on behalf of the cache backend during object lookup
- * and creation).
- */
-enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
-					const void *data, uint16_t datalen,
-					loff_t object_size)
-{
-	enum fscache_checkaux result;
-
-	if (!object->cookie->def->check_aux) {
-		fscache_stat(&fscache_n_checkaux_none);
-		return FSCACHE_CHECKAUX_OKAY;
-	}
-
-	result = object->cookie->def->check_aux(object->cookie->netfs_data,
-						data, datalen, object_size);
-	switch (result) {
-		/* entry okay as is */
-	case FSCACHE_CHECKAUX_OKAY:
-		fscache_stat(&fscache_n_checkaux_okay);
-		break;
-
-		/* entry requires update */
-	case FSCACHE_CHECKAUX_NEEDS_UPDATE:
-		fscache_stat(&fscache_n_checkaux_update);
-		break;
-
-		/* entry requires deletion */
-	case FSCACHE_CHECKAUX_OBSOLETE:
-		fscache_stat(&fscache_n_checkaux_obsolete);
-		break;
-
-	default:
-		BUG();
-	}
-
-	return result;
-}
-EXPORT_SYMBOL(fscache_check_aux);
-
-/*
- * Asynchronously invalidate an object.
- */
-static const struct fscache_state *_fscache_invalidate_object(struct fscache_object *object,
-							      int event)
-{
-	struct fscache_operation *op;
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	/* We're going to need the cookie.  If the cookie is not available then
-	 * retire the object instead.
-	 */
-	if (!fscache_use_cookie(object)) {
-		set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
-		_leave(" [no cookie]");
-		return transit_to(KILL_OBJECT);
-	}
-
-	/* Reject any new read/write ops and abort any that are pending. */
-	clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-	fscache_cancel_all_ops(object);
-
-	/* Now we have to wait for in-progress reads and writes */
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op)
-		goto nomem;
-
-	fscache_operation_init(cookie, op, object->cache->ops->invalidate_object,
-			       NULL, NULL);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_invalidate);
-
-	spin_lock(&cookie->lock);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto submit_op_failed;
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-
-	/* Once we've completed the invalidation, we know there will be no data
-	 * stored in the cache and thus we can reinstate the data-check-skip
-	 * optimisation.
-	 */
-	set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-
-	/* We can allow read and write requests to come in once again.  They'll
-	 * queue up behind our exclusive invalidation operation.
-	 */
-	if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-	_leave(" [ok]");
-	return transit_to(UPDATE_OBJECT);
-
-nomem:
-	fscache_mark_object_dead(object);
-	fscache_unuse_cookie(object);
-	_leave(" [ENOMEM]");
-	return transit_to(KILL_OBJECT);
-
-submit_op_failed:
-	fscache_mark_object_dead(object);
-	spin_unlock(&cookie->lock);
-	fscache_unuse_cookie(object);
-	kfree(op);
-	_leave(" [EIO]");
-	return transit_to(KILL_OBJECT);
-}
-
-static const struct fscache_state *fscache_invalidate_object(struct fscache_object *object,
-							     int event)
-{
-	const struct fscache_state *s;
-
-	fscache_stat(&fscache_n_invalidates_run);
-	fscache_stat(&fscache_n_cop_invalidate_object);
-	s = _fscache_invalidate_object(object, event);
-	fscache_stat_d(&fscache_n_cop_invalidate_object);
-	return s;
-}
-
-/*
- * Update auxiliary data.
- */
-static void fscache_update_aux_data(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_updates_run);
-	fscache_stat(&fscache_n_cop_update_object);
-	object->cache->ops->update_object(object);
-	fscache_stat_d(&fscache_n_cop_update_object);
-}
-
-/*
- * Asynchronously update an object.
- */
-static const struct fscache_state *fscache_update_object(struct fscache_object *object,
-							 int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	fscache_update_aux_data(object);
-
-	_leave("");
-	return transit_to(WAIT_FOR_CMD);
-}
-
-/**
- * fscache_object_retrying_stale - Note retrying stale object
- * @object: The object that will be retried
- *
- * Note that an object lookup found an on-disk object that was adjudged to be
- * stale and has been deleted.  The lookup will be retried.
- */
-void fscache_object_retrying_stale(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_cache_no_space_reject);
-}
-EXPORT_SYMBOL(fscache_object_retrying_stale);
-
-/**
- * fscache_object_mark_killed - Note that an object was killed
- * @object: The object that was culled
- * @why: The reason the object was killed.
- *
- * Note that an object was killed.  Returns true if the object was
- * already marked killed, false if it wasn't.
- */
-void fscache_object_mark_killed(struct fscache_object *object,
-				enum fscache_why_object_killed why)
-{
-	if (test_and_set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags)) {
-		pr_err("Error: Object already killed by cache [%s]\n",
-		       object->cache->identifier);
-		return;
-	}
-
-	switch (why) {
-	case FSCACHE_OBJECT_NO_SPACE:
-		fscache_stat(&fscache_n_cache_no_space_reject);
-		break;
-	case FSCACHE_OBJECT_IS_STALE:
-		fscache_stat(&fscache_n_cache_stale_objects);
-		break;
-	case FSCACHE_OBJECT_WAS_RETIRED:
-		fscache_stat(&fscache_n_cache_retired_objects);
-		break;
-	case FSCACHE_OBJECT_WAS_CULLED:
-		fscache_stat(&fscache_n_cache_culled_objects);
-		break;
-	}
-}
-EXPORT_SYMBOL(fscache_object_mark_killed);
-
-/*
- * The object is dead.  We can get here if an object gets queued by an event
- * that would lead to its death (such as EV_KILL) when the dispatcher is
- * already running (and so can be requeued) but hasn't yet cleared the event
- * mask.
- */
-static const struct fscache_state *fscache_object_dead(struct fscache_object *object,
-						       int event)
-{
-	if (!test_and_set_bit(FSCACHE_OBJECT_RUN_AFTER_DEAD,
-			      &object->flags))
-		return NO_TRANSIT;
-
-	WARN(true, "FS-Cache object redispatched after death");
-	return NO_TRANSIT;
-}
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
deleted file mode 100644
index e002cdfaf3cc..000000000000
--- a/fs/fscache/operation.c
+++ /dev/null
@@ -1,633 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache worker operation management routines
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See Documentation/filesystems/caching/operations.rst
- */
-
-#define FSCACHE_DEBUG_LEVEL OPERATION
-#include <linux/module.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-atomic_t fscache_op_debug_id;
-EXPORT_SYMBOL(fscache_op_debug_id);
-
-static void fscache_operation_dummy_cancel(struct fscache_operation *op)
-{
-}
-
-/**
- * fscache_operation_init - Do basic initialisation of an operation
- * @cookie: The cookie to operate on
- * @op: The operation to initialise
- * @processor: The function to perform the operation
- * @cancel: A function to handle operation cancellation
- * @release: The release function to assign
- *
- * Do basic initialisation of an operation.  The caller must still set flags,
- * object and processor if needed.
- */
-void fscache_operation_init(struct fscache_cookie *cookie,
-			    struct fscache_operation *op,
-			    fscache_operation_processor_t processor,
-			    fscache_operation_cancel_t cancel,
-			    fscache_operation_release_t release)
-{
-	INIT_WORK(&op->work, fscache_op_work_func);
-	atomic_set(&op->usage, 1);
-	op->state = FSCACHE_OP_ST_INITIALISED;
-	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
-	op->processor = processor;
-	op->cancel = cancel ?: fscache_operation_dummy_cancel;
-	op->release = release;
-	INIT_LIST_HEAD(&op->pend_link);
-	fscache_stat(&fscache_n_op_initialised);
-	trace_fscache_op(cookie, op, fscache_op_init);
-}
-EXPORT_SYMBOL(fscache_operation_init);
-
-/**
- * fscache_enqueue_operation - Enqueue an operation for processing
- * @op: The operation to enqueue
- *
- * Enqueue an operation for processing by the FS-Cache thread pool.
- *
- * This will get its own ref on the object.
- */
-void fscache_enqueue_operation(struct fscache_operation *op)
-{
-	struct fscache_cookie *cookie = op->object->cookie;
-	
-	_enter("{OBJ%x OP%x,%u}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	ASSERT(list_empty(&op->pend_link));
-	ASSERT(op->processor != NULL);
-	ASSERT(fscache_object_is_available(op->object));
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
-		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
-
-	fscache_stat(&fscache_n_op_enqueue);
-	switch (op->flags & FSCACHE_OP_TYPE) {
-	case FSCACHE_OP_ASYNC:
-		trace_fscache_op(cookie, op, fscache_op_enqueue_async);
-		_debug("queue async");
-		atomic_inc(&op->usage);
-		if (!queue_work(fscache_op_wq, &op->work))
-			fscache_put_operation(op);
-		break;
-	case FSCACHE_OP_MYTHREAD:
-		trace_fscache_op(cookie, op, fscache_op_enqueue_mythread);
-		_debug("queue for caller's attention");
-		break;
-	default:
-		pr_err("Unexpected op type %lx", op->flags);
-		BUG();
-		break;
-	}
-}
-EXPORT_SYMBOL(fscache_enqueue_operation);
-
-/*
- * start an op running
- */
-static void fscache_run_op(struct fscache_object *object,
-			   struct fscache_operation *op)
-{
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
-
-	op->state = FSCACHE_OP_ST_IN_PROGRESS;
-	object->n_in_progress++;
-	if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-		wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-	if (op->processor)
-		fscache_enqueue_operation(op);
-	else
-		trace_fscache_op(object->cookie, op, fscache_op_run);
-	fscache_stat(&fscache_n_op_run);
-}
-
-/*
- * report an unexpected submission
- */
-static void fscache_report_unexpected_submission(struct fscache_object *object,
-						 struct fscache_operation *op,
-						 const struct fscache_state *ostate)
-{
-	static bool once_only;
-	struct fscache_operation *p;
-	unsigned n;
-
-	if (once_only)
-		return;
-	once_only = true;
-
-	kdebug("unexpected submission OP%x [OBJ%x %s]",
-	       op->debug_id, object->debug_id, object->state->name);
-	kdebug("objstate=%s [%s]", object->state->name, ostate->name);
-	kdebug("objflags=%lx", object->flags);
-	kdebug("objevent=%lx [%lx]", object->events, object->event_mask);
-	kdebug("ops=%u inp=%u exc=%u",
-	       object->n_ops, object->n_in_progress, object->n_exclusive);
-
-	if (!list_empty(&object->pending_ops)) {
-		n = 0;
-		list_for_each_entry(p, &object->pending_ops, pend_link) {
-			ASSERTCMP(p->object, ==, object);
-			kdebug("%p %p", op->processor, op->release);
-			n++;
-		}
-
-		kdebug("n=%u", n);
-	}
-
-	dump_stack();
-}
-
-/*
- * submit an exclusive operation for an object
- * - other ops are excluded from running simultaneously with this one
- * - this gets any extra refs it needs on an op
- */
-int fscache_submit_exclusive_op(struct fscache_object *object,
-				struct fscache_operation *op)
-{
-	const struct fscache_state *ostate;
-	unsigned long flags;
-	int ret;
-
-	_enter("{OBJ%x OP%x},", object->debug_id, op->debug_id);
-
-	trace_fscache_op(object->cookie, op, fscache_op_submit_ex);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
-	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
-	ASSERT(list_empty(&op->pend_link));
-
-	ostate = object->state;
-	smp_rmb();
-
-	op->state = FSCACHE_OP_ST_PENDING;
-	flags = READ_ONCE(object->flags);
-	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
-		fscache_stat(&fscache_n_op_rejected);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else if (unlikely(fscache_cache_is_broken(object))) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -EIO;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
-		op->object = object;
-		object->n_ops++;
-		object->n_exclusive++;	/* reads and writes must wait */
-
-		if (object->n_in_progress > 0) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-		} else if (!list_empty(&object->pending_ops)) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-			fscache_start_operations(object);
-		} else {
-			ASSERTCMP(object->n_in_progress, ==, 0);
-			fscache_run_op(object, op);
-		}
-
-		/* need to issue a new write op after this */
-		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
-		op->object = object;
-		object->n_ops++;
-		object->n_exclusive++;	/* reads and writes must wait */
-		atomic_inc(&op->usage);
-		list_add_tail(&op->pend_link, &object->pending_ops);
-		fscache_stat(&fscache_n_op_pend);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else {
-		fscache_report_unexpected_submission(object, op, ostate);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * submit an operation for an object
- * - objects may be submitted only in the following states:
- *   - during object creation (write ops may be submitted)
- *   - whilst the object is active
- *   - after an I/O error incurred in one of the two above states (op rejected)
- * - this gets any extra refs it needs on an op
- */
-int fscache_submit_op(struct fscache_object *object,
-		      struct fscache_operation *op)
-{
-	const struct fscache_state *ostate;
-	unsigned long flags;
-	int ret;
-
-	_enter("{OBJ%x OP%x},{%u}",
-	       object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	trace_fscache_op(object->cookie, op, fscache_op_submit);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
-	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
-	ASSERT(list_empty(&op->pend_link));
-
-	ostate = object->state;
-	smp_rmb();
-
-	op->state = FSCACHE_OP_ST_PENDING;
-	flags = READ_ONCE(object->flags);
-	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
-		fscache_stat(&fscache_n_op_rejected);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else if (unlikely(fscache_cache_is_broken(object))) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -EIO;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
-		op->object = object;
-		object->n_ops++;
-
-		if (object->n_exclusive > 0) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-		} else if (!list_empty(&object->pending_ops)) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-			fscache_start_operations(object);
-		} else {
-			ASSERTCMP(object->n_exclusive, ==, 0);
-			fscache_run_op(object, op);
-		}
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
-		op->object = object;
-		object->n_ops++;
-		atomic_inc(&op->usage);
-		list_add_tail(&op->pend_link, &object->pending_ops);
-		fscache_stat(&fscache_n_op_pend);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else {
-		fscache_report_unexpected_submission(object, op, ostate);
-		ASSERT(!fscache_object_is_active(object));
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * queue an object for withdrawal on error, aborting all following asynchronous
- * operations
- */
-void fscache_abort_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	fscache_raise_event(object, FSCACHE_OBJECT_EV_ERROR);
-}
-
-/*
- * Jump start the operation processing on an object.  The caller must hold
- * object->lock.
- */
-void fscache_start_operations(struct fscache_object *object)
-{
-	struct fscache_operation *op;
-	bool stop = false;
-
-	while (!list_empty(&object->pending_ops) && !stop) {
-		op = list_entry(object->pending_ops.next,
-				struct fscache_operation, pend_link);
-
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags)) {
-			if (object->n_in_progress > 0)
-				break;
-			stop = true;
-		}
-		list_del_init(&op->pend_link);
-		fscache_run_op(object, op);
-
-		/* the pending queue was holding a ref on the object */
-		fscache_put_operation(op);
-	}
-
-	ASSERTCMP(object->n_in_progress, <=, object->n_ops);
-
-	_debug("woke %d ops on OBJ%x",
-	       object->n_in_progress, object->debug_id);
-}
-
-/*
- * cancel an operation that's pending on an object
- */
-int fscache_cancel_op(struct fscache_operation *op,
-		      bool cancel_in_progress_op)
-{
-	struct fscache_object *object = op->object;
-	bool put = false;
-	int ret;
-
-	_enter("OBJ%x OP%x}", op->object->debug_id, op->debug_id);
-
-	trace_fscache_op(object->cookie, op, fscache_op_cancel);
-
-	ASSERTCMP(op->state, >=, FSCACHE_OP_ST_PENDING);
-	ASSERTCMP(op->state, !=, FSCACHE_OP_ST_CANCELLED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-
-	ret = -EBUSY;
-	if (op->state == FSCACHE_OP_ST_PENDING) {
-		ASSERT(!list_empty(&op->pend_link));
-		list_del_init(&op->pend_link);
-		put = true;
-
-		fscache_stat(&fscache_n_op_cancelled);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		ret = 0;
-	} else if (op->state == FSCACHE_OP_ST_IN_PROGRESS && cancel_in_progress_op) {
-		ASSERTCMP(object->n_in_progress, >, 0);
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		object->n_in_progress--;
-		if (object->n_in_progress == 0)
-			fscache_start_operations(object);
-
-		fscache_stat(&fscache_n_op_cancelled);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		ret = 0;
-	}
-
-	if (put)
-		fscache_put_operation(op);
-	spin_unlock(&object->lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * Cancel all pending operations on an object
- */
-void fscache_cancel_all_ops(struct fscache_object *object)
-{
-	struct fscache_operation *op;
-
-	_enter("OBJ%x", object->debug_id);
-
-	spin_lock(&object->lock);
-
-	while (!list_empty(&object->pending_ops)) {
-		op = list_entry(object->pending_ops.next,
-				struct fscache_operation, pend_link);
-		fscache_stat(&fscache_n_op_cancelled);
-		list_del_init(&op->pend_link);
-
-		trace_fscache_op(object->cookie, op, fscache_op_cancel_all);
-
-		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		fscache_put_operation(op);
-		cond_resched_lock(&object->lock);
-	}
-
-	spin_unlock(&object->lock);
-	_leave("");
-}
-
-/*
- * Record the completion or cancellation of an in-progress operation.
- */
-void fscache_op_complete(struct fscache_operation *op, bool cancelled)
-{
-	struct fscache_object *object = op->object;
-
-	_enter("OBJ%x", object->debug_id);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
-	ASSERTCMP(object->n_in_progress, >, 0);
-	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
-		    object->n_exclusive, >, 0);
-	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
-		    object->n_in_progress, ==, 1);
-
-	spin_lock(&object->lock);
-
-	if (!cancelled) {
-		trace_fscache_op(object->cookie, op, fscache_op_completed);
-		op->state = FSCACHE_OP_ST_COMPLETE;
-	} else {
-		op->cancel(op);
-		trace_fscache_op(object->cookie, op, fscache_op_cancelled);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-	}
-
-	if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-		object->n_exclusive--;
-	object->n_in_progress--;
-	if (object->n_in_progress == 0)
-		fscache_start_operations(object);
-
-	spin_unlock(&object->lock);
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_op_complete);
-
-/*
- * release an operation
- * - queues pending ops if this is the last in-progress op
- */
-void fscache_put_operation(struct fscache_operation *op)
-{
-	struct fscache_object *object;
-	struct fscache_cache *cache;
-
-	_enter("{OBJ%x OP%x,%d}",
-	       op->object ? op->object->debug_id : 0,
-	       op->debug_id, atomic_read(&op->usage));
-
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	if (!atomic_dec_and_test(&op->usage))
-		return;
-
-	trace_fscache_op(op->object ? op->object->cookie : NULL, op, fscache_op_put);
-
-	_debug("PUT OP");
-	ASSERTIFCMP(op->state != FSCACHE_OP_ST_INITIALISED &&
-		    op->state != FSCACHE_OP_ST_COMPLETE,
-		    op->state, ==, FSCACHE_OP_ST_CANCELLED);
-
-	fscache_stat(&fscache_n_op_release);
-
-	if (op->release) {
-		op->release(op);
-		op->release = NULL;
-	}
-	op->state = FSCACHE_OP_ST_DEAD;
-
-	object = op->object;
-	if (likely(object)) {
-		if (test_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags))
-			atomic_dec(&object->n_reads);
-		if (test_bit(FSCACHE_OP_UNUSE_COOKIE, &op->flags))
-			fscache_unuse_cookie(object);
-
-		/* now... we may get called with the object spinlock held, so we
-		 * complete the cleanup here only if we can immediately acquire the
-		 * lock, and defer it otherwise */
-		if (!spin_trylock(&object->lock)) {
-			_debug("defer put");
-			fscache_stat(&fscache_n_op_deferred_release);
-
-			cache = object->cache;
-			spin_lock(&cache->op_gc_list_lock);
-			list_add_tail(&op->pend_link, &cache->op_gc_list);
-			spin_unlock(&cache->op_gc_list_lock);
-			schedule_work(&cache->op_gc);
-			_leave(" [defer]");
-			return;
-		}
-
-		ASSERTCMP(object->n_ops, >, 0);
-		object->n_ops--;
-		if (object->n_ops == 0)
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
-
-		spin_unlock(&object->lock);
-	}
-
-	kfree(op);
-	_leave(" [done]");
-}
-EXPORT_SYMBOL(fscache_put_operation);
-
-/*
- * garbage collect operations that have had their release deferred
- */
-void fscache_operation_gc(struct work_struct *work)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	struct fscache_cache *cache =
-		container_of(work, struct fscache_cache, op_gc);
-	int count = 0;
-
-	_enter("");
-
-	do {
-		spin_lock(&cache->op_gc_list_lock);
-		if (list_empty(&cache->op_gc_list)) {
-			spin_unlock(&cache->op_gc_list_lock);
-			break;
-		}
-
-		op = list_entry(cache->op_gc_list.next,
-				struct fscache_operation, pend_link);
-		list_del(&op->pend_link);
-		spin_unlock(&cache->op_gc_list_lock);
-
-		object = op->object;
-		trace_fscache_op(object->cookie, op, fscache_op_gc);
-
-		spin_lock(&object->lock);
-
-		_debug("GC DEFERRED REL OBJ%x OP%x",
-		       object->debug_id, op->debug_id);
-		fscache_stat(&fscache_n_op_gc);
-
-		ASSERTCMP(atomic_read(&op->usage), ==, 0);
-		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_DEAD);
-
-		ASSERTCMP(object->n_ops, >, 0);
-		object->n_ops--;
-		if (object->n_ops == 0)
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
-
-		spin_unlock(&object->lock);
-		kfree(op);
-
-	} while (count++ < 20);
-
-	if (!list_empty(&cache->op_gc_list))
-		schedule_work(&cache->op_gc);
-
-	_leave("");
-}
-
-/*
- * execute an operation using fs_op_wq to provide processing context -
- * the caller holds a ref to this object, so we don't need to hold one
- */
-void fscache_op_work_func(struct work_struct *work)
-{
-	struct fscache_operation *op =
-		container_of(work, struct fscache_operation, work);
-
-	_enter("{OBJ%x OP%x,%d}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	trace_fscache_op(op->object->cookie, op, fscache_op_work);
-
-	ASSERT(op->processor != NULL);
-	op->processor(op);
-	fscache_put_operation(op);
-
-	_leave("");
-}
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
deleted file mode 100644
index 3fd6a2b45fed..000000000000
--- a/fs/fscache/page.c
+++ /dev/null
@@ -1,176 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Cache page management and data I/O routines
- *
- * Copyright (C) 2004-2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL PAGE
-#include <linux/module.h>
-#include <linux/fscache-cache.h>
-#include <linux/buffer_head.h>
-#include <linux/pagevec.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-/*
- * actually apply the changed attributes to a cache object
- */
-static void fscache_attr_changed_op(struct fscache_operation *op)
-{
-	struct fscache_object *object = op->object;
-	int ret;
-
-	_enter("{OBJ%x OP%x}", object->debug_id, op->debug_id);
-
-	fscache_stat(&fscache_n_attr_changed_calls);
-
-	if (fscache_object_is_active(object)) {
-		fscache_stat(&fscache_n_cop_attr_changed);
-		ret = object->cache->ops->attr_changed(object);
-		fscache_stat_d(&fscache_n_cop_attr_changed);
-		if (ret < 0)
-			fscache_abort_object(object);
-		fscache_op_complete(op, ret < 0);
-	} else {
-		fscache_op_complete(op, true);
-	}
-
-	_leave("");
-}
-
-/*
- * notification that the attributes on an object have changed
- */
-int __fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-
-	_enter("%p", cookie);
-
-	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-
-	fscache_stat(&fscache_n_attr_changed);
-
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op) {
-		fscache_stat(&fscache_n_attr_changed_nomem);
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	fscache_operation_init(cookie, op, fscache_attr_changed_op, NULL, NULL);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_attr_changed);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto nobufs_dec;
-	spin_unlock(&cookie->lock);
-	fscache_stat(&fscache_n_attr_changed_ok);
-	fscache_put_operation(op);
-	_leave(" = 0");
-	return 0;
-
-nobufs_dec:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs:
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_stat(&fscache_n_attr_changed_nobufs);
-	_leave(" = %d", -ENOBUFS);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_attr_changed);
-
-/*
- * wait for a deferred lookup to complete
- */
-int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
-{
-	_enter("");
-
-	if (!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags)) {
-		_leave(" = 0 [imm]");
-		return 0;
-	}
-
-	fscache_stat(&fscache_n_retrievals_wait);
-
-	if (wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
-			TASK_INTERRUPTIBLE) != 0) {
-		fscache_stat(&fscache_n_retrievals_intr);
-		_leave(" = -ERESTARTSYS");
-		return -ERESTARTSYS;
-	}
-
-	ASSERT(!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags));
-
-	smp_rmb();
-	_leave(" = 0 [dly]");
-	return 0;
-}
-
-/*
- * wait for an object to become active (or dead)
- */
-int fscache_wait_for_operation_activation(struct fscache_object *object,
-					  struct fscache_operation *op,
-					  atomic_t *stat_op_waits,
-					  atomic_t *stat_object_dead)
-{
-	int ret;
-
-	if (!test_bit(FSCACHE_OP_WAITING, &op->flags))
-		goto check_if_dead;
-
-	_debug(">>> WT");
-	if (stat_op_waits)
-		fscache_stat(stat_op_waits);
-	if (wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
-			TASK_INTERRUPTIBLE) != 0) {
-		trace_fscache_op(object->cookie, op, fscache_op_signal);
-		ret = fscache_cancel_op(op, false);
-		if (ret == 0)
-			return -ERESTARTSYS;
-
-		/* it's been removed from the pending queue by another party,
-		 * so we should get to run shortly */
-		wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
-			    TASK_UNINTERRUPTIBLE);
-	}
-	_debug("<<< GO");
-
-check_if_dead:
-	if (op->state == FSCACHE_OP_ST_CANCELLED) {
-		if (stat_object_dead)
-			fscache_stat(stat_object_dead);
-		_leave(" = -ENOBUFS [cancelled]");
-		return -ENOBUFS;
-	}
-	if (unlikely(fscache_object_is_dying(object) ||
-		     fscache_cache_is_broken(object))) {
-		enum fscache_operation_state state = op->state;
-		trace_fscache_op(object->cookie, op, fscache_op_signal);
-		fscache_cancel_op(op, true);
-		if (stat_object_dead)
-			fscache_stat(stat_object_dead);
-		_leave(" = -ENOBUFS [obj dead %d]", state);
-		return -ENOBUFS;
-	}
-	return 0;
-}
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
deleted file mode 100644
index 061df8f61ffc..000000000000
--- a/fs/fscache/proc.c
+++ /dev/null
@@ -1,71 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache statistics viewing interface
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL OPERATION
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include "internal.h"
-
-/*
- * initialise the /proc/fs/fscache/ directory
- */
-int __init fscache_proc_init(void)
-{
-	_enter("");
-
-	if (!proc_mkdir("fs/fscache", NULL))
-		goto error_dir;
-
-	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
-			     &fscache_cookies_seq_ops))
-		goto error_cookies;
-
-#ifdef CONFIG_FSCACHE_STATS
-	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
-			fscache_stats_show))
-		goto error_stats;
-#endif
-
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
-			 &fscache_objlist_proc_ops))
-		goto error_objects;
-#endif
-
-	_leave(" = 0");
-	return 0;
-
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-error_objects:
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-error_stats:
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
-error_cookies:
-	remove_proc_entry("fs/fscache", NULL);
-error_dir:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-
-/*
- * clean up the /proc/fs/fscache/ directory
- */
-void fscache_proc_cleanup(void)
-{
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	remove_proc_entry("fs/fscache/objects", NULL);
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
-	remove_proc_entry("fs/fscache", NULL);
-}
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
deleted file mode 100644
index 2449aa459140..000000000000
--- a/fs/fscache/stats.c
+++ /dev/null
@@ -1,226 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache statistics
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL THREAD
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include "internal.h"
-
-/*
- * operation counters
- */
-atomic_t fscache_n_op_pend;
-atomic_t fscache_n_op_run;
-atomic_t fscache_n_op_enqueue;
-atomic_t fscache_n_op_deferred_release;
-atomic_t fscache_n_op_initialised;
-atomic_t fscache_n_op_release;
-atomic_t fscache_n_op_gc;
-atomic_t fscache_n_op_cancelled;
-atomic_t fscache_n_op_rejected;
-
-atomic_t fscache_n_attr_changed;
-atomic_t fscache_n_attr_changed_ok;
-atomic_t fscache_n_attr_changed_nobufs;
-atomic_t fscache_n_attr_changed_nomem;
-atomic_t fscache_n_attr_changed_calls;
-
-atomic_t fscache_n_retrievals;
-atomic_t fscache_n_retrievals_ok;
-atomic_t fscache_n_retrievals_wait;
-atomic_t fscache_n_retrievals_nodata;
-atomic_t fscache_n_retrievals_nobufs;
-atomic_t fscache_n_retrievals_intr;
-atomic_t fscache_n_retrievals_nomem;
-atomic_t fscache_n_retrievals_object_dead;
-atomic_t fscache_n_retrieval_ops;
-atomic_t fscache_n_retrieval_op_waits;
-
-atomic_t fscache_n_stores;
-atomic_t fscache_n_stores_ok;
-atomic_t fscache_n_stores_again;
-atomic_t fscache_n_stores_nobufs;
-atomic_t fscache_n_stores_intr;
-atomic_t fscache_n_stores_oom;
-atomic_t fscache_n_store_ops;
-atomic_t fscache_n_stores_object_dead;
-atomic_t fscache_n_store_op_waits;
-
-atomic_t fscache_n_acquires;
-atomic_t fscache_n_acquires_null;
-atomic_t fscache_n_acquires_no_cache;
-atomic_t fscache_n_acquires_ok;
-atomic_t fscache_n_acquires_nobufs;
-atomic_t fscache_n_acquires_oom;
-
-atomic_t fscache_n_invalidates;
-atomic_t fscache_n_invalidates_run;
-
-atomic_t fscache_n_updates;
-atomic_t fscache_n_updates_null;
-atomic_t fscache_n_updates_run;
-
-atomic_t fscache_n_relinquishes;
-atomic_t fscache_n_relinquishes_null;
-atomic_t fscache_n_relinquishes_waitcrt;
-atomic_t fscache_n_relinquishes_retire;
-
-atomic_t fscache_n_cookie_index;
-atomic_t fscache_n_cookie_data;
-atomic_t fscache_n_cookie_special;
-
-atomic_t fscache_n_object_alloc;
-atomic_t fscache_n_object_no_alloc;
-atomic_t fscache_n_object_lookups;
-atomic_t fscache_n_object_lookups_negative;
-atomic_t fscache_n_object_lookups_positive;
-atomic_t fscache_n_object_lookups_timed_out;
-atomic_t fscache_n_object_created;
-atomic_t fscache_n_object_avail;
-atomic_t fscache_n_object_dead;
-
-atomic_t fscache_n_checkaux_none;
-atomic_t fscache_n_checkaux_okay;
-atomic_t fscache_n_checkaux_update;
-atomic_t fscache_n_checkaux_obsolete;
-
-atomic_t fscache_n_cop_alloc_object;
-atomic_t fscache_n_cop_lookup_object;
-atomic_t fscache_n_cop_lookup_complete;
-atomic_t fscache_n_cop_grab_object;
-atomic_t fscache_n_cop_invalidate_object;
-atomic_t fscache_n_cop_update_object;
-atomic_t fscache_n_cop_drop_object;
-atomic_t fscache_n_cop_put_object;
-atomic_t fscache_n_cop_sync_cache;
-atomic_t fscache_n_cop_attr_changed;
-
-atomic_t fscache_n_cache_no_space_reject;
-atomic_t fscache_n_cache_stale_objects;
-atomic_t fscache_n_cache_retired_objects;
-atomic_t fscache_n_cache_culled_objects;
-
-/*
- * display the general statistics
- */
-int fscache_stats_show(struct seq_file *m, void *v)
-{
-	seq_puts(m, "FS-Cache statistics\n");
-
-	seq_printf(m, "Cookies: idx=%u dat=%u spc=%u\n",
-		   atomic_read(&fscache_n_cookie_index),
-		   atomic_read(&fscache_n_cookie_data),
-		   atomic_read(&fscache_n_cookie_special));
-
-	seq_printf(m, "Objects: alc=%u nal=%u avl=%u ded=%u\n",
-		   atomic_read(&fscache_n_object_alloc),
-		   atomic_read(&fscache_n_object_no_alloc),
-		   atomic_read(&fscache_n_object_avail),
-		   atomic_read(&fscache_n_object_dead));
-	seq_printf(m, "ChkAux : non=%u ok=%u upd=%u obs=%u\n",
-		   atomic_read(&fscache_n_checkaux_none),
-		   atomic_read(&fscache_n_checkaux_okay),
-		   atomic_read(&fscache_n_checkaux_update),
-		   atomic_read(&fscache_n_checkaux_obsolete));
-
-	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
-		   " oom=%u\n",
-		   atomic_read(&fscache_n_acquires),
-		   atomic_read(&fscache_n_acquires_null),
-		   atomic_read(&fscache_n_acquires_no_cache),
-		   atomic_read(&fscache_n_acquires_ok),
-		   atomic_read(&fscache_n_acquires_nobufs),
-		   atomic_read(&fscache_n_acquires_oom));
-
-	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u tmo=%u\n",
-		   atomic_read(&fscache_n_object_lookups),
-		   atomic_read(&fscache_n_object_lookups_negative),
-		   atomic_read(&fscache_n_object_lookups_positive),
-		   atomic_read(&fscache_n_object_created),
-		   atomic_read(&fscache_n_object_lookups_timed_out));
-
-	seq_printf(m, "Invals : n=%u run=%u\n",
-		   atomic_read(&fscache_n_invalidates),
-		   atomic_read(&fscache_n_invalidates_run));
-
-	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
-		   atomic_read(&fscache_n_updates),
-		   atomic_read(&fscache_n_updates_null),
-		   atomic_read(&fscache_n_updates_run));
-
-	seq_printf(m, "Relinqs: n=%u nul=%u wcr=%u rtr=%u\n",
-		   atomic_read(&fscache_n_relinquishes),
-		   atomic_read(&fscache_n_relinquishes_null),
-		   atomic_read(&fscache_n_relinquishes_waitcrt),
-		   atomic_read(&fscache_n_relinquishes_retire));
-
-	seq_printf(m, "AttrChg: n=%u ok=%u nbf=%u oom=%u run=%u\n",
-		   atomic_read(&fscache_n_attr_changed),
-		   atomic_read(&fscache_n_attr_changed_ok),
-		   atomic_read(&fscache_n_attr_changed_nobufs),
-		   atomic_read(&fscache_n_attr_changed_nomem),
-		   atomic_read(&fscache_n_attr_changed_calls));
-
-	seq_printf(m, "Retrvls: n=%u ok=%u wt=%u nod=%u nbf=%u"
-		   " int=%u oom=%u\n",
-		   atomic_read(&fscache_n_retrievals),
-		   atomic_read(&fscache_n_retrievals_ok),
-		   atomic_read(&fscache_n_retrievals_wait),
-		   atomic_read(&fscache_n_retrievals_nodata),
-		   atomic_read(&fscache_n_retrievals_nobufs),
-		   atomic_read(&fscache_n_retrievals_intr),
-		   atomic_read(&fscache_n_retrievals_nomem));
-	seq_printf(m, "Retrvls: ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_retrieval_ops),
-		   atomic_read(&fscache_n_retrieval_op_waits),
-		   atomic_read(&fscache_n_retrievals_object_dead));
-
-	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u int=%u oom=%u\n",
-		   atomic_read(&fscache_n_stores),
-		   atomic_read(&fscache_n_stores_ok),
-		   atomic_read(&fscache_n_stores_again),
-		   atomic_read(&fscache_n_stores_nobufs),
-		   atomic_read(&fscache_n_stores_intr),
-		   atomic_read(&fscache_n_stores_oom));
-	seq_printf(m, "Stores : ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_store_ops),
-		   atomic_read(&fscache_n_store_op_waits),
-		   atomic_read(&fscache_n_stores_object_dead));
-
-	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
-		   atomic_read(&fscache_n_op_pend),
-		   atomic_read(&fscache_n_op_run),
-		   atomic_read(&fscache_n_op_enqueue),
-		   atomic_read(&fscache_n_op_cancelled),
-		   atomic_read(&fscache_n_op_rejected));
-	seq_printf(m, "Ops    : ini=%u dfr=%u rel=%u gc=%u\n",
-		   atomic_read(&fscache_n_op_initialised),
-		   atomic_read(&fscache_n_op_deferred_release),
-		   atomic_read(&fscache_n_op_release),
-		   atomic_read(&fscache_n_op_gc));
-
-	seq_printf(m, "CacheOp: alo=%d luo=%d luc=%d gro=%d\n",
-		   atomic_read(&fscache_n_cop_alloc_object),
-		   atomic_read(&fscache_n_cop_lookup_object),
-		   atomic_read(&fscache_n_cop_lookup_complete),
-		   atomic_read(&fscache_n_cop_grab_object));
-	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
-		   atomic_read(&fscache_n_cop_invalidate_object),
-		   atomic_read(&fscache_n_cop_update_object),
-		   atomic_read(&fscache_n_cop_drop_object),
-		   atomic_read(&fscache_n_cop_put_object),
-		   atomic_read(&fscache_n_cop_attr_changed),
-		   atomic_read(&fscache_n_cop_sync_cache));
-	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
-		   atomic_read(&fscache_n_cache_no_space_reject),
-		   atomic_read(&fscache_n_cache_stale_objects),
-		   atomic_read(&fscache_n_cache_retired_objects),
-		   atomic_read(&fscache_n_cache_culled_objects));
-	netfs_stats_show(m);
-	return 0;
-}
diff --git a/fs/fscache_old/Kconfig b/fs/fscache_old/Kconfig
new file mode 100644
index 000000000000..b313a978ae0a
--- /dev/null
+++ b/fs/fscache_old/Kconfig
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FSCACHE
+	tristate "General filesystem local caching manager"
+	select NETFS_SUPPORT
+	help
+	  This option enables a generic filesystem caching manager that can be
+	  used by various network and other filesystems to cache data locally.
+	  Different sorts of caches can be plugged in, depending on the
+	  resources available.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
+
+config FSCACHE_STATS
+	bool "Gather statistical information on local caching"
+	depends on FSCACHE && PROC_FS
+	select NETFS_STATS
+	help
+	  This option causes statistical information to be gathered on local
+	  caching and exported through file:
+
+		/proc/fs/fscache/stats
+
+	  The gathering of statistics adds a certain amount of overhead to
+	  execution as there are a quite a few stats gathered, and on a
+	  multi-CPU system these may be on cachelines that keep bouncing
+	  between CPUs.  On the other hand, the stats are very useful for
+	  debugging purposes.  Saying 'Y' here is recommended.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
+
+config FSCACHE_DEBUG
+	bool "Debug FS-Cache"
+	depends on FSCACHE
+	help
+	  This permits debugging to be dynamically enabled in the local caching
+	  management module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
diff --git a/fs/fscache_old/Makefile b/fs/fscache_old/Makefile
new file mode 100644
index 000000000000..03a871d689bb
--- /dev/null
+++ b/fs/fscache_old/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for general filesystem caching code
+#
+
+fscache-y := \
+	cache.o \
+	cookie.o \
+	fsdef.o \
+	io.o \
+	main.o \
+	netfs.o \
+	object.o \
+	operation.o \
+	page.o
+
+fscache-$(CONFIG_PROC_FS) += proc.o
+fscache-$(CONFIG_FSCACHE_STATS) += stats.o
+
+obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache_old/cache.c b/fs/fscache_old/cache.c
new file mode 100644
index 000000000000..cfa60c2faf68
--- /dev/null
+++ b/fs/fscache_old/cache.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache cache handling
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+LIST_HEAD(fscache_cache_list);
+DECLARE_RWSEM(fscache_addremove_sem);
+DECLARE_WAIT_QUEUE_HEAD(fscache_cache_cleared_wq);
+EXPORT_SYMBOL(fscache_cache_cleared_wq);
+
+static LIST_HEAD(fscache_cache_tag_list);
+
+/*
+ * look up a cache tag
+ */
+struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
+{
+	struct fscache_cache_tag *tag, *xtag;
+
+	/* firstly check for the existence of the tag under read lock */
+	down_read(&fscache_addremove_sem);
+
+	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
+		if (strcmp(tag->name, name) == 0) {
+			atomic_inc(&tag->usage);
+			up_read(&fscache_addremove_sem);
+			return tag;
+		}
+	}
+
+	up_read(&fscache_addremove_sem);
+
+	/* the tag does not exist - create a candidate */
+	xtag = kzalloc(sizeof(*xtag) + strlen(name) + 1, GFP_KERNEL);
+	if (!xtag)
+		/* return a dummy tag if out of memory */
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&xtag->usage, 1);
+	strcpy(xtag->name, name);
+
+	/* write lock, search again and add if still not present */
+	down_write(&fscache_addremove_sem);
+
+	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
+		if (strcmp(tag->name, name) == 0) {
+			atomic_inc(&tag->usage);
+			up_write(&fscache_addremove_sem);
+			kfree(xtag);
+			return tag;
+		}
+	}
+
+	list_add_tail(&xtag->link, &fscache_cache_tag_list);
+	up_write(&fscache_addremove_sem);
+	return xtag;
+}
+
+/*
+ * release a reference to a cache tag
+ */
+void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
+{
+	if (tag != ERR_PTR(-ENOMEM)) {
+		down_write(&fscache_addremove_sem);
+
+		if (atomic_dec_and_test(&tag->usage))
+			list_del_init(&tag->link);
+		else
+			tag = NULL;
+
+		up_write(&fscache_addremove_sem);
+
+		kfree(tag);
+	}
+}
+
+/*
+ * select a cache in which to store an object
+ * - the cache addremove semaphore must be at least read-locked by the caller
+ * - the object will never be an index
+ */
+struct fscache_cache *fscache_select_cache_for_object(
+	struct fscache_cookie *cookie)
+{
+	struct fscache_cache_tag *tag;
+	struct fscache_object *object;
+	struct fscache_cache *cache;
+
+	_enter("");
+
+	if (list_empty(&fscache_cache_list)) {
+		_leave(" = NULL [no cache]");
+		return NULL;
+	}
+
+	/* we check the parent to determine the cache to use */
+	spin_lock(&cookie->lock);
+
+	/* the first in the parent's backing list should be the preferred
+	 * cache */
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+
+		cache = object->cache;
+		if (fscache_object_is_dying(object) ||
+		    test_bit(FSCACHE_IOERROR, &cache->flags))
+			cache = NULL;
+
+		spin_unlock(&cookie->lock);
+		_leave(" = %s [parent]", cache ? cache->tag->name : "NULL");
+		return cache;
+	}
+
+	/* the parent is unbacked */
+	if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		/* cookie not an index and is unbacked */
+		spin_unlock(&cookie->lock);
+		_leave(" = NULL [cookie ub,ni]");
+		return NULL;
+	}
+
+	spin_unlock(&cookie->lock);
+
+	if (!cookie->def->select_cache)
+		goto no_preference;
+
+	/* ask the netfs for its preference */
+	tag = cookie->def->select_cache(cookie->parent->netfs_data,
+					cookie->netfs_data);
+	if (!tag)
+		goto no_preference;
+
+	if (tag == ERR_PTR(-ENOMEM)) {
+		_leave(" = NULL [nomem tag]");
+		return NULL;
+	}
+
+	if (!tag->cache) {
+		_leave(" = NULL [unbacked tag]");
+		return NULL;
+	}
+
+	if (test_bit(FSCACHE_IOERROR, &tag->cache->flags))
+		return NULL;
+
+	_leave(" = %s [specific]", tag->name);
+	return tag->cache;
+
+no_preference:
+	/* netfs has no preference - just select first cache */
+	cache = list_entry(fscache_cache_list.next,
+			   struct fscache_cache, link);
+	_leave(" = %s [first]", cache->tag->name);
+	return cache;
+}
+
+/**
+ * fscache_init_cache - Initialise a cache record
+ * @cache: The cache record to be initialised
+ * @ops: The cache operations to be installed in that record
+ * @idfmt: Format string to define identifier
+ * @...: sprintf-style arguments
+ *
+ * Initialise a record of a cache and fill in the name.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+void fscache_init_cache(struct fscache_cache *cache,
+			const struct fscache_cache_ops *ops,
+			const char *idfmt,
+			...)
+{
+	va_list va;
+
+	memset(cache, 0, sizeof(*cache));
+
+	cache->ops = ops;
+
+	va_start(va, idfmt);
+	vsnprintf(cache->identifier, sizeof(cache->identifier), idfmt, va);
+	va_end(va);
+
+	INIT_WORK(&cache->op_gc, fscache_operation_gc);
+	INIT_LIST_HEAD(&cache->link);
+	INIT_LIST_HEAD(&cache->object_list);
+	INIT_LIST_HEAD(&cache->op_gc_list);
+	spin_lock_init(&cache->object_list_lock);
+	spin_lock_init(&cache->op_gc_list_lock);
+}
+EXPORT_SYMBOL(fscache_init_cache);
+
+/**
+ * fscache_add_cache - Declare a cache as being open for business
+ * @cache: The record describing the cache
+ * @ifsdef: The record of the cache object describing the top-level index
+ * @tagname: The tag describing this cache
+ *
+ * Add a cache to the system, making it available for netfs's to use.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+int fscache_add_cache(struct fscache_cache *cache,
+		      struct fscache_object *ifsdef,
+		      const char *tagname)
+{
+	struct fscache_cache_tag *tag;
+
+	ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
+	BUG_ON(!cache->ops);
+	BUG_ON(!ifsdef);
+
+	cache->flags = 0;
+	ifsdef->event_mask =
+		((1 << NR_FSCACHE_OBJECT_EVENTS) - 1) &
+		~(1 << FSCACHE_OBJECT_EV_CLEARED);
+	__set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &ifsdef->flags);
+
+	if (!tagname)
+		tagname = cache->identifier;
+
+	BUG_ON(!tagname[0]);
+
+	_enter("{%s.%s},,%s", cache->ops->name, cache->identifier, tagname);
+
+	/* we use the cache tag to uniquely identify caches */
+	tag = __fscache_lookup_cache_tag(tagname);
+	if (IS_ERR(tag))
+		goto nomem;
+
+	if (test_and_set_bit(FSCACHE_TAG_RESERVED, &tag->flags))
+		goto tag_in_use;
+
+	cache->kobj = kobject_create_and_add(tagname, fscache_root);
+	if (!cache->kobj)
+		goto error;
+
+	ifsdef->cache = cache;
+	cache->fsdef = ifsdef;
+
+	down_write(&fscache_addremove_sem);
+
+	tag->cache = cache;
+	cache->tag = tag;
+
+	/* add the cache to the list */
+	list_add(&cache->link, &fscache_cache_list);
+
+	/* add the cache's netfs definition index object to the cache's
+	 * list */
+	spin_lock(&cache->object_list_lock);
+	list_add_tail(&ifsdef->cache_link, &cache->object_list);
+	spin_unlock(&cache->object_list_lock);
+
+	/* add the cache's netfs definition index object to the top level index
+	 * cookie as a known backing object */
+	spin_lock(&fscache_fsdef_index.lock);
+
+	hlist_add_head(&ifsdef->cookie_link,
+		       &fscache_fsdef_index.backing_objects);
+
+	refcount_inc(&fscache_fsdef_index.ref);
+
+	/* done */
+	spin_unlock(&fscache_fsdef_index.lock);
+	up_write(&fscache_addremove_sem);
+
+	pr_notice("Cache \"%s\" added (type %s)\n",
+		  cache->tag->name, cache->ops->name);
+	kobject_uevent(cache->kobj, KOBJ_ADD);
+
+	_leave(" = 0 [%s]", cache->identifier);
+	return 0;
+
+tag_in_use:
+	pr_err("Cache tag '%s' already in use\n", tagname);
+	__fscache_release_cache_tag(tag);
+	_leave(" = -EXIST");
+	return -EEXIST;
+
+error:
+	__fscache_release_cache_tag(tag);
+	_leave(" = -EINVAL");
+	return -EINVAL;
+
+nomem:
+	_leave(" = -ENOMEM");
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(fscache_add_cache);
+
+/**
+ * fscache_io_error - Note a cache I/O error
+ * @cache: The record describing the cache
+ *
+ * Note that an I/O error occurred in a cache and that it should no longer be
+ * used for anything.  This also reports the error into the kernel log.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+void fscache_io_error(struct fscache_cache *cache)
+{
+	if (!test_and_set_bit(FSCACHE_IOERROR, &cache->flags))
+		pr_err("Cache '%s' stopped due to I/O error\n",
+		       cache->ops->name);
+}
+EXPORT_SYMBOL(fscache_io_error);
+
+/*
+ * request withdrawal of all the objects in a cache
+ * - all the objects being withdrawn are moved onto the supplied list
+ */
+static void fscache_withdraw_all_objects(struct fscache_cache *cache,
+					 struct list_head *dying_objects)
+{
+	struct fscache_object *object;
+
+	while (!list_empty(&cache->object_list)) {
+		spin_lock(&cache->object_list_lock);
+
+		if (!list_empty(&cache->object_list)) {
+			object = list_entry(cache->object_list.next,
+					    struct fscache_object, cache_link);
+			list_move_tail(&object->cache_link, dying_objects);
+
+			_debug("withdraw %x", object->cookie->debug_id);
+
+			/* This must be done under object_list_lock to prevent
+			 * a race with fscache_drop_object().
+			 */
+			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
+		}
+
+		spin_unlock(&cache->object_list_lock);
+		cond_resched();
+	}
+}
+
+/**
+ * fscache_withdraw_cache - Withdraw a cache from the active service
+ * @cache: The record describing the cache
+ *
+ * Withdraw a cache from service, unbinding all its cache objects from the
+ * netfs cookies they're currently representing.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+void fscache_withdraw_cache(struct fscache_cache *cache)
+{
+	LIST_HEAD(dying_objects);
+
+	_enter("");
+
+	pr_notice("Withdrawing cache \"%s\"\n",
+		  cache->tag->name);
+
+	/* make the cache unavailable for cookie acquisition */
+	if (test_and_set_bit(FSCACHE_CACHE_WITHDRAWN, &cache->flags))
+		BUG();
+
+	down_write(&fscache_addremove_sem);
+	list_del_init(&cache->link);
+	cache->tag->cache = NULL;
+	up_write(&fscache_addremove_sem);
+
+	/* make sure all pages pinned by operations on behalf of the netfs are
+	 * written to disk */
+	fscache_stat(&fscache_n_cop_sync_cache);
+	cache->ops->sync_cache(cache);
+	fscache_stat_d(&fscache_n_cop_sync_cache);
+
+	/* we now have to destroy all the active objects pertaining to this
+	 * cache - which we do by passing them off to thread pool to be
+	 * disposed of */
+	_debug("destroy");
+
+	fscache_withdraw_all_objects(cache, &dying_objects);
+
+	/* wait for all extant objects to finish their outstanding operations
+	 * and go away */
+	_debug("wait for finish");
+	wait_event(fscache_cache_cleared_wq,
+		   atomic_read(&cache->object_count) == 0);
+	_debug("wait for clearance");
+	wait_event(fscache_cache_cleared_wq,
+		   list_empty(&cache->object_list));
+	_debug("cleared");
+	ASSERT(list_empty(&dying_objects));
+
+	kobject_put(cache->kobj);
+
+	clear_bit(FSCACHE_TAG_RESERVED, &cache->tag->flags);
+	fscache_release_cache_tag(cache->tag);
+	cache->tag = NULL;
+
+	_leave("");
+}
+EXPORT_SYMBOL(fscache_withdraw_cache);
diff --git a/fs/fscache_old/cookie.c b/fs/fscache_old/cookie.c
new file mode 100644
index 000000000000..8a850c3d0775
--- /dev/null
+++ b/fs/fscache_old/cookie.c
@@ -0,0 +1,1061 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* netfs cookie management
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for more information on
+ * the netfs API.
+ */
+
+#define FSCACHE_DEBUG_LEVEL COOKIE
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+struct kmem_cache *fscache_cookie_jar;
+
+static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
+
+#define fscache_cookie_hash_shift 15
+static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
+static LIST_HEAD(fscache_cookies);
+static DEFINE_RWLOCK(fscache_cookies_lock);
+
+static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
+					    loff_t object_size);
+static int fscache_alloc_object(struct fscache_cache *cache,
+				struct fscache_cookie *cookie);
+static int fscache_attach_object(struct fscache_cookie *cookie,
+				 struct fscache_object *object);
+
+static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
+{
+	struct fscache_object *object;
+	struct hlist_node *o;
+	const u8 *k;
+	unsigned loop;
+
+	pr_err("%c-cookie c=%08x [p=%08x fl=%lx nc=%u na=%u]\n",
+	       prefix,
+	       cookie->debug_id,
+	       cookie->parent ? cookie->parent->debug_id : 0,
+	       cookie->flags,
+	       atomic_read(&cookie->n_children),
+	       atomic_read(&cookie->n_active));
+	pr_err("%c-cookie d=%p{%s} n=%p\n",
+	       prefix,
+	       cookie->def,
+	       cookie->def ? cookie->def->name : "?",
+	       cookie->netfs_data);
+
+	o = READ_ONCE(cookie->backing_objects.first);
+	if (o) {
+		object = hlist_entry(o, struct fscache_object, cookie_link);
+		pr_err("%c-cookie o=%u\n", prefix, object->debug_id);
+	}
+
+	pr_err("%c-key=[%u] '", prefix, cookie->key_len);
+	k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
+		cookie->inline_key : cookie->key;
+	for (loop = 0; loop < cookie->key_len; loop++)
+		pr_cont("%02x", k[loop]);
+	pr_cont("'\n");
+}
+
+void fscache_free_cookie(struct fscache_cookie *cookie)
+{
+	if (cookie) {
+		BUG_ON(!hlist_empty(&cookie->backing_objects));
+		write_lock(&fscache_cookies_lock);
+		list_del(&cookie->proc_link);
+		write_unlock(&fscache_cookies_lock);
+		if (cookie->aux_len > sizeof(cookie->inline_aux))
+			kfree(cookie->aux);
+		if (cookie->key_len > sizeof(cookie->inline_key))
+			kfree(cookie->key);
+		kmem_cache_free(fscache_cookie_jar, cookie);
+	}
+}
+
+/*
+ * Set the index key in a cookie.  The cookie struct has space for a 16-byte
+ * key plus length and hash, but if that's not big enough, it's instead a
+ * pointer to a buffer containing 3 bytes of hash, 1 byte of length and then
+ * the key data.
+ */
+static int fscache_set_key(struct fscache_cookie *cookie,
+			   const void *index_key, size_t index_key_len)
+{
+	u32 *buf;
+	int bufs;
+
+	bufs = DIV_ROUND_UP(index_key_len, sizeof(*buf));
+
+	if (index_key_len > sizeof(cookie->inline_key)) {
+		buf = kcalloc(bufs, sizeof(*buf), GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		cookie->key = buf;
+	} else {
+		buf = (u32 *)cookie->inline_key;
+	}
+
+	memcpy(buf, index_key, index_key_len);
+	cookie->key_hash = fscache_hash(0, buf, bufs);
+	return 0;
+}
+
+static long fscache_compare_cookie(const struct fscache_cookie *a,
+				   const struct fscache_cookie *b)
+{
+	const void *ka, *kb;
+
+	if (a->key_hash != b->key_hash)
+		return (long)a->key_hash - (long)b->key_hash;
+	if (a->parent != b->parent)
+		return (long)a->parent - (long)b->parent;
+	if (a->key_len != b->key_len)
+		return (long)a->key_len - (long)b->key_len;
+	if (a->type != b->type)
+		return (long)a->type - (long)b->type;
+
+	if (a->key_len <= sizeof(a->inline_key)) {
+		ka = &a->inline_key;
+		kb = &b->inline_key;
+	} else {
+		ka = a->key;
+		kb = b->key;
+	}
+	return memcmp(ka, kb, a->key_len);
+}
+
+static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
+
+/*
+ * Allocate a cookie.
+ */
+struct fscache_cookie *fscache_alloc_cookie(
+	struct fscache_cookie *parent,
+	const struct fscache_cookie_def *def,
+	const void *index_key, size_t index_key_len,
+	const void *aux_data, size_t aux_data_len,
+	void *netfs_data,
+	loff_t object_size)
+{
+	struct fscache_cookie *cookie;
+
+	/* allocate and initialise a cookie */
+	cookie = kmem_cache_zalloc(fscache_cookie_jar, GFP_KERNEL);
+	if (!cookie)
+		return NULL;
+
+	cookie->key_len = index_key_len;
+	cookie->aux_len = aux_data_len;
+
+	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
+		goto nomem;
+
+	if (cookie->aux_len <= sizeof(cookie->inline_aux)) {
+		memcpy(cookie->inline_aux, aux_data, cookie->aux_len);
+	} else {
+		cookie->aux = kmemdup(aux_data, cookie->aux_len, GFP_KERNEL);
+		if (!cookie->aux)
+			goto nomem;
+	}
+
+	refcount_set(&cookie->ref, 1);
+	atomic_set(&cookie->n_children, 0);
+	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
+
+	/* We keep the active count elevated until relinquishment to prevent an
+	 * attempt to wake up every time the object operations queue quiesces.
+	 */
+	atomic_set(&cookie->n_active, 1);
+
+	cookie->def		= def;
+	cookie->parent		= parent;
+	cookie->netfs_data	= netfs_data;
+	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
+	cookie->type		= def->type;
+	spin_lock_init(&cookie->lock);
+	INIT_HLIST_HEAD(&cookie->backing_objects);
+
+	write_lock(&fscache_cookies_lock);
+	list_add_tail(&cookie->proc_link, &fscache_cookies);
+	write_unlock(&fscache_cookies_lock);
+	return cookie;
+
+nomem:
+	fscache_free_cookie(cookie);
+	return NULL;
+}
+
+/*
+ * Attempt to insert the new cookie into the hash.  If there's a collision, we
+ * return the old cookie if it's not in use and an error otherwise.
+ */
+struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
+{
+	struct fscache_cookie *cursor;
+	struct hlist_bl_head *h;
+	struct hlist_bl_node *p;
+	unsigned int bucket;
+
+	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
+	h = &fscache_cookie_hash[bucket];
+
+	hlist_bl_lock(h);
+	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
+		if (fscache_compare_cookie(candidate, cursor) == 0)
+			goto collision;
+	}
+
+	__set_bit(FSCACHE_COOKIE_ACQUIRED, &candidate->flags);
+	fscache_cookie_get(candidate->parent, fscache_cookie_get_acquire_parent);
+	atomic_inc(&candidate->parent->n_children);
+	hlist_bl_add_head(&candidate->hash_link, h);
+	hlist_bl_unlock(h);
+	return candidate;
+
+collision:
+	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
+		trace_fscache_cookie(cursor->debug_id, refcount_read(&cursor->ref),
+				     fscache_cookie_collision);
+		pr_err("Duplicate cookie detected\n");
+		fscache_print_cookie(cursor, 'O');
+		fscache_print_cookie(candidate, 'N');
+		hlist_bl_unlock(h);
+		return NULL;
+	}
+
+	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
+	hlist_bl_unlock(h);
+	return cursor;
+}
+
+/*
+ * request a cookie to represent an object (index, datafile, xattr, etc)
+ * - parent specifies the parent object
+ *   - the top level index cookie for each netfs is stored in the fscache_netfs
+ *     struct upon registration
+ * - def points to the definition
+ * - the netfs_data will be passed to the functions pointed to in *def
+ * - all attached caches will be searched to see if they contain this object
+ * - index objects aren't stored on disk until there's a dependent file that
+ *   needs storing
+ * - other objects are stored in a selected cache immediately, and all the
+ *   indices forming the path to it are instantiated if necessary
+ * - we never let on to the netfs about errors
+ *   - we may set a negative cookie pointer, but that's okay
+ */
+struct fscache_cookie *__fscache_acquire_cookie(
+	struct fscache_cookie *parent,
+	const struct fscache_cookie_def *def,
+	const void *index_key, size_t index_key_len,
+	const void *aux_data, size_t aux_data_len,
+	void *netfs_data,
+	loff_t object_size,
+	bool enable)
+{
+	struct fscache_cookie *candidate, *cookie;
+
+	BUG_ON(!def);
+
+	_enter("{%s},{%s},%p,%u",
+	       parent ? (char *) parent->def->name : "<no-parent>",
+	       def->name, netfs_data, enable);
+
+	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
+		return NULL;
+	if (!aux_data || !aux_data_len) {
+		aux_data = NULL;
+		aux_data_len = 0;
+	}
+
+	fscache_stat(&fscache_n_acquires);
+
+	/* if there's no parent cookie, then we don't create one here either */
+	if (!parent) {
+		fscache_stat(&fscache_n_acquires_null);
+		_leave(" [no parent]");
+		return NULL;
+	}
+
+	/* validate the definition */
+	BUG_ON(!def->name[0]);
+
+	BUG_ON(def->type == FSCACHE_COOKIE_TYPE_INDEX &&
+	       parent->type != FSCACHE_COOKIE_TYPE_INDEX);
+
+	candidate = fscache_alloc_cookie(parent, def,
+					 index_key, index_key_len,
+					 aux_data, aux_data_len,
+					 netfs_data, object_size);
+	if (!candidate) {
+		fscache_stat(&fscache_n_acquires_oom);
+		_leave(" [ENOMEM]");
+		return NULL;
+	}
+
+	cookie = fscache_hash_cookie(candidate);
+	if (!cookie) {
+		trace_fscache_cookie(candidate->debug_id, 1,
+				     fscache_cookie_discard);
+		goto out;
+	}
+
+	if (cookie == candidate)
+		candidate = NULL;
+
+	switch (cookie->type) {
+	case FSCACHE_COOKIE_TYPE_INDEX:
+		fscache_stat(&fscache_n_cookie_index);
+		break;
+	case FSCACHE_COOKIE_TYPE_DATAFILE:
+		fscache_stat(&fscache_n_cookie_data);
+		break;
+	default:
+		fscache_stat(&fscache_n_cookie_special);
+		break;
+	}
+
+	trace_fscache_acquire(cookie);
+
+	if (enable) {
+		/* if the object is an index then we need do nothing more here
+		 * - we create indices on disk when we need them as an index
+		 * may exist in multiple caches */
+		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
+			if (fscache_acquire_non_index_cookie(cookie, object_size) == 0) {
+				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
+			} else {
+				atomic_dec(&parent->n_children);
+				fscache_cookie_put(cookie,
+						   fscache_cookie_put_acquire_nobufs);
+				fscache_stat(&fscache_n_acquires_nobufs);
+				_leave(" = NULL");
+				return NULL;
+			}
+		} else {
+			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
+		}
+	}
+
+	fscache_stat(&fscache_n_acquires_ok);
+
+out:
+	fscache_free_cookie(candidate);
+	return cookie;
+}
+EXPORT_SYMBOL(__fscache_acquire_cookie);
+
+/*
+ * Enable a cookie to permit it to accept new operations.
+ */
+void __fscache_enable_cookie(struct fscache_cookie *cookie,
+			     const void *aux_data,
+			     loff_t object_size,
+			     bool (*can_enable)(void *data),
+			     void *data)
+{
+	_enter("%x", cookie->debug_id);
+
+	trace_fscache_enable(cookie);
+
+	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
+			 TASK_UNINTERRUPTIBLE);
+
+	fscache_update_aux(cookie, aux_data);
+
+	if (test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
+		goto out_unlock;
+
+	if (can_enable && !can_enable(data)) {
+		/* The netfs decided it didn't want to enable after all */
+	} else if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		/* Wait for outstanding disablement to complete */
+		__fscache_wait_on_invalidate(cookie);
+
+		if (fscache_acquire_non_index_cookie(cookie, object_size) == 0)
+			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
+	} else {
+		set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
+	}
+
+out_unlock:
+	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
+	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
+}
+EXPORT_SYMBOL(__fscache_enable_cookie);
+
+/*
+ * acquire a non-index cookie
+ * - this must make sure the index chain is instantiated and instantiate the
+ *   object representation too
+ */
+static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
+					    loff_t object_size)
+{
+	struct fscache_object *object;
+	struct fscache_cache *cache;
+	int ret;
+
+	_enter("");
+
+	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
+
+	/* now we need to see whether the backing objects for this cookie yet
+	 * exist, if not there'll be nothing to search */
+	down_read(&fscache_addremove_sem);
+
+	if (list_empty(&fscache_cache_list)) {
+		up_read(&fscache_addremove_sem);
+		_leave(" = 0 [no caches]");
+		return 0;
+	}
+
+	/* select a cache in which to store the object */
+	cache = fscache_select_cache_for_object(cookie->parent);
+	if (!cache) {
+		up_read(&fscache_addremove_sem);
+		fscache_stat(&fscache_n_acquires_no_cache);
+		_leave(" = -ENOMEDIUM [no cache]");
+		return -ENOMEDIUM;
+	}
+
+	_debug("cache %s", cache->tag->name);
+
+	set_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
+
+	/* ask the cache to allocate objects for this cookie and its parent
+	 * chain */
+	ret = fscache_alloc_object(cache, cookie);
+	if (ret < 0) {
+		up_read(&fscache_addremove_sem);
+		_leave(" = %d", ret);
+		return ret;
+	}
+
+	spin_lock(&cookie->lock);
+	if (hlist_empty(&cookie->backing_objects)) {
+		spin_unlock(&cookie->lock);
+		goto unavailable;
+	}
+
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+
+	fscache_set_store_limit(object, object_size);
+
+	/* initiate the process of looking up all the objects in the chain
+	 * (done by fscache_initialise_object()) */
+	fscache_raise_event(object, FSCACHE_OBJECT_EV_NEW_CHILD);
+
+	spin_unlock(&cookie->lock);
+
+	/* we may be required to wait for lookup to complete at this point */
+	if (!fscache_defer_lookup) {
+		wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
+			    TASK_UNINTERRUPTIBLE);
+		if (test_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags))
+			goto unavailable;
+	}
+
+	up_read(&fscache_addremove_sem);
+	_leave(" = 0 [deferred]");
+	return 0;
+
+unavailable:
+	up_read(&fscache_addremove_sem);
+	_leave(" = -ENOBUFS");
+	return -ENOBUFS;
+}
+
+/*
+ * recursively allocate cache object records for a cookie/cache combination
+ * - caller must be holding the addremove sem
+ */
+static int fscache_alloc_object(struct fscache_cache *cache,
+				struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+	int ret;
+
+	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->def->name);
+
+	spin_lock(&cookie->lock);
+	hlist_for_each_entry(object, &cookie->backing_objects,
+			     cookie_link) {
+		if (object->cache == cache)
+			goto object_already_extant;
+	}
+	spin_unlock(&cookie->lock);
+
+	/* ask the cache to allocate an object (we may end up with duplicate
+	 * objects at this stage, but we sort that out later) */
+	fscache_stat(&fscache_n_cop_alloc_object);
+	object = cache->ops->alloc_object(cache, cookie);
+	fscache_stat_d(&fscache_n_cop_alloc_object);
+	if (IS_ERR(object)) {
+		fscache_stat(&fscache_n_object_no_alloc);
+		ret = PTR_ERR(object);
+		goto error;
+	}
+
+	ASSERTCMP(object->cookie, ==, cookie);
+	fscache_stat(&fscache_n_object_alloc);
+
+	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
+
+	_debug("ALLOC OBJ%x: %s {%lx}",
+	       object->debug_id, cookie->def->name, object->events);
+
+	ret = fscache_alloc_object(cache, cookie->parent);
+	if (ret < 0)
+		goto error_put;
+
+	/* only attach if we managed to allocate all we needed, otherwise
+	 * discard the object we just allocated and instead use the one
+	 * attached to the cookie */
+	if (fscache_attach_object(cookie, object) < 0) {
+		fscache_stat(&fscache_n_cop_put_object);
+		cache->ops->put_object(object, fscache_obj_put_attach_fail);
+		fscache_stat_d(&fscache_n_cop_put_object);
+	}
+
+	_leave(" = 0");
+	return 0;
+
+object_already_extant:
+	ret = -ENOBUFS;
+	if (fscache_object_is_dying(object) ||
+	    fscache_cache_is_broken(object)) {
+		spin_unlock(&cookie->lock);
+		goto error;
+	}
+	spin_unlock(&cookie->lock);
+	_leave(" = 0 [found]");
+	return 0;
+
+error_put:
+	fscache_stat(&fscache_n_cop_put_object);
+	cache->ops->put_object(object, fscache_obj_put_alloc_fail);
+	fscache_stat_d(&fscache_n_cop_put_object);
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * attach a cache object to a cookie
+ */
+static int fscache_attach_object(struct fscache_cookie *cookie,
+				 struct fscache_object *object)
+{
+	struct fscache_object *p;
+	struct fscache_cache *cache = object->cache;
+	int ret;
+
+	_enter("{%s},{OBJ%x}", cookie->def->name, object->debug_id);
+
+	ASSERTCMP(object->cookie, ==, cookie);
+
+	spin_lock(&cookie->lock);
+
+	/* there may be multiple initial creations of this object, but we only
+	 * want one */
+	ret = -EEXIST;
+	hlist_for_each_entry(p, &cookie->backing_objects, cookie_link) {
+		if (p->cache == object->cache) {
+			if (fscache_object_is_dying(p))
+				ret = -ENOBUFS;
+			goto cant_attach_object;
+		}
+	}
+
+	/* pin the parent object */
+	spin_lock_nested(&cookie->parent->lock, 1);
+	hlist_for_each_entry(p, &cookie->parent->backing_objects,
+			     cookie_link) {
+		if (p->cache == object->cache) {
+			if (fscache_object_is_dying(p)) {
+				ret = -ENOBUFS;
+				spin_unlock(&cookie->parent->lock);
+				goto cant_attach_object;
+			}
+			object->parent = p;
+			spin_lock(&p->lock);
+			p->n_children++;
+			spin_unlock(&p->lock);
+			break;
+		}
+	}
+	spin_unlock(&cookie->parent->lock);
+
+	/* attach to the cache's object list */
+	if (list_empty(&object->cache_link)) {
+		spin_lock(&cache->object_list_lock);
+		list_add(&object->cache_link, &cache->object_list);
+		spin_unlock(&cache->object_list_lock);
+	}
+
+	/* Attach to the cookie.  The object already has a ref on it. */
+	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
+	ret = 0;
+
+cant_attach_object:
+	spin_unlock(&cookie->lock);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Invalidate an object.  Callable with spinlocks held.
+ */
+void __fscache_invalidate(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+
+	_enter("{%s}", cookie->def->name);
+
+	fscache_stat(&fscache_n_invalidates);
+
+	/* Only permit invalidation of data files.  Invalidating an index will
+	 * require the caller to release all its attachments to the tree rooted
+	 * there, and if it's doing that, it may as well just retire the
+	 * cookie.
+	 */
+	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
+
+	/* If there's an object, we tell the object state machine to handle the
+	 * invalidation on our behalf, otherwise there's nothing to do.
+	 */
+	if (!hlist_empty(&cookie->backing_objects)) {
+		spin_lock(&cookie->lock);
+
+		if (fscache_cookie_enabled(cookie) &&
+		    !hlist_empty(&cookie->backing_objects) &&
+		    !test_and_set_bit(FSCACHE_COOKIE_INVALIDATING,
+				      &cookie->flags)) {
+			object = hlist_entry(cookie->backing_objects.first,
+					     struct fscache_object,
+					     cookie_link);
+			if (fscache_object_is_live(object))
+				fscache_raise_event(
+					object, FSCACHE_OBJECT_EV_INVALIDATE);
+		}
+
+		spin_unlock(&cookie->lock);
+	}
+
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_invalidate);
+
+/*
+ * Wait for object invalidation to complete.
+ */
+void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
+{
+	_enter("%x", cookie->debug_id);
+
+	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
+		    TASK_UNINTERRUPTIBLE);
+
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_wait_on_invalidate);
+
+/*
+ * update the index entries backing a cookie
+ */
+void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
+{
+	struct fscache_object *object;
+
+	fscache_stat(&fscache_n_updates);
+
+	if (!cookie) {
+		fscache_stat(&fscache_n_updates_null);
+		_leave(" [no cookie]");
+		return;
+	}
+
+	_enter("{%s}", cookie->def->name);
+
+	spin_lock(&cookie->lock);
+
+	fscache_update_aux(cookie, aux_data);
+
+	if (fscache_cookie_enabled(cookie)) {
+		/* update the index entry on disk in each cache backing this
+		 * cookie.
+		 */
+		hlist_for_each_entry(object,
+				     &cookie->backing_objects, cookie_link) {
+			fscache_raise_event(object, FSCACHE_OBJECT_EV_UPDATE);
+		}
+	}
+
+	spin_unlock(&cookie->lock);
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_update_cookie);
+
+/*
+ * Disable a cookie to stop it from accepting new requests from the netfs.
+ */
+void __fscache_disable_cookie(struct fscache_cookie *cookie,
+			      const void *aux_data,
+			      bool invalidate)
+{
+	struct fscache_object *object;
+	bool awaken = false;
+
+	_enter("%x,%u", cookie->debug_id, invalidate);
+
+	trace_fscache_disable(cookie);
+
+	ASSERTCMP(atomic_read(&cookie->n_active), >, 0);
+
+	if (atomic_read(&cookie->n_children) != 0) {
+		pr_err("Cookie '%s' still has children\n",
+		       cookie->def->name);
+		BUG();
+	}
+
+	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
+			 TASK_UNINTERRUPTIBLE);
+
+	fscache_update_aux(cookie, aux_data);
+
+	if (!test_and_clear_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
+		goto out_unlock_enable;
+
+	/* If the cookie is being invalidated, wait for that to complete first
+	 * so that we can reuse the flag.
+	 */
+	__fscache_wait_on_invalidate(cookie);
+
+	/* Dispose of the backing objects */
+	set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags);
+
+	spin_lock(&cookie->lock);
+	if (!hlist_empty(&cookie->backing_objects)) {
+		hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
+			if (invalidate)
+				set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
+			clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
+			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
+		}
+	} else {
+		if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
+			awaken = true;
+	}
+	spin_unlock(&cookie->lock);
+	if (awaken)
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+
+	/* Wait for cessation of activity requiring access to the netfs (when
+	 * n_active reaches 0).  This makes sure outstanding reads and writes
+	 * have completed.
+	 */
+	if (!atomic_dec_and_test(&cookie->n_active)) {
+		wait_var_event(&cookie->n_active,
+			       !atomic_read(&cookie->n_active));
+	}
+
+	/* Reset the cookie state if it wasn't relinquished */
+	if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags)) {
+		atomic_inc(&cookie->n_active);
+		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
+	}
+
+out_unlock_enable:
+	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
+	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_disable_cookie);
+
+/*
+ * release a cookie back to the cache
+ * - the object will be marked as recyclable on disk if retire is true
+ * - all dependents of this cookie must have already been unregistered
+ *   (indices/files/pages)
+ */
+void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
+				 const void *aux_data,
+				 bool retire)
+{
+	fscache_stat(&fscache_n_relinquishes);
+	if (retire)
+		fscache_stat(&fscache_n_relinquishes_retire);
+
+	if (!cookie) {
+		fscache_stat(&fscache_n_relinquishes_null);
+		_leave(" [no cookie]");
+		return;
+	}
+
+	_enter("%x{%s,%d},%d",
+	       cookie->debug_id, cookie->def->name,
+	       atomic_read(&cookie->n_active), retire);
+
+	trace_fscache_relinquish(cookie, retire);
+
+	/* No further netfs-accessing operations on this cookie permitted */
+	if (test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags))
+		BUG();
+
+	__fscache_disable_cookie(cookie, aux_data, retire);
+
+	/* Clear pointers back to the netfs */
+	cookie->netfs_data	= NULL;
+	cookie->def		= NULL;
+
+	if (cookie->parent) {
+		ASSERTCMP(refcount_read(&cookie->parent->ref), >, 0);
+		ASSERTCMP(atomic_read(&cookie->parent->n_children), >, 0);
+		atomic_dec(&cookie->parent->n_children);
+	}
+
+	/* Dispose of the netfs's link to the cookie */
+	fscache_cookie_put(cookie, fscache_cookie_put_relinquish);
+
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_relinquish_cookie);
+
+/*
+ * Remove a cookie from the hash table.
+ */
+static void fscache_unhash_cookie(struct fscache_cookie *cookie)
+{
+	struct hlist_bl_head *h;
+	unsigned int bucket;
+
+	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
+	h = &fscache_cookie_hash[bucket];
+
+	hlist_bl_lock(h);
+	hlist_bl_del(&cookie->hash_link);
+	hlist_bl_unlock(h);
+}
+
+/*
+ * Drop a reference to a cookie.
+ */
+void fscache_cookie_put(struct fscache_cookie *cookie,
+			enum fscache_cookie_trace where)
+{
+	struct fscache_cookie *parent;
+	int ref;
+
+	_enter("%x", cookie->debug_id);
+
+	do {
+		unsigned int cookie_debug_id = cookie->debug_id;
+		bool zero = __refcount_dec_and_test(&cookie->ref, &ref);
+
+		trace_fscache_cookie(cookie_debug_id, ref - 1, where);
+		if (!zero)
+			return;
+
+		parent = cookie->parent;
+		fscache_unhash_cookie(cookie);
+		fscache_free_cookie(cookie);
+
+		cookie = parent;
+		where = fscache_cookie_put_parent;
+	} while (cookie);
+
+	_leave("");
+}
+
+/*
+ * Get a reference to a cookie.
+ */
+struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
+					  enum fscache_cookie_trace where)
+{
+	int ref;
+
+	__refcount_inc(&cookie->ref, &ref);
+	trace_fscache_cookie(cookie->debug_id, ref + 1, where);
+	return cookie;
+}
+
+/*
+ * check the consistency between the netfs inode and the backing cache
+ *
+ * NOTE: it only serves no-index type
+ */
+int __fscache_check_consistency(struct fscache_cookie *cookie,
+				const void *aux_data)
+{
+	struct fscache_operation *op;
+	struct fscache_object *object;
+	bool wake_cookie = false;
+	int ret;
+
+	_enter("%p,", cookie);
+
+	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
+
+	if (fscache_wait_for_deferred_lookup(cookie) < 0)
+		return -ERESTARTSYS;
+
+	if (hlist_empty(&cookie->backing_objects))
+		return 0;
+
+	op = kzalloc(sizeof(*op), GFP_NOIO | __GFP_NOMEMALLOC | __GFP_NORETRY);
+	if (!op)
+		return -ENOMEM;
+
+	fscache_operation_init(cookie, op, NULL, NULL, NULL);
+	op->flags = FSCACHE_OP_MYTHREAD |
+		(1 << FSCACHE_OP_WAITING) |
+		(1 << FSCACHE_OP_UNUSE_COOKIE);
+	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_check_consistency);
+
+	spin_lock(&cookie->lock);
+
+	fscache_update_aux(cookie, aux_data);
+
+	if (!fscache_cookie_enabled(cookie) ||
+	    hlist_empty(&cookie->backing_objects))
+		goto inconsistent;
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+	if (test_bit(FSCACHE_IOERROR, &object->cache->flags))
+		goto inconsistent;
+
+	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
+
+	__fscache_use_cookie(cookie);
+	if (fscache_submit_op(object, op) < 0)
+		goto submit_failed;
+
+	/* the work queue now carries its own ref on the object */
+	spin_unlock(&cookie->lock);
+
+	ret = fscache_wait_for_operation_activation(object, op, NULL, NULL);
+	if (ret == 0) {
+		/* ask the cache to honour the operation */
+		ret = object->cache->ops->check_consistency(op);
+		fscache_op_complete(op, false);
+	} else if (ret == -ENOBUFS) {
+		ret = 0;
+	}
+
+	fscache_put_operation(op);
+	_leave(" = %d", ret);
+	return ret;
+
+submit_failed:
+	wake_cookie = __fscache_unuse_cookie(cookie);
+inconsistent:
+	spin_unlock(&cookie->lock);
+	if (wake_cookie)
+		__fscache_wake_unused_cookie(cookie);
+	kfree(op);
+	_leave(" = -ESTALE");
+	return -ESTALE;
+}
+EXPORT_SYMBOL(__fscache_check_consistency);
+
+/*
+ * Generate a list of extant cookies in /proc/fs/fscache/cookies
+ */
+static int fscache_cookies_seq_show(struct seq_file *m, void *v)
+{
+	struct fscache_cookie *cookie;
+	unsigned int keylen = 0, auxlen = 0;
+	char _type[3], *type;
+	u8 *p;
+
+	if (v == &fscache_cookies) {
+		seq_puts(m,
+			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF              NETFS_DATA\n"
+			 "======== ======== ===== ===== === == === ================ ==========\n"
+			 );
+		return 0;
+	}
+
+	cookie = list_entry(v, struct fscache_cookie, proc_link);
+
+	switch (cookie->type) {
+	case 0:
+		type = "IX";
+		break;
+	case 1:
+		type = "DT";
+		break;
+	default:
+		snprintf(_type, sizeof(_type), "%02u",
+			 cookie->type);
+		type = _type;
+		break;
+	}
+
+	seq_printf(m,
+		   "%08x %08x %5u %5u %3u %s %03lx %-16s %px",
+		   cookie->debug_id,
+		   cookie->parent ? cookie->parent->debug_id : 0,
+		   refcount_read(&cookie->ref),
+		   atomic_read(&cookie->n_children),
+		   atomic_read(&cookie->n_active),
+		   type,
+		   cookie->flags,
+		   cookie->def->name,
+		   cookie->netfs_data);
+
+	keylen = cookie->key_len;
+	auxlen = cookie->aux_len;
+
+	if (keylen > 0 || auxlen > 0) {
+		seq_puts(m, " ");
+		p = keylen <= sizeof(cookie->inline_key) ?
+			cookie->inline_key : cookie->key;
+		for (; keylen > 0; keylen--)
+			seq_printf(m, "%02x", *p++);
+		if (auxlen > 0) {
+			seq_puts(m, ", ");
+			p = auxlen <= sizeof(cookie->inline_aux) ?
+				cookie->inline_aux : cookie->aux;
+			for (; auxlen > 0; auxlen--)
+				seq_printf(m, "%02x", *p++);
+		}
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static void *fscache_cookies_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(fscache_cookies_lock)
+{
+	read_lock(&fscache_cookies_lock);
+	return seq_list_start_head(&fscache_cookies, *_pos);
+}
+
+static void *fscache_cookies_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &fscache_cookies, _pos);
+}
+
+static void fscache_cookies_seq_stop(struct seq_file *m, void *v)
+	__releases(rcu)
+{
+	read_unlock(&fscache_cookies_lock);
+}
+
+
+const struct seq_operations fscache_cookies_seq_ops = {
+	.start  = fscache_cookies_seq_start,
+	.next   = fscache_cookies_seq_next,
+	.stop   = fscache_cookies_seq_stop,
+	.show   = fscache_cookies_seq_show,
+};
diff --git a/fs/fscache_old/fsdef.c b/fs/fscache_old/fsdef.c
new file mode 100644
index 000000000000..0402673c680e
--- /dev/null
+++ b/fs/fscache_old/fsdef.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Filesystem index definition
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include "internal.h"
+
+static
+enum fscache_checkaux fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
+						    const void *data,
+						    uint16_t datalen,
+						    loff_t object_size);
+
+/*
+ * The root index is owned by FS-Cache itself.
+ *
+ * When a netfs requests caching facilities, FS-Cache will, if one doesn't
+ * already exist, create an entry in the root index with the key being the name
+ * of the netfs ("AFS" for example), and the auxiliary data holding the index
+ * structure version supplied by the netfs:
+ *
+ *				     FSDEF
+ *				       |
+ *				 +-----------+
+ *				 |           |
+ *				NFS         AFS
+ *			       [v=1]       [v=1]
+ *
+ * If an entry with the appropriate name does already exist, the version is
+ * compared.  If the version is different, the entire subtree from that entry
+ * will be discarded and a new entry created.
+ *
+ * The new entry will be an index, and a cookie referring to it will be passed
+ * to the netfs.  This is then the root handle by which the netfs accesses the
+ * cache.  It can create whatever objects it likes in that index, including
+ * further indices.
+ */
+static struct fscache_cookie_def fscache_fsdef_index_def = {
+	.name		= ".FS-Cache",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+};
+
+struct fscache_cookie fscache_fsdef_index = {
+	.debug_id	= 1,
+	.ref		= REFCOUNT_INIT(1),
+	.n_active	= ATOMIC_INIT(1),
+	.lock		= __SPIN_LOCK_UNLOCKED(fscache_fsdef_index.lock),
+	.backing_objects = HLIST_HEAD_INIT,
+	.def		= &fscache_fsdef_index_def,
+	.flags		= 1 << FSCACHE_COOKIE_ENABLED,
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+};
+EXPORT_SYMBOL(fscache_fsdef_index);
+
+/*
+ * Definition of an entry in the root index.  Each entry is an index, keyed to
+ * a specific netfs and only applicable to a particular version of the index
+ * structure used by that netfs.
+ */
+struct fscache_cookie_def fscache_fsdef_netfs_def = {
+	.name		= "FSDEF.netfs",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.check_aux	= fscache_fsdef_netfs_check_aux,
+};
+
+/*
+ * check that the index structure version number stored in the auxiliary data
+ * matches the one the netfs gave us
+ */
+static enum fscache_checkaux fscache_fsdef_netfs_check_aux(
+	void *cookie_netfs_data,
+	const void *data,
+	uint16_t datalen,
+	loff_t object_size)
+{
+	struct fscache_netfs *netfs = cookie_netfs_data;
+	uint32_t version;
+
+	_enter("{%s},,%hu", netfs->name, datalen);
+
+	if (datalen != sizeof(version)) {
+		_leave(" = OBSOLETE [dl=%d v=%zu]", datalen, sizeof(version));
+		return FSCACHE_CHECKAUX_OBSOLETE;
+	}
+
+	memcpy(&version, data, sizeof(version));
+	if (version != netfs->version) {
+		_leave(" = OBSOLETE [ver=%x net=%x]", version, netfs->version);
+		return FSCACHE_CHECKAUX_OBSOLETE;
+	}
+
+	_leave(" = OKAY");
+	return FSCACHE_CHECKAUX_OKAY;
+}
diff --git a/fs/fscache_old/internal.h b/fs/fscache_old/internal.h
new file mode 100644
index 000000000000..7288622cf2c3
--- /dev/null
+++ b/fs/fscache_old/internal.h
@@ -0,0 +1,409 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Internal definitions for FS-Cache
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+/*
+ * Lock order, in the order in which multiple locks should be obtained:
+ * - fscache_addremove_sem
+ * - cookie->lock
+ * - cookie->parent->lock
+ * - cache->object_list_lock
+ * - object->lock
+ * - object->parent->lock
+ * - cookie->stores_lock
+ * - fscache_thread_lock
+ *
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "FS-Cache: " fmt
+
+#include <linux/fscache_old-cache.h>
+#include <trace/events/fscache_old.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+
+#define FSCACHE_MIN_THREADS	4
+#define FSCACHE_MAX_THREADS	32
+
+/*
+ * cache.c
+ */
+extern struct list_head fscache_cache_list;
+extern struct rw_semaphore fscache_addremove_sem;
+
+extern struct fscache_cache *fscache_select_cache_for_object(
+	struct fscache_cookie *);
+
+/*
+ * cookie.c
+ */
+extern struct kmem_cache *fscache_cookie_jar;
+extern const struct seq_operations fscache_cookies_seq_ops;
+
+extern void fscache_free_cookie(struct fscache_cookie *);
+extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
+						   const struct fscache_cookie_def *,
+						   const void *, size_t,
+						   const void *, size_t,
+						   void *, loff_t);
+extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
+extern struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *,
+						 enum fscache_cookie_trace);
+extern void fscache_cookie_put(struct fscache_cookie *,
+			       enum fscache_cookie_trace);
+
+static inline void fscache_cookie_see(struct fscache_cookie *cookie,
+				      enum fscache_cookie_trace where)
+{
+	trace_fscache_cookie(cookie->debug_id, refcount_read(&cookie->ref),
+			     where);
+}
+
+/*
+ * fsdef.c
+ */
+extern struct fscache_cookie fscache_fsdef_index;
+extern struct fscache_cookie_def fscache_fsdef_netfs_def;
+
+/*
+ * main.c
+ */
+extern unsigned fscache_defer_lookup;
+extern unsigned fscache_defer_create;
+extern unsigned fscache_debug;
+extern struct kobject *fscache_root;
+extern struct workqueue_struct *fscache_object_wq;
+extern struct workqueue_struct *fscache_op_wq;
+DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
+
+extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
+
+static inline bool fscache_object_congested(void)
+{
+	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
+}
+
+/*
+ * object.c
+ */
+extern void fscache_enqueue_object(struct fscache_object *);
+
+/*
+ * operation.c
+ */
+extern int fscache_submit_exclusive_op(struct fscache_object *,
+				       struct fscache_operation *);
+extern int fscache_submit_op(struct fscache_object *,
+			     struct fscache_operation *);
+extern int fscache_cancel_op(struct fscache_operation *, bool);
+extern void fscache_cancel_all_ops(struct fscache_object *);
+extern void fscache_abort_object(struct fscache_object *);
+extern void fscache_start_operations(struct fscache_object *);
+extern void fscache_operation_gc(struct work_struct *);
+
+/*
+ * page.c
+ */
+extern int fscache_wait_for_deferred_lookup(struct fscache_cookie *);
+extern int fscache_wait_for_operation_activation(struct fscache_object *,
+						 struct fscache_operation *,
+						 atomic_t *,
+						 atomic_t *);
+
+/*
+ * proc.c
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
+ * stats.c
+ */
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_ops_processed[FSCACHE_MAX_THREADS];
+extern atomic_t fscache_n_objs_processed[FSCACHE_MAX_THREADS];
+
+extern atomic_t fscache_n_op_pend;
+extern atomic_t fscache_n_op_run;
+extern atomic_t fscache_n_op_enqueue;
+extern atomic_t fscache_n_op_deferred_release;
+extern atomic_t fscache_n_op_initialised;
+extern atomic_t fscache_n_op_release;
+extern atomic_t fscache_n_op_gc;
+extern atomic_t fscache_n_op_cancelled;
+extern atomic_t fscache_n_op_rejected;
+
+extern atomic_t fscache_n_attr_changed;
+extern atomic_t fscache_n_attr_changed_ok;
+extern atomic_t fscache_n_attr_changed_nobufs;
+extern atomic_t fscache_n_attr_changed_nomem;
+extern atomic_t fscache_n_attr_changed_calls;
+
+extern atomic_t fscache_n_retrievals;
+extern atomic_t fscache_n_retrievals_ok;
+extern atomic_t fscache_n_retrievals_wait;
+extern atomic_t fscache_n_retrievals_nodata;
+extern atomic_t fscache_n_retrievals_nobufs;
+extern atomic_t fscache_n_retrievals_intr;
+extern atomic_t fscache_n_retrievals_nomem;
+extern atomic_t fscache_n_retrievals_object_dead;
+extern atomic_t fscache_n_retrieval_ops;
+extern atomic_t fscache_n_retrieval_op_waits;
+
+extern atomic_t fscache_n_stores;
+extern atomic_t fscache_n_stores_ok;
+extern atomic_t fscache_n_stores_again;
+extern atomic_t fscache_n_stores_nobufs;
+extern atomic_t fscache_n_stores_intr;
+extern atomic_t fscache_n_stores_oom;
+extern atomic_t fscache_n_store_ops;
+extern atomic_t fscache_n_stores_object_dead;
+extern atomic_t fscache_n_store_op_waits;
+
+extern atomic_t fscache_n_acquires;
+extern atomic_t fscache_n_acquires_null;
+extern atomic_t fscache_n_acquires_no_cache;
+extern atomic_t fscache_n_acquires_ok;
+extern atomic_t fscache_n_acquires_nobufs;
+extern atomic_t fscache_n_acquires_oom;
+
+extern atomic_t fscache_n_invalidates;
+extern atomic_t fscache_n_invalidates_run;
+
+extern atomic_t fscache_n_updates;
+extern atomic_t fscache_n_updates_null;
+extern atomic_t fscache_n_updates_run;
+
+extern atomic_t fscache_n_relinquishes;
+extern atomic_t fscache_n_relinquishes_null;
+extern atomic_t fscache_n_relinquishes_waitcrt;
+extern atomic_t fscache_n_relinquishes_retire;
+
+extern atomic_t fscache_n_cookie_index;
+extern atomic_t fscache_n_cookie_data;
+extern atomic_t fscache_n_cookie_special;
+
+extern atomic_t fscache_n_object_alloc;
+extern atomic_t fscache_n_object_no_alloc;
+extern atomic_t fscache_n_object_lookups;
+extern atomic_t fscache_n_object_lookups_negative;
+extern atomic_t fscache_n_object_lookups_positive;
+extern atomic_t fscache_n_object_lookups_timed_out;
+extern atomic_t fscache_n_object_created;
+extern atomic_t fscache_n_object_avail;
+extern atomic_t fscache_n_object_dead;
+
+extern atomic_t fscache_n_checkaux_none;
+extern atomic_t fscache_n_checkaux_okay;
+extern atomic_t fscache_n_checkaux_update;
+extern atomic_t fscache_n_checkaux_obsolete;
+
+extern atomic_t fscache_n_cop_alloc_object;
+extern atomic_t fscache_n_cop_lookup_object;
+extern atomic_t fscache_n_cop_lookup_complete;
+extern atomic_t fscache_n_cop_grab_object;
+extern atomic_t fscache_n_cop_invalidate_object;
+extern atomic_t fscache_n_cop_update_object;
+extern atomic_t fscache_n_cop_drop_object;
+extern atomic_t fscache_n_cop_put_object;
+extern atomic_t fscache_n_cop_sync_cache;
+extern atomic_t fscache_n_cop_attr_changed;
+
+extern atomic_t fscache_n_cache_no_space_reject;
+extern atomic_t fscache_n_cache_stale_objects;
+extern atomic_t fscache_n_cache_retired_objects;
+extern atomic_t fscache_n_cache_culled_objects;
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
+ * raise an event on an object
+ * - if the event is not masked for that object, then the object is
+ *   queued for attention by the thread pool.
+ */
+static inline void fscache_raise_event(struct fscache_object *object,
+				       unsigned event)
+{
+	BUG_ON(event >= NR_FSCACHE_OBJECT_EVENTS);
+#if 0
+	printk("*** fscache_raise_event(OBJ%d{%lx},%x)\n",
+	       object->debug_id, object->event_mask, (1 << event));
+#endif
+	if (!test_and_set_bit(event, &object->events) &&
+	    test_bit(event, &object->event_mask))
+		fscache_enqueue_object(object);
+}
+
+/*
+ * Update the auxiliary data on a cookie.
+ */
+static inline
+void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
+{
+	void *p;
+
+	if (!aux_data)
+		return;
+	if (cookie->aux_len <= sizeof(cookie->inline_aux))
+		p = cookie->inline_aux;
+	else
+		p = cookie->aux;
+
+	if (memcmp(p, aux_data, cookie->aux_len) != 0) {
+		memcpy(p, aux_data, cookie->aux_len);
+		set_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags);
+	}
+}
+
+/*****************************************************************************/
+/*
+ * debug tracing
+ */
+#define dbgprintk(FMT, ...) \
+	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+
+#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
+
+#define kjournal(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+
+#ifdef __KDEBUG
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_FSCACHE_DEBUG)
+#define _enter(FMT, ...)			\
+do {						\
+	if (__do_kdebug(ENTER))			\
+		kenter(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _leave(FMT, ...)			\
+do {						\
+	if (__do_kdebug(LEAVE))			\
+		kleave(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _debug(FMT, ...)			\
+do {						\
+	if (__do_kdebug(DEBUG))			\
+		kdebug(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
+
+/*
+ * determine whether a particular optional debugging point should be logged
+ * - we need to go through three steps to persuade cpp to correctly join the
+ *   shorthand in FSCACHE_DEBUG_LEVEL with its prefix
+ */
+#define ____do_kdebug(LEVEL, POINT) \
+	unlikely((fscache_debug & \
+		  (FSCACHE_POINT_##POINT << (FSCACHE_DEBUG_ ## LEVEL * 3))))
+#define ___do_kdebug(LEVEL, POINT) \
+	____do_kdebug(LEVEL, POINT)
+#define __do_kdebug(POINT) \
+	___do_kdebug(FSCACHE_DEBUG_LEVEL, POINT)
+
+#define FSCACHE_DEBUG_CACHE	0
+#define FSCACHE_DEBUG_COOKIE	1
+#define FSCACHE_DEBUG_PAGE	2
+#define FSCACHE_DEBUG_OPERATION	3
+
+#define FSCACHE_POINT_ENTER	1
+#define FSCACHE_POINT_LEAVE	2
+#define FSCACHE_POINT_DEBUG	4
+
+#ifndef FSCACHE_DEBUG_LEVEL
+#define FSCACHE_DEBUG_LEVEL CACHE
+#endif
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
diff --git a/fs/fscache_old/io.c b/fs/fscache_old/io.c
new file mode 100644
index 000000000000..4443ec957138
--- /dev/null
+++ b/fs/fscache_old/io.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache data I/O routines
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL PAGE
+#include <linux/module.h>
+#define FSCACHE_USE_NEW_IO_API
+#define FSCACHE_USE_FALLBACK_IO_API
+#include <linux/fscache_old-cache.h>
+#include <linux/uio.h>
+#include <linux/bvec.h>
+#include <linux/slab.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+/*
+ * Start a cache operation.
+ * - we return:
+ *   -ENOMEM	- out of memory, some pages may be being read
+ *   -ERESTARTSYS - interrupted, some pages may be being read
+ *   -ENOBUFS	- no backing object or space available in which to cache any
+ *                pages not being read
+ *   -ENODATA	- no data available in the backing object for some or all of
+ *                the pages
+ *   0		- dispatched a read on all pages
+ */
+int __fscache_begin_operation(struct netfs_cache_resources *cres,
+			      struct fscache_cookie *cookie,
+			      bool for_write)
+{
+	struct fscache_operation *op;
+	struct fscache_object *object;
+	bool wake_cookie = false;
+	int ret;
+
+	_enter("c=%08x", cres->debug_id);
+
+	if (for_write)
+		fscache_stat(&fscache_n_stores);
+	else
+		fscache_stat(&fscache_n_retrievals);
+
+	if (hlist_empty(&cookie->backing_objects))
+		goto nobufs;
+
+	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
+		_leave(" = -ENOBUFS [invalidating]");
+		return -ENOBUFS;
+	}
+
+	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
+
+	if (fscache_wait_for_deferred_lookup(cookie) < 0)
+		return -ERESTARTSYS;
+
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
+	if (!op)
+		return -ENOMEM;
+
+	fscache_operation_init(cookie, op, NULL, NULL, NULL);
+	op->flags = FSCACHE_OP_MYTHREAD |
+		(1UL << FSCACHE_OP_WAITING) |
+		(1UL << FSCACHE_OP_UNUSE_COOKIE);
+
+	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_retr_multi);
+
+	spin_lock(&cookie->lock);
+
+	if (!fscache_cookie_enabled(cookie) ||
+	    hlist_empty(&cookie->backing_objects))
+		goto nobufs_unlock;
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+
+	__fscache_use_cookie(cookie);
+	atomic_inc(&object->n_reads);
+	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags);
+
+	if (fscache_submit_op(object, op) < 0)
+		goto nobufs_unlock_dec;
+	spin_unlock(&cookie->lock);
+
+	/* we wait for the operation to become active, and then process it
+	 * *here*, in this thread, and not in the thread pool */
+	if (for_write) {
+		fscache_stat(&fscache_n_store_ops);
+
+		ret = fscache_wait_for_operation_activation(
+			object, op,
+			__fscache_stat(&fscache_n_store_op_waits),
+			__fscache_stat(&fscache_n_stores_object_dead));
+	} else {
+		fscache_stat(&fscache_n_retrieval_ops);
+
+		ret = fscache_wait_for_operation_activation(
+			object, op,
+			__fscache_stat(&fscache_n_retrieval_op_waits),
+			__fscache_stat(&fscache_n_retrievals_object_dead));
+	}
+	if (ret < 0)
+		goto error;
+
+	/* ask the cache to honour the operation */
+	ret = object->cache->ops->begin_operation(cres, op);
+
+error:
+	if (for_write) {
+		if (ret == -ENOMEM)
+			fscache_stat(&fscache_n_stores_oom);
+		else if (ret == -ERESTARTSYS)
+			fscache_stat(&fscache_n_stores_intr);
+		else if (ret < 0)
+			fscache_stat(&fscache_n_stores_nobufs);
+		else
+			fscache_stat(&fscache_n_stores_ok);
+	} else {
+		if (ret == -ENOMEM)
+			fscache_stat(&fscache_n_retrievals_nomem);
+		else if (ret == -ERESTARTSYS)
+			fscache_stat(&fscache_n_retrievals_intr);
+		else if (ret == -ENODATA)
+			fscache_stat(&fscache_n_retrievals_nodata);
+		else if (ret < 0)
+			fscache_stat(&fscache_n_retrievals_nobufs);
+		else
+			fscache_stat(&fscache_n_retrievals_ok);
+	}
+
+	fscache_put_operation(op);
+	_leave(" = %d", ret);
+	return ret;
+
+nobufs_unlock_dec:
+	atomic_dec(&object->n_reads);
+	wake_cookie = __fscache_unuse_cookie(cookie);
+nobufs_unlock:
+	spin_unlock(&cookie->lock);
+	fscache_put_operation(op);
+	if (wake_cookie)
+		__fscache_wake_unused_cookie(cookie);
+nobufs:
+	if (for_write)
+		fscache_stat(&fscache_n_stores_nobufs);
+	else
+		fscache_stat(&fscache_n_retrievals_nobufs);
+	_leave(" = -ENOBUFS");
+	return -ENOBUFS;
+}
+EXPORT_SYMBOL(__fscache_begin_operation);
+
+/*
+ * Clean up an operation.
+ */
+static void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	cres->ops->end_operation(cres);
+}
+
+/*
+ * Fallback page reading interface.
+ */
+int __fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_read_operation(&cres, cookie);
+	if (ret < 0)
+		return ret;
+
+	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+			   NULL, NULL);
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_read_page);
+
+/*
+ * Fallback page writing interface.
+ */
+int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = __fscache_begin_operation(&cres, cookie, true);
+	if (ret < 0)
+		return ret;
+
+	ret = cres.ops->prepare_fallback_write(&cres, page_index(page));
+	if (ret < 0)
+		goto out;
+
+	ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+out:
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_write_page);
diff --git a/fs/fscache_old/main.c b/fs/fscache_old/main.c
new file mode 100644
index 000000000000..4207f98e405f
--- /dev/null
+++ b/fs/fscache_old/main.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* General filesystem local caching manager
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+MODULE_DESCRIPTION("FS Cache Manager");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+unsigned fscache_defer_lookup = 1;
+module_param_named(defer_lookup, fscache_defer_lookup, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(fscache_defer_lookup,
+		 "Defer cookie lookup to background thread");
+
+unsigned fscache_defer_create = 1;
+module_param_named(defer_create, fscache_defer_create, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(fscache_defer_create,
+		 "Defer cookie creation to background thread");
+
+unsigned fscache_debug;
+module_param_named(debug, fscache_debug, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(fscache_debug,
+		 "FS-Cache debugging mask");
+
+struct kobject *fscache_root;
+struct workqueue_struct *fscache_object_wq;
+struct workqueue_struct *fscache_op_wq;
+
+DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
+
+/* these values serve as lower bounds, will be adjusted in fscache_init() */
+static unsigned fscache_object_max_active = 4;
+static unsigned fscache_op_max_active = 2;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table_header *fscache_sysctl_header;
+
+static int fscache_max_active_sysctl(struct ctl_table *table, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct workqueue_struct **wqp = table->extra1;
+	unsigned int *datap = table->data;
+	int ret;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (ret == 0)
+		workqueue_set_max_active(*wqp, *datap);
+	return ret;
+}
+
+static struct ctl_table fscache_sysctls[] = {
+	{
+		.procname	= "object_max_active",
+		.data		= &fscache_object_max_active,
+		.maxlen		= sizeof(unsigned),
+		.mode		= 0644,
+		.proc_handler	= fscache_max_active_sysctl,
+		.extra1		= &fscache_object_wq,
+	},
+	{
+		.procname	= "operation_max_active",
+		.data		= &fscache_op_max_active,
+		.maxlen		= sizeof(unsigned),
+		.mode		= 0644,
+		.proc_handler	= fscache_max_active_sysctl,
+		.extra1		= &fscache_op_wq,
+	},
+	{}
+};
+
+static struct ctl_table fscache_sysctls_root[] = {
+	{
+		.procname	= "fscache",
+		.mode		= 0555,
+		.child		= fscache_sysctls,
+	},
+	{}
+};
+#endif
+
+/*
+ * Mixing scores (in bits) for (7,20):
+ * Input delta: 1-bit      2-bit
+ * 1 round:     330.3     9201.6
+ * 2 rounds:   1246.4    25475.4
+ * 3 rounds:   1907.1    31295.1
+ * 4 rounds:   2042.3    31718.6
+ * Perfect:    2048      31744
+ *            (32*64)   (32*31/2 * 64)
+ */
+#define HASH_MIX(x, y, a)	\
+	(	x ^= (a),	\
+	y ^= x,	x = rol32(x, 7),\
+	x += y,	y = rol32(y,20),\
+	y *= 9			)
+
+static inline unsigned int fold_hash(unsigned long x, unsigned long y)
+{
+	/* Use arch-optimized multiply if one exists */
+	return __hash_32(y ^ __hash_32(x));
+}
+
+/*
+ * Generate a hash.  This is derived from full_name_hash(), but we want to be
+ * sure it is arch independent and that it doesn't change as bits of the
+ * computed hash value might appear on disk.  The caller also guarantees that
+ * the hashed data will be a series of aligned 32-bit words.
+ */
+unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
+{
+	unsigned int a, x = 0, y = salt;
+
+	for (; n; n--) {
+		a = *data++;
+		HASH_MIX(x, y, a);
+	}
+	return fold_hash(x, y);
+}
+
+/*
+ * initialise the fs caching module
+ */
+static int __init fscache_init(void)
+{
+	unsigned int nr_cpus = num_possible_cpus();
+	unsigned int cpu;
+	int ret;
+
+	fscache_object_max_active =
+		clamp_val(nr_cpus,
+			  fscache_object_max_active, WQ_UNBOUND_MAX_ACTIVE);
+
+	ret = -ENOMEM;
+	fscache_object_wq = alloc_workqueue("fscache_object", WQ_UNBOUND,
+					    fscache_object_max_active);
+	if (!fscache_object_wq)
+		goto error_object_wq;
+
+	fscache_op_max_active =
+		clamp_val(fscache_object_max_active / 2,
+			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
+
+	ret = -ENOMEM;
+	fscache_op_wq = alloc_workqueue("fscache_operation", WQ_UNBOUND,
+					fscache_op_max_active);
+	if (!fscache_op_wq)
+		goto error_op_wq;
+
+	for_each_possible_cpu(cpu)
+		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
+
+	ret = fscache_proc_init();
+	if (ret < 0)
+		goto error_proc;
+
+#ifdef CONFIG_SYSCTL
+	ret = -ENOMEM;
+	fscache_sysctl_header = register_sysctl_table(fscache_sysctls_root);
+	if (!fscache_sysctl_header)
+		goto error_sysctl;
+#endif
+
+	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
+					       sizeof(struct fscache_cookie),
+					       0, 0, NULL);
+	if (!fscache_cookie_jar) {
+		pr_notice("Failed to allocate a cookie jar\n");
+		ret = -ENOMEM;
+		goto error_cookie_jar;
+	}
+
+	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
+	if (!fscache_root)
+		goto error_kobj;
+
+	pr_notice("Loaded\n");
+	return 0;
+
+error_kobj:
+	kmem_cache_destroy(fscache_cookie_jar);
+error_cookie_jar:
+#ifdef CONFIG_SYSCTL
+	unregister_sysctl_table(fscache_sysctl_header);
+error_sysctl:
+#endif
+	fscache_proc_cleanup();
+error_proc:
+	destroy_workqueue(fscache_op_wq);
+error_op_wq:
+	destroy_workqueue(fscache_object_wq);
+error_object_wq:
+	return ret;
+}
+
+fs_initcall(fscache_init);
+
+/*
+ * clean up on module removal
+ */
+static void __exit fscache_exit(void)
+{
+	_enter("");
+
+	kobject_put(fscache_root);
+	kmem_cache_destroy(fscache_cookie_jar);
+#ifdef CONFIG_SYSCTL
+	unregister_sysctl_table(fscache_sysctl_header);
+#endif
+	fscache_proc_cleanup();
+	destroy_workqueue(fscache_op_wq);
+	destroy_workqueue(fscache_object_wq);
+	pr_notice("Unloaded\n");
+}
+
+module_exit(fscache_exit);
diff --git a/fs/fscache_old/netfs.c b/fs/fscache_old/netfs.c
new file mode 100644
index 000000000000..d6bdb7b5e723
--- /dev/null
+++ b/fs/fscache_old/netfs.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache netfs (client) registration
+ *
+ * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL COOKIE
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * register a network filesystem for caching
+ */
+int __fscache_register_netfs(struct fscache_netfs *netfs)
+{
+	struct fscache_cookie *candidate, *cookie;
+
+	_enter("{%s}", netfs->name);
+
+	/* allocate a cookie for the primary index */
+	candidate = fscache_alloc_cookie(&fscache_fsdef_index,
+					 &fscache_fsdef_netfs_def,
+					 netfs->name, strlen(netfs->name),
+					 &netfs->version, sizeof(netfs->version),
+					 netfs, 0);
+	if (!candidate) {
+		_leave(" = -ENOMEM");
+		return -ENOMEM;
+	}
+
+	candidate->flags = 1 << FSCACHE_COOKIE_ENABLED;
+
+	/* check the netfs type is not already present */
+	cookie = fscache_hash_cookie(candidate);
+	if (!cookie)
+		goto already_registered;
+	if (cookie != candidate) {
+		trace_fscache_cookie(candidate->debug_id, 1, fscache_cookie_discard);
+		fscache_free_cookie(candidate);
+	}
+
+	fscache_cookie_get(cookie->parent, fscache_cookie_get_register_netfs);
+	atomic_inc(&cookie->parent->n_children);
+
+	netfs->primary_index = cookie;
+
+	pr_notice("Netfs '%s' registered for caching\n", netfs->name);
+	trace_fscache_netfs(netfs);
+	_leave(" = 0");
+	return 0;
+
+already_registered:
+	fscache_cookie_put(candidate, fscache_cookie_put_dup_netfs);
+	_leave(" = -EEXIST");
+	return -EEXIST;
+}
+EXPORT_SYMBOL(__fscache_register_netfs);
+
+/*
+ * unregister a network filesystem from the cache
+ * - all cookies must have been released first
+ */
+void __fscache_unregister_netfs(struct fscache_netfs *netfs)
+{
+	_enter("{%s.%u}", netfs->name, netfs->version);
+
+	fscache_relinquish_cookie(netfs->primary_index, NULL, false);
+	pr_notice("Netfs '%s' unregistered from caching\n", netfs->name);
+
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_unregister_netfs);
diff --git a/fs/fscache_old/object.c b/fs/fscache_old/object.c
new file mode 100644
index 000000000000..86ad941726f7
--- /dev/null
+++ b/fs/fscache_old/object.c
@@ -0,0 +1,1123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache object state machine handler
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/filesystems/caching/object.rst for a description of the
+ * object state machine and the in-kernel representations.
+ */
+
+#define FSCACHE_DEBUG_LEVEL COOKIE
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/prefetch.h>
+#include "internal.h"
+
+static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *, int);
+static const struct fscache_state *fscache_kill_dependents(struct fscache_object *, int);
+static const struct fscache_state *fscache_drop_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_initialise_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_invalidate_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *, int);
+static const struct fscache_state *fscache_kill_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_lookup_failure(struct fscache_object *, int);
+static const struct fscache_state *fscache_look_up_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_object_available(struct fscache_object *, int);
+static const struct fscache_state *fscache_parent_ready(struct fscache_object *, int);
+static const struct fscache_state *fscache_update_object(struct fscache_object *, int);
+static const struct fscache_state *fscache_object_dead(struct fscache_object *, int);
+
+#define __STATE_NAME(n) fscache_osm_##n
+#define STATE(n) (&__STATE_NAME(n))
+
+/*
+ * Define a work state.  Work states are execution states.  No event processing
+ * is performed by them.  The function attached to a work state returns a
+ * pointer indicating the next state to which the state machine should
+ * transition.  Returning NO_TRANSIT repeats the current state, but goes back
+ * to the scheduler first.
+ */
+#define WORK_STATE(n, sn, f) \
+	const struct fscache_state __STATE_NAME(n) = {			\
+		.name = #n,						\
+		.short_name = sn,					\
+		.work = f						\
+	}
+
+/*
+ * Returns from work states.
+ */
+#define transit_to(state) ({ prefetch(&STATE(state)->work); STATE(state); })
+
+#define NO_TRANSIT ((struct fscache_state *)NULL)
+
+/*
+ * Define a wait state.  Wait states are event processing states.  No execution
+ * is performed by them.  Wait states are just tables of "if event X occurs,
+ * clear it and transition to state Y".  The dispatcher returns to the
+ * scheduler if none of the events in which the wait state has an interest are
+ * currently pending.
+ */
+#define WAIT_STATE(n, sn, ...) \
+	const struct fscache_state __STATE_NAME(n) = {			\
+		.name = #n,						\
+		.short_name = sn,					\
+		.work = NULL,						\
+		.transitions = { __VA_ARGS__, { 0, NULL } }		\
+	}
+
+#define TRANSIT_TO(state, emask) \
+	{ .events = (emask), .transit_to = STATE(state) }
+
+/*
+ * The object state machine.
+ */
+static WORK_STATE(INIT_OBJECT,		"INIT", fscache_initialise_object);
+static WORK_STATE(PARENT_READY,		"PRDY", fscache_parent_ready);
+static WORK_STATE(ABORT_INIT,		"ABRT", fscache_abort_initialisation);
+static WORK_STATE(LOOK_UP_OBJECT,	"LOOK", fscache_look_up_object);
+static WORK_STATE(OBJECT_AVAILABLE,	"AVBL", fscache_object_available);
+static WORK_STATE(JUMPSTART_DEPS,	"JUMP", fscache_jumpstart_dependents);
+
+static WORK_STATE(INVALIDATE_OBJECT,	"INVL", fscache_invalidate_object);
+static WORK_STATE(UPDATE_OBJECT,	"UPDT", fscache_update_object);
+
+static WORK_STATE(LOOKUP_FAILURE,	"LCFL", fscache_lookup_failure);
+static WORK_STATE(KILL_OBJECT,		"KILL", fscache_kill_object);
+static WORK_STATE(KILL_DEPENDENTS,	"KDEP", fscache_kill_dependents);
+static WORK_STATE(DROP_OBJECT,		"DROP", fscache_drop_object);
+static WORK_STATE(OBJECT_DEAD,		"DEAD", fscache_object_dead);
+
+static WAIT_STATE(WAIT_FOR_INIT,	"?INI",
+		  TRANSIT_TO(INIT_OBJECT,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
+
+static WAIT_STATE(WAIT_FOR_PARENT,	"?PRN",
+		  TRANSIT_TO(PARENT_READY,	1 << FSCACHE_OBJECT_EV_PARENT_READY));
+
+static WAIT_STATE(WAIT_FOR_CMD,		"?CMD",
+		  TRANSIT_TO(INVALIDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_INVALIDATE),
+		  TRANSIT_TO(UPDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_UPDATE),
+		  TRANSIT_TO(JUMPSTART_DEPS,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
+
+static WAIT_STATE(WAIT_FOR_CLEARANCE,	"?CLR",
+		  TRANSIT_TO(KILL_OBJECT,	1 << FSCACHE_OBJECT_EV_CLEARED));
+
+/*
+ * Out-of-band event transition tables.  These are for handling unexpected
+ * events, such as an I/O error.  If an OOB event occurs, the state machine
+ * clears and disables the event and forces a transition to the nominated work
+ * state (acurrently executing work states will complete first).
+ *
+ * In such a situation, object->state remembers the state the machine should
+ * have been in/gone to and returning NO_TRANSIT returns to that.
+ */
+static const struct fscache_transition fscache_osm_init_oob[] = {
+	   TRANSIT_TO(ABORT_INIT,
+		      (1 << FSCACHE_OBJECT_EV_ERROR) |
+		      (1 << FSCACHE_OBJECT_EV_KILL)),
+	   { 0, NULL }
+};
+
+static const struct fscache_transition fscache_osm_lookup_oob[] = {
+	   TRANSIT_TO(LOOKUP_FAILURE,
+		      (1 << FSCACHE_OBJECT_EV_ERROR) |
+		      (1 << FSCACHE_OBJECT_EV_KILL)),
+	   { 0, NULL }
+};
+
+static const struct fscache_transition fscache_osm_run_oob[] = {
+	   TRANSIT_TO(KILL_OBJECT,
+		      (1 << FSCACHE_OBJECT_EV_ERROR) |
+		      (1 << FSCACHE_OBJECT_EV_KILL)),
+	   { 0, NULL }
+};
+
+static int  fscache_get_object(struct fscache_object *,
+			       enum fscache_obj_ref_trace);
+static void fscache_put_object(struct fscache_object *,
+			       enum fscache_obj_ref_trace);
+static bool fscache_enqueue_dependents(struct fscache_object *, int);
+static void fscache_dequeue_object(struct fscache_object *);
+static void fscache_update_aux_data(struct fscache_object *);
+
+/*
+ * we need to notify the parent when an op completes that we had outstanding
+ * upon it
+ */
+static inline void fscache_done_parent_op(struct fscache_object *object)
+{
+	struct fscache_object *parent = object->parent;
+
+	_enter("OBJ%x {OBJ%x,%x}",
+	       object->debug_id, parent->debug_id, parent->n_ops);
+
+	spin_lock_nested(&parent->lock, 1);
+	parent->n_obj_ops--;
+	parent->n_ops--;
+	if (parent->n_ops == 0)
+		fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
+	spin_unlock(&parent->lock);
+}
+
+/*
+ * Object state machine dispatcher.
+ */
+static void fscache_object_sm_dispatcher(struct fscache_object *object)
+{
+	const struct fscache_transition *t;
+	const struct fscache_state *state, *new_state;
+	unsigned long events, event_mask;
+	bool oob;
+	int event = -1;
+
+	ASSERT(object != NULL);
+
+	_enter("{OBJ%x,%s,%lx}",
+	       object->debug_id, object->state->name, object->events);
+
+	event_mask = object->event_mask;
+restart:
+	object->event_mask = 0; /* Mask normal event handling */
+	state = object->state;
+restart_masked:
+	events = object->events;
+
+	/* Handle any out-of-band events (typically an error) */
+	if (events & object->oob_event_mask) {
+		_debug("{OBJ%x} oob %lx",
+		       object->debug_id, events & object->oob_event_mask);
+		oob = true;
+		for (t = object->oob_table; t->events; t++) {
+			if (events & t->events) {
+				state = t->transit_to;
+				ASSERT(state->work != NULL);
+				event = fls(events & t->events) - 1;
+				__clear_bit(event, &object->oob_event_mask);
+				clear_bit(event, &object->events);
+				goto execute_work_state;
+			}
+		}
+	}
+	oob = false;
+
+	/* Wait states are just transition tables */
+	if (!state->work) {
+		if (events & event_mask) {
+			for (t = state->transitions; t->events; t++) {
+				if (events & t->events) {
+					new_state = t->transit_to;
+					event = fls(events & t->events) - 1;
+					trace_fscache_osm(object, state,
+							  true, false, event);
+					clear_bit(event, &object->events);
+					_debug("{OBJ%x} ev %d: %s -> %s",
+					       object->debug_id, event,
+					       state->name, new_state->name);
+					object->state = state = new_state;
+					goto execute_work_state;
+				}
+			}
+
+			/* The event mask didn't include all the tabled bits */
+			BUG();
+		}
+		/* Randomly woke up */
+		goto unmask_events;
+	}
+
+execute_work_state:
+	_debug("{OBJ%x} exec %s", object->debug_id, state->name);
+
+	trace_fscache_osm(object, state, false, oob, event);
+	new_state = state->work(object, event);
+	event = -1;
+	if (new_state == NO_TRANSIT) {
+		_debug("{OBJ%x} %s notrans", object->debug_id, state->name);
+		if (unlikely(state == STATE(OBJECT_DEAD))) {
+			_leave(" [dead]");
+			return;
+		}
+		fscache_enqueue_object(object);
+		event_mask = object->oob_event_mask;
+		goto unmask_events;
+	}
+
+	_debug("{OBJ%x} %s -> %s",
+	       object->debug_id, state->name, new_state->name);
+	object->state = state = new_state;
+
+	if (state->work) {
+		if (unlikely(state == STATE(OBJECT_DEAD))) {
+			_leave(" [dead]");
+			return;
+		}
+		goto restart_masked;
+	}
+
+	/* Transited to wait state */
+	event_mask = object->oob_event_mask;
+	for (t = state->transitions; t->events; t++)
+		event_mask |= t->events;
+
+unmask_events:
+	object->event_mask = event_mask;
+	smp_mb();
+	events = object->events;
+	if (events & event_mask)
+		goto restart;
+	_leave(" [msk %lx]", event_mask);
+}
+
+/*
+ * execute an object
+ */
+static void fscache_object_work_func(struct work_struct *work)
+{
+	struct fscache_object *object =
+		container_of(work, struct fscache_object, work);
+
+	_enter("{OBJ%x}", object->debug_id);
+
+	fscache_object_sm_dispatcher(object);
+	fscache_put_object(object, fscache_obj_put_work);
+}
+
+/**
+ * fscache_object_init - Initialise a cache object description
+ * @object: Object description
+ * @cookie: Cookie object will be attached to
+ * @cache: Cache in which backing object will be found
+ *
+ * Initialise a cache object description to its basic values.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+void fscache_object_init(struct fscache_object *object,
+			 struct fscache_cookie *cookie,
+			 struct fscache_cache *cache)
+{
+	const struct fscache_transition *t;
+
+	atomic_inc(&cache->object_count);
+
+	object->state = STATE(WAIT_FOR_INIT);
+	object->oob_table = fscache_osm_init_oob;
+	object->flags = 1 << FSCACHE_OBJECT_IS_LIVE;
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	INIT_HLIST_NODE(&object->cookie_link);
+	INIT_WORK(&object->work, fscache_object_work_func);
+	INIT_LIST_HEAD(&object->dependents);
+	INIT_LIST_HEAD(&object->dep_link);
+	INIT_LIST_HEAD(&object->pending_ops);
+	object->n_children = 0;
+	object->n_ops = object->n_in_progress = object->n_exclusive = 0;
+	object->events = 0;
+	object->store_limit = 0;
+	object->store_limit_l = 0;
+	object->cache = cache;
+	object->cookie = cookie;
+	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
+	object->parent = NULL;
+#ifdef CONFIG_FSCACHE_OBJECT_LIST
+	RB_CLEAR_NODE(&object->objlist_link);
+#endif
+
+	object->oob_event_mask = 0;
+	for (t = object->oob_table; t->events; t++)
+		object->oob_event_mask |= t->events;
+	object->event_mask = object->oob_event_mask;
+	for (t = object->state->transitions; t->events; t++)
+		object->event_mask |= t->events;
+}
+EXPORT_SYMBOL(fscache_object_init);
+
+/*
+ * Mark the object as no longer being live, making sure that we synchronise
+ * against op submission.
+ */
+static inline void fscache_mark_object_dead(struct fscache_object *object)
+{
+	spin_lock(&object->lock);
+	clear_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
+	spin_unlock(&object->lock);
+}
+
+/*
+ * Abort object initialisation before we start it.
+ */
+static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *object,
+								int event)
+{
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	object->oob_event_mask = 0;
+	fscache_dequeue_object(object);
+	return transit_to(KILL_OBJECT);
+}
+
+/*
+ * initialise an object
+ * - check the specified object's parent to see if we can make use of it
+ *   immediately to do a creation
+ * - we may need to start the process of creating a parent and we need to wait
+ *   for the parent's lookup and creation to complete if it's not there yet
+ */
+static const struct fscache_state *fscache_initialise_object(struct fscache_object *object,
+							     int event)
+{
+	struct fscache_object *parent;
+	bool success;
+
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	ASSERT(list_empty(&object->dep_link));
+
+	parent = object->parent;
+	if (!parent) {
+		_leave(" [no parent]");
+		return transit_to(DROP_OBJECT);
+	}
+
+	_debug("parent: %s of:%lx", parent->state->name, parent->flags);
+
+	if (fscache_object_is_dying(parent)) {
+		_leave(" [bad parent]");
+		return transit_to(DROP_OBJECT);
+	}
+
+	if (fscache_object_is_available(parent)) {
+		_leave(" [ready]");
+		return transit_to(PARENT_READY);
+	}
+
+	_debug("wait");
+
+	spin_lock(&parent->lock);
+	fscache_stat(&fscache_n_cop_grab_object);
+	success = false;
+	if (fscache_object_is_live(parent) &&
+	    object->cache->ops->grab_object(object, fscache_obj_get_add_to_deps)) {
+		list_add(&object->dep_link, &parent->dependents);
+		success = true;
+	}
+	fscache_stat_d(&fscache_n_cop_grab_object);
+	spin_unlock(&parent->lock);
+	if (!success) {
+		_leave(" [grab failed]");
+		return transit_to(DROP_OBJECT);
+	}
+
+	/* fscache_acquire_non_index_cookie() uses this
+	 * to wake the chain up */
+	fscache_raise_event(parent, FSCACHE_OBJECT_EV_NEW_CHILD);
+	_leave(" [wait]");
+	return transit_to(WAIT_FOR_PARENT);
+}
+
+/*
+ * Once the parent object is ready, we should kick off our lookup op.
+ */
+static const struct fscache_state *fscache_parent_ready(struct fscache_object *object,
+							int event)
+{
+	struct fscache_object *parent = object->parent;
+
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	ASSERT(parent != NULL);
+
+	spin_lock(&parent->lock);
+	parent->n_ops++;
+	parent->n_obj_ops++;
+	spin_unlock(&parent->lock);
+
+	_leave("");
+	return transit_to(LOOK_UP_OBJECT);
+}
+
+/*
+ * look an object up in the cache from which it was allocated
+ * - we hold an "access lock" on the parent object, so the parent object cannot
+ *   be withdrawn by either party till we've finished
+ */
+static const struct fscache_state *fscache_look_up_object(struct fscache_object *object,
+							  int event)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_object *parent = object->parent;
+	int ret;
+
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	object->oob_table = fscache_osm_lookup_oob;
+
+	ASSERT(parent != NULL);
+	ASSERTCMP(parent->n_ops, >, 0);
+	ASSERTCMP(parent->n_obj_ops, >, 0);
+
+	/* make sure the parent is still available */
+	ASSERT(fscache_object_is_available(parent));
+
+	if (fscache_object_is_dying(parent) ||
+	    test_bit(FSCACHE_IOERROR, &object->cache->flags) ||
+	    !fscache_use_cookie(object)) {
+		_leave(" [unavailable]");
+		return transit_to(LOOKUP_FAILURE);
+	}
+
+	_debug("LOOKUP \"%s\" in \"%s\"",
+	       cookie->def->name, object->cache->tag->name);
+
+	fscache_stat(&fscache_n_object_lookups);
+	fscache_stat(&fscache_n_cop_lookup_object);
+	ret = object->cache->ops->lookup_object(object);
+	fscache_stat_d(&fscache_n_cop_lookup_object);
+
+	fscache_unuse_cookie(object);
+
+	if (ret == -ETIMEDOUT) {
+		/* probably stuck behind another object, so move this one to
+		 * the back of the queue */
+		fscache_stat(&fscache_n_object_lookups_timed_out);
+		_leave(" [timeout]");
+		return NO_TRANSIT;
+	}
+
+	if (ret < 0) {
+		_leave(" [error]");
+		return transit_to(LOOKUP_FAILURE);
+	}
+
+	_leave(" [ok]");
+	return transit_to(OBJECT_AVAILABLE);
+}
+
+/**
+ * fscache_object_lookup_negative - Note negative cookie lookup
+ * @object: Object pointing to cookie to mark
+ *
+ * Note negative lookup, permitting those waiting to read data from an already
+ * existing backing object to continue as there's no data for them to read.
+ */
+void fscache_object_lookup_negative(struct fscache_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+
+	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
+
+	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
+		fscache_stat(&fscache_n_object_lookups_negative);
+
+		/* Allow write requests to begin stacking up and read requests to begin
+		 * returning ENODATA.
+		 */
+		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
+
+		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+	}
+	_leave("");
+}
+EXPORT_SYMBOL(fscache_object_lookup_negative);
+
+/**
+ * fscache_obtained_object - Note successful object lookup or creation
+ * @object: Object pointing to cookie to mark
+ *
+ * Note successful lookup and/or creation, permitting those waiting to write
+ * data to a backing object to continue.
+ *
+ * Note that after calling this, an object's cookie may be relinquished by the
+ * netfs, and so must be accessed with object lock held.
+ */
+void fscache_obtained_object(struct fscache_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+
+	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
+
+	/* if we were still looking up, then we must have a positive lookup
+	 * result, in which case there may be data available */
+	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
+		fscache_stat(&fscache_n_object_lookups_positive);
+
+		/* We do (presumably) have data */
+		clear_bit_unlock(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
+
+		/* Allow write requests to begin stacking up and read requests
+		 * to begin shovelling data.
+		 */
+		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+	} else {
+		fscache_stat(&fscache_n_object_created);
+	}
+
+	set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
+	_leave("");
+}
+EXPORT_SYMBOL(fscache_obtained_object);
+
+/*
+ * handle an object that has just become available
+ */
+static const struct fscache_state *fscache_object_available(struct fscache_object *object,
+							    int event)
+{
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	object->oob_table = fscache_osm_run_oob;
+
+	spin_lock(&object->lock);
+
+	fscache_done_parent_op(object);
+	if (object->n_in_progress == 0) {
+		if (object->n_ops > 0) {
+			ASSERTCMP(object->n_ops, >=, object->n_obj_ops);
+			fscache_start_operations(object);
+		} else {
+			ASSERT(list_empty(&object->pending_ops));
+		}
+	}
+	spin_unlock(&object->lock);
+
+	fscache_stat(&fscache_n_cop_lookup_complete);
+	object->cache->ops->lookup_complete(object);
+	fscache_stat_d(&fscache_n_cop_lookup_complete);
+
+	fscache_stat(&fscache_n_object_avail);
+
+	_leave("");
+	return transit_to(JUMPSTART_DEPS);
+}
+
+/*
+ * Wake up this object's dependent objects now that we've become available.
+ */
+static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *object,
+								int event)
+{
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_PARENT_READY))
+		return NO_TRANSIT; /* Not finished; requeue */
+	return transit_to(WAIT_FOR_CMD);
+}
+
+/*
+ * Handle lookup or creation failute.
+ */
+static const struct fscache_state *fscache_lookup_failure(struct fscache_object *object,
+							  int event)
+{
+	struct fscache_cookie *cookie;
+
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	object->oob_event_mask = 0;
+
+	fscache_stat(&fscache_n_cop_lookup_complete);
+	object->cache->ops->lookup_complete(object);
+	fscache_stat_d(&fscache_n_cop_lookup_complete);
+
+	set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags);
+
+	cookie = object->cookie;
+	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+
+	fscache_done_parent_op(object);
+	return transit_to(KILL_OBJECT);
+}
+
+/*
+ * Wait for completion of all active operations on this object and the death of
+ * all child objects of this object.
+ */
+static const struct fscache_state *fscache_kill_object(struct fscache_object *object,
+						       int event)
+{
+	_enter("{OBJ%x,%d,%d},%d",
+	       object->debug_id, object->n_ops, object->n_children, event);
+
+	fscache_mark_object_dead(object);
+	object->oob_event_mask = 0;
+
+	if (test_bit(FSCACHE_OBJECT_RETIRED, &object->flags)) {
+		/* Reject any new read/write ops and abort any that are pending. */
+		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
+		fscache_cancel_all_ops(object);
+	}
+
+	if (list_empty(&object->dependents) &&
+	    object->n_ops == 0 &&
+	    object->n_children == 0)
+		return transit_to(DROP_OBJECT);
+
+	if (object->n_in_progress == 0) {
+		spin_lock(&object->lock);
+		if (object->n_ops > 0 && object->n_in_progress == 0)
+			fscache_start_operations(object);
+		spin_unlock(&object->lock);
+	}
+
+	if (!list_empty(&object->dependents))
+		return transit_to(KILL_DEPENDENTS);
+
+	return transit_to(WAIT_FOR_CLEARANCE);
+}
+
+/*
+ * Kill dependent objects.
+ */
+static const struct fscache_state *fscache_kill_dependents(struct fscache_object *object,
+							   int event)
+{
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_KILL))
+		return NO_TRANSIT; /* Not finished */
+	return transit_to(WAIT_FOR_CLEARANCE);
+}
+
+/*
+ * Drop an object's attachments
+ */
+static const struct fscache_state *fscache_drop_object(struct fscache_object *object,
+						       int event)
+{
+	struct fscache_object *parent = object->parent;
+	struct fscache_cookie *cookie = object->cookie;
+	struct fscache_cache *cache = object->cache;
+	bool awaken = false;
+
+	_enter("{OBJ%x,%d},%d", object->debug_id, object->n_children, event);
+
+	ASSERT(cookie != NULL);
+	ASSERT(!hlist_unhashed(&object->cookie_link));
+
+	if (test_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags)) {
+		_debug("final update");
+		fscache_update_aux_data(object);
+	}
+
+	/* Make sure the cookie no longer points here and that the netfs isn't
+	 * waiting for us.
+	 */
+	spin_lock(&cookie->lock);
+	hlist_del_init(&object->cookie_link);
+	if (hlist_empty(&cookie->backing_objects) &&
+	    test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
+		awaken = true;
+	spin_unlock(&cookie->lock);
+
+	if (awaken)
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
+
+
+	/* Prevent a race with our last child, which has to signal EV_CLEARED
+	 * before dropping our spinlock.
+	 */
+	spin_lock(&object->lock);
+	spin_unlock(&object->lock);
+
+	/* Discard from the cache's collection of objects */
+	spin_lock(&cache->object_list_lock);
+	list_del_init(&object->cache_link);
+	spin_unlock(&cache->object_list_lock);
+
+	fscache_stat(&fscache_n_cop_drop_object);
+	cache->ops->drop_object(object);
+	fscache_stat_d(&fscache_n_cop_drop_object);
+
+	/* The parent object wants to know when all it dependents have gone */
+	if (parent) {
+		_debug("release parent OBJ%x {%d}",
+		       parent->debug_id, parent->n_children);
+
+		spin_lock(&parent->lock);
+		parent->n_children--;
+		if (parent->n_children == 0)
+			fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
+		spin_unlock(&parent->lock);
+		object->parent = NULL;
+	}
+
+	/* this just shifts the object release to the work processor */
+	fscache_put_object(object, fscache_obj_put_drop_obj);
+	fscache_stat(&fscache_n_object_dead);
+
+	_leave("");
+	return transit_to(OBJECT_DEAD);
+}
+
+/*
+ * get a ref on an object
+ */
+static int fscache_get_object(struct fscache_object *object,
+			      enum fscache_obj_ref_trace why)
+{
+	int ret;
+
+	fscache_stat(&fscache_n_cop_grab_object);
+	ret = object->cache->ops->grab_object(object, why) ? 0 : -EAGAIN;
+	fscache_stat_d(&fscache_n_cop_grab_object);
+	return ret;
+}
+
+/*
+ * Discard a ref on an object
+ */
+static void fscache_put_object(struct fscache_object *object,
+			       enum fscache_obj_ref_trace why)
+{
+	fscache_stat(&fscache_n_cop_put_object);
+	object->cache->ops->put_object(object, why);
+	fscache_stat_d(&fscache_n_cop_put_object);
+}
+
+/**
+ * fscache_object_destroy - Note that a cache object is about to be destroyed
+ * @object: The object to be destroyed
+ *
+ * Note the imminent destruction and deallocation of a cache object record.
+ */
+void fscache_object_destroy(struct fscache_object *object)
+{
+	/* We can get rid of the cookie now */
+	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
+	object->cookie = NULL;
+}
+EXPORT_SYMBOL(fscache_object_destroy);
+
+/*
+ * enqueue an object for metadata-type processing
+ */
+void fscache_enqueue_object(struct fscache_object *object)
+{
+	_enter("{OBJ%x}", object->debug_id);
+
+	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
+		wait_queue_head_t *cong_wq =
+			&get_cpu_var(fscache_object_cong_wait);
+
+		if (queue_work(fscache_object_wq, &object->work)) {
+			if (fscache_object_congested())
+				wake_up(cong_wq);
+		} else
+			fscache_put_object(object, fscache_obj_put_queue);
+
+		put_cpu_var(fscache_object_cong_wait);
+	}
+}
+
+/**
+ * fscache_object_sleep_till_congested - Sleep until object wq is congested
+ * @timeoutp: Scheduler sleep timeout
+ *
+ * Allow an object handler to sleep until the object workqueue is congested.
+ *
+ * The caller must set up a wake up event before calling this and must have set
+ * the appropriate sleep mode (such as TASK_UNINTERRUPTIBLE) and tested its own
+ * condition before calling this function as no test is made here.
+ *
+ * %true is returned if the object wq is congested, %false otherwise.
+ */
+bool fscache_object_sleep_till_congested(signed long *timeoutp)
+{
+	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
+	DEFINE_WAIT(wait);
+
+	if (fscache_object_congested())
+		return true;
+
+	add_wait_queue_exclusive(cong_wq, &wait);
+	if (!fscache_object_congested())
+		*timeoutp = schedule_timeout(*timeoutp);
+	finish_wait(cong_wq, &wait);
+
+	return fscache_object_congested();
+}
+EXPORT_SYMBOL_GPL(fscache_object_sleep_till_congested);
+
+/*
+ * Enqueue the dependents of an object for metadata-type processing.
+ *
+ * If we don't manage to finish the list before the scheduler wants to run
+ * again then return false immediately.  We return true if the list was
+ * cleared.
+ */
+static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
+{
+	struct fscache_object *dep;
+	bool ret = true;
+
+	_enter("{OBJ%x}", object->debug_id);
+
+	if (list_empty(&object->dependents))
+		return true;
+
+	spin_lock(&object->lock);
+
+	while (!list_empty(&object->dependents)) {
+		dep = list_entry(object->dependents.next,
+				 struct fscache_object, dep_link);
+		list_del_init(&dep->dep_link);
+
+		fscache_raise_event(dep, event);
+		fscache_put_object(dep, fscache_obj_put_enq_dep);
+
+		if (!list_empty(&object->dependents) && need_resched()) {
+			ret = false;
+			break;
+		}
+	}
+
+	spin_unlock(&object->lock);
+	return ret;
+}
+
+/*
+ * remove an object from whatever queue it's waiting on
+ */
+static void fscache_dequeue_object(struct fscache_object *object)
+{
+	_enter("{OBJ%x}", object->debug_id);
+
+	if (!list_empty(&object->dep_link)) {
+		spin_lock(&object->parent->lock);
+		list_del_init(&object->dep_link);
+		spin_unlock(&object->parent->lock);
+	}
+
+	_leave("");
+}
+
+/**
+ * fscache_check_aux - Ask the netfs whether an object on disk is still valid
+ * @object: The object to ask about
+ * @data: The auxiliary data for the object
+ * @datalen: The size of the auxiliary data
+ * @object_size: The size of the object according to the server.
+ *
+ * This function consults the netfs about the coherency state of an object.
+ * The caller must be holding a ref on cookie->n_active (held by
+ * fscache_look_up_object() on behalf of the cache backend during object lookup
+ * and creation).
+ */
+enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
+					const void *data, uint16_t datalen,
+					loff_t object_size)
+{
+	enum fscache_checkaux result;
+
+	if (!object->cookie->def->check_aux) {
+		fscache_stat(&fscache_n_checkaux_none);
+		return FSCACHE_CHECKAUX_OKAY;
+	}
+
+	result = object->cookie->def->check_aux(object->cookie->netfs_data,
+						data, datalen, object_size);
+	switch (result) {
+		/* entry okay as is */
+	case FSCACHE_CHECKAUX_OKAY:
+		fscache_stat(&fscache_n_checkaux_okay);
+		break;
+
+		/* entry requires update */
+	case FSCACHE_CHECKAUX_NEEDS_UPDATE:
+		fscache_stat(&fscache_n_checkaux_update);
+		break;
+
+		/* entry requires deletion */
+	case FSCACHE_CHECKAUX_OBSOLETE:
+		fscache_stat(&fscache_n_checkaux_obsolete);
+		break;
+
+	default:
+		BUG();
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(fscache_check_aux);
+
+/*
+ * Asynchronously invalidate an object.
+ */
+static const struct fscache_state *_fscache_invalidate_object(struct fscache_object *object,
+							      int event)
+{
+	struct fscache_operation *op;
+	struct fscache_cookie *cookie = object->cookie;
+
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	/* We're going to need the cookie.  If the cookie is not available then
+	 * retire the object instead.
+	 */
+	if (!fscache_use_cookie(object)) {
+		set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
+		_leave(" [no cookie]");
+		return transit_to(KILL_OBJECT);
+	}
+
+	/* Reject any new read/write ops and abort any that are pending. */
+	clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
+	fscache_cancel_all_ops(object);
+
+	/* Now we have to wait for in-progress reads and writes */
+	op = kzalloc(sizeof(*op), GFP_KERNEL);
+	if (!op)
+		goto nomem;
+
+	fscache_operation_init(cookie, op, object->cache->ops->invalidate_object,
+			       NULL, NULL);
+	op->flags = FSCACHE_OP_ASYNC |
+		(1 << FSCACHE_OP_EXCLUSIVE) |
+		(1 << FSCACHE_OP_UNUSE_COOKIE);
+	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_invalidate);
+
+	spin_lock(&cookie->lock);
+	if (fscache_submit_exclusive_op(object, op) < 0)
+		goto submit_op_failed;
+	spin_unlock(&cookie->lock);
+	fscache_put_operation(op);
+
+	/* Once we've completed the invalidation, we know there will be no data
+	 * stored in the cache and thus we can reinstate the data-check-skip
+	 * optimisation.
+	 */
+	set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
+
+	/* We can allow read and write requests to come in once again.  They'll
+	 * queue up behind our exclusive invalidation operation.
+	 */
+	if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	_leave(" [ok]");
+	return transit_to(UPDATE_OBJECT);
+
+nomem:
+	fscache_mark_object_dead(object);
+	fscache_unuse_cookie(object);
+	_leave(" [ENOMEM]");
+	return transit_to(KILL_OBJECT);
+
+submit_op_failed:
+	fscache_mark_object_dead(object);
+	spin_unlock(&cookie->lock);
+	fscache_unuse_cookie(object);
+	kfree(op);
+	_leave(" [EIO]");
+	return transit_to(KILL_OBJECT);
+}
+
+static const struct fscache_state *fscache_invalidate_object(struct fscache_object *object,
+							     int event)
+{
+	const struct fscache_state *s;
+
+	fscache_stat(&fscache_n_invalidates_run);
+	fscache_stat(&fscache_n_cop_invalidate_object);
+	s = _fscache_invalidate_object(object, event);
+	fscache_stat_d(&fscache_n_cop_invalidate_object);
+	return s;
+}
+
+/*
+ * Update auxiliary data.
+ */
+static void fscache_update_aux_data(struct fscache_object *object)
+{
+	fscache_stat(&fscache_n_updates_run);
+	fscache_stat(&fscache_n_cop_update_object);
+	object->cache->ops->update_object(object);
+	fscache_stat_d(&fscache_n_cop_update_object);
+}
+
+/*
+ * Asynchronously update an object.
+ */
+static const struct fscache_state *fscache_update_object(struct fscache_object *object,
+							 int event)
+{
+	_enter("{OBJ%x},%d", object->debug_id, event);
+
+	fscache_update_aux_data(object);
+
+	_leave("");
+	return transit_to(WAIT_FOR_CMD);
+}
+
+/**
+ * fscache_object_retrying_stale - Note retrying stale object
+ * @object: The object that will be retried
+ *
+ * Note that an object lookup found an on-disk object that was adjudged to be
+ * stale and has been deleted.  The lookup will be retried.
+ */
+void fscache_object_retrying_stale(struct fscache_object *object)
+{
+	fscache_stat(&fscache_n_cache_no_space_reject);
+}
+EXPORT_SYMBOL(fscache_object_retrying_stale);
+
+/**
+ * fscache_object_mark_killed - Note that an object was killed
+ * @object: The object that was culled
+ * @why: The reason the object was killed.
+ *
+ * Note that an object was killed.  Returns true if the object was
+ * already marked killed, false if it wasn't.
+ */
+void fscache_object_mark_killed(struct fscache_object *object,
+				enum fscache_why_object_killed why)
+{
+	if (test_and_set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags)) {
+		pr_err("Error: Object already killed by cache [%s]\n",
+		       object->cache->identifier);
+		return;
+	}
+
+	switch (why) {
+	case FSCACHE_OBJECT_NO_SPACE:
+		fscache_stat(&fscache_n_cache_no_space_reject);
+		break;
+	case FSCACHE_OBJECT_IS_STALE:
+		fscache_stat(&fscache_n_cache_stale_objects);
+		break;
+	case FSCACHE_OBJECT_WAS_RETIRED:
+		fscache_stat(&fscache_n_cache_retired_objects);
+		break;
+	case FSCACHE_OBJECT_WAS_CULLED:
+		fscache_stat(&fscache_n_cache_culled_objects);
+		break;
+	}
+}
+EXPORT_SYMBOL(fscache_object_mark_killed);
+
+/*
+ * The object is dead.  We can get here if an object gets queued by an event
+ * that would lead to its death (such as EV_KILL) when the dispatcher is
+ * already running (and so can be requeued) but hasn't yet cleared the event
+ * mask.
+ */
+static const struct fscache_state *fscache_object_dead(struct fscache_object *object,
+						       int event)
+{
+	if (!test_and_set_bit(FSCACHE_OBJECT_RUN_AFTER_DEAD,
+			      &object->flags))
+		return NO_TRANSIT;
+
+	WARN(true, "FS-Cache object redispatched after death");
+	return NO_TRANSIT;
+}
diff --git a/fs/fscache_old/operation.c b/fs/fscache_old/operation.c
new file mode 100644
index 000000000000..e002cdfaf3cc
--- /dev/null
+++ b/fs/fscache_old/operation.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache worker operation management routines
+ *
+ * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/filesystems/caching/operations.rst
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+atomic_t fscache_op_debug_id;
+EXPORT_SYMBOL(fscache_op_debug_id);
+
+static void fscache_operation_dummy_cancel(struct fscache_operation *op)
+{
+}
+
+/**
+ * fscache_operation_init - Do basic initialisation of an operation
+ * @cookie: The cookie to operate on
+ * @op: The operation to initialise
+ * @processor: The function to perform the operation
+ * @cancel: A function to handle operation cancellation
+ * @release: The release function to assign
+ *
+ * Do basic initialisation of an operation.  The caller must still set flags,
+ * object and processor if needed.
+ */
+void fscache_operation_init(struct fscache_cookie *cookie,
+			    struct fscache_operation *op,
+			    fscache_operation_processor_t processor,
+			    fscache_operation_cancel_t cancel,
+			    fscache_operation_release_t release)
+{
+	INIT_WORK(&op->work, fscache_op_work_func);
+	atomic_set(&op->usage, 1);
+	op->state = FSCACHE_OP_ST_INITIALISED;
+	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
+	op->processor = processor;
+	op->cancel = cancel ?: fscache_operation_dummy_cancel;
+	op->release = release;
+	INIT_LIST_HEAD(&op->pend_link);
+	fscache_stat(&fscache_n_op_initialised);
+	trace_fscache_op(cookie, op, fscache_op_init);
+}
+EXPORT_SYMBOL(fscache_operation_init);
+
+/**
+ * fscache_enqueue_operation - Enqueue an operation for processing
+ * @op: The operation to enqueue
+ *
+ * Enqueue an operation for processing by the FS-Cache thread pool.
+ *
+ * This will get its own ref on the object.
+ */
+void fscache_enqueue_operation(struct fscache_operation *op)
+{
+	struct fscache_cookie *cookie = op->object->cookie;
+	
+	_enter("{OBJ%x OP%x,%u}",
+	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
+
+	ASSERT(list_empty(&op->pend_link));
+	ASSERT(op->processor != NULL);
+	ASSERT(fscache_object_is_available(op->object));
+	ASSERTCMP(atomic_read(&op->usage), >, 0);
+	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
+		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
+
+	fscache_stat(&fscache_n_op_enqueue);
+	switch (op->flags & FSCACHE_OP_TYPE) {
+	case FSCACHE_OP_ASYNC:
+		trace_fscache_op(cookie, op, fscache_op_enqueue_async);
+		_debug("queue async");
+		atomic_inc(&op->usage);
+		if (!queue_work(fscache_op_wq, &op->work))
+			fscache_put_operation(op);
+		break;
+	case FSCACHE_OP_MYTHREAD:
+		trace_fscache_op(cookie, op, fscache_op_enqueue_mythread);
+		_debug("queue for caller's attention");
+		break;
+	default:
+		pr_err("Unexpected op type %lx", op->flags);
+		BUG();
+		break;
+	}
+}
+EXPORT_SYMBOL(fscache_enqueue_operation);
+
+/*
+ * start an op running
+ */
+static void fscache_run_op(struct fscache_object *object,
+			   struct fscache_operation *op)
+{
+	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
+
+	op->state = FSCACHE_OP_ST_IN_PROGRESS;
+	object->n_in_progress++;
+	if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
+		wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
+	if (op->processor)
+		fscache_enqueue_operation(op);
+	else
+		trace_fscache_op(object->cookie, op, fscache_op_run);
+	fscache_stat(&fscache_n_op_run);
+}
+
+/*
+ * report an unexpected submission
+ */
+static void fscache_report_unexpected_submission(struct fscache_object *object,
+						 struct fscache_operation *op,
+						 const struct fscache_state *ostate)
+{
+	static bool once_only;
+	struct fscache_operation *p;
+	unsigned n;
+
+	if (once_only)
+		return;
+	once_only = true;
+
+	kdebug("unexpected submission OP%x [OBJ%x %s]",
+	       op->debug_id, object->debug_id, object->state->name);
+	kdebug("objstate=%s [%s]", object->state->name, ostate->name);
+	kdebug("objflags=%lx", object->flags);
+	kdebug("objevent=%lx [%lx]", object->events, object->event_mask);
+	kdebug("ops=%u inp=%u exc=%u",
+	       object->n_ops, object->n_in_progress, object->n_exclusive);
+
+	if (!list_empty(&object->pending_ops)) {
+		n = 0;
+		list_for_each_entry(p, &object->pending_ops, pend_link) {
+			ASSERTCMP(p->object, ==, object);
+			kdebug("%p %p", op->processor, op->release);
+			n++;
+		}
+
+		kdebug("n=%u", n);
+	}
+
+	dump_stack();
+}
+
+/*
+ * submit an exclusive operation for an object
+ * - other ops are excluded from running simultaneously with this one
+ * - this gets any extra refs it needs on an op
+ */
+int fscache_submit_exclusive_op(struct fscache_object *object,
+				struct fscache_operation *op)
+{
+	const struct fscache_state *ostate;
+	unsigned long flags;
+	int ret;
+
+	_enter("{OBJ%x OP%x},", object->debug_id, op->debug_id);
+
+	trace_fscache_op(object->cookie, op, fscache_op_submit_ex);
+
+	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
+	ASSERTCMP(atomic_read(&op->usage), >, 0);
+
+	spin_lock(&object->lock);
+	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
+	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
+	ASSERT(list_empty(&op->pend_link));
+
+	ostate = object->state;
+	smp_rmb();
+
+	op->state = FSCACHE_OP_ST_PENDING;
+	flags = READ_ONCE(object->flags);
+	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
+		fscache_stat(&fscache_n_op_rejected);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	} else if (unlikely(fscache_cache_is_broken(object))) {
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -EIO;
+	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
+		op->object = object;
+		object->n_ops++;
+		object->n_exclusive++;	/* reads and writes must wait */
+
+		if (object->n_in_progress > 0) {
+			atomic_inc(&op->usage);
+			list_add_tail(&op->pend_link, &object->pending_ops);
+			fscache_stat(&fscache_n_op_pend);
+		} else if (!list_empty(&object->pending_ops)) {
+			atomic_inc(&op->usage);
+			list_add_tail(&op->pend_link, &object->pending_ops);
+			fscache_stat(&fscache_n_op_pend);
+			fscache_start_operations(object);
+		} else {
+			ASSERTCMP(object->n_in_progress, ==, 0);
+			fscache_run_op(object, op);
+		}
+
+		/* need to issue a new write op after this */
+		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
+		ret = 0;
+	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
+		op->object = object;
+		object->n_ops++;
+		object->n_exclusive++;	/* reads and writes must wait */
+		atomic_inc(&op->usage);
+		list_add_tail(&op->pend_link, &object->pending_ops);
+		fscache_stat(&fscache_n_op_pend);
+		ret = 0;
+	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	} else {
+		fscache_report_unexpected_submission(object, op, ostate);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	}
+
+	spin_unlock(&object->lock);
+	return ret;
+}
+
+/*
+ * submit an operation for an object
+ * - objects may be submitted only in the following states:
+ *   - during object creation (write ops may be submitted)
+ *   - whilst the object is active
+ *   - after an I/O error incurred in one of the two above states (op rejected)
+ * - this gets any extra refs it needs on an op
+ */
+int fscache_submit_op(struct fscache_object *object,
+		      struct fscache_operation *op)
+{
+	const struct fscache_state *ostate;
+	unsigned long flags;
+	int ret;
+
+	_enter("{OBJ%x OP%x},{%u}",
+	       object->debug_id, op->debug_id, atomic_read(&op->usage));
+
+	trace_fscache_op(object->cookie, op, fscache_op_submit);
+
+	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
+	ASSERTCMP(atomic_read(&op->usage), >, 0);
+
+	spin_lock(&object->lock);
+	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
+	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
+	ASSERT(list_empty(&op->pend_link));
+
+	ostate = object->state;
+	smp_rmb();
+
+	op->state = FSCACHE_OP_ST_PENDING;
+	flags = READ_ONCE(object->flags);
+	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
+		fscache_stat(&fscache_n_op_rejected);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	} else if (unlikely(fscache_cache_is_broken(object))) {
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -EIO;
+	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
+		op->object = object;
+		object->n_ops++;
+
+		if (object->n_exclusive > 0) {
+			atomic_inc(&op->usage);
+			list_add_tail(&op->pend_link, &object->pending_ops);
+			fscache_stat(&fscache_n_op_pend);
+		} else if (!list_empty(&object->pending_ops)) {
+			atomic_inc(&op->usage);
+			list_add_tail(&op->pend_link, &object->pending_ops);
+			fscache_stat(&fscache_n_op_pend);
+			fscache_start_operations(object);
+		} else {
+			ASSERTCMP(object->n_exclusive, ==, 0);
+			fscache_run_op(object, op);
+		}
+		ret = 0;
+	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
+		op->object = object;
+		object->n_ops++;
+		atomic_inc(&op->usage);
+		list_add_tail(&op->pend_link, &object->pending_ops);
+		fscache_stat(&fscache_n_op_pend);
+		ret = 0;
+	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	} else {
+		fscache_report_unexpected_submission(object, op, ostate);
+		ASSERT(!fscache_object_is_active(object));
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		ret = -ENOBUFS;
+	}
+
+	spin_unlock(&object->lock);
+	return ret;
+}
+
+/*
+ * queue an object for withdrawal on error, aborting all following asynchronous
+ * operations
+ */
+void fscache_abort_object(struct fscache_object *object)
+{
+	_enter("{OBJ%x}", object->debug_id);
+
+	fscache_raise_event(object, FSCACHE_OBJECT_EV_ERROR);
+}
+
+/*
+ * Jump start the operation processing on an object.  The caller must hold
+ * object->lock.
+ */
+void fscache_start_operations(struct fscache_object *object)
+{
+	struct fscache_operation *op;
+	bool stop = false;
+
+	while (!list_empty(&object->pending_ops) && !stop) {
+		op = list_entry(object->pending_ops.next,
+				struct fscache_operation, pend_link);
+
+		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags)) {
+			if (object->n_in_progress > 0)
+				break;
+			stop = true;
+		}
+		list_del_init(&op->pend_link);
+		fscache_run_op(object, op);
+
+		/* the pending queue was holding a ref on the object */
+		fscache_put_operation(op);
+	}
+
+	ASSERTCMP(object->n_in_progress, <=, object->n_ops);
+
+	_debug("woke %d ops on OBJ%x",
+	       object->n_in_progress, object->debug_id);
+}
+
+/*
+ * cancel an operation that's pending on an object
+ */
+int fscache_cancel_op(struct fscache_operation *op,
+		      bool cancel_in_progress_op)
+{
+	struct fscache_object *object = op->object;
+	bool put = false;
+	int ret;
+
+	_enter("OBJ%x OP%x}", op->object->debug_id, op->debug_id);
+
+	trace_fscache_op(object->cookie, op, fscache_op_cancel);
+
+	ASSERTCMP(op->state, >=, FSCACHE_OP_ST_PENDING);
+	ASSERTCMP(op->state, !=, FSCACHE_OP_ST_CANCELLED);
+	ASSERTCMP(atomic_read(&op->usage), >, 0);
+
+	spin_lock(&object->lock);
+
+	ret = -EBUSY;
+	if (op->state == FSCACHE_OP_ST_PENDING) {
+		ASSERT(!list_empty(&op->pend_link));
+		list_del_init(&op->pend_link);
+		put = true;
+
+		fscache_stat(&fscache_n_op_cancelled);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
+			object->n_exclusive--;
+		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
+			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
+		ret = 0;
+	} else if (op->state == FSCACHE_OP_ST_IN_PROGRESS && cancel_in_progress_op) {
+		ASSERTCMP(object->n_in_progress, >, 0);
+		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
+			object->n_exclusive--;
+		object->n_in_progress--;
+		if (object->n_in_progress == 0)
+			fscache_start_operations(object);
+
+		fscache_stat(&fscache_n_op_cancelled);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
+			object->n_exclusive--;
+		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
+			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
+		ret = 0;
+	}
+
+	if (put)
+		fscache_put_operation(op);
+	spin_unlock(&object->lock);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Cancel all pending operations on an object
+ */
+void fscache_cancel_all_ops(struct fscache_object *object)
+{
+	struct fscache_operation *op;
+
+	_enter("OBJ%x", object->debug_id);
+
+	spin_lock(&object->lock);
+
+	while (!list_empty(&object->pending_ops)) {
+		op = list_entry(object->pending_ops.next,
+				struct fscache_operation, pend_link);
+		fscache_stat(&fscache_n_op_cancelled);
+		list_del_init(&op->pend_link);
+
+		trace_fscache_op(object->cookie, op, fscache_op_cancel_all);
+
+		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
+		op->cancel(op);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+
+		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
+			object->n_exclusive--;
+		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
+			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
+		fscache_put_operation(op);
+		cond_resched_lock(&object->lock);
+	}
+
+	spin_unlock(&object->lock);
+	_leave("");
+}
+
+/*
+ * Record the completion or cancellation of an in-progress operation.
+ */
+void fscache_op_complete(struct fscache_operation *op, bool cancelled)
+{
+	struct fscache_object *object = op->object;
+
+	_enter("OBJ%x", object->debug_id);
+
+	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
+	ASSERTCMP(object->n_in_progress, >, 0);
+	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
+		    object->n_exclusive, >, 0);
+	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
+		    object->n_in_progress, ==, 1);
+
+	spin_lock(&object->lock);
+
+	if (!cancelled) {
+		trace_fscache_op(object->cookie, op, fscache_op_completed);
+		op->state = FSCACHE_OP_ST_COMPLETE;
+	} else {
+		op->cancel(op);
+		trace_fscache_op(object->cookie, op, fscache_op_cancelled);
+		op->state = FSCACHE_OP_ST_CANCELLED;
+	}
+
+	if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
+		object->n_exclusive--;
+	object->n_in_progress--;
+	if (object->n_in_progress == 0)
+		fscache_start_operations(object);
+
+	spin_unlock(&object->lock);
+	_leave("");
+}
+EXPORT_SYMBOL(fscache_op_complete);
+
+/*
+ * release an operation
+ * - queues pending ops if this is the last in-progress op
+ */
+void fscache_put_operation(struct fscache_operation *op)
+{
+	struct fscache_object *object;
+	struct fscache_cache *cache;
+
+	_enter("{OBJ%x OP%x,%d}",
+	       op->object ? op->object->debug_id : 0,
+	       op->debug_id, atomic_read(&op->usage));
+
+	ASSERTCMP(atomic_read(&op->usage), >, 0);
+
+	if (!atomic_dec_and_test(&op->usage))
+		return;
+
+	trace_fscache_op(op->object ? op->object->cookie : NULL, op, fscache_op_put);
+
+	_debug("PUT OP");
+	ASSERTIFCMP(op->state != FSCACHE_OP_ST_INITIALISED &&
+		    op->state != FSCACHE_OP_ST_COMPLETE,
+		    op->state, ==, FSCACHE_OP_ST_CANCELLED);
+
+	fscache_stat(&fscache_n_op_release);
+
+	if (op->release) {
+		op->release(op);
+		op->release = NULL;
+	}
+	op->state = FSCACHE_OP_ST_DEAD;
+
+	object = op->object;
+	if (likely(object)) {
+		if (test_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags))
+			atomic_dec(&object->n_reads);
+		if (test_bit(FSCACHE_OP_UNUSE_COOKIE, &op->flags))
+			fscache_unuse_cookie(object);
+
+		/* now... we may get called with the object spinlock held, so we
+		 * complete the cleanup here only if we can immediately acquire the
+		 * lock, and defer it otherwise */
+		if (!spin_trylock(&object->lock)) {
+			_debug("defer put");
+			fscache_stat(&fscache_n_op_deferred_release);
+
+			cache = object->cache;
+			spin_lock(&cache->op_gc_list_lock);
+			list_add_tail(&op->pend_link, &cache->op_gc_list);
+			spin_unlock(&cache->op_gc_list_lock);
+			schedule_work(&cache->op_gc);
+			_leave(" [defer]");
+			return;
+		}
+
+		ASSERTCMP(object->n_ops, >, 0);
+		object->n_ops--;
+		if (object->n_ops == 0)
+			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
+
+		spin_unlock(&object->lock);
+	}
+
+	kfree(op);
+	_leave(" [done]");
+}
+EXPORT_SYMBOL(fscache_put_operation);
+
+/*
+ * garbage collect operations that have had their release deferred
+ */
+void fscache_operation_gc(struct work_struct *work)
+{
+	struct fscache_operation *op;
+	struct fscache_object *object;
+	struct fscache_cache *cache =
+		container_of(work, struct fscache_cache, op_gc);
+	int count = 0;
+
+	_enter("");
+
+	do {
+		spin_lock(&cache->op_gc_list_lock);
+		if (list_empty(&cache->op_gc_list)) {
+			spin_unlock(&cache->op_gc_list_lock);
+			break;
+		}
+
+		op = list_entry(cache->op_gc_list.next,
+				struct fscache_operation, pend_link);
+		list_del(&op->pend_link);
+		spin_unlock(&cache->op_gc_list_lock);
+
+		object = op->object;
+		trace_fscache_op(object->cookie, op, fscache_op_gc);
+
+		spin_lock(&object->lock);
+
+		_debug("GC DEFERRED REL OBJ%x OP%x",
+		       object->debug_id, op->debug_id);
+		fscache_stat(&fscache_n_op_gc);
+
+		ASSERTCMP(atomic_read(&op->usage), ==, 0);
+		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_DEAD);
+
+		ASSERTCMP(object->n_ops, >, 0);
+		object->n_ops--;
+		if (object->n_ops == 0)
+			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
+
+		spin_unlock(&object->lock);
+		kfree(op);
+
+	} while (count++ < 20);
+
+	if (!list_empty(&cache->op_gc_list))
+		schedule_work(&cache->op_gc);
+
+	_leave("");
+}
+
+/*
+ * execute an operation using fs_op_wq to provide processing context -
+ * the caller holds a ref to this object, so we don't need to hold one
+ */
+void fscache_op_work_func(struct work_struct *work)
+{
+	struct fscache_operation *op =
+		container_of(work, struct fscache_operation, work);
+
+	_enter("{OBJ%x OP%x,%d}",
+	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
+
+	trace_fscache_op(op->object->cookie, op, fscache_op_work);
+
+	ASSERT(op->processor != NULL);
+	op->processor(op);
+	fscache_put_operation(op);
+
+	_leave("");
+}
diff --git a/fs/fscache_old/page.c b/fs/fscache_old/page.c
new file mode 100644
index 000000000000..1d86c8a2a8c4
--- /dev/null
+++ b/fs/fscache_old/page.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache page management and data I/O routines
+ *
+ * Copyright (C) 2004-2008 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL PAGE
+#include <linux/module.h>
+#include <linux/fscache-cache.h>
+#include <linux/buffer_head.h>
+#include <linux/pagevec.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * wait for a deferred lookup to complete
+ */
+int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
+{
+	_enter("");
+
+	if (!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags)) {
+		_leave(" = 0 [imm]");
+		return 0;
+	}
+
+	fscache_stat(&fscache_n_retrievals_wait);
+
+	if (wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
+			TASK_INTERRUPTIBLE) != 0) {
+		fscache_stat(&fscache_n_retrievals_intr);
+		_leave(" = -ERESTARTSYS");
+		return -ERESTARTSYS;
+	}
+
+	ASSERT(!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags));
+
+	smp_rmb();
+	_leave(" = 0 [dly]");
+	return 0;
+}
+
+/*
+ * wait for an object to become active (or dead)
+ */
+int fscache_wait_for_operation_activation(struct fscache_object *object,
+					  struct fscache_operation *op,
+					  atomic_t *stat_op_waits,
+					  atomic_t *stat_object_dead)
+{
+	int ret;
+
+	if (!test_bit(FSCACHE_OP_WAITING, &op->flags))
+		goto check_if_dead;
+
+	_debug(">>> WT");
+	if (stat_op_waits)
+		fscache_stat(stat_op_waits);
+	if (wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
+			TASK_INTERRUPTIBLE) != 0) {
+		trace_fscache_op(object->cookie, op, fscache_op_signal);
+		ret = fscache_cancel_op(op, false);
+		if (ret == 0)
+			return -ERESTARTSYS;
+
+		/* it's been removed from the pending queue by another party,
+		 * so we should get to run shortly */
+		wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
+			    TASK_UNINTERRUPTIBLE);
+	}
+	_debug("<<< GO");
+
+check_if_dead:
+	if (op->state == FSCACHE_OP_ST_CANCELLED) {
+		if (stat_object_dead)
+			fscache_stat(stat_object_dead);
+		_leave(" = -ENOBUFS [cancelled]");
+		return -ENOBUFS;
+	}
+	if (unlikely(fscache_object_is_dying(object) ||
+		     fscache_cache_is_broken(object))) {
+		enum fscache_operation_state state = op->state;
+		trace_fscache_op(object->cookie, op, fscache_op_signal);
+		fscache_cancel_op(op, true);
+		if (stat_object_dead)
+			fscache_stat(stat_object_dead);
+		_leave(" = -ENOBUFS [obj dead %d]", state);
+		return -ENOBUFS;
+	}
+	return 0;
+}
diff --git a/fs/fscache_old/proc.c b/fs/fscache_old/proc.c
new file mode 100644
index 000000000000..061df8f61ffc
--- /dev/null
+++ b/fs/fscache_old/proc.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache statistics viewing interface
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+/*
+ * initialise the /proc/fs/fscache/ directory
+ */
+int __init fscache_proc_init(void)
+{
+	_enter("");
+
+	if (!proc_mkdir("fs/fscache", NULL))
+		goto error_dir;
+
+	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
+			     &fscache_cookies_seq_ops))
+		goto error_cookies;
+
+#ifdef CONFIG_FSCACHE_STATS
+	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
+			fscache_stats_show))
+		goto error_stats;
+#endif
+
+#ifdef CONFIG_FSCACHE_OBJECT_LIST
+	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
+			 &fscache_objlist_proc_ops))
+		goto error_objects;
+#endif
+
+	_leave(" = 0");
+	return 0;
+
+#ifdef CONFIG_FSCACHE_OBJECT_LIST
+error_objects:
+#endif
+#ifdef CONFIG_FSCACHE_STATS
+	remove_proc_entry("fs/fscache/stats", NULL);
+error_stats:
+#endif
+	remove_proc_entry("fs/fscache/cookies", NULL);
+error_cookies:
+	remove_proc_entry("fs/fscache", NULL);
+error_dir:
+	_leave(" = -ENOMEM");
+	return -ENOMEM;
+}
+
+/*
+ * clean up the /proc/fs/fscache/ directory
+ */
+void fscache_proc_cleanup(void)
+{
+#ifdef CONFIG_FSCACHE_OBJECT_LIST
+	remove_proc_entry("fs/fscache/objects", NULL);
+#endif
+#ifdef CONFIG_FSCACHE_STATS
+	remove_proc_entry("fs/fscache/stats", NULL);
+#endif
+	remove_proc_entry("fs/fscache/cookies", NULL);
+	remove_proc_entry("fs/fscache", NULL);
+}
diff --git a/fs/fscache_old/stats.c b/fs/fscache_old/stats.c
new file mode 100644
index 000000000000..2449aa459140
--- /dev/null
+++ b/fs/fscache_old/stats.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache statistics
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL THREAD
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+/*
+ * operation counters
+ */
+atomic_t fscache_n_op_pend;
+atomic_t fscache_n_op_run;
+atomic_t fscache_n_op_enqueue;
+atomic_t fscache_n_op_deferred_release;
+atomic_t fscache_n_op_initialised;
+atomic_t fscache_n_op_release;
+atomic_t fscache_n_op_gc;
+atomic_t fscache_n_op_cancelled;
+atomic_t fscache_n_op_rejected;
+
+atomic_t fscache_n_attr_changed;
+atomic_t fscache_n_attr_changed_ok;
+atomic_t fscache_n_attr_changed_nobufs;
+atomic_t fscache_n_attr_changed_nomem;
+atomic_t fscache_n_attr_changed_calls;
+
+atomic_t fscache_n_retrievals;
+atomic_t fscache_n_retrievals_ok;
+atomic_t fscache_n_retrievals_wait;
+atomic_t fscache_n_retrievals_nodata;
+atomic_t fscache_n_retrievals_nobufs;
+atomic_t fscache_n_retrievals_intr;
+atomic_t fscache_n_retrievals_nomem;
+atomic_t fscache_n_retrievals_object_dead;
+atomic_t fscache_n_retrieval_ops;
+atomic_t fscache_n_retrieval_op_waits;
+
+atomic_t fscache_n_stores;
+atomic_t fscache_n_stores_ok;
+atomic_t fscache_n_stores_again;
+atomic_t fscache_n_stores_nobufs;
+atomic_t fscache_n_stores_intr;
+atomic_t fscache_n_stores_oom;
+atomic_t fscache_n_store_ops;
+atomic_t fscache_n_stores_object_dead;
+atomic_t fscache_n_store_op_waits;
+
+atomic_t fscache_n_acquires;
+atomic_t fscache_n_acquires_null;
+atomic_t fscache_n_acquires_no_cache;
+atomic_t fscache_n_acquires_ok;
+atomic_t fscache_n_acquires_nobufs;
+atomic_t fscache_n_acquires_oom;
+
+atomic_t fscache_n_invalidates;
+atomic_t fscache_n_invalidates_run;
+
+atomic_t fscache_n_updates;
+atomic_t fscache_n_updates_null;
+atomic_t fscache_n_updates_run;
+
+atomic_t fscache_n_relinquishes;
+atomic_t fscache_n_relinquishes_null;
+atomic_t fscache_n_relinquishes_waitcrt;
+atomic_t fscache_n_relinquishes_retire;
+
+atomic_t fscache_n_cookie_index;
+atomic_t fscache_n_cookie_data;
+atomic_t fscache_n_cookie_special;
+
+atomic_t fscache_n_object_alloc;
+atomic_t fscache_n_object_no_alloc;
+atomic_t fscache_n_object_lookups;
+atomic_t fscache_n_object_lookups_negative;
+atomic_t fscache_n_object_lookups_positive;
+atomic_t fscache_n_object_lookups_timed_out;
+atomic_t fscache_n_object_created;
+atomic_t fscache_n_object_avail;
+atomic_t fscache_n_object_dead;
+
+atomic_t fscache_n_checkaux_none;
+atomic_t fscache_n_checkaux_okay;
+atomic_t fscache_n_checkaux_update;
+atomic_t fscache_n_checkaux_obsolete;
+
+atomic_t fscache_n_cop_alloc_object;
+atomic_t fscache_n_cop_lookup_object;
+atomic_t fscache_n_cop_lookup_complete;
+atomic_t fscache_n_cop_grab_object;
+atomic_t fscache_n_cop_invalidate_object;
+atomic_t fscache_n_cop_update_object;
+atomic_t fscache_n_cop_drop_object;
+atomic_t fscache_n_cop_put_object;
+atomic_t fscache_n_cop_sync_cache;
+atomic_t fscache_n_cop_attr_changed;
+
+atomic_t fscache_n_cache_no_space_reject;
+atomic_t fscache_n_cache_stale_objects;
+atomic_t fscache_n_cache_retired_objects;
+atomic_t fscache_n_cache_culled_objects;
+
+/*
+ * display the general statistics
+ */
+int fscache_stats_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, "FS-Cache statistics\n");
+
+	seq_printf(m, "Cookies: idx=%u dat=%u spc=%u\n",
+		   atomic_read(&fscache_n_cookie_index),
+		   atomic_read(&fscache_n_cookie_data),
+		   atomic_read(&fscache_n_cookie_special));
+
+	seq_printf(m, "Objects: alc=%u nal=%u avl=%u ded=%u\n",
+		   atomic_read(&fscache_n_object_alloc),
+		   atomic_read(&fscache_n_object_no_alloc),
+		   atomic_read(&fscache_n_object_avail),
+		   atomic_read(&fscache_n_object_dead));
+	seq_printf(m, "ChkAux : non=%u ok=%u upd=%u obs=%u\n",
+		   atomic_read(&fscache_n_checkaux_none),
+		   atomic_read(&fscache_n_checkaux_okay),
+		   atomic_read(&fscache_n_checkaux_update),
+		   atomic_read(&fscache_n_checkaux_obsolete));
+
+	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
+		   " oom=%u\n",
+		   atomic_read(&fscache_n_acquires),
+		   atomic_read(&fscache_n_acquires_null),
+		   atomic_read(&fscache_n_acquires_no_cache),
+		   atomic_read(&fscache_n_acquires_ok),
+		   atomic_read(&fscache_n_acquires_nobufs),
+		   atomic_read(&fscache_n_acquires_oom));
+
+	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u tmo=%u\n",
+		   atomic_read(&fscache_n_object_lookups),
+		   atomic_read(&fscache_n_object_lookups_negative),
+		   atomic_read(&fscache_n_object_lookups_positive),
+		   atomic_read(&fscache_n_object_created),
+		   atomic_read(&fscache_n_object_lookups_timed_out));
+
+	seq_printf(m, "Invals : n=%u run=%u\n",
+		   atomic_read(&fscache_n_invalidates),
+		   atomic_read(&fscache_n_invalidates_run));
+
+	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
+		   atomic_read(&fscache_n_updates),
+		   atomic_read(&fscache_n_updates_null),
+		   atomic_read(&fscache_n_updates_run));
+
+	seq_printf(m, "Relinqs: n=%u nul=%u wcr=%u rtr=%u\n",
+		   atomic_read(&fscache_n_relinquishes),
+		   atomic_read(&fscache_n_relinquishes_null),
+		   atomic_read(&fscache_n_relinquishes_waitcrt),
+		   atomic_read(&fscache_n_relinquishes_retire));
+
+	seq_printf(m, "AttrChg: n=%u ok=%u nbf=%u oom=%u run=%u\n",
+		   atomic_read(&fscache_n_attr_changed),
+		   atomic_read(&fscache_n_attr_changed_ok),
+		   atomic_read(&fscache_n_attr_changed_nobufs),
+		   atomic_read(&fscache_n_attr_changed_nomem),
+		   atomic_read(&fscache_n_attr_changed_calls));
+
+	seq_printf(m, "Retrvls: n=%u ok=%u wt=%u nod=%u nbf=%u"
+		   " int=%u oom=%u\n",
+		   atomic_read(&fscache_n_retrievals),
+		   atomic_read(&fscache_n_retrievals_ok),
+		   atomic_read(&fscache_n_retrievals_wait),
+		   atomic_read(&fscache_n_retrievals_nodata),
+		   atomic_read(&fscache_n_retrievals_nobufs),
+		   atomic_read(&fscache_n_retrievals_intr),
+		   atomic_read(&fscache_n_retrievals_nomem));
+	seq_printf(m, "Retrvls: ops=%u owt=%u abt=%u\n",
+		   atomic_read(&fscache_n_retrieval_ops),
+		   atomic_read(&fscache_n_retrieval_op_waits),
+		   atomic_read(&fscache_n_retrievals_object_dead));
+
+	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u int=%u oom=%u\n",
+		   atomic_read(&fscache_n_stores),
+		   atomic_read(&fscache_n_stores_ok),
+		   atomic_read(&fscache_n_stores_again),
+		   atomic_read(&fscache_n_stores_nobufs),
+		   atomic_read(&fscache_n_stores_intr),
+		   atomic_read(&fscache_n_stores_oom));
+	seq_printf(m, "Stores : ops=%u owt=%u abt=%u\n",
+		   atomic_read(&fscache_n_store_ops),
+		   atomic_read(&fscache_n_store_op_waits),
+		   atomic_read(&fscache_n_stores_object_dead));
+
+	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
+		   atomic_read(&fscache_n_op_pend),
+		   atomic_read(&fscache_n_op_run),
+		   atomic_read(&fscache_n_op_enqueue),
+		   atomic_read(&fscache_n_op_cancelled),
+		   atomic_read(&fscache_n_op_rejected));
+	seq_printf(m, "Ops    : ini=%u dfr=%u rel=%u gc=%u\n",
+		   atomic_read(&fscache_n_op_initialised),
+		   atomic_read(&fscache_n_op_deferred_release),
+		   atomic_read(&fscache_n_op_release),
+		   atomic_read(&fscache_n_op_gc));
+
+	seq_printf(m, "CacheOp: alo=%d luo=%d luc=%d gro=%d\n",
+		   atomic_read(&fscache_n_cop_alloc_object),
+		   atomic_read(&fscache_n_cop_lookup_object),
+		   atomic_read(&fscache_n_cop_lookup_complete),
+		   atomic_read(&fscache_n_cop_grab_object));
+	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
+		   atomic_read(&fscache_n_cop_invalidate_object),
+		   atomic_read(&fscache_n_cop_update_object),
+		   atomic_read(&fscache_n_cop_drop_object),
+		   atomic_read(&fscache_n_cop_put_object),
+		   atomic_read(&fscache_n_cop_attr_changed),
+		   atomic_read(&fscache_n_cop_sync_cache));
+	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
+		   atomic_read(&fscache_n_cache_no_space_reject),
+		   atomic_read(&fscache_n_cache_stale_objects),
+		   atomic_read(&fscache_n_cache_retired_objects),
+		   atomic_read(&fscache_n_cache_culled_objects));
+	netfs_stats_show(m);
+	return 0;
+}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 679055720dae..a87c51063aa1 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -12,7 +12,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
 #define FSCACHE_USE_FALLBACK_IO_API
-#include <linux/fscache.h>
+#include <linux/fscache_old.h>
 
 #ifdef CONFIG_NFS_FSCACHE
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
deleted file mode 100644
index 5e610f9a524c..000000000000
--- a/include/linux/fscache-cache.h
+++ /dev/null
@@ -1,434 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* General filesystem caching backing cache interface
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * NOTE!!! See:
- *
- *	Documentation/filesystems/caching/backend-api.rst
- *
- * for a description of the cache backend interface declared here.
- */
-
-#ifndef _LINUX_FSCACHE_CACHE_H
-#define _LINUX_FSCACHE_CACHE_H
-
-#include <linux/fscache.h>
-#include <linux/sched.h>
-#include <linux/workqueue.h>
-
-#define NR_MAXCACHES BITS_PER_LONG
-
-struct fscache_cache;
-struct fscache_cache_ops;
-struct fscache_object;
-struct fscache_operation;
-
-enum fscache_obj_ref_trace {
-	fscache_obj_get_add_to_deps,
-	fscache_obj_get_queue,
-	fscache_obj_put_alloc_fail,
-	fscache_obj_put_attach_fail,
-	fscache_obj_put_drop_obj,
-	fscache_obj_put_enq_dep,
-	fscache_obj_put_queue,
-	fscache_obj_put_work,
-	fscache_obj_ref__nr_traces
-};
-
-/*
- * cache tag definition
- */
-struct fscache_cache_tag {
-	struct list_head	link;
-	struct fscache_cache	*cache;		/* cache referred to by this tag */
-	unsigned long		flags;
-#define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
-	atomic_t		usage;
-	char			name[];	/* tag name */
-};
-
-/*
- * cache definition
- */
-struct fscache_cache {
-	const struct fscache_cache_ops *ops;
-	struct fscache_cache_tag *tag;		/* tag representing this cache */
-	struct kobject		*kobj;		/* system representation of this cache */
-	struct list_head	link;		/* link in list of caches */
-	size_t			max_index_size;	/* maximum size of index data */
-	char			identifier[36];	/* cache label */
-
-	/* node management */
-	struct work_struct	op_gc;		/* operation garbage collector */
-	struct list_head	object_list;	/* list of data/index objects */
-	struct list_head	op_gc_list;	/* list of ops to be deleted */
-	spinlock_t		object_list_lock;
-	spinlock_t		op_gc_list_lock;
-	atomic_t		object_count;	/* no. of live objects in this cache */
-	struct fscache_object	*fsdef;		/* object for the fsdef index */
-	unsigned long		flags;
-#define FSCACHE_IOERROR		0	/* cache stopped on I/O error */
-#define FSCACHE_CACHE_WITHDRAWN	1	/* cache has been withdrawn */
-};
-
-extern wait_queue_head_t fscache_cache_cleared_wq;
-
-/*
- * operation to be applied to a cache object
- * - retrieval initiation operations are done in the context of the process
- *   that issued them, and not in an async thread pool
- */
-typedef void (*fscache_operation_release_t)(struct fscache_operation *op);
-typedef void (*fscache_operation_processor_t)(struct fscache_operation *op);
-typedef void (*fscache_operation_cancel_t)(struct fscache_operation *op);
-
-enum fscache_operation_state {
-	FSCACHE_OP_ST_BLANK,		/* Op is not yet submitted */
-	FSCACHE_OP_ST_INITIALISED,	/* Op is initialised */
-	FSCACHE_OP_ST_PENDING,		/* Op is blocked from running */
-	FSCACHE_OP_ST_IN_PROGRESS,	/* Op is in progress */
-	FSCACHE_OP_ST_COMPLETE,		/* Op is complete */
-	FSCACHE_OP_ST_CANCELLED,	/* Op has been cancelled */
-	FSCACHE_OP_ST_DEAD		/* Op is now dead */
-};
-
-struct fscache_operation {
-	struct work_struct	work;		/* record for async ops */
-	struct list_head	pend_link;	/* link in object->pending_ops */
-	struct fscache_object	*object;	/* object to be operated upon */
-
-	unsigned long		flags;
-#define FSCACHE_OP_TYPE		0x000f	/* operation type */
-#define FSCACHE_OP_ASYNC	0x0001	/* - async op, processor may sleep for disk */
-#define FSCACHE_OP_MYTHREAD	0x0002	/* - processing is done be issuing thread, not pool */
-#define FSCACHE_OP_WAITING	4	/* cleared when op is woken */
-#define FSCACHE_OP_EXCLUSIVE	5	/* exclusive op, other ops must wait */
-#define FSCACHE_OP_DEC_READ_CNT	6	/* decrement object->n_reads on destruction */
-#define FSCACHE_OP_UNUSE_COOKIE	7	/* call fscache_unuse_cookie() on completion */
-#define FSCACHE_OP_KEEP_FLAGS	0x00f0	/* flags to keep when repurposing an op */
-
-	enum fscache_operation_state state;
-	atomic_t		usage;
-	unsigned		debug_id;	/* debugging ID */
-
-	/* operation processor callback
-	 * - can be NULL if FSCACHE_OP_WAITING is going to be used to perform
-	 *   the op in a non-pool thread */
-	fscache_operation_processor_t processor;
-
-	/* Operation cancellation cleanup (optional) */
-	fscache_operation_cancel_t cancel;
-
-	/* operation releaser */
-	fscache_operation_release_t release;
-};
-
-extern atomic_t fscache_op_debug_id;
-extern void fscache_op_work_func(struct work_struct *work);
-
-extern void fscache_enqueue_operation(struct fscache_operation *);
-extern void fscache_op_complete(struct fscache_operation *, bool);
-extern void fscache_put_operation(struct fscache_operation *);
-extern void fscache_operation_init(struct fscache_cookie *,
-				   struct fscache_operation *,
-				   fscache_operation_processor_t,
-				   fscache_operation_cancel_t,
-				   fscache_operation_release_t);
-
-/*
- * cache operations
- */
-struct fscache_cache_ops {
-	/* name of cache provider */
-	const char *name;
-
-	/* allocate an object record for a cookie */
-	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
-					       struct fscache_cookie *cookie);
-
-	/* look up the object for a cookie
-	 * - return -ETIMEDOUT to be requeued
-	 */
-	int (*lookup_object)(struct fscache_object *object);
-
-	/* finished looking up */
-	void (*lookup_complete)(struct fscache_object *object);
-
-	/* increment the usage count on this object (may fail if unmounting) */
-	struct fscache_object *(*grab_object)(struct fscache_object *object,
-					      enum fscache_obj_ref_trace why);
-
-	/* pin an object in the cache */
-	int (*pin_object)(struct fscache_object *object);
-
-	/* unpin an object in the cache */
-	void (*unpin_object)(struct fscache_object *object);
-
-	/* check the consistency between the backing cache and the FS-Cache
-	 * cookie */
-	int (*check_consistency)(struct fscache_operation *op);
-
-	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct fscache_object *object);
-
-	/* Invalidate an object */
-	void (*invalidate_object)(struct fscache_operation *op);
-
-	/* discard the resources pinned by an object and effect retirement if
-	 * necessary */
-	void (*drop_object)(struct fscache_object *object);
-
-	/* dispose of a reference to an object */
-	void (*put_object)(struct fscache_object *object,
-			   enum fscache_obj_ref_trace why);
-
-	/* sync a cache */
-	void (*sync_cache)(struct fscache_cache *cache);
-
-	/* notification that the attributes of a non-index object (such as
-	 * i_size) have changed */
-	int (*attr_changed)(struct fscache_object *object);
-
-	/* reserve space for an object's data and associated metadata */
-	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
-
-	/* Begin an operation for the netfs lib */
-	int (*begin_operation)(struct netfs_cache_resources *cres,
-			       struct fscache_operation *op);
-};
-
-extern struct fscache_cookie fscache_fsdef_index;
-
-/*
- * Event list for fscache_object::{event_mask,events}
- */
-enum {
-	FSCACHE_OBJECT_EV_NEW_CHILD,	/* T if object has a new child */
-	FSCACHE_OBJECT_EV_PARENT_READY,	/* T if object's parent is ready */
-	FSCACHE_OBJECT_EV_UPDATE,	/* T if object should be updated */
-	FSCACHE_OBJECT_EV_INVALIDATE,	/* T if cache requested object invalidation */
-	FSCACHE_OBJECT_EV_CLEARED,	/* T if accessors all gone */
-	FSCACHE_OBJECT_EV_ERROR,	/* T if fatal error occurred during processing */
-	FSCACHE_OBJECT_EV_KILL,		/* T if netfs relinquished or cache withdrew object */
-	NR_FSCACHE_OBJECT_EVENTS
-};
-
-#define FSCACHE_OBJECT_EVENTS_MASK ((1UL << NR_FSCACHE_OBJECT_EVENTS) - 1)
-
-/*
- * States for object state machine.
- */
-struct fscache_transition {
-	unsigned long events;
-	const struct fscache_state *transit_to;
-};
-
-struct fscache_state {
-	char name[24];
-	char short_name[8];
-	const struct fscache_state *(*work)(struct fscache_object *object,
-					    int event);
-	const struct fscache_transition transitions[];
-};
-
-/*
- * on-disk cache file or index handle
- */
-struct fscache_object {
-	const struct fscache_state *state;	/* Object state machine state */
-	const struct fscache_transition *oob_table; /* OOB state transition table */
-	int			debug_id;	/* debugging ID */
-	int			n_children;	/* number of child objects */
-	int			n_ops;		/* number of extant ops on object */
-	int			n_obj_ops;	/* number of object ops outstanding on object */
-	int			n_in_progress;	/* number of ops in progress */
-	int			n_exclusive;	/* number of exclusive ops queued or in progress */
-	atomic_t		n_reads;	/* number of read ops in progress */
-	spinlock_t		lock;		/* state and operations lock */
-
-	unsigned long		lookup_jif;	/* time at which lookup started */
-	unsigned long		oob_event_mask;	/* OOB events this object is interested in */
-	unsigned long		event_mask;	/* events this object is interested in */
-	unsigned long		events;		/* events to be processed by this object
-						 * (order is important - using fls) */
-
-	unsigned long		flags;
-#define FSCACHE_OBJECT_LOCK		0	/* T if object is busy being processed */
-#define FSCACHE_OBJECT_PENDING_WRITE	1	/* T if object has pending write */
-#define FSCACHE_OBJECT_WAITING		2	/* T if object is waiting on its parent */
-#define FSCACHE_OBJECT_IS_LIVE		3	/* T if object is not withdrawn or relinquished */
-#define FSCACHE_OBJECT_IS_LOOKED_UP	4	/* T if object has been looked up */
-#define FSCACHE_OBJECT_IS_AVAILABLE	5	/* T if object has become active */
-#define FSCACHE_OBJECT_RETIRED		6	/* T if object was retired on relinquishment */
-#define FSCACHE_OBJECT_KILLED_BY_CACHE	7	/* T if object was killed by the cache */
-#define FSCACHE_OBJECT_RUN_AFTER_DEAD	8	/* T if object has been dispatched after death */
-
-	struct list_head	cache_link;	/* link in cache->object_list */
-	struct hlist_node	cookie_link;	/* link in cookie->backing_objects */
-	struct fscache_cache	*cache;		/* cache that supplied this object */
-	struct fscache_cookie	*cookie;	/* netfs's file/index object */
-	struct fscache_object	*parent;	/* parent object */
-	struct work_struct	work;		/* attention scheduling record */
-	struct list_head	dependents;	/* FIFO of dependent objects */
-	struct list_head	dep_link;	/* link in parent's dependents list */
-	struct list_head	pending_ops;	/* unstarted operations on this object */
-	pgoff_t			store_limit;	/* current storage limit */
-	loff_t			store_limit_l;	/* current storage limit */
-};
-
-extern void fscache_object_init(struct fscache_object *, struct fscache_cookie *,
-				struct fscache_cache *);
-extern void fscache_object_destroy(struct fscache_object *);
-
-extern void fscache_object_lookup_negative(struct fscache_object *object);
-extern void fscache_obtained_object(struct fscache_object *object);
-
-static inline bool fscache_object_is_live(struct fscache_object *object)
-{
-	return test_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
-}
-
-static inline bool fscache_object_is_dying(struct fscache_object *object)
-{
-	return !fscache_object_is_live(object);
-}
-
-static inline bool fscache_object_is_available(struct fscache_object *object)
-{
-	return test_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
-}
-
-static inline bool fscache_cache_is_broken(struct fscache_object *object)
-{
-	return test_bit(FSCACHE_IOERROR, &object->cache->flags);
-}
-
-static inline bool fscache_object_is_active(struct fscache_object *object)
-{
-	return fscache_object_is_available(object) &&
-		fscache_object_is_live(object) &&
-		!fscache_cache_is_broken(object);
-}
-
-/**
- * fscache_object_destroyed - Note destruction of an object in a cache
- * @cache: The cache from which the object came
- *
- * Note the destruction and deallocation of an object record in a cache.
- */
-static inline void fscache_object_destroyed(struct fscache_cache *cache)
-{
-	if (atomic_dec_and_test(&cache->object_count))
-		wake_up_all(&fscache_cache_cleared_wq);
-}
-
-/**
- * fscache_object_lookup_error - Note an object encountered an error
- * @object: The object on which the error was encountered
- *
- * Note that an object encountered a fatal error (usually an I/O error) and
- * that it should be withdrawn as soon as possible.
- */
-static inline void fscache_object_lookup_error(struct fscache_object *object)
-{
-	set_bit(FSCACHE_OBJECT_EV_ERROR, &object->events);
-}
-
-/**
- * fscache_set_store_limit - Set the maximum size to be stored in an object
- * @object: The object to set the maximum on
- * @i_size: The limit to set in bytes
- *
- * Set the maximum size an object is permitted to reach, implying the highest
- * byte that may be written.  Intended to be called by the attr_changed() op.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-static inline
-void fscache_set_store_limit(struct fscache_object *object, loff_t i_size)
-{
-	object->store_limit_l = i_size;
-	object->store_limit = i_size >> PAGE_SHIFT;
-	if (i_size & ~PAGE_MASK)
-		object->store_limit++;
-}
-
-static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
-{
-	atomic_inc(&cookie->n_active);
-}
-
-/**
- * fscache_use_cookie - Request usage of cookie attached to an object
- * @object: Object description
- * 
- * Request usage of the cookie attached to an object.  NULL is returned if the
- * relinquishment had reduced the cookie usage count to 0.
- */
-static inline bool fscache_use_cookie(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	return atomic_inc_not_zero(&cookie->n_active) != 0;
-}
-
-static inline bool __fscache_unuse_cookie(struct fscache_cookie *cookie)
-{
-	return atomic_dec_and_test(&cookie->n_active);
-}
-
-static inline void __fscache_wake_unused_cookie(struct fscache_cookie *cookie)
-{
-	wake_up_var(&cookie->n_active);
-}
-
-/**
- * fscache_unuse_cookie - Cease usage of cookie attached to an object
- * @object: Object description
- * 
- * Cease usage of the cookie attached to an object.  When the users count
- * reaches zero then the cookie relinquishment will be permitted to proceed.
- */
-static inline void fscache_unuse_cookie(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	if (__fscache_unuse_cookie(cookie))
-		__fscache_wake_unused_cookie(cookie);
-}
-
-/*
- * out-of-line cache backend functions
- */
-extern __printf(3, 4)
-void fscache_init_cache(struct fscache_cache *cache,
-			const struct fscache_cache_ops *ops,
-			const char *idfmt, ...);
-
-extern int fscache_add_cache(struct fscache_cache *cache,
-			     struct fscache_object *fsdef,
-			     const char *tagname);
-extern void fscache_withdraw_cache(struct fscache_cache *cache);
-
-extern void fscache_io_error(struct fscache_cache *cache);
-
-extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
-
-extern enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
-					       const void *data,
-					       uint16_t datalen,
-					       loff_t object_size);
-
-extern void fscache_object_retrying_stale(struct fscache_object *object);
-
-enum fscache_why_object_killed {
-	FSCACHE_OBJECT_IS_STALE,
-	FSCACHE_OBJECT_NO_SPACE,
-	FSCACHE_OBJECT_WAS_RETIRED,
-	FSCACHE_OBJECT_WAS_CULLED,
-};
-extern void fscache_object_mark_killed(struct fscache_object *object,
-				       enum fscache_why_object_killed why);
-
-#endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
deleted file mode 100644
index 01558d155799..000000000000
--- a/include/linux/fscache.h
+++ /dev/null
@@ -1,645 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* General filesystem caching interface
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * NOTE!!! See:
- *
- *	Documentation/filesystems/caching/netfs-api.rst
- *
- * for a description of the network filesystem interface declared here.
- */
-
-#ifndef _LINUX_FSCACHE_H
-#define _LINUX_FSCACHE_H
-
-#include <linux/fs.h>
-#include <linux/list.h>
-#include <linux/pagemap.h>
-#include <linux/pagevec.h>
-#include <linux/list_bl.h>
-#include <linux/netfs.h>
-
-#if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
-#define fscache_available() (1)
-#define fscache_cookie_valid(cookie) (cookie)
-#define fscache_resources_valid(cres) ((cres)->cache_priv)
-#else
-#define fscache_available() (0)
-#define fscache_cookie_valid(cookie) (0)
-#define fscache_resources_valid(cres) (false)
-#endif
-
-struct pagevec;
-struct fscache_cache_tag;
-struct fscache_cookie;
-struct fscache_netfs;
-struct netfs_read_request;
-
-/* result of index entry consultation */
-enum fscache_checkaux {
-	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
-	FSCACHE_CHECKAUX_NEEDS_UPDATE,	/* entry requires update */
-	FSCACHE_CHECKAUX_OBSOLETE,	/* entry requires deletion */
-};
-
-/*
- * fscache cookie definition
- */
-struct fscache_cookie_def {
-	/* name of cookie type */
-	char name[16];
-
-	/* cookie type */
-	uint8_t type;
-#define FSCACHE_COOKIE_TYPE_INDEX	0
-#define FSCACHE_COOKIE_TYPE_DATAFILE	1
-
-	/* select the cache into which to insert an entry in this index
-	 * - optional
-	 * - should return a cache identifier or NULL to cause the cache to be
-	 *   inherited from the parent if possible or the first cache picked
-	 *   for a non-index file if not
-	 */
-	struct fscache_cache_tag *(*select_cache)(
-		const void *parent_netfs_data,
-		const void *cookie_netfs_data);
-
-	/* consult the netfs about the state of an object
-	 * - this function can be absent if the index carries no state data
-	 * - the netfs data from the cookie being used as the target is
-	 *   presented, as is the auxiliary data and the object size
-	 */
-	enum fscache_checkaux (*check_aux)(void *cookie_netfs_data,
-					   const void *data,
-					   uint16_t datalen,
-					   loff_t object_size);
-};
-
-/*
- * fscache cached network filesystem type
- * - name, version and ops must be filled in before registration
- * - all other fields will be set during registration
- */
-struct fscache_netfs {
-	uint32_t			version;	/* indexing version */
-	const char			*name;		/* filesystem name */
-	struct fscache_cookie		*primary_index;
-};
-
-/*
- * data file or index object cookie
- * - a file will only appear in one cache
- * - a request to cache a file may or may not be honoured, subject to
- *   constraints such as disk space
- * - indices are created on disk just-in-time
- */
-struct fscache_cookie {
-	refcount_t			ref;		/* number of users of this cookie */
-	atomic_t			n_children;	/* number of children of this cookie */
-	atomic_t			n_active;	/* number of active users of netfs ptrs */
-	unsigned int			debug_id;
-	spinlock_t			lock;
-	struct hlist_head		backing_objects; /* object(s) backing this file/index */
-	const struct fscache_cookie_def	*def;		/* definition */
-	struct fscache_cookie		*parent;	/* parent of this entry */
-	struct hlist_bl_node		hash_link;	/* Link in hash table */
-	struct list_head		proc_link;	/* Link in proc list */
-	void				*netfs_data;	/* back pointer to netfs */
-
-	unsigned long			flags;
-#define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
-#define FSCACHE_COOKIE_NO_DATA_YET	1	/* T if new object with no cached data yet */
-#define FSCACHE_COOKIE_UNAVAILABLE	2	/* T if cookie is unavailable (error, etc) */
-#define FSCACHE_COOKIE_INVALIDATING	3	/* T if cookie is being invalidated */
-#define FSCACHE_COOKIE_RELINQUISHED	4	/* T if cookie has been relinquished */
-#define FSCACHE_COOKIE_ENABLED		5	/* T if cookie is enabled */
-#define FSCACHE_COOKIE_ENABLEMENT_LOCK	6	/* T if cookie is being en/disabled */
-#define FSCACHE_COOKIE_AUX_UPDATED	8	/* T if the auxiliary data was updated */
-#define FSCACHE_COOKIE_ACQUIRED		9	/* T if cookie is in use */
-#define FSCACHE_COOKIE_RELINQUISHING	10	/* T if cookie is being relinquished */
-
-	u8				type;		/* Type of object */
-	u8				key_len;	/* Length of index key */
-	u8				aux_len;	/* Length of auxiliary data */
-	u32				key_hash;	/* Hash of parent, type, key, len */
-	union {
-		void			*key;		/* Index key */
-		u8			inline_key[16];	/* - If the key is short enough */
-	};
-	union {
-		void			*aux;		/* Auxiliary data */
-		u8			inline_aux[8];	/* - If the aux data is short enough */
-	};
-};
-
-static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
-{
-	return (fscache_cookie_valid(cookie) &&
-		test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags));
-}
-
-/*
- * slow-path functions for when there is actually caching available, and the
- * netfs does actually have a valid token
- * - these are not to be called directly
- * - these are undefined symbols when FS-Cache is not configured and the
- *   optimiser takes care of not using them
- */
-extern int __fscache_register_netfs(struct fscache_netfs *);
-extern void __fscache_unregister_netfs(struct fscache_netfs *);
-extern struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *);
-extern void __fscache_release_cache_tag(struct fscache_cache_tag *);
-
-extern struct fscache_cookie *__fscache_acquire_cookie(
-	struct fscache_cookie *,
-	const struct fscache_cookie_def *,
-	const void *, size_t,
-	const void *, size_t,
-	void *, loff_t, bool);
-extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
-extern int __fscache_check_consistency(struct fscache_cookie *, const void *);
-extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
-extern int __fscache_attr_changed(struct fscache_cookie *);
-extern void __fscache_invalidate(struct fscache_cookie *);
-extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
-#ifdef FSCACHE_USE_NEW_IO_API
-extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
-				     bool);
-#endif
-#ifdef FSCACHE_USE_FALLBACK_IO_API
-extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
-extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
-#endif
-extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
-extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
-				    bool (*)(void *), void *);
-
-/**
- * fscache_register_netfs - Register a filesystem as desiring caching services
- * @netfs: The description of the filesystem
- *
- * Register a filesystem as desiring caching services if they're available.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_register_netfs(struct fscache_netfs *netfs)
-{
-	if (fscache_available())
-		return __fscache_register_netfs(netfs);
-	else
-		return 0;
-}
-
-/**
- * fscache_unregister_netfs - Indicate that a filesystem no longer desires
- * caching services
- * @netfs: The description of the filesystem
- *
- * Indicate that a filesystem no longer desires caching services for the
- * moment.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_unregister_netfs(struct fscache_netfs *netfs)
-{
-	if (fscache_available())
-		__fscache_unregister_netfs(netfs);
-}
-
-/**
- * fscache_lookup_cache_tag - Look up a cache tag
- * @name: The name of the tag to search for
- *
- * Acquire a specific cache referral tag that can be used to select a specific
- * cache in which to cache an index.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name)
-{
-	if (fscache_available())
-		return __fscache_lookup_cache_tag(name);
-	else
-		return NULL;
-}
-
-/**
- * fscache_release_cache_tag - Release a cache tag
- * @tag: The tag to release
- *
- * Release a reference to a cache referral tag previously looked up.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_release_cache_tag(struct fscache_cache_tag *tag)
-{
-	if (fscache_available())
-		__fscache_release_cache_tag(tag);
-}
-
-/**
- * fscache_acquire_cookie - Acquire a cookie to represent a cache object
- * @parent: The cookie that's to be the parent of this one
- * @def: A description of the cache object, including callback operations
- * @index_key: The index key for this cookie
- * @index_key_len: Size of the index key
- * @aux_data: The auxiliary data for the cookie (may be NULL)
- * @aux_data_len: Size of the auxiliary data buffer
- * @netfs_data: An arbitrary piece of data to be kept in the cookie to
- * represent the cache object to the netfs
- * @object_size: The initial size of object
- * @enable: Whether or not to enable a data cookie immediately
- *
- * This function is used to inform FS-Cache about part of an index hierarchy
- * that can be used to locate files.  This is done by requesting a cookie for
- * each index in the path to the file.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-struct fscache_cookie *fscache_acquire_cookie(
-	struct fscache_cookie *parent,
-	const struct fscache_cookie_def *def,
-	const void *index_key,
-	size_t index_key_len,
-	const void *aux_data,
-	size_t aux_data_len,
-	void *netfs_data,
-	loff_t object_size,
-	bool enable)
-{
-	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
-		return __fscache_acquire_cookie(parent, def,
-						index_key, index_key_len,
-						aux_data, aux_data_len,
-						netfs_data, object_size, enable);
-	else
-		return NULL;
-}
-
-/**
- * fscache_relinquish_cookie - Return the cookie to the cache, maybe discarding
- * it
- * @cookie: The cookie being returned
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- * @retire: True if the cache object the cookie represents is to be discarded
- *
- * This function returns a cookie to the cache, forcibly discarding the
- * associated cache object if retire is set to true.  The opportunity is
- * provided to update the auxiliary data in the cache before the object is
- * disconnected.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_relinquish_cookie(struct fscache_cookie *cookie,
-			       const void *aux_data,
-			       bool retire)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_relinquish_cookie(cookie, aux_data, retire);
-}
-
-/**
- * fscache_check_consistency - Request validation of a cache's auxiliary data
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- *
- * Request an consistency check from fscache, which passes the request to the
- * backing cache.  The auxiliary data on the cookie will be updated first if
- * @aux_data is set.
- *
- * Returns 0 if consistent and -ESTALE if inconsistent.  May also
- * return -ENOMEM and -ERESTARTSYS.
- */
-static inline
-int fscache_check_consistency(struct fscache_cookie *cookie,
-			      const void *aux_data)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_check_consistency(cookie, aux_data);
-	else
-		return 0;
-}
-
-/**
- * fscache_update_cookie - Request that a cache object be updated
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- *
- * Request an update of the index data for the cache object associated with the
- * cookie.  The auxiliary data on the cookie will be updated first if @aux_data
- * is set.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_update_cookie(cookie, aux_data);
-}
-
-/**
- * fscache_pin_cookie - Pin a data-storage cache object in its cache
- * @cookie: The cookie representing the cache object
- *
- * Permit data-storage cache objects to be pinned in the cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_pin_cookie(struct fscache_cookie *cookie)
-{
-	return -ENOBUFS;
-}
-
-/**
- * fscache_pin_cookie - Unpin a data-storage cache object in its cache
- * @cookie: The cookie representing the cache object
- *
- * Permit data-storage cache objects to be unpinned from the cache.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_unpin_cookie(struct fscache_cookie *cookie)
-{
-}
-
-/**
- * fscache_attr_changed - Notify cache that an object's attributes changed
- * @cookie: The cookie representing the cache object
- *
- * Send a notification to the cache indicating that an object's attributes have
- * changed.  This includes the data size.  These attributes will be obtained
- * through the get_attr() cookie definition op.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_attr_changed(cookie);
-	else
-		return -ENOBUFS;
-}
-
-/**
- * fscache_invalidate - Notify cache that an object needs invalidation
- * @cookie: The cookie representing the cache object
- *
- * Notify the cache that an object is needs to be invalidated and that it
- * should abort any retrievals or stores it is doing on the cache.  The object
- * is then marked non-caching until such time as the invalidation is complete.
- *
- * This can be called with spinlocks held.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_invalidate(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_invalidate(cookie);
-}
-
-/**
- * fscache_wait_on_invalidate - Wait for invalidation to complete
- * @cookie: The cookie representing the cache object
- *
- * Wait for the invalidation of an object to complete.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_invalidate(cookie);
-}
-
-#ifdef FSCACHE_USE_NEW_IO_API
-
-/**
- * fscache_begin_read_operation - Begin a read operation for the netfs lib
- * @cres: The cache resources for the read being performed
- * @cookie: The cookie representing the cache object
- *
- * Begin a read operation on behalf of the netfs helper library.  @cres
- * indicates the cache resources to which the operation state should be
- * attached; @cookie indicates the cache object that will be accessed.
- *
- * This is intended to be called from the ->begin_cache_operation() netfs lib
- * operation as implemented by the network filesystem.
- *
- * Returns:
- * * 0		- Success
- * * -ENOBUFS	- No caching available
- * * Other error code from the cache, such as -ENOMEM.
- */
-static inline
-int fscache_begin_read_operation(struct netfs_cache_resources *cres,
-				 struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_begin_operation(cres, cookie, false);
-	return -ENOBUFS;
-}
-
-/**
- * fscache_operation_valid - Return true if operations resources are usable
- * @cres: The resources to check.
- *
- * Returns a pointer to the operations table if usable or NULL if not.
- */
-static inline
-const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
-{
-	return fscache_resources_valid(cres) ? cres->ops : NULL;
-}
-
-/**
- * fscache_read - Start a read from the cache.
- * @cres: The cache resources to use
- * @start_pos: The beginning file offset in the cache file
- * @iter: The buffer to fill - and also the length
- * @read_hole: How to handle a hole in the data.
- * @term_func: The function to call upon completion
- * @term_func_priv: The private data for @term_func
- *
- * Start a read from the cache.  @cres indicates the cache object to read from
- * and must be obtained by a call to fscache_begin_operation() beforehand.
- *
- * The data is read into the iterator, @iter, and that also indicates the size
- * of the operation.  @start_pos is the start position in the file, though if
- * @seek_data is set appropriately, the cache can use SEEK_DATA to find the
- * next piece of data, writing zeros for the hole into the iterator.
- *
- * Upon termination of the operation, @term_func will be called and supplied
- * with @term_func_priv plus the amount of data written, if successful, or the
- * error code otherwise.
- */
-static inline
-int fscache_read(struct netfs_cache_resources *cres,
-		 loff_t start_pos,
-		 struct iov_iter *iter,
-		 enum netfs_read_from_hole read_hole,
-		 netfs_io_terminated_t term_func,
-		 void *term_func_priv)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-	return ops->read(cres, start_pos, iter, read_hole,
-			 term_func, term_func_priv);
-}
-
-/**
- * fscache_write - Start a write to the cache.
- * @cres: The cache resources to use
- * @start_pos: The beginning file offset in the cache file
- * @iter: The data to write - and also the length
- * @term_func: The function to call upon completion
- * @term_func_priv: The private data for @term_func
- *
- * Start a write to the cache.  @cres indicates the cache object to write to and
- * must be obtained by a call to fscache_begin_operation() beforehand.
- *
- * The data to be written is obtained from the iterator, @iter, and that also
- * indicates the size of the operation.  @start_pos is the start position in
- * the file.
- *
- * Upon termination of the operation, @term_func will be called and supplied
- * with @term_func_priv plus the amount of data written, if successful, or the
- * error code otherwise.
- */
-static inline
-int fscache_write(struct netfs_cache_resources *cres,
-		  loff_t start_pos,
-		  struct iov_iter *iter,
-		  netfs_io_terminated_t term_func,
-		  void *term_func_priv)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
-}
-
-#endif /* FSCACHE_USE_NEW_IO_API */
-
-/**
- * fscache_disable_cookie - Disable a cookie
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- * @invalidate: Invalidate the backing object
- *
- * Disable a cookie from accepting further alloc, read, write, invalidate,
- * update or acquire operations.  Outstanding operations can still be waited
- * upon and pages can still be uncached and the cookie relinquished.
- *
- * This will not return until all outstanding operations have completed.
- *
- * If @invalidate is set, then the backing object will be invalidated and
- * detached, otherwise it will just be detached.
- *
- * If @aux_data is set, then auxiliary data will be updated from that.
- */
-static inline
-void fscache_disable_cookie(struct fscache_cookie *cookie,
-			    const void *aux_data,
-			    bool invalidate)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_disable_cookie(cookie, aux_data, invalidate);
-}
-
-/**
- * fscache_enable_cookie - Reenable a cookie
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- * @object_size: Current size of object
- * @can_enable: A function to permit enablement once lock is held
- * @data: Data for can_enable()
- *
- * Reenable a previously disabled cookie, allowing it to accept further alloc,
- * read, write, invalidate, update or acquire operations.  An attempt will be
- * made to immediately reattach the cookie to a backing object.  If @aux_data
- * is set, the auxiliary data attached to the cookie will be updated.
- *
- * The can_enable() function is called (if not NULL) once the enablement lock
- * is held to rule on whether enablement is still permitted to go ahead.
- */
-static inline
-void fscache_enable_cookie(struct fscache_cookie *cookie,
-			   const void *aux_data,
-			   loff_t object_size,
-			   bool (*can_enable)(void *data),
-			   void *data)
-{
-	if (fscache_cookie_valid(cookie) && !fscache_cookie_enabled(cookie))
-		__fscache_enable_cookie(cookie, aux_data, object_size,
-					can_enable, data);
-}
-
-#ifdef FSCACHE_USE_FALLBACK_IO_API
-
-/**
- * fscache_fallback_read_page - Read a page from a cache object (DANGEROUS)
- * @cookie: The cookie representing the cache object
- * @page: The page to be read to
- *
- * Synchronously read a page from the cache.  The page's offset is used to
- * indicate where to read.
- *
- * This is dangerous and should be moved away from as it relies on the
- * assumption that the backing filesystem will exactly record the blocks we
- * have stored there.
- */
-static inline
-int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
-{
-	if (fscache_cookie_enabled(cookie))
-		return __fscache_fallback_read_page(cookie, page);
-	return -ENOBUFS;
-}
-
-/**
- * fscache_fallback_write_page - Write a page to a cache object (DANGEROUS)
- * @cookie: The cookie representing the cache object
- * @page: The page to be written from
- *
- * Synchronously write a page to the cache.  The page's offset is used to
- * indicate where to write.
- *
- * This is dangerous and should be moved away from as it relies on the
- * assumption that the backing filesystem will exactly record the blocks we
- * have stored there.
- */
-static inline
-int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
-{
-	if (fscache_cookie_enabled(cookie))
-		return __fscache_fallback_write_page(cookie, page);
-	return -ENOBUFS;
-}
-
-#endif /* FSCACHE_USE_FALLBACK_IO_API */
-
-#endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/fscache_old-cache.h b/include/linux/fscache_old-cache.h
new file mode 100644
index 000000000000..39ccd7eff62e
--- /dev/null
+++ b/include/linux/fscache_old-cache.h
@@ -0,0 +1,434 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* General filesystem caching backing cache interface
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * NOTE!!! See:
+ *
+ *	Documentation/filesystems/caching/backend-api.rst
+ *
+ * for a description of the cache backend interface declared here.
+ */
+
+#ifndef _LINUX_FSCACHE_CACHE_H
+#define _LINUX_FSCACHE_CACHE_H
+
+#include <linux/fscache_old.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#define NR_MAXCACHES BITS_PER_LONG
+
+struct fscache_cache;
+struct fscache_cache_ops;
+struct fscache_object;
+struct fscache_operation;
+
+enum fscache_obj_ref_trace {
+	fscache_obj_get_add_to_deps,
+	fscache_obj_get_queue,
+	fscache_obj_put_alloc_fail,
+	fscache_obj_put_attach_fail,
+	fscache_obj_put_drop_obj,
+	fscache_obj_put_enq_dep,
+	fscache_obj_put_queue,
+	fscache_obj_put_work,
+	fscache_obj_ref__nr_traces
+};
+
+/*
+ * cache tag definition
+ */
+struct fscache_cache_tag {
+	struct list_head	link;
+	struct fscache_cache	*cache;		/* cache referred to by this tag */
+	unsigned long		flags;
+#define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
+	atomic_t		usage;
+	char			name[];	/* tag name */
+};
+
+/*
+ * cache definition
+ */
+struct fscache_cache {
+	const struct fscache_cache_ops *ops;
+	struct fscache_cache_tag *tag;		/* tag representing this cache */
+	struct kobject		*kobj;		/* system representation of this cache */
+	struct list_head	link;		/* link in list of caches */
+	size_t			max_index_size;	/* maximum size of index data */
+	char			identifier[36];	/* cache label */
+
+	/* node management */
+	struct work_struct	op_gc;		/* operation garbage collector */
+	struct list_head	object_list;	/* list of data/index objects */
+	struct list_head	op_gc_list;	/* list of ops to be deleted */
+	spinlock_t		object_list_lock;
+	spinlock_t		op_gc_list_lock;
+	atomic_t		object_count;	/* no. of live objects in this cache */
+	struct fscache_object	*fsdef;		/* object for the fsdef index */
+	unsigned long		flags;
+#define FSCACHE_IOERROR		0	/* cache stopped on I/O error */
+#define FSCACHE_CACHE_WITHDRAWN	1	/* cache has been withdrawn */
+};
+
+extern wait_queue_head_t fscache_cache_cleared_wq;
+
+/*
+ * operation to be applied to a cache object
+ * - retrieval initiation operations are done in the context of the process
+ *   that issued them, and not in an async thread pool
+ */
+typedef void (*fscache_operation_release_t)(struct fscache_operation *op);
+typedef void (*fscache_operation_processor_t)(struct fscache_operation *op);
+typedef void (*fscache_operation_cancel_t)(struct fscache_operation *op);
+
+enum fscache_operation_state {
+	FSCACHE_OP_ST_BLANK,		/* Op is not yet submitted */
+	FSCACHE_OP_ST_INITIALISED,	/* Op is initialised */
+	FSCACHE_OP_ST_PENDING,		/* Op is blocked from running */
+	FSCACHE_OP_ST_IN_PROGRESS,	/* Op is in progress */
+	FSCACHE_OP_ST_COMPLETE,		/* Op is complete */
+	FSCACHE_OP_ST_CANCELLED,	/* Op has been cancelled */
+	FSCACHE_OP_ST_DEAD		/* Op is now dead */
+};
+
+struct fscache_operation {
+	struct work_struct	work;		/* record for async ops */
+	struct list_head	pend_link;	/* link in object->pending_ops */
+	struct fscache_object	*object;	/* object to be operated upon */
+
+	unsigned long		flags;
+#define FSCACHE_OP_TYPE		0x000f	/* operation type */
+#define FSCACHE_OP_ASYNC	0x0001	/* - async op, processor may sleep for disk */
+#define FSCACHE_OP_MYTHREAD	0x0002	/* - processing is done be issuing thread, not pool */
+#define FSCACHE_OP_WAITING	4	/* cleared when op is woken */
+#define FSCACHE_OP_EXCLUSIVE	5	/* exclusive op, other ops must wait */
+#define FSCACHE_OP_DEC_READ_CNT	6	/* decrement object->n_reads on destruction */
+#define FSCACHE_OP_UNUSE_COOKIE	7	/* call fscache_unuse_cookie() on completion */
+#define FSCACHE_OP_KEEP_FLAGS	0x00f0	/* flags to keep when repurposing an op */
+
+	enum fscache_operation_state state;
+	atomic_t		usage;
+	unsigned		debug_id;	/* debugging ID */
+
+	/* operation processor callback
+	 * - can be NULL if FSCACHE_OP_WAITING is going to be used to perform
+	 *   the op in a non-pool thread */
+	fscache_operation_processor_t processor;
+
+	/* Operation cancellation cleanup (optional) */
+	fscache_operation_cancel_t cancel;
+
+	/* operation releaser */
+	fscache_operation_release_t release;
+};
+
+extern atomic_t fscache_op_debug_id;
+extern void fscache_op_work_func(struct work_struct *work);
+
+extern void fscache_enqueue_operation(struct fscache_operation *);
+extern void fscache_op_complete(struct fscache_operation *, bool);
+extern void fscache_put_operation(struct fscache_operation *);
+extern void fscache_operation_init(struct fscache_cookie *,
+				   struct fscache_operation *,
+				   fscache_operation_processor_t,
+				   fscache_operation_cancel_t,
+				   fscache_operation_release_t);
+
+/*
+ * cache operations
+ */
+struct fscache_cache_ops {
+	/* name of cache provider */
+	const char *name;
+
+	/* allocate an object record for a cookie */
+	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
+					       struct fscache_cookie *cookie);
+
+	/* look up the object for a cookie
+	 * - return -ETIMEDOUT to be requeued
+	 */
+	int (*lookup_object)(struct fscache_object *object);
+
+	/* finished looking up */
+	void (*lookup_complete)(struct fscache_object *object);
+
+	/* increment the usage count on this object (may fail if unmounting) */
+	struct fscache_object *(*grab_object)(struct fscache_object *object,
+					      enum fscache_obj_ref_trace why);
+
+	/* pin an object in the cache */
+	int (*pin_object)(struct fscache_object *object);
+
+	/* unpin an object in the cache */
+	void (*unpin_object)(struct fscache_object *object);
+
+	/* check the consistency between the backing cache and the FS-Cache
+	 * cookie */
+	int (*check_consistency)(struct fscache_operation *op);
+
+	/* store the updated auxiliary data on an object */
+	void (*update_object)(struct fscache_object *object);
+
+	/* Invalidate an object */
+	void (*invalidate_object)(struct fscache_operation *op);
+
+	/* discard the resources pinned by an object and effect retirement if
+	 * necessary */
+	void (*drop_object)(struct fscache_object *object);
+
+	/* dispose of a reference to an object */
+	void (*put_object)(struct fscache_object *object,
+			   enum fscache_obj_ref_trace why);
+
+	/* sync a cache */
+	void (*sync_cache)(struct fscache_cache *cache);
+
+	/* notification that the attributes of a non-index object (such as
+	 * i_size) have changed */
+	int (*attr_changed)(struct fscache_object *object);
+
+	/* reserve space for an object's data and associated metadata */
+	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+
+	/* Begin an operation for the netfs lib */
+	int (*begin_operation)(struct netfs_cache_resources *cres,
+			       struct fscache_operation *op);
+};
+
+extern struct fscache_cookie fscache_fsdef_index;
+
+/*
+ * Event list for fscache_object::{event_mask,events}
+ */
+enum {
+	FSCACHE_OBJECT_EV_NEW_CHILD,	/* T if object has a new child */
+	FSCACHE_OBJECT_EV_PARENT_READY,	/* T if object's parent is ready */
+	FSCACHE_OBJECT_EV_UPDATE,	/* T if object should be updated */
+	FSCACHE_OBJECT_EV_INVALIDATE,	/* T if cache requested object invalidation */
+	FSCACHE_OBJECT_EV_CLEARED,	/* T if accessors all gone */
+	FSCACHE_OBJECT_EV_ERROR,	/* T if fatal error occurred during processing */
+	FSCACHE_OBJECT_EV_KILL,		/* T if netfs relinquished or cache withdrew object */
+	NR_FSCACHE_OBJECT_EVENTS
+};
+
+#define FSCACHE_OBJECT_EVENTS_MASK ((1UL << NR_FSCACHE_OBJECT_EVENTS) - 1)
+
+/*
+ * States for object state machine.
+ */
+struct fscache_transition {
+	unsigned long events;
+	const struct fscache_state *transit_to;
+};
+
+struct fscache_state {
+	char name[24];
+	char short_name[8];
+	const struct fscache_state *(*work)(struct fscache_object *object,
+					    int event);
+	const struct fscache_transition transitions[];
+};
+
+/*
+ * on-disk cache file or index handle
+ */
+struct fscache_object {
+	const struct fscache_state *state;	/* Object state machine state */
+	const struct fscache_transition *oob_table; /* OOB state transition table */
+	int			debug_id;	/* debugging ID */
+	int			n_children;	/* number of child objects */
+	int			n_ops;		/* number of extant ops on object */
+	int			n_obj_ops;	/* number of object ops outstanding on object */
+	int			n_in_progress;	/* number of ops in progress */
+	int			n_exclusive;	/* number of exclusive ops queued or in progress */
+	atomic_t		n_reads;	/* number of read ops in progress */
+	spinlock_t		lock;		/* state and operations lock */
+
+	unsigned long		lookup_jif;	/* time at which lookup started */
+	unsigned long		oob_event_mask;	/* OOB events this object is interested in */
+	unsigned long		event_mask;	/* events this object is interested in */
+	unsigned long		events;		/* events to be processed by this object
+						 * (order is important - using fls) */
+
+	unsigned long		flags;
+#define FSCACHE_OBJECT_LOCK		0	/* T if object is busy being processed */
+#define FSCACHE_OBJECT_PENDING_WRITE	1	/* T if object has pending write */
+#define FSCACHE_OBJECT_WAITING		2	/* T if object is waiting on its parent */
+#define FSCACHE_OBJECT_IS_LIVE		3	/* T if object is not withdrawn or relinquished */
+#define FSCACHE_OBJECT_IS_LOOKED_UP	4	/* T if object has been looked up */
+#define FSCACHE_OBJECT_IS_AVAILABLE	5	/* T if object has become active */
+#define FSCACHE_OBJECT_RETIRED		6	/* T if object was retired on relinquishment */
+#define FSCACHE_OBJECT_KILLED_BY_CACHE	7	/* T if object was killed by the cache */
+#define FSCACHE_OBJECT_RUN_AFTER_DEAD	8	/* T if object has been dispatched after death */
+
+	struct list_head	cache_link;	/* link in cache->object_list */
+	struct hlist_node	cookie_link;	/* link in cookie->backing_objects */
+	struct fscache_cache	*cache;		/* cache that supplied this object */
+	struct fscache_cookie	*cookie;	/* netfs's file/index object */
+	struct fscache_object	*parent;	/* parent object */
+	struct work_struct	work;		/* attention scheduling record */
+	struct list_head	dependents;	/* FIFO of dependent objects */
+	struct list_head	dep_link;	/* link in parent's dependents list */
+	struct list_head	pending_ops;	/* unstarted operations on this object */
+	pgoff_t			store_limit;	/* current storage limit */
+	loff_t			store_limit_l;	/* current storage limit */
+};
+
+extern void fscache_object_init(struct fscache_object *, struct fscache_cookie *,
+				struct fscache_cache *);
+extern void fscache_object_destroy(struct fscache_object *);
+
+extern void fscache_object_lookup_negative(struct fscache_object *object);
+extern void fscache_obtained_object(struct fscache_object *object);
+
+static inline bool fscache_object_is_live(struct fscache_object *object)
+{
+	return test_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
+}
+
+static inline bool fscache_object_is_dying(struct fscache_object *object)
+{
+	return !fscache_object_is_live(object);
+}
+
+static inline bool fscache_object_is_available(struct fscache_object *object)
+{
+	return test_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
+}
+
+static inline bool fscache_cache_is_broken(struct fscache_object *object)
+{
+	return test_bit(FSCACHE_IOERROR, &object->cache->flags);
+}
+
+static inline bool fscache_object_is_active(struct fscache_object *object)
+{
+	return fscache_object_is_available(object) &&
+		fscache_object_is_live(object) &&
+		!fscache_cache_is_broken(object);
+}
+
+/**
+ * fscache_object_destroyed - Note destruction of an object in a cache
+ * @cache: The cache from which the object came
+ *
+ * Note the destruction and deallocation of an object record in a cache.
+ */
+static inline void fscache_object_destroyed(struct fscache_cache *cache)
+{
+	if (atomic_dec_and_test(&cache->object_count))
+		wake_up_all(&fscache_cache_cleared_wq);
+}
+
+/**
+ * fscache_object_lookup_error - Note an object encountered an error
+ * @object: The object on which the error was encountered
+ *
+ * Note that an object encountered a fatal error (usually an I/O error) and
+ * that it should be withdrawn as soon as possible.
+ */
+static inline void fscache_object_lookup_error(struct fscache_object *object)
+{
+	set_bit(FSCACHE_OBJECT_EV_ERROR, &object->events);
+}
+
+/**
+ * fscache_set_store_limit - Set the maximum size to be stored in an object
+ * @object: The object to set the maximum on
+ * @i_size: The limit to set in bytes
+ *
+ * Set the maximum size an object is permitted to reach, implying the highest
+ * byte that may be written.  Intended to be called by the attr_changed() op.
+ *
+ * See Documentation/filesystems/caching/backend-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_set_store_limit(struct fscache_object *object, loff_t i_size)
+{
+	object->store_limit_l = i_size;
+	object->store_limit = i_size >> PAGE_SHIFT;
+	if (i_size & ~PAGE_MASK)
+		object->store_limit++;
+}
+
+static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
+{
+	atomic_inc(&cookie->n_active);
+}
+
+/**
+ * fscache_use_cookie - Request usage of cookie attached to an object
+ * @object: Object description
+ * 
+ * Request usage of the cookie attached to an object.  NULL is returned if the
+ * relinquishment had reduced the cookie usage count to 0.
+ */
+static inline bool fscache_use_cookie(struct fscache_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	return atomic_inc_not_zero(&cookie->n_active) != 0;
+}
+
+static inline bool __fscache_unuse_cookie(struct fscache_cookie *cookie)
+{
+	return atomic_dec_and_test(&cookie->n_active);
+}
+
+static inline void __fscache_wake_unused_cookie(struct fscache_cookie *cookie)
+{
+	wake_up_var(&cookie->n_active);
+}
+
+/**
+ * fscache_unuse_cookie - Cease usage of cookie attached to an object
+ * @object: Object description
+ * 
+ * Cease usage of the cookie attached to an object.  When the users count
+ * reaches zero then the cookie relinquishment will be permitted to proceed.
+ */
+static inline void fscache_unuse_cookie(struct fscache_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	if (__fscache_unuse_cookie(cookie))
+		__fscache_wake_unused_cookie(cookie);
+}
+
+/*
+ * out-of-line cache backend functions
+ */
+extern __printf(3, 4)
+void fscache_init_cache(struct fscache_cache *cache,
+			const struct fscache_cache_ops *ops,
+			const char *idfmt, ...);
+
+extern int fscache_add_cache(struct fscache_cache *cache,
+			     struct fscache_object *fsdef,
+			     const char *tagname);
+extern void fscache_withdraw_cache(struct fscache_cache *cache);
+
+extern void fscache_io_error(struct fscache_cache *cache);
+
+extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
+
+extern enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
+					       const void *data,
+					       uint16_t datalen,
+					       loff_t object_size);
+
+extern void fscache_object_retrying_stale(struct fscache_object *object);
+
+enum fscache_why_object_killed {
+	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_NO_SPACE,
+	FSCACHE_OBJECT_WAS_RETIRED,
+	FSCACHE_OBJECT_WAS_CULLED,
+};
+extern void fscache_object_mark_killed(struct fscache_object *object,
+				       enum fscache_why_object_killed why);
+
+#endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache_old.h b/include/linux/fscache_old.h
new file mode 100644
index 000000000000..01558d155799
--- /dev/null
+++ b/include/linux/fscache_old.h
@@ -0,0 +1,645 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* General filesystem caching interface
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * NOTE!!! See:
+ *
+ *	Documentation/filesystems/caching/netfs-api.rst
+ *
+ * for a description of the network filesystem interface declared here.
+ */
+
+#ifndef _LINUX_FSCACHE_H
+#define _LINUX_FSCACHE_H
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/list_bl.h>
+#include <linux/netfs.h>
+
+#if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
+#define fscache_available() (1)
+#define fscache_cookie_valid(cookie) (cookie)
+#define fscache_resources_valid(cres) ((cres)->cache_priv)
+#else
+#define fscache_available() (0)
+#define fscache_cookie_valid(cookie) (0)
+#define fscache_resources_valid(cres) (false)
+#endif
+
+struct pagevec;
+struct fscache_cache_tag;
+struct fscache_cookie;
+struct fscache_netfs;
+struct netfs_read_request;
+
+/* result of index entry consultation */
+enum fscache_checkaux {
+	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
+	FSCACHE_CHECKAUX_NEEDS_UPDATE,	/* entry requires update */
+	FSCACHE_CHECKAUX_OBSOLETE,	/* entry requires deletion */
+};
+
+/*
+ * fscache cookie definition
+ */
+struct fscache_cookie_def {
+	/* name of cookie type */
+	char name[16];
+
+	/* cookie type */
+	uint8_t type;
+#define FSCACHE_COOKIE_TYPE_INDEX	0
+#define FSCACHE_COOKIE_TYPE_DATAFILE	1
+
+	/* select the cache into which to insert an entry in this index
+	 * - optional
+	 * - should return a cache identifier or NULL to cause the cache to be
+	 *   inherited from the parent if possible or the first cache picked
+	 *   for a non-index file if not
+	 */
+	struct fscache_cache_tag *(*select_cache)(
+		const void *parent_netfs_data,
+		const void *cookie_netfs_data);
+
+	/* consult the netfs about the state of an object
+	 * - this function can be absent if the index carries no state data
+	 * - the netfs data from the cookie being used as the target is
+	 *   presented, as is the auxiliary data and the object size
+	 */
+	enum fscache_checkaux (*check_aux)(void *cookie_netfs_data,
+					   const void *data,
+					   uint16_t datalen,
+					   loff_t object_size);
+};
+
+/*
+ * fscache cached network filesystem type
+ * - name, version and ops must be filled in before registration
+ * - all other fields will be set during registration
+ */
+struct fscache_netfs {
+	uint32_t			version;	/* indexing version */
+	const char			*name;		/* filesystem name */
+	struct fscache_cookie		*primary_index;
+};
+
+/*
+ * data file or index object cookie
+ * - a file will only appear in one cache
+ * - a request to cache a file may or may not be honoured, subject to
+ *   constraints such as disk space
+ * - indices are created on disk just-in-time
+ */
+struct fscache_cookie {
+	refcount_t			ref;		/* number of users of this cookie */
+	atomic_t			n_children;	/* number of children of this cookie */
+	atomic_t			n_active;	/* number of active users of netfs ptrs */
+	unsigned int			debug_id;
+	spinlock_t			lock;
+	struct hlist_head		backing_objects; /* object(s) backing this file/index */
+	const struct fscache_cookie_def	*def;		/* definition */
+	struct fscache_cookie		*parent;	/* parent of this entry */
+	struct hlist_bl_node		hash_link;	/* Link in hash table */
+	struct list_head		proc_link;	/* Link in proc list */
+	void				*netfs_data;	/* back pointer to netfs */
+
+	unsigned long			flags;
+#define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
+#define FSCACHE_COOKIE_NO_DATA_YET	1	/* T if new object with no cached data yet */
+#define FSCACHE_COOKIE_UNAVAILABLE	2	/* T if cookie is unavailable (error, etc) */
+#define FSCACHE_COOKIE_INVALIDATING	3	/* T if cookie is being invalidated */
+#define FSCACHE_COOKIE_RELINQUISHED	4	/* T if cookie has been relinquished */
+#define FSCACHE_COOKIE_ENABLED		5	/* T if cookie is enabled */
+#define FSCACHE_COOKIE_ENABLEMENT_LOCK	6	/* T if cookie is being en/disabled */
+#define FSCACHE_COOKIE_AUX_UPDATED	8	/* T if the auxiliary data was updated */
+#define FSCACHE_COOKIE_ACQUIRED		9	/* T if cookie is in use */
+#define FSCACHE_COOKIE_RELINQUISHING	10	/* T if cookie is being relinquished */
+
+	u8				type;		/* Type of object */
+	u8				key_len;	/* Length of index key */
+	u8				aux_len;	/* Length of auxiliary data */
+	u32				key_hash;	/* Hash of parent, type, key, len */
+	union {
+		void			*key;		/* Index key */
+		u8			inline_key[16];	/* - If the key is short enough */
+	};
+	union {
+		void			*aux;		/* Auxiliary data */
+		u8			inline_aux[8];	/* - If the aux data is short enough */
+	};
+};
+
+static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
+{
+	return (fscache_cookie_valid(cookie) &&
+		test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags));
+}
+
+/*
+ * slow-path functions for when there is actually caching available, and the
+ * netfs does actually have a valid token
+ * - these are not to be called directly
+ * - these are undefined symbols when FS-Cache is not configured and the
+ *   optimiser takes care of not using them
+ */
+extern int __fscache_register_netfs(struct fscache_netfs *);
+extern void __fscache_unregister_netfs(struct fscache_netfs *);
+extern struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *);
+extern void __fscache_release_cache_tag(struct fscache_cache_tag *);
+
+extern struct fscache_cookie *__fscache_acquire_cookie(
+	struct fscache_cookie *,
+	const struct fscache_cookie_def *,
+	const void *, size_t,
+	const void *, size_t,
+	void *, loff_t, bool);
+extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
+extern int __fscache_check_consistency(struct fscache_cookie *, const void *);
+extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
+extern int __fscache_attr_changed(struct fscache_cookie *);
+extern void __fscache_invalidate(struct fscache_cookie *);
+extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
+#ifdef FSCACHE_USE_NEW_IO_API
+extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
+				     bool);
+#endif
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
+extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
+#endif
+extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
+extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
+				    bool (*)(void *), void *);
+
+/**
+ * fscache_register_netfs - Register a filesystem as desiring caching services
+ * @netfs: The description of the filesystem
+ *
+ * Register a filesystem as desiring caching services if they're available.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+int fscache_register_netfs(struct fscache_netfs *netfs)
+{
+	if (fscache_available())
+		return __fscache_register_netfs(netfs);
+	else
+		return 0;
+}
+
+/**
+ * fscache_unregister_netfs - Indicate that a filesystem no longer desires
+ * caching services
+ * @netfs: The description of the filesystem
+ *
+ * Indicate that a filesystem no longer desires caching services for the
+ * moment.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_unregister_netfs(struct fscache_netfs *netfs)
+{
+	if (fscache_available())
+		__fscache_unregister_netfs(netfs);
+}
+
+/**
+ * fscache_lookup_cache_tag - Look up a cache tag
+ * @name: The name of the tag to search for
+ *
+ * Acquire a specific cache referral tag that can be used to select a specific
+ * cache in which to cache an index.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name)
+{
+	if (fscache_available())
+		return __fscache_lookup_cache_tag(name);
+	else
+		return NULL;
+}
+
+/**
+ * fscache_release_cache_tag - Release a cache tag
+ * @tag: The tag to release
+ *
+ * Release a reference to a cache referral tag previously looked up.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_release_cache_tag(struct fscache_cache_tag *tag)
+{
+	if (fscache_available())
+		__fscache_release_cache_tag(tag);
+}
+
+/**
+ * fscache_acquire_cookie - Acquire a cookie to represent a cache object
+ * @parent: The cookie that's to be the parent of this one
+ * @def: A description of the cache object, including callback operations
+ * @index_key: The index key for this cookie
+ * @index_key_len: Size of the index key
+ * @aux_data: The auxiliary data for the cookie (may be NULL)
+ * @aux_data_len: Size of the auxiliary data buffer
+ * @netfs_data: An arbitrary piece of data to be kept in the cookie to
+ * represent the cache object to the netfs
+ * @object_size: The initial size of object
+ * @enable: Whether or not to enable a data cookie immediately
+ *
+ * This function is used to inform FS-Cache about part of an index hierarchy
+ * that can be used to locate files.  This is done by requesting a cookie for
+ * each index in the path to the file.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+struct fscache_cookie *fscache_acquire_cookie(
+	struct fscache_cookie *parent,
+	const struct fscache_cookie_def *def,
+	const void *index_key,
+	size_t index_key_len,
+	const void *aux_data,
+	size_t aux_data_len,
+	void *netfs_data,
+	loff_t object_size,
+	bool enable)
+{
+	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
+		return __fscache_acquire_cookie(parent, def,
+						index_key, index_key_len,
+						aux_data, aux_data_len,
+						netfs_data, object_size, enable);
+	else
+		return NULL;
+}
+
+/**
+ * fscache_relinquish_cookie - Return the cookie to the cache, maybe discarding
+ * it
+ * @cookie: The cookie being returned
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @retire: True if the cache object the cookie represents is to be discarded
+ *
+ * This function returns a cookie to the cache, forcibly discarding the
+ * associated cache object if retire is set to true.  The opportunity is
+ * provided to update the auxiliary data in the cache before the object is
+ * disconnected.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_relinquish_cookie(struct fscache_cookie *cookie,
+			       const void *aux_data,
+			       bool retire)
+{
+	if (fscache_cookie_valid(cookie))
+		__fscache_relinquish_cookie(cookie, aux_data, retire);
+}
+
+/**
+ * fscache_check_consistency - Request validation of a cache's auxiliary data
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ *
+ * Request an consistency check from fscache, which passes the request to the
+ * backing cache.  The auxiliary data on the cookie will be updated first if
+ * @aux_data is set.
+ *
+ * Returns 0 if consistent and -ESTALE if inconsistent.  May also
+ * return -ENOMEM and -ERESTARTSYS.
+ */
+static inline
+int fscache_check_consistency(struct fscache_cookie *cookie,
+			      const void *aux_data)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_check_consistency(cookie, aux_data);
+	else
+		return 0;
+}
+
+/**
+ * fscache_update_cookie - Request that a cache object be updated
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ *
+ * Request an update of the index data for the cache object associated with the
+ * cookie.  The auxiliary data on the cookie will be updated first if @aux_data
+ * is set.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		__fscache_update_cookie(cookie, aux_data);
+}
+
+/**
+ * fscache_pin_cookie - Pin a data-storage cache object in its cache
+ * @cookie: The cookie representing the cache object
+ *
+ * Permit data-storage cache objects to be pinned in the cache.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+int fscache_pin_cookie(struct fscache_cookie *cookie)
+{
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_pin_cookie - Unpin a data-storage cache object in its cache
+ * @cookie: The cookie representing the cache object
+ *
+ * Permit data-storage cache objects to be unpinned from the cache.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_unpin_cookie(struct fscache_cookie *cookie)
+{
+}
+
+/**
+ * fscache_attr_changed - Notify cache that an object's attributes changed
+ * @cookie: The cookie representing the cache object
+ *
+ * Send a notification to the cache indicating that an object's attributes have
+ * changed.  This includes the data size.  These attributes will be obtained
+ * through the get_attr() cookie definition op.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+int fscache_attr_changed(struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_attr_changed(cookie);
+	else
+		return -ENOBUFS;
+}
+
+/**
+ * fscache_invalidate - Notify cache that an object needs invalidation
+ * @cookie: The cookie representing the cache object
+ *
+ * Notify the cache that an object is needs to be invalidated and that it
+ * should abort any retrievals or stores it is doing on the cache.  The object
+ * is then marked non-caching until such time as the invalidation is complete.
+ *
+ * This can be called with spinlocks held.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_invalidate(struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		__fscache_invalidate(cookie);
+}
+
+/**
+ * fscache_wait_on_invalidate - Wait for invalidation to complete
+ * @cookie: The cookie representing the cache object
+ *
+ * Wait for the invalidation of an object to complete.
+ *
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
+ * description.
+ */
+static inline
+void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie))
+		__fscache_wait_on_invalidate(cookie);
+}
+
+#ifdef FSCACHE_USE_NEW_IO_API
+
+/**
+ * fscache_begin_read_operation - Begin a read operation for the netfs lib
+ * @cres: The cache resources for the read being performed
+ * @cookie: The cookie representing the cache object
+ *
+ * Begin a read operation on behalf of the netfs helper library.  @cres
+ * indicates the cache resources to which the operation state should be
+ * attached; @cookie indicates the cache object that will be accessed.
+ *
+ * This is intended to be called from the ->begin_cache_operation() netfs lib
+ * operation as implemented by the network filesystem.
+ *
+ * Returns:
+ * * 0		- Success
+ * * -ENOBUFS	- No caching available
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_begin_read_operation(struct netfs_cache_resources *cres,
+				 struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_begin_operation(cres, cookie, false);
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_operation_valid - Return true if operations resources are usable
+ * @cres: The resources to check.
+ *
+ * Returns a pointer to the operations table if usable or NULL if not.
+ */
+static inline
+const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
+{
+	return fscache_resources_valid(cres) ? cres->ops : NULL;
+}
+
+/**
+ * fscache_read - Start a read from the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The buffer to fill - and also the length
+ * @read_hole: How to handle a hole in the data.
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a read from the cache.  @cres indicates the cache object to read from
+ * and must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data is read into the iterator, @iter, and that also indicates the size
+ * of the operation.  @start_pos is the start position in the file, though if
+ * @seek_data is set appropriately, the cache can use SEEK_DATA to find the
+ * next piece of data, writing zeros for the hole into the iterator.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_read(struct netfs_cache_resources *cres,
+		 loff_t start_pos,
+		 struct iov_iter *iter,
+		 enum netfs_read_from_hole read_hole,
+		 netfs_io_terminated_t term_func,
+		 void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->read(cres, start_pos, iter, read_hole,
+			 term_func, term_func_priv);
+}
+
+/**
+ * fscache_write - Start a write to the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The data to write - and also the length
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a write to the cache.  @cres indicates the cache object to write to and
+ * must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data to be written is obtained from the iterator, @iter, and that also
+ * indicates the size of the operation.  @start_pos is the start position in
+ * the file.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_write(struct netfs_cache_resources *cres,
+		  loff_t start_pos,
+		  struct iov_iter *iter,
+		  netfs_io_terminated_t term_func,
+		  void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
+}
+
+#endif /* FSCACHE_USE_NEW_IO_API */
+
+/**
+ * fscache_disable_cookie - Disable a cookie
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @invalidate: Invalidate the backing object
+ *
+ * Disable a cookie from accepting further alloc, read, write, invalidate,
+ * update or acquire operations.  Outstanding operations can still be waited
+ * upon and pages can still be uncached and the cookie relinquished.
+ *
+ * This will not return until all outstanding operations have completed.
+ *
+ * If @invalidate is set, then the backing object will be invalidated and
+ * detached, otherwise it will just be detached.
+ *
+ * If @aux_data is set, then auxiliary data will be updated from that.
+ */
+static inline
+void fscache_disable_cookie(struct fscache_cookie *cookie,
+			    const void *aux_data,
+			    bool invalidate)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		__fscache_disable_cookie(cookie, aux_data, invalidate);
+}
+
+/**
+ * fscache_enable_cookie - Reenable a cookie
+ * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @object_size: Current size of object
+ * @can_enable: A function to permit enablement once lock is held
+ * @data: Data for can_enable()
+ *
+ * Reenable a previously disabled cookie, allowing it to accept further alloc,
+ * read, write, invalidate, update or acquire operations.  An attempt will be
+ * made to immediately reattach the cookie to a backing object.  If @aux_data
+ * is set, the auxiliary data attached to the cookie will be updated.
+ *
+ * The can_enable() function is called (if not NULL) once the enablement lock
+ * is held to rule on whether enablement is still permitted to go ahead.
+ */
+static inline
+void fscache_enable_cookie(struct fscache_cookie *cookie,
+			   const void *aux_data,
+			   loff_t object_size,
+			   bool (*can_enable)(void *data),
+			   void *data)
+{
+	if (fscache_cookie_valid(cookie) && !fscache_cookie_enabled(cookie))
+		__fscache_enable_cookie(cookie, aux_data, object_size,
+					can_enable, data);
+}
+
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+
+/**
+ * fscache_fallback_read_page - Read a page from a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be read to
+ *
+ * Synchronously read a page from the cache.  The page's offset is used to
+ * indicate where to read.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_read_page(cookie, page);
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_fallback_write_page - Write a page to a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be written from
+ *
+ * Synchronously write a page to the cache.  The page's offset is used to
+ * indicate where to write.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_write_page(cookie, page);
+	return -ENOBUFS;
+}
+
+#endif /* FSCACHE_USE_FALLBACK_IO_API */
+
+#endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
deleted file mode 100644
index 446392f5ba83..000000000000
--- a/include/trace/events/fscache.h
+++ /dev/null
@@ -1,523 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* FS-Cache tracepoints
- *
- * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM fscache
-
-#if !defined(_TRACE_FSCACHE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_FSCACHE_H
-
-#include <linux/fscache.h>
-#include <linux/tracepoint.h>
-
-/*
- * Define enums for tracing information.
- */
-#ifndef __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
-#define __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
-
-enum fscache_cookie_trace {
-	fscache_cookie_collision,
-	fscache_cookie_discard,
-	fscache_cookie_get_acquire_parent,
-	fscache_cookie_get_attach_object,
-	fscache_cookie_get_reacquire,
-	fscache_cookie_get_register_netfs,
-	fscache_cookie_put_acquire_nobufs,
-	fscache_cookie_put_dup_netfs,
-	fscache_cookie_put_relinquish,
-	fscache_cookie_put_object,
-	fscache_cookie_put_parent,
-};
-
-enum fscache_page_trace {
-	fscache_page_cached,
-	fscache_page_inval,
-	fscache_page_maybe_release,
-	fscache_page_radix_clear_store,
-	fscache_page_radix_delete,
-	fscache_page_radix_insert,
-	fscache_page_radix_pend2store,
-	fscache_page_radix_set_pend,
-	fscache_page_uncache,
-	fscache_page_write,
-	fscache_page_write_end,
-	fscache_page_write_end_pend,
-	fscache_page_write_end_noc,
-	fscache_page_write_wait,
-	fscache_page_trace__nr
-};
-
-enum fscache_op_trace {
-	fscache_op_cancel,
-	fscache_op_cancel_all,
-	fscache_op_cancelled,
-	fscache_op_completed,
-	fscache_op_enqueue_async,
-	fscache_op_enqueue_mythread,
-	fscache_op_gc,
-	fscache_op_init,
-	fscache_op_put,
-	fscache_op_run,
-	fscache_op_signal,
-	fscache_op_submit,
-	fscache_op_submit_ex,
-	fscache_op_work,
-	fscache_op_trace__nr
-};
-
-enum fscache_page_op_trace {
-	fscache_page_op_alloc_one,
-	fscache_page_op_attr_changed,
-	fscache_page_op_check_consistency,
-	fscache_page_op_invalidate,
-	fscache_page_op_retr_multi,
-	fscache_page_op_retr_one,
-	fscache_page_op_write_one,
-	fscache_page_op_trace__nr
-};
-
-#endif
-
-/*
- * Declare tracing information enums and their string mappings for display.
- */
-#define fscache_cookie_traces						\
-	EM(fscache_cookie_collision,		"*COLLISION*")		\
-	EM(fscache_cookie_discard,		"DISCARD")		\
-	EM(fscache_cookie_get_acquire_parent,	"GET prn")		\
-	EM(fscache_cookie_get_attach_object,	"GET obj")		\
-	EM(fscache_cookie_get_reacquire,	"GET raq")		\
-	EM(fscache_cookie_get_register_netfs,	"GET net")		\
-	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
-	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
-	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
-	EM(fscache_cookie_put_object,		"PUT obj")		\
-	E_(fscache_cookie_put_parent,		"PUT prn")
-
-#define fscache_page_traces						\
-	EM(fscache_page_cached,			"Cached ")		\
-	EM(fscache_page_inval,			"InvalPg")		\
-	EM(fscache_page_maybe_release,		"MayRels")		\
-	EM(fscache_page_uncache,		"Uncache")		\
-	EM(fscache_page_radix_clear_store,	"RxCStr ")		\
-	EM(fscache_page_radix_delete,		"RxDel  ")		\
-	EM(fscache_page_radix_insert,		"RxIns  ")		\
-	EM(fscache_page_radix_pend2store,	"RxP2S  ")		\
-	EM(fscache_page_radix_set_pend,		"RxSPend ")		\
-	EM(fscache_page_write,			"WritePg")		\
-	EM(fscache_page_write_end,		"EndPgWr")		\
-	EM(fscache_page_write_end_pend,		"EndPgWP")		\
-	EM(fscache_page_write_end_noc,		"EndPgNC")		\
-	E_(fscache_page_write_wait,		"WtOnWrt")
-
-#define fscache_op_traces						\
-	EM(fscache_op_cancel,			"Cancel1")		\
-	EM(fscache_op_cancel_all,		"CancelA")		\
-	EM(fscache_op_cancelled,		"Canclld")		\
-	EM(fscache_op_completed,		"Complet")		\
-	EM(fscache_op_enqueue_async,		"EnqAsyn")		\
-	EM(fscache_op_enqueue_mythread,		"EnqMyTh")		\
-	EM(fscache_op_gc,			"GC     ")		\
-	EM(fscache_op_init,			"Init   ")		\
-	EM(fscache_op_put,			"Put    ")		\
-	EM(fscache_op_run,			"Run    ")		\
-	EM(fscache_op_signal,			"Signal ")		\
-	EM(fscache_op_submit,			"Submit ")		\
-	EM(fscache_op_submit_ex,		"SubmitX")		\
-	E_(fscache_op_work,			"Work   ")
-
-#define fscache_page_op_traces						\
-	EM(fscache_page_op_alloc_one,		"Alloc1 ")		\
-	EM(fscache_page_op_attr_changed,	"AttrChg")		\
-	EM(fscache_page_op_check_consistency,	"CheckCn")		\
-	EM(fscache_page_op_invalidate,		"Inval  ")		\
-	EM(fscache_page_op_retr_multi,		"RetrMul")		\
-	EM(fscache_page_op_retr_one,		"Retr1  ")		\
-	E_(fscache_page_op_write_one,		"Write1 ")
-
-/*
- * Export enum symbols via userspace.
- */
-#undef EM
-#undef E_
-#define EM(a, b) TRACE_DEFINE_ENUM(a);
-#define E_(a, b) TRACE_DEFINE_ENUM(a);
-
-fscache_cookie_traces;
-
-/*
- * Now redefine the EM() and E_() macros to map the enums to the strings that
- * will be printed in the output.
- */
-#undef EM
-#undef E_
-#define EM(a, b)	{ a, b },
-#define E_(a, b)	{ a, b }
-
-
-TRACE_EVENT(fscache_cookie,
-	    TP_PROTO(unsigned int cookie_debug_id,
-		     int ref,
-		     enum fscache_cookie_trace where),
-
-	    TP_ARGS(cookie_debug_id, ref, where),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(enum fscache_cookie_trace,	where		)
-		    __field(int,			ref		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie_debug_id;
-		    __entry->where	= where;
-		    __entry->ref	= ref;
-			   ),
-
-	    TP_printk("%s c=%08x r=%d",
-		      __print_symbolic(__entry->where, fscache_cookie_traces),
-		      __entry->cookie, __entry->ref)
-	    );
-
-TRACE_EVENT(fscache_netfs,
-	    TP_PROTO(struct fscache_netfs *netfs),
-
-	    TP_ARGS(netfs),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __array(char,			name, 8		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= netfs->primary_index->debug_id;
-		    strncpy(__entry->name, netfs->name, 8);
-		    __entry->name[7]		= 0;
-			   ),
-
-	    TP_printk("c=%08x n=%s",
-		      __entry->cookie, __entry->name)
-	    );
-
-TRACE_EVENT(fscache_acquire,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		parent		)
-		    __array(char,			name, 8		)
-		    __field(int,			p_ref		)
-		    __field(int,			p_n_children	)
-		    __field(u8,				p_flags		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->parent		= cookie->parent->debug_id;
-		    __entry->p_ref		= refcount_read(&cookie->parent->ref);
-		    __entry->p_n_children	= atomic_read(&cookie->parent->n_children);
-		    __entry->p_flags		= cookie->parent->flags;
-		    memcpy(__entry->name, cookie->def->name, 8);
-		    __entry->name[7]		= 0;
-			   ),
-
-	    TP_printk("c=%08x p=%08x pr=%d pc=%d pf=%02x n=%s",
-		      __entry->cookie, __entry->parent, __entry->p_ref,
-		      __entry->p_n_children, __entry->p_flags, __entry->name)
-	    );
-
-TRACE_EVENT(fscache_relinquish,
-	    TP_PROTO(struct fscache_cookie *cookie, bool retire),
-
-	    TP_ARGS(cookie, retire),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		parent		)
-		    __field(int,			ref		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-		    __field(bool,			retire		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->parent	= cookie->parent->debug_id;
-		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-		    __entry->retire	= retire;
-			   ),
-
-	    TP_printk("c=%08x r=%d p=%08x Nc=%d Na=%d f=%02x r=%u",
-		      __entry->cookie, __entry->ref,
-		      __entry->parent, __entry->n_children, __entry->n_active,
-		      __entry->flags, __entry->retire)
-	    );
-
-TRACE_EVENT(fscache_enable,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(int,			ref		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-			   ),
-
-	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->ref,
-		      __entry->n_children, __entry->n_active, __entry->flags)
-	    );
-
-TRACE_EVENT(fscache_disable,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(int,			ref		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-			   ),
-
-	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->ref,
-		      __entry->n_children, __entry->n_active, __entry->flags)
-	    );
-
-TRACE_EVENT(fscache_osm,
-	    TP_PROTO(struct fscache_object *object,
-		     const struct fscache_state *state,
-		     bool wait, bool oob, s8 event_num),
-
-	    TP_ARGS(object, state, wait, oob, event_num),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		object		)
-		    __array(char,			state, 8	)
-		    __field(bool,			wait		)
-		    __field(bool,			oob		)
-		    __field(s8,				event_num	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= object->cookie->debug_id;
-		    __entry->object		= object->debug_id;
-		    __entry->wait		= wait;
-		    __entry->oob		= oob;
-		    __entry->event_num		= event_num;
-		    memcpy(__entry->state, state->short_name, 8);
-			   ),
-
-	    TP_printk("c=%08x o=%08d %s %s%sev=%d",
-		      __entry->cookie,
-		      __entry->object,
-		      __entry->state,
-		      __print_symbolic(__entry->wait,
-				       { true,  "WAIT" },
-				       { false, "WORK" }),
-		      __print_symbolic(__entry->oob,
-				       { true,  " OOB " },
-				       { false, " " }),
-		      __entry->event_num)
-	    );
-
-TRACE_EVENT(fscache_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     enum fscache_page_trace why),
-
-	    TP_ARGS(cookie, page, why),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(pgoff_t,			page		)
-		    __field(enum fscache_page_trace,	why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page->index;
-		    __entry->why		= why;
-			   ),
-
-	    TP_printk("c=%08x %s pg=%lx",
-		      __entry->cookie,
-		      __print_symbolic(__entry->why, fscache_page_traces),
-		      __entry->page)
-	    );
-
-TRACE_EVENT(fscache_check_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     void *val, int n),
-
-	    TP_ARGS(cookie, page, val, n),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(void *,			page		)
-		    __field(void *,			val		)
-		    __field(int,			n		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page;
-		    __entry->val		= val;
-		    __entry->n			= n;
-			   ),
-
-	    TP_printk("c=%08x pg=%p val=%p n=%d",
-		      __entry->cookie, __entry->page, __entry->val, __entry->n)
-	    );
-
-TRACE_EVENT(fscache_wake_cookie,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-			   ),
-
-	    TP_printk("c=%08x", __entry->cookie)
-	    );
-
-TRACE_EVENT(fscache_op,
-	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
-		     enum fscache_op_trace why),
-
-	    TP_ARGS(cookie, op, why),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(enum fscache_op_trace,	why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie ? cookie->debug_id : 0;
-		    __entry->op			= op->debug_id;
-		    __entry->why		= why;
-			   ),
-
-	    TP_printk("c=%08x op=%08x %s",
-		      __entry->cookie, __entry->op,
-		      __print_symbolic(__entry->why, fscache_op_traces))
-	    );
-
-TRACE_EVENT(fscache_page_op,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     struct fscache_operation *op, enum fscache_page_op_trace what),
-
-	    TP_ARGS(cookie, page, op, what),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			page		)
-		    __field(enum fscache_page_op_trace,	what		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page ? page->index : 0;
-		    __entry->op			= op->debug_id;
-		    __entry->what		= what;
-			   ),
-
-	    TP_printk("c=%08x %s pg=%lx op=%08x",
-		      __entry->cookie,
-		      __print_symbolic(__entry->what, fscache_page_op_traces),
-		      __entry->page, __entry->op)
-	    );
-
-TRACE_EVENT(fscache_wrote_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     struct fscache_operation *op, int ret),
-
-	    TP_ARGS(cookie, page, op, ret),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			page		)
-		    __field(int,			ret		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page->index;
-		    __entry->op			= op->debug_id;
-		    __entry->ret		= ret;
-			   ),
-
-	    TP_printk("c=%08x pg=%lx op=%08x ret=%d",
-		      __entry->cookie, __entry->page, __entry->op, __entry->ret)
-	    );
-
-TRACE_EVENT(fscache_gang_lookup,
-	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
-		     void **results, int n, pgoff_t store_limit),
-
-	    TP_ARGS(cookie, op, results, n, store_limit),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			results0	)
-		    __field(int,			n		)
-		    __field(pgoff_t,			store_limit	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->op			= op->debug_id;
-		    __entry->results0		= results[0] ? ((struct page *)results[0])->index : (pgoff_t)-1;
-		    __entry->n			= n;
-		    __entry->store_limit	= store_limit;
-			   ),
-
-	    TP_printk("c=%08x op=%08x r0=%lx n=%d sl=%lx",
-		      __entry->cookie, __entry->op, __entry->results0, __entry->n,
-		      __entry->store_limit)
-	    );
-
-#endif /* _TRACE_FSCACHE_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/include/trace/events/fscache_old.h b/include/trace/events/fscache_old.h
new file mode 100644
index 000000000000..2408f3c5554b
--- /dev/null
+++ b/include/trace/events/fscache_old.h
@@ -0,0 +1,523 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* FS-Cache tracepoints
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fscache_old
+
+#if !defined(_TRACE_FSCACHE_OLD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSCACHE_OLD_H
+
+#include <linux/fscache_old.h>
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum fscache_cookie_trace {
+	fscache_cookie_collision,
+	fscache_cookie_discard,
+	fscache_cookie_get_acquire_parent,
+	fscache_cookie_get_attach_object,
+	fscache_cookie_get_reacquire,
+	fscache_cookie_get_register_netfs,
+	fscache_cookie_put_acquire_nobufs,
+	fscache_cookie_put_dup_netfs,
+	fscache_cookie_put_relinquish,
+	fscache_cookie_put_object,
+	fscache_cookie_put_parent,
+};
+
+enum fscache_page_trace {
+	fscache_page_cached,
+	fscache_page_inval,
+	fscache_page_maybe_release,
+	fscache_page_radix_clear_store,
+	fscache_page_radix_delete,
+	fscache_page_radix_insert,
+	fscache_page_radix_pend2store,
+	fscache_page_radix_set_pend,
+	fscache_page_uncache,
+	fscache_page_write,
+	fscache_page_write_end,
+	fscache_page_write_end_pend,
+	fscache_page_write_end_noc,
+	fscache_page_write_wait,
+	fscache_page_trace__nr
+};
+
+enum fscache_op_trace {
+	fscache_op_cancel,
+	fscache_op_cancel_all,
+	fscache_op_cancelled,
+	fscache_op_completed,
+	fscache_op_enqueue_async,
+	fscache_op_enqueue_mythread,
+	fscache_op_gc,
+	fscache_op_init,
+	fscache_op_put,
+	fscache_op_run,
+	fscache_op_signal,
+	fscache_op_submit,
+	fscache_op_submit_ex,
+	fscache_op_work,
+	fscache_op_trace__nr
+};
+
+enum fscache_page_op_trace {
+	fscache_page_op_alloc_one,
+	fscache_page_op_attr_changed,
+	fscache_page_op_check_consistency,
+	fscache_page_op_invalidate,
+	fscache_page_op_retr_multi,
+	fscache_page_op_retr_one,
+	fscache_page_op_write_one,
+	fscache_page_op_trace__nr
+};
+
+#endif
+
+/*
+ * Declare tracing information enums and their string mappings for display.
+ */
+#define fscache_cookie_traces						\
+	EM(fscache_cookie_collision,		"*COLLISION*")		\
+	EM(fscache_cookie_discard,		"DISCARD")		\
+	EM(fscache_cookie_get_acquire_parent,	"GET prn")		\
+	EM(fscache_cookie_get_attach_object,	"GET obj")		\
+	EM(fscache_cookie_get_reacquire,	"GET raq")		\
+	EM(fscache_cookie_get_register_netfs,	"GET net")		\
+	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
+	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
+	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
+	EM(fscache_cookie_put_object,		"PUT obj")		\
+	E_(fscache_cookie_put_parent,		"PUT prn")
+
+#define fscache_page_traces						\
+	EM(fscache_page_cached,			"Cached ")		\
+	EM(fscache_page_inval,			"InvalPg")		\
+	EM(fscache_page_maybe_release,		"MayRels")		\
+	EM(fscache_page_uncache,		"Uncache")		\
+	EM(fscache_page_radix_clear_store,	"RxCStr ")		\
+	EM(fscache_page_radix_delete,		"RxDel  ")		\
+	EM(fscache_page_radix_insert,		"RxIns  ")		\
+	EM(fscache_page_radix_pend2store,	"RxP2S  ")		\
+	EM(fscache_page_radix_set_pend,		"RxSPend ")		\
+	EM(fscache_page_write,			"WritePg")		\
+	EM(fscache_page_write_end,		"EndPgWr")		\
+	EM(fscache_page_write_end_pend,		"EndPgWP")		\
+	EM(fscache_page_write_end_noc,		"EndPgNC")		\
+	E_(fscache_page_write_wait,		"WtOnWrt")
+
+#define fscache_op_traces						\
+	EM(fscache_op_cancel,			"Cancel1")		\
+	EM(fscache_op_cancel_all,		"CancelA")		\
+	EM(fscache_op_cancelled,		"Canclld")		\
+	EM(fscache_op_completed,		"Complet")		\
+	EM(fscache_op_enqueue_async,		"EnqAsyn")		\
+	EM(fscache_op_enqueue_mythread,		"EnqMyTh")		\
+	EM(fscache_op_gc,			"GC     ")		\
+	EM(fscache_op_init,			"Init   ")		\
+	EM(fscache_op_put,			"Put    ")		\
+	EM(fscache_op_run,			"Run    ")		\
+	EM(fscache_op_signal,			"Signal ")		\
+	EM(fscache_op_submit,			"Submit ")		\
+	EM(fscache_op_submit_ex,		"SubmitX")		\
+	E_(fscache_op_work,			"Work   ")
+
+#define fscache_page_op_traces						\
+	EM(fscache_page_op_alloc_one,		"Alloc1 ")		\
+	EM(fscache_page_op_attr_changed,	"AttrChg")		\
+	EM(fscache_page_op_check_consistency,	"CheckCn")		\
+	EM(fscache_page_op_invalidate,		"Inval  ")		\
+	EM(fscache_page_op_retr_multi,		"RetrMul")		\
+	EM(fscache_page_op_retr_one,		"Retr1  ")		\
+	E_(fscache_page_op_write_one,		"Write1 ")
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+fscache_cookie_traces;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+
+TRACE_EVENT(fscache_cookie,
+	    TP_PROTO(unsigned int cookie_debug_id,
+		     int ref,
+		     enum fscache_cookie_trace where),
+
+	    TP_ARGS(cookie_debug_id, ref, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(enum fscache_cookie_trace,	where		)
+		    __field(int,			ref		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->where	= where;
+		    __entry->ref	= ref;
+			   ),
+
+	    TP_printk("%s c=%08x r=%d",
+		      __print_symbolic(__entry->where, fscache_cookie_traces),
+		      __entry->cookie, __entry->ref)
+	    );
+
+TRACE_EVENT(fscache_netfs,
+	    TP_PROTO(struct fscache_netfs *netfs),
+
+	    TP_ARGS(netfs),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __array(char,			name, 8		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= netfs->primary_index->debug_id;
+		    strncpy(__entry->name, netfs->name, 8);
+		    __entry->name[7]		= 0;
+			   ),
+
+	    TP_printk("c=%08x n=%s",
+		      __entry->cookie, __entry->name)
+	    );
+
+TRACE_EVENT(fscache_acquire,
+	    TP_PROTO(struct fscache_cookie *cookie),
+
+	    TP_ARGS(cookie),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		parent		)
+		    __array(char,			name, 8		)
+		    __field(int,			p_ref		)
+		    __field(int,			p_n_children	)
+		    __field(u8,				p_flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->parent		= cookie->parent->debug_id;
+		    __entry->p_ref		= refcount_read(&cookie->parent->ref);
+		    __entry->p_n_children	= atomic_read(&cookie->parent->n_children);
+		    __entry->p_flags		= cookie->parent->flags;
+		    memcpy(__entry->name, cookie->def->name, 8);
+		    __entry->name[7]		= 0;
+			   ),
+
+	    TP_printk("c=%08x p=%08x pr=%d pc=%d pf=%02x n=%s",
+		      __entry->cookie, __entry->parent, __entry->p_ref,
+		      __entry->p_n_children, __entry->p_flags, __entry->name)
+	    );
+
+TRACE_EVENT(fscache_relinquish,
+	    TP_PROTO(struct fscache_cookie *cookie, bool retire),
+
+	    TP_ARGS(cookie, retire),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		parent		)
+		    __field(int,			ref		)
+		    __field(int,			n_children	)
+		    __field(int,			n_active	)
+		    __field(u8,				flags		)
+		    __field(bool,			retire		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->parent	= cookie->parent->debug_id;
+		    __entry->ref	= refcount_read(&cookie->ref);
+		    __entry->n_children	= atomic_read(&cookie->n_children);
+		    __entry->n_active	= atomic_read(&cookie->n_active);
+		    __entry->flags	= cookie->flags;
+		    __entry->retire	= retire;
+			   ),
+
+	    TP_printk("c=%08x r=%d p=%08x Nc=%d Na=%d f=%02x r=%u",
+		      __entry->cookie, __entry->ref,
+		      __entry->parent, __entry->n_children, __entry->n_active,
+		      __entry->flags, __entry->retire)
+	    );
+
+TRACE_EVENT(fscache_enable,
+	    TP_PROTO(struct fscache_cookie *cookie),
+
+	    TP_ARGS(cookie),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(int,			ref		)
+		    __field(int,			n_children	)
+		    __field(int,			n_active	)
+		    __field(u8,				flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->ref	= refcount_read(&cookie->ref);
+		    __entry->n_children	= atomic_read(&cookie->n_children);
+		    __entry->n_active	= atomic_read(&cookie->n_active);
+		    __entry->flags	= cookie->flags;
+			   ),
+
+	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
+		      __entry->cookie, __entry->ref,
+		      __entry->n_children, __entry->n_active, __entry->flags)
+	    );
+
+TRACE_EVENT(fscache_disable,
+	    TP_PROTO(struct fscache_cookie *cookie),
+
+	    TP_ARGS(cookie),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(int,			ref		)
+		    __field(int,			n_children	)
+		    __field(int,			n_active	)
+		    __field(u8,				flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->ref	= refcount_read(&cookie->ref);
+		    __entry->n_children	= atomic_read(&cookie->n_children);
+		    __entry->n_active	= atomic_read(&cookie->n_active);
+		    __entry->flags	= cookie->flags;
+			   ),
+
+	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
+		      __entry->cookie, __entry->ref,
+		      __entry->n_children, __entry->n_active, __entry->flags)
+	    );
+
+TRACE_EVENT(fscache_osm,
+	    TP_PROTO(struct fscache_object *object,
+		     const struct fscache_state *state,
+		     bool wait, bool oob, s8 event_num),
+
+	    TP_ARGS(object, state, wait, oob, event_num),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		object		)
+		    __array(char,			state, 8	)
+		    __field(bool,			wait		)
+		    __field(bool,			oob		)
+		    __field(s8,				event_num	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= object->cookie->debug_id;
+		    __entry->object		= object->debug_id;
+		    __entry->wait		= wait;
+		    __entry->oob		= oob;
+		    __entry->event_num		= event_num;
+		    memcpy(__entry->state, state->short_name, 8);
+			   ),
+
+	    TP_printk("c=%08x o=%08d %s %s%sev=%d",
+		      __entry->cookie,
+		      __entry->object,
+		      __entry->state,
+		      __print_symbolic(__entry->wait,
+				       { true,  "WAIT" },
+				       { false, "WORK" }),
+		      __print_symbolic(__entry->oob,
+				       { true,  " OOB " },
+				       { false, " " }),
+		      __entry->event_num)
+	    );
+
+TRACE_EVENT(fscache_page,
+	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
+		     enum fscache_page_trace why),
+
+	    TP_ARGS(cookie, page, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(pgoff_t,			page		)
+		    __field(enum fscache_page_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->page		= page->index;
+		    __entry->why		= why;
+			   ),
+
+	    TP_printk("c=%08x %s pg=%lx",
+		      __entry->cookie,
+		      __print_symbolic(__entry->why, fscache_page_traces),
+		      __entry->page)
+	    );
+
+TRACE_EVENT(fscache_check_page,
+	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
+		     void *val, int n),
+
+	    TP_ARGS(cookie, page, val, n),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(void *,			page		)
+		    __field(void *,			val		)
+		    __field(int,			n		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->page		= page;
+		    __entry->val		= val;
+		    __entry->n			= n;
+			   ),
+
+	    TP_printk("c=%08x pg=%p val=%p n=%d",
+		      __entry->cookie, __entry->page, __entry->val, __entry->n)
+	    );
+
+TRACE_EVENT(fscache_wake_cookie,
+	    TP_PROTO(struct fscache_cookie *cookie),
+
+	    TP_ARGS(cookie),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+			   ),
+
+	    TP_printk("c=%08x", __entry->cookie)
+	    );
+
+TRACE_EVENT(fscache_op,
+	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
+		     enum fscache_op_trace why),
+
+	    TP_ARGS(cookie, op, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
+		    __field(enum fscache_op_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie ? cookie->debug_id : 0;
+		    __entry->op			= op->debug_id;
+		    __entry->why		= why;
+			   ),
+
+	    TP_printk("c=%08x op=%08x %s",
+		      __entry->cookie, __entry->op,
+		      __print_symbolic(__entry->why, fscache_op_traces))
+	    );
+
+TRACE_EVENT(fscache_page_op,
+	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
+		     struct fscache_operation *op, enum fscache_page_op_trace what),
+
+	    TP_ARGS(cookie, page, op, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
+		    __field(pgoff_t,			page		)
+		    __field(enum fscache_page_op_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->page		= page ? page->index : 0;
+		    __entry->op			= op->debug_id;
+		    __entry->what		= what;
+			   ),
+
+	    TP_printk("c=%08x %s pg=%lx op=%08x",
+		      __entry->cookie,
+		      __print_symbolic(__entry->what, fscache_page_op_traces),
+		      __entry->page, __entry->op)
+	    );
+
+TRACE_EVENT(fscache_wrote_page,
+	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
+		     struct fscache_operation *op, int ret),
+
+	    TP_ARGS(cookie, page, op, ret),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
+		    __field(pgoff_t,			page		)
+		    __field(int,			ret		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->page		= page->index;
+		    __entry->op			= op->debug_id;
+		    __entry->ret		= ret;
+			   ),
+
+	    TP_printk("c=%08x pg=%lx op=%08x ret=%d",
+		      __entry->cookie, __entry->page, __entry->op, __entry->ret)
+	    );
+
+TRACE_EVENT(fscache_gang_lookup,
+	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
+		     void **results, int n, pgoff_t store_limit),
+
+	    TP_ARGS(cookie, op, results, n, store_limit),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
+		    __field(pgoff_t,			results0	)
+		    __field(int,			n		)
+		    __field(pgoff_t,			store_limit	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->op			= op->debug_id;
+		    __entry->results0		= results[0] ? ((struct page *)results[0])->index : (pgoff_t)-1;
+		    __entry->n			= n;
+		    __entry->store_limit	= store_limit;
+			   ),
+
+	    TP_printk("c=%08x op=%08x r0=%lx n=%d sl=%lx",
+		      __entry->cookie, __entry->op, __entry->results0, __entry->n,
+		      __entry->store_limit)
+	    );
+
+#endif /* _TRACE_FSCACHE_OLD_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


