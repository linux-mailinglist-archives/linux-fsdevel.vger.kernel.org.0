Return-Path: <linux-fsdevel+bounces-4714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FE802A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE331C203D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7284415
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m8V5pPJi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bncqdXhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8584102;
	Sun,  3 Dec 2023 17:41:21 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42A6521F1D;
	Mon,  4 Dec 2023 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701654080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hISKijnd4xCcDmgO6DNsS7HeW40Z82Adw8RbpXfukPw=;
	b=m8V5pPJiMRAxtoimiVdIs7Go+HmGCbkELbSzKiWpz7JBzjg07VvWbVPbDQri05SQgDW8X4
	be2msdm/mAWGmtg9+5uf9dIPx5+Mrx0pQ5z2BdanZ8Ow5kDJ9YwN9yveoWr9Ov4dYanE2U
	zg59OdKU7vD3DAxedk4pm6cGKlXROfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701654080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hISKijnd4xCcDmgO6DNsS7HeW40Z82Adw8RbpXfukPw=;
	b=bncqdXhiwAKqw2l4M4UQW3sj49f4IDMCVNuzCrT/kffJkZSyCDDHZELvNwwJzaLDv//yIq
	bIGrTwozdrE85uAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7D451368D;
	Mon,  4 Dec 2023 01:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2en3HTsubWWLOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 01:41:15 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
Date: Mon,  4 Dec 2023 12:36:41 +1100
Message-ID: <20231204014042.6754-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204014042.6754-1-neilb@suse.de>
References: <20231204014042.6754-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [0.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.973];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.71

User-space processes always call task_work_run() as needed when
returning from a system call.  Kernel-threads generally do not.
Because of this some work that is best run in the task_works context
(guaranteed that no locks are held) cannot be queued to task_works from
kernel threads and so are queued to a (single) work_time to be managed
on a work queue.

This means that any cost for doing the work is not imposed on the kernel
thread, and importantly excessive amounts of work cannot apply
back-pressure to reduce the amount of new work queued.

I have evidence from a customer site when nfsd (which runs as kernel
threads) is being asked to modify many millions of files which causes
sufficient memory pressure that some cache (in XFS I think) gets cleaned
earlier than would be ideal.  When __dput (from the workqueue) calls
__dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
previously cached info from storage.  This slows down the single thread
that is making all the final __dput() calls for all the nfsd threads
with the net result that files are added to the delayed_fput_list faster
than they are removed, and the system eventually runs out of memory.

This happens because there is no back-pressure: the nfsd isn't forced to
slow down when __dput() is slow for any reason.  To fix this we can
change the nfsd threads to call task_work_run() regularly (much like
user-space processes do) and allow it to declare this so that work does
get queued to task_works rather than to a work queue.

This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
instead of PF_KTHREAD to determine whether it is sensible to queue
something to task_works.  This flag is always set for non-kernel threads.

task_work_run() is also exported so that it can be called from a module
such as nfsd.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/file_table.c       | 3 ++-
 fs/namespace.c        | 2 +-
 include/linux/sched.h | 2 +-
 kernel/fork.c         | 2 ++
 kernel/task_work.c    | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3da9d08..d36cade6e366 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -435,7 +435,8 @@ void fput(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		if (likely(!in_interrupt() &&
+			   (task->flags & PF_RUNS_TASK_WORK))) {
 			init_task_work(&file->f_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
 				return;
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..46d640b70ca9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
 
 	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
 		struct task_struct *task = current;
-		if (likely(!(task->flags & PF_KTHREAD))) {
+		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
 			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
 			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
 				return;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..e4eebac708e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1747,7 +1747,7 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..d612d8f14861 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2330,6 +2330,8 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
+	else
+		p->flags |= PF_RUNS_TASK_WORK;
 	if (args->user_worker) {
 		/*
 		 * Mark us a user worker, and block any signal that isn't
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..aec19876e121 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -183,3 +183,4 @@ void task_work_run(void)
 		} while (work);
 	}
 }
+EXPORT_SYMBOL(task_work_run);
-- 
2.43.0


