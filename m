Return-Path: <linux-fsdevel+bounces-43981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D653CA605F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8416B8804C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22472212FB7;
	Thu, 13 Mar 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbIsTrcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60B212B0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908957; cv=none; b=QdB18tESa41ZNqsOS8EJ/Du4Wgcw7MNW/a1g4xoQeosuoaZ8XZdjLTspvboeflAKChuMi24J+NVOACNIIup58iS0WE7fvGzA4+L4PdbdoOQ/oXCukh4W6McDygeDopgU3pCXH/SIuSVrUD6vywoSTK6ZEzxhy4vUkK9+GpjuKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908957; c=relaxed/simple;
	bh=fHs1s2WCKQ84Yspbi4jtwD+PSbtcWohuKJ09bCFjMKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYJYq10ZLJwwbS84LD6mmFRDx4NxeFxUakmQS2PseAniMO5vXbYRw/Mt7upW4j3CAl33dsqLPCo36nGc0iY8ByEFC6laauMRzxOX3CYxpf3Jfw+6eeYDcXELqgSxaRr/vjeFfTDnF0k/MKkw/XmIO7IvBeEo7Mi0joGk/NHuVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbIsTrcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YW3tQO1OIxbJZ9HZnJpB3E2VWDABEHP8uIr97iicS+8=;
	b=bbIsTrcSnyvLGqp+KX4PnyKSPUlIl/EEuw39nkJ+nfrBRBCzyq/un8gQttoagCVOBuuXV5
	Sf7I6QivZ0wdmyHtTeVbQXwEzU/t6c0GOdvBvkbxd4l2hb6m5Pv5/FezWfcpxe3RTtJSEx
	MEzbfJh4MXEzih2qJV6xP0Tv47IasI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-cdmA10zOMiClYN4h6-rr4g-1; Thu,
 13 Mar 2025 19:35:49 -0400
X-MC-Unique: cdmA10zOMiClYN4h6-rr4g-1
X-Mimecast-MFC-AGG-ID: cdmA10zOMiClYN4h6-rr4g_1741908948
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5763B1801A07;
	Thu, 13 Mar 2025 23:35:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12ED81955BCB;
	Thu, 13 Mar 2025 23:35:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 32/35] netfs: Add some more RMW support for ceph
Date: Thu, 13 Mar 2025 23:33:24 +0000
Message-ID: <20250313233341.1675324-33-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add some support for RMW in ceph:

 (1) Add netfs_unbuffered_read_from_inode() to allow reading from an inode
     without having a file pointer so that truncate can modify a
     now-partial tail block of a content-encrypted file.

     This takes an additional argument to cause it to fail or give a short
     read if a hole is encountered.  This is noted on the request with
     NETFS_RREQ_NO_READ_HOLE for the filesystem to pick up.

 (2) Set NETFS_RREQ_RMW when doing an RMW as part of a request.

 (3) Provide a ->rmw_read_done() op for netfslib to tell the filesystem
     that it has completed the read required for RMW.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_read.c       | 75 ++++++++++++++++++++++++++++++++++++
 fs/netfs/direct_write.c      |  1 +
 fs/netfs/main.c              |  1 +
 fs/netfs/objects.c           |  1 +
 fs/netfs/read_collect.c      |  2 +
 fs/netfs/write_retry.c       |  3 ++
 include/linux/netfs.h        |  7 ++++
 include/trace/events/netfs.h |  3 ++
 8 files changed, 93 insertions(+)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 5e4bd1e5a378..4061f934dfe6 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -373,3 +373,78 @@ ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter);
+
+/**
+ * netfs_unbuffered_read_from_inode - Perform an unbuffered sync I/O read
+ * @inode: The inode being accessed
+ * @pos: The file position to read from
+ * @iter: The output buffer (also specifies read length)
+ * @nohole: True to return short/ENODATA if hole encountered
+ *
+ * Perform a synchronous unbuffered I/O from the inode to the output buffer.
+ * No use is made of the pagecache.  The output buffer must be suitably aligned
+ * if content encryption is to be used.  If @nohole is true then the read will
+ * stop short if a hole is encountered and return -ENODATA if the read begins
+ * with a hole.
+ *
+ * The caller must hold any appropriate locks.
+ */
+ssize_t netfs_unbuffered_read_from_inode(struct inode *inode, loff_t pos,
+					 struct iov_iter *iter, bool nohole)
+{
+	struct netfs_io_request *rreq;
+	ssize_t ret;
+	size_t orig_count = iov_iter_count(iter);
+
+	_enter("");
+
+	if (WARN_ON(user_backed_iter(iter)))
+		return -EIO;
+
+	if (!orig_count)
+		return 0; /* Don't update atime */
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, pos, orig_count);
+	if (ret < 0)
+		return ret;
+	inode_update_time(inode, S_ATIME);
+
+	rreq = netfs_alloc_request(inode->i_mapping, NULL, pos, orig_count,
+				   NULL, NETFS_UNBUFFERED_READ);
+	if (IS_ERR(rreq))
+		return PTR_ERR(rreq);
+
+	ret = -EIO;
+	if (test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags) &&
+	    WARN_ON(!netfs_is_crypto_aligned(rreq, iter)))
+		goto out;
+
+	netfs_stat(&netfs_n_rh_dio_read);
+	trace_netfs_read(rreq, rreq->start, rreq->len,
+			 netfs_read_trace_unbuffered_read_from_inode);
+
+	rreq->buffer.iter	= *iter;
+	rreq->len		= orig_count;
+	rreq->direct_bv_unpin	= false;
+	iov_iter_advance(iter, orig_count);
+
+	if (nohole)
+		__set_bit(NETFS_RREQ_NO_READ_HOLE, &rreq->flags);
+
+	/* We're going to do the crypto in place in the destination buffer. */
+	if (test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags))
+		__set_bit(NETFS_RREQ_CRYPT_IN_PLACE, &rreq->flags);
+
+	ret = netfs_dispatch_unbuffered_reads(rreq);
+
+	if (!rreq->submitted) {
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		goto out;
+	}
+
+	ret = netfs_wait_for_read(rreq);
+out:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_unbuffered_read_from_inode);
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 83c5c06c4710..a99722f90c71 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -145,6 +145,7 @@ static ssize_t netfs_write_through_bounce_buffer(struct netfs_io_request *wreq,
 		wreq->start		= gstart;
 		wreq->len		= gend - gstart;
 
+		__set_bit(NETFS_RREQ_RMW, &ictx->flags);
 		if (gstart >= end) {
 			/* At or after EOF, nothing to read. */
 		} else {
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 07f8cffbda8c..0900dea53e4a 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -39,6 +39,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READ_GAPS]		= "RG",
 	[NETFS_READ_SINGLE]		= "R1",
 	[NETFS_READ_FOR_WRITE]		= "RW",
+	[NETFS_UNBUFFERED_READ]		= "UR",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITEBACK_SINGLE]	= "W1",
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 4606e830c116..958c4d460d07 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -60,6 +60,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_SINGLE ||
 	    origin == NETFS_READ_FOR_WRITE ||
+	    origin == NETFS_UNBUFFERED_READ ||
 	    origin == NETFS_DIO_READ) {
 		INIT_WORK(&rreq->work, netfs_read_collection_worker);
 		rreq->io_streams[0].avail = true;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 0a0bff90ca9e..013a90738dcd 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -462,6 +462,7 @@ static void netfs_read_collection(struct netfs_io_request *rreq)
 	//netfs_rreq_is_still_valid(rreq);
 
 	switch (rreq->origin) {
+	case NETFS_UNBUFFERED_READ:
 	case NETFS_DIO_READ:
 	case NETFS_READ_GAPS:
 	case NETFS_RMW_READ:
@@ -681,6 +682,7 @@ ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
 	if (ret == 0) {
 		ret = rreq->transferred;
 		switch (rreq->origin) {
+		case NETFS_UNBUFFERED_READ:
 		case NETFS_DIO_READ:
 		case NETFS_READ_SINGLE:
 			ret = rreq->transferred;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index f727b48e2bfe..9e4e79d5a403 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -386,6 +386,9 @@ ssize_t netfs_rmw_read(struct netfs_io_request *wreq, struct file *file,
 		ret = 0;
 	}
 
+	if (ret == 0 && rreq->netfs_ops->rmw_read_done)
+		rreq->netfs_ops->rmw_read_done(wreq, rreq);
+
 error:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9d17d4bd9753..4049c985b9b4 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -220,6 +220,7 @@ enum netfs_io_origin {
 	NETFS_READ_GAPS,		/* This read is a synchronous read to fill gaps */
 	NETFS_READ_SINGLE,		/* This read should be treated as a single object */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_UNBUFFERED_READ,		/* This is an unbuffered I/O read */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITEBACK_SINGLE,		/* This monolithic write was triggered by writepages */
@@ -308,6 +309,9 @@ struct netfs_io_request {
 #define NETFS_RREQ_CONTENT_ENCRYPTION	16	/* Content encryption is in use */
 #define NETFS_RREQ_CRYPT_IN_PLACE	17	/* Do decryption in place */
 #define NETFS_RREQ_PUT_RMW_TAIL		18	/* Need to put ->rmw_tail */
+#define NETFS_RREQ_RMW			19	/* Performing RMW cycle */
+#define NETFS_RREQ_REPEAT_RMW		20	/* Need to perform an RMW cycle */
+#define NETFS_RREQ_NO_READ_HOLE		21	/* Give short read/error if hole encountered */
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
@@ -336,6 +340,7 @@ struct netfs_request_ops {
 	/* Modification handling */
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
 	void (*post_modify)(struct inode *inode, void *fs_priv);
+	void (*rmw_read_done)(struct netfs_io_request *wreq, struct netfs_io_request *rreq);
 
 	/* Write request handling */
 	void (*begin_writeback)(struct netfs_io_request *wreq);
@@ -432,6 +437,8 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t netfs_buffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t netfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t netfs_unbuffered_read_from_inode(struct inode *inode, loff_t pos,
+					 struct iov_iter *iter, bool nohole);
 
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 74af82d773bd..9254c6f0e604 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -23,6 +23,7 @@
 	EM(netfs_read_trace_read_gaps,		"READ-GAPS")	\
 	EM(netfs_read_trace_read_single,	"READ-SNGL")	\
 	EM(netfs_read_trace_prefetch_for_write,	"PREFETCHW")	\
+	EM(netfs_read_trace_unbuffered_read_from_inode, "READ-INOD") \
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_write_traces					\
@@ -38,6 +39,7 @@
 	EM(NETFS_READ_GAPS,			"RG")		\
 	EM(NETFS_READ_SINGLE,			"R1")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	EM(NETFS_UNBUFFERED_READ,		"UR")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITEBACK_SINGLE,		"W1")		\
@@ -104,6 +106,7 @@
 	EM(netfs_sreq_trace_io_progress,	"IO   ")	\
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_need_clear,		"N-CLR")	\
+	EM(netfs_sreq_trace_need_rmw,		"N-RMW")	\
 	EM(netfs_sreq_trace_partial_read,	"PARTR")	\
 	EM(netfs_sreq_trace_need_retry,		"ND-RT")	\
 	EM(netfs_sreq_trace_pending,		"PEND ")	\


