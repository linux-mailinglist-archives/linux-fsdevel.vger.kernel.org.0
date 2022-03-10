Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE64D4EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiCJQRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCJQRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9900190C0B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646928986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLnoMDsXAZhvceWKXXrKOjeeVt8EWF9LQHtKfhIe5YE=;
        b=diRZFWm/PV8IIpsHUcjRr8LKLTnasNh0ZEYUZ3ETQYEIJ2wYy05E633UskVuTJ/kA2JA9Z
        TUHNrvPyfgxl7euqgigRbWMlmnzfjPQ0/rxSnbcGuuUTkqRF3Khqnyaq6EbwaPxt8owCKq
        G9lLTccYvhk0urhZ0HuaCXIbvdj06WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-k09c7HqCMmKzHwBJDIG-XA-1; Thu, 10 Mar 2022 11:16:23 -0500
X-MC-Unique: k09c7HqCMmKzHwBJDIG-XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F4951DC;
        Thu, 10 Mar 2022 16:16:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21B7126E51;
        Thu, 10 Mar 2022 16:15:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 05/20] netfs: Split netfs_io_* object handling out
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@redhat.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 16:15:46 +0000
Message-ID: <164692894693.2099075.7831091294248735173.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split netfs_io_* object handling out into a file that's going to contain
object allocation, get and put routines.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164622995118.3564931.6089530629052064470.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678197044.1200972.11511937252083343775.stgit@warthog.procyon.org.uk/ # v2
---

 fs/netfs/Makefile      |    6 ++
 fs/netfs/internal.h    |   18 +++++++
 fs/netfs/objects.c     |  123 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/netfs/read_helper.c |  118 ----------------------------------------------
 4 files changed, 147 insertions(+), 118 deletions(-)
 create mode 100644 fs/netfs/objects.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index c15bfc966d96..939fd00a1fc9 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-netfs-y := read_helper.o stats.o
+netfs-y := \
+	objects.o \
+	read_helper.o
+
+netfs-$(CONFIG_NETFS_STATS) += stats.o
 
 obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index b7f2c4459f33..cf7a3ddb16a4 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -5,17 +5,35 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
+
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
 
 #define pr_fmt(fmt) "netfs: " fmt
 
+/*
+ * objects.c
+ */
+struct netfs_io_request *netfs_alloc_request(const struct netfs_request_ops *ops,
+					     void *netfs_priv,
+					     struct file *file);
+void netfs_get_request(struct netfs_io_request *rreq);
+void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
+void netfs_put_request(struct netfs_io_request *rreq, bool was_async);
+struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
+void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_get_subrequest(struct netfs_io_subrequest *subreq);
+
 /*
  * read_helper.c
  */
 extern unsigned int netfs_debug;
 
+void netfs_rreq_work(struct work_struct *work);
+
 /*
  * stats.c
  */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
new file mode 100644
index 000000000000..f7383c28dc6e
--- /dev/null
+++ b/fs/netfs/objects.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Object lifetime handling and tracing.
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Allocate an I/O request and initialise it.
+ */
+struct netfs_io_request *netfs_alloc_request(
+	const struct netfs_request_ops *ops, void *netfs_priv,
+	struct file *file)
+{
+	static atomic_t debug_ids;
+	struct netfs_io_request *rreq;
+
+	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
+	if (rreq) {
+		rreq->netfs_ops	= ops;
+		rreq->netfs_priv = netfs_priv;
+		rreq->inode	= file_inode(file);
+		rreq->i_size	= i_size_read(rreq->inode);
+		rreq->debug_id	= atomic_inc_return(&debug_ids);
+		INIT_LIST_HEAD(&rreq->subrequests);
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+		refcount_set(&rreq->usage, 1);
+		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+		if (ops->init_request)
+			ops->init_request(rreq, file);
+		netfs_stat(&netfs_n_rh_rreq);
+	}
+
+	return rreq;
+}
+
+void netfs_get_request(struct netfs_io_request *rreq)
+{
+	refcount_inc(&rreq->usage);
+}
+
+void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+
+	while (!list_empty(&rreq->subrequests)) {
+		subreq = list_first_entry(&rreq->subrequests,
+					  struct netfs_io_subrequest, rreq_link);
+		list_del(&subreq->rreq_link);
+		netfs_put_subrequest(subreq, was_async);
+	}
+}
+
+static void netfs_free_request(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+	netfs_clear_subrequests(rreq, false);
+	if (rreq->netfs_priv)
+		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
+	if (rreq->cache_resources.ops)
+		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+	kfree(rreq);
+	netfs_stat_d(&netfs_n_rh_rreq);
+}
+
+void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
+{
+	if (refcount_dec_and_test(&rreq->usage)) {
+		if (was_async) {
+			rreq->work.func = netfs_free_request;
+			if (!queue_work(system_unbound_wq, &rreq->work))
+				BUG();
+		} else {
+			netfs_free_request(&rreq->work);
+		}
+	}
+}
+
+/*
+ * Allocate and partially initialise an I/O request structure.
+ */
+struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
+	if (subreq) {
+		INIT_LIST_HEAD(&subreq->rreq_link);
+		refcount_set(&subreq->usage, 2);
+		subreq->rreq = rreq;
+		netfs_get_request(rreq);
+		netfs_stat(&netfs_n_rh_sreq);
+	}
+
+	return subreq;
+}
+
+void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
+{
+	refcount_inc(&subreq->usage);
+}
+
+static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
+				   bool was_async)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
+	kfree(subreq);
+	netfs_stat_d(&netfs_n_rh_sreq);
+	netfs_put_request(rreq, was_async);
+}
+
+void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async)
+{
+	if (refcount_dec_and_test(&subreq->usage))
+		__netfs_put_subrequest(subreq, was_async);
+}
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 26d54055b17e..ef23ef9889d5 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -27,122 +27,6 @@ unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
-static void netfs_rreq_work(struct work_struct *);
-static void __netfs_put_subrequest(struct netfs_io_subrequest *, bool);
-
-static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
-				 bool was_async)
-{
-	if (refcount_dec_and_test(&subreq->usage))
-		__netfs_put_subrequest(subreq, was_async);
-}
-
-static struct netfs_io_request *netfs_alloc_request(
-	const struct netfs_request_ops *ops, void *netfs_priv,
-	struct file *file)
-{
-	static atomic_t debug_ids;
-	struct netfs_io_request *rreq;
-
-	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
-	if (rreq) {
-		rreq->netfs_ops	= ops;
-		rreq->netfs_priv = netfs_priv;
-		rreq->inode	= file_inode(file);
-		rreq->i_size	= i_size_read(rreq->inode);
-		rreq->debug_id	= atomic_inc_return(&debug_ids);
-		INIT_LIST_HEAD(&rreq->subrequests);
-		INIT_WORK(&rreq->work, netfs_rreq_work);
-		refcount_set(&rreq->usage, 1);
-		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-		if (ops->init_request)
-			ops->init_request(rreq, file);
-		netfs_stat(&netfs_n_rh_rreq);
-	}
-
-	return rreq;
-}
-
-static void netfs_get_request(struct netfs_io_request *rreq)
-{
-	refcount_inc(&rreq->usage);
-}
-
-static void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
-{
-	struct netfs_io_subrequest *subreq;
-
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-					  struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
-		netfs_put_subrequest(subreq, was_async);
-	}
-}
-
-static void netfs_free_request(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_clear_subrequests(rreq, false);
-	if (rreq->netfs_priv)
-		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
-	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
-	if (rreq->cache_resources.ops)
-		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	kfree(rreq);
-	netfs_stat_d(&netfs_n_rh_rreq);
-}
-
-static void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
-{
-	if (refcount_dec_and_test(&rreq->usage)) {
-		if (was_async) {
-			rreq->work.func = netfs_free_request;
-			if (!queue_work(system_unbound_wq, &rreq->work))
-				BUG();
-		} else {
-			netfs_free_request(&rreq->work);
-		}
-	}
-}
-
-/*
- * Allocate and partially initialise an I/O request structure.
- */
-static struct netfs_io_subrequest *netfs_alloc_subrequest(
-	struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
-	if (subreq) {
-		INIT_LIST_HEAD(&subreq->rreq_link);
-		refcount_set(&subreq->usage, 2);
-		subreq->rreq = rreq;
-		netfs_get_request(rreq);
-		netfs_stat(&netfs_n_rh_sreq);
-	}
-
-	return subreq;
-}
-
-static void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
-{
-	refcount_inc(&subreq->usage);
-}
-
-static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
-				   bool was_async)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
-	kfree(subreq);
-	netfs_stat_d(&netfs_n_rh_sreq);
-	netfs_put_request(rreq, was_async);
-}
-
 /*
  * Clear the unread part of an I/O request.
  */
@@ -558,7 +442,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	netfs_rreq_completed(rreq, was_async);
 }
 
-static void netfs_rreq_work(struct work_struct *work)
+void netfs_rreq_work(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);


