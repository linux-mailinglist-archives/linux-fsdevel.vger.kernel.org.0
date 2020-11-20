Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0D2BB9D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgKTXQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:16:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46004 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTXQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:17 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2020 18:16:16 EST
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdX-002RDz-J2; Fri, 20 Nov 2020 16:16:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdW-00EG00-K1; Fri, 20 Nov 2020 16:16:15 -0700
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
Date:   Fri, 20 Nov 2020 17:14:22 -0600
Message-Id: <20201120231441.29911-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdW-00EG00-K1;;;mid=<20201120231441.29911-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Xhwlps+6lJ3cvlbGlrhm0qEn5witM5cY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01 autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 399 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.6 (1.2%), b_tie_ro: 3.1 (0.8%), parse: 1.36
        (0.3%), extract_message_metadata: 11 (2.8%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-1000: 18 (4.5%), tests_pri_-950: 1.48 (0.4%),
        tests_pri_-900: 1.28 (0.3%), tests_pri_-90: 80 (20.0%), check_bayes:
        78 (19.6%), b_tokenize: 13 (3.2%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 51 (12.9%), b_finish: 0.76
        (0.2%), tests_pri_0: 269 (67.4%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 1.06 (0.3%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 05/24] bpf: In bpf_task_fd_query use fget_task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the helper fget_task to simplify bpf_task_fd_query.

As well as simplifying the code this removes one unnecessary increment of
struct files_struct.  This unnecessary increment of files_struct.count can
result in exec unnecessarily unsharing files_struct and breaking posix
locks, and it can result in fget_light having to fallback to fget reducing
performance.

This simplification comes from the observation that none of the
callers of get_files_struct actually need to call get_files_struct
that was made when discussing[1] exec and posix file locks.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-5-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/syscall.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8f50c9c19f1b..6d49c2e1634c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3878,7 +3878,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	pid_t pid = attr->task_fd_query.pid;
 	u32 fd = attr->task_fd_query.fd;
 	const struct perf_event *event;
-	struct files_struct *files;
 	struct task_struct *task;
 	struct file *file;
 	int err;
@@ -3896,23 +3895,11 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
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
@@ -3952,7 +3939,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	err = -ENOTSUPP;
 put_file:
 	fput(file);
-out:
 	return err;
 }
 
-- 
2.25.0

