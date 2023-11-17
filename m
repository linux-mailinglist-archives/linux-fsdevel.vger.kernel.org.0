Return-Path: <linux-fsdevel+bounces-3075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5A7EFA3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383A51F27BCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAB54F82;
	Fri, 17 Nov 2023 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6ghOiap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB511BC5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsCXZYi8G6brqu2iwUxtHCsIIj0ZKZC/tTA2dXo92P0=;
	b=S6ghOiaptWf8mAJ9plAqNK5onF2E5gUYIk2cTyHm2a8DsifLSZO18e8fIZxmZfTzUrtnCG
	fAuHb4vs55oiLGqzTwF1sEuyUlX9N7W9rv8Xk52IkU/MQDl/iEtNUITxmhLIj7WtLk2qkQ
	QqTm8GBeMpAyAP80RQJIg/svgxhasbM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-flao8ClKNU-_2gpvXRsFBA-1; Fri,
 17 Nov 2023 16:16:51 -0500
X-MC-Unique: flao8ClKNU-_2gpvXRsFBA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0E3028040C0;
	Fri, 17 Nov 2023 21:16:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44D6B492BE0;
	Fri, 17 Nov 2023 21:16:47 +0000 (UTC)
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
Subject: [PATCH v2 18/51] fscache: Add a function to begin an cache op from a netfslib request
Date: Fri, 17 Nov 2023 21:15:10 +0000
Message-ID: <20231117211544.1740466-19-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Add a function to begin an cache read or write operation from a netfslib
I/O request.  This function can then be pointed to directly by the network
filesystem's netfs_request_ops::begin_cache_operation op pointer.

Ideally, netfslib would just call into fscache directly, but that would
cause dependency cycles as fscache calls into netfslib directly.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_addr.c        | 18 ++----------------
 fs/afs/file.c           | 14 +-------------
 fs/ceph/addr.c          |  2 +-
 fs/ceph/cache.h         | 12 ------------
 fs/fscache/io.c         | 42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h |  6 ++++++
 6 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 18a666c43e4a..516572bad412 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -17,6 +17,7 @@
 #include <linux/swap.h>
 #include <linux/uio.h>
 #include <linux/netfs.h>
+#include <linux/fscache.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -82,25 +83,10 @@ static void v9fs_free_request(struct netfs_io_request *rreq)
 	p9_fid_put(fid);
 }
 
-/**
- * v9fs_begin_cache_operation - Begin a cache operation for a read
- * @rreq: The read request
- */
-static int v9fs_begin_cache_operation(struct netfs_io_request *rreq)
-{
-#ifdef CONFIG_9P_FSCACHE
-	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(rreq->inode));
-
-	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
-#else
-	return -ENOBUFS;
-#endif
-}
-
 const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
 	.free_request		= v9fs_free_request,
-	.begin_cache_operation	= v9fs_begin_cache_operation,
+	.begin_cache_operation	= fscache_begin_cache_operation,
 	.issue_read		= v9fs_issue_read,
 };
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index a7658fb2d7dc..490dbccf1710 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -359,18 +359,6 @@ static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 	return 0;
 }
 
-static int afs_begin_cache_operation(struct netfs_io_request *rreq)
-{
-#ifdef CONFIG_AFS_FSCACHE
-	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
-
-	return fscache_begin_read_operation(&rreq->cache_resources,
-					    afs_vnode_cache(vnode));
-#else
-	return -ENOBUFS;
-#endif
-}
-
 static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
 				 struct folio **foliop, void **_fsdata)
 {
@@ -387,7 +375,7 @@ static void afs_free_request(struct netfs_io_request *rreq)
 const struct netfs_request_ops afs_req_ops = {
 	.init_request		= afs_init_request,
 	.free_request		= afs_free_request,
-	.begin_cache_operation	= afs_begin_cache_operation,
+	.begin_cache_operation	= fscache_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
 	.issue_read		= afs_issue_read,
 };
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 03feb4dc6352..595bd774f046 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -489,7 +489,7 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 const struct netfs_request_ops ceph_netfs_ops = {
 	.init_request		= ceph_init_request,
 	.free_request		= ceph_netfs_free_request,
-	.begin_cache_operation	= ceph_begin_cache_operation,
+	.begin_cache_operation	= fscache_begin_cache_operation,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.clamp_length		= ceph_netfs_clamp_length,
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index dc502daac49a..b804f1094764 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -57,13 +57,6 @@ static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
 	return fscache_dirty_folio(mapping, folio, ceph_fscache_cookie(ci));
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
-{
-	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(rreq->inode));
-
-	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
-}
-
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
 	return fscache_cookie_enabled(ceph_fscache_cookie(ceph_inode(inode)));
@@ -135,11 +128,6 @@ static inline bool ceph_is_cache_enabled(struct inode *inode)
 	return false;
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
-{
-	return -ENOBUFS;
-}
-
 static inline void ceph_fscache_note_page_release(struct inode *inode)
 {
 }
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0d2b8dec8f82..cb602dd651e6 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -158,6 +158,48 @@ int __fscache_begin_write_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_write_operation);
 
+/**
+ * fscache_begin_cache_operation - Begin a cache op for netfslib
+ * @rreq: The netfs request that wants to access the cache.
+ *
+ * Begin an I/O operation on behalf of the netfs helper library, read or write.
+ * @rreq indicates the netfs operation that wishes to access the cache.
+ *
+ * This is intended to be pointed to directly by the ->begin_cache_operation()
+ * netfs lib operation for the network filesystem.
+ *
+ * @cres->inval_counter is set from @cookie->inval_counter for comparison at
+ * the end of the operation.  This allows invalidation during the operation to
+ * be detected by the caller.
+ *
+ * Returns:
+ * * 0		- Success
+ * * -ENOBUFS	- No caching available
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+int fscache_begin_cache_operation(struct netfs_io_request *rreq)
+{
+	struct netfs_inode *ctx = netfs_inode(rreq->inode);
+
+	switch (rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_FOR_WRITE:
+		return fscache_begin_operation(&rreq->cache_resources,
+					       netfs_i_cookie(ctx),
+					       FSCACHE_WANT_PARAMS,
+					       fscache_access_io_read);
+	case NETFS_WRITEBACK:
+		return fscache_begin_operation(&rreq->cache_resources,
+					       netfs_i_cookie(ctx),
+					       FSCACHE_WANT_PARAMS,
+					       fscache_access_io_write);
+	default:
+		return -ENOBUFS;
+	}
+}
+EXPORT_SYMBOL(fscache_begin_cache_operation);
+
 /**
  * fscache_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 8e312c8323a8..9c389adaf286 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -177,6 +177,12 @@ extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_spa
 				     bool);
 extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
 
+#if __fscache_available
+extern int fscache_begin_cache_operation(struct netfs_io_request *rreq);
+#else
+#define fscache_begin_cache_operation NULL
+#endif
+
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
  * @volume_key: An identification string for the volume


