Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063B4BBF8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBRSfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:35:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiBRSfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:35:20 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C79224943;
        Fri, 18 Feb 2022 10:35:03 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL82Z-0004OI-D8; Fri, 18 Feb 2022 13:31:35 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        paulmck@kernel.org, gscrivan@redhat.com, viro@zeniv.linux.org.uk,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/2] ipc: get rid of free_ipc_work workqueue
Date:   Fri, 18 Feb 2022 13:31:14 -0500
Message-Id: <20220218183114.2867528-3-riel@surriel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218183114.2867528-1-riel@surriel.com>
References: <20220218183114.2867528-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With kern_unmount deferring the freeing of the vfsmount structure
through queue_rcu_work, we no longer need a separate workqueue for
freeing up ipc_namespace structures.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/ipc_namespace.h |  2 --
 ipc/namespace.c               | 21 +--------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b75395ec8d52..5a3debde2f3d 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -67,8 +67,6 @@ struct ipc_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 
-	struct llist_node mnt_llist;
-
 	struct ns_common ns;
 } __randomize_layout;
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index ae83f0f2651b..090a08b17710 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -117,9 +117,6 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
-	/* mq_put_mnt() waits for a grace period as kern_unmount()
-	 * uses synchronize_rcu().
-	 */
 	mq_put_mnt(ns);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
@@ -131,21 +128,6 @@ static void free_ipc_ns(struct ipc_namespace *ns)
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
@@ -168,8 +150,7 @@ void put_ipc_ns(struct ipc_namespace *ns)
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
 
-		if (llist_add(&ns->mnt_llist, &free_ipc_list))
-			schedule_work(&free_ipc_work);
+		free_ipc_ns(ns);
 	}
 }
 
-- 
2.34.1

