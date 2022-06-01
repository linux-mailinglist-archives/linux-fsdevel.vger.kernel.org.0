Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0E53A5D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbiFANVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353199AbiFANVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:21:04 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B3644D9D4
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 06:20:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-vLc6cXEvNsOpYsXD4FreTw-1; Wed, 01 Jun 2022 09:20:55 -0400
X-MC-Unique: vLc6cXEvNsOpYsXD4FreTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C6001C0F68A;
        Wed,  1 Jun 2022 13:20:55 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01B4B414A7E9;
        Wed,  1 Jun 2022 13:20:52 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [RFC PATCH 4/4] sysctl: mqueue: Do not use dynamic memory
Date:   Wed,  1 Jun 2022 15:20:32 +0200
Message-Id: <e0576f541687d52de6c1053360a1895b58179f33.1654086665.git.legion@kernel.org>
In-Reply-To: <cover.1654086665.git.legion@kernel.org>
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com> <cover.1654086665.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dynamic memory allocation is needed to modify .data and specify the
per namespace parameter. The new sysctl API is allowed to get rid of
the need for such modification.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/ipc_namespace.h |  17 -----
 ipc/mq_sysctl.c               | 138 +++++++++++++++++++---------------
 ipc/mqueue.c                  |   5 --
 ipc/namespace.c               |   6 --
 4 files changed, 79 insertions(+), 87 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 51c2c247c447..d20753093a2c 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -174,21 +174,4 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
 }
 #endif
 
-#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
-
-void retire_mq_sysctls(struct ipc_namespace *ns);
-bool setup_mq_sysctls(struct ipc_namespace *ns);
-
-#else /* CONFIG_POSIX_MQUEUE_SYSCTL */
-
-static inline void retire_mq_sysctls(struct ipc_namespace *ns)
-{
-}
-
-static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
-{
-	return true;
-}
-
-#endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
 #endif
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index fbf6a8b93a26..08ff7dfb721c 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -13,6 +13,45 @@
 #include <linux/capability.h>
 #include <linux/slab.h>
 
+static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table);
+
+static int mq_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
+{
+	ctx->ctl_data = current->nsproxy->ipc_ns;
+	return 0;
+}
+
+static ssize_t mq_sys_read(struct ctl_context *ctx, struct file *file,
+		     char *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctx->table;
+	table.data = data_from_ns(ctx, ctx->table);
+	return table.proc_handler(&table, 0, buffer, lenp, ppos);
+}
+
+static ssize_t mq_sys_write(struct ctl_context *ctx, struct file *file,
+		      char *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctx->table;
+	table.data = data_from_ns(ctx, ctx->table);
+	return table.proc_handler(&table, 1, buffer, lenp, ppos);
+}
+
+static struct ctl_fops mq_sys_fops = {
+	.open	= mq_sys_open,
+	.read	= mq_sys_read,
+	.write	= mq_sys_write,
+};
+
+enum {
+	MQ_SYSCTL_QUEUES_MAX,
+	MQ_SYSCTL_MSG_MAX,
+	MQ_SYSCTL_MSGSIZE_MAX,
+	MQ_SYSCTL_MSG_DEFAULT,
+	MQ_SYSCTL_MSGSIZE_DEFAULT,
+	MQ_SYSCTL_COUNTS
+};
+
 static int msg_max_limit_min = MIN_MSGMAX;
 static int msg_max_limit_max = HARD_MSGMAX;
 
@@ -20,14 +59,15 @@ static int msg_maxsize_limit_min = MIN_MSGSIZEMAX;
 static int msg_maxsize_limit_max = HARD_MSGSIZEMAX;
 
 static struct ctl_table mq_sysctls[] = {
-	{
+	[MQ_SYSCTL_QUEUES_MAX] = {
 		.procname	= "queues_max",
 		.data		= &init_ipc_ns.mq_queues_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
+		.ctl_fops	= &mq_sys_fops,
 	},
-	{
+	[MQ_SYSCTL_MSG_MAX] = {
 		.procname	= "msg_max",
 		.data		= &init_ipc_ns.mq_msg_max,
 		.maxlen		= sizeof(int),
@@ -35,8 +75,9 @@ static struct ctl_table mq_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
+		.ctl_fops	= &mq_sys_fops,
 	},
-	{
+	[MQ_SYSCTL_MSGSIZE_MAX] = {
 		.procname	= "msgsize_max",
 		.data		= &init_ipc_ns.mq_msgsize_max,
 		.maxlen		= sizeof(int),
@@ -44,8 +85,9 @@ static struct ctl_table mq_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
+		.ctl_fops	= &mq_sys_fops,
 	},
-	{
+	[MQ_SYSCTL_MSG_DEFAULT] = {
 		.procname	= "msg_default",
 		.data		= &init_ipc_ns.mq_msg_default,
 		.maxlen		= sizeof(int),
@@ -53,8 +95,9 @@ static struct ctl_table mq_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
+		.ctl_fops	= &mq_sys_fops,
 	},
-	{
+	[MQ_SYSCTL_MSGSIZE_DEFAULT] = {
 		.procname	= "msgsize_default",
 		.data		= &init_ipc_ns.mq_msgsize_default,
 		.maxlen		= sizeof(int),
@@ -62,70 +105,47 @@ static struct ctl_table mq_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
+		.ctl_fops	= &mq_sys_fops,
 	},
 	{}
 };
 
-static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
+static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table)
 {
-	return &current->nsproxy->ipc_ns->mq_set;
+	struct ipc_namespace *ns = ctx->ctl_data;
+
+	switch (ctx->table - mq_sysctls) {
+		case MQ_SYSCTL_QUEUES_MAX:      return &ns->mq_queues_max;
+		case MQ_SYSCTL_MSG_MAX:         return &ns->mq_msg_max;
+		case MQ_SYSCTL_MSGSIZE_MAX:     return &ns->mq_msgsize_max;
+		case MQ_SYSCTL_MSG_DEFAULT:     return &ns->mq_msg_default;
+		case MQ_SYSCTL_MSGSIZE_DEFAULT: return &ns->mq_msgsize_default;
+	}
+	return NULL;
 }
 
-static int set_is_seen(struct ctl_table_set *set)
-{
-	return &current->nsproxy->ipc_ns->mq_set == set;
-}
+static struct ctl_table mq_sysctl_dir[] = {
+	{
+		.procname       = "mqueue",
+		.mode           = 0555,
+		.child          = mq_sysctls,
+	},
+	{}
+};
 
-static struct ctl_table_root set_root = {
-	.lookup = set_lookup,
+static struct ctl_table mq_sysctl_root[] = {
+	{
+		.procname       = "fs",
+		.mode           = 0555,
+		.child          = mq_sysctl_dir,
+	},
+	{}
 };
 
-bool setup_mq_sysctls(struct ipc_namespace *ns)
+static int __init mq_sysctl_init(void)
 {
-	struct ctl_table *tbl;
-
-	setup_sysctl_set(&ns->mq_set, &set_root, set_is_seen);
-
-	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
-	if (tbl) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(mq_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.mq_queues_max)
-				tbl[i].data = &ns->mq_queues_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_max)
-				tbl[i].data = &ns->mq_msg_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_max)
-				tbl[i].data = &ns->mq_msgsize_max;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msg_default)
-				tbl[i].data = &ns->mq_msg_default;
-
-			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_default)
-				tbl[i].data = &ns->mq_msgsize_default;
-			else
-				tbl[i].data = NULL;
-		}
-
-		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set, "fs/mqueue", tbl);
-	}
-	if (!ns->mq_sysctls) {
-		kfree(tbl);
-		retire_sysctl_set(&ns->mq_set);
-		return false;
-	}
-
-	return true;
+	register_sysctl_table(mq_sysctl_root);
+	return 0;
 }
 
-void retire_mq_sysctls(struct ipc_namespace *ns)
-{
-	struct ctl_table *tbl;
-
-	tbl = ns->mq_sysctls->ctl_table_arg;
-	unregister_sysctl_table(ns->mq_sysctls);
-	retire_sysctl_set(&ns->mq_set);
-	kfree(tbl);
-}
+device_initcall(mq_sysctl_init);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c0f24cc9f619..ffb79a24d70b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1711,11 +1711,6 @@ static int __init init_mqueue_fs(void)
 	if (mqueue_inode_cachep == NULL)
 		return -ENOMEM;
 
-	if (!setup_mq_sysctls(&init_ipc_ns)) {
-		pr_warn("sysctl registration failed\n");
-		return -ENOMEM;
-	}
-
 	error = register_filesystem(&mqueue_fs_type);
 	if (error)
 		goto out_sysctl;
diff --git a/ipc/namespace.c b/ipc/namespace.c
index f760243ca685..ae83f0f2651b 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -59,10 +59,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (err)
 		goto fail_put;
 
-	err = -ENOMEM;
-	if (!setup_mq_sysctls(ns))
-		goto fail_put;
-
 	sem_init_ns(ns);
 	msg_init_ns(ns);
 	shm_init_ns(ns);
@@ -129,8 +125,6 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
 
-	retire_mq_sysctls(ns);
-
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.33.3

