Return-Path: <linux-fsdevel+bounces-45400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F1A771F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C800188B49C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437E131E2D;
	Tue,  1 Apr 2025 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An6fGshs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937A3B2A0;
	Tue,  1 Apr 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467619; cv=none; b=avweqoUn+hI/IWy1Ip4+vXlbdQJ6pzkPklX8KlnCh7YT3b500miCSM7Ks7oOoC/gU2eqNkCVMxXwOfNTdPJ4emfSPIKZVf+nxnVCD7UTWmQ0pbNiYKUOECM3Wa4hCZNiCT2AqnmQPyqz5nhMTrt83nfjGPWlpm3OaDouZsj4VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467619; c=relaxed/simple;
	bh=LgKEk3JEMCVIwbUc0LPca13vEvDo6/Cr7URqAgR/XqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb1tc/5TfD+YMQxTySAtiBuNh3L8r9JfrQw7rUkLCnIckjljypJ6NoLBYhwOwEP4MlZFMaHMHp9CCakgb+kvYpE8TrFCkOMFD2CJhYFteI19cfged4Wu4qJmF+pxhxoFShiX26tN0yfW+f2JtVZ/8K+c3ouvn58DW+mKVNV3lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An6fGshs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B414C4CEED;
	Tue,  1 Apr 2025 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743467618;
	bh=LgKEk3JEMCVIwbUc0LPca13vEvDo6/Cr7URqAgR/XqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=An6fGshskWq3QX8K2FdJorEK8/jRxdV8qJFnAJ3r5Zlcj4tXqQhTB6vvqyKbBv1gS
	 Zg/RHe2VIDB+Nrm2x6xq8FJcPucoIX0EzhoRockD1cLBNheXhuSIJWFJCrWOedkwy6
	 RiVVR54jefaVaQG529fPF4qmEurlvBollB7pOwIkbLCrIsKYZimTM15VUmp+NeVvbP
	 5Vq69BzwS7F/IdoEgojBFs09SZZ+3sp1tmYieWJsD4XBHsw4K9I+p53NuuPCJgyVw9
	 uk4juI9lqnBbY9XAJhIlDBQK1Noe7Su6lSg4DaK7MwIWEyS2vwjcyqPRw2UCOxIlwX
	 K348wMhvuW0rQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Date: Tue,  1 Apr 2025 02:32:48 +0200
Message-ID: <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=8352; i=brauner@kernel.org; h=from:subject:message-id; bh=FtAblvbK+CSDReLl0ZY3VoDAalHQydNqGK9uQ+GdDdI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/NrGJ874lqjwv3tLYOsvov2n+xYyaF0H9cikWFdPi6 1k0VG51lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATMRQhuF/tle9eNHfU/WzXHUO 7Jb1ujT38NeJwifmLVhWJPfipOSzCYwMd36V/HP5wli56ETJu/1fk/asYrMM8VOUCXCKvnlyxcs MVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

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
Link: https://lore.kernel.org/r/20250326112220.1988619-7-mcgrof@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_discard.c   |  2 +-
 fs/xfs/xfs_log.c       |  3 +--
 fs/xfs/xfs_log_cil.c   |  2 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 14 +++++++-------
 fs/xfs/xfs_trans_ail.c |  3 ---
 fs/xfs/xfs_zone_gc.c   |  2 --
 8 files changed, 12 insertions(+), 18 deletions(-)

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
index 53944cc7af24..06eb51a3d13b 100644
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
 
@@ -2488,7 +2488,7 @@ xfs_init_workqueues(void)
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


