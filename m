Return-Path: <linux-fsdevel+bounces-311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936D7C8A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D701F2138E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5722C845;
	Fri, 13 Oct 2023 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyCYX1aD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176020B1D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:07:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920AC2D7C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBU+evKYv1DNx1iSvDhlzRDqOL3+5VRS9ZOU8xNhh8s=;
	b=gyCYX1aDb4aWaa9k7X010ramGHoWnEASVKCxNt/EM6SVfrZU7AVhIM+LuFOrR26rUekWH6
	38gIUwFspT+Pf6vY4k0YvWpDYIN1pkZ9OcjAQJ/FIpIExRReSTo4deUXKtR8PCcatYSWx/
	aGdpORGdr26cNTbFMnhuZzrPFTqdEwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-SPuFm4d-NGGsRvCeqTD79g-1; Fri, 13 Oct 2023 12:06:49 -0400
X-MC-Unique: SPuFm4d-NGGsRvCeqTD79g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A8E088B7A1;
	Fri, 13 Oct 2023 16:06:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 661D91C060DF;
	Fri, 13 Oct 2023 16:06:29 +0000 (UTC)
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
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 36/53] netfs: Decrypt encrypted content
Date: Fri, 13 Oct 2023 17:04:05 +0100
Message-ID: <20231013160423.2218093-37-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 3f4e64968623..8dc68a75d6cd 100644
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
index cdb471938225..524e6f5ff3fd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -326,6 +326,9 @@ struct netfs_request_ops {
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


