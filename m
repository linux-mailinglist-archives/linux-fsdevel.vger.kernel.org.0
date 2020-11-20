Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48222BBA02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgKTXUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:05 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36046 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgKTXUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFhC-006UZN-77; Fri, 20 Nov 2020 16:20:02 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdr-00EG00-VT; Fri, 20 Nov 2020 16:16:36 -0700
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
Date:   Fri, 20 Nov 2020 17:14:28 -0600
Message-Id: <20201120231441.29911-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdr-00EG00-VT;;;mid=<20201120231441.29911-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/h0QmcCLCV6HVHgw+OmRdeEJ6Or8V526k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
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
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 308 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (1.5%), b_tie_ro: 3.1 (1.0%), parse: 1.27
        (0.4%), extract_message_metadata: 13 (4.2%), get_uri_detail_list: 1.76
        (0.6%), tests_pri_-1000: 21 (6.7%), tests_pri_-950: 1.07 (0.3%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 67 (21.9%), check_bayes:
        66 (21.5%), b_tokenize: 7 (2.2%), b_tok_get_all: 7 (2.4%),
        b_comp_prob: 1.63 (0.5%), b_tok_touch_all: 48 (15.5%), b_finish: 0.64
        (0.2%), tests_pri_0: 189 (61.6%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 1.96 (0.6%), poll_dns_idle: 0.71 (0.2%),
        tests_pri_10: 1.70 (0.6%), tests_pri_500: 5 (1.8%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v2 11/24] file: Implement task_lookup_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a companion to lookup_fd_rcu implement task_lookup_fd_rcu for
querying an arbitrary process about a specific file.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200818103713.aw46m7vprsy4vlve@wittgenstein
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 15 +++++++++++++++
 include/linux/fdtable.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 5861c4f89419..6448523ca29e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -865,6 +865,21 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
+struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
+{
+	/* Must be called with rcu_read_lock held */
+	struct files_struct *files;
+	struct file *file = NULL;
+
+	task_lock(task);
+	files = task->files;
+	if (files)
+		file = files_lookup_fd_rcu(files, fd);
+	task_unlock(task);
+
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2a4a8fed536e..a0558ae9b40c 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -110,6 +110,8 @@ static inline struct file *lookup_fd_rcu(unsigned int fd)
 	return files_lookup_fd_rcu(current->files, fd);
 }
 
+struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd);
+
 struct task_struct;
 
 struct files_struct *get_files_struct(struct task_struct *);
-- 
2.25.0

