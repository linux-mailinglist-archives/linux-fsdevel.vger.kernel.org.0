Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997794B5C48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiBNVFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:05:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBNVFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:05:06 -0500
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 13:04:57 PST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9DE104A59;
        Mon, 14 Feb 2022 13:04:55 -0800 (PST)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJiNk-0000oK-H1; Mon, 14 Feb 2022 15:55:36 -0500
Date:   Mon, 14 Feb 2022 15:55:36 -0500
From:   Rik van Riel <riel@surriel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Giuseppe Scrivano <gscrivan@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220214155536.1e0da8b6@imladris.surriel.com>
In-Reply-To: <20220214194440.GZ4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
        <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
        <20220214194440.GZ4285@paulmck-ThinkPad-P17-Gen-1>
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

On Mon, 14 Feb 2022 11:44:40 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> On Mon, Feb 14, 2022 at 07:26:49PM +0000, Chris Mason wrote:

> Moving from synchronize_rcu() to synchronize_rcu_expedited() does buy
> you at least an order of magnitude.  But yes, it should be possible to
> get rid of all but one call per batch, which would be better.  Maybe
> a bit more complicated, but probably not that much.

It doesn't look too bad, except for the include of ../fs/mount.h.

I'm hoping somebody has a better idea on how to deal with that.
Do we need a kern_unmount() variant that doesn't do the RCU wait,
or should it get a parameter, or something else?

Is there an ordering requirement between the synchronize_rcu call
and zeroing out n->mq_mnt->mnt_ls?

What other changes do we need to make everything right?

The change below also fixes the issue that to-be-freed items that
are queued up while the free_ipc work function runs do not result
in the work item being enqueued again.

This patch is still totally untested because the 4 year old is
at home today :)


diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766ddc3b..321cbda17cfb 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -17,6 +17,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 
+#include "../fs/mount.h"
 #include "util.h"
 
 static struct ucounts *inc_ipc_namespaces(struct user_namespace *ns)
@@ -117,10 +118,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
-	/* mq_put_mnt() waits for a grace period as kern_unmount()
-	 * uses synchronize_rcu().
-	 */
-	mq_put_mnt(ns);
+	mntput(ns->mq_mnt);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -134,11 +132,19 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 static LLIST_HEAD(free_ipc_list);
 static void free_ipc(struct work_struct *unused)
 {
-	struct llist_node *node = llist_del_all(&free_ipc_list);
+	struct llist_node *node;
 	struct ipc_namespace *n, *t;
 
-	llist_for_each_entry_safe(n, t, node, mnt_llist)
-		free_ipc_ns(n);
+	while ((node = llist_del_all(&free_ipc_list))) {
+		llist_for_each_entry(n, node, mnt_llist)
+			real_mount(n->mq_mnt)->mnt_ns = NULL;
+
+		/* Wait for the last users to have gone away. */
+		synchronize_rcu();
+
+		llist_for_each_entry_safe(n, t, node, mnt_llist)
+			free_ipc_ns(n);
+	}
 }
 
 /*

