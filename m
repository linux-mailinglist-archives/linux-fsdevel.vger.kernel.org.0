Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885992BBA08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgKTXUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:20:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47022 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgKTXUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh9-002RbQ-B6; Fri, 20 Nov 2020 16:19:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeN-00EG00-Df; Fri, 20 Nov 2020 16:17:07 -0700
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
Date:   Fri, 20 Nov 2020 17:14:37 -0600
Message-Id: <20201120231441.29911-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeN-00EG00-Df;;;mid=<20201120231441.29911-20-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hX9lwaOnMXrM0YEb54E/d3ReYkLxNKoQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 361 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.2%), b_tie_ro: 3.1 (0.9%), parse: 1.30
        (0.4%), extract_message_metadata: 13 (3.6%), get_uri_detail_list: 2.2
        (0.6%), tests_pri_-1000: 20 (5.7%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 70 (19.3%), check_bayes:
        68 (19.0%), b_tokenize: 7 (2.1%), b_tok_get_all: 7 (2.0%),
        b_comp_prob: 1.74 (0.5%), b_tok_touch_all: 49 (13.6%), b_finish: 0.70
        (0.2%), tests_pri_0: 237 (65.6%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.97 (0.3%), tests_pri_10:
        2.9 (0.8%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 20/24] file: Merge __alloc_fd into alloc_fd
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function __alloc_fd was added to support binder[1].  With binder
fixed[2] there are no more users.

As alloc_fd just calls __alloc_fd with "files=current->files",
merge them together by transforming the files parameter into a
local variable initialized to current->files.

[1] dcfadfa4ec5a ("new helper: __alloc_fd()")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-16-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 11 +++--------
 include/linux/fdtable.h |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 07e25f1b9dfd..621563701bd9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -480,9 +480,9 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-int __alloc_fd(struct files_struct *files,
-	       unsigned start, unsigned end, unsigned flags)
+static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 {
+	struct files_struct *files = current->files;
 	unsigned int fd;
 	int error;
 	struct fdtable *fdt;
@@ -538,14 +538,9 @@ int __alloc_fd(struct files_struct *files,
 	return error;
 }
 
-static int alloc_fd(unsigned start, unsigned end, unsigned flags)
-{
-	return __alloc_fd(current->files, start, end, flags);
-}
-
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
 {
-	return __alloc_fd(current->files, 0, nofile, flags);
+	return alloc_fd(0, nofile, flags);
 }
 
 int get_unused_fd_flags(unsigned flags)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index a5ec736d74a5..dc476ae92f56 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -124,8 +124,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __alloc_fd(struct files_struct *files,
-		      unsigned start, unsigned end, unsigned flags);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

