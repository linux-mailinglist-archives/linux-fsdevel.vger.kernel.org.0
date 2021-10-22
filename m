Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE17437DF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhJVTLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234396AbhJVTK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmwERs7VHKeWxzX+7bcvlQXu7N9aWN3WcQvwFKOVNvo=;
        b=QMOib7U6eynmStmDGnKRkwR6BXjBg9epXPCzsYJjtvLJqmw9kvbV7xmbK2TiOFYcs62aab
        l8z/nQz5WC6klb0sQzvrVCvEU4M0UptYj7aEI9e4BYyZhz8KQ/CJkErChQwH8lXSZ+YPsC
        P/5f9ti0a/UmZvSXKotA+NNomBPJ0OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-_y3YAgwZNZi7i7kOX_r-Hg-1; Fri, 22 Oct 2021 15:08:04 -0400
X-MC-Unique: _y3YAgwZNZi7i7kOX_r-Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA3F918D6A2A;
        Fri, 22 Oct 2021 19:08:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4E913ABD;
        Fri, 22 Oct 2021 19:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 39/53] cachefiles: Implement begin and end I/O
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
Date:   Fri, 22 Oct 2021 20:07:55 +0100
Message-ID: <163492967580.1038219.14310300084876500421.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the routines for beginning and ending an I/O operation.

When beginning an I/O operation, we are guaranteed that the cookie has
reached a certain stage (we're called by fscache after it has done a
suitable wait).

If a file is available, we paste a ref over into the cache resources for
the I/O routines to use.  This means that the object can be invalidated
whilst the I/O is ongoing without needing to synchronise as the file
pointer in the object is replaced, but the file pointer in the cache
resources is unaffected.

Ending the operation just requires ditching any refs we have and dropping
the access guarantee that fscache got for us on the cookie.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/Makefile         |    1 +
 fs/cachefiles/interface.c      |    1 +
 fs/cachefiles/internal.h       |    6 ++++
 fs/cachefiles/io.c             |   57 ++++++++++++++++++++++++++++++++++++++++
 include/trace/events/fscache.h |    2 +
 5 files changed, 67 insertions(+)
 create mode 100644 fs/cachefiles/io.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 5dd99ca8df05..c0df4c42cb09 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -7,6 +7,7 @@ cachefiles-y := \
 	bind.o \
 	daemon.o \
 	interface.o \
+	io.o \
 	key.o \
 	main.o \
 	namei.o \
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index b4a0bd2e803f..cfbae3ab66db 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -478,5 +478,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.withdraw_cookie	= cachefiles_withdraw_cookie,
 	.invalidate_cookie	= cachefiles_invalidate_cookie,
 	.resize_cookie		= cachefiles_resize_cookie,
+	.begin_operation	= cachefiles_begin_operation,
 	.prepare_to_write	= cachefiles_prepare_to_write,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3fa23710fc6f..d3c7db3b058e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -206,6 +206,12 @@ extern void cachefiles_put_object(struct cachefiles_object *object,
 				  enum cachefiles_obj_ref_trace why);
 extern void cachefiles_sync_cache(struct cachefiles_cache *cache);
 
+/*
+ * io.c
+ */
+extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
+				       enum fscache_want_stage want_stage);
+
 /*
  * key.c
  */
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
new file mode 100644
index 000000000000..3839d0905a92
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
+				enum fscache_want_stage want_stage)
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
+	if (!cachefiles_cres_file(cres) && want_stage != FSCACHE_WANT_PARAMS) {
+		pr_err("failed to get cres->file\n");
+		return false;
+	}
+
+	return true;
+}
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 3ebb874b5f0f..86bf79bd3df8 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -77,6 +77,7 @@ enum fscache_access_trace {
 	fscache_access_cache_unpin,
 	fscache_access_invalidate_cookie,
 	fscache_access_invalidate_cookie_end,
+	fscache_access_io_end,
 	fscache_access_io_not_live,
 	fscache_access_io_read,
 	fscache_access_io_resize,
@@ -149,6 +150,7 @@ enum fscache_access_trace {
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
 	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
 	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
+	EM(fscache_access_io_end,		"END   io     ")	\
 	EM(fscache_access_io_not_live,		"END   io_notl")	\
 	EM(fscache_access_io_read,		"BEGIN io_read")	\
 	EM(fscache_access_io_resize,		"BEGIN io_resz")	\


