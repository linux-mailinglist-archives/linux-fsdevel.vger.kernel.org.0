Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCDB437D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhJVTGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233690AbhJVTG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkw/96L1Qmb9gC+VuQCk+YU9JjtxtEUmp/N5bkvbDi8=;
        b=JQV9TH9Q57Z+DhQKKcIq1njpiC3EVec9F2W4M204q3cFdKLGLVaQb4D3+lIAcvFwgDa3I/
        FRs0+IH/MfvOliOohpxLkEVXYOVmtOj5y2d3xDw5+jA4vULJlhWTD0y4szVuyfaW1zuQ/M
        Vrd7V3i/ykpT4/avw4pJdHUknMMPBNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-TiGYkmUsNq2uLp_IuU4rRw-1; Fri, 22 Oct 2021 15:04:07 -0400
X-MC-Unique: TiGYkmUsNq2uLp_IuU4rRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6FA0806689;
        Fri, 22 Oct 2021 19:04:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0FF35B826;
        Fri, 22 Oct 2021 19:03:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 21/53] fscache: Provide a means to begin an operation
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
Date:   Fri, 22 Oct 2021 20:03:57 +0100
Message-ID: <163492943791.1038219.9645087798121151922.stgit@warthog.procyon.org.uk>
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

Provide a function to begin a read operation:

	int fscache_begin_read_operation(
		struct netfs_cache_resources *cres,
		struct fscache_cookie *cookie)

This may be called by the network filesystem on behalf of netfslib, but may
also be called to use the I/O access functions directly.  It attaches the
resources required by the cache to cres struct from the supplied cookie.

This holds access to the cache behind the cookie for the duration of the
operation and forces cache withdrawal and cookie invalidation to perform
some sort of synchronisation on the operation.

Note that this does not guarantee that the cache state is fully set up and
able to perform I/O immediately; looking up and creation may be left
proceeding in the background.  The operations intended to be called by the
network filesystem, such as reading and writing, are expected to wait for
the cookie to move to the correct state.

This will, however, potentially sleep, waiting for a certain minimum state
to be set or for operations such as invalidate to advance far enough that
I/O can resume.

A function is also provided for the cache to call to wait for the cache
object to get to a state where it can be used for certain things:

	bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
					enum fscache_want_stage stage);

This looks at the cache resources provided by the begin function and waits
for them to get to an appropriate stage.  There's a choice of wanting just
some parameters (FSCACHE_WANT_PARAM) or the ability to do I/O
(FSCACHE_WANT_READ or FSCACHE_WANT_WRITE).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/Makefile            |    1 
 fs/fscache/io.c                |  152 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h  |   23 ++++++
 include/linux/fscache.h        |   51 +++++++++++++
 include/trace/events/fscache.h |    6 ++
 5 files changed, 233 insertions(+)
 create mode 100644 fs/fscache/io.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index bcc79615f93a..afb090ea16c4 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -6,6 +6,7 @@
 fscache-y := \
 	cache.o \
 	cookie.o \
+	io.o \
 	main.o \
 	volume.o
 
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
new file mode 100644
index 000000000000..9c747069b923
--- /dev/null
+++ b/fs/fscache/io.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache data I/O routines
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#define FSCACHE_USE_NEW_IO_API
+#define FSCACHE_USE_FALLBACK_IO_API
+#include <linux/fscache-cache.h>
+#include <linux/uio.h>
+#include <linux/bvec.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+/**
+ * fscache_wait_for_operation - Wait for an object become accessible
+ * @cres: The cache resources for the operation being performed
+ * @want_stage: The minimum stage the object must be at
+ *
+ * See if the target cache object is at the specified minimum stage of
+ * accessibility yet, and if not, wait for it.
+ */
+bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_stage want_stage)
+{
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
+	enum fscache_cookie_stage stage;
+
+again:
+	if (!fscache_cache_is_live(cookie->volume->cache)) {
+		_leave(" [broken]");
+		return false;
+	}
+
+	stage = READ_ONCE(cookie->stage);
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_CREATING:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		if (want_stage == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		fallthrough;
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
+		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
+		goto again;
+
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+	default:
+		_leave(" [not live]");
+		return false;
+	}
+
+ready:
+	if (!cres->cache_priv2)
+		return cookie->volume->cache->ops->begin_operation(cres, want_stage);
+	return true;
+}
+EXPORT_SYMBOL(fscache_wait_for_operation);
+
+/*
+ * Begin an I/O operation on the cache, waiting till we reach the right state.
+ *
+ * Attaches the resources required to the operation resources record.
+ */
+static int fscache_begin_operation(struct netfs_cache_resources *cres,
+				   struct fscache_cookie *cookie,
+				   enum fscache_want_stage want_stage,
+				   enum fscache_access_trace why)
+{
+	enum fscache_cookie_stage stage;
+	long timeo;
+	bool once_only = false;
+
+	cres->ops		= NULL;
+	cres->cache_priv	= cookie;
+	cres->cache_priv2	= NULL;
+	cres->debug_id		= cookie->debug_id;
+	cres->inval_counter	= cookie->inval_counter;
+
+	if (!fscache_begin_cookie_access(cookie, why))
+		return -ENOBUFS;
+
+again:
+	spin_lock(&cookie->lock);
+
+	stage = cookie->stage;
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_COMMITTING:
+		goto wait_and_validate;
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		if (want_stage == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		goto wait_and_validate;
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		goto not_live;
+	default:
+		goto not_live;
+	}
+
+ready:
+	spin_unlock(&cookie->lock);
+	if (!cookie->volume->cache->ops->begin_operation(cres, want_stage))
+		goto failed;
+	return 0;
+
+wait_and_validate:
+	spin_unlock(&cookie->lock);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     atomic_read(&cookie->n_accesses),
+			     fscache_access_io_wait);
+	timeo = wait_var_event_timeout(&cookie->stage,
+				       READ_ONCE(cookie->stage) != stage, 20 * HZ);
+	if (timeo <= 1 && !once_only) {
+		pr_warn("%s: cookie stage change wait timed out: cookie->stage=%u stage=%u",
+			__func__, READ_ONCE(cookie->stage), stage);
+		fscache_print_cookie(cookie, 'O');
+		once_only = true;
+	}
+	goto again;
+
+not_live:
+	spin_unlock(&cookie->lock);
+failed:
+	cres->cache_priv = NULL;
+	cres->ops = NULL;
+	fscache_end_cookie_access(cookie, fscache_access_io_not_live);
+	_leave(" = -ENOBUFS");
+	return -ENOBUFS;
+}
+
+int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
+				   struct fscache_cookie *cookie)
+{
+	return fscache_begin_operation(cres, cookie, FSCACHE_WANT_PARAMS,
+				       fscache_access_io_read);
+}
+EXPORT_SYMBOL(__fscache_begin_read_operation);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 46d77a1840cd..2d57b85cfde3 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -69,6 +69,10 @@ struct fscache_cache_ops {
 	/* Invalidate an object */
 	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
 
+	/* Begin an operation for the netfs lib */
+	bool (*begin_operation)(struct netfs_cache_resources *cres,
+				enum fscache_want_stage want_stage);
+
 	/* Prepare to write to a live cache object */
 	void (*prepare_to_write)(struct fscache_cookie *cookie);
 };
@@ -123,6 +127,8 @@ extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
 				      enum fscache_access_trace why);
 extern void fscache_set_cookie_stage(struct fscache_cookie *cookie,
 				     enum fscache_cookie_stage stage);
+extern bool fscache_wait_for_operation(struct netfs_cache_resources *cred,
+				       enum fscache_want_stage stage);
 
 /*
  * Find the key on a cookie.
@@ -149,6 +155,23 @@ static inline void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
 	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_CREATING);
 }
 
+static inline struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv;
+}
+
+/**
+ * fscache_end_operation - End an fscache I/O operation.
+ * @cres: The resources to dispose of.
+ */
+static inline
+void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	if (ops)
+		ops->end_operation(cres);
+}
+
 extern struct workqueue_struct *fscache_wq;
 
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 0b01eaaef44c..ba55717f81ca 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -47,6 +47,12 @@ struct fscache_cookie;
 
 #define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
 
+enum fscache_want_stage {
+	FSCACHE_WANT_PARAMS,
+	FSCACHE_WANT_WRITE,
+	FSCACHE_WANT_READ,
+};
+
 /*
  * Data object state.
  */
@@ -162,6 +168,9 @@ extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
+#ifdef FSCACHE_USE_NEW_IO_API
+extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
+#endif
 
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
@@ -358,4 +367,46 @@ void fscache_invalidate(struct fscache_cookie *cookie,
 		__fscache_invalidate(cookie, aux_data, size, flags);
 }
 
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
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_begin_read_operation(cres, cookie);
+	return -ENOBUFS;
+}
+
+#endif /* FSCACHE_USE_NEW_IO_API */
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index b705ff36bddc..4ccaf4490b1b 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -75,6 +75,9 @@ enum fscache_access_trace {
 	fscache_access_cache_unpin,
 	fscache_access_invalidate_cookie,
 	fscache_access_invalidate_cookie_end,
+	fscache_access_io_not_live,
+	fscache_access_io_read,
+	fscache_access_io_wait,
 	fscache_access_lookup_cookie,
 	fscache_access_lookup_cookie_end,
 	fscache_access_relinquish_volume,
@@ -140,6 +143,9 @@ enum fscache_access_trace {
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
 	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
 	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
+	EM(fscache_access_io_not_live,		"END   io_notl")	\
+	EM(fscache_access_io_read,		"BEGIN io_read")	\
+	EM(fscache_access_io_wait,		"WAIT  io    ")		\
 	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
 	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\


