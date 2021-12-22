Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0971D47DAF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbhLVX0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344908AbhLVX0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUX5KVPe1aKL4iBg1mYeZuSBKFHmmuMxsuoLWaqpba4=;
        b=YE8FneRv70MjiGpMR6DmQUtqmjlIwLU+T+1R4yuJu6lTut30m+YGMmiRKJDj4+jGXJzKqj
        8Wv6fMfikmLRqtgXayeSpiifAaoRiRBE+uNv7W1rCV2EcLyT7UQjGBW/mirBMg2moApEfH
        I/cyAkIBBylgivduhK4F11NKQI28LtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-a1IjEcQXO8esjqMMCoTGhA-1; Wed, 22 Dec 2021 18:26:40 -0500
X-MC-Unique: a1IjEcQXO8esjqMMCoTGhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B13DF801B0C;
        Wed, 22 Dec 2021 23:26:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30F9610911A9;
        Wed, 22 Dec 2021 23:26:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 49/68] cachefiles: Implement begin and end I/O operation
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
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:26:30 +0000
Message-ID: <164021559030.640689.3684291785218094142.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the methods for beginning and ending an I/O operation.

When called to begin an I/O operation, we are guaranteed that the cookie
has reached a certain stage (we're called by fscache after it has done a
suitable wait).

If a file is available, we paste a ref over into the cache resources for
the I/O routines to use.  This means that the object can be invalidated
whilst the I/O is ongoing without the need to synchronise as the file
pointer in the object is replaced, but the file pointer in the cache
resources is unaffected.

Ending the operation just requires ditching any refs we have and dropping
the access guarantee that fscache got for us on the cookie.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819645033.215744.2199344081658268312.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906951916.143852.9531384743995679857.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967161222.1823006.4461476204800357263.stgit@warthog.procyon.org.uk/ # v3
---

 fs/cachefiles/Makefile         |    1 +
 fs/cachefiles/interface.c      |    1 +
 fs/cachefiles/internal.h       |   18 +++++++++++++
 fs/cachefiles/io.c             |   57 ++++++++++++++++++++++++++++++++++++++++
 include/trace/events/fscache.h |    2 +
 5 files changed, 79 insertions(+)
 create mode 100644 fs/cachefiles/io.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index cb7a6bcf51eb..16d811f1a2fa 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -7,6 +7,7 @@ cachefiles-y := \
 	cache.o \
 	daemon.o \
 	interface.o \
+	io.o \
 	key.o \
 	main.o \
 	namei.o \
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index e47c52c34071..ad9d311413ff 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -362,5 +362,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.lookup_cookie		= cachefiles_lookup_cookie,
 	.withdraw_cookie	= cachefiles_withdraw_cookie,
 	.invalidate_cookie	= cachefiles_invalidate_cookie,
+	.begin_operation	= cachefiles_begin_operation,
 	.prepare_to_write	= cachefiles_prepare_to_write,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d7aae04edc61..d5868f5514d3 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -105,6 +105,18 @@ struct cachefiles_cache {
 
 #include <trace/events/cachefiles.h>
 
+static inline
+struct file *cachefiles_cres_file(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv2;
+}
+
+static inline
+struct cachefiles_object *cachefiles_cres_object(struct netfs_cache_resources *cres)
+{
+	return fscache_cres_cookie(cres)->cache_priv;
+}
+
 /*
  * note change of state for daemon
  */
@@ -177,6 +189,12 @@ extern struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object
 extern void cachefiles_put_object(struct cachefiles_object *object,
 				  enum cachefiles_obj_ref_trace why);
 
+/*
+ * io.c
+ */
+extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
+				       enum fscache_want_state want_state);
+
 /*
  * key.c
  */
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
new file mode 100644
index 000000000000..adeb9a42fd7b
--- /dev/null
+++ b/fs/cachefiles/io.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* kiocb-using read/write
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/falloc.h>
+#include <linux/sched/mm.h>
+#include <trace/events/fscache.h>
+#include "internal.h"
+
+/*
+ * Clean up an operation.
+ */
+static void cachefiles_end_operation(struct netfs_cache_resources *cres)
+{
+	struct file *file = cachefiles_cres_file(cres);
+
+	if (file)
+		fput(file);
+	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
+}
+
+static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
+	.end_operation		= cachefiles_end_operation,
+};
+
+/*
+ * Open the cache file when beginning a cache operation.
+ */
+bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_state want_state)
+{
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+
+	if (!cachefiles_cres_file(cres)) {
+		cres->ops = &cachefiles_netfs_cache_ops;
+		if (object->file) {
+			spin_lock(&object->lock);
+			if (!cres->cache_priv2 && object->file)
+				cres->cache_priv2 = get_file(object->file);
+			spin_unlock(&object->lock);
+		}
+	}
+
+	if (!cachefiles_cres_file(cres) && want_state != FSCACHE_WANT_PARAMS) {
+		pr_err("failed to get cres->file\n");
+		return false;
+	}
+
+	return true;
+}
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index d9d830296ec3..1594aefadeac 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -78,6 +78,7 @@ enum fscache_access_trace {
 	fscache_access_cache_unpin,
 	fscache_access_invalidate_cookie,
 	fscache_access_invalidate_cookie_end,
+	fscache_access_io_end,
 	fscache_access_io_not_live,
 	fscache_access_io_read,
 	fscache_access_io_resize,
@@ -152,6 +153,7 @@ enum fscache_access_trace {
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
 	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
 	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
+	EM(fscache_access_io_end,		"END   io     ")	\
 	EM(fscache_access_io_not_live,		"END   io_notl")	\
 	EM(fscache_access_io_read,		"BEGIN io_read")	\
 	EM(fscache_access_io_resize,		"BEGIN io_resz")	\


