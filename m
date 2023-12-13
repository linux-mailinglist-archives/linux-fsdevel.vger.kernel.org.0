Return-Path: <linux-fsdevel+bounces-5967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40055811832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23B21F21DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E33A8C4;
	Wed, 13 Dec 2023 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3HNdbgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494282103
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702482177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0djqwLuCvlvk0OjBvb82pdPoghqse7MEdZOjK6ISxs=;
	b=I3HNdbgnp4S7aXmsQ2HHA9h2kH6K6Z4xWgyWUP/H6AxcaOzNt4vyapQL+C+2LPc80MV1f1
	YtsecORty9sRverUzhqxTO2ozbkVvgDKxzMjVgCGeo9YRuj6tDh7tEV9vstRXQxKEJOnC5
	csbXZxnBfzerQDBs2lsdh6fyrq2skoE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-v3le_z6KO_2iRd5i0VbGPg-1; Wed, 13 Dec 2023 10:42:51 -0500
X-MC-Unique: v3le_z6KO_2iRd5i0VbGPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBEF88350E6;
	Wed, 13 Dec 2023 15:42:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E980451E3;
	Wed, 13 Dec 2023 15:42:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v4 13/13] cifs: Remove some code that's no longer used, part 3
Date: Wed, 13 Dec 2023 15:41:39 +0000
Message-ID: <20231213154139.432922-14-dhowells@redhat.com>
In-Reply-To: <20231213154139.432922-1-dhowells@redhat.com>
References: <20231213154139.432922-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Remove some code that was #if'd out with the netfslib conversion.  This is
split into parts for file.c as the diff generator otherwise produces a hard
to read diff for part of it where a big chunk is cut out.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/file.c | 1003 ------------------------------------------
 1 file changed, 1003 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 7e51c2702cdb..ef97c1708a5b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2687,470 +2687,6 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	return rc;
 }
 
-#if 0 // TODO remove 3594
-static void collect_uncached_write_data(struct cifs_aio_ctx *ctx);
-
-static void
-cifs_uncached_writev_complete(struct work_struct *work)
-{
-	struct cifs_io_subrequest *wdata = container_of(work,
-					struct cifs_io_subrequest, work);
-	struct inode *inode = d_inode(wdata->cfile->dentry);
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-
-	spin_lock(&inode->i_lock);
-	cifs_update_eof(cifsi, wdata->subreq.start, wdata->subreq.len);
-	if (cifsi->netfs.remote_i_size > inode->i_size)
-		i_size_write(inode, cifsi->netfs.remote_i_size);
-	spin_unlock(&inode->i_lock);
-
-	complete(&wdata->done);
-	collect_uncached_write_data(wdata->ctx);
-	/* the below call can possibly free the last ref to aio ctx */
-	cifs_put_writedata(wdata);
-}
-
-static int
-cifs_resend_wdata(struct cifs_io_subrequest *wdata, struct list_head *wdata_list,
-	struct cifs_aio_ctx *ctx)
-{
-	size_t wsize;
-	struct cifs_credits credits;
-	int rc;
-	struct TCP_Server_Info *server = wdata->server;
-
-	do {
-		if (wdata->cfile->invalidHandle) {
-			rc = cifs_reopen_file(wdata->cfile, false);
-			if (rc == -EAGAIN)
-				continue;
-			else if (rc)
-				break;
-		}
-
-
-		/*
-		 * Wait for credits to resend this wdata.
-		 * Note: we are attempting to resend the whole wdata not in
-		 * segments
-		 */
-		do {
-			rc = server->ops->wait_mtu_credits(server, wdata->subreq.len,
-						&wsize, &credits);
-			if (rc)
-				goto fail;
-
-			if (wsize < wdata->subreq.len) {
-				add_credits_and_wake_if(server, &credits, 0);
-				msleep(1000);
-			}
-		} while (wsize < wdata->subreq.len);
-		wdata->credits = credits;
-
-		rc = adjust_credits(server, &wdata->credits, wdata->subreq.len);
-
-		if (!rc) {
-			if (wdata->cfile->invalidHandle)
-				rc = -EAGAIN;
-			else {
-#ifdef CONFIG_CIFS_SMB_DIRECT
-				if (wdata->mr) {
-					wdata->mr->need_invalidate = true;
-					smbd_deregister_mr(wdata->mr);
-					wdata->mr = NULL;
-				}
-#endif
-				rc = server->ops->async_writev(wdata);
-			}
-		}
-
-		/* If the write was successfully sent, we are done */
-		if (!rc) {
-			list_add_tail(&wdata->list, wdata_list);
-			return 0;
-		}
-
-		/* Roll back credits and retry if needed */
-		add_credits_and_wake_if(server, &wdata->credits, 0);
-	} while (rc == -EAGAIN);
-
-fail:
-	cifs_put_writedata(wdata);
-	return rc;
-}
-
-/*
- * Select span of a bvec iterator we're going to use.  Limit it by both maximum
- * size and maximum number of segments.
- */
-static size_t cifs_limit_bvec_subset(const struct iov_iter *iter, size_t max_size,
-				     size_t max_segs, unsigned int *_nsegs)
-{
-	const struct bio_vec *bvecs = iter->bvec;
-	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
-	size_t len, span = 0, n = iter->count;
-	size_t skip = iter->iov_offset;
-
-	if (WARN_ON(!iov_iter_is_bvec(iter)) || n == 0)
-		return 0;
-
-	while (n && ix < nbv && skip) {
-		len = bvecs[ix].bv_len;
-		if (skip < len)
-			break;
-		skip -= len;
-		n -= len;
-		ix++;
-	}
-
-	while (n && ix < nbv) {
-		len = min3(n, bvecs[ix].bv_len - skip, max_size);
-		span += len;
-		max_size -= len;
-		nsegs++;
-		ix++;
-		if (max_size == 0 || nsegs >= max_segs)
-			break;
-		skip = 0;
-		n -= len;
-	}
-
-	*_nsegs = nsegs;
-	return span;
-}
-
-static int
-cifs_write_from_iter(loff_t fpos, size_t len, struct iov_iter *from,
-		     struct cifsFileInfo *open_file,
-		     struct cifs_sb_info *cifs_sb, struct list_head *wdata_list,
-		     struct cifs_aio_ctx *ctx)
-{
-	int rc = 0;
-	size_t cur_len, max_len;
-	struct cifs_io_subrequest *wdata;
-	pid_t pid;
-	struct TCP_Server_Info *server;
-	unsigned int xid, max_segs = INT_MAX;
-
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = open_file->pid;
-	else
-		pid = current->tgid;
-
-	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
-	xid = get_xid();
-
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->smbd_conn)
-		max_segs = server->smbd_conn->max_frmr_depth;
-#endif
-
-	do {
-		struct cifs_credits credits_on_stack;
-		struct cifs_credits *credits = &credits_on_stack;
-		unsigned int nsegs = 0;
-		size_t wsize;
-
-		if (signal_pending(current)) {
-			rc = -EINTR;
-			break;
-		}
-
-		if (open_file->invalidHandle) {
-			rc = cifs_reopen_file(open_file, false);
-			if (rc == -EAGAIN)
-				continue;
-			else if (rc)
-				break;
-		}
-
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
-						   &wsize, credits);
-		if (rc)
-			break;
-
-		max_len = min_t(const size_t, len, wsize);
-		if (!max_len) {
-			rc = -EAGAIN;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		cur_len = cifs_limit_bvec_subset(from, max_len, max_segs, &nsegs);
-		cifs_dbg(FYI, "write_from_iter len=%zx/%zx nsegs=%u/%lu/%u\n",
-			 cur_len, max_len, nsegs, from->nr_segs, max_segs);
-		if (cur_len == 0) {
-			rc = -EIO;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		wdata = cifs_writedata_alloc(cifs_uncached_writev_complete);
-		if (!wdata) {
-			rc = -ENOMEM;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		wdata->uncached	= true;
-		wdata->sync_mode = WB_SYNC_ALL;
-		wdata->subreq.start	= (__u64)fpos;
-		wdata->cfile	= cifsFileInfo_get(open_file);
-		wdata->server	= server;
-		wdata->pid	= pid;
-		wdata->subreq.len	= cur_len;
-		wdata->credits	= credits_on_stack;
-		wdata->subreq.io_iter	= *from;
-		wdata->ctx	= ctx;
-		kref_get(&ctx->refcount);
-
-		iov_iter_truncate(&wdata->subreq.io_iter, cur_len);
-
-		rc = adjust_credits(server, &wdata->credits, wdata->subreq.len);
-
-		if (!rc) {
-			if (wdata->cfile->invalidHandle)
-				rc = -EAGAIN;
-			else
-				rc = server->ops->async_writev(wdata);
-		}
-
-		if (rc) {
-			add_credits_and_wake_if(server, &wdata->credits, 0);
-			cifs_put_writedata(wdata);
-			if (rc == -EAGAIN)
-				continue;
-			break;
-		}
-
-		list_add_tail(&wdata->list, wdata_list);
-		iov_iter_advance(from, cur_len);
-		fpos += cur_len;
-		len -= cur_len;
-	} while (len > 0);
-
-	free_xid(xid);
-	return rc;
-}
-
-static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
-{
-	struct cifs_io_subrequest *wdata, *tmp;
-	struct cifs_tcon *tcon;
-	struct cifs_sb_info *cifs_sb;
-	struct dentry *dentry = ctx->cfile->dentry;
-	ssize_t rc;
-
-	tcon = tlink_tcon(ctx->cfile->tlink);
-	cifs_sb = CIFS_SB(dentry->d_sb);
-
-	mutex_lock(&ctx->aio_mutex);
-
-	if (list_empty(&ctx->list)) {
-		mutex_unlock(&ctx->aio_mutex);
-		return;
-	}
-
-	rc = ctx->rc;
-	/*
-	 * Wait for and collect replies for any successful sends in order of
-	 * increasing offset. Once an error is hit, then return without waiting
-	 * for any more replies.
-	 */
-restart_loop:
-	list_for_each_entry_safe(wdata, tmp, &ctx->list, list) {
-		if (!rc) {
-			if (!try_wait_for_completion(&wdata->done)) {
-				mutex_unlock(&ctx->aio_mutex);
-				return;
-			}
-
-			if (wdata->result)
-				rc = wdata->result;
-			else
-				ctx->total_len += wdata->subreq.len;
-
-			/* resend call if it's a retryable error */
-			if (rc == -EAGAIN) {
-				struct list_head tmp_list;
-				struct iov_iter tmp_from = ctx->iter;
-
-				INIT_LIST_HEAD(&tmp_list);
-				list_del_init(&wdata->list);
-
-				if (ctx->direct_io)
-					rc = cifs_resend_wdata(
-						wdata, &tmp_list, ctx);
-				else {
-					iov_iter_advance(&tmp_from,
-						 wdata->subreq.start - ctx->pos);
-
-					rc = cifs_write_from_iter(wdata->subreq.start,
-						wdata->subreq.len, &tmp_from,
-						ctx->cfile, cifs_sb, &tmp_list,
-						ctx);
-
-					cifs_put_writedata(wdata);
-				}
-
-				list_splice(&tmp_list, &ctx->list);
-				goto restart_loop;
-			}
-		}
-		list_del_init(&wdata->list);
-		cifs_put_writedata(wdata);
-	}
-
-	cifs_stats_bytes_written(tcon, ctx->total_len);
-	set_bit(CIFS_INO_INVALID_MAPPING, &CIFS_I(dentry->d_inode)->flags);
-
-	ctx->rc = (rc == 0) ? ctx->total_len : rc;
-
-	mutex_unlock(&ctx->aio_mutex);
-
-	if (ctx->iocb && ctx->iocb->ki_complete)
-		ctx->iocb->ki_complete(ctx->iocb, ctx->rc);
-	else
-		complete(&ctx->done);
-}
-
-static ssize_t __cifs_writev(
-	struct kiocb *iocb, struct iov_iter *from, bool direct)
-{
-	struct file *file = iocb->ki_filp;
-	ssize_t total_written = 0;
-	struct cifsFileInfo *cfile;
-	struct cifs_tcon *tcon;
-	struct cifs_sb_info *cifs_sb;
-	struct cifs_aio_ctx *ctx;
-	int rc;
-
-	rc = generic_write_checks(iocb, from);
-	if (rc <= 0)
-		return rc;
-
-	cifs_sb = CIFS_FILE_SB(file);
-	cfile = file->private_data;
-	tcon = tlink_tcon(cfile->tlink);
-
-	if (!tcon->ses->server->ops->async_writev)
-		return -ENOSYS;
-
-	ctx = cifs_aio_ctx_alloc();
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->cfile = cifsFileInfo_get(cfile);
-
-	if (!is_sync_kiocb(iocb))
-		ctx->iocb = iocb;
-
-	ctx->pos = iocb->ki_pos;
-	ctx->direct_io = direct;
-	ctx->nr_pinned_pages = 0;
-
-	if (user_backed_iter(from)) {
-		/*
-		 * Extract IOVEC/UBUF-type iterators to a BVEC-type iterator as
-		 * they contain references to the calling process's virtual
-		 * memory layout which won't be available in an async worker
-		 * thread.  This also takes a pin on every folio involved.
-		 */
-		rc = netfs_extract_user_iter(from, iov_iter_count(from),
-					     &ctx->iter, 0);
-		if (rc < 0) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
-
-		ctx->nr_pinned_pages = rc;
-		ctx->bv = (void *)ctx->iter.bvec;
-		ctx->bv_need_unpin = iov_iter_extract_will_pin(from);
-	} else if ((iov_iter_is_bvec(from) || iov_iter_is_kvec(from)) &&
-		   !is_sync_kiocb(iocb)) {
-		/*
-		 * If the op is asynchronous, we need to copy the list attached
-		 * to a BVEC/KVEC-type iterator, but we assume that the storage
-		 * will be pinned by the caller; in any case, we may or may not
-		 * be able to pin the pages, so we don't try.
-		 */
-		ctx->bv = (void *)dup_iter(&ctx->iter, from, GFP_KERNEL);
-		if (!ctx->bv) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return -ENOMEM;
-		}
-	} else {
-		/*
-		 * Otherwise, we just pass the iterator down as-is and rely on
-		 * the caller to make sure the pages referred to by the
-		 * iterator don't evaporate.
-		 */
-		ctx->iter = *from;
-	}
-
-	ctx->len = iov_iter_count(&ctx->iter);
-
-	/* grab a lock here due to read response handlers can access ctx */
-	mutex_lock(&ctx->aio_mutex);
-
-	rc = cifs_write_from_iter(iocb->ki_pos, ctx->len, &ctx->iter,
-				  cfile, cifs_sb, &ctx->list, ctx);
-
-	/*
-	 * If at least one write was successfully sent, then discard any rc
-	 * value from the later writes. If the other write succeeds, then
-	 * we'll end up returning whatever was written. If it fails, then
-	 * we'll get a new rc value from that.
-	 */
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
-		total_written = ctx->total_len;
-		mutex_unlock(&ctx->aio_mutex);
-	} else {
-		rc = ctx->rc;
-		total_written = ctx->total_len;
-	}
-
-	kref_put(&ctx->refcount, cifs_aio_ctx_release);
-
-	if (unlikely(!total_written))
-		return rc;
-
-	iocb->ki_pos += total_written;
-	return total_written;
-}
-
-ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-
-	cifs_revalidate_mapping(file->f_inode);
-	return __cifs_writev(iocb, from, true);
-}
-
-ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
-{
-	return __cifs_writev(iocb, from, false);
-}
-#endif // TODO remove 3594
-
 static ssize_t
 cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -3239,450 +2775,6 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
-#if 0 // TODO remove 4143
-static struct cifs_io_subrequest *cifs_readdata_alloc(work_func_t complete)
-{
-	struct cifs_io_subrequest *rdata;
-
-	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
-	if (rdata) {
-		refcount_set(&rdata->subreq.ref, 1);
-		INIT_LIST_HEAD(&rdata->list);
-		init_completion(&rdata->done);
-		INIT_WORK(&rdata->work, complete);
-	}
-
-	return rdata;
-}
-
-void
-cifs_readdata_release(struct cifs_io_subrequest *rdata)
-{
-	if (rdata->ctx)
-		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (rdata->mr) {
-		smbd_deregister_mr(rdata->mr);
-		rdata->mr = NULL;
-	}
-#endif
-	if (rdata->cfile)
-		cifsFileInfo_put(rdata->cfile);
-
-	kfree(rdata);
-}
-
-static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
-
-static void
-cifs_uncached_readv_complete(struct work_struct *work)
-{
-	struct cifs_io_subrequest *rdata =
-		container_of(work, struct cifs_io_subrequest, work);
-
-	complete(&rdata->done);
-	collect_uncached_read_data(rdata->ctx);
-	/* the below call can possibly free the last ref to aio ctx */
-	cifs_put_readdata(rdata);
-}
-
-static int cifs_resend_rdata(struct cifs_io_subrequest *rdata,
-			struct list_head *rdata_list,
-			struct cifs_aio_ctx *ctx)
-{
-	size_t rsize;
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
-			rc = server->ops->wait_mtu_credits(server, rdata->subreq.len,
-						&rsize, &credits);
-
-			if (rc)
-				goto fail;
-
-			if (rsize < rdata->subreq.len) {
-				add_credits_and_wake_if(server, &credits, 0);
-				msleep(1000);
-			}
-		} while (rsize < rdata->subreq.len);
-		rdata->credits = credits;
-
-		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
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
-	cifs_put_readdata(rdata);
-	return rc;
-}
-
-static int
-cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
-		     struct cifs_sb_info *cifs_sb, struct list_head *rdata_list,
-		     struct cifs_aio_ctx *ctx)
-{
-	struct cifs_io_subrequest *rdata;
-	unsigned int nsegs, max_segs = INT_MAX;
-	struct cifs_credits credits_on_stack;
-	struct cifs_credits *credits = &credits_on_stack;
-	size_t cur_len, max_len, rsize;
-	int rc;
-	pid_t pid;
-	struct TCP_Server_Info *server;
-
-	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
-
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->smbd_conn)
-		max_segs = server->smbd_conn->max_frmr_depth;
-#endif
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
-		max_len = min_t(size_t, len, rsize);
-
-		cur_len = cifs_limit_bvec_subset(&ctx->iter, max_len,
-						 max_segs, &nsegs);
-		cifs_dbg(FYI, "read-to-iter len=%zx/%zx nsegs=%u/%lu/%u\n",
-			 cur_len, max_len, nsegs, ctx->iter.nr_segs, max_segs);
-		if (cur_len == 0) {
-			rc = -EIO;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
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
-		rdata->subreq.start	= fpos;
-		rdata->subreq.len	= cur_len;
-		rdata->pid	= pid;
-		rdata->credits	= credits_on_stack;
-		rdata->ctx	= ctx;
-		kref_get(&ctx->refcount);
-
-		rdata->subreq.io_iter = ctx->iter;
-		iov_iter_truncate(&rdata->subreq.io_iter, cur_len);
-
-		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
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
-			cifs_put_readdata(rdata);
-			if (rc == -EAGAIN)
-				continue;
-			break;
-		}
-
-		list_add_tail(&rdata->list, rdata_list);
-		iov_iter_advance(&ctx->iter, cur_len);
-		fpos += cur_len;
-		len -= cur_len;
-	} while (len > 0);
-
-	return rc;
-}
-
-static void
-collect_uncached_read_data(struct cifs_aio_ctx *ctx)
-{
-	struct cifs_io_subrequest *rdata, *tmp;
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
-						rdata->subreq.start + got_bytes,
-						rdata->subreq.len - got_bytes,
-						rdata->cfile, cifs_sb,
-						&tmp_list, ctx);
-
-					cifs_put_readdata(rdata);
-				}
-
-				list_splice(&tmp_list, &ctx->list);
-
-				goto again;
-			} else if (rdata->result)
-				rc = rdata->result;
-
-			/* if there was a short read -- discard anything left */
-			if (rdata->got_bytes && rdata->got_bytes < rdata->subreq.len)
-				rc = -ENODATA;
-
-			ctx->total_len += rdata->got_bytes;
-		}
-		list_del_init(&rdata->list);
-		cifs_put_readdata(rdata);
-	}
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
-	ctx->nr_pinned_pages = 0;
-
-	if (!is_sync_kiocb(iocb))
-		ctx->iocb = iocb;
-
-	if (user_backed_iter(to)) {
-		/*
-		 * Extract IOVEC/UBUF-type iterators to a BVEC-type iterator as
-		 * they contain references to the calling process's virtual
-		 * memory layout which won't be available in an async worker
-		 * thread.  This also takes a pin on every folio involved.
-		 */
-		rc = netfs_extract_user_iter(to, iov_iter_count(to),
-					     &ctx->iter, 0);
-		if (rc < 0) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
-
-		ctx->nr_pinned_pages = rc;
-		ctx->bv = (void *)ctx->iter.bvec;
-		ctx->bv_need_unpin = iov_iter_extract_will_pin(to);
-		ctx->should_dirty = true;
-	} else if ((iov_iter_is_bvec(to) || iov_iter_is_kvec(to)) &&
-		   !is_sync_kiocb(iocb)) {
-		/*
-		 * If the op is asynchronous, we need to copy the list attached
-		 * to a BVEC/KVEC-type iterator, but we assume that the storage
-		 * will be retained by the caller; in any case, we may or may
-		 * not be able to pin the pages, so we don't try.
-		 */
-		ctx->bv = (void *)dup_iter(&ctx->iter, to, GFP_KERNEL);
-		if (!ctx->bv) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return -ENOMEM;
-		}
-	} else {
-		/*
-		 * Otherwise, we just pass the iterator down as-is and rely on
-		 * the caller to make sure the pages referred to by the
-		 * iterator don't evaporate.
-		 */
-		ctx->iter = *to;
-	}
-
-	if (direct) {
-		rc = filemap_write_and_wait_range(file->f_inode->i_mapping,
-						  offset, offset + len - 1);
-		if (rc) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return -EAGAIN;
-		}
-	}
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
-
-}
-#endif // end netfslib removal 4143
-
 ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t rc;
@@ -3781,101 +2873,6 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	return rc;
 }
 
-#if 0 // TODO remove 4633
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
-#endif // end netfslib remove 4633
-
-
 static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 {
 	return netfs_page_mkwrite(vmf, NULL);


