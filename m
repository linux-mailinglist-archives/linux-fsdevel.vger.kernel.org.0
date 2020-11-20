Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE42BADF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKTPLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728039AbgKTPLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBRqQQCAwiewSr3Mz1MyPJP/r3DASh8azb14ddhRPVg=;
        b=CEPmkyPKhlpU+DqfK56q1X5Kupr/Bhc1gnSEAg1wmk4w487ltiTApwJCQoEjyITsVKG+FO
        aw7EuFalzW2pqNP7Wu1L80tm172NAgR0Snn9F6CFo4bfsebPAs8DZpZdW8xl9jSmU3Obsi
        Yp1Dl0uX6beXd/4EFj2lBrRiFrdxwwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-msQHBA0UORirEomDJM91DQ-1; Fri, 20 Nov 2020 10:11:35 -0500
X-MC-Unique: msQHBA0UORirEomDJM91DQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 822C485EE8F;
        Fri, 20 Nov 2020 15:11:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F08860C15;
        Fri, 20 Nov 2020 15:11:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 41/76] cachefiles: Implement a content-present indicator
 and bitmap
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:11:26 +0000
Message-ID: <160588508638.3465195.13598196924706710300.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a content indicator that indicates the presence or absence of
content and a bitmap that indicates which blocks of granular content are
present in a granular file.  This is added to the xattr that stores the
netfs coherency data, along with the file size and the file zero point (the
point after which it can be assumed that the server doesn't have any data).

In the content bitmap, if present, each bit indicates which 256KiB granules
of a cache file are present.  This is stored in a separate xattr, which is
loaded when the first I/O handle is created on that cache object and saved
when the object is discarded from memory.

Non-index objects in the cache can be monolithic or granular.  The content
map isn't used for monolithic objects (FSCACHE_COOKIE_ADV_SINGLE_CHUNK) as
they are expected to be all-or-nothing, so the content indicator alone
suffices.  Examples of this would be AFS directory or symlink content.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Makefile            |    1 
 fs/cachefiles/bind.c              |    1 
 fs/cachefiles/content-map.c       |  246 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c         |    5 +
 fs/cachefiles/internal.h          |   32 +++++
 fs/cachefiles/io.c                |    4 +
 fs/cachefiles/xattr.c             |   24 +++-
 include/trace/events/cachefiles.h |    4 -
 8 files changed, 309 insertions(+), 8 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index d894d317d6e7..84615aca866a 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -5,6 +5,7 @@
 
 cachefiles-y := \
 	bind.o \
+	content-map.o \
 	daemon.o \
 	interface.o \
 	io.o \
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index c89a422fd1d1..88c7cb4fb0f7 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -102,6 +102,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 		goto error_root_object;
 
 	atomic_set(&fsdef->usage, 1);
+	rwlock_init(&fsdef->content_map_lock);
 	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
 
 	/* look up the directory at the root of the cache */
diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
new file mode 100644
index 000000000000..68fcab313361
--- /dev/null
+++ b/fs/cachefiles/content-map.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Datafile content management
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/swap.h>
+#include <linux/xattr.h>
+#include "internal.h"
+
+static const char cachefiles_xattr_content_map[] =
+	XATTR_USER_PREFIX "CacheFiles.content";
+
+/*
+ * Determine the map size for a granulated object.
+ *
+ * There's one bit per granule.  We size it in terms of 8-byte chunks, where a
+ * 64-bit span * 256KiB bytes granules covers 16MiB of file space.  At that,
+ * 512B will cover 1GiB.
+ */
+static size_t cachefiles_map_size(loff_t i_size)
+{
+	loff_t size;
+	size_t granules, bits, bytes, map_size;
+
+	if (i_size <= CACHEFILES_GRAN_SIZE * 64)
+		return 8;
+
+	size = min_t(loff_t, i_size + CACHEFILES_GRAN_SIZE - 1, CACHEFILES_SIZE_LIMIT);
+	granules = size / CACHEFILES_GRAN_SIZE;
+	bits = granules + (64 - 1);
+	bits &= ~(64 - 1);
+	bytes = bits / 8;
+	map_size = roundup_pow_of_two(bytes);
+	_leave(" = %zx [i=%llx g=%zu b=%zu]", map_size, i_size, granules, bits);
+	return map_size;
+}
+
+/*
+ * Mark the content map to indicate stored granule.
+ */
+void cachefiles_mark_content_map(struct cachefiles_object *object,
+				 loff_t start, loff_t len)
+{
+	_enter("%llx", start);
+
+	read_lock_bh(&object->content_map_lock);
+
+	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
+		if (start == 0) {
+			object->content_info = CACHEFILES_CONTENT_SINGLE;
+			set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags);
+		}
+	} else {
+		pgoff_t granule;
+		loff_t end = start + len;
+
+		start = round_down(start, CACHEFILES_GRAN_SIZE);
+		do {
+			granule = start / CACHEFILES_GRAN_SIZE;
+			if (granule / 8 >= object->content_map_size)
+				break;
+
+			set_bit_le(granule, object->content_map);
+			object->content_map_changed = true;
+			start += CACHEFILES_GRAN_SIZE;
+
+		} while (start < end);
+
+		if (object->content_info != CACHEFILES_CONTENT_MAP) {
+			object->content_info = CACHEFILES_CONTENT_MAP;
+			set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags);
+		}
+	}
+
+	read_unlock_bh(&object->content_map_lock);
+}
+
+/*
+ * Expand the content map to a larger file size.
+ */
+void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t i_size)
+{
+	size_t size;
+	u8 *map, *zap;
+
+	size = cachefiles_map_size(i_size);
+
+	_enter("%llx,%zx,%x", i_size, size, object->content_map_size);
+
+	if (size <= object->content_map_size)
+		return;
+
+	map = kzalloc(size, GFP_KERNEL);
+	if (!map)
+		return;
+
+	write_lock_bh(&object->content_map_lock);
+	if (size > object->content_map_size) {
+		zap = object->content_map;
+		memcpy(map, zap, object->content_map_size);
+		object->content_map = map;
+		object->content_map_size = size;
+	} else {
+		zap = map;
+	}
+	write_unlock_bh(&object->content_map_lock);
+
+	kfree(zap);
+}
+
+/*
+ * Adjust the content map when we shorten a backing object.
+ *
+ * We need to unmark any granules that are going to be discarded.
+ */
+void cachefiles_shorten_content_map(struct cachefiles_object *object,
+				    loff_t new_size)
+{
+	struct fscache_cookie *cookie = object->fscache.cookie;
+	ssize_t granules_needed, bits_needed, bytes_needed;
+
+	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK)
+		return;
+
+	write_lock_bh(&object->content_map_lock);
+
+	if (object->content_info == CACHEFILES_CONTENT_MAP) {
+		if (cookie->zero_point > new_size)
+			cookie->zero_point = new_size;
+
+		granules_needed = new_size;
+		granules_needed += CACHEFILES_GRAN_SIZE - 1;
+		granules_needed /= CACHEFILES_GRAN_SIZE;
+		bits_needed = round_up(granules_needed, 8);
+		bytes_needed = bits_needed / 8;
+
+		if (bytes_needed < object->content_map_size)
+			memset(object->content_map + bytes_needed, 0,
+			       object->content_map_size - bytes_needed);
+
+		if (bits_needed > granules_needed) {
+			size_t byte = (granules_needed - 1) / 8;
+			unsigned int shift = granules_needed % 8;
+			unsigned int mask = (1 << shift) - 1;
+			object->content_map[byte] &= mask;
+		}
+	}
+
+	write_unlock_bh(&object->content_map_lock);
+}
+
+/*
+ * Load the content map.
+ */
+bool cachefiles_load_content_map(struct cachefiles_object *object)
+{
+	struct cachefiles_cache *cache = container_of(object->fscache.cache,
+						      struct cachefiles_cache, cache);
+	const struct cred *saved_cred;
+	ssize_t got;
+	size_t size;
+	u8 *map = NULL;
+
+	_enter("c=%08x,%llx",
+	       object->fscache.cookie->debug_id,
+	       object->fscache.cookie->object_size);
+
+	object->content_info = CACHEFILES_CONTENT_NO_DATA;
+	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
+		/* Single-chunk object.  The presence or absence of the content
+		 * map xattr is sufficient indication.
+		 */
+		size = 0;
+	} else {
+		/* Granulated object.  There's one bit per granule.  We size it
+		 * in terms of 8-byte chunks, where a 64-bit span * 256KiB
+		 * bytes granules covers 16MiB of file space.  At that, 512B
+		 * will cover 1GiB.
+		 */
+		size = cachefiles_map_size(object->fscache.cookie->object_size);
+		map = kzalloc(size, GFP_KERNEL);
+		if (!map)
+			return false;
+	}
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	got = vfs_getxattr(object->dentry, cachefiles_xattr_content_map,
+			   map, size);
+	cachefiles_end_secure(cache, saved_cred);
+	if (got < 0 && got != -ENODATA) {
+		kfree(map);
+		_leave(" = f [%zd]", got);
+		return false;
+	}
+
+	if (size == 0) {
+		if (got != -ENODATA)
+			object->content_info = CACHEFILES_CONTENT_SINGLE;
+		_leave(" = t [%zd]", got);
+	} else {
+		object->content_map = map;
+		object->content_map_size = size;
+		object->content_info = CACHEFILES_CONTENT_MAP;
+		_leave(" = t [%zd/%zu %*phN]", got, size, (int)size, map);
+	}
+
+	return true;
+}
+
+/*
+ * Save the content map.
+ */
+void cachefiles_save_content_map(struct cachefiles_object *object)
+{
+	ssize_t ret;
+	size_t size;
+	u8 *map;
+
+	_enter("c=%08x", object->fscache.cookie->debug_id);
+
+	if (object->content_info != CACHEFILES_CONTENT_MAP)
+		return;
+
+	size = object->content_map_size;
+	map = object->content_map;
+
+	/* Don't save trailing zeros, but do save at least one byte */
+	for (; size > 0; size--)
+		if (map[size - 1])
+			break;
+
+	ret = vfs_setxattr(object->dentry, cachefiles_xattr_content_map,
+			   map, size, 0);
+	if (ret < 0) {
+		cachefiles_io_error_obj(object, "Unable to set xattr e=%zd s=%zu",
+					ret, size);
+		return;
+	}
+
+	_leave(" = %zd", ret);
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 7e8940a7fb55..1d06cf72eeb0 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -37,6 +37,7 @@ struct fscache_object *cachefiles_alloc_object(struct fscache_cookie *cookie,
 		return NULL;
 	}
 
+	rwlock_init(&object->content_map_lock);
 	fscache_object_init(&object->fscache, cookie, &cache->cache);
 	object->fscache.parent = parent;
 	object->fscache.stage = FSCACHE_OBJECT_STAGE_LOOKING_UP;
@@ -198,6 +199,8 @@ static void cachefiles_update_object(struct fscache_object *_object)
 static void cachefiles_commit_object(struct cachefiles_object *object,
 				     struct cachefiles_cache *cache)
 {
+	if (object->content_map_changed)
+		cachefiles_save_content_map(object);
 }
 
 /*
@@ -298,6 +301,8 @@ static void cachefiles_put_object(struct fscache_object *_object,
 		ASSERTCMP(object->dentry, ==, NULL);
 		ASSERTCMP(object->fscache.n_children, ==, 0);
 
+		kfree(object->content_map);
+
 		cache = object->fscache.cache;
 		fscache_object_destroy(&object->fscache);
 		kmem_cache_free(cachefiles_object_jar, object);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2dab3ee386ad..e065550a4bc0 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,11 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 
+/* Cachefile granularity */
+#define CACHEFILES_GRAN_SIZE	(256 * 1024)
+#define CACHEFILES_DIO_BLOCK_SIZE 4096
+#define CACHEFILES_SIZE_LIMIT	(512 * 8 * CACHEFILES_GRAN_SIZE)
+
 struct cachefiles_cache;
 struct cachefiles_object;
 
@@ -29,6 +34,16 @@ extern unsigned cachefiles_debug;
 
 #define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
+enum cachefiles_content {
+	/* These values are saved on disk */
+	CACHEFILES_CONTENT_NO_DATA	= 0, /* No content stored */
+	CACHEFILES_CONTENT_SINGLE	= 1, /* Content is monolithic, all is present */
+	CACHEFILES_CONTENT_ALL		= 2, /* Content is all present, no map */
+	CACHEFILES_CONTENT_MAP		= 3, /* Content is piecemeal, map in use */
+	CACHEFILES_CONTENT_DIRTY	= 4, /* Content is dirty (only seen on disk) */
+	nr__cachefiles_content
+};
+
 /*
  * node records
  */
@@ -41,6 +56,13 @@ struct cachefiles_object {
 	atomic_t			usage;		/* object usage count */
 	uint8_t				type;		/* object type */
 	bool				new;		/* T if object new */
+
+	/* Map of the content blocks in the object */
+	enum cachefiles_content		content_info:8;	/* Info about content presence */
+	bool				content_map_changed;
+	u8				*content_map;		/* Content present bitmap */
+	unsigned int			content_map_size;	/* Size of buffer */
+	rwlock_t			content_map_lock;
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -100,6 +122,16 @@ static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
 extern int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args);
 extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
 
+/*
+ * content-map.c
+ */
+extern void cachefiles_mark_content_map(struct cachefiles_object *object,
+					loff_t start, loff_t len);
+extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);
+extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
+extern bool cachefiles_load_content_map(struct cachefiles_object *object);
+extern void cachefiles_save_content_map(struct cachefiles_object *object);
+
 /*
  * daemon.c
  */
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2d406d681597..bf1930699636 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -59,6 +59,10 @@ bool cachefiles_open_object(struct cachefiles_object *object)
 	path.mnt = cache->mnt;
 	path.dentry = object->dentry;
 
+	if (object->content_info == CACHEFILES_CONTENT_MAP &&
+	    !cachefiles_load_content_map(object))
+		goto error;
+
 	file = open_with_fake_path(&path,
 				   O_RDWR | O_LARGEFILE | O_DIRECT,
 				   d_backing_inode(object->dentry),
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 19db19b7d7db..cbd43855dc0d 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -16,8 +16,11 @@
 #include "internal.h"
 
 struct cachefiles_xattr {
-	uint8_t				type;
-	uint8_t				data[];
+	__be64	object_size;	/* Actual size of the object */
+	__be64	zero_point;	/* Size after which server has no data not written by us */
+	__u8	type;		/* Type of object */
+	__u8	content;	/* Content presence (enum cachefiles_content) */
+	__u8	data[];		/* netfs coherency data */
 } __packed;
 
 static const char cachefiles_xattr_cache[] =
@@ -118,7 +121,10 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	if (!buf)
 		return -ENOMEM;
 
-	buf->type = object->fscache.cookie->type;
+	buf->object_size	= cpu_to_be64(object->fscache.cookie->object_size);
+	buf->zero_point		= cpu_to_be64(object->fscache.cookie->zero_point);
+	buf->type		= object->fscache.cookie->type;
+	buf->content		= object->content_info;
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
 
@@ -127,7 +133,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 			   xattr_flags);
 	if (ret < 0) {
 		trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
-					   0,
+					   buf->content,
 					   cachefiles_coherency_set_fail);
 		if (ret != -ENOMEM)
 			cachefiles_io_error_obj(
@@ -135,7 +141,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 				"Failed to set xattr with error %d", ret);
 	} else {
 		trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
-					   0,
+					   buf->content,
 					   cachefiles_coherency_set_ok);
 	}
 
@@ -174,15 +180,21 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 		why = cachefiles_coherency_check_xattr;
 	} else if (buf->type != object->fscache.cookie->type) {
 		why = cachefiles_coherency_check_type;
+	} else if (buf->content >= nr__cachefiles_content) {
+		why = cachefiles_coherency_check_content;
 	} else if (memcmp(buf->data, p, len) != 0) {
 		why = cachefiles_coherency_check_aux;
+	} else if (be64_to_cpu(buf->object_size) != object->fscache.cookie->object_size) {
+		why = cachefiles_coherency_check_objsize;
 	} else {
+		object->fscache.cookie->zero_point = be64_to_cpu(buf->zero_point);
+		object->content_info = buf->content;
 		why = cachefiles_coherency_check_ok;
 		ret = 0;
 	}
 
 	trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
-				   0, why);
+				   buf->content, why);
 	kfree(buf);
 	return ret;
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index bf588c3f4a07..e7af1d683009 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -324,7 +324,7 @@ TRACE_EVENT(cachefiles_mark_buried,
 TRACE_EVENT(cachefiles_coherency,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     ino_t ino,
-		     int content,
+		     enum cachefiles_content content,
 		     enum cachefiles_coherency_trace why),
 
 	    TP_ARGS(obj, ino, content, why),
@@ -333,7 +333,7 @@ TRACE_EVENT(cachefiles_coherency,
 	    TP_STRUCT__entry(
 		    __field(unsigned int,			obj	)
 		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(int,				content	)
+		    __field(enum cachefiles_content,		content	)
 		    __field(u64,				ino	)
 			     ),
 


