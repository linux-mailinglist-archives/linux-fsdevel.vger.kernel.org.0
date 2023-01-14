Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350266A788
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjANAe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjANAeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20282F88;
        Fri, 13 Jan 2023 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CzX5TNn6oh8/8V1ep/+qFHA/PZO960nB4oCzG0Ioh0Y=; b=eeeTwrvd/zAeqsSVvWWa0CJ1o9
        Id5NPecHtcqGVSSvzqzvauFzB/rMhxeEp6OjPkz0NIdhEpFZrtCDyvMqJ1vH399n8Bzp1T+UBSaeB
        RHVFarvAgYVPUEgxiSQZ9YqtlU799K7DhtfXRo+iKsZmr+bkUrzfv/hvMYPhTP5y+uapMzgEbsdKR
        xX9hLbJoIqL1d+fosURSBbzjUn3iyzdNXPeNdPjerQ2ecBGaz0wVHP5Vc3znbq9uD/iUbgPRGyx0h
        +u4KL8wjyExPxMwp0V0aZNPGYgn48yh+A3dKBrm44iQy2y4KlF3vBSxc/KpgYU0wA/Fpp7dLk1Fxg
        ZXlqQCbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004twL-FW; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 13/24] nilfs2: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:33:58 -0800
Message-Id: <20230114003409.1168311-14-mcgrof@kernel.org>
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

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/nilfs2 --jobs 12 --use-gitgrep

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
 fs/nilfs2/segment.c | 48 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index f7a14ed12a66..1c48aa9c7f56 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2541,6 +2541,8 @@ static int nilfs_segctor_thread(void *arg)
 	struct nilfs_sc_info *sci = (struct nilfs_sc_info *)arg;
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int timeout = 0;
+	DEFINE_WAIT(wait);
+	int should_sleep = 1;
 
 	sci->sc_timer_task = current;
 
@@ -2572,38 +2574,28 @@ static int nilfs_segctor_thread(void *arg)
 		timeout = 0;
 	}
 
+	prepare_to_wait(&sci->sc_wait_daemon, &wait,
+			TASK_INTERRUPTIBLE);
 
-	if (freezing(current)) {
+	if (sci->sc_seq_request != sci->sc_seq_done)
+		should_sleep = 0;
+	else if (sci->sc_flush_request)
+		should_sleep = 0;
+	else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
+		should_sleep = time_before(jiffies,
+				sci->sc_timer.expires);
+
+	if (should_sleep) {
 		spin_unlock(&sci->sc_state_lock);
-		try_to_freeze();
+		schedule();
 		spin_lock(&sci->sc_state_lock);
-	} else {
-		DEFINE_WAIT(wait);
-		int should_sleep = 1;
-
-		prepare_to_wait(&sci->sc_wait_daemon, &wait,
-				TASK_INTERRUPTIBLE);
-
-		if (sci->sc_seq_request != sci->sc_seq_done)
-			should_sleep = 0;
-		else if (sci->sc_flush_request)
-			should_sleep = 0;
-		else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
-			should_sleep = time_before(jiffies,
-					sci->sc_timer.expires);
-
-		if (should_sleep) {
-			spin_unlock(&sci->sc_state_lock);
-			schedule();
-			spin_lock(&sci->sc_state_lock);
-		}
-		finish_wait(&sci->sc_wait_daemon, &wait);
-		timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
-			   time_after_eq(jiffies, sci->sc_timer.expires));
-
-		if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
-			set_nilfs_discontinued(nilfs);
 	}
+	finish_wait(&sci->sc_wait_daemon, &wait);
+	timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		   time_after_eq(jiffies, sci->sc_timer.expires));
+
+	if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
+		set_nilfs_discontinued(nilfs);
 	goto loop;
 
  end_thread:
-- 
2.35.1

