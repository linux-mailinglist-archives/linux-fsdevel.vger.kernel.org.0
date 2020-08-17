Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67AF247A06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgHQWJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:09:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32812 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgHQWJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJy-001GwP-OE; Mon, 17 Aug 2020 16:09:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJx-0004PB-Pg; Mon, 17 Aug 2020 16:09:38 -0600
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
Date:   Mon, 17 Aug 2020 17:04:10 -0500
Message-Id: <20200817220425.9389-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nJx-0004PB-Pg;;;mid=<20200817220425.9389-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xNEwjlJ8evEae+YxPr4wPgZFD/xy0je8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 527 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.72
        (0.3%), extract_message_metadata: 15 (2.8%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 15 (2.9%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 136 (25.7%), check_bayes:
        134 (25.4%), b_tokenize: 13 (2.5%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 103 (19.5%), b_finish: 1.20
        (0.2%), tests_pri_0: 323 (61.4%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 15 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 02/17] exec: Simplify unshare_files
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that exec no longer needs to return the unshared files to their
previous value there is no reason to return displaced.

Instead when unshare_fd creates a copy of the file table, call
put_files_struct before returning from unshare_files.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c           |  5 +----
 fs/exec.c               |  5 +----
 include/linux/fdtable.h |  2 +-
 kernel/fork.c           | 12 ++++++------
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..568d6e391082 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -585,7 +585,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
-	struct files_struct *displaced;
 	/* require nonrelative corefile path and be extra careful */
 	bool need_suid_safe = false;
 	bool core_dumped = false;
@@ -791,11 +790,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 	/* get us an unshared descriptor table; almost always a no-op */
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto close_fail;
-	if (displaced)
-		put_files_struct(displaced);
 	if (!dump_interrupted()) {
 		/*
 		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
diff --git a/fs/exec.c b/fs/exec.c
index 17c007bba712..9b723d2560d1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,7 +1354,6 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
-	struct files_struct *displaced;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1375,11 +1374,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/* Ensure the files table is not shared. */
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto out;
-	if (displaced)
-		put_files_struct(displaced);
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index a32bf47c593e..f46a084b60b2 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -109,7 +109,7 @@ struct task_struct;
 struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
 void reset_files_struct(struct files_struct *);
-int unshare_files(struct files_struct **);
+int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..3049a41076f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2995,21 +2995,21 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
  *	the exec layer of the kernel.
  */
 
-int unshare_files(struct files_struct **displaced)
+int unshare_files(void)
 {
 	struct task_struct *task = current;
-	struct files_struct *copy = NULL;
+	struct files_struct *old, *copy = NULL;
 	int error;
 
 	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
-	if (error || !copy) {
-		*displaced = NULL;
+	if (error || !copy)
 		return error;
-	}
-	*displaced = task->files;
+
+	old = task->files;
 	task_lock(task);
 	task->files = copy;
 	task_unlock(task);
+	put_files_struct(old);
 	return 0;
 }
 
-- 
2.25.0

