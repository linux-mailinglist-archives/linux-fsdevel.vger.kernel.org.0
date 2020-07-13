Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1225F21DC75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgGMQcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:32:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729751AbgGMQcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6wJEF6h9RyZlI1lvZu1g53t5XRJdv+VdZXfwMx2rgA=;
        b=UPKfYxcEjyLi92Vzn4BKF9vqFtddRr3btE7i/lTSITK8CoABqu7Ij34T3zQTiA8pncQiS5
        dWQ5P0dxatq6UcCybXCMa0e4/trsGhIdw02CqdISyrMAOuVT/Brd1Bckt0YdVFXYseak8U
        0KHXoogpszdM8DhIzbqEN21hXcC3trI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-iNjn9-t1P7aRbJc_SOSc0w-1; Mon, 13 Jul 2020 12:32:28 -0400
X-MC-Unique: iNjn9-t1P7aRbJc_SOSc0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2811B107ACCA;
        Mon, 13 Jul 2020 16:32:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABDCF5C1D0;
        Mon, 13 Jul 2020 16:32:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/32] fscache: Rewrite the I/O API based on iov_iter
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:32:19 +0100
Message-ID: <159465793995.1376674.8648007758551605034.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
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
 fs/fscache/io.c                   |  170 +++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h     |   28 +++++
 include/linux/fscache.h           |  201 +++++++++++++++++++++++++++++++++++++
 include/trace/events/cachefiles.h |    2 
 5 files changed, 402 insertions(+)
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
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
new file mode 100644
index 000000000000..8d7f79551699
--- /dev/null
+++ b/fs/fscache/io.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Data I/O routines
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
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
+ * Initialise an I/O request
+ */
+void __fscache_init_io_request(struct fscache_io_request *req,
+			       struct fscache_cookie *cookie)
+{
+	req->cookie = fscache_cookie_get(cookie, fscache_cookie_get_ioreq);
+}
+EXPORT_SYMBOL(__fscache_init_io_request);
+
+/*
+ * Clean up an I/O request
+ */
+void __fscache_free_io_request(struct fscache_io_request *req)
+{
+	if (req->object)
+		req->object->cache->ops->put_object(req->object,
+						    fscache_obj_put_ioreq);
+	fscache_cookie_put(req->cookie, fscache_cookie_put_ioreq);
+}
+EXPORT_SYMBOL(__fscache_free_io_request);
+
+enum fscache_want_stage {
+	FSCACHE_WANT_PARAMS,
+	FSCACHE_WANT_WRITE,
+	FSCACHE_WANT_READ,
+};
+
+/*
+ * Begin an I/O operation on the cache, waiting till we reach the right state.
+ *
+ * Returns a pointer to the object to use or an error.  If an object is
+ * returned, it will have an extra ref on it.
+ */
+static struct fscache_object *fscache_begin_io_operation(
+	struct fscache_cookie *cookie,
+	enum fscache_want_stage want,
+	struct fscache_io_request *req)
+{
+	struct fscache_object *object;
+	enum fscache_cookie_stage stage;
+
+again:
+	spin_lock(&cookie->lock);
+
+	stage = cookie->stage;
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+	case FSCACHE_COOKIE_STAGE_DEAD:
+		goto not_live;
+	case FSCACHE_COOKIE_STAGE_INITIALISING:
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		goto wait_and_validate;
+
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+		if (want == FSCACHE_WANT_READ)
+			goto no_data_yet;
+		/* Fall through */
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	}
+
+ready:
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+
+	if (fscache_cache_is_broken(object))
+		goto not_live;
+
+	object->cache->ops->grab_object(object, fscache_obj_get_ioreq);
+
+	atomic_inc(&cookie->n_ops);
+	spin_unlock(&cookie->lock);
+	return object;
+
+wait_and_validate:
+	spin_unlock(&cookie->lock);
+	wait_var_event(&cookie->stage, cookie->stage != stage);
+	if (req &&
+	    req->ops->is_still_valid &&
+	    !req->ops->is_still_valid(req)) {
+		_leave(" = -ESTALE");
+		return ERR_PTR(-ESTALE);
+	}
+	goto again;
+
+no_data_yet:
+	spin_unlock(&cookie->lock);
+	_leave(" = -ENODATA");
+	return ERR_PTR(-ENODATA);
+
+not_live:
+	spin_unlock(&cookie->lock);
+	_leave(" = -ENOBUFS");
+	return ERR_PTR(-ENOBUFS);
+}
+
+/*
+ * Determine the size of an allocation granule or a region of data in the
+ * cache.
+ */
+void __fscache_shape_request(struct fscache_cookie *cookie,
+			     struct fscache_request_shape *shape)
+{
+	struct fscache_object *object =
+		fscache_begin_io_operation(cookie, FSCACHE_WANT_PARAMS, NULL);
+
+	if (!IS_ERR(object)) {
+		object->cache->ops->shape_request(object, shape);
+		object->cache->ops->put_object(object, fscache_obj_put_ioreq);
+		fscache_end_io_operation(cookie);
+	}
+}
+EXPORT_SYMBOL(__fscache_shape_request);
+
+/*
+ * Read data from the cache.
+ */
+int __fscache_read(struct fscache_io_request *req, struct iov_iter *iter)
+{
+	struct fscache_object *object =
+		fscache_begin_io_operation(req->cookie, FSCACHE_WANT_READ, req);
+
+	if (!IS_ERR(object)) {
+		req->object = object;
+		return object->cache->ops->read(object, req, iter);
+	} else {
+		req->error = PTR_ERR(object);
+		if (req->io_done)
+			req->io_done(req);
+		return req->error;
+	}
+}
+EXPORT_SYMBOL(__fscache_read);
+
+/*
+ * Write data to the cache.
+ */
+int __fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
+{
+	struct fscache_object *object =
+		fscache_begin_io_operation(req->cookie, FSCACHE_WANT_WRITE, req);
+
+	if (!IS_ERR(object)) {
+		req->object = object;
+		return object->cache->ops->write(object, req, iter);
+	} else {
+		req->error = PTR_ERR(object);
+		if (req->io_done)
+			req->io_done(req);
+		return req->error;
+	}
+}
+EXPORT_SYMBOL(__fscache_write);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index de1cffb2558e..81a41e37f07b 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -22,11 +22,13 @@
 struct fscache_cache;
 struct fscache_cache_ops;
 struct fscache_object;
+struct fscache_io_operations;
 
 enum fscache_obj_ref_trace {
 	fscache_obj_get_attach,
 	fscache_obj_get_exists,
 	fscache_obj_get_inval,
+	fscache_obj_get_ioreq,
 	fscache_obj_get_wait,
 	fscache_obj_get_withdraw,
 	fscache_obj_new,
@@ -37,6 +39,7 @@ enum fscache_obj_ref_trace {
 	fscache_obj_put_drop_child,
 	fscache_obj_put_drop_obj,
 	fscache_obj_put_inval,
+	fscache_obj_put_ioreq,
 	fscache_obj_put_lookup_fail,
 	fscache_obj_put_withdraw,
 	fscache_obj_ref__nr_traces
@@ -134,6 +137,20 @@ struct fscache_cache_ops {
 
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+
+	/* Shape the extent of a read or write */
+	void (*shape_request)(struct fscache_object *object,
+			      struct fscache_request_shape *shape);
+
+	/* Read data from the cache */
+	int (*read)(struct fscache_object *object,
+		    struct fscache_io_request *req,
+		    struct iov_iter *iter);
+
+	/* Write data to the cache */
+	int (*write)(struct fscache_object *object,
+		     struct fscache_io_request *req,
+		     struct iov_iter *iter);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
@@ -239,4 +256,15 @@ static inline void fscache_end_io_operation(struct fscache_cookie *cookie)
 		wake_up_var(&cookie->n_ops);
 }
 
+static inline void fscache_get_io_request(struct fscache_io_request *req)
+{
+	req->ops->get(req);
+}
+
+static inline void fscache_put_io_request(struct fscache_io_request *req)
+{
+	if (req)
+		req->ops->put(req);
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 11b18761a3b6..aec75fc0d297 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -42,9 +42,11 @@
 /* pattern used to fill dead space in an index entry */
 #define FSCACHE_INDEX_DEADFILL_PATTERN 0x79
 
+struct iov_iter;
 struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
+struct fscache_io_request_ops;
 
 enum fscache_cookie_type {
 	FSCACHE_COOKIE_TYPE_INDEX,
@@ -122,6 +124,73 @@ struct fscache_cookie {
 	};
 };
 
+/*
+ * The size and shape of a request to the cache, adjusted for cache
+ * granularity, for the data available on doing a read, the page size and
+ * non-contiguities and for the netfs's own I/O patterning.
+ *
+ * Before calling fscache_shape_request(), @proposed_start and @proposed_end
+ * must be set to indicate the bounds of the request and @max_io_pages to the
+ * limit the netfs is willing to accept on the size of an I/O operation.
+ * @i_size should be set to the size the file should be considered to be and
+ * @for_write should be set if a write request is being shaped.
+ *
+ * After shaping, @actual_start and @actual_end will mark out the size of the
+ * shaped request.  @granularity will convey the size a the cache block, should
+ * the request need to be reduced in scope, either due to memory constraints or
+ * netfs I/O constraints.  @dio_block_size will be set to the direct I/O size
+ * for the cache - fscache_read/write() can't be expected read/write chunks
+ * smaller than this or at positions that aren't aligned to this.
+ *
+ * Finally, @to_be_done will be set by the shaper to indicate whether the
+ * region can be read from the cache or filled with zeros and whether it should
+ * be written to the cache after being read from the server or cleared.
+ */
+struct fscache_request_shape {
+	/* Parameters */
+	loff_t		i_size;		/* The file size to use in calculations */
+	pgoff_t		proposed_start;	/* First page in the proposed request */
+	unsigned int	proposed_nr_pages; /* Number of pages in the proposed request */
+	unsigned int	max_io_pages;	/* Max pages in a netfs I/O request (or UINT_MAX) */
+	bool		for_write;	/* Set if shaping a write */
+
+	/* Result */
+#define FSCACHE_READ_FROM_SERVER 0x00
+#define FSCACHE_READ_FROM_CACHE	0x01
+#define FSCACHE_WRITE_TO_CACHE	0x02
+#define FSCACHE_FILL_WITH_ZERO	0x04
+	unsigned int	to_be_done;	/* What should be done by the caller */
+	unsigned int	granularity;	/* Cache granularity in pages */
+	unsigned int	dio_block_size;	/* Block size required for direct I/O */
+	unsigned int	actual_nr_pages; /* Number of pages in the shaped request */
+	pgoff_t		actual_start;	/* First page in the shaped request */
+};
+
+/*
+ * Descriptor for an fscache I/O request.
+ */
+struct fscache_io_request {
+	const struct fscache_io_request_ops *ops;
+	struct fscache_cookie	*cookie;
+	struct fscache_object	*object;
+	loff_t			pos;		/* Where to start the I/O */
+	loff_t			len;		/* Size of the I/O */
+	loff_t			transferred;	/* Amount of data transferred */
+	short			error;		/* 0 or error that occurred */
+	unsigned long		flags;
+#define FSCACHE_IO_DATA_FROM_SERVER	0	/* Set if data was read from server */
+#define FSCACHE_IO_DATA_FROM_CACHE	1	/* Set if data was read from the cache */
+	void (*io_done)(struct fscache_io_request *);
+};
+
+struct fscache_io_request_ops {
+	bool (*is_still_valid)(struct fscache_io_request *);
+	void (*issue_op)(struct fscache_io_request *);
+	void (*done)(struct fscache_io_request *);
+	void (*get)(struct fscache_io_request *);
+	void (*put)(struct fscache_io_request *);
+};
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
@@ -149,6 +218,12 @@ extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
+extern void __fscache_shape_request(struct fscache_cookie *, struct fscache_request_shape *);
+extern void __fscache_init_io_request(struct fscache_io_request *,
+				      struct fscache_cookie *);
+extern void __fscache_free_io_request(struct fscache_io_request *);
+extern int __fscache_read(struct fscache_io_request *, struct iov_iter *);
+extern int __fscache_write(struct fscache_io_request *, struct iov_iter *);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
@@ -407,4 +482,130 @@ void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
 		__fscache_wait_on_invalidate(cookie);
 }
 
+/**
+ * fscache_init_io_request - Initialise an I/O request
+ * @req: The I/O request to initialise
+ * @cookie: The I/O cookie to access
+ * @ops: The operations table to set
+ */
+static inline void fscache_init_io_request(struct fscache_io_request *req,
+					   struct fscache_cookie *cookie,
+					   const struct fscache_io_request_ops *ops)
+{
+	req->ops = ops;
+	if (fscache_cookie_valid(cookie))
+		__fscache_init_io_request(req, cookie);
+}
+
+/**
+ * fscache_free_io_request - Clean up an I/O request
+ * @req: The I/O request to clean
+ */
+static inline
+void fscache_free_io_request(struct fscache_io_request *req)
+{
+	if (req->cookie)
+		__fscache_free_io_request(req);
+}
+
+/**
+ * fscache_shape_request - Shape an request to fit cache granulation
+ * @cookie: The cache cookie to access
+ * @shape: The request proposed by the VM/filesystem (gets modified).
+ *
+ * Shape the size and position of a cache I/O request such that either the
+ * region will entirely be read from the server or entirely read from the
+ * cache.  The proposed region may be adjusted by a combination of extending
+ * the front forward and/or extending or shrinking the end.  In any case, the
+ * first page of the proposed request will be contained in the revised extent.
+ *
+ * The function sets shape->to_be_done to FSCACHE_READ_FROM_CACHE to indicate
+ * that the data is resident in the cache and can be read from there,
+ * FSCACHE_WRITE_TO_CACHE to indicate that the data isn't present, but the
+ * netfs should write it, FSCACHE_FILL_WITH_ZERO to indicate that the data
+ * should be all zeros on the server and can just be fabricated locally or
+ * FSCACHE_READ_FROM_SERVER to indicate that there's no cache or an error
+ * occurred and the netfs should just read from the server.
+ */
+static inline
+void fscache_shape_request(struct fscache_cookie *cookie,
+			   struct fscache_request_shape *shape)
+{
+	shape->to_be_done	= FSCACHE_READ_FROM_SERVER;
+	shape->granularity	= 1;
+	shape->dio_block_size	= 1;
+	shape->actual_nr_pages	= shape->proposed_nr_pages;
+	shape->actual_start	= shape->proposed_start;
+
+	if (fscache_cookie_valid(cookie))
+		__fscache_shape_request(cookie, shape);
+}
+
+/**
+ * fscache_read - Read data from the cache.
+ * @req: The I/O request descriptor
+ * @iter: The buffer to read into
+ *
+ * The cache will attempt to read from the object referred to by the cookie,
+ * using the size and position described in the request.  The data will be
+ * transferred to the buffer described by the iterator specified in the request.
+ *
+ * If this fails or can't be done, an error will be set in the request
+ * descriptor and the netfs must reissue the read to the server.
+ *
+ * Note that the length and position of the request should be aligned to the DIO
+ * block size returned by fscache_shape_request().
+ *
+ * If req->done is set, the request will be submitted as asynchronous I/O and
+ * -EIOCBQUEUED may be returned to indicate that the operation is in progress.
+ * The done function will be called when the operation is concluded either way.
+ *
+ * If req->done is not set, the request will be submitted as synchronous I/O and
+ * will be completed before the function returns.
+ */
+static inline
+int fscache_read(struct fscache_io_request *req, struct iov_iter *iter)
+{
+	if (fscache_cookie_valid(req->cookie))
+		return __fscache_read(req, iter);
+	req->error = -ENODATA;
+	if (req->io_done)
+		req->io_done(req);
+	return -ENODATA;
+}
+
+
+/**
+ * fscache_write - Write data to the cache.
+ * @req: The I/O request description
+ * @iter: The data to write
+ *
+ * The cache will attempt to write to the object referred to by the cookie,
+ * using the size and position described in the request.  The data will be
+ * transferred from the iterator specified in the request.
+ *
+ * If this fails or can't be done, an error will be set in the request
+ * descriptor.
+ *
+ * Note that the length and position of the request should be aligned to the DIO
+ * block size returned by fscache_shape_request().
+ *
+ * If req->io_done is set, the request will be submitted as asynchronous I/O and
+ * -EIOCBQUEUED may be returned to indicate that the operation is in progress.
+ * The done function will be called when the operation is concluded either way.
+ *
+ * If req->io_done is not set, the request will be submitted as synchronous I/O and
+ * will be completed before the function returns.
+ */
+static inline
+int fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
+{
+	if (fscache_cookie_valid(req->cookie))
+		return __fscache_write(req, iter);
+	req->error = -ENOBUFS;
+	if (req->io_done)
+		req->io_done(req);
+	return -ENOBUFS;
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


