Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14B046199F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378775AbhK2OkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378782AbhK2OiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anBrQdqUxp/0RD+8EpRov+VqGaK/KF83ThVTJNrKfa0=;
        b=JuDuIVtRWt92Ifc3uZVq3TI30dCwz20VC4dFyybsigQ//QW5WTBPDGgRuEtJ3jEKhWxPpm
        9uR89PTRJvI3LhiftFuZnu3Q7VRoL/bsiXMIPQAVVQsqh8ttf9vV+3zsiprOUELT7Bl8F4
        Is1qwx9Y4TIUdDUVTSjQC/RSJ7+o+Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-UDoYyVXNOg-2dDHEKrrW5w-1; Mon, 29 Nov 2021 09:34:52 -0500
X-MC-Unique: UDoYyVXNOg-2dDHEKrrW5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A1018C9F44;
        Mon, 29 Nov 2021 14:34:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B311010426;
        Mon, 29 Nov 2021 14:34:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 51/64] cachefiles: Implement the I/O routines
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
Date:   Mon, 29 Nov 2021 14:34:39 +0000
Message-ID: <163819647945.215744.17827962047487125939.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the I/O routines for cachefiles.  There are two sets of routines
here: preparation and actual I/O.

Preparation for read involves looking to see whether there is data present,
and how much.  Netfslib tells us what it wants us to do and we have the
option of adjusting shrinking and telling it whether to read from the
cache, download from the server or simply clear a region.

Preparation for write involves checking for space and defending against
possibly running short of space, if necessary punching out a hole in the
file so that we don't leave old data in the cache if we update the
coherency information.

Then there's a read routine and a write routine.  They wait for the cookie
state to move to something appropriate and then start a potentially
asynchronous direct I/O operation upon it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/io.c                |  514 +++++++++++++++++++++++++++++++++++++
 include/trace/events/cachefiles.h |  121 +++++++++
 2 files changed, 635 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index adeb9a42fd7b..d284984da1fa 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -14,6 +14,516 @@
 #include <trace/events/fscache.h>
 #include "internal.h"
 
+struct cachefiles_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+	loff_t			start;
+	union {
+		size_t		skipped;
+		size_t		len;
+	};
+	struct cachefiles_object *object;
+	netfs_io_terminated_t	term_func;
+	void			*term_func_priv;
+	bool			was_async;
+	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
+	u64			b_writing;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		cachefiles_put_object(ki->object, cachefiles_obj_put_ioreq);
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
+/*
+ * Handle completion of a read from the cache.
+ */
+static void cachefiles_read_complete(struct kiocb *iocb, long ret)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld", ret);
+
+	if (ret < 0)
+		trace_cachefiles_io_error(ki->object, inode, ret,
+					  cachefiles_trace_read_error);
+
+	if (ki->term_func) {
+		if (ret >= 0) {
+			if (ki->object->cookie->inval_counter == ki->inval_counter)
+				ki->skipped += ret;
+			else
+				ret = -ESTALE;
+		}
+
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
+			   enum netfs_read_from_hole read_hole,
+			   netfs_io_terminated_t term_func,
+			   void *term_func_priv)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_kiocb *ki;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter), skipped = 0;
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		goto presubmission_error;
+
+	fscache_count_read();
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file_inode(file)));
+
+	/* If the caller asked us to seek for data before doing the read, then
+	 * we should do that now.  If we find a gap, we fill it with zeros.
+	 */
+	if (read_hole != NETFS_READ_HOLE_IGNORE) {
+		loff_t off = start_pos, off2;
+
+		off2 = cachefiles_inject_read_error();
+		if (off2 == 0)
+			off2 = vfs_llseek(file, off, SEEK_DATA);
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
+			ret = -ENODATA;
+			if (read_hole == NETFS_READ_HOLE_FAIL)
+				goto presubmission_error;
+
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
+	ret = -ENOMEM;
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
+	ki->object		= object;
+	ki->inval_counter	= cres->inval_counter;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+	ki->was_async		= true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	get_file(ki->iocb.ki_filp);
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
+
+	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, len - skipped);
+	old_nofs = memalloc_nofs_save();
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
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
+		cachefiles_read_complete(&ki->iocb, ret);
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
+static void cachefiles_write_complete(struct kiocb *iocb, long ret)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct cachefiles_object *object = ki->object;
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld", ret);
+
+	/* Tell lockdep we inherited freeze protection from submission thread */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+
+	if (ret < 0)
+		trace_cachefiles_io_error(object, inode, ret,
+					  cachefiles_trace_write_error);
+
+	atomic_long_sub(ki->b_writing, &object->volume->cache->b_writing);
+	set_bit(FSCACHE_COOKIE_HAVE_DATA, &object->cookie->flags);
+	if (ki->term_func)
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
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
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter);
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+		goto presubmission_error;
+	fscache_count_write();
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+	file = cachefiles_cres_file(cres);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file_inode(file)));
+
+	ret = -ENOMEM;
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
+	ki->object		= object;
+	ki->inval_counter	= cres->inval_counter;
+	ki->start		= start_pos;
+	ki->len			= len;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+	ki->was_async		= true;
+	ki->b_writing		= (len + (1 << cache->bshift)) >> cache->bshift;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_write_complete;
+	atomic_long_add(ki->b_writing, &cache->b_writing);
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
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
+
+	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
+	old_nofs = memalloc_nofs_save();
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
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
+		cachefiles_write_complete(&ki->iocb, ret);
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
+		term_func(term_func_priv, ret, false);
+	return ret;
+}
+
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+						      loff_t i_size)
+{
+	enum cachefiles_prepare_read_trace why;
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
+	const struct cred *saved_cred;
+	struct file *file = cachefiles_cres_file(cres);
+	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
+	loff_t off, to;
+	ino_t ino = file ? file_inode(file)->i_ino : 0;
+
+	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
+
+	if (subreq->start >= i_size) {
+		ret = NETFS_FILL_WITH_ZEROES;
+		why = cachefiles_trace_read_after_eof;
+		goto out_no_object;
+	}
+
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
+		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+		why = cachefiles_trace_read_no_data;
+		goto out_no_object;
+	}
+
+	/* The object and the file may be being created in the background. */
+	if (!file) {
+		why = cachefiles_trace_read_no_file;
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+			goto out_no_object;
+		file = cachefiles_cres_file(cres);
+		if (!file)
+			goto out_no_object;
+		ino = file_inode(file)->i_ino;
+	}
+
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	off = cachefiles_inject_read_error();
+	if (off == 0)
+		off = vfs_llseek(file, subreq->start, SEEK_DATA);
+	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
+		if (off == (loff_t)-ENXIO) {
+			why = cachefiles_trace_read_seek_nxio;
+			goto download_and_store;
+		}
+		trace_cachefiles_io_error(object, file_inode(file), off,
+					  cachefiles_trace_seek_error);
+		why = cachefiles_trace_read_seek_error;
+		goto out;
+	}
+
+	if (off >= subreq->start + subreq->len) {
+		why = cachefiles_trace_read_found_hole;
+		goto download_and_store;
+	}
+
+	if (off > subreq->start) {
+		off = round_up(off, cache->bsize);
+		subreq->len = off - subreq->start;
+		why = cachefiles_trace_read_found_part;
+		goto download_and_store;
+	}
+
+	to = cachefiles_inject_read_error();
+	if (to == 0)
+		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
+		trace_cachefiles_io_error(object, file_inode(file), to,
+					  cachefiles_trace_seek_error);
+		why = cachefiles_trace_read_seek_error;
+		goto out;
+	}
+
+	if (to < subreq->start + subreq->len) {
+		if (subreq->start + subreq->len >= i_size)
+			to = round_up(to, cache->bsize);
+		else
+			to = round_down(to, cache->bsize);
+		subreq->len = to - subreq->start;
+	}
+
+	why = cachefiles_trace_read_have_data;
+	ret = NETFS_READ_FROM_CACHE;
+	goto out;
+
+download_and_store:
+	__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+out:
+	cachefiles_end_secure(cache, saved_cred);
+out_no_object:
+	trace_cachefiles_prep_read(subreq, ret, why, ino);
+	return ret;
+}
+
+/*
+ * Prepare for a write to occur.
+ */
+static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
+				      loff_t *_start, size_t *_len, loff_t i_size,
+				      bool no_space_allocated_yet)
+{
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct file *file = cachefiles_cres_file(cres);
+	loff_t start = *_start, pos;
+	size_t len = *_len, down;
+	int ret;
+
+	/* Round to DIO size */
+	down = start - round_down(start, PAGE_SIZE);
+	*_start = start - down;
+	*_len = round_up(down + len, PAGE_SIZE);
+
+	/* We need to work out whether there's sufficient disk space to perform
+	 * the write - but we can skip that check if we have space already
+	 * allocated.
+	 */
+	if (no_space_allocated_yet)
+		goto check_space;
+
+	pos = cachefiles_inject_read_error();
+	if (pos == 0)
+		pos = vfs_llseek(file, *_start, SEEK_DATA);
+	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
+		if (pos == -ENXIO)
+			goto check_space; /* Unallocated tail */
+		trace_cachefiles_io_error(object, file_inode(file), pos,
+					  cachefiles_trace_seek_error);
+		return pos;
+	}
+	if ((u64)pos >= (u64)*_start + *_len)
+		goto check_space; /* Unallocated region */
+
+	/* We have a block that's at least partially filled - if we're low on
+	 * space, we need to see if it's fully allocated.  If it's not, we may
+	 * want to cull it.
+	 */
+	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE) == 0)
+		return 0; /* Enough space to simply overwrite the whole block */
+
+	pos = cachefiles_inject_read_error();
+	if (pos == 0)
+		pos = vfs_llseek(file, *_start, SEEK_HOLE);
+	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
+		trace_cachefiles_io_error(object, file_inode(file), pos,
+					  cachefiles_trace_seek_error);
+		return pos;
+	}
+	if ((u64)pos >= (u64)*_start + *_len)
+		return 0; /* Fully allocated */
+
+	/* Partially allocated, but insufficient space: cull. */
+	pos = cachefiles_inject_remove_error();
+	if (pos == 0)
+		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				    *_start, *_len);
+	if (ret < 0) {
+		trace_cachefiles_io_error(object, file_inode(file), ret,
+					  cachefiles_trace_fallocate_error);
+		cachefiles_io_error_obj(object,
+					"CacheFiles: fallocate failed (%d)\n", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+
+check_space:
+	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE);
+}
+
+static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
+				    loff_t *_start, size_t *_len, loff_t i_size,
+				    bool no_space_allocated_yet)
+{
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+	int ret;
+
+	if (!cachefiles_cres_file(cres)) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+			return -ENOBUFS;
+		if (!cachefiles_cres_file(cres))
+			return -ENOBUFS;
+	}
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(cres, _start, _len, i_size,
+					 no_space_allocated_yet);
+	cachefiles_end_secure(cache, saved_cred);
+	return ret;
+}
+
 /*
  * Clean up an operation.
  */
@@ -28,6 +538,10 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
+	.read			= cachefiles_read,
+	.write			= cachefiles_write,
+	.prepare_read		= cachefiles_prepare_read,
+	.prepare_write		= cachefiles_prepare_write,
 };
 
 /*
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 47b584b3ffab..95ddf96b9b1d 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -61,6 +61,17 @@ enum cachefiles_trunc_trace {
 	cachefiles_trunc_shrink,
 };
 
+enum cachefiles_prepare_read_trace {
+	cachefiles_trace_read_after_eof,
+	cachefiles_trace_read_found_hole,
+	cachefiles_trace_read_found_part,
+	cachefiles_trace_read_have_data,
+	cachefiles_trace_read_no_data,
+	cachefiles_trace_read_no_file,
+	cachefiles_trace_read_seek_error,
+	cachefiles_trace_read_seek_nxio,
+};
+
 enum cachefiles_error_trace {
 	cachefiles_trace_fallocate_error,
 	cachefiles_trace_getxattr_error,
@@ -125,6 +136,16 @@ enum cachefiles_error_trace {
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
 	E_(cachefiles_trunc_shrink,		"SHRINK")
 
+#define cachefiles_prepare_read_traces					\
+	EM(cachefiles_trace_read_after_eof,	"after-eof ")		\
+	EM(cachefiles_trace_read_found_hole,	"found-hole")		\
+	EM(cachefiles_trace_read_found_part,	"found-part")		\
+	EM(cachefiles_trace_read_have_data,	"have-data ")		\
+	EM(cachefiles_trace_read_no_data,	"no-data   ")		\
+	EM(cachefiles_trace_read_no_file,	"no-file   ")		\
+	EM(cachefiles_trace_read_seek_error,	"seek-error")		\
+	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
+
 #define cachefiles_error_traces						\
 	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
 	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
@@ -157,6 +178,7 @@ cachefiles_obj_kill_traces;
 cachefiles_obj_ref_traces;
 cachefiles_coherency_traces;
 cachefiles_trunc_traces;
+cachefiles_prepare_read_traces;
 cachefiles_error_traces;
 
 /*
@@ -343,6 +365,105 @@ TRACE_EVENT(cachefiles_coherency,
 		      __entry->content)
 	    );
 
+TRACE_EVENT(cachefiles_prep_read,
+	    TP_PROTO(struct netfs_read_subrequest *sreq,
+		     enum netfs_read_source source,
+		     enum cachefiles_prepare_read_trace why,
+		     ino_t cache_inode),
+
+	    TP_ARGS(sreq, source, why, cache_inode),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned short,		index		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_read_source,	source		)
+		    __field(enum cachefiles_prepare_read_trace,	why	)
+		    __field(size_t,			len		)
+		    __field(loff_t,			start		)
+		    __field(unsigned int,		netfs_inode	)
+		    __field(unsigned int,		cache_inode	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= sreq->rreq->debug_id;
+		    __entry->index	= sreq->debug_index;
+		    __entry->flags	= sreq->flags;
+		    __entry->source	= source;
+		    __entry->why	= why;
+		    __entry->len	= sreq->len;
+		    __entry->start	= sreq->start;
+		    __entry->netfs_inode = sreq->rreq->inode->i_ino;
+		    __entry->cache_inode = cache_inode;
+			   ),
+
+	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx ni=%x b=%x",
+		      __entry->rreq, __entry->index,
+		      __print_symbolic(__entry->source, netfs_sreq_sources),
+		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
+		      __entry->flags,
+		      __entry->start, __entry->len,
+		      __entry->netfs_inode, __entry->cache_inode)
+	    );
+
+TRACE_EVENT(cachefiles_read,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     loff_t start,
+		     size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(size_t,				len	)
+		    __field(loff_t,				start	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->start	= start;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_write,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     loff_t start,
+		     size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(size_t,				len	)
+		    __field(loff_t,				start	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->start	= start;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
 TRACE_EVENT(cachefiles_trunc,
 	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
 		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),


