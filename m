Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880ED461868
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378603AbhK2ObR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377994AbhK2O1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNoahQqoijxnQzeud606cw1ZJJa+5oCykmQJTMHWAWw=;
        b=bhIeBAqONGtojtw8qTwogDOUFryiOoRJZUgqhQYvSzIAa2mTeNWY2UO6Yd9ZLj6C7q9qM3
        eS6n9edKko348zwxtTM5wG7FMavc6XfDJFEzKAUNJgtiws5ujoRAX6sncKLqfTETSCGZv5
        TMlMt5DTrnOIND4gRnEPeUZ6AGQ12sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-585-yXi1lZVHMO2BpaQeU48vXQ-1; Mon, 29 Nov 2021 09:24:18 -0500
X-MC-Unique: yXi1lZVHMO2BpaQeU48vXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E125E10B7462;
        Mon, 29 Nov 2021 14:24:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29586694BF;
        Mon, 29 Nov 2021 14:24:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/64] fscache: Introduce new driver
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:24:00 +0000
Message-ID: <163819584034.215744.4290533472390439030.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce basic skeleton of the new, rewritten fscache driver.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/Makefile                    |    1 
 fs/fscache/Kconfig             |   39 +++++++++
 fs/fscache/Makefile            |   12 +++
 fs/fscache/internal.h          |  183 ++++++++++++++++++++++++++++++++++++++++
 fs/fscache/main.c              |   65 ++++++++++++++
 fs/fscache/proc.c              |   42 +++++++++
 fs/fscache/stats.c             |   22 +++++
 include/linux/fscache-cache.h  |    2 
 include/linux/fscache.h        |    6 +
 include/trace/events/fscache.h |   49 +++++++++++
 10 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 fs/fscache/Makefile
 create mode 100644 fs/fscache/internal.h
 create mode 100644 fs/fscache/main.c
 create mode 100644 fs/fscache/proc.c
 create mode 100644 fs/fscache/stats.c
 create mode 100644 include/trace/events/fscache.h

diff --git a/fs/Makefile b/fs/Makefile
index 23ddd0803d14..290815f3fd31 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
+obj-$(CONFIG_FSCACHE)		+= fscache/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
 # We place ext4 before ext2 so that clean ext3 root fs's do NOT mount using the
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 6440484d9461..76316c4a3fb7 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -1,4 +1,43 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config FSCACHE
+	tristate "General filesystem local caching manager"
+	select NETFS_SUPPORT
+	help
+	  This option enables a generic filesystem caching manager that can be
+	  used by various network and other filesystems to cache data locally.
+	  Different sorts of caches can be plugged in, depending on the
+	  resources available.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
+
+config FSCACHE_STATS
+	bool "Gather statistical information on local caching"
+	depends on FSCACHE && PROC_FS
+	select NETFS_STATS
+	help
+	  This option causes statistical information to be gathered on local
+	  caching and exported through file:
+
+		/proc/fs/fscache/stats
+
+	  The gathering of statistics adds a certain amount of overhead to
+	  execution as there are a quite a few stats gathered, and on a
+	  multi-CPU system these may be on cachelines that keep bouncing
+	  between CPUs.  On the other hand, the stats are very useful for
+	  debugging purposes.  Saying 'Y' here is recommended.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
+
+config FSCACHE_DEBUG
+	bool "Debug FS-Cache"
+	depends on FSCACHE
+	help
+	  This permits debugging to be dynamically enabled in the local caching
+	  management module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
+
+	  See Documentation/filesystems/caching/fscache.rst for more information.
+
 config FSCACHE_OLD_API
 	bool
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
new file mode 100644
index 000000000000..f9722de32247
--- /dev/null
+++ b/fs/fscache/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for general filesystem caching code
+#
+
+fscache-y := \
+	main.o
+
+fscache-$(CONFIG_PROC_FS) += proc.o
+fscache-$(CONFIG_FSCACHE_STATS) += stats.o
+
+obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
new file mode 100644
index 000000000000..ea52f8594a77
--- /dev/null
+++ b/fs/fscache/internal.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Internal definitions for FS-Cache
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "FS-Cache: " fmt
+
+#include <linux/slab.h>
+#include <linux/fscache-cache.h>
+#include <trace/events/fscache.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+
+/*
+ * main.c
+ */
+extern unsigned fscache_debug;
+
+/*
+ * proc.c
+ */
+#ifdef CONFIG_PROC_FS
+extern int __init fscache_proc_init(void);
+extern void fscache_proc_cleanup(void);
+#else
+#define fscache_proc_init()	(0)
+#define fscache_proc_cleanup()	do {} while (0)
+#endif
+
+/*
+ * stats.c
+ */
+#ifdef CONFIG_FSCACHE_STATS
+
+static inline void fscache_stat(atomic_t *stat)
+{
+	atomic_inc(stat);
+}
+
+static inline void fscache_stat_d(atomic_t *stat)
+{
+	atomic_dec(stat);
+}
+
+#define __fscache_stat(stat) (stat)
+
+int fscache_stats_show(struct seq_file *m, void *v);
+#else
+
+#define __fscache_stat(stat) (NULL)
+#define fscache_stat(stat) do {} while (0)
+#define fscache_stat_d(stat) do {} while (0)
+#endif
+
+
+/*****************************************************************************/
+/*
+ * debug tracing
+ */
+#define dbgprintk(FMT, ...) \
+	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+
+#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
+
+#define kjournal(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+
+#ifdef __KDEBUG
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_FSCACHE_DEBUG)
+#define _enter(FMT, ...)			\
+do {						\
+	if (__do_kdebug(ENTER))			\
+		kenter(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _leave(FMT, ...)			\
+do {						\
+	if (__do_kdebug(LEAVE))			\
+		kleave(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _debug(FMT, ...)			\
+do {						\
+	if (__do_kdebug(DEBUG))			\
+		kdebug(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
+
+/*
+ * determine whether a particular optional debugging point should be logged
+ * - we need to go through three steps to persuade cpp to correctly join the
+ *   shorthand in FSCACHE_DEBUG_LEVEL with its prefix
+ */
+#define ____do_kdebug(LEVEL, POINT) \
+	unlikely((fscache_debug & \
+		  (FSCACHE_POINT_##POINT << (FSCACHE_DEBUG_ ## LEVEL * 3))))
+#define ___do_kdebug(LEVEL, POINT) \
+	____do_kdebug(LEVEL, POINT)
+#define __do_kdebug(POINT) \
+	___do_kdebug(FSCACHE_DEBUG_LEVEL, POINT)
+
+#define FSCACHE_DEBUG_CACHE	0
+#define FSCACHE_DEBUG_COOKIE	1
+#define FSCACHE_DEBUG_OBJECT	2
+#define FSCACHE_DEBUG_OPERATION	3
+
+#define FSCACHE_POINT_ENTER	1
+#define FSCACHE_POINT_LEAVE	2
+#define FSCACHE_POINT_DEBUG	4
+
+#ifndef FSCACHE_DEBUG_LEVEL
+#define FSCACHE_DEBUG_LEVEL CACHE
+#endif
+
+/*
+ * assertions
+ */
+#if 1 /* defined(__KDEBUGALL) */
+
+#define ASSERT(X)							\
+do {									\
+	if (unlikely(!(X))) {						\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTCMP(X, OP, Y)						\
+do {									\
+	if (unlikely(!((X) OP (Y)))) {					\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		pr_err("%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIF(C, X)							\
+do {									\
+	if (unlikely((C) && !(X))) {					\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIFCMP(C, X, OP, Y)					\
+do {									\
+	if (unlikely((C) && !((X) OP (Y)))) {				\
+		pr_err("\n");					\
+		pr_err("Assertion failed\n");	\
+		pr_err("%lx " #OP " %lx is false\n",		\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#else
+
+#define ASSERT(X)			do {} while (0)
+#define ASSERTCMP(X, OP, Y)		do {} while (0)
+#define ASSERTIF(C, X)			do {} while (0)
+#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
+
+#endif /* assert or not */
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
new file mode 100644
index 000000000000..819de2ee1276
--- /dev/null
+++ b/fs/fscache/main.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* General filesystem local caching manager
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include <linux/init.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+MODULE_DESCRIPTION("FS Cache Manager");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+unsigned fscache_debug;
+module_param_named(debug, fscache_debug, uint,
+		   S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(fscache_debug,
+		 "FS-Cache debugging mask");
+
+struct workqueue_struct *fscache_wq;
+EXPORT_SYMBOL(fscache_wq);
+
+/*
+ * initialise the fs caching module
+ */
+static int __init fscache_init(void)
+{
+	int ret = -ENOMEM;
+
+	fscache_wq = alloc_workqueue("fscache", WQ_UNBOUND | WQ_FREEZABLE, 0);
+	if (!fscache_wq)
+		goto error_wq;
+
+	ret = fscache_proc_init();
+	if (ret < 0)
+		goto error_proc;
+
+	pr_notice("Loaded\n");
+	return 0;
+
+error_proc:
+	destroy_workqueue(fscache_wq);
+error_wq:
+	return ret;
+}
+
+fs_initcall(fscache_init);
+
+/*
+ * clean up on module removal
+ */
+static void __exit fscache_exit(void)
+{
+	_enter("");
+
+	fscache_proc_cleanup();
+	destroy_workqueue(fscache_wq);
+	pr_notice("Unloaded\n");
+}
+
+module_exit(fscache_exit);
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
new file mode 100644
index 000000000000..b28003d7d63f
--- /dev/null
+++ b/fs/fscache/proc.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache statistics viewing interface
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+/*
+ * initialise the /proc/fs/fscache/ directory
+ */
+int __init fscache_proc_init(void)
+{
+	if (!proc_mkdir("fs/fscache", NULL))
+		goto error_dir;
+
+#ifdef CONFIG_FSCACHE_STATS
+	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
+				fscache_stats_show))
+		goto error;
+#endif
+
+	return 0;
+
+error:
+	remove_proc_entry("fs/fscache", NULL);
+error_dir:
+	return -ENOMEM;
+}
+
+/*
+ * clean up the /proc/fs/fscache/ directory
+ */
+void fscache_proc_cleanup(void)
+{
+	remove_proc_entry("fs/fscache", NULL);
+}
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
new file mode 100644
index 000000000000..bd92f93e1680
--- /dev/null
+++ b/fs/fscache/stats.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache statistics
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL CACHE
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+/*
+ * display the general statistics
+ */
+int fscache_stats_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, "FS-Cache statistics\n");
+
+	netfs_stats_show(m);
+	return 0;
+}
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 47f21a53ac4b..d6910a913918 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -16,4 +16,6 @@
 
 #include <linux/fscache.h>
 
+extern struct workqueue_struct *fscache_wq;
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 0364a4ca16f6..1cf90c252aac 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /* General filesystem caching interface
  *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * NOTE!!! See:
@@ -18,9 +18,13 @@
 #include <linux/netfs.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
+#define __fscache_available (1)
+#define fscache_available() (1)
 #define fscache_cookie_valid(cookie) (cookie)
 #define fscache_cookie_enabled(cookie) (cookie)
 #else
+#define __fscache_available (0)
+#define fscache_available() (0)
 #define fscache_cookie_valid(cookie) (0)
 #define fscache_cookie_enabled(cookie) (0)
 #endif
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
new file mode 100644
index 000000000000..fe214c5cc87f
--- /dev/null
+++ b/include/trace/events/fscache.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* FS-Cache tracepoints
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fscache
+
+#if !defined(_TRACE_FSCACHE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSCACHE_H
+
+#include <linux/fscache.h>
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+#endif
+
+/*
+ * Declare tracing information enums and their string mappings for display.
+ */
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+
+#endif /* _TRACE_FSCACHE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


