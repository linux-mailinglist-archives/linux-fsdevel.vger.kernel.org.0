Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE372BB9DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKTXQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:16:28 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33648 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgKTXQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdi-006TqE-8D; Fri, 20 Nov 2020 16:16:26 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdg-00EG00-RF; Fri, 20 Nov 2020 16:16:25 -0700
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
Date:   Fri, 20 Nov 2020 17:14:25 -0600
Message-Id: <20201120231441.29911-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdg-00EG00-RF;;;mid=<20201120231441.29911-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18edY7AsNzDid9bgwd2GH9BMu//oTEEyxM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMGappySubj_01,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 828 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.3%), b_tie_ro: 10 (1.2%), parse: 1.47
        (0.2%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 2.5
        (0.3%), tests_pri_-1000: 16 (1.9%), tests_pri_-950: 1.35 (0.2%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 189 (22.8%), check_bayes:
        187 (22.6%), b_tokenize: 15 (1.9%), b_tok_get_all: 9 (1.1%),
        b_comp_prob: 3.4 (0.4%), b_tok_touch_all: 156 (18.9%), b_finish: 0.92
        (0.1%), tests_pri_0: 582 (70.3%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        1.74 (0.2%), tests_pri_500: 8 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 08/24] file: Factor files_lookup_fd_locked out of fcheck_files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To make it easy to tell where files->file_lock protection is being
used when looking up a file create files_lookup_fd_locked.  Only allow
this function to be called with the file_lock held.

Update the callers of fcheck and fcheck_files that are called with the
files->file_lock held to call files_lookup_fd_locked instead.

Hopefully this makes it easier to quickly understand what is going on.

The need for better names became apparent in the last round of
discussion of this set of changes[1].

[1] https://lkml.kernel.org/r/CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               |  2 +-
 fs/locks.c              | 14 ++++++++------
 fs/proc/fd.c            |  2 +-
 include/linux/fdtable.h |  7 +++++++
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index b5591efb87f5..9d0e91168be1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1098,7 +1098,7 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 
 	spin_lock(&files->file_lock);
 	err = expand_files(files, newfd);
-	file = fcheck(oldfd);
+	file = files_lookup_fd_locked(files, oldfd);
 	if (unlikely(!file))
 		goto Ebadf;
 	if (unlikely(err < 0)) {
diff --git a/fs/locks.c b/fs/locks.c
index 1f84a03601fe..148197c1b547 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2539,14 +2539,15 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	 */
 	if (!error && file_lock->fl_type != F_UNLCK &&
 	    !(file_lock->fl_flags & FL_OFDLCK)) {
+		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
 		 * update of i_flctx->flc_posix and check for it done in
 		 * close(). rcu_read_lock() wouldn't do.
 		 */
-		spin_lock(&current->files->file_lock);
-		f = fcheck(fd);
-		spin_unlock(&current->files->file_lock);
+		spin_lock(&files->file_lock);
+		f = files_lookup_fd_locked(files, fd);
+		spin_unlock(&files->file_lock);
 		if (f != filp) {
 			file_lock->fl_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
@@ -2670,14 +2671,15 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	 */
 	if (!error && file_lock->fl_type != F_UNLCK &&
 	    !(file_lock->fl_flags & FL_OFDLCK)) {
+		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
 		 * update of i_flctx->flc_posix and check for it done in
 		 * close(). rcu_read_lock() wouldn't do.
 		 */
-		spin_lock(&current->files->file_lock);
-		f = fcheck(fd);
-		spin_unlock(&current->files->file_lock);
+		spin_lock(&files->file_lock);
+		f = files_lookup_fd_locked(files, fd);
+		spin_unlock(&files->file_lock);
 		if (f != filp) {
 			file_lock->fl_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index d58960f6ee52..2cca9bca3b3a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -35,7 +35,7 @@ static int seq_show(struct seq_file *m, void *v)
 		unsigned int fd = proc_fd(m->private);
 
 		spin_lock(&files->file_lock);
-		file = fcheck_files(files, fd);
+		file = files_lookup_fd_locked(files, fd);
 		if (file) {
 			struct fdtable *fdt = files_fdtable(files);
 
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 639933f37da9..fda4b81dd735 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -91,6 +91,13 @@ static inline struct file *files_lookup_fd_raw(struct files_struct *files, unsig
 	return NULL;
 }
 
+static inline struct file *files_lookup_fd_locked(struct files_struct *files, unsigned int fd)
+{
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&files->file_lock),
+			   "suspicious rcu_dereference_check() usage");
+	return files_lookup_fd_raw(files, fd);
+}
+
 static inline struct file *fcheck_files(struct files_struct *files, unsigned int fd)
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
-- 
2.25.0

