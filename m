Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D189D49B59B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386989AbiAYODK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385742AbiAYOAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643119216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssmuK407DvTsyk/H/EO57MZ7G3jp8P3zJlHztI7Z1Ak=;
        b=gFOfgepFchCwdzhjLcDSdQpNFpfgyqIRBBh2NV5gkviKxCigI+1yWTFkmaMLE6QJqay/oS
        pmIe8BMAGK6mG8Fb38obXC7tGPFpRtR1pP4DmV8xpDEzDuMd5eNGhKbJXCmbZya9PMx5LW
        KQ1m8gtc1PeInyCGEOPJfjpSYMtgtbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-T63jkJRWP3u8JZItuA1TNg-1; Tue, 25 Jan 2022 09:00:14 -0500
X-MC-Unique: T63jkJRWP3u8JZItuA1TNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A3958144E7;
        Tue, 25 Jan 2022 14:00:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30471703B8;
        Tue, 25 Jan 2022 13:59:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, nspmangalore@gmail.com
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 13:59:57 +0000
Message-ID: <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cifs/Kconfig        |    1 
 fs/cifs/cifsfs.c       |    6 
 fs/cifs/cifsfs.h       |    3 
 fs/cifs/cifsglob.h     |    6 
 fs/cifs/cifssmb.c      |    9 -
 fs/cifs/file.c         |  824 ++++++++----------------------------------------
 fs/cifs/fscache.c      |   31 --
 fs/cifs/fscache.h      |   52 ---
 fs/cifs/inode.c        |   17 +
 fs/cifs/smb2pdu.c      |   15 +
 fs/netfs/read_helper.c |    7 
 11 files changed, 182 insertions(+), 789 deletions(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 3b7e3b9e4fd2..c47e2d3a101f 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -2,6 +2,7 @@
 config CIFS
 	tristate "SMB3 and CIFS support (advanced network filesystem)"
 	depends on INET
+	select NETFS_SUPPORT
 	select NLS
 	select CRYPTO
 	select CRYPTO_MD5
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index a56cb9c8c5ff..bd06df3bb24b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -936,7 +936,7 @@ cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return cifs_user_readv(iocb, iter);
+		return netfs_direct_read_iter(iocb, iter);
 
 	rc = cifs_revalidate_mapping(inode);
 	if (rc)
@@ -1314,7 +1314,7 @@ const struct file_operations cifs_file_strict_ops = {
 };
 
 const struct file_operations cifs_file_direct_ops = {
-	.read_iter = cifs_direct_readv,
+	.read_iter = netfs_direct_read_iter,
 	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
@@ -1370,7 +1370,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 };
 
 const struct file_operations cifs_file_direct_nobrl_ops = {
-	.read_iter = cifs_direct_readv,
+	.read_iter = netfs_direct_read_iter,
 	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 1c77bbc0815f..c7d5c268fc47 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -85,6 +85,7 @@ extern const struct inode_operations cifs_dfs_referral_inode_operations;
 
 
 /* Functions related to files and directories */
+extern const struct netfs_request_ops cifs_req_ops;
 extern const struct file_operations cifs_file_ops;
 extern const struct file_operations cifs_file_direct_ops; /* if directio mnt */
 extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
@@ -94,8 +95,6 @@ extern const struct file_operations cifs_file_strict_nobrl_ops;
 extern int cifs_open(struct inode *inode, struct file *file);
 extern int cifs_close(struct inode *inode, struct file *file);
 extern int cifs_closedir(struct inode *inode, struct file *file);
-extern ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 3a4fed645636..938e4e9827ed 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1313,18 +1313,14 @@ struct cifs_aio_ctx {
 
 /* asynchronous read support */
 struct cifs_readdata {
+	struct netfs_read_subrequest	*subreq;
 	struct kref			refcount;
-	struct list_head		list;
-	struct completion		done;
 	struct cifsFileInfo		*cfile;
-	struct address_space		*mapping;
-	struct cifs_aio_ctx		*ctx;
 	__u64				offset;
 	ssize_t				got_bytes;
 	unsigned int			bytes;
 	pid_t				pid;
 	int				result;
-	struct work_struct		work;
 	struct iov_iter			iter;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 38e7276352e2..c9fb77a8b31b 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/uaccess.h>
+#include <linux/netfs.h>
 #include "cifspdu.h"
 #include "cifsfs.h"
 #include "cifsglob.h"
@@ -1609,7 +1610,13 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		rdata->result = -EIO;
 	}
 
-	queue_work(cifsiod_wq, &rdata->work);
+	if (rdata->result == 0 || rdata->result == -EAGAIN)
+		iov_iter_advance(&rdata->subreq->iter, rdata->got_bytes);
+	netfs_subreq_terminated(rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result,
+				false);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 	DeleteMidQEntry(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f9b9a1562e17..36559de02e37 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
+#include <linux/netfs.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -3306,12 +3307,8 @@ static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
 	struct cifs_readdata *rdata;
 
 	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
-	if (rdata) {
+	if (rdata)
 		kref_init(&rdata->refcount);
-		INIT_LIST_HEAD(&rdata->list);
-		init_completion(&rdata->done);
-		INIT_WORK(&rdata->work, complete);
-	}
 
 	return rdata;
 }
@@ -3322,8 +3319,6 @@ cifs_readdata_release(struct kref *refcount)
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
 
-	if (rdata->ctx)
-		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
@@ -3336,370 +3331,6 @@ cifs_readdata_release(struct kref *refcount)
 	kfree(rdata);
 }
 
-static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
-
-static void
-cifs_uncached_readv_complete(struct work_struct *work)
-{
-	struct cifs_readdata *rdata = container_of(work,
-						struct cifs_readdata, work);
-
-	complete(&rdata->done);
-	collect_uncached_read_data(rdata->ctx);
-	/* the below call can possibly free the last ref to aio ctx */
-	kref_put(&rdata->refcount, cifs_readdata_release);
-}
-
-static int cifs_resend_rdata(struct cifs_readdata *rdata,
-			struct list_head *rdata_list,
-			struct cifs_aio_ctx *ctx)
-{
-	unsigned int rsize;
-	struct cifs_credits credits;
-	int rc;
-	struct TCP_Server_Info *server;
-
-	/* XXX: should we pick a new channel here? */
-	server = rdata->server;
-
-	do {
-		if (rdata->cfile->invalidHandle) {
-			rc = cifs_reopen_file(rdata->cfile, true);
-			if (rc == -EAGAIN)
-				continue;
-			else if (rc)
-				break;
-		}
-
-		/*
-		 * Wait for credits to resend this rdata.
-		 * Note: we are attempting to resend the whole rdata not in
-		 * segments
-		 */
-		do {
-			rc = server->ops->wait_mtu_credits(server, rdata->bytes,
-						&rsize, &credits);
-
-			if (rc)
-				goto fail;
-
-			if (rsize < rdata->bytes) {
-				add_credits_and_wake_if(server, &credits, 0);
-				msleep(1000);
-			}
-		} while (rsize < rdata->bytes);
-		rdata->credits = credits;
-
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
-		if (!rc) {
-			if (rdata->cfile->invalidHandle)
-				rc = -EAGAIN;
-			else {
-#ifdef CONFIG_CIFS_SMB_DIRECT
-				if (rdata->mr) {
-					rdata->mr->need_invalidate = true;
-					smbd_deregister_mr(rdata->mr);
-					rdata->mr = NULL;
-				}
-#endif
-				rc = server->ops->async_readv(rdata);
-			}
-		}
-
-		/* If the read was successfully sent, we are done */
-		if (!rc) {
-			/* Add to aio pending list */
-			list_add_tail(&rdata->list, rdata_list);
-			return 0;
-		}
-
-		/* Roll back credits and retry if needed */
-		add_credits_and_wake_if(server, &rdata->credits, 0);
-	} while (rc == -EAGAIN);
-
-fail:
-	kref_put(&rdata->refcount, cifs_readdata_release);
-	return rc;
-}
-
-static int
-cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
-		     struct cifs_sb_info *cifs_sb, struct list_head *rdata_list,
-		     struct cifs_aio_ctx *ctx)
-{
-	struct cifs_readdata *rdata;
-	unsigned int rsize;
-	struct cifs_credits credits_on_stack;
-	struct cifs_credits *credits = &credits_on_stack;
-	size_t cur_len;
-	int rc;
-	pid_t pid;
-	struct TCP_Server_Info *server;
-
-	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
-
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = open_file->pid;
-	else
-		pid = current->tgid;
-
-	do {
-		if (open_file->invalidHandle) {
-			rc = cifs_reopen_file(open_file, true);
-			if (rc == -EAGAIN)
-				continue;
-			else if (rc)
-				break;
-		}
-
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-						   &rsize, credits);
-		if (rc)
-			break;
-
-		cur_len = min_t(const size_t, len, rsize);
-
-		rdata = cifs_readdata_alloc(cifs_uncached_readv_complete);
-		if (!rdata) {
-			add_credits_and_wake_if(server, credits, 0);
-			rc = -ENOMEM;
-			break;
-		}
-
-		rdata->server	= server;
-		rdata->cfile	= cifsFileInfo_get(open_file);
-		rdata->offset	= offset;
-		rdata->bytes	= cur_len;
-		rdata->pid	= pid;
-		rdata->credits	= credits_on_stack;
-		rdata->ctx	= ctx;
-		kref_get(&ctx->refcount);
-
-		rdata->iter	= ctx->iter;
-		iov_iter_advance(&rdata->iter, offset - ctx->pos);
-		iov_iter_truncate(&rdata->iter, cur_len);
-
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
-
-		if (!rc) {
-			if (rdata->cfile->invalidHandle)
-				rc = -EAGAIN;
-			else
-				rc = server->ops->async_readv(rdata);
-		}
-
-		if (rc) {
-			add_credits_and_wake_if(server, &rdata->credits, 0);
-			kref_put(&rdata->refcount, cifs_readdata_release);
-			if (rc == -EAGAIN)
-				continue;
-			break;
-		}
-
-		list_add_tail(&rdata->list, rdata_list);
-		offset += cur_len;
-		len -= cur_len;
-	} while (len > 0);
-
-	return rc;
-}
-
-static void
-collect_uncached_read_data(struct cifs_aio_ctx *ctx)
-{
-	struct cifs_readdata *rdata, *tmp;
-	struct iov_iter *to = &ctx->iter;
-	struct cifs_sb_info *cifs_sb;
-	int rc;
-
-	cifs_sb = CIFS_SB(ctx->cfile->dentry->d_sb);
-
-	mutex_lock(&ctx->aio_mutex);
-
-	if (list_empty(&ctx->list)) {
-		mutex_unlock(&ctx->aio_mutex);
-		return;
-	}
-
-	rc = ctx->rc;
-	/* the loop below should proceed in the order of increasing offsets */
-again:
-	list_for_each_entry_safe(rdata, tmp, &ctx->list, list) {
-		if (!rc) {
-			if (!try_wait_for_completion(&rdata->done)) {
-				mutex_unlock(&ctx->aio_mutex);
-				return;
-			}
-
-			if (rdata->result == -EAGAIN) {
-				/* resend call if it's a retryable error */
-				struct list_head tmp_list;
-				unsigned int got_bytes = rdata->got_bytes;
-
-				list_del_init(&rdata->list);
-				INIT_LIST_HEAD(&tmp_list);
-
-				if (ctx->direct_io) {
-					/*
-					 * Re-use rdata as this is a
-					 * direct I/O
-					 */
-					rc = cifs_resend_rdata(
-						rdata,
-						&tmp_list, ctx);
-				} else {
-					rc = cifs_send_async_read(
-						rdata->offset + got_bytes,
-						rdata->bytes - got_bytes,
-						rdata->cfile, cifs_sb,
-						&tmp_list, ctx);
-
-					kref_put(&rdata->refcount,
-						cifs_readdata_release);
-				}
-
-				list_splice(&tmp_list, &ctx->list);
-
-				goto again;
-			} else if (rdata->result)
-				rc = rdata->result;
-
-			/* if there was a short read -- discard anything left */
-			if (rdata->got_bytes && rdata->got_bytes < rdata->bytes)
-				rc = -ENODATA;
-
-			ctx->total_len += rdata->got_bytes;
-		}
-		list_del_init(&rdata->list);
-		kref_put(&rdata->refcount, cifs_readdata_release);
-	}
-
-	if (!ctx->direct_io)
-		ctx->total_len = ctx->len - iov_iter_count(to);
-
-	/* mask nodata case */
-	if (rc == -ENODATA)
-		rc = 0;
-
-	ctx->rc = (rc == 0) ? (ssize_t)ctx->total_len : rc;
-
-	mutex_unlock(&ctx->aio_mutex);
-
-	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
-	else
-		complete(&ctx->done);
-}
-
-static ssize_t __cifs_readv(
-	struct kiocb *iocb, struct iov_iter *to, bool direct)
-{
-	size_t len;
-	struct file *file = iocb->ki_filp;
-	struct cifs_sb_info *cifs_sb;
-	struct cifsFileInfo *cfile;
-	struct cifs_tcon *tcon;
-	ssize_t rc, total_read = 0;
-	loff_t offset = iocb->ki_pos;
-	struct cifs_aio_ctx *ctx;
-
-	/*
-	 * iov_iter_get_pages_alloc() doesn't work with ITER_KVEC,
-	 * fall back to data copy read path
-	 * this could be improved by getting pages directly in ITER_KVEC
-	 */
-	if (direct && iov_iter_is_kvec(to)) {
-		cifs_dbg(FYI, "use non-direct cifs_user_readv for kvec I/O\n");
-		direct = false;
-	}
-
-	len = iov_iter_count(to);
-	if (!len)
-		return 0;
-
-	cifs_sb = CIFS_FILE_SB(file);
-	cfile = file->private_data;
-	tcon = tlink_tcon(cfile->tlink);
-
-	if (!tcon->ses->server->ops->async_readv)
-		return -ENOSYS;
-
-	if ((file->f_flags & O_ACCMODE) == O_WRONLY)
-		cifs_dbg(FYI, "attempting read on write only file instance\n");
-
-	ctx = cifs_aio_ctx_alloc();
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->pos	= offset;
-	ctx->direct_io	= direct;
-	ctx->len	= len;
-	ctx->cfile	= cifsFileInfo_get(cfile);
-
-	if (!is_sync_kiocb(iocb))
-		ctx->iocb = iocb;
-
-	if (iter_is_iovec(to))
-		ctx->should_dirty = true;
-
-	rc = extract_iter_to_iter(to, len, &ctx->iter, &ctx->bv);
-	if (rc < 0) {
-		kref_put(&ctx->refcount, cifs_aio_ctx_release);
-		return rc;
-	}
-	ctx->npages = rc;
-
-	/* grab a lock here due to read response handlers can access ctx */
-	mutex_lock(&ctx->aio_mutex);
-
-	rc = cifs_send_async_read(offset, len, cfile, cifs_sb, &ctx->list, ctx);
-
-	/* if at least one read request send succeeded, then reset rc */
-	if (!list_empty(&ctx->list))
-		rc = 0;
-
-	mutex_unlock(&ctx->aio_mutex);
-
-	if (rc) {
-		kref_put(&ctx->refcount, cifs_aio_ctx_release);
-		return rc;
-	}
-
-	if (!is_sync_kiocb(iocb)) {
-		kref_put(&ctx->refcount, cifs_aio_ctx_release);
-		return -EIOCBQUEUED;
-	}
-
-	rc = wait_for_completion_killable(&ctx->done);
-	if (rc) {
-		mutex_lock(&ctx->aio_mutex);
-		ctx->rc = rc = -EINTR;
-		total_read = ctx->total_len;
-		mutex_unlock(&ctx->aio_mutex);
-	} else {
-		rc = ctx->rc;
-		total_read = ctx->total_len;
-	}
-
-	kref_put(&ctx->refcount, cifs_aio_ctx_release);
-
-	if (total_read) {
-		iocb->ki_pos += total_read;
-		return total_read;
-	}
-	return rc;
-}
-
-ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to)
-{
-	return __cifs_readv(iocb, to, true);
-}
-
-ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
-{
-	return __cifs_readv(iocb, to, false);
-}
-
 ssize_t
 cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -3720,12 +3351,15 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	 * pos+len-1.
 	 */
 	if (!CIFS_CACHE_READ(cinode))
-		return cifs_user_readv(iocb, to);
+		return netfs_direct_read_iter(iocb, to);
 
 	if (cap_unix(tcon->ses) &&
 	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
-	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0))
+	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0)) {
+		if (iocb->ki_flags & IOCB_DIRECT)
+			return netfs_direct_read_iter(iocb, to);
 		return generic_file_read_iter(iocb, to);
+	}
 
 	/*
 	 * We need to hold the sem to be sure nobody modifies lock list
@@ -3734,104 +3368,16 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	down_read(&cinode->lock_sem);
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
 				     tcon->ses->server->vals->shared_lock_type,
-				     0, NULL, CIFS_READ_OP))
-		rc = generic_file_read_iter(iocb, to);
+				     0, NULL, CIFS_READ_OP)) {
+		if (iocb->ki_flags & IOCB_DIRECT)
+			rc = netfs_direct_read_iter(iocb, to);
+		else
+			rc = generic_file_read_iter(iocb, to);
+	}
 	up_read(&cinode->lock_sem);
 	return rc;
 }
 
-static ssize_t
-cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
-{
-	int rc = -EACCES;
-	unsigned int bytes_read = 0;
-	unsigned int total_read;
-	unsigned int current_read_size;
-	unsigned int rsize;
-	struct cifs_sb_info *cifs_sb;
-	struct cifs_tcon *tcon;
-	struct TCP_Server_Info *server;
-	unsigned int xid;
-	char *cur_offset;
-	struct cifsFileInfo *open_file;
-	struct cifs_io_parms io_parms = {0};
-	int buf_type = CIFS_NO_BUFFER;
-	__u32 pid;
-
-	xid = get_xid();
-	cifs_sb = CIFS_FILE_SB(file);
-
-	/* FIXME: set up handlers for larger reads and/or convert to async */
-	rsize = min_t(unsigned int, cifs_sb->ctx->rsize, CIFSMaxBufSize);
-
-	if (file->private_data == NULL) {
-		rc = -EBADF;
-		free_xid(xid);
-		return rc;
-	}
-	open_file = file->private_data;
-	tcon = tlink_tcon(open_file->tlink);
-	server = cifs_pick_channel(tcon->ses);
-
-	if (!server->ops->sync_read) {
-		free_xid(xid);
-		return -ENOSYS;
-	}
-
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = open_file->pid;
-	else
-		pid = current->tgid;
-
-	if ((file->f_flags & O_ACCMODE) == O_WRONLY)
-		cifs_dbg(FYI, "attempting read on write only file instance\n");
-
-	for (total_read = 0, cur_offset = read_data; read_size > total_read;
-	     total_read += bytes_read, cur_offset += bytes_read) {
-		do {
-			current_read_size = min_t(uint, read_size - total_read,
-						  rsize);
-			/*
-			 * For windows me and 9x we do not want to request more
-			 * than it negotiated since it will refuse the read
-			 * then.
-			 */
-			if (!(tcon->ses->capabilities &
-				tcon->ses->server->vals->cap_large_files)) {
-				current_read_size = min_t(uint,
-					current_read_size, CIFSMaxBufSize);
-			}
-			if (open_file->invalidHandle) {
-				rc = cifs_reopen_file(open_file, true);
-				if (rc != 0)
-					break;
-			}
-			io_parms.pid = pid;
-			io_parms.tcon = tcon;
-			io_parms.offset = *offset;
-			io_parms.length = current_read_size;
-			io_parms.server = server;
-			rc = server->ops->sync_read(xid, &open_file->fid, &io_parms,
-						    &bytes_read, &cur_offset,
-						    &buf_type);
-		} while (rc == -EAGAIN);
-
-		if (rc || (bytes_read == 0)) {
-			if (total_read) {
-				break;
-			} else {
-				free_xid(xid);
-				return rc;
-			}
-		} else {
-			cifs_stats_bytes_read(tcon, total_read);
-			*offset += bytes_read;
-		}
-	}
-	free_xid(xid);
-	return total_read;
-}
-
 /*
  * If the page is mmap'ed into a process' page tables, then we need to make
  * sure that it doesn't change while being written back.
@@ -3901,224 +3447,149 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 /*
- * Unlock a bunch of folios in the pagecache.
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
  */
-static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgoff_t last)
-{
-       struct folio *folio;
-       XA_STATE(xas, &mapping->i_pages, first);
-
-       rcu_read_lock();
-       xas_for_each(&xas, folio, last) {
-               folio_unlock(folio);
-       }
-       rcu_read_unlock();
-}
-
-static void cifs_readahead_complete(struct work_struct *work)
-{
-	struct cifs_readdata *rdata = container_of(work,
-						   struct cifs_readdata, work);
-	struct folio *folio;
-	pgoff_t last;
-	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
-
-	XA_STATE(xas, &rdata->mapping->i_pages, rdata->offset / PAGE_SIZE);
-
-#if 0
-	if (good)
-		cifs_readpage_to_fscache(rdata->mapping->host, page);
-#endif
-
-	if (iov_iter_count(&rdata->iter) > 0)
-		iov_iter_zero(iov_iter_count(&rdata->iter), &rdata->iter);
-
-	last = round_down(rdata->offset + rdata->got_bytes - 1, PAGE_SIZE);
-
-	xas_for_each(&xas, folio, last) {
-		if (good) {
-			flush_dcache_folio(folio);
-			folio_mark_uptodate(folio);
-		}
-		folio_unlock(folio);
-	}
-
-	kref_put(&rdata->refcount, cifs_readdata_release);
-}
-
-static void cifs_readahead(struct readahead_control *ractl)
+static void cifs_req_issue_op(struct netfs_read_subrequest *subreq)
 {
-	struct cifsFileInfo *open_file = ractl->file->private_data;
-	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
+	struct netfs_read_request *rreq = subreq->rreq;
 	struct TCP_Server_Info *server;
+	struct cifs_readdata *rdata;
+	struct cifsFileInfo *open_file = rreq->netfs_priv;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	struct cifs_credits credits_on_stack, *credits = &credits_on_stack;
 	unsigned int xid;
 	pid_t pid;
 	int rc = 0;
+	unsigned int rsize;
 
 	xid = get_xid();
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
 	else
-		pid = current->tgid;
+		pid = current->tgid; // Ummm...  This may be a workqueue
 
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
-	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
-		 __func__, ractl->file, ractl->mapping, readahead_count(ractl));
-
-	/*
-	 * Chop the readahead request up into rsize-sized read requests.
-	 */
-	while (readahead_count(ractl) - ractl->_batch_count) {
-		unsigned int i, nr_pages, rsize;
-		struct cifs_readdata *rdata;
-		struct cifs_credits credits_on_stack;
-		struct cifs_credits *credits = &credits_on_stack;
+	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
+		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
+		 subreq->transferred, subreq->len);
 
-		if (open_file->invalidHandle) {
+	if (open_file->invalidHandle) {
+		do {
 			rc = cifs_reopen_file(open_file, true);
-			if (rc) {
-				if (rc == -EAGAIN)
-					continue;
-				break;
-			}
-		}
-
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-						   &rsize, credits);
+		} while (rc == -EAGAIN);
 		if (rc)
-			break;
-		nr_pages = min_t(size_t, rsize / PAGE_SIZE, readahead_count(ractl));
-
-		/*
-		 * Give up immediately if rsize is too small to read an entire
-		 * page. The VFS will fall back to readpage. We should never
-		 * reach this point however since we set ra_pages to 0 when the
-		 * rsize is smaller than a cache page.
-		 */
-		if (unlikely(!nr_pages)) {
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		rdata = cifs_readdata_alloc(cifs_readahead_complete);
-		if (!rdata) {
-			/* best to give up if we're out of mem */
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+			goto out;
+	}
 
-		rdata->offset	= readahead_pos(ractl);
-		rdata->bytes	= nr_pages * PAGE_SIZE;
-		rdata->cfile	= cifsFileInfo_get(open_file);
-		rdata->server	= server;
-		rdata->mapping	= ractl->mapping;
-		rdata->pid	= pid;
-		rdata->credits	= credits_on_stack;
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize, credits);
+	if (rc)
+		goto out;
 
-		for (i = 0; i < nr_pages; i++)
-			if (!readahead_folio(ractl))
-				BUG();
+	rdata = cifs_readdata_alloc(NULL);
+	if (!rdata) {
+		add_credits_and_wake_if(server, credits, 0);
+		rc = -ENOMEM;
+		goto out;
+	}
 
-		iov_iter_xarray(&rdata->iter, READ, &rdata->mapping->i_pages,
-				rdata->offset, rdata->bytes);
+	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	rdata->subreq	= subreq;
+	rdata->cfile	= cifsFileInfo_get(open_file);
+	rdata->server	= server;
+	rdata->offset	= subreq->start + subreq->transferred;
+	rdata->bytes	= subreq->len   - subreq->transferred;
+	rdata->pid	= pid;
+	rdata->credits	= credits_on_stack;
+	rdata->iter	= subreq->iter;
 
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
-		if (!rc) {
-			if (rdata->cfile->invalidHandle)
-				rc = -EAGAIN;
-			else
-				rc = server->ops->async_readv(rdata);
-		}
+	rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+	if (!rc) {
+		if (rdata->cfile->invalidHandle)
+			rc = -EAGAIN;
+		else
+			rc = server->ops->async_readv(rdata);
+	}
 
-		if (rc) {
-			add_credits_and_wake_if(server, &rdata->credits, 0);
-			cifs_unlock_folios(rdata->mapping,
-					   rdata->offset / PAGE_SIZE,
-					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
-			/* Fallback to the readpage in error/reconnect cases */
-			kref_put(&rdata->refcount, cifs_readdata_release);
-			break;
-		}
+	if (rc) {
+		add_credits_and_wake_if(server, &rdata->credits, 0);
+		/* Fallback to the readpage in error/reconnect cases */
+		kref_put(&rdata->refcount, cifs_readdata_release);
+		goto out;
 	}
 
+	kref_put(&rdata->refcount, cifs_readdata_release);
+
+out:
 	free_xid(xid);
+	if (rc)
+		netfs_subreq_terminated(subreq, rc, false);
+}
+
+static int cifs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+{
+	rreq->netfs_priv = file->private_data;
+	return 0;
 }
 
 /*
- * cifs_readpage_worker must be called with the page pinned
+ * Expand the size of a readahead to the size of the rsize, if at least as
+ * large as a page, allowing for the possibility that rsize is not pow-2
+ * aligned.
  */
-static int cifs_readpage_worker(struct file *file, struct page *page,
-	loff_t *poffset)
+static void cifs_expand_readahead(struct netfs_read_request *rreq)
 {
-	char *read_data;
-	int rc;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	unsigned int rsize = cifs_sb->ctx->rsize;
+	loff_t misalignment, i_size = i_size_read(rreq->inode);
 
-	/* Is the page cached? */
-	rc = cifs_readpage_from_fscache(file_inode(file), page);
-	if (rc == 0)
-		goto read_complete;
-
-	read_data = kmap(page);
-	/* for reads over a certain size could initiate async read ahead */
-
-	rc = cifs_read(file, read_data, PAGE_SIZE, poffset);
-
-	if (rc < 0)
-		goto io_error;
-	else
-		cifs_dbg(FYI, "Bytes read %d\n", rc);
+	if (rsize < PAGE_SIZE)
+		return;
 
-	/* we do not want atime to be less than mtime, it broke some apps */
-	file_inode(file)->i_atime = current_time(file_inode(file));
-	if (timespec64_compare(&(file_inode(file)->i_atime), &(file_inode(file)->i_mtime)))
-		file_inode(file)->i_atime = file_inode(file)->i_mtime;
+	if (rsize < INT_MAX)
+		rsize = roundup_pow_of_two(rsize);
 	else
-		file_inode(file)->i_atime = current_time(file_inode(file));
+		rsize = ((unsigned int)INT_MAX + 1) / 2;
 
-	if (PAGE_SIZE > rc)
-		memset(read_data + rc, 0, PAGE_SIZE - rc);
-
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-
-	/* send this page to the cache */
-	cifs_readpage_to_fscache(file_inode(file), page);
-
-	rc = 0;
-
-io_error:
-	kunmap(page);
-	unlock_page(page);
+	misalignment = rreq->start & (rsize - 1);
+	if (misalignment) {
+		rreq->start -= misalignment;
+		rreq->len += misalignment;
+	}
 
-read_complete:
-	return rc;
+	rreq->len = round_up(rreq->len, rsize);
+	if (rreq->start < i_size && rreq->len > i_size - rreq->start)
+		rreq->len = i_size - rreq->start;
 }
 
-static int cifs_readpage(struct file *file, struct page *page)
+static void cifs_rreq_done(struct netfs_read_request *rreq)
 {
-	loff_t offset = page_file_offset(page);
-	int rc = -EACCES;
-	unsigned int xid;
+	struct inode *inode = rreq->inode;
 
-	xid = get_xid();
-
-	if (file->private_data == NULL) {
-		rc = -EBADF;
-		free_xid(xid);
-		return rc;
-	}
-
-	cifs_dbg(FYI, "readpage %p at offset %d 0x%x\n",
-		 page, (int)offset, (int)offset);
-
-	rc = cifs_readpage_worker(file, page, &offset);
+	/* we do not want atime to be less than mtime, it broke some apps */
+	inode->i_atime = current_time(inode);
+	if (timespec64_compare(&inode->i_atime, &inode->i_mtime))
+		inode->i_atime = inode->i_mtime;
+	else
+		inode->i_atime = current_time(inode);
+}
 
-	free_xid(xid);
-	return rc;
+static void cifs_req_cleanup(struct address_space *mapping, void *netfs_priv)
+{
 }
 
+const struct netfs_request_ops cifs_req_ops = {
+	.init_rreq		= cifs_init_rreq,
+	.expand_readahead	= cifs_expand_readahead,
+	.issue_op		= cifs_req_issue_op,
+	.done			= cifs_rreq_done,
+	.cleanup		= cifs_req_cleanup,
+};
+
 static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
 {
 	struct cifsFileInfo *open_file;
@@ -4168,34 +3639,20 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata)
 {
-	int oncethru = 0;
-	pgoff_t index = pos >> PAGE_SHIFT;
-	loff_t offset = pos & (PAGE_SIZE - 1);
-	loff_t page_start = pos & PAGE_MASK;
-	loff_t i_size;
-	struct page *page;
-	int rc = 0;
+	struct folio *folio;
+	int rc;
 
 	cifs_dbg(FYI, "write_begin from %lld len %d\n", (long long)pos, len);
 
-start:
-	page = grab_cache_page_write_begin(mapping, index, flags);
-	if (!page) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	if (PageUptodate(page))
-		goto out;
-
-	/*
-	 * If we write a full page it will be up to date, no need to read from
-	 * the server. If the write is short, we'll end up doing a sync write
-	 * instead.
+	/* Prefetch area to be written into the cache if we're caching this
+	 * file.  We need to do this before we get a lock on the page in case
+	 * there's more than one writer competing for the same cache block.
 	 */
-	if (len == PAGE_SIZE)
-		goto out;
+	rc = netfs_write_begin(file, mapping, pos, len, flags, &folio, fsdata);
+	if (rc < 0)
+		return rc;
 
+#if 0
 	/*
 	 * optimize away the read when we have an oplock, and we're not
 	 * expecting to use any of the data we'd be reading in. That
@@ -4210,34 +3667,17 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 					   offset + len,
 					   PAGE_SIZE);
 			/*
-			 * PageChecked means that the parts of the page
-			 * to which we're not writing are considered up
-			 * to date. Once the data is copied to the
-			 * page, it can be set uptodate.
+			 * Marking a folio checked means that the parts of the
+			 * page to which we're not writing are considered up to
+			 * date. Once the data is copied to the page, it can be
+			 * set uptodate.
 			 */
-			SetPageChecked(page);
+			folio_set_checked(folio);
 			goto out;
 		}
 	}
-
-	if ((file->f_flags & O_ACCMODE) != O_WRONLY && !oncethru) {
-		/*
-		 * might as well read a page, it is fast enough. If we get
-		 * an error, we don't need to return it. cifs_write_end will
-		 * do a sync write instead since PG_uptodate isn't set.
-		 */
-		cifs_readpage_worker(file, page, &page_start);
-		put_page(page);
-		oncethru = 1;
-		goto start;
-	} else {
-		/* we could try using another file handle if there is one -
-		   but how would we lock it to prevent close of that handle
-		   racing with this read? In any case
-		   this will be written out by write_end so is fine */
-	}
-out:
-	*pagep = page;
+#endif
+	*pagep = folio_page(folio, (pos - folio_pos(folio)) / PAGE_SIZE);
 	return rc;
 }
 
@@ -4429,8 +3869,8 @@ static int cifs_set_page_dirty(struct page *page)
 #endif
 
 const struct address_space_operations cifs_addr_ops = {
-	.readpage = cifs_readpage,
-	.readahead = cifs_readahead,
+	.readpage = netfs_readpage,
+	.readahead = netfs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
@@ -4455,7 +3895,7 @@ const struct address_space_operations cifs_addr_ops = {
  * to leave cifs_readpages out of the address space operations.
  */
 const struct address_space_operations cifs_addr_ops_smallbuf = {
-	.readpage = cifs_readpage,
+	.readpage = netfs_readpage,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index a7e7e5a97b7f..bb1c3a372de4 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -134,34 +134,3 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 		cifsi->netfs_ctx.cache = NULL;
 	}
 }
-
-/*
- * Retrieve a page from FS-Cache
- */
-int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
-		 __func__, cifs_inode_cookie(inode), page, inode);
-	return -ENOBUFS; // Needs conversion to using netfslib
-}
-
-/*
- * Retrieve a set of pages from FS-Cache
- */
-int __cifs_readpages_from_fscache(struct inode *inode,
-				struct address_space *mapping,
-				struct list_head *pages,
-				unsigned *nr_pages)
-{
-	cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
-		 __func__, cifs_inode_cookie(inode), *nr_pages, inode);
-	return -ENOBUFS; // Needs conversion to using netfslib
-}
-
-void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
-{
-	cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
-		 __func__, cifs_inode_cookie(inode), page, inode);
-
-	// Needs conversion to using netfslib
-}
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 9f6e42e85d14..fdc03cd7b881 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -58,14 +58,6 @@ void cifs_fscache_fill_coherency(struct inode *inode,
 }
 
 
-extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
-extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
-extern int __cifs_readpages_from_fscache(struct inode *,
-					 struct address_space *,
-					 struct list_head *,
-					 unsigned *);
-extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
-
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
 {
 	return netfs_i_cookie(inode);
@@ -80,33 +72,6 @@ static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags
 			   i_size_read(inode), flags);
 }
 
-static inline int cifs_readpage_from_fscache(struct inode *inode,
-					     struct page *page)
-{
-	if (cifs_inode_cookie(inode))
-		return __cifs_readpage_from_fscache(inode, page);
-
-	return -ENOBUFS;
-}
-
-static inline int cifs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	if (cifs_inode_cookie(inode))
-		return __cifs_readpages_from_fscache(inode, mapping, pages,
-						     nr_pages);
-	return -ENOBUFS;
-}
-
-static inline void cifs_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-	if (PageFsCache(page))
-		__cifs_readpage_to_fscache(inode, page);
-}
-
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -123,23 +88,6 @@ static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool upd
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
 
-static inline int
-cifs_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	return -ENOBUFS;
-}
-
-static inline int cifs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return -ENOBUFS;
-}
-
-static inline void cifs_readpage_to_fscache(struct inode *inode,
-			struct page *page) {}
-
 #endif /* CONFIG_CIFS_FSCACHE */
 
 #endif /* _CIFS_FSCACHE_H */
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 7d8b3ceb2af3..b6a9ded9fbb2 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -26,6 +26,19 @@
 #include "fs_context.h"
 #include "cifs_ioctl.h"
 
+/*
+ * Set parameters for the netfs library
+ */
+static void cifs_set_netfs_context(struct inode *inode)
+{
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+
+	netfs_i_context_init(inode, &cifs_req_ops);
+	ctx->rsize = cifs_sb->ctx->rsize;
+	ctx->wsize = cifs_sb->ctx->wsize;
+}
+
 static void cifs_set_ops(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -209,8 +222,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 
 	if (fattr->cf_flags & CIFS_FATTR_DFS_REFERRAL)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW)
+	if (inode->i_state & I_NEW) {
+		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
+	}
 	return 0;
 }
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index ebbea7526ee2..0d76cffb4e75 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -23,6 +23,7 @@
 #include <linux/uuid.h>
 #include <linux/pagemap.h>
 #include <linux/xattr.h>
+#include <linux/netfs.h>
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
@@ -4185,7 +4186,19 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     tcon->tid, tcon->ses->Suid,
 				     rdata->offset, rdata->got_bytes);
 
-	queue_work(cifsiod_wq, &rdata->work);
+	if (rdata->result == -ENODATA) {
+		/* We may have got an EOF error because fallocate
+		 * failed to enlarge the file.
+		 */
+		if (rdata->subreq->start < rdata->subreq->rreq->i_size)
+			rdata->result = 0;
+	}
+	if (rdata->result == 0 || rdata->result == -EAGAIN)
+		iov_iter_advance(&rdata->subreq->iter, rdata->got_bytes);
+	netfs_subreq_terminated(rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, false);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 	DeleteMidQEntry(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index df13c9b22ca8..1fa242140dc4 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -553,8 +553,13 @@ static void netfs_rreq_assess_dio(struct netfs_read_request *rreq)
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 		if (subreq->error || subreq->transferred == 0)
 			break;
-		for (i = 0; i < subreq->bv_count; i++)
+		for (i = 0; i < subreq->bv_count; i++) {
 			flush_dcache_page(subreq->bv[i].bv_page);
+			// TODO: cifs marks pages in the destination buffer
+			// dirty under some circumstances after a read.  Do we
+			// need to do that too?
+			set_page_dirty(subreq->bv[i].bv_page);
+		}
 		transferred += subreq->transferred;
 		if (subreq->transferred < subreq->len)
 			break;


