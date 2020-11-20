Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004E32BAE16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgKTPNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgKTPNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsnXmFuXUd9zaqHhUBwdJdMRy+w9xFniok+y+VPqZho=;
        b=R2312cck2alSvuknv8fM0FcLmImY57h+/69CB1rVef7j/wzAH8pi0/+fR9wAUxvOVJiYMk
        ERR4vyiX1WgtQIlhPJysbrA7sdByqrjpevXYajrDLbO4eHYX706evvtVX0nuLneSuM9abj
        6v7UsK550MNHc5kq9u5scptHoMfYkFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-5l9VzYPMNd2cyJweCWgnfg-1; Fri, 20 Nov 2020 10:13:00 -0500
X-MC-Unique: 5l9VzYPMNd2cyJweCWgnfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CDD1005D5A;
        Fri, 20 Nov 2020 15:12:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4979410021B3;
        Fri, 20 Nov 2020 15:12:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 48/76] fscache: Always create /proc/fs/fscache/stats if
 configured
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:12:51 +0000
Message-ID: <160588517154.3465195.3972712335234937475.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the fscache initialisation so that /proc/fs/fscache/stats is always
created, if FSCACHE_STATS=y, thereby allowing it to be used if the read
helper is enabled, but not the rest of the caching infrastructure.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Makefile     |    3 +
 fs/fscache/cache_init.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h   |   12 +++-
 fs/fscache/main.c       |  115 ++++-----------------------------------
 fs/fscache/proc.c       |   52 +-----------------
 fs/fscache/stats.c      |    8 +++
 6 files changed, 174 insertions(+), 155 deletions(-)
 create mode 100644 fs/fscache/cache_init.c

diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 3caf66810e7b..5d3284f6fe2d 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -5,6 +5,7 @@
 
 fscache-y := \
 	cache.o \
+	cache_init.o \
 	cookie.o \
 	dispatcher.o \
 	fsdef.o \
@@ -15,8 +16,8 @@ fscache-y := \
 	object_bits.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
-fscache-$(CONFIG_FSCACHE_STATS) += stats.o
 fscache-$(CONFIG_FSCACHE_HISTOGRAM) += histogram.o
 fscache-$(CONFIG_FSCACHE_OBJECT_LIST) += object-list.o
+fscache-$(CONFIG_FSCACHE_STATS) += stats.o
 
 obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache/cache_init.c b/fs/fscache/cache_init.c
new file mode 100644
index 000000000000..8cade2e00050
--- /dev/null
+++ b/fs/fscache/cache_init.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* General filesystem local caching manager
+ *
+ * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+struct kobject *fscache_root;
+struct workqueue_struct *fscache_op_wq;
+
+/* these values serve as lower bounds, will be adjusted in fscache_init() */
+static unsigned fscache_object_max_active = 4;
+static unsigned fscache_op_max_active = 2;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table_header *fscache_sysctl_header;
+
+static int fscache_max_active_sysctl(struct ctl_table *table, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct workqueue_struct **wqp = table->extra1;
+	unsigned int *datap = table->data;
+	int ret;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (ret == 0)
+		workqueue_set_max_active(*wqp, *datap);
+	return ret;
+}
+
+static struct ctl_table fscache_sysctls[] = {
+	{
+		.procname	= "operation_max_active",
+		.data		= &fscache_op_max_active,
+		.maxlen		= sizeof(unsigned),
+		.mode		= 0644,
+		.proc_handler	= fscache_max_active_sysctl,
+		.extra1		= &fscache_op_wq,
+	},
+	{}
+};
+
+static struct ctl_table fscache_sysctls_root[] = {
+	{
+		.procname	= "fscache",
+		.mode		= 0555,
+		.child		= fscache_sysctls,
+	},
+	{}
+};
+#endif
+
+/*
+ * Initialise the caching code.
+ */
+int __init fscache_init_caching(void)
+{
+	int ret;
+
+	fscache_op_max_active =
+		clamp_val(fscache_object_max_active / 2,
+			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
+
+	ret = -ENOMEM;
+	fscache_op_wq = alloc_workqueue("fscache_operation", WQ_UNBOUND,
+					fscache_op_max_active);
+	if (!fscache_op_wq)
+		goto error_op_wq;
+
+	ret = fscache_init_dispatchers();
+	if (ret < 0)
+		goto error_dispatchers;
+
+	ret = fscache_proc_caching_init();
+	if (ret < 0)
+		goto error_proc;
+
+#ifdef CONFIG_SYSCTL
+	ret = -ENOMEM;
+	fscache_sysctl_header = register_sysctl_table(fscache_sysctls_root);
+	if (!fscache_sysctl_header)
+		goto error_sysctl;
+#endif
+
+	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
+					       sizeof(struct fscache_cookie),
+					       0, 0, NULL);
+	if (!fscache_cookie_jar) {
+		pr_notice("Failed to allocate a cookie jar\n");
+		ret = -ENOMEM;
+		goto error_cookie_jar;
+	}
+
+	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
+	if (!fscache_root)
+		goto error_kobj;
+
+	return 0;
+
+error_kobj:
+	kmem_cache_destroy(fscache_cookie_jar);
+error_cookie_jar:
+#ifdef CONFIG_SYSCTL
+	unregister_sysctl_table(fscache_sysctl_header);
+error_sysctl:
+#endif
+	fscache_kill_dispatchers();
+error_dispatchers:
+error_proc:
+	destroy_workqueue(fscache_op_wq);
+error_op_wq:
+	return ret;
+}
+
+/*
+ * clean up on module removal
+ */
+void __exit fscache_exit_caching(void)
+{
+	_enter("");
+
+	kobject_put(fscache_root);
+	kmem_cache_destroy(fscache_cookie_jar);
+#ifdef CONFIG_SYSCTL
+	unregister_sysctl_table(fscache_sysctl_header);
+#endif
+	fscache_kill_dispatchers();
+	destroy_workqueue(fscache_op_wq);
+}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index ae05f636faac..1721823b8cac 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -56,6 +56,12 @@ static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
 		kfree(tag);
 }
 
+/*
+ * cache_init.c
+ */
+extern int __init fscache_init_caching(void);
+extern void __exit fscache_exit_caching(void);
+
 /*
  * cookie.c
  */
@@ -164,11 +170,9 @@ extern void fscache_objlist_remove(struct fscache_object *);
  * proc.c
  */
 #ifdef CONFIG_PROC_FS
-extern int __init fscache_proc_init(void);
-extern void fscache_proc_cleanup(void);
+extern int __init fscache_proc_caching_init(void);
 #else
 #define fscache_proc_init()	(0)
-#define fscache_proc_cleanup()	do {} while (0)
 #endif
 
 /*
@@ -230,11 +234,13 @@ static inline void fscache_stat_d(atomic_t *stat)
 #define __fscache_stat(stat) (stat)
 
 int fscache_stats_show(struct seq_file *m, void *v);
+extern int __init fscache_proc_stats_init(void);
 #else
 
 #define __fscache_stat(stat) (NULL)
 #define fscache_stat(stat) do {} while (0)
 #define fscache_stat_d(stat) do {} while (0)
+#define fscache_proc_stats_init(void) 0
 #endif
 
 static inline
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 003e53d17245..9bdcd9557aa6 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -11,8 +11,7 @@
 #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/slab.h>
-#include <linux/seq_file.h>
-#define CREATE_TRACE_POINTS
+#include <linux/proc_fs.h>
 #include "internal.h"
 
 MODULE_DESCRIPTION("FS Cache Manager");
@@ -25,115 +24,31 @@ module_param_named(debug, fscache_debug, uint,
 MODULE_PARM_DESC(fscache_debug,
 		 "FS-Cache debugging mask");
 
-struct kobject *fscache_root;
-struct workqueue_struct *fscache_op_wq;
-
-/* these values serve as lower bounds, will be adjusted in fscache_init() */
-static unsigned fscache_object_max_active = 4;
-static unsigned fscache_op_max_active = 2;
-
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_header *fscache_sysctl_header;
-
-static int fscache_max_active_sysctl(struct ctl_table *table, int write,
-				     void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct workqueue_struct **wqp = table->extra1;
-	unsigned int *datap = table->data;
-	int ret;
-
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (ret == 0)
-		workqueue_set_max_active(*wqp, *datap);
-	return ret;
-}
-
-static struct ctl_table fscache_sysctls[] = {
-	{
-		.procname	= "operation_max_active",
-		.data		= &fscache_op_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_op_wq,
-	},
-	{}
-};
-
-static struct ctl_table fscache_sysctls_root[] = {
-	{
-		.procname	= "fscache",
-		.mode		= 0555,
-		.child		= fscache_sysctls,
-	},
-	{}
-};
-#endif
-
 /*
- * initialise the fs caching module
+ * Initialise the module
  */
 static int __init fscache_init(void)
 {
 	int ret;
 
-	fscache_op_max_active =
-		clamp_val(fscache_object_max_active / 2,
-			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
-
-	ret = -ENOMEM;
-	fscache_op_wq = alloc_workqueue("fscache_operation", WQ_UNBOUND,
-					fscache_op_max_active);
-	if (!fscache_op_wq)
-		goto error_op_wq;
+	if (!proc_mkdir("fs/fscache", NULL))
+		return -ENOMEM;
 
-	ret = fscache_init_dispatchers();
+	ret = fscache_proc_stats_init();
 	if (ret < 0)
-		goto error_dispatchers;
+		goto error;
 
-	ret = fscache_proc_init();
+	ret = fscache_init_caching();
 	if (ret < 0)
-		goto error_proc;
-
-#ifdef CONFIG_SYSCTL
-	ret = -ENOMEM;
-	fscache_sysctl_header = register_sysctl_table(fscache_sysctls_root);
-	if (!fscache_sysctl_header)
-		goto error_sysctl;
-#endif
-
-	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
-					       sizeof(struct fscache_cookie),
-					       0, 0, NULL);
-	if (!fscache_cookie_jar) {
-		pr_notice("Failed to allocate a cookie jar\n");
-		ret = -ENOMEM;
-		goto error_cookie_jar;
-	}
-
-	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
-	if (!fscache_root)
-		goto error_kobj;
+		goto error;
 
 	pr_notice("Loaded\n");
 	return 0;
 
-error_kobj:
-	kmem_cache_destroy(fscache_cookie_jar);
-error_cookie_jar:
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-error_sysctl:
-#endif
-	fscache_kill_dispatchers();
-error_dispatchers:
-	fscache_proc_cleanup();
-error_proc:
-	destroy_workqueue(fscache_op_wq);
-error_op_wq:
+error:
+	remove_proc_subtree("fs/fscache", NULL);
 	return ret;
 }
-
 fs_initcall(fscache_init);
 
 /*
@@ -143,14 +58,8 @@ static void __exit fscache_exit(void)
 {
 	_enter("");
 
-	kobject_put(fscache_root);
-	kmem_cache_destroy(fscache_cookie_jar);
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-#endif
-	fscache_proc_cleanup();
-	fscache_kill_dispatchers();
-	destroy_workqueue(fscache_op_wq);
+	remove_proc_subtree("fs/fscache", NULL);
+	fscache_exit_caching();
 	pr_notice("Unloaded\n");
 }
 
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index 729d083f1e91..7e156b21bb1d 100644
--- a/fs/fscache/proc.c
+++ b/fs/fscache/proc.c
@@ -14,67 +14,23 @@
 /*
  * initialise the /proc/fs/fscache/ directory
  */
-int __init fscache_proc_init(void)
+int __init fscache_proc_caching_init(void)
 {
-	if (!proc_mkdir("fs/fscache", NULL))
-		goto error_dir;
-
 	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
 			     &fscache_cookies_seq_ops))
-		goto error_cookies;
-
-#ifdef CONFIG_FSCACHE_STATS
-	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
-			fscache_stats_show))
-		goto error_stats;
-#endif
+		return -ENOMEM;
 
 #ifdef CONFIG_FSCACHE_HISTOGRAM
 	if (!proc_create_seq("fs/fscache/histogram", S_IFREG | 0444, NULL,
 			 &fscache_histogram_ops))
-		goto error_histogram;
+		return -ENOMEM;
 #endif
 
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
 			 &fscache_objlist_proc_ops))
-		goto error_objects;
+		return -ENOMEM;
 #endif
 
 	return 0;
-
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-error_objects:
-#endif
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-	remove_proc_entry("fs/fscache/histogram", NULL);
-error_histogram:
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-error_stats:
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
-error_cookies:
-	remove_proc_entry("fs/fscache", NULL);
-error_dir:
-	return -ENOMEM;
-}
-
-/*
- * clean up the /proc/fs/fscache/ directory
- */
-void fscache_proc_cleanup(void)
-{
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	remove_proc_entry("fs/fscache/objects", NULL);
-#endif
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-	remove_proc_entry("fs/fscache/histogram", NULL);
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
-	remove_proc_entry("fs/fscache", NULL);
 }
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index dffe6925aadb..bf2935571de5 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -115,3 +115,11 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cache_culled_objects));
 	return 0;
 }
+
+int __init fscache_proc_stats_init(void)
+{
+	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
+			fscache_stats_show))
+		return -ENOMEM;
+	return 0;
+}


