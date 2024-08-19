Return-Path: <linux-fsdevel+bounces-26303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37329572EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CEA1F2246E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BBD531;
	Mon, 19 Aug 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgQe2op2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC318A926;
	Mon, 19 Aug 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091495; cv=none; b=KliS2Ex6DXxRtYu/gUuhkwNmKG+1PqvM/wZ3T5RBl92V6h3JWqm7xNXR2Tk7S7KAubw3vRlmd+oWGi5vUxbn/xWi+e7xfYU3nXhylqkYLCuecEl1OKw5uqbpiIZWY4POy0giGwL2ueb00npXYaR/iC7LVphLRUrfAZjTICOKVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091495; c=relaxed/simple;
	bh=SEQjq+EMrLZdi+P7R1Hxi2v99pg71dg3Qkmbh6w8g5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txx7wHP4qpXV08NPbG/BL/SkeHJ9fZXcEoR9VPbOl9MuXd371m3NjPZR5k3KEKbA/iNWMmJFPn+KDuZ+++eG7TQzu8Q9NiJ7MKA3JAYJdd3CxxD7Af+tH2HhhISHbkPSy+a10/90ZOhHIVd1d2OKZLUkitk7KqlW1Pz8aElcQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgQe2op2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C69C4AF0C;
	Mon, 19 Aug 2024 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091495;
	bh=SEQjq+EMrLZdi+P7R1Hxi2v99pg71dg3Qkmbh6w8g5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgQe2op2T6K7BgSdngLnoRPVaphjg/AIoKC191r7oFw6SSRj6quEM5FC2azqjL4Ca
	 nh2XTaPMGkHJFGVPnY7Xv3s/Ua2Eb6b32zCkoDpnDrIWI7v4vxadUjsCeejBpqNMd0
	 WQwH2tAqc0ijjCPeHZ02FzzRlHgrwkVCgk4UsZI/x7kYJaYUxckL/J1m1oAIuygj7z
	 GA3mZ2WpYHZsBuzVg/fAC54AmB4S0Ebez9xfjIQw+kRmz2pSxllNCu1erw+dh+NzOu
	 dxmPvUEU0RKwnaheR70b+Alzi+nzHtszP/QzuxGmHjV+6ylITcMZoLjs5E0aWMfjM8
	 CqDgk7WU3AF4A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 17/24] nfs/localio: use dedicated workqueues for filesystem read and write
Date: Mon, 19 Aug 2024 14:17:22 -0400
Message-ID: <20240819181750.70570-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
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
 fs/nfs/inode.c    | 57 ++++++++++++++++++++++------------
 fs/nfs/internal.h |  1 +
 fs/nfs/localio.c  | 79 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 95 insertions(+), 42 deletions(-)

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
index acb9d8bb4076..23f0d180fd19 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -439,6 +439,7 @@ int nfs_check_flags(int);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
+extern struct workqueue_struct *nfslocaliod_workqueue;
 extern struct inode *nfs_alloc_inode(struct super_block *sb);
 extern void nfs_free_inode(struct inode *);
 extern int nfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d6ec425bf6f0..2d3118005afc 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -255,30 +255,45 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 			status > 0 ? status : 0, hdr->res.eof);
 }
 
-static int
-nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_read(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	const struct cred *save_cred;
 	struct iov_iter iter;
 	ssize_t status;
 
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
+static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+			     const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
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
@@ -407,14 +422,39 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	nfs_local_pgio_done(hdr, status);
 }
 
-static int
-nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
-		const struct rpc_call_ops *call_ops)
+static void nfs_local_call_write(struct work_struct *work)
 {
-	struct nfs_local_kiocb *iocb;
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	unsigned long old_flags = current->flags;
+	const struct cred *save_cred;
 	struct iov_iter iter;
 	ssize_t status;
 
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
+static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+			      const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
@@ -422,7 +462,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
-	nfs_local_iter_init(&iter, iocb, WRITE);
 
 	switch (hdr->args.stable) {
 	default:
@@ -437,14 +476,8 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
 
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


