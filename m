Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8020D2BBA15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgKTXUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35962 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgKTXT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh8-006UYI-74; Fri, 20 Nov 2020 16:19:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFea-00EG00-TR; Fri, 20 Nov 2020 16:17:21 -0700
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
Date:   Fri, 20 Nov 2020 17:14:40 -0600
Message-Id: <20201120231441.29911-23-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFea-00EG00-TR;;;mid=<20201120231441.29911-23-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+WPgiefUzQYgmtCM2bY9TtjITWdux5+J8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 638 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 19 (3.0%), b_tie_ro: 17 (2.7%), parse: 2.5 (0.4%),
         extract_message_metadata: 16 (2.5%), get_uri_detail_list: 2.1 (0.3%),
        tests_pri_-1000: 16 (2.5%), tests_pri_-950: 1.51 (0.2%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 247 (38.7%), check_bayes:
        245 (38.4%), b_tokenize: 11 (1.8%), b_tok_get_all: 7 (1.1%),
        b_comp_prob: 2.6 (0.4%), b_tok_touch_all: 220 (34.5%), b_finish: 1.13
        (0.2%), tests_pri_0: 315 (49.4%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 12 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 23/24] file: Rename __close_fd_get_file close_fd_get_file
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function close_fd_get_file is explicitly a variant of
__close_fd[1].  Now that __close_fd has been renamed close_fd, rename
close_fd_get_file to be consistent with close_fd.

When __alloc_fd, __close_fd and __fd_install were introduced the
double underscore indicated that the function took a struct
files_struct parameter.  The function __close_fd_get_file never has so
the naming has always been inconsistent.  This just cleans things up
so there are not any lingering mentions or references __close_fd left
in the code.

[1] 80cd795630d6 ("binder: fix use-after-free due to ksys_close() during fdget()")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/android/binder.c | 2 +-
 fs/file.c                | 4 ++--
 fs/io_uring.c            | 2 +-
 include/linux/fdtable.h  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b5117576792b..5b2e3721ac27 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2226,7 +2226,7 @@ static void binder_deferred_fd_close(int fd)
 	if (!twcb)
 		return;
 	init_task_work(&twcb->twork, binder_do_fd_close);
-	__close_fd_get_file(fd, &twcb->file);
+	close_fd_get_file(fd, &twcb->file);
 	if (twcb->file) {
 		filp_close(twcb->file, current->files);
 		task_work_add(current, &twcb->twork, TWA_RESUME);
diff --git a/fs/file.c b/fs/file.c
index 987ea51630b4..947ac6d5602f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -721,11 +721,11 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 }
 
 /*
- * variant of __close_fd that gets a ref on the file for later fput.
+ * variant of close_fd that gets a ref on the file for later fput.
  * The caller must ensure that filp_close() called on the file, and then
  * an fput().
  */
-int __close_fd_get_file(unsigned int fd, struct file **res)
+int close_fd_get_file(unsigned int fd, struct file **res)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index b42dfa0243bf..2e6e51292eff 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4206,7 +4206,7 @@ static int io_close(struct io_kiocb *req, bool force_nonblock,
 
 	/* might be already done during nonblock submission */
 	if (!close->put_file) {
-		ret = __close_fd_get_file(close->fd, &close->put_file);
+		ret = close_fd_get_file(close->fd, &close->put_file);
 		if (ret < 0)
 			return (ret == -ENOENT) ? -EBADF : ret;
 	}
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index dad4a488ce60..4ed3589f9294 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -126,7 +126,7 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-extern int __close_fd_get_file(unsigned int fd, struct file **res);
+extern int close_fd_get_file(unsigned int fd, struct file **res);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 		      struct files_struct **new_fdp);
 
-- 
2.25.0

