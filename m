Return-Path: <linux-fsdevel+bounces-5917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C790811672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11458B20837
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED6364C1;
	Wed, 13 Dec 2023 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnWP4eQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A925BF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXclU2RwEHr6/zRJbfo0avpxB2MmbXmM1O7VqBArdhM=;
	b=ZnWP4eQJnK/EsHr2KjVCohhjzvlr5kTKHL9nu884DEzEXhMu5Nl38GehQHp7YkQhjGAH/4
	pReZSl21lHCJRzUCh08XX+X4cXHXba/RpvnRSGAyGWhF+vof+Q+XE+GjNzuY5g3xGC6q2r
	GuwaZZh9a3FscIvKB+AcU1u18OubmWw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-n_hhXb5pO6ysfAa7O8x7VQ-1; Wed,
 13 Dec 2023 10:24:19 -0500
X-MC-Unique: n_hhXb5pO6ysfAa7O8x7VQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 430E41C05B02;
	Wed, 13 Dec 2023 15:24:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C1982166B32;
	Wed, 13 Dec 2023 15:24:15 +0000 (UTC)
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
Subject: [PATCH v4 06/39] netfs: Add a procfile to list in-progress requests
Date: Wed, 13 Dec 2023 15:23:16 +0000
Message-ID: <20231213152350.431591-7-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add a procfile, /proc/fs/netfs/requests, to list in-progress netfslib I/O
requests.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h   | 22 ++++++++++++++
 fs/netfs/main.c       | 69 ++++++++++++++++++++++++++++++++++++++++++-
 fs/netfs/objects.c    |  4 ++-
 include/linux/netfs.h |  6 +++-
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a15fe67e1db7..937d9a22f178 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -33,6 +33,28 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
  * main.c
  */
 extern unsigned int netfs_debug;
+extern struct list_head netfs_io_requests;
+extern spinlock_t netfs_proc_lock;
+
+#ifdef CONFIG_PROC_FS
+static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
+{
+	spin_lock(&netfs_proc_lock);
+	list_add_tail_rcu(&rreq->proc_link, &netfs_io_requests);
+	spin_unlock(&netfs_proc_lock);
+}
+static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq)
+{
+	if (!list_empty(&rreq->proc_link)) {
+		spin_lock(&netfs_proc_lock);
+		list_del_rcu(&rreq->proc_link);
+		spin_unlock(&netfs_proc_lock);
+	}
+}
+#else
+static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
+static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
+#endif
 
 /*
  * objects.c
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index c9af6e0896d3..97ce1436615b 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -21,13 +21,80 @@ unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
+#ifdef CONFIG_PROC_FS
+LIST_HEAD(netfs_io_requests);
+DEFINE_SPINLOCK(netfs_proc_lock);
+
+static const char *netfs_origins[] = {
+	[NETFS_READAHEAD]	= "RA",
+	[NETFS_READPAGE]	= "RP",
+	[NETFS_READ_FOR_WRITE]	= "RW",
+};
+
+/*
+ * Generate a list of I/O requests in /proc/fs/netfs/requests
+ */
+static int netfs_requests_seq_show(struct seq_file *m, void *v)
+{
+	struct netfs_io_request *rreq;
+
+	if (v == &netfs_io_requests) {
+		seq_puts(m,
+			 "REQUEST  OR REF FL ERR  OPS COVERAGE\n"
+			 "======== == === == ==== === =========\n"
+			 );
+		return 0;
+	}
+
+	rreq = list_entry(v, struct netfs_io_request, proc_link);
+	seq_printf(m,
+		   "%08x %s %3d %2lx %4d %3d @%04llx %zx/%zx",
+		   rreq->debug_id,
+		   netfs_origins[rreq->origin],
+		   refcount_read(&rreq->ref),
+		   rreq->flags,
+		   rreq->error,
+		   atomic_read(&rreq->nr_outstanding),
+		   rreq->start, rreq->submitted, rreq->len);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static void *netfs_requests_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(rcu)
+{
+	rcu_read_lock();
+	return seq_list_start_head(&netfs_io_requests, *_pos);
+}
+
+static void *netfs_requests_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &netfs_io_requests, _pos);
+}
+
+static void netfs_requests_seq_stop(struct seq_file *m, void *v)
+	__releases(rcu)
+{
+	rcu_read_unlock();
+}
+
+static const struct seq_operations netfs_requests_seq_ops = {
+	.start  = netfs_requests_seq_start,
+	.next   = netfs_requests_seq_next,
+	.stop   = netfs_requests_seq_stop,
+	.show   = netfs_requests_seq_show,
+};
+#endif /* CONFIG_PROC_FS */
+
 static int __init netfs_init(void)
 {
 	int ret = -ENOMEM;
 
 	if (!proc_mkdir("fs/netfs", NULL))
 		goto error;
-
+	if (!proc_create_seq("fs/netfs/requests", S_IFREG | 0444, NULL,
+			     &netfs_requests_seq_ops))
+		goto error_proc;
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
 				netfs_stats_show))
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e17cdf53f6a7..85f428fc52e6 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -45,6 +45,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 		}
 	}
 
+	netfs_proc_add_rreq(rreq);
 	netfs_stat(&netfs_n_rh_rreq);
 	return rreq;
 }
@@ -76,12 +77,13 @@ static void netfs_free_request(struct work_struct *work)
 		container_of(work, struct netfs_io_request, work);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
+	netfs_proc_del_rreq(rreq);
 	netfs_clear_subrequests(rreq, false);
 	if (rreq->netfs_ops->free_request)
 		rreq->netfs_ops->free_request(rreq);
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	kfree(rreq);
+	kfree_rcu(rreq, rcu);
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 32faf6c89702..7244ddebd974 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -175,10 +175,14 @@ enum netfs_io_origin {
  * operations to a variety of data stores and then stitch the result together.
  */
 struct netfs_io_request {
-	struct work_struct	work;
+	union {
+		struct work_struct work;
+		struct rcu_head rcu;
+	};
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
 	struct netfs_cache_resources cache_resources;
+	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;


