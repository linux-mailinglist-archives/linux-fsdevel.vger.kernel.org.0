Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1BF247A10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgHQWKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:10:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32968 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgHQWJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKF-001Gya-MY; Mon, 17 Aug 2020 16:09:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKE-0004PB-TN; Mon, 17 Aug 2020 16:09:55 -0600
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
Date:   Mon, 17 Aug 2020 17:04:14 -0500
Message-Id: <20200817220425.9389-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKE-0004PB-TN;;;mid=<20200817220425.9389-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+FAvHqoU00EuPv+eIsuw9qOJOke3CL9M=
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
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 11 (3.0%), parse: 1.42
        (0.4%), extract_message_metadata: 13 (3.6%), get_uri_detail_list: 1.29
        (0.4%), tests_pri_-1000: 15 (4.1%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 120 (32.8%), check_bayes:
        118 (32.3%), b_tokenize: 8 (2.3%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 97 (26.5%), b_finish: 1.04
        (0.3%), tests_pri_0: 188 (51.3%), check_dkim_signature: 0.87 (0.2%),
        check_dkim_adsp: 2.0 (0.6%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        2.9 (0.8%), tests_pri_500: 8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/17] file: Implement fcheck_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a companion to fget_task implement fcheck_task for use for querying
a process about a specific file.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 13 +++++++++++++
 include/linux/fdtable.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index c585dbaf31a3..8d4b385055e9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -863,6 +863,19 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
+struct file *fcheck_task(struct task_struct *task, unsigned int fd)
+{
+	/* Must be called with rcu_read_lock held */
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = fcheck_files(task->files, fd);
+	task_unlock(task);
+
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 7cc9885044d9..def9debd2ce2 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -103,6 +103,7 @@ static inline struct file *fcheck_files(struct files_struct *files, unsigned int
  * Check whether the specified fd has an open file.
  */
 #define fcheck(fd)	fcheck_files(current->files, fd)
+struct file *fcheck_task(struct task_struct *task, unsigned int fd);
 
 struct task_struct;
 
-- 
2.25.0

