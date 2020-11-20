Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA52BADE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKTPLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgKTPLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/+8PT6hvdzsqumpIcFkRs+u8vk9juQnIN7YFLeVybY=;
        b=PY1vuHzLgNAANIBJEKWHZXMwo/Wq1cV8qPi2yEJehaakS4lWTJcLKKU/QI97XkTjKym+B0
        UAjV8eo3+aPb5U/1vjcZhLJ2HA+QuyvXOqbB+mEPtnhR244iQDKVZtUPYZSz7wDhU2jz8J
        qOPEm5rJEhsNVVJt7JxleK2uH26RPmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-WU-p8fn4Pnq8RhluvRhokw-1; Fri, 20 Nov 2020 10:11:12 -0500
X-MC-Unique: WU-p8fn4Pnq8RhluvRhokw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B640801B1A;
        Fri, 20 Nov 2020 15:11:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C34110021B3;
        Fri, 20 Nov 2020 15:11:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 39/76] cachefiles: Implement new fscache I/O backend API
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
Date:   Fri, 20 Nov 2020 15:11:02 +0000
Message-ID: <160588506244.3465195.14835834211702469652.stgit@warthog.procyon.org.uk>
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

Implement the new fscache I/O backend API in cachefiles.  The
cachefiles_object struct carries a non-accounted file to the cachefiles
object (so that it doesn't cause ENFILE).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Makefile    |    1 +
 fs/cachefiles/interface.c |   13 +++++++
 fs/cachefiles/internal.h  |   19 ++++++++++
 fs/cachefiles/io.c        |   85 +++++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/namei.c     |    3 ++
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/io.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 3455d3646547..d894d317d6e7 100644
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
index 3f6d2be690bc..dc8c875223bb 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -453,6 +453,18 @@ static unsigned int cachefiles_get_object_usage(const struct fscache_object *_ob
 	return atomic_read(&object->usage);
 }
 
+static const struct fscache_op_ops cachefiles_io_ops = {
+	.wait_for_operation	= __fscache_wait_for_operation,
+	.end_operation		= __fscache_end_operation,
+	.read			= cachefiles_read,
+	.write			= cachefiles_write,
+};
+
+static void cachefiles_begin_operation(struct fscache_op_resources *opr)
+{
+	opr->ops = &cachefiles_io_ops;
+}
+
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
 	.alloc_object		= cachefiles_alloc_object,
@@ -466,4 +478,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.put_object		= cachefiles_put_object,
 	.get_object_usage	= cachefiles_get_object_usage,
 	.sync_cache		= cachefiles_sync_cache,
+	.begin_operation	= cachefiles_begin_operation,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 16d15291a629..caa6dfbaf333 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -115,6 +115,22 @@ extern const struct fscache_cache_ops cachefiles_cache_ops;
 extern struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 						     enum fscache_obj_ref_trace why);
 
+/*
+ * io.c
+ */
+extern int cachefiles_read(struct fscache_op_resources *opr,
+			   loff_t start_pos,
+			   struct iov_iter *iter,
+			   bool seek_data,
+			   fscache_io_terminated_t term_func,
+			   void *term_func_priv);
+extern int cachefiles_write(struct fscache_op_resources *opr,
+			    loff_t start_pos,
+			    struct iov_iter *iter,
+			    fscache_io_terminated_t term_func,
+			    void *term_func_priv);
+extern bool cachefiles_open_object(struct cachefiles_object *obj);
+
 /*
  * key.c
  */
@@ -216,7 +232,8 @@ do {									\
 									\
 	___cache = container_of((object)->fscache.cache,		\
 				struct cachefiles_cache, cache);	\
-	cachefiles_io_error(___cache, FMT, ##__VA_ARGS__);		\
+	cachefiles_io_error(___cache, FMT " [o=%08x]", ##__VA_ARGS__,	\
+			    object->fscache.debug_id);			\
 } while (0)
 
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
new file mode 100644
index 000000000000..f1d5976aa28c
--- /dev/null
+++ b/fs/cachefiles/io.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Data I/O routines
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/xattr.h>
+#include "internal.h"
+#include <trace/events/fscache.h>
+
+/*
+ * Initiate a read from the cache.
+ */
+int cachefiles_read(struct fscache_op_resources *opr,
+		    loff_t start_pos,
+		    struct iov_iter *iter,
+		    bool seek_data,
+		    fscache_io_terminated_t term_func,
+		    void *term_func_priv)
+{
+	fscache_wait_for_operation(opr, FSCACHE_WANT_READ);
+	fscache_count_io_operation(opr->object->cookie);
+	if (term_func)
+		term_func(term_func_priv, -ENODATA);
+	return -ENODATA;
+}
+
+/*
+ * Initiate a write to the cache.
+ */
+int cachefiles_write(struct fscache_op_resources *opr,
+		     loff_t start_pos,
+		     struct iov_iter *iter,
+		     fscache_io_terminated_t term_func,
+		     void *term_func_priv)
+{
+	fscache_wait_for_operation(opr, FSCACHE_WANT_WRITE);
+	fscache_count_io_operation(opr->object->cookie);
+	if (term_func)
+		term_func(term_func_priv, -ENOBUFS);
+	return -ENOBUFS;
+}
+
+/*
+ * Open a cache object.
+ */
+bool cachefiles_open_object(struct cachefiles_object *object)
+{
+	struct cachefiles_cache *cache =
+		container_of(object->fscache.cache, struct cachefiles_cache, cache);
+	struct file *file;
+	struct path path;
+
+	path.mnt = cache->mnt;
+	path.dentry = object->backer;
+
+	file = open_with_fake_path(&path,
+				   O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(object->backer),
+				   cache->cache_cred);
+	if (IS_ERR(file))
+		goto error;
+
+	if (!S_ISREG(file_inode(file)->i_mode))
+		goto error_file;
+
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		goto error_file;
+	}
+
+	object->backing_file = file;
+	return true;
+
+error_file:
+	fput(file);
+error:
+	return false;
+}
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 0a7e2031efa2..4b515054d92e 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -490,6 +490,9 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 		} else {
 			BUG(); // TODO: open file in data-class subdir
 		}
+
+		if (!cachefiles_open_object(object))
+			goto check_error;
 	}
 
 	if (object->new)


