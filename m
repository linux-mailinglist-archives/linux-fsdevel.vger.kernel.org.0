Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F11C414F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgEDRLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:11:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22421 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbgEDRLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6INEmDY18T/wFHsp23tCqTOVWy7CNMLePqtGB2ROnk=;
        b=Lsb90AXDIGiqtiIS1qv0X629H8Wk+98dBAx+OEaBe4KBOFH/pc45EezScpfTACv0QZ6Nz1
        +006cixDTJLDbmZTkSa7JZEqsTUW9cwtZqGfo6mxfAMwuJO8HBpVSog9ihOTnDVePWtvPz
        MbiVSUmEBKZ45Zcr2jilTJh7BK+aUlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-KxjhO_ecPhmOOWixrIs2pQ-1; Mon, 04 May 2020 13:11:04 -0400
X-MC-Unique: KxjhO_ecPhmOOWixrIs2pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB870107ACCA;
        Mon,  4 May 2020 17:11:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 248C95D9D3;
        Mon,  4 May 2020 17:10:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 23/61] fscache: Rewrite the I/O API based on iov_iter
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:10:59 +0100
Message-ID: <158861225931.340223.8007166887971855106.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

	struct fscache_extent {
		pgoff_t		start;
		pgoff_t		block_end;
		pgoff_t		limit;
		unsigned int	dio_block_size;
	};

and then it calls:

	unsigned int
	fscache_shape_extent(struct fscache_cookie *cookie,
			     struct fscache_extent *extent,
			     loff_t i_size, bool for_write);

to shape it.

The netfs should set 'start' to be the first page to read, 'block_end' to
be last page in the proposed read + 1 and 'limit' to be or ULONG_MAX or the
point beyond which the read cannot be extended.  'dio_block_size' should be
set to 0.

The cache will then shape the proposed read to fit a blocking factor
appropriate for the cache object and region of the file.  It may extend
start forward and may shrink or extend block_end to fit the granularity of
the cache.  This will be trimmed to the end of file as specified by the
'i_size' parameter.

Upon return, 'start' and 'limit' in the fscache_extent struct will be
updated to indicate the cache's idea of the desired size and position of
the operation.  'block_end' will hold the minimum size that will satisfy
the cache.  Note that the shaped extent will always include the start page.

'dio_block_size' will be set to whatever I/O size the cache must
communicate with its storage in.  This is necessary to set up the iov_iter
to be passed to the cache for reading and writing so that it can do direct
I/O.

The return value of fscache_shape_extent() is a bitmask, with
FSCACHE_READ_FROM_CACHE indicating that the cache shaped extent should be
read from the cache and FSCACHE_WRITE_TO_CACHE indicating that the data
should be written to the cache after it has been fetched.

Once the netfs has set up its iterator, if FSCACHE_READ_FROM_CACHE was
returned, it should then call:

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
 fs/fscache/io.c                   |  173 ++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h     |   29 ++++++
 include/linux/fscache.h           |  179 +++++++++++++++++++++++++++++++++++++
 include/trace/events/cachefiles.h |    2 
 5 files changed, 384 insertions(+)
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
index 000000000000..0cea98bbb8ad
--- /dev/null
+++ b/fs/fscache/io.c
@@ -0,0 +1,173 @@
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
+unsigned int __fscache_shape_extent(struct fscache_cookie *cookie,
+				    struct fscache_extent *extent,
+				    loff_t i_size, bool for_write)
+{
+	struct fscache_object *object =
+		fscache_begin_io_operation(cookie, FSCACHE_WANT_PARAMS, NULL);
+	unsigned int ret = 0;
+
+	if (!IS_ERR(object)) {
+		ret = object->cache->ops->shape_extent(object, extent, i_size, for_write);
+		object->cache->ops->put_object(object, fscache_obj_put_ioreq);
+		fscache_end_io_operation(cookie);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_shape_extent);
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
index fbf1b60149aa..1d235072239d 100644
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
@@ -134,6 +137,21 @@ struct fscache_cache_ops {
 
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+
+	/* Shape the extent of a read or write */
+	unsigned int (*shape_extent)(struct fscache_object *object,
+				     struct fscache_extent *extent,
+				     loff_t i_size, bool for_write);
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
@@ -239,4 +257,15 @@ static inline void fscache_end_io_operation(struct fscache_cookie *cookie)
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
index e4fe28cfdf5c..98a6bd668f48 100644
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
@@ -122,6 +124,44 @@ struct fscache_cookie {
 	};
 };
 
+/*
+ * The extent of the allocation granule in the cache, modulated for the
+ * available data on doing a read, the page size and non-contiguities.
+ *
+ * This also includes the block size to which I/O requests must be aligned.
+ */
+struct fscache_extent {
+	pgoff_t		start;		/* First page in the extent */
+	pgoff_t		block_end;	/* End of first block */
+	pgoff_t		limit;		/* Limit of extent (or ULONG_MAX) */
+	unsigned int	dio_block_size;	/* Block size required for direct I/O */
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
@@ -149,6 +189,14 @@ extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
+extern unsigned int __fscache_shape_extent(struct fscache_cookie *,
+					   struct fscache_extent *,
+					   loff_t, bool);
+extern void __fscache_init_io_request(struct fscache_io_request *,
+				      struct fscache_cookie *);
+extern void __fscache_free_io_request(struct fscache_io_request *);
+extern int __fscache_read(struct fscache_io_request *, struct iov_iter *);
+extern int __fscache_write(struct fscache_io_request *, struct iov_iter *);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
@@ -407,4 +455,135 @@ void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
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
+#define FSCACHE_READ_FROM_CACHE	0x01
+#define FSCACHE_WRITE_TO_CACHE	0x02
+#define FSCACHE_FILL_WITH_ZERO	0x04
+
+/**
+ * fscache_shape_extent - Shape an extent to fit cache granulation
+ * @cookie: The cache cookie to access
+ * @extent: The extent proposed by the VM/filesystem and the reply.
+ * @i_size: The size to consider the file to be.
+ * @for_write: If the determination is for a write.
+ *
+ * Determine the size and position of the extent that will cover the first page
+ * in the cache such that either that extent will entirely be read from the
+ * server or entirely read from the cache.  The provided extent may be
+ * adjusted, by a combination of extending the front of the extent forward
+ * and/or extending or shrinking the end of the extent.  In any case, the
+ * starting page of the proposed extent will be contained in the revised
+ * extent.
+ *
+ * The function returns FSCACHE_READ_FROM_CACHE to indicate that the data is
+ * resident in the cache and can be read from there, FSCACHE_WRITE_TO_CACHE to
+ * indicate that the data isn't present, but the netfs should write it,
+ * FSCACHE_FILL_WITH_ZERO to indicate that the data should be all zeros on the
+ * server and can just be fabricated locally in or 0 to indicate that there's
+ * no cache or an error occurred and the netfs should just read from the
+ * server.
+ */
+static inline
+unsigned int fscache_shape_extent(struct fscache_cookie *cookie,
+				  struct fscache_extent *extent,
+				  loff_t i_size, bool for_write)
+{
+	if (fscache_cookie_valid(cookie))
+		return __fscache_shape_extent(cookie, extent, i_size,
+					      for_write);
+	return 0;
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
+ * block size returned by fscache_shape_extent().
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
+ * block size returned by fscache_shape_extent().
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


