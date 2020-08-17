Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0955247A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgHQWMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:12:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47250 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgHQWLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM6-004wAs-AJ; Mon, 17 Aug 2020 16:11:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKe-0004PB-Bh; Mon, 17 Aug 2020 16:10:21 -0600
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
Date:   Mon, 17 Aug 2020 17:04:20 -0500
Message-Id: <20200817220425.9389-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKe-0004PB-Bh;;;mid=<20200817220425.9389-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qmfRJ3lIgWJPZ2rZtUxGKy6lZEDFtyz4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.82
        (0.4%), extract_message_metadata: 18 (3.9%), get_uri_detail_list: 2.6
        (0.6%), tests_pri_-1000: 20 (4.3%), tests_pri_-950: 1.42 (0.3%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 154 (33.6%), check_bayes:
        152 (33.1%), b_tokenize: 10 (2.2%), b_tok_get_all: 12 (2.7%),
        b_comp_prob: 5 (1.1%), b_tok_touch_all: 114 (24.9%), b_finish: 1.23
        (0.3%), tests_pri_0: 238 (51.7%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
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

Instead hold task_lock for the duration that task->files needs to be
stable in seq_show.  The task_lock was already taken in
get_files_struct, and so skipping get_files_struct performs less work
overall, and avoids the problems with the files_struct reference
count.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/fd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index d9fee5390fd7..0b46eea154b7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -28,9 +28,8 @@ static int seq_show(struct seq_file *m, void *v)
 	if (!task)
 		return -ENOENT;
 
-	files = get_files_struct(task);
-	put_task_struct(task);
-
+	task_lock(task);
+	files = task->files;
 	if (files) {
 		unsigned int fd = proc_fd(m->private);
 
@@ -47,8 +46,9 @@ static int seq_show(struct seq_file *m, void *v)
 			ret = 0;
 		}
 		spin_unlock(&files->file_lock);
-		put_files_struct(files);
 	}
+	task_unlock(task);
+	put_task_struct(task);
 
 	if (ret)
 		return ret;
@@ -57,6 +57,7 @@ static int seq_show(struct seq_file *m, void *v)
 		   (long long)file->f_pos, f_flags,
 		   real_mount(file->f_path.mnt)->mnt_id);
 
+	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
 		goto out;
-- 
2.25.0

