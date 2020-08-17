Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F680247A1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgHQWK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46586 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgHQWKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:10:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKW-004vtM-PI; Mon, 17 Aug 2020 16:10:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKV-0004PB-W4; Mon, 17 Aug 2020 16:10:12 -0600
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
Date:   Mon, 17 Aug 2020 17:04:18 -0500
Message-Id: <20200817220425.9389-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKV-0004PB-W4;;;mid=<20200817220425.9389-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/rGzp3jrWwVWIWQnolVzaJMEaOuCOGy6w=
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
X-Spam-Timing: total 405 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 10 (2.4%), parse: 1.50
        (0.4%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.99
        (0.5%), tests_pri_-1000: 16 (3.9%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.21 (0.3%), tests_pri_-90: 76 (18.9%), check_bayes:
        75 (18.5%), b_tokenize: 10 (2.5%), b_tok_get_all: 9 (2.3%),
        b_comp_prob: 3.7 (0.9%), b_tok_touch_all: 48 (11.9%), b_finish: 0.90
        (0.2%), tests_pri_0: 260 (64.3%), check_dkim_signature: 1.04 (0.3%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.65 (0.2%), tests_pri_10:
        3.3 (0.8%), tests_pri_500: 16 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/17] proc/fd: In proc_readfd_common use fnext_task
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

Using fnext_task simplifies proc_readfd_common, by moving the checking
for the maximum file descritor into the generic code, and by
remvoing the need for capturing and releasing a reference on
files_struct.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/fd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index abfdcb21cc79..d9fee5390fd7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -218,7 +218,6 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			      instantiate_t instantiate)
 {
 	struct task_struct *p = get_proc_task(file_inode(file));
-	struct files_struct *files;
 	unsigned int fd;
 
 	if (!p)
@@ -226,22 +225,18 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 
 	if (!dir_emit_dots(file, ctx))
 		goto out;
-	files = get_files_struct(p);
-	if (!files)
-		goto out;
 
 	rcu_read_lock();
-	for (fd = ctx->pos - 2;
-	     fd < files_fdtable(files)->max_fds;
-	     fd++, ctx->pos++) {
+	for (fd = ctx->pos - 2;; fd++, ctx->pos++) {
 		struct file *f;
 		struct fd_data data;
 		char name[10 + 1];
 		unsigned int len;
 
-		f = fcheck_files(files, fd);
+		f = fnext_task(p, &fd);
+		ctx->pos = fd;
 		if (!f)
-			continue;
+			break;
 		data.mode = f->f_mode;
 		rcu_read_unlock();
 		data.fd = fd;
@@ -250,13 +245,11 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		if (!proc_fill_cache(file, ctx,
 				     name, len, instantiate, p,
 				     &data))
-			goto out_fd_loop;
+			goto out;
 		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-out_fd_loop:
-	put_files_struct(files);
 out:
 	put_task_struct(p);
 	return 0;
-- 
2.25.0

