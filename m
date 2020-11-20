Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924D72BB9CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgKTXQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:16:08 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33444 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTXQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:06 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdN-006Tng-AZ; Fri, 20 Nov 2020 16:16:05 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdM-00EG00-61; Fri, 20 Nov 2020 16:16:04 -0700
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
Date:   Fri, 20 Nov 2020 17:14:19 -0600
Message-Id: <20201120231441.29911-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdM-00EG00-61;;;mid=<20201120231441.29911-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196u8wLHWhkRGE/DETQH7hBBNOxVYgWlQo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 558 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.6%), parse: 1.38 (0.2%),
         extract_message_metadata: 15 (2.7%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 16 (2.8%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 61 (11.0%), check_bayes:
        60 (10.7%), b_tokenize: 11 (2.0%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 34 (6.1%), b_finish: 0.75
        (0.1%), tests_pri_0: 434 (77.8%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.70 (0.1%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 13 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 02/24] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that exec no longer needs to return the unshared files to their
previous value there is no reason to return displaced.

Instead when unshare_fd creates a copy of the file table, call
put_files_struct before returning from unshare_files.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-2-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c           |  5 +----
 fs/exec.c               |  5 +----
 include/linux/fdtable.h |  2 +-
 kernel/fork.c           | 12 ++++++------
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0cd9056d79cc..abf807235262 100644
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
index fa788988efe9..14fae2ec1c9d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1238,7 +1238,6 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
-	struct files_struct *displaced;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1259,11 +1258,9 @@ int begin_new_exec(struct linux_binprm * bprm)
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
index 32083db7a2a2..837b546528c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3023,21 +3023,21 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
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

