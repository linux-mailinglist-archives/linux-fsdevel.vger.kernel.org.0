Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9DB233183
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgG3MBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:01:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:57156 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728675AbgG3MBK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:10 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17F0-0002zz-44; Thu, 30 Jul 2020 15:00:54 +0300
Subject: [PATCH 20/23] ipc: Add ipc namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:01:08 +0300
Message-ID: <159611046802.535980.15486117399701470621.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now they are exposed in /proc/namespace/ directory.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 ipc/namespace.c |   13 ++++++++++++-
 ipc/shm.c       |    1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766ddc3b..ce6f87dd6d08 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -63,8 +63,17 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	msg_init_ns(ns);
 	shm_init_ns(ns);
 
+	err = ns_idr_register(&ns->ns);
+	if (err)
+		goto fail_exit;
+
 	return ns;
 
+fail_exit:
+	mq_put_mnt(ns);
+	sem_exit_ns(ns);
+	msg_exit_ns(ns);
+	shm_exit_ns(ns);
 fail_put:
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
@@ -117,6 +126,8 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
+	ns_idr_unregister(&ns->ns);
+
 	/* mq_put_mnt() waits for a grace period as kern_unmount()
 	 * uses synchronize_rcu().
 	 */
@@ -128,7 +139,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kfree(ns);
+	kfree(ns); /* RCU grace period wait is done in mq_put_mnt */
 }
 
 static LLIST_HEAD(free_ipc_list);
diff --git a/ipc/shm.c b/ipc/shm.c
index 6cf24a5994ec..9e83556d9dcb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -137,6 +137,7 @@ void shm_exit_ns(struct ipc_namespace *ns)
 static int __init ipc_ns_init(void)
 {
 	shm_init_ns(&init_ipc_ns);
+	WARN_ON(ns_idr_register(&init_ipc_ns.ns) < 0);
 	return 0;
 }
 


