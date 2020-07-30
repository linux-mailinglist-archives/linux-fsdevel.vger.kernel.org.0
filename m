Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88F233185
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgG3MB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:01:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:57292 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728951AbgG3MB0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:26 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17FG-00030u-52; Thu, 30 Jul 2020 15:01:10 +0300
Subject: [PATCH 23/23] time: Add time namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:01:24 +0300
Message-ID: <159611048400.535980.3963260192974391169.stgit@localhost.localdomain>
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
 include/linux/time_namespace.h |    1 +
 kernel/time/namespace.c        |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index a51ffc089219..18eb8a9f7d68 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -24,6 +24,7 @@ struct time_namespace {
 	struct page		*vvar_page;
 	/* If set prevents changing offsets after any task joined namespace. */
 	bool			frozen_offsets;
+	struct rcu_head		rcu;
 } __randomize_layout;
 
 extern struct time_namespace init_time_ns;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index c4c829eb3511..164a057ccbfc 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -107,8 +107,15 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	ns->offsets = old_ns->offsets;
 	ns->frozen_offsets = false;
+
+	err = ns_idr_register(&ns->ns);
+	if (err)
+		goto fail_put_userns;
 	return ns;
 
+fail_put_userns:
+	put_user_ns(user_ns);
+	ns_free_inum(&ns->ns);
 fail_free_page:
 	__free_page(ns->vvar_page);
 fail_free:
@@ -228,11 +235,12 @@ static void timens_set_vvar_page(struct task_struct *task,
 
 void free_time_ns(struct time_namespace *ns)
 {
+	ns_idr_unregister(&ns->ns);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	__free_page(ns->vvar_page);
-	kfree(ns);
+	kfree_rcu(ns, rcu);
 }
 
 static struct time_namespace *to_time_ns(struct ns_common *ns)
@@ -470,6 +478,7 @@ struct time_namespace init_time_ns = {
 
 static int __init time_ns_init(void)
 {
+	WARN_ON(ns_idr_register(&init_time_ns.ns) < 0);
 	return 0;
 }
 subsys_initcall(time_ns_init);


