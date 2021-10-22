Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399A6437DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhJVTI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234218AbhJVTIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u6FsY60ZEf/aq91jODyRvm26gKiZCdUvfiTMHL93vo=;
        b=K8Uh0sdsYCpL06/PNBQzZ57+B3obWxBJzQZgJCzDxCZJ1vtph1dgHyuwDO8J/KkrsOKadS
        CkipNUBWT7JFKISME5MXbshVWpHmaNZwy5nI8Ui3OOwxLd2frhfN5DDplr7rlGUPuNIgAl
        0HECh6nOTAahi5SGsasvjcqZlGJUhLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-07Qt9FavOLqXEurIohmbUw-1; Fri, 22 Oct 2021 15:05:58 -0400
X-MC-Unique: 07Qt9FavOLqXEurIohmbUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D0318D6A2A;
        Fri, 22 Oct 2021 19:05:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E20A519D9D;
        Fri, 22 Oct 2021 19:05:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 29/53] cachefiles: Introduce new driver
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:05:52 +0100
Message-ID: <163492955211.1038219.12440210955398087211.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce basic skeleton of the new, rewritten cachefiles driver.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/Kconfig                        |    1 
 fs/Makefile                       |    1 
 fs/cachefiles/Kconfig             |   21 +++++++
 fs/cachefiles/Makefile            |    9 +++
 fs/cachefiles/internal.h          |  118 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/main.c              |   53 +++++++++++++++++
 include/trace/events/cachefiles.h |   49 +++++++++++++++
 7 files changed, 252 insertions(+)
 create mode 100644 fs/cachefiles/Kconfig
 create mode 100644 fs/cachefiles/Makefile
 create mode 100644 fs/cachefiles/internal.h
 create mode 100644 fs/cachefiles/main.c
 create mode 100644 include/trace/events/cachefiles.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 68f662c09a8d..001fd1a9115c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -132,6 +132,7 @@ menu "Caches"
 
 source "fs/netfs/Kconfig"
 source "fs/fscache/Kconfig"
+source "fs/cachefiles/Kconfig"
 source "fs/fscache_old/Kconfig"
 source "fs/cachefiles_old/Kconfig"
 
diff --git a/fs/Makefile b/fs/Makefile
index 0dd8a4d526ad..09703d49ac90 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
+obj-$(CONFIG_CACHEFILES)	+= cachefiles/
 obj-$(CONFIG_CACHEFILES_OLD)	+= cachefiles_old/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_TRACING)		+= tracefs/
diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
new file mode 100644
index 000000000000..6827b40f7ddc
--- /dev/null
+++ b/fs/cachefiles/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CACHEFILES
+	tristate "Filesystem caching on files"
+	depends on FSCACHE && BLOCK
+	help
+	  This permits use of a mounted filesystem as a cache for other
+	  filesystems - primarily networking filesystems - thus allowing fast
+	  local disk to enhance the speed of slower devices.
+
+	  See Documentation/filesystems/caching/cachefiles.rst for more
+	  information.
+
+config CACHEFILES_DEBUG
+	bool "Debug CacheFiles"
+	depends on CACHEFILES
+	help
+	  This permits debugging to be dynamically enabled in the filesystem
+	  caching on files module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
+	  by including a debugging specifier in /etc/cachefilesd.conf.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
new file mode 100644
index 000000000000..a7f3e982e249
--- /dev/null
+++ b/fs/cachefiles/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for caching in a mounted filesystem
+#
+
+cachefiles-y := \
+	main.o
+
+obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
new file mode 100644
index 000000000000..55da223e49a9
--- /dev/null
+++ b/fs/cachefiles/internal.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* General netfs cache on cache files internal defs
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "CacheFiles: " fmt
+
+
+#include <linux/fscache-cache.h>
+#include <linux/timer.h>
+#include <linux/wait_bit.h>
+#include <linux/cred.h>
+#include <linux/workqueue.h>
+#include <linux/security.h>
+
+extern unsigned cachefiles_debug;
+#define CACHEFILES_DEBUG_KENTER	1
+#define CACHEFILES_DEBUG_KLEAVE	2
+#define CACHEFILES_DEBUG_KDEBUG	4
+
+
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
+
+#if defined(__KDEBUG)
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_CACHEFILES_DEBUG)
+#define _enter(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KENTER)	\
+		kenter(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _leave(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KLEAVE)	\
+		kleave(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _debug(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KDEBUG)	\
+		kdebug(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
+
+#if 1 /* defined(__KDEBUGALL) */
+
+#define ASSERT(X)							\
+do {									\
+	if (unlikely(!(X))) {						\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTCMP(X, OP, Y)						\
+do {									\
+	if (unlikely(!((X) OP (Y)))) {					\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		pr_err("%lx " #OP " %lx is false\n",			\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIF(C, X)							\
+do {									\
+	if (unlikely((C) && !(X))) {					\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIFCMP(C, X, OP, Y)					\
+do {									\
+	if (unlikely((C) && !((X) OP (Y)))) {				\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		pr_err("%lx " #OP " %lx is false\n",			\
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
+#endif
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
new file mode 100644
index 000000000000..47bc1cc078de
--- /dev/null
+++ b/fs/cachefiles/main.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Network filesystem caching backend to use cache files on a premounted
+ * filesystem
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/statfs.h>
+#include <linux/sysctl.h>
+#include <linux/miscdevice.h>
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+unsigned cachefiles_debug;
+module_param_named(debug, cachefiles_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
+
+MODULE_DESCRIPTION("Mounted-filesystem based cache");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+/*
+ * initialise the fs caching module
+ */
+static int __init cachefiles_init(void)
+{
+	pr_info("Loaded\n");
+	return 0;
+}
+
+fs_initcall(cachefiles_init);
+
+/*
+ * clean up on module removal
+ */
+static void __exit cachefiles_exit(void)
+{
+	pr_info("Unloading\n");
+}
+
+module_exit(cachefiles_exit);
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
new file mode 100644
index 000000000000..5ee0aabb20be
--- /dev/null
+++ b/include/trace/events/cachefiles.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* CacheFiles tracepoints
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cachefiles
+
+#if !defined(_TRACE_CACHEFILES_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CACHEFILES_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+#endif
+
+/*
+ * Define enum -> string mappings for display.
+ */
+
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
+#endif /* _TRACE_CACHEFILES_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


