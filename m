Return-Path: <linux-fsdevel+bounces-6721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEE81B811
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5DD28B600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1C83F53;
	Thu, 21 Dec 2023 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mraq/v0u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D781E5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBGmviZKZkNj16tSs/QMP3jVGoPPPd0Ca5Z2PkWUIFw=;
	b=Mraq/v0upWNvaBmoEmCqStZ8vOtlI6GSbS8lTPPVoc0N8lbR0mBfRVT5/74H5HlBv342RW
	18kRAkCY6HjEqZGzxfHRKNZVU/Y+NE+EKeZGgGzY48SZvVPOuj1+6h5V8Sw/NAvTD7CwEL
	HDQfiBkSG4d6iPdjpKMK7t6QDRBVeOw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-GJGRDdsZML2JkN0KQ9v9vQ-1; Thu,
 21 Dec 2023 08:25:42 -0500
X-MC-Unique: GJGRDdsZML2JkN0KQ9v9vQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763841C0651F;
	Thu, 21 Dec 2023 13:25:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7089B112131D;
	Thu, 21 Dec 2023 13:25:38 +0000 (UTC)
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
Subject: [PATCH v5 25/40] netfs: Provide func to copy data to pagecache for buffered write
Date: Thu, 21 Dec 2023 13:23:20 +0000
Message-ID: <20231221132400.1601991-26-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Provide a netfs write helper, netfs_perform_write() to buffer data to be
written in the pagecache and mark the modified folios dirty.

It will perform "streaming writes" for folios that aren't currently
resident, if possible, storing data in partially modified folios that are
marked dirty, but not uptodate.  It will also tag pages as belonging to
fs-specific write groups if so directed by the filesystem.

This is derived from generic_perform_write(), but doesn't use
->write_begin() and ->write_end(), having that logic rolled in instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/Makefile            |   1 +
 fs/netfs/buffered_read.c     |  49 ++++++
 fs/netfs/buffered_write.c    | 330 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |   2 +
 fs/netfs/io.c                |   1 +
 include/linux/netfs.h        |   5 +
 include/trace/events/netfs.h |  73 ++++++++
 7 files changed, 461 insertions(+)
 create mode 100644 fs/netfs/buffered_write.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index c69c6775b8ac..85d8333a1ed4 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -2,6 +2,7 @@
 
 netfs-y := \
 	buffered_read.o \
+	buffered_write.o \
 	io.o \
 	iterator.o \
 	locking.o \
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 6b9a44cafbac..73a6e4d61f9d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -63,6 +63,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				break;
 			}
 			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
 				folio_start_fscache(folio);
 				folio_started = true;
 			}
@@ -454,3 +455,51 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_write_begin);
+
+/*
+ * Preload the data into a page we're proposing to write into.
+ */
+int netfs_prefetch_for_write(struct file *file, struct folio *folio,
+			     size_t offset, size_t len)
+{
+	struct netfs_io_request *rreq;
+	struct address_space *mapping = folio_file_mapping(folio);
+	struct netfs_inode *ctx = netfs_inode(mapping->host);
+	unsigned long long start = folio_pos(folio);
+	size_t flen = folio_size(folio);
+	int ret;
+
+	_enter("%zx @%llx", flen, start);
+
+	ret = -ENOMEM;
+
+	rreq = netfs_alloc_request(mapping, file, start, flen,
+				   NETFS_READ_FOR_WRITE);
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto error;
+	}
+
+	rreq->no_unlock_folio = folio_index(folio);
+	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
+	ret = netfs_begin_cache_read(rreq, ctx);
+	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+		goto error_put;
+
+	netfs_stat(&netfs_n_rh_write_begin);
+	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
+
+	/* Set up the output buffer */
+	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
+			rreq->start, rreq->len);
+
+	ret = netfs_begin_read(rreq, true);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	return ret;
+
+error_put:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
new file mode 100644
index 000000000000..6e7f06d9962d
--- /dev/null
+++ b/fs/netfs/buffered_write.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level write support.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+#include "internal.h"
+
+/*
+ * Determined write method.  Adjust netfs_folio_traces if this is changed.
+ */
+enum netfs_how_to_modify {
+	NETFS_FOLIO_IS_UPTODATE,	/* Folio is uptodate already */
+	NETFS_JUST_PREFETCH,		/* We have to read the folio anyway */
+	NETFS_WHOLE_FOLIO_MODIFY,	/* We're going to overwrite the whole folio */
+	NETFS_MODIFY_AND_CLEAR,		/* We can assume there is no data to be downloaded. */
+	NETFS_STREAMING_WRITE,		/* Store incomplete data in non-uptodate page. */
+	NETFS_STREAMING_WRITE_CONT,	/* Continue streaming write. */
+	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
+};
+
+static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
+{
+	if (netfs_group && !folio_get_private(folio))
+		folio_attach_private(folio, netfs_get_group(netfs_group));
+}
+
+/*
+ * Decide how we should modify a folio.  We might be attempting to do
+ * write-streaming, in which case we don't want to a local RMW cycle if we can
+ * avoid it.  If we're doing local caching or content crypto, we award that
+ * priority over avoiding RMW.  If the file is open readably, then we also
+ * assume that we may want to read what we wrote.
+ */
+static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
+						    struct file *file,
+						    struct folio *folio,
+						    void *netfs_group,
+						    size_t flen,
+						    size_t offset,
+						    size_t len,
+						    bool maybe_trouble)
+{
+	struct netfs_folio *finfo = netfs_folio_info(folio);
+	loff_t pos = folio_file_pos(folio);
+
+	_enter("");
+
+	if (netfs_folio_group(folio) != netfs_group)
+		return NETFS_FLUSH_CONTENT;
+
+	if (folio_test_uptodate(folio))
+		return NETFS_FOLIO_IS_UPTODATE;
+
+	if (pos >= ctx->remote_i_size)
+		return NETFS_MODIFY_AND_CLEAR;
+
+	if (!maybe_trouble && offset == 0 && len >= flen)
+		return NETFS_WHOLE_FOLIO_MODIFY;
+
+	if (file->f_mode & FMODE_READ)
+		return NETFS_JUST_PREFETCH;
+
+	if (netfs_is_cache_enabled(ctx))
+		return NETFS_JUST_PREFETCH;
+
+	if (!finfo)
+		return NETFS_STREAMING_WRITE;
+
+	/* We can continue a streaming write only if it continues on from the
+	 * previous.  If it overlaps, we must flush lest we suffer a partial
+	 * copy and disjoint dirty regions.
+	 */
+	if (offset == finfo->dirty_offset + finfo->dirty_len)
+		return NETFS_STREAMING_WRITE_CONT;
+	return NETFS_FLUSH_CONTENT;
+}
+
+/*
+ * Grab a folio for writing and lock it.
+ */
+static struct folio *netfs_grab_folio_for_write(struct address_space *mapping,
+						loff_t pos, size_t part)
+{
+	pgoff_t index = pos / PAGE_SIZE;
+
+	return __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+				   mapping_gfp_mask(mapping));
+}
+
+/**
+ * netfs_perform_write - Copy data into the pagecache.
+ * @iocb: The operation parameters
+ * @iter: The source buffer
+ * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ *
+ * Copy data into pagecache pages attached to the inode specified by @iocb.
+ * The caller must hold appropriate inode locks.
+ *
+ * Dirty pages are tagged with a netfs_folio struct if they're not up to date
+ * to indicate the range modified.  Dirty pages may also be tagged with a
+ * netfs-specific grouping such that data from an old group gets flushed before
+ * a new one is started.
+ */
+ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
+			    struct netfs_group *netfs_group)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = inode->i_mapping;
+	struct netfs_inode *ctx = netfs_inode(inode);
+	struct netfs_folio *finfo;
+	struct folio *folio;
+	enum netfs_how_to_modify howto;
+	enum netfs_folio_trace trace;
+	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
+	ssize_t written = 0, ret;
+	loff_t i_size, pos = iocb->ki_pos, from, to;
+	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	bool maybe_trouble = false;
+
+	do {
+		size_t flen;
+		size_t offset;	/* Offset into pagecache folio */
+		size_t part;	/* Bytes to write to folio */
+		size_t copied;	/* Bytes copied from user */
+
+		ret = balance_dirty_pages_ratelimited_flags(mapping, bdp_flags);
+		if (unlikely(ret < 0))
+			break;
+
+		offset = pos & (max_chunk - 1);
+		part = min(max_chunk - offset, iov_iter_count(iter));
+
+		/* Bring in the user pages that we will copy from _first_ lest
+		 * we hit a nasty deadlock on copying from the same page as
+		 * we're writing to, without it being marked uptodate.
+		 *
+		 * Not only is this an optimisation, but it is also required to
+		 * check that the address is actually valid, when atomic
+		 * usercopies are used below.
+		 *
+		 * We rely on the page being held onto long enough by the LRU
+		 * that we can grab it below if this causes it to be read.
+		 */
+		ret = -EFAULT;
+		if (unlikely(fault_in_iov_iter_readable(iter, part) == part))
+			break;
+
+		ret = -ENOMEM;
+		folio = netfs_grab_folio_for_write(mapping, pos, part);
+		if (!folio)
+			break;
+
+		flen = folio_size(folio);
+		offset = pos & (flen - 1);
+		part = min_t(size_t, flen - offset, part);
+
+		if (signal_pending(current)) {
+			ret = written ? -EINTR : -ERESTARTSYS;
+			goto error_folio_unlock;
+		}
+
+		/* See if we need to prefetch the area we're going to modify.
+		 * We need to do this before we get a lock on the folio in case
+		 * there's more than one writer competing for the same cache
+		 * block.
+		 */
+		howto = netfs_how_to_modify(ctx, file, folio, netfs_group,
+					    flen, offset, part, maybe_trouble);
+		_debug("howto %u", howto);
+		switch (howto) {
+		case NETFS_JUST_PREFETCH:
+			ret = netfs_prefetch_for_write(file, folio, offset, part);
+			if (ret < 0) {
+				_debug("prefetch = %zd", ret);
+				goto error_folio_unlock;
+			}
+			break;
+		case NETFS_FOLIO_IS_UPTODATE:
+		case NETFS_WHOLE_FOLIO_MODIFY:
+		case NETFS_STREAMING_WRITE_CONT:
+			break;
+		case NETFS_MODIFY_AND_CLEAR:
+			zero_user_segment(&folio->page, 0, offset);
+			break;
+		case NETFS_STREAMING_WRITE:
+			ret = -EIO;
+			if (WARN_ON(folio_get_private(folio)))
+				goto error_folio_unlock;
+			break;
+		case NETFS_FLUSH_CONTENT:
+			trace_netfs_folio(folio, netfs_flush_content);
+			from = folio_pos(folio);
+			to = from + folio_size(folio) - 1;
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = filemap_write_and_wait_range(mapping, from, to);
+			if (ret < 0)
+				goto error_folio_unlock;
+			continue;
+		}
+
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_folio(folio);
+
+		copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+
+		flush_dcache_folio(folio);
+
+		/* Deal with a (partially) failed copy */
+		if (copied == 0) {
+			ret = -EFAULT;
+			goto error_folio_unlock;
+		}
+
+		trace = (enum netfs_folio_trace)howto;
+		switch (howto) {
+		case NETFS_FOLIO_IS_UPTODATE:
+		case NETFS_JUST_PREFETCH:
+			netfs_set_group(folio, netfs_group);
+			break;
+		case NETFS_MODIFY_AND_CLEAR:
+			zero_user_segment(&folio->page, offset + copied, flen);
+			netfs_set_group(folio, netfs_group);
+			folio_mark_uptodate(folio);
+			break;
+		case NETFS_WHOLE_FOLIO_MODIFY:
+			if (unlikely(copied < part)) {
+				maybe_trouble = true;
+				iov_iter_revert(iter, copied);
+				copied = 0;
+				goto retry;
+			}
+			netfs_set_group(folio, netfs_group);
+			folio_mark_uptodate(folio);
+			break;
+		case NETFS_STREAMING_WRITE:
+			if (offset == 0 && copied == flen) {
+				netfs_set_group(folio, netfs_group);
+				folio_mark_uptodate(folio);
+				trace = netfs_streaming_filled_page;
+				break;
+			}
+			finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
+			if (!finfo) {
+				iov_iter_revert(iter, copied);
+				ret = -ENOMEM;
+				goto error_folio_unlock;
+			}
+			finfo->netfs_group = netfs_get_group(netfs_group);
+			finfo->dirty_offset = offset;
+			finfo->dirty_len = copied;
+			folio_attach_private(folio, (void *)((unsigned long)finfo |
+							     NETFS_FOLIO_INFO));
+			break;
+		case NETFS_STREAMING_WRITE_CONT:
+			finfo = netfs_folio_info(folio);
+			finfo->dirty_len += copied;
+			if (finfo->dirty_offset == 0 && finfo->dirty_len == flen) {
+				if (finfo->netfs_group)
+					folio_change_private(folio, finfo->netfs_group);
+				else
+					folio_detach_private(folio);
+				folio_mark_uptodate(folio);
+				kfree(finfo);
+				trace = netfs_streaming_cont_filled_page;
+			}
+			break;
+		default:
+			WARN(true, "Unexpected modify type %u ix=%lx\n",
+			     howto, folio_index(folio));
+			ret = -EIO;
+			goto error_folio_unlock;
+		}
+
+		trace_netfs_folio(folio, trace);
+
+		/* Update the inode size if we moved the EOF marker */
+		i_size = i_size_read(inode);
+		pos += copied;
+		if (pos > i_size) {
+			if (ctx->ops->update_i_size) {
+				ctx->ops->update_i_size(inode, pos);
+			} else {
+				i_size_write(inode, pos);
+#if IS_ENABLED(CONFIG_FSCACHE)
+				fscache_update_cookie(ctx->cache, NULL, &pos);
+#endif
+			}
+		}
+		written += copied;
+
+		folio_mark_dirty(folio);
+	retry:
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = NULL;
+
+		cond_resched();
+	} while (iov_iter_count(iter));
+
+out:
+	if (likely(written)) {
+		/* Flush and wait for a write that requires immediate synchronisation. */
+		if (iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) {
+			_debug("dsync");
+			ret = filemap_fdatawait_range(mapping, iocb->ki_pos,
+						      iocb->ki_pos + written);
+		}
+
+		iocb->ki_pos += written;
+	}
+
+	_leave(" = %zd [%zd]", written, ret);
+	return written ? written : ret;
+
+error_folio_unlock:
+	folio_unlock(folio);
+	folio_put(folio);
+	goto out;
+}
+EXPORT_SYMBOL(netfs_perform_write);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 0f20587f5a9b..17e4ea4456c7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,6 +23,8 @@
  * buffered_read.c
  */
 void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
+int netfs_prefetch_for_write(struct file *file, struct folio *folio,
+			     size_t offset, size_t len);
 
 /*
  * io.c
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index e83ef5835d25..774aef6ea4cb 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -125,6 +125,7 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 			if (have_unlocked && folio_index(folio) <= unlocked)
 				continue;
 			unlocked = folio_index(folio);
+			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
 			folio_end_fscache(folio);
 			have_unlocked = true;
 		}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 78d9f9486ee4..34b4cd9a56a6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -368,6 +368,11 @@ struct netfs_cache_ops {
 			       loff_t *_data_start, size_t *_data_len);
 };
 
+/* High-level write API */
+ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
+			    struct netfs_group *netfs_group);
+
+/* Address operations API */
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e03635172760..8308b81f36be 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -19,6 +19,7 @@
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
+	EM(netfs_read_trace_prefetch_for_write,	"PREFETCHW")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_write_traces					\
@@ -100,6 +101,31 @@
 	EM(netfs_sreq_trace_put_work,		"PUT WORK   ")	\
 	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
 
+#define netfs_folio_traces					\
+	/* The first few correspond to enum netfs_how_to_modify */	\
+	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\
+	EM(netfs_just_prefetch,			"mod-prefetch")	\
+	EM(netfs_whole_folio_modify,		"mod-whole-f")	\
+	EM(netfs_modify_and_clear,		"mod-n-clear")	\
+	EM(netfs_streaming_write,		"mod-streamw")	\
+	EM(netfs_streaming_write_cont,		"mod-streamw+")	\
+	EM(netfs_flush_content,			"flush")	\
+	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
+	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
+	/* The rest are for writeback */			\
+	EM(netfs_folio_trace_clear,		"clear")	\
+	EM(netfs_folio_trace_clear_s,		"clear-s")	\
+	EM(netfs_folio_trace_clear_g,		"clear-g")	\
+	EM(netfs_folio_trace_copy_to_cache,	"copy")		\
+	EM(netfs_folio_trace_end_copy,		"end-copy")	\
+	EM(netfs_folio_trace_kill,		"kill")		\
+	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
+	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
+	EM(netfs_folio_trace_redirty,		"redirty")	\
+	EM(netfs_folio_trace_redirtied,		"redirtied")	\
+	EM(netfs_folio_trace_store,		"store")	\
+	E_(netfs_folio_trace_store_plus,	"store+")
+
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
@@ -115,6 +141,7 @@ enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
 enum netfs_failure { netfs_failures } __mode(byte);
 enum netfs_rreq_ref_trace { netfs_rreq_ref_traces } __mode(byte);
 enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
+enum netfs_folio_trace { netfs_folio_traces } __mode(byte);
 
 #endif
 
@@ -135,6 +162,7 @@ netfs_sreq_traces;
 netfs_failures;
 netfs_rreq_ref_traces;
 netfs_sreq_ref_traces;
+netfs_folio_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -335,6 +363,51 @@ TRACE_EVENT(netfs_sreq_ref,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(netfs_folio,
+	    TP_PROTO(struct folio *folio, enum netfs_folio_trace why),
+
+	    TP_ARGS(folio, why),
+
+	    TP_STRUCT__entry(
+		    __field(ino_t,			ino)
+		    __field(pgoff_t,			index)
+		    __field(unsigned int,		nr)
+		    __field(enum netfs_folio_trace,	why)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->ino = folio->mapping->host->i_ino;
+		    __entry->why = why;
+		    __entry->index = folio_index(folio);
+		    __entry->nr = folio_nr_pages(folio);
+			   ),
+
+	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
+		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
+		      __print_symbolic(__entry->why, netfs_folio_traces))
+	    );
+
+TRACE_EVENT(netfs_write_iter,
+	    TP_PROTO(const struct kiocb *iocb, const struct iov_iter *from),
+
+	    TP_ARGS(iocb, from),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned long long,		start		)
+		    __field(size_t,			len		)
+		    __field(unsigned int,		flags		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->start	= iocb->ki_pos;
+		    __entry->len	= iov_iter_count(from);
+		    __entry->flags	= iocb->ki_flags;
+			   ),
+
+	    TP_printk("WRITE-ITER s=%llx l=%zx f=%x",
+		      __entry->start, __entry->len, __entry->flags)
+	    );
+
 TRACE_EVENT(netfs_write,
 	    TP_PROTO(const struct netfs_io_request *wreq,
 		     enum netfs_write_trace what),


