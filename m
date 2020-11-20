Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC212BAE1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgKTPNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbgKTPNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0q1FPl1J1kXlixzwocU0y2DdbR7NJYQ0Tf3Rxq3Vr4=;
        b=fWoOl8aFbX5ykR1nGwOIlA0uvg6ifmLl0Ej0ynGEF0ZtZ1VFl2wmWs2Ir8PVZaymZDjBCv
        XJU+HBONsCHr0PdA48YYU4yFq2/YouHDgqXhxxAQ/rUTJWtU/D+h7NqG3rhwCkBRWVkXlE
        hKh1xRMtE+nXxIz6vh7ncmt+CZ7A18Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-pqUjrqaWN-acbBbkDJIREQ-1; Fri, 20 Nov 2020 10:13:12 -0500
X-MC-Unique: pqUjrqaWN-acbBbkDJIREQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8B67107AD30;
        Fri, 20 Nov 2020 15:13:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DF8360853;
        Fri, 20 Nov 2020 15:13:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 49/76] netfs: Stats
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:13:03 +0000
Message-ID: <160588518372.3465195.15930838383494185851.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/netfs/Kconfig       |   15 ++++++++++++++
 fs/netfs/Makefile      |    3 +--
 fs/netfs/internal.h    |   34 +++++++++++++++++++++++++++++++
 fs/netfs/read_helper.c |   32 +++++++++++++++++++++++++++--
 fs/netfs/stats.c       |   53 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |    1 +
 6 files changed, 134 insertions(+), 4 deletions(-)
 create mode 100644 fs/netfs/stats.c

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 2ebf90e6ca95..578112713703 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -6,3 +6,18 @@ config NETFS_SUPPORT
 	  This option enables support for network filesystems, including
 	  helpers for high-level buffered I/O, abstracting out read
 	  segmentation, local caching and transparent huge page support.
+
+config NETFS_STATS
+	bool "Gather statistical information on local caching"
+	depends on NETFS_SUPPORT && PROC_FS
+	help
+	  This option causes statistical information to be gathered on local
+	  caching and exported through file:
+
+		/proc/fs/fscache/stats
+
+	  The gathering of statistics adds a certain amount of overhead to
+	  execution as there are a quite a few stats gathered, and on a
+	  multi-CPU system these may be on cachelines that keep bouncing
+	  between CPUs.  On the other hand, the stats are very useful for
+	  debugging purposes.  Saying 'Y' here is recommended.
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 4b4eff2ba369..c15bfc966d96 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-netfs-y := \
-	read_helper.o
+netfs-y := read_helper.o stats.o
 
 obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index b07f43f9130e..d83317b1eb9d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -16,8 +16,42 @@
  */
 extern unsigned int netfs_debug;
 
+/*
+ * stats.c
+ */
+#ifdef CONFIG_NETFS_STATS
+extern atomic_t netfs_n_rh_readahead;
+extern atomic_t netfs_n_rh_readpage;
+extern atomic_t netfs_n_rh_rreq;
+extern atomic_t netfs_n_rh_sreq;
+extern atomic_t netfs_n_rh_download;
+extern atomic_t netfs_n_rh_download_done;
+extern atomic_t netfs_n_rh_download_failed;
+extern atomic_t netfs_n_rh_download_instead;
+extern atomic_t netfs_n_rh_read;
+extern atomic_t netfs_n_rh_read_done;
+extern atomic_t netfs_n_rh_read_failed;
+extern atomic_t netfs_n_rh_zero;
+extern atomic_t netfs_n_rh_short_read;
+extern atomic_t netfs_n_rh_write;
+extern atomic_t netfs_n_rh_write_done;
+extern atomic_t netfs_n_rh_write_failed;
+
+
+static inline void netfs_stat(atomic_t *stat)
+{
+	atomic_inc(stat);
+}
+
+static inline void netfs_stat_d(atomic_t *stat)
+{
+	atomic_dec(stat);
+}
+
+#else
 #define netfs_stat(x) do {} while(0)
 #define netfs_stat_d(x) do {} while(0)
+#endif
 
 /*****************************************************************************/
 /*
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 21d3578c6979..e1ce197d8d18 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -55,6 +55,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
 		refcount_set(&rreq->usage, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 		ops->init_rreq(rreq, file);
+		netfs_stat(&netfs_n_rh_rreq);
 	}
 
 	return rreq;
@@ -86,6 +87,7 @@ static void netfs_put_read_request(struct netfs_read_request *rreq)
 		fscache_end_operation(&rreq->cache_resources);
 		trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 		kfree(rreq);
+		netfs_stat_d(&netfs_n_rh_rreq);
 	}
 }
 
@@ -102,6 +104,7 @@ static struct netfs_read_subrequest *netfs_alloc_subrequest(
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->usage, 2);
 		subreq->rreq = rreq;
+		netfs_stat(&netfs_n_rh_sreq);
 	}
 
 	return subreq;
@@ -117,6 +120,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq)
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	netfs_put_read_request(subreq->rreq);
 	kfree(subreq);
+	netfs_stat_d(&netfs_n_rh_sreq);
 }
 
 /*
@@ -153,6 +157,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 
+	netfs_stat(&netfs_n_rh_read);
 	fscache_read(&rreq->cache_resources, subreq->start, &iter, seek_data,
 		     netfs_cache_read_terminated, subreq);
 }
@@ -163,6 +168,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
 				   struct netfs_read_subrequest *subreq)
 {
+	netfs_stat(&netfs_n_rh_zero);
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	netfs_subreq_terminated(subreq, 0);
 }
@@ -186,6 +192,7 @@ static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
 static void netfs_read_from_server(struct netfs_read_request *rreq,
 				   struct netfs_read_subrequest *subreq)
 {
+	netfs_stat(&netfs_n_rh_download);
 	rreq->netfs_ops->issue_op(subreq);
 }
 
@@ -240,10 +247,13 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error)
 	struct netfs_read_subrequest *subreq = priv;
 	struct netfs_read_request *rreq = subreq->rreq;
 
-	if (IS_ERR_VALUE(transferred_or_error))
+	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
-	else
+		netfs_stat(&netfs_n_rh_write_failed);
+	} else {
 		subreq->error = 0;
+		netfs_stat(&netfs_n_rh_write_done);
+	}
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
 
@@ -288,6 +298,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 			netfs_put_subrequest(next);
 		}
 
+		netfs_stat(&netfs_n_rh_write);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
 
 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
@@ -415,6 +426,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
 
+	netfs_stat(&netfs_n_rh_short_read);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
 	netfs_get_read_subrequest(subreq);
@@ -449,6 +461,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
+			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_read_subrequest(subreq);
 			atomic_inc(&rreq->nr_rd_ops);
@@ -563,6 +576,17 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 	       subreq->debug_index, subreq->start, subreq->flags,
 	       transferred_or_error);
 
+	switch (subreq->source) {
+	case NETFS_READ_FROM_CACHE:
+		netfs_stat(&netfs_n_rh_read_done);
+		break;
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_stat(&netfs_n_rh_download_done);
+		break;
+	default:
+		break;
+	}
+
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
 		goto failed;
@@ -616,8 +640,10 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 
 failed:
 	if (subreq->source == NETFS_READ_FROM_CACHE) {
+		netfs_stat(&netfs_n_rh_read_failed);
 		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	} else {
+		netfs_stat(&netfs_n_rh_download_failed);
 		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
 		rreq->error = subreq->error;
 	}
@@ -822,6 +848,7 @@ void netfs_readahead(struct readahead_control *ractl,
 	rreq->start	= readahead_pos(ractl);
 	rreq->len	= readahead_length(ractl);
 
+	netfs_stat(&netfs_n_rh_readahead);
 	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
 			 netfs_read_trace_readahead);
 
@@ -897,6 +924,7 @@ int netfs_readpage(struct file *file,
 	rreq->start		= page->index * PAGE_SIZE;
 	rreq->len		= thp_size(page);
 
+	netfs_stat(&netfs_n_rh_readpage);
 	trace_netfs_read(rreq, page->index * PAGE_SIZE, thp_size(page),
 			 netfs_read_trace_readpage);
 
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
new file mode 100644
index 000000000000..3a7a3c10e1cd
--- /dev/null
+++ b/fs/netfs/stats.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Netfs support statistics
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/seq_file.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+atomic_t netfs_n_rh_readahead;
+atomic_t netfs_n_rh_readpage;
+atomic_t netfs_n_rh_rreq;
+atomic_t netfs_n_rh_sreq;
+atomic_t netfs_n_rh_download;
+atomic_t netfs_n_rh_download_done;
+atomic_t netfs_n_rh_download_failed;
+atomic_t netfs_n_rh_download_instead;
+atomic_t netfs_n_rh_read;
+atomic_t netfs_n_rh_read_done;
+atomic_t netfs_n_rh_read_failed;
+atomic_t netfs_n_rh_zero;
+atomic_t netfs_n_rh_short_read;
+atomic_t netfs_n_rh_write;
+atomic_t netfs_n_rh_write_done;
+atomic_t netfs_n_rh_write_failed;
+
+void netfs_stats_show(struct seq_file *m)
+{
+	seq_printf(m, "RdHelp : RA=%u RP=%u rr=%u sr=%u\n",
+		   atomic_read(&netfs_n_rh_readahead),
+		   atomic_read(&netfs_n_rh_readpage),
+		   atomic_read(&netfs_n_rh_rreq),
+		   atomic_read(&netfs_n_rh_sreq));
+	seq_printf(m, "RdHelp : ZR=%u sh=%u\n",
+		   atomic_read(&netfs_n_rh_zero),
+		   atomic_read(&netfs_n_rh_short_read));
+	seq_printf(m, "RdHelp : DL=%u ds=%u df=%u di=%u\n",
+		   atomic_read(&netfs_n_rh_download),
+		   atomic_read(&netfs_n_rh_download_done),
+		   atomic_read(&netfs_n_rh_download_failed),
+		   atomic_read(&netfs_n_rh_download_instead));
+	seq_printf(m, "RdHelp : RD=%u rs=%u rf=%u\n",
+		   atomic_read(&netfs_n_rh_read),
+		   atomic_read(&netfs_n_rh_read_done),
+		   atomic_read(&netfs_n_rh_read_failed));
+	seq_printf(m, "RdHelp : WR=%u ws=%u wf=%u\n",
+		   atomic_read(&netfs_n_rh_write),
+		   atomic_read(&netfs_n_rh_write_done),
+		   atomic_read(&netfs_n_rh_write_failed));
+}
+EXPORT_SYMBOL(netfs_stats_show);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c4276eb9914d..d9cd9a1d1f6d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -98,5 +98,6 @@ extern int netfs_readpage(struct file *,
 			  void *);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t);
+extern void netfs_stats_show(struct seq_file *);
 
 #endif /* _LINUX_NETFS_H */


