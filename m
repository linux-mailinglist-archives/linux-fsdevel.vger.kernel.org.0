Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10053A5D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353221AbiFANVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353196AbiFANVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:21:03 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C81D4D634
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 06:20:57 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-O_Pd3AsIMGigCWcA94cQtA-1; Wed, 01 Jun 2022 09:20:53 -0400
X-MC-Unique: O_Pd3AsIMGigCWcA94cQtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B024B802804;
        Wed,  1 Jun 2022 13:20:52 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94762414A7E7;
        Wed,  1 Jun 2022 13:20:50 +0000 (UTC)
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
Subject: [RFC PATCH 3/4] sysctl: userns: Do not use dynamic memory
Date:   Wed,  1 Jun 2022 15:20:31 +0200
Message-Id: <81190e5e4879d53be2e1416bcad0b663421339d6.1654086665.git.legion@kernel.org>
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
 include/linux/user_namespace.h |   6 --
 kernel/ucount.c                | 116 +++++++++++++--------------------
 kernel/user_namespace.c        |  10 +--
 3 files changed, 46 insertions(+), 86 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 45f09bec02c4..7b134516e5cb 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -95,10 +95,6 @@ struct user_namespace {
 	struct key		*persistent_keyring_register;
 #endif
 	struct work_struct	work;
-#ifdef CONFIG_SYSCTL
-	struct ctl_table_set	set;
-	struct ctl_table_header *sysctls;
-#endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
 	long rlimit_max[UCOUNT_RLIMIT_COUNTS];
@@ -116,8 +112,6 @@ struct ucounts {
 extern struct user_namespace init_user_ns;
 extern struct ucounts init_ucounts;
 
-bool setup_userns_sysctls(struct user_namespace *ns);
-void retire_userns_sysctls(struct user_namespace *ns);
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid, enum ucount_type type);
 void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index ee8e57fd6f90..4a5072671847 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -7,6 +7,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
+#include <linux/fs.h>
 
 struct ucounts init_ucounts = {
 	.ns    = &init_user_ns,
@@ -26,38 +27,20 @@ static DEFINE_SPINLOCK(ucounts_lock);
 
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table_set *
-set_lookup(struct ctl_table_root *root)
-{
-	return &current_user_ns()->set;
-}
-
-static int set_is_seen(struct ctl_table_set *set)
-{
-	return &current_user_ns()->set == set;
-}
-
-static int set_permissions(struct ctl_table_header *head,
-				  struct ctl_table *table)
-{
-	struct user_namespace *user_ns =
-		container_of(head->set, struct user_namespace, set);
-	int mode;
-
-	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
-	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
-		mode = (table->mode & S_IRWXU) >> 6;
-	else
-	/* Allow all others at most read-only access */
-		mode = table->mode & S_IROTH;
-	return (mode << 6) | (mode << 3) | mode;
-}
-
-static struct ctl_table_root set_root = {
-	.lookup = set_lookup,
-	.permissions = set_permissions,
+static int user_sys_open(struct ctl_context *ctx, struct inode *inode,
+		        struct file *file);
+static ssize_t user_sys_read(struct ctl_context *ctx, struct file *file,
+			    char *buffer, size_t *lenp, loff_t *ppos);
+static ssize_t user_sys_write(struct ctl_context *ctx, struct file *file,
+			     char *buffer, size_t *lenp, loff_t *ppos);
+
+static struct ctl_fops user_sys_fops = {
+	.open	= user_sys_open,
+	.read	= user_sys_read,
+	.write	= user_sys_write,
 };
 
+static long ue_dummy = 0;
 static long ue_zero = 0;
 static long ue_int_max = INT_MAX;
 
@@ -66,9 +49,11 @@ static long ue_int_max = INT_MAX;
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
+		.data		= &ue_dummy,			\
 		.proc_handler	= proc_doulongvec_minmax,	\
 		.extra1		= &ue_zero,			\
 		.extra2		= &ue_int_max,			\
+		.ctl_fops	= &user_sys_fops,		\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
@@ -89,44 +74,43 @@ static struct ctl_table user_table[] = {
 #endif
 	{ }
 };
-#endif /* CONFIG_SYSCTL */
 
-bool setup_userns_sysctls(struct user_namespace *ns)
+static int user_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
 {
-#ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
-
-	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
-	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
-	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
-	if (tbl) {
-		int i;
-		for (i = 0; i < UCOUNT_COUNTS; i++) {
-			tbl[i].data = &ns->ucount_max[i];
-		}
-		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl);
-	}
-	if (!ns->sysctls) {
-		kfree(tbl);
-		retire_sysctl_set(&ns->set);
-		return false;
-	}
-#endif
-	return true;
+	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
+	if ((file->f_mode & FMODE_WRITE) &&
+	    !ns_capable(file->f_cred->user_ns, CAP_SYS_RESOURCE))
+		return -EPERM;
+	return 0;
 }
 
-void retire_userns_sysctls(struct user_namespace *ns)
+static ssize_t user_sys_read(struct ctl_context *ctx, struct file *file,
+		     char *buffer, size_t *lenp, loff_t *ppos)
 {
-#ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	struct ctl_table table = *ctx->table;
+	table.data = &file->f_cred->user_ns->ucount_max[ctx->table - user_table];
+	return table.proc_handler(&table, 0, buffer, lenp, ppos);
+}
 
-	tbl = ns->sysctls->ctl_table_arg;
-	unregister_sysctl_table(ns->sysctls);
-	retire_sysctl_set(&ns->set);
-	kfree(tbl);
-#endif
+static ssize_t user_sys_write(struct ctl_context *ctx, struct file *file,
+		      char *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctx->table;
+	table.data = &file->f_cred->user_ns->ucount_max[ctx->table - user_table];
+	return table.proc_handler(&table, 1, buffer, lenp, ppos);
 }
 
+static struct ctl_table user_root_table[] = {
+	{
+		.procname       = "user",
+		.mode           = 0555,
+		.child          = user_table,
+	},
+	{}
+};
+
+#endif /* CONFIG_SYSCTL */
+
 static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid, struct hlist_head *hashent)
 {
 	struct ucounts *ucounts;
@@ -357,17 +341,7 @@ bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigne
 static __init int user_namespace_sysctl_init(void)
 {
 #ifdef CONFIG_SYSCTL
-	static struct ctl_table_header *user_header;
-	static struct ctl_table empty[1];
-	/*
-	 * It is necessary to register the user directory in the
-	 * default set so that registrations in the child sets work
-	 * properly.
-	 */
-	user_header = register_sysctl("user", empty);
-	kmemleak_ignore(user_header);
-	BUG_ON(!user_header);
-	BUG_ON(!setup_userns_sysctls(&init_user_ns));
+	register_sysctl_table(user_root_table);
 #endif
 	hlist_add_ucounts(&init_ucounts);
 	inc_rlimit_ucounts(&init_ucounts, UCOUNT_RLIMIT_NPROC, 1);
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 981bb2d10d83..c0e707bc9a31 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -149,17 +149,10 @@ int create_user_ns(struct cred *new)
 	INIT_LIST_HEAD(&ns->keyring_name_list);
 	init_rwsem(&ns->keyring_sem);
 #endif
-	ret = -ENOMEM;
-	if (!setup_userns_sysctls(ns))
-		goto fail_keyring;
 
 	set_cred_user_ns(new, ns);
 	return 0;
-fail_keyring:
-#ifdef CONFIG_PERSISTENT_KEYRINGS
-	key_put(ns->persistent_keyring_register);
-#endif
-	ns_free_inum(&ns->ns);
+
 fail_free:
 	kmem_cache_free(user_ns_cachep, ns);
 fail_dec:
@@ -208,7 +201,6 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
-		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
 		kmem_cache_free(user_ns_cachep, ns);
-- 
2.33.3

