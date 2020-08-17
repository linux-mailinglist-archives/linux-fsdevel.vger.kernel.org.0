Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084B3247A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgHQWKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33104 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgHQWKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:10:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKS-001H0V-Pl; Mon, 17 Aug 2020 16:10:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKS-0004PB-0O; Mon, 17 Aug 2020 16:10:08 -0600
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
Date:   Mon, 17 Aug 2020 17:04:17 -0500
Message-Id: <20200817220425.9389-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKS-0004PB-0O;;;mid=<20200817220425.9389-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18XoryakreQpr9Brl3/jR/BCv6ZPxl9B9A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 382 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.58
        (0.4%), extract_message_metadata: 13 (3.4%), get_uri_detail_list: 1.53
        (0.4%), tests_pri_-1000: 17 (4.5%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 78 (20.5%), check_bayes:
        77 (20.1%), b_tokenize: 10 (2.5%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 54 (14.1%), b_finish: 0.86
        (0.2%), tests_pri_0: 244 (63.7%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/17] file: Implement fnext_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a companion to fget_task and fcheck_task implement fnext_task that
will return the struct file for the first file descriptor show number
is equal or greater than the fd argument value, or NULL if there is
no such struct file.

This allows file descriptors of foreign processes to be iterated through
safely, without needed to increment the count on files_struct.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 21 +++++++++++++++++++++
 include/linux/fdtable.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 8d4b385055e9..88f9f78869f8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -876,6 +876,27 @@ struct file *fcheck_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
+struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)
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
+			file = fcheck_files(files, fd);
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
index def9debd2ce2..a3a054084f49 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -104,6 +104,7 @@ static inline struct file *fcheck_files(struct files_struct *files, unsigned int
  */
 #define fcheck(fd)	fcheck_files(current->files, fd)
 struct file *fcheck_task(struct task_struct *task, unsigned int fd);
+struct file *fnext_task(struct task_struct *task, unsigned int *fd);
 
 struct task_struct;
 
-- 
2.25.0

