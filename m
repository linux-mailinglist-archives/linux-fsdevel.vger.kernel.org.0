Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3921DC5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgGMQcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:32:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50616 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730518AbgGMQcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFWzOvKlQKljLhANCdGMPaz1s06wEFCG5wrNzS5w+bY=;
        b=QscXOp+Kixilq7eyPleSOZKDPCtHAfJ5f9rrqcD+/aLVg7LhSAxKD+n0iCHvEX2Z5dJo+e
        CWdcItKp5D5R0j4ruIF1S5vt/5AKFv66/LYJNZtoKUXgtor8e6n+On8yJ+OsYOfdYWILXy
        mekSLQFId5kSFeLCzPU+ZD4rpHj4koM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-tfYVvGyfMaSbVREs3bDUZA-1; Mon, 13 Jul 2020 12:32:04 -0400
X-MC-Unique: tfYVvGyfMaSbVREs3bDUZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B290A80183C;
        Mon, 13 Jul 2020 16:32:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06AD310013C0;
        Mon, 13 Jul 2020 16:31:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/32] fscache: Provide a simple thread pool for running ops
 asynchronously
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:31:56 +0100
Message-ID: <159465791622.1376674.11171480091432676587.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a simple thread pool that can be used to run cookie management
operations in the background and a dispatcher infrastructure to punt
operations to the pool if threads are available or to just run the
operation in the calling thread if not.

A future patch will replace all the object state machine stuff with whole
routines that do all the work in one go without trying to interleave bits
from various objects.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Makefile            |    1 
 fs/fscache/dispatcher.c        |  144 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h          |    8 ++
 fs/fscache/main.c              |    7 ++
 include/trace/events/fscache.h |    6 +-
 5 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 fs/fscache/dispatcher.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index ac3fcd909fff..7b10c6aad157 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -6,6 +6,7 @@
 fscache-y := \
 	cache.o \
 	cookie.o \
+	dispatcher.o \
 	fsdef.o \
 	main.o \
 	netfs.o \
diff --git a/fs/fscache/dispatcher.c b/fs/fscache/dispatcher.c
new file mode 100644
index 000000000000..fba71b99c951
--- /dev/null
+++ b/fs/fscache/dispatcher.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Object dispatcher
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/freezer.h>
+#include "internal.h"
+
+#define FSCACHE_DISPATCHER_POOL_SIZE 8
+
+static LIST_HEAD(fscache_pending_work);
+static DEFINE_SPINLOCK(fscache_work_lock);
+static DECLARE_WAIT_QUEUE_HEAD(fscache_dispatcher_pool);
+static struct completion fscache_dispatcher_pool_done[FSCACHE_DISPATCHER_POOL_SIZE];
+static bool fscache_dispatcher_stop;
+
+struct fscache_work {
+	struct list_head	link;
+	struct fscache_cookie	*cookie;
+	struct fscache_object	*object;
+	int			param;
+	void (*func)(struct fscache_cookie *, struct fscache_object *, int);
+};
+
+/*
+ * Attempt to queue some work to do.  If there's too much asynchronous work
+ * already queued, we'll do it here in this thread instead.
+ */
+void fscache_dispatch(struct fscache_cookie *cookie,
+		      struct fscache_object *object,
+		      int param,
+		      void (*func)(struct fscache_cookie *,
+				   struct fscache_object *, int))
+{
+	struct fscache_work *work;
+	bool queued = false;
+
+	work = kzalloc(sizeof(struct fscache_work), GFP_KERNEL);
+	if (work) {
+		work->cookie = cookie;
+		work->object = object;
+		work->param = param;
+		work->func = func;
+
+		spin_lock(&fscache_work_lock);
+		if (waitqueue_active(&fscache_dispatcher_pool) ||
+		    list_empty(&fscache_pending_work)) {
+			fscache_cookie_get(cookie, fscache_cookie_get_work);
+			list_add_tail(&work->link, &fscache_pending_work);
+			wake_up(&fscache_dispatcher_pool);
+			queued = true;
+		}
+		spin_unlock(&fscache_work_lock);
+	}
+
+	if (!queued) {
+		kfree(work);
+		func(cookie, object, param);
+	}
+}
+
+/*
+ * A dispatcher thread.
+ */
+static int fscache_dispatcher(void *data)
+{
+	struct completion *done = data;
+
+	for (;;) {
+		if (!list_empty(&fscache_pending_work)) {
+			struct fscache_work *work = NULL;
+
+			spin_lock(&fscache_work_lock);
+			if (!list_empty(&fscache_pending_work)) {
+				work = list_entry(fscache_pending_work.next,
+						  struct fscache_work, link);
+				list_del_init(&work->link);
+			}
+			spin_unlock(&fscache_work_lock);
+
+			if (work) {
+				work->func(work->cookie, work->object, work->param);
+				fscache_cookie_put(work->cookie, fscache_cookie_put_work);
+				kfree(work);
+			}
+			continue;
+		} else if (fscache_dispatcher_stop) {
+			break;
+		}
+
+		wait_event_freezable(fscache_dispatcher_pool,
+				     (fscache_dispatcher_stop ||
+				      !list_empty(&fscache_pending_work)));
+	}
+
+	complete_and_exit(done, 0);
+}
+
+/*
+ * Start up the dispatcher threads.
+ */
+int fscache_init_dispatchers(void)
+{
+	struct task_struct *t;
+	int i;
+
+	for (i = 0; i < FSCACHE_DISPATCHER_POOL_SIZE; i++) {
+		t = kthread_create(fscache_dispatcher,
+				   &fscache_dispatcher_pool_done[i],
+				   "kfsc/%d", i);
+		if (IS_ERR(t))
+			goto failed;
+		wake_up_process(t);
+	}
+
+	return 0;
+
+failed:
+	fscache_dispatcher_stop = true;
+	wake_up_all(&fscache_dispatcher_pool);
+	for (i--; i >= 0; i--)
+		wait_for_completion(&fscache_dispatcher_pool_done[i]);
+	return PTR_ERR(t);
+}
+
+/*
+ * Kill off the dispatcher threads.
+ */
+void fscache_kill_dispatchers(void)
+{
+	int i;
+
+	fscache_dispatcher_stop = true;
+	wake_up_all(&fscache_dispatcher_pool);
+
+	for (i = 0; i < FSCACHE_DISPATCHER_POOL_SIZE; i++)
+		wait_for_completion(&fscache_dispatcher_pool_done[i]);
+}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index bc5539d2157b..2100e2222884 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -75,6 +75,14 @@ extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
 extern void fscache_cookie_put(struct fscache_cookie *,
 			       enum fscache_cookie_trace);
 
+/*
+ * dispatcher.c
+ */
+extern void fscache_dispatch(struct fscache_cookie *, struct fscache_object *, int,
+			     void (*func)(struct fscache_cookie *, struct fscache_object *, int));
+extern int fscache_init_dispatchers(void);
+extern void fscache_kill_dispatchers(void);
+
 /*
  * fsdef.c
  */
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index c1e6cc9091aa..c8f1beafa8e1 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -125,6 +125,10 @@ static int __init fscache_init(void)
 	for_each_possible_cpu(cpu)
 		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
 
+	ret = fscache_init_dispatchers();
+	if (ret < 0)
+		goto error_dispatchers;
+
 	ret = fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
@@ -159,6 +163,8 @@ static int __init fscache_init(void)
 	unregister_sysctl_table(fscache_sysctl_header);
 error_sysctl:
 #endif
+	fscache_kill_dispatchers();
+error_dispatchers:
 	fscache_proc_cleanup();
 error_proc:
 	destroy_workqueue(fscache_op_wq);
@@ -183,6 +189,7 @@ static void __exit fscache_exit(void)
 	unregister_sysctl_table(fscache_sysctl_header);
 #endif
 	fscache_proc_cleanup();
+	fscache_kill_dispatchers();
 	destroy_workqueue(fscache_op_wq);
 	destroy_workqueue(fscache_object_wq);
 	pr_notice("Unloaded\n");
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 08d7de72409d..fb3fdf2921ee 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -26,11 +26,13 @@ enum fscache_cookie_trace {
 	fscache_cookie_get_attach_object,
 	fscache_cookie_get_reacquire,
 	fscache_cookie_get_register_netfs,
+	fscache_cookie_get_work,
 	fscache_cookie_put_acquire_nobufs,
 	fscache_cookie_put_dup_netfs,
 	fscache_cookie_put_relinquish,
 	fscache_cookie_put_object,
 	fscache_cookie_put_parent,
+	fscache_cookie_put_work,
 };
 
 #endif
@@ -45,11 +47,13 @@ enum fscache_cookie_trace {
 	EM(fscache_cookie_get_attach_object,	"GET obj")		\
 	EM(fscache_cookie_get_reacquire,	"GET raq")		\
 	EM(fscache_cookie_get_register_netfs,	"GET net")		\
+	EM(fscache_cookie_get_work,		"GET wrk")		\
 	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
 	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
 	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
 	EM(fscache_cookie_put_object,		"PUT obj")		\
-	E_(fscache_cookie_put_parent,		"PUT prn")
+	EM(fscache_cookie_put_parent,		"PUT prn")		\
+	E_(fscache_cookie_put_work,		"PUT wrk")
 
 /*
  * Export enum symbols via userspace.


