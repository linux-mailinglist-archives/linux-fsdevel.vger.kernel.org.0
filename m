Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93C1C41B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgEDRNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:13:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730169AbgEDRN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHc2FKYXS9dkKKaIRAuOph6L2WYGy1yATcMTzek8D5E=;
        b=R5vx+t7fr1jyObhxvrpAuL3EATATkyeqbBX6PeZ/VHSFevApAP9uyrsqvBkVvx83vig/kr
        QCdbmIYWzX+OPuovITOYNDq8HHmKT3wJT/np1UykvvPGLWDMI7hSKfwC+yAZD8QtjDESpJ
        Mx0ewR3+dtDfl5hI8goAXkz4qa8O8KU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-DdiPnD1_PSqX_9lfDv852w-1; Mon, 04 May 2020 13:13:20 -0400
X-MC-Unique: DdiPnD1_PSqX_9lfDv852w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C08E819057AB;
        Mon,  4 May 2020 17:13:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9F135D9DC;
        Mon,  4 May 2020 17:13:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 38/61] fscache: Add read helper
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
Date:   Mon, 04 May 2020 18:13:15 +0100
Message-ID: <158861239500.340223.16866129612047911506.stgit@warthog.procyon.org.uk>
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

Add a helper function, fscache_read_helper(), to do the work of shaping
read requests, attempting to read from the cache, issuing or reissuing
requests to the filesystem to pass to the server and writing back to the
filesystem.

The filesystem passes in a prepared request descriptor with the fscache
descriptor embedded in it to fscache_read_helper().  The caller also
indicates which pages it is particularly interested in and provides some
operations to issue reads and manage the request descriptor.

Also add a tracepoint to track calls.  A set of 'notes' are taken to record
the path through the function and this is dumped into the trace.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Makefile            |    3 
 fs/fscache/read_helper.c       |  548 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h        |   22 ++
 include/trace/events/fscache.h |   44 +++
 4 files changed, 616 insertions(+), 1 deletion(-)
 create mode 100644 fs/fscache/read_helper.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 3caf66810e7b..e9a46544756e 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -12,7 +12,8 @@ fscache-y := \
 	main.o \
 	netfs.o \
 	obj.o \
-	object_bits.o
+	object_bits.o \
+	read_helper.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/read_helper.c b/fs/fscache/read_helper.c
new file mode 100644
index 000000000000..9ed6e76ef255
--- /dev/null
+++ b/fs/fscache/read_helper.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Read helper.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/fscache-cache.h>
+#include "internal.h"
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
+			if (req->write_to_cache)
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
+
+	if (req->write_to_cache)
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
+#define FSCACHE_RHLP_NOTE_READ_FROM_CACHE	FSCACHE_READ_FROM_CACHE
+#define FSCACHE_RHLP_NOTE_WRITE_TO_CACHE	FSCACHE_WRITE_TO_CACHE
+#define FSCACHE_RHLP_NOTE_FILL_WITH_ZERO	FSCACHE_FILL_WITH_ZERO
+#define FSCACHE_RHLP_NOTE_READ_FOR_WRITE	0x000100 /* Type: FSCACHE_READ_FOR_WRITE */
+#define FSCACHE_RHLP_NOTE_READ_LOCKED_PAGE	0x000200 /* Type: FSCACHE_READ_LOCKED_PAGE */
+#define FSCACHE_RHLP_NOTE_READ_PAGE_LIST	0x000300 /* Type: FSCACHE_READ_PAGE_LIST */
+#define FSCACHE_RHLP_NOTE_LIST_NOTCONTIG	0x001000 /* Page list: not contiguous */
+#define FSCACHE_RHLP_NOTE_LIST_NOMEM		0x002000 /* Page list: ENOMEM */
+#define FSCACHE_RHLP_NOTE_LIST_U2D		0x004000 /* Page list: page uptodate */
+#define FSCACHE_RHLP_NOTE_LIST_ERROR		0x008000 /* Page list: add error */
+#define FSCACHE_RHLP_NOTE_TRAILER_ADD		0x010000 /* Trailer: Creating */
+#define FSCACHE_RHLP_NOTE_TRAILER_NOMEM		0x020000 /* Trailer: ENOMEM */
+#define FSCACHE_RHLP_NOTE_TRAILER_U2D		0x040000 /* Trailer: Uptodate */
+#define FSCACHE_RHLP_NOTE_U2D_IN_PREFACE	0x100000 /* Uptodate page in preface */
+#define FSCACHE_RHLP_NOTE_UNDERSIZED		0x200000 /* Undersized block */
+#define FSCACHE_RHLP_NOTE_AFTER_EOF		0x800000 /* After EOF */
+
+/**
+ * fscache_read_helper - Helper to manage a read request
+ * @req: The initialised request structure to use
+ * @extent: The extent of the pages to access
+ * @requested_page: Singular page to include
+ * @pages: Unattached pages to include (readpages)
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
+int fscache_read_helper(struct fscache_io_request *req,
+			struct fscache_extent *extent,
+			struct page **requested_page,
+			struct list_head *pages,
+			enum fscache_read_type type,
+			unsigned int aop_flags)
+{
+	struct address_space *mapping = req->mapping;
+	struct page *page;
+	enum fscache_read_helper_trace what;
+	unsigned int notes;
+	pgoff_t eof, cursor, start, first_index, trailer = ULONG_MAX;
+	loff_t i_size;
+	int ret;
+
+	first_index = extent->start;
+	_enter("{%lx,%lx}", first_index, extent->limit);
+
+	ASSERTIFCMP(requested_page && *requested_page,
+		    (*requested_page)->index, ==, first_index);
+	ASSERTIF(type == FSCACHE_READ_LOCKED_PAGE ||
+		 type == FSCACHE_READ_FOR_WRITE,
+		 pages == NULL);
+	ASSERTIFCMP(pages && !list_empty(pages),
+		    first_index, ==, lru_to_page(pages)->index);
+
+	i_size = i_size_read(mapping->host);
+	if (type == FSCACHE_READ_FOR_WRITE) {
+		loff_t new_size = extent->block_end;
+		new_size <<= PAGE_SHIFT;
+		if (new_size > i_size)
+			i_size = new_size;
+	}
+	eof = (i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	notes = fscache_shape_extent(req->cookie, extent, i_size, false);
+	req->dio_block_size = extent->dio_block_size;
+
+	start = cursor = extent->start;
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
+		req->write_to_cache = true;
+		while (cursor < first_index) {
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
+			fscache_ignore_pages(mapping, start, cursor + 1);
+			req->write_to_cache = false;
+			start = cursor = first_index;
+			req->nr_pages = 0;
+			break;
+		}
+		page = NULL;
+	} else {
+		req->write_to_cache = false;
+		start = cursor = first_index;
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
+			page = grab_cache_page_write_begin(mapping, first_index,
+							   aop_flags);
+			if (!page)
+				goto nomem;
+			*requested_page = page;
+		}
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
+			if (page->index != cursor) {
+				notes |= FSCACHE_RHLP_NOTE_LIST_NOTCONTIG;
+				break;
+			}
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
+			    cursor == extent->block_end)
+				break;
+
+		} while (!list_empty(pages) && cursor < extent->limit);
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
+	if (req->write_to_cache) {
+		notes |= FSCACHE_RHLP_NOTE_TRAILER_ADD;
+		trailer = cursor;
+		while (cursor < extent->limit) {
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
+	if (cursor <= first_index) {
+		_debug("v.short");
+		goto nomem_unlock; /* We wouldn't've included the first page */
+	}
+
+submit_anyway:
+	if (cursor < extent->block_end) {
+		/* The request is short of what we need to be able to cache the
+		 * minimum cache block so discard the trailer.
+		 */
+		_debug("short");
+		notes |= FSCACHE_RHLP_NOTE_UNDERSIZED;
+		req->write_to_cache = false;
+		if (trailer != ULONG_MAX) {
+			fscache_ignore_pages(mapping, trailer, cursor);
+			req->nr_pages -= cursor - trailer;
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
+	trace_fscache_read_helper(req->cookie, start, start + req->nr_pages,
+				  notes, what);
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
+	if (cursor > first_index)
+		goto submit_anyway;
+nomem_unlock:
+	fscache_ignore_pages(mapping, start, cursor);
+	ret = -ENOMEM;
+dont:
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(fscache_read_helper);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index b46df865911c..ad44fa4cd844 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -152,7 +152,16 @@ struct fscache_io_request {
 	unsigned long		flags;
 #define FSCACHE_IO_DATA_FROM_SERVER	0	/* Set if data was read from server */
 #define FSCACHE_IO_DATA_FROM_CACHE	1	/* Set if data was read from the cache */
+#define FSCACHE_IO_DONT_UNLOCK_PAGES	2	/* Don't unlock the pages on completion */
 	void (*io_done)(struct fscache_io_request *);
+	struct work_struct	work;
+
+	/* Bits for readpages helper */
+	struct address_space	*mapping;	/* The mapping being accessed */
+	unsigned int		nr_pages;	/* Number of pages involved in the I/O */
+	unsigned int		dio_block_size;	/* Rounding for direct I/O in the cache */
+	bool			write_to_cache;	/* T if should write to the cache */
+	struct page		*no_unlock_page; /* Don't unlock this page after read */
 };
 
 struct fscache_io_request_ops {
@@ -571,4 +580,17 @@ int fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
 	return -ENOBUFS;
 }
 
+enum fscache_read_type {
+	FSCACHE_READ_PAGE_LIST,		/* Read the list of pages (readpages) */
+	FSCACHE_READ_LOCKED_PAGE,	/* requested_page is added and locked */
+	FSCACHE_READ_FOR_WRITE,		/* This read is a prelude to write_begin */
+};
+
+extern int fscache_read_helper(struct fscache_io_request *,
+			       struct fscache_extent *,
+			       struct page **,
+			       struct list_head *,
+			       enum fscache_read_type,
+			       unsigned int);
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 4ce81f3f4c5b..e78a3fa9b633 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -39,6 +39,13 @@ enum fscache_cookie_trace {
 	fscache_cookie_see_discard,
 };
 
+enum fscache_read_helper_trace {
+	fscache_read_helper_download,
+	fscache_read_helper_read,
+	fscache_read_helper_skip,
+	fscache_read_helper_zero,
+};
+
 #endif
 
 /*
@@ -63,6 +70,13 @@ enum fscache_cookie_trace {
 	EM(fscache_cookie_put_work,		"PUT work ")		\
 	E_(fscache_cookie_see_discard,		"SEE discd")
 
+#define fscache_read_helper_traces				\
+	EM(fscache_read_helper_download,	"DOWN")		\
+	EM(fscache_read_helper_read,		"READ")		\
+	EM(fscache_read_helper_skip,		"SKIP")		\
+	E_(fscache_read_helper_zero,		"ZERO")
+
+
 /*
  * Export enum symbols via userspace.
  */
@@ -72,6 +86,7 @@ enum fscache_cookie_trace {
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
 fscache_cookie_traces;
+fscache_read_helper_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -198,6 +213,35 @@ TRACE_EVENT(fscache_relinquish,
 		      __entry->flags, __entry->retire)
 	    );
 
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
+		    __entry->cookie	= cookie->debug_id;
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
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


