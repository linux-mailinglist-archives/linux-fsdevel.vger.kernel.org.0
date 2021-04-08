Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED93585F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhDHOIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231986AbhDHOGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGNJGYrcsOCZOVWj2xM1jhDYW4WKfIFmPbLYVLxKiv8=;
        b=eKhrTCxFmBxoBt+Nbocr7YmM0dzTQ2HDac4dWP8BWjudtqwzXyl0qoXaWoxnT6SowQYegN
        4AHdHrQLcx2RinqlbMA0Rt4KdqeeZO+/uiM6BolVy2AQwTEWx6p69raQuzcU1TKTkUNN7o
        Ov9zGtBDJ1NooQFpdyIXOabrmrXeCOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-JT1aIhQJNlCRMxD7eAWStg-1; Thu, 08 Apr 2021 10:06:42 -0400
X-MC-Unique: JT1aIhQJNlCRMxD7eAWStg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C0B8189D6;
        Thu,  8 Apr 2021 14:06:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F9E5D765;
        Thu,  8 Apr 2021 14:06:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 12/30] netfs: Gather stats
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:06:32 +0100
Message-ID: <161789079281.6155.17141344853277186500.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gather statistics from the netfs interface that can be exported through a
seqfile.  This is intended to be called by a later patch when viewing
/proc/fs/fscache/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/161118139247.1232039.10556850937548511068.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161034669.2537118.2761232524997091480.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340397101.1303470.17581910581108378458.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539539959.286939.6794352576462965914.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653797700.2770958.5801990354413178228.stgit@warthog.procyon.org.uk/ # v5
---

 fs/netfs/Kconfig       |   15 +++++++++++++
 fs/netfs/Makefile      |    3 +--
 fs/netfs/internal.h    |   34 ++++++++++++++++++++++++++++++
 fs/netfs/read_helper.c |   23 ++++++++++++++++++++
 fs/netfs/stats.c       |   54 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |    1 +
 6 files changed, 128 insertions(+), 2 deletions(-)
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
index ee665c0e7dc8..98b6f4516da1 100644
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
index 799eee7f4ee6..6d6ed30f417e 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -56,6 +56,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
 		refcount_set(&rreq->usage, 1);
 		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 		ops->init_rreq(rreq, file);
+		netfs_stat(&netfs_n_rh_rreq);
 	}
 
 	return rreq;
@@ -88,6 +89,7 @@ static void netfs_free_read_request(struct work_struct *work)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 	kfree(rreq);
+	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
 static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
@@ -117,6 +119,7 @@ static struct netfs_read_subrequest *netfs_alloc_subrequest(
 		refcount_set(&subreq->usage, 2);
 		subreq->rreq = rreq;
 		netfs_get_read_request(rreq);
+		netfs_stat(&netfs_n_rh_sreq);
 	}
 
 	return subreq;
@@ -134,6 +137,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	kfree(subreq);
+	netfs_stat_d(&netfs_n_rh_sreq);
 	netfs_put_read_request(rreq, was_async);
 }
 
@@ -156,6 +160,7 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
 				   struct netfs_read_subrequest *subreq)
 {
+	netfs_stat(&netfs_n_rh_zero);
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	netfs_subreq_terminated(subreq, 0, false);
 }
@@ -179,6 +184,7 @@ static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
 static void netfs_read_from_server(struct netfs_read_request *rreq,
 				   struct netfs_read_subrequest *subreq)
 {
+	netfs_stat(&netfs_n_rh_download);
 	rreq->netfs_ops->issue_op(subreq);
 }
 
@@ -288,6 +294,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
 
+	netfs_stat(&netfs_n_rh_short_read);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
 	netfs_get_read_subrequest(subreq);
@@ -319,6 +326,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
+			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_read_subrequest(subreq);
 			atomic_inc(&rreq->nr_rd_ops);
@@ -414,6 +422,17 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
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
@@ -470,8 +489,10 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 
 failed:
 	if (subreq->source == NETFS_READ_FROM_CACHE) {
+		netfs_stat(&netfs_n_rh_read_failed);
 		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	} else {
+		netfs_stat(&netfs_n_rh_download_failed);
 		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
 		rreq->error = subreq->error;
 	}
@@ -653,6 +674,7 @@ void netfs_readahead(struct readahead_control *ractl,
 	rreq->start	= readahead_pos(ractl);
 	rreq->len	= readahead_length(ractl);
 
+	netfs_stat(&netfs_n_rh_readahead);
 	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
 			 netfs_read_trace_readahead);
 
@@ -722,6 +744,7 @@ int netfs_readpage(struct file *file,
 	rreq->start	= page_index(page) * PAGE_SIZE;
 	rreq->len	= thp_size(page);
 
+	netfs_stat(&netfs_n_rh_readpage);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	netfs_get_read_request(rreq);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
new file mode 100644
index 000000000000..df6ff5718f25
--- /dev/null
+++ b/fs/netfs/stats.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Netfs support statistics
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
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
index 8e8c6a4e4dde..db4af80cbae3 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -166,5 +166,6 @@ extern int netfs_readpage(struct file *,
 			  void *);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
+extern void netfs_stats_show(struct seq_file *);
 
 #endif /* _LINUX_NETFS_H */


