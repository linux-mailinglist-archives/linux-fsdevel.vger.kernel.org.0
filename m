Return-Path: <linux-fsdevel+bounces-6699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D278381B77C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D101C21BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E87764E;
	Thu, 21 Dec 2023 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxX+F60Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA337762B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBzpmC0rJxDkvfFcXCiCIB5MfO/JtYwi4o+qNt5d+DE=;
	b=FxX+F60Ypw5RuTzQfGJWd/hbmDXu4V1alvrkIr6gl31jQf2WEmCpWLA/PWoe924AVQ8h7P
	LDN+PbaMefxK8UHAMsX/hQtnBXg5bCh8ASg5P3Pd7OoPQL/WBJG0ezGbA1Gn7vreG1wKOD
	U2YB6IZrhyzN2VBsHaPGj93Z6QJg8RA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-y0D9VzEQNPqmRF_h0brYdw-1; Thu, 21 Dec 2023 08:24:18 -0500
X-MC-Unique: y0D9VzEQNPqmRF_h0brYdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A325868A04;
	Thu, 21 Dec 2023 13:24:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23DBD1121313;
	Thu, 21 Dec 2023 13:24:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/40] netfs, fscache: Move fs/fscache/* into fs/netfs/
Date: Thu, 21 Dec 2023 13:22:58 +0000
Message-ID: <20231221132400.1601991-4-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

There's a problem with dependencies between netfslib and fscache as each
wants to access some functions of the other.  Deal with this by moving
fs/fscache/* into fs/netfs/ and renaming those files to begin with
"fscache-".

For the moment, the moved files are changed as little as possible and an
fscache module is still built.  A subsequent patch will integrate them.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---

Notes:
    Changes
    =======
    ver #5)
     - Adjust MAINTAINERS file.

 MAINTAINERS                                   | 21 ++++++----
 fs/Kconfig                                    |  1 -
 fs/Makefile                                   |  1 -
 fs/fscache/Kconfig                            | 40 -------------------
 fs/fscache/Makefile                           | 16 --------
 fs/netfs/Kconfig                              | 39 ++++++++++++++++++
 fs/netfs/Makefile                             | 14 ++++++-
 fs/{fscache/cache.c => netfs/fscache_cache.c} |  0
 .../cookie.c => netfs/fscache_cookie.c}       |  0
 .../internal.h => netfs/fscache_internal.h}   |  0
 fs/{fscache/io.c => netfs/fscache_io.c}       |  0
 fs/{fscache/main.c => netfs/fscache_main.c}   |  0
 fs/{fscache/proc.c => netfs/fscache_proc.c}   |  0
 fs/{fscache/stats.c => netfs/fscache_stats.c} |  0
 .../volume.c => netfs/fscache_volume.c}       |  0
 fs/netfs/internal.h                           |  5 +++
 fs/netfs/main.c                               |  5 ++-
 17 files changed, 73 insertions(+), 69 deletions(-)
 delete mode 100644 fs/fscache/Kconfig
 delete mode 100644 fs/fscache/Makefile
 rename fs/{fscache/cache.c => netfs/fscache_cache.c} (100%)
 rename fs/{fscache/cookie.c => netfs/fscache_cookie.c} (100%)
 rename fs/{fscache/internal.h => netfs/fscache_internal.h} (100%)
 rename fs/{fscache/io.c => netfs/fscache_io.c} (100%)
 rename fs/{fscache/main.c => netfs/fscache_main.c} (100%)
 rename fs/{fscache/proc.c => netfs/fscache_proc.c} (100%)
 rename fs/{fscache/stats.c => netfs/fscache_stats.c} (100%)
 rename fs/{fscache/volume.c => netfs/fscache_volume.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..b38e1723b505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8135,6 +8135,19 @@ S:	Supported
 F:	fs/iomap/
 F:	include/linux/iomap.h
 
+FILESYSTEMS [NETFS LIBRARY]
+M:	David Howells <dhowells@redhat.com>
+L:	linux-cachefs@redhat.com (moderated for non-subscribers)
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	Documentation/filesystems/caching/
+F:	Documentation/filesystems/netfs_library.rst
+F:	fs/netfs/
+F:	include/linux/fscache*.h
+F:	include/linux/netfs.h
+F:	include/trace/events/fscache.h
+F:	include/trace/events/netfs.h
+
 FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
 L:	linux-hwmon@vger.kernel.org
@@ -8569,14 +8582,6 @@ F:	Documentation/power/freezing-of-tasks.rst
 F:	include/linux/freezer.h
 F:	kernel/freezer.c
 
-FS-CACHE: LOCAL CACHING FOR NETWORK FILESYSTEMS
-M:	David Howells <dhowells@redhat.com>
-L:	linux-cachefs@redhat.com (moderated for non-subscribers)
-S:	Supported
-F:	Documentation/filesystems/caching/
-F:	fs/fscache/
-F:	include/linux/fscache*.h
-
 FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
 M:	Eric Biggers <ebiggers@kernel.org>
 M:	Theodore Y. Ts'o <tytso@mit.edu>
diff --git a/fs/Kconfig b/fs/Kconfig
index 42837617a55b..c935c341eb6e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -140,7 +140,6 @@ source "fs/overlayfs/Kconfig"
 menu "Caches"
 
 source "fs/netfs/Kconfig"
-source "fs/fscache/Kconfig"
 source "fs/cachefiles/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 75522f88e763..af7632368e98 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
-obj-$(CONFIG_FSCACHE)		+= fscache/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
 # We place ext4 before ext2 so that clean ext3 root fs's do NOT mount using the
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
deleted file mode 100644
index b313a978ae0a..000000000000
--- a/fs/fscache/Kconfig
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-config FSCACHE
-	tristate "General filesystem local caching manager"
-	select NETFS_SUPPORT
-	help
-	  This option enables a generic filesystem caching manager that can be
-	  used by various network and other filesystems to cache data locally.
-	  Different sorts of caches can be plugged in, depending on the
-	  resources available.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_STATS
-	bool "Gather statistical information on local caching"
-	depends on FSCACHE && PROC_FS
-	select NETFS_STATS
-	help
-	  This option causes statistical information to be gathered on local
-	  caching and exported through file:
-
-		/proc/fs/fscache/stats
-
-	  The gathering of statistics adds a certain amount of overhead to
-	  execution as there are a quite a few stats gathered, and on a
-	  multi-CPU system these may be on cachelines that keep bouncing
-	  between CPUs.  On the other hand, the stats are very useful for
-	  debugging purposes.  Saying 'Y' here is recommended.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_DEBUG
-	bool "Debug FS-Cache"
-	depends on FSCACHE
-	help
-	  This permits debugging to be dynamically enabled in the local caching
-	  management module.  If this is set, the debugging output may be
-	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
deleted file mode 100644
index afb090ea16c4..000000000000
--- a/fs/fscache/Makefile
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for general filesystem caching code
-#
-
-fscache-y := \
-	cache.o \
-	cookie.o \
-	io.o \
-	main.o \
-	volume.o
-
-fscache-$(CONFIG_PROC_FS) += proc.o
-fscache-$(CONFIG_FSCACHE_STATS) += stats.o
-
-obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index b4db21022cb4..b4378688357c 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -21,3 +21,42 @@ config NETFS_STATS
 	  multi-CPU system these may be on cachelines that keep bouncing
 	  between CPUs.  On the other hand, the stats are very useful for
 	  debugging purposes.  Saying 'Y' here is recommended.
+
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
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 386d6fb92793..bbb2b824bd5e 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,5 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 
+fscache-y := \
+	fscache_cache.o \
+	fscache_cookie.o \
+	fscache_io.o \
+	fscache_main.o \
+	fscache_volume.o
+
+fscache-$(CONFIG_PROC_FS) += fscache_proc.o
+fscache-$(CONFIG_FSCACHE_STATS) += fscache_stats.o
+
+obj-$(CONFIG_FSCACHE) := fscache.o
+
 netfs-y := \
 	buffered_read.o \
 	io.o \
@@ -9,4 +21,4 @@ netfs-y := \
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
-obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
+obj-$(CONFIG_NETFS_SUPPORT) += netfs.o
diff --git a/fs/fscache/cache.c b/fs/netfs/fscache_cache.c
similarity index 100%
rename from fs/fscache/cache.c
rename to fs/netfs/fscache_cache.c
diff --git a/fs/fscache/cookie.c b/fs/netfs/fscache_cookie.c
similarity index 100%
rename from fs/fscache/cookie.c
rename to fs/netfs/fscache_cookie.c
diff --git a/fs/fscache/internal.h b/fs/netfs/fscache_internal.h
similarity index 100%
rename from fs/fscache/internal.h
rename to fs/netfs/fscache_internal.h
diff --git a/fs/fscache/io.c b/fs/netfs/fscache_io.c
similarity index 100%
rename from fs/fscache/io.c
rename to fs/netfs/fscache_io.c
diff --git a/fs/fscache/main.c b/fs/netfs/fscache_main.c
similarity index 100%
rename from fs/fscache/main.c
rename to fs/netfs/fscache_main.c
diff --git a/fs/fscache/proc.c b/fs/netfs/fscache_proc.c
similarity index 100%
rename from fs/fscache/proc.c
rename to fs/netfs/fscache_proc.c
diff --git a/fs/fscache/stats.c b/fs/netfs/fscache_stats.c
similarity index 100%
rename from fs/fscache/stats.c
rename to fs/netfs/fscache_stats.c
diff --git a/fs/fscache/volume.c b/fs/netfs/fscache_volume.c
similarity index 100%
rename from fs/fscache/volume.c
rename to fs/netfs/fscache_volume.c
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 43fac1b14e40..e96432499eb2 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -5,9 +5,12 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <trace/events/netfs.h>
+#include "fscache_internal.h"
 
 #ifdef pr_fmt
 #undef pr_fmt
@@ -107,6 +110,7 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 /*
  * debug tracing
  */
+#if 0
 #define dbgprintk(FMT, ...) \
 	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
 
@@ -143,3 +147,4 @@ do {						\
 #define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
 #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
 #endif
+#endif
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 068568702957..237c54a01d97 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -8,8 +8,8 @@
 #include <linux/module.h>
 #include <linux/export.h>
 #include "internal.h"
-#define CREATE_TRACE_POINTS
-#include <trace/events/netfs.h>
+//#define CREATE_TRACE_POINTS
+//#include <trace/events/netfs.h>
 
 MODULE_DESCRIPTION("Network fs support");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -18,3 +18,4 @@ MODULE_LICENSE("GPL");
 unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+


