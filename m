Return-Path: <linux-fsdevel+bounces-5250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53B8095F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607AF1C203B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C24F1E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsJfCqKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E14487
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg7EtDdjykTAeOsmJC/ThrDtLSSX8ywqHaSfOHXVwXY=;
	b=PsJfCqKmnUGGLbCg3OAvKnqyyVxBv5zaEAzOLF9Ty7H6ajRm4FUPFkgfWyXIczKu1KMhNu
	M3kF1maHI8QpVk8Xmy21HC7Xza5+vOH2S4sJusa++dKFkt8Vp/WQI+mOtZFL6n9/gQPiGV
	ZFNOKD1Is2k3XYKclJ3OrLcRa6dr55Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-VQWqfDk7NVCntUA9RKDIcg-1; Thu, 07 Dec 2023 16:24:36 -0500
X-MC-Unique: VQWqfDk7NVCntUA9RKDIcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C354E88CDCE;
	Thu,  7 Dec 2023 21:24:35 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1788D2166B35;
	Thu,  7 Dec 2023 21:24:32 +0000 (UTC)
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
Subject: [PATCH v3 42/59] netfs: Implement a write-through caching option
Date: Thu,  7 Dec 2023 21:21:49 +0000
Message-ID: <20231207212206.1379128-43-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
index a71a9af1b880..461be124b35d 100644
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
@@ -135,6 +137,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -145,6 +155,30 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -317,7 +351,25 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -327,17 +379,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
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
index 942578d98199..dfc2351c69d7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -115,6 +115,9 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
  */
 int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		      enum netfs_write_trace what);
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
+int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end);
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
 
 /*
  * stats.c
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 1e43bc73e130..3a45ecdc4eac 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_LAUNDER_WRITE]		= "LW",
 	[NETFS_RMW_READ]		= "RM",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 8e4585216fc7..4da87d491c1d 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -42,6 +42,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	xa_init(&rreq->bounce);
 	INIT_LIST_HEAD(&rreq->subrequests);
+	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index c0ac3ac57861..7cbbe40aa997 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -391,3 +391,93 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
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
index 5ceb03abf1ff..e44508850ba2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -141,6 +141,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_ENCRYPTED	2		/* The file contents are encrypted */
+#define NETFS_ICTX_WRITETHROUGH	3		/* Write-through caching */
 	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
 	unsigned char		crypto_bshift;	/* log2 of crypto block size */
 	unsigned char		crypto_trailer;	/* Size of crypto trailer */
@@ -232,6 +233,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_RMW_READ,			/* This is an unbuffered read for RMW */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 94669fad4b7a..fcf4e41e280d 100644
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
 	EM(NETFS_RMW_READ,			"RM")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
@@ -141,7 +143,9 @@
 	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
-	E_(netfs_folio_trace_store_plus,	"store+")
+	EM(netfs_folio_trace_store_plus,	"store+")	\
+	EM(netfs_folio_trace_wthru,		"wthru")	\
+	E_(netfs_folio_trace_wthru_plus,	"wthru+")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY


