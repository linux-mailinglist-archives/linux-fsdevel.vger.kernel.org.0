Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E566A7A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjANAfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjANAe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B888DFA;
        Fri, 13 Jan 2023 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sA46072UUIGL5Kh0iBH2gpikSfm/h334hpGh720jgWo=; b=YLTLwqO2Mt7VDCHtk8T6vakI82
        esk2gGAdnKSYN1dtEJq1DdVjlVXyN4nAEuDTutXWuTHNdBJ9KZNOKcNQa+nNfLHeJTrl54EcCIb1m
        jVIfR2XOTESqrjCvK4V1baDAsC2qCjSZGZF6utoIydLJFHjSewTKPRtcdNEe0FYDqi5GC1Ksr7A5C
        D2yVITq1Fowfx0soPeK5x/ztVBYNLQcbPcVoBWVXE4FwppdQ6XpY2GiBNtpCSJCtCJIiBGfM/SuB1
        BbK41+LF+QJbvyUwW1DC9QbVmbaIrw0guejOE20rC8m7smqjuEQ1qWTEVoYeFXwyzKekS8E4sn8m9
        i5Xcgs0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004twH-CP; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 11/24] gfs2: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:33:56 -0800
Message-Id: <20230114003409.1168311-12-mcgrof@kernel.org>
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

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/gfs2 --jobs 12 --use-gitgrep

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
 fs/gfs2/glock.c      | 6 +++---
 fs/gfs2/log.c        | 2 --
 fs/gfs2/main.c       | 4 ++--
 fs/gfs2/ops_fstype.c | 4 ++--
 fs/gfs2/quota.c      | 2 --
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 524f3c96b9a4..7ad1a1229ae3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2459,14 +2459,14 @@ int __init gfs2_glock_init(void)
 	if (ret < 0)
 		return ret;
 
-	glock_workqueue = alloc_workqueue("glock_workqueue", WQ_MEM_RECLAIM |
-					  WQ_HIGHPRI | WQ_FREEZABLE, 0);
+	glock_workqueue = alloc_workqueue("glock_workqueue",
+					  WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!glock_workqueue) {
 		rhashtable_destroy(&gl_hash_table);
 		return -ENOMEM;
 	}
 	gfs2_delete_workqueue = alloc_workqueue("delete_workqueue",
-						WQ_MEM_RECLAIM | WQ_FREEZABLE,
+						WQ_MEM_RECLAIM,
 						0);
 	if (!gfs2_delete_workqueue) {
 		destroy_workqueue(glock_workqueue);
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 1fcc829f02ab..213fafc367f4 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1330,8 +1330,6 @@ int gfs2_logd(void *data)
 
 		t = gfs2_tune_get(sdp, gt_logd_secs) * HZ;
 
-		try_to_freeze();
-
 		do {
 			prepare_to_wait(&sdp->sd_logd_waitq, &wait,
 					TASK_INTERRUPTIBLE);
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index afcb32854f14..43d4748ad183 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -153,12 +153,12 @@ static int __init init_gfs2_fs(void)
 
 	error = -ENOMEM;
 	gfs_recovery_wq = alloc_workqueue("gfs_recovery",
-					  WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+					  WQ_MEM_RECLAIM, 0);
 	if (!gfs_recovery_wq)
 		goto fail_wq1;
 
 	gfs2_control_wq = alloc_workqueue("gfs2_control",
-					  WQ_UNBOUND | WQ_FREEZABLE, 0);
+					  WQ_UNBOUND, 0);
 	if (!gfs2_control_wq)
 		goto fail_wq2;
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0cf1d2d0ef5..8f5a63148eaf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1740,7 +1740,7 @@ static void gfs2_kill_sb(struct super_block *sb)
 
 struct file_system_type gfs2_fs_type = {
 	.name = "gfs2",
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_AUTOFREEZE,
 	.init_fs_context = gfs2_init_fs_context,
 	.parameters = gfs2_fs_parameters,
 	.kill_sb = gfs2_kill_sb,
@@ -1750,7 +1750,7 @@ MODULE_ALIAS_FS("gfs2");
 
 struct file_system_type gfs2meta_fs_type = {
 	.name = "gfs2meta",
-	.fs_flags = FS_REQUIRES_DEV,
+	.fs_flags = FS_REQUIRES_DEV | FS_AUTOFREEZE,
 	.init_fs_context = gfs2_meta_init_fs_context,
 	.owner = THIS_MODULE,
 };
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 1ed17226d9ed..710764af9d04 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1555,8 +1555,6 @@ int gfs2_quotad(void *data)
 		quotad_check_timeo(sdp, "sync", gfs2_quota_sync, t,
 				   &quotad_timeo, &tune->gt_quota_quantum);
 
-		try_to_freeze();
-
 bypass:
 		t = min(quotad_timeo, statfs_timeo);
 
-- 
2.35.1

