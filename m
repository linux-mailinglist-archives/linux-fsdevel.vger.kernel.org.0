Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670D247A15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgHQWKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60230 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgHQWKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:10:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKO-001qoV-OX; Mon, 17 Aug 2020 16:10:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKN-0004PB-S0; Mon, 17 Aug 2020 16:10:04 -0600
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
Date:   Mon, 17 Aug 2020 17:04:16 -0500
Message-Id: <20200817220425.9389-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKN-0004PB-S0;;;mid=<20200817220425.9389-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MSKEEDBeBw7dsl4MHrKCmLyi274gTksY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.3 (0.6%), b_tie_ro: 2.3 (0.4%), parse: 0.74
        (0.1%), extract_message_metadata: 8 (1.6%), get_uri_detail_list: 1.04
        (0.2%), tests_pri_-1000: 10 (2.0%), tests_pri_-950: 0.89 (0.2%),
        tests_pri_-900: 0.78 (0.1%), tests_pri_-90: 256 (48.3%), check_bayes:
        255 (48.1%), b_tokenize: 6 (1.2%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 1.59 (0.3%), b_tok_touch_all: 237 (44.8%), b_finish: 0.77
        (0.1%), tests_pri_0: 241 (45.4%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        1.71 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/17] proc/fd: In proc_fd_link use fcheck_task
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

Using fcheck_task instead of get_files_struct simplifies proc_fd_link by
removing unnecessary locking, and reference counting.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/fd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 4048a87c51ee..abfdcb21cc79 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -141,29 +141,23 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 
 static int proc_fd_link(struct dentry *dentry, struct path *path)
 {
-	struct files_struct *files = NULL;
 	struct task_struct *task;
 	int ret = -ENOENT;
 
 	task = get_proc_task(d_inode(dentry));
 	if (task) {
-		files = get_files_struct(task);
-		put_task_struct(task);
-	}
-
-	if (files) {
 		unsigned int fd = proc_fd(d_inode(dentry));
 		struct file *fd_file;
 
-		spin_lock(&files->file_lock);
-		fd_file = fcheck_files(files, fd);
+		rcu_read_lock();
+		fd_file = fcheck_task(task, fd);
 		if (fd_file) {
 			*path = fd_file->f_path;
 			path_get(&fd_file->f_path);
 			ret = 0;
 		}
-		spin_unlock(&files->file_lock);
-		put_files_struct(files);
+		rcu_read_unlock();
+		put_task_struct(task);
 	}
 
 	return ret;
-- 
2.25.0

