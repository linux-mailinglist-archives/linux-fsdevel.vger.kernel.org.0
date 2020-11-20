Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041152BAEAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKTPTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbgKTPTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VcxcbR3I+/KolholQXr9kk5hjFx0z0dRM8YbywDjdA=;
        b=ffsuquJuuzj1fl0yBUWNbURwfQN0JaV2ahejk8duNULhYtpmm8YmzHB2XjzCAOsElIRCdK
        2U0g7RMOlyvdfMXL4tv31GZ7ZefJ++nruUAbkqYnPZjVoozzxhuw5bo2RUicXbBvWQVB8s
        DSL0yyu/EiPkgpaLaO9JldWX/4ijWm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-W6-MaewuMzewGjZeTS4FLg-1; Fri, 20 Nov 2020 10:18:56 -0500
X-MC-Unique: W6-MaewuMzewGjZeTS4FLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DFE8145E5;
        Fri, 20 Nov 2020 15:18:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF4135D6D1;
        Fri, 20 Nov 2020 15:18:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 73/76] afs: Add O_DIRECT read support
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
Date:   Fri, 20 Nov 2020 15:18:26 +0000
Message-ID: <160588550694.3465195.1373401214547164382.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add synchronous O_DIRECT read support to AFS (no AIO yet).  It can
theoretically handle reads up to the maximum size describable by loff_t -
and given an iterator with sufficiently capacity to handle that and given
support on the server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c      |   59 +++++++++++++++++++++++++++++++++++
 fs/afs/fsclient.c  |   18 ++++++++---
 fs/afs/internal.h  |    2 +
 fs/afs/write.c     |   88 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/afs/yfsclient.c |   12 +++++--
 5 files changed, 161 insertions(+), 18 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index bd070684de53..27445866531c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -24,6 +24,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static void afs_readahead(struct readahead_control *ractl);
+static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
@@ -53,6 +54,7 @@ const struct address_space_operations afs_fs_aops = {
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
 	.invalidatepage	= afs_invalidatepage,
+	.direct_IO	= afs_direct_IO,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
 	.writepage	= afs_writepage,
@@ -529,3 +531,60 @@ static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		vma->vm_ops = &afs_vm_ops;
 	return ret;
 }
+
+/*
+ * Direct file read operation for an AFS file.
+ *
+ * TODO: To support AIO, the pages in the iterator have to be copied and
+ * refs taken on them.  Then -EIOCBQUEUED needs to be returned.
+ * iocb->ki_complete must then be called upon completion of the operation.
+ */
+static ssize_t afs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	struct afs_read *req;
+	ssize_t ret, transferred;
+
+	_enter("%llx,%zx", iocb->ki_pos, iov_iter_count(iter));
+
+	req = afs_alloc_read(GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->vnode	= vnode;
+	req->key	= key_get(afs_file_key(file));
+	req->pos	= iocb->ki_pos;
+	req->len	= iov_iter_count(iter);
+	req->iter	= iter;
+
+	task_io_account_read(req->len);
+
+	// TODO nfs_start_io_direct(inode);
+	ret = afs_fetch_data(vnode, req);
+	if (ret == 0)
+		transferred = req->actual_len;
+	afs_put_read(req);
+
+	// TODO nfs_end_io_direct(inode);
+
+	if (ret == 0)
+		ret = transferred;
+
+	BUG_ON(ret == -EIOCBQUEUED); // TODO
+	//if (iocb->ki_complete)
+	//	iocb->ki_complete(iocb, ret, 0); // only if ret == -EIOCBQUEUED
+
+	_leave(" = %zu", ret);
+	return ret;
+}
+
+/*
+ * Do direct I/O.
+ */
+static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	if (iov_iter_rw(iter) == READ)
+		return afs_file_direct_read(iocb, iter);
+	return afs_file_direct_write(iocb, iter);
+}
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2f695a260442..5e42af4d1ded 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -438,7 +438,7 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	bp[3] = htonl(vp->fid.unique);
 	bp[4] = htonl(upper_32_bits(req->pos));
 	bp[5] = htonl(lower_32_bits(req->pos));
-	bp[6] = 0;
+	bp[6] = htonl(upper_32_bits(req->len));
 	bp[7] = htonl(lower_32_bits(req->len));
 
 	trace_afs_make_fs_call(call, &vp->fid);
@@ -1058,6 +1058,7 @@ static void afs_fs_store_data64(struct afs_operation *op)
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
 	__be32 *bp;
+	u32 mask = 0;
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode);
@@ -1070,6 +1071,9 @@ static void afs_fs_store_data64(struct afs_operation *op)
 
 	call->write_iter = op->store.write_iter;
 
+	if (op->flags & AFS_OPERATION_SET_MTIME)
+		mask |= AFS_SET_MTIME;
+
 	/* marshall the parameters */
 	bp = call->request;
 	*bp++ = htonl(FSSTOREDATA64);
@@ -1077,8 +1081,8 @@ static void afs_fs_store_data64(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.vnode);
 	*bp++ = htonl(vp->fid.unique);
 
-	*bp++ = htonl(AFS_SET_MTIME); /* mask */
-	*bp++ = htonl(op->mtime.tv_sec); /* mtime */
+	*bp++ = htonl(mask);
+	*bp++ = htonl(op->mtime.tv_sec);
 	*bp++ = 0; /* owner */
 	*bp++ = 0; /* group */
 	*bp++ = 0; /* unix mode */
@@ -1103,6 +1107,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
 	__be32 *bp;
+	u32 mask = 0;
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode);
@@ -1125,6 +1130,9 @@ void afs_fs_store_data(struct afs_operation *op)
 
 	call->write_iter = op->store.write_iter;
 
+	if (op->flags & AFS_OPERATION_SET_MTIME)
+		mask |= AFS_SET_MTIME;
+
 	/* marshall the parameters */
 	bp = call->request;
 	*bp++ = htonl(FSSTOREDATA);
@@ -1132,8 +1140,8 @@ void afs_fs_store_data(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.vnode);
 	*bp++ = htonl(vp->fid.unique);
 
-	*bp++ = htonl(AFS_SET_MTIME); /* mask */
-	*bp++ = htonl(op->mtime.tv_sec); /* mtime */
+	*bp++ = htonl(mask);
+	*bp++ = htonl(op->mtime.tv_sec);
 	*bp++ = 0; /* owner */
 	*bp++ = 0; /* group */
 	*bp++ = 0; /* unix mode */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index bc76c08b9f38..e80fb6fe15b3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -853,6 +853,7 @@ struct afs_operation {
 #define AFS_OPERATION_TRIED_ALL		0x0400	/* Set if we've tried all the fileservers */
 #define AFS_OPERATION_RETRY_SERVER	0x0800	/* Set if we should retry the current server */
 #define AFS_OPERATION_DIR_CONFLICT	0x1000	/* Set if we detected a 3rd-party dir change */
+#define AFS_OPERATION_SET_MTIME		0x2000	/* Set if we should try to store the mtime */
 };
 
 /*
@@ -1506,6 +1507,7 @@ extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
 extern int afs_launder_page(struct page *);
+extern ssize_t afs_file_direct_write(struct kiocb *, struct iov_iter *);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 627b08d8de1f..bab110c00abd 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -387,7 +387,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	op->store.i_size = max(pos + size, i_size);
 	op->store.laundering = laundering;
 	op->mtime = vnode->vfs_inode.i_mtime;
-	op->flags |= AFS_OPERATION_UNINTR;
+	op->flags |= AFS_OPERATION_SET_MTIME | AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
 try_next_key:
@@ -810,7 +810,6 @@ int afs_writepages(struct address_space *mapping,
 ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
-	ssize_t result;
 	size_t count = iov_iter_count(from);
 
 	_enter("{%llx:%llu},{%zu},",
@@ -822,13 +821,7 @@ ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		return -EBUSY;
 	}
 
-	if (!count)
-		return 0;
-
-	result = generic_file_write_iter(iocb, from);
-
-	_leave(" = %zd", result);
-	return result;
+	return generic_file_write_iter(iocb, from);
 }
 
 /*
@@ -997,3 +990,80 @@ static void afs_write_to_cache(struct afs_vnode *vnode,
 			       vnode->vfs_inode.i_mapping, start, len, i_size,
 			       afs_write_to_cache_done, vnode);
 }
+
+static void afs_dio_store_data_success(struct afs_operation *op)
+{
+	struct afs_vnode *vnode = op->file[0].vnode;
+
+	op->ctime = op->file[0].scb.status.mtime_client;
+	afs_vnode_commit_status(op, &op->file[0]);
+	if (op->error == 0) {
+		afs_stat_v(vnode, n_stores);
+		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
+	}
+}
+
+static const struct afs_operation_ops afs_dio_store_data_operation = {
+	.issue_afs_rpc	= afs_fs_store_data,
+	.issue_yfs_rpc	= yfs_fs_store_data,
+	.success	= afs_dio_store_data_success,
+};
+
+/*
+ * Direct file write operation for an AFS file.
+ *
+ * TODO: To support AIO, the pages in the iterator have to be copied and
+ * refs taken on them.  Then -EIOCBQUEUED needs to be returned.
+ * iocb->ki_complete must then be called upon completion of the operation.
+ */
+ssize_t afs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	struct afs_operation *op;
+	loff_t size = iov_iter_count(iter), i_size;
+	ssize_t ret;
+
+	_enter("%s{%llx:%llu.%u},%llx,%llx",
+	       vnode->volume->name,
+	       vnode->fid.vid,
+	       vnode->fid.vnode,
+	       vnode->fid.unique,
+	       size, iocb->ki_pos);
+
+	op = afs_alloc_operation(afs_file_key(file), vnode->volume);
+	if (IS_ERR(op))
+		return -ENOMEM;
+
+	i_size = i_size_read(&vnode->vfs_inode);
+
+	afs_op_set_vnode(op, 0, vnode);
+	op->file[0].dv_delta	= 1;
+	op->file[0].set_size	= true;
+	op->store.write_iter	= iter;
+	op->store.pos		= iocb->ki_pos;
+	op->store.size		= size;
+	op->store.i_size	= max(iocb->ki_pos + size, i_size);
+	op->ops			= &afs_dio_store_data_operation;
+
+	//if (!is_sync_kiocb(iocb)) {
+
+	ret = afs_do_sync_operation(op);
+	if (ret == 0)
+		ret = size;
+
+	{
+		struct afs_vnode_cache_aux aux = {
+			.data_version = vnode->status.data_version,
+		};
+		fscache_invalidate(afs_vnode_cache(vnode), &aux,
+				   i_size_read(&vnode->vfs_inode),
+				   FSCACHE_INVAL_DIO_WRITE);
+	}
+
+	//if (iocb->ki_complete)
+	//	iocb->ki_complete(iocb, ret, 0); // only if ret == -EIOCBQUEUED
+
+	_leave(" = %zd", ret);
+	return ret;
+}
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 2b35cba8ad62..a8c4e230002d 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -95,12 +95,16 @@ static __be32 *xdr_encode_YFSStoreStatus_mode(__be32 *bp, mode_t mode)
 	return bp + xdr_size(x);
 }
 
-static __be32 *xdr_encode_YFSStoreStatus_mtime(__be32 *bp, const struct timespec64 *t)
+static __be32 *xdr_encode_YFSStoreStatus_mtime(__be32 *bp, struct afs_operation *op)
 {
 	struct yfs_xdr_YFSStoreStatus *x = (void *)bp;
-	s64 mtime = linux_to_yfs_time(t);
+	s64 mtime = linux_to_yfs_time(&op->mtime);
+	u32 mask = 0;
 
-	x->mask		= htonl(AFS_SET_MTIME);
+	if (op->flags & AFS_OPERATION_SET_MTIME)
+		mask |= AFS_SET_MTIME;
+
+	x->mask		= htonl(mask);
 	x->mode		= htonl(0);
 	x->mtime_client	= u64_to_xdr(mtime);
 	x->owner	= u64_to_xdr(0);
@@ -1103,7 +1107,7 @@ void yfs_fs_store_data(struct afs_operation *op)
 	bp = xdr_encode_u32(bp, YFSSTOREDATA64);
 	bp = xdr_encode_u32(bp, 0); /* RPC flags */
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
-	bp = xdr_encode_YFSStoreStatus_mtime(bp, &op->mtime);
+	bp = xdr_encode_YFSStoreStatus_mtime(bp, op);
 	bp = xdr_encode_u64(bp, op->store.pos);
 	bp = xdr_encode_u64(bp, op->store.size);
 	bp = xdr_encode_u64(bp, op->store.i_size);


