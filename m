Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3F4BAB23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 21:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiBQUgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 15:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiBQUgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:36:42 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF962237ED;
        Thu, 17 Feb 2022 12:36:26 -0800 (PST)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nKnVk-0003MQ-N8; Thu, 17 Feb 2022 15:36:20 -0500
Date:   Thu, 17 Feb 2022 15:36:20 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Chris Mason <clm@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
Message-ID: <20220217153620.4607bc28@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch works, but a cleanup question for Al Viro:

How do we get rid of #include "../fs/mount.h" and the raw ->mnt_ns = NULL thing
in the cleanest way?

---8<---
Currently freeing ipc_namespace structures is done through a
workqueue, with every single item on the queue waiting in
synchronize_rcu before it is freed, limiting the rate at which
ipc_namespace structures can be freed to something on the order
of 100 a second.

Getting rid of that workqueue and just using rcu_work instead
allows a whole batch of ipc_namespace frees to wait one single
RCU grace period, after which they can all get freed quickly.

Without this patch, a test program that simply calls
unshare(CLONE_NEWIPC) a million times in a loop eventually
gets -ENOSPC as the total number of ipc_namespace structures
exceeds the limit, due to slow freeing.

With this patch, the test program runs successfully every time.

Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/ipc_namespace.h |  2 +-
 ipc/namespace.c               | 30 ++++++++----------------------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b75395ec8d52..ee26fdbb2ce4 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -67,7 +67,7 @@ struct ipc_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 
-	struct llist_node mnt_llist;
+	struct rcu_work free_rwork;
 
 	struct ns_common ns;
 } __randomize_layout;
diff --git a/ipc/namespace.c b/ipc/namespace.c
index ae83f0f2651b..3d151bc5f723 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -17,6 +17,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 
+#include "../fs/mount.h"
 #include "util.h"
 
 static struct ucounts *inc_ipc_namespaces(struct user_namespace *ns)
@@ -115,12 +116,11 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 	up_write(&ids->rwsem);
 }
 
-static void free_ipc_ns(struct ipc_namespace *ns)
+static void free_ipc_ns(struct work_struct *work)
 {
-	/* mq_put_mnt() waits for a grace period as kern_unmount()
-	 * uses synchronize_rcu().
-	 */
-	mq_put_mnt(ns);
+	struct ipc_namespace *ns = container_of(to_rcu_work(work),
+				   struct ipc_namespace, free_rwork);
+	mntput(ns->mq_mnt);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -131,21 +131,6 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	kfree(ns);
 }
 
-static LLIST_HEAD(free_ipc_list);
-static void free_ipc(struct work_struct *unused)
-{
-	struct llist_node *node = llist_del_all(&free_ipc_list);
-	struct ipc_namespace *n, *t;
-
-	llist_for_each_entry_safe(n, t, node, mnt_llist)
-		free_ipc_ns(n);
-}
-
-/*
- * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
- */
-static DECLARE_WORK(free_ipc_work, free_ipc);
-
 /*
  * put_ipc_ns - drop a reference to an ipc namespace.
  * @ns: the namespace to put
@@ -166,10 +151,11 @@ void put_ipc_ns(struct ipc_namespace *ns)
 {
 	if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
+		real_mount(ns->mq_mnt)->mnt_ns = NULL;
 		spin_unlock(&mq_lock);
 
-		if (llist_add(&ns->mnt_llist, &free_ipc_list))
-			schedule_work(&free_ipc_work);
+		INIT_RCU_WORK(&ns->free_rwork, free_ipc_ns);
+		queue_rcu_work(system_wq, &ns->free_rwork);
 	}
 }
 
-- 
2.34.1


