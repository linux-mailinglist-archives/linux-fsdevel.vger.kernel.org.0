Return-Path: <linux-fsdevel+bounces-3098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E17EFABF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390B6B20F9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462294A985;
	Fri, 17 Nov 2023 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4OsFJDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654D35BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vexZJLzBIyyLPeX5Ek0LXizOmJkCJIbOd7D7U7LHKH0=;
	b=U4OsFJDnykKfFbMhtAPmSjYtqx/h76ggxOr0BjU5L8uOAxIcHD033xL7xzp4H+o4LA+1jO
	ybC+MM8DECeqVZ9P90VCa1wbXHGMi7AOa6VZWeFRzN4GwF6nf4MA1hVQxlZAjJBm/gqh9F
	hGzqU2ukJFiy2VxzoMOBHIbgc1T9ykQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DTQdvzYOMMuT2PyT53z6MA-1; Fri, 17 Nov 2023 16:18:01 -0500
X-MC-Unique: DTQdvzYOMMuT2PyT53z6MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13BC4811E8E;
	Fri, 17 Nov 2023 21:18:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73A471121307;
	Fri, 17 Nov 2023 21:17:57 +0000 (UTC)
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
Subject: [PATCH v2 33/51] netfs: Perform content encryption
Date: Fri, 17 Nov 2023 21:15:25 +0000
Message-ID: <20231117211544.1740466-34-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
index d5c2809fc029..5ea852ac276c 100644
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
index 4f0feedb357a..93e16f7caf67 100644
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
index edb94c437793..d3e74ad478ce 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -22,6 +22,11 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
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
index c1218b183197..6bf3b3f51499 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -44,6 +44,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (test_bit(NETFS_ICTX_ENCRYPTED, &ctx->flags))
+		__set_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags);
 	if (cached)
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 	if (file && file->f_flags & O_NONBLOCK)
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index bb42789c7a24..2d2530dc9507 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -366,7 +366,11 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
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
@@ -378,6 +382,7 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
 		ctx->ops->create_write_requests(wreq, wreq->start, wreq->len);
 
+out:
 	if (atomic_dec_and_test(&wreq->nr_outstanding))
 		netfs_write_terminated(wreq, false);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index cb80de66d165..639f1f9cb7e0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 
+struct scatterlist;
 enum netfs_sreq_ref_trace;
 
 /*
@@ -141,7 +142,9 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+#define NETFS_ICTX_ENCRYPTED	2		/* The file contents are encrypted */
 	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
+	unsigned char		crypto_bshift;	/* log2 of crypto block size */
 };
 
 /*
@@ -286,6 +289,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
+#define NETFS_RREQ_CONTENT_ENCRYPTION	11	/* Content encryption is in use */
+#define NETFS_RREQ_CRYPT_IN_PLACE	12	/* Enc/dec in place in ->io_iter */
 	const struct netfs_request_ops *netfs_ops;
 	void (*cleanup)(struct netfs_io_request *req);
 };
@@ -317,6 +322,11 @@ struct netfs_request_ops {
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
@@ -465,6 +475,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->zero_point = ctx->remote_i_size;
 	ctx->flags = 0;
 	ctx->min_bshift = 0;
+	ctx->crypto_bshift = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 60f98c99fe21..70e2f9a48f24 100644
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


