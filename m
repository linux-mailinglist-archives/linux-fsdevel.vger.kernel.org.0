Return-Path: <linux-fsdevel+bounces-3083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9C7EFA6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD6281446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367D4777C;
	Fri, 17 Nov 2023 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8+CLaEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E4C1BEB
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmfXBVlMsm2chMbQyKBBe8+lheiIqsV1CsACyw5IYTE=;
	b=G8+CLaEN5GUWuUon9x7A9xj3+E0dXjmU+tH49v6eClDaaEyQXAc5nFa+3WILYRlvtaYRN1
	Mu9N8d9t6BB+lJwfXcu+EktCX4Z3aw0Ir05qhNGwtcStw1oLCsKJ5mFD7QMjE+eHFm2Ron
	RhwG+UbiJsECBt45nNuP209eVcFcumM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-e8H8Un-WMimv7o6BGwG5zw-1; Fri, 17 Nov 2023 16:18:04 -0500
X-MC-Unique: e8H8Un-WMimv7o6BGwG5zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77ACD185A784;
	Fri, 17 Nov 2023 21:18:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBCAC5036;
	Fri, 17 Nov 2023 21:18:00 +0000 (UTC)
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
Subject: [PATCH v2 34/51] netfs: Decrypt encrypted content
Date: Fri, 17 Nov 2023 21:15:26 +0000
Message-ID: <20231117211544.1740466-35-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Implement a facility to provide decryption for encrypted content to a whole
read-request in one go (which might have been stitched together from
disparate sources with divisions that don't match page boundaries).

Note that this doesn't necessarily gain the best throughput if the crypto
block size is equal to or less than the size of a page (in which case we
might be better doing it as pages become read), but it will handle crypto
blocks larger than the size of a page.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/crypto.c            | 59 ++++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |  1 +
 fs/netfs/io.c                |  6 +++-
 include/linux/netfs.h        |  3 ++
 include/trace/events/netfs.h |  2 ++
 5 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/crypto.c b/fs/netfs/crypto.c
index 943d01f430e2..6729bcda4f47 100644
--- a/fs/netfs/crypto.c
+++ b/fs/netfs/crypto.c
@@ -87,3 +87,62 @@ bool netfs_encrypt(struct netfs_io_request *wreq)
 	wreq->error = ret;
 	return false;
 }
+
+/*
+ * Decrypt the result of a read request.
+ */
+void netfs_decrypt(struct netfs_io_request *rreq)
+{
+	struct netfs_inode *ctx = netfs_inode(rreq->inode);
+	struct scatterlist source_sg[16], dest_sg[16];
+	unsigned int n_source;
+	size_t n, chunk, bsize = 1UL << ctx->crypto_bshift;
+	loff_t pos;
+	int ret;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_decrypt);
+	if (rreq->start >= rreq->i_size)
+		return;
+
+	n = min_t(unsigned long long, rreq->len, rreq->i_size - rreq->start);
+
+	_debug("DECRYPT %llx-%llx f=%lx",
+	       rreq->start, rreq->start + n, rreq->flags);
+
+	pos = rreq->start;
+	for (; n > 0; n -= chunk, pos += chunk) {
+		chunk = min(n, bsize);
+
+		ret = netfs_iter_to_sglist(&rreq->io_iter, chunk,
+					   source_sg, ARRAY_SIZE(source_sg));
+		if (ret < 0)
+			goto error;
+		n_source = ret;
+
+		if (test_bit(NETFS_RREQ_CRYPT_IN_PLACE, &rreq->flags)) {
+			ret = ctx->ops->decrypt_block(rreq, pos, chunk,
+						      source_sg, n_source,
+						      source_sg, n_source);
+		} else {
+			ret = netfs_iter_to_sglist(&rreq->iter, chunk,
+						   dest_sg, ARRAY_SIZE(dest_sg));
+			if (ret < 0)
+				goto error;
+			ret = ctx->ops->decrypt_block(rreq, pos, chunk,
+						      source_sg, n_source,
+						      dest_sg, ret);
+		}
+
+		if (ret < 0)
+			goto error_failed;
+	}
+
+	return;
+
+error_failed:
+	trace_netfs_failure(rreq, NULL, ret, netfs_fail_decryption);
+error:
+	rreq->error = ret;
+	set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+	return;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d3e74ad478ce..fbecfd9b3174 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -26,6 +26,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
  * crypto.c
  */
 bool netfs_encrypt(struct netfs_io_request *wreq);
+void netfs_decrypt(struct netfs_io_request *rreq);
 
 /*
  * direct_write.c
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 36a3f720193a..9887b22e4cb3 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -398,6 +398,9 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 		return;
 	}
 
+	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags))
+		netfs_decrypt(rreq);
 	if (rreq->origin != NETFS_DIO_READ)
 		netfs_rreq_unlock_folios(rreq);
 	else
@@ -427,7 +430,8 @@ static void netfs_rreq_work(struct work_struct *work)
 static void netfs_rreq_terminated(struct netfs_io_request *rreq,
 				  bool was_async)
 {
-	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
+	if ((test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) ||
+	     test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags)) &&
 	    was_async) {
 		if (!queue_work(system_unbound_wq, &rreq->work))
 			BUG();
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 639f1f9cb7e0..364361cc93be 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -327,6 +327,9 @@ struct netfs_request_ops {
 	int (*encrypt_block)(struct netfs_io_request *wreq, loff_t pos, size_t len,
 			     struct scatterlist *source_sg, unsigned int n_source,
 			     struct scatterlist *dest_sg, unsigned int n_dest);
+	int (*decrypt_block)(struct netfs_io_request *rreq, loff_t pos, size_t len,
+			     struct scatterlist *source_sg, unsigned int n_source,
+			     struct scatterlist *dest_sg, unsigned int n_dest);
 };
 
 /*
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 70e2f9a48f24..2f35057602fa 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -40,6 +40,7 @@
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
+	EM(netfs_rreq_trace_decrypt,		"DECRYPT")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_encrypt,		"ENCRYPT")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
@@ -75,6 +76,7 @@
 #define netfs_failures							\
 	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
 	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
+	EM(netfs_fail_decryption,		"decryption")		\
 	EM(netfs_fail_dio_read_short,		"dio-read-short")	\
 	EM(netfs_fail_dio_read_zero,		"dio-read-zero")	\
 	EM(netfs_fail_encryption,		"encryption")		\


