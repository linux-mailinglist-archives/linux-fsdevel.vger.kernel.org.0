Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F5233165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgG3MAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:56668 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbgG3MAI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:08 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Dx-0002x1-Fn; Thu, 30 Jul 2020 14:59:49 +0300
Subject: [PATCH 08/23] time: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:03 +0300
Message-ID: <159611040338.535980.6847379168016198580.stgit@localhost.localdomain>
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

Convert time namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/time_namespace.h |    9 ++++-----
 kernel/time/namespace.c        |    9 +++------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..a51ffc089219 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/sched.h>
-#include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
@@ -18,7 +17,6 @@ struct timens_offsets {
 };
 
 struct time_namespace {
-	struct kref		kref;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	struct ns_common	ns;
@@ -37,20 +35,21 @@ extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
-	kref_get(&ns->kref);
+	refcount_inc(&ns->ns.count);
 	return ns;
 }
 
 struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns);
-void free_time_ns(struct kref *kref);
+void free_time_ns(struct time_namespace *ns);
 int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
-	kref_put(&ns->kref, free_time_ns);
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_time_ns(ns);
 }
 
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index afc65e6be33e..c4c829eb3511 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -92,7 +92,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
-	kref_init(&ns->kref);
+	refcount_set(&ns->ns.count, 1);
 
 	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!ns->vvar_page)
@@ -226,11 +226,8 @@ static void timens_set_vvar_page(struct task_struct *task,
 	mutex_unlock(&offset_lock);
 }
 
-void free_time_ns(struct kref *kref)
+void free_time_ns(struct time_namespace *ns)
 {
-	struct time_namespace *ns;
-
-	ns = container_of(kref, struct time_namespace, kref);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
@@ -464,7 +461,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 };
 
 struct time_namespace init_time_ns = {
-	.kref		= KREF_INIT(3),
+	.ns.count	= REFCOUNT_INIT(3),
 	.user_ns	= &init_user_ns,
 	.ns.inum	= PROC_TIME_INIT_INO,
 	.ns.ops		= &timens_operations,


