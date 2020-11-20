Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A432BAE00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgKTPMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728740AbgKTPMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XIuN70yEnhw6lyIcpzBOK0F2J/00EGK3E0GROkfQavs=;
        b=fwD+stCHIknf5EEg60sQmSmU0E0X5L/Sk8g63gcFQ/sasBKkwU508/RxInh5ghV+TRKcOL
        gpoWHSWKPosXAPlQMcK7cP3b9xypzZjnws0R362S2pW6YnS4F046jD7n5UWVbR1lphq/Sp
        s66SnxvmUy5yP6T6CXvgPOWCak3Ug2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-vdPAadHGNRyU29kCJjGpjQ-1; Fri, 20 Nov 2020 10:12:13 -0500
X-MC-Unique: vdPAadHGNRyU29kCJjGpjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEEE8107AD30;
        Fri, 20 Nov 2020 15:12:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC40060C15;
        Fri, 20 Nov 2020 15:12:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 44/76] cachefiles: Implement read and write parts of new
 I/O API
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
Date:   Fri, 20 Nov 2020 15:12:02 +0000
Message-ID: <160588512294.3465195.3303829406395432321.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement writing into the cache and reading back from the cache inside
cachefiles using asynchronous direct I/O from the specified iterator.  The
size and position of the request should be aligned to the reported
dio_block_size.

Errors and completion are reported by callback.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c |   20 ++-
 fs/cachefiles/internal.h  |    2 
 fs/cachefiles/io.c        |  270 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 277 insertions(+), 15 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 0e3d5b5ffc55..c14e2b4f5b24 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -12,8 +12,6 @@
 #include "internal.h"
 
 static int cachefiles_attr_changed(struct cachefiles_object *object);
-static void cachefiles_put_object(struct fscache_object *_object,
-				  enum fscache_obj_ref_trace why);
 
 /*
  * Allocate an object record for a cookie lookup and prepare the lookup data.
@@ -160,7 +158,8 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
-	loff_t object_size;
+	struct inode *inode;
+	loff_t object_size, i_size;
 	int ret;
 
 	_enter("{OBJ%x}", _object->debug_id);
@@ -172,12 +171,14 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	cachefiles_begin_secure(cache, &saved_cred);
 
 	object_size = object->fscache.cookie->object_size;
-	if (i_size_read(d_inode(object->dentry)) > object_size) {
+	inode = d_inode(object->dentry);
+	i_size = i_size_read(inode);
+	if (i_size > object_size) {
 		struct path path = {
 			.mnt	= cache->mnt,
 			.dentry	= object->dentry
 		};
-		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->dentry)), object_size);
+		_debug("trunc %llx -> %llx", i_size, object_size);
 		ret = vfs_truncate(&path, object_size);
 		if (ret < 0) {
 			cachefiles_io_error_obj(object, "Trunc-to-size failed");
@@ -186,8 +187,9 @@ static void cachefiles_update_object(struct fscache_object *_object)
 		}
 
 		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
-		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->dentry)), object_size);
-		if (i_size_read(d_inode(object->dentry)) < object_size) {
+		i_size = i_size_read(inode);
+		_debug("trunc %llx -> %llx", i_size, object_size);
+		if (i_size < object_size) {
 			ret = vfs_truncate(&path, object_size);
 			if (ret < 0) {
 				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
@@ -283,8 +285,8 @@ static void cachefiles_drop_object(struct fscache_object *_object,
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
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e9f45d5053b1..24a8aed2600d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -150,6 +150,8 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
 extern const struct fscache_cache_ops cachefiles_cache_ops;
 extern struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 						     enum fscache_obj_ref_trace why);
+extern void cachefiles_put_object(struct fscache_object *_object,
+				  enum fscache_obj_ref_trace why);
 
 /*
  * io.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index bf1930699636..4c66b9183dd6 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -10,9 +10,52 @@
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/xattr.h>
+#include <linux/sched/mm.h>
 #include "internal.h"
 #include <trace/events/fscache.h>
 
+struct cachefiles_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+	loff_t			start;
+	union {
+		size_t		skipped;
+		size_t		len;
+	};
+	struct cachefiles_object *object;
+	fscache_io_terminated_t	term_func;
+	void			*term_func_priv;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		cachefiles_put_object(&ki->object->fscache, fscache_obj_put_ioreq);
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
+	fscache_uncount_io_operation(ki->object->fscache.cookie);
+	cachefiles_put_kiocb(ki);
+}
+
 /*
  * Initiate a read from the cache.
  */
@@ -23,11 +66,142 @@ int cachefiles_read(struct fscache_op_resources *opr,
 		    fscache_io_terminated_t term_func,
 		    void *term_func_priv)
 {
-	fscache_wait_for_operation(opr, FSCACHE_WANT_READ);
+	struct cachefiles_object *object =
+		container_of(opr->object, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter), skipped = 0;
+
+	spin_lock(&object->fscache.lock);
+	file = get_file(object->backing_file);
+	spin_unlock(&object->fscache.lock);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file->f_inode));
+
+	__fscache_wait_for_operation(opr, FSCACHE_WANT_READ);
 	fscache_count_io_operation(opr->object->cookie);
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
+			fscache_uncount_io_operation(object->fscache.cookie);
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
+	ki->object		= object;
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
+	cachefiles_grab_object(&object->fscache, fscache_obj_get_ioreq);
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
+	fput(file);
 	if (term_func)
-		term_func(term_func_priv, -ENODATA);
-	return -ENODATA;
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
+	if (ret < 0) {
+		if (ki->term_func)
+			ki->term_func(ki->term_func_priv, ret);
+	} else {
+		if (ret == ki->len)
+			cachefiles_mark_content_map(ki->object, ki->start, ki->len);
+		if (ki->term_func)
+			ki->term_func(ki->term_func_priv, ret);
+	}
+
+	fscache_uncount_io_operation(ki->object->fscache.cookie);
+	cachefiles_put_kiocb(ki);
 }
 
 /*
@@ -39,11 +213,95 @@ int cachefiles_write(struct fscache_op_resources *opr,
 		     fscache_io_terminated_t term_func,
 		     void *term_func_priv)
 {
-	fscache_wait_for_operation(opr, FSCACHE_WANT_WRITE);
+	struct cachefiles_object *object =
+		container_of(opr->object, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter);
+
+	spin_lock(&object->fscache.lock);
+	file = get_file(object->backing_file);
+	spin_unlock(&object->fscache.lock);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file->f_inode));
+
+	__fscache_wait_for_operation(opr, FSCACHE_WANT_WRITE);
 	fscache_count_io_operation(opr->object->cookie);
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
+	ki->object		= object;
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
+	cachefiles_grab_object(&object->fscache, fscache_obj_get_ioreq);
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
+	fput(file);
 	if (term_func)
-		term_func(term_func_priv, -ENOBUFS);
-	return -ENOBUFS;
+		term_func(term_func_priv, -ENOMEM);
+	return -ENOMEM;
 }
 
 /*


