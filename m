Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF82BB9FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgKTXUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:03 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47076 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgKTXUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFhA-002Rc7-V7; Fri, 20 Nov 2020 16:20:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFe9-00EG00-8Y; Fri, 20 Nov 2020 16:16:54 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, criu@openvz.org,
        bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 20 Nov 2020 17:14:33 -0600
Message-Id: <20201120231441.29911-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFe9-00EG00-8Y;;;mid=<20201120231441.29911-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UiNkGFJP+cwxvIGMAiHgWENa406BND64=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMGappySubj_02,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  1.0 XMGappySubj_02 Gappier still
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 524 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.58
        (0.3%), extract_message_metadata: 12 (2.4%), get_uri_detail_list: 4.2
        (0.8%), tests_pri_-1000: 12 (2.2%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 87 (16.6%), check_bayes:
        85 (16.3%), b_tokenize: 10 (2.0%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 58 (11.0%), b_finish: 0.74
        (0.1%), tests_pri_0: 391 (74.7%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 1.05 (0.2%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 16/24] bpf/task_iter: In task_file_seq_get_next use task_lookup_next_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When discussing[1] exec and posix file locks it was realized that none
of the callers of get_files_struct fundamentally needed to call
get_files_struct, and that by switching them to helper functions
instead it will both simplify their code and remove unnecessary
increments of files_struct.count.  Those unnecessary increments can
result in exec unnecessarily unsharing files_struct which breaking
posix locks, and it can result in fget_light having to fallback to
fget reducing system performance.

Using task_lookup_next_fd_rcu simplifies task_file_seq_get_next, by
moving the checking for the maximum file descritor into the generic
code, and by remvoing the need for capturing and releasing a reference
on files_struct.  As the reference count of files_struct no longer
needs to be maintained bpf_iter_seq_task_file_info can have it's files
member removed and task_file_seq_get_next no longer needs it's fstruct
argument.

The curr_fd local variable does need to become unsigned to be used
with fnext_task.  As curr_fd is assigned from and assigned a u32
making curr_fd an unsigned int won't cause problems and might prevent
them.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-11-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/task_iter.c | 44 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5ab2ccfb96cb..4ec63170c741 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -130,45 +130,33 @@ struct bpf_iter_seq_task_file_info {
 	 */
 	struct bpf_iter_seq_task_common common;
 	struct task_struct *task;
-	struct files_struct *files;
 	u32 tid;
 	u32 fd;
 };
 
 static struct file *
 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
-		       struct task_struct **task, struct files_struct **fstruct)
+		       struct task_struct **task)
 {
 	struct pid_namespace *ns = info->common.ns;
-	u32 curr_tid = info->tid, max_fds;
-	struct files_struct *curr_files;
+	u32 curr_tid = info->tid;
 	struct task_struct *curr_task;
-	int curr_fd = info->fd;
+	unsigned int curr_fd = info->fd;
 
 	/* If this function returns a non-NULL file object,
-	 * it held a reference to the task/files_struct/file.
+	 * it held a reference to the task/file.
 	 * Otherwise, it does not hold any reference.
 	 */
 again:
 	if (*task) {
 		curr_task = *task;
-		curr_files = *fstruct;
 		curr_fd = info->fd;
 	} else {
 		curr_task = task_seq_get_next(ns, &curr_tid, true);
 		if (!curr_task)
 			return NULL;
 
-		curr_files = get_files_struct(curr_task);
-		if (!curr_files) {
-			put_task_struct(curr_task);
-			curr_tid = ++(info->tid);
-			info->fd = 0;
-			goto again;
-		}
-
-		/* set *fstruct, *task and info->tid */
-		*fstruct = curr_files;
+		/* set *task and info->tid */
 		*task = curr_task;
 		if (curr_tid == info->tid) {
 			curr_fd = info->fd;
@@ -179,13 +167,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 	}
 
 	rcu_read_lock();
-	max_fds = files_fdtable(curr_files)->max_fds;
-	for (; curr_fd < max_fds; curr_fd++) {
+	for (;; curr_fd++) {
 		struct file *f;
-
-		f = files_lookup_fd_rcu(curr_files, curr_fd);
+		f = task_lookup_next_fd_rcu(curr_task, &curr_fd);
 		if (!f)
-			continue;
+			break;
 		if (!get_file_rcu(f))
 			continue;
 
@@ -197,10 +183,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 
 	/* the current task is done, go to the next task */
 	rcu_read_unlock();
-	put_files_struct(curr_files);
 	put_task_struct(curr_task);
 	*task = NULL;
-	*fstruct = NULL;
 	info->fd = 0;
 	curr_tid = ++(info->tid);
 	goto again;
@@ -209,13 +193,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct bpf_iter_seq_task_file_info *info = seq->private;
-	struct files_struct *files = NULL;
 	struct task_struct *task = NULL;
 	struct file *file;
 
-	file = task_file_seq_get_next(info, &task, &files);
+	file = task_file_seq_get_next(info, &task);
 	if (!file) {
-		info->files = NULL;
 		info->task = NULL;
 		return NULL;
 	}
@@ -223,7 +205,6 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 	if (*pos == 0)
 		++*pos;
 	info->task = task;
-	info->files = files;
 
 	return file;
 }
@@ -231,22 +212,19 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 static void *task_file_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct bpf_iter_seq_task_file_info *info = seq->private;
-	struct files_struct *files = info->files;
 	struct task_struct *task = info->task;
 	struct file *file;
 
 	++*pos;
 	++info->fd;
 	fput((struct file *)v);
-	file = task_file_seq_get_next(info, &task, &files);
+	file = task_file_seq_get_next(info, &task);
 	if (!file) {
-		info->files = NULL;
 		info->task = NULL;
 		return NULL;
 	}
 
 	info->task = task;
-	info->files = files;
 
 	return file;
 }
@@ -295,9 +273,7 @@ static void task_file_seq_stop(struct seq_file *seq, void *v)
 		(void)__task_file_seq_show(seq, v, true);
 	} else {
 		fput((struct file *)v);
-		put_files_struct(info->files);
 		put_task_struct(info->task);
-		info->files = NULL;
 		info->task = NULL;
 	}
 }
-- 
2.25.0

