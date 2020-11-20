Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED22BBA0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKTXU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:29 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49144 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgKTXT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh7-006Xzz-Kx; Fri, 20 Nov 2020 16:19:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFe2-00EG00-1l; Fri, 20 Nov 2020 16:16:46 -0700
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
Date:   Fri, 20 Nov 2020 17:14:31 -0600
Message-Id: <20201120231441.29911-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFe2-00EG00-1l;;;mid=<20201120231441.29911-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WaiBJd3Nq6/ZzikkysKyBD91aHVCzXs0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMGappySubj_02,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 521 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (1.9%), parse: 1.33
        (0.3%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.3
        (0.4%), tests_pri_-1000: 14 (2.6%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 81 (15.5%), check_bayes:
        79 (15.1%), b_tokenize: 9 (1.7%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 54 (10.3%), b_finish: 1.42
        (0.3%), tests_pri_0: 383 (73.5%), check_dkim_signature: 0.79 (0.2%),
        check_dkim_adsp: 3.7 (0.7%), poll_dns_idle: 1.32 (0.3%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 14/24] file: Implement task_lookup_next_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a companion to fget_task and task_lookup_fd_rcu implement
task_lookup_next_fd_rcu that will return the struct file for the first
file descriptor number that is equal or greater than the fd argument
value, or NULL if there is no such struct file.

This allows file descriptors of foreign processes to be iterated
through safely, without needed to increment the count on files_struct.

Some concern[1] has been expressed that this function takes the task_lock
for each iteration and thus for each file descriptor.  This place
where this function will be called in a commonly used code path is for
listing /proc/<pid>/fd.  I did some small benchmarks and did not see
any measurable performance differences.  For ordinary users ls is
likely to stat each of the directory entries and tid_fd_mode called
from tid_fd_revalidae has always taken the task lock for each file
descriptor.  So this does not look like it will be a big change in
practice.

At some point is will probably be worth changing put_files_struct to
free files_struct after an rcu grace period so that task_lock won't be
needed at all.

[1] https://lkml.kernel.org/r/20200817220425.9389-10-ebiederm@xmission.com
v1: https://lkml.kernel.org/r/20200817220425.9389-9-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 21 +++++++++++++++++++++
 include/linux/fdtable.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 6448523ca29e..23b888a4acbe 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -880,6 +880,27 @@ struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
+struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret_fd)
+{
+	/* Must be called with rcu_read_lock held */
+	struct files_struct *files;
+	unsigned int fd = *ret_fd;
+	struct file *file = NULL;
+
+	task_lock(task);
+	files = task->files;
+	if (files) {
+		for (; fd < files_fdtable(files)->max_fds; fd++) {
+			file = files_lookup_fd_rcu(files, fd);
+			if (file)
+				break;
+		}
+	}
+	task_unlock(task);
+	*ret_fd = fd;
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index a0558ae9b40c..cf6c52dae3a1 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -111,6 +111,7 @@ static inline struct file *lookup_fd_rcu(unsigned int fd)
 }
 
 struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd);
+struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *fd);
 
 struct task_struct;
 
-- 
2.25.0

