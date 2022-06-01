Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE553A5D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353223AbiFANVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbiFANU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:20:59 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 776C44D61F
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 06:20:57 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-4Z-CMtpGOVKaHbq7mveZtw-1; Wed, 01 Jun 2022 09:20:51 -0400
X-MC-Unique: 4Z-CMtpGOVKaHbq7mveZtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4838C1C0F68B;
        Wed,  1 Jun 2022 13:20:50 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E85B414A7E7;
        Wed,  1 Jun 2022 13:20:48 +0000 (UTC)
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
Subject: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
Date:   Wed,  1 Jun 2022 15:20:30 +0200
Message-Id: <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
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

Dynamic memory allocation is needed to modify .data and specify the per
namespace parameter. The new sysctl API is allowed to get rid of the
need for such modification.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/ipc_namespace.h |  18 ---
 ipc/ipc_sysctl.c              | 236 +++++++++++++++++-----------------
 ipc/namespace.c               |   4 -
 3 files changed, 121 insertions(+), 137 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e3e8c8662b49..51c2c247c447 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -191,22 +191,4 @@ static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
 }
 
 #endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
-
-#ifdef CONFIG_SYSVIPC_SYSCTL
-
-bool setup_ipc_sysctls(struct ipc_namespace *ns);
-void retire_ipc_sysctls(struct ipc_namespace *ns);
-
-#else /* CONFIG_SYSVIPC_SYSCTL */
-
-static inline void retire_ipc_sysctls(struct ipc_namespace *ns)
-{
-}
-
-static inline bool setup_ipc_sysctls(struct ipc_namespace *ns)
-{
-	return true;
-}
-
-#endif /* CONFIG_SYSVIPC_SYSCTL */
 #endif
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ef313ecfb53a..833b670c38f3 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -68,26 +68,94 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 	return ret;
 }
 
+static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table);
+
+static int ipc_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
+{
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+
+	// For now, we only allow changes in init_user_ns.
+	if (ns->user_ns != &init_user_ns)
+		return -EPERM;
+
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	int index = (ctx->table - ipc_sysctls);
+
+	switch (index) {
+		case IPC_SYSCTL_SEM_NEXT_ID:
+		case IPC_SYSCTL_MSG_NEXT_ID:
+		case IPC_SYSCTL_SHM_NEXT_ID:
+			if (!checkpoint_restore_ns_capable(ns->user_ns))
+				return -EPERM;
+			break;
+	}
+#endif
+	ctx->ctl_data = ns;
+	return 0;
+}
+
+static ssize_t ipc_sys_read(struct ctl_context *ctx, struct file *file,
+		     char *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctx->table;
+	table.data = data_from_ns(ctx, ctx->table);
+	return table.proc_handler(&table, 0, buffer, lenp, ppos);
+}
+
+static ssize_t ipc_sys_write(struct ctl_context *ctx, struct file *file,
+		      char *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctx->table;
+	table.data = data_from_ns(ctx, ctx->table);
+	return table.proc_handler(&table, 1, buffer, lenp, ppos);
+}
+
+static struct ctl_fops ipc_sys_fops = {
+	.open	= ipc_sys_open,
+	.read	= ipc_sys_read,
+	.write	= ipc_sys_write,
+};
+
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
 int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
 
+enum {
+	IPC_SYSCTL_SHMMAX,
+	IPC_SYSCTL_SHMALL,
+	IPC_SYSCTL_SHMMNI,
+	IPC_SYSCTL_SHM_RMID_FORCED,
+	IPC_SYSCTL_MSGMAX,
+	IPC_SYSCTL_MSGMNI,
+	IPC_SYSCTL_AUTO_MSGMNI,
+	IPC_SYSCTL_MSGMNB,
+	IPC_SYSCTL_SEM,
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	IPC_SYSCTL_SEM_NEXT_ID,
+	IPC_SYSCTL_MSG_NEXT_ID,
+	IPC_SYSCTL_SHM_NEXT_ID,
+#endif
+	IPC_SYSCTL_COUNTS
+};
+
 static struct ctl_table ipc_sysctls[] = {
-	{
+	[IPC_SYSCTL_SHMMAX] = {
 		.procname	= "shmmax",
 		.data		= &init_ipc_ns.shm_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler   = proc_doulongvec_minmax,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_SHMALL] = {
 		.procname	= "shmall",
 		.data		= &init_ipc_ns.shm_ctlall,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
+		.proc_handler   = proc_doulongvec_minmax,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_SHMMNI] = {
 		.procname	= "shmmni",
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
@@ -95,8 +163,9 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_SHM_RMID_FORCED] = {
 		.procname	= "shm_rmid_forced",
 		.data		= &init_ipc_ns.shm_rmid_forced,
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
@@ -104,8 +173,9 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_MSGMAX] = {
 		.procname	= "msgmax",
 		.data		= &init_ipc_ns.msg_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
@@ -113,8 +183,9 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_MSGMNI] = {
 		.procname	= "msgmni",
 		.data		= &init_ipc_ns.msg_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
@@ -122,8 +193,9 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_AUTO_MSGMNI] = {
 		.procname	= "auto_msgmni",
 		.data		= NULL,
 		.maxlen		= sizeof(int),
@@ -131,8 +203,9 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_ipc_auto_msgmni,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_MSGMNB] = {
 		.procname	=  "msgmnb",
 		.data		= &init_ipc_ns.msg_ctlmnb,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
@@ -140,152 +213,85 @@ static struct ctl_table ipc_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_SEM] = {
 		.procname	= "sem",
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_sem_dointvec,
+		.ctl_fops	= &ipc_sys_fops,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	{
+	[IPC_SYSCTL_SEM_NEXT_ID] = {
 		.procname	= "sem_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
-		.mode		= 0444,
+		.mode		= 0666,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_MSG_NEXT_ID] = {
 		.procname	= "msg_next_id",
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
-		.mode		= 0444,
+		.mode		= 0666,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
+		.ctl_fops	= &ipc_sys_fops,
 	},
-	{
+	[IPC_SYSCTL_SHM_NEXT_ID] = {
 		.procname	= "shm_next_id",
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
-		.mode		= 0444,
+		.mode		= 0666,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
+		.ctl_fops	= &ipc_sys_fops,
 	},
 #endif
-	{}
+	[IPC_SYSCTL_COUNTS] = {}
 };
 
-static struct ctl_table_set *set_lookup(struct ctl_table_root *root)
+static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table)
 {
-	return &current->nsproxy->ipc_ns->ipc_set;
-}
-
-static int set_is_seen(struct ctl_table_set *set)
-{
-	return &current->nsproxy->ipc_ns->ipc_set == set;
-}
-
-static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
-{
-	int mode = table->mode;
-
+	struct ipc_namespace *ns = ctx->ctl_data;
+
+	switch (ctx->table - ipc_sysctls) {
+		case IPC_SYSCTL_SHMMAX:			return &ns->shm_ctlmax;
+		case IPC_SYSCTL_SHMALL:			return &ns->shm_ctlall;
+		case IPC_SYSCTL_SHMMNI:			return &ns->shm_ctlmni;
+		case IPC_SYSCTL_SHM_RMID_FORCED:	return &ns->shm_rmid_forced;
+		case IPC_SYSCTL_MSGMAX:			return &ns->msg_ctlmax;
+		case IPC_SYSCTL_MSGMNI:			return &ns->msg_ctlmni;
+		case IPC_SYSCTL_MSGMNB:			return &ns->msg_ctlmnb;
+		case IPC_SYSCTL_SEM:			return &ns->sem_ctls;
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
-
-	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
-	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
-	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
-	    checkpoint_restore_ns_capable(ns->user_ns))
-		mode = 0666;
+		case IPC_SYSCTL_SEM_NEXT_ID:		return &ns->ids[IPC_SEM_IDS].next_id;
+		case IPC_SYSCTL_MSG_NEXT_ID:		return &ns->ids[IPC_MSG_IDS].next_id;
+		case IPC_SYSCTL_SHM_NEXT_ID:		return &ns->ids[IPC_SHM_IDS].next_id;
 #endif
-	return mode;
-}
-
-static struct ctl_table_root set_root = {
-	.lookup = set_lookup,
-	.permissions = ipc_permissions,
-};
-
-bool setup_ipc_sysctls(struct ipc_namespace *ns)
-{
-	struct ctl_table *tbl;
-
-	setup_sysctl_set(&ns->ipc_set, &set_root, set_is_seen);
-
-	tbl = kmemdup(ipc_sysctls, sizeof(ipc_sysctls), GFP_KERNEL);
-	if (tbl) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(ipc_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.shm_ctlmax)
-				tbl[i].data = &ns->shm_ctlmax;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_ctlall)
-				tbl[i].data = &ns->shm_ctlall;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_ctlmni)
-				tbl[i].data = &ns->shm_ctlmni;
-
-			else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced)
-				tbl[i].data = &ns->shm_rmid_forced;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmax)
-				tbl[i].data = &ns->msg_ctlmax;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmni)
-				tbl[i].data = &ns->msg_ctlmni;
-
-			else if (tbl[i].data == &init_ipc_ns.msg_ctlmnb)
-				tbl[i].data = &ns->msg_ctlmnb;
-
-			else if (tbl[i].data == &init_ipc_ns.sem_ctls)
-				tbl[i].data = &ns->sem_ctls;
-#ifdef CONFIG_CHECKPOINT_RESTORE
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
-
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
-
-			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id)
-				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
-#endif
-			else
-				tbl[i].data = NULL;
-		}
-
-		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl);
-	}
-	if (!ns->ipc_sysctls) {
-		kfree(tbl);
-		retire_sysctl_set(&ns->ipc_set);
-		return false;
 	}
-
-	return true;
+	return NULL;
 }
 
-void retire_ipc_sysctls(struct ipc_namespace *ns)
-{
-	struct ctl_table *tbl;
-
-	tbl = ns->ipc_sysctls->ctl_table_arg;
-	unregister_sysctl_table(ns->ipc_sysctls);
-	retire_sysctl_set(&ns->ipc_set);
-	kfree(tbl);
-}
+static struct ctl_table ipc_root_table[] = {
+	{
+		.procname       = "kernel",
+		.mode           = 0555,
+		.child          = ipc_sysctls,
+	},
+	{}
+};
 
 static int __init ipc_sysctl_init(void)
 {
-	if (!setup_ipc_sysctls(&init_ipc_ns)) {
-		pr_warn("ipc sysctl registration failed\n");
-		return -ENOMEM;
-	}
+	register_sysctl_table(ipc_root_table);
 	return 0;
 }
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 754f3237194a..f760243ca685 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -63,9 +63,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (!setup_mq_sysctls(ns))
 		goto fail_put;
 
-	if (!setup_ipc_sysctls(ns))
-		goto fail_put;
-
 	sem_init_ns(ns);
 	msg_init_ns(ns);
 	shm_init_ns(ns);
@@ -133,7 +130,6 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	shm_exit_ns(ns);
 
 	retire_mq_sysctls(ns);
-	retire_ipc_sysctls(ns);
 
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-- 
2.33.3

