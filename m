Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE384F6E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiDFXGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiDFXGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD21333E38
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0L8Ceoa0jxhzve7DJUig5Pw+XifSLnkhAswEh4LVRzw=;
        b=VgcPvdGfwMppAdjwxGq/YSOG/u+oE5NLFKfl1e1uhh+hPctONyrf99pzD1D326Gal6YVA4
        OpuQakcZVGsWSuwYiSwH99PLWXdQgoLi6PoA0BoFf3+AbNxLoFNl8lRrvQMMcyRcWtdsWt
        IQllL7gHX7ODEk9Ud+P1RJCcIkYx2Pc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-xr6Y455lPFm_OX4uoRLnvw-1; Wed, 06 Apr 2022 19:04:02 -0400
X-MC-Unique: xr6Y455lPFm_OX4uoRLnvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE62329AB3E0;
        Wed,  6 Apr 2022 23:04:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AADEA2026985;
        Wed,  6 Apr 2022 23:03:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/14] cifs: Use netfslib to handle reads
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:03:45 +0100
Message-ID: <164928622550.457102.17775997910940658055.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the cifs filesystem use netfslib to handle both buffered and direct
reads and alo to handle the preloading of pages to be modified.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/Kconfig    |    1 
 fs/cifs/cifsfs.c   |    6 
 fs/cifs/cifsfs.h   |    3 
 fs/cifs/cifsglob.h |    6 
 fs/cifs/cifssmb.c  |    9 -
 fs/cifs/file.c     |  918 ++++++++--------------------------------------------
 fs/cifs/fscache.c  |  117 -------
 fs/cifs/fscache.h  |   70 ----
 fs/cifs/inode.c    |   16 +
 fs/cifs/smb2pdu.c  |   15 +
 fs/netfs/io.c      |    7 
 11 files changed, 195 insertions(+), 973 deletions(-)

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
index fb60b5410789..b33f5eb3233c 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -945,7 +945,7 @@ cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return cifs_user_readv(iocb, iter);
+		return netfs_direct_read_iter(iocb, iter);
 
 	rc = cifs_revalidate_mapping(inode);
 	if (rc)
@@ -1323,7 +1323,7 @@ const struct file_operations cifs_file_strict_ops = {
 };
 
 const struct file_operations cifs_file_direct_ops = {
-	.read_iter = cifs_direct_readv,
+	.read_iter = netfs_direct_read_iter,
 	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
@@ -1379,7 +1379,7 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
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
index 06e0dd2c408d..e7db00396391 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1315,18 +1315,14 @@ struct cifs_aio_ctx {
 
 /* asynchronous read support */
 struct cifs_readdata {
+	struct netfs_io_subrequest	*subreq;
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
index 1256cafe08b1..5956caaec0e3 100644
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
index aa72be9dcf4e..200280be064d 100644
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
@@ -3326,12 +3327,8 @@ static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
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
@@ -3342,8 +3339,6 @@ cifs_readdata_release(struct kref *refcount)
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
 
-	if (rdata->ctx)
-		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
@@ -3356,375 +3351,6 @@ cifs_readdata_release(struct kref *refcount)
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
-		if (cifs_sb->ctx->rsize == 0)
-			cifs_sb->ctx->rsize =
-				server->ops->negotiate_rsize(tlink_tcon(open_file->tlink),
-							     cifs_sb->ctx);
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
@@ -3745,12 +3371,15 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3759,104 +3388,16 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
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
@@ -3926,278 +3467,161 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 /*
- * Unlock a bunch of folios in the pagecache.
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
  */
-static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgoff_t last)
+static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 {
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
-{
-	struct cifsFileInfo *open_file = ractl->file->private_data;
-	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct TCP_Server_Info *server;
-	unsigned int xid, nr_pages, last_batch_size = 0, cache_nr_pages = 0;
-	pgoff_t next_cached = ULONG_MAX;
-	bool caching = fscache_cookie_enabled(cifs_inode_cookie(ractl->mapping->host)) &&
-		cifs_inode_cookie(ractl->mapping->host)->cache_priv;
-	bool check_cache = caching;
+	struct cifs_readdata *rdata;
+	struct cifsFileInfo *open_file = rreq->netfs_priv;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	struct cifs_credits credits_on_stack, *credits = &credits_on_stack;
+	unsigned int xid;
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
-	while ((nr_pages = readahead_count(ractl) - last_batch_size)) {
-		unsigned int i, rsize;
-		struct page *page;
-		struct cifs_readdata *rdata;
-		struct cifs_credits credits_on_stack;
-		struct cifs_credits *credits = &credits_on_stack;
-		pgoff_t index = readahead_index(ractl) + last_batch_size;
-
-		/*
-		 * Find out if we have anything cached in the range of
-		 * interest, and if so, where the next chunk of cached data is.
-		 */
-		if (caching) {
-			if (check_cache) {
-				rc = cifs_fscache_query_occupancy(
-					ractl->mapping->host, index, nr_pages,
-					&next_cached, &cache_nr_pages);
-				if (rc < 0)
-					caching = false;
-				check_cache = false;
-			}
-
-			if (index == next_cached) {
-				/*
-				 * TODO: Send a whole batch of pages to be read
-				 * by the cache.
-				 */
-				page = readahead_page(ractl);
-				last_batch_size = 1 << thp_order(page);
-				if (cifs_readpage_from_fscache(ractl->mapping->host,
-							       page) < 0) {
-					/*
-					 * TODO: Deal with cache read failure
-					 * here, but for the moment, delegate
-					 * that to readpage.
-					 */
-					caching = false;
-				}
-				unlock_page(page);
-				next_cached++;
-				cache_nr_pages--;
-				if (cache_nr_pages == 0)
-					check_cache = true;
-				continue;
-			}
-		}
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
-		if (cifs_sb->ctx->rsize == 0)
-			cifs_sb->ctx->rsize =
-				server->ops->negotiate_rsize(tlink_tcon(open_file->tlink),
-							     cifs_sb->ctx);
-
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-						   &rsize, credits);
+		} while (rc == -EAGAIN);
 		if (rc)
-			break;
-		nr_pages = min_t(size_t, rsize / PAGE_SIZE, readahead_count(ractl));
-		nr_pages = min_t(size_t, nr_pages, next_cached - index);
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
+			goto out;
+	}
 
-		rdata = cifs_readdata_alloc(cifs_readahead_complete);
-		if (!rdata) {
-			/* best to give up if we're out of mem */
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+	if (cifs_sb->ctx->rsize == 0)
+		cifs_sb->ctx->rsize =
+			server->ops->negotiate_rsize(tlink_tcon(open_file->tlink),
+						     cifs_sb->ctx);
 
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
-
-		if (rc) {
-			add_credits_and_wake_if(server, &rdata->credits, 0);
-			cifs_unlock_folios(rdata->mapping,
-					   rdata->offset / PAGE_SIZE,
-					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
-			/* Fallback to the readpage in error/reconnect cases */
-			kref_put(&rdata->refcount, cifs_readdata_release);
-			break;
-		}
+	rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+	if (!rc) {
+		if (rdata->cfile->invalidHandle)
+			rc = -EAGAIN;
+		else
+			rc = server->ops->async_readv(rdata);
+	}
 
+	if (rc) {
+		add_credits_and_wake_if(server, &rdata->credits, 0);
+		/* Fallback to the readpage in error/reconnect cases */
 		kref_put(&rdata->refcount, cifs_readdata_release);
-		last_batch_size = ractl->_batch_count;
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
+static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
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
+static void cifs_expand_readahead(struct netfs_io_request *rreq)
 {
-	char *read_data;
-	int rc;
-
-	/* Is the page cached? */
-	rc = cifs_readpage_from_fscache(file_inode(file), page);
-	if (rc == 0)
-		goto read_complete;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	unsigned int rsize = cifs_sb->ctx->rsize;
+	loff_t misalignment, i_size = i_size_read(rreq->inode);
 
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
-
-	if (PAGE_SIZE > rc)
-		memset(read_data + rc, 0, PAGE_SIZE - rc);
+		rsize = ((unsigned int)INT_MAX + 1) / 2;
 
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
+static void cifs_rreq_done(struct netfs_io_request *rreq)
 {
-	loff_t offset = page_file_offset(page);
-	int rc = -EACCES;
-	unsigned int xid;
-
-	xid = get_xid();
-
-	if (file->private_data == NULL) {
-		rc = -EBADF;
-		free_xid(xid);
-		return rc;
-	}
+	struct inode *inode = rreq->inode;
 
-	cifs_dbg(FYI, "readpage %p at offset %d 0x%x\n",
-		 page, (int)offset, (int)offset);
+	/* we do not want atime to be less than mtime, it broke some apps */
+	inode->i_atime = current_time(inode);
+	if (timespec64_compare(&inode->i_atime, &inode->i_mtime))
+		inode->i_atime = inode->i_mtime;
+	else
+		inode->i_atime = current_time(inode);
+}
 
-	rc = cifs_readpage_worker(file, page, &offset);
+static int cifs_begin_cache_operation(struct netfs_io_request *rreq)
+{
+#ifdef CONFIG_CIFS_FSCACHE
+	struct fscache_cookie *cookie = cifs_inode_cookie(rreq->inode);
 
-	free_xid(xid);
-	return rc;
+	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
+#else
+	return -ENOBUFS;
+#endif
 }
 
+const struct netfs_request_ops cifs_req_ops = {
+	.init_request		= cifs_init_request,
+	.begin_cache_operation	= cifs_begin_cache_operation,
+	.expand_readahead	= cifs_expand_readahead,
+	.issue_read		= cifs_req_issue_read,
+	.done			= cifs_rreq_done,
+};
+
 static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
 {
 	struct cifsFileInfo *open_file;
@@ -4247,34 +3671,20 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
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
@@ -4289,56 +3699,20 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
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
 
-static int cifs_release_page(struct page *page, gfp_t gfp)
-{
-	if (PagePrivate(page))
-		return 0;
-	if (PageFsCache(page)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		wait_on_page_fscache(page);
-	}
-	fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
-	return true;
-}
-
-static void cifs_invalidate_folio(struct folio *folio, size_t offset,
-				 size_t length)
-{
-	folio_wait_fscache(folio);
-}
-
 static int cifs_launder_folio(struct folio *folio)
 {
 	int rc = 0;
@@ -4528,16 +3902,16 @@ static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
 #endif
 
 const struct address_space_operations cifs_addr_ops = {
-	.readpage = cifs_readpage,
-	.readahead = cifs_readahead,
+	.readpage = netfs_readpage,
+	.readahead = netfs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
+	.releasepage = netfs_releasepage,
 	.direct_IO = cifs_direct_io,
-	.invalidate_folio = cifs_invalidate_folio,
+	.invalidate_folio = netfs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
 	/*
 	 * TODO: investigate and if useful we could add an cifs_migratePage
@@ -4554,13 +3928,13 @@ const struct address_space_operations cifs_addr_ops = {
  * to leave cifs_readpages out of the address space operations.
  */
 const struct address_space_operations cifs_addr_ops_smallbuf = {
-	.readpage = cifs_readpage,
+	.readpage = netfs_readpage,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
-	.invalidate_folio = cifs_invalidate_folio,
+	.releasepage = netfs_releasepage,
+	.invalidate_folio = netfs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
 };
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index a638b29e9062..bb1c3a372de4 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -134,120 +134,3 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 		cifsi->netfs_ctx.cache = NULL;
 	}
 }
-
-/*
- * Fallback page reading interface.
- */
-static int fscache_fallback_read_page(struct inode *inode, struct page *page)
-{
-	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	int ret;
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = fscache_begin_read_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
-			   NULL, NULL);
-	fscache_end_operation(&cres);
-	return ret;
-}
-
-/*
- * Fallback page writing interface.
- */
-static int fscache_fallback_write_page(struct inode *inode, struct page *page,
-				       bool no_space_allocated_yet)
-{
-	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
-	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	loff_t start = page_offset(page);
-	size_t len = PAGE_SIZE;
-	int ret;
-
-	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
-
-	ret = fscache_begin_write_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
-				      no_space_allocated_yet);
-	if (ret == 0)
-		ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
-	fscache_end_operation(&cres);
-	return ret;
-}
-
-/*
- * Retrieve a page from FS-Cache
- */
-int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	int ret;
-
-	cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
-		 __func__, cifs_inode_cookie(inode), page, inode);
-
-	ret = fscache_fallback_read_page(inode, page);
-	if (ret < 0)
-		return ret;
-
-	/* Read completed synchronously */
-	SetPageUptodate(page);
-	return 0;
-}
-
-void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
-{
-	cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
-		 __func__, cifs_inode_cookie(inode), page, inode);
-
-	fscache_fallback_write_page(inode, page, true);
-}
-
-/*
- * Query the cache occupancy.
- */
-int __cifs_fscache_query_occupancy(struct inode *inode,
-				   pgoff_t first, unsigned int nr_pages,
-				   pgoff_t *_data_first,
-				   unsigned int *_data_nr_pages)
-{
-	struct netfs_cache_resources cres;
-	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
-	loff_t start, data_start;
-	size_t len, data_len;
-	int ret;
-
-	ret = fscache_begin_read_operation(&cres, cookie);
-	if (ret < 0)
-		return ret;
-
-	start = first * PAGE_SIZE;
-	len = nr_pages * PAGE_SIZE;
-	ret = cres.ops->query_occupancy(&cres, start, len, PAGE_SIZE,
-					&data_start, &data_len);
-	if (ret == 0) {
-		*_data_first = data_start / PAGE_SIZE;
-		*_data_nr_pages = len / PAGE_SIZE;
-	}
-
-	fscache_end_operation(&cres);
-	return ret;
-}
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 52355c0912ae..db863e757f7a 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -73,52 +73,6 @@ static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags
 			   i_size_read(inode), flags);
 }
 
-extern int __cifs_fscache_query_occupancy(struct inode *inode,
-					  pgoff_t first, unsigned int nr_pages,
-					  pgoff_t *_data_first,
-					  unsigned int *_data_nr_pages);
-
-static inline int cifs_fscache_query_occupancy(struct inode *inode,
-					       pgoff_t first, unsigned int nr_pages,
-					       pgoff_t *_data_first,
-					       unsigned int *_data_nr_pages)
-{
-	if (!cifs_inode_cookie(inode))
-		return -ENOBUFS;
-	return __cifs_fscache_query_occupancy(inode, first, nr_pages,
-					      _data_first, _data_nr_pages);
-}
-
-extern int __cifs_readpage_from_fscache(struct inode *pinode, struct page *ppage);
-extern void __cifs_readpage_to_fscache(struct inode *pinode, struct page *ppage);
-
-
-static inline int cifs_readpage_from_fscache(struct inode *inode,
-					     struct page *page)
-{
-	if (cifs_inode_cookie(inode))
-		return __cifs_readpage_from_fscache(inode, page);
-	return -ENOBUFS;
-}
-
-static inline void cifs_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-	if (cifs_inode_cookie(inode))
-		__cifs_readpage_to_fscache(inode, page);
-}
-
-static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		wait_on_page_fscache(page);
-		fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
-	}
-	return true;
-}
-
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -135,30 +89,6 @@ static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool upd
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
 
-static inline int cifs_fscache_query_occupancy(struct inode *inode,
-					       pgoff_t first, unsigned int nr_pages,
-					       pgoff_t *_data_first,
-					       unsigned int *_data_nr_pages)
-{
-	*_data_first = ULONG_MAX;
-	*_data_nr_pages = 0;
-	return -ENOBUFS;
-}
-
-static inline int
-cifs_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	return -ENOBUFS;
-}
-
-static inline
-void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
-
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return true; /* May release page */
-}
-
 #endif /* CONFIG_CIFS_FSCACHE */
 
 #endif /* _CIFS_FSCACHE_H */
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 2f9e7d2f81b6..40c6f04f7521 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -26,6 +26,18 @@
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
+}
+
 static void cifs_set_ops(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -213,8 +225,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 
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
index 6bb9a90b018f..19ad6c89121a 100644
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
@@ -4182,7 +4183,19 @@ smb2_readv_callback(struct mid_q_entry *mid)
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
+				rdata->got_bytes : rdata->result, true);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 	DeleteMidQEntry(mid);
 	add_credits(server, &credits, 0);
 }
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index aaaafc3e1601..a39f07c3758b 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -324,8 +324,13 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 	unsigned int i;
 	size_t transferred = 0;
 
-	for (i = 0; i < rreq->direct_bv_count; i++)
+	for (i = 0; i < rreq->direct_bv_count; i++) {
 		flush_dcache_page(rreq->direct_bv[i].bv_page);
+		// TODO: cifs marks pages in the destination buffer
+		// dirty under some circumstances after a read.  Do we
+		// need to do that too?
+		set_page_dirty(rreq->direct_bv[i].bv_page);
+	}
 
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 		if (subreq->error || subreq->transferred == 0)


