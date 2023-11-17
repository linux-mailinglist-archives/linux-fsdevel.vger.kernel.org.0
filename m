Return-Path: <linux-fsdevel+bounces-3067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2BE7EFA09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEDC1C20AFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15451C3F;
	Fri, 17 Nov 2023 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjM8KE8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802A1BF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XsFLz2EuWELNmn/3ReHo183WyKRFTXnu6c6UxVP0+4=;
	b=HjM8KE8H++1/EFqLj+on7MkKP4e9JJLXriRKMu6wA7y+A/GqC9TF33OWqNXC0Aer/2Git8
	V889daDBBrUv++Piu0erM3YG5pooRhiKSz9+RfLP3K5H7seRTay/E+izkXJG4O/y7KtdqW
	VwP1rfKMXQ7RQJS/5WYgGyDe+MOxmPQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-dqR4t2aNOMGgKR3V1feRag-1; Fri,
 17 Nov 2023 16:16:41 -0500
X-MC-Unique: dqR4t2aNOMGgKR3V1feRag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD4B13C025D3;
	Fri, 17 Nov 2023 21:16:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC5340C6EBC;
	Fri, 17 Nov 2023 21:16:37 +0000 (UTC)
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
Subject: [PATCH v2 15/51] netfs: Extend the netfs_io_*request structs to handle writes
Date: Fri, 17 Nov 2023 21:15:07 +0000
Message-ID: <20231117211544.1740466-16-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Modify the netfs_io_request struct to act as a point around which writes
can be coordinated.  It represents and pins a range of pages that need
writing and a list of regions of dirty data in that range of pages.

If RMW is required, the original data can be downloaded into the bounce
buffer, decrypted if necessary, the modifications made, then the modified
data can be reencrypted/recompressed and sent back to the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h          |  6 ++++++
 fs/netfs/main.c              |  3 ++-
 fs/netfs/objects.c           |  6 ++++++
 fs/netfs/stats.c             | 18 ++++++++++++++----
 include/linux/netfs.h        | 15 ++++++++++++++-
 include/trace/events/netfs.h |  8 ++++++--
 6 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 21a47f118009..3a920377b01f 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -106,6 +106,12 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_upload;
+extern atomic_t netfs_n_wh_upload_done;
+extern atomic_t netfs_n_wh_upload_failed;
+extern atomic_t netfs_n_wh_write;
+extern atomic_t netfs_n_wh_write_done;
+extern atomic_t netfs_n_wh_write_failed;
 
 
 static inline void netfs_stat(atomic_t *stat)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 0f0c6e70aa44..e990738c2213 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -28,10 +28,11 @@ MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 LIST_HEAD(netfs_io_requests);
 DEFINE_SPINLOCK(netfs_proc_lock);
 
-static const char *netfs_origins[] = {
+static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]	= "RA",
 	[NETFS_READPAGE]	= "RP",
 	[NETFS_READ_FOR_WRITE]	= "RW",
+	[NETFS_WRITEBACK]	= "WB",
 };
 
 /*
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index a7947e82374a..7ef804e8915c 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,6 +20,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_inode *ctx = netfs_inode(inode);
 	struct netfs_io_request *rreq;
+	bool cached = netfs_is_cache_enabled(ctx);
 	int ret;
 
 	rreq = kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_request),
@@ -38,7 +39,10 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	xa_init(&rreq->bounce);
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
+
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	if (cached)
+		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
@@ -48,6 +52,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 		}
 	}
 
+	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
 	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
@@ -132,6 +137,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 			 sizeof(struct netfs_io_subrequest),
 			 GFP_KERNEL);
 	if (subreq) {
+		INIT_WORK(&subreq->work, NULL);
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->ref, 2);
 		subreq->rreq = rreq;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5510a7a14a40..ce2a1a983280 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -27,6 +27,12 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_upload;
+atomic_t netfs_n_wh_upload_done;
+atomic_t netfs_n_wh_upload_failed;
+atomic_t netfs_n_wh_write;
+atomic_t netfs_n_wh_write_done;
+atomic_t netfs_n_wh_write_failed;
 
 void netfs_stats_show(struct seq_file *m)
 {
@@ -50,9 +56,13 @@ void netfs_stats_show(struct seq_file *m)
 		   atomic_read(&netfs_n_rh_read),
 		   atomic_read(&netfs_n_rh_read_done),
 		   atomic_read(&netfs_n_rh_read_failed));
-	seq_printf(m, "RdHelp : WR=%u ws=%u wf=%u\n",
-		   atomic_read(&netfs_n_rh_write),
-		   atomic_read(&netfs_n_rh_write_done),
-		   atomic_read(&netfs_n_rh_write_failed));
+	seq_printf(m, "WrHelp : UL=%u us=%u uf=%u\n",
+		   atomic_read(&netfs_n_wh_upload),
+		   atomic_read(&netfs_n_wh_upload_done),
+		   atomic_read(&netfs_n_wh_upload_failed));
+	seq_printf(m, "WrHelp : WR=%u ws=%u wf=%u\n",
+		   atomic_read(&netfs_n_wh_write),
+		   atomic_read(&netfs_n_wh_write_done),
+		   atomic_read(&netfs_n_wh_write_failed));
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 20ddd46fa0bc..62b768260eda 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -118,6 +118,9 @@ enum netfs_io_source {
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
 	NETFS_INVALID_READ,
+	NETFS_UPLOAD_TO_SERVER,
+	NETFS_WRITE_TO_CACHE,
+	NETFS_INVALID_WRITE,
 } __mode(byte);
 
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
@@ -151,9 +154,14 @@ struct netfs_cache_resources {
 };
 
 /*
- * Descriptor for a single component subrequest.
+ * Descriptor for a single component subrequest.  Each operation represents an
+ * individual read/write from/to a server, a cache, a journal, etc..
+ *
+ * The buffer iterator is persistent for the life of the subrequest struct and
+ * the pages it points to can be relied on to exist for the duration.
  */
 struct netfs_io_subrequest {
+	struct work_struct	work;
 	struct netfs_io_request *rreq;		/* Supervising I/O request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
@@ -178,6 +186,8 @@ enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
+	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	nr__netfs_io_origin
 } __mode(byte);
 
 /*
@@ -202,6 +212,7 @@ struct netfs_io_request {
 	__counted_by(direct_bv_count);
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
+	unsigned int		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
@@ -221,6 +232,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
 #define NETFS_RREQ_USE_BOUNCE_BUFFER	6	/* Use bounce buffer */
+#define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
+#define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 	const struct netfs_request_ops *netfs_ops;
 };
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fce6d0bc78e5..4ea4e34d279f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -24,7 +24,8 @@
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
-	E_(NETFS_READ_FOR_WRITE,		"RW")
+	EM(NETFS_READ_FOR_WRITE,		"RW")		\
+	E_(NETFS_WRITEBACK,			"WB")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
@@ -39,7 +40,10 @@
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
 	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\
-	E_(NETFS_INVALID_READ,			"INVL")		\
+	EM(NETFS_INVALID_READ,			"INVL")		\
+	EM(NETFS_UPLOAD_TO_SERVER,		"UPLD")		\
+	EM(NETFS_WRITE_TO_CACHE,		"WRIT")		\
+	E_(NETFS_INVALID_WRITE,			"INVL")
 
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\


