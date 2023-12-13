Return-Path: <linux-fsdevel+bounces-5916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF0811666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C76B208CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1628B35F05;
	Wed, 13 Dec 2023 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSvf05To"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF412F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XI1xSoIOgSiowLypR6weaVQC9UtzbtGS+yNMugVydM=;
	b=TSvf05ToD31/brKWrG2IDVeUUvs20tyOP9RQKCOTfbyg2mC+9yhnM0ACxS4vSsGlBCtUpa
	k4FTxAgF1jshCnuhR0gb2lIsNG5y1D30tskQnZQcnx3142b30wtMprGpiW+XPGiRTQ7nBT
	q2/XZXpf8Bro2SkiO/bwW70ZAmRhix4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-oSg6gETKO86pTc99K02n8A-1; Wed, 13 Dec 2023 10:24:12 -0500
X-MC-Unique: oSg6gETKO86pTc99K02n8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF8FF863017;
	Wed, 13 Dec 2023 15:24:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 213A01C060B1;
	Wed, 13 Dec 2023 15:24:08 +0000 (UTC)
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
Subject: [PATCH v4 04/39] netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink
Date: Wed, 13 Dec 2023 15:23:14 +0000
Message-ID: <20231213152350.431591-5-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Rename /proc/fs/fscache to "netfs" and make a symlink from fscache to that.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---
 fs/netfs/fscache_main.c  |  8 ++------
 fs/netfs/fscache_proc.c  | 23 ++++++++---------------
 fs/netfs/fscache_stats.c |  4 +---
 fs/netfs/internal.h      | 12 +++++++++++-
 fs/netfs/main.c          | 33 +++++++++++++++++++++++++++++++++
 fs/netfs/stats.c         | 13 +++++++------
 include/linux/netfs.h    |  1 -
 7 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
index 00600a4d9ce5..42e98bb523e3 100644
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -62,7 +62,7 @@ unsigned int fscache_hash(unsigned int salt, const void *data, size_t len)
 /*
  * initialise the fs caching module
  */
-static int __init fscache_init(void)
+int __init fscache_init(void)
 {
 	int ret = -ENOMEM;
 
@@ -94,12 +94,10 @@ static int __init fscache_init(void)
 	return ret;
 }
 
-fs_initcall(fscache_init);
-
 /*
  * clean up on module removal
  */
-static void __exit fscache_exit(void)
+void __exit fscache_exit(void)
 {
 	_enter("");
 
@@ -108,5 +106,3 @@ static void __exit fscache_exit(void)
 	destroy_workqueue(fscache_wq);
 	pr_notice("FS-Cache unloaded\n");
 }
-
-module_exit(fscache_exit);
diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
index dc3b0e9c8cce..ecd0d1edafaa 100644
--- a/fs/netfs/fscache_proc.c
+++ b/fs/netfs/fscache_proc.c
@@ -12,41 +12,34 @@
 #include "internal.h"
 
 /*
- * initialise the /proc/fs/fscache/ directory
+ * Add files to /proc/fs/netfs/.
  */
 int __init fscache_proc_init(void)
 {
-	if (!proc_mkdir("fs/fscache", NULL))
-		goto error_dir;
+	if (!proc_symlink("fs/fscache", NULL, "../netfs"))
+		goto error_sym;
 
-	if (!proc_create_seq("fs/fscache/caches", S_IFREG | 0444, NULL,
+	if (!proc_create_seq("fs/netfs/caches", S_IFREG | 0444, NULL,
 			     &fscache_caches_seq_ops))
 		goto error;
 
-	if (!proc_create_seq("fs/fscache/volumes", S_IFREG | 0444, NULL,
+	if (!proc_create_seq("fs/netfs/volumes", S_IFREG | 0444, NULL,
 			     &fscache_volumes_seq_ops))
 		goto error;
 
-	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
+	if (!proc_create_seq("fs/netfs/cookies", S_IFREG | 0444, NULL,
 			     &fscache_cookies_seq_ops))
 		goto error;
-
-#ifdef CONFIG_FSCACHE_STATS
-	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
-				fscache_stats_show))
-		goto error;
-#endif
-
 	return 0;
 
 error:
 	remove_proc_entry("fs/fscache", NULL);
-error_dir:
+error_sym:
 	return -ENOMEM;
 }
 
 /*
- * clean up the /proc/fs/fscache/ directory
+ * Clean up the /proc/fs/fscache symlink.
  */
 void fscache_proc_cleanup(void)
 {
diff --git a/fs/netfs/fscache_stats.c b/fs/netfs/fscache_stats.c
index fc94e5e79f1c..aad812ead398 100644
--- a/fs/netfs/fscache_stats.c
+++ b/fs/netfs/fscache_stats.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(fscache_n_culled);
 /*
  * display the general statistics
  */
-int fscache_stats_show(struct seq_file *m, void *v)
+int fscache_stats_show(struct seq_file *m)
 {
 	seq_puts(m, "FS-Cache statistics\n");
 	seq_printf(m, "Cookies: n=%d v=%d vcol=%u voom=%u\n",
@@ -96,7 +96,5 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "IO     : rd=%u wr=%u\n",
 		   atomic_read(&fscache_n_read),
 		   atomic_read(&fscache_n_write));
-
-	netfs_stats_show(m);
 	return 0;
 }
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 43769ac606e8..a15fe67e1db7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -76,6 +76,7 @@ extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
 
+int netfs_stats_show(struct seq_file *m, void *v);
 
 static inline void netfs_stat(atomic_t *stat)
 {
@@ -166,6 +167,13 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
  * fscache-main.c
  */
 extern unsigned int fscache_hash(unsigned int salt, const void *data, size_t len);
+#ifdef CONFIG_PROC_FS
+int __init fscache_init(void);
+void __exit fscache_exit(void);
+#else
+static inline int fscache_init(void) { return 0; }
+static inline void fscache_exit(void) {}
+#endif
 
 /*
  * fscache-proc.c
@@ -216,12 +224,14 @@ static inline void fscache_stat_d(atomic_t *stat)
 
 #define __fscache_stat(stat) (stat)
 
-int fscache_stats_show(struct seq_file *m, void *v);
+int fscache_stats_show(struct seq_file *m);
 #else
 
 #define __fscache_stat(stat) (NULL)
 #define fscache_stat(stat) do {} while (0)
 #define fscache_stat_d(stat) do {} while (0)
+
+static inline int fscache_stats_show(struct seq_file *m) { return 0; }
 #endif
 
 /*
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 1ba8091fcf3e..c9af6e0896d3 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -7,6 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/export.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include "internal.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/netfs.h>
@@ -19,3 +21,34 @@ unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
+static int __init netfs_init(void)
+{
+	int ret = -ENOMEM;
+
+	if (!proc_mkdir("fs/netfs", NULL))
+		goto error;
+
+#ifdef CONFIG_FSCACHE_STATS
+	if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
+				netfs_stats_show))
+		goto error_proc;
+#endif
+
+	ret = fscache_init();
+	if (ret < 0)
+		goto error_proc;
+	return 0;
+
+error_proc:
+	remove_proc_entry("fs/netfs", NULL);
+error:
+	return ret;
+}
+fs_initcall(netfs_init);
+
+static void __exit netfs_exit(void)
+{
+	fscache_exit();
+	remove_proc_entry("fs/netfs", NULL);
+}
+module_exit(netfs_exit);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5510a7a14a40..6025dc485f7e 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -28,31 +28,32 @@ atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
 
-void netfs_stats_show(struct seq_file *m)
+int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "RdHelp : RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
+	seq_printf(m, "Netfs  : RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip),
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq));
-	seq_printf(m, "RdHelp : ZR=%u sh=%u sk=%u\n",
+	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),
 		   atomic_read(&netfs_n_rh_write_zskip));
-	seq_printf(m, "RdHelp : DL=%u ds=%u df=%u di=%u\n",
+	seq_printf(m, "Netfs  : DL=%u ds=%u df=%u di=%u\n",
 		   atomic_read(&netfs_n_rh_download),
 		   atomic_read(&netfs_n_rh_download_done),
 		   atomic_read(&netfs_n_rh_download_failed),
 		   atomic_read(&netfs_n_rh_download_instead));
-	seq_printf(m, "RdHelp : RD=%u rs=%u rf=%u\n",
+	seq_printf(m, "Netfs  : RD=%u rs=%u rf=%u\n",
 		   atomic_read(&netfs_n_rh_read),
 		   atomic_read(&netfs_n_rh_read_done),
 		   atomic_read(&netfs_n_rh_read_failed));
-	seq_printf(m, "RdHelp : WR=%u ws=%u wf=%u\n",
+	seq_printf(m, "Netfs  : WR=%u ws=%u wf=%u\n",
 		   atomic_read(&netfs_n_rh_write),
 		   atomic_read(&netfs_n_rh_write_done),
 		   atomic_read(&netfs_n_rh_write_failed));
+	return fscache_stats_show(m);
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d294ff8f9ae4..9bd91cd615d5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -294,7 +294,6 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  bool was_async, enum netfs_sreq_ref_trace what);
-void netfs_stats_show(struct seq_file *);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


