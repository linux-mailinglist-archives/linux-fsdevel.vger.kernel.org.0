Return-Path: <linux-fsdevel+bounces-6732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CA81B869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943C3B27930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D3627F0;
	Thu, 21 Dec 2023 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INY0eiUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100815991A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21bm0l+BhDuYlny9Ngjk+7mGhbvQdboWCvSUTaoHTsg=;
	b=INY0eiUMgLSvAlUfMeNzLL/Ij5iuAB+aqSqLcRfyhazfOieiDzg+1kJ7DTDfqJifUc8fUo
	j4zLRAFZwIcq9yhzPM/dLU2rI7BXSjKLzau36QVK+g/3H6ITZQN+KgqjPh8ZGZfjjcYSoR
	q5+IiaeRu3XITjA5H6TvMJsV7sYDDlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-S3ztP8qNPH2KYTnPBXoLmQ-1; Thu, 21 Dec 2023 08:26:26 -0500
X-MC-Unique: S3ztP8qNPH2KYTnPBXoLmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC3F685CEA5;
	Thu, 21 Dec 2023 13:26:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C49EB1121313;
	Thu, 21 Dec 2023 13:26:22 +0000 (UTC)
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
Subject: [PATCH v5 36/40] netfs: Implement a write-through caching option
Date: Thu, 21 Dec 2023 13:23:31 +0000
Message-ID: <20231221132400.1601991-37-dhowells@redhat.com>
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

Provide a flag whereby a filesystem may request that cifs_perform_write()
perform write-through caching.  This involves putting pages directly into
writeback rather than dirty and attaching them to a write operation as we
go.

Further, the writes being made are limited to the byte range being written
rather than whole folios being written.  This can be used by cifs, for
example, to deal with strict byte-range locking.

This can't be used with content encryption as that may require expansion of
the write RPC beyond the write being made.

This doesn't affect writes via mmap - those are written back in the normal
way; similarly failed writethrough writes are marked dirty and left to
writeback to retry.  Another option would be to simply invalidate them, but
the contents can be simultaneously accessed by read() and through mmap.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c    | 69 +++++++++++++++++++++++----
 fs/netfs/internal.h          |  3 ++
 fs/netfs/main.c              |  1 +
 fs/netfs/objects.c           |  1 +
 fs/netfs/output.c            | 90 ++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |  2 +
 include/trace/events/netfs.h |  8 +++-
 7 files changed, 162 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 50be8fe3ca43..6ca6c4bde5eb 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -26,6 +26,8 @@ enum netfs_how_to_modify {
 	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
 };
 
+static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq);
+
 static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
 	if (netfs_group && !folio_get_private(folio))
@@ -133,6 +135,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct netfs_inode *ctx = netfs_inode(inode);
+	struct writeback_control wbc = {
+		.sync_mode	= WB_SYNC_NONE,
+		.for_sync	= true,
+		.nr_to_write	= LONG_MAX,
+		.range_start	= iocb->ki_pos,
+		.range_end	= iocb->ki_pos + iter->count,
+	};
+	struct netfs_io_request *wreq = NULL;
 	struct netfs_folio *finfo;
 	struct folio *folio;
 	enum netfs_how_to_modify howto;
@@ -143,6 +153,30 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble = false;
 
+	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
+		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
+	    ) {
+		if (pos < i_size_read(inode)) {
+			ret = filemap_write_and_wait_range(mapping, pos, pos + iter->count);
+			if (ret < 0) {
+				goto out;
+			}
+		}
+
+		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
+
+		wreq = netfs_begin_writethrough(iocb, iter->count);
+		if (IS_ERR(wreq)) {
+			wbc_detach_inode(&wbc);
+			ret = PTR_ERR(wreq);
+			wreq = NULL;
+			goto out;
+		}
+		if (!is_sync_kiocb(iocb))
+			wreq->iocb = iocb;
+		wreq->cleanup = netfs_cleanup_buffered_write;
+	}
+
 	do {
 		size_t flen;
 		size_t offset;	/* Offset into pagecache folio */
@@ -315,7 +349,25 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		written += copied;
 
-		folio_mark_dirty(folio);
+		if (likely(!wreq)) {
+			folio_mark_dirty(folio);
+		} else {
+			if (folio_test_dirty(folio))
+				/* Sigh.  mmap. */
+				folio_clear_dirty_for_io(folio);
+			/* We make multiple writes to the folio... */
+			if (!folio_test_writeback(folio)) {
+				folio_wait_fscache(folio);
+				folio_start_writeback(folio);
+				folio_start_fscache(folio);
+				if (wreq->iter.count == 0)
+					trace_netfs_folio(folio, netfs_folio_trace_wthru);
+				else
+					trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
+			}
+			netfs_advance_writethrough(wreq, copied,
+						   offset + copied == flen);
+		}
 	retry:
 		folio_unlock(folio);
 		folio_put(folio);
@@ -325,17 +377,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
-	if (likely(written)) {
-		/* Flush and wait for a write that requires immediate synchronisation. */
-		if (iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) {
-			_debug("dsync");
-			ret = filemap_fdatawait_range(mapping, iocb->ki_pos,
-						      iocb->ki_pos + written);
-		}
-
-		iocb->ki_pos += written;
+	if (unlikely(wreq)) {
+		ret = netfs_end_writethrough(wreq, iocb);
+		wbc_detach_inode(&wbc);
+		if (ret == -EIOCBQUEUED)
+			return ret;
 	}
 
+	iocb->ki_pos += written;
 	_leave(" = %zd [%zd]", written, ret);
 	return written ? written : ret;
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 2de4f826dbe4..d2d63120ac60 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -101,6 +101,9 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
  */
 int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		      enum netfs_write_trace what);
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
+int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end);
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
 
 /*
  * stats.c
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 473f889e1bd1..81a13071b258 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -30,6 +30,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_LAUNDER_WRITE]		= "LW",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_READ]		= "DR",
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index b4e3bd836e5d..610ceb5bd86c 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -41,6 +41,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->i_size	= i_size_read(inode);
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	INIT_LIST_HEAD(&rreq->subrequests);
+	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index cc9065733b42..625eb68f3e5a 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -386,3 +386,93 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		    TASK_UNINTERRUPTIBLE);
 	return wreq->error;
 }
+
+/*
+ * Begin a write operation for writing through the pagecache.
+ */
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
+{
+	struct netfs_io_request *wreq;
+	struct file *file = iocb->ki_filp;
+
+	wreq = netfs_alloc_request(file->f_mapping, file, iocb->ki_pos, len,
+				   NETFS_WRITETHROUGH);
+	if (IS_ERR(wreq))
+		return wreq;
+
+	trace_netfs_write(wreq, netfs_write_trace_writethrough);
+
+	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+	iov_iter_xarray(&wreq->iter, ITER_SOURCE, &wreq->mapping->i_pages, wreq->start, 0);
+	wreq->io_iter = wreq->iter;
+
+	/* ->outstanding > 0 carries a ref */
+	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
+	atomic_set(&wreq->nr_outstanding, 1);
+	return wreq;
+}
+
+static void netfs_submit_writethrough(struct netfs_io_request *wreq, bool final)
+{
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	unsigned long long start;
+	size_t len;
+
+	if (!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+		return;
+
+	start = wreq->start + wreq->submitted;
+	len = wreq->iter.count - wreq->submitted;
+	if (!final) {
+		len /= wreq->wsize; /* Round to number of maximum packets */
+		len *= wreq->wsize;
+	}
+
+	ictx->ops->create_write_requests(wreq, start, len);
+	wreq->submitted += len;
+}
+
+/*
+ * Advance the state of the write operation used when writing through the
+ * pagecache.  Data has been copied into the pagecache that we need to append
+ * to the request.  If we've added more than wsize then we need to create a new
+ * subrequest.
+ */
+int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end)
+{
+	_enter("ic=%zu sb=%zu ws=%u cp=%zu tp=%u",
+	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_end);
+
+	wreq->iter.count += copied;
+	wreq->io_iter.count += copied;
+	if (to_page_end && wreq->io_iter.count - wreq->submitted >= wreq->wsize)
+		netfs_submit_writethrough(wreq, false);
+
+	return wreq->error;
+}
+
+/*
+ * End a write operation used when writing through the pagecache.
+ */
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb)
+{
+	int ret = -EIOCBQUEUED;
+
+	_enter("ic=%zu sb=%zu ws=%u",
+	       wreq->iter.count, wreq->submitted, wreq->wsize);
+
+	if (wreq->submitted < wreq->io_iter.count)
+		netfs_submit_writethrough(wreq, true);
+
+	if (atomic_dec_and_test(&wreq->nr_outstanding))
+		netfs_write_terminated(wreq, false);
+
+	if (is_sync_kiocb(iocb)) {
+		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+		ret = wreq->error;
+	}
+
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	return ret;
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 3413d06033ed..8cde618cf6d9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -139,6 +139,7 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 };
 
 /*
@@ -227,6 +228,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index cc998798e20a..447a8c21cf57 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -27,13 +27,15 @@
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
 	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
-	E_(netfs_write_trace_writeback,		"WRITEBACK")
+	EM(netfs_write_trace_writeback,		"WRITEBACK")	\
+	E_(netfs_write_trace_writethrough,	"WRITETHRU")
 
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
+	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_LAUNDER_WRITE,			"LW")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
@@ -136,7 +138,9 @@
 	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
-	E_(netfs_folio_trace_store_plus,	"store+")
+	EM(netfs_folio_trace_store_plus,	"store+")	\
+	EM(netfs_folio_trace_wthru,		"wthru")	\
+	E_(netfs_folio_trace_wthru_plus,	"wthru+")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY


