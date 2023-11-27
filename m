Return-Path: <linux-fsdevel+bounces-3998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8107FACF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490211C20C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A146558;
	Mon, 27 Nov 2023 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC210F0;
	Mon, 27 Nov 2023 14:05:31 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C3601F388;
	Mon, 27 Nov 2023 22:05:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 020361367B;
	Mon, 27 Nov 2023 22:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1znWJ6QSZWU6OwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Nov 2023 22:05:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Date: Tue, 28 Nov 2023 09:05:21 +1100
Message-id: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.98)[-0.979];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 2.81
X-Rspamd-Queue-Id: 8C3601F388


I have evidence from a customer site of 256 nfsd threads adding files to
delayed_fput_lists nearly twice as fast they are retired by a single
work-queue thread running delayed_fput().  As you might imagine this
does not end well (20 million files in the queue at the time a snapshot
was taken for analysis).

While this might point to a problem with the filesystem not handling the
final close efficiently, such problems should only hurt throughput, not
lead to memory exhaustion.

For normal threads, the thread that closes the file also calls the
final fput so there is natural rate limiting preventing excessive growth
in the list of delayed fputs.  For kernel threads, and particularly for
nfsd, delayed in the final fput do not impose any throttling to prevent
the thread from closing more files.

A simple way to fix this is to treat nfsd threads like normal processes
for task_work.  Thus the pending files are queued for the thread, and
the same thread finishes the work.

Currently KTHREADs are assumed never to call task_work_run().  With this
patch that it still the default but it is implemented by storing the
magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
nfsd, will call task_work_run() periodically, it sets ->task_works
to NULL to indicate this.

Signed-off-by: NeilBrown <neilb@suse.de>
---

I wonder which tree this should go through assuming everyone likes it.
VFS maybe??

Thanks.

 fs/file_table.c           | 2 +-
 fs/nfsd/nfssvc.c          | 4 ++++
 include/linux/sched.h     | 1 +
 include/linux/task_work.h | 4 +++-
 kernel/fork.c             | 2 +-
 kernel/task_work.c        | 7 ++++---
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..e79351df22be 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -445,7 +445,7 @@ void fput(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task =3D current;
=20
-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+		if (likely(!in_interrupt())) {
 			init_task_work(&file->f_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
 				return;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 66ca50b38b27..c047961262ca 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -13,6 +13,7 @@
 #include <linux/fs_struct.h>
 #include <linux/swap.h>
 #include <linux/siphash.h>
+#include <linux/task_work.h>
=20
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/svcsock.h>
@@ -941,6 +942,7 @@ nfsd(void *vrqstp)
 	}
=20
 	current->fs->umask =3D 0;
+	current->task_works =3D NULL; /* Declare that I will call task_work_run() */
=20
 	atomic_inc(&nfsdstats.th_cnt);
=20
@@ -955,6 +957,8 @@ nfsd(void *vrqstp)
=20
 		svc_recv(rqstp);
 		validate_process_creds();
+		if (task_work_pending(current))
+			task_work_run();
 	}
=20
 	atomic_dec(&nfsdstats.th_cnt);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..c63c2bedbf71 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1117,6 +1117,7 @@ struct task_struct {
 	unsigned int			sas_ss_flags;
=20
 	struct callback_head		*task_works;
+#define	TASK_WORKS_DISABLED	((void*)1)
=20
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a68429..3c74e3de81ed 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -22,7 +22,9 @@ enum task_work_notify_mode {
=20
 static inline bool task_work_pending(struct task_struct *task)
 {
-	return READ_ONCE(task->task_works);
+	struct callback_head *works =3D READ_ONCE(task->task_works);
+
+	return works && works !=3D TASK_WORKS_DISABLED;
 }
=20
 int task_work_add(struct task_struct *task, struct callback_head *twork,
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..903b29804fe1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2577,7 +2577,7 @@ __latent_entropy struct task_struct *copy_process(
 	p->dirty_paused_when =3D 0;
=20
 	p->pdeath_signal =3D 0;
-	p->task_works =3D NULL;
+	p->task_works =3D args->kthread ? TASK_WORKS_DISABLED : NULL;
 	clear_posix_cputimers_work(p);
=20
 #ifdef CONFIG_KRETPROBES
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..ffdf4b0d7a0e 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -49,7 +49,8 @@ int task_work_add(struct task_struct *task, struct callback=
_head *work,
=20
 	head =3D READ_ONCE(task->task_works);
 	do {
-		if (unlikely(head =3D=3D &work_exited))
+		if (unlikely(head =3D=3D &work_exited ||
+			     head =3D=3D TASK_WORKS_DISABLED))
 			return -ESRCH;
 		work->next =3D head;
 	} while (!try_cmpxchg(&task->task_works, &head, work));
@@ -157,7 +158,7 @@ void task_work_run(void)
 		work =3D READ_ONCE(task->task_works);
 		do {
 			head =3D NULL;
-			if (!work) {
+			if (!work || work =3D=3D TASK_WORKS_DISABLED) {
 				if (task->flags & PF_EXITING)
 					head =3D &work_exited;
 				else
@@ -165,7 +166,7 @@ void task_work_run(void)
 			}
 		} while (!try_cmpxchg(&task->task_works, &work, head));
=20
-		if (!work)
+		if (!work || work =3D=3D TASK_WORKS_DISABLED)
 			break;
 		/*
 		 * Synchronize with task_work_cancel(). It can not remove
--=20
2.42.1


