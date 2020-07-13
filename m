Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630FB21DCE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgGMQfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:35:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730381AbgGMQfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHC4V3SNcNWEeoqr0+yZp8TAkthvX50zruMsPOPj7go=;
        b=UMpEBDQq4B6DvtdC10zRQfHL1uUErlxHNmj4IsDXM012zZaMSoD/mvW+zJWVtuBHXV8LC5
        YzG7fYtOzBLEvS6azP8xTFQFt9ldFjlqO99A3+pLxCaclvcbXB2frzu9BFcBlBfMuUQ4f3
        x/jqSPPmgYWH+lKEcc4LwZx8jfM5XbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-q2J_Mu_0PfeF9CIG-wJgyA-1; Mon, 13 Jul 2020 12:35:17 -0400
X-MC-Unique: q2J_Mu_0PfeF9CIG-wJgyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E038015CB;
        Mon, 13 Jul 2020 16:35:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE0A6FDD1;
        Mon, 13 Jul 2020 16:35:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/32] fscache: Add read helper
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
Date:   Mon, 13 Jul 2020 17:35:08 +0100
Message-ID: <159465810864.1376674.10267227421160756746.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a trio of helper functions:

	fscache_read_helper_page_list();
	fscache_read_helper_locked_page();
	fscache_read_helper_for_write();

to do the work of shaping read requests, attempting to read from the cache,
issuing or reissuing requests to the filesystem to pass to the server and
writing back to the filesystem.

The filesystem passes in a prepared request descriptor with the fscache
descriptor embedded in it to one of the helper functions.  The caller also
indicates which page(s) it is interested in and provides some operations to
issue reads and manage the request descriptor.

The helper is placed into its own module, fsinfo_support.ko, which must be
enabled unconditionally by any filesystem which wishes to use the helper
even if CONFIG_FSCACHE=no.  This module is selected by
CONFIG_FSCACHE_SUPPORT.  About half of the code is optimised away by
CONFIG_FSCACHE=no.

Also add a tracepoint to track calls.  A set of 'notes' are taken to record
the path through the function and this is dumped into the trace.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/Makefile                            |    2 
 fs/fscache/Kconfig                     |    4 
 fs/fscache/Makefile                    |    3 
 fs/fscache/internal.h                  |    8 
 fs/fscache/main.c                      |    1 
 fs/fscache/read_helper.c               |  656 ++++++++++++++++++++++++++++++++
 include/linux/fscache.h                |   26 +
 include/trace/events/fscache_support.h |   91 ++++
 8 files changed, 789 insertions(+), 2 deletions(-)
 create mode 100644 fs/fscache/read_helper.c
 create mode 100644 include/trace/events/fscache_support.h

diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..8b0a5b5b1d86 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_PROFILING)		+= dcookies.o
 obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
-obj-$(CONFIG_FSCACHE)		+= fscache/
+obj-$(CONFIG_FSCACHE_SUPPORT)	+= fscache/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
 # We place ext4 before ext2 so that clean ext3 root fs's do NOT mount using the
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index ce6f731065d0..369c12ef0167 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -1,7 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config FSCACHE_SUPPORT
+	tristate "Support for local caching of network filesystems"
+
 config FSCACHE
 	tristate "General filesystem local caching manager"
+	depends on FSCACHE_SUPPORT
 	help
 	  This option enables a generic filesystem caching manager that can be
 	  used by various network and other filesystems to cache data locally.
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 3caf66810e7b..0a5c8c654942 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -20,3 +20,6 @@ fscache-$(CONFIG_FSCACHE_HISTOGRAM) += histogram.o
 fscache-$(CONFIG_FSCACHE_OBJECT_LIST) += object-list.o
 
 obj-$(CONFIG_FSCACHE) := fscache.o
+
+fscache_support-y := read_helper.o
+obj-$(CONFIG_FSCACHE_SUPPORT) += fscache_support.o
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index a70c1a612309..2674438ccafd 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -30,6 +30,8 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
+#if IS_ENABLED(CONFIG_FSCACHE)
+
 #define FSCACHE_MIN_THREADS	4
 #define FSCACHE_MAX_THREADS	32
 
@@ -266,6 +268,12 @@ void fscache_update_aux(struct fscache_cookie *cookie,
 		cookie->object_size = *object_size;
 }
 
+#else /* CONFIG_FSCACHE */
+
+#define fscache_op_wq system_wq
+
+#endif /* CONFIG_FSCACHE */
+
 /*****************************************************************************/
 /*
  * debug tracing
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index b2691439377b..ac4fd4d59479 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -39,6 +39,7 @@ MODULE_PARM_DESC(fscache_debug,
 
 struct kobject *fscache_root;
 struct workqueue_struct *fscache_op_wq;
+EXPORT_SYMBOL(fscache_op_wq);
 
 /* these values serve as lower bounds, will be adjusted in fscache_init() */
 static unsigned fscache_object_max_active = 4;
diff --git a/fs/fscache/read_helper.c b/fs/fscache/read_helper.c
new file mode 100644
index 000000000000..62fed27aa938
--- /dev/null
+++ b/fs/fscache/read_helper.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Read helper.
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/fscache-cache.h>
+#include "internal.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/fscache_support.h>
+
+MODULE_DESCRIPTION("FS Cache Manager Support");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+#define FSCACHE_RHLP_NOTE_READ_FROM_CACHE	FSCACHE_READ_FROM_CACHE
+#define FSCACHE_RHLP_NOTE_WRITE_TO_CACHE	FSCACHE_WRITE_TO_CACHE
+#define FSCACHE_RHLP_NOTE_FILL_WITH_ZERO	FSCACHE_FILL_WITH_ZERO
+#define FSCACHE_RHLP_NOTE_READ_FOR_WRITE	0x00000100 /* Type: FSCACHE_READ_FOR_WRITE */
+#define FSCACHE_RHLP_NOTE_READ_LOCKED_PAGE	0x00000200 /* Type: FSCACHE_READ_LOCKED_PAGE */
+#define FSCACHE_RHLP_NOTE_READ_PAGE_LIST	0x00000300 /* Type: FSCACHE_READ_PAGE_LIST */
+#define FSCACHE_RHLP_NOTE_LIST_NOMEM		0x00001000 /* Page list: ENOMEM */
+#define FSCACHE_RHLP_NOTE_LIST_U2D		0x00002000 /* Page list: page uptodate */
+#define FSCACHE_RHLP_NOTE_LIST_ERROR		0x00004000 /* Page list: add error */
+#define FSCACHE_RHLP_NOTE_TRAILER_ADD		0x00010000 /* Trailer: Creating */
+#define FSCACHE_RHLP_NOTE_TRAILER_NOMEM		0x00020000 /* Trailer: ENOMEM */
+#define FSCACHE_RHLP_NOTE_TRAILER_U2D		0x00040000 /* Trailer: Uptodate */
+#define FSCACHE_RHLP_NOTE_U2D_IN_PREFACE	0x00100000 /* Uptodate page in preface */
+#define FSCACHE_RHLP_NOTE_UNDERSIZED		0x00200000 /* Undersized block */
+#define FSCACHE_RHLP_NOTE_AFTER_EOF		0x00400000 /* After EOF */
+#define FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE	0x00800000 /* Actually write to the cache */
+#define FSCACHE_RHLP_NOTE_CANCELLED		0x80000000 /* Operation cancelled by netfs */
+
+unsigned fscache_rh_debug;
+module_param_named(debug, fscache_rh_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(fscache_rh_debug, "FS-Cache read helper debugging mask");
+#define fscache_debug fscache_rh_debug
+
+enum fscache_read_type {
+	FSCACHE_READ_PAGE_LIST,		/* Read the list of pages (readpages) */
+	FSCACHE_READ_LOCKED_PAGE,	/* requested_page is added and locked */
+	FSCACHE_READ_FOR_WRITE,		/* This read is a prelude to write_begin */
+};
+
+static void fscache_read_from_server(struct fscache_io_request *req)
+{
+	req->ops->issue_op(req);
+}
+
+/*
+ * Deal with the completion of writing the data to the cache.  We have to clear
+ * the PG_fscache bits on the pages involved and releases the caller's ref.
+ */
+static void fscache_read_copy_done(struct fscache_io_request *req)
+{
+	struct page *page;
+	pgoff_t index = req->pos >> PAGE_SHIFT;
+	pgoff_t last = index + req->nr_pages - 1;
+
+	XA_STATE(xas, &req->mapping->i_pages, index);
+
+	_enter("%lx,%x,%llx", index, req->nr_pages, req->transferred);
+
+	/* Clear PG_fscache on the pages that were being written out. */
+	rcu_read_lock();
+	xas_for_each(&xas, page, last) {
+		BUG_ON(xa_is_value(page));
+		BUG_ON(PageCompound(page));
+
+		unlock_page_fscache(page);
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * Write a completed read request to the cache.
+ */
+static void fscache_do_read_copy_to_cache(struct work_struct *work)
+{
+	struct fscache_io_request *req =
+		container_of(work, struct fscache_io_request, work);
+	struct iov_iter iter;
+
+	_enter("");
+
+	iov_iter_mapping(&iter, WRITE, req->mapping, req->pos,
+			 round_up(req->len, req->dio_block_size));
+
+	req->io_done = fscache_read_copy_done;
+	fscache_write(req, &iter);
+	fscache_put_io_request(req);
+}
+
+static void fscache_read_copy_to_cache(struct fscache_io_request *req)
+{
+	fscache_get_io_request(req);
+
+	if (!in_softirq())
+		return fscache_do_read_copy_to_cache(&req->work);
+
+	BUG_ON(work_pending(&req->work));
+	INIT_WORK(&req->work, fscache_do_read_copy_to_cache);
+	if (!queue_work(fscache_op_wq, &req->work))
+		BUG();
+}
+
+/*
+ * Clear the unread part of the file on a short read.
+ */
+static void fscache_clear_unread(struct fscache_io_request *req)
+{
+	struct iov_iter iter;
+
+	iov_iter_mapping(&iter, WRITE, req->mapping,
+			 req->pos + req->transferred,
+			 req->len - req->transferred);
+
+	_debug("clear %zx @%llx", iov_iter_count(&iter), iter.mapping_start);
+
+	iov_iter_zero(iov_iter_count(&iter), &iter);
+}
+
+/*
+ * Handle completion of a read operation.  This may be called in softirq
+ * context.
+ */
+static void fscache_read_done(struct fscache_io_request *req)
+{
+	struct page *page;
+	pgoff_t start = req->pos >> PAGE_SHIFT;
+	pgoff_t last = start + req->nr_pages - 1;
+
+	XA_STATE(xas, &req->mapping->i_pages, start);
+
+	_enter("%lx,%x,%llx,%d",
+	       start, req->nr_pages, req->transferred, req->error);
+
+	if (req->transferred < req->len)
+		fscache_clear_unread(req);
+
+	if (!test_bit(FSCACHE_IO_DONT_UNLOCK_PAGES, &req->flags)) {
+		rcu_read_lock();
+		xas_for_each(&xas, page, last) {
+			if (test_bit(FSCACHE_IO_WRITE_TO_CACHE, &req->flags))
+				SetPageFsCache(page);
+			if (page == req->no_unlock_page)
+				SetPageUptodate(page);
+			else
+				page_endio(page, false, 0);
+			put_page(page);
+		}
+		rcu_read_unlock();
+	}
+
+	task_io_account_read(req->transferred);
+	req->ops->done(req);
+	if (test_and_clear_bit(FSCACHE_IO_READ_IN_PROGRESS, &req->flags))
+		wake_up_bit(&req->flags, FSCACHE_IO_READ_IN_PROGRESS);
+
+	if (test_bit(FSCACHE_IO_WRITE_TO_CACHE, &req->flags))
+		fscache_read_copy_to_cache(req);
+}
+
+/*
+ * Reissue the read against the server.
+ */
+static void fscache_reissue_read(struct work_struct *work)
+{
+	struct fscache_io_request *req =
+		container_of(work, struct fscache_io_request, work);
+
+	_debug("DOWNLOAD: %llu", req->len);
+
+	req->io_done = fscache_read_done;
+	fscache_read_from_server(req);
+	fscache_put_io_request(req);
+}
+
+/*
+ * Handle completion of a read from cache operation.  If the read failed, we
+ * need to reissue the request against the server.  We might, however, be
+ * called in softirq mode and need to punt.
+ */
+static void fscache_file_read_maybe_reissue(struct fscache_io_request *req)
+{
+	_enter("%d", req->error);
+
+	if (req->error == 0) {
+		fscache_read_done(req);
+	} else {
+		INIT_WORK(&req->work, fscache_reissue_read);
+		fscache_get_io_request(req);
+		queue_work(fscache_op_wq, &req->work);
+	}
+}
+
+/*
+ * Issue a read against the cache.
+ */
+static void fscache_read_from_cache(struct fscache_io_request *req)
+{
+	struct iov_iter iter;
+
+	iov_iter_mapping(&iter, READ, req->mapping, req->pos, req->len);
+	fscache_read(req, &iter);
+}
+
+/*
+ * Discard the locks and page refs that we obtained on a sequence of pages.
+ */
+static void fscache_ignore_pages(struct address_space *mapping,
+				  pgoff_t start, pgoff_t end)
+{
+	struct page *page;
+
+	_enter("%lx,%lx", start, end);
+
+	if (end > start) {
+		XA_STATE(xas, &mapping->i_pages, start);
+
+		rcu_read_lock();
+		xas_for_each(&xas, page, end - 1) {
+			_debug("- ignore %lx", page->index);
+			BUG_ON(xa_is_value(page));
+			BUG_ON(PageCompound(page));
+
+			unlock_page(page);
+			put_page(page);
+		}
+		rcu_read_unlock();
+	}
+}
+
+/**
+ * fscache_read_helper - Helper to manage a read request
+ * @req: The initialised request structure to use
+ * @requested_page: Singular page to include (LOCKED_PAGE/FOR_WRITE)
+ * @pages: Unattached pages to include (PAGE_LIST)
+ * @page_to_be_written: The index of the primary page (FOR_WRITE)
+ * @max_pages: The maximum number of pages to read in one transaction
+ * @type: FSCACHE_READ_*
+ * @aop_flags: AOP_FLAG_*
+ *
+ * Read a sequence of pages appropriately sized for an fscache allocation
+ * block.  Pages are added at both ends and to fill in the gaps as appropriate
+ * to make it the right size.
+ *
+ * req->mapping should indicate the mapping to which the pages will be attached.
+ *
+ * The operations pointed to by req->ops will be used to issue or reissue a
+ * read against the server in case the cache is unavailable, incomplete or
+ * generates an error.  req->iter will be set up to point to the iterator
+ * representing the buffer to be filled in.
+ *
+ * A ref on @req is consumed eventually by this function or one of its
+ * eventually-dispatched callees.
+ */
+static int fscache_read_helper(struct fscache_io_request *req,
+			       struct page **requested_page,
+			       struct list_head *pages,
+			       pgoff_t page_to_be_written,
+			       pgoff_t max_pages,
+			       enum fscache_read_type type,
+			       unsigned int aop_flags)
+{
+	struct fscache_request_shape shape;
+	struct address_space *mapping = req->mapping;
+	struct page *page;
+	enum fscache_read_helper_trace what;
+	unsigned int notes;
+	pgoff_t eof, cursor, start;
+	loff_t new_size;
+	int ret;
+
+	shape.granularity	= 1;
+	shape.max_io_pages	= max_pages;
+	shape.i_size		= i_size_read(mapping->host);
+	shape.for_write		= false;
+
+	switch (type) {
+	case FSCACHE_READ_PAGE_LIST:
+		shape.proposed_start = lru_to_page(pages)->index;
+		shape.proposed_nr_pages =
+			lru_to_last_page(pages)->index - shape.proposed_start + 1;
+		break;
+
+	case FSCACHE_READ_LOCKED_PAGE:
+		shape.proposed_start = (*requested_page)->index;
+		shape.proposed_nr_pages = 1;
+		break;
+
+	case FSCACHE_READ_FOR_WRITE:
+		new_size = (loff_t)(page_to_be_written + 1) << PAGE_SHIFT;
+		if (new_size > shape.i_size)
+			shape.i_size = new_size;
+		shape.proposed_start = page_to_be_written;
+		shape.proposed_nr_pages = 1;
+		break;
+
+	default:
+		BUG();
+	}
+
+	_enter("%lx,%x", shape.proposed_start, shape.proposed_nr_pages);
+
+	eof = (shape.i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	fscache_shape_request(req->cookie, &shape);
+	if (req->ops->reshape)
+		req->ops->reshape(req, &shape);
+	notes = shape.to_be_done;
+
+	req->dio_block_size = shape.dio_block_size;
+
+	start = cursor = shape.actual_start;
+
+	/* Add pages to the pagecache.  We keep the pages ref'd and locked
+	 * until the read is complete.  We may also need to add pages to both
+	 * sides of the request to make it up to the cache allocation granule
+	 * alignment and size.
+	 *
+	 * Note that it's possible for the file size to change whilst we're
+	 * doing this, but we rely on the server returning less than we asked
+	 * for if the file shrank.  We also rely on this to deal with a partial
+	 * page at the end of the file.
+	 *
+	 * If we're going to end up loading from the server and writing to the
+	 * cache, we start by inserting blank pages before the first page being
+	 * examined.  If we can fetch from the cache or we're not going to
+	 * write to the cache, it's unnecessary.
+	 */
+	if (notes & FSCACHE_RHLP_NOTE_WRITE_TO_CACHE) {
+		notes |= FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE;
+		while (cursor < shape.proposed_start) {
+			page = find_or_create_page(mapping, cursor,
+						   readahead_gfp_mask(mapping));
+			if (!page)
+				goto nomem;
+			if (!PageUptodate(page)) {
+				req->nr_pages++; /* Add to the reading list */
+				cursor++;
+				continue;
+			}
+
+			/* There's an up-to-date page in the preface - just
+			 * fetch the requested pages and skip saving to the
+			 * cache.
+			 */
+			notes |= FSCACHE_RHLP_NOTE_U2D_IN_PREFACE;
+			notes &= ~FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE;
+			fscache_ignore_pages(mapping, start, cursor + 1);
+			start = cursor = shape.proposed_start;
+			req->nr_pages = 0;
+			break;
+		}
+		page = NULL;
+	} else {
+		notes &= ~FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE;
+		start = cursor = shape.proposed_start;
+		req->nr_pages = 0;
+	}
+
+	switch (type) {
+	case FSCACHE_READ_FOR_WRITE:
+		/* We're doing a prefetch for a write on a single page.  We get
+		 * or create the requested page if we weren't given it and lock
+		 * it.
+		 */
+		notes |= FSCACHE_RHLP_NOTE_READ_FOR_WRITE;
+		if (*requested_page) {
+			_debug("prewrite req %lx", cursor);
+			page = *requested_page;
+			ret = -ERESTARTSYS;
+			if (lock_page_killable(page) < 0)
+				goto dont;
+		} else {
+			_debug("prewrite new %lx %lx", cursor, eof);
+			page = grab_cache_page_write_begin(mapping, shape.proposed_start,
+							   aop_flags);
+			if (!page)
+				goto nomem;
+			*requested_page = page;
+		}
+
+		if (PageUptodate(page)) {
+			notes |= FSCACHE_RHLP_NOTE_LIST_U2D;
+
+			trace_fscache_read_helper(req->cookie,
+						  start, start + req->nr_pages,
+						  notes, fscache_read_helper_race);
+			req->ops->done(req);
+			ret = 0;
+			goto cancelled;
+		}
+
+		get_page(page);
+		req->no_unlock_page = page;
+		req->nr_pages++;
+		cursor++;
+		page = NULL;
+		ret = 0;
+		break;
+
+	case FSCACHE_READ_LOCKED_PAGE:
+		/* We've got a single page preattached to the inode and locked.
+		 * Get our own ref on it.
+		 */
+		_debug("locked");
+		notes |= FSCACHE_RHLP_NOTE_READ_LOCKED_PAGE;
+		get_page(*requested_page);
+		req->nr_pages++;
+		cursor++;
+		ret = 0;
+		break;
+
+	case FSCACHE_READ_PAGE_LIST:
+		/* We've been given a contiguous list of pages to add. */
+		notes |= FSCACHE_RHLP_NOTE_READ_PAGE_LIST;
+		do {
+			_debug("given %lx", cursor);
+
+			page = lru_to_page(pages);
+			if (WARN_ON(page->index != cursor))
+				break;
+
+			list_del(&page->lru);
+
+			ret = add_to_page_cache_lru(page, mapping, cursor,
+						    readahead_gfp_mask(mapping));
+			switch (ret) {
+			case 0:
+				/* Add to the reading list */
+				req->nr_pages++;
+				cursor++;
+				page = NULL;
+				break;
+
+			case -EEXIST:
+				put_page(page);
+
+				_debug("conflict %lx %d", cursor, ret);
+				page = find_or_create_page(mapping, cursor,
+							   readahead_gfp_mask(mapping));
+				if (!page) {
+					notes |= FSCACHE_RHLP_NOTE_LIST_NOMEM;
+					goto stop;
+				}
+
+				if (PageUptodate(page)) {
+					unlock_page(page);
+					put_page(page); /* Avoid overwriting */
+					ret = 0;
+					notes |= FSCACHE_RHLP_NOTE_LIST_U2D;
+					goto stop;
+				}
+
+				req->nr_pages++; /* Add to the reading list */
+				cursor++;
+				break;
+
+			default:
+				_debug("add fail %lx %d", cursor, ret);
+				put_page(page);
+				page = NULL;
+				notes |= FSCACHE_RHLP_NOTE_LIST_ERROR;
+				goto stop;
+			}
+
+			/* Trim the fetch to the cache granularity so we don't
+			 * get a chain-failure of blocks being unable to be
+			 * used because the previous uncached read spilt over.
+			 */
+			if ((notes & FSCACHE_RHLP_NOTE_U2D_IN_PREFACE) &&
+			    cursor == shape.actual_start + shape.granularity)
+				break;
+
+		} while (!list_empty(pages) && req->nr_pages < shape.actual_nr_pages);
+		ret = 0;
+		break;
+
+	default:
+		BUG();
+	}
+
+	/* If we're going to be writing to the cache, insert pages after the
+	 * requested block to make up the numbers.
+	 */
+	if (notes & FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE) {
+		notes |= FSCACHE_RHLP_NOTE_TRAILER_ADD;
+		while (req->nr_pages < shape.actual_nr_pages) {
+			_debug("after %lx", cursor);
+			page = find_or_create_page(mapping, cursor,
+						   readahead_gfp_mask(mapping));
+			if (!page) {
+				notes |= FSCACHE_RHLP_NOTE_TRAILER_NOMEM;
+				goto stop;
+			}
+			if (PageUptodate(page)) {
+				unlock_page(page);
+				put_page(page); /* Avoid overwriting */
+				notes |= FSCACHE_RHLP_NOTE_TRAILER_U2D;
+				goto stop;
+			}
+
+			req->nr_pages++; /* Add to the reading list */
+			cursor++;
+		}
+	}
+
+stop:
+	_debug("have %u", req->nr_pages);
+	if (req->nr_pages == 0)
+		goto dont;
+
+	if (cursor <= shape.proposed_start) {
+		_debug("v.short");
+		goto nomem_unlock; /* We wouldn't've included the first page */
+	}
+
+submit_anyway:
+	if ((notes & FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE) &&
+	    req->nr_pages < shape.actual_nr_pages) {
+		/* The request is short of what we need to be able to cache the
+		 * entire set of pages and the trailer, so trim it to cache
+		 * granularity if we can without reducing it to nothing.
+		 */
+		unsigned int down_to = round_down(req->nr_pages, shape.granularity);
+		_debug("short %u", down_to);
+
+		notes |= FSCACHE_RHLP_NOTE_UNDERSIZED;
+
+		if (down_to > 0) {
+			fscache_ignore_pages(mapping, shape.actual_start + down_to, cursor);
+			req->nr_pages = down_to;
+		} else {
+			notes &= ~FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE;
+		}
+	}
+
+	req->len = req->nr_pages * PAGE_SIZE;
+	req->pos = start;
+	req->pos <<= PAGE_SHIFT;
+
+	if (start >= eof) {
+		notes |= FSCACHE_RHLP_NOTE_AFTER_EOF;
+		what = fscache_read_helper_skip;
+	} else if (notes & FSCACHE_RHLP_NOTE_FILL_WITH_ZERO) {
+		what = fscache_read_helper_zero;
+	} else if (notes & FSCACHE_RHLP_NOTE_READ_FROM_CACHE) {
+		what = fscache_read_helper_read;
+	} else {
+		what = fscache_read_helper_download;
+	}
+
+	ret = 0;
+	if (req->ops->is_req_valid) {
+		/* Allow the netfs to decide if the request is still valid
+		 * after all the pages are locked.
+		 */
+		ret = req->ops->is_req_valid(req);
+		if (ret < 0)
+			notes |= FSCACHE_RHLP_NOTE_CANCELLED;
+	}
+
+	trace_fscache_read_helper(req->cookie, start, start + req->nr_pages,
+				  notes, what);
+
+	if (notes & FSCACHE_RHLP_NOTE_CANCELLED)
+		goto cancelled;
+
+	if (notes & FSCACHE_RHLP_NOTE_DO_WRITE_TO_CACHE)
+		__set_bit(FSCACHE_IO_WRITE_TO_CACHE, &req->flags);
+
+	__set_bit(FSCACHE_IO_READ_IN_PROGRESS, &req->flags);
+
+	switch (what) {
+	case fscache_read_helper_skip:
+		/* The read is entirely beyond the end of the file, so skip the
+		 * actual operation and let the done handler deal with clearing
+		 * the pages.
+		 */
+		_debug("SKIP READ: %llu", req->len);
+		fscache_read_done(req);
+		break;
+	case fscache_read_helper_zero:
+		_debug("ZERO READ: %llu", req->len);
+		fscache_read_done(req);
+		break;
+	case fscache_read_helper_read:
+		req->io_done = fscache_file_read_maybe_reissue;
+		fscache_read_from_cache(req);
+		break;
+	case fscache_read_helper_download:
+		_debug("DOWNLOAD: %llu", req->len);
+		req->io_done = fscache_read_done;
+		fscache_read_from_server(req);
+		break;
+	default:
+		BUG();
+	}
+
+	_leave(" = 0");
+	return 0;
+
+nomem:
+	if (cursor > shape.proposed_start)
+		goto submit_anyway;
+nomem_unlock:
+	ret = -ENOMEM;
+cancelled:
+	fscache_ignore_pages(mapping, start, cursor);
+dont:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+int fscache_read_helper_page_list(struct fscache_io_request *req,
+				  struct list_head *pages,
+				  pgoff_t max_pages)
+{
+	ASSERT(pages);
+	ASSERT(!list_empty(pages));
+	return fscache_read_helper(req, NULL, pages, 0, max_pages,
+				   FSCACHE_READ_PAGE_LIST, 0);
+}
+EXPORT_SYMBOL(fscache_read_helper_page_list);
+
+int fscache_read_helper_locked_page(struct fscache_io_request *req,
+				    struct page *page,
+				    pgoff_t max_pages)
+{
+	ASSERT(page);
+	return fscache_read_helper(req, &page, NULL, 0, max_pages,
+				   FSCACHE_READ_LOCKED_PAGE, 0);
+}
+EXPORT_SYMBOL(fscache_read_helper_locked_page);
+
+int fscache_read_helper_for_write(struct fscache_io_request *req,
+				  struct page **page,
+				  pgoff_t index,
+				  pgoff_t max_pages,
+				  unsigned int aop_flags)
+{
+	ASSERT(page);
+	ASSERTIF(*page, (*page)->index == index);
+	return fscache_read_helper(req, page, NULL, index, max_pages,
+				   FSCACHE_READ_FOR_WRITE, aop_flags);
+}
+EXPORT_SYMBOL(fscache_read_helper_for_write);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index bfb28cebfcfd..0aee6edef672 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -181,12 +181,24 @@ struct fscache_io_request {
 	unsigned long		flags;
 #define FSCACHE_IO_DATA_FROM_SERVER	0	/* Set if data was read from server */
 #define FSCACHE_IO_DATA_FROM_CACHE	1	/* Set if data was read from the cache */
+#define FSCACHE_IO_DONT_UNLOCK_PAGES	2	/* Don't unlock the pages on completion */
+#define FSCACHE_IO_READ_IN_PROGRESS	3	/* Cleared and woken upon completion of the read */
+#define FSCACHE_IO_WRITE_TO_CACHE	4	/* Set if should write to cache */
 	void (*io_done)(struct fscache_io_request *);
+	struct work_struct	work;
+
+	/* Bits for readpages helper */
+	struct address_space	*mapping;	/* The mapping being accessed */
+	unsigned int		nr_pages;	/* Number of pages involved in the I/O */
+	unsigned int		dio_block_size;	/* Rounding for direct I/O in the cache */
+	struct page		*no_unlock_page; /* Don't unlock this page after read */
 };
 
 struct fscache_io_request_ops {
+	int (*is_req_valid)(struct fscache_io_request *);
 	bool (*is_still_valid)(struct fscache_io_request *);
 	void (*issue_op)(struct fscache_io_request *);
+	void (*reshape)(struct fscache_io_request *, struct fscache_request_shape *);
 	void (*done)(struct fscache_io_request *);
 	void (*get)(struct fscache_io_request *);
 	void (*put)(struct fscache_io_request *);
@@ -489,7 +501,7 @@ static inline void fscache_init_io_request(struct fscache_io_request *req,
 static inline
 void fscache_free_io_request(struct fscache_io_request *req)
 {
-	if (req->cookie)
+	if (fscache_cookie_valid(req->cookie))
 		__fscache_free_io_request(req);
 }
 
@@ -593,4 +605,16 @@ int fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
 	return -ENOBUFS;
 }
 
+extern int fscache_read_helper_page_list(struct fscache_io_request *,
+					 struct list_head *,
+					 pgoff_t);
+extern int fscache_read_helper_locked_page(struct fscache_io_request *,
+					   struct page *,
+					   pgoff_t);
+extern int fscache_read_helper_for_write(struct fscache_io_request *,
+					 struct page **,
+					 pgoff_t,
+					 pgoff_t,
+					 unsigned int);
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache_support.h b/include/trace/events/fscache_support.h
new file mode 100644
index 000000000000..0d94650ad637
--- /dev/null
+++ b/include/trace/events/fscache_support.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* FS-Cache support module tracepoints
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fscache_support
+
+#if !defined(_TRACE_FSCACHE_SUPPORT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSCACHE_SUPPORT_H
+
+#include <linux/fscache.h>
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __FSCACHE_SUPPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __FSCACHE_SUPPORT_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum fscache_read_helper_trace {
+	fscache_read_helper_download,
+	fscache_read_helper_race,
+	fscache_read_helper_read,
+	fscache_read_helper_skip,
+	fscache_read_helper_zero,
+};
+
+#endif
+
+#define fscache_read_helper_traces				\
+	EM(fscache_read_helper_download,	"DOWN")		\
+	EM(fscache_read_helper_race,		"RACE")		\
+	EM(fscache_read_helper_read,		"READ")		\
+	EM(fscache_read_helper_skip,		"SKIP")		\
+	E_(fscache_read_helper_zero,		"ZERO")
+
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+fscache_read_helper_traces;
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
+TRACE_EVENT(fscache_read_helper,
+	    TP_PROTO(struct fscache_cookie *cookie, pgoff_t start, pgoff_t end,
+		     unsigned int notes, enum fscache_read_helper_trace what),
+
+	    TP_ARGS(cookie, start, end, notes, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(pgoff_t,			start		)
+		    __field(pgoff_t,			end		)
+		    __field(unsigned int,		notes		)
+		    __field(enum fscache_read_helper_trace, what	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie ? cookie->debug_id : 0;
+		    __entry->start	= start;
+		    __entry->end	= end;
+		    __entry->what	= what;
+		    __entry->notes	= notes;
+			   ),
+
+	    TP_printk("c=%08x %s n=%08x p=%lx-%lx",
+		      __entry->cookie,
+		      __print_symbolic(__entry->what, fscache_read_helper_traces),
+		      __entry->notes,
+		      __entry->start, __entry->end)
+	    );
+
+#endif /* _TRACE_FSCACHE_SUPPORT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


