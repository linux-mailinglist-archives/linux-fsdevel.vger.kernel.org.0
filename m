Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8066A7A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjANAfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjANAe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB188DE8;
        Fri, 13 Jan 2023 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CCUfcpN4x/0Xi0jTJWkJ/jCEx8NEnlfKV4sQV1U7TQ0=; b=VMOixw9IkMgNv5e9sfrKE1iPor
        X12c3Lc0b0L0J65RYhqSm64eBz9ngJsL2Vo/4EzvrSc37i0CFf2/y33CqkWtVBLy7ysZd4LcFq61+
        IDHLx+PTFmSDnZB28YvaKhCgVY0BhYtboWjjMAt14f1jfazsPtGtJInZd0Lwp5NyDsFBQkAe1U+9R
        kuSvpT4qmfqNV7Cd3fL6jn5bne189EY5/EL+cH66RjAmPX9pRhDbMLxcsedeOGzMhNsZbR+7wL5W9
        3pg8Y0TCsWClwxnHYcQOMcDNVC6+tLH2SUPREEWaC4D8JJJExaChJTg76HiYxaqQtSM33cXJ+R/vE
        kIvXbAFw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004tw7-4e; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 06/24] xfs: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:33:51 -0800
Message-Id: <20230114003409.1168311-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230114003409.1168311-1-mcgrof@kernel.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel power management now supports allowing the VFS
to handle filesystem freezing freezes and thawing. Take advantage
of that and remove the kthread freezing. This is needed so that we
properly really stop IO in flight without races after userspace
has been frozen. Without this we rely on kthread freezing and
its semantics are loose and error prone.

The filesystem therefore is in charge of properly dealing with
quiescing of the filesystem through its callbacks if it thinks
it knows better than how the VFS handles it.

The following Coccinelle rule was used as to remove the now superflous
freezer calls:

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/xfs --jobs 12 --use-gitgrep

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
 fs/xfs/xfs_log.c       |  3 +--
 fs/xfs/xfs_log_cil.c   |  2 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 16 ++++++++--------
 fs/xfs/xfs_trans_ail.c |  3 ---
 6 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index fc61cc024023..fbdbc81dc8ad 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1678,8 +1678,7 @@ xlog_alloc_log(
 	log->l_iclog->ic_prev = prev_iclog;	/* re-write 1st prev ptr */
 
 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM |
-				    WQ_HIGHPRI),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_HIGHPRI),
 			0, mp->m_super->s_id);
 	if (!log->l_ioend_workqueue)
 		goto out_free_iclog;
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eccbfb99e894..bcc5c8234ce8 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1842,7 +1842,7 @@ xlog_cil_init(
 	 * concurrency the log spinlocks will be exposed to.
 	 */
 	cil->xc_push_wq = alloc_workqueue("xfs-cil/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_UNBOUND),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_UNBOUND),
 			4, log->l_mp->m_super->s_id);
 	if (!cil->xc_push_wq)
 		goto out_destroy_cil;
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index f85e3b07ab44..98832a84be66 100644
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -294,7 +294,7 @@ int
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
index 0c4b73e9b29d..54cbf15fc459 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -526,37 +526,37 @@ xfs_init_mount_workqueues(
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
 
@@ -1966,7 +1966,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("xfs");
 
@@ -2205,7 +2205,7 @@ xfs_init_workqueues(void)
 	 * max_active value for this workqueue.
 	 */
 	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 7d4109af193e..03a9bb64927c 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -600,7 +600,6 @@ xfsaild(
 	unsigned int	noreclaim_flag;
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	set_freezable();
 
 	while (1) {
 		if (tout && tout <= 20)
@@ -666,8 +665,6 @@ xfsaild(
 
 		__set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
-
 		tout = xfsaild_push(ailp);
 	}
 
-- 
2.35.1

