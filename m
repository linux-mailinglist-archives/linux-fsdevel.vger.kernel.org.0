Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7122BBA0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgKTXUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:21 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgKTXUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh8-002RbD-NX; Fri, 20 Nov 2020 16:19:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdy-00EG00-Lx; Fri, 20 Nov 2020 16:16:43 -0700
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
Date:   Fri, 20 Nov 2020 17:14:30 -0600
Message-Id: <20201120231441.29911-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdy-00EG00-Lx;;;mid=<20201120231441.29911-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194cx44q+KvkyQRjsxLSGAq1iGzNebFjbg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 413 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.2%), parse: 1.35 (0.3%),
         extract_message_metadata: 11 (2.7%), get_uri_detail_list: 0.95 (0.2%),
         tests_pri_-1000: 15 (3.6%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 145 (35.0%), check_bayes:
        143 (34.5%), b_tokenize: 8 (1.9%), b_tok_get_all: 4.6 (1.1%),
        b_comp_prob: 2.0 (0.5%), b_tok_touch_all: 124 (30.0%), b_finish: 1.20
        (0.3%), tests_pri_0: 216 (52.3%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.63 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 13/24] kcmp: In get_file_raw_ptr use task_lookup_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify get_file_raw_ptr to use task_lookup_fd_rcu.  The helper
task_lookup_fd_rcu does the work of taking the task lock and verifying
that task->files != NULL and then calls files_lookup_fd_rcu.  So let
use the helper to make a simpler implementation of get_file_raw_ptr.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kcmp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 990717c1aed3..36e58eb5a11d 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -61,16 +61,11 @@ static int kcmp_ptr(void *v1, void *v2, enum kcmp_type type)
 static struct file *
 get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 {
-	struct file *file = NULL;
+	struct file *file;
 
-	task_lock(task);
 	rcu_read_lock();
-
-	if (task->files)
-		file = files_lookup_fd_rcu(task->files, idx);
-
+	file = task_lookup_fd_rcu(task, idx);
 	rcu_read_unlock();
-	task_unlock(task);
 
 	return file;
 }
-- 
2.25.0

