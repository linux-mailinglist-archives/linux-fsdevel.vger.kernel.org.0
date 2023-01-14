Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F566A7A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjANAfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjANAe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA38B504;
        Fri, 13 Jan 2023 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=U3bpnd6547PaoT3tgQQ7x9+yqyo+lAhpNKGMVa67XeM=; b=w9EHUy7rgp86Q5B/90dfPTHVXG
        N9/FDKz3TfdC7yxmfYhnSr4SyeTHxd3rl68Ff2Y/H9j8Ew37kF5rL61ehtrpsWcLfR1m5IfdMK4jd
        CY7AQ+jZIu1vfaTurN+btG4MAA1u68WedJGPR24qqeseYZoSavZ7mOoOTH2XGYPokRsVV+0UN1sCm
        4gR5StmaY1Am5TVrlXpmenGD9MfwEqNqjebnragMeFWnyW1H/U2OFsLdCNeUdwdlQTfIax8DUkeOa
        g0F+Ko0eeHHXTxub/ocrr1am9G9M2TGeNWPrzxCkTjcGwZWlycduv/p+Td200sgG+vnG1mhzmTP2L
        XkZ6xRMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004twX-OK; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 19/24] jbd2: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:34:04 -0800
Message-Id: <20230114003409.1168311-20-mcgrof@kernel.org>
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

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/jbd2 --jobs 12 --use-gitgrep

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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/jbd2/journal.c | 54 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e80c781731f8..99a4db5b40fc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -169,6 +169,8 @@ static int kjournald2(void *arg)
 {
 	journal_t *journal = arg;
 	transaction_t *transaction;
+	DEFINE_WAIT(wait);
+	int should_sleep = 1;
 
 	/*
 	 * Set up an interval timer which can be used to trigger a commit wakeup
@@ -176,8 +178,6 @@ static int kjournald2(void *arg)
 	 */
 	timer_setup(&journal->j_commit_timer, commit_timeout, 0);
 
-	set_freezable();
-
 	/* Record that the journal thread is running */
 	journal->j_task = current;
 	wake_up(&journal->j_wait_done_commit);
@@ -212,41 +212,27 @@ static int kjournald2(void *arg)
 	}
 
 	wake_up(&journal->j_wait_done_commit);
-	if (freezing(current)) {
-		/*
-		 * The simpler the better. Flushing journal isn't a
-		 * good idea, because that depends on threads that may
-		 * be already stopped.
-		 */
-		jbd2_debug(1, "Now suspending kjournald2\n");
+	/*
+	 * We assume on resume that commits are already there,
+	 * so we don't sleep
+	 */
+
+	prepare_to_wait(&journal->j_wait_commit, &wait,
+			TASK_INTERRUPTIBLE);
+	if (journal->j_commit_sequence != journal->j_commit_request)
+		should_sleep = 0;
+	transaction = journal->j_running_transaction;
+	if (transaction && time_after_eq(jiffies,
+					transaction->t_expires))
+		should_sleep = 0;
+	if (journal->j_flags & JBD2_UNMOUNT)
+		should_sleep = 0;
+	if (should_sleep) {
 		write_unlock(&journal->j_state_lock);
-		try_to_freeze();
+		schedule();
 		write_lock(&journal->j_state_lock);
-	} else {
-		/*
-		 * We assume on resume that commits are already there,
-		 * so we don't sleep
-		 */
-		DEFINE_WAIT(wait);
-		int should_sleep = 1;
-
-		prepare_to_wait(&journal->j_wait_commit, &wait,
-				TASK_INTERRUPTIBLE);
-		if (journal->j_commit_sequence != journal->j_commit_request)
-			should_sleep = 0;
-		transaction = journal->j_running_transaction;
-		if (transaction && time_after_eq(jiffies,
-						transaction->t_expires))
-			should_sleep = 0;
-		if (journal->j_flags & JBD2_UNMOUNT)
-			should_sleep = 0;
-		if (should_sleep) {
-			write_unlock(&journal->j_state_lock);
-			schedule();
-			write_lock(&journal->j_state_lock);
-		}
-		finish_wait(&journal->j_wait_commit, &wait);
 	}
+	finish_wait(&journal->j_wait_commit, &wait);
 
 	jbd2_debug(1, "kjournald2 wakes\n");
 
-- 
2.35.1

