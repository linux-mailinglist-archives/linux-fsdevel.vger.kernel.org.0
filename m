Return-Path: <linux-fsdevel+bounces-27735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D874496377B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911C0281468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEEB839F7;
	Thu, 29 Aug 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5d4rrlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EC25763;
	Thu, 29 Aug 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893495; cv=none; b=Xt11Cgo7FpdZlytLFHa25hvzVyU/2Q66mMpxKNgFiNuTYoKT5RBHmAXj0dcYEpJBSDLVzqnLN5ktL5GW7Cz2srvOxS3A79eIXcMvyMUMEB2ZaK0s6ZZtoOgFh9F/tNukyBuRu+AZ/vs+zqutCy5KKyIi5BRnuoGFvm8aGojvJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893495; c=relaxed/simple;
	bh=3QQLBzZHdOH8OfsDqIVG1OYfzAJRF9Nl6g34NOlCPTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWhfBr3EWYpYJjbDFngSU+J+cpMAx4Uz1bF2GyWxaIblwtCVrEuf41kkWDz+lcwGJGdhdXLmZ2fVcy5IMxvOdcgZ9vtLCUIQtDKGdKXRDDeb0SUWjk0qHEnGJqa8JIHag62qXVQrCpM3BcpZ70zYb6h/9IfDzIcB6PPLQ+1DktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5d4rrlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48674C4CEC0;
	Thu, 29 Aug 2024 01:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893495;
	bh=3QQLBzZHdOH8OfsDqIVG1OYfzAJRF9Nl6g34NOlCPTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5d4rrlQKZSojpkUUO6EbFkYbeRDjIxLnz841naJsav7vOe5FMd26to11h0hVDCo8
	 Zb1UTee9aqQu9QfjtFwZVW5UmWfz8T6k7AU1rcvRojxCaLD+RBu81d77vLqr6zyCPZ
	 N6FU2ty0nWurnN1xr0Gs3SCK3sDd+VWmbTaOrrw0BBURc1unw3MUxMOtZwv/UQXt7l
	 6lKn6+mWqC414jxpsduV5I2qGNCkwzUjfPnHIdPQenLI6zj6VfIBDJz9cpScb3ZUeS
	 0bNUjf8l7y01l/P7bVhKmwp/df9Kyr1mBsdMGbRhdbGMpuN1IUu498Ubw1hD0YOU5n
	 aMcJ8kdb4ssoA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 22/25] nfs/localio: use dedicated workqueues for filesystem read and write
Date: Wed, 28 Aug 2024 21:04:17 -0400
Message-ID: <20240829010424.83693-23-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For localio access, don't call filesystem read() and write() routines
directly.  This solves two problems:

1) localio writes need to use a normal (non-memreclaim) unbound
   workqueue.  This avoids imposing new requirements on how underlying
   filesystems process frontend IO, which would cause a large amount
   of work to update all filesystems.  Without this change, when XFS
   starts getting low on space, XFS flushes work on a non-memreclaim
   work queue, which causes a priority inversion problem:

00573 workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM xfs-sync/vdc:xfs_flush_inodes_worker
00573 WARNING: CPU: 6 PID: 8525 at kernel/workqueue.c:3706 check_flush_dependency+0x2a4/0x328
00573 Modules linked in:
00573 CPU: 6 PID: 8525 Comm: kworker/u71:5 Not tainted 6.10.0-rc3-ktest-00032-g2b0a133403ab #18502
00573 Hardware name: linux,dummy-virt (DT)
00573 Workqueue: writeback wb_workfn (flush-0:33)
00573 pstate: 400010c5 (nZcv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
00573 pc : check_flush_dependency+0x2a4/0x328
00573 lr : check_flush_dependency+0x2a4/0x328
00573 sp : ffff0000c5f06bb0
00573 x29: ffff0000c5f06bb0 x28: ffff0000c998a908 x27: 1fffe00019331521
00573 x26: ffff0000d0620900 x25: ffff0000c5f06ca0 x24: ffff8000828848c0
00573 x23: 1fffe00018be0d8e x22: ffff0000c1210000 x21: ffff0000c75fde00
00573 x20: ffff800080bfd258 x19: ffff0000cad63400 x18: ffff0000cd3a4810
00573 x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080508d98
00573 x14: 0000000000000000 x13: 204d49414c434552 x12: 1fffe0001b6eeab2
00573 x11: ffff60001b6eeab2 x10: dfff800000000000 x9 : ffff60001b6eeab3
00573 x8 : 0000000000000001 x7 : 00009fffe491154e x6 : ffff0000db775593
00573 x5 : ffff0000db775590 x4 : ffff0000db775590 x3 : 0000000000000000
00573 x2 : 0000000000000027 x1 : ffff600018be0d62 x0 : dfff800000000000
00573 Call trace:
00573  check_flush_dependency+0x2a4/0x328
00573  __flush_work+0x184/0x5c8
00573  flush_work+0x18/0x28
00573  xfs_flush_inodes+0x68/0x88
00573  xfs_file_buffered_write+0x128/0x6f0
00573  xfs_file_write_iter+0x358/0x448
00573  nfs_local_doio+0x854/0x1568
00573  nfs_initiate_pgio+0x214/0x418
00573  nfs_generic_pg_pgios+0x304/0x480
00573  nfs_pageio_doio+0xe8/0x240
00573  nfs_pageio_complete+0x160/0x480
00573  nfs_writepages+0x300/0x4f0
00573  do_writepages+0x12c/0x4a0
00573  __writeback_single_inode+0xd4/0xa68
00573  writeback_sb_inodes+0x470/0xcb0
00573  __writeback_inodes_wb+0xb0/0x1d0
00573  wb_writeback+0x594/0x808
00573  wb_workfn+0x5e8/0x9e0
00573  process_scheduled_works+0x53c/0xd90
00573  worker_thread+0x370/0x8c8
00573  kthread+0x258/0x2e8
00573  ret_from_fork+0x10/0x20

2) Some filesystem writeback routines can end up taking up a lot of
   stack space (particularly XFS).  Instead of risking running over
   due to the extra overhead from the NFS stack, we should just call
   these routines from a workqueue job.  Since we need to do this to
   address 1) above we're able to avoid possibly blowing the stack
   "for free".

Use of dedicated workqueues improves performance over using the
system_unbound_wq.

Also, the creds used to open the file are used to override_creds() in
both nfs_local_call_read() and nfs_local_call_write() -- otherwise the
workqueue could have elevated capabilities (which the caller may not).

Lastly, care is taken to set PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO in
nfs_do_local_write() to avoid writeback deadlocks.

The PF_LOCAL_THROTTLE flag prevents deadlocks in balance_dirty_pages()
by causing writes to only be throttled against other writes to the
same bdi (it keeps the throttling local).  Normally all writes to
bdi(s) are throttled equally (after throughput factors are allowed
for).

The PF_MEMALLOC_NOIO flag prevents the lower filesystem IO from
causing memory reclaim to re-enter filesystems or IO devices and so
prevents deadlocks from occuring where IO that cleans pages is
waiting on IO to complete.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de> # eliminated wait_for_completion
---
 fs/nfs/inode.c    | 57 +++++++++++++++++++++++------------
 fs/nfs/internal.h |  1 +
 fs/nfs/localio.c  | 75 ++++++++++++++++++++++++++++++++++-------------
 3 files changed, 93 insertions(+), 40 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4914a11c3c2..542c7d97b235 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2461,35 +2461,54 @@ static void nfs_destroy_inodecache(void)
 	kmem_cache_destroy(nfs_inode_cachep);
 }
 
+struct workqueue_struct *nfslocaliod_workqueue;
 struct workqueue_struct *nfsiod_workqueue;
 EXPORT_SYMBOL_GPL(nfsiod_workqueue);
 
 /*
- * start up the nfsiod workqueue
- */
-static int nfsiod_start(void)
-{
-	struct workqueue_struct *wq;
-	dprintk("RPC:       creating workqueue nfsiod\n");
-	wq = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	if (wq == NULL)
-		return -ENOMEM;
-	nfsiod_workqueue = wq;
-	return 0;
-}
-
-/*
- * Destroy the nfsiod workqueue
+ * Destroy the nfsiod workqueues
  */
 static void nfsiod_stop(void)
 {
 	struct workqueue_struct *wq;
 
 	wq = nfsiod_workqueue;
-	if (wq == NULL)
-		return;
-	nfsiod_workqueue = NULL;
-	destroy_workqueue(wq);
+	if (wq != NULL) {
+		nfsiod_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	wq = nfslocaliod_workqueue;
+	if (wq != NULL) {
+		nfslocaliod_workqueue = NULL;
+		destroy_workqueue(wq);
+	}
+#endif /* CONFIG_NFS_LOCALIO */
+}
+
+/*
+ * Start the nfsiod workqueues
+ */
+static int nfsiod_start(void)
+{
+	dprintk("RPC:       creating workqueue nfsiod\n");
+	nfsiod_workqueue = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (nfsiod_workqueue == NULL)
+		return -ENOMEM;
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/*
+	 * localio writes need to use a normal (non-memreclaim) workqueue.
+	 * When we start getting low on space, XFS goes and calls flush_work() on
+	 * a non-memreclaim work queue, which causes a priority inversion problem.
+	 */
+	dprintk("RPC:       creating workqueue nfslocaliod\n");
+	nfslocaliod_workqueue = alloc_workqueue("nfslocaliod", WQ_UNBOUND, 0);
+	if (unlikely(nfslocaliod_workqueue == NULL)) {
+		nfsiod_stop();
+		return -ENOMEM;
+	}
+#endif /* CONFIG_NFS_LOCALIO */
+	return 0;
 }
 
 unsigned int nfs_net_id;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0716c90eaf9c..cc7e6f466dc9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -440,6 +440,7 @@ int nfs_check_flags(int);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
+extern struct workqueue_struct *nfslocaliod_workqueue;
 extern struct inode *nfs_alloc_inode(struct super_block *sb);
 extern void nfs_free_inode(struct inode *);
 extern int nfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 96e04328adb9..fa598b99941a 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -268,15 +268,34 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 			status > 0 ? status : 0, hdr->res.eof);
 }
 
+static void nfs_local_call_read(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	const struct cred *save_cred;
+	struct iov_iter iter;
+	ssize_t status;
+
+	save_cred = override_creds(filp->f_cred);
+
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_read_done(iocb, status);
+	nfs_local_pgio_release(iocb);
+
+	revert_creds(save_cred);
+}
+
 static int
 nfs_do_local_read(struct nfs_pgio_header *hdr,
 		  struct nfs_localio_ctx *localio,
 		  const struct rpc_call_ops *call_ops)
 {
-	struct file *filp = nfs_to.nfsd_file_file(localio->nf);
 	struct nfs_local_kiocb *iocb;
-	struct iov_iter iter;
-	ssize_t status;
 
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
@@ -284,16 +303,12 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, READ);
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
-	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_read_done(iocb, status);
-	nfs_local_pgio_release(iocb);
+	INIT_WORK(&iocb->work, nfs_local_call_read);
+	queue_work(nfslocaliod_workqueue, &iocb->work);
 
 	return 0;
 }
@@ -421,15 +436,40 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	nfs_local_pgio_done(hdr, status);
 }
 
+static void nfs_local_call_write(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	unsigned long old_flags = current->flags;
+	const struct cred *save_cred;
+	struct iov_iter iter;
+	ssize_t status;
+
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+	save_cred = override_creds(filp->f_cred);
+
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	WARN_ON_ONCE(status == -EIOCBQUEUED);
+
+	nfs_local_write_done(iocb, status);
+	nfs_local_vfs_getattr(iocb);
+	nfs_local_pgio_release(iocb);
+
+	revert_creds(save_cred);
+	current->flags = old_flags;
+}
+
 static int
 nfs_do_local_write(struct nfs_pgio_header *hdr,
 		   struct nfs_localio_ctx *localio,
 		   const struct rpc_call_ops *call_ops)
 {
-	struct file *filp = nfs_to.nfsd_file_file(localio->nf);
 	struct nfs_local_kiocb *iocb;
-	struct iov_iter iter;
-	ssize_t status;
 
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
@@ -438,7 +478,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, WRITE);
 
 	switch (hdr->args.stable) {
 	default:
@@ -453,14 +492,8 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
-	file_start_write(filp);
-	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
-	file_end_write(filp);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_write_done(iocb, status);
-	nfs_local_vfs_getattr(iocb);
-	nfs_local_pgio_release(iocb);
+	INIT_WORK(&iocb->work, nfs_local_call_write);
+	queue_work(nfslocaliod_workqueue, &iocb->work);
 
 	return 0;
 }
-- 
2.44.0


