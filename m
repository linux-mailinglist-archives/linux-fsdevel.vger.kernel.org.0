Return-Path: <linux-fsdevel+bounces-3082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBA7EFA6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1645B2096D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061656779;
	Fri, 17 Nov 2023 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLEJqVFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7F3856
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/GtZmHCvQ0C6cEV7lrqQKTToBGwZLos13Q7MvBYGlc=;
	b=VLEJqVFT++MFBntyWYtn6Qxg0tN8aRG0baBdZUdeeLpiW5yoKvY2EuGheByNFdP2PCGfwf
	bRE6hNfPjhMaoYpI0EPJ0bQtKrjLllbe1yEWkZUCtaIrTX5QdlM9vL2i8P6qQeQRbrtN2D
	crMdv2+6LcKDCKk2p7d4StPohh15Png=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-1ca7bNFiNtO8FsaTl7FK4w-1; Fri, 17 Nov 2023 16:18:11 -0500
X-MC-Unique: 1ca7bNFiNtO8FsaTl7FK4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41065821944;
	Fri, 17 Nov 2023 21:18:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 88C3BC15881;
	Fri, 17 Nov 2023 21:18:07 +0000 (UTC)
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
Subject: [PATCH v2 36/51] netfs: Support encryption on Unbuffered/DIO write
Date: Fri, 17 Nov 2023 21:15:28 +0000
Message-ID: <20231117211544.1740466-37-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Support unbuffered and direct I/O writes to an encrypted file.  This may
require making an RMW cycle if the write is not appropriately aligned with
respect to the crypto blocks.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_read.c       |   2 +-
 fs/netfs/direct_write.c      | 210 ++++++++++++++++++++++++++++++++++-
 fs/netfs/internal.h          |   8 ++
 fs/netfs/io.c                | 117 +++++++++++++++++++
 fs/netfs/main.c              |   1 +
 include/linux/netfs.h        |   4 +
 include/trace/events/netfs.h |   1 +
 7 files changed, 337 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 158719b56900..c01cbe42db8a 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -88,7 +88,7 @@ static int netfs_copy_xarray_to_iter(struct netfs_io_request *rreq,
  * If we did a direct read to a bounce buffer (say we needed to decrypt it),
  * copy the data obtained to the destination iterator.
  */
-static int netfs_dio_copy_bounce_to_dest(struct netfs_io_request *rreq)
+int netfs_dio_copy_bounce_to_dest(struct netfs_io_request *rreq)
 {
 	struct iov_iter *dest_iter = &rreq->iter;
 	struct kiocb *iocb = rreq->iocb;
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index b1a4921ac4a2..f9dea801d6dd 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -23,6 +23,100 @@ static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
 	}
 }
 
+/*
+ * Allocate a bunch of pages and add them into the xarray buffer starting at
+ * the given index.
+ */
+static int netfs_alloc_buffer(struct xarray *xa, pgoff_t index, unsigned int nr_pages)
+{
+	struct page *page;
+	unsigned int n;
+	int ret = 0;
+	LIST_HEAD(list);
+
+	n = alloc_pages_bulk_list(GFP_NOIO, nr_pages, &list);
+	if (n < nr_pages) {
+		ret = -ENOMEM;
+	}
+
+	while ((page = list_first_entry_or_null(&list, struct page, lru))) {
+		list_del(&page->lru);
+		page->index = index;
+		ret = xa_insert(xa, index++, page, GFP_NOIO);
+		if (ret < 0)
+			break;
+	}
+
+	while ((page = list_first_entry_or_null(&list, struct page, lru))) {
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	return ret;
+}
+
+/*
+ * Copy all of the data from the source iterator into folios in the destination
+ * xarray.  We cannot step through and kmap the source iterator if it's an
+ * iovec, so we have to step through the xarray and drop the RCU lock each
+ * time.
+ */
+static int netfs_copy_iter_to_xarray(struct iov_iter *src, struct xarray *xa,
+				     unsigned long long start)
+{
+	struct folio *folio;
+	void *base;
+	pgoff_t index = start / PAGE_SIZE;
+	size_t len, copied, count = iov_iter_count(src);
+
+	XA_STATE(xas, xa, index);
+
+	_enter("%zx", count);
+
+	if (!count)
+		return -EIO;
+
+	len = PAGE_SIZE - offset_in_page(start);
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t offset;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		/* There shouldn't be a need to call xas_pause() as no one else
+		 * can see the xarray we're iterating over.
+		 */
+		rcu_read_unlock();
+
+		offset = offset_in_folio(folio, start);
+		_debug("folio %lx +%zx [%llx]", folio->index, offset, start);
+
+		while (offset < folio_size(folio)) {
+			len = min(count, len);
+
+			base = kmap_local_folio(folio, offset);
+			copied = copy_from_iter(base, len, src);
+			kunmap_local(base);
+			if (copied != len)
+				goto out;
+			count -= len;
+			if (count == 0)
+				goto out;
+
+			start += len;
+			offset += len;
+			len = PAGE_SIZE;
+		}
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
+out:
+	_leave(" = %zx", count);
+	return count ? -EIO : 0;
+}
+
 /*
  * Perform an unbuffered write where we may have to do an RMW operation on an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -31,20 +125,47 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 					   struct netfs_group *netfs_group)
 {
 	struct netfs_io_request *wreq;
+	struct netfs_inode *ctx = netfs_inode(file_inode(iocb->ki_filp));
+	unsigned long long real_size = ctx->remote_i_size;
 	unsigned long long start = iocb->ki_pos;
 	unsigned long long end = start + iov_iter_count(iter);
 	ssize_t ret, n;
-	bool async = !is_sync_kiocb(iocb);
+	size_t min_bsize = 1UL << ctx->min_bshift;
+	size_t bmask = min_bsize - 1;
+	size_t gap_before = start & bmask;
+	size_t gap_after = (min_bsize - end) & bmask;
+	bool use_bounce, async = !is_sync_kiocb(iocb);
+	enum {
+		DIRECT_IO, COPY_TO_BOUNCE, ENC_TO_BOUNCE, COPY_THEN_ENC,
+	} buffering;
 
 	_enter("");
 
+	/* The real size must be rounded out to the crypto block size plus
+	 * any trailer we might want to attach.
+	 */
+	if (real_size && ctx->crypto_bshift) {
+		size_t cmask = 1UL << ctx->crypto_bshift;
+
+		if (real_size < ctx->crypto_trailer)
+			return -EIO;
+		if ((real_size - ctx->crypto_trailer) & cmask)
+			return -EIO;
+		real_size -= ctx->crypto_trailer;
+	}
+
 	/* We're going to need a bounce buffer if what we transmit is going to
 	 * be different in some way to the source buffer, e.g. because it gets
 	 * encrypted/compressed or because it needs expanding to a block size.
 	 */
-	// TODO
+	use_bounce = test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags);
+	if (gap_before || gap_after) {
+		if (iocb->ki_flags & IOCB_DIRECT)
+			return -EINVAL;
+		use_bounce = true;
+	}
 
-	_debug("uw %llx-%llx", start, end);
+	_debug("uw %llx-%llx +%zx,%zx", start, end, gap_before, gap_after);
 
 	wreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				   start, end - start,
@@ -53,7 +174,57 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	if (IS_ERR(wreq))
 		return PTR_ERR(wreq);
 
-	{
+	if (use_bounce) {
+		unsigned long long bstart = start - gap_before;
+		unsigned long long bend = end + gap_after;
+		pgoff_t first = bstart / PAGE_SIZE;
+		pgoff_t last  = (bend - 1) / PAGE_SIZE;
+
+		_debug("bounce %llx-%llx %lx-%lx", bstart, bend, first, last);
+
+		ret = netfs_alloc_buffer(&wreq->bounce, first, last - first + 1);
+		if (ret < 0)
+			goto out;
+
+		iov_iter_xarray(&wreq->io_iter, READ, &wreq->bounce,
+				bstart, bend - bstart);
+
+		if (gap_before || gap_after)
+			async = false; /* We may have to repeat the RMW cycle */
+	}
+
+repeat_rmw_cycle:
+	if (use_bounce) {
+		/* If we're going to need to do an RMW cycle, fill in the gaps
+		 * at the ends of the buffer.
+		 */
+		if (gap_before || gap_after) {
+			struct iov_iter buffer = wreq->io_iter;
+
+			if ((gap_before && start - gap_before < real_size) ||
+			    (gap_after && end < real_size)) {
+				ret = netfs_rmw_read(wreq, iocb->ki_filp,
+						     start - gap_before, gap_before,
+						     end, end < real_size ? gap_after : 0);
+				if (ret < 0)
+					goto out;
+			}
+
+			if (gap_before && start - gap_before >= real_size)
+				iov_iter_zero(gap_before, &buffer);
+			if (gap_after && end >= real_size) {
+				iov_iter_advance(&buffer, end - start);
+				iov_iter_zero(gap_after, &buffer);
+			}
+		}
+
+		if (!test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &wreq->flags))
+			buffering = COPY_TO_BOUNCE;
+		else if (!gap_before && !gap_after && netfs_is_crypto_aligned(wreq, iter))
+			buffering = ENC_TO_BOUNCE;
+		else
+			buffering = COPY_THEN_ENC;
+	} else {
 		/* If this is an async op and we're not using a bounce buffer,
 		 * we have to save the source buffer as the iterator is only
 		 * good until we return.  In such a case, extract an iterator
@@ -77,10 +248,25 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		}
 
 		wreq->io_iter = wreq->iter;
+		buffering = DIRECT_IO;
 	}
 
 	/* Copy the data into the bounce buffer and encrypt it. */
-	// TODO
+	if (buffering == COPY_TO_BOUNCE ||
+	    buffering == COPY_THEN_ENC) {
+		ret = netfs_copy_iter_to_xarray(iter, &wreq->bounce, wreq->start);
+		if (ret < 0)
+			goto out;
+		wreq->iter = wreq->io_iter;
+		wreq->start -= gap_before;
+		wreq->len += gap_before + gap_after;
+	}
+
+	if (buffering == COPY_THEN_ENC ||
+	    buffering == ENC_TO_BOUNCE) {
+		if (!netfs_encrypt(wreq))
+			goto out;
+	}
 
 	/* Dispatch the write. */
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
@@ -101,6 +287,20 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
 
+		/* See if the write failed due to a 3rd party race when doing
+		 * an RMW on a partially modified block in an encrypted file.
+		 */
+		if (test_and_clear_bit(NETFS_RREQ_REPEAT_RMW, &wreq->flags)) {
+			netfs_clear_subrequests(wreq, false);
+			iov_iter_revert(iter, end - start);
+			wreq->error = 0;
+			wreq->start = start;
+			wreq->len = end - start;
+			wreq->transferred = 0;
+			wreq->submitted = 0;
+			goto repeat_rmw_cycle;
+		}
+
 		ret = wreq->error;
 		_debug("waited = %zd", ret);
 		if (ret == 0) {
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 447a67301329..782b73b1f5a7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -28,6 +28,11 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 bool netfs_encrypt(struct netfs_io_request *wreq);
 void netfs_decrypt(struct netfs_io_request *rreq);
 
+/*
+ * direct_read.c
+ */
+int netfs_dio_copy_bounce_to_dest(struct netfs_io_request *rreq);
+
 /*
  * direct_write.c
  */
@@ -38,6 +43,9 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
  * io.c
  */
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
+ssize_t netfs_rmw_read(struct netfs_io_request *wreq, struct file *file,
+		       unsigned long long start1, size_t len1,
+		       unsigned long long start2, size_t len2);
 
 /*
  * main.c
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 9887b22e4cb3..14a9f3312d3b 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -775,3 +775,120 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 out:
 	return ret;
 }
+
+static bool netfs_rmw_read_one(struct netfs_io_request *rreq,
+			       unsigned long long start, size_t len)
+{
+	struct netfs_inode *ctx = netfs_inode(rreq->inode);
+	struct iov_iter io_iter;
+	unsigned long long pstart, end = start + len;
+	pgoff_t first, last;
+	ssize_t ret;
+	size_t min_bsize = 1UL << ctx->min_bshift;
+
+	/* Determine the block we need to load. */
+	end = round_up(end, min_bsize);
+	start = round_down(start, min_bsize);
+
+	/* Determine the folios we need to insert. */
+	pstart = round_down(start, PAGE_SIZE);
+	first = pstart / PAGE_SIZE;
+	last = DIV_ROUND_UP(end, PAGE_SIZE);
+
+	ret = netfs_add_folios_to_buffer(&rreq->bounce, rreq->mapping,
+					 first, last, GFP_NOFS);
+	if (ret < 0) {
+		rreq->error = ret;
+		return false;
+	}
+
+	rreq->start = start;
+	rreq->len = len;
+	rreq->submitted = 0;
+	iov_iter_xarray(&rreq->io_iter, ITER_DEST, &rreq->bounce, start, len);
+
+	io_iter = rreq->io_iter;
+	do {
+		_debug("submit %llx + %zx >= %llx",
+		       rreq->start, rreq->submitted, rreq->i_size);
+		if (rreq->start + rreq->submitted >= rreq->i_size)
+			break;
+		if (!netfs_rreq_submit_slice(rreq, &io_iter, &rreq->subreq_counter))
+			break;
+	} while (rreq->submitted < rreq->len);
+
+	if (rreq->submitted < rreq->len) {
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Begin the process of reading in one or two chunks of data for use by
+ * unbuffered write to perform an RMW cycle.  We don't read directly into the
+ * write buffer as this may get called to redo the read in the case that a
+ * conditional write fails due to conflicting 3rd-party modifications.
+ */
+ssize_t netfs_rmw_read(struct netfs_io_request *wreq, struct file *file,
+		       unsigned long long start1, size_t len1,
+		       unsigned long long start2, size_t len2)
+{
+	struct netfs_io_request *rreq;
+	ssize_t ret;
+
+	_enter("RMW:R=%x %llx-%llx %llx-%llx",
+	       rreq->debug_id, start1, start1 + len1 - 1, start2, start2 + len2 - 1);
+
+	rreq = netfs_alloc_request(wreq->mapping, file,
+				   start1, start2 - start1 + len2, NETFS_RMW_READ);
+	if (IS_ERR(rreq))
+		return PTR_ERR(rreq);
+
+	INIT_WORK(&rreq->work, netfs_rreq_work);
+
+	rreq->iter = wreq->io_iter;
+	__set_bit(NETFS_RREQ_CRYPT_IN_PLACE, &rreq->flags);
+	__set_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags);
+
+	/* Chop the reads into slices according to what the netfs wants and
+	 * submit each one.
+	 */
+	netfs_get_request(rreq, netfs_rreq_trace_get_for_outstanding);
+	atomic_set(&rreq->nr_outstanding, 1);
+	if (len1 && !netfs_rmw_read_one(rreq, start1, len1))
+		goto wait;
+	if (len2)
+		netfs_rmw_read_one(rreq, start2, len2);
+
+wait:
+	/* Keep nr_outstanding incremented so that the ref always belongs to us
+	 * and the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	for (;;) {
+		wait_var_event(&rreq->nr_outstanding,
+			       atomic_read(&rreq->nr_outstanding) == 1);
+		netfs_rreq_assess(rreq, false);
+		if (atomic_read(&rreq->nr_outstanding) == 1)
+			break;
+		cond_resched();
+	}
+
+	trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
+	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
+		    TASK_UNINTERRUPTIBLE);
+
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+		ret = -EIO;
+	}
+
+	if (ret == 0)
+		ret = netfs_dio_copy_bounce_to_dest(rreq);
+
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	return ret;
+}
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 1cf10f9c4c1f..b335e6a50f9c 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_RMW_READ]		= "RM",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_DIO_WRITE]		= "DW",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 364361cc93be..c3d1eac1ce51 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -145,6 +145,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ENCRYPTED	2		/* The file contents are encrypted */
 	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
 	unsigned char		crypto_bshift;	/* log2 of crypto block size */
+	unsigned char		crypto_trailer;	/* Size of crypto trailer */
 };
 
 /*
@@ -233,6 +234,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_RMW_READ,			/* This is an unbuffered read for RMW */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
@@ -291,6 +293,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
 #define NETFS_RREQ_CONTENT_ENCRYPTION	11	/* Content encryption is in use */
 #define NETFS_RREQ_CRYPT_IN_PLACE	12	/* Enc/dec in place in ->io_iter */
+#define NETFS_RREQ_REPEAT_RMW		13	/* Need to repeat RMW cycle */
 	const struct netfs_request_ops *netfs_ops;
 	void (*cleanup)(struct netfs_io_request *req);
 };
@@ -479,6 +482,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->flags = 0;
 	ctx->min_bshift = 0;
 	ctx->crypto_bshift = 0;
+	ctx->crypto_trailer = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2f35057602fa..825946f510ee 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -33,6 +33,7 @@
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
+	EM(NETFS_RMW_READ,			"RM")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	E_(NETFS_DIO_WRITE,			"DW")


