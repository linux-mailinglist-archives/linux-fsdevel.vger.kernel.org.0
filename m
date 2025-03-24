Return-Path: <linux-fsdevel+bounces-44924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E107A6E65A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50365174D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D71F4CB6;
	Mon, 24 Mar 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0NPt46n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB891F4736
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853718; cv=none; b=If6jiK6jGY2xSBGwaDTSVc3JJgSYJWW14maFSbinHSL69NKZVhGuc93+9ww4UUPXHf+e6J3co1owoxtIhRjnz7GNfZNFes6G1cKGY4O1VPv5l6i+8p4zZBQybOpjYVzFGZjIYIDRIqI6+0ccnUMgJSp+rZC4GmVSHwnmBLUbuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853718; c=relaxed/simple;
	bh=0Vif7nQgMkWvMZedGbS1nUvu236o7oBNvlr0UAYTD+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kzhVPsPH3mclrsKFFJsxxQKMalBI0+KTCu4tmoRvdBhvd+5NrvoEXljvaKpH98EIifqfKQR9L4w6E9/Xc5sXgEkfda1ZhXNQh7AVtHHzNR+gSnseRNOx0cgMbzJTIpwjHOmznhn64Zr7osP4raGKWTg8Jv/qXAry6liKt+N6YBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0NPt46n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D96C4CEEE;
	Mon, 24 Mar 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853717;
	bh=0Vif7nQgMkWvMZedGbS1nUvu236o7oBNvlr0UAYTD+E=;
	h=Date:From:To:Cc:Subject:From;
	b=V0NPt46nFDWJYlx6AJWLVnkmGWH2bdOCGVYyp6Nm7WD7IoERE9XLqAVlxDnqguJLL
	 ETKKEpenjIExigymh4QTc5rblHANZuecJp0nVlrdW4UWEmRgwmur7oVZ7uBRM717dx
	 atxAS3j4TAhqQPj87DG/UlQGLtY7lQ9epRKz9KolSiHc9XK4X5bKevv9LzDRpncVhM
	 c4RdaXTGPuk1GJWRvMcQ2UczoFU0CiVNyg769C8U+9KKoKCIMpepxjjO/e0291mqMB
	 8kV97QoPRpiLcs6KI8a1w+3RvJRkH/TTS7noRb+5ZPTwRS20jGuvBEtyzQj1+VyU1u
	 ntxZCm61mBqEQ==
Date: Mon, 24 Mar 2025 15:01:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Subject: fs freeze stuff
Message-ID: <Z-HWVCJOPq9rGIEL@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applying the following cocci file still yields more work:

@ has_freeze_fs @
identifier super_ops;
expression freeze_op;
@@

struct super_operations super_ops = {
.freeze_fs = freeze_op,
};

@ remove_set_freezable depends on has_freeze_fs @
expression time;
statement S, S2;
expression task, current;
@@

(
-       set_freezable();
|
-       if (try_to_freeze())
-               continue;
|
-       try_to_freeze();
|
-       freezable_schedule();
+       schedule();
|
-       freezable_schedule_timeout(time);
+       schedule_timeout(time);
|
-       if (freezing(task)) { S }
|
-       if (freezing(task)) { S }
-       else
	    { S2 }
|
-       freezing(current)
)

@ remove_wq_freezable @
expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
identifier fs_wq_fn;
@@

(
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE,
+                              WQ_ARG2,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
+                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
			   ...);
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE
+               WQ_ARG1
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
+               WQ_ARG1 | WQ_ARG3
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
+               WQ_ARG2 | WQ_ARG3
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2
+               WQ_ARG2
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE
+               0
    )
)

diff -u -p a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2659,7 +2659,7 @@ static int anx7625_i2c_probe(struct i2c_
 	if (platform->pdata.intp_irq) {
 		INIT_WORK(&platform->work, anx7625_work_func);
 		platform->workqueue = alloc_workqueue("anx7625_work",
-						      WQ_FREEZABLE | WQ_MEM_RECLAIM, 1);
+						      WQ_MEM_RECLAIM, 1);
 		if (!platform->workqueue) {
 			DRM_DEV_ERROR(dev, "fail to create work queue\n");
 			ret = -ENOMEM;
diff -u -p a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1365,7 +1365,7 @@ static int mcp251x_can_probe(struct spi_
 	if (ret)
 		goto out_clk;
 
-	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+	priv->wq = alloc_workqueue("mcp251x_wq", WQ_MEM_RECLAIM,
 				   0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
diff -u -p a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1516,7 +1516,6 @@ static int anx7411_i2c_probe(struct i2c_
 
 	INIT_WORK(&plat->work, anx7411_work_func);
 	plat->workqueue = alloc_workqueue("anx7411_work",
-					  WQ_FREEZABLE |
 					  WQ_MEM_RECLAIM,
 					  1);
 	if (!plat->workqueue) {
diff -u -p a/fs/gfs2/main.c b/fs/gfs2/main.c
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -151,12 +151,12 @@ static int __init init_gfs2_fs(void)
 
 	error = -ENOMEM;
 	gfs2_recovery_wq = alloc_workqueue("gfs2_recovery",
-					  WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+					  WQ_MEM_RECLAIM, 0);
 	if (!gfs2_recovery_wq)
 		goto fail_wq1;
 
 	gfs2_control_wq = alloc_workqueue("gfs2_control",
-					  WQ_UNBOUND | WQ_FREEZABLE, 0);
+					  WQ_UNBOUND, 0);
 	if (!gfs2_control_wq)
 		goto fail_wq2;
 
diff -u -p a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1189,13 +1189,13 @@ static int gfs2_fill_super(struct super_
 
 	error = -ENOMEM;
 	sdp->sd_glock_wq = alloc_workqueue("gfs2-glock/%s",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
+			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0,
 			sdp->sd_fsname);
 	if (!sdp->sd_glock_wq)
 		goto fail_free;
 
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
-			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
+			WQ_MEM_RECLAIM, 0, sdp->sd_fsname);
 	if (!sdp->sd_delete_wq)
 		goto fail_glock_wq;
 
diff -u -p a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -66,7 +66,7 @@ int __init fscache_init(void)
 {
 	int ret = -ENOMEM;
 
-	fscache_wq = alloc_workqueue("fscache", WQ_UNBOUND | WQ_FREEZABLE, 0);
+	fscache_wq = alloc_workqueue("fscache", WQ_UNBOUND, 0);
 	if (!fscache_wq)
 		goto error_wq;
 
diff -u -p a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1879,7 +1879,7 @@ init_cifs(void)
 		cifs_dbg(VFS, "dir_cache_timeout set to max of 65000 seconds\n");
 	}
 
-	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	cifsiod_wq = alloc_workqueue("cifsiod", WQ_MEM_RECLAIM, 0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
 		goto out_clean_proc;
@@ -1893,42 +1893,42 @@ init_cifs(void)
 
 	/* WQ_UNBOUND allows decrypt tasks to run on any CPU */
 	decrypt_wq = alloc_workqueue("smb3decryptd",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!decrypt_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsiod_wq;
 	}
 
 	fileinfo_put_wq = alloc_workqueue("cifsfileinfoput",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!fileinfo_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_decrypt_wq;
 	}
 
 	cifsoplockd_wq = alloc_workqueue("cifsoplockd",
-					 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					 WQ_MEM_RECLAIM, 0);
 	if (!cifsoplockd_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_fileinfo_put_wq;
 	}
 
 	deferredclose_wq = alloc_workqueue("deferredclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_MEM_RECLAIM, 0);
 	if (!deferredclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsoplockd_wq;
 	}
 
 	serverclose_wq = alloc_workqueue("serverclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_MEM_RECLAIM, 0);
 	if (!serverclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_deferredclose_wq;
 	}
 
 	cfid_put_wq = alloc_workqueue("cfid_put_wq",
-				      WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				      WQ_MEM_RECLAIM, 0);
 	if (!cfid_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_serverclose_wq;
diff -u -p a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -293,7 +293,7 @@ int
 xfs_mru_cache_init(void)
 {
 	xfs_mru_reap_wq = alloc_workqueue("xfs_mru_cache",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 1);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 1);
 	if (!xfs_mru_reap_wq)
 		return -ENOMEM;
 	return 0;
diff -u -p a/fs/xfs/xfs_pwork.c b/fs/xfs/xfs_pwork.c
--- a/fs/xfs/xfs_pwork.c
+++ b/fs/xfs/xfs_pwork.c
@@ -72,7 +72,7 @@ xfs_pwork_init(
 	trace_xfs_pwork_init(mp, nr_threads, current->pid);
 
 	pctl->wq = alloc_workqueue("%s-%d",
-			WQ_UNBOUND | WQ_SYSFS | WQ_FREEZABLE, nr_threads, tag,
+			WQ_UNBOUND | WQ_SYSFS, nr_threads, tag,
 			current->pid);
 	if (!pctl->wq)
 		return -ENOMEM;
diff -u -p a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -565,37 +565,37 @@ xfs_init_mount_workqueues(
 	struct xfs_mount	*mp)
 {
 	mp->m_buf_workqueue = alloc_workqueue("xfs-buf/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			1, mp->m_super->s_id);
 	if (!mp->m_buf_workqueue)
 		goto out;
 
 	mp->m_unwritten_workqueue = alloc_workqueue("xfs-conv/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
 	if (!mp->m_reclaim_workqueue)
 		goto out_destroy_unwritten;
 
 	mp->m_blockgc_wq = alloc_workqueue("xfs-blockgc/%s",
-			XFS_WQFLAGS(WQ_UNBOUND | WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_UNBOUND | WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
 	if (!mp->m_blockgc_wq)
 		goto out_destroy_reclaim;
 
 	mp->m_inodegc_wq = alloc_workqueue("xfs-inodegc/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			1, mp->m_super->s_id);
 	if (!mp->m_inodegc_wq)
 		goto out_destroy_blockgc;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);
+			XFS_WQFLAGS(0), 0, mp->m_super->s_id);
 	if (!mp->m_sync_workqueue)
 		goto out_destroy_inodegc;
 
@@ -2500,7 +2500,7 @@ xfs_init_workqueues(void)
 	 * max_active value for this workqueue.
 	 */
 	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
diff -u -p a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_de
 
 	if (!lo->workqueue) {
 		lo->workqueue = alloc_workqueue("loop%d",
-						WQ_UNBOUND | WQ_FREEZABLE,
+						WQ_UNBOUND,
 						0, lo->lo_number);
 		if (!lo->workqueue) {
 			error = -ENOMEM;
diff -u -p a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -770,7 +770,7 @@ static int hi3110_open(struct net_device
 		goto out_close;
 	}
 
-	priv->wq = alloc_workqueue("hi3110_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+	priv->wq = alloc_workqueue("hi3110_wq", WQ_MEM_RECLAIM,
 				   0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
diff -u -p a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -333,12 +333,12 @@ static int wg_newlink(struct net_device
 		goto err_free_peer_hashtable;
 
 	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
-			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
+			WQ_CPU_INTENSIVE, 0, dev->name);
 	if (!wg->handshake_receive_wq)
 		goto err_free_index_hashtable;
 
 	wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
-			WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
+			WQ_UNBOUND, 0, dev->name);
 	if (!wg->handshake_send_wq)
 		goto err_destroy_handshake_receive;
 
diff -u -p a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2762,7 +2762,7 @@ static void __exit rproc_exit_panic(void
 static int __init remoteproc_init(void)
 {
 	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq",
-						WQ_UNBOUND | WQ_FREEZABLE, 0);
+						WQ_UNBOUND, 0);
 	if (!rproc_recovery_wq) {
 		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
 		return -ENOMEM;
diff -u -p a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2811,7 +2811,7 @@ static void scrub_workers_put(struct btr
 static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 {
 	struct workqueue_struct *scrub_workers = NULL;
-	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
 
diff -u -p a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -287,7 +287,7 @@ int dfs_cache_init(void)
 	int i;
 
 	dfscache_wq = alloc_workqueue("cifs-dfscache",
-				      WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM,
+				      WQ_UNBOUND | WQ_MEM_RECLAIM,
 				      0);
 	if (!dfscache_wq)
 		return -ENOMEM;
diff -u -p a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1489,8 +1489,7 @@ xlog_alloc_log(
 	log->l_iclog->ic_prev = prev_iclog;	/* re-write 1st prev ptr */
 
 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM |
-				    WQ_HIGHPRI),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_HIGHPRI),
 			0, mp->m_super->s_id);
 	if (!log->l_ioend_workqueue)
 		goto out_free_iclog;
diff -u -p a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1658,7 +1658,7 @@ int scmi_notification_init(struct scmi_h
 		goto err;
 
 	ni->notify_wq = alloc_workqueue(dev_name(handle->dev),
-					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
+					WQ_UNBOUND | WQ_SYSFS,
 					0);
 	if (!ni->notify_wq)
 		goto err;
diff -u -p a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -420,7 +420,7 @@ static int virtio_chan_setup(struct scmi
 
 		vioch->deferred_tx_wq =
 			alloc_workqueue(dev_name(&scmi_vdev->dev),
-					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
+					WQ_UNBOUND | WQ_SYSFS,
 					0);
 		if (!vioch->deferred_tx_wq)
 			return -ENOMEM;
diff -u -p a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2647,7 +2647,7 @@ static int nintendo_hid_probe(struct hid
 	init_waitqueue_head(&ctlr->wait);
 	spin_lock_init(&ctlr->lock);
 	ctlr->rumble_queue = alloc_workqueue("hid-nintendo-rumble_wq",
-					     WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+					     WQ_MEM_RECLAIM, 0);
 	if (!ctlr->rumble_queue) {
 		ret = -ENOMEM;
 		goto err;
diff -u -p a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1254,7 +1254,6 @@ static int hidg_bind(struct usb_configur
 
 	INIT_WORK(&hidg->work, get_report_workqueue_handler);
 	hidg->workqueue = alloc_workqueue("report_work",
-					  WQ_FREEZABLE |
 					  WQ_MEM_RECLAIM,
 					  1);
 
diff -u -p a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -987,7 +987,7 @@ static int virtballoon_probe(struct virt
 			goto out_del_vqs;
 		}
 		vb->balloon_wq = alloc_workqueue("balloon-wq",
-					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
+					WQ_CPU_INTENSIVE, 0);
 		if (!vb->balloon_wq) {
 			err = -ENOMEM;
 			goto out_del_vqs;
diff -u -p a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1962,8 +1962,8 @@ static void btrfs_init_qgroup(struct btr
 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
-	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
-	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE;
+	unsigned int flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
+	unsigned int ordered_flags = WQ_MEM_RECLAIM;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
diff -u -p a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1932,7 +1932,7 @@ xlog_cil_init(
 	 * concurrency the log spinlocks will be exposed to.
 	 */
 	cil->xc_push_wq = alloc_workqueue("xfs-cil/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_UNBOUND),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_UNBOUND),
 			4, log->l_mp->m_super->s_id);
 	if (!cil->xc_push_wq)
 		goto out_destroy_cil;
diff -u -p a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7825,7 +7825,7 @@ void __init workqueue_init_early(void)
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
 					      WQ_POWER_EFFICIENT, 0);
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
-					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
+					      WQ_POWER_EFFICIENT,
 					      0);
 	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
 	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
diff -u -p a/fs/ext4/super.c b/fs/ext4/super.c
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3776,7 +3776,6 @@ static int ext4_lazyinit_thread(void *ar
 	unsigned long next_wakeup, cur;
 
 	BUG_ON(NULL == eli);
-	set_freezable();
 
 cont_thread:
 	while (true) {
@@ -3835,8 +3834,6 @@ cont_thread:
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
-		try_to_freeze();
-
 		cur = jiffies;
 		if (!next_wakeup_initialized || time_after_eq(cur, next_wakeup)) {
 			cond_resched();

