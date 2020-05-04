Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376151C419D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgEDRNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:13:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730125AbgEDRNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TD8IvGU/cs1ejkxvD4Als159+boOBcHJ/ANKfYOUjVo=;
        b=BunGYQpKIRmq8RLCMKxDYywRiZi6JCzTlFs5nd+x/csuFsPF+Z+lpWx5Cype6GWrF/sppL
        kss1NXUPnCmfRQ5MIL8kxYa3UtFSYhIduTBg4MpCcjiZ327IlHS/SvtmvSNL8OH/uTeqLx
        BjNofQHtVZ4f8Fi7dWhNvnUHbJMEO+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-AOKbFEc9PmWYUEvwg5nZjg-1; Mon, 04 May 2020 13:13:04 -0400
X-MC-Unique: AOKbFEc9PmWYUEvwg5nZjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A0B108BD0A;
        Mon,  4 May 2020 17:13:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD9D160C80;
        Mon,  4 May 2020 17:12:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 36/61] cachefiles: Implement read and write parts of new
 I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:12:55 +0100
Message-ID: <158861237502.340223.8393701975417626960.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
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

 fs/cachefiles/io.c |  208 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index ddb44ec5a199..42e0d620d778 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -12,30 +12,226 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
+struct cachefiles_kiocb {
+	struct kiocb			iocb;
+	struct fscache_io_request	*req;
+	refcount_t			ki_refcnt;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		fscache_put_io_request(ki->req);
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
+	struct fscache_io_request *req = ki->req;
+
+	_enter("%llx,%ld,%ld", req->len, ret, ret2);
+
+	fscache_end_io_operation(req->cookie);
+
+	if (ret < 0) {
+		req->error = ret;
+	} else if (ret != req->len) {
+		req->error = -ENODATA;
+	} else {
+		req->transferred = ret;
+		set_bit(FSCACHE_IO_DATA_FROM_CACHE, &req->flags);
+	}
+	if (req->io_done)
+		req->io_done(req);
+	cachefiles_put_kiocb(ki);
+}
+
 /*
  * Initiate a read from the cache.
  */
-int cachefiles_read(struct fscache_object *object,
+int cachefiles_read(struct fscache_object *obj,
 		    struct fscache_io_request *req,
 		    struct iov_iter *iter)
 {
-	req->error = -ENODATA;
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct file *file = object->backing_file;
+	ssize_t ret = -ENOBUFS;
+
+	_enter("%pD,%li,%llx,%llx/%llx",
+	       file, file_inode(file)->i_ino, req->pos, req->len, i_size_read(file->f_inode));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= get_file(file);
+	ki->iocb.ki_pos		= req->pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->req			= req;
+
+	if (req->io_done)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	ret = rw_verify_area(READ, file, &ki->iocb.ki_pos, iov_iter_count(iter));
+	if (ret < 0)
+		goto presubmission_error_free;
+
+	fscache_get_io_request(req);
+	ret = call_read_iter(file, &ki->iocb, iter);
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
+	fput(file);
+	kfree(ki);
+presubmission_error:
+	req->error = -ENOMEM;
+	if (req->io_done)
+		req->io_done(req);
+	return -ENOMEM;
+}
+
+/*
+ * Handle completion of a write to the cache.
+ */
+static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct fscache_io_request *req = ki->req;
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%llx,%ld,%ld", req->len, ret, ret2);
+
+	/* Tell lockdep we inherited freeze protection from submission thread */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+
+	fscache_end_io_operation(req->cookie);
+
+	if (ret < 0)
+		req->error = ret;
+	else if (ret != req->len)
+		req->error = -ENOBUFS;
+	else
+		cachefiles_mark_content_map(req);
 	if (req->io_done)
 		req->io_done(req);
-	return -ENODATA;
+	cachefiles_put_kiocb(ki);
 }
 
 /*
  * Initiate a write to the cache.
  */
-int cachefiles_write(struct fscache_object *object,
+int cachefiles_write(struct fscache_object *obj,
 		     struct fscache_io_request *req,
 		     struct iov_iter *iter)
 {
-	req->error = -ENOBUFS;
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file = object->backing_file;
+	ssize_t ret = -ENOBUFS;
+
+	_enter("%pD,%li,%llx,%llx/%llx",
+	       file, file_inode(file)->i_ino, req->pos, req->len, i_size_read(file->f_inode));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= get_file(file);
+	ki->iocb.ki_pos		= req->pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->req			= req;
+
+	if (req->io_done)
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
+	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE, true);
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+
+	fscache_get_io_request(req);
+	ret = call_write_iter(file, &ki->iocb, iter);
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
+	fput(file);
+	kfree(ki);
+presubmission_error:
+	req->error = -ENOMEM;
 	if (req->io_done)
 		req->io_done(req);
-	return -ENOBUFS;
+	return -ENOMEM;
 }
 
 /*


