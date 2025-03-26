Return-Path: <linux-fsdevel+bounces-45072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FFA7159C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C2188B8E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CFF1DE2A9;
	Wed, 26 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="46lg4Qo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2BEEC3;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=X2EfzP9GyL8c9ZX5oralJjXgHs0pTrkLrLhxGgv/D7hz1sLBT9g9CJBFB6kejosA8dgtPHhjEYF8Z6t0lP70qeKcClPrNvM/g2OuedJLK9VIGOfz6l35nYrvI8HKh0pCYD5xs4l28hffl9GWxm22rayr1/iBxxUOYI38tmc2O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=GqQAE2gI9jpYg3gMwXkCpEnwEG0pEMzVmX2dEBpK1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POgYJAvf4GxxnEIJDa9PFOrXMU25BsiOr7lavuDkS8TLAyFPAYTKHkTwUc9h8BNc9XtmbC6MmoMcpiw7yq/m3SqFRjcuPsY+FL4bKDjsOyw4iOiFgeHip93244+wYa4fDyinC1MRCXLRyC3h5j46RSZ26sNKC/HRUDGdxj3/6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=46lg4Qo4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d0u73LY7N6aNB4yHaOSQ3RxfhJSx72C3Op6MMJeJuck=; b=46lg4Qo4UazkYkHkgsh8m6mAjk
	WRSWIz5C4Rel7jWx3B95q5QuEtiCg9gMLXHdnjX3lk7xbtrd2j8lXZeXJlpynb+5hWRjBmvuNghtA
	p2BaXSqMYkyBXIfn7rwL3LHtFdsPhsDujTeGXnb3EU7by29LgkPr44fCcd1TXM20bFyaUFQJwJ9my
	OGMFSCxu1ov1IbzEvxDqB/yZ3vuA016Y7F/5ETa4SFq3oFecg7D/Ctgg/W9slCF7b4B9Uwf7erPPU
	6IdZSsnwvCHuXWVVWD50/lVKtYZUP9y2ji3GigrY47BAbJ6wxkYHlwafsva1bZ32FFGklnj4JPKay
	4yrqtGhg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LMC-3XEq;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 6/6] xfs: replace kthread freezing with auto fs freezing
Date: Wed, 26 Mar 2025 04:22:20 -0700
Message-ID: <20250326112220.1988619-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The kernel power management now supports allowing the VFS
to handle filesystem freezing freezes and thawing. Take advantage
of that and remove the kthread freezing. This is needed so that we
properly really stop IO in flight without races after userspace
has been frozen. Without this we rely on kthread freezing and
its semantics are loose and error prone.

The filesystem therefore is in charge of properly dealing with
quiescing of the filesystem through its callbacks if it thinks
it knows better than how the VFS handles it.

The following Coccinelle rule was used as to remove the now superfluous
freezer calls:

make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/xfs

virtual patch

@ remove_set_freezable @
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

@ add_auto_flag @
expression E1;
identifier fs_type;
@@

struct file_system_type fs_type = {
	.fs_flags = E1
+                   | FS_AUTOFREEZE
	,
};

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_discard.c   |  2 +-
 fs/xfs/xfs_log.c       |  3 +--
 fs/xfs/xfs_log_cil.c   |  2 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 16 ++++++++--------
 fs/xfs/xfs_trans_ail.c |  3 ---
 fs/xfs/xfs_zone_gc.c   |  2 --
 8 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index c1a306268ae4..1596cf0ecb9b 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -333,7 +333,7 @@ xfs_trim_gather_extents(
 static bool
 xfs_trim_should_stop(void)
 {
-	return fatal_signal_pending(current) || freezing(current);
+	return fatal_signal_pending(current);
 }
 
 /*
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 6493bdb57351..317f6db292fb 100644
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
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..8ff5d68394e6 100644
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
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index d0f5b403bdbe..c9a49c6f6129 100644
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
diff --git a/fs/xfs/xfs_pwork.c b/fs/xfs/xfs_pwork.c
index c283b801cc5d..3f5bf53f8778 100644
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
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..4fae48072ef3 100644
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
 
@@ -2228,7 +2228,7 @@ static struct file_system_type xfs_fs_type = {
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
-				  FS_LBS,
+				  FS_LBS | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("xfs");
 
@@ -2500,7 +2500,7 @@ xfs_init_workqueues(void)
 	 * max_active value for this workqueue.
 	 */
 	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 0fcb1828e598..ad8183db0780 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -636,7 +636,6 @@ xfsaild(
 	unsigned int	noreclaim_flag;
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	set_freezable();
 
 	while (1) {
 		/*
@@ -695,8 +694,6 @@ xfsaild(
 
 		__set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
-
 		tout = xfsaild_push(ailp);
 	}
 
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index c5136ea9bb1d..1875b6551ab0 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
 	}
 
 	__set_current_state(TASK_RUNNING);
-	try_to_freeze();
 
 	if (reset_list)
 		xfs_zone_gc_reset_zones(data, reset_list);
@@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
 	unsigned int		nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
-	set_freezable();
 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
-- 
2.47.2


