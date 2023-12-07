Return-Path: <linux-fsdevel+bounces-5240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F58095CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9BB1C20BBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0705730A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAfcnW+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2453C29
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RGhYTY83CzEEwD3sxxlcJDtqFoFg1xQiYrcAXYGcq4=;
	b=cAfcnW+pcMHrbl4Q+tgYfrxnZHeBlvi4FgCI9gTP+ZzTQKloRMf9yDMqkL6pg1Y1kfkgn+
	cWUFntfpGw4YOLdw3Vk/N4q9yzwbTqtFry4QfZcmPptoGcx1372o0VtJQ+L41lhDgDwowG
	x1FvNEpMs5scbwth7zo6eg31u8x7TT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-GP4ZXKzINJ2l4ohXuOv0Hw-1; Thu,
 07 Dec 2023 16:24:20 -0500
X-MC-Unique: GP4ZXKzINJ2l4ohXuOv0Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E987B386A0A1;
	Thu,  7 Dec 2023 21:24:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51189C15880;
	Thu,  7 Dec 2023 21:24:16 +0000 (UTC)
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
Subject: [PATCH v3 37/59] netfs: Perform content encryption
Date: Thu,  7 Dec 2023 21:21:44 +0000
Message-ID: <20231207212206.1379128-38-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

When dealing with an encrypted file, we gather together sufficient pages
from the pagecache to constitute a logical crypto block, allocate a bounce
buffer and then ask the filesystem to encrypt between the buffers.  The
bounce buffer is then passed to the filesystem to upload.

The network filesystem must set a flag to indicate what service is desired
and what the logical blocksize will be.

The netfs library iterates through each block to be processed, providing a
pair of scatterlists to describe the start and end buffers.

Note that it should be possible in future to encrypt DIO writes also by
this same mechanism.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/Makefile            |  1 +
 fs/netfs/buffered_write.c    |  3 +-
 fs/netfs/crypto.c            | 89 ++++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |  5 ++
 fs/netfs/objects.c           |  2 +
 fs/netfs/output.c            |  7 ++-
 include/linux/netfs.h        | 11 +++++
 include/trace/events/netfs.h |  2 +
 8 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 fs/netfs/crypto.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index d4d1d799819e..0c433fce15dc 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	buffered_read.o \
 	buffered_write.o \
+	crypto.o \
 	direct_read.o \
 	direct_write.o \
 	io.o \
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 8339e3f753af..bffa508945cb 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -77,7 +77,8 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 	if (!maybe_trouble && offset == 0 && len >= flen)
 		return NETFS_WHOLE_FOLIO_MODIFY;
 
-	if (file->f_mode & FMODE_READ)
+	if (file->f_mode & FMODE_READ ||
+	    test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags))
 		return NETFS_JUST_PREFETCH;
 
 	if (netfs_is_cache_enabled(ctx) ||
diff --git a/fs/netfs/crypto.c b/fs/netfs/crypto.c
new file mode 100644
index 000000000000..943d01f430e2
--- /dev/null
+++ b/fs/netfs/crypto.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem content encryption support.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include "internal.h"
+
+/*
+ * Populate a scatterlist from the next bufferage of an I/O iterator.
+ */
+static int netfs_iter_to_sglist(const struct iov_iter *iter, size_t len,
+				struct scatterlist *sg, unsigned int n_sg)
+{
+	struct iov_iter tmp_iter = *iter;
+	struct sg_table sgtable = { .sgl = sg };
+	ssize_t ret;
+
+	_enter("%zx/%zx", len, iov_iter_count(iter));
+
+	sg_init_table(sg, n_sg);
+	ret = extract_iter_to_sg(&tmp_iter, len, &sgtable, n_sg, 0);
+	if (ret < 0)
+		return ret;
+	sg_mark_end(&sg[sgtable.nents - 1]);
+	return sgtable.nents;
+}
+
+/*
+ * Prepare a write request for writing.  We encrypt in/into the bounce buffer.
+ */
+bool netfs_encrypt(struct netfs_io_request *wreq)
+{
+	struct netfs_inode *ctx = netfs_inode(wreq->inode);
+	struct scatterlist source_sg[16], dest_sg[16];
+	unsigned int n_dest;
+	size_t n, chunk, bsize = 1UL << ctx->crypto_bshift;
+	loff_t pos;
+	int ret;
+
+	_enter("");
+
+	trace_netfs_rreq(wreq, netfs_rreq_trace_encrypt);
+
+	pos = wreq->start;
+	n = wreq->len;
+	_debug("ENCRYPT %llx-%llx", pos, pos + n - 1);
+
+	for (; n > 0; n -= chunk, pos += chunk) {
+		chunk = min(n, bsize);
+
+		ret = netfs_iter_to_sglist(&wreq->io_iter, chunk,
+					   dest_sg, ARRAY_SIZE(dest_sg));
+		if (ret < 0)
+			goto error;
+		n_dest = ret;
+
+		if (test_bit(NETFS_RREQ_CRYPT_IN_PLACE, &wreq->flags)) {
+			ret = ctx->ops->encrypt_block(wreq, pos, chunk,
+						      dest_sg, n_dest,
+						      dest_sg, n_dest);
+		} else {
+			ret = netfs_iter_to_sglist(&wreq->iter, chunk,
+						   source_sg, ARRAY_SIZE(source_sg));
+			if (ret < 0)
+				goto error;
+			ret = ctx->ops->encrypt_block(wreq, pos, chunk,
+						      source_sg, ret,
+						      dest_sg, n_dest);
+		}
+
+		if (ret < 0)
+			goto error_failed;
+	}
+
+	return true;
+
+error_failed:
+	trace_netfs_failure(wreq, NULL, ret, netfs_fail_encryption);
+error:
+	wreq->error = ret;
+	return false;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ae7a6aedc7cb..9412ec886df1 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -26,6 +26,11 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
+/*
+ * crypto.c
+ */
+bool netfs_encrypt(struct netfs_io_request *wreq);
+
 /*
  * direct_write.c
  */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 16252cc4576e..8e4585216fc7 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -45,6 +45,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags))
+		__set_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags);
 	if (cached)
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 	if (file && file->f_flags & O_NONBLOCK)
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index cc9065733b42..c0ac3ac57861 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -364,7 +364,11 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 	 * background whilst we generate a list of write ops that we want to
 	 * perform.
 	 */
-	// TODO: Encrypt or compress the region as appropriate
+	if (test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &wreq->flags) &&
+	    !netfs_encrypt(wreq)) {
+		may_wait = true;
+		goto out;
+	}
 
 	/* We need to write all of the region to the cache */
 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
@@ -376,6 +380,7 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
 		ctx->ops->create_write_requests(wreq, wreq->start, wreq->len);
 
+out:
 	if (atomic_dec_and_test(&wreq->nr_outstanding))
 		netfs_write_terminated(wreq, false);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 69ff5d652931..c2985f73d870 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 
+struct scatterlist;
 enum netfs_sreq_ref_trace;
 
 /*
@@ -139,7 +140,9 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+#define NETFS_ICTX_ENCRYPTED	2		/* The file contents are encrypted */
 	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
+	unsigned char		crypto_bshift;	/* log2 of crypto block size */
 };
 
 /*
@@ -285,6 +288,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
+#define NETFS_RREQ_CONTENT_ENCRYPTION	11	/* Content encryption is in use */
+#define NETFS_RREQ_CRYPT_IN_PLACE	12	/* Enc/dec in place in ->io_iter */
 	const struct netfs_request_ops *netfs_ops;
 	void (*cleanup)(struct netfs_io_request *req);
 };
@@ -315,6 +320,11 @@ struct netfs_request_ops {
 	void (*create_write_requests)(struct netfs_io_request *wreq,
 				      loff_t start, size_t len);
 	void (*invalidate_cache)(struct netfs_io_request *wreq);
+
+	/* Content encryption */
+	int (*encrypt_block)(struct netfs_io_request *wreq, loff_t pos, size_t len,
+			     struct scatterlist *source_sg, unsigned int n_source,
+			     struct scatterlist *dest_sg, unsigned int n_dest);
 };
 
 /*
@@ -464,6 +474,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->remote_i_size = i_size_read(&ctx->inode);
 	ctx->flags = 0;
 	ctx->min_bshift = 0;
+	ctx->crypto_bshift = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 914a24b03d08..3f50819613e2 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -41,6 +41,7 @@
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_encrypt,		"ENCRYPT")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
@@ -76,6 +77,7 @@
 	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
 	EM(netfs_fail_dio_read_short,		"dio-read-short")	\
 	EM(netfs_fail_dio_read_zero,		"dio-read-zero")	\
+	EM(netfs_fail_encryption,		"encryption")		\
 	EM(netfs_fail_read,			"read")			\
 	EM(netfs_fail_short_read,		"short-read")		\
 	EM(netfs_fail_prepare_write,		"prep-write")		\


