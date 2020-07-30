Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E6233177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgG3MAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:57040 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbgG3MAy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:54 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Ej-0002zO-S1; Thu, 30 Jul 2020 15:00:37 +0300
Subject: [PATCH 17/23] pid: Add pid namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:51 +0300
Message-ID: <159611045173.535980.13125182914304511849.stgit@localhost.localdomain>
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

Note, that we already wait RCU grace period before
pid namespace's memory is freed.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/pid_namespace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index da8490390f51..06398a7c4c59 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -109,8 +109,13 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
 
+	if (ns_idr_register(&ns->ns) < 0)
+		goto out_free_inum;
+
 	return ns;
 
+out_free_inum:
+	ns_free_inum(&ns->ns);
 out_free_idr:
 	idr_destroy(&ns->idr);
 	kmem_cache_free(pid_ns_cachep, ns);
@@ -132,6 +137,7 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
+	ns_idr_unregister(&ns->ns);
 	ns_free_inum(&ns->ns);
 
 	idr_destroy(&ns->idr);
@@ -466,6 +472,7 @@ static __init int pid_namespaces_init(void)
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_paths(kern_path, pid_ns_ctl_table);
 #endif
+	WARN_ON(ns_idr_register(&init_pid_ns.ns) < 0);
 	return 0;
 }
 


