Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954C4247A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgHQWLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:11:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33570 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgHQWLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM4-001H7q-Gf; Mon, 17 Aug 2020 16:11:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKa-0004PB-2m; Mon, 17 Aug 2020 16:10:16 -0600
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
        =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 17 Aug 2020 17:04:19 -0500
Message-Id: <20200817220425.9389-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKa-0004PB-2m;;;mid=<20200817220425.9389-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GsEQJ0oPPoD5n5diUwjvIvO0UyKBadWU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMGappySubj_02,
        XMNoVowels,XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMGappySubj_02 Gappier still
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 531 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.48
        (0.3%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 76 (14.3%), check_bayes:
        74 (14.0%), b_tokenize: 14 (2.6%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 43 (8.1%), b_finish: 0.82
        (0.2%), tests_pri_0: 399 (75.1%), check_dkim_signature: 0.90 (0.2%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/17] bpf/task_iter: In task_file_seq_get_next use fnext_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
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

Using fnext_task simplifies task_file_seq_get_next, by moving the
checking for the maximum file descritor into the generic code, and by
remvoing the need for capturing and releasing a reference on
files_struct.  As the reference count of files_struct no longer needs
to be maintained bpf_iter_seq_task_file_info can have it's files member
removed and task_file_seq_get_next no longer it's fstruct argument.

The curr_fd local variable does need to become unsigned to be used
with fnext_task.  As curr_fd is assigned from and assigned a u32
making curr_fd an unsigned int won't cause problems and might prevent
them.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/task_iter.c | 43 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 232df29793e9..831d42d7543a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -122,45 +122,33 @@ struct bpf_iter_seq_task_file_info {
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
 		curr_task = task_seq_get_next(ns, &curr_tid);
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
@@ -171,13 +159,12 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 	}
 
 	rcu_read_lock();
-	max_fds = files_fdtable(curr_files)->max_fds;
-	for (; curr_fd < max_fds; curr_fd++) {
+	for (;; curr_fd++) {
 		struct file *f;
 
-		f = fcheck_files(curr_files, curr_fd);
+		f = fnext_task(curr_task, &curr_fd);
 		if (!f)
-			continue;
+			break;
 
 		/* set info->fd */
 		info->fd = curr_fd;
@@ -188,10 +175,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 
 	/* the current task is done, go to the next task */
 	rcu_read_unlock();
-	put_files_struct(curr_files);
 	put_task_struct(curr_task);
 	*task = NULL;
-	*fstruct = NULL;
 	info->fd = 0;
 	curr_tid = ++(info->tid);
 	goto again;
@@ -200,13 +185,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
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
@@ -214,7 +197,6 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 	if (*pos == 0)
 		++*pos;
 	info->task = task;
-	info->files = files;
 
 	return file;
 }
@@ -222,22 +204,19 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
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
@@ -286,9 +265,7 @@ static void task_file_seq_stop(struct seq_file *seq, void *v)
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

