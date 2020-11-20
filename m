Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100E2BAD8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKTPI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728456AbgKTPIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ce7I6TX0Eivr0ReMrIaiS0RmAIXLfaGj85hBuIk17QQ=;
        b=U8r/Qs0hN/om8MxhSuvyLWp5mmqOtq2pYu6gM+v/SKVq4quQe+zmS6dMx8BlPSqLmp+Qvs
        VMtsUWOgLkZNefvsdiqWnAgcqje/u0qLhKJGdYMxjfa+I8Dfb/DzxzkQtN/HZ0Hn/VFdGr
        as9VAuutrLnk3wU1zMw9+lXHZWcg/5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-RmoWGPKlMiCP3ACV4dfmEA-1; Fri, 20 Nov 2020 10:08:20 -0500
X-MC-Unique: RmoWGPKlMiCP3ACV4dfmEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEC4684A5E0;
        Fri, 20 Nov 2020 15:08:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 555566085A;
        Fri, 20 Nov 2020 15:08:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 26/76] fscache: Rewrite the I/O API based on iov_iter
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
Date:   Fri, 20 Nov 2020 15:08:10 +0000
Message-ID: <160588489050.3465195.108828716426599824.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the fscache I/O API by introducing a number of new routines based
on a number of principles:

 (1) The cache provides *only* write-to-cache and read-from-cache calls for
     transferring data to/from the cache.

 (2) The bufferage for I/O to/from the cache is supplied with an iov_iter.
     There is no requirement that the iov_iters involved have anything to
     do with an inode's pagecache, though if it does, an ITER_MAPPING
     iterator is available.

 (3) I/O to/from any particular cache object is done in one of a number of
     modes, set for the cache object at cookie acquisition time:

	(A) Single blob.  The blob must be written in its entirety in one
	    go.

	(B) Granular.  Writes to the cache should be done in granule
	    sized-blocks, where, for the moment, a granule will be 256KiB,
	    but could be variable.  This allows the metadata indicating
	    which granules are present to be smaller at the cost of using
	    more disk space.

     In both cases, reads from the cache may be done in smaller chunks and
     small update writes may be done inside a block that exists.

 (4) I/O to/from the cache must be aligned to the DIO block size of the
     backing filesystem.  The cache tells the caller what it should
     consider the DIO block size to be.  This will never be larger than
     page size.

 (5) Completion of the I/O results in a callback - after which the cache
     no longer knows about it.

 (6) The cache doesn't retain any pointers back into the netfs, either the
     code, its state or its pagecache.


To do granular I/O, the netfs has to take the read or write request it got
from the VFS/VM and 'shape' it to fit the caching parameters.  It does this
by filling in a form to indicate the extent of the operation it might like
to make:

	struct fscache_request_shape {
		/* Parameters */
		loff_t		i_size;
		pgoff_t		proposed_start;
		unsigned int	proposed_nr_pages;
		unsigned int	max_io_pages;
		bool		for_write;

		/* Result */
		unsigned int	to_be_done;
		unsigned int	granularity;
		unsigned int	dio_block_size;
		unsigned int	actual_nr_pages;
		pgoff_t		actual_start;
	};

and then it calls:

	void fscache_shape_request(struct fscache_cookie *cookie,
				   struct fscache_request_shape *shape);

to shape it.

The netfs should set 'proposed_start' to be the first page to read,
'proposed_nr_pages' to indicate the size of the request and 'i_size' to
indicate the size that the file should be considered to be.  'max_io_pages'
should be set to the maximum size of a transaction, up to UINT_MAX, and
'for_write' should be set to true if this is for a write to the cache.

The cache will then shape the proposed read to fit a blocking factor
appropriate for the cache object and region of the file.  It may extend
start forward and may shrink or extend the request to fit the granularity
of the cache.  This will be trimmed to the end of file as specified by the
proposed file size.

Upon return, 'to_be_done' will be set to one of FSCACHE_READ_FROM_SERVER,
FSCACHE_READ_FROM_CACHE, FSCACHE_FILL_WITH_ZERO, and may have
FSCACHE_WRITE_TO_CACHE bitwise-OR'd onto it.

'actual_start' and 'actual_nr_pages' will be set to indicate
the cache's proposal for the desired size and position of the operation.
'granularity' will be set to hold the cache block granularity (in pages)
and transaction can be shortened to a multiple of this.  Note that the
shaped request will always include the proposed_start page.

'dio_block_size' will be set to whatever I/O size the cache must
communicate with its storage in.  This is necessary to set up the iov_iter
to be passed to the cache for reading and writing so that it can do direct
I/O.

Once the netfs has set up its request, if FSCACHE_READ_FROM_CACHE was set,
it should then call:

	void fscache_read(struct fscache_io_request *req)

to read data from the cache.  To do this, it needs to fill out a request
descriptor:

	struct fscache_io_request {
		const struct fscache_io_request_ops *ops;
		struct fscache_cookie	*cookie;
		loff_t			pos;
		loff_t			len;
		int			error;
		bool (*is_still_valid)(struct fscache_io_request *);
		void (*done)(struct fscache_io_request *);
		...
	};

The ops pointer, cookie, position and length should be set to describe the
I/O operation to be performed.  An 'is_still_valid' function may be
provided to check whether the operation should still go ahead after a wait
in case it got invalidated by the server.

A 'done' function may be provided that will be called to finalise the
operation.  If provided, the 'done' function will be always be called, even
when the operation doesn't take place because there's no cache.  If no done
function is called, the operation will be synchronous.

Note that the pages must be pinned - typically by locking them.

If FSCACHE_WRITE_TO_CACHE was set, then once the data is read from the
server, the netfs should write it to the cache by calling:

	void fscache_write(struct fscache_io_request *req)

The request descriptor is set as for fscache_read().  Note that the pages
must be pinned.  In this case, PG_fscache can be set on the page and the
pages can be unlocked; the bit can then be cleared by the done handler.
The releasepage, invalidatepage, launderpage and page_mkwrite functions
should be used to suspend progress until the bit is cleared.  The following
functions are made available in an earlier patch for this:

	void unlock_page_fscache(struct page *page);
	void wait_on_page_fscache(struct page *page)

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Makefile               |    1 
 fs/fscache/cookie.c               |    4 -
 fs/fscache/internal.h             |    1 
 fs/fscache/io.c                   |  144 +++++++++++++++++++++++++++++
 fs/fscache/obj.c                  |    2 
 include/linux/fscache-cache.h     |   20 ++++
 include/linux/fscache.h           |  186 +++++++++++++++++++++++++++++++++++++
 include/trace/events/cachefiles.h |    2 
 include/trace/events/fscache.h    |    2 
 9 files changed, 357 insertions(+), 5 deletions(-)
 create mode 100644 fs/fscache/io.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 396e1b5fdc28..3caf66810e7b 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -8,6 +8,7 @@ fscache-y := \
 	cookie.o \
 	dispatcher.o \
 	fsdef.o \
+	io.o \
 	main.o \
 	netfs.o \
 	obj.o \
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 3e79177a7b7b..e6b87596b1d0 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -20,7 +20,7 @@ static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
 
-static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
+void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
 	struct fscache_object *object;
 	struct hlist_node *o;
@@ -569,7 +569,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	case FSCACHE_COOKIE_STAGE_ACTIVE:
 		cookie->stage = FSCACHE_COOKIE_STAGE_INVALIDATING;
 
-		atomic_inc(&cookie->n_ops);
+		fscache_count_io_operation(cookie);
 		object->cache->ops->grab_object(object, fscache_obj_get_inval);
 		spin_unlock(&cookie->lock);
 		wake_up_cookie_stage(cookie);
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 67ca437c1f73..6c2a6ebe4f02 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -59,6 +59,7 @@ static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
 /*
  * cookie.c
  */
+extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
 extern struct kmem_cache *fscache_cookie_jar;
 extern const struct seq_operations fscache_cookies_seq_ops;
 
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
new file mode 100644
index 000000000000..7ad13900b281
--- /dev/null
+++ b/fs/fscache/io.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Data I/O routines
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/module.h>
+#include <linux/fscache-cache.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Wait for a cookie to reach the specified stage.
+ */
+void __fscache_wait_for_operation(struct fscache_op_resources *opr,
+				  enum fscache_want_stage want_stage)
+{
+	struct fscache_cookie *cookie = opr->object->cookie;
+	enum fscache_cookie_stage stage;
+
+again:
+	stage = READ_ONCE(cookie->stage);
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	if (fscache_cache_is_broken(opr->object)) {
+		_leave(" [broken]");
+		return;
+	}
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_INITIALISING:
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
+		goto again;
+
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		return;
+	case FSCACHE_COOKIE_STAGE_INDEX:
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+	default:
+		_leave(" [not live]");
+		return;
+	}
+}
+EXPORT_SYMBOL(__fscache_wait_for_operation);
+
+/*
+ * Release the resources needed by an operation.
+ */
+void __fscache_end_operation(struct fscache_op_resources *opr)
+{
+	struct fscache_object *object = opr->object;
+
+	fscache_uncount_io_operation(object->cookie);
+	object->cache->ops->put_object(object, fscache_obj_put_ioreq);
+}
+EXPORT_SYMBOL(__fscache_end_operation);
+
+/*
+ * Begin an I/O operation on the cache, waiting till we reach the right state.
+ *
+ * Attaches the resources required to the operation resources record.
+ */
+int __fscache_begin_operation(struct fscache_cookie *cookie,
+			      struct fscache_op_resources *opr,
+			      enum fscache_want_stage want_stage)
+{
+	struct fscache_object *object;
+	enum fscache_cookie_stage stage;
+	long timeo;
+	bool once_only = false;
+
+again:
+	spin_lock(&cookie->lock);
+
+	stage = cookie->stage;
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_INITIALISING:
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		goto wait_and_validate;
+
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+		if (want_stage == FSCACHE_WANT_READ)
+			goto no_data_yet;
+		fallthrough;
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STAGE_INDEX:
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		goto not_live;
+	default:
+		goto not_live;
+	}
+
+ready:
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+
+	if (fscache_cache_is_broken(object))
+		goto not_live;
+
+	opr->object = object;
+	object->cache->ops->grab_object(object, fscache_obj_get_ioreq);
+	object->cache->ops->begin_operation(opr);
+
+	fscache_count_io_operation(cookie);
+	spin_unlock(&cookie->lock);
+	return 0;
+
+wait_and_validate:
+	spin_unlock(&cookie->lock);
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
+no_data_yet:
+	spin_unlock(&cookie->lock);
+	opr->object = NULL;
+	_leave(" = -ENODATA");
+	return -ENODATA;
+
+not_live:
+	spin_unlock(&cookie->lock);
+	opr->object = NULL;
+	_leave(" = -ENOBUFS");
+	return -ENOBUFS;
+}
+EXPORT_SYMBOL(__fscache_begin_operation);
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index d4a3b6fac791..7286d3e2eb31 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -274,7 +274,7 @@ void fscache_invalidate_object(struct fscache_cookie *cookie,
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_NO_DATA_YET);
 	else
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
-	fscache_end_io_operation(cookie);
+	fscache_uncount_io_operation(cookie);
 }
 
 /*
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 19770160dbb9..97415d19aa82 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -27,6 +27,7 @@ enum fscache_obj_ref_trace {
 	fscache_obj_get_attach,
 	fscache_obj_get_exists,
 	fscache_obj_get_inval,
+	fscache_obj_get_ioreq,
 	fscache_obj_get_wait,
 	fscache_obj_get_withdraw,
 	fscache_obj_new,
@@ -37,6 +38,7 @@ enum fscache_obj_ref_trace {
 	fscache_obj_put_drop_child,
 	fscache_obj_put_drop_obj,
 	fscache_obj_put_inval,
+	fscache_obj_put_ioreq,
 	fscache_obj_put_lookup_fail,
 	fscache_obj_put_withdraw,
 	fscache_obj_ref__nr_traces
@@ -134,6 +136,9 @@ struct fscache_cache_ops {
 
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+
+	/* Begin an operation on a cache object */
+	void (*begin_operation)(struct fscache_op_resources *opr);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
@@ -231,12 +236,23 @@ static inline void *fscache_get_aux(struct fscache_cookie *cookie)
 }
 
 /*
- * Complete an I/O operation
+ * Count the start of an I/O operation
  */
-static inline void fscache_end_io_operation(struct fscache_cookie *cookie)
+static inline void fscache_count_io_operation(struct fscache_cookie *cookie)
+{
+	atomic_inc(&cookie->n_ops);
+}
+
+/*
+ * Count the end of an I/O operation
+ */
+static inline void fscache_uncount_io_operation(struct fscache_cookie *cookie)
 {
 	if (atomic_dec_and_test(&cookie->n_ops))
 		wake_up_var(&cookie->n_ops);
 }
 
+extern void __fscache_wait_for_operation(struct fscache_op_resources *, enum fscache_want_stage);
+extern void __fscache_end_operation(struct fscache_op_resources *);
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9d5e0d7ba860..3cd18ddc3903 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -21,11 +21,15 @@
 #include <linux/list_bl.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
+#define __fscache_available (1)
 #define fscache_available() (1)
 #define fscache_cookie_valid(cookie) (cookie)
+#define fscache_object_valid(object) (object)
 #else
+#define __fscache_available (0)
 #define fscache_available() (0)
 #define fscache_cookie_valid(cookie) (0)
+#define fscache_object_valid(object) (NULL)
 #endif
 
 
@@ -45,6 +49,10 @@
 struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
+struct fscache_op_resources;
+struct fscache_op_ops;
+
+typedef void (*fscache_io_terminated_t)(void *priv, ssize_t transferred_or_error);
 
 enum fscache_cookie_type {
 	FSCACHE_COOKIE_TYPE_INDEX,
@@ -55,6 +63,12 @@ enum fscache_cookie_type {
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
 
+enum fscache_want_stage {
+	FSCACHE_WANT_PARAMS,
+	FSCACHE_WANT_WRITE,
+	FSCACHE_WANT_READ,
+};
+
 /*
  * fscache cached network filesystem type
  * - name, version and ops must be filled in before registration
@@ -124,6 +138,42 @@ struct fscache_cookie {
 	};
 };
 
+/*
+ * Resources required to do operations.
+ */
+struct fscache_op_resources {
+#if __fscache_available
+	const struct fscache_op_ops	*ops;
+	struct fscache_object		*object;
+#endif
+};
+
+/*
+ * Table of operations for doing things to a non-index cookie.
+ */
+struct fscache_op_ops {
+	/* Wait for an operation to complete */
+	void (*wait_for_operation)(struct fscache_op_resources *opr,
+				   enum fscache_want_stage want_stage);
+	/* End an operation */
+	void (*end_operation)(struct fscache_op_resources *opr);
+
+	/* Read data from the cache */
+	int (*read)(struct fscache_op_resources *opr,
+		    loff_t start_pos,
+		    struct iov_iter *iter,
+		    bool seek_data,
+		    fscache_io_terminated_t term_func,
+		    void *term_func_priv);
+
+	/* Write data to the cache */
+	int (*write)(struct fscache_op_resources *opr,
+		     loff_t start_pos,
+		     struct iov_iter *iter,
+		     fscache_io_terminated_t term_func,
+		     void *term_func_priv);
+};
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
@@ -147,6 +197,8 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	loff_t);
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
+extern int __fscache_begin_operation(struct fscache_cookie *, struct fscache_op_resources *,
+				     enum fscache_want_stage);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
@@ -392,4 +444,138 @@ void fscache_invalidate(struct fscache_cookie *cookie)
 		__fscache_invalidate(cookie);
 }
 
+/**
+ * fscache_begin_operation - Begin an fscache I/O operation
+ * @cookie: The cookie representing the cache object
+ * @opr: Where to stash the resources
+ * @want_stage: The minimum stage the object must be at
+ *
+ * Prepare to do an operation against a cache object, represented by @cookie.
+ * Any resources pinned to make the operation possible will be cached in *@opr.
+ * The stage that the object must be at before the operation can take place
+ * should be specified in @want_stage.  The function will wait until this is
+ * the case, or the object fails.
+ *
+ * Returns 0 on success, -ENODATA if reading is desired, but there's no data
+ * available yet and -ENOBUFS if the cache object is unavailable.
+ */
+static inline
+int fscache_begin_operation(struct fscache_cookie *cookie,
+			    struct fscache_op_resources *opr,
+			    enum fscache_want_stage want_stage)
+{
+	if (fscache_cookie_valid(cookie))
+		return __fscache_begin_operation(cookie, opr, want_stage);
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_operation_valid - Return true if operations resources are usable
+ * @opr: The resources to check.
+ *
+ * Returns a pointer to the operations table if usable or NULL if not.
+ */
+static inline
+const struct fscache_op_ops *fscache_operation_valid(const struct fscache_op_resources *opr)
+{
+#if __fscache_available
+	return fscache_object_valid(opr->object) ? opr->ops : NULL;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * fscache_wait_for_operation - Wait for an object become accessible
+ * @cookie: The cookie representing the cache object
+ * @want_stage: The minimum stage the object must be at
+ *
+ * See if the target cache object is at the specified minimum stage of
+ * accessibility yet, and if not, wait for it.
+ */
+static inline
+void fscache_wait_for_operation(struct fscache_op_resources *opr,
+				enum fscache_want_stage want_stage)
+{
+	const struct fscache_op_ops *ops = fscache_operation_valid(opr);
+	if (ops)
+		ops->wait_for_operation(opr, want_stage);
+}
+
+/**
+ * fscache_end_operation - End an fscache I/O operation.
+ * @opr: The resources to dispose of.
+ */
+static inline
+void fscache_end_operation(struct fscache_op_resources *opr)
+{
+	const struct fscache_op_ops *ops = fscache_operation_valid(opr);
+	if (ops)
+		ops->end_operation(opr);
+}
+
+/**
+ * fscache_read - Start a read from the cache.
+ * @opr: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The buffer to fill - and also the length
+ * @seek_data: True to seek for the data
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a read from the cache.  @opr indicates the cache object to read from
+ * and must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data is read into the iterator, @iter, and that also indicates the size
+ * of the operation.  @start_pos is the start position in the file, though if
+ * @seek_data is set, the cache will use SEEK_DATA to find the next piece of
+ * data, writing zeros for the hole into the iterator.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_read(struct fscache_op_resources *opr,
+		 loff_t start_pos,
+		 struct iov_iter *iter,
+		 bool seek_data,
+		 fscache_io_terminated_t term_func,
+		 void *term_func_priv)
+{
+	const struct fscache_op_ops *ops = fscache_operation_valid(opr);
+	return ops->read(opr, start_pos, iter, seek_data,
+			 term_func, term_func_priv);
+}
+
+/**
+ * fscache_write - Start a write to the cache.
+ * @opr: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The data to write - and also the length
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a write to the cache.  @opr indicates the cache object to write to and
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
+int fscache_write(struct fscache_op_resources *opr,
+		 loff_t start_pos,
+		 struct iov_iter *iter,
+		 fscache_io_terminated_t term_func,
+		 void *term_func_priv)
+{
+	const struct fscache_op_ops *ops = fscache_operation_valid(opr);
+	return ops->write(opr, start_pos, iter, term_func, term_func_priv);
+}
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 4fedc2e9c428..0aa3f3126f6e 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -39,6 +39,7 @@ enum cachefiles_obj_ref_trace {
 	EM(fscache_obj_get_attach,		"GET attach")		\
 	EM(fscache_obj_get_exists,		"GET exists")		\
 	EM(fscache_obj_get_inval,		"GET inval")		\
+	EM(fscache_obj_get_ioreq,		"GET ioreq")		\
 	EM(fscache_obj_get_wait,		"GET wait")		\
 	EM(fscache_obj_get_withdraw,		"GET withdraw")		\
 	EM(fscache_obj_new,			"NEW obj")		\
@@ -49,6 +50,7 @@ enum cachefiles_obj_ref_trace {
 	EM(fscache_obj_put_drop_child,		"PUT drop_child")	\
 	EM(fscache_obj_put_drop_obj,		"PUT drop_obj")		\
 	EM(fscache_obj_put_inval,		"PUT inval")		\
+	EM(fscache_obj_put_ioreq,		"PUT ioreq")		\
 	EM(fscache_obj_put_withdraw,		"PUT withdraw")		\
 	EM(fscache_obj_put_lookup_fail,		"PUT lookup_fail")	\
 	EM(cachefiles_obj_put_wait_retry,	"PUT wait_retry")	\
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 0794900b7ab9..2edf74c40e83 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -51,12 +51,14 @@ enum fscache_cookie_trace {
 	EM(fscache_cookie_get_acquire_parent,	"GET paren")		\
 	EM(fscache_cookie_get_attach_object,	"GET attch")		\
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_cookie_get_ioreq,		"GET ioreq")		\
 	EM(fscache_cookie_get_register_netfs,	"GET rgstr")		\
 	EM(fscache_cookie_get_work,		"GET work ")		\
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cookie_new_netfs,		"NEW netfs")		\
 	EM(fscache_cookie_put_dup_netfs,	"PUT dupnf")		\
 	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_cookie_put_ioreq,		"PUT ioreq")		\
 	EM(fscache_cookie_put_object,		"PUT obj  ")		\
 	EM(fscache_cookie_put_parent,		"PUT paren")		\
 	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\


