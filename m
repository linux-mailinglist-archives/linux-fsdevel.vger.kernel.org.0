Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D182C346C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhCWWXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234134AbhCWWU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616538026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOFBnZTk3/q40avq3uXyok1s3yy1V3pG4ds6pqa9afw=;
        b=G0BHCf3QzJ+k/YMnUBAbaLM1z2ul3+EC3H+YzrqkrYu/1+qxncivBOIThCcMayM+vDZFu/
        e/c1VAOI3gmaSq+6/8eUvEJ2aCh7hLm5yPjxwpzE4ptrp2t09d0s+nmTK/+8MG8LOIgB5F
        8pbRKu9JErcxV3Vx26bRnVuZXJolFmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-hLRyAX43OrSqXaRQgo66CA-1; Tue, 23 Mar 2021 18:20:24 -0400
X-MC-Unique: hLRyAX43OrSqXaRQgo66CA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEC2E87A826;
        Tue, 23 Mar 2021 22:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB6E10023B5;
        Tue, 23 Mar 2021 22:20:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 14/28] fscache,
 cachefiles: Add alternate API to use kiocb for read/write to cache
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:20:14 +0000
Message-ID: <161653801477.2770958.10543270629064934227.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an alternate API by which the cache can be accessed through a kiocb,
doing async DIO, rather than using the current API that tells the cache
where all the pages are.

The new API is intended to be used in conjunction with the netfs helper
library.  A filesystem must pick one or the other and not mix them.

Filesystems wanting to use the new API must #define FSCACHE_USE_NEW_IO_API
before #including the header.  This prevents them from continuing to use
the old API at the same time as there are incompatibilities in how the
PG_fscache page bit is used.

Changes:
 - Use the vfs_iocb_iter_read/write() helpers[1]
 - Move initial definition of fscache_begin_read_operation() here.
 - Remove a commented-out line[2]
 - Combine ki->term_func calls in cachefiles_read_complete()[2].
 - Remove explicit NULL initialiser[2].
 - Remove extern on func decl[2].
 - Put in param names on func decl[2].
 - Remove redundant else[2].
 - Fill out the kdoc comment for fscache_begin_read_operation().
 - Rename fs/fscache/page2.c to io.c to match later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20210216102614.GA27555@lst.de/ [1]
Link: https://lore.kernel.org/r/20210216084230.GA23669@lst.de/ [2]
Link: https://lore.kernel.org/r/161118142558.1232039.17993829899588971439.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161037850.2537118.8819808229350326503.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340402057.1303470.8038373593844486698.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539545919.286939.14573472672781434757.stgit@warthog.procyon.org.uk/ # v4
---

 fs/cachefiles/Makefile        |    1 
 fs/cachefiles/interface.c     |    5 -
 fs/cachefiles/internal.h      |    9 +
 fs/cachefiles/io.c            |  403 +++++++++++++++++++++++++++++++++++++++++
 fs/fscache/Kconfig            |    1 
 fs/fscache/Makefile           |    1 
 fs/fscache/internal.h         |    4 
 fs/fscache/io.c               |  116 ++++++++++++
 fs/fscache/page.c             |    2 
 fs/fscache/stats.c            |    1 
 include/linux/fscache-cache.h |    4 
 include/linux/fscache.h       |   39 ++++
 12 files changed, 583 insertions(+), 3 deletions(-)
 create mode 100644 fs/cachefiles/io.c
 create mode 100644 fs/fscache/io.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 891dedda5905..2227dc2d5498 100644
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
index 5efa6a3702c0..da3948fdb615 100644
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
index cf9bd6401c2d..4ed83aa5253b 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -150,6 +150,9 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
 
+void cachefiles_put_object(struct fscache_object *_object,
+			   enum fscache_obj_ref_trace why);
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
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
new file mode 100644
index 000000000000..620959d1e95b
--- /dev/null
+++ b/fs/cachefiles/io.c
@@ -0,0 +1,403 @@
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
+	bool			was_async;
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
+		if (ret >= 0)
+			ret += ki->skipped;
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
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
+	ki->was_async		= true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	get_file(ki->iocb.ki_filp);
+
+	old_nofs = memalloc_nofs_save();
+	ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
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
+		ki->was_async = false;
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
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, ret < 0 ? ret : skipped, false);
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
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
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
+	ki->was_async		= true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_write_complete;
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
+	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
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
+		ki->was_async = false;
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
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, -ENOMEM, false);
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
+	loff_t off, to;
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
+		off = round_up(off, cache->bsize);
+		subreq->len = off - subreq->start;
+		goto download_and_store;
+	}
+
+	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+	if (to < 0 && to >= (loff_t)-MAX_ERRNO)
+		goto cache_fail;
+
+	if (to < subreq->start + subreq->len) {
+		if (subreq->start + subreq->len >= i_size)
+			to = round_up(to, cache->bsize);
+		else
+			to = round_down(to, cache->bsize);
+		subreq->len = to - subreq->start;
+	}
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
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 5e796e6c38e5..427efa73b9bd 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -2,6 +2,7 @@
 
 config FSCACHE
 	tristate "General filesystem local caching manager"
+	select NETFS_SUPPORT
 	help
 	  This option enables a generic filesystem caching manager that can be
 	  used by various network and other filesystems to cache data locally.
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 79e08e05ef84..3b2ffa93ac18 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -7,6 +7,7 @@ fscache-y := \
 	cache.o \
 	cookie.o \
 	fsdef.o \
+	io.o \
 	main.o \
 	netfs.o \
 	object.o \
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 08e91efbce53..c483863b740a 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -142,6 +142,10 @@ extern int fscache_wait_for_operation_activation(struct fscache_object *,
 						 atomic_t *,
 						 atomic_t *);
 extern void fscache_invalidate_writes(struct fscache_cookie *);
+struct fscache_retrieval *fscache_alloc_retrieval(struct fscache_cookie *cookie,
+						  struct address_space *mapping,
+						  fscache_rw_complete_t end_io_func,
+						  void *context);
 
 /*
  * proc.c
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
new file mode 100644
index 000000000000..8ecc1141802f
--- /dev/null
+++ b/fs/fscache/io.c
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
+#define FSCACHE_USE_NEW_IO_API
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
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3f0b19dcfae7..3235ddbdcc09 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -304,6 +304,10 @@ struct fscache_cache_ops {
 
 	/* dissociate a cache from all the pages it was backing */
 	void (*dissociate_pages)(struct fscache_cache *cache);
+
+	/* Begin a read operation for the netfs lib */
+	int (*begin_read_operation)(struct netfs_read_request *rreq,
+				    struct fscache_retrieval *op);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 1f8dc72369ee..abc1c4737fb8 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -37,6 +37,7 @@ struct pagevec;
 struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
+struct netfs_read_request;
 
 typedef void (*fscache_rw_complete_t)(struct page *page,
 				      void *context,
@@ -191,6 +192,10 @@ extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
 extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
+
+#ifdef FSCACHE_USE_NEW_IO_API
+extern int __fscache_begin_read_operation(struct netfs_read_request *, struct fscache_cookie *);
+#else
 extern int __fscache_read_or_alloc_page(struct fscache_cookie *,
 					struct page *,
 					fscache_rw_complete_t,
@@ -214,6 +219,8 @@ extern void __fscache_uncache_all_inode_pages(struct fscache_cookie *,
 					      struct inode *);
 extern void __fscache_readpages_cancel(struct fscache_cookie *cookie,
 				       struct list_head *pages);
+#endif /* FSCACHE_USE_NEW_IO_API */
+
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
 				    bool (*)(void *), void *);
@@ -498,6 +505,36 @@ int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size)
 	return -ENOBUFS;
 }
 
+#ifdef FSCACHE_USE_NEW_IO_API
+
+/**
+ * fscache_begin_read_operation - Begin a read operation for the netfs lib
+ * @rreq: The read request being undertaken
+ * @cookie: The cookie representing the cache object
+ *
+ * Begin a read operation on behalf of the netfs helper library.  @rreq
+ * indicates the read request to which the operation state should be attached;
+ * @cookie indicates the cache object that will be accessed.
+ *
+ * This is intended to be called from the ->begin_cache_operation() netfs lib
+ * operation as implemented by the network filesystem.
+ *
+ * Returns:
+ * * 0		- Success
+ * * -ENOBUFS	- No caching available
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_begin_read_operation(struct netfs_read_request *rreq,
+				 struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_begin_read_operation(rreq, cookie);
+	return -ENOBUFS;
+}
+
+#else /* FSCACHE_USE_NEW_IO_API */
+
 /**
  * fscache_read_or_alloc_page - Read a page from the cache or allocate a block
  * in which to store it
@@ -777,6 +814,8 @@ void fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
 		__fscache_uncache_all_inode_pages(cookie, inode);
 }
 
+#endif /* FSCACHE_USE_NEW_IO_API */
+
 /**
  * fscache_disable_cookie - Disable a cookie
  * @cookie: The cookie representing the cache object


