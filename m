Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4C247A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgHQWKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60130 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgHQWJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKB-001qmx-LW; Mon, 17 Aug 2020 16:09:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKA-0004PB-1o; Mon, 17 Aug 2020 16:09:51 -0600
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
Date:   Mon, 17 Aug 2020 17:04:13 -0500
Message-Id: <20200817220425.9389-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKA-0004PB-1o;;;mid=<20200817220425.9389-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19rbO3QE4jZB/c5thWMG71BB86jat5hk8w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1183 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (0.9%), b_tie_ro: 9 (0.7%), parse: 1.58 (0.1%),
         extract_message_metadata: 11 (0.9%), get_uri_detail_list: 1.52 (0.1%),
         tests_pri_-1000: 13 (1.1%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 148 (12.5%), check_bayes:
        146 (12.4%), b_tokenize: 8 (0.7%), b_tok_get_all: 10 (0.9%),
        b_comp_prob: 2.1 (0.2%), b_tok_touch_all: 123 (10.4%), b_finish: 0.83
        (0.1%), tests_pri_0: 979 (82.7%), check_dkim_signature: 0.55 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.68 (0.1%), tests_pri_10:
        4.2 (0.4%), tests_pri_500: 12 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/17] bpf: In bpf_task_fd_query use fget_task
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

Use fget_task to simplify bpf_task_fd_query.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/syscall.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 86299a292214..93657d5f6538 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3741,7 +3741,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	pid_t pid = attr->task_fd_query.pid;
 	u32 fd = attr->task_fd_query.fd;
 	const struct perf_event *event;
-	struct files_struct *files;
 	struct task_struct *task;
 	struct file *file;
 	int err;
@@ -3759,23 +3758,11 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (!task)
 		return -ENOENT;
 
-	files = get_files_struct(task);
-	put_task_struct(task);
-	if (!files)
-		return -ENOENT;
-
 	err = 0;
-	spin_lock(&files->file_lock);
-	file = fcheck_files(files, fd);
+	file = fget_task(task, fd);
+	put_task_struct(task);
 	if (!file)
-		err = -EBADF;
-	else
-		get_file(file);
-	spin_unlock(&files->file_lock);
-	put_files_struct(files);
-
-	if (err)
-		goto out;
+		return -EBADF;
 
 	if (file->f_op == &bpf_link_fops) {
 		struct bpf_link *link = file->private_data;
@@ -3815,7 +3802,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	err = -ENOTSUPP;
 put_file:
 	fput(file);
-out:
 	return err;
 }
 
-- 
2.25.0

