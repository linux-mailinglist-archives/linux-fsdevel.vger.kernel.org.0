Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28252BB9FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgKTXUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:04 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36090 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgKTXUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFhC-006UZk-Ow; Fri, 20 Nov 2020 16:20:02 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeG-00EG00-6u; Fri, 20 Nov 2020 16:17:00 -0700
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
Date:   Fri, 20 Nov 2020 17:14:35 -0600
Message-Id: <20201120231441.29911-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeG-00EG00-6u;;;mid=<20201120231441.29911-18-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WN8YoHfI/03jv7EktJCZELxhOW1eGhBc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 547 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.8%), b_tie_ro: 2.9 (0.5%), parse: 1.36
        (0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.9
        (0.5%), tests_pri_-1000: 20 (3.6%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 184 (33.6%), check_bayes:
        182 (33.3%), b_tokenize: 8 (1.5%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 160 (29.3%), b_finish: 0.79
        (0.1%), tests_pri_0: 309 (56.6%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 18/24] file: Merge __fd_install into fd_install
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function __fd_install was added to support binder[1].  With binder
fixed[2] there are no more users.

As fd_install just calls __fd_install with "files=current->files",
merge them together by transforming the files parameter into a
local variable initialized to current->files.

[1] f869e8a7f753 ("expose a low-level variant of fd_install() for binder")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1:https://lkml.kernel.org/r/20200817220425.9389-14-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 25 ++++++-------------------
 include/linux/fdtable.h |  2 --
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 23b888a4acbe..0d4ec0fa23b3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -158,7 +158,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	spin_unlock(&files->file_lock);
 	new_fdt = alloc_fdtable(nr);
 
-	/* make sure all __fd_install() have seen resize_in_progress
+	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
 	 */
 	if (atomic_read(&files->count) > 1)
@@ -181,7 +181,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	rcu_assign_pointer(files->fdt, new_fdt);
 	if (cur_fdt != &files->fdtab)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
-	/* coupled with smp_rmb() in __fd_install() */
+	/* coupled with smp_rmb() in fd_install() */
 	smp_wmb();
 	return 1;
 }
@@ -584,17 +584,13 @@ EXPORT_SYMBOL(put_unused_fd);
  * It should never happen - if we allow dup2() do it, _really_ bad things
  * will follow.
  *
- * NOTE: __fd_install() variant is really, really low-level; don't
- * use it unless you are forced to by truly lousy API shoved down
- * your throat.  'files' *MUST* be either current->files or obtained
- * by get_files_struct(current) done by whoever had given it to you,
- * or really bad things will happen.  Normally you want to use
- * fd_install() instead.
+ * This consumes the "file" refcount, so callers should treat it
+ * as if they had called fput(file).
  */
 
-void __fd_install(struct files_struct *files, unsigned int fd,
-		struct file *file)
+void fd_install(unsigned int fd, struct file *file)
 {
+	struct files_struct *files = current->files;
 	struct fdtable *fdt;
 
 	rcu_read_lock_sched();
@@ -616,15 +612,6 @@ void __fd_install(struct files_struct *files, unsigned int fd,
 	rcu_read_unlock_sched();
 }
 
-/*
- * This consumes the "file" refcount, so callers should treat it
- * as if they had called fput(file).
- */
-void fd_install(unsigned int fd, struct file *file)
-{
-	__fd_install(current->files, fd, file);
-}
-
 EXPORT_SYMBOL(fd_install);
 
 static struct file *pick_file(struct files_struct *files, unsigned fd)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index cf6c52dae3a1..a5ec736d74a5 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -126,8 +126,6 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
-extern void __fd_install(struct files_struct *files,
-		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

