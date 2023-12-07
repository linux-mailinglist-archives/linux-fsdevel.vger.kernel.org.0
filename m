Return-Path: <linux-fsdevel+bounces-5238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546698095CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95B7B20D17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E457329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNFE21MJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517D3C3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5weY3TAEZXAYDCmBDEVYygYM1kFM1iNPdRbIVf5ORpg=;
	b=HNFE21MJOlfvCvf7jDrkofaQdJEvCJK4J4ZWEDCTJBiWd72Z/9l9UCdaiWWzppjMwX3CSd
	a1lk/kazpvev1PZnjhyLpHQ2Pglj2XuE4g0ohAOw4iSnRcptoPS1BFlLm6gToSJ6cRS75C
	5AsfdqSd/dSWs6BgYCyEmR+C/lIlG40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-qyXwTIyJO_uXXDNIGmcfsw-1; Thu, 07 Dec 2023 16:24:26 -0500
X-MC-Unique: qyXwTIyJO_uXXDNIGmcfsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A05CA870820;
	Thu,  7 Dec 2023 21:24:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 096233C2E;
	Thu,  7 Dec 2023 21:24:22 +0000 (UTC)
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
Subject: [PATCH v3 39/59] netfs: Support decryption on ubuffered/DIO read
Date: Thu,  7 Dec 2023 21:21:46 +0000
Message-ID: <20231207212206.1379128-40-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Support unbuffered and direct I/O reads from an encrypted file.  This may
require making a larger read than is required into a bounce buffer and
copying out the required bits.  We don't decrypt in-place in the user
buffer lest userspace interfere and muck up the decryption.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_read.c | 10 ++++++++++
 fs/netfs/internal.h    | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 52ad8fa66dd5..158719b56900 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -181,6 +181,16 @@ static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_
 		iov_iter_advance(iter, orig_count);
 	}
 
+	/* If we're going to do decryption or decompression, we're going to
+	 * need a bounce buffer - and if the data is misaligned for the crypto
+	 * algorithm, we decrypt in place and then copy.
+	 */
+	if (test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags)) {
+		if (!netfs_is_crypto_aligned(rreq, iter))
+			__set_bit(NETFS_RREQ_CRYPT_IN_PLACE, &rreq->flags);
+		__set_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags);
+	}
+
 	/* If we're going to use a bounce buffer, we need to set it up.  We
 	 * will then need to pad the request out to the minimum block size.
 	 */
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index b6c142ef996a..7180e2931189 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -198,6 +198,23 @@ static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
 		netfs_group->free(netfs_group);
 }
 
+/*
+ * Check to see if a buffer aligns with the crypto unit block size.  If it
+ * doesn't the crypto layer is going to copy all the data - in which case
+ * relying on the crypto op for a free copy is pointless.
+ */
+static inline bool netfs_is_crypto_aligned(struct netfs_io_request *rreq,
+					   struct iov_iter *iter)
+{
+	struct netfs_inode *ctx = netfs_inode(rreq->inode);
+	unsigned long align, mask = (1UL << ctx->min_bshift) - 1;
+
+	if (!ctx->min_bshift)
+		return true;
+	align = iov_iter_alignment(iter);
+	return (align & mask) == 0;
+}
+
 /*
  * fscache-cache.c
  */


