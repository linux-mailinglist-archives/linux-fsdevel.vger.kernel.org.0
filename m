Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B02BB9F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgKTXT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:19:57 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46934 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgKTXT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh5-002Ral-ID; Fri, 20 Nov 2020 16:19:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeJ-00EG00-Oz; Fri, 20 Nov 2020 16:17:04 -0700
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
Date:   Fri, 20 Nov 2020 17:14:36 -0600
Message-Id: <20201120231441.29911-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeJ-00EG00-Oz;;;mid=<20201120231441.29911-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/07Js/AbSwO/7LHKe+DUR0IrwFWqtok48=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 556 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.16
        (0.2%), extract_message_metadata: 15 (2.8%), get_uri_detail_list: 1.49
        (0.3%), tests_pri_-1000: 32 (5.7%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 232 (41.8%), check_bayes:
        231 (41.5%), b_tokenize: 9 (1.6%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.5 (0.4%), b_tok_touch_all: 206 (37.1%), b_finish: 0.96
        (0.2%), tests_pri_0: 240 (43.1%), check_dkim_signature: 1.23 (0.2%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 16 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 19/24] file: In f_dupfd read RLIMIT_NOFILE once.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify the code, and remove the chance of races by reading
RLIMIT_NOFILE only once in f_dupfd.

Pass the read value of RLIMIT_NOFILE into alloc_fd which is the other
location the rlimit was read in f_dupfd.  As f_dupfd is the only
caller of alloc_fd this changing alloc_fd is trivially safe.

Further this causes alloc_fd to take all of the same arguments as
__alloc_fd except for the files_struct argument.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-15-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0d4ec0fa23b3..07e25f1b9dfd 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -538,9 +538,9 @@ int __alloc_fd(struct files_struct *files,
 	return error;
 }
 
-static int alloc_fd(unsigned start, unsigned flags)
+static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 {
-	return __alloc_fd(current->files, start, rlimit(RLIMIT_NOFILE), flags);
+	return __alloc_fd(current->files, start, end, flags);
 }
 
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
@@ -1175,10 +1175,11 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
+	unsigned long nofile = rlimit(RLIMIT_NOFILE);
 	int err;
-	if (from >= rlimit(RLIMIT_NOFILE))
+	if (from >= nofile)
 		return -EINVAL;
-	err = alloc_fd(from, flags);
+	err = alloc_fd(from, nofile, flags);
 	if (err >= 0) {
 		get_file(file);
 		fd_install(err, file);
-- 
2.25.0

