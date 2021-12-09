Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6A46EF08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbhLIRC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241888AbhLIRCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsR6Kq1JaC3YuGI6o7H6dVIRsPOR4elb36pjreB7bEk=;
        b=UlYccSaiNHpT2pXFj0+nXn3c2JL8887mzhZ31dlso3z8n4GoyhSZMoH0VVYBF+QVtgmd5E
        Y0m5l+YNOStjEgkJyOBddI0DYct+Oi/0An9Rhkjzb94zUS4kuuneE/UwQKKzxdqahmAtVc
        Q4hA/z0i9Bo3hH5iMFwjLSac7qrTWVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-5n0f3Yv5MzGCkYgycxFZZg-1; Thu, 09 Dec 2021 11:58:33 -0500
X-MC-Unique: 5n0f3Yv5MzGCkYgycxFZZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BD9A802E68;
        Thu,  9 Dec 2021 16:58:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9041819729;
        Thu,  9 Dec 2021 16:58:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 20/67] fscache: Provide a means to begin an operation
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 16:58:26 +0000
Message-ID: <163906910672.143852.13856103384424986357.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to begin a read operation:

	int fscache_begin_read_operation(
		struct netfs_cache_resources *cres,
		struct fscache_cookie *cookie)

This is primarily intended to be called by network filesystems on behalf of
netfslib, but may also be called to use the I/O access functions directly.
It attaches the resources required by the cache to cres struct from the
supplied cookie.

This holds access to the cache behind the cookie for the duration of the
operation and forces cache withdrawal and cookie invalidation to perform
synchronisation on the operation.  cres->inval_counter is set from the
cookie at this point so that it can be compared at the end of the
operation.

Note that this does not guarantee that the cache state is fully set up and
able to perform I/O immediately; looking up and creation may be left in
progress in the background.  The operations intended to be called by the
network filesystem, such as reading and writing, are expected to wait for
the cookie to move to the correct state.

This will, however, potentially sleep, waiting for a certain minimum state
to be set or for operations such as invalidate to advance far enough that
I/O can resume.


Also provide a function for the cache to call to wait for the cache object
to get to a state where it can be used for certain things:

	bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
					enum fscache_want_stage stage);

This looks at the cache resources provided by the begin function and waits
for them to get to an appropriate stage.  There's a choice of wanting just
some parameters (FSCACHE_WANT_PARAM) or the ability to do I/O
(FSCACHE_WANT_READ or FSCACHE_WANT_WRITE).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819603692.215744.146724961588817028.stgit@warthog.procyon.org.uk/ # v1
---

 fs/fscache/Makefile            |    1 
 fs/fscache/internal.h          |   11 +++
 fs/fscache/io.c                |  151 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h  |   11 +++
 include/linux/fscache.h        |   49 +++++++++++++
 include/trace/events/fscache.h |    6 ++
 6 files changed, 229 insertions(+)
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
 
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index e4f3a1a993f6..1308bfff94fb 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -70,6 +70,17 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 			     where);
 }
 
+/*
+ * io.c
+ */
+static inline void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+
+	if (ops)
+		ops->end_operation(cres);
+}
+
 /*
  * main.c
  */
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
new file mode 100644
index 000000000000..460a43473019
--- /dev/null
+++ b/fs/fscache/io.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache data I/O routines
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#define FSCACHE_DEBUG_LEVEL OPERATION
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
+ * @want_state: The minimum state the object must be at
+ *
+ * See if the target cache object is at the specified minimum state of
+ * accessibility yet, and if not, wait for it.
+ */
+bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_state want_state)
+{
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
+	enum fscache_cookie_state state;
+
+again:
+	if (!fscache_cache_is_live(cookie->volume->cache)) {
+		_leave(" [broken]");
+		return false;
+	}
+
+	state = fscache_cookie_state(cookie);
+	_enter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
+
+	switch (state) {
+	case FSCACHE_COOKIE_STATE_CREATING:
+	case FSCACHE_COOKIE_STATE_INVALIDATING:
+		if (want_state == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		fallthrough;
+	case FSCACHE_COOKIE_STATE_LOOKING_UP:
+	case FSCACHE_COOKIE_STATE_LRU_DISCARDING:
+		wait_var_event(&cookie->state,
+			       fscache_cookie_state(cookie) != state);
+		goto again;
+
+	case FSCACHE_COOKIE_STATE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STATE_DROPPED:
+	case FSCACHE_COOKIE_STATE_RELINQUISHING:
+	default:
+		_leave(" [not live]");
+		return false;
+	}
+
+ready:
+	if (!cres->cache_priv2)
+		return cookie->volume->cache->ops->begin_operation(cres, want_state);
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
+				   enum fscache_want_state want_state,
+				   enum fscache_access_trace why)
+{
+	enum fscache_cookie_state state;
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
+	state = fscache_cookie_state(cookie);
+	_enter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
+
+	switch (state) {
+	case FSCACHE_COOKIE_STATE_LOOKING_UP:
+	case FSCACHE_COOKIE_STATE_LRU_DISCARDING:
+	case FSCACHE_COOKIE_STATE_INVALIDATING:
+		goto wait_for_file_wrangling;
+	case FSCACHE_COOKIE_STATE_CREATING:
+		if (want_state == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		goto wait_for_file_wrangling;
+	case FSCACHE_COOKIE_STATE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STATE_DROPPED:
+	case FSCACHE_COOKIE_STATE_RELINQUISHING:
+		WARN(1, "Can't use cookie in state %u\n", cookie->state);
+		goto not_live;
+	default:
+		goto not_live;
+	}
+
+ready:
+	spin_unlock(&cookie->lock);
+	if (!cookie->volume->cache->ops->begin_operation(cres, want_state))
+		goto failed;
+	return 0;
+
+wait_for_file_wrangling:
+	spin_unlock(&cookie->lock);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     atomic_read(&cookie->n_accesses),
+			     fscache_access_io_wait);
+	timeo = wait_var_event_timeout(&cookie->state,
+				       fscache_cookie_state(cookie) != state, 20 * HZ);
+	if (timeo <= 1 && !once_only) {
+		pr_warn("%s: cookie state change wait timed out: cookie->state=%u state=%u",
+			__func__, fscache_cookie_state(cookie), state);
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
index 1ad56bfd9d72..566497cf5f13 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -67,6 +67,10 @@ struct fscache_cache_ops {
 	/* Invalidate an object */
 	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
 
+	/* Begin an operation for the netfs lib */
+	bool (*begin_operation)(struct netfs_cache_resources *cres,
+				enum fscache_want_state want_state);
+
 	/* Prepare to write to a live cache object */
 	void (*prepare_to_write)(struct fscache_cookie *cookie);
 };
@@ -101,6 +105,8 @@ extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
 extern void fscache_cookie_lookup_negative(struct fscache_cookie *cookie);
 extern void fscache_resume_after_invalidation(struct fscache_cookie *cookie);
 extern void fscache_caching_failed(struct fscache_cookie *cookie);
+extern bool fscache_wait_for_operation(struct netfs_cache_resources *cred,
+				       enum fscache_want_state state);
 
 /**
  * fscache_cookie_state - Read the state of a cookie
@@ -129,4 +135,9 @@ static inline void *fscache_get_key(struct fscache_cookie *cookie)
 		return cookie->key;
 }
 
+static inline struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv;
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 39913ccae07f..329ed9dcd22f 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -41,6 +41,12 @@ struct fscache_cookie;
 
 #define FSCACHE_INVAL_DIO_WRITE		0x01 /* Invalidate due to DIO write */
 
+enum fscache_want_state {
+	FSCACHE_WANT_PARAMS,
+	FSCACHE_WANT_WRITE,
+	FSCACHE_WANT_READ,
+};
+
 /*
  * Data object state.
  */
@@ -156,6 +162,7 @@ extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
+extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
@@ -354,4 +361,46 @@ void fscache_invalidate(struct fscache_cookie *cookie,
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
+ * @cres->inval_counter is set from @cookie->inval_counter for comparison at
+ * the end of the operation.  This allows invalidation during the operation to
+ * be detected by the caller.
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
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 294792881434..9f78c903b00a 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -76,6 +76,9 @@ enum fscache_access_trace {
 	fscache_access_cache_unpin,
 	fscache_access_invalidate_cookie,
 	fscache_access_invalidate_cookie_end,
+	fscache_access_io_not_live,
+	fscache_access_io_read,
+	fscache_access_io_wait,
 	fscache_access_lookup_cookie,
 	fscache_access_lookup_cookie_end,
 	fscache_access_lookup_cookie_end_failed,
@@ -143,6 +146,9 @@ enum fscache_access_trace {
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
 	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
 	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
+	EM(fscache_access_io_not_live,		"END   io_notl")	\
+	EM(fscache_access_io_read,		"BEGIN io_read")	\
+	EM(fscache_access_io_wait,		"WAIT  io     ")	\
 	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
 	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_lookup_cookie_end_failed,"END   lookupf")	\


