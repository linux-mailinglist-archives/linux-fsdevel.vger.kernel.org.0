Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1567DB22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 02:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjA0BPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 20:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjA0BPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:15:51 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F56F21C;
        Thu, 26 Jan 2023 17:15:49 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pLDLC-00038z-2q;
        Thu, 26 Jan 2023 20:15:42 -0500
From:   Rik van Riel <riel@surriel.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org,
        gscrivan@redhat.com
Cc:     Rik van Riel <riel@surriel.com>, Chris Mason <clm@meta.com>
Subject: [PATCH 1/2] ipc,namespace: make ipc namespace allocation wait for pending free
Date:   Thu, 26 Jan 2023 20:15:34 -0500
Message-Id: <20230127011535.1265297-2-riel@surriel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230127011535.1265297-1-riel@surriel.com>
References: <20230127011535.1265297-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the ipc namespace allocation will fail when there are
ipc_namespace structures pending to be freed. This results in the
simple test case below, as well as some real world workloads, to
get allocation failures even when the number of ipc namespaces in
actual use is way below the limit.

int main()
{
	int i;

	for (i = 0; i < 100000; i++) {
		if (unshare(CLONE_NEWIPC) < 0)
			error(EXIT_FAILURE, errno, "unshare");
	}
}

Make the allocation of an ipc_namespace wait for pending frees,
so it will succeed.

real	6m19.197s
user	0m0.041s
sys	0m1.019s

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: Chris Mason <clm@meta.com>
---
 ipc/namespace.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 8316ea585733..a26860a41dac 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -19,6 +19,12 @@
 
 #include "util.h"
 
+/*
+ * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
+ */
+static void free_ipc(struct work_struct *unused);
+static DECLARE_WORK(free_ipc_work, free_ipc);
+
 static struct ucounts *inc_ipc_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_IPC_NAMESPACES);
@@ -37,9 +43,18 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	int err;
 
 	err = -ENOSPC;
+ again:
 	ucounts = inc_ipc_namespaces(user_ns);
-	if (!ucounts)
+	if (!ucounts) {
+		/*
+		 * IPC namespaces are freed asynchronously, by free_ipc_work.
+		 * If frees were pending, flush_work will wait, and
+		 * return true. Fail the allocation if no frees are pending.
+		 */
+		if (flush_work(&free_ipc_work))
+			goto again;
 		goto fail;
+	}
 
 	err = -ENOMEM;
 	ns = kzalloc(sizeof(struct ipc_namespace), GFP_KERNEL_ACCOUNT);
@@ -157,11 +172,6 @@ static void free_ipc(struct work_struct *unused)
 		free_ipc_ns(n);
 }
 
-/*
- * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
- */
-static DECLARE_WORK(free_ipc_work, free_ipc);
-
 /*
  * put_ipc_ns - drop a reference to an ipc namespace.
  * @ns: the namespace to put
-- 
2.38.1

