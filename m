Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F15233180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgG3MBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:01:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:57242 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728918AbgG3MBV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:21 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17FA-00030d-Pn; Thu, 30 Jul 2020 15:01:04 +0300
Subject: [PATCH 22/23] cgroup: Add cgroup namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:01:18 +0300
Message-ID: <159611047870.535980.3790860133632973446.stgit@localhost.localdomain>
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
 include/linux/cgroup.h    |    1 +
 kernel/cgroup/namespace.c |   23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 451c2d26a5db..38913d91fa92 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -858,6 +858,7 @@ struct cgroup_namespace {
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	struct css_set          *root_cset;
+	struct rcu_head		rcu;
 };
 
 extern struct cgroup_namespace init_cgroup_ns;
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index f5e8828c109c..64393bbafb2c 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -39,11 +39,12 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 
 void free_cgroup_ns(struct cgroup_namespace *ns)
 {
+	ns_idr_unregister(&ns->ns);
 	put_css_set(ns->root_cset);
 	dec_cgroup_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kfree(ns);
+	kfree_rcu(ns, rcu);
 }
 EXPORT_SYMBOL(free_cgroup_ns);
 
@@ -54,6 +55,7 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 	struct cgroup_namespace *new_ns;
 	struct ucounts *ucounts;
 	struct css_set *cset;
+	int err;
 
 	BUG_ON(!old_ns);
 
@@ -78,16 +80,28 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 
 	new_ns = alloc_cgroup_ns();
 	if (IS_ERR(new_ns)) {
-		put_css_set(cset);
-		dec_cgroup_namespaces(ucounts);
-		return new_ns;
+		err = PTR_ERR(new_ns);
+		goto err_put_css_set;
 	}
 
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	new_ns->root_cset = cset;
 
+	err = ns_idr_register(&new_ns->ns);
+	if (err < 0)
+		goto err_put_user_ns;
+
 	return new_ns;
+
+err_put_user_ns:
+	put_user_ns(new_ns->user_ns);
+	ns_free_inum(&new_ns->ns);
+	kfree(new_ns);
+err_put_css_set:
+	put_css_set(cset);
+	dec_cgroup_namespaces(ucounts);
+	return ERR_PTR(err);
 }
 
 static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
@@ -152,6 +166,7 @@ const struct proc_ns_operations cgroupns_operations = {
 
 static __init int cgroup_namespaces_init(void)
 {
+	WARN_ON(ns_idr_register(&init_cgroup_ns.ns) < 0);
 	return 0;
 }
 subsys_initcall(cgroup_namespaces_init);


