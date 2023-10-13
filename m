Return-Path: <linux-fsdevel+bounces-297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7547C89EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8177428306E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DD21362;
	Fri, 13 Oct 2023 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL1fsf+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186521116
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:05:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3C196
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZnc3j734khDGwXznc6wh2xPv7mSRAABdKA6EQBsCg4=;
	b=CL1fsf+0FeAqna15xvLLLYQPuCo0G8tYoVARAULjBfWFE6pJojwI914bdNhIIpN96X/fr6
	aMwJCZ+R+6b8uBOcx3ELmENB2sLWCCXx1OTwwNE7QTLTwUIWruWzc2+8sfbAFHlFpfxjah
	Xp1x91bfXJeh37/DUUVTmqsoSOXlV3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-Jzb0pISoMpSdZfj-hqrYxg-1; Fri, 13 Oct 2023 12:05:24 -0400
X-MC-Unique: Jzb0pISoMpSdZfj-hqrYxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC5CF1C113E2;
	Fri, 13 Oct 2023 16:05:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BDEFC15BBC;
	Fri, 13 Oct 2023 16:05:21 +0000 (UTC)
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
Subject: [RFC PATCH 17/53] netfs: Extend the netfs_io_*request structs to handle writes
Date: Fri, 13 Oct 2023 17:03:46 +0100
Message-ID: <20231013160423.2218093-18-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 00e01278316f..46183dad4d50 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -109,6 +109,12 @@ extern atomic_t netfs_n_rh_write_begin;
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
index 9b965a509e5a..30ec42566966 100644
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
 	if (file && file->f_flags & O_NONBLOCK)
 		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
@@ -50,6 +54,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 		}
 	}
 
+	trace_netfs_rreq_ref(rreq->debug_id, 1, netfs_rreq_trace_new);
 	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
@@ -134,6 +139,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
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
index aaf1c1d4de51..4115274e3129 100644
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
 	unsigned int		direct_bv_count; /* Number of elements in bv[] */
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
+	unsigned int		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
@@ -223,6 +234,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_NONBLOCK		6	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		7	/* We blocked */
 #define NETFS_RREQ_USE_BOUNCE_BUFFER	8	/* Use bounce buffer */
+#define NETFS_RREQ_WRITE_TO_CACHE	9	/* Need to write to the cache */
+#define NETFS_RREQ_UPLOAD_TO_SERVER	10	/* Need to write to the server */
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


