Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28A02FDF59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 03:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbhATXvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 18:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732221AbhATWZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611181436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8idhIeicuUFPSEjGNuxicJoJQU8BMB9g7oq90/gOCc=;
        b=Q2H/01gu1s7RL/oRQHVwQOp3cEwrGByTAvFkQw/zMELfKFN62F8YWsB0kRiTNOPYejOqe3
        RRXkrqhr3paKghD3z4W02dGHqRplx0OZLIOtq0rGwtbWkkWQJFXiEdFb0V5TqG3FyJmmkM
        LE4k6HqBoqj7zq5B7B8OcaTwoDKVjkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-lwfEx6r3N5iTJxuy8z6Q-w-1; Wed, 20 Jan 2021 17:23:54 -0500
X-MC-Unique: lwfEx6r3N5iTJxuy8z6Q-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C47B59;
        Wed, 20 Jan 2021 22:23:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 587C45D9C2;
        Wed, 20 Jan 2021 22:23:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/25] fscache,
 cachefiles: Add alternate API to use kiocb for read/write to cache
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jan 2021 22:23:45 +0000
Message-ID: <161118142558.1232039.17993829899588971439.stgit@warthog.procyon.org.uk>
In-Reply-To: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
References: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an alternate API by which the cache can be accessed through a kiocb,
doing async DIO, rather than using the current API that tells the cache
where all the pages are.

The new API is intended to be used in conjunction with the netfs helper
library.  A filesystem must pick one or the other and not mix them.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Makefile    |    1 
 fs/cachefiles/interface.c |    5 -
 fs/cachefiles/internal.h  |    9 +
 fs/cachefiles/rdwr2.c     |  406 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fscache/Makefile       |    3 
 fs/fscache/internal.h     |    3 
 fs/fscache/page.c         |    2 
 fs/fscache/page2.c        |  116 +++++++++++++
 fs/fscache/stats.c        |    1 
 9 files changed, 542 insertions(+), 4 deletions(-)
 create mode 100644 fs/cachefiles/rdwr2.c
 create mode 100644 fs/fscache/page2.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 891dedda5905..ea17b169ea5e 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -11,6 +11,7 @@ cachefiles-y := \
 	main.o \
 	namei.o \
 	rdwr.o \
+	rdwr2.o \
 	security.o \
 	xattr.o
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4cea5fbf695e..eaede2585d07 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -319,8 +319,8 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 /*
  * dispose of a reference to an object
  */
-static void cachefiles_put_object(struct fscache_object *_object,
-				  enum fscache_obj_ref_trace why)
+void cachefiles_put_object(struct fscache_object *_object,
+			   enum fscache_obj_ref_trace why)
 {
 	struct cachefiles_object *object;
 	struct fscache_cache *cache;
@@ -568,4 +568,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.uncache_page		= cachefiles_uncache_page,
 	.dissociate_pages	= cachefiles_dissociate_pages,
 	.check_consistency	= cachefiles_check_consistency,
+	.begin_read_operation	= cachefiles_begin_read_operation,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index cf9bd6401c2d..896819b80bbc 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -150,6 +150,9 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
 
+extern void cachefiles_put_object(struct fscache_object *_object,
+				  enum fscache_obj_ref_trace why);
+
 /*
  * key.c
  */
@@ -217,6 +220,12 @@ extern int cachefiles_allocate_pages(struct fscache_retrieval *,
 extern int cachefiles_write_page(struct fscache_storage *, struct page *);
 extern void cachefiles_uncache_page(struct fscache_object *, struct page *);
 
+/*
+ * rdwr2.c
+ */
+extern int cachefiles_begin_read_operation(struct netfs_read_request *,
+					   struct fscache_retrieval *);
+
 /*
  * security.c
  */
diff --git a/fs/cachefiles/rdwr2.c b/fs/cachefiles/rdwr2.c
new file mode 100644
index 000000000000..841dfabf00ea
--- /dev/null
+++ b/fs/cachefiles/rdwr2.c
@@ -0,0 +1,406 @@
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
+#include <linux/sched/mm.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+struct cachefiles_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+	loff_t			start;
+	union {
+		size_t		skipped;
+		size_t		len;
+	};
+	netfs_io_terminated_t	term_func;
+	void			*term_func_priv;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
+/*
+ * Handle completion of a read from the cache.
+ */
+static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+
+	_enter("%ld,%ld", ret, ret2);
+
+	if (ki->term_func) {
+		if (ret < 0)
+			ki->term_func(ki->term_func_priv, ret);
+		else
+			ki->term_func(ki->term_func_priv, ki->skipped + ret);
+	}
+
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Initiate a read from the cache.
+ */
+static int cachefiles_read(struct netfs_cache_resources *cres,
+			   loff_t start_pos,
+			   struct iov_iter *iter,
+			   bool seek_data,
+			   netfs_io_terminated_t term_func,
+			   void *term_func_priv)
+{
+	struct cachefiles_kiocb *ki;
+	struct file *file = cres->cache_priv2;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter), skipped = 0;
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file->f_inode));
+
+	/* If the caller asked us to seek for data before doing the read, then
+	 * we should do that now.  If we find a gap, we fill it with zeros.
+	 */
+	if (seek_data) {
+		loff_t off = start_pos, off2;
+
+		off2 = vfs_llseek(file, off, SEEK_DATA);
+		if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO && off2 != -ENXIO) {
+			skipped = 0;
+			ret = off2;
+			goto presubmission_error;
+		}
+
+		if (off2 == -ENXIO || off2 >= start_pos + len) {
+			/* The region is beyond the EOF or there's no more data
+			 * in the region, so clear the rest of the buffer and
+			 * return success.
+			 */
+			iov_iter_zero(len, iter);
+			skipped = len;
+			ret = 0;
+			goto presubmission_error;
+		}
+
+		skipped = off2 - off;
+		iov_iter_zero(skipped, iter);
+	}
+
+	ret = -ENOBUFS;
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= start_pos + skipped;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->skipped		= skipped;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	ret = rw_verify_area(READ, file, &ki->iocb.ki_pos, len - skipped);
+	if (ret < 0)
+		goto presubmission_error_free;
+
+	get_file(ki->iocb.ki_filp);
+
+	old_nofs = memalloc_nofs_save();
+	ret = call_read_iter(file, &ki->iocb, iter);
+	memalloc_nofs_restore(old_nofs);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		fallthrough;
+	default:
+		cachefiles_read_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error_free:
+	kfree(ki);
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, ret < 0 ? ret : skipped);
+	return ret;
+}
+
+/*
+ * Handle completion of a write to the cache.
+ */
+static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld,%ld", ret, ret2);
+
+	/* Tell lockdep we inherited freeze protection from submission thread */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+
+	if (ki->term_func)
+		ki->term_func(ki->term_func_priv, ret);
+
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Initiate a write to the cache.
+ */
+static int cachefiles_write(struct netfs_cache_resources *cres,
+			    loff_t start_pos,
+			    struct iov_iter *iter,
+			    netfs_io_terminated_t term_func,
+			    void *term_func_priv)
+{
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file = cres->cache_priv2;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file->f_inode));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= start_pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->start		= start_pos;
+	ki->len			= len;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_write_complete;
+
+	ret = rw_verify_area(WRITE, file, &ki->iocb.ki_pos, iov_iter_count(iter));
+	if (ret < 0)
+		goto presubmission_error_free;
+
+	/* Open-code file_start_write here to grab freeze protection, which
+	 * will be released by another thread in aio_complete_rw().  Fool
+	 * lockdep by telling it the lock got released so that it doesn't
+	 * complain about the held lock when we return to userspace.
+	 */
+	inode = file_inode(file);
+	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+
+	get_file(ki->iocb.ki_filp);
+
+	old_nofs = memalloc_nofs_save();
+	ret = call_write_iter(file, &ki->iocb, iter);
+	memalloc_nofs_restore(old_nofs);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		/* Fall through */
+	default:
+		cachefiles_write_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error_free:
+	kfree(ki);
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, -ENOMEM);
+	return -ENOMEM;
+}
+
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+						      loff_t i_size)
+{
+	struct fscache_retrieval *op = subreq->rreq->cache_resources.cache_priv;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	struct file *file = subreq->rreq->cache_resources.cache_priv2;
+	loff_t off;
+
+	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
+
+	object = container_of(op->op.object,
+			      struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	if (!file)
+		goto cache_fail_nosec;
+
+	if (subreq->start >= i_size)
+		return NETFS_FILL_WITH_ZEROES;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	off = vfs_llseek(file, subreq->start, SEEK_DATA);
+	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
+		if (off == (loff_t)-ENXIO)
+			goto download_and_store;
+		goto cache_fail;
+	}
+
+	if (off >= subreq->start + subreq->len)
+		goto download_and_store;
+
+	if (off > subreq->start) {
+		subreq->len = off - subreq->start;
+		goto download_and_store;
+	}
+
+	off = vfs_llseek(file, subreq->start, SEEK_HOLE);
+	if (off < 0 && off >= (loff_t)-MAX_ERRNO)
+		goto cache_fail;
+
+	if (off < subreq->start + subreq->len)
+		subreq->len = off - subreq->start;
+
+	cachefiles_end_secure(cache, saved_cred);
+	return NETFS_READ_FROM_CACHE;
+
+download_and_store:
+	if (cachefiles_has_space(cache, 0, (subreq->len + PAGE_SIZE - 1) / PAGE_SIZE) == 0)
+		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+cache_fail:
+	cachefiles_end_secure(cache, saved_cred);
+cache_fail_nosec:
+	return NETFS_DOWNLOAD_FROM_SERVER;
+}
+
+/*
+ * Clean up an operation.
+ */
+static void cachefiles_end_operation(struct netfs_cache_resources *cres)
+{
+	struct fscache_retrieval *op = cres->cache_priv;
+	struct file *file = cres->cache_priv2;
+
+	_enter("");
+
+	if (file)
+		fput(file);
+	if (op) {
+		fscache_op_complete(&op->op, false);
+		fscache_put_retrieval(op);
+	}
+
+	_leave("");
+}
+
+static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
+	.end_operation		= cachefiles_end_operation,
+	.read			= cachefiles_read,
+	.write			= cachefiles_write,
+	.expand_readahead	= NULL,
+	.prepare_read		= cachefiles_prepare_read,
+};
+
+/*
+ * Open the cache file when beginning a cache operation.
+ */
+int cachefiles_begin_read_operation(struct netfs_read_request *rreq,
+				    struct fscache_retrieval *op)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct path path;
+	struct file *file;
+
+	_enter("");
+
+	object = container_of(op->op.object,
+			      struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	path.mnt = cache->mnt;
+	path.dentry = object->backer;
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_inode(object->backer), cache->cache_cred);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	if (!S_ISREG(file_inode(file)->i_mode))
+		goto error_file;
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		goto error_file;
+	}
+
+	fscache_get_retrieval(op);
+	rreq->cache_resources.cache_priv = op;
+	rreq->cache_resources.cache_priv2 = file;
+	rreq->cache_resources.ops = &cachefiles_netfs_cache_ops;
+	rreq->cookie_debug_id = object->fscache.debug_id;
+	_leave("");
+	return 0;
+
+error_file:
+	fput(file);
+	return -EIO;
+}
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 79e08e05ef84..38f28fec2aa3 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -11,7 +11,8 @@ fscache-y := \
 	netfs.o \
 	object.o \
 	operation.o \
-	page.o
+	page.o \
+	page2.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 08e91efbce53..c42672cadf2d 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -142,6 +142,9 @@ extern int fscache_wait_for_operation_activation(struct fscache_object *,
 						 atomic_t *,
 						 atomic_t *);
 extern void fscache_invalidate_writes(struct fscache_cookie *);
+extern struct fscache_retrieval *fscache_alloc_retrieval(struct fscache_cookie *,
+							 struct address_space *,
+							 fscache_rw_complete_t, void *);
 
 /*
  * proc.c
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 26af6fdf1538..991b0a871744 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -299,7 +299,7 @@ static void fscache_release_retrieval_op(struct fscache_operation *_op)
 /*
  * allocate a retrieval op
  */
-static struct fscache_retrieval *fscache_alloc_retrieval(
+struct fscache_retrieval *fscache_alloc_retrieval(
 	struct fscache_cookie *cookie,
 	struct address_space *mapping,
 	fscache_rw_complete_t end_io_func,
diff --git a/fs/fscache/page2.c b/fs/fscache/page2.c
new file mode 100644
index 000000000000..e3bc7178d99f
--- /dev/null
+++ b/fs/fscache/page2.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache data I/O routines
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL PAGE
+#include <linux/module.h>
+#include <linux/fscache-cache.h>
+#include <linux/slab.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+/*
+ * Start a cache read operation.
+ * - we return:
+ *   -ENOMEM	- out of memory, some pages may be being read
+ *   -ERESTARTSYS - interrupted, some pages may be being read
+ *   -ENOBUFS	- no backing object or space available in which to cache any
+ *                pages not being read
+ *   -ENODATA	- no data available in the backing object for some or all of
+ *                the pages
+ *   0		- dispatched a read on all pages
+ */
+int __fscache_begin_read_operation(struct netfs_read_request *rreq,
+				   struct fscache_cookie *cookie)
+{
+	struct fscache_retrieval *op;
+	struct fscache_object *object;
+	bool wake_cookie = false;
+	int ret;
+
+	_enter("rr=%08x", rreq->debug_id);
+
+	fscache_stat(&fscache_n_retrievals);
+
+	if (hlist_empty(&cookie->backing_objects))
+		goto nobufs;
+
+	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
+		_leave(" = -ENOBUFS [invalidating]");
+		return -ENOBUFS;
+	}
+
+	ASSERTCMP(cookie->def->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
+
+	if (fscache_wait_for_deferred_lookup(cookie) < 0)
+		return -ERESTARTSYS;
+
+	op = fscache_alloc_retrieval(cookie, NULL, NULL, NULL);
+	if (!op)
+		return -ENOMEM;
+	//atomic_set(&op->n_pages, 1);
+	trace_fscache_page_op(cookie, NULL, &op->op, fscache_page_op_retr_multi);
+
+	spin_lock(&cookie->lock);
+
+	if (!fscache_cookie_enabled(cookie) ||
+	    hlist_empty(&cookie->backing_objects))
+		goto nobufs_unlock;
+	object = hlist_entry(cookie->backing_objects.first,
+			     struct fscache_object, cookie_link);
+
+	__fscache_use_cookie(cookie);
+	atomic_inc(&object->n_reads);
+	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->op.flags);
+
+	if (fscache_submit_op(object, &op->op) < 0)
+		goto nobufs_unlock_dec;
+	spin_unlock(&cookie->lock);
+
+	fscache_stat(&fscache_n_retrieval_ops);
+
+	/* we wait for the operation to become active, and then process it
+	 * *here*, in this thread, and not in the thread pool */
+	ret = fscache_wait_for_operation_activation(
+		object, &op->op,
+		__fscache_stat(&fscache_n_retrieval_op_waits),
+		__fscache_stat(&fscache_n_retrievals_object_dead));
+	if (ret < 0)
+		goto error;
+
+	/* ask the cache to honour the operation */
+	ret = object->cache->ops->begin_read_operation(rreq, op);
+
+error:
+	if (ret == -ENOMEM)
+		fscache_stat(&fscache_n_retrievals_nomem);
+	else if (ret == -ERESTARTSYS)
+		fscache_stat(&fscache_n_retrievals_intr);
+	else if (ret == -ENODATA)
+		fscache_stat(&fscache_n_retrievals_nodata);
+	else if (ret < 0)
+		fscache_stat(&fscache_n_retrievals_nobufs);
+	else
+		fscache_stat(&fscache_n_retrievals_ok);
+
+	fscache_put_retrieval(op);
+	_leave(" = %d", ret);
+	return ret;
+
+nobufs_unlock_dec:
+	atomic_dec(&object->n_reads);
+	wake_cookie = __fscache_unuse_cookie(cookie);
+nobufs_unlock:
+	spin_unlock(&cookie->lock);
+	fscache_put_retrieval(op);
+	if (wake_cookie)
+		__fscache_wake_unused_cookie(cookie);
+nobufs:
+	fscache_stat(&fscache_n_retrievals_nobufs);
+	_leave(" = -ENOBUFS");
+	return -ENOBUFS;
+}
+EXPORT_SYMBOL(__fscache_begin_read_operation);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index a5aa93ece8c5..a7c3ed89a3e0 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -278,5 +278,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cache_stale_objects),
 		   atomic_read(&fscache_n_cache_retired_objects),
 		   atomic_read(&fscache_n_cache_culled_objects));
+	netfs_stats_show(m);
 	return 0;
 }


