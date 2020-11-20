Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB62BAE24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgKTPNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729148AbgKTPNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hpLkd3e1GFxX5HiVLrld/21xrzQQ6riD4cN3B8XnlM=;
        b=AlJdnv/IOBf2VvqFWKxeSyIHi5DMQnsaPIJvPDY1V35RrMJaDpiDVKwvPKzh9lksdilEaA
        CeZnPkvYEWNVrh7ia4l10uJjmpurhOlHYFzhtrHKvRNsuDtB6VCH6n22emKnbzPkW+2sGI
        R7oGczi6P3LlEadeQIiX81V/cVaKtYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-kepO-NyjMsm7F9O0tQxt9Q-1; Fri, 20 Nov 2020 10:13:24 -0500
X-MC-Unique: kepO-NyjMsm7F9O0tQxt9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A576D1868408;
        Fri, 20 Nov 2020 15:13:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDBFF6064B;
        Fri, 20 Nov 2020 15:13:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 50/76] fscache: New stats
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
Date:   Fri, 20 Nov 2020 15:13:15 +0000
Message-ID: <160588519591.3465195.13700401271599881928.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create some new stat counters appropriate to the reworked code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c            |    2 ++
 fs/fscache/Kconfig            |    1 +
 fs/fscache/dispatcher.c       |    6 ++++++
 fs/fscache/internal.h         |    8 ++++++--
 fs/fscache/stats.c            |   27 ++++++++++++++++++++++++---
 include/linux/fscache-cache.h |   10 ++++++++++
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index c9866bd5e010..1060c1c57008 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -84,6 +84,7 @@ int cachefiles_read(struct fscache_op_resources *opr,
 
 	__fscache_wait_for_operation(opr, FSCACHE_WANT_READ);
 	fscache_count_io_operation(opr->object->cookie);
+	fscache_count_read();
 
 	/* If the caller asked us to seek for data before doing the read, then
 	 * we should do that now.  If we find a gap, we fill it with zeros.
@@ -233,6 +234,7 @@ int cachefiles_write(struct fscache_op_resources *opr,
 
 	__fscache_wait_for_operation(opr, FSCACHE_WANT_WRITE);
 	fscache_count_io_operation(opr->object->cookie);
+	fscache_count_write();
 
 	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
 	if (!ki)
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index b04f07160e5e..fe7f856a4037 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -14,6 +14,7 @@ config FSCACHE
 config FSCACHE_STATS
 	bool "Gather statistical information on local caching"
 	depends on FSCACHE && PROC_FS
+	select NETFS_STATS
 	help
 	  This option causes statistical information to be gathered on local
 	  caching and exported through file:
diff --git a/fs/fscache/dispatcher.c b/fs/fscache/dispatcher.c
index 3d957e499da3..2663bd4b36e8 100644
--- a/fs/fscache/dispatcher.c
+++ b/fs/fscache/dispatcher.c
@@ -41,6 +41,8 @@ void fscache_dispatch(struct fscache_cookie *cookie,
 	struct fscache_work *work;
 	bool queued = false;
 
+	fscache_stat(&fscache_n_dispatch_count);
+
 	work = kzalloc(sizeof(struct fscache_work), GFP_KERNEL);
 	if (work) {
 		work->cookie = cookie;
@@ -57,10 +59,13 @@ void fscache_dispatch(struct fscache_cookie *cookie,
 			queued = true;
 		}
 		spin_unlock(&fscache_work_lock);
+		if (queued)
+			fscache_stat(&fscache_n_dispatch_deferred);
 	}
 
 	if (!queued) {
 		kfree(work);
+		fscache_stat(&fscache_n_dispatch_inline);
 		func(cookie, object, param);
 	}
 }
@@ -86,6 +91,7 @@ static int fscache_dispatcher(void *data)
 
 			if (work) {
 				work->func(work->cookie, work->object, work->param);
+				fscache_stat(&fscache_n_dispatch_in_pool);
 				fscache_cookie_put(work->cookie, fscache_cookie_put_work);
 				kfree(work);
 			}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 1721823b8cac..73568e84fe3d 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -221,6 +221,11 @@ extern atomic_t fscache_n_cache_stale_objects;
 extern atomic_t fscache_n_cache_retired_objects;
 extern atomic_t fscache_n_cache_culled_objects;
 
+extern atomic_t fscache_n_dispatch_count;
+extern atomic_t fscache_n_dispatch_deferred;
+extern atomic_t fscache_n_dispatch_inline;
+extern atomic_t fscache_n_dispatch_in_pool;
+
 static inline void fscache_stat(atomic_t *stat)
 {
 	atomic_inc(stat);
@@ -233,10 +238,9 @@ static inline void fscache_stat_d(atomic_t *stat)
 
 #define __fscache_stat(stat) (stat)
 
-int fscache_stats_show(struct seq_file *m, void *v);
 extern int __init fscache_proc_stats_init(void);
-#else
 
+#else
 #define __fscache_stat(stat) (NULL)
 #define fscache_stat(stat) do {} while (0)
 #define fscache_stat_d(stat) do {} while (0)
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index bf2935571de5..952214305853 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -6,9 +6,9 @@
  */
 
 #define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/netfs.h>
 #include "internal.h"
 
 /*
@@ -56,13 +56,22 @@ atomic_t fscache_n_cache_stale_objects;
 atomic_t fscache_n_cache_retired_objects;
 atomic_t fscache_n_cache_culled_objects;
 
+atomic_t fscache_n_dispatch_count;
+atomic_t fscache_n_dispatch_deferred;
+atomic_t fscache_n_dispatch_inline;
+atomic_t fscache_n_dispatch_in_pool;
+
+atomic_t fscache_n_read;
+EXPORT_SYMBOL(fscache_n_read);
+atomic_t fscache_n_write;
+EXPORT_SYMBOL(fscache_n_write);
+
 /*
  * display the general statistics
  */
-int fscache_stats_show(struct seq_file *m, void *v)
+static int fscache_stats_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "FS-Cache statistics\n");
-
 	seq_printf(m, "Cookies: idx=%u dat=%u spc=%u\n",
 		   atomic_read(&fscache_n_cookie_index),
 		   atomic_read(&fscache_n_cookie_data),
@@ -113,6 +122,18 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cache_stale_objects),
 		   atomic_read(&fscache_n_cache_retired_objects),
 		   atomic_read(&fscache_n_cache_culled_objects));
+
+	seq_printf(m, "Disp   : n=%u il=%u df=%u pl=%u\n",
+		   atomic_read(&fscache_n_dispatch_count),
+		   atomic_read(&fscache_n_dispatch_inline),
+		   atomic_read(&fscache_n_dispatch_deferred),
+		   atomic_read(&fscache_n_dispatch_in_pool));
+
+	seq_printf(m, "IO     : rd=%u wr=%u\n",
+		   atomic_read(&fscache_n_read),
+		   atomic_read(&fscache_n_write));
+
+	netfs_stats_show(m);
 	return 0;
 }
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 54625464a109..dacfda1d3c20 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -259,4 +259,14 @@ static inline void fscache_uncount_io_operation(struct fscache_cookie *cookie)
 extern void __fscache_wait_for_operation(struct fscache_op_resources *, enum fscache_want_stage);
 extern void __fscache_end_operation(struct fscache_op_resources *);
 
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_read;
+extern atomic_t fscache_n_write;
+#define fscache_count_read() atomic_inc(&fscache_n_read)
+#define fscache_count_write() atomic_inc(&fscache_n_write)
+#else
+#define fscache_count_read() do {} while(0)
+#define fscache_count_write() do {} while(0)
+#endif
+
 #endif /* _LINUX_FSCACHE_CACHE_H */


