Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2807247A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgHQWMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:12:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33606 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgHQWLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM5-001H8C-Vy; Mon, 17 Aug 2020 16:11:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKm-0004PB-L7; Mon, 17 Aug 2020 16:10:29 -0600
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
Date:   Mon, 17 Aug 2020 17:04:22 -0500
Message-Id: <20200817220425.9389-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKm-0004PB-L7;;;mid=<20200817220425.9389-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/b1FqIJGp7GfPLwyPwndSgsGRDfb1vTc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (2.4%), b_tie_ro: 8 (2.0%), parse: 1.04 (0.3%),
         extract_message_metadata: 10 (2.5%), get_uri_detail_list: 1.79 (0.4%),
         tests_pri_-1000: 13 (3.2%), tests_pri_-950: 1.03 (0.3%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 88 (22.0%), check_bayes:
        87 (21.8%), b_tokenize: 9 (2.3%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 64 (15.9%), b_finish: 0.69
        (0.2%), tests_pri_0: 263 (65.7%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 1.99 (0.5%), poll_dns_idle: 0.52 (0.1%),
        tests_pri_10: 2.3 (0.6%), tests_pri_500: 9 (2.2%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 14/17] file: Merge __fd_install into fd_install
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function __fd_install was added to support binder[1].  With binder
fixed[2] there are no more users.  Further with get_files_struct
removed there can be no more users of __fd_install that pass anything
except current->files.

As fd_install just calls __fd_install with "files=current->files",
merge them together by transforming the files parameter into a
local variable initialized to current->files.

[1] f869e8a7f753 ("expose a low-level variant of fd_install() for binder")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 25 ++++++-------------------
 include/linux/fdtable.h |  2 --
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 605e756f3c63..1a755811669d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -157,7 +157,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	spin_unlock(&files->file_lock);
 	new_fdt = alloc_fdtable(nr);
 
-	/* make sure all __fd_install() have seen resize_in_progress
+	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
 	 */
 	if (atomic_read(&files->count) > 1)
@@ -180,7 +180,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	rcu_assign_pointer(files->fdt, new_fdt);
 	if (cur_fdt != &files->fdtab)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
-	/* coupled with smp_rmb() in __fd_install() */
+	/* coupled with smp_rmb() in fd_install() */
 	smp_wmb();
 	return 1;
 }
@@ -569,17 +569,13 @@ EXPORT_SYMBOL(put_unused_fd);
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
@@ -601,15 +597,6 @@ void __fd_install(struct files_struct *files, unsigned int fd,
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
index 8c4bc6aa19c9..4da8aacc461a 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -118,8 +118,6 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
-extern void __fd_install(struct files_struct *files,
-		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

