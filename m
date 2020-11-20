Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275652BB9FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKTXUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:03 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49194 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgKTXUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh9-006Y0K-Rr; Fri, 20 Nov 2020 16:19:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFee-00EG00-LB; Fri, 20 Nov 2020 16:17:25 -0700
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
Date:   Fri, 20 Nov 2020 17:14:41 -0600
Message-Id: <20201120231441.29911-24-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFee-00EG00-LB;;;mid=<20201120231441.29911-24-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/pcMQqBBQUv0JpdvGdw8YX55VohZwtBzg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 426 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 9 (2.2%), parse: 1.14 (0.3%),
         extract_message_metadata: 17 (4.1%), get_uri_detail_list: 2.00 (0.5%),
         tests_pri_-1000: 27 (6.4%), tests_pri_-950: 1.89 (0.4%),
        tests_pri_-900: 1.53 (0.4%), tests_pri_-90: 102 (23.9%), check_bayes:
        99 (23.2%), b_tokenize: 17 (3.9%), b_tok_get_all: 10 (2.3%),
        b_comp_prob: 3.6 (0.8%), b_tok_touch_all: 63 (14.8%), b_finish: 1.74
        (0.4%), tests_pri_0: 247 (58.0%), check_dkim_signature: 0.99 (0.2%),
        check_dkim_adsp: 4.2 (1.0%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 12 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 24/24] file: Remove get_files_struct
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

Now that get_files_struct has no more users and can not cause the
problems for posix file locking and fget_light remove get_files_struct
so that it does not gain any new users.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-13-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 13 -------------
 include/linux/fdtable.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 947ac6d5602f..412033d8cfdf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -411,19 +411,6 @@ static struct fdtable *close_files(struct files_struct * files)
 	return fdt;
 }
 
-struct files_struct *get_files_struct(struct task_struct *task)
-{
-	struct files_struct *files;
-
-	task_lock(task);
-	files = task->files;
-	if (files)
-		atomic_inc(&files->count);
-	task_unlock(task);
-
-	return files;
-}
-
 void put_files_struct(struct files_struct *files)
 {
 	if (atomic_dec_and_test(&files->count)) {
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 4ed3589f9294..d0e78174874a 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -115,7 +115,6 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *fd)
 
 struct task_struct;
 
-struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
-- 
2.25.0

